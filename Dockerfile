FROM yoh300/magento:latest
MAINTAINER Watchara Chiamchit <yoh300@hotmail.com>

ADD create_mysql_admin_user.sh /create_mysql_admin_user.sh
RUN chmod 755 /*.sh

RUN useradd -ms /bin/bash jenkins
RUN mkdir -p /usr/.tmp/
RUN mkdir -p /var/jenkins_home/workspace && rm -fr /var/www/html && ln -s /var/jenkins_home/workspace /var/www/html
ADD modman /usr/bin/modman
ADD mage-ci /usr/bin/mage-ci
ADD phpunit /usr/bin/phpunit
ADD sqlite3 /usr/bin/sqlite3
COPY magento-1.8.1.0.tar.gz /usr/.tmp/
COPY magento-1.9.0.0.tar.gz /usr/.tmp/
COPY magento-1.9.1.0.tar.gz /usr/.tmp/

RUN chown jenkins:jenkins /var/jenkins_home/workspace
RUN echo "jenkins:password" | chpasswd
RUN echo "root:admin123" | chpasswd

# Add volumes for MySQL 
VOLUME  ["/etc/mysql", "/var/lib/mysql" ]

EXPOSE 80 3306 22 21
CMD ["/run.sh"]


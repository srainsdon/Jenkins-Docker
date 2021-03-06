FROM jenkins/jenkins:lts

LABEL maintainer "seth.rainsdon@nunetnetworks.net"
USER root
RUN apt-get update
RUN apt-get -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common
RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey
RUN apt-key add /tmp/dkey
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"
RUN apt-get update
RUN apt-get -y install docker-ce
RUN usermod -aG docker jenkins
# tell docker what port to expose
EXPOSE 8080

# docker container run --name JenkinsDocker -d -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock srainsdon/dockerjenkins

# docker exec JenkinsDocker cat /var/jenkins_home/secrets/initialAdminPassword

FROM circleci/android@sha256:b6646fdf7457f61825526e7bfce364d8e533da6ceb1cdb98e371e94348ecc834

USER root

# install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

# Installs Node.js and npm and npx
RUN apt-get install -y curl \
  && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
  && apt-get install -y nodejs \
  && curl -L https://www.npmjs.com/install.sh | sh

RUN apt-get update && \
    apt-get install -y ruby

#install fastlane
RUN gem install fastlane \
    && gem install bundler \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && apt-get autoremove -y && apt-get clean

USER circleci

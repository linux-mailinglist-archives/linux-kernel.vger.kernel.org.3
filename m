Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2234B5C1E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiBNVF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:05:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiBNVFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:05:44 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BE0107D22
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:05:31 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h6so28852004wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1B+AkjdFXT+evGUU921Dh8e0UYmT9RxnLatFFheo8ZM=;
        b=tKiXBV3PsLNJcVEA14EhUxb/dM7rQEVhTpOKJKhzn1YmWOZlcAH4/UuqDOivcAKCEA
         b7Mlhkhx2G5CvwmDhkTBxwrw15avqGlgoEnxcoFQ8ru69OoMJNWZKsSGZF6kDwYYxdsU
         n9njOLI/hQ/UYl81RoF7pyYg4/qbf5k0vFB5/1+hMiOqkZUoqFOo1ylMB5QVe3BKUsPL
         rBZjUdKAIhmhBnNFLwcpFK3N7IG2CpFDm2s0Tzka/KwHEMmW3qCTvF4ccF4W0AXM5Zn2
         R/nQXIA43/CA8QeO3nWV8D33DlkrdeZFaDkcpOjSboknl86e7mCIGEs603t+PYmJsZO1
         5K1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1B+AkjdFXT+evGUU921Dh8e0UYmT9RxnLatFFheo8ZM=;
        b=Dsm9GlmT7QZUK4AxO/hTni+WX4cRAAGmPOuQCZa4e2XY76jZ9D3FqepqP+drEmK0Rr
         2m0of4aC/i5fCHwL/7eWt+xWcpOeAy8OEEUBZ2OgIOf9J119nLcwJ7tT3oxzrOV7U4QG
         rYAXNXKF6ud1YzNhMTndhWR8wQIGgFuPlfmzVnoyI5tKi+HW96wljXiQ/pbiwqXbaTxW
         rtauLDgbJOPrXt2R05zrgErGTX1EL/Slb7kDeZVp2bCMY5gMMXvl+pg/Oq5WR2bTMW75
         m3hJj1pwXWUmvBvWwj8xsU+zEQqHYOG/goq0hUhE2nkn6w+nJaZMynxOQT95kAo2ybjg
         HCbQ==
X-Gm-Message-State: AOAM533YPTwZi1CxXpcmoPjcaZ85A82Ltm+MIKro8rdsubA7wPJj8z5T
        1l0DwGvk0QyKIiwi3EZkg0+AiQ==
X-Google-Smtp-Source: ABdhPJykGAVCLY3lhNvxyZkg5CkQZBZcAY9SN9ldvV0Fi4UgbpDoy+xoeadtjgAMadecuIu0p3EaNA==
X-Received: by 2002:adf:f5c2:: with SMTP id k2mr661011wrp.53.1644872729530;
        Mon, 14 Feb 2022 13:05:29 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:758e:84ee:c9c7:9bfb])
        by smtp.gmail.com with ESMTPSA id az7sm16137189wmb.14.2022.02.14.13.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 13:05:28 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     srinivas.pandruvada@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [RFC PATCH 3/4] tools/thermal: A temperature capture tool
Date:   Mon, 14 Feb 2022 22:04:29 +0100
Message-Id: <20220214210446.255780-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220214210446.255780-1-daniel.lezcano@linaro.org>
References: <20220214210446.255780-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'thermometer' tool allows to capture the temperature of a set of
thermal zones defined in a configuration file at a specified rate.

It is designed to have the lowest possible overhead. It will write the
captured temperature per thermal zone per file so making easier to
write a gnuplot script.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 tools/Makefile                             |  16 +-
 tools/thermal/thermometer/Build            |   2 +
 tools/thermal/thermometer/Makefile         |  23 ++
 tools/thermal/thermometer/thermometer.c    | 384 +++++++++++++++++++++
 tools/thermal/thermometer/thermometer.conf |   5 +
 5 files changed, 427 insertions(+), 3 deletions(-)
 create mode 100644 tools/thermal/thermometer/Build
 create mode 100644 tools/thermal/thermometer/Makefile
 create mode 100644 tools/thermal/thermometer/thermometer.c
 create mode 100644 tools/thermal/thermometer/thermometer.conf

diff --git a/tools/Makefile b/tools/Makefile
index c253cbd27c06..78615f8cb463 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -31,6 +31,7 @@ help:
 	@echo '  bootconfig             - boot config tool'
 	@echo '  spi                    - spi tools'
 	@echo '  tmon                   - thermal monitoring and tuning tool'
+	@echo '  thermometer            - temperature capture tool'
 	@echo '  thermal                - thermal library'
 	@echo '  tracing                - misc tracing tools'
 	@echo '  turbostat              - Intel CPU idle stats and freq reporting tool'
@@ -95,6 +96,9 @@ turbostat x86_energy_perf_policy intel-speed-select: FORCE
 tmon: FORCE
 	$(call descend,thermal/$@)
 
+thermometer: FORCE
+	$(call descend,thermal/$@)
+
 freefall: FORCE
 	$(call descend,laptop/$@)
 
@@ -105,7 +109,7 @@ all: acpi cgroup counter cpupower gpio hv firewire \
 		perf selftests bootconfig spi turbostat usb \
 		virtio vm bpf x86_energy_perf_policy \
 		tmon freefall iio objtool kvm_stat wmi \
-		pci debugging tracing thermal
+		pci debugging tracing thermal thermometer
 
 acpi_install:
 	$(call descend,power/$(@:_install=),install)
@@ -128,6 +132,9 @@ turbostat_install x86_energy_perf_policy_install intel-speed-select_install:
 tmon_install:
 	$(call descend,thermal/$(@:_install=),install)
 
+thermometer_install:
+	$(call descend,thermal/$(@:_install=),install)
+
 freefall_install:
 	$(call descend,laptop/$(@:_install=),install)
 
@@ -140,7 +147,7 @@ install: acpi_install cgroup_install counter_install cpupower_install gpio_insta
 		virtio_install vm_install bpf_install x86_energy_perf_policy_install \
 		tmon_install freefall_install objtool_install kvm_stat_install \
 		wmi_install pci_install debugging_install intel-speed-select_install \
-		tracing_install
+		tracing_install thermometer_install
 
 acpi_clean:
 	$(call descend,power/acpi,clean)
@@ -173,6 +180,9 @@ thermal_clean:
 turbostat_clean x86_energy_perf_policy_clean intel-speed-select_clean:
 	$(call descend,power/x86/$(@:_clean=),clean)
 
+thermometer_clean:
+	$(call descend,thermal/thermometer,clean)
+
 tmon_clean:
 	$(call descend,thermal/tmon,clean)
 
@@ -187,6 +197,6 @@ clean: acpi_clean cgroup_clean counter_clean cpupower_clean hv_clean firewire_cl
 		vm_clean bpf_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
 		freefall_clean build_clean libbpf_clean libsubcmd_clean \
 		gpio_clean objtool_clean leds_clean wmi_clean pci_clean firmware_clean debugging_clean \
-		intel-speed-select_clean tracing_clean thermal_clean
+		intel-speed-select_clean tracing_clean thermal_clean thermometer_clean
 
 .PHONY: FORCE
diff --git a/tools/thermal/thermometer/Build b/tools/thermal/thermometer/Build
new file mode 100644
index 000000000000..2531dda4acdd
--- /dev/null
+++ b/tools/thermal/thermometer/Build
@@ -0,0 +1,2 @@
+thermometer-y += thermometer.o
+
diff --git a/tools/thermal/thermometer/Makefile b/tools/thermal/thermometer/Makefile
new file mode 100644
index 000000000000..7d08661b3472
--- /dev/null
+++ b/tools/thermal/thermometer/Makefile
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for cgroup tools
+
+ifeq ($(srctree),)
+srctree := $(patsubst %/,%,$(dir $(CURDIR)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+# $(info Determined 'srctree' to be $(srctree))
+endif
+
+CFLAGS = -Wall -Wextra
+CFLAGS += -I$(srctree)/tools/thermal/lib
+
+LDFLAGS = -L$(srctree)/tools/thermal/lib
+LDFLAGS += -lthermal_tools
+LDFLAGS += -lconfig
+
+all: thermometer
+%: %.c
+	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)
+
+clean:
+	$(RM) thermometer
diff --git a/tools/thermal/thermometer/thermometer.c b/tools/thermal/thermometer/thermometer.c
new file mode 100644
index 000000000000..12306c715320
--- /dev/null
+++ b/tools/thermal/thermometer/thermometer.c
@@ -0,0 +1,384 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2022, Linaro Ltd - Daniel Lezcano <daniel.lezcano@linaro.org>
+#define _GNU_SOURCE
+#include <dirent.h>
+#include <fcntl.h>
+#include <regex.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/timerfd.h>
+#include <sys/types.h>
+#include <time.h>
+#include <unistd.h>
+#include <linux/thermal.h>
+
+#include <libconfig.h>
+
+#include "thermal_tools.h"
+
+#define CLASS_THERMAL "/sys/class/thermal"
+
+struct options {
+	int loglvl;
+	int logopt;
+	int overwrite;
+	const char *config;
+	char postfix[PATH_MAX];
+	char output[PATH_MAX];
+};
+
+struct tz_regex {
+	regex_t regex;	
+	int polling;
+};
+
+struct configuration {
+	struct tz_regex *tz_regex;
+	int nr_tz_regex;
+
+};
+
+struct tz {
+	FILE *file_out;
+	int fd_temp;
+	int fd_timer;
+	int polling;
+	const char *name;
+};
+
+struct thermometer {
+	struct tz *tz;
+	int nr_tz;
+};
+
+static struct tz_regex *configuration_tz_match(const char *expr,
+					       struct configuration *config)
+{
+	int i;
+
+	for (i = 0; i < config->nr_tz_regex; i++) {
+
+		if (!regexec(&config->tz_regex[i].regex, expr, 0, NULL, 0))
+			return &config->tz_regex[i];
+	}
+
+	return NULL;
+}
+
+static int configuration_init(const char *path, struct configuration *config)
+{
+	config_t cfg;
+	
+	config_setting_t *tz;
+	int i, length;
+	
+	config_init(&cfg);
+
+	if (!config_read_file(&cfg, path)) {
+		ERROR("Failed to parse %s:%d - %s\n", config_error_file(&cfg),
+		      config_error_line(&cfg), config_error_text(&cfg));
+
+		return -1;
+	}
+
+	tz = config_lookup(&cfg, "thermal-zones");
+	if (!tz) {
+		ERROR("No thermal zone configured to be monitored\n");
+		return -1;
+	}
+
+	length = config_setting_length(tz);
+
+	INFO("Found %d thermal zone(s) regular expression\n", length);
+
+	for (i = 0; i < length; i++) {
+
+		config_setting_t *node;
+		const char *name;
+		int polling;
+
+		node = config_setting_get_elem(tz, i);
+		if (!node) {
+			ERROR("Missing node name '%d'\n", i);
+			return -1;
+		};
+
+		if (!config_setting_lookup_string(node, "name", &name)) {
+			ERROR("Thermal zone name not found\n");
+			return -1;
+		}
+
+		if (!config_setting_lookup_int(node, "polling", &polling)) {
+			ERROR("Polling value not found");
+			return -1;
+		}
+		
+		config->tz_regex = realloc(config->tz_regex, sizeof(*config->tz_regex) *
+					(config->nr_tz_regex + 1));
+
+		if (regcomp(&config->tz_regex[config->nr_tz_regex].regex, name,
+			    REG_NOSUB | REG_EXTENDED)) {
+			ERROR("Invalid regular expression '%s'\n", name);
+			continue;
+		}
+
+		config->tz_regex[config->nr_tz_regex].polling = polling;
+		config->nr_tz_regex++;
+
+		INFO("Thermal zone regular expression '%s' with polling %d\n",
+		     name, polling);
+	}
+	
+	return 0;
+}
+
+static int options_init(int argc, char *argv[], struct options *options)
+{
+	int opt;
+	time_t now = time(NULL);
+
+	strftime(options->postfix, sizeof(options->postfix),
+		 "-%Y-%m-%d_%H:%M:%S", gmtime(&now));
+	
+	while ((opt = getopt(argc, argv, "o:c:l:p:eswg")) != -1) {
+               switch (opt) {
+	       case 'c':
+		       options->config = optarg;
+		       break;
+	       case 'l':
+		       options->loglvl = log_str2level(optarg);
+		       break;
+	       case 'p':
+		       strcpy(options->postfix, optarg);
+		       break;
+	       case 'o':
+		       strcpy(options->output, optarg);
+		       break;
+	       case 'e':
+		       options->logopt |= TO_STDERR;
+		       break;
+	       case 's':
+		       options->logopt |= TO_STDOUT;
+		       break;
+	       case 'g':
+		       options->logopt |= TO_SYSLOG;
+		       break;
+	       case 'w':
+		       options->overwrite = 1;
+		       break;
+               default: /* '?' */
+		       ERROR("Usage: %s \n", argv[0]);
+		       return -1;
+               }
+	}
+
+	printf("Options;\n");
+	printf(" * config: '%s'\n", options->config);
+	printf(" * log level: '%d'\n", options->loglvl);
+	printf(" * postfix: %s\n", options->postfix);
+	printf(" * output: %s\n", options->output);
+
+	return 0;
+}
+
+static int thermometer_add_tz(const char *path, const char *name, int polling,
+			      struct thermometer *thermometer)
+{
+	int fd;
+	char tz_path[PATH_MAX];
+
+	sprintf(tz_path, CLASS_THERMAL"/%s/temp", path);
+
+	fd = open(tz_path, O_RDONLY);
+	if (fd < 0) {
+		ERROR("Failed to open '%s': %m\n", tz_path);
+		return -1;
+	}
+
+	thermometer->tz = realloc(thermometer->tz,
+				  sizeof(*thermometer->tz) * (thermometer->nr_tz + 1));
+	if (!thermometer->tz) {
+		ERROR("Failed to allocate thermometer->tz\n");
+		return -1;
+	}
+
+	thermometer->tz[thermometer->nr_tz].fd_temp = fd;
+	thermometer->tz[thermometer->nr_tz].name = strdup(name);
+	thermometer->tz[thermometer->nr_tz].polling = polling;
+	thermometer->nr_tz++;
+
+	INFO("Added thermal zone '%s->%s (polling:%d)'\n", path, name, polling);
+
+	return 0;
+}
+
+static int thermometer_init(struct configuration *config,
+			    struct thermometer *thermometer)
+{
+	DIR *dir;
+	struct dirent *dirent;
+	struct tz_regex *tz_regex;
+	const char *tz_dirname = "thermal_zone";
+
+	if (mainloop_init()) {
+		ERROR("Failed to start mainloop\n");
+		return -1;
+	}
+
+	dir = opendir(CLASS_THERMAL);
+        if (!dir) {
+                ERROR("failed to open '%s'\n", CLASS_THERMAL);
+                return -1;
+        }
+
+        while ((dirent = readdir(dir))) {
+		char tz_type[THERMAL_NAME_LENGTH];
+		char tz_path[PATH_MAX];
+		FILE *tz_file;
+		
+		if (strncmp(dirent->d_name, tz_dirname, strlen(tz_dirname)))
+			continue;
+
+		sprintf(tz_path, CLASS_THERMAL"/%s/type", dirent->d_name);
+
+		tz_file = fopen(tz_path, "r");
+		if (!tz_file) {
+			ERROR("Failed to open '%s': %m", tz_path);
+			continue;
+		}
+
+		fscanf(tz_file, "%s", tz_type);
+		
+		fclose(tz_file);
+
+		tz_regex = configuration_tz_match(tz_type, config);
+		if (!tz_regex)
+			continue;
+			
+		if (thermometer_add_tz(dirent->d_name, tz_type,
+				       tz_regex->polling, thermometer))
+			continue;
+	}
+
+        closedir(dir);
+
+	return 0;
+}
+
+static int timer_callback(int fd, void *arg)
+{
+	struct tz *tz = arg;
+	char buf[16] = { 0 };
+
+	pread(tz->fd_temp, buf, sizeof(buf), 0);
+
+	fprintf(tz->file_out, "%ld %s", getuptimeofday_ms(), buf);
+
+	read(fd, buf, sizeof(buf));
+	
+	return 0;
+}
+
+static int thermometer_start(struct thermometer *thermometer,
+			     struct options *options)
+{
+	struct itimerspec timer_it = { 0 };
+	char *path;
+	FILE *f;
+	int i;
+
+	for (i = 0; i < thermometer->nr_tz; i++) {
+
+		asprintf(&path, "%s/%s%s", options->output,
+			 thermometer->tz[i].name, options->postfix);
+
+		if (!options->overwrite && !access(path, F_OK)) {
+			ERROR("'%s' already exists\n", path);
+			return -1;
+		}
+		
+		f = fopen(path, "w");
+		if (!f) {
+			ERROR("Failed to create '%s':%m\n", path);
+			return -1;
+		}
+
+		fprintf(f, "timestamp(ms) %s(°mC)\n", thermometer->tz[i].name);
+
+		thermometer->tz[i].file_out = f;
+
+		/*
+		 * Create polling timer
+		 */
+		thermometer->tz[i].fd_timer = timerfd_create(CLOCK_MONOTONIC, 0);
+		if (thermometer->tz[i].fd_timer < 0) {
+			ERROR("Failed to create timer for '%s': %m\n",
+			      thermometer->tz[i].name);
+			return -1;
+		}
+
+		timer_it.it_interval = timer_it.it_value =
+			msec_to_timespec(thermometer->tz[i].polling);
+
+		if (timerfd_settime(thermometer->tz[i].fd_timer, 0,
+				    &timer_it, NULL) < 0)
+			return -1;
+
+		if (mainloop_add(thermometer->tz[i].fd_timer, timer_callback,
+				 &thermometer->tz[i]))
+			return -1;
+	}
+
+	return mainloop(-1);
+}
+
+static int thermometer_stop(struct thermometer *thermometer)
+{
+	int i;
+
+	INFO("Closing/flushing output files\n");
+	
+	for (i = 0; i < thermometer->nr_tz; i++) {
+		fclose(thermometer->tz[i].file_out);
+	}
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	struct options options = {
+		.config = "thermometer.conf",
+		.loglvl = LOG_DEBUG,
+		.output = ".",
+	};
+
+	struct configuration config = { 0 };
+
+	struct thermometer thermometer = { 0 };
+	
+	if (options_init(argc, argv, &options))
+		return -1;
+	
+	if (log_init(options.loglvl, argv[0], options.logopt))
+		return -1;
+
+	if (configuration_init(options.config, &config))
+		return -1;
+	
+	if (uptimeofday_init())
+		return -1;
+
+	if (thermometer_init(&config, &thermometer))
+		return -1;
+
+	if (thermometer_start(&thermometer, &options))
+		return -1;
+
+	if (thermometer_stop(&thermometer))
+		return -1;
+	
+	return 0;
+}
diff --git a/tools/thermal/thermometer/thermometer.conf b/tools/thermal/thermometer/thermometer.conf
new file mode 100644
index 000000000000..350907accb3e
--- /dev/null
+++ b/tools/thermal/thermometer/thermometer.conf
@@ -0,0 +1,5 @@
+
+thermal-zones = (
+	      {	name = "cpu[0-7]-thermal";
+	      	polling = 100; }
+      )
-- 
2.25.1


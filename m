Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C644BB983
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbiBRMyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:54:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbiBRMyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:54:41 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66552B31A4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 04:54:23 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id k41so5204553wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 04:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jSXbJw1rUuo8PYFX5hnOcOE3GUIhEKb5po2TwofCI7Q=;
        b=p57HJBhRA7jjaa4rnb92Ok40NBIwUYLAMmDd9viooDHPzg6lHevNLMO43yjEzh3yVl
         mlzLkbwSRUuuDsupJvhIdNKUoroprrpriEQz52mmEdhSPtPi49AqH+ydRrEw9nUt6Gl0
         nK41ONywFO280eTg+EgtIDqn84P3r+Y4vzdo3hs7SCIi3r1sOrsNAYZ11e42JPZdqjrK
         PR+qFW0K7Pix2OVhCo6cXqpZVnl8F4vFJvx51QatiTtL1SjW/UD1V6wqv5pVGSlzvCV7
         Nz2SKLUDyJdUjCuJ5nBjWlYBG1RBosvyyJhEOZY8MwvuWEcuO+b6M/oDvx6LzM8ACsOK
         JF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jSXbJw1rUuo8PYFX5hnOcOE3GUIhEKb5po2TwofCI7Q=;
        b=iozRuQGcKxD5dfPHHszEEmJusNlhESml4kDs6lN40KmPf3jms2LIn/oswZksPEvjCi
         52iUGg2FMCsL25z1v9qHiP+DvtWPjnH/qiI76wPDvbExMm27UydqFJnD/yy/Ky/G079h
         d870ZuAy+k+WmlIzcsCxd3xvywddC1nwS6F3VyhMyppeuyQPe5Ekdpbxme8ugZdgT4OU
         iDB7ZIAAWHE66JY+I2KfxWzYebybbFK91b29PtCEq2zV1+8ddfnUVAmyheZXthROj598
         WC/nkPXSPaNG9TMUp/p4RAOfphi1zSUVuwQKA24Ulc3x1W87Mx4+SBQRpJTSqZpb62W+
         thmw==
X-Gm-Message-State: AOAM533xkqY2Vd28eunnzjwNgWWDc5/4v4SrHayoE+b464S9Kld1gK6H
        tazJbZId4V/6fzsPhVKLU3FUYg==
X-Google-Smtp-Source: ABdhPJwQxDRRddw8Go+7N4Z8ucMR3r2kqzHNIrjafdFSVzSHR0cjDHInFbk5M5mrsX4VcXH2UR0Kxg==
X-Received: by 2002:a05:600c:285:b0:37b:e5b1:c446 with SMTP id 5-20020a05600c028500b0037be5b1c446mr6967811wmk.49.1645188862300;
        Fri, 18 Feb 2022 04:54:22 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:5828:300b:5226:ef02])
        by smtp.gmail.com with ESMTPSA id p7sm17034011wrr.95.2022.02.18.04.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 04:54:21 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     srinivas.pandruvada@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v1 3/4] tools/thermal: A temperature capture tool
Date:   Fri, 18 Feb 2022 13:53:33 +0100
Message-Id: <20220218125334.995447-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220218125334.995447-1-daniel.lezcano@linaro.org>
References: <20220218125334.995447-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
 tools/thermal/thermometer/thermometer.c    | 393 +++++++++++++++++++++
 tools/thermal/thermometer/thermometer.conf |   5 +
 5 files changed, 436 insertions(+), 3 deletions(-)
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
index 000000000000..966961ef21cb
--- /dev/null
+++ b/tools/thermal/thermometer/thermometer.c
@@ -0,0 +1,393 @@
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
+#include "thermal-tools.h"
+
+#define CLASS_THERMAL "/sys/class/thermal"
+
+enum {
+	THERMOMETER_SUCCESS = 0,
+	THERMOMETER_OPTION_ERROR,
+	THERMOMETER_LOG_ERROR,
+	THERMOMETER_CONFIG_ERROR,
+	THERMOMETER_TIME_ERROR,
+	THERMOMETER_INIT_ERROR,
+	THERMOMETER_RUNTIME_ERROR
+};
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
+		return THERMOMETER_OPTION_ERROR;
+	
+	if (log_init(options.loglvl, argv[0], options.logopt))
+		return THERMOMETER_LOG_ERROR;
+
+	if (configuration_init(options.config, &config))
+		return THERMOMETER_CONFIG_ERROR;
+	
+	if (uptimeofday_init())
+		return THERMOMETER_TIME_ERROR;
+
+	if (thermometer_init(&config, &thermometer))
+		return THERMOMETER_INIT_ERROR;
+
+	if (thermometer_start(&thermometer, &options))
+		return THERMOMETER_RUNTIME_ERROR;
+
+	if (thermometer_stop(&thermometer))
+		return THERMOMETER_RUNTIME_ERROR;
+	
+	return THERMOMETER_SUCCESS;
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0704EBE57
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 12:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245186AbiC3KH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 06:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245181AbiC3KHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:07:20 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECFCED9E4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 03:05:33 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r13so28469098wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 03:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PGQlj9TEsb6f3Qz+wlAvnxY/j23ohMghNrtlMbgqvGc=;
        b=YmYQ48smNP0yRiczg1vJ2Z0dGEXhbEhzJqvF+sKabr78HkFjZD1Cn+YVGJUqK6d7/l
         pIQtiW/cT3XRigXiHrKsQBvt1FyUVajkN3G+6fKbkzzfKF0jBlVejXQarSg3djdIkcKg
         hMNJfPcqLicmS/vn51oDWe41GXrVhgamd0ld0n+EhSAqdx6/11trYILMUsIggXk8NroE
         cDraBzO0RWTlaibFoDir9ZehlScMVxRfI64GWpmThY5TBoMQ/s+RABbZtpoKCu6K6OC7
         3CraZOU9AMu+csfIs7bP9wTQNrKWT7BWGVUiWXlFUk541olalL29nFL34lDd58L+8as/
         /nYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PGQlj9TEsb6f3Qz+wlAvnxY/j23ohMghNrtlMbgqvGc=;
        b=oDgFcGBlpwlLB6mFTsqDzJAngQh63t4SaSxAtpvxBJ8YsB6HpuwkyErK5M29kxpX7x
         ETczzsLS4UnuzcDAcw47Rd1+qUrnkqkUwNvSFHBkCPOFb00W+u4W/z0m4eJSGOYudUFF
         QJBHOwPY7RFF+svOgBuzJfTVUQuIr4ORZLw6aJTKOYxtmz5eVt6uX7QBD5f6Jz43fzWo
         XKDfOHoCM+azORUDVVxl7EYiHKPB4Ho5c0NNDH1ikPmIwZHt6XquPvtLQ7OHqORQArh0
         9vgfrncgs2LvsVtYnYwH2++pEWkN9RW8tQl9W03GW5MqPqov0qciLcOouVTV8qntjv8h
         N91w==
X-Gm-Message-State: AOAM532wJY3aYPk9KHe6rXFlH6OJj06RiftOSKPhjbghnZZSsv5L5Vo/
        oa934dt46w5SlptX/H5TFFb3gQ==
X-Google-Smtp-Source: ABdhPJwPQTgKhU5pPsl0td3R4tZUBHdwuc8zohS2IhF+KaLZ39qP0ErrK2uISxdTZ7cOwBcsWGqBRg==
X-Received: by 2002:a5d:6d8b:0:b0:203:e242:5e38 with SMTP id l11-20020a5d6d8b000000b00203e2425e38mr36036111wrs.105.1648634732037;
        Wed, 30 Mar 2022 03:05:32 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:8f92:3217:a3c6:3ee8])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d4e08000000b002054b5437f2sm16542743wrt.115.2022.03.30.03.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 03:05:31 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     srinivas.pandruvada@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v2 4/4] tools/thermal: Add thermal daemon skeleton
Date:   Wed, 30 Mar 2022 12:04:44 +0200
Message-Id: <20220330100444.3846661-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220330100444.3846661-1-daniel.lezcano@linaro.org>
References: <20220330100444.3846661-1-daniel.lezcano@linaro.org>
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

This change provides a simple daemon skeleton. It is an example of how
to use the thermal library which wraps all the complex code related to
the netlink and transforms it into a callback oriented code.

The goal of this skeleton is to give a base brick for anyone
interested in writing its own thermal engine or as an example to rely
on to write its own thermal monitoring implementation.

In the future, it will evolve with more features and hopefully more
logic.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 tools/Makefile                                |  16 +-
 tools/thermal/thermal-engine/Build            |   2 +
 tools/thermal/thermal-engine/Makefile         |  28 ++
 tools/thermal/thermal-engine/thermal-engine.c | 326 ++++++++++++++++++
 4 files changed, 369 insertions(+), 3 deletions(-)
 create mode 100644 tools/thermal/thermal-engine/Build
 create mode 100644 tools/thermal/thermal-engine/Makefile
 create mode 100644 tools/thermal/thermal-engine/thermal-engine.c

diff --git a/tools/Makefile b/tools/Makefile
index 78615f8cb463..b71cf39d3c08 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -32,6 +32,7 @@ help:
 	@echo '  spi                    - spi tools'
 	@echo '  tmon                   - thermal monitoring and tuning tool'
 	@echo '  thermometer            - temperature capture tool'
+	@echo '  thermal-engine         - thermal monitoring tool'
 	@echo '  thermal                - thermal library'
 	@echo '  tracing                - misc tracing tools'
 	@echo '  turbostat              - Intel CPU idle stats and freq reporting tool'
@@ -99,6 +100,9 @@ tmon: FORCE
 thermometer: FORCE
 	$(call descend,thermal/$@)
 
+thermal-engine: FORCE thermal
+	$(call descend,thermal/$@)
+
 freefall: FORCE
 	$(call descend,laptop/$@)
 
@@ -109,7 +113,7 @@ all: acpi cgroup counter cpupower gpio hv firewire \
 		perf selftests bootconfig spi turbostat usb \
 		virtio vm bpf x86_energy_perf_policy \
 		tmon freefall iio objtool kvm_stat wmi \
-		pci debugging tracing thermal thermometer
+		pci debugging tracing thermal thermometer thermal-engine
 
 acpi_install:
 	$(call descend,power/$(@:_install=),install)
@@ -135,6 +139,9 @@ tmon_install:
 thermometer_install:
 	$(call descend,thermal/$(@:_install=),install)
 
+thermal-engine_install:
+	$(call descend,thermal/$(@:_install=),install)
+
 freefall_install:
 	$(call descend,laptop/$(@:_install=),install)
 
@@ -147,7 +154,7 @@ install: acpi_install cgroup_install counter_install cpupower_install gpio_insta
 		virtio_install vm_install bpf_install x86_energy_perf_policy_install \
 		tmon_install freefall_install objtool_install kvm_stat_install \
 		wmi_install pci_install debugging_install intel-speed-select_install \
-		tracing_install thermometer_install
+		tracing_install thermometer_install thermal-engine_install
 
 acpi_clean:
 	$(call descend,power/acpi,clean)
@@ -183,6 +190,9 @@ turbostat_clean x86_energy_perf_policy_clean intel-speed-select_clean:
 thermometer_clean:
 	$(call descend,thermal/thermometer,clean)
 
+thermal-engine_clean:
+	$(call descend,thermal/thermal-engine,clean)
+
 tmon_clean:
 	$(call descend,thermal/tmon,clean)
 
@@ -197,6 +207,6 @@ clean: acpi_clean cgroup_clean counter_clean cpupower_clean hv_clean firewire_cl
 		vm_clean bpf_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
 		freefall_clean build_clean libbpf_clean libsubcmd_clean \
 		gpio_clean objtool_clean leds_clean wmi_clean pci_clean firmware_clean debugging_clean \
-		intel-speed-select_clean tracing_clean thermal_clean thermometer_clean
+		intel-speed-select_clean tracing_clean thermal_clean thermometer_clean thermal-engine_clean
 
 .PHONY: FORCE
diff --git a/tools/thermal/thermal-engine/Build b/tools/thermal/thermal-engine/Build
new file mode 100644
index 000000000000..0c8b65248c80
--- /dev/null
+++ b/tools/thermal/thermal-engine/Build
@@ -0,0 +1,2 @@
+thermal-engine-y += thermal-engine.o
+
diff --git a/tools/thermal/thermal-engine/Makefile b/tools/thermal/thermal-engine/Makefile
new file mode 100644
index 000000000000..6bd05ff89485
--- /dev/null
+++ b/tools/thermal/thermal-engine/Makefile
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for thermal tools
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
+CFLAGS += -I$(srctree)/tools/lib/thermal/include
+
+LDFLAGS = -L$(srctree)/tools/thermal/lib
+LDFLAGS += -L$(srctree)/tools/lib/thermal
+LDFLAGS += -lthermal_tools
+LDFLAGS += -lthermal
+LDFLAGS += -lconfig
+LDFLAGS += -lnl-genl-3 -lnl-3
+
+VERSION = 0.0.1
+
+all: thermal-engine
+%: %.c
+	$(CC) $(CFLAGS) -D VERSION=\"$(VERSION)\" -o $@ $^ $(LDFLAGS)
+clean:
+	$(RM) thermal-engine
diff --git a/tools/thermal/thermal-engine/thermal-engine.c b/tools/thermal/thermal-engine/thermal-engine.c
new file mode 100644
index 000000000000..525520049aa2
--- /dev/null
+++ b/tools/thermal/thermal-engine/thermal-engine.c
@@ -0,0 +1,326 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Thermal monitoring tool based on the thermal netlink events.
+ *
+ * Copyright (C) 2022 Linaro Ltd.
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@kernel.org>
+ */
+#include <errno.h>
+#include <fcntl.h>
+#include <getopt.h>
+#include <libgen.h>
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <signal.h>
+#include <unistd.h>
+
+#include <syslog.h>
+
+#include <sys/epoll.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+
+#include <thermal.h>
+#include "thermal-tools.h"
+
+struct options {
+	int loglevel;
+	int logopt;
+	int interactive;
+	int daemonize;
+};
+
+struct thermal_data {
+	struct thermal_zone *tz;
+	struct thermal_handler *th;
+};
+
+static int show_trip(struct thermal_trip *tt, __maybe_unused void *arg)
+{
+	INFO("trip id=%d, type=%d, temp=%d, hyst=%d\n",
+	     tt->id, tt->type, tt->temp, tt->hyst);
+
+	return 0;
+}
+
+static int show_temp(struct thermal_zone *tz, __maybe_unused void *arg)
+{
+	thermal_cmd_get_temp(arg, tz);
+
+	INFO("temperature: %d\n", tz->temp);
+
+	return 0;
+}
+
+static int show_governor(struct thermal_zone *tz, __maybe_unused void *arg)
+{
+	thermal_cmd_get_governor(arg, tz);
+
+	INFO("governor: '%s'\n", tz->governor);
+
+	return 0;
+}
+
+static int show_tz(struct thermal_zone *tz, __maybe_unused void *arg)
+{
+	INFO("thermal zone '%s', id=%d\n", tz->name, tz->id);
+
+	for_each_thermal_trip(tz->trip, show_trip, NULL);
+
+	show_temp(tz, arg);
+
+	show_governor(tz, arg);
+
+	return 0;
+}
+
+static int tz_create(const char *name, int tz_id, __maybe_unused void *arg)
+{
+	INFO("Thermal zone '%s'/%d created\n", name, tz_id);
+
+	return 0;
+}
+
+static int tz_delete(int tz_id, __maybe_unused void *arg)
+{
+	INFO("Thermal zone %d deleted\n", tz_id);
+
+	return 0;
+}
+
+static int tz_disable(int tz_id, void *arg)
+{
+	struct thermal_data *td = arg;
+	struct thermal_zone *tz = thermal_zone_find_by_id(td->tz, tz_id);
+
+	INFO("Thermal zone %d ('%s') disabled\n", tz_id, tz->name);
+
+	return 0;
+}
+
+static int tz_enable(int tz_id, void *arg)
+{
+	struct thermal_data *td = arg;
+	struct thermal_zone *tz = thermal_zone_find_by_id(td->tz, tz_id);
+
+	INFO("Thermal zone %d ('%s') enabled\n", tz_id, tz->name);
+
+	return 0;
+}
+
+static int trip_high(int tz_id, int trip_id, int temp, void *arg)
+{
+	struct thermal_data *td = arg;
+	struct thermal_zone *tz = thermal_zone_find_by_id(td->tz, tz_id);
+
+	INFO("Thermal zone %d ('%s'): trip point %d crossed way up with %d °C\n",
+	     tz_id, tz->name, trip_id, temp);
+
+	return 0;
+}
+
+static int trip_low(int tz_id, int trip_id, int temp, void *arg)
+{
+	struct thermal_data *td = arg;
+	struct thermal_zone *tz = thermal_zone_find_by_id(td->tz, tz_id);
+
+	INFO("Thermal zone %d ('%s'): trip point %d crossed way down with %d °C\n",
+	     tz_id, tz->name, trip_id, temp);
+
+	return 0;
+}
+
+static int trip_add(int tz_id, int trip_id, int type, int temp, int hyst, __maybe_unused void *arg)
+{
+	INFO("Trip point added %d: id=%d, type=%d, temp=%d, hyst=%d\n",
+	     tz_id, trip_id, type, temp, hyst);
+
+	return 0;
+}
+
+static int trip_delete(int tz_id, int trip_id, __maybe_unused void *arg)
+{
+	INFO("Trip point deleted %d: id=%d\n", tz_id, trip_id);
+
+	return 0;
+}
+
+static int trip_change(int tz_id, int trip_id, int type, int temp,
+		       int hyst, __maybe_unused void *arg)
+{
+	struct thermal_data *td = arg;
+	struct thermal_zone *tz = thermal_zone_find_by_id(td->tz, tz_id);
+
+	INFO("Trip point changed %d: id=%d, type=%d, temp=%d, hyst=%d\n",
+	     tz_id, trip_id, type, temp, hyst);
+
+	tz->trip[trip_id].type = type;
+	tz->trip[trip_id].temp = temp;
+	tz->trip[trip_id].hyst = hyst;
+
+	return 0;
+}
+
+static int cdev_add(const char *name, int cdev_id, int max_state, __maybe_unused void *arg)
+{
+	INFO("Cooling device '%s'/%d (max state=%d) added\n", name, cdev_id, max_state);
+
+	return 0;
+}
+
+static int cdev_delete(int cdev_id, __maybe_unused void *arg)
+{
+	INFO("Cooling device %d deleted", cdev_id);
+
+	return 0;
+}
+
+static int cdev_update(int cdev_id, int cur_state, __maybe_unused void *arg)
+{
+	INFO("cdev:%d state:%d\n", cdev_id, cur_state);
+
+	return 0;
+}
+
+static int gov_change(int tz_id, const char *name, __maybe_unused void *arg)
+{
+	struct thermal_data *td = arg;
+	struct thermal_zone *tz = thermal_zone_find_by_id(td->tz, tz_id);
+
+	INFO("%s: governor changed %s -> %s\n", tz->name, tz->governor, name);
+
+	strcpy(tz->governor, name);
+
+	return 0;
+}
+
+static struct thermal_ops ops = {
+	.events.tz_create	= tz_create,
+	.events.tz_delete	= tz_delete,
+	.events.tz_disable	= tz_disable,
+	.events.tz_enable	= tz_enable,
+	.events.trip_high	= trip_high,
+	.events.trip_low	= trip_low,
+	.events.trip_add	= trip_add,
+	.events.trip_delete	= trip_delete,
+	.events.trip_change	= trip_change,
+	.events.cdev_add	= cdev_add,
+	.events.cdev_delete	= cdev_delete,
+	.events.cdev_update	= cdev_update,
+	.events.gov_change	= gov_change
+};
+
+static int thermal_event(__maybe_unused int fd, __maybe_unused void *arg)
+{
+	struct thermal_data *td = arg;
+
+	return thermal_events_handle(td->th, td);
+}
+
+static void help(const char *cmd)
+{
+	printf("%s : A thermal monitoring engine based on notifications\n", cmd);
+	printf("Usage: %s [options]\n", cmd);
+	printf("\t-h, --help\t\tthis help\n");
+	printf("\t-d, --daemonize\tcapture duration\n");
+	printf("\t-l <level>, --loglevel <level>\tlog level: ");
+	printf("DEBUG, INFO, NOTICE, WARN, ERROR\n");
+	printf("\t-s, --syslog\t\toutput to syslog\n");
+	printf("\n");
+	exit(0);
+}
+
+static int options_init(int argc, char *argv[], struct options *options)
+{
+	int opt;
+
+	struct option long_options[] = {
+		{ "help",	no_argument, NULL, 'h' },
+		{ "daemonize",	no_argument, NULL, 'd' },
+		{ "syslog",	no_argument, NULL, 's' },
+		{ "loglevel",	required_argument, NULL, 'l' },
+		{ 0, 0, 0, 0 }
+	};
+
+	while (1) {
+
+		int optindex = 0;
+
+		opt = getopt_long(argc, argv, "l:dhs", long_options, &optindex);
+		if (opt == -1)
+			break;
+
+		switch (opt) {
+		case 'l':
+			options->loglevel = log_str2level(optarg);
+			break;
+		case 'd':
+			options->daemonize = 1;
+			break;
+		case 's':
+			options->logopt = TO_SYSLOG;
+			break;
+		case 'h':
+			help(basename(argv[0]));
+			break;
+		default: /* '?' */
+			ERROR("Usage: %s --help\n", argv[0]);
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+enum {
+	THERMAL_ENGINE_SUCCESS = 0,
+	THERMAL_ENGINE_OPTION_ERROR,
+	THERMAL_ENGINE_DAEMON_ERROR,
+	THERMAL_ENGINE_LOG_ERROR,
+	THERMAL_ENGINE_THERMAL_ERROR,
+	THERMAL_ENGINE_MAINLOOP_ERROR,
+};
+
+int main(int argc, char *argv[])
+{
+	struct thermal_data td;
+	struct options options = {
+		.loglevel = LOG_INFO,
+		.logopt = TO_STDOUT,
+	};
+
+	if (options_init(argc, argv, &options))
+		return THERMAL_ENGINE_OPTION_ERROR;
+
+	if (options.daemonize && daemon(0, 0))
+		return THERMAL_ENGINE_DAEMON_ERROR;
+
+	if (log_init(options.loglevel, basename(argv[0]), options.logopt))
+		return THERMAL_ENGINE_LOG_ERROR;
+
+	td.th = thermal_init(&ops);
+	if (!td.th)
+		return THERMAL_ENGINE_THERMAL_ERROR;
+
+	td.tz = thermal_zone_discover(td.th);
+	if (!td.tz)
+		return THERMAL_ENGINE_THERMAL_ERROR;
+
+	for_each_thermal_zone(td.tz, show_tz, td.th);
+
+	if (mainloop_init())
+		return THERMAL_ENGINE_MAINLOOP_ERROR;
+
+	if (mainloop_add(thermal_events_fd(td.th), thermal_event, &td))
+		return THERMAL_ENGINE_MAINLOOP_ERROR;
+
+	INFO("Waiting for thermal events ...\n");
+
+	if (mainloop(-1))
+		return THERMAL_ENGINE_MAINLOOP_ERROR;
+
+	return THERMAL_ENGINE_SUCCESS;
+}
-- 
2.25.1


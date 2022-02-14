Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDF14B5C52
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiBNVHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:07:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiBNVFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:05:47 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FF7107ABD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:05:37 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d27so25079032wrb.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SgFhE0ZevlJqqlaQprgZ5E8JMdmDi6MgeaIR829GhFw=;
        b=tj/Lhe63yEW0CDHrv+8qOihzNYnrcLv7k8n9w4FeUOKWDfF1mDBA04evDxb817hnds
         7Zq8HF2Ek9gR9auC3iC2wS9xFabwmENPFzgZaBBukD5qy7Ye1DC/euiSkd4D2qJXkYAN
         6x7XbQYP+OuVXkBsRoCsBAHrHBW5a5sgEF4FjflMLUM4bEksjJFN30s4qGodLNdtIKXM
         WKhLtNQ/XyRUaCKN/s5+45OtPzkzCjWJw1T2r8TF8pkr+DSggX0hLI5+xS9lBQE5BzQs
         4xjgv/i5hi3ovW/6nC4sDOXuKsepgbtFYSoqfKAZgJ0xE+MDIdjfLt6PgJ8CTjkSkxhk
         dvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SgFhE0ZevlJqqlaQprgZ5E8JMdmDi6MgeaIR829GhFw=;
        b=L7FseLtb2C3cKGdCX/yyLT/MEoqNik/VMH6UmJ/8+qg9sfJgDvNJ2v6Qn/Veaxxauu
         LIFQIjIXb34BEJbgSMPd+1V9XA0S2370bKTxsZxRgDMYxgzqa/A5a/5UFlcvA8vQ748n
         NOXnKt1vRDF0nWiC1x0+Z/5ifG/L8qRGWGArfrY81nH9y+9nloeEaUEYsy7q0h2yTZVJ
         /TaHZKbkTTtU2uxVcK4X0sYEpcpzJRYW1CSEfRc1wzd+1V6tomJNtUR7kj4mhhncu2Rn
         aLDSghCMBVzF/W9HtXjmGxxoJqvXOdOPvv9yUHSbKxdAax9YEGpzv+iPXb2OSORcHS2I
         fy2Q==
X-Gm-Message-State: AOAM532gna4ahClzsuEZgDEcYZsfyGOeKGvy+tyUuckPOrSbpvCykKpQ
        K2mQIwjitPSg7puU6Dd9Y2yysA==
X-Google-Smtp-Source: ABdhPJzAJoedXfGK513QCXoYgNttqjVb1H8c5LmxUf+c3dbA9K0TQ0DOOkhDswetMl2FU3nS3xtQmg==
X-Received: by 2002:a5d:4e48:: with SMTP id r8mr668408wrt.570.1644872735565;
        Mon, 14 Feb 2022 13:05:35 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:758e:84ee:c9c7:9bfb])
        by smtp.gmail.com with ESMTPSA id az7sm16137189wmb.14.2022.02.14.13.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 13:05:34 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     srinivas.pandruvada@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [RFC PATCH 4/4] tools/thermal: Add thermal daemon skeleton
Date:   Mon, 14 Feb 2022 22:04:30 +0100
Message-Id: <20220214210446.255780-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220214210446.255780-1-daniel.lezcano@linaro.org>
References: <20220214210446.255780-1-daniel.lezcano@linaro.org>
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

This change provides a simple daemon skeleton. It provides an example
of how to use the thermal library.

The goal of this skeleton is to give a base brick for anyone
interested in writing its own thermal engine.

In the future, it will evolve with more features.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 tools/Makefile                    |  16 +-
 tools/thermal/thermald/Build      |   2 +
 tools/thermal/thermald/Makefile   |  27 +++
 tools/thermal/thermald/thermald.c | 275 ++++++++++++++++++++++++++++++
 4 files changed, 317 insertions(+), 3 deletions(-)
 create mode 100644 tools/thermal/thermald/Build
 create mode 100644 tools/thermal/thermald/Makefile
 create mode 100644 tools/thermal/thermald/thermald.c

diff --git a/tools/Makefile b/tools/Makefile
index 78615f8cb463..a8c4a65ac953 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -32,6 +32,7 @@ help:
 	@echo '  spi                    - spi tools'
 	@echo '  tmon                   - thermal monitoring and tuning tool'
 	@echo '  thermometer            - temperature capture tool'
+	@echo '  thermald               - thermal monitoring tool'
 	@echo '  thermal                - thermal library'
 	@echo '  tracing                - misc tracing tools'
 	@echo '  turbostat              - Intel CPU idle stats and freq reporting tool'
@@ -99,6 +100,9 @@ tmon: FORCE
 thermometer: FORCE
 	$(call descend,thermal/$@)
 
+thermald: FORCE thermal
+	$(call descend,thermal/$@)
+
 freefall: FORCE
 	$(call descend,laptop/$@)
 
@@ -109,7 +113,7 @@ all: acpi cgroup counter cpupower gpio hv firewire \
 		perf selftests bootconfig spi turbostat usb \
 		virtio vm bpf x86_energy_perf_policy \
 		tmon freefall iio objtool kvm_stat wmi \
-		pci debugging tracing thermal thermometer
+		pci debugging tracing thermal thermometer thermald
 
 acpi_install:
 	$(call descend,power/$(@:_install=),install)
@@ -135,6 +139,9 @@ tmon_install:
 thermometer_install:
 	$(call descend,thermal/$(@:_install=),install)
 
+thermald_install:
+	$(call descend,thermal/$(@:_install=),install)
+
 freefall_install:
 	$(call descend,laptop/$(@:_install=),install)
 
@@ -147,7 +154,7 @@ install: acpi_install cgroup_install counter_install cpupower_install gpio_insta
 		virtio_install vm_install bpf_install x86_energy_perf_policy_install \
 		tmon_install freefall_install objtool_install kvm_stat_install \
 		wmi_install pci_install debugging_install intel-speed-select_install \
-		tracing_install thermometer_install
+		tracing_install thermometer_install thermald_install
 
 acpi_clean:
 	$(call descend,power/acpi,clean)
@@ -183,6 +190,9 @@ turbostat_clean x86_energy_perf_policy_clean intel-speed-select_clean:
 thermometer_clean:
 	$(call descend,thermal/thermometer,clean)
 
+thermald_clean:
+	$(call descend,thermal/thermald,clean)
+
 tmon_clean:
 	$(call descend,thermal/tmon,clean)
 
@@ -197,6 +207,6 @@ clean: acpi_clean cgroup_clean counter_clean cpupower_clean hv_clean firewire_cl
 		vm_clean bpf_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
 		freefall_clean build_clean libbpf_clean libsubcmd_clean \
 		gpio_clean objtool_clean leds_clean wmi_clean pci_clean firmware_clean debugging_clean \
-		intel-speed-select_clean tracing_clean thermal_clean thermometer_clean
+		intel-speed-select_clean tracing_clean thermal_clean thermometer_clean thermald_clean
 
 .PHONY: FORCE
diff --git a/tools/thermal/thermald/Build b/tools/thermal/thermald/Build
new file mode 100644
index 000000000000..23a8ff56d290
--- /dev/null
+++ b/tools/thermal/thermald/Build
@@ -0,0 +1,2 @@
+thermald-y += thermald.o
+
diff --git a/tools/thermal/thermald/Makefile b/tools/thermal/thermald/Makefile
new file mode 100644
index 000000000000..c74e87c2b233
--- /dev/null
+++ b/tools/thermal/thermald/Makefile
@@ -0,0 +1,27 @@
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
+CFLAGS += -I$(srctree)/tools/lib/thermal/include
+
+LDFLAGS = -L$(srctree)/tools/thermal/lib
+LDFLAGS += -L$(srctree)/tools/lib/thermal
+LDFLAGS += -lthermal_tools
+LDFLAGS += -lthermal
+LDFLAGS += -lconfig
+LDFLAGS += -lnl-genl-3 -lnl-3
+
+all: thermald
+%: %.c
+	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)
+
+clean:
+	$(RM) thermald
diff --git a/tools/thermal/thermald/thermald.c b/tools/thermal/thermald/thermald.c
new file mode 100644
index 000000000000..92ced613c06e
--- /dev/null
+++ b/tools/thermal/thermald/thermald.c
@@ -0,0 +1,275 @@
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
+static int trip_change(int tz_id, int trip_id, int type, int temp, int hyst, __maybe_unused void *arg)
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
+static int options_init(int argc, char *argv[], struct options *options)
+{
+	int opt;
+	
+	while ((opt = getopt(argc, argv, "sl:")) != -1) {
+               switch (opt) {
+	       case 'l':
+		       options->loglevel = log_str2level(optarg);
+		       break;
+	       case 's':
+		       options->logopt |= TO_STDOUT;
+		       break;
+               default: /* '?' */
+		       ERROR("Usage: %s \n", argv[0]);
+		       return -1;
+               }
+	}
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	struct thermal_data td;
+	struct options options = {
+		.loglevel = LOG_DEBUG,
+		.logopt = LOG_SYSLOG
+	};
+
+	if (options_init(argc, argv, &options))
+		return 1;
+
+	if (!(options.logopt & TO_STDOUT) && daemon(0, 0))
+		return 1;
+	
+	if (log_init(options.loglevel, basename(argv[0]), options.logopt))
+		return 1;
+
+	td.th = thermal_init(&ops);
+	if (!td.th)
+		return 1;
+
+	td.tz = thermal_zone_discover(td.th);
+	if (!td.tz)
+		return 1;
+
+	for_each_thermal_zone(td.tz, show_tz, td.th);
+	
+	if (mainloop_init())
+		return 1;
+
+	if (mainloop_add(thermal_events_fd(td.th), thermal_event, &td))
+		return 1;
+
+	return mainloop(-1);
+}
-- 
2.25.1


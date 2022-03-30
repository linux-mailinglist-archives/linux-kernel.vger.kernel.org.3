Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9034EBE50
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 12:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245142AbiC3KG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 06:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245138AbiC3KGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:06:55 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1460DFFA9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 03:05:08 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j18so28483259wrd.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 03:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X0cVlNPtVwnSw5gZ4pa9tLmY4mqZGnFS2d9FtzXI5Mw=;
        b=v62g3hqUY+W6WRvyKh4/6XLTxFWo+D9A7wPKo9NDMkbR4J6OTPUpQYmVabPOpsY8QN
         kRXAyLVTsdEwr9asT7iCXbeQ96FYgj2j0pWqs5JC/81gnf+NdbDmxkjulJYwLE4fAq0m
         Pvx3zpRZsqga5XCdIr6cw6C5fRlh5hOJsA3qoXPcvX67+glonnm3ICzDPkWIqfclxhLz
         5qE1sxv2dQFghcYmti2ZsBKwdVq09Yn7hgL4dnWmdDvr8+8hVHOb6qVYpQLowgx5IzWU
         qj/hL06Gf7X8tTL3NDolpFVUPcykn0d5GbbFdgYPWstEASu51aHUdE//RWimxZSVpUHv
         2Exw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X0cVlNPtVwnSw5gZ4pa9tLmY4mqZGnFS2d9FtzXI5Mw=;
        b=G9rsVbUpvubDufWDbG2HTJ2n65SmANzqfj0OAFMoQ+AIxFQdu1fp208iIJa/twLt49
         pCughD7jeeXZDL4IgMPRdheN+SAT4NME0Hj2Yrsxnq/bTi2PO/T4DXQp0fs5dslcXIoH
         sZEdoEUDcd3EVShlags/GDoXmkHE+KIX8z2VEj5sNrQQmEQu8p6z0LFblJSohXOXsq1v
         4i/IG6Wb1IDnV0tQB6tBGCU82Jl1HNMDU9alW53+1RUn/hvvNatjF2sJWMQ8Gba8uuA+
         o4LCpjzX+loaG1fto6L4ptdIVaw/2uk0E3+XhvwQmHvEaYP1FVLzRI+524QiJFu7eZKs
         Uk2w==
X-Gm-Message-State: AOAM530Bi7oDskqv0MnHYDehsmOnOL+e9BArgbTxgN2iW6wwK3ZtoxA8
        CzEwLwYPGfsEl/oSt0uDEU6VlA==
X-Google-Smtp-Source: ABdhPJwH24hPLHbH8z1duANBrwZa9loErloqxRSFFFsn1XXVVFb0HY6B/ZssziZEpoOa0Cz+hKJm/w==
X-Received: by 2002:a5d:498b:0:b0:203:e5d5:622c with SMTP id r11-20020a5d498b000000b00203e5d5622cmr35943781wrq.153.1648634707078;
        Wed, 30 Mar 2022 03:05:07 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:8f92:3217:a3c6:3ee8])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d4e08000000b002054b5437f2sm16542743wrt.115.2022.03.30.03.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 03:05:06 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     srinivas.pandruvada@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v2 1/4] tools/lib/thermal: Add a thermal library
Date:   Wed, 30 Mar 2022 12:04:41 +0200
Message-Id: <20220330100444.3846661-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220330100444.3846661-1-daniel.lezcano@linaro.org>
References: <20220330100444.3846661-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
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

The thermal framework implements a netlink notification mechanism to
be used by the userspace to have a thermal configuration discovery,
trip point changes or violation, cooling device changes notifications,
etc...

This library provides a level of abstraction for the thermal netlink
notification allowing the userspace to connect to the notification
mechanism more easily. The library is callback oriented.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 MAINTAINERS                              |   1 +
 tools/Makefile                           |  14 +-
 tools/lib/thermal/.gitignore             |   2 +
 tools/lib/thermal/Build                  |   5 +
 tools/lib/thermal/Makefile               | 165 +++++++++++
 tools/lib/thermal/commands.c             | 349 +++++++++++++++++++++++
 tools/lib/thermal/events.c               | 164 +++++++++++
 tools/lib/thermal/include/thermal.h      | 142 +++++++++
 tools/lib/thermal/libthermal.map         |  25 ++
 tools/lib/thermal/libthermal.pc.template |  12 +
 tools/lib/thermal/sampling.c             |  75 +++++
 tools/lib/thermal/thermal.c              | 126 ++++++++
 tools/lib/thermal/thermal_nl.c           | 215 ++++++++++++++
 tools/lib/thermal/thermal_nl.h           |  46 +++
 14 files changed, 1339 insertions(+), 2 deletions(-)
 create mode 100644 tools/lib/thermal/.gitignore
 create mode 100644 tools/lib/thermal/Build
 create mode 100644 tools/lib/thermal/Makefile
 create mode 100644 tools/lib/thermal/commands.c
 create mode 100644 tools/lib/thermal/events.c
 create mode 100644 tools/lib/thermal/include/thermal.h
 create mode 100644 tools/lib/thermal/libthermal.map
 create mode 100644 tools/lib/thermal/libthermal.pc.template
 create mode 100644 tools/lib/thermal/sampling.c
 create mode 100644 tools/lib/thermal/thermal.c
 create mode 100644 tools/lib/thermal/thermal_nl.c
 create mode 100644 tools/lib/thermal/thermal_nl.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3bcb6f13617f..07fb2d6e2810 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19129,6 +19129,7 @@ F:	drivers/thermal/
 F:	include/linux/cpu_cooling.h
 F:	include/linux/thermal.h
 F:	include/uapi/linux/thermal.h
+F:	tools/lib/thermal/
 F:	tools/thermal/
 
 THERMAL DRIVER FOR AMLOGIC SOCS
diff --git a/tools/Makefile b/tools/Makefile
index db2f7b8ebed5..c253cbd27c06 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -31,6 +31,7 @@ help:
 	@echo '  bootconfig             - boot config tool'
 	@echo '  spi                    - spi tools'
 	@echo '  tmon                   - thermal monitoring and tuning tool'
+	@echo '  thermal                - thermal library'
 	@echo '  tracing                - misc tracing tools'
 	@echo '  turbostat              - Intel CPU idle stats and freq reporting tool'
 	@echo '  usb                    - USB testing tools'
@@ -85,6 +86,9 @@ perf: FORCE
 selftests: FORCE
 	$(call descend,testing/$@)
 
+thermal: FORCE
+	$(call descend,lib/$@)
+
 turbostat x86_energy_perf_policy intel-speed-select: FORCE
 	$(call descend,power/x86/$@)
 
@@ -101,7 +105,7 @@ all: acpi cgroup counter cpupower gpio hv firewire \
 		perf selftests bootconfig spi turbostat usb \
 		virtio vm bpf x86_energy_perf_policy \
 		tmon freefall iio objtool kvm_stat wmi \
-		pci debugging tracing
+		pci debugging tracing thermal
 
 acpi_install:
 	$(call descend,power/$(@:_install=),install)
@@ -115,6 +119,9 @@ cgroup_install counter_install firewire_install gpio_install hv_install iio_inst
 selftests_install:
 	$(call descend,testing/$(@:_install=),install)
 
+thermal_install:
+	$(call descend,lib/$(@:_install=),install)
+
 turbostat_install x86_energy_perf_policy_install intel-speed-select_install:
 	$(call descend,power/x86/$(@:_install=),install)
 
@@ -160,6 +167,9 @@ perf_clean:
 selftests_clean:
 	$(call descend,testing/$(@:_clean=),clean)
 
+thermal_clean:
+	$(call descend,lib/thermal,clean)
+
 turbostat_clean x86_energy_perf_policy_clean intel-speed-select_clean:
 	$(call descend,power/x86/$(@:_clean=),clean)
 
@@ -177,6 +187,6 @@ clean: acpi_clean cgroup_clean counter_clean cpupower_clean hv_clean firewire_cl
 		vm_clean bpf_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
 		freefall_clean build_clean libbpf_clean libsubcmd_clean \
 		gpio_clean objtool_clean leds_clean wmi_clean pci_clean firmware_clean debugging_clean \
-		intel-speed-select_clean tracing_clean
+		intel-speed-select_clean tracing_clean thermal_clean
 
 .PHONY: FORCE
diff --git a/tools/lib/thermal/.gitignore b/tools/lib/thermal/.gitignore
new file mode 100644
index 000000000000..5d2aeda80fea
--- /dev/null
+++ b/tools/lib/thermal/.gitignore
@@ -0,0 +1,2 @@
+libthermal.so*
+libthermal.pc
diff --git a/tools/lib/thermal/Build b/tools/lib/thermal/Build
new file mode 100644
index 000000000000..4a892d9e24f9
--- /dev/null
+++ b/tools/lib/thermal/Build
@@ -0,0 +1,5 @@
+libthermal-y += commands.o
+libthermal-y += events.o
+libthermal-y += thermal_nl.o
+libthermal-y += sampling.o
+libthermal-y += thermal.o
diff --git a/tools/lib/thermal/Makefile b/tools/lib/thermal/Makefile
new file mode 100644
index 000000000000..2d0d255fd0e1
--- /dev/null
+++ b/tools/lib/thermal/Makefile
@@ -0,0 +1,165 @@
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+# Most of this file is copied from tools/lib/perf/Makefile
+
+LIBTHERMAL_VERSION = 0
+LIBTHERMAL_PATCHLEVEL = 0
+LIBTHERMAL_EXTRAVERSION = 1
+
+MAKEFLAGS += --no-print-directory
+
+ifeq ($(srctree),)
+srctree := $(patsubst %/,%,$(dir $(CURDIR)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+# $(info Determined 'srctree' to be $(srctree))
+endif
+
+INSTALL = install
+
+# Use DESTDIR for installing into a different root directory.
+# This is useful for building a package. The program will be
+# installed in this directory as if it was the root directory.
+# Then the build tool can move it later.
+DESTDIR ?=
+DESTDIR_SQ = '$(subst ','\'',$(DESTDIR))'
+
+include $(srctree)/tools/scripts/Makefile.include
+include $(srctree)/tools/scripts/Makefile.arch
+
+ifeq ($(LP64), 1)
+  libdir_relative = lib64
+else
+  libdir_relative = lib
+endif
+
+prefix ?=
+libdir = $(prefix)/$(libdir_relative)
+
+# Shell quotes
+libdir_SQ = $(subst ','\'',$(libdir))
+libdir_relative_SQ = $(subst ','\'',$(libdir_relative))
+
+ifeq ("$(origin V)", "command line")
+  VERBOSE = $(V)
+endif
+ifndef VERBOSE
+  VERBOSE = 0
+endif
+
+ifeq ($(VERBOSE),1)
+  Q =
+else
+  Q = @
+endif
+
+# Set compile option CFLAGS
+ifdef EXTRA_CFLAGS
+  CFLAGS := $(EXTRA_CFLAGS)
+else
+  CFLAGS := -g -Wall
+endif
+
+INCLUDES = \
+-I/usr/include/libnl3 \
+-I$(srctree)/tools/lib/thermal/include \
+-I$(srctree)/tools/lib/ \
+-I$(srctree)/tools/include \
+-I$(srctree)/tools/arch/$(SRCARCH)/include/ \
+-I$(srctree)/tools/arch/$(SRCARCH)/include/uapi \
+-I$(srctree)/tools/include/uapi
+
+# Append required CFLAGS
+override CFLAGS += $(EXTRA_WARNINGS)
+override CFLAGS += -Werror -Wall
+override CFLAGS += -fPIC
+override CFLAGS += $(INCLUDES)
+override CFLAGS += -fvisibility=hidden
+override CFGLAS += -Wl,-L.
+override CFGLAS += -Wl,-lthermal
+
+all:
+
+export srctree OUTPUT CC LD CFLAGS V
+export DESTDIR DESTDIR_SQ
+
+include $(srctree)/tools/build/Makefile.include
+
+VERSION_SCRIPT := libthermal.map
+
+PATCHLEVEL    = $(LIBTHERMAL_PATCHLEVEL)
+EXTRAVERSION  = $(LIBTHERMAL_EXTRAVERSION)
+VERSION       = $(LIBTHERMAL_VERSION).$(LIBTHERMAL_PATCHLEVEL).$(LIBTHERMAL_EXTRAVERSION)
+
+LIBTHERMAL_SO := $(OUTPUT)libthermal.so.$(VERSION)
+LIBTHERMAL_A  := $(OUTPUT)libthermal.a
+LIBTHERMAL_IN := $(OUTPUT)libthermal-in.o
+LIBTHERMAL_PC := $(OUTPUT)libthermal.pc
+LIBTHERMAL_ALL := $(LIBTHERMAL_A) $(OUTPUT)libthermal.so*
+
+THERMAL_UAPI := include/uapi/linux/thermal.h
+
+$(THERMAL_UAPI): FORCE
+	ln -sf $(srctree)/$@ $(srctree)/tools/$@
+
+$(LIBTHERMAL_IN): FORCE
+	$(Q)$(MAKE) $(build)=libthermal
+
+$(LIBTHERMAL_A): $(LIBTHERMAL_IN)
+	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIBTHERMAL_IN)
+
+$(LIBTHERMAL_SO): $(LIBTHERMAL_IN)
+	$(QUIET_LINK)$(CC) --shared -Wl,-soname,libthermal.so \
+                                    -Wl,--version-script=$(VERSION_SCRIPT) $^ -o $@
+	@ln -sf $(@F) $(OUTPUT)libthermal.so
+	@ln -sf $(@F) $(OUTPUT)libthermal.so.$(LIBTHERMAL_VERSION)
+
+
+libs: $(THERMAL_UAPI) $(LIBTHERMAL_A) $(LIBTHERMAL_SO) $(LIBTHERMAL_PC)
+
+all: fixdep
+	$(Q)$(MAKE) libs
+
+clean:
+	$(call QUIET_CLEAN, libthermal) $(RM) $(LIBTHERMAL_A) \
+                *.o *~ *.a *.so *.so.$(VERSION) *.so.$(LIBTHERMAL_VERSION) .*.d .*.cmd LIBTHERMAL-CFLAGS $(LIBTHERMAL_PC)
+
+$(LIBTHERMAL_PC):
+	$(QUIET_GEN)sed -e "s|@PREFIX@|$(prefix)|" \
+		-e "s|@LIBDIR@|$(libdir_SQ)|" \
+		-e "s|@VERSION@|$(VERSION)|" \
+		< libthermal.pc.template > $@
+
+define do_install_mkdir
+	if [ ! -d '$(DESTDIR_SQ)$1' ]; then             \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$1'; \
+	fi
+endef
+
+define do_install
+	if [ ! -d '$(DESTDIR_SQ)$2' ]; then             \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$2'; \
+	fi;                                             \
+	$(INSTALL) $1 $(if $3,-m $3,) '$(DESTDIR_SQ)$2'
+endef
+
+install_lib: libs
+	$(call QUIET_INSTALL, $(LIBTHERMAL_ALL)) \
+		$(call do_install_mkdir,$(libdir_SQ)); \
+		cp -fpR $(LIBTHERMAL_ALL) $(DESTDIR)$(libdir_SQ)
+
+install_headers:
+	$(call QUIET_INSTALL, headers) \
+		$(call do_install,include/thermal.h,$(prefix)/include/thermal,644); \
+
+install_pkgconfig: $(LIBTHERMAL_PC)
+	$(call QUIET_INSTALL, $(LIBTHERMAL_PC)) \
+		$(call do_install,$(LIBTHERMAL_PC),$(libdir_SQ)/pkgconfig,644)
+
+install_doc:
+	$(Q)$(MAKE) -C Documentation install-man install-html install-examples
+
+install: install_lib install_headers install_pkgconfig
+
+FORCE:
+
+.PHONY: all install clean FORCE
diff --git a/tools/lib/thermal/commands.c b/tools/lib/thermal/commands.c
new file mode 100644
index 000000000000..539083780107
--- /dev/null
+++ b/tools/lib/thermal/commands.c
@@ -0,0 +1,349 @@
+// SPDX-License-Identifier: LGPL-2.1+
+// Copyright (C) 2022, Linaro Ltd - Daniel Lezcano <daniel.lezcano@linaro.org>
+#define _GNU_SOURCE
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include <thermal.h>
+#include "thermal_nl.h"
+
+static struct nla_policy thermal_genl_policy[THERMAL_GENL_ATTR_MAX + 1] = {
+	/* Thermal zone */
+	[THERMAL_GENL_ATTR_TZ]                  = { .type = NLA_NESTED },
+	[THERMAL_GENL_ATTR_TZ_ID]               = { .type = NLA_U32 },
+	[THERMAL_GENL_ATTR_TZ_TEMP]             = { .type = NLA_U32 },
+	[THERMAL_GENL_ATTR_TZ_TRIP]             = { .type = NLA_NESTED },
+	[THERMAL_GENL_ATTR_TZ_TRIP_ID]          = { .type = NLA_U32 },
+	[THERMAL_GENL_ATTR_TZ_TRIP_TEMP]        = { .type = NLA_U32 },
+	[THERMAL_GENL_ATTR_TZ_TRIP_TYPE]        = { .type = NLA_U32 },
+	[THERMAL_GENL_ATTR_TZ_TRIP_HYST]        = { .type = NLA_U32 },
+	[THERMAL_GENL_ATTR_TZ_MODE]             = { .type = NLA_U32 },
+	[THERMAL_GENL_ATTR_TZ_CDEV_WEIGHT]      = { .type = NLA_U32 },
+	[THERMAL_GENL_ATTR_TZ_NAME]             = { .type = NLA_STRING },
+
+	/* Governor(s) */
+	[THERMAL_GENL_ATTR_TZ_GOV]              = { .type = NLA_NESTED },
+	[THERMAL_GENL_ATTR_TZ_GOV_NAME]         = { .type = NLA_STRING },
+
+	/* Cooling devices */
+	[THERMAL_GENL_ATTR_CDEV]                = { .type = NLA_NESTED },
+	[THERMAL_GENL_ATTR_CDEV_ID]             = { .type = NLA_U32 },
+	[THERMAL_GENL_ATTR_CDEV_CUR_STATE]      = { .type = NLA_U32 },
+	[THERMAL_GENL_ATTR_CDEV_MAX_STATE]      = { .type = NLA_U32 },
+	[THERMAL_GENL_ATTR_CDEV_NAME]           = { .type = NLA_STRING },
+};
+
+static int parse_tz_get(struct genl_info *info, struct thermal_zone **tz)
+{
+	struct nlattr *attr;
+	struct thermal_zone *__tz = NULL;
+	size_t size = 0;
+	int rem;
+
+	nla_for_each_nested(attr, info->attrs[THERMAL_GENL_ATTR_TZ], rem) {
+
+		if (nla_type(attr) == THERMAL_GENL_ATTR_TZ_ID) {
+
+			size++;
+
+			__tz = realloc(__tz, sizeof(*__tz) * (size + 2));
+			if (!__tz)
+				return THERMAL_ERROR;
+
+			__tz[size - 1].id = nla_get_u32(attr);
+		}
+
+
+		if (nla_type(attr) == THERMAL_GENL_ATTR_TZ_NAME)
+			nla_strlcpy(__tz[size - 1].name, attr,
+				    THERMAL_NAME_LENGTH);
+	}
+
+	/*
+	 * We end the array of thermal zones
+	 */
+	__tz[size].id = -1;
+
+	*tz = __tz;
+
+	return THERMAL_SUCCESS;
+}
+
+static int parse_cdev_get(struct genl_info *info, struct thermal_cdev **cdev)
+{
+	struct nlattr *attr;
+	struct thermal_cdev *__cdev = NULL;
+	size_t size = 0;
+	int rem;
+
+	nla_for_each_nested(attr, info->attrs[THERMAL_GENL_ATTR_CDEV], rem) {
+
+		if (nla_type(attr) == THERMAL_GENL_ATTR_CDEV_ID) {
+
+			size++;
+
+			__cdev = realloc(__cdev, sizeof(*__cdev) * (size + 2));
+			if (!__cdev)
+				return THERMAL_ERROR;
+
+			__cdev[size - 1].id = nla_get_u32(attr);
+		}
+
+		if (nla_type(attr) == THERMAL_GENL_ATTR_CDEV_NAME) {
+			nla_strlcpy(__cdev[size - 1].name, attr,
+				    THERMAL_NAME_LENGTH);
+		}
+
+		if (nla_type(attr) == THERMAL_GENL_ATTR_CDEV_CUR_STATE)
+			__cdev[size - 1].cur_state = nla_get_u32(attr);
+
+		if (nla_type(attr) == THERMAL_GENL_ATTR_CDEV_MAX_STATE)
+			__cdev[size - 1].max_state = nla_get_u32(attr);
+	}
+
+	__cdev[size].id = -1;
+
+	*cdev = __cdev;
+
+	return THERMAL_SUCCESS;
+}
+
+static int parse_tz_get_trip(struct genl_info *info, struct thermal_zone *tz)
+{
+	struct nlattr *attr;
+	struct thermal_trip *__tt = NULL;
+	size_t size = 0;
+	int rem;
+
+	nla_for_each_nested(attr, info->attrs[THERMAL_GENL_ATTR_TZ_TRIP], rem) {
+
+		if (nla_type(attr) == THERMAL_GENL_ATTR_TZ_TRIP_ID) {
+
+			size++;
+
+			__tt = realloc(__tt, sizeof(*__tt) * (size + 2));
+			if (!__tt)
+				return THERMAL_ERROR;
+
+			__tt[size - 1].id = nla_get_u32(attr);
+		}
+
+		if (nla_type(attr) == THERMAL_GENL_ATTR_TZ_TRIP_TYPE)
+			__tt[size - 1].type = nla_get_u32(attr);
+
+		if (nla_type(attr) == THERMAL_GENL_ATTR_TZ_TRIP_TEMP)
+			__tt[size - 1].temp = nla_get_u32(attr);
+
+		if (nla_type(attr) == THERMAL_GENL_ATTR_TZ_TRIP_HYST)
+			__tt[size - 1].hyst = nla_get_u32(attr);
+	}
+
+	__tt[size].id = -1;
+
+	tz->trip = __tt;
+
+	return THERMAL_SUCCESS;
+}
+
+static int parse_tz_get_temp(struct genl_info *info, struct thermal_zone *tz)
+{
+	int id = -1;
+
+	if (info->attrs[THERMAL_GENL_ATTR_TZ_ID])
+		id = nla_get_u32(info->attrs[THERMAL_GENL_ATTR_TZ_ID]);
+
+	if (tz->id != id)
+		return THERMAL_ERROR;
+
+	if (info->attrs[THERMAL_GENL_ATTR_TZ_TEMP])
+		tz->temp = nla_get_u32(info->attrs[THERMAL_GENL_ATTR_TZ_TEMP]);
+
+	return THERMAL_SUCCESS;
+}
+
+static int parse_tz_get_gov(struct genl_info *info, struct thermal_zone *tz)
+{
+	int id = -1;
+
+	if (info->attrs[THERMAL_GENL_ATTR_TZ_ID])
+		id = nla_get_u32(info->attrs[THERMAL_GENL_ATTR_TZ_ID]);
+
+	if (tz->id != id)
+		return THERMAL_ERROR;
+
+	if (info->attrs[THERMAL_GENL_ATTR_TZ_GOV_NAME]) {
+		nla_strlcpy(tz->governor,
+			    info->attrs[THERMAL_GENL_ATTR_TZ_GOV_NAME],
+			    THERMAL_NAME_LENGTH);
+	}
+
+	return THERMAL_SUCCESS;
+}
+
+static int handle_netlink(struct nl_cache_ops *unused,
+			  struct genl_cmd *cmd,
+			  struct genl_info *info, void *arg)
+{
+	int ret;
+
+	switch (cmd->c_id) {
+
+	case THERMAL_GENL_CMD_TZ_GET_ID:
+		ret = parse_tz_get(info, arg);
+		break;
+
+	case THERMAL_GENL_CMD_CDEV_GET:
+		ret = parse_cdev_get(info, arg);
+		break;
+
+	case THERMAL_GENL_CMD_TZ_GET_TEMP:
+		ret = parse_tz_get_temp(info, arg);
+		break;
+
+	case THERMAL_GENL_CMD_TZ_GET_TRIP:
+		ret = parse_tz_get_trip(info, arg);
+		break;
+
+	case THERMAL_GENL_CMD_TZ_GET_GOV:
+		ret = parse_tz_get_gov(info, arg);
+		break;
+
+	default:
+		return THERMAL_ERROR;
+	};
+
+	return ret;
+}
+
+static struct genl_cmd thermal_cmds[] = {
+	{
+		.c_id		= THERMAL_GENL_CMD_TZ_GET_ID,
+		.c_name		= (char *)"List thermal zones",
+		.c_msg_parser	= handle_netlink,
+		.c_maxattr	= THERMAL_GENL_ATTR_MAX,
+		.c_attr_policy	= thermal_genl_policy,
+	},
+	{
+		.c_id		= THERMAL_GENL_CMD_TZ_GET_GOV,
+		.c_name		= (char *)"Get governor",
+		.c_msg_parser	= handle_netlink,
+		.c_maxattr	= THERMAL_GENL_ATTR_MAX,
+		.c_attr_policy	= thermal_genl_policy,
+	},
+	{
+		.c_id		= THERMAL_GENL_CMD_TZ_GET_TEMP,
+		.c_name		= (char *)"Get thermal zone temperature",
+		.c_msg_parser	= handle_netlink,
+		.c_maxattr	= THERMAL_GENL_ATTR_MAX,
+		.c_attr_policy	= thermal_genl_policy,
+	},
+	{
+		.c_id		= THERMAL_GENL_CMD_TZ_GET_TRIP,
+		.c_name		= (char *)"Get thermal zone trip points",
+		.c_msg_parser	= handle_netlink,
+		.c_maxattr	= THERMAL_GENL_ATTR_MAX,
+		.c_attr_policy	= thermal_genl_policy,
+	},
+	{
+		.c_id		= THERMAL_GENL_CMD_CDEV_GET,
+		.c_name		= (char *)"Get cooling devices",
+		.c_msg_parser	= handle_netlink,
+		.c_maxattr	= THERMAL_GENL_ATTR_MAX,
+		.c_attr_policy	= thermal_genl_policy,
+	},
+};
+
+static struct genl_ops thermal_cmd_ops = {
+	.o_name		= (char *)"thermal",
+	.o_cmds		= thermal_cmds,
+	.o_ncmds	= ARRAY_SIZE(thermal_cmds),
+};
+
+static thermal_error_t thermal_genl_auto(struct thermal_handler *th, int id, int cmd,
+					 int flags, void *arg)
+{
+	struct nl_msg *msg;
+	void *hdr;
+
+	msg = nlmsg_alloc();
+	if (!msg)
+		return THERMAL_ERROR;
+
+	hdr = genlmsg_put(msg, NL_AUTO_PORT, NL_AUTO_SEQ, thermal_cmd_ops.o_id,
+			  0, flags, cmd, THERMAL_GENL_VERSION);
+	if (!hdr)
+		return THERMAL_ERROR;
+
+	if (id >= 0 && nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_ID, id))
+		return THERMAL_ERROR;
+
+	if (nl_send_msg(th->sk_cmd, th->cb_cmd, msg, genl_handle_msg, arg))
+		return THERMAL_ERROR;
+
+	nlmsg_free(msg);
+
+	return THERMAL_SUCCESS;
+}
+
+thermal_error_t thermal_cmd_get_tz(struct thermal_handler *th, struct thermal_zone **tz)
+{
+	return thermal_genl_auto(th, -1, THERMAL_GENL_CMD_TZ_GET_ID,
+				 NLM_F_DUMP | NLM_F_ACK, tz);
+}
+
+thermal_error_t thermal_cmd_get_cdev(struct thermal_handler *th, struct thermal_cdev **tc)
+{
+	return thermal_genl_auto(th, -1, THERMAL_GENL_CMD_CDEV_GET,
+				 NLM_F_DUMP | NLM_F_ACK, tc);
+}
+
+thermal_error_t thermal_cmd_get_trip(struct thermal_handler *th, struct thermal_zone *tz)
+{
+	return thermal_genl_auto(th, tz->id, THERMAL_GENL_CMD_TZ_GET_TRIP,
+				 0, tz);
+}
+
+thermal_error_t thermal_cmd_get_governor(struct thermal_handler *th, struct thermal_zone *tz)
+{
+	return thermal_genl_auto(th, tz->id, THERMAL_GENL_CMD_TZ_GET_GOV, 0, tz);
+}
+
+thermal_error_t thermal_cmd_get_temp(struct thermal_handler *th, struct thermal_zone *tz)
+{
+	return thermal_genl_auto(th, tz->id, THERMAL_GENL_CMD_TZ_GET_TEMP, 0, tz);
+}
+
+thermal_error_t thermal_cmd_exit(struct thermal_handler *th)
+{
+	if (genl_unregister_family(&thermal_cmd_ops))
+		return THERMAL_ERROR;
+
+	nl_thermal_disconnect(th->sk_cmd, th->cb_cmd);
+
+	return THERMAL_SUCCESS;
+}
+
+thermal_error_t thermal_cmd_init(struct thermal_handler *th)
+{
+	int ret;
+	int family;
+
+	if (nl_thermal_connect(&th->sk_cmd, &th->cb_cmd))
+		return THERMAL_ERROR;
+
+	ret = genl_register_family(&thermal_cmd_ops);
+	if (ret)
+		return THERMAL_ERROR;
+
+	ret = genl_ops_resolve(th->sk_cmd, &thermal_cmd_ops);
+	if (ret)
+		return THERMAL_ERROR;
+
+	family = genl_ctrl_resolve(th->sk_cmd, "nlctrl");
+	if (family != GENL_ID_CTRL)
+		return THERMAL_ERROR;
+
+	return THERMAL_SUCCESS;
+}
diff --git a/tools/lib/thermal/events.c b/tools/lib/thermal/events.c
new file mode 100644
index 000000000000..a7a55d1a0c4c
--- /dev/null
+++ b/tools/lib/thermal/events.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: LGPL-2.1+
+// Copyright (C) 2022, Linaro Ltd - Daniel Lezcano <daniel.lezcano@linaro.org>
+#include <linux/netlink.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+
+#include <thermal.h>
+#include "thermal_nl.h"
+
+/*
+ * Optimization: fill this array to tell which event we do want to pay
+ * attention to. That happens at init time with the ops
+ * structure. Each ops will enable the event and the general handler
+ * will be able to discard the event if there is not ops associated
+ * with it.
+ */
+static int enabled_ops[__THERMAL_GENL_EVENT_MAX];
+
+static int handle_thermal_event(struct nl_msg *n, void *arg)
+{
+	struct nlmsghdr *nlh = nlmsg_hdr(n);
+	struct genlmsghdr *genlhdr = genlmsg_hdr(nlh);
+	struct nlattr *attrs[THERMAL_GENL_ATTR_MAX + 1];
+	struct thermal_handler_param *thp = arg;
+	struct thermal_events_ops *ops = &thp->th->ops->events;
+
+	genlmsg_parse(nlh, 0, attrs, THERMAL_GENL_ATTR_MAX, NULL);
+
+	arg = thp->arg;
+
+	/*
+	 * This is an event we don't care of, bail out.
+	 */
+	if (!enabled_ops[genlhdr->cmd])
+		return THERMAL_SUCCESS;
+
+	switch (genlhdr->cmd) {
+
+	case THERMAL_GENL_EVENT_TZ_CREATE:
+		return ops->tz_create(nla_get_string(attrs[THERMAL_GENL_ATTR_TZ_NAME]),
+				      nla_get_u32(attrs[THERMAL_GENL_ATTR_TZ_ID]), arg);
+
+	case THERMAL_GENL_EVENT_TZ_DELETE:
+		return ops->tz_delete(nla_get_u32(attrs[THERMAL_GENL_ATTR_TZ_ID]), arg);
+
+	case THERMAL_GENL_EVENT_TZ_ENABLE:
+		return ops->tz_enable(nla_get_u32(attrs[THERMAL_GENL_ATTR_TZ_ID]), arg);
+
+	case THERMAL_GENL_EVENT_TZ_DISABLE:
+		return ops->tz_disable(nla_get_u32(attrs[THERMAL_GENL_ATTR_TZ_ID]), arg);
+
+	case THERMAL_GENL_EVENT_TZ_TRIP_CHANGE:
+		return ops->trip_change(nla_get_u32(attrs[THERMAL_GENL_ATTR_TZ_ID]),
+					nla_get_u32(attrs[THERMAL_GENL_ATTR_TZ_TRIP_ID]),
+					nla_get_u32(attrs[THERMAL_GENL_ATTR_TZ_TRIP_TYPE]),
+					nla_get_u32(attrs[THERMAL_GENL_ATTR_TZ_TRIP_TEMP]),
+					nla_get_u32(attrs[THERMAL_GENL_ATTR_TZ_TRIP_HYST]), arg);
+
+	case THERMAL_GENL_EVENT_TZ_TRIP_ADD:
+		return ops->trip_add(nla_get_u32(attrs[THERMAL_GENL_ATTR_TZ_ID]),
+				     nla_get_u32(attrs[THERMAL_GENL_ATTR_TZ_TRIP_ID]),
+				     nla_get_u32(attrs[THERMAL_GENL_ATTR_TZ_TRIP_TYPE]),
+				     nla_get_u32(attrs[THERMAL_GENL_ATTR_TZ_TRIP_TEMP]),
+				     nla_get_u32(attrs[THERMAL_GENL_ATTR_TZ_TRIP_HYST]), arg);
+
+	case THERMAL_GENL_EVENT_TZ_TRIP_DELETE:
+		return ops->trip_delete(nla_get_u32(attrs[THERMAL_GENL_ATTR_TZ_ID]),
+					nla_get_u32(attrs[THERMAL_GENL_ATTR_TZ_TRIP_ID]), arg);
+
+	case THERMAL_GENL_EVENT_TZ_TRIP_UP:
+		return ops->trip_high(nla_get_u32(attrs[THERMAL_GENL_ATTR_TZ_ID]),
+				      nla_get_u32(attrs[THERMAL_GENL_ATTR_TZ_TRIP_ID]),
+				      nla_get_u32(attrs[THERMAL_GENL_ATTR_TZ_TEMP]), arg);
+
+	case THERMAL_GENL_EVENT_TZ_TRIP_DOWN:
+		return ops->trip_low(nla_get_u32(attrs[THERMAL_GENL_ATTR_TZ_ID]),
+				     nla_get_u32(attrs[THERMAL_GENL_ATTR_TZ_TRIP_ID]),
+				     nla_get_u32(attrs[THERMAL_GENL_ATTR_TZ_TEMP]), arg);
+
+	case THERMAL_GENL_EVENT_CDEV_ADD:
+		return ops->cdev_add(nla_get_string(attrs[THERMAL_GENL_ATTR_CDEV_NAME]),
+				     nla_get_u32(attrs[THERMAL_GENL_ATTR_CDEV_ID]),
+				     nla_get_u32(attrs[THERMAL_GENL_ATTR_CDEV_MAX_STATE]), arg);
+
+	case THERMAL_GENL_EVENT_CDEV_DELETE:
+		return ops->cdev_delete(nla_get_u32(attrs[THERMAL_GENL_ATTR_CDEV_ID]), arg);
+
+	case THERMAL_GENL_EVENT_CDEV_STATE_UPDATE:
+		return ops->cdev_update(nla_get_u32(attrs[THERMAL_GENL_ATTR_CDEV_ID]),
+					nla_get_u32(attrs[THERMAL_GENL_ATTR_CDEV_CUR_STATE]), arg);
+
+	case THERMAL_GENL_EVENT_TZ_GOV_CHANGE:
+		return ops->gov_change(nla_get_u32(attrs[THERMAL_GENL_ATTR_TZ_ID]),
+				       nla_get_string(attrs[THERMAL_GENL_ATTR_GOV_NAME]), arg);
+	default:
+		return -1;
+	}
+}
+
+static void thermal_events_ops_init(struct thermal_events_ops *ops)
+{
+	enabled_ops[THERMAL_GENL_EVENT_TZ_CREATE]	= !!ops->tz_create;
+	enabled_ops[THERMAL_GENL_EVENT_TZ_DELETE]	= !!ops->tz_delete;
+	enabled_ops[THERMAL_GENL_EVENT_TZ_DISABLE]	= !!ops->tz_disable;
+	enabled_ops[THERMAL_GENL_EVENT_TZ_ENABLE]	= !!ops->tz_enable;
+	enabled_ops[THERMAL_GENL_EVENT_TZ_TRIP_UP]	= !!ops->trip_high;
+	enabled_ops[THERMAL_GENL_EVENT_TZ_TRIP_DOWN]	= !!ops->trip_low;
+	enabled_ops[THERMAL_GENL_EVENT_TZ_TRIP_CHANGE]	= !!ops->trip_change;
+	enabled_ops[THERMAL_GENL_EVENT_TZ_TRIP_ADD]	= !!ops->trip_add;
+	enabled_ops[THERMAL_GENL_EVENT_TZ_TRIP_DELETE]	= !!ops->trip_delete;
+	enabled_ops[THERMAL_GENL_EVENT_CDEV_ADD]	= !!ops->cdev_add;
+	enabled_ops[THERMAL_GENL_EVENT_CDEV_DELETE]	= !!ops->cdev_delete;
+	enabled_ops[THERMAL_GENL_EVENT_CDEV_STATE_UPDATE] = !!ops->cdev_update;
+	enabled_ops[THERMAL_GENL_EVENT_TZ_GOV_CHANGE]	= !!ops->gov_change;
+}
+
+thermal_error_t thermal_events_handle(struct thermal_handler *th, void *arg)
+{
+	struct thermal_handler_param thp = { .th = th, .arg = arg };
+
+	if (!th)
+		return THERMAL_ERROR;
+
+	if (nl_cb_set(th->cb_event, NL_CB_VALID, NL_CB_CUSTOM,
+		      handle_thermal_event, &thp))
+		return THERMAL_ERROR;
+
+	return nl_recvmsgs(th->sk_event, th->cb_event);
+}
+
+int thermal_events_fd(struct thermal_handler *th)
+{
+	if (!th)
+		return -1;
+
+	return nl_socket_get_fd(th->sk_event);
+}
+
+thermal_error_t thermal_events_exit(struct thermal_handler *th)
+{
+	if (nl_unsubscribe_thermal(th->sk_event, th->cb_event,
+				   THERMAL_GENL_EVENT_GROUP_NAME))
+		return THERMAL_ERROR;
+
+	nl_thermal_disconnect(th->sk_event, th->cb_event);
+
+	return THERMAL_SUCCESS;
+}
+
+thermal_error_t thermal_events_init(struct thermal_handler *th)
+{
+	thermal_events_ops_init(&th->ops->events);
+
+	if (nl_thermal_connect(&th->sk_event, &th->cb_event))
+		return THERMAL_ERROR;
+
+	if (nl_subscribe_thermal(th->sk_event, th->cb_event,
+				 THERMAL_GENL_EVENT_GROUP_NAME))
+		return THERMAL_ERROR;
+
+	return THERMAL_SUCCESS;
+}
diff --git a/tools/lib/thermal/include/thermal.h b/tools/lib/thermal/include/thermal.h
new file mode 100644
index 000000000000..1abc560602cf
--- /dev/null
+++ b/tools/lib/thermal/include/thermal.h
@@ -0,0 +1,142 @@
+/* SPDX-License-Identifier: LGPL-2.1+ */
+/* Copyright (C) 2022, Linaro Ltd - Daniel Lezcano <daniel.lezcano@linaro.org> */
+#ifndef __LIBTHERMAL_H
+#define __LIBTHERMAL_H
+
+#include <linux/thermal.h>
+
+#ifndef LIBTHERMAL_API
+#define LIBTHERMAL_API __attribute__((visibility("default")))
+#endif
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+struct thermal_sampling_ops {
+	int (*tz_temp)(int tz_id, int temp, void *arg);
+};
+
+struct thermal_events_ops {
+	int (*tz_create)(const char *name, int tz_id, void *arg);
+	int (*tz_delete)(int tz_id, void *arg);
+	int (*tz_enable)(int tz_id, void *arg);
+	int (*tz_disable)(int tz_id, void *arg);
+	int (*trip_high)(int tz_id, int trip_id, int temp, void *arg);
+	int (*trip_low)(int tz_id, int trip_id, int temp, void *arg);
+	int (*trip_add)(int tz_id, int trip_id, int type, int temp, int hyst, void *arg);
+	int (*trip_change)(int tz_id, int trip_id, int type, int temp, int hyst, void *arg);
+	int (*trip_delete)(int tz_id, int trip_id, void *arg);
+	int (*cdev_add)(const char *name, int cdev_id, int max_state, void *arg);
+	int (*cdev_delete)(int cdev_id, void *arg);
+	int (*cdev_update)(int cdev_id, int cur_state, void *arg);
+	int (*gov_change)(int tz_id, const char *gov_name, void *arg);
+};
+
+struct thermal_ops {
+	struct thermal_sampling_ops sampling;
+	struct thermal_events_ops events;
+};
+
+struct thermal_trip {
+	int id;
+	int type;
+	int temp;
+	int hyst;
+};
+
+struct thermal_zone {
+	int id;
+	int temp;
+	char name[THERMAL_NAME_LENGTH];
+	char governor[THERMAL_NAME_LENGTH];
+	struct thermal_trip *trip;
+};
+
+struct thermal_cdev {
+	int id;
+	char name[THERMAL_NAME_LENGTH];
+	int max_state;
+	int min_state;
+	int cur_state;
+};
+
+typedef enum {
+	THERMAL_ERROR = -1,
+	THERMAL_SUCCESS = 0,
+} thermal_error_t;
+
+struct thermal_handler;
+
+typedef int (*cb_tz_t)(struct thermal_zone *, void *);
+
+typedef int (*cb_tt_t)(struct thermal_trip *, void *);
+
+typedef int (*cb_tc_t)(struct thermal_cdev *, void *);
+
+LIBTHERMAL_API int for_each_thermal_zone(struct thermal_zone *tz, cb_tz_t cb, void *arg);
+
+LIBTHERMAL_API int for_each_thermal_trip(struct thermal_trip *tt, cb_tt_t cb, void *arg);
+
+LIBTHERMAL_API int for_each_thermal_cdev(struct thermal_cdev *cdev, cb_tc_t cb, void *arg);
+
+LIBTHERMAL_API struct thermal_zone *thermal_zone_find_by_name(struct thermal_zone *tz,
+							      const char *name);
+
+LIBTHERMAL_API struct thermal_zone *thermal_zone_find_by_id(struct thermal_zone *tz, int id);
+
+LIBTHERMAL_API struct thermal_zone *thermal_zone_discover(struct thermal_handler *th);
+
+LIBTHERMAL_API struct thermal_handler *thermal_init(struct thermal_ops *ops);
+
+LIBTHERMAL_API void thermal_exit(struct thermal_handler *th);
+
+/*
+ * Netlink thermal events
+ */
+LIBTHERMAL_API thermal_error_t thermal_events_exit(struct thermal_handler *th);
+
+LIBTHERMAL_API thermal_error_t thermal_events_init(struct thermal_handler *th);
+
+LIBTHERMAL_API thermal_error_t thermal_events_handle(struct thermal_handler *th, void *arg);
+
+LIBTHERMAL_API int thermal_events_fd(struct thermal_handler *th);
+
+/*
+ * Netlink thermal commands
+ */
+LIBTHERMAL_API thermal_error_t thermal_cmd_exit(struct thermal_handler *th);
+
+LIBTHERMAL_API thermal_error_t thermal_cmd_init(struct thermal_handler *th);
+
+LIBTHERMAL_API thermal_error_t thermal_cmd_get_tz(struct thermal_handler *th,
+						  struct thermal_zone **tz);
+
+LIBTHERMAL_API thermal_error_t thermal_cmd_get_cdev(struct thermal_handler *th,
+						    struct thermal_cdev **tc);
+
+LIBTHERMAL_API thermal_error_t thermal_cmd_get_trip(struct thermal_handler *th,
+						    struct thermal_zone *tz);
+
+LIBTHERMAL_API thermal_error_t thermal_cmd_get_governor(struct thermal_handler *th,
+							struct thermal_zone *tz);
+
+LIBTHERMAL_API thermal_error_t thermal_cmd_get_temp(struct thermal_handler *th,
+						    struct thermal_zone *tz);
+
+/*
+ * Netlink thermal samples
+ */
+LIBTHERMAL_API thermal_error_t thermal_sampling_exit(struct thermal_handler *th);
+
+LIBTHERMAL_API thermal_error_t thermal_sampling_init(struct thermal_handler *th);
+
+LIBTHERMAL_API thermal_error_t thermal_sampling_handle(struct thermal_handler *th, void *arg);
+
+LIBTHERMAL_API int thermal_sampling_fd(struct thermal_handler *th);
+
+#endif /* __LIBTHERMAL_H */
+
+#ifdef __cplusplus
+}
+#endif
diff --git a/tools/lib/thermal/libthermal.map b/tools/lib/thermal/libthermal.map
new file mode 100644
index 000000000000..d5e77738c7a4
--- /dev/null
+++ b/tools/lib/thermal/libthermal.map
@@ -0,0 +1,25 @@
+LIBTHERMAL_0.0.1 {
+	global:
+		thermal_init;
+		for_each_thermal_zone;
+		for_each_thermal_trip;
+		for_each_thermal_cdev;
+		thermal_zone_find_by_name;
+		thermal_zone_find_by_id;
+		thermal_zone_discover;
+		thermal_init;
+		thermal_events_init;
+		thermal_events_handle;
+		thermal_events_fd;
+		thermal_cmd_init;
+		thermal_cmd_get_tz;
+		thermal_cmd_get_cdev;
+		thermal_cmd_get_trip;
+		thermal_cmd_get_governor;
+		thermal_cmd_get_temp;
+		thermal_sampling_init;
+		thermal_sampling_handle;
+		thermal_sampling_fd;
+local:
+		*;
+};
diff --git a/tools/lib/thermal/libthermal.pc.template b/tools/lib/thermal/libthermal.pc.template
new file mode 100644
index 000000000000..6f3769731b59
--- /dev/null
+++ b/tools/lib/thermal/libthermal.pc.template
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+prefix=@PREFIX@
+libdir=@LIBDIR@
+includedir=${prefix}/include
+
+Name: libthermal
+Description: thermal library
+Requires: libnl-3.0 libnl-genl-3.0
+Version: @VERSION@
+Libs: -L${libdir} -lnl-genl-3 -lnl-3
+Cflags: -I${includedir} -I{include}/libnl3
diff --git a/tools/lib/thermal/sampling.c b/tools/lib/thermal/sampling.c
new file mode 100644
index 000000000000..ee818f4e9654
--- /dev/null
+++ b/tools/lib/thermal/sampling.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: LGPL-2.1+
+// Copyright (C) 2022, Linaro Ltd - Daniel Lezcano <daniel.lezcano@linaro.org>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include <thermal.h>
+#include "thermal_nl.h"
+
+static int handle_thermal_sample(struct nl_msg *n, void *arg)
+{
+	struct nlmsghdr *nlh = nlmsg_hdr(n);
+	struct genlmsghdr *genlhdr = genlmsg_hdr(nlh);
+	struct nlattr *attrs[THERMAL_GENL_ATTR_MAX + 1];
+	struct thermal_handler_param *thp = arg;
+	struct thermal_handler *th = thp->th;
+
+	genlmsg_parse(nlh, 0, attrs, THERMAL_GENL_ATTR_MAX, NULL);
+
+	switch (genlhdr->cmd) {
+
+	case THERMAL_GENL_SAMPLING_TEMP:
+		return th->ops->sampling.tz_temp(
+			nla_get_u32(attrs[THERMAL_GENL_ATTR_TZ_ID]),
+			nla_get_u32(attrs[THERMAL_GENL_ATTR_TZ_TEMP]), arg);
+	default:
+		return THERMAL_ERROR;
+	}
+}
+
+thermal_error_t thermal_sampling_handle(struct thermal_handler *th, void *arg)
+{
+	struct thermal_handler_param thp = { .th = th, .arg = arg };
+
+	if (!th)
+		return THERMAL_ERROR;
+
+	if (nl_cb_set(th->cb_sampling, NL_CB_VALID, NL_CB_CUSTOM,
+		      handle_thermal_sample, &thp))
+		return THERMAL_ERROR;
+
+	return nl_recvmsgs(th->sk_sampling, th->cb_sampling);
+}
+
+int thermal_sampling_fd(struct thermal_handler *th)
+{
+	if (!th)
+		return -1;
+
+	return nl_socket_get_fd(th->sk_sampling);
+}
+
+thermal_error_t thermal_sampling_exit(struct thermal_handler *th)
+{
+	if (nl_unsubscribe_thermal(th->sk_sampling, th->cb_sampling,
+				   THERMAL_GENL_EVENT_GROUP_NAME))
+		return THERMAL_ERROR;
+
+	nl_thermal_disconnect(th->sk_sampling, th->cb_sampling);
+
+	return THERMAL_SUCCESS;
+}
+
+thermal_error_t thermal_sampling_init(struct thermal_handler *th)
+{
+	if (nl_thermal_connect(&th->sk_sampling, &th->cb_sampling))
+		return THERMAL_ERROR;
+
+	if (nl_subscribe_thermal(th->sk_sampling, th->cb_sampling,
+				 THERMAL_GENL_SAMPLING_GROUP_NAME))
+		return THERMAL_ERROR;
+
+	return THERMAL_SUCCESS;
+}
diff --git a/tools/lib/thermal/thermal.c b/tools/lib/thermal/thermal.c
new file mode 100644
index 000000000000..a80b967ce334
--- /dev/null
+++ b/tools/lib/thermal/thermal.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: LGPL-2.1+
+// Copyright (C) 2022, Linaro Ltd - Daniel Lezcano <daniel.lezcano@linaro.org>
+#include <stdio.h>
+#include <thermal.h>
+
+#include "thermal_nl.h"
+
+int for_each_thermal_cdev(struct thermal_cdev *cdev, cb_tc_t cb, void *arg)
+{
+	int i, ret = 0;
+
+	for (i = 0; cdev[i].id != -1; i++)
+		ret |= cb(&cdev[i], arg);
+
+	return ret;
+}
+
+int for_each_thermal_trip(struct thermal_trip *tt, cb_tt_t cb, void *arg)
+{
+	int i, ret = 0;
+
+	for (i = 0; tt[i].id != -1; i++)
+		ret |= cb(&tt[i], arg);
+
+	return ret;
+}
+
+int for_each_thermal_zone(struct thermal_zone *tz, cb_tz_t cb, void *arg)
+{
+	int i, ret = 0;
+
+	for (i = 0; tz[i].id != -1; i++)
+		ret |= cb(&tz[i], arg);
+
+	return ret;
+}
+
+struct thermal_zone *thermal_zone_find_by_name(struct thermal_zone *tz,
+					       const char *name)
+{
+	int i;
+
+	if (!name)
+		return NULL;
+
+	for (i = 0; tz[i].id != -1; i++) {
+		if (!strcmp(tz[i].name, name))
+			return &tz[i];
+	}
+
+	return NULL;
+}
+
+struct thermal_zone *thermal_zone_find_by_id(struct thermal_zone *tz, int id)
+{
+	int i;
+
+	if (id < 0)
+		return NULL;
+
+	for (i = 0; tz[i].id != -1; i++) {
+		if (tz[i].id == id)
+			return &tz[i];
+	}
+
+	return NULL;
+}
+
+static int __thermal_zone_discover(struct thermal_zone *tz, void *th)
+{
+	if (thermal_cmd_get_trip(th, tz) < 0)
+		return -1;
+
+	if (thermal_cmd_get_governor(th, tz))
+		return -1;
+
+	return 0;
+}
+
+struct thermal_zone *thermal_zone_discover(struct thermal_handler *th)
+{
+	struct thermal_zone *tz;
+
+	if (thermal_cmd_get_tz(th, &tz) < 0)
+		return NULL;
+
+	if (for_each_thermal_zone(tz, __thermal_zone_discover, th))
+		return NULL;
+
+	return tz;
+}
+
+void thermal_exit(struct thermal_handler *th)
+{
+	thermal_cmd_exit(th);
+	thermal_events_exit(th);
+	thermal_sampling_exit(th);
+
+	free(th);
+}
+
+struct thermal_handler *thermal_init(struct thermal_ops *ops)
+{
+	struct thermal_handler *th;
+
+	th = malloc(sizeof(*th));
+	if (!th)
+		return NULL;
+	th->ops = ops;
+
+	if (thermal_events_init(th))
+		goto out_free;
+
+	if (thermal_sampling_init(th))
+		goto out_free;
+
+	if (thermal_cmd_init(th))
+		goto out_free;
+
+	return th;
+
+out_free:
+	free(th);
+
+	return NULL;
+}
diff --git a/tools/lib/thermal/thermal_nl.c b/tools/lib/thermal/thermal_nl.c
new file mode 100644
index 000000000000..b05cf9569858
--- /dev/null
+++ b/tools/lib/thermal/thermal_nl.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: LGPL-2.1+
+// Copyright (C) 2022, Linaro Ltd - Daniel Lezcano <daniel.lezcano@linaro.org>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include <thermal.h>
+#include "thermal_nl.h"
+
+struct handler_args {
+	const char *group;
+	int id;
+};
+
+static __thread int err;
+static __thread int done;
+
+static int nl_seq_check_handler(struct nl_msg *msg, void *arg)
+{
+	return NL_OK;
+}
+
+static int nl_error_handler(struct sockaddr_nl *nla, struct nlmsgerr *nl_err,
+			    void *arg)
+{
+	int *ret = arg;
+
+	if (ret)
+		*ret = nl_err->error;
+
+	return NL_STOP;
+}
+
+static int nl_finish_handler(struct nl_msg *msg, void *arg)
+{
+	int *ret = arg;
+
+	if (ret)
+		*ret = 1;
+
+	return NL_OK;
+}
+
+static int nl_ack_handler(struct nl_msg *msg, void *arg)
+{
+	int *ret = arg;
+
+	if (ret)
+		*ret = 1;
+
+	return NL_OK;
+}
+
+int nl_send_msg(struct nl_sock *sock, struct nl_cb *cb, struct nl_msg *msg,
+		int (*rx_handler)(struct nl_msg *, void *), void *data)
+{
+	if (!rx_handler)
+		return THERMAL_ERROR;
+
+	err = nl_send_auto_complete(sock, msg);
+	if (err < 0)
+		return err;
+
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, rx_handler, data);
+
+	err = done = 0;
+
+	while (err == 0 && done == 0)
+		nl_recvmsgs(sock, cb);
+
+	return err;
+}
+
+static int nl_family_handler(struct nl_msg *msg, void *arg)
+{
+	struct handler_args *grp = arg;
+	struct nlattr *tb[CTRL_ATTR_MAX + 1];
+	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+	struct nlattr *mcgrp;
+	int rem_mcgrp;
+
+	nla_parse(tb, CTRL_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
+		  genlmsg_attrlen(gnlh, 0), NULL);
+
+	if (!tb[CTRL_ATTR_MCAST_GROUPS])
+		return THERMAL_ERROR;
+
+	nla_for_each_nested(mcgrp, tb[CTRL_ATTR_MCAST_GROUPS], rem_mcgrp) {
+
+		struct nlattr *tb_mcgrp[CTRL_ATTR_MCAST_GRP_MAX + 1];
+
+		nla_parse(tb_mcgrp, CTRL_ATTR_MCAST_GRP_MAX,
+			  nla_data(mcgrp), nla_len(mcgrp), NULL);
+
+		if (!tb_mcgrp[CTRL_ATTR_MCAST_GRP_NAME] ||
+		    !tb_mcgrp[CTRL_ATTR_MCAST_GRP_ID])
+			continue;
+
+		if (strncmp(nla_data(tb_mcgrp[CTRL_ATTR_MCAST_GRP_NAME]),
+			    grp->group,
+			    nla_len(tb_mcgrp[CTRL_ATTR_MCAST_GRP_NAME])))
+			continue;
+
+		grp->id = nla_get_u32(tb_mcgrp[CTRL_ATTR_MCAST_GRP_ID]);
+
+		break;
+	}
+
+	return THERMAL_SUCCESS;
+}
+
+static int nl_get_multicast_id(struct nl_sock *sock, struct nl_cb *cb,
+			       const char *family, const char *group)
+{
+	struct nl_msg *msg;
+	int ret = 0, ctrlid;
+	struct handler_args grp = {
+		.group = group,
+		.id = -ENOENT,
+	};
+
+	msg = nlmsg_alloc();
+	if (!msg)
+		return THERMAL_ERROR;
+
+	ctrlid = genl_ctrl_resolve(sock, "nlctrl");
+
+	genlmsg_put(msg, 0, 0, ctrlid, 0, 0, CTRL_CMD_GETFAMILY, 0);
+
+	nla_put_string(msg, CTRL_ATTR_FAMILY_NAME, family);
+
+	ret = nl_send_msg(sock, cb, msg, nl_family_handler, &grp);
+	if (ret)
+		goto nla_put_failure;
+
+	ret = grp.id;
+
+nla_put_failure:
+	nlmsg_free(msg);
+	return ret;
+}
+
+int nl_thermal_connect(struct nl_sock **nl_sock, struct nl_cb **nl_cb)
+{
+	struct nl_cb *cb;
+	struct nl_sock *sock;
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	if (!cb)
+		return THERMAL_ERROR;
+
+	sock = nl_socket_alloc();
+	if (!sock)
+		goto out_cb_free;
+
+	if (genl_connect(sock))
+		goto out_socket_free;
+
+	if (nl_cb_err(cb, NL_CB_CUSTOM, nl_error_handler, &err) ||
+	    nl_cb_set(cb, NL_CB_FINISH, NL_CB_CUSTOM, nl_finish_handler, &done) ||
+	    nl_cb_set(cb, NL_CB_ACK, NL_CB_CUSTOM, nl_ack_handler, &done) ||
+	    nl_cb_set(cb, NL_CB_SEQ_CHECK, NL_CB_CUSTOM, nl_seq_check_handler, &done))
+		return THERMAL_ERROR;
+
+	*nl_sock = sock;
+	*nl_cb = cb;
+
+	return THERMAL_SUCCESS;
+
+out_socket_free:
+	nl_socket_free(sock);
+out_cb_free:
+	nl_cb_put(cb);
+	return THERMAL_ERROR;
+}
+
+void nl_thermal_disconnect(struct nl_sock *nl_sock, struct nl_cb *nl_cb)
+{
+	nl_close(nl_sock);
+	nl_socket_free(nl_sock);
+	nl_cb_put(nl_cb);
+}
+
+int nl_unsubscribe_thermal(struct nl_sock *nl_sock, struct nl_cb *nl_cb,
+			   const char *group)
+{
+	int mcid;
+
+	mcid = nl_get_multicast_id(nl_sock, nl_cb, THERMAL_GENL_FAMILY_NAME,
+				   group);
+	if (mcid < 0)
+		return THERMAL_ERROR;
+
+	if (nl_socket_drop_membership(nl_sock, mcid))
+		return THERMAL_ERROR;
+
+	return THERMAL_SUCCESS;
+}
+
+int nl_subscribe_thermal(struct nl_sock *nl_sock, struct nl_cb *nl_cb,
+			 const char *group)
+{
+	int mcid;
+
+	mcid = nl_get_multicast_id(nl_sock, nl_cb, THERMAL_GENL_FAMILY_NAME,
+				   group);
+	if (mcid < 0)
+		return THERMAL_ERROR;
+
+	if (nl_socket_add_membership(nl_sock, mcid))
+		return THERMAL_ERROR;
+
+	return THERMAL_SUCCESS;
+}
diff --git a/tools/lib/thermal/thermal_nl.h b/tools/lib/thermal/thermal_nl.h
new file mode 100644
index 000000000000..ddf635642f07
--- /dev/null
+++ b/tools/lib/thermal/thermal_nl.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: LGPL-2.1+ */
+/* Copyright (C) 2022, Linaro Ltd - Daniel Lezcano <daniel.lezcano@linaro.org> */
+#ifndef __THERMAL_H
+#define __THERMAL_H
+
+#include <netlink/netlink.h>
+#include <netlink/genl/genl.h>
+#include <netlink/genl/mngt.h>
+#include <netlink/genl/ctrl.h>
+
+struct thermal_handler {
+	int done;
+	int error;
+	struct thermal_ops *ops;
+	struct nl_msg *msg;
+	struct nl_sock *sk_event;
+	struct nl_sock *sk_sampling;
+	struct nl_sock *sk_cmd;
+	struct nl_cb *cb_cmd;
+	struct nl_cb *cb_event;
+	struct nl_cb *cb_sampling;
+};
+
+struct thermal_handler_param {
+	struct thermal_handler *th;
+	void *arg;
+};
+
+/*
+ * Low level netlink
+ */
+extern int nl_subscribe_thermal(struct nl_sock *nl_sock, struct nl_cb *nl_cb,
+				const char *group);
+
+extern int nl_unsubscribe_thermal(struct nl_sock *nl_sock, struct nl_cb *nl_cb,
+				  const char *group);
+
+extern int nl_thermal_connect(struct nl_sock **nl_sock, struct nl_cb **nl_cb);
+
+extern void nl_thermal_disconnect(struct nl_sock *nl_sock, struct nl_cb *nl_cb);
+
+extern int nl_send_msg(struct nl_sock *sock, struct nl_cb *nl_cb, struct nl_msg *msg,
+		       int (*rx_handler)(struct nl_msg *, void *),
+		       void *data);
+
+#endif /* __THERMAL_H */
-- 
2.25.1


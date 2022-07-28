Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B4F584250
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 16:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbiG1OyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 10:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbiG1Oxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 10:53:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0EAA68DE8;
        Thu, 28 Jul 2022 07:53:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5C65168F;
        Thu, 28 Jul 2022 07:53:19 -0700 (PDT)
Received: from e126387.arm.com (unknown [10.57.11.24])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07BF73F70D;
        Thu, 28 Jul 2022 07:53:17 -0700 (PDT)
From:   carsten.haitzler@foss.arm.com
To:     linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: [PATCH v5 03/14] perf test: Add build infra for perf test tools for CoreSight tests
Date:   Thu, 28 Jul 2022 15:52:45 +0100
Message-Id: <20220728145256.2985298-4-carsten.haitzler@foss.arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220728145256.2985298-1-carsten.haitzler@foss.arm.com>
References: <20220728145256.2985298-1-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Carsten Haitzler (Rasterman)" <raster@rasterman.com>

This adds the initial build infrastructure (makefiles maintainers
information) for adding follow-on tests for CoreSight.

Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
---
 MAINTAINERS                                   |  1 +
 tools/perf/Makefile.perf                      | 18 ++++++++++---
 tools/perf/tests/shell/coresight/Makefile     | 26 +++++++++++++++++++
 .../tests/shell/coresight/Makefile.miniconfig | 24 +++++++++++++++++
 4 files changed, 66 insertions(+), 3 deletions(-)
 create mode 100644 tools/perf/tests/shell/coresight/Makefile
 create mode 100644 tools/perf/tests/shell/coresight/Makefile.miniconfig

diff --git a/MAINTAINERS b/MAINTAINERS
index 171563d8dc14..87e4ac463429 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1989,6 +1989,7 @@ F:	drivers/hwtracing/coresight/*
 F:	include/dt-bindings/arm/coresight-cti-dt.h
 F:	include/linux/coresight*
 F:	samples/coresight/*
+F:	tools/perf/tests/shell/coresight/*
 F:	tools/perf/arch/arm/util/auxtrace.c
 F:	tools/perf/arch/arm/util/cs-etm.c
 F:	tools/perf/arch/arm/util/cs-etm.h
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 8f738e11356d..edb621ace2e2 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -629,7 +629,15 @@ sync_file_range_tbls := $(srctree)/tools/perf/trace/beauty/sync_file_range.sh
 $(sync_file_range_arrays): $(linux_uapi_dir)/fs.h $(sync_file_range_tbls)
 	$(Q)$(SHELL) '$(sync_file_range_tbls)' $(linux_uapi_dir) > $@
 
-all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
+TESTS_CORESIGHT_DIR := $(srctree)/tools/perf/tests/shell/coresight
+
+tests-coresight-targets: FORCE
+	$(Q)$(MAKE) -C $(TESTS_CORESIGHT_DIR)
+
+tests-coresight-targets-clean:
+	$(Q)$(MAKE) -C $(TESTS_CORESIGHT_DIR) clean
+
+all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS) tests-coresight-targets
 
 # Create python binding output directory if not already present
 _dummy := $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
@@ -1015,7 +1023,10 @@ install-tests: all install-gtk
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
 		$(INSTALL) tests/shell/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
-		$(INSTALL) tests/shell/lib/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'
+		$(INSTALL) tests/shell/lib/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'; \
+		$(INSTALL) tests/shell/coresight/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'
+	$(Q)$(MAKE) -C tests/shell/coresight install-tests
 
 install-bin: install-tools install-tests install-traceevent-plugins
 
@@ -1085,7 +1096,7 @@ endif # BUILD_BPF_SKEL
 bpf-skel-clean:
 	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS)
 
-clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean
+clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean tests-coresight-targets-clean
 	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-iostat $(LANG_BINDINGS)
 	$(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
 	$(Q)$(RM) $(OUTPUT).config-detected
@@ -1143,5 +1154,6 @@ FORCE:
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
 .PHONY: .FORCE-PERF-VERSION-FILE TAGS tags cscope FORCE prepare
 .PHONY: libtraceevent_plugins archheaders
+.PHONY: $(TESTS_CORESIGHT_TARGETS)
 
 endif # force_fixdep
diff --git a/tools/perf/tests/shell/coresight/Makefile b/tools/perf/tests/shell/coresight/Makefile
new file mode 100644
index 000000000000..3b816bb4ced3
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/Makefile
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+include ../../../../../tools/scripts/Makefile.include
+include ../../../../../tools/scripts/Makefile.arch
+include ../../../../../tools/scripts/utilities.mak
+
+SUBDIRS =
+
+all: $(SUBDIRS)
+$(SUBDIRS):
+	$(Q)$(MAKE) -C $@
+
+INSTALLDIRS = $(SUBDIRS:%=install-%)
+
+install-tests: $(INSTALLDIRS)
+$(INSTALLDIRS):
+	$(Q)$(MAKE) -C $(@:install-%=%) install-tests
+
+CLEANDIRS = $(SUBDIRS:%=clean-%)
+
+clean: $(CLEANDIRS)
+$(CLEANDIRS):
+	$(Q)$(MAKE) -C $(@:clean-%=%) clean >/dev/null
+
+.PHONY: all clean $(SUBDIRS) $(CLEANDIRS) $(INSTALLDIRS)
+
diff --git a/tools/perf/tests/shell/coresight/Makefile.miniconfig b/tools/perf/tests/shell/coresight/Makefile.miniconfig
new file mode 100644
index 000000000000..a65482d769ab
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/Makefile.miniconfig
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+
+ifndef DESTDIR
+prefix ?= $(HOME)
+endif
+
+DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
+perfexecdir = libexec/perf-core
+perfexec_instdir = $(perfexecdir)
+
+ifneq ($(filter /%,$(firstword $(perfexecdir))),)
+perfexec_instdir = $(perfexecdir)
+else
+perfexec_instdir = $(prefix)/$(perfexecdir)
+endif
+
+perfexec_instdir_SQ = $(subst ','\'',$(perfexec_instdir))
+INSTALL = install
+INSTDIR_SUB = tests/shell/coresight
+
+include ../../../../../scripts/Makefile.include
+include ../../../../../scripts/Makefile.arch
+include ../../../../../scripts/utilities.mak
-- 
2.32.0


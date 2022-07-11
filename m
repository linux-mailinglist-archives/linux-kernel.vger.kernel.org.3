Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817C0563333
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 14:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbiGAMJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 08:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbiGAMJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:09:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CA0B7BD26;
        Fri,  1 Jul 2022 05:09:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55B56113E;
        Fri,  1 Jul 2022 05:09:05 -0700 (PDT)
Received: from e126387.arm.com (unknown [10.57.71.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DAB8B3F792;
        Fri,  1 Jul 2022 05:09:03 -0700 (PDT)
From:   carsten.haitzler@foss.arm.com
To:     linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: [PATCH 04/14] perf test: Add asm pureloop test tool
Date:   Fri,  1 Jul 2022 13:07:53 +0100
Message-Id: <20220701120804.3226396-5-carsten.haitzler@foss.arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220701120804.3226396-1-carsten.haitzler@foss.arm.com>
References: <20220701120804.3226396-1-carsten.haitzler@foss.arm.com>
Reply-To: carsten.haitzler@foss.arm.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Carsten Haitzler (Rasterman)" <raster@rasterman.com>

Add test tool to be driven by further test scripts. This tool is pure
arm64 ASM with no libc usage to ensure it is the same exact
binary/code every time so it can also be re-used for many uses. It
just loops for a given fixed number of loops.

Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
---
 tools/perf/tests/shell/coresight/Makefile     |  3 +-
 .../shell/coresight/asm_pure_loop/.gitignore  |  1 +
 .../shell/coresight/asm_pure_loop/Makefile    | 34 +++++++++++++++++++
 .../coresight/asm_pure_loop/asm_pure_loop.S   | 28 +++++++++++++++
 4 files changed, 65 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/tests/shell/coresight/asm_pure_loop/.gitignore
 create mode 100644 tools/perf/tests/shell/coresight/asm_pure_loop/Makefile
 create mode 100644 tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S

diff --git a/tools/perf/tests/shell/coresight/Makefile b/tools/perf/tests/shell/coresight/Makefile
index 3b816bb4ced3..d4f868d55773 100644
--- a/tools/perf/tests/shell/coresight/Makefile
+++ b/tools/perf/tests/shell/coresight/Makefile
@@ -4,7 +4,8 @@ include ../../../../../tools/scripts/Makefile.include
 include ../../../../../tools/scripts/Makefile.arch
 include ../../../../../tools/scripts/utilities.mak
 
-SUBDIRS =
+SUBDIRS = \
+	asm_pure_loop
 
 all: $(SUBDIRS)
 $(SUBDIRS):
diff --git a/tools/perf/tests/shell/coresight/asm_pure_loop/.gitignore b/tools/perf/tests/shell/coresight/asm_pure_loop/.gitignore
new file mode 100644
index 000000000000..468673ac32e8
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/asm_pure_loop/.gitignore
@@ -0,0 +1 @@
+asm_pure_loop
diff --git a/tools/perf/tests/shell/coresight/asm_pure_loop/Makefile b/tools/perf/tests/shell/coresight/asm_pure_loop/Makefile
new file mode 100644
index 000000000000..206849e92bc9
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/asm_pure_loop/Makefile
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: GPL-2.0
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+
+include ../Makefile.miniconfig
+
+# Binary to produce
+BIN=asm_pure_loop
+# Any linking/libraries needed for the binary - empty if none needed
+LIB=
+
+all: $(BIN)
+
+$(BIN): $(BIN).S
+ifdef CORESIGHT
+ifeq ($(ARCH),arm64)
+# Build line - this is raw asm with no libc to have an always exact binary
+	$(Q)$(CC) $(BIN).S -nostdlib -static -o $(BIN) $(LIB)
+endif
+endif
+
+install-tests: all
+ifdef CORESIGHT
+ifeq ($(ARCH),arm64)
+# Install the test tool in the right place
+	$(call QUIET_INSTALL, tests) \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/$(INSTDIR_SUB)/$(BIN)'; \
+		$(INSTALL) $(BIN) '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/$(INSTDIR_SUB)/$(BIN)/$(BIN)'
+endif
+endif
+
+clean:
+	$(Q)$(RM) -f $(BIN)
+
+.PHONY: all clean install-tests
diff --git a/tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S b/tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S
new file mode 100644
index 000000000000..75cf084a927d
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Tamas Zsoldos <tamas.zsoldos@arm.com>, 2021 */
+
+.globl _start
+_start:
+	mov	x0, 0x0000ffff
+	mov	x1, xzr
+loop:
+	nop
+	nop
+	cbnz	x1, noskip
+	nop
+	nop
+	adrp	x2, skip
+	add 	x2, x2, :lo12:skip
+	br	x2
+	nop
+	nop
+noskip:
+	nop
+	nop
+skip:
+	sub	x0, x0, 1
+	cbnz	x0, loop
+
+	mov	x0, #0
+	mov	x8, #93 // __NR_exit syscall
+	svc	#0
-- 
2.32.0


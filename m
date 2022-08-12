Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D86B5910B0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 14:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238727AbiHLMRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 08:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238680AbiHLMRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 08:17:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 725D6A61D2;
        Fri, 12 Aug 2022 05:17:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06DAD113E;
        Fri, 12 Aug 2022 05:17:04 -0700 (PDT)
Received: from e126387.arm.com (unknown [10.57.42.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 070F33F70D;
        Fri, 12 Aug 2022 05:17:01 -0700 (PDT)
From:   carsten.haitzler@foss.arm.com
To:     linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: [PATCH v7 07/14] perf test: Add memcpy thread test tool
Date:   Fri, 12 Aug 2022 13:16:34 +0100
Message-Id: <20220812121641.336465-8-carsten.haitzler@foss.arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812121641.336465-1-carsten.haitzler@foss.arm.com>
References: <20220812121641.336465-1-carsten.haitzler@foss.arm.com>
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

From: Carsten Haitzler <carsten.haitzler@arm.com>

Add test tool to be driven by further test scripts. This is a simple C
based memcpy with threads test to drive from scripts.

Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
---
 tools/perf/tests/shell/coresight/Makefile     |  3 +-
 .../shell/coresight/memcpy_thread/.gitignore  |  1 +
 .../shell/coresight/memcpy_thread/Makefile    | 33 ++++++++
 .../coresight/memcpy_thread/memcpy_thread.c   | 79 +++++++++++++++++++
 4 files changed, 115 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/tests/shell/coresight/memcpy_thread/.gitignore
 create mode 100644 tools/perf/tests/shell/coresight/memcpy_thread/Makefile
 create mode 100644 tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c

diff --git a/tools/perf/tests/shell/coresight/Makefile b/tools/perf/tests/shell/coresight/Makefile
index d4f868d55773..561c807022ec 100644
--- a/tools/perf/tests/shell/coresight/Makefile
+++ b/tools/perf/tests/shell/coresight/Makefile
@@ -5,7 +5,8 @@ include ../../../../../tools/scripts/Makefile.arch
 include ../../../../../tools/scripts/utilities.mak
 
 SUBDIRS = \
-	asm_pure_loop
+	asm_pure_loop \
+	memcpy_thread
 
 all: $(SUBDIRS)
 $(SUBDIRS):
diff --git a/tools/perf/tests/shell/coresight/memcpy_thread/.gitignore b/tools/perf/tests/shell/coresight/memcpy_thread/.gitignore
new file mode 100644
index 000000000000..f8217e56091e
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/memcpy_thread/.gitignore
@@ -0,0 +1 @@
+memcpy_thread
diff --git a/tools/perf/tests/shell/coresight/memcpy_thread/Makefile b/tools/perf/tests/shell/coresight/memcpy_thread/Makefile
new file mode 100644
index 000000000000..2db637eb2c26
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/memcpy_thread/Makefile
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: GPL-2.0
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+include ../Makefile.miniconfig
+
+# Binary to produce
+BIN=memcpy_thread
+# Any linking/libraries needed for the binary - empty if none needed
+LIB=-pthread
+
+all: $(BIN)
+
+$(BIN): $(BIN).c
+ifdef CORESIGHT
+ifeq ($(ARCH),arm64)
+# Build line
+	$(Q)$(CC) $(BIN).c -o $(BIN) $(LIB)
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
diff --git a/tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c b/tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c
new file mode 100644
index 000000000000..a7e169d1bf64
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+// Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <pthread.h>
+
+struct args {
+	unsigned long loops;
+	unsigned long size;
+	pthread_t th;
+	void *ret;
+};
+
+static void *thrfn(void *arg)
+{
+	struct args *a = arg;
+	unsigned long i, len = a->loops;
+	unsigned char *src, *dst;
+
+	src = malloc(a->size * 1024);
+	dst = malloc(a->size * 1024);
+	if ((!src) || (!dst)) {
+		printf("ERR: Can't allocate memory\n");
+		exit(1);
+	}
+	for (i = 0; i < len; i++)
+		memcpy(dst, src, a->size * 1024);
+}
+
+static pthread_t new_thr(void *(*fn) (void *arg), void *arg)
+{
+	pthread_t t;
+	pthread_attr_t attr;
+
+	pthread_attr_init(&attr);
+	pthread_create(&t, &attr, fn, arg);
+	return t;
+}
+
+int main(int argc, char **argv)
+{
+	unsigned long i, len, size, thr;
+	pthread_t threads[256];
+	struct args args[256];
+	long long v;
+
+	if (argc < 4) {
+		printf("ERR: %s [copysize Kb] [numthreads] [numloops (hundreds)]\n", argv[0]);
+		exit(1);
+	}
+
+	v = atoll(argv[1]);
+	if ((v < 1) || (v > (1024 * 1024))) {
+		printf("ERR: max memory 1GB (1048576 KB)\n");
+		exit(1);
+	}
+	size = v;
+	thr = atol(argv[2]);
+	if ((thr < 1) || (thr > 256)) {
+		printf("ERR: threads 1-256\n");
+		exit(1);
+	}
+	v = atoll(argv[3]);
+	if ((v < 1) || (v > 40000000000ll)) {
+		printf("ERR: loops 1-40000000000 (hundreds)\n");
+		exit(1);
+	}
+	len = v * 100;
+	for (i = 0; i < thr; i++) {
+		args[i].loops = len;
+		args[i].size = size;
+		args[i].th = new_thr(thrfn, &(args[i]));
+	}
+	for (i = 0; i < thr; i++)
+		pthread_join(args[i].th, &(args[i].ret));
+	return 0;
+}
-- 
2.32.0


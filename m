Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE74B591043
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 13:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbiHLLnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 07:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237874AbiHLLmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 07:42:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28902AF0D2;
        Fri, 12 Aug 2022 04:42:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5C45113E;
        Fri, 12 Aug 2022 04:42:51 -0700 (PDT)
Received: from e126387.arm.com (unknown [10.57.42.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8B6C3F70D;
        Fri, 12 Aug 2022 04:42:49 -0700 (PDT)
From:   carsten.haitzler@foss.arm.com
To:     linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: [PATCH v6 11/14] perf test: Add unroll thread test tool
Date:   Fri, 12 Aug 2022 12:42:15 +0100
Message-Id: <20220812114218.323052-12-carsten.haitzler@foss.arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812114218.323052-1-carsten.haitzler@foss.arm.com>
References: <20220812114218.323052-1-carsten.haitzler@foss.arm.com>
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

Add test tool to be driven by further test scripts. This is a simple C
based test that is for arm64 with some inline ASM to manually unroll a
lot of code to have a very long sequence of commands.

Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
---
 tools/perf/tests/shell/coresight/Makefile     |  3 +-
 .../coresight/unroll_loop_thread/.gitignore   |  1 +
 .../coresight/unroll_loop_thread/Makefile     | 33 +++++++++
 .../unroll_loop_thread/unroll_loop_thread.c   | 74 +++++++++++++++++++
 4 files changed, 110 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/tests/shell/coresight/unroll_loop_thread/.gitignore
 create mode 100644 tools/perf/tests/shell/coresight/unroll_loop_thread/Makefile
 create mode 100644 tools/perf/tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c

diff --git a/tools/perf/tests/shell/coresight/Makefile b/tools/perf/tests/shell/coresight/Makefile
index 004974a71fb8..3b2b876cd9e2 100644
--- a/tools/perf/tests/shell/coresight/Makefile
+++ b/tools/perf/tests/shell/coresight/Makefile
@@ -7,7 +7,8 @@ include ../../../../../tools/scripts/utilities.mak
 SUBDIRS = \
 	asm_pure_loop \
 	memcpy_thread \
-	thread_loop
+	thread_loop \
+	unroll_loop_thread
 
 all: $(SUBDIRS)
 $(SUBDIRS):
diff --git a/tools/perf/tests/shell/coresight/unroll_loop_thread/.gitignore b/tools/perf/tests/shell/coresight/unroll_loop_thread/.gitignore
new file mode 100644
index 000000000000..2cb4e996dbf3
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/unroll_loop_thread/.gitignore
@@ -0,0 +1 @@
+unroll_loop_thread
diff --git a/tools/perf/tests/shell/coresight/unroll_loop_thread/Makefile b/tools/perf/tests/shell/coresight/unroll_loop_thread/Makefile
new file mode 100644
index 000000000000..6264c4e3abd1
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/unroll_loop_thread/Makefile
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: GPL-2.0
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+include ../Makefile.miniconfig
+
+# Binary to produce
+BIN=unroll_loop_thread
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
diff --git a/tools/perf/tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c b/tools/perf/tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c
new file mode 100644
index 000000000000..8f6d384208ed
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+// Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <pthread.h>
+
+struct args {
+	pthread_t th;
+	unsigned int in;
+	void *ret;
+};
+
+static void *thrfn(void *arg)
+{
+	struct args *a = arg;
+	unsigned int i, in = a->in;
+
+	for (i = 0; i < 10000; i++) {
+		asm volatile (
+// force an unroll of thia add instruction so we can test long runs of code
+#define SNIP1 "add %[in], %[in], #1\n"
+// 10
+#define SNIP2 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1
+// 100
+#define SNIP3 SNIP2 SNIP2 SNIP2 SNIP2 SNIP2 SNIP2 SNIP2 SNIP2 SNIP2 SNIP2
+// 1000
+#define SNIP4 SNIP3 SNIP3 SNIP3 SNIP3 SNIP3 SNIP3 SNIP3 SNIP3 SNIP3 SNIP3
+// 10000
+#define SNIP5 SNIP4 SNIP4 SNIP4 SNIP4 SNIP4 SNIP4 SNIP4 SNIP4 SNIP4 SNIP4
+// 100000
+			SNIP5 SNIP5 SNIP5 SNIP5 SNIP5 SNIP5 SNIP5 SNIP5 SNIP5 SNIP5
+			: /* out */
+			: /* in */ [in] "r" (in)
+			: /* clobber */
+		);
+	}
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
+	unsigned int i, thr;
+	pthread_t threads[256];
+	struct args args[256];
+
+	if (argc < 2) {
+		printf("ERR: %s [numthreads]\n", argv[0]);
+		exit(1);
+	}
+
+	thr = atoi(argv[1]);
+	if ((thr > 256) || (thr < 1)) {
+		printf("ERR: threads 1-256\n");
+		exit(1);
+	}
+	for (i = 0; i < thr; i++) {
+		args[i].in = rand();
+		args[i].th = new_thr(thrfn, &(args[i]));
+	}
+	for (i = 0; i < thr; i++)
+		pthread_join(args[i].th, &(args[i].ret));
+	return 0;
+}
-- 
2.32.0


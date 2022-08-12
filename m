Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8BA59103C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 13:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237704AbiHLLnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 07:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbiHLLmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 07:42:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4502DAF0CB;
        Fri, 12 Aug 2022 04:42:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D26FF113E;
        Fri, 12 Aug 2022 04:42:48 -0700 (PDT)
Received: from e126387.arm.com (unknown [10.57.42.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D71783F70D;
        Fri, 12 Aug 2022 04:42:46 -0700 (PDT)
From:   carsten.haitzler@foss.arm.com
To:     linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: [PATCH v6 09/14] perf test: Add thread loop test tool
Date:   Fri, 12 Aug 2022 12:42:13 +0100
Message-Id: <20220812114218.323052-10-carsten.haitzler@foss.arm.com>
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
based loop with threads test to drive from scripts that can output TIDs
for tracking/checking.

Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
---
 tools/perf/tests/shell/coresight/Makefile     |  3 +-
 .../shell/coresight/thread_loop/.gitignore    |  1 +
 .../shell/coresight/thread_loop/Makefile      | 33 +++++++
 .../shell/coresight/thread_loop/thread_loop.c | 86 +++++++++++++++++++
 4 files changed, 122 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/tests/shell/coresight/thread_loop/.gitignore
 create mode 100644 tools/perf/tests/shell/coresight/thread_loop/Makefile
 create mode 100644 tools/perf/tests/shell/coresight/thread_loop/thread_loop.c

diff --git a/tools/perf/tests/shell/coresight/Makefile b/tools/perf/tests/shell/coresight/Makefile
index 561c807022ec..004974a71fb8 100644
--- a/tools/perf/tests/shell/coresight/Makefile
+++ b/tools/perf/tests/shell/coresight/Makefile
@@ -6,7 +6,8 @@ include ../../../../../tools/scripts/utilities.mak
 
 SUBDIRS = \
 	asm_pure_loop \
-	memcpy_thread
+	memcpy_thread \
+	thread_loop
 
 all: $(SUBDIRS)
 $(SUBDIRS):
diff --git a/tools/perf/tests/shell/coresight/thread_loop/.gitignore b/tools/perf/tests/shell/coresight/thread_loop/.gitignore
new file mode 100644
index 000000000000..6d4c33eaa9e8
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/thread_loop/.gitignore
@@ -0,0 +1 @@
+thread_loop
diff --git a/tools/perf/tests/shell/coresight/thread_loop/Makefile b/tools/perf/tests/shell/coresight/thread_loop/Makefile
new file mode 100644
index 000000000000..ea846c038e7a
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/thread_loop/Makefile
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: GPL-2.0
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+include ../Makefile.miniconfig
+
+# Binary to produce
+BIN=thread_loop
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
diff --git a/tools/perf/tests/shell/coresight/thread_loop/thread_loop.c b/tools/perf/tests/shell/coresight/thread_loop/thread_loop.c
new file mode 100644
index 000000000000..c0158fac7d0b
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/thread_loop/thread_loop.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+// Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+
+// define this for gettid()
+#define _GNU_SOURCE
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <pthread.h>
+#include <sys/syscall.h>
+#ifndef SYS_gettid
+// gettid is 178 on arm64
+# define SYS_gettid 178
+#endif
+#define gettid() syscall(SYS_gettid)
+
+struct args {
+	unsigned int loops;
+	pthread_t th;
+	void *ret;
+};
+
+static void *thrfn(void *arg)
+{
+	struct args *a = arg;
+	int i = 0, len = a->loops;
+
+	if (getenv("SHOW_TID")) {
+		unsigned long long tid = gettid();
+
+		printf("%llu\n", tid);
+	}
+	asm volatile(
+		"loop:\n"
+		"add %[i], %[i], #1\n"
+		"cmp %[i], %[len]\n"
+		"blt loop\n"
+		: /* out */
+		: /* in */ [i] "r" (i), [len] "r" (len)
+		: /* clobber */
+	);
+	return (void *)(long)i;
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
+	unsigned int i, len, thr;
+	pthread_t threads[256];
+	struct args args[256];
+
+	if (argc < 3) {
+		printf("ERR: %s [numthreads] [numloops (millions)]\n", argv[0]);
+		exit(1);
+	}
+
+	thr = atoi(argv[1]);
+	if ((thr < 1) || (thr > 256)) {
+		printf("ERR: threads 1-256\n");
+		exit(1);
+	}
+	len = atoi(argv[2]);
+	if ((len < 1) || (len > 4000)) {
+		printf("ERR: max loops 4000 (millions)\n");
+		exit(1);
+	}
+	len *= 1000000;
+	for (i = 0; i < thr; i++) {
+		args[i].loops = len;
+		args[i].th = new_thr(thrfn, &(args[i]));
+	}
+	for (i = 0; i < thr; i++)
+		pthread_join(args[i].th, &(args[i].ret));
+	return 0;
+}
-- 
2.32.0


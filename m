Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2EC7475926
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 13:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242680AbhLOMzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 07:55:02 -0500
Received: from foss.arm.com ([217.140.110.172]:51214 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242663AbhLOMzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 07:55:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DD7FD6E;
        Wed, 15 Dec 2021 04:55:00 -0800 (PST)
Received: from e126387.extremechicken.org (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 402743F774;
        Wed, 15 Dec 2021 04:54:59 -0800 (PST)
From:   carsten.haitzler@foss.arm.com
To:     linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org
Subject: [PATCH 05/12] perf test: Add coresight test to check all threads get some data logged
Date:   Wed, 15 Dec 2021 12:54:02 +0000
Message-Id: <20211215125409.61488-5-carsten.haitzler@foss.arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215125409.61488-1-carsten.haitzler@foss.arm.com>
References: <20211215125409.61488-1-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Carsten Haitzler <carsten.haitzler@arm.com>

This adds a test and test scripts to check that all threads in the
target binary end up logging some kind of coresight aux data and that
they are not missing.

Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
---
 .../coresight_thread_loop_check_tid_10.sh     | 19 ++++
 .../coresight_thread_loop_check_tid_2.sh      | 19 ++++
 .../coresight_thread_loop_check_tid_250.sh    | 19 ++++
 .../perf/tests/shell/tools/coresight/Makefile |  3 +-
 .../tools/coresight/thread_loop/Makefile      | 29 +++++++
 .../tools/coresight/thread_loop/thread_loop.c | 86 +++++++++++++++++++
 6 files changed, 174 insertions(+), 1 deletion(-)
 create mode 100755 tools/perf/tests/shell/coresight_thread_loop_check_tid_10.sh
 create mode 100755 tools/perf/tests/shell/coresight_thread_loop_check_tid_2.sh
 create mode 100755 tools/perf/tests/shell/coresight_thread_loop_check_tid_250.sh
 create mode 100644 tools/perf/tests/shell/tools/coresight/thread_loop/Makefile
 create mode 100644 tools/perf/tests/shell/tools/coresight/thread_loop/thread_loop.c

diff --git a/tools/perf/tests/shell/coresight_thread_loop_check_tid_10.sh b/tools/perf/tests/shell/coresight_thread_loop_check_tid_10.sh
new file mode 100755
index 000000000000..283ad9facdee
--- /dev/null
+++ b/tools/perf/tests/shell/coresight_thread_loop_check_tid_10.sh
@@ -0,0 +1,19 @@
+#!/bin/sh -e
+# Coresight / Thread Loop 10 Threads - Check TID
+
+# SPDX-License-Identifier: GPL-2.0
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+
+TEST="thread_loop"
+. $(dirname $0)/lib/coresight.sh
+ARGS="10 2000"
+DATV="check-tid-10th"
+DATA="$DATD/perf-$TEST-$DATV.data"
+STDO="$DATD/perf-$TEST-$DATV.stdout"
+
+SHOW_TID=1 perf record -s $PERFRECOPT -o "$DATA" "$BIN" $ARGS > $STDO
+
+perf_dump_aux_tid_verify "$DATA" "$STDO"
+
+err=$?
+exit $err
diff --git a/tools/perf/tests/shell/coresight_thread_loop_check_tid_2.sh b/tools/perf/tests/shell/coresight_thread_loop_check_tid_2.sh
new file mode 100755
index 000000000000..ce8ba534bba2
--- /dev/null
+++ b/tools/perf/tests/shell/coresight_thread_loop_check_tid_2.sh
@@ -0,0 +1,19 @@
+#!/bin/sh -e
+# Coresight / Thread Loop 2 Threads - Check TID
+
+# SPDX-License-Identifier: GPL-2.0
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+
+TEST="thread_loop"
+. $(dirname $0)/lib/coresight.sh
+ARGS="2 4000"
+DATV="check-tid-2th"
+DATA="$DATD/perf-$TEST-$DATV.data"
+STDO="$DATD/perf-$TEST-$DATV.stdout"
+
+SHOW_TID=1 perf record -s $PERFRECOPT -o "$DATA" "$BIN" $ARGS > $STDO
+
+perf_dump_aux_tid_verify "$DATA" "$STDO"
+
+err=$?
+exit $err
diff --git a/tools/perf/tests/shell/coresight_thread_loop_check_tid_250.sh b/tools/perf/tests/shell/coresight_thread_loop_check_tid_250.sh
new file mode 100755
index 000000000000..cb14581c1e68
--- /dev/null
+++ b/tools/perf/tests/shell/coresight_thread_loop_check_tid_250.sh
@@ -0,0 +1,19 @@
+#!/bin/sh -e
+# Coresight / Thread Loop 250 Threads - Check TID
+
+# SPDX-License-Identifier: GPL-2.0
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+
+TEST="thread_loop"
+. $(dirname $0)/lib/coresight.sh
+ARGS="250 100"
+DATV="check-tid-250th"
+DATA="$DATD/perf-$TEST-$DATV.data"
+STDO="$DATD/perf-$TEST-$DATV.stdout"
+
+SHOW_TID=1 perf record -s $PERFRECOPT -o "$DATA" "$BIN" $ARGS > $STDO
+
+perf_dump_aux_tid_verify "$DATA" "$STDO"
+
+err=$?
+exit $err
diff --git a/tools/perf/tests/shell/tools/coresight/Makefile b/tools/perf/tests/shell/tools/coresight/Makefile
index 723006ea827c..1edab729db76 100644
--- a/tools/perf/tests/shell/tools/coresight/Makefile
+++ b/tools/perf/tests/shell/tools/coresight/Makefile
@@ -5,7 +5,8 @@ include ../../../../../../tools/scripts/Makefile.arch
 include ../../../../../../tools/scripts/utilities.mak
 
 SUBDIRS = \
-	asm_pure_loop
+	asm_pure_loop \
+	thread_loop
 
 all: $(SUBDIRS)
 $(SUBDIRS):
diff --git a/tools/perf/tests/shell/tools/coresight/thread_loop/Makefile b/tools/perf/tests/shell/tools/coresight/thread_loop/Makefile
new file mode 100644
index 000000000000..424df4e8b0e6
--- /dev/null
+++ b/tools/perf/tests/shell/tools/coresight/thread_loop/Makefile
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+include ../Makefile.miniconfig
+
+BIN=thread_loop
+LIB=-pthread
+
+all: $(BIN)
+
+$(BIN): $(BIN).c
+ifdef CORESIGHT
+ifeq ($(ARCH),arm64)
+	$(Q)$(CC) $(BIN).c -o $(BIN) $(LIB)
+endif
+endif
+
+install-tests: all
+ifdef CORESIGHT
+ifeq ($(ARCH),arm64)
+	$(call QUIET_INSTALL, tests) \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/tools/$(BIN)'; \
+		$(INSTALL) $(BIN) '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/tools/$(BIN)/$(BIN)'
+endif
+endif
+
+clean:
+	$(Q)$(RM) -f $(BIN)
+
+.PHONY: all clean install-tests
diff --git a/tools/perf/tests/shell/tools/coresight/thread_loop/thread_loop.c b/tools/perf/tests/shell/tools/coresight/thread_loop/thread_loop.c
new file mode 100644
index 000000000000..c0158fac7d0b
--- /dev/null
+++ b/tools/perf/tests/shell/tools/coresight/thread_loop/thread_loop.c
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


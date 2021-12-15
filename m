Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B760347592E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 13:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242710AbhLOMzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 07:55:23 -0500
Received: from foss.arm.com ([217.140.110.172]:51268 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242726AbhLOMzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 07:55:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0E3A13A1;
        Wed, 15 Dec 2021 04:55:07 -0800 (PST)
Received: from e126387.extremechicken.org (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B42763F774;
        Wed, 15 Dec 2021 04:55:06 -0800 (PST)
From:   carsten.haitzler@foss.arm.com
To:     linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org
Subject: [PATCH 11/12] perf test: Add unrolled loop tests for coresight aux data
Date:   Wed, 15 Dec 2021 12:54:08 +0000
Message-Id: <20211215125409.61488-11-carsten.haitzler@foss.arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215125409.61488-1-carsten.haitzler@foss.arm.com>
References: <20211215125409.61488-1-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Carsten Haitzler <carsten.haitzler@arm.com>

These tests have large batches of code manually unrolled with macros
to ensure that the processor has to walk through a lot of instructions
and memory for those instructions to generate the coresight aux data.

Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
---
 .../shell/coresight_unroll_loop_thread_1.sh   | 18 +++++
 .../shell/coresight_unroll_loop_thread_10.sh  | 18 +++++
 .../shell/coresight_unroll_loop_thread_2.sh   | 18 +++++
 .../shell/coresight_unroll_loop_thread_25.sh  | 18 +++++
 .../shell/coresight_unroll_loop_thread_250.sh | 18 +++++
 .../perf/tests/shell/tools/coresight/Makefile |  3 +-
 .../coresight/unroll_loop_thread/Makefile     | 29 ++++++++
 .../unroll_loop_thread/unroll_loop_thread.c   | 74 +++++++++++++++++++
 8 files changed, 195 insertions(+), 1 deletion(-)
 create mode 100755 tools/perf/tests/shell/coresight_unroll_loop_thread_1.sh
 create mode 100755 tools/perf/tests/shell/coresight_unroll_loop_thread_10.sh
 create mode 100755 tools/perf/tests/shell/coresight_unroll_loop_thread_2.sh
 create mode 100755 tools/perf/tests/shell/coresight_unroll_loop_thread_25.sh
 create mode 100755 tools/perf/tests/shell/coresight_unroll_loop_thread_250.sh
 create mode 100644 tools/perf/tests/shell/tools/coresight/unroll_loop_thread/Makefile
 create mode 100644 tools/perf/tests/shell/tools/coresight/unroll_loop_thread/unroll_loop_thread.c

diff --git a/tools/perf/tests/shell/coresight_unroll_loop_thread_1.sh b/tools/perf/tests/shell/coresight_unroll_loop_thread_1.sh
new file mode 100755
index 000000000000..9175ec532bd8
--- /dev/null
+++ b/tools/perf/tests/shell/coresight_unroll_loop_thread_1.sh
@@ -0,0 +1,18 @@
+#!/bin/sh -e
+# Coresight / Unroll Loop Thread 1
+
+# SPDX-License-Identifier: GPL-2.0
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+
+TEST="unroll_loop_thread"
+. $(dirname $0)/lib/coresight.sh
+ARGS="1"
+DATV="1"
+DATA="$DATD/perf-$TEST-$DATV.data"
+
+perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
+
+perf_dump_aux_verify "$DATA" 118 14 14
+
+err=$?
+exit $err
diff --git a/tools/perf/tests/shell/coresight_unroll_loop_thread_10.sh b/tools/perf/tests/shell/coresight_unroll_loop_thread_10.sh
new file mode 100755
index 000000000000..66cf0245294e
--- /dev/null
+++ b/tools/perf/tests/shell/coresight_unroll_loop_thread_10.sh
@@ -0,0 +1,18 @@
+#!/bin/sh -e
+# Coresight / Unroll Loop Thread 10
+
+# SPDX-License-Identifier: GPL-2.0
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+
+TEST="unroll_loop_thread"
+. $(dirname $0)/lib/coresight.sh
+ARGS="10"
+DATV="10"
+DATA="$DATD/perf-$TEST-$DATV.data"
+
+perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
+
+perf_dump_aux_verify "$DATA" 127 17 17
+
+err=$?
+exit $err
diff --git a/tools/perf/tests/shell/coresight_unroll_loop_thread_2.sh b/tools/perf/tests/shell/coresight_unroll_loop_thread_2.sh
new file mode 100755
index 000000000000..ff2e293699b0
--- /dev/null
+++ b/tools/perf/tests/shell/coresight_unroll_loop_thread_2.sh
@@ -0,0 +1,18 @@
+#!/bin/sh -e
+# Coresight / Unroll Loop Thread 2
+
+# SPDX-License-Identifier: GPL-2.0
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+
+TEST="unroll_loop_thread"
+. $(dirname $0)/lib/coresight.sh
+ARGS="2"
+DATV="2"
+DATA="$DATD/perf-$TEST-$DATV.data"
+
+perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
+
+perf_dump_aux_verify "$DATA" 65 6 6
+
+err=$?
+exit $err
diff --git a/tools/perf/tests/shell/coresight_unroll_loop_thread_25.sh b/tools/perf/tests/shell/coresight_unroll_loop_thread_25.sh
new file mode 100755
index 000000000000..7d7669a797ab
--- /dev/null
+++ b/tools/perf/tests/shell/coresight_unroll_loop_thread_25.sh
@@ -0,0 +1,18 @@
+#!/bin/sh -e
+# Coresight / Unroll Loop Thread 25
+
+# SPDX-License-Identifier: GPL-2.0
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+
+TEST="unroll_loop_thread"
+. $(dirname $0)/lib/coresight.sh
+ARGS="25"
+DATV="25"
+DATA="$DATD/perf-$TEST-$DATV.data"
+
+perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
+
+perf_dump_aux_verify "$DATA" 72 26 25
+
+err=$?
+exit $err
diff --git a/tools/perf/tests/shell/coresight_unroll_loop_thread_250.sh b/tools/perf/tests/shell/coresight_unroll_loop_thread_250.sh
new file mode 100755
index 000000000000..7a0e23aff0dc
--- /dev/null
+++ b/tools/perf/tests/shell/coresight_unroll_loop_thread_250.sh
@@ -0,0 +1,18 @@
+#!/bin/sh -e
+# Coresight / Unroll Loop Thread 250
+
+# SPDX-License-Identifier: GPL-2.0
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+
+TEST="unroll_loop_thread"
+. $(dirname $0)/lib/coresight.sh
+ARGS="250"
+DATV="250"
+DATA="$DATD/perf-$TEST-$DATV.data"
+
+perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
+
+perf_dump_aux_verify "$DATA" 544 2417 2417
+
+err=$?
+exit $err
diff --git a/tools/perf/tests/shell/tools/coresight/Makefile b/tools/perf/tests/shell/tools/coresight/Makefile
index be671aac06b8..b9cdeff1149b 100644
--- a/tools/perf/tests/shell/tools/coresight/Makefile
+++ b/tools/perf/tests/shell/tools/coresight/Makefile
@@ -10,7 +10,8 @@ SUBDIRS = \
 	bubble_sort \
 	bubble_sort_thread \
         memcpy \
-        memcpy_thread
+        memcpy_thread \
+        unroll_loop_thread
 
 all: $(SUBDIRS)
 $(SUBDIRS):
diff --git a/tools/perf/tests/shell/tools/coresight/unroll_loop_thread/Makefile b/tools/perf/tests/shell/tools/coresight/unroll_loop_thread/Makefile
new file mode 100644
index 000000000000..45ab2be8be92
--- /dev/null
+++ b/tools/perf/tests/shell/tools/coresight/unroll_loop_thread/Makefile
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+include ../Makefile.miniconfig
+
+BIN=unroll_loop_thread
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
diff --git a/tools/perf/tests/shell/tools/coresight/unroll_loop_thread/unroll_loop_thread.c b/tools/perf/tests/shell/tools/coresight/unroll_loop_thread/unroll_loop_thread.c
new file mode 100644
index 000000000000..cb9d22c7dfb9
--- /dev/null
+++ b/tools/perf/tests/shell/tools/coresight/unroll_loop_thread/unroll_loop_thread.c
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
+	unsigned int in, out;
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFCB7475929
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 13:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242700AbhLOMzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 07:55:15 -0500
Received: from foss.arm.com ([217.140.110.172]:51256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242711AbhLOMzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 07:55:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C5C811D4;
        Wed, 15 Dec 2021 04:55:06 -0800 (PST)
Received: from e126387.extremechicken.org (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E7EE3F774;
        Wed, 15 Dec 2021 04:55:05 -0800 (PST)
From:   carsten.haitzler@foss.arm.com
To:     linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org
Subject: [PATCH 10/12] perf test: Add threaded memcpy tests to check coresight aux data
Date:   Wed, 15 Dec 2021 12:54:07 +0000
Message-Id: <20211215125409.61488-10-carsten.haitzler@foss.arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215125409.61488-1-carsten.haitzler@foss.arm.com>
References: <20211215125409.61488-1-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Carsten Haitzler <carsten.haitzler@arm.com>

This adds threaded memcpy test looking at coresight aux data quality.

Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
---
 .../shell/coresight_memcpy_thread_1m_2.sh     | 18 +++++
 .../shell/coresight_memcpy_thread_1m_25.sh    | 18 +++++
 .../shell/coresight_memcpy_thread_32m_10.sh   | 18 +++++
 .../shell/coresight_memcpy_thread_32m_2.sh    | 18 +++++
 .../shell/coresight_memcpy_thread_64k_2.sh    | 18 +++++
 .../shell/coresight_memcpy_thread_64k_25.sh   | 18 +++++
 .../shell/coresight_memcpy_thread_64k_250.sh  | 18 +++++
 .../perf/tests/shell/tools/coresight/Makefile |  3 +-
 .../tools/coresight/memcpy_thread/Makefile    | 29 +++++++
 .../coresight/memcpy_thread/memcpy_thread.c   | 79 +++++++++++++++++++
 10 files changed, 236 insertions(+), 1 deletion(-)
 create mode 100755 tools/perf/tests/shell/coresight_memcpy_thread_1m_2.sh
 create mode 100755 tools/perf/tests/shell/coresight_memcpy_thread_1m_25.sh
 create mode 100755 tools/perf/tests/shell/coresight_memcpy_thread_32m_10.sh
 create mode 100755 tools/perf/tests/shell/coresight_memcpy_thread_32m_2.sh
 create mode 100755 tools/perf/tests/shell/coresight_memcpy_thread_64k_2.sh
 create mode 100755 tools/perf/tests/shell/coresight_memcpy_thread_64k_25.sh
 create mode 100755 tools/perf/tests/shell/coresight_memcpy_thread_64k_250.sh
 create mode 100644 tools/perf/tests/shell/tools/coresight/memcpy_thread/Makefile
 create mode 100644 tools/perf/tests/shell/tools/coresight/memcpy_thread/memcpy_thread.c

diff --git a/tools/perf/tests/shell/coresight_memcpy_thread_1m_2.sh b/tools/perf/tests/shell/coresight_memcpy_thread_1m_2.sh
new file mode 100755
index 000000000000..32d5ee94343a
--- /dev/null
+++ b/tools/perf/tests/shell/coresight_memcpy_thread_1m_2.sh
@@ -0,0 +1,18 @@
+#!/bin/sh -e
+# Coresight / Memcpy 1M 2 Threads
+
+# SPDX-License-Identifier: GPL-2.0
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+
+TEST="memcpy_thread"
+. $(dirname $0)/lib/coresight.sh
+ARGS="1024 2 400"
+DATV="1m_2"
+DATA="$DATD/perf-$TEST-$DATV.data"
+
+perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
+
+perf_dump_aux_verify "$DATA" 125 26 26
+
+err=$?
+exit $err
diff --git a/tools/perf/tests/shell/coresight_memcpy_thread_1m_25.sh b/tools/perf/tests/shell/coresight_memcpy_thread_1m_25.sh
new file mode 100755
index 000000000000..6510f8c7df99
--- /dev/null
+++ b/tools/perf/tests/shell/coresight_memcpy_thread_1m_25.sh
@@ -0,0 +1,18 @@
+#!/bin/sh -e
+# Coresight / Memcpy 1M 25 Threads
+
+# SPDX-License-Identifier: GPL-2.0
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+
+TEST="memcpy_thread"
+. $(dirname $0)/lib/coresight.sh
+ARGS="1024 25 1"
+DATV="1m_25"
+DATA="$DATD/perf-$TEST-$DATV.data"
+
+perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
+
+perf_dump_aux_verify "$DATA" 1 44 43
+
+err=$?
+exit $err
diff --git a/tools/perf/tests/shell/coresight_memcpy_thread_32m_10.sh b/tools/perf/tests/shell/coresight_memcpy_thread_32m_10.sh
new file mode 100755
index 000000000000..3715ed4b612e
--- /dev/null
+++ b/tools/perf/tests/shell/coresight_memcpy_thread_32m_10.sh
@@ -0,0 +1,18 @@
+#!/bin/sh -e
+# Coresight / Memcpy 32M 10 Threads
+
+# SPDX-License-Identifier: GPL-2.0
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+
+TEST="memcpy_thread"
+. $(dirname $0)/lib/coresight.sh
+ARGS="32768 10 1"
+DATV="32m_10"
+DATA="$DATD/perf-$TEST-$DATV.data"
+
+perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
+
+perf_dump_aux_verify "$DATA" 6 36 36
+
+err=$?
+exit $err
diff --git a/tools/perf/tests/shell/coresight_memcpy_thread_32m_2.sh b/tools/perf/tests/shell/coresight_memcpy_thread_32m_2.sh
new file mode 100755
index 000000000000..ad57bf4d9c0c
--- /dev/null
+++ b/tools/perf/tests/shell/coresight_memcpy_thread_32m_2.sh
@@ -0,0 +1,18 @@
+#!/bin/sh -e
+# Coresight / Memcpy 32M 2 Threads
+
+# SPDX-License-Identifier: GPL-2.0
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+
+TEST="memcpy_thread"
+. $(dirname $0)/lib/coresight.sh
+ARGS="32768 2 1"
+DATV="32m_2"
+DATA="$DATD/perf-$TEST-$DATV.data"
+
+perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
+
+perf_dump_aux_verify "$DATA" 3 12 12
+
+err=$?
+exit $err
diff --git a/tools/perf/tests/shell/coresight_memcpy_thread_64k_2.sh b/tools/perf/tests/shell/coresight_memcpy_thread_64k_2.sh
new file mode 100755
index 000000000000..282cc8922641
--- /dev/null
+++ b/tools/perf/tests/shell/coresight_memcpy_thread_64k_2.sh
@@ -0,0 +1,18 @@
+#!/bin/sh -e
+# Coresight / Memcpy 64k 2 Threads
+
+# SPDX-License-Identifier: GPL-2.0
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+
+TEST="memcpy_thread"
+. $(dirname $0)/lib/coresight.sh
+ARGS="64 2 100"
+DATV="64k_2"
+DATA="$DATD/perf-$TEST-$DATV.data"
+
+perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
+
+perf_dump_aux_verify "$DATA" 66 11 11
+
+err=$?
+exit $err
diff --git a/tools/perf/tests/shell/coresight_memcpy_thread_64k_25.sh b/tools/perf/tests/shell/coresight_memcpy_thread_64k_25.sh
new file mode 100755
index 000000000000..05bc6c23f4a1
--- /dev/null
+++ b/tools/perf/tests/shell/coresight_memcpy_thread_64k_25.sh
@@ -0,0 +1,18 @@
+#!/bin/sh -e
+# Coresight / Memcpy 64k 25 Threads
+
+# SPDX-License-Identifier: GPL-2.0
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+
+TEST="memcpy_thread"
+. $(dirname $0)/lib/coresight.sh
+ARGS="64 25 2"
+DATV="64k_25"
+DATA="$DATD/perf-$TEST-$DATV.data"
+
+perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
+
+perf_dump_aux_verify "$DATA" 118 31 31
+
+err=$?
+exit $err
diff --git a/tools/perf/tests/shell/coresight_memcpy_thread_64k_250.sh b/tools/perf/tests/shell/coresight_memcpy_thread_64k_250.sh
new file mode 100755
index 000000000000..aaf35e32f610
--- /dev/null
+++ b/tools/perf/tests/shell/coresight_memcpy_thread_64k_250.sh
@@ -0,0 +1,18 @@
+#!/bin/sh -e
+# Coresight / Memcpy 64k 250 Threads
+
+# SPDX-License-Identifier: GPL-2.0
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+
+TEST="memcpy_thread"
+. $(dirname $0)/lib/coresight.sh
+ARGS="64 250 1"
+DATV="64k_250"
+DATA="$DATD/perf-$TEST-$DATV.data"
+
+perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
+
+perf_dump_aux_verify "$DATA" 340 1878 1878
+
+err=$?
+exit $err
diff --git a/tools/perf/tests/shell/tools/coresight/Makefile b/tools/perf/tests/shell/tools/coresight/Makefile
index 99030c889b04..be671aac06b8 100644
--- a/tools/perf/tests/shell/tools/coresight/Makefile
+++ b/tools/perf/tests/shell/tools/coresight/Makefile
@@ -9,7 +9,8 @@ SUBDIRS = \
 	thread_loop \
 	bubble_sort \
 	bubble_sort_thread \
-        memcpy
+        memcpy \
+        memcpy_thread
 
 all: $(SUBDIRS)
 $(SUBDIRS):
diff --git a/tools/perf/tests/shell/tools/coresight/memcpy_thread/Makefile b/tools/perf/tests/shell/tools/coresight/memcpy_thread/Makefile
new file mode 100644
index 000000000000..e2604cfae74b
--- /dev/null
+++ b/tools/perf/tests/shell/tools/coresight/memcpy_thread/Makefile
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+include ../Makefile.miniconfig
+
+BIN=memcpy_thread
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
diff --git a/tools/perf/tests/shell/tools/coresight/memcpy_thread/memcpy_thread.c b/tools/perf/tests/shell/tools/coresight/memcpy_thread/memcpy_thread.c
new file mode 100644
index 000000000000..a7e169d1bf64
--- /dev/null
+++ b/tools/perf/tests/shell/tools/coresight/memcpy_thread/memcpy_thread.c
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


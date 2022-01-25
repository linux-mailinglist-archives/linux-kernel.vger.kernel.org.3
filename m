Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F8C49B95C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1586462AbiAYQyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:54:19 -0500
Received: from foss.arm.com ([217.140.110.172]:55652 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1586761AbiAYQvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:51:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BC8A1FB;
        Tue, 25 Jan 2022 08:51:52 -0800 (PST)
Received: from ip-10-252-15-108.eu-west-1.compute.internal (unknown [10.252.15.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EDD343F766;
        Tue, 25 Jan 2022 08:51:50 -0800 (PST)
From:   German Gomez <german.gomez@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     German Gomez <german.gomez@arm.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH] perf test: Add shell script test for ARM64 frame-pointer call graphs
Date:   Tue, 25 Jan 2022 16:51:32 +0000
Message-Id: <20220125165133.10198-1-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the commit in [1], the frame-pointer call-graphs were fixed in ARM64.
So add a test to avoid future regressions.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b9f6fbb3b2c29736970ae9fcc0e82b0bd459442b

Suggested-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: German Gomez <german.gomez@arm.com>
---
 .../tests/shell/test_arm_fp_call_graph.sh     | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_arm_fp_call_graph.sh

diff --git a/tools/perf/tests/shell/test_arm_fp_call_graph.sh b/tools/perf/tests/shell/test_arm_fp_call_graph.sh
new file mode 100755
index 000000000000..4ba17163b320
--- /dev/null
+++ b/tools/perf/tests/shell/test_arm_fp_call_graph.sh
@@ -0,0 +1,74 @@
+#!/bin/sh
+# Check frame pointer call-graphs are correct on Arm64
+
+# SPDX-License-Identifier: GPL-2.0
+# German Gomez <german.gomez@arm.com>, 2022
+
+# This test checks that the perf tool injects the missing caller of a
+# leaf function on Arm64 when unwinding using frame pointers.
+# See: https://lore.kernel.org/r/20211217154521.80603-7-german.gomez@arm.com
+
+# Only run this test on Arm64
+lscpu | grep -q "aarch64" || return 2
+
+if ! [ -x "$(command -v cc)" ]; then
+	echo "failed: no compiler, install gcc"
+	exit 2
+fi
+
+PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+TEST_PROGRAM_SOURCE=$(mktemp /tmp/test_program.XXXXX.c)
+TEST_PROGRAM=$(mktemp /tmp/test_program.XXXXX)
+SCRIPT_FILE=$(mktemp /tmp/perf.script.XXXXX)
+
+cleanup_files() {
+	rm -f $PERF_DATA*
+	rm -f $TEST_PROGRAM_SOURCE
+	rm -f $TEST_PROGRAM
+	rm -f $SCRIPT_FILE
+}
+
+trap cleanup_files exit term int
+
+# compile test program
+cat << EOF > $TEST_PROGRAM_SOURCE
+int a = 0;
+void leaf(void) {
+  for (int i = 0; i < 10000000; i++)
+    a *= a;
+}
+void parent(void) {
+  leaf();
+}
+int main(void) {
+  parent();
+  return 0;
+}
+EOF
+
+CFLAGS="-O0 -fno-inline -fno-omit-frame-pointer"
+cc $CFLAGS $TEST_PROGRAM_SOURCE -o $TEST_PROGRAM || exit 1
+
+perf record --call-graph fp -o $PERF_DATA -- $TEST_PROGRAM
+
+# search for the following pattern in perf-script output
+#     734 leaf+0x18 (...)
+#     78b parent+0xb (...)
+#     7a4 main+0xc (...)
+
+perf script -i $PERF_DATA | egrep "[0-9a-f]+ +leaf" -A2 -m1 > $SCRIPT_FILE
+
+egrep -q " +leaf\+0x[0-9a-f]+" $SCRIPT_FILE && \
+egrep -q " +parent\+0x[0-9a-f]+" $SCRIPT_FILE && \
+egrep -q " +main\+0x[0-9a-f]+" $SCRIPT_FILE
+err=$?
+
+echo -n "Check frame pointer call-graphs on Arm64: "
+if [ $err != 0 ]; then
+	echo "FAIL"
+	exit 1
+else
+	echo "PASS"
+fi
+
+exit 0
-- 
2.25.1


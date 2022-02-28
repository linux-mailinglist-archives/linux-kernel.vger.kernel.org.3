Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CC94C7206
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 17:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238064AbiB1Q5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 11:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbiB1Q5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:57:44 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3EFB679C77;
        Mon, 28 Feb 2022 08:57:04 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFFD21042;
        Mon, 28 Feb 2022 08:57:03 -0800 (PST)
Received: from ip-10-252-15-108.eu-west-1.compute.internal (unknown [10.252.15.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5723F3F70D;
        Mon, 28 Feb 2022 08:57:02 -0800 (PST)
From:   German Gomez <german.gomez@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     james.clark@arm.com, German Gomez <german.gomez@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH] perf test arm-spe: Check if perf-record hangs when recording workload with forks
Date:   Mon, 28 Feb 2022 16:56:54 +0000
Message-Id: <20220228165655.3920-1-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add shell test to check if perf-record hangs when recording an arm_spe
event with forks.

The test FAILS if the Kernel is not patched with Commit 961c391217 ("perf:
Always wake the parent event").

Unpatched Kernel:

  $ perf test -v 90
  90: Check Arm SPE doesn't hang when there are forks
  --- start ---
  test child forked, pid 14232
  Recording workload with fork
  Log lines = 90 /tmp/__perf_test.stderr.0Nu0U
  Log lines after 1 second = 90 /tmp/__perf_test.stderr.0Nu0U
  SPE hang test: FAIL
  test child finished with -1
  ---- end ----
  Check Arm SPE trace data in workload with forks: FAILED!

Patched Kernel:

  $ perf test -v 90
  90: Check Arm SPE doesn't hang when there are forks
  --- start ---
  test child forked, pid 2930
  Compiling test program...
  Recording workload...
  Log lines = 478 /tmp/__perf_test.log.026AI
  Log lines after 1 second = 557 /tmp/__perf_test.log.026AI
  SPE hang test: PASS
  Cleaning up files...
  test child finished with 0
  ---- end ----
  Check Arm SPE trace data in workload with forks: Ok

Signed-off-by: German Gomez <german.gomez@arm.com>
---
 tools/perf/tests/shell/test_arm_spe_fork.sh | 92 +++++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_arm_spe_fork.sh

diff --git a/tools/perf/tests/shell/test_arm_spe_fork.sh b/tools/perf/tests/shell/test_arm_spe_fork.sh
new file mode 100755
index 000000000..c920d3583
--- /dev/null
+++ b/tools/perf/tests/shell/test_arm_spe_fork.sh
@@ -0,0 +1,92 @@
+#!/bin/sh
+# Check Arm SPE doesn't hang when there are forks
+
+# SPDX-License-Identifier: GPL-2.0
+# German Gomez <german.gomez@arm.com>, 2022
+
+skip_if_no_arm_spe_event() {
+	perf list | egrep -q 'arm_spe_[0-9]+//' && return 0
+	return 2
+}
+
+skip_if_no_arm_spe_event || exit 2
+
+# skip if there's no compiler
+if ! [ -x "$(command -v cc)" ]; then
+	echo "failed: no compiler, install gcc"
+	exit 2
+fi
+
+TEST_PROGRAM_SOURCE=$(mktemp /tmp/__perf_test.program.XXXXX.c)
+TEST_PROGRAM=$(mktemp /tmp/__perf_test.program.XXXXX)
+PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+PERF_RECORD_LOG=$(mktemp /tmp/__perf_test.log.XXXXX)
+
+cleanup_files()
+{
+	echo "Cleaning up files..."
+	rm -f ${PERF_RECORD_LOG}
+	rm -f ${PERF_DATA}
+	rm -f ${TEST_PROGRAM_SOURCE}
+	rm -f ${TEST_PROGRAM}
+}
+
+trap cleanup_files exit term int
+
+# compile test program
+cat << EOF > $TEST_PROGRAM_SOURCE
+#include <math.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/wait.h>
+
+int workload() {
+  while (1)
+    sqrt(rand());
+  return 0;
+}
+
+int main() {
+  switch (fork()) {
+    case 0:
+      return workload();
+    case -1:
+      return 1;
+    default:
+      wait(NULL);
+  }
+  return 0;
+}
+EOF
+
+echo "Compiling test program..."
+CFLAGS="-lm"
+cc $TEST_PROGRAM_SOURCE $CFLAGS -o $TEST_PROGRAM || exit 1
+
+echo "Recording workload..."
+perf record -o ${PERF_DATA} -e arm_spe/period=65536/ -vvv -- $TEST_PROGRAM > ${PERF_RECORD_LOG} 2>&1 &
+PERFPID=$!
+
+# Check if perf hangs by checking the perf-record logs.
+sleep 1
+log0=$(wc -l $PERF_RECORD_LOG)
+echo Log lines = $log0
+sleep 1
+log1=$(wc -l $PERF_RECORD_LOG)
+echo Log lines after 1 second = $log1
+
+kill $PERFPID
+wait $PERFPID
+# test program may leave an orphan process running the workload
+killall $(basename $TEST_PROGRAM)
+
+if [ "$log0" = "$log1" ];
+then
+        echo "SPE hang test: FAIL"
+        exit 1
+else
+        echo "SPE hang test: PASS"
+fi
+
+exit 0
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5A54C8CB8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 14:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbiCANfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 08:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbiCANfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 08:35:04 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 876353A198;
        Tue,  1 Mar 2022 05:34:23 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27B571042;
        Tue,  1 Mar 2022 05:34:23 -0800 (PST)
Received: from ip-10-252-15-108.eu-west-1.compute.internal (unknown [10.252.15.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 94B393F70D;
        Tue,  1 Mar 2022 05:34:21 -0800 (PST)
From:   German Gomez <german.gomez@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     German Gomez <german.gomez@arm.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH] perf test arm64: Test unwinding using fame-pointer (fp) mode
Date:   Tue,  1 Mar 2022 13:34:13 +0000
Message-Id: <20220301133414.11766-1-german.gomez@arm.com>
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

Add a shell script to check that the call-graphs generated using frame
pointers (--call-graph fp) are complete and not missing leaf functions:

  | $ perf test 88 -v
  |  88: Check Arm64 callgraphs are complete in fp mode                  :
  | --- start ---
  | test child forked, pid 8734
  |  + Compiling test program (/tmp/test_program.Cz3yL)...
  |  + Recording (PID=8749)...
  |  + Stopping perf-record...
  | test_program.Cz
  | 		     728 leaf
  | 		     753 parent
  | 		     76c main
  | test child finished with 0
  | ---- end ----
  | Check Arm SPE callgraphs are complete in fp mode: Ok

Fixes: b9f6fbb3b2c2 ("perf arm64: Inject missing frames when using 'perf record --call-graph=fp'")
Suggested-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: German Gomez <german.gomez@arm.com>
---
 .../perf/tests/shell/test_arm_callgraph_fp.sh | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_arm_callgraph_fp.sh

diff --git a/tools/perf/tests/shell/test_arm_callgraph_fp.sh b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
new file mode 100755
index 000000000..c4fa9255b
--- /dev/null
+++ b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
@@ -0,0 +1,65 @@
+#!/bin/sh
+# Check Arm64 callgraphs are complete in fp mode
+# SPDX-License-Identifier: GPL-2.0
+
+lscpu | grep -q "aarch64" || exit 2
+
+if ! [ -x "$(command -v cc)" ]; then
+	echo "failed: no compiler, install gcc"
+	exit 2
+fi
+
+PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+TEST_PROGRAM_SOURCE=$(mktemp /tmp/test_program.XXXXX.c)
+TEST_PROGRAM=$(mktemp /tmp/test_program.XXXXX)
+
+cleanup_files()
+{
+	rm -f $PERF_DATA
+	rm -f $TEST_PROGRAM_SOURCE
+	rm -f $TEST_PROGRAM
+}
+
+trap cleanup_files exit term int
+
+cat << EOF > $TEST_PROGRAM_SOURCE
+int a = 0;
+void leaf(void) {
+  for (;;)
+    a += a;
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
+echo " + Compiling test program ($TEST_PROGRAM)..."
+CFLAGS="-O0 -fno-inline -fno-omit-frame-pointer"
+cc $CFLAGS $TEST_PROGRAM_SOURCE -o $TEST_PROGRAM || exit 1
+
+# Add a 1 second delay to skip samples that are not in the leaf() function
+perf record -o $PERF_DATA --call-graph fp -e cycles//u -D 1000 -- $TEST_PROGRAM 2> /dev/null &
+PID=$!
+echo " + Recording (PID=$PID)..."
+sleep 2
+echo " + Stopping perf-record..."
+kill $PID
+wait $PID
+
+# example perf-script output:
+#
+# program 
+# 	728 leaf
+# 	753 parent
+# 	76c main
+# ...
+
+perf script -i $PERF_DATA -F comm,ip,sym | head -n4
+perf script -i $PERF_DATA -F comm,ip,sym | head -n4 |
+	awk '{ if ($2 != "") sym[i++] = $2 } END { if (sym[0] != "leaf" ||
+						       sym[1] != "parent" ||
+						       sym[2] != "main") exit 1 }'
-- 
2.25.1


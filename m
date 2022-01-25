Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7195649B8A1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbiAYQcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:32:10 -0500
Received: from foss.arm.com ([217.140.110.172]:54038 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351666AbiAYQZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:25:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA3E4D6E;
        Tue, 25 Jan 2022 08:25:48 -0800 (PST)
Received: from e127744.arm.com (unknown [10.57.88.59])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 885263F766;
        Tue, 25 Jan 2022 08:25:46 -0800 (PST)
From:   German Gomez <german.gomez@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     German Gomez <german.gomez@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1] perf test: Add branch stack sampling tests for ARM64
Date:   Tue, 25 Jan 2022 16:25:09 +0000
Message-Id: <20220125162510.2860932-2-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220125162510.2860932-1-german.gomez@arm.com>
References: <1642998653-21377-1-git-send-email-anshuman.khandual@arm.com>
 <20220125162510.2860932-1-german.gomez@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds two shell script tests in order to test branch stack sampling on
ARM64 plarforms. This functionality is enabled by the Branch Record
Buffer Extension (BRBE) on Arm.

Information about BRBE can be found in [1] chapter F1.

[1]: https://developer.arm.com/documentation/ddi0608/latest

Signed-off-by: German Gomez <german.gomez@arm.com>
---
 .../perf/tests/shell/test_arm_brbe_kernel.sh  | 42 ++++++++++
 .../tests/shell/test_arm_brbe_userspace.sh    | 80 +++++++++++++++++++
 2 files changed, 122 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_arm_brbe_kernel.sh
 create mode 100755 tools/perf/tests/shell/test_arm_brbe_userspace.sh

diff --git a/tools/perf/tests/shell/test_arm_brbe_kernel.sh b/tools/perf/tests/shell/test_arm_brbe_kernel.sh
new file mode 100755
index 000000000..dc5a2238f
--- /dev/null
+++ b/tools/perf/tests/shell/test_arm_brbe_kernel.sh
@@ -0,0 +1,42 @@
+#!/bin/bash
+# Arm64 BRBE kernel branches
+
+# SPDX-License-Identifier: GPL-2.0
+# German Gomez <german.gomez@arm.com>, 2022
+
+PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+
+cleanup_files() {
+	rm -f $PERF_DATA*
+}
+
+trap cleanup_files exit term int
+
+test_brbe_kernel() {
+	lscpu | grep -q "aarch64" || return $?
+	perf record -o $PERF_DATA --branch-filter any,k -- true > /dev/null 2>&1
+}
+
+test_brbe_kernel || exit 2
+
+# example perf-script output:
+#   0xffffffff9a80dd5e/0xffffffff9a87c5c0/P/-/-/1
+#   0xffff8000080ac20c/0xffff800008e99720/P/-/-/2
+#   0xffff8000080ac20c/0xffff800008e99720/P/-/-/3
+
+# kernel addresses always have the upper 16 bits set (https://lwn.net/Articles/718895/)
+KERNEL_ADDRESS_REGEX="0xffff[0-9a-f]{12}"
+
+perf record -o $PERF_DATA --branch-filter any,k -a -- sleep 1
+perf script -i $PERF_DATA --fields brstack | egrep "(0x0|$KERNEL_ADDRESS_REGEX)\/(0x0|$KERNEL_ADDRESS_REGEX)\/" > /dev/null
+err=$?
+
+echo -n "BRB kernel branches: "
+if [ $err != 0 ]; then
+	echo "FAIL"
+	exit 1
+else
+	echo "PASS"
+fi
+
+exit 0
diff --git a/tools/perf/tests/shell/test_arm_brbe_userspace.sh b/tools/perf/tests/shell/test_arm_brbe_userspace.sh
new file mode 100755
index 000000000..4f0bdc03a
--- /dev/null
+++ b/tools/perf/tests/shell/test_arm_brbe_userspace.sh
@@ -0,0 +1,80 @@
+#!/bin/bash
+# Arm64 BRBE userspace branches
+
+# SPDX-License-Identifier: GPL-2.0
+# German Gomez <german.gomez@arm.com>, 2022
+
+PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+TEST_PROGRAM_SOURCE=$(mktemp /tmp/brbe_test_program.XXXXX.c)
+TEST_PROGRAM=$(mktemp /tmp/brbe_test_program.XXXXX)
+
+cleanup_files() {
+	rm -f $PERF_DATA*
+	rm -f $TEST_PROGRAM_SOURCE
+	rm -f $TEST_PROGRAM
+}
+
+trap cleanup_files exit term int
+
+test_brbe_user() {
+	lscpu | grep -q "aarch64" || return $?
+	perf record -o $PERF_DATA --branch-filter any,u -- true > /dev/null 2>&1
+}
+
+test_brbe_user || exit 2
+
+# Skip if there's no compiler
+# We need it to compile the test program
+if ! [ -x "$(command -v cc)" ]; then
+	echo "failed: no compiler, install gcc"
+	exit 2
+fi
+
+script_has_branch() {
+	local from="$1\+0x[0-9a-f]+"
+	local to="$2\+0x[0-9a-f]+"
+	perf script -i $PERF_DATA --fields brstacksym | egrep -qm 1 " +$from\/$to\/"
+}
+
+# compile test program
+cat << EOF > $TEST_PROGRAM_SOURCE
+void f2() {
+}
+void f1() {
+  f2();
+}
+void f0() {
+  f1();
+  f2();
+}
+int main() {
+  while(1) {
+    f0();
+    f1();
+  }
+  return 0;
+}
+EOF
+
+CFLAGS="-O0 -fno-inline -static"
+cc $CFLAGS $TEST_PROGRAM_SOURCE -o $TEST_PROGRAM || exit 1
+
+perf record -o $PERF_DATA --branch-filter any,u -- timeout 1 $TEST_PROGRAM
+
+script_has_branch "main" "f0" &&
+	script_has_branch "main" "f1" &&
+	script_has_branch "f0" "f1" &&
+	script_has_branch "f0" "f2" &&
+	script_has_branch "f1" "f2" &&
+	script_has_branch "main" "main"
+err=$?
+
+echo -n "BRB user branches: "
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


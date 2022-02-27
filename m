Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2F74C5EE9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 21:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiB0U57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 15:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbiB0U5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 15:57:31 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E4F96E4C0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 12:56:46 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85A5711FB;
        Sun, 27 Feb 2022 12:56:46 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2911D3F66F;
        Sun, 27 Feb 2022 12:56:45 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        peter.hilber@opensynergy.com, cristian.marussi@arm.com
Subject: [RFC PATCH 15/16] selftests: arm64: Add initial SCMI testcases
Date:   Sun, 27 Feb 2022 20:56:07 +0000
Message-Id: <20220227205608.30812-16-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220227205608.30812-1-cristian.marussi@arm.com>
References: <20220227205608.30812-1-cristian.marussi@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few initial testcases for Clock and Sensot protocol plus all the test
infrastructure, including the test runeer.

All of this just an experimental demonstrator.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 tools/testing/selftests/arm64/Makefile        |   2 +-
 tools/testing/selftests/arm64/scmi/Makefile   |   6 +
 tools/testing/selftests/arm64/scmi/config     |   1 +
 .../arm64/scmi/kselftest_scmi_lib.sh          | 118 ++++++++++++++++++
 .../selftests/arm64/scmi/run_scmi_tests.sh    |  69 ++++++++++
 .../testcases/protocol_0x14/clock_enable.sh   |  33 +++++
 .../protocol_0x14/clock_rate_read.sh          |  18 +++
 .../protocol_0x14/clock_rate_write.sh         |  29 +++++
 .../testcases/protocol_0x15/sensor_reading.sh |  17 +++
 9 files changed, 292 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/arm64/scmi/Makefile
 create mode 100644 tools/testing/selftests/arm64/scmi/config
 create mode 100644 tools/testing/selftests/arm64/scmi/kselftest_scmi_lib.sh
 create mode 100755 tools/testing/selftests/arm64/scmi/run_scmi_tests.sh
 create mode 100755 tools/testing/selftests/arm64/scmi/testcases/protocol_0x14/clock_enable.sh
 create mode 100755 tools/testing/selftests/arm64/scmi/testcases/protocol_0x14/clock_rate_read.sh
 create mode 100755 tools/testing/selftests/arm64/scmi/testcases/protocol_0x14/clock_rate_write.sh
 create mode 100755 tools/testing/selftests/arm64/scmi/testcases/protocol_0x15/sensor_reading.sh

diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile
index 1e8d9a8f59df..6648dd8e2173 100644
--- a/tools/testing/selftests/arm64/Makefile
+++ b/tools/testing/selftests/arm64/Makefile
@@ -4,7 +4,7 @@
 ARCH ?= $(shell uname -m 2>/dev/null || echo not)
 
 ifneq (,$(filter $(ARCH),aarch64 arm64))
-ARM64_SUBTARGETS ?= tags signal pauth fp mte bti abi
+ARM64_SUBTARGETS ?= tags signal pauth fp mte bti abi scmi
 else
 ARM64_SUBTARGETS :=
 endif
diff --git a/tools/testing/selftests/arm64/scmi/Makefile b/tools/testing/selftests/arm64/scmi/Makefile
new file mode 100644
index 000000000000..8786d8d4c332
--- /dev/null
+++ b/tools/testing/selftests/arm64/scmi/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+
+TEST_PROGS := run_scmi_tests.sh
+TEST_FILES := kselftest_scmi_lib.sh testcases/*
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/arm64/scmi/config b/tools/testing/selftests/arm64/scmi/config
new file mode 100644
index 000000000000..161387084a3f
--- /dev/null
+++ b/tools/testing/selftests/arm64/scmi/config
@@ -0,0 +1 @@
+CONFIG_ARM_SCMI_TEST_DRIVER=y
diff --git a/tools/testing/selftests/arm64/scmi/kselftest_scmi_lib.sh b/tools/testing/selftests/arm64/scmi/kselftest_scmi_lib.sh
new file mode 100644
index 000000000000..54d27b5f3e1a
--- /dev/null
+++ b/tools/testing/selftests/arm64/scmi/kselftest_scmi_lib.sh
@@ -0,0 +1,118 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+SCMI_TEST_DRV="scmi_test_driver"
+TRES=(0 0 0)
+
+ksft_log()
+{
+	echo -e "[SCMI]: $1"
+}
+
+ksft_skip()
+{
+	echo -e "[SKIP]: $1"
+	exit 4
+}
+
+ksft_pass()
+{
+	echo -e "[PASS]: $1"
+}
+
+ksft_fail()
+{
+	echo -e "[FAIL]: $1"
+	exit 1
+}
+
+ksft_results()
+{
+	if [ $# -gt 0 ]; then
+		local val
+		local idx
+		local ret=$1
+
+		case "$ret" in
+			0)
+				idx=0
+				;;
+			4)
+				idx=1
+				;;
+			*)
+				idx=2
+				;;
+		esac
+		val=${TRES[${idx}]}
+		TRES[$idx]=$((val + 1))
+	else
+		ksft_log "Summary - PASS[${TRES[0]}]  SKIP[${TRES[1]}]  FAIL[${TRES[2]}]"
+		[ "x${TRES[2]}" != "x0" ] && exit 1
+		[ "x${TRES[1]}" != "x0" -a "x${TRES[0]}" == "x0" ] && exit 4
+		exit 0
+	fi
+}
+
+ksft_scmi_run_one()
+{
+	tcase=$1
+
+	echo "-> Running testcase: $tcase"
+
+	./$tcase
+       ret=$?
+
+       ksft_results $ret
+}
+
+ksft_scmi_check_fw_version()
+{
+	local supported=$1
+	local current="${SCMI_VENDOR}:${SCMI_SUB_VENDOR}"
+
+	if [ "x${current}" != "x${supported}" ]; then
+		ksft_skip "Current FW('$current') is UNSUPPORTED. Should be '$supported'"
+	fi
+}
+
+ksft_scmi_transport_is_atomic ()
+{
+	[ "x$SCMI_TRANSPORT_IS_ATOMIC" == "xY" ] && return 0 || return 1
+}
+
+ksft_scmi_protocol_resources_get()
+{
+	local proto_dir=$1
+	local resources=""
+
+	for d in ${proto_dir}/*; do
+		rd="$(basename $d)"
+		[[ $rd =~ [0-9] ]] && resources="$resources $rd"
+	done
+
+	echo "$resources"
+}
+
+ksft_scmi_value_get()
+{
+	local syspath=$1
+	local __retval=$2
+	local value
+
+	value=$(cat $syspath)
+	[ "x$?" != "x0" ] && ksft_fail "Fail to read $syspath"
+
+	eval $__retval="'$value'"
+}
+
+ksft_scmi_value_set()
+{
+	local syspath=$1
+	local value=$2
+
+	echo $value > $syspath
+	[ "x$?" != "x0" ] && ksft_fail "Fail to write $syspath - err:$?"
+}
+
+
diff --git a/tools/testing/selftests/arm64/scmi/run_scmi_tests.sh b/tools/testing/selftests/arm64/scmi/run_scmi_tests.sh
new file mode 100755
index 000000000000..f372744a4579
--- /dev/null
+++ b/tools/testing/selftests/arm64/scmi/run_scmi_tests.sh
@@ -0,0 +1,69 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. ./kselftest_scmi_lib.sh
+
+check_root_privs()
+{
+	[ x"$(id -u)" != "x0" ] && ksft_skip "You need to be root"
+}
+
+check_scmi_testing_stack()
+{
+	local debugfs_root=$(findmnt -o TARGET -t debugfs | grep -v TARGET)
+	export SCMI_DEBUGFS_TOPDIR="$debugfs_root/scmi"
+
+	# Try to load module if not builtin
+	if [ ! -d $SCMI_DEBUGFS_TOPDIR ]; then
+		modprobe $SCMI_TEST_DRV || ksft_skip "Failed to load $SCMI_TEST_DRV"
+		[ ! -d $SCMI_DEBUGFS_TOPDIR ] && ksft_skip "SCMI Test stack not found; is CONFIG_ARM_SCMI_TEST_DRIVER enabled ?"
+	fi
+}
+
+setup_scmi_test_env()
+{
+	local scmi_info_dir="${SCMI_DEBUGFS_TOPDIR}/info/"
+
+	export SCMI_VENDOR="$(cat ${scmi_info_dir}/vendor_id)"
+	export SCMI_SUB_VENDOR="$(cat ${scmi_info_dir}/sub_vendor_id)"
+	export SCMI_VERS_MAJ="$(cat ${scmi_info_dir}/major_ver)"
+	export SCMI_VERS_MIN="$(cat ${scmi_info_dir}/minor_ver)"
+	export SCMI_VERS_IMPL="$(cat ${scmi_info_dir}/impl_ver)"
+
+	ksft_log "Found stack: $SCMI_VENDOR/$SCMI_SUB_VENDOR ${SCMI_VERS_MAJ}.${SCMI_VERS_MAJ} - $SCMI_VERS_IMPL"
+
+	SCMI_TEST_PROTOS=""
+	for p in ${SCMI_DEBUGFS_TOPDIR}/protocol_*; do
+		SCMI_TEST_PROTOS="${SCMI_TEST_PROTOS} $(basename $p)"
+	done
+
+	ksft_log "Found testing protocols: $SCMI_TEST_PROTOS"
+
+	export SCMI_TEST_PROTOS
+	SCMI_TRANSPORT_IS_ATOMIC="N"
+	[ -d "${SCMI_DEBUGFS_TOPDIR}/transport" ] &&
+		SCMI_TRANSPORT_IS_ATOMIC=$(cat "${SCMI_DEBUGFS_TOPDIR}/transport/is_atomic")
+	export SCMI_TRANSPORT_IS_ATOMIC
+}
+
+# Setup
+check_root_privs
+
+check_scmi_testing_stack
+
+setup_scmi_test_env
+
+# Main
+# Run all available tests for the found protocols
+#
+for proto_dir in $SCMI_TEST_PROTOS; do
+	[ ! -d $proto_dir ] && ksft_log "$proto_dir tests NOT supported." && continue
+	export TST_PROTO_DIR="${SCMI_DEBUGFS_TOPDIR}/${proto_dir}"
+	TST_PROTO_VERSION=$(cat ${TST_PROTO_DIR}/version)
+	ksft_log "Running tests for SCMI $proto_dir ver:$TST_PROTO_VERSION"
+	for tst in $proto_dir/*; do
+		ksft_scmi_run_one $tst
+	done
+done
+
+ksft_results
diff --git a/tools/testing/selftests/arm64/scmi/testcases/protocol_0x14/clock_enable.sh b/tools/testing/selftests/arm64/scmi/testcases/protocol_0x14/clock_enable.sh
new file mode 100755
index 000000000000..4cdf3a097ba7
--- /dev/null
+++ b/tools/testing/selftests/arm64/scmi/testcases/protocol_0x14/clock_enable.sh
@@ -0,0 +1,33 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. ./kselftest_scmi_lib.sh
+
+supported_fw="EMU-SCMI-VM:userland"
+ksft_scmi_check_fw_version $supported_fw
+
+clock_enable_disable() {
+	rname=$1
+	rdir=$2
+	clk_op=$3
+
+	ksft_scmi_value_set $rdir/$clk_op Y
+	ksft_scmi_value_set $rdir/$clk_op N
+	ksft_log "Clock $rname: $clk_op - ON/OFF ... OK"
+}
+
+resources=$(ksft_scmi_protocol_resources_get $TST_PROTO_DIR)
+ksft_log "Found Clock resources: $resources"
+
+for res in $resources;do
+	resd="$TST_PROTO_DIR/$res"
+	name="$(cat $resd/info/name)"
+
+	clock_enable_disable $name $resd "enable"
+	if [ ksft_transport_is_atomic ]; then
+		clock_enable_disable $name $resd "enable_atomic_irqs_off"
+		clock_enable_disable $name $resd "enable_atomic_irqs_on"
+	fi
+done
+
+ksft_pass "$0"
diff --git a/tools/testing/selftests/arm64/scmi/testcases/protocol_0x14/clock_rate_read.sh b/tools/testing/selftests/arm64/scmi/testcases/protocol_0x14/clock_rate_read.sh
new file mode 100755
index 000000000000..88c444fd317d
--- /dev/null
+++ b/tools/testing/selftests/arm64/scmi/testcases/protocol_0x14/clock_rate_read.sh
@@ -0,0 +1,18 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. ./kselftest_scmi_lib.sh
+
+resources=$(ksft_scmi_protocol_resources_get $TST_PROTO_DIR)
+ksft_log "Found Clock resources: $resources"
+
+for res in $resources;do
+	resd="$TST_PROTO_DIR/$res"
+	name="$(cat $resd/info/name)"
+	val=0
+
+	ksft_scmi_value_get $resd/rate_get_set val
+	ksft_log "$name READ => $val"
+done
+
+ksft_pass "$0"
diff --git a/tools/testing/selftests/arm64/scmi/testcases/protocol_0x14/clock_rate_write.sh b/tools/testing/selftests/arm64/scmi/testcases/protocol_0x14/clock_rate_write.sh
new file mode 100755
index 000000000000..346084ec3812
--- /dev/null
+++ b/tools/testing/selftests/arm64/scmi/testcases/protocol_0x14/clock_rate_write.sh
@@ -0,0 +1,29 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. ./kselftest_scmi_lib.sh
+
+supported_fw="EMU-SCMI-VM:userland"
+ksft_scmi_check_fw_version $supported_fw
+
+resources=$(ksft_scmi_protocol_resources_get $TST_PROTO_DIR)
+ksft_log "Found Clock resources: $resources"
+
+for res in $resources;do
+	resd="$TST_PROTO_DIR/$res"
+	name="$(cat $resd/info/name)"
+	val=0
+	oldval=0
+	setval=0
+
+	ksft_scmi_value_get $resd/rate_get_set oldval
+	setval=$((oldval + 666))
+
+	ksft_scmi_value_set $resd/rate_get_set $setval
+
+	ksft_scmi_value_get $resd/rate_get_set val
+	[ "x$val" != "x$setval" ] && ksft_fail "Set:$setval readback:$val"
+	ksft_log "$name OK -> read:$oldval  set:$setval  readback:$val"
+done
+
+ksft_pass "$0"
diff --git a/tools/testing/selftests/arm64/scmi/testcases/protocol_0x15/sensor_reading.sh b/tools/testing/selftests/arm64/scmi/testcases/protocol_0x15/sensor_reading.sh
new file mode 100755
index 000000000000..b0f5f6361379
--- /dev/null
+++ b/tools/testing/selftests/arm64/scmi/testcases/protocol_0x15/sensor_reading.sh
@@ -0,0 +1,17 @@
+#!/bin/bash
+
+. ./kselftest_scmi_lib.sh
+
+resources=$(ksft_scmi_protocol_resources_get $TST_PROTO_DIR)
+ksft_log "Found Sensor resources: $resources"
+
+for res in $resources;do
+	resd="$TST_PROTO_DIR/$res"
+	name="$(cat $resd/info/name)"
+	val=0
+
+	ksft_scmi_value_get $resd/reading_get val
+	ksft_log "$name READ => $val"
+done
+
+ksft_pass $0
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E0A502F90
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 22:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351533AbiDOUL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 16:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351248AbiDOULL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 16:11:11 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6592BDBD04
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 13:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650053319; x=1681589319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DhRlwDgprdhgsfLbiPaWbnvZhwFauCFtzcWern6oXIk=;
  b=TTBNWyrlZT06tiM9iVg5ZUqSvh+vA93l56cFeWMIEqvbVy7ypmX1DhWY
   IdlBbNbGiVRptTeh8ENMz0C9MqV4fBKQ23AudAveptsVG/e/Q7i6yNTM2
   qdjcEub2BFmYwzVEgbziz0TaujMNWhHA4+35qLTo0Cx2qRqxFh7UPmu3X
   L+X+DuPasq8su/y6fYfWENjSYAsGmY0vggabL3+qN1LJ+ypbcnFuzQyqP
   VWX0rcE4RVjHJr9uelMIWqWKeP9c94zw/HegNVhI9YmD2DGvDnqFM+etX
   Tw5LMSsooHbBZSo0qDzWm95xECcR3bymzf2HNnTs5C9SY2eZQPO+MWH4m
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="262078959"
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="262078959"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 13:08:11 -0700
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="574510722"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.209.98.156])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 13:08:11 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mcgrof@kernel.org, rafael@kernel.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v2 8/8] selftests: firmware: Add firmware upload selftests
Date:   Fri, 15 Apr 2022 13:08:05 -0700
Message-Id: <20220415200805.610339-9-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220415200805.610339-1-russell.h.weight@intel.com>
References: <20220415200805.610339-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add selftests to verify the firmware upload mechanism. These test
include simple firmware uploads as well as upload cancellation and
error injection. The test creates three firmware devices and verifies
that they all work correctly and independently.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
v2:
  - No changes from v1
---
 tools/testing/selftests/firmware/Makefile     |   2 +-
 tools/testing/selftests/firmware/config       |   1 +
 tools/testing/selftests/firmware/fw_lib.sh    |   7 +
 .../selftests/firmware/fw_run_tests.sh        |   4 +
 tools/testing/selftests/firmware/fw_upload.sh | 214 ++++++++++++++++++
 5 files changed, 227 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/firmware/fw_upload.sh

diff --git a/tools/testing/selftests/firmware/Makefile b/tools/testing/selftests/firmware/Makefile
index 40211cd8f0e6..7992969deaa2 100644
--- a/tools/testing/selftests/firmware/Makefile
+++ b/tools/testing/selftests/firmware/Makefile
@@ -4,7 +4,7 @@ CFLAGS = -Wall \
          -O2
 
 TEST_PROGS := fw_run_tests.sh
-TEST_FILES := fw_fallback.sh fw_filesystem.sh fw_lib.sh
+TEST_FILES := fw_fallback.sh fw_filesystem.sh fw_upload.sh fw_lib.sh
 TEST_GEN_FILES := fw_namespace
 
 include ../lib.mk
diff --git a/tools/testing/selftests/firmware/config b/tools/testing/selftests/firmware/config
index bf634dda0720..6e402519b117 100644
--- a/tools/testing/selftests/firmware/config
+++ b/tools/testing/selftests/firmware/config
@@ -3,3 +3,4 @@ CONFIG_FW_LOADER=y
 CONFIG_FW_LOADER_USER_HELPER=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
+CONFIG_FW_UPLOAD=y
diff --git a/tools/testing/selftests/firmware/fw_lib.sh b/tools/testing/selftests/firmware/fw_lib.sh
index 5b8c0fedee76..fe8d34dbe7ca 100755
--- a/tools/testing/selftests/firmware/fw_lib.sh
+++ b/tools/testing/selftests/firmware/fw_lib.sh
@@ -63,6 +63,7 @@ check_setup()
 	HAS_FW_LOADER_USER_HELPER="$(kconfig_has CONFIG_FW_LOADER_USER_HELPER=y)"
 	HAS_FW_LOADER_USER_HELPER_FALLBACK="$(kconfig_has CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y)"
 	HAS_FW_LOADER_COMPRESS="$(kconfig_has CONFIG_FW_LOADER_COMPRESS=y)"
+	HAS_FW_UPLOAD="$(kconfig_has CONFIG_FW_UPLOAD=y)"
 	PROC_FW_IGNORE_SYSFS_FALLBACK="0"
 	PROC_FW_FORCE_SYSFS_FALLBACK="0"
 
@@ -113,6 +114,12 @@ verify_reqs()
 			exit 0
 		fi
 	fi
+	if [ "$TEST_REQS_FW_UPLOAD" = "yes" ]; then
+		if [ ! "$HAS_FW_UPLOAD" = "yes" ]; then
+			echo "firmware upload disabled so ignoring test"
+			exit 0
+		fi
+	fi
 }
 
 setup_tmp_file()
diff --git a/tools/testing/selftests/firmware/fw_run_tests.sh b/tools/testing/selftests/firmware/fw_run_tests.sh
index 777377078d5e..f6d95a2d5124 100755
--- a/tools/testing/selftests/firmware/fw_run_tests.sh
+++ b/tools/testing/selftests/firmware/fw_run_tests.sh
@@ -22,6 +22,10 @@ run_tests()
 	proc_set_force_sysfs_fallback $1
 	proc_set_ignore_sysfs_fallback $2
 	$TEST_DIR/fw_fallback.sh
+
+	proc_set_force_sysfs_fallback $1
+	proc_set_ignore_sysfs_fallback $2
+	$TEST_DIR/fw_upload.sh
 }
 
 run_test_config_0001()
diff --git a/tools/testing/selftests/firmware/fw_upload.sh b/tools/testing/selftests/firmware/fw_upload.sh
new file mode 100755
index 000000000000..c7a6f06c9adb
--- /dev/null
+++ b/tools/testing/selftests/firmware/fw_upload.sh
@@ -0,0 +1,214 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# This validates the user-initiated fw upload mechanism of the firmware
+# loader. It verifies that one or more firmware devices can be created
+# for a device driver. It also verifies the data transfer, the
+# cancellation support, and the error flows.
+set -e
+
+TEST_REQS_FW_UPLOAD="yes"
+TEST_DIR=$(dirname $0)
+
+progress_states="preparing transferring  programming"
+errors="hw-error
+	timeout
+	device-busy
+	invalid-file-size
+	read-write-error
+	flash-wearout"
+error_abort="user-abort"
+fwname1=fw1
+fwname2=fw2
+fwname3=fw3
+
+source $TEST_DIR/fw_lib.sh
+
+check_mods
+check_setup
+verify_reqs
+
+trap "upload_finish" EXIT
+
+upload_finish() {
+	local fwdevs="$fwname1 $fwname2 $fwname3"
+
+	for name in $fwdevs; do
+		if [ -e "$DIR/$name" ]; then
+			echo -n "$name" > "$DIR"/upload_unregister
+		fi
+	done
+}
+
+upload_fw() {
+	local name="$1"
+	local file="$2"
+
+	echo 1 > "$DIR"/"$name"/loading
+	cat "$file" > "$DIR"/"$name"/data
+	echo 0 > "$DIR"/"$name"/loading
+}
+
+verify_fw() {
+	local name="$1"
+	local file="$2"
+
+	echo -n "$name" > "$DIR"/config_upload_name
+	if ! cmp "$file" "$DIR"/upload_read > /dev/null 2>&1; then
+		echo "$0: firmware compare for $name did not match" >&2
+		exit 1
+	fi
+
+	echo "$0: firmware upload for $name works" >&2
+	return 0
+}
+
+inject_error() {
+	local name="$1"
+	local status="$2"
+	local error="$3"
+
+	echo 1 > "$DIR"/"$name"/loading
+	echo -n "inject":"$status":"$error" > "$DIR"/"$name"/data
+	echo 0 > "$DIR"/"$name"/loading
+}
+
+await_status() {
+	local name="$1"
+	local expected="$2"
+	local status
+	local i
+
+	let i=0
+	while [ $i -lt 50 ]; do
+		status=$(cat "$DIR"/"$name"/status)
+		if [ "$status" = "$expected" ]; then
+			return 0;
+		fi
+		sleep 1e-03
+		let i=$i+1
+	done
+
+	echo "$0: Invalid status: Expected $expected, Actual $status" >&2
+	return 1;
+}
+
+await_idle() {
+	local name="$1"
+
+	await_status "$name" "idle"
+	return $?
+}
+
+expect_error() {
+	local name="$1"
+	local expected="$2"
+	local error=$(cat "$DIR"/"$name"/error)
+
+	if [ "$error" != "$expected" ]; then
+		echo "Invalid error: Expected $expected, Actual $error" >&2
+		return 1
+	fi
+
+	return 0
+}
+
+random_firmware() {
+	local bs="$1"
+	local count="$2"
+	local file=$(mktemp -p /tmp uploadfwXXX.bin)
+
+	dd if=/dev/urandom of="$file" bs="$bs" count="$count" > /dev/null 2>&1
+	echo "$file"
+}
+
+test_upload_cancel() {
+	local name="$1"
+	local status
+
+	for status in $progress_states; do
+		inject_error $name $status $error_abort
+		if ! await_status $name $status; then
+			exit 1
+		fi
+
+		echo 1 > "$DIR"/"$name"/cancel
+
+		if ! await_idle $name; then
+			exit 1
+		fi
+
+		if ! expect_error $name "$status":"$error_abort"; then
+			exit 1
+		fi
+	done
+
+	echo "$0: firmware upload cancellation works"
+	return 0
+}
+
+test_error_handling() {
+	local name=$1
+	local status
+	local error
+
+	for status in $progress_states; do
+		for error in $errors; do
+			inject_error $name $status $error
+
+			if ! await_idle $name; then
+				exit 1
+			fi
+
+			if ! expect_error $name "$status":"$error"; then
+				exit 1
+			fi
+
+		done
+	done
+	echo "$0: firmware upload error handling works"
+}
+
+test_fw_too_big() {
+	local name=$1
+	local fw_too_big=`random_firmware 512 5`
+	local expected="preparing:invalid-file-size"
+
+	upload_fw $name $fw_too_big
+	rm -f $fw_too_big
+
+	if ! await_idle $name; then
+		exit 1
+	fi
+
+	if ! expect_error $name $expected; then
+		exit 1
+	fi
+
+	echo "$0: oversized firmware error handling works"
+}
+
+echo -n "$fwname1" > "$DIR"/upload_register
+echo -n "$fwname2" > "$DIR"/upload_register
+echo -n "$fwname3" > "$DIR"/upload_register
+
+test_upload_cancel $fwname1
+test_error_handling $fwname1
+test_fw_too_big $fwname1
+
+fw_file1=`random_firmware 512 4`
+fw_file2=`random_firmware 512 3`
+fw_file3=`random_firmware 512 2`
+
+upload_fw $fwname1 $fw_file1
+upload_fw $fwname2 $fw_file2
+upload_fw $fwname3 $fw_file3
+
+verify_fw ${fwname1} ${fw_file1}
+verify_fw ${fwname2} ${fw_file2}
+verify_fw ${fwname3} ${fw_file3}
+
+echo -n "$fwname1" > "$DIR"/upload_unregister
+echo -n "$fwname2" > "$DIR"/upload_unregister
+echo -n "$fwname3" > "$DIR"/upload_unregister
+
+exit 0
-- 
2.25.1


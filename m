Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0213E5103B3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353050AbiDZQmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348600AbiDZQmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:42:08 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6141420F5D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650991140; x=1682527140;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JuGMOU+H6LBTQwsiSNp3IjNAcHxmBURpsuWFPNqt9rQ=;
  b=PZ5FiMP+s/TkLTf24Z48r6v5lCyW41H/EvomDlOI3KEdGAyPItKJBMXT
   fjMBfgFhP323bObgZtwFn53obA8gqQXhGJzxieQwCFlvyfVYNxA8Hskl4
   hOHEGKs30+kR94XxltwY/m+ofDpzhVoNvL3DAhc8JwRoBF55EOVMf6xeg
   YNWi+Yaq8vESHBV5vDrsoea/8Ly8XUPzxOr9Gm124ZzIzF2J0J0PcLepd
   ruB7UjjZneMxHUjQCGYF7ZqngAPgla8SCsCXlYhqOCgN2UlRVBJ9uqDAv
   rwPftVPm2fc5dKlAiHBpnFD0NjWf25GqTzpq4m5SIrsncPWX3h8Q+Ew8J
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="265451431"
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="265451431"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 09:35:36 -0700
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="679075354"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.212.180.158])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 09:35:34 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mcgrof@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, marpagan@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v6 1/1] selftests: firmware: Add firmware upload selftests
Date:   Tue, 26 Apr 2022 09:35:32 -0700
Message-Id: <20220426163532.114961-1-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add selftests to verify the firmware upload mechanism. These test
include simple firmware uploads as well as upload cancellation and
error injection. The test creates three firmware devices and verifies
that they all work correctly and independently.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Tianfei zhang <tianfei.zhang@intel.com>
Tested-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
v2:
  - No changes from v1
v3:
  - Added Reviewed-by tag
v4:
  - Added Reviewed-by tag
v5:
  - Added Tested-by tag
v6:
  - Rebased on driver-core-testing branch
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
index 3fa8282b053b..7bffd67800bf 100755
--- a/tools/testing/selftests/firmware/fw_lib.sh
+++ b/tools/testing/selftests/firmware/fw_lib.sh
@@ -64,6 +64,7 @@ check_setup()
 	HAS_FW_LOADER_USER_HELPER_FALLBACK="$(kconfig_has CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y)"
 	HAS_FW_LOADER_COMPRESS_XZ="$(kconfig_has CONFIG_FW_LOADER_COMPRESS_XZ=y)"
 	HAS_FW_LOADER_COMPRESS_ZSTD="$(kconfig_has CONFIG_FW_LOADER_COMPRESS_ZSTD=y)"
+	HAS_FW_UPLOAD="$(kconfig_has CONFIG_FW_UPLOAD=y)"
 	PROC_FW_IGNORE_SYSFS_FALLBACK="0"
 	PROC_FW_FORCE_SYSFS_FALLBACK="0"
 
@@ -119,6 +120,12 @@ verify_reqs()
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A95958977A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 07:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239070AbiHDFrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 01:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238960AbiHDFr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 01:47:26 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F6C6111A;
        Wed,  3 Aug 2022 22:47:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8dSDIXtpwO/weBAfRchYicY6BXYO8eEZCJYX31Cse0V7Vi7mYhSQdAYTP3oWhGEpkzzhJ7SoseCXOvbRkm9dKm4eqM2DEhnE3BGfpjFsMWaffRUhVub4Sn2ngcmXXAFhWbs0N1yqrB+wLXujsDNQ1dA/ymdCAEAixaG9T9jAL6WL1KahIzdSqoSMAVmNLRJV94H8T3ADrb0ywnfudntZD04Nx/RGAy1s8sDvBV2xoHt7+gmfc9jjh/ZmmYyEs6rl5s7CVtzHvbLJZtpDylzglH4oC0SD2b5eNLGWFK2O1CS9VfJwceaZwr6HaRRGe+kVKsvXyDd5m8BXyfAkT7upg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/TX9smQeuJV1bYric3acWx63EsDvg5HzzRSxVEznG0=;
 b=QyghJhKpH6hz7EWrfx96PieM3UNc1FXeAgApJWXk4PqICqemgU7+sVomLlgBqZETE5O0fOAEAbOrT5WkrMHgMU6vseEggGDqBgsredlROZ1yQ//gFRupccYcE/aGaHwBQLCR4USEMsoQsdPJI6v1kzyRsvWILUeREJmNGet4ib3gMoCEoiwRCo/5yokQaZOmNZP/SNeCg4HYFjm7H92vFIM878pt0Myf+f5Qj1ROvu3Gw8L57C3v2/ftiLmrCQNXqgGHknq+TDg86lwk2Sf5LXpNk5SzGjpwZhXUwe0+ciz5fMt+dOSpByPE3fV4pZ24qmi3AHgAUFDU1S4FzP1MLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/TX9smQeuJV1bYric3acWx63EsDvg5HzzRSxVEznG0=;
 b=jEvqvGayZJmEP3b2QMT1EBxWVIHJDlHvIFWyjsANc0KdbYtzUhDvrazlBoCTCTew4n0nTcvDEaDSQMEi0ILi1P2fCYcI4oIxh6Y3ulKaW+wx3rkNA33u+Hn8l3eACgLSmJoYSnlMawG4anJJL/KjPquRQXGbbWI63yhZhF3YxfE=
Received: from DS7PR03CA0063.namprd03.prod.outlook.com (2603:10b6:5:3bb::8) by
 BN6PR12MB1665.namprd12.prod.outlook.com (2603:10b6:405:7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14; Thu, 4 Aug 2022 05:47:10 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::b8) by DS7PR03CA0063.outlook.office365.com
 (2603:10b6:5:3bb::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16 via Frontend
 Transport; Thu, 4 Aug 2022 05:47:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Thu, 4 Aug 2022 05:47:09 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 4 Aug
 2022 00:47:04 -0500
From:   Meng Li <li.meng@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Huang Rui <ray.huang@amd.com>, <linux-pm@vger.kernel.org>
CC:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, <linux-kernel@vger.kernel.org>,
        Meng Li <li.meng@amd.com>
Subject: [PATCH V2 1/4] selftests: amd-pstate: Modify amd-pstate-ut.sh to basic.sh.
Date:   Thu, 4 Aug 2022 13:44:11 +0800
Message-ID: <20220804054414.1510764-2-li.meng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804054414.1510764-1-li.meng@amd.com>
References: <20220804054414.1510764-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 414af6bd-55b5-4ac9-5e28-08da75dcc5ad
X-MS-TrafficTypeDiagnostic: BN6PR12MB1665:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 92zxHYm7HuoWLx4x6ZyWt1aFAk0w1hX7Kot1DfNZaD6GJyNG4ITXN5ahFLR+V7t9J86w5C4JKmKu1Qm1PBDiwZ7TKwPJfUwA/K6digTn7GivHh/g2ijsH6OA+Y7HihrzEryIPVs4wY5GYmjmhHi+z3yVM8qSUQJQpvbXNvs5uQWViqFPO+FpLR7RaWu/F3I3VRVY8B3d8FS+MpGsjNjLNspO/izaWSJeCMRsoQv2wtIzWXBauL+je6YS0jNDv1TtUTWxw63yN+aPg89vGxypuo0X8a8d87lqK/tIGz49JCjS90JvBHESNN9BqEQQYRgNTCUyy1dba6Zzq2giYQRRXh/iC4m4t8mTa3vqvbh2UO4IpetGbyvVVf9ZumbE0bEDGNmbrLC+WLaK+hdSuqk2mqPIS0Gtdpm1smgpVEBxpOdqNdEuJ9kOCKw+iYMcLCbEIGfcXGQ+ohnxBcdjwfkEpbTfpV+ySF1GMQXcq0wFGcop70+MgoaRqU1VslTXC7fwEM6BEoOp6C2hc6S4WM/yI8G8kQIsEt7BTvW6dvWkYKTW85WRyl93YVPCbBgqaARlmwNJ9Z/40QGcKjzdY+PVzDdbrQOqB4W7f8Rbs9azKBD2FEsWsqOUqTIo1nNi9w/XOKDZScqZkremAZ2ULEAMOc6scSJWKZSqj9iI1HnqFU9fI1jFhA8ClSrCWhFBK17fHiSOreCaCJvKdisBbmU3uHF4Dnnc03a9I2071trjviedlfq9U+BwqEICXdk/kQcKMRnWIrklgvTgZQS8AGaviH/U/pzH4fm76qT0LN6obuW2IYcxifpbxnMJecNAbI3RQhL9UTu0z8l4AoL68TfWSA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(136003)(396003)(346002)(46966006)(36840700001)(40470700004)(16526019)(186003)(426003)(47076005)(336012)(40460700003)(2906002)(26005)(41300700001)(7696005)(6666004)(1076003)(82740400003)(2616005)(86362001)(81166007)(356005)(40480700001)(83380400001)(82310400005)(36860700001)(5660300002)(36756003)(70586007)(4326008)(70206006)(8676002)(8936002)(316002)(478600001)(54906003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 05:47:09.5137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 414af6bd-55b5-4ac9-5e28-08da75dcc5ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1665
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify amd-pstate-ut.sh to basic.sh.
The purpose of this modification is to facilitate the subsequent
addition of gitsource, tbench and other tests.
Then you can specify test case in kselftest/amd-pstate, for example:
sudo ./run.sh -c basic, this command only test basic kernel funcitions.
The detail please run the below script.
./run.sh --help

Signed-off-by: Meng Li <li.meng@amd.com>
---
 tools/testing/selftests/amd-pstate/Makefile   |   3 +-
 .../selftests/amd-pstate/amd-pstate-ut.sh     |  55 -------
 tools/testing/selftests/amd-pstate/basic.sh   |  38 +++++
 tools/testing/selftests/amd-pstate/run.sh     | 141 ++++++++++++++++++
 4 files changed, 181 insertions(+), 56 deletions(-)
 delete mode 100755 tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
 create mode 100755 tools/testing/selftests/amd-pstate/basic.sh
 create mode 100755 tools/testing/selftests/amd-pstate/run.sh

diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
index 199867f44b32..6f4c7b01e3bb 100644
--- a/tools/testing/selftests/amd-pstate/Makefile
+++ b/tools/testing/selftests/amd-pstate/Makefile
@@ -4,6 +4,7 @@
 # No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
 all:
 
-TEST_PROGS := amd-pstate-ut.sh
+TEST_PROGS := run.sh
+TEST_FILES := basic.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh b/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
deleted file mode 100755
index 273364650285..000000000000
--- a/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
+++ /dev/null
@@ -1,55 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-# amd-pstate-ut is a test module for testing the amd-pstate driver.
-# It can only run on x86 architectures and current cpufreq driver
-# must be amd-pstate.
-# (1) It can help all users to verify their processor support
-# (SBIOS/Firmware or Hardware).
-# (2) Kernel can have a basic function test to avoid the kernel
-# regression during the update.
-# (3) We can introduce more functional or performance tests to align
-# the result together, it will benefit power and performance scale optimization.
-
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
-
-# amd-pstate-ut only run on x86/x86_64 AMD systems.
-ARCH=$(uname -m 2>/dev/null | sed -e 's/i.86/x86/' -e 's/x86_64/x86/')
-VENDOR=$(cat /proc/cpuinfo | grep -m 1 'vendor_id' | awk '{print $NF}')
-
-if ! echo "$ARCH" | grep -q x86; then
-	echo "$0 # Skipped: Test can only run on x86 architectures."
-	exit $ksft_skip
-fi
-
-if ! echo "$VENDOR" | grep -iq amd; then
-	echo "$0 # Skipped: Test can only run on AMD CPU."
-	echo "$0 # Current cpu vendor is $VENDOR."
-	exit $ksft_skip
-fi
-
-scaling_driver=$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_driver)
-if [ "$scaling_driver" != "amd-pstate" ]; then
-	echo "$0 # Skipped: Test can only run on amd-pstate driver."
-	echo "$0 # Current cpufreq scaling drvier is $scaling_driver."
-	exit $ksft_skip
-fi
-
-msg="Skip all tests:"
-if [ ! -w /dev ]; then
-    echo $msg please run this as root >&2
-    exit $ksft_skip
-fi
-
-if ! /sbin/modprobe -q -n amd-pstate-ut; then
-	echo "amd-pstate-ut: module amd-pstate-ut is not found [SKIP]"
-	exit $ksft_skip
-fi
-if /sbin/modprobe -q amd-pstate-ut; then
-	/sbin/modprobe -q -r amd-pstate-ut
-	echo "amd-pstate-ut: ok"
-else
-	echo "amd-pstate-ut: [FAIL]"
-	exit 1
-fi
diff --git a/tools/testing/selftests/amd-pstate/basic.sh b/tools/testing/selftests/amd-pstate/basic.sh
new file mode 100755
index 000000000000..e4c43193e4a3
--- /dev/null
+++ b/tools/testing/selftests/amd-pstate/basic.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+# amd-pstate-ut is a test module for testing the amd-pstate driver.
+# It can only run on x86 architectures and current cpufreq driver
+# must be amd-pstate.
+# (1) It can help all users to verify their processor support
+# (SBIOS/Firmware or Hardware).
+# (2) Kernel can have a basic function test to avoid the kernel
+# regression during the update.
+# (3) We can introduce more functional or performance tests to align
+# the result together, it will benefit power and performance scale optimization.
+
+# protect against multiple inclusion
+if [ $FILE_BASIC ]; then
+	return 0
+else
+	FILE_BASIC=DONE
+fi
+
+amd_pstate_basic()
+{
+	printf "\n---------------------------------------------\n"
+	printf "*** Running AMD P-state ut                ***"
+	printf "\n---------------------------------------------\n"
+
+	if ! /sbin/modprobe -q -n amd-pstate-ut; then
+		echo "amd-pstate-ut: module amd-pstate-ut is not found [SKIP]"
+		exit $ksft_skip
+	fi
+	if /sbin/modprobe -q amd-pstate-ut; then
+		/sbin/modprobe -q -r amd-pstate-ut
+		echo "amd-pstate-basic: ok"
+	else
+		echo "amd-pstate-basic: [FAIL]"
+		exit 1
+	fi
+}
diff --git a/tools/testing/selftests/amd-pstate/run.sh b/tools/testing/selftests/amd-pstate/run.sh
new file mode 100755
index 000000000000..dfacbec063c0
--- /dev/null
+++ b/tools/testing/selftests/amd-pstate/run.sh
@@ -0,0 +1,141 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# protect against multiple inclusion
+if [ $FILE_MAIN ]; then
+	return 0
+else
+	FILE_MAIN=DONE
+fi
+
+source basic.sh
+
+# amd-pstate-ut only run on x86/x86_64 AMD systems.
+ARCH=$(uname -m 2>/dev/null | sed -e 's/i.86/x86/' -e 's/x86_64/x86/')
+VENDOR=$(cat /proc/cpuinfo | grep -m 1 'vendor_id' | awk '{print $NF}')
+
+FUNC=all
+OUTFILE=selftest
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+# All amd-pstate tests
+amd_pstate_all()
+{
+	printf "\n=============================================\n"
+	printf "***** Running AMD P-state Sanity Tests  *****\n"
+	printf "=============================================\n\n"
+
+	# unit test for amd-pstate kernel driver
+	amd_pstate_basic
+}
+
+helpme()
+{
+	printf "Usage: $0 [OPTION...]
+	[-h <help>]
+	[-o <output-file-for-dump>]
+	[-c <all: All testing,
+	     basic: Basic testing.>]
+	\n"
+	exit 2
+}
+
+parse_arguments()
+{
+	while getopts ho:c: arg
+	do
+		case $arg in
+			h) # --help
+				helpme
+				;;
+
+			c) # --func_type (Function to perform: basic (default: all))
+				FUNC=$OPTARG
+				;;
+
+			o) # --output-file (Output file to store dumps)
+				OUTFILE=$OPTARG
+				;;
+
+			*)
+				helpme
+				;;
+		esac
+	done
+}
+
+prerequisite()
+{
+	if ! echo "$ARCH" | grep -q x86; then
+		echo "$0 # Skipped: Test can only run on x86 architectures."
+		exit $ksft_skip
+	fi
+
+	if ! echo "$VENDOR" | grep -iq amd; then
+		echo "$0 # Skipped: Test can only run on AMD CPU."
+		echo "$0 # Current cpu vendor is $VENDOR."
+		exit $ksft_skip
+	fi
+
+	scaling_driver=$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_driver)
+	if [ "$scaling_driver" != "amd-pstate" ]; then
+		echo "$0 # Skipped: Test can only run on amd-pstate driver."
+		echo "$0 # Current cpufreq scaling drvier is $scaling_driver."
+		exit $ksft_skip
+	fi
+
+	msg="Skip all tests:"
+	if [ ! -w /dev ]; then
+		echo $msg please run this as root >&2
+		exit $ksft_skip
+	fi
+}
+
+do_test()
+{
+	case "$FUNC" in
+		"all")
+			amd_pstate_all
+			;;
+
+		"basic")
+			amd_pstate_basic
+			;;
+
+		*)
+			echo "Invalid [-f] function type"
+			helpme
+			;;
+	esac
+}
+
+# clear dumps
+pre_clear_dumps()
+{
+	case "$FUNC" in
+		"all")
+			rm -rf $OUTFILE*
+			;;
+
+		*)
+			;;
+	esac
+}
+
+post_clear_dumps()
+{
+	rm -rf $OUTFILE.log
+}
+
+# Parse arguments
+parse_arguments $@
+
+# Make sure all requirements are met
+prerequisite
+
+# Run requested functions
+pre_clear_dumps
+do_test | tee -a $OUTFILE.log
+post_clear_dumps
-- 
2.25.1


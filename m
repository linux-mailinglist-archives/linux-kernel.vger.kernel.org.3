Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B598C568002
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 09:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbiGFHhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 03:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbiGFHhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 03:37:08 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D4622B2D;
        Wed,  6 Jul 2022 00:37:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JV8dDokWB1lvplJiiBJzDlRT+6JDzRgYSqgD1qmGJgbOrDqq3CTZucTdNvSO9GbMDRPINGKQi6azekTLx+BiDnPKDkIWE7UaXPayEGo9LZaptWpPPX4llD/QF5/oMoQckcl0durqWI3Vl1jDqyKNuluoUXXxuGNBfE+XUDSUmSqmv/RLukZXFzO+ob+VTM7RDZHkz1hK9YdB3XV5fBY1bzU7/hcSSKAOQLNqIfEPwZ5BGEFIOvfIuva+KpPSg4+D7sJEycj0MIaGrAR/tM+b68qLgJ9TgP2ilp6Jz0dhwOEgO0b8EK6+c7TrZxQ3Ye9V7cESUwhuCEoHPgubDIHX2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRfgOiS1B4ukdh5lyCJvijBwLT3IcTDzlgRc/+oyiv0=;
 b=E4JrIIS+fglCCObF1AT+KweD0Z0suciQ5uKYrzI/EgiuxggQC4eOgILVhOw1nAqV5uTeddMNqHU2CVnJ4eRL/otNWR6nx34XhtSKwd9pMzmWJCXIlw4oXmSZtVTP+OYqo+TylWNMuzrKmaIQ0O2cRpzBLAM4qO1TiBed1U4ZI2HWVrDH9B5AaLdwMFcu3bIE8SGm8JFs14J6oR4URCz0OlLX7VRvkIwvuewesYqpnUf37USjJk1dGq1XjE4NVurDia6NT1Yc+8H/+bNwy45sk4U+QN4MGDjDXHkmhtVn0/c4QGI1Nl1X8VfLhwOFdkxEkgY4iqIcF1Rlu0ZM5KOqlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRfgOiS1B4ukdh5lyCJvijBwLT3IcTDzlgRc/+oyiv0=;
 b=rMzXlDGEAt0uEdaG0iIN5fpsYXUZRoiWwMLmsCXaw6NNgkwTzbmvWr283e1KBztjxn3BVeCGrwU7fHruRBRyL8KaoArnUlC2yvTkTWgtqXxsp+ZuKosqsIKKd0I+6KkHRYOb1eCkGuroeFhJF9x6F0/tTboIk/pcqjqTw54Lvd8=
Received: from MWHPR03CA0014.namprd03.prod.outlook.com (2603:10b6:300:117::24)
 by BL0PR12MB4964.namprd12.prod.outlook.com (2603:10b6:208:1c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 6 Jul
 2022 07:37:05 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:117:cafe::e6) by MWHPR03CA0014.outlook.office365.com
 (2603:10b6:300:117::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Wed, 6 Jul 2022 07:37:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 07:37:04 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 02:36:58 -0500
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
Subject: [PATCH V1 2/4] selftests: amd-pstate: Trigger tbench benchmark and test cpus
Date:   Wed, 6 Jul 2022 15:36:20 +0800
Message-ID: <20220706073622.672135-3-li.meng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706073622.672135-1-li.meng@amd.com>
References: <20220706073622.672135-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43a3349e-e20c-41be-6ad3-08da5f2252b3
X-MS-TrafficTypeDiagnostic: BL0PR12MB4964:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QCCa68Y5fq0lxfuQDdXlNHsJ6U4TBNVXNMYMLHI84VQ4nrLbn4Nv6ZvXh+NsGNsGbKG5zaCl8SghtytV2XpSdO61YKZXY8p0ZcDpJ4BmEzWM0FJSVVbw1dTSEK00d0V8sjLOSJFY9JS+LUsA6aUlsFjSSfkq4yRp0yz5v18QWfa6S+/uoNuUoL4Sap83oKnulEjzAbbnx09wwtRXKt61p7xOi9+427w9Zl66Mj+V+yj79kn6rSgTAIsPCmTlhzVeNL12GPkVjLR69mwxnZ3bF1sOa+Q9pxo0CFmPlK6OGDkZetBLPhJkMk/JCAfo9xf5h5yt2GtSNeJg2v6GiM2090ktdpwOrKvf7Cerbu4I0ZNr2F6OEbtzKmCxBs6KrSyuaQbPR3bRVgu+WWu4iygrmEhvbkbQgIqRC1MrBE9HciVqjcL9GwaKhylxRjG/ntQaNusPekO12nkTp0CXDxwJKldTWfsYUx18VtVIglCCdg5ziZbVTRihDQeaoAlOEIZWyHmzuDbg92EfdqSliCs4w2Hk/W7XmmrMmGOmbUs/DLE9aePNsiIRT1YC92eetc2FMvSIvLl2oXtHIEfcweKW8JMDqgdo1pxwSQ3h8uq1fZ3v60QPlqHZR3kjeUb5mFWEWdXG751Wm8BmgUdQXkY4whKy4ZYJ0/9n8vvvFgpm1Jp4xZ0rqNPlHmZRx2hmxoOZEOiU/Ue/Aj1gOOWSChClnY7Am91D7slrhXYM4OxjffoK7CunRI8I3t6D/YOc02+IOj5X6524rkz9iZQITzbjbYIVLWQNdmIAHhL6589WAuQpLV/7J1jhIVGNmwkCcih7Yn76FyioknWNKpwEkTAOwxmE3ZVLILsYo/bsP5SFFrp5fBdhyyiepwDfwZ1tYWA/EhzJ7aD1uLmPnDbYplXhxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(396003)(136003)(46966006)(40470700004)(36840700001)(7696005)(36756003)(356005)(81166007)(34020700004)(40480700001)(54906003)(36860700001)(110136005)(316002)(86362001)(82740400003)(6666004)(82310400005)(2906002)(8676002)(83380400001)(41300700001)(4326008)(5660300002)(336012)(47076005)(26005)(30864003)(70206006)(70586007)(426003)(40460700003)(16526019)(186003)(8936002)(1076003)(2616005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 07:37:04.5488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a3349e-e20c-41be-6ad3-08da5f2252b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4964
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tbench.sh trigger the tbench testing and monitor the cpu desire
performance, frequency, load, power consumption and throughput etc.

Signed-off-by: Meng Li <li.meng@amd.com>
---
 tools/testing/selftests/amd-pstate/Makefile  |  10 +-
 tools/testing/selftests/amd-pstate/main.sh   | 168 ++++++++++++++++-
 tools/testing/selftests/amd-pstate/tbench.sh | 187 +++++++++++++++++++
 3 files changed, 361 insertions(+), 4 deletions(-)
 create mode 100755 tools/testing/selftests/amd-pstate/tbench.sh

diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
index 167ab51ec290..e2fb03381a32 100644
--- a/tools/testing/selftests/amd-pstate/Makefile
+++ b/tools/testing/selftests/amd-pstate/Makefile
@@ -4,7 +4,15 @@
 # No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
 all:
 
+uname_M := $(shell uname -m 2>/dev/null || echo not)
+ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
+
+ifeq (x86,$(ARCH))
+TEST_GEN_FILES += ../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py
+TEST_GEN_FILES += ../../../power/x86/intel_pstate_tracer/intel_pstate_tracer.py
+endif
+
 TEST_PROGS := run.sh
-TEST_FILES := main.sh basic.sh
+TEST_FILES := main.sh basic.sh tbench.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/amd-pstate/main.sh b/tools/testing/selftests/amd-pstate/main.sh
index 1c28b5d7b4c5..ae71fe62e3b0 100755
--- a/tools/testing/selftests/amd-pstate/main.sh
+++ b/tools/testing/selftests/amd-pstate/main.sh
@@ -9,6 +9,7 @@ else
 fi
 
 source basic.sh
+source tbench.sh
 
 # amd-pstate-ut only run on x86/x86_64 AMD systems.
 ARCH=$(uname -m 2>/dev/null | sed -e 's/i.86/x86/' -e 's/x86_64/x86/')
@@ -16,10 +17,95 @@ VENDOR=$(cat /proc/cpuinfo | grep -m 1 'vendor_id' | awk '{print $NF}')
 
 FUNC=all
 OUTFILE=selftest
+OUTFILE_TBENCH="$OUTFILE.tbench"
+
+SYSFS=
+CPUROOT=
+CPUFREQROOT=
+MAKE_CPUS=
+
+TIME_LIMIT=100
+PROCESS_NUM=128
+LOOP_TIMES=3
+TRACER_INTERVAL=10
 
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 
+# Counts CPUs with cpufreq directories
+count_cpus()
+{
+	count=0;
+
+	for cpu in `ls $CPUROOT | grep "cpu[0-9].*"`; do
+		if [ -d $CPUROOT/$cpu/cpufreq ]; then
+			let count=count+1;
+		fi
+	done
+
+	echo $count;
+}
+
+# $1: policy
+find_current_governor()
+{
+	cat $CPUFREQROOT/$1/scaling_governor
+}
+
+# $1: policy
+backup_governor()
+{
+	local cur_gov=$(find_current_governor $1)
+
+	printf "Governor backup done for $1: $cur_gov\n"
+	echo "$1 $cur_gov" >> $OUTFILE.backup_governor.log
+}
+
+restore_governor()
+{
+	i=0;
+
+	policies=$(awk '{print $1}' $OUTFILE.backup_governor.log)
+	for policy in $policies; do
+		let i++;
+		governor=$(sed -n ''$i'p' $OUTFILE.backup_governor.log | awk '{print $2}')
+
+		# switch governor
+		_switch_governor $policy $governor
+		printf "Governor restored for $policy to $governor\n"
+	done
+}
+
+# $1: policy, $2: governor
+_switch_governor()
+{
+	echo $2 > $CPUFREQROOT/$1/scaling_governor
+}
+
+for_each_policy()
+{
+	policies=$(ls $CPUFREQROOT| grep "policy[0-9].*")
+	for policy in $policies; do
+		$@ $policy
+	done
+}
+
+# $1: governor, $2: policy
+switch_governor()
+{
+	local filepath=$CPUFREQROOT/$2/scaling_available_governors
+
+	# Exit if cpu isn't managed by cpufreq core
+	if [ ! -f $filepath ]; then
+		return;
+	fi
+
+	# switch governor
+	_switch_governor $2 $1
+
+	printf "Switched governor for $2 to $1\n"
+}
+
 # All amd-pstate tests
 amd_pstate_all()
 {
@@ -27,8 +113,19 @@ amd_pstate_all()
 	printf "***** Running AMD P-state Sanity Tests  *****\n"
 	printf "=============================================\n\n"
 
+	count=$(count_cpus)
+	if [ $count = 0 ]; then
+		printf "No cpu is managed by cpufreq core, exiting\n"
+		exit;
+	else
+		printf "AMD P-state manages: $count CPUs\n"
+	fi
+
 	# unit test for amd-pstate kernel driver
 	amd_pstate_basic
+
+	# tbench
+	amd_pstate_tbench
 }
 
 helpme()
@@ -37,21 +134,26 @@ helpme()
 	[-h <help>]
 	[-o <output-file-for-dump>]
 	[-c <all: All testing,
-	     basic: Basic testing.>]
+	     basic: Basic testing,
+	     tbench: Tbench testing.>]
+	[-t <tbench time limit>]
+	[-p <tbench process number>]
+	[-l <loop times for tbench]
+	[-i <amd tracer interval]
 	\n"
 	exit 2
 }
 
 parse_arguments()
 {
-	while getopts ho:c: arg
+	while getopts ho:c:t:p:l:i: arg
 	do
 		case $arg in
 			h) # --help
 				helpme
 				;;
 
-			c) # --func_type (Function to perform: basic (default: all))
+			c) # --func_type (Function to perform: basic, tbench (default: all))
 				FUNC=$OPTARG
 				;;
 
@@ -59,6 +161,21 @@ parse_arguments()
 				OUTFILE=$OPTARG
 				;;
 
+			t) # --tbench-time-limit
+				TIME_LIMIT=$OPTARG
+				;;
+
+			p) # --tbench-process-number
+				PROCESS_NUM=$OPTARG
+				;;
+
+			l) # --tbench-loop-times
+				LOOP_TIMES=$OPTARG
+				;;
+
+			i) # --amd-tracer-interval
+				TRACER_INTERVAL=$OPTARG
+				;;
 			\?)
 				helpme
 				;;
@@ -91,10 +208,44 @@ prerequisite()
 		echo $msg please run this as root >&2
 		exit $ksft_skip
 	fi
+
+	if [ ! -f perf ] ; then
+		echo $msg please build perf under directory tools/perf and copy it to directory amd-pstate. >&2
+		exit $ksft_skip
+	fi
+
+	SYSFS=`mount -t sysfs | head -1 | awk '{ print $3 }'`
+
+	if [ ! -d "$SYSFS" ]; then
+		echo $msg sysfs is not mounted >&2
+		exit 2
+	fi
+
+	CPUROOT=$SYSFS/devices/system/cpu
+	CPUFREQROOT="$CPUROOT/cpufreq"
+
+	if ! ls $CPUROOT/cpu* > /dev/null 2>&1; then
+		echo $msg cpus not available in sysfs >&2
+		exit 2
+	fi
+
+	if ! ls $CPUROOT/cpufreq > /dev/null 2>&1; then
+		echo $msg cpufreq directory not available in sysfs >&2
+		exit 2
+	fi
 }
 
 do_test()
 {
+	# Check if CPUs are managed by cpufreq or not
+	count=$(count_cpus)
+	MAKE_CPUS=$((count*2))
+
+	if [ $count = 0 ]; then
+		echo "No cpu is managed by cpufreq core, exiting"
+		exit 2;
+	fi
+
 	case "$FUNC" in
 		"all")
 		amd_pstate_all
@@ -104,6 +255,10 @@ do_test()
 		amd_pstate_basic
 		;;
 
+		"tbench")
+		amd_pstate_tbench
+		;;
+
 		*)
 		echo "Invalid [-f] function type"
 		helpme
@@ -122,10 +277,17 @@ pre_clear_dumps()
 		"basic")
 		;;
 
+		"tbench")
+		rm -rf $OUTFILE.log
+		rm -rf $OUTFILE.backup_governor.log
+		rm -rf $OUTFILE_TBENCH*
+		;;
+
 	esac
 }
 
 post_clear_dumps()
 {
 	rm -rf $OUTFILE.log
+	rm -rf $OUTFILE.backup_governor.log
 }
diff --git a/tools/testing/selftests/amd-pstate/tbench.sh b/tools/testing/selftests/amd-pstate/tbench.sh
new file mode 100755
index 000000000000..0320300971ce
--- /dev/null
+++ b/tools/testing/selftests/amd-pstate/tbench.sh
@@ -0,0 +1,187 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+# Testing and monitor the cpu frequency and performance when
+# this script trigger tbench test.
+
+# protect against multiple inclusion
+if [ $FILE_TBENCH ]; then
+	return 0
+else
+	FILE_TBENCH=DONE
+fi
+
+tbench_name="dbench-4.0"
+tbench_tar="$tbench_name.tar.gz"
+tbench_url="https://ftp.samba.org/pub/pub/tridge/dbench/dbench-4.0.tar.gz"
+tbench_governors=("ondemand" "schedutil")
+
+# $1: governor, $2: round, $3: des-perf, $4: freq, $5: load, $6: performance, $7: energy, $8: PPW
+store_csv_tbench()
+{
+	echo "$1, $2, $3, $4, $5, $6, $7, $8" | tee -a $OUTFILE_TBENCH.csv > /dev/null 2>&1
+}
+
+empty_line_csv_tbench()
+{
+	echo "" | tee -a $OUTFILE_TBENCH.csv > /dev/null 2>&1
+}
+
+pre_clear_tbench()
+{
+	rm -rf results/tracer-tbench*
+}
+
+post_clear_tbench()
+{
+	rm -rf results/tracer-tbench*
+	rm -rf $OUTFILE_TBENCH*.log
+}
+
+install_tbench()
+{
+	if [ ! -d $tbench_name ]; then
+		printf "Download tbench, please wait a moment ...\n\n"
+		wget -O $tbench_tar $tbench_url > /dev/null 2>&1
+
+		printf "Tar tbench ...\n\n"
+		tar -xzf $tbench_tar
+
+		printf "Compile and install tbench ...\n\n"
+		cd $tbench_name
+		./autogen.sh
+		./configure > /dev/null 2>&1
+		make > /dev/null 2>&1
+		make install > /dev/null 2>&1
+		cd ..
+	fi
+}
+
+# $1: governor, $2: loop
+run_tbench()
+{
+	echo "Launching amd pstate tracer for $1 #$2 tracer_interval: $TRACER_INTERVAL"
+	./amd_pstate_trace.py -n tracer-tbench-$1-$2 -i $TRACER_INTERVAL > /dev/null 2>&1 &
+
+	printf "Test tbench for $1 #$2 time_limit: $TIME_LIMIT procs_num: $PROCESS_NUM\n"
+	cd $tbench_name
+	./tbench_srv > /dev/null 2>&1 &
+	./../perf stat -a --per-socket -I 1000 -e power/energy-pkg/ ./tbench -t $TIME_LIMIT $PROCESS_NUM > ../$OUTFILE_TBENCH-perf-$1-$2.log 2>&1
+	cd ..
+
+	pid=`pidof tbench_srv`
+	kill $pid
+
+	for job in `jobs -p`
+	do
+		echo "Waiting for job id $job"
+		wait $job
+	done
+}
+
+# $1: governor, $2: loop
+parse_tbench()
+{
+	awk '{print $5}' results/tracer-tbench-$1-$2/cpu.csv | sed -e '1d' | sed s/,// > $OUTFILE_TBENCH-des-perf-$1-$2.log
+	avg_des_perf=$(awk 'BEGIN {i=0; sum=0};{i++; sum += $1};END {print sum/i}' $OUTFILE_TBENCH-des-perf-$1-$2.log)
+	printf "Tbench-$1-#$2 avg des perf: $avg_des_perf\n" | tee -a $OUTFILE_TBENCH.result
+
+	awk '{print $7}' results/tracer-tbench-$1-$2/cpu.csv | sed -e '1d' | sed s/,// > $OUTFILE_TBENCH-freq-$1-$2.log
+	avg_freq=$(awk 'BEGIN {i=0; sum=0};{i++; sum += $1};END {print sum/i}' $OUTFILE_TBENCH-freq-$1-$2.log)
+	printf "Tbench-$1-#$2 avg freq: $avg_freq\n" | tee -a $OUTFILE_TBENCH.result
+
+	awk '{print $11}' results/tracer-tbench-$1-$2/cpu.csv | sed -e '1d' | sed s/,// > $OUTFILE_TBENCH-load-$1-$2.log
+	avg_load=$(awk 'BEGIN {i=0; sum=0};{i++; sum += $1};END {print sum/i}' $OUTFILE_TBENCH-load-$1-$2.log)
+	printf "Tbench-$1-#$2 avg load: $avg_load\n" | tee -a $OUTFILE_TBENCH.result
+
+	grep Throughput $OUTFILE_TBENCH-perf-$1-$2.log | awk '{print $2}' > $OUTFILE_TBENCH-throughput-$1-$2.log
+	tp_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_TBENCH-throughput-$1-$2.log)
+	printf "Tbench-$1-#$2 throughput(MB/s): $tp_sum\n" | tee -a $OUTFILE_TBENCH.result
+
+	grep Joules $OUTFILE_TBENCH-perf-$1-$2.log | awk '{print $4}' > $OUTFILE_TBENCH-energy-$1-$2.log
+	en_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_TBENCH-energy-$1-$2.log)
+	printf "Tbench-$1-#$2 power consumption(J): $en_sum\n" | tee -a $OUTFILE_TBENCH.result
+
+	ppw=`echo "scale=4;($TIME_LIMIT-1)*$tp_sum/$en_sum" | bc | awk '{printf "%.4f", $0}'`
+	printf "Tbench-$1-#$2 PPW(MB/J): $ppw\n" | tee -a $OUTFILE_TBENCH.result
+	printf "\n" | tee -a $OUTFILE_TBENCH.result
+
+	store_csv_tbench $1 $2 $avg_des_perf $avg_freq $avg_load $tp_sum $en_sum $ppw
+}
+
+# $1: governor
+loop_tbench()
+{
+	printf "\nTbench total test times is $LOOP_TIMES for $1\n\n"
+	for i in `seq 1 $LOOP_TIMES`
+	do
+		run_tbench $1 $i
+		parse_tbench $1 $i
+	done
+}
+
+# $1: governor
+gather_tbench()
+{
+	printf "Tbench test result for $1 (loops:$LOOP_TIMES)" | tee -a $OUTFILE_TBENCH.result
+	printf "\n--------------------------------------------------\n" | tee -a $OUTFILE_TBENCH.result
+
+	grep "Tbench-$1-#" $OUTFILE_TBENCH.result | grep "avg des perf:" | awk '{print $NF}' > $OUTFILE_TBENCH-des-perf-$1.log
+	avg_des_perf=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_TBENCH-des-perf-$1.log)
+	printf "Tbench-$1 avg des perf: $avg_des_perf\n" | tee -a $OUTFILE_TBENCH.result
+
+	grep "Tbench-$1-#" $OUTFILE_TBENCH.result | grep "avg freq:" | awk '{print $NF}' > $OUTFILE_TBENCH-freq-$1.log
+	avg_freq=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_TBENCH-freq-$1.log)
+	printf "Tbench-$1 avg freq: $avg_freq\n" | tee -a $OUTFILE_TBENCH.result
+
+	grep "Tbench-$1-#" $OUTFILE_TBENCH.result | grep "avg load:" | awk '{print $NF}' > $OUTFILE_TBENCH-load-$1.log
+	avg_load=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_TBENCH-load-$1.log)
+	printf "Tbench-$1 avg load: $avg_load\n" | tee -a $OUTFILE_TBENCH.result
+
+	grep "Tbench-$1-#" $OUTFILE_TBENCH.result | grep "throughput(MB/s):" | awk '{print $NF}' > $OUTFILE_TBENCH-throughput-$1.log
+	tp_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_TBENCH-throughput-$1.log)
+	printf "Tbench-$1 total throughput(MB/s): $tp_sum\n" | tee -a $OUTFILE_TBENCH.result
+
+	avg_tp=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_TBENCH-throughput-$1.log)
+	printf "Tbench-$1 avg throughput(MB/s): $avg_tp\n" | tee -a $OUTFILE_TBENCH.result
+
+	grep "Tbench-$1-#" $OUTFILE_TBENCH.result | grep "power consumption(J):" | awk '{print $NF}' > $OUTFILE_TBENCH-energy-$1.log
+	en_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_TBENCH-energy-$1.log)
+	printf "Tbench-$1 total power consumption(J): $en_sum\n" | tee -a $OUTFILE_TBENCH.result
+
+	avg_en=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_TBENCH-energy-$1.log)
+	printf "Tbench-$1 avg power consumption(J): $avg_en\n" | tee -a $OUTFILE_TBENCH.result
+
+	ppw=`echo "scale=4;($TIME_LIMIT-1)*$avg_tp/$avg_en" | bc | awk '{printf "%.4f", $0}'`
+	printf "Tbench-$1 PPW(MB/J): $ppw\n" | tee -a $OUTFILE_TBENCH.result
+	printf "\n" | tee -a $OUTFILE_TBENCH.result
+
+	store_csv_tbench $1 "Average" $avg_des_perf $avg_freq $avg_load $avg_tp $avg_en $ppw
+	empty_line_csv_tbench
+}
+
+amd_pstate_tbench()
+{
+	printf "\n---------------------------------------------\n"
+	printf "*** Running AMD P-state tbench            ***"
+	printf "\n---------------------------------------------\n"
+
+	pre_clear_tbench
+
+	install_tbench
+
+	store_csv_tbench "Governor" "Round" "Des-perf" "Freq" "Load" "Performance(MB/s)" "Energy(Joules)" "PPW(MB/J)"
+
+	for_each_policy backup_governor
+
+	for governor in ${tbench_governors[*]} ; do
+		printf "\nSpecified governor is $governor\n\n"
+		for_each_policy switch_governor $governor
+		loop_tbench $governor
+		gather_tbench $governor
+	done
+
+	restore_governor
+
+	post_clear_tbench
+}
-- 
2.25.1


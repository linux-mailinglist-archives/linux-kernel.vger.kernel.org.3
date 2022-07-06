Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E97568007
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 09:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbiGFHhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 03:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiGFHhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 03:37:03 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BED922B12;
        Wed,  6 Jul 2022 00:37:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4qN/Ygj/0W/BJggo2zwMoHjLBIduwF1UQaADeexh/0VoPkMsMAywp2RHCz1BToNq+q8lpb01xQCQxtO6WYG54FDlR0S6uhjk8G2CGarvwmH1xRjFhGr0ixphmfP6O9q2dMyg7BkWY4aSXGj6IP70R718nTXZYE3aVXkc98b6nR+oNeODaJdX2GO7GliFZ0OmcnKg9xslhlpcmttABZ0w8d7rW3hCUpKDj+xClNvh8dHd3tSxaBTY3ZHRR9PORxkWqkH83oWVdH3HWgnU+ZSUeFo8bVor4dm0bOOAvJ3lRqS5ZjiDS5RD/Qkk4nxyaFGqqJZg6PbLw+Wu3k+D5qPeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8frwN5BUYDjDSKMjlKCxogQT8IDDj4bmOt/zbxWJSVE=;
 b=C0dZ5Pc52ytZCcHJJP9o/cokl/3d6HlPgWHIk8u72D1nfXRw/GLSAgkqT4CqcC1iwvy2mHWjltCYvOhqDYH+Fr/6u9pcrJJ+7f2NX8RPugyPAmKjSewXeF+PrwEa2m5h2dMd8tsqraf087BN8Mxp/3fw1kpfS67Cml7ry9tGd9UXd7ippxI6Duq7O27d3fRyxbSrlNwhg0e2IZgEo4mxw3nZL66jTxe4V4wz16PshPDKr+jCYxSy5fAxuFNjODDeuIVf7F3LpzHSE2SGHY9b++KM6IT0jKPS44J4nD/xsgNvqBPEinrLTU8u8SvhcHN1h2dZ2wMDHBz2w4wDbO2MfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8frwN5BUYDjDSKMjlKCxogQT8IDDj4bmOt/zbxWJSVE=;
 b=qlJqgBjH1GrmM9PaPvM2WmpxP6zxpU9p1/y/S9Ozo3QZdxTQ4xlb+w8lKeTj7GzvZhLltnhfDCPPrcUgh2PqH5u3qNCcHrVcKZZil1P817kLSWaUhipBv/4D8LJC5ZfzGlrDQW2Kdu2+m8UQQm8IYAvd71y3te0USw51fy62Ohw=
Received: from MW4PR04CA0362.namprd04.prod.outlook.com (2603:10b6:303:81::7)
 by BYAPR12MB4696.namprd12.prod.outlook.com (2603:10b6:a03:9d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Wed, 6 Jul
 2022 07:36:59 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::f8) by MW4PR04CA0362.outlook.office365.com
 (2603:10b6:303:81::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Wed, 6 Jul 2022 07:36:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 07:36:59 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 02:36:54 -0500
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
Subject: [PATCH V1 1/4] selftests: amd-pstate: Modify amd-pstate-ut.sh to basic.sh.
Date:   Wed, 6 Jul 2022 15:36:19 +0800
Message-ID: <20220706073622.672135-2-li.meng@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7fd02a77-258d-4692-425f-08da5f224f66
X-MS-TrafficTypeDiagnostic: BYAPR12MB4696:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /qZjdOQgsaE5MpXJWeOcIMhF4hO9U5DWAROtNhN7odsPt95QUcwUsnx6l6g9oaBnqaILbuRrbrED8KXnXC/QsLj9HINGDZfltvczfwF6CyvPK1U+iAqYnzRda1djWkEG0OsQfMHcXMBla3oPOlNtCK8jEW9FksFdxg5Ys/8m6AscH/VTsBEn/aIcT7ElA2o0lq+dLpx4XQMe5TA0f6ZOuEdpOUBNOoboVzWTng6k1WI1fT+9OOx7Xzxtf2Vx9y7/Pya2LvJFu3ktzej8X+VVYwPW/hPFv0rfAPOL3JimvTFPLH/ZF11voZK44VlmCnzpD8kzwY8mUHD0wgTD7HBxBOP/qX+JxcpdGXHpqvJzbamuIgrMxXmDFOYBfwmjp+VWxwIS8nAkdspxCfPu12NDgEow/gRB3hDuZVB5yYgA7N1yAnChK4cryUg61aivm8T9XIEum6KTSwgHmVKXYmRIHOlxyNvXH6ylkr6Twywg900cKWpcdhlFqNj5MZus6rywnIn6BL1KtAyP/4SQNbB9/kb8Rcf+41gLUjGcA25dvWZw/MOMdkyiSxggvCVQ5SRq9J/cUl+xnfFoNrsGgq94D3FlewDJT96iIbx738875IQDZHEbPDDU1EMAgd7DdICwT8fLXynCZf8YFuHrxQJ6GCpt+f7xAWBkUTuJ1V41uNUXYIPDw1QdfO+oRI/77dWKhU1dFRrEUt6ySDQF2S73sUgZfOi/BatWTtrwYr7hZ7mfkGCN64kf/LlsW+VtBQtbwzPDx9i0d/DjAaLvP4/7BOltX6MQClgvMCzqHhThE+FCpdVqJG8uWmthksc03KxnYMqk9dDRj/8zw6kIjhL/WgK0EjK72brtJqYA+s415DsyvdAJEjGfJrjfvnjjiDrk
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(346002)(396003)(39860400002)(40470700004)(46966006)(36840700001)(36860700001)(40460700003)(110136005)(54906003)(316002)(2616005)(26005)(6666004)(7696005)(1076003)(186003)(16526019)(36756003)(478600001)(34020700004)(2906002)(86362001)(356005)(8936002)(5660300002)(8676002)(4326008)(82310400005)(70586007)(70206006)(41300700001)(426003)(47076005)(336012)(83380400001)(40480700001)(82740400003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 07:36:59.0256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd02a77-258d-4692-425f-08da5f224f66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4696
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify amd-pstate-ut.sh to basic.sh.
The purpose of this modification is to facilitate the subsequent
addition of gitsource, tbench and other tests.

Signed-off-by: Meng Li <li.meng@amd.com>
---
 tools/testing/selftests/amd-pstate/Makefile   |   3 +-
 .../selftests/amd-pstate/amd-pstate-ut.sh     |  55 --------
 tools/testing/selftests/amd-pstate/basic.sh   |  38 +++++
 tools/testing/selftests/amd-pstate/main.sh    | 131 ++++++++++++++++++
 tools/testing/selftests/amd-pstate/run.sh     |  15 ++
 5 files changed, 186 insertions(+), 56 deletions(-)
 delete mode 100755 tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
 create mode 100755 tools/testing/selftests/amd-pstate/basic.sh
 create mode 100755 tools/testing/selftests/amd-pstate/main.sh
 create mode 100755 tools/testing/selftests/amd-pstate/run.sh

diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
index 199867f44b32..167ab51ec290 100644
--- a/tools/testing/selftests/amd-pstate/Makefile
+++ b/tools/testing/selftests/amd-pstate/Makefile
@@ -4,6 +4,7 @@
 # No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
 all:
 
-TEST_PROGS := amd-pstate-ut.sh
+TEST_PROGS := run.sh
+TEST_FILES := main.sh basic.sh
 
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
diff --git a/tools/testing/selftests/amd-pstate/main.sh b/tools/testing/selftests/amd-pstate/main.sh
new file mode 100755
index 000000000000..1c28b5d7b4c5
--- /dev/null
+++ b/tools/testing/selftests/amd-pstate/main.sh
@@ -0,0 +1,131 @@
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
+			\?)
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
+		amd_pstate_all
+		;;
+
+		"basic")
+		amd_pstate_basic
+		;;
+
+		*)
+		echo "Invalid [-f] function type"
+		helpme
+		;;
+	esac
+}
+
+# clear dumps
+pre_clear_dumps()
+{
+	case "$FUNC" in
+		"all")
+		rm -rf $OUTFILE*
+		;;
+
+		"basic")
+		;;
+
+	esac
+}
+
+post_clear_dumps()
+{
+	rm -rf $OUTFILE.log
+}
diff --git a/tools/testing/selftests/amd-pstate/run.sh b/tools/testing/selftests/amd-pstate/run.sh
new file mode 100755
index 000000000000..247e80bfee44
--- /dev/null
+++ b/tools/testing/selftests/amd-pstate/run.sh
@@ -0,0 +1,15 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source main.sh
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


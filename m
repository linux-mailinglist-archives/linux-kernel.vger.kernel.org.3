Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275135302D7
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 13:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344180AbiEVLza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 07:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343855AbiEVLzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 07:55:13 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010DE2CDD0;
        Sun, 22 May 2022 04:55:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IROfwf1SdwVts3jLKw5oWS9FafI/CGBF7j/3k8hx4XQqk6+cNgsxjUZ9PLe+UFBUAODOoQsnQ5emk6uG0YWDRHDA8VjBa6hsbX5pl0JZ6+0WeeufsNh6IcKhpGwgGqbjLuoG2sawc3TydGqf9SCv4dcW7fL6/Y5zkHqSYLt4QBd+ep+7PeKsArH7J5FMQ5KjfTzFdR0WhuQEPXHZx62poPCLBSAjU+T/+36N2CGQMTtcrtHMQDyVDE6Awt852D9yDOdMJVaNcj57eWvZ5tmsFem865DTtt0YI6Yx9YagyHBJpfpfCtJOUp2NjE3vPZzTGQNNozRfvEi8Fue60D8GMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7L4MROqeoaltJjpkJ2a3yrAGFgtSA1wgwNyomYl7Wg=;
 b=jwIbP4ghKwf2RSZXLmFR/mt4jKkQo7UDdzlWRMv0f36bFLkvRDLSrCwpruV96KmyDFVMWbfWEdFf1PAwksddKaBa3sCMTIJUVmPcn/74ALD3V3/cCVds9sGddtffA0hYPN1zStWE8iAwKx8TeTkGVKujDPR0l1cHd5vdGFToczyxbeAENxXsuwWufpZZ8il77T7xK9Ev3xpTryoUM6zgDepU7GNmsuTVc+LXYHU0fbO4wehP4JMUC4PbyqyNBsPDR24zXSnEt0R/JRaqey2YSsO6j0/LeXoMQGLIBztpMm9t9YDuA3Q7kH+C92Sypny5Bli/0nvX9rctyC0tvkEDSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7L4MROqeoaltJjpkJ2a3yrAGFgtSA1wgwNyomYl7Wg=;
 b=lQF8dF/Ff61gdiULgo+uFsufWDqK6L2LNgIDqj3c3DFKTJqg4+lpuX0+QBfi5rVdmLjNDgAHWPylq6lOLhbzF2nS3TfsNYjn+YA57qSdLaFNRItuAOzeKSGlfrBLyZMsK4Dq0aah+lgtOpN/FXOndjpcxhcVnvv28cZKHmlx8a4=
Received: from BN0PR04CA0001.namprd04.prod.outlook.com (2603:10b6:408:ee::6)
 by BN7PR12MB2740.namprd12.prod.outlook.com (2603:10b6:408:23::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19; Sun, 22 May
 2022 11:55:08 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::2e) by BN0PR04CA0001.outlook.office365.com
 (2603:10b6:408:ee::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15 via Frontend
 Transport; Sun, 22 May 2022 11:55:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Sun, 22 May 2022 11:55:08 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 22 May
 2022 06:55:04 -0500
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
Subject: [PATCH V7 3/4] selftests: amd-pstate: Add test trigger for amd-pstate driver
Date:   Sun, 22 May 2022 19:54:22 +0800
Message-ID: <20220522115423.1147282-4-li.meng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220522115423.1147282-1-li.meng@amd.com>
References: <20220522115423.1147282-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f70d7a8a-51cf-4d82-0b9b-08da3be9eb08
X-MS-TrafficTypeDiagnostic: BN7PR12MB2740:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB27403D1CF1AC9EEDBAA21899F7D59@BN7PR12MB2740.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D87cSkroi4HB6dKg3jeKeOT6/LJyDrsc2O/2tTc/jI9J7GDPH8hIslBL9jAACYAEJRwXzIbx5pSezdEo9T332XWE40vfNN8qCnmXyuEgTcr8T7E+BWOzFK5tVx1yoh0z2iZK/PvB6F20F0Mh1tQTH6EV2XC8Xo4i9UhDw+7/XR1Loin90SVmUZg/QKUucqFQ4gezcbA0lkyDFugMtsV6R9Gcj7HLj6dVkrUePD2R4xOQ19ENqMICWMai9b6Bzqed2sVSJ8pOFuG68/ZOlcWdjsHprJFzGE8vF3vA5P31GIhsJ8Er4w00cveATQ6srNQDI0HEuPDXDtK8Y5ITHuPIFu9krQntCPsatSei2WemUUeggWIEKQMRs7p5EidkJcbNjZHJwyepBiXusq+OLPFPNkbKlBq1e83YgVaLfNoQT7XIiMrQETmiuKyneuFs2hUSQ+DOgsihIoCCK9E9Qce51hBjuNY+Vvk3OSAr5lmpGcrMitXoJymHP/gJUL4nMJGKs8j6kNQ4NoccnIxuXyE6F/wPBhvLrMpmxJASSFmRYdKiPhzwQHRKQAVpbfG8aRbjg+WIuLfOUh0/3/7i72yD4ap68aSnktacZeBTnBoEIgrYg+G7Q8DL3SQTq7S92V7VvLuQocRQHgoZC1Jk/F/U7VmLeJc3p2GCS+xx2i9LsP/6IIqCRoCMOhv5y+QxYd6sfw+aXLkmGaMjRw2WH+/cfw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(316002)(4326008)(54906003)(8676002)(70586007)(70206006)(2906002)(336012)(426003)(47076005)(40460700003)(36756003)(110136005)(36860700001)(82310400005)(186003)(16526019)(7696005)(2616005)(6666004)(26005)(5660300002)(508600001)(8936002)(83380400001)(81166007)(86362001)(356005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2022 11:55:08.2157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f70d7a8a-51cf-4d82-0b9b-08da3be9eb08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2740
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add amd-pstate test trigger in kselftest, it will load/unload
amd-pstate-ut module to test some cases etc.

Signed-off-by: Meng Li <li.meng@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
---
 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/amd-pstate/Makefile   |  9 +++
 .../selftests/amd-pstate/amd-pstate-ut.sh     | 55 +++++++++++++++++++
 tools/testing/selftests/amd-pstate/config     |  1 +
 4 files changed, 66 insertions(+)
 create mode 100644 tools/testing/selftests/amd-pstate/Makefile
 create mode 100755 tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
 create mode 100644 tools/testing/selftests/amd-pstate/config

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 2319ec87f53d..975c13368286 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 TARGETS += alsa
+TARGETS += amd-pstate
 TARGETS += arm64
 TARGETS += bpf
 TARGETS += breakpoints
diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
new file mode 100644
index 000000000000..199867f44b32
--- /dev/null
+++ b/tools/testing/selftests/amd-pstate/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Makefile for amd-pstate/ function selftests
+
+# No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
+all:
+
+TEST_PROGS := amd-pstate-ut.sh
+
+include ../lib.mk
diff --git a/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh b/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
new file mode 100755
index 000000000000..273364650285
--- /dev/null
+++ b/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
@@ -0,0 +1,55 @@
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
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+# amd-pstate-ut only run on x86/x86_64 AMD systems.
+ARCH=$(uname -m 2>/dev/null | sed -e 's/i.86/x86/' -e 's/x86_64/x86/')
+VENDOR=$(cat /proc/cpuinfo | grep -m 1 'vendor_id' | awk '{print $NF}')
+
+if ! echo "$ARCH" | grep -q x86; then
+	echo "$0 # Skipped: Test can only run on x86 architectures."
+	exit $ksft_skip
+fi
+
+if ! echo "$VENDOR" | grep -iq amd; then
+	echo "$0 # Skipped: Test can only run on AMD CPU."
+	echo "$0 # Current cpu vendor is $VENDOR."
+	exit $ksft_skip
+fi
+
+scaling_driver=$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_driver)
+if [ "$scaling_driver" != "amd-pstate" ]; then
+	echo "$0 # Skipped: Test can only run on amd-pstate driver."
+	echo "$0 # Current cpufreq scaling drvier is $scaling_driver."
+	exit $ksft_skip
+fi
+
+msg="Skip all tests:"
+if [ ! -w /dev ]; then
+    echo $msg please run this as root >&2
+    exit $ksft_skip
+fi
+
+if ! /sbin/modprobe -q -n amd-pstate-ut; then
+	echo "amd-pstate-ut: module amd-pstate-ut is not found [SKIP]"
+	exit $ksft_skip
+fi
+if /sbin/modprobe -q amd-pstate-ut; then
+	/sbin/modprobe -q -r amd-pstate-ut
+	echo "amd-pstate-ut: ok"
+else
+	echo "amd-pstate-ut: [FAIL]"
+	exit 1
+fi
diff --git a/tools/testing/selftests/amd-pstate/config b/tools/testing/selftests/amd-pstate/config
new file mode 100644
index 000000000000..f43103c9adc4
--- /dev/null
+++ b/tools/testing/selftests/amd-pstate/config
@@ -0,0 +1 @@
+CONFIG_X86_AMD_PSTATE_UT=m
-- 
2.25.1


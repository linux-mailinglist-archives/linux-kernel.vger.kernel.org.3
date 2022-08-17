Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A16C5967DD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 05:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238172AbiHQDtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 23:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238139AbiHQDtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 23:49:35 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1F57B287;
        Tue, 16 Aug 2022 20:49:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWgNU5dASF2EvQxq7xRGQ8bXApNbPCPVVFhOaS28/saJYmjK2L4W/Irr/48OjUmXdWYk2qfR0NRus7Ncp4hETpRmnjY6rrVttKj3rGBp93UFEdRbCo71nV1EtuIA8ycvC08Szt7k/xl4J3MTLqQ77uaH0c3QBfIksJMWUTjKscOXJ1A1AFLfQhR62asKOm1iurxTLGjNapDRei/EjscdZfRuj6W/Ab3tV2tUqFx0WEob1mDs/abp3CMml0hfw1LNPcDl04yje8g8JPFVJgkwZjk55cQYiUBnyPu7z8dR9dowbhB9WMkgAm+3XDDQDtbsQMnFEzyqTqRdYgy6DuGQbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GVszYkIkLFZfnNmhfzhMQaxHfb2cQkoV6KOKw5UxP4=;
 b=d2quR/YpOwRrdM9erep67IErAzp6vS2AOj7cMPKxqCAkwMaoG5+TWU8Idsl9Lr9yP0oYM4ZApufYISm+pXlVJEscc8SoJc3xvsK0Bvmcuah83TupBTVIMbwIHy5LjJADasriq2ZQMkpCfeWyA/FxZgzXzU636U6hhDFXvggK+Qu6XwAykG+yksM/+6gKlywR0wq6aWvw/CP/XVINSnAb91pNFbjS8ub6Dlt6CZtMZNL8wYnbNAZNNrs5gbc89BkFmFTBN2JYmWJd4XkogZxRHpMU+CVKAX/Oenl/UsqDpm7PSnM3jeuOlQ/01d+1X0yYlBrr8twmjgYyramqK24CtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GVszYkIkLFZfnNmhfzhMQaxHfb2cQkoV6KOKw5UxP4=;
 b=LUFZIdH1MlyZdIL1sXrfiplx0evW39HeyJvB5jYNrxN3QWY2Vqp9zvkJLfGRnUbDGsMv25LAtiwJujSMBABC1jNgeLfTl4Btw5MPf3lm1q4zTNX0UfhMPokzPmyuOZWILt/LYh9hUU8gjy0CYfj6vIGUUtMGmZgaIHRWVHAQhr8=
Received: from BN9PR03CA0787.namprd03.prod.outlook.com (2603:10b6:408:13f::12)
 by BY5PR12MB4131.namprd12.prod.outlook.com (2603:10b6:a03:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 17 Aug
 2022 03:49:30 +0000
Received: from BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::56) by BN9PR03CA0787.outlook.office365.com
 (2603:10b6:408:13f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.18 via Frontend
 Transport; Wed, 17 Aug 2022 03:49:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT085.mail.protection.outlook.com (10.13.176.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Wed, 17 Aug 2022 03:49:30 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 16 Aug
 2022 22:48:58 -0500
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
Subject: [RESEND PATCH 3/4] selftests: amd-pstate: Add test trigger for amd-pstate driver
Date:   Wed, 17 Aug 2022 11:46:29 +0800
Message-ID: <20220817034630.1172065-4-li.meng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220817034630.1172065-1-li.meng@amd.com>
References: <20220817034630.1172065-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bfdd9bf-d0cc-4f7d-165d-08da80037d7c
X-MS-TrafficTypeDiagnostic: BY5PR12MB4131:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: spBanXJOLZEu3zm2KEQZHkGA1azhbxMVVBbqFi8z2o3WEtdvOuHXcpYZA3/It13RQsRv1KRzxOKo0HVLfO3PuJLnYoI2/tv89cqGEccwnfEwasEh7TaqGaSz2SDVLFemdZadNRBua1ukC7kvEEnCvn5W9pn7lMENwG6WuXXAIfM2ZCyfOnDS7BQZUQym+QDXDibbls4e4NVZ389L6L1hcPsRLQBSjRclGEpa0y25Rye0I0+iZ/NhQ1aw0Ri1Sunb53MPZeLXzb8QnRudh9qSRKPnN9eIpI492idcDXbgc+gcgEy0VyFIzQncbWCCfWCnZPhXrCwAlisOfnZkC97FPdpGhJoKhLJTCagz51/4ne5q1W7l8d+ZJ2Mp7n0NzRXo986kixtaMedzoUMtWzQWA7lm5uu2W8DEy9eeRGPG+yONnurmP1gF0LpUyueIIfihK7+s1qz13vJK/dlT0v5JE+m2G91PkL28BXllAfc302fLi1MV5/aHChn88m+8VXvOcx6mBlwBNUypmteT1DRoGcpIPgJOuUNERbYNsCYwNQfK+HVGuYSi/stqQ+AfTbQcRZfo6u2f2F1AY+/4KqNSBcymV/W5uB2xLP0wPYQjvfL0uDK32MSm00wIXfCAqriovMMpaHMrMLpHw729YmvPBDtra49ARu9gI3mjS5tdKliYlLAzRsEZr8wmisdEI2yaBQoVMQBp9Xwi5XB1K2T+OCSokbFdZvp+gIktw3aTf/YdsiRwkaJ5ORfX1E42deja5XaFTaGl6hFEKbK3VcuEENWlUE7sS8/dXjSH7IEEjzFq1egn59P0Gy4l5cAxrCfqyD1z2WcB+busf3XUTsvWSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(396003)(346002)(36840700001)(46966006)(40470700004)(336012)(47076005)(54906003)(2616005)(1076003)(40480700001)(6666004)(186003)(86362001)(7696005)(36860700001)(36756003)(26005)(83380400001)(110136005)(40460700003)(82310400005)(316002)(16526019)(4326008)(426003)(41300700001)(70206006)(2906002)(70586007)(478600001)(5660300002)(81166007)(356005)(82740400003)(8676002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 03:49:30.4262
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bfdd9bf-d0cc-4f7d-165d-08da80037d7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4131
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add amd-pstate test trigger in kselftest, it will load/unload
amd-pstate-ut module to test some cases etc.

Signed-off-by: Meng Li <li.meng@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
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
index 10b34bb03bc1..02b4f3477eae 100644
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


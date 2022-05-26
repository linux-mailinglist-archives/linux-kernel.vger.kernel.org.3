Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5766553497E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 05:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344826AbiEZDsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 23:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344087AbiEZDsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 23:48:03 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C01BDA3F;
        Wed, 25 May 2022 20:48:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RShf8IqSuaYwshcbT7OrxSKYr90wP98e3WJ/UNU3fCEIwv4xhKYIqy77/bxqxc4I5CNOqoUKS8x01C+ae0LogaM97JfWZNaY7avfvKTSlDZb1ig+htFxsw1hToGFz40hS1VTR3a3vY7Fgg4QQtpXLmR0fupOnMuv+KXnruM4tqrja1pagajHb/KfSzJ6eYweb0I0HwOnXp8QPf5BJWnTE/NDOfeidoBbDQpVyL2ht6MfcAIPY/PH0nBIFbjGFZeZINanMore+CyEHt/eeJlmr19eoEeeBz+biqhd70gZp2OFXMwr0y7Mk5rFS9QDONHEIlh0m9WH+dudBuWoGJztKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vO5qBZuLSWIOcOBNYZy30RKATGOQ21c106gC7Cwnhj4=;
 b=mVb3wTl5c18FS+kMSeoK2ECaSELLPIsn5mXSi8jW1v7NSUOFB02syOk5SsOq6usNiR9tozc8rvGkFIXKlfyRWaRNeNkq3aAEP3/if1O8zGhjU0ES4LQzeUeTVFMIelwkQNILyVySXgMgfrfg2OSK4W67XyuuVkw5roxhi+qR9IoZgW/4OwEME/l5VpfR/ePIFWp5T9XBBh9UUaiSzwkJ4WyZ/fxSC8eQFIdcVThCYkK7hQykAECF2T8cXoXEjRyaW/man8TepVa8pOMCNC90COwiB5SqyJI4I7dMwJUyiFb71zmhjrJbbn/pveL3iBXHeRTMSkT3qez9XadwoUXn0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vO5qBZuLSWIOcOBNYZy30RKATGOQ21c106gC7Cwnhj4=;
 b=q6qITz5LZYxBiOypxUQP3fFQTpAoxFVezRBpFv8R2rAhA8DRYCXcomYtDeBsFFW6R5QrP7wivZ3GaqE0rAr/WWvfhqFzzNTfqiC7YTfCxw+K0dIUnyRlIQy1h7L9Fe4P29M4At5qBgKUAUSrY6RPhfC/YwGAdQGD0+70blh86Uo=
Received: from MW4P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::25)
 by CY4PR1201MB0119.namprd12.prod.outlook.com (2603:10b6:910:1e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19; Thu, 26 May
 2022 03:47:58 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::8e) by MW4P221CA0020.outlook.office365.com
 (2603:10b6:303:8b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Thu, 26 May 2022 03:47:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Thu, 26 May 2022 03:47:57 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 22:47:53 -0500
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
Subject: [V8 PATCH 3/4] selftests: amd-pstate: Add test trigger for amd-pstate driver
Date:   Thu, 26 May 2022 11:47:24 +0800
Message-ID: <20220526034725.1708916-4-li.meng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220526034725.1708916-1-li.meng@amd.com>
References: <20220526034725.1708916-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01882314-91e4-4d6f-935b-08da3eca8600
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0119:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0119E748E4D3EA0B0DCBE572F7D99@CY4PR1201MB0119.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +njGOcR/BCm0Q7BtFbDopYPl4IVRiX78f8PyU3cX/0JF3A3Rhy05/Pef3FSrH1rbnIKqEkoIJwRwNbCVko6PHiNZMqicpwh0mZQP2tF6KCs7Qcg4XWjJ4WMEBsV78Q7rC6h7+8grDLtySd8B2qX5BmBWbJfcl9Y/ZAkqDJne4Lmwz7a9It5EKhwjm6LhBioi4HcLJdy/LGvZwwG0N/boKqV4CT4tpH2O3p/Br3wjBrfbLoOYBduyqpzrzQwp3hBjF2IbuGmKkn0H3omMZBuZOFm70ArdxaTkiurDnRGHBiQjG/xWNIKLbT4aeHjrIJRIdvoMjLzSFLk+j9230rOGeqatnKldNyfT8Cc+1v1yoX8Ka8DjKS8Z1rcwhs3Nn3LnfytnEpnz4XHJeWOHRDp/otlOMh4oQmxKdhZqMY3PasLW9NQHp5xC+ziQp9IHm8RtpksK/Au0L7DLRKWIGluaf2zV664nxIfOs8nvSQ1/UpVHiwFLnj/hmYHNqsxrAf3Kj1mqJ2OzbUJYq3HlbkvHOKSwmDpkpJElPQSDzs/yc3DgiFGJ8K6Q/BuhLVWGPeRUISIGW8z5fBYBySOoeI2ZBDsm3wu4azqEboDf4Gxlflno4FnnY/ouo/CdOc4ft9TMM2v0K+PanfzUn2lzT1EdBgW05NAFixov8axAboD6i2CygRN6YLsqhY7tnPSVRxVhLBf+a/yD8lA5LaPzPiL2vA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(83380400001)(47076005)(186003)(16526019)(82310400005)(336012)(70206006)(426003)(81166007)(1076003)(36860700001)(36756003)(7696005)(6666004)(356005)(110136005)(54906003)(70586007)(40460700003)(508600001)(316002)(2906002)(2616005)(4326008)(8676002)(5660300002)(26005)(8936002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 03:47:57.6972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01882314-91e4-4d6f-935b-08da3eca8600
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0119
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


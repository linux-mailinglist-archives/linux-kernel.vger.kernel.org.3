Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D71052120B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239722AbiEJKX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239549AbiEJKX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:23:56 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2086.outbound.protection.outlook.com [40.107.100.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17EA2AACD1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:19:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LohGFeR7M9fC4zUYlsyYjNQY/LV8ItPihPYE0nQwrcQ9WC5wyJEVs+z0djxJ7ru5YaJ2ZNkdG15nEPwkcr5NkpUgW+TykuHZL6VdZyU8xpMQKlDpVV71o1KDWrZiUZDqkL1mtwqKxhDbxI1wHFYvbgSO1pXJmlWF6VDLACL4bnUW8uESQASI3G+/VZ6eW9oCpOqtMmviIbgXktCOhL1nNgw26TVP+yIowaSnhp1ygDBi9i/AnFpIa31pz33cmnYRER8/bvZ/N97R+GSkO86HMBEDepc54pO/pSbfZbmtcD+rv1uuCAUYL2zOtirtfpHZI+zouAT7B42E99N3lcnnrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxMrkkKmYkVYNuoNzY5fLLB1875LQSIak2HCgqOdsc4=;
 b=RuirsyU3vRAxgoH6W/eJwDKlquKuJVREnua7HboAg6666/iZXLEJR2PqQY5fxnsPH5bHCr6ZMcryuEyn1MDKH81Ecjm+sSNR54Rsw98MFSOf4ES4BzNuRsRMsj6wbIR+xgy1MygoJlR5CRj6fUHoARpmimgxt7Kq/yh+dbYmvcY0aScG+e7WgIvjSPayROVH+9LYPQ3Q0GeuCvMtEVDCz7JWOhJtxO3NfFnv+PxPYo4IXMwmWbgSulCz5bjJN1X35t55LQ7kHNXyKzYxdEEBrGBwjGb0hb88vYbVZDUhKT7BDTFsIrsI+hx50YG3eN3HXlzby62mAQzSOLjlHHX1Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxMrkkKmYkVYNuoNzY5fLLB1875LQSIak2HCgqOdsc4=;
 b=L6yh/EGrI7cWS/KAvmi2u7R9UT7d+JjYwUKFN3dSJ7UhUbnUb9CIhZo9GAgyB7moLOwulX82yaP6CAUmQymE4A68Eb72KraQSc9+zXON3TN5h6RpC+A85OkXvNx49jVLe+DEea1Daic9DAoumO4UWc/V4DsXLpx0zrL0OgbuEeA=
Received: from DS7PR06CA0020.namprd06.prod.outlook.com (2603:10b6:8:2a::21) by
 BN6PR12MB1329.namprd12.prod.outlook.com (2603:10b6:404:19::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.21; Tue, 10 May 2022 10:19:50 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::f2) by DS7PR06CA0020.outlook.office365.com
 (2603:10b6:8:2a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Tue, 10 May 2022 10:19:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 10:19:50 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 05:19:42 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <Lewis.Carroll@amd.com>, <Mario.Limonciello@amd.com>,
        <gautham.shenoy@amd.com>, <Ananth.Narayan@amd.com>,
        <bharata@amd.com>, <len.brown@intel.com>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        <peterz@infradead.org>, <chang.seok.bae@intel.com>,
        <keescook@chromium.org>, <metze@samba.org>,
        <zhengqi.arch@bytedance.com>, <mark.rutland@arm.com>,
        <puwen@hygon.cn>, <rafael.j.wysocki@intel.com>,
        <andrew.cooper3@citrix.com>, <jing2.liu@intel.com>,
        <jmattson@google.com>, <pawan.kumar.gupta@linux.intel.com>
Subject: [PATCH v3 2/3] x86: Remove vendor checks from prefer_mwait_c1_over_halt
Date:   Tue, 10 May 2022 15:48:07 +0530
Message-ID: <cb388b0f7893a10f3808b0d963fb209c9127a6f6.1652176835.git-series.wyes.karny@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.fba143c82098dffab6bbf0a2f3c4be8bae07ccf1.1652176835.git-series.wyes.karny@amd.com>
References: <cover.fba143c82098dffab6bbf0a2f3c4be8bae07ccf1.1652176835.git-series.wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab163c75-b78c-4e0d-e277-08da326e9e00
X-MS-TrafficTypeDiagnostic: BN6PR12MB1329:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1329C6D9DF8A7FC9C7AFA0A084C99@BN6PR12MB1329.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w1nUflbnFaFslvN61w6O0YMagCQ48JccTsJpa4xAT/8AL42OHXz9UseKNz1gKFnjuowzScFQL9heGuXzW3qZidOV+n5dWjO0MYPLNxNtBobCGAz0RFcNspeuCM3WY9hAD+bYNajdc8LlpaWJpCozwQYUT0w3WWnCO7KyJrjdV6a8Uz4ehE0RBcMBfGDLwvSfpc/t99ZsBv/8q9dZSVeoi19QG4qs7a8iIB/HhnJsAu4AT6vnlVybGp1ooO4fcxEp3OFYej0Q35+LtHdeXHmmi/5zNKteEJrzLhk3ussX+SxKXpYGFcJhaO1RljsLCBhttkcRHB/2eppWPknNrezq19VSWQp0yvGAzYSI0aHxdhEtSjfAO2fbaBOK4G0Cx9UedBF4NipfY5q0yi+V3sx7PDVxGjLyjl8i1rDtTK0UCnznqFum8XWlg50eYYV3pTYmp3ovaM+8SB2jzMfff11JsRcqKMB45p/yD2YmoeA+ic0fH8LFc0DLr4dGHd42/hqyPIhc0GiIqP/508ZFgfbLt+6fLCm2/OGl9R4z9ofsyduSdl+ujgSGz1eChtDzGv76aPlZmD38xD+rhT6J69PEhXaC0HqoCxAa0EI5dl7x3ahyKfUq4Sb23KO77XgECLq9wdpOqcb3SXmNMm28v/T9GLfOQJM0AxctghZ7+C7b/ewGc09m54M/dxRPv4BEn5dyJMoOeteV15wfrOAW/JNhUdnJC3n4FStJ/bAkoRk4yzizNvCU6VrYaoD6efKRemYLx5AXvIyZZ86+UVq/DqtWZrKp757HLHcMDsPfIakTCuc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2906002)(8676002)(508600001)(44832011)(36756003)(36860700001)(186003)(5660300002)(70586007)(16526019)(336012)(82310400005)(426003)(40460700003)(7416002)(47076005)(83380400001)(966005)(2616005)(316002)(8936002)(54906003)(70206006)(4326008)(6916009)(86362001)(81166007)(26005)(7696005)(356005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 10:19:50.3746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab163c75-b78c-4e0d-e277-08da326e9e00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1329
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove vendor checks from prefer_mwait_c1_over_halt function. Restore
the decision tree to support MWAIT C1 as the default idle state based on
CPUID checks as done by Thomas Gleixner in
commit 09fd4b4ef5bc ("x86: use cpuid to check MWAIT support for C1")

The decision tree is removed in
commit 69fb3676df33 ("x86 idle: remove mwait_idle() and "idle=mwait" cmdline param")

Prefer MWAIT when the following conditions are satisfied:
    1. CPUID_Fn00000001_ECX [Monitor] should be set
    2. CPUID_Fn00000005 should be supported
    3. If CPUID_Fn00000005_ECX [EMX] is set then there should be
       at least one C1 substate available, indicated by
       CPUID_Fn00000005_EDX [MWaitC1SubStates] bits.

Otherwise use HLT for default_idle function.

HPC customers who want to optimize for lower latency are known to
disable Global C-States in the BIOS. In fact, some vendors allow
choosing a BIOS 'performance' profile which explicitly disables
C-States.  In this scenario, the cpuidle driver will not be loaded and
the kernel will continue with the default idle state chosen at boot
time. On AMD systems currently the default idle state is HLT which has
a higher exit latency compared to MWAIT.

The reason for the choice of HLT over MWAIT on AMD systems is:

1. Families prior to 10h didn't support MWAIT
2. Families 10h-15h supported MWAIT, but not MWAIT C1. Hence it was
   preferable to use HLT as the default state on these systems.

However, AMD Family 17h onwards supports MWAIT as well as MWAIT C1. And
it is preferable to use MWAIT as the default idle state on these
systems, as it has lower exit latencies.

The below table represents the exit latency for HLT and MWAIT on AMD
Zen 3 system. Exit latency is measured by issuing a wakeup (IPI) to
other CPU and measuring how many clock cycles it took to wakeup.  Each
iteration measures 10K wakeups by pinning source and destination.

HLT:

25.0000th percentile  :      1900 ns
50.0000th percentile  :      2000 ns
75.0000th percentile  :      2300 ns
90.0000th percentile  :      2500 ns
95.0000th percentile  :      2600 ns
99.0000th percentile  :      2800 ns
99.5000th percentile  :      3000 ns
99.9000th percentile  :      3400 ns
99.9500th percentile  :      3600 ns
99.9900th percentile  :      5900 ns
  Min latency         :      1700 ns
  Max latency         :      5900 ns
Total Samples      9999

MWAIT:

25.0000th percentile  :      1400 ns
50.0000th percentile  :      1500 ns
75.0000th percentile  :      1700 ns
90.0000th percentile  :      1800 ns
95.0000th percentile  :      1900 ns
99.0000th percentile  :      2300 ns
99.5000th percentile  :      2500 ns
99.9000th percentile  :      3200 ns
99.9500th percentile  :      3500 ns
99.9900th percentile  :      4600 ns
  Min latency         :      1200 ns
  Max latency         :      4600 ns
Total Samples      9997

Improvement (99th percentile): 21.74%

Below is another result for context_switch2 micro-benchmark, which
brings out the impact of improved wakeup latency through increased
context-switches per second.

Link: https://ozlabs.org/~anton/junkcode/context_switch2.c

with HLT:
-------------------------------
50.0000th percentile  :  190184
75.0000th percentile  :  191032
90.0000th percentile  :  192314
95.0000th percentile  :  192520
99.0000th percentile  :  192844
MIN  :  190148
MAX  :  192852

with MWAIT:
-------------------------------
50.0000th percentile  :  277444
75.0000th percentile  :  278268
90.0000th percentile  :  278888
95.0000th percentile  :  279164
99.0000th percentile  :  280504
MIN  :  273278
MAX  :  281410

Improvement(99th percentile): ~ 45.46%

Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
Changes in v3:
- Remove unnecessary CPUID level check

 arch/x86/include/asm/mwait.h |  1 +
 arch/x86/kernel/process.c    | 35 +++++++++++++++++++++++++----------
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index 29dd27b5a339..3a8fdf881313 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -13,6 +13,7 @@
 #define MWAIT_SUBSTATE_SIZE		4
 #define MWAIT_HINT2CSTATE(hint)		(((hint) >> MWAIT_SUBSTATE_SIZE) & MWAIT_CSTATE_MASK)
 #define MWAIT_HINT2SUBSTATE(hint)	((hint) & MWAIT_CSTATE_MASK)
+#define MWAIT_C1_SUBSTATE_MASK  0xf0
 
 #define CPUID_MWAIT_LEAF		5
 #define CPUID5_ECX_EXTENSIONS_SUPPORTED 0x1
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 49b915d1b7b4..e26c63615931 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -813,28 +813,43 @@ static void amd_e400_idle(void)
 }
 
 /*
- * Intel Core2 and older machines prefer MWAIT over HALT for C1.
- * We can't rely on cpuidle installing MWAIT, because it will not load
- * on systems that support only C1 -- so the boot default must be MWAIT.
+ * Prefer MWAIT over HALT if MWAIT is supported, MWAIT_CPUID leaf
+ * exists and whenever MONITOR/MWAIT extensions are present there is at
+ * least one C1 substate.
  *
- * Some AMD machines are the opposite, they depend on using HALT.
- *
- * So for default C1, which is used during boot until cpuidle loads,
- * use MWAIT-C1 on Intel HW that has it, else use HALT.
+ * Do not prefer MWAIT if MONITOR instruction has a bug or idle=nomwait
+ * is passed to kernel commandline parameter.
  */
 static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
 {
+	u32 eax, ebx, ecx, edx;
+
 	/* User has disallowed the use of MWAIT. Fallback to HALT */
 	if (boot_option_idle_override == IDLE_NOMWAIT)
 		return 0;
 
-	if (c->x86_vendor != X86_VENDOR_INTEL)
+	/* MWAIT is not supported on this platform. Fallback to HALT */
+	if (!cpu_has(c, X86_FEATURE_MWAIT))
 		return 0;
 
-	if (!cpu_has(c, X86_FEATURE_MWAIT) || boot_cpu_has_bug(X86_BUG_MONITOR))
+	/* Monitor has a bug. Fallback to HALT */
+	if (boot_cpu_has_bug(X86_BUG_MONITOR))
 		return 0;
 
-	return 1;
+	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);
+
+	/*
+	 * If MWAIT extensions are not available, it is safe to use MWAIT
+	 * with EAX=0, ECX=0.
+	 */
+	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED))
+		return 1;
+
+	/*
+	 * If MWAIT extensions are available, there should be least one
+	 * MWAIT C1 substate present.
+	 */
+	return (edx & MWAIT_C1_SUBSTATE_MASK);
 }
 
 /*
-- 
git-series 0.9.1

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C446553ED86
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 20:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbiFFSFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 14:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiFFSFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 14:05:04 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88AD244086
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 11:04:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEkYbSGgGLjRFe6COhpo6JuTVu6W7Q5cTEmzZVy1y25xBaX5tfzU7X+bJHTVtaq5U3kqruSG3yVd7r3a86q7fmuz/0PNifF3crEfcx6a7+/COxuH4Z7rJgNog8OPTNeYY3/6O0yXnSwAyUM4cKmxnXEYt/2nzZrwI2V3P8J+t//fi97UrKMpyTbbQHoKSfoXJQ6Pk656rqOPo444UkcZtJMqMBRreIfD/BQKAM904foq/gSqf2RKclgl1TB+gbbExJZGkD5OddAiAyxhb3WHDf7fuPdiubTuhZtzsa72lFdKIynF9J4xhK1ZLn5rnH8HqhISm7ePz0QlhQnzs9UOyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/QaQ5aJq9uoMNg9bZZygsCN5JeJp3V0Y0ttIlIW2Hs=;
 b=MyB6tSFEAhQGsXxA4uSKB+7aJJ923yalSl6MY4QvHjT4GhMuXOEYxpphCzwYqtbuZFNgr9Di2oB4GLun9P1v2r8UVFTqWyDIHfzm2hPzeWD10qJJBzptrAbie8jncsksdmW1gkjPkWKosXj6+HuxY/IKXLuZ5tTWEMUODgFVucAT97tTv17BzfzvFpfqig6rdSolDRw1Bg/QLf9i5WqFwoDu7Q/daYyIT43EaxK/+aFXLLWulrsWdNlmrg+TbpoC4vKIry92XEObhZJ2cFLvTGEr/SnBIyblbh+6IVEptbVHOPmf1mMqhlAYlXuVLFBiNW8cXiA7T0M+tilDhPzzmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/QaQ5aJq9uoMNg9bZZygsCN5JeJp3V0Y0ttIlIW2Hs=;
 b=dXUVCJfk0Nw6AUObcnk9R4JU9Ev5Pdtq3zHYA14I+74OJ94CTS1L3uMiFRiIDXCVNlR/CGtPeSVvyZ6IcyPZfzE/l/IxkTukJbuRA7KpZgkxsqmd72D0Np8O7Xqf1lV8jGofTV67/cNbZTl81ct+m8iUV5H4TwN6UmiZIMulV9Y=
Received: from MWHPR15CA0030.namprd15.prod.outlook.com (2603:10b6:300:ad::16)
 by DM6PR12MB4122.namprd12.prod.outlook.com (2603:10b6:5:214::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Mon, 6 Jun
 2022 18:04:51 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::49) by MWHPR15CA0030.outlook.office365.com
 (2603:10b6:300:ad::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19 via Frontend
 Transport; Mon, 6 Jun 2022 18:04:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Mon, 6 Jun 2022 18:04:51 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 6 Jun
 2022 13:04:42 -0500
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
        <rui.zhang@intel.com>, <puwen@hygon.cn>,
        <rafael.j.wysocki@intel.com>, <andrew.cooper3@citrix.com>,
        <jing2.liu@intel.com>, <jmattson@google.com>,
        <pawan.kumar.gupta@linux.intel.com>
Subject: [PATCH v5 2/3] x86: Remove vendor checks from prefer_mwait_c1_over_halt
Date:   Mon, 6 Jun 2022 23:33:35 +0530
Message-ID: <0cc675d8fd1f55e41b510e10abf2e21b6e9803d5.1654538381.git-series.wyes.karny@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.12ae0052320eae3574e421a17822624143a4bc61.1654538381.git-series.wyes.karny@amd.com>
References: <cover.12ae0052320eae3574e421a17822624143a4bc61.1654538381.git-series.wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37e52b0c-b2e1-4a4c-c8e3-08da47e70d7b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4122:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB41225231898C217B45156DFA84A29@DM6PR12MB4122.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A73iRjTXje5EqleLJIZhs2fBe77ycpJASnsoxO+Hm+FVKxcwy4Ezy97lYrYE+71sNV/u4snM8CPqioJH2LUFdGHtGKf4pDDMx4GtFaByd2Ivo1dRPifNIWkHlGiupSmeTDYxiJZmy7KNc/T9IgW8JU6U0nUi0jLysuWaHRxIgI/Rm40vKndWoqzMVHbw3QUg9SCwyrn2OOPyV9UlqW1gz/KzM+AnEeMfUb1S3/RyoR9Xsif5Ip2U5LzSA8DMTr3LwgzvNYWIR38Sn9YaHM9LeXMzL/m+cFY3XbxExW/HIv2FvtsUeMx+bB89WEORLIHlh0hCVYlmznbGNsz5kYCjOxjSk09nAZIEGgtvwZ2XcxOkAnUQXvEv8p2JXj0C+WAhwxfvlmAG2IeWBeL+MFvexEQ+Fps+q9VSjlRGhDzhrEOfH5ZLD1ACFtcrZS02e9xo3bOVYYKme4w4LSOPOoE7/INOu9LIjYumlVJRHlBrJorIr8plZx7M7vLT/op7QeBBqQA8bxV71U0258gg5DPzIn63rh2Mxmuh0kzBDaK6iRl80BWE9sPfu8SHI0RSuc581zjyIBq8fGFdClx71+OBjGqwMV0oQIZWb37YZUhHNuOiRzrqKg7DUKK8ELhHWOo1EUOlpPA5QqX7tJlzkuAFRbuWw4ku7D38VPryhUpy28gO+dbh2r7i5ApGnAhod3JuTJ7MUcE052lfOFstgF0YAdsekqXL6njmqyFMvnldISYmUN3pMAV4rbYw7S+UKv9hrWSTLBaov0GATTwNVMu18qdngGRaNb78B0Lqgs19uVo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36860700001)(316002)(82310400005)(16526019)(54906003)(4326008)(8676002)(7696005)(2906002)(70586007)(6916009)(86362001)(70206006)(81166007)(36756003)(7416002)(8936002)(40460700003)(83380400001)(26005)(2616005)(5660300002)(426003)(186003)(336012)(44832011)(47076005)(356005)(508600001)(966005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 18:04:51.3861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e52b0c-b2e1-4a4c-c8e3-08da47e70d7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4122
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Zhang Rui <rui.zhang@intel.com>
---
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
index 5cd30eedd33c..5d627f8e5e79 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -810,28 +810,43 @@ static void amd_e400_idle(void)
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
+	 * If MWAIT extensions are available, there should be at least one
+	 * MWAIT C1 substate present.
+	 */
+	return (edx & MWAIT_C1_SUBSTATE_MASK);
 }
 
 /*
-- 
git-series 0.9.1

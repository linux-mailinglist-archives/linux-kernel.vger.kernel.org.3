Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB6B5318B4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238975AbiEWQ5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238995AbiEWQ52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:57:28 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC8E3A73A
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:57:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DnoJzB7A7GlFZHBzR6VLpvEVKw5Ta2yS/CdyfZLn5pBSY7EdzIWr6RMeK0aL8q+4AuirtyP8WVXBDbPZOIBzs6yoL0wVgtJJ9ieZL0dHMRmSAhHlG48i81plJAna+anDdq7CFqqT3MgFycsaXapu8ybY6aPJgoE58OAiG39uJfqu6JHM3TJY81F1qZqn60/06InE7zVIMFGyMBVGwZWfwb7ewkG8SRpq8uPVhLRD7lNUnUZO5WnXjOdjXZw8OLj1NIZV7iJbEP1DR7vSDez7jVZUVOa0l/R5GwdWz0fZEzizQupPG1SLjpmZAhYAxeWkNmTsSkamVkbMISwvrkthlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMkL3k0mrcLFU/tZgCF4rvgJB3p1BX+kc3188X0yQDc=;
 b=nyERQ+kCoIWrdAedIPh+oBCFWC0wdEhftk/Y1W4F8VDsQWhPR4oPID5tbemDhWvsWbPT0gxv8IUEYasOxxKQKzLry3Veov0swPrXQ4kNwiyztP34J/kbZkk7xahHmr+LjpH4CrIWiVW42Lp2J9L1y2lxX4eB9ezI2ztaGMUyB/nlZJnSwran1fZlUb2cbTS1bRVl9tCV533vwJJxiTzImApBC06YpRiMbgFS6l41EDvsuAHxG9wAJeOo0cxx7Eq4iv5bpmUuoZd222/9qRXwpSLpby2D8s0ALvrdFhpmY/U7VEk4SMEOc1PdkX39hLW2HjvQHbHN183BAZ9Iq/rMQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMkL3k0mrcLFU/tZgCF4rvgJB3p1BX+kc3188X0yQDc=;
 b=CiUO6FGMvC+UVu5+rdkKy4RWjBYCpAUhXwn1PjtHdp+OMCbV4biMMJO5lliXQcx1ylDjpMbHmmMz10uoGT9yWoRmfC/BhQ/808BWaRMlmv5uQl3c8ASPLi+G8ckbTPIC3uhuZpFoSbkrALhVPDNMWZZHpoOmrnbp4S+srLkVx5Q=
Received: from DS7P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::7) by
 BYAPR12MB2776.namprd12.prod.outlook.com (2603:10b6:a03:67::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.18; Mon, 23 May 2022 16:57:09 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::9c) by DS7P222CA0001.outlook.office365.com
 (2603:10b6:8:2e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14 via Frontend
 Transport; Mon, 23 May 2022 16:57:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Mon, 23 May 2022 16:57:08 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 23 May
 2022 11:57:01 -0500
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
Subject: [PATCH v4 2/3] x86: Remove vendor checks from prefer_mwait_c1_over_halt
Date:   Mon, 23 May 2022 22:25:50 +0530
Message-ID: <67ca737f7cdabfc75f930cf59b49d910d8c491d6.1653324016.git-series.wyes.karny@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.7d2ba81d1918bbfd8ae5e6774db8da0502f7ed67.1653324016.git-series.wyes.karny@amd.com>
References: <cover.7d2ba81d1918bbfd8ae5e6774db8da0502f7ed67.1653324016.git-series.wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7489bd2-7ef5-48e0-c8b1-08da3cdd4637
X-MS-TrafficTypeDiagnostic: BYAPR12MB2776:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB27767D5A980FBDC55257193C84D49@BYAPR12MB2776.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tytP99oKbLi0gy9ElxqYgDifkJ2748Su9AWo77D6TWvGWmNDDqBIfMDIgnAuxelWINZs9JekPQkB5mTE7wnSk1sjWTy0dETZwneKJeWRjZGG6cHbAhzE8z9KZ8oxa2AxDHTv/bfFe/VS2j7DoVoeEyAlyzzwlhro0dCRG8deSaaDEifZL/uFy5z/QxO9XP3PR8vwQS2PVcVMKWdalgOL1CFZ5dsyDoNhMGMCj+YtcTMaYc1dPsXf2ekyUlJd3VY8neLfy92a0TlB4qDgWaFBSvqOXryCw62HY7vtWGYV/cDfyg8Y0GXuoZ2htpfEi7fIMM04AYXaQ3I5LQJ3lk5/pixbPOlu0Wi4EpDLsjK56fcVFNRFRc8wBLlc5BvZlFoTxnNtZrtr3PHFtJX+JC22/9sJ5250PpMwbTfwysV7jGs6ujjjIk1gB3gFZx6lwZ7oA//4gkxrLe1YRtAGk1CZ5po2L7Nt6IltHqZAoAiflPwMo9ee9zWDHFCjTOpvYLnEHNp5hRdP8roroNaba+I+fg46YdT6qzgzQMXo4LOtH1iCT9UmsOIxTJF3aWJxGoJwLaW47B4zLCyN24/dhoHsbwPVdtvTlsbFwMCKZUka6J+a7FzFceM5fH25Gyj6eD5jf+vnzYAgQDyBQ0VUeVXxfmkFUBsOBLLDa+r1qSp69hOZ+xk5UvU5zZknbOHb7Jv0Condeg5NZ3mPIxnVsve03zqTyY+S9WvA34r3KP5D1+WIMCmgPhbiVDxoc9ZP6MKIEX6ee4Yhb5dEyhwNJ36A4babGEjyE/jW/3mVY48mViI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2616005)(40460700003)(83380400001)(6666004)(86362001)(186003)(16526019)(26005)(316002)(36756003)(82310400005)(54906003)(36860700001)(8676002)(70586007)(70206006)(7696005)(4326008)(6916009)(2906002)(356005)(966005)(7416002)(44832011)(426003)(336012)(47076005)(8936002)(508600001)(5660300002)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 16:57:08.8752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7489bd2-7ef5-48e0-c8b1-08da3cdd4637
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2776
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
index 4e0178b066c5..7bf4d73c9522 100644
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
+	 * If MWAIT extensions are available, there should be at least one
+	 * MWAIT C1 substate present.
+	 */
+	return (edx & MWAIT_C1_SUBSTATE_MASK);
 }
 
 /*
-- 
git-series 0.9.1

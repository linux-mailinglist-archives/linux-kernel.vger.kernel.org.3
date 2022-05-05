Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D69651BDA2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 13:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356382AbiEELGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 07:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353619AbiEELF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 07:05:56 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155EB47AEA
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 04:02:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfI6azV6tFab0NIyhv9QZPNrVmO+n2xzllGSNtJFUzth18COW1KW+pIl/M5YCw6vtQTIQBy6RSZYF34u3td4i8QZOSqfjhlVzkSGjthTU1ZYbfQcA+mDZoUO1CTsFm5YTGW8UCpznfLCqAv4W81nvY6JHsJo7Eoq0JcejMbX7U6ChUBCFrbLqK321C5hY96NY9Yxfm0U5CQ9FCGYCZ3QsgrkVVSdkTJwfGJAXNjxh7h9ceNGSjoG20S0kfoSX3Md5Pmi97hv623y+6Qa0N60kllcMJT587lzJRE3BX2BpNpxcfgZF7xiwdltYuKhoaYU2ftXcFEHC0zrEsL6znGOXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eC2sxYrPBTpB/+fRb5eeV8DiJ749EI/ZradDxvKG3AI=;
 b=i7gfzdW/Un+t997lTmTYCsXxm0ZV1bmR6Q68gfGcDy/S0dCr7Zbx79qoVF+XoRB7ILEm4ET+Scb0H3iHKywCo3MHYc1YQWPolaOJrbFu7fImGqgb/wi24quStkoYV1InYa6pRbZrTLaTVz1ZABxtdGdXNhtFBWQyndj7m0ftPWe/2Ui0L9EcPbMUPuOI2rGt8Z9QvFsOV88E4KiWUdX95dATqCQ6ATox7V/5FPXVVAf5cX5PSaFtx022jds+/dlZIR7H6Z5YgX+PJqry/B/aJ7wzpsM5WXKPC05Dt5ZYeRkj1rkwrAx7ijzFBnd9SyXjbQLnG84xI03u1oYNKbkF8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eC2sxYrPBTpB/+fRb5eeV8DiJ749EI/ZradDxvKG3AI=;
 b=RY5vw1nx7tWNOJy2XYoRuqquDQtrRqxspTY7/tKthcyTBnMlwG4ybX9DuCFSmY7zc2xileoWw2PyBYNwmUA3x+nEshxvxRN4oqTVz4i3JDJAgWNrIebdnHqfCs6zPwi+WWqqZNWvoUBp23P1PRPEab0UUDgVWpzfPWjNKQev0Ao=
Received: from DM5PR21CA0032.namprd21.prod.outlook.com (2603:10b6:3:ed::18) by
 MW3PR12MB4443.namprd12.prod.outlook.com (2603:10b6:303:2d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Thu, 5 May 2022 11:02:05 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ed:cafe::82) by DM5PR21CA0032.outlook.office365.com
 (2603:10b6:3:ed::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.8 via Frontend
 Transport; Thu, 5 May 2022 11:02:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 11:02:04 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 06:01:57 -0500
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
Subject: [PATCH v2 2/3] x86: Remove vendor checks from prefer_mwait_c1_over_halt
Date:   Thu, 5 May 2022 16:31:40 +0530
Message-ID: <20220505110140.453184-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220505104856.452311-1-wyes.karny@amd.com>
References: <20220505104856.452311-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9f530d1-41d7-4e67-98f0-08da2e86b092
X-MS-TrafficTypeDiagnostic: MW3PR12MB4443:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB44433CD472E1DD1A9C2D096084C29@MW3PR12MB4443.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kWhzYkJnx5R4OqoSeLuJuOaiyVgAE+yjKM7vSaz+xYIOCUaWn6GR7C+IKnaRg7nWDf5TdTV6bruYi/wcBviPi99+N2uy0a2zxtB0betUogE5ds3iZjVlsJedUampOraKr2xbe2AL4jBranSXTuUYcGBoDSy+11dy7w+OM6uxF/miRxgTX+AQO1jy4vJBSSMiYFrPPRRjygcZwCtg4El8i0z9oZ6WCCDjuzRm7xeT2vUWHqFrf3COzyDDyfpxEvdRQDmSKIA+TrQfoxnb7OZ7bbUkwm38SRN0Mf3oJ3ynnp/70WE9Zmss6YT3OzF3vux5ZCTSwTE4mlZOzWBWT/EpXKp9aXwXU4h2eUpzX7ZHVv34jTUNgVTFBNIeeYdUlgCzxP7rurSNKUAoUaYO+xUHxzi6Ih14Lj3XhuyJlT2r/TId6L4XGMI/xtFgeZNz/paUrH07eD7gM8H9dv6XFwdMgWjK+ra+JJTrpzQUx75SJrhxz19Xkk0pQjEStlY3fHx/FqEEesvPEgyYYTMRGjbZ+JW3Ig10ExnEnQ91W2gPCdLr7H/DxOeCl45hvS4S43jHrRvMUT72ePADULjoBxdfUpRYRQe1j6loUqbVzDUHu5q6Fw9xOUkKhhGr1IMPE8HgOoK7FPgtAWpr3ZNzyXHLJQncresuwJiUxVNETezK1bld4JVvxYTPRwsoFbS3ejbusHaf96BEls/WPkWMa8wA/5XVkgvKiCStZGbg/W2igiOSXuxnqzMXntJjevv9/qZ9W2Gym9WD+h9N0znYsQQ8GiY+pDpqanuYISbAG9Llf8c=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(81166007)(7696005)(356005)(6666004)(2906002)(36756003)(8676002)(966005)(26005)(40460700003)(508600001)(70586007)(4326008)(70206006)(82310400005)(5660300002)(86362001)(316002)(8936002)(36860700001)(47076005)(336012)(16526019)(426003)(186003)(44832011)(7416002)(83380400001)(6916009)(54906003)(2616005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 11:02:04.8614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f530d1-41d7-4e67-98f0-08da2e86b092
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4443
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove vendor checks form prefer_mwait_c1_over_halt function.
Based on CPUID give preference to MWAIT C1.

Restore the decision tree to support MWAIT as the default idle state
based on CPUID checks as done by Thomas Gleixner in an earlier patch:
commit 09fd4b4ef5bc ("x86: use cpuid to check MWAIT support for C1")

The commit which removed the decision tree is:
commit 69fb3676df33 ("x86 idle: remove mwait_idle() and "idle=mwait" cmdline param")

Below conditions clearly say that is MWAIT is preferred or not:
    1. CPUID_Fn00000001_ECX [Monitor] should be set
    2. CPUID_Fn00000005 should be supported
    3. If CPUID_Fn00000005_ECX [EMX] is set then there should be
       at least one C1 substate available, indicated by
       CPUID_Fn00000005_EDX [MWaitC1SubStates] bits.

Otherwise use HALT for default_idle function.

HPC customers who want to optimize for lower latency are known to
disable Global C-States in the BIOS. In this scenario, the cpuidle driver
will not be loaded and the kernel will continue with the default idle state
chosen at boot time. On AMD systems currently the default idle state
is HALT which has a higher exit latency compared to MWAIT.

The reason for this is

1. Families prior to 10h didn't support MWAIT
2. Families 10h-15h supported MWAIT, but not MWAIT C1. Hence it was
   preferable to use HALT as the default state on these systems.

However, AMD Family 17h onwards supports MWAIT as well as MWAIT
C1. And it is preferable to use MWAIT as the default idle state on
these systems, as it has lower exit latencies.

The below table represents the exit latency for HALT and MWAIT on AMD
Zen 3 system.
Exit latency is measured by issuing a wakeup (IPI) to other
CPU and measuring how many clock cycles it took to wakeup.
Each iteration measures 10K wakeups by pinning source and
destination.

HALT:

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

Below is another result for context_switch2 micro-benchmark,
which brings out the impact of improved wakeup latency through
increased context-switches per second.

Link: https://ozlabs.org/~anton/junkcode/context_switch2.c

with HALT:
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
index 49b915d1b7b4..314924e9b8e8 100644
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
+ * least 1 C1 substate.
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
+		return 0;
+
+	/* Monitor has a bug. Fallback to HALT */
+	if (boot_cpu_has_bug(X86_BUG_MONITOR))
 		return 0;
 
-	if (!cpu_has(c, X86_FEATURE_MWAIT) || boot_cpu_has_bug(X86_BUG_MONITOR))
+	if (c->cpuid_level < CPUID_MWAIT_LEAF)
 		return 0;
 
-	return 1;
+	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);
+
+	/*
+	 * If ECX doesn't have extended info about MWAIT,
+	 * don't need to check substates.
+	 */
+	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED))
+		return 1;
+
+	/* Check, whether at least 1 MWAIT C1 substate is present */
+	return (edx & MWAIT_C1_SUBSTATE_MASK);
 }
 
 /*
-- 
2.27.0


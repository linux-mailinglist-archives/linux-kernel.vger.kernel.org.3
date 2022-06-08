Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC0E543EF7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 00:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbiFHWBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 18:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbiFHWBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 18:01:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E49E48E56;
        Wed,  8 Jun 2022 15:01:04 -0700 (PDT)
Date:   Wed, 08 Jun 2022 22:01:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654725663;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cC6wkthMo5rBMJlLL9G9I0tPHpeEsC24L7qAOHtpbgo=;
        b=OkxsEfq95Wf1CRylJ8UGy+vlJB7lSrgxwbB0/2JV1XPyhnEIsd+y285a4WdXvCaPPoVNkl
        RfGRhoRxZYZuTyQGlGSABpI6gxR8lEJ1qZLPhwpZ0EVI1+jXFuP+PtxLg/l/U0PyaZ2XIb
        MLCkAG6neVOx2G6lqppeeLC9gxZ6bAOT+Ms85NfNs8S2RupD91jMQhn1age/nSXYedPHdu
        XVWd77xj0LfRSXtQ+mA1FMfGATVANb4SwLDmbg3max6cTQxs0Qhc8zerZMJl7iwH2BI6fP
        11sCgbMaHguiAcO4iKrJ28WXdzaCZs2VE9DNTZkp55xSK/rJfNpcp/bQnRndKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654725663;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cC6wkthMo5rBMJlLL9G9I0tPHpeEsC24L7qAOHtpbgo=;
        b=e+8q4Tp+wsnPU0R5yCLHoLtQ8ChII3BVnLa29cZRtX65ZihdePCkDU1LQll1989T0EYFVz
        rqBJQ4mDey7pTyAg==
From:   "tip-bot2 for Wyes Karny" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86: Remove vendor checks from prefer_mwait_c1_over_halt
Cc:     Wyes Karny <wyes.karny@amd.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C0cc675d8fd1f55e41b510e10abf2e21b6e9803d5=2E16545?=
 =?utf-8?q?38381=2Egit-series=2Ewyes=2Ekarny=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C0cc675d8fd1f55e41b510e10abf2e21b6e9803d5=2E165453?=
 =?utf-8?q?8381=2Egit-series=2Ewyes=2Ekarny=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165472566140.4207.13754937499422959001.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     aebef63cf7ff222660fd321c47e24452e8437673
Gitweb:        https://git.kernel.org/tip/aebef63cf7ff222660fd321c47e24452e8437673
Author:        Wyes Karny <wyes.karny@amd.com>
AuthorDate:    Mon, 06 Jun 2022 23:33:35 +05:30
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 08 Jun 2022 13:00:19 -07:00

x86: Remove vendor checks from prefer_mwait_c1_over_halt

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
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Link: https://ozlabs.org/~anton/junkcode/context_switch2.c
Link: https://lkml.kernel.org/r/0cc675d8fd1f55e41b510e10abf2e21b6e9803d5.1654538381.git-series.wyes.karny@amd.com
---
 arch/x86/include/asm/mwait.h |  1 +-
 arch/x86/kernel/process.c    | 35 +++++++++++++++++++++++++----------
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index 29dd27b..3a8fdf8 100644
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
index dca2e5e..5cbfbe5 100644
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

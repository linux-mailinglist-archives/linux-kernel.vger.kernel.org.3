Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EC25A9546
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 13:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbiIALAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 07:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiIALAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:00:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9CD10F08F;
        Thu,  1 Sep 2022 04:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MHAxYyxUgR/abIYCe2+tqPs37wMBg4sI4S4Xv4QcQS8=; b=B5OVANHSncb4o/i9LeD4iOlbBp
        Lkm41yBotm9Rgq6eyqGORQkRoQKkM5uLMy/qVzC80T3GmvzA9RqJ1EH7YBsMkoMJWK7vet+rcu8Hj
        1bkyB5Aih7cUb79kiDyEpXRh9NMgfuz8QoBrJ+hi9NPGTEKh7Zq+yh2NgfpxZMbPaAxW6AXD0Ed32
        GLuyLeIfsFoAl2lnubUJLV/fEndhgDkjMHqGJO6jYNh4Ty2pMuP4BNLLPm6RQWyKKi8Irg/Jx6218
        gq4rBpPES4CreTfsfWKhcYMFi8sUx5Y0bT6LTjMvPKI7sH8DpiIcJii0LuePKe9hQbEqjp8gP+liX
        qpd9WFmw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oThvz-005yDA-Hg; Thu, 01 Sep 2022 11:00:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6DB0D3002C7;
        Thu,  1 Sep 2022 13:00:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 522202B87B626; Thu,  1 Sep 2022 13:00:29 +0200 (CEST)
Date:   Thu, 1 Sep 2022 13:00:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Adam Langley <agl@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: Should Linux set the new constant-time mode CPU flags?
Message-ID: <YxCQzZqLZ49gLlrH@hirez.programming.kicks-ass.net>
References: <YwgCrqutxmX0W72r@gmail.com>
 <Ywzr2d52ixYXUDWR@zx2c4.com>
 <6ec9cdab-db5b-ab28-c92d-79c3812dd369@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ec9cdab-db5b-ab28-c92d-79c3812dd369@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 07:25:29AM -0700, Dave Hansen wrote:
> On 8/29/22 09:39, Jason A. Donenfeld wrote:
> > On Thu, Aug 25, 2022 at 11:15:58PM +0000, Eric Biggers wrote:
> >> I'm wondering if people are aware of this issue, and whether anyone has any
> >> thoughts on whether/where the kernel should be setting these new CPU flags.
> >> There don't appear to have been any prior discussions about this.  (Thanks to
> > Maybe it should be set unconditionally now, until we figure out how to
> > make it more granular.
> 
> Personally, I'm in this camp as well.  Let's be safe and set it by
> default.  There's also this tidbit in the Intel docs (and chopping out a
> bunch of the noise):
> 
> 	(On) processors based on microarchitectures before Ice Lake ...
> 	the instructions listed here operate as if DOITM is enabled.
> 
> IOW, setting DOITM=0 isn't going back to the stone age.  At worst, I'd
> guess that you're giving up some optimization that only shows up in very
> recent CPUs in the first place.
> 
> If folks want DOITM=1 on their snazzy new CPUs, then they came come with
> performance data to demonstrate the gain they'll get from adding kernel
> code to get DOITM=1.  There are a range of ways we could handle it, all
> the way from adding a command-line parameter to per-task management.
> 
> Anybody disagree?

Since I'm not feeling too well I figured I'd do something trivial and
whipped up the below patch.


---
 arch/x86/include/asm/cpufeatures.h |  3 ++
 arch/x86/include/asm/msr-index.h   |  4 +++
 arch/x86/kernel/cpu/common.c       | 69 ++++++++++++++++++++++++++++++--------
 arch/x86/kernel/cpu/scattered.c    |  1 +
 4 files changed, 63 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 333d94394516..9b92f4e5e80a 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -305,6 +305,7 @@
 #define X86_FEATURE_USE_IBPB_FW		(11*32+16) /* "" Use IBPB during runtime firmware calls */
 #define X86_FEATURE_RSB_VMEXIT_LITE	(11*32+17) /* "" Fill RSB on VM exit when EIBRS is enabled */
 #define X86_FEATURE_CALL_DEPTH		(11*32+18) /* "" Call depth tracking for RSB stuffing */
+#define X86_FEATURE_MCDT_NO		(11*32+19) /* Not affected by MCDT */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
@@ -460,5 +461,7 @@
 #define X86_BUG_MMIO_STALE_DATA		X86_BUG(25) /* CPU is affected by Processor MMIO Stale Data vulnerabilities */
 #define X86_BUG_RETBLEED		X86_BUG(26) /* CPU is affected by RETBleed */
 #define X86_BUG_EIBRS_PBRSB		X86_BUG(27) /* EIBRS is vulnerable to Post Barrier RSB Predictions */
+#define X86_BUG_DOIT			X86_BUG(28)
+#define X86_BUG_MCDT			X86_BUG(29)
 
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 6674bdb096f3..08b4e0c2f7d3 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -119,6 +119,7 @@
 						 * Not susceptible to
 						 * TSX Async Abort (TAA) vulnerabilities.
 						 */
+#define ARCH_CAP_DOIT			BIT(12) /* Data Operand Independent Timing */
 #define ARCH_CAP_SBDR_SSDP_NO		BIT(13)	/*
 						 * Not susceptible to SBDR and SSDP
 						 * variants of Processor MMIO stale data
@@ -155,6 +156,9 @@
 						 * Return Stack Buffer Predictions.
 						 */
 
+#define MSR_IA32_UARCH_MISC_CTL		0x00001b01
+#define UARCH_MISC_DOIT			BIT(0)	/* Enable DOIT */
+
 #define MSR_IA32_FLUSH_CMD		0x0000010b
 #define L1D_FLUSH			BIT(0)	/*
 						 * Writeback and invalidate the
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 28eba74b93de..e9d5bc870696 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -568,6 +568,30 @@ static __init int setup_disable_pku(char *arg)
 __setup("nopku", setup_disable_pku);
 #endif /* CONFIG_X86_64 */
 
+static bool doit_disabled = false;
+
+static __init int setup_disable_doit(char *arg)
+{
+	pr_info("x86: 'nodoit' specified, not enabling Data Operand Independent Timing\n");
+	doit_disabled = true;
+	return 1;
+}
+__setup("nodoit", setup_disable_doit);
+
+static __always_inline void setup_doit(struct cpuinfo_x86 *c)
+{
+	u64 msr = 0;
+
+	if (!cpu_has(c, X86_BUG_DOIT))
+		return;
+
+	if (!doit_disabled)
+		return;
+
+	rdmsrl(MSR_IA32_UARCH_MISC_CTL, msr);
+	wrmsrl(MSR_IA32_UARCH_MISC_CTL, msr | UARCH_MISC_DOIT);
+}
+
 #ifdef CONFIG_X86_KERNEL_IBT
 
 __noendbr u64 ibt_save(void)
@@ -1249,6 +1273,8 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 #define MMIO_SBDS	BIT(2)
 /* CPU is affected by RETbleed, speculating where you would not expect it */
 #define RETBLEED	BIT(3)
+/* CPU might be affected by MXCSR Configuration Dependent Timing (MCDT) */
+#define MCDT		BIT(4)
 
 static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_INTEL_STEPPINGS(IVYBRIDGE,	X86_STEPPING_ANY,		SRBDS),
@@ -1260,20 +1286,26 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_INTEL_STEPPINGS(BROADWELL_G,	X86_STEPPING_ANY,		SRBDS),
 	VULNBL_INTEL_STEPPINGS(BROADWELL_X,	X86_STEPPING_ANY,		MMIO),
 	VULNBL_INTEL_STEPPINGS(BROADWELL,	X86_STEPPING_ANY,		SRBDS),
-	VULNBL_INTEL_STEPPINGS(SKYLAKE_L,	X86_STEPPING_ANY,		SRBDS | MMIO | RETBLEED),
-	VULNBL_INTEL_STEPPINGS(SKYLAKE_X,	X86_STEPPING_ANY,		MMIO | RETBLEED),
-	VULNBL_INTEL_STEPPINGS(SKYLAKE,		X86_STEPPING_ANY,		SRBDS | MMIO | RETBLEED),
-	VULNBL_INTEL_STEPPINGS(KABYLAKE_L,	X86_STEPPING_ANY,		SRBDS | MMIO | RETBLEED),
-	VULNBL_INTEL_STEPPINGS(KABYLAKE,	X86_STEPPING_ANY,		SRBDS | MMIO | RETBLEED),
-	VULNBL_INTEL_STEPPINGS(CANNONLAKE_L,	X86_STEPPING_ANY,		RETBLEED),
-	VULNBL_INTEL_STEPPINGS(ICELAKE_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED),
-	VULNBL_INTEL_STEPPINGS(ICELAKE_D,	X86_STEPPING_ANY,		MMIO),
-	VULNBL_INTEL_STEPPINGS(ICELAKE_X,	X86_STEPPING_ANY,		MMIO),
-	VULNBL_INTEL_STEPPINGS(COMETLAKE,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED),
-	VULNBL_INTEL_STEPPINGS(COMETLAKE_L,	X86_STEPPINGS(0x0, 0x0),	MMIO | RETBLEED),
-	VULNBL_INTEL_STEPPINGS(COMETLAKE_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED),
-	VULNBL_INTEL_STEPPINGS(LAKEFIELD,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED),
-	VULNBL_INTEL_STEPPINGS(ROCKETLAKE,	X86_STEPPING_ANY,		MMIO | RETBLEED),
+	VULNBL_INTEL_STEPPINGS(SKYLAKE_L,	X86_STEPPING_ANY,		SRBDS | MMIO | RETBLEED | MCDT),
+	VULNBL_INTEL_STEPPINGS(SKYLAKE_X,	X86_STEPPING_ANY,		MMIO | RETBLEED | MCDT),
+	VULNBL_INTEL_STEPPINGS(SKYLAKE,		X86_STEPPING_ANY,		SRBDS | MMIO | RETBLEED | MCDT),
+	VULNBL_INTEL_STEPPINGS(KABYLAKE_L,	X86_STEPPING_ANY,		SRBDS | MMIO | RETBLEED | MCDT),
+	VULNBL_INTEL_STEPPINGS(KABYLAKE,	X86_STEPPING_ANY,		SRBDS | MMIO | RETBLEED | MCDT),
+	VULNBL_INTEL_STEPPINGS(CANNONLAKE_L,	X86_STEPPING_ANY,		RETBLEED | MCDT),
+	VULNBL_INTEL_STEPPINGS(ICELAKE_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | MCDT),
+	VULNBL_INTEL_STEPPINGS(ICELAKE_D,	X86_STEPPING_ANY,		MMIO | MCDT),
+	VULNBL_INTEL_STEPPINGS(ICELAKE_X,	X86_STEPPING_ANY,		MMIO | MCDT),
+	VULNBL_INTEL_STEPPINGS(COMETLAKE,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | MCDT),
+	VULNBL_INTEL_STEPPINGS(COMETLAKE_L,	X86_STEPPINGS(0x0, 0x0),	MMIO | RETBLEED | MCDT),
+	VULNBL_INTEL_STEPPINGS(COMETLAKE_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | MCDT),
+	VULNBL_INTEL_STEPPINGS(LAKEFIELD,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | MCDT),
+	VULNBL_INTEL_STEPPINGS(ROCKETLAKE,	X86_STEPPING_ANY,		MMIO | RETBLEED | MCDT),
+	VULNBL_INTEL_STEPPINGS(TIGERLAKE,	X86_STEPPING_ANY,		MCDT),
+	VULNBL_INTEL_STEPPINGS(TIGERLAKE_L,	X86_STEPPING_ANY,		MCDT),
+	VULNBL_INTEL_STEPPINGS(ALDERLAKE,	X86_STEPPING_ANY,		MCDT),
+	VULNBL_INTEL_STEPPINGS(ALDERLAKE_L,	X86_STEPPING_ANY,		MCDT),
+	VULNBL_INTEL_STEPPINGS(ALDERLAKE_N,	X86_STEPPING_ANY,		MCDT),
+
 	VULNBL_INTEL_STEPPINGS(ATOM_TREMONT,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS),
 	VULNBL_INTEL_STEPPINGS(ATOM_TREMONT_D,	X86_STEPPING_ANY,		MMIO),
 	VULNBL_INTEL_STEPPINGS(ATOM_TREMONT_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS),
@@ -1318,6 +1350,9 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	    !(ia32_cap & ARCH_CAP_PSCHANGE_MC_NO))
 		setup_force_cpu_bug(X86_BUG_ITLB_MULTIHIT);
 
+	if (ia32_cap & ARCH_CAP_DOIT)
+		setup_force_cpu_bug(X86_BUG_DOIT);
+
 	if (cpu_matches(cpu_vuln_whitelist, NO_SPECULATION))
 		return;
 
@@ -1388,6 +1423,11 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 			setup_force_cpu_bug(X86_BUG_RETBLEED);
 	}
 
+	if (!cpu_has(c, X86_FEATURE_MCDT_NO)) {
+		if (cpu_matches(cpu_vuln_blacklist, MCDT))
+			setup_force_cpu_bug(X86_BUG_MCDT);
+	}
+
 	if (cpu_has(c, X86_FEATURE_IBRS_ENHANCED) &&
 	    !cpu_matches(cpu_vuln_whitelist, NO_EIBRS_PBRSB) &&
 	    !(ia32_cap & ARCH_CAP_PBRSB_NO))
@@ -1869,6 +1909,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	x86_init_rdrand(c);
 	setup_pku(c);
 	setup_cet(c);
+	setup_doit(c);
 
 	/*
 	 * Clear/Set all flags overridden by options, need do it
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index fd44b54c90d5..5063f8046554 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -27,6 +27,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_APERFMPERF,       CPUID_ECX,  0, 0x00000006, 0 },
 	{ X86_FEATURE_EPB,		CPUID_ECX,  3, 0x00000006, 0 },
 	{ X86_FEATURE_INTEL_PPIN,	CPUID_EBX,  0, 0x00000007, 1 },
+	{ X86_FEATURE_MCDT_NO,		CPUID_ECX,  5, 0x00000007, 2 },
 	{ X86_FEATURE_RRSBA_CTRL,	CPUID_EDX,  2, 0x00000007, 2 },
 	{ X86_FEATURE_CQM_LLC,		CPUID_EDX,  1, 0x0000000f, 0 },
 	{ X86_FEATURE_CQM_OCCUP_LLC,	CPUID_EDX,  0, 0x0000000f, 1 },

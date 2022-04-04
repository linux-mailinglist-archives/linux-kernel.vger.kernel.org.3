Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4850E4F147B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 14:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239656AbiDDMN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 08:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237698AbiDDMNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 08:13:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61483DDC9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 05:11:26 -0700 (PDT)
Message-ID: <20220404104820.598704095@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649074285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=8ERp8DrhSUtNs0E8ZS0zOsiyutPHspCx2MDoLtawyr8=;
        b=OWpttuQGSfL3eKON5GSgvkLtJn4c6I6JTmXd2ygf2TjiyfXdJg1+3htI2ePHGsfu+M68wt
        j72TVuKQhYLbyxTJ7eOZ9as8fi1N/ieTDdHgUPV0tpOfX1KUlnQDyXoIxZ9eNGK7JsHWhh
        9mK7IREqwr5FJxxDCMW0F6pL6Wg7EWdnKbqh2BcnG0Y5CD/Wqwp+LyzUVQ1MT1TQG7P1pp
        UfuaS8AIpzHn7Cq1NNPblVdWx26ekhixXD25lDqokt9DUQchg31i6vNvBy7K9SlnKC3ULU
        Y+WJgEl+k7jG91VPysaqUZW1mT/FWNiPi9KqQuNE2M74F5CsC5vlNkd9hGumgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649074285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=8ERp8DrhSUtNs0E8ZS0zOsiyutPHspCx2MDoLtawyr8=;
        b=vRNhgwkRzG2NVaRnK13wvJN/1A1yqE58oLVVSSXMC21zdXL6n0vTfYp3SlwMHB7Tg3ZG4a
        eC1TIGHAZAYF6xAA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: [patch 1/3] x86/fpu/xsave: Support XSAVEC in the kernel
References: <20220404103741.809025935@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  4 Apr 2022 14:11:25 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

XSAVEC is the user space counterpart of XSAVES which cannot save supervisor
state. In virtualization scenarios the hypervisor does not expose XSAVES
but XSAVEC to the guest, though the kernel does not make use of it.

That's unfortunate because XSAVEC uses the compacted format of saving the
XSTATE. This is more efficient in terms of storage space vs. XSAVE[OPT] as
it does not create holes for XSTATE components which are not supported or
enabled by the kernel but are available in hardware. There is room for
further optimizations when XSAVEC/S and XGETBV1 are supported.

In order to support XSAVEC:

 - Define the XSAVEC ASM macro as it's not yet supported by the required
   minimal toolchain.

 - Create a software defined X86_FEATURE_XCOMPACTED to select the compacted
   XSTATE buffer format for both XSAVEC and XSAVES.

 - Make XSAVEC an option in the 'XSAVE' ASM alternatives

Requested-by: Andrew Cooper <Andrew.Cooper3@citrix.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/cpufeatures.h |    2 -
 arch/x86/kernel/fpu/xstate.c       |   58 ++++++++++++++++++++++++-------------
 arch/x86/kernel/fpu/xstate.h       |   14 +++++---
 3 files changed, 48 insertions(+), 26 deletions(-)

--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -201,7 +201,7 @@
 #define X86_FEATURE_INVPCID_SINGLE	( 7*32+ 7) /* Effectively INVPCID && CR4.PCIDE=1 */
 #define X86_FEATURE_HW_PSTATE		( 7*32+ 8) /* AMD HW-PState */
 #define X86_FEATURE_PROC_FEEDBACK	( 7*32+ 9) /* AMD ProcFeedbackInterface */
-/* FREE!                                ( 7*32+10) */
+#define X86_FEATURE_XCOMPACTED		( 7*32+10) /* "" Use compacted XSTATE (XSAVES or XSAVEC) */
 #define X86_FEATURE_PTI			( 7*32+11) /* Kernel Page Table Isolation enabled */
 #define X86_FEATURE_RETPOLINE		( 7*32+12) /* "" Generic Retpoline mitigation for Spectre variant 2 */
 #define X86_FEATURE_RETPOLINE_LFENCE	( 7*32+13) /* "" Use LFENCE for Spectre variant 2 */
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -142,7 +142,8 @@ static unsigned int xfeature_get_offset(
 	 * Non-compacted format and legacy features use the cached fixed
 	 * offsets.
 	 */
-	if (!cpu_feature_enabled(X86_FEATURE_XSAVES) || xfeature <= XFEATURE_SSE)
+	if (!cpu_feature_enabled(X86_FEATURE_XCOMPACTED) ||
+	    xfeature <= XFEATURE_SSE)
 		return xstate_offsets[xfeature];
 
 	/*
@@ -369,12 +370,12 @@ static void __init setup_init_fpu_buf(vo
 	/*
 	 * All components are now in init state. Read the state back so
 	 * that init_fpstate contains all non-zero init state. This only
-	 * works with XSAVE, but not with XSAVEOPT and XSAVES because
+	 * works with XSAVE, but not with XSAVEOPT and XSAVEC/S because
 	 * those use the init optimization which skips writing data for
 	 * components in init state.
 	 *
 	 * XSAVE could be used, but that would require to reshuffle the
-	 * data when XSAVES is available because XSAVES uses xstate
+	 * data when XSAVEC/S is available because XSAVEC/S uses xstate
 	 * compaction. But doing so is a pointless exercise because most
 	 * components have an all zeros init state except for the legacy
 	 * ones (FP and SSE). Those can be saved with FXSAVE into the
@@ -584,7 +585,8 @@ static unsigned int xstate_calculate_siz
  */
 static bool __init paranoid_xstate_size_valid(unsigned int kernel_size)
 {
-	bool compacted = cpu_feature_enabled(X86_FEATURE_XSAVES);
+	bool compacted = cpu_feature_enabled(X86_FEATURE_XCOMPACTED);
+	bool xsaves = cpu_feature_enabled(X86_FEATURE_XSAVES);
 	unsigned int size = FXSAVE_SIZE + XSAVE_HDR_SIZE;
 	int i;
 
@@ -595,7 +597,7 @@ static bool __init paranoid_xstate_size_
 		 * Supervisor state components can be managed only by
 		 * XSAVES.
 		 */
-		if (!compacted && xfeature_is_supervisor(i)) {
+		if (!xsaves && xfeature_is_supervisor(i)) {
 			XSTATE_WARN_ON(1);
 			return false;
 		}
@@ -612,8 +614,11 @@ static bool __init paranoid_xstate_size_
  * the size of the *user* states.  If we use it to size a buffer
  * that we use 'XSAVES' on, we could potentially overflow the
  * buffer because 'XSAVES' saves system states too.
+ *
+ * This also takes compaction into account. So this works for
+ * XSAVEC as well.
  */
-static unsigned int __init get_xsaves_size(void)
+static unsigned int __init get_compacted_size(void)
 {
 	unsigned int eax, ebx, ecx, edx;
 	/*
@@ -623,6 +628,10 @@ static unsigned int __init get_xsaves_si
 	 *    containing all the state components
 	 *    corresponding to bits currently set in
 	 *    XCR0 | IA32_XSS.
+	 *
+	 * When XSAVES is not available but XSAVEC (virt)
+	 * then there are no supervisor states, but XSAVEC
+	 * still uses compacted format.
 	 */
 	cpuid_count(XSTATE_CPUID, 1, &eax, &ebx, &ecx, &edx);
 	return ebx;
@@ -632,13 +641,13 @@ static unsigned int __init get_xsaves_si
  * Get the total size of the enabled xstates without the independent supervisor
  * features.
  */
-static unsigned int __init get_xsaves_size_no_independent(void)
+static unsigned int __init get_xsave_compacted_size(void)
 {
 	u64 mask = xfeatures_mask_independent();
 	unsigned int size;
 
 	if (!mask)
-		return get_xsaves_size();
+		return get_compacted_size();
 
 	/* Disable independent features. */
 	wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor());
@@ -647,7 +656,7 @@ static unsigned int __init get_xsaves_si
 	 * Ask the hardware what size is required of the buffer.
 	 * This is the size required for the task->fpu buffer.
 	 */
-	size = get_xsaves_size();
+	size = get_compacted_size();
 
 	/* Re-enable independent features so XSAVES will work on them again. */
 	wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor() | mask);
@@ -687,20 +696,21 @@ static int __init init_xstate_size(void)
 {
 	/* Recompute the context size for enabled features: */
 	unsigned int user_size, kernel_size, kernel_default_size;
-	bool compacted = cpu_feature_enabled(X86_FEATURE_XSAVES);
+	bool compacted = cpu_feature_enabled(X86_FEATURE_XCOMPACTED);
 
 	/* Uncompacted user space size */
 	user_size = get_xsave_size_user();
 
 	/*
-	 * XSAVES kernel size includes supervisor states and
-	 * uses compacted format when available.
+	 * XSAVES kernel size includes supervisor states and uses compacted
+	 * format. XSAVEC uses compacted format, but does not save
+	 * supervisor states.
 	 *
-	 * XSAVE does not support supervisor states so
-	 * kernel and user size is identical.
+	 * XSAVE[OPT] do not support supervisor states so kernel and user
+	 * size is identical.
 	 */
 	if (compacted)
-		kernel_size = get_xsaves_size_no_independent();
+		kernel_size = get_xsave_compacted_size();
 	else
 		kernel_size = user_size;
 
@@ -813,8 +823,11 @@ void __init fpu__init_system_xstate(unsi
 	if (!cpu_feature_enabled(X86_FEATURE_XFD))
 		fpu_kernel_cfg.max_features &= ~XFEATURE_MASK_USER_DYNAMIC;
 
-	fpu_kernel_cfg.max_features &= XFEATURE_MASK_USER_SUPPORTED |
-			      XFEATURE_MASK_SUPERVISOR_SUPPORTED;
+	if (!cpu_feature_enabled(X86_FEATURE_XSAVES))
+		fpu_kernel_cfg.max_features &= XFEATURE_MASK_USER_SUPPORTED;
+	else
+		fpu_kernel_cfg.max_features &= XFEATURE_MASK_USER_SUPPORTED |
+					XFEATURE_MASK_SUPERVISOR_SUPPORTED;
 
 	fpu_user_cfg.max_features = fpu_kernel_cfg.max_features;
 	fpu_user_cfg.max_features &= XFEATURE_MASK_USER_SUPPORTED;
@@ -837,6 +850,11 @@ void __init fpu__init_system_xstate(unsi
 	 */
 	init_fpstate.xfd = fpu_user_cfg.max_features & XFEATURE_MASK_USER_DYNAMIC;
 
+	/* Set up compaction feature bit */
+	if (cpu_feature_enabled(X86_FEATURE_XSAVEC) ||
+	    cpu_feature_enabled(X86_FEATURE_XSAVES))
+		setup_force_cpu_cap(X86_FEATURE_XCOMPACTED);
+
 	/* Enable xstate instructions to be able to continue with initialization: */
 	fpu__init_cpu_xstate();
 
@@ -873,7 +891,7 @@ void __init fpu__init_system_xstate(unsi
 	pr_info("x86/fpu: Enabled xstate features 0x%llx, context size is %d bytes, using '%s' format.\n",
 		fpu_kernel_cfg.max_features,
 		fpu_kernel_cfg.max_size,
-		boot_cpu_has(X86_FEATURE_XSAVES) ? "compacted" : "standard");
+		boot_cpu_has(X86_FEATURE_XCOMPACTED) ? "compacted" : "standard");
 	return;
 
 out_disable:
@@ -917,7 +935,7 @@ static void *__raw_xsave_addr(struct xre
 	if (WARN_ON_ONCE(!xfeature_enabled(xfeature_nr)))
 		return NULL;
 
-	if (cpu_feature_enabled(X86_FEATURE_XSAVES)) {
+	if (cpu_feature_enabled(X86_FEATURE_XCOMPACTED)) {
 		if (WARN_ON_ONCE(!(xcomp_bv & BIT_ULL(xfeature_nr))))
 			return NULL;
 	}
@@ -1525,7 +1543,7 @@ static int __xstate_request_perm(u64 per
 	 * vendors into extending XFD for the pre AMX states, especially
 	 * AVX512.
 	 */
-	bool compacted = cpu_feature_enabled(X86_FEATURE_XSAVES);
+	bool compacted = cpu_feature_enabled(X86_FEATURE_XCOMPACTED);
 	struct fpu *fpu = &current->group_leader->thread.fpu;
 	struct fpu_state_perm *perm;
 	unsigned int ksize, usize;
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -16,7 +16,7 @@ static inline void xstate_init_xcomp_bv(
 	 * XRSTORS requires these bits set in xcomp_bv, or it will
 	 * trigger #GP:
 	 */
-	if (cpu_feature_enabled(X86_FEATURE_XSAVES))
+	if (cpu_feature_enabled(X86_FEATURE_XCOMPACTED))
 		xsave->header.xcomp_bv = mask | XCOMP_BV_COMPACTED_FORMAT;
 }
 
@@ -79,6 +79,7 @@ static inline u64 xfeatures_mask_indepen
 /* These macros all use (%edi)/(%rdi) as the single memory argument. */
 #define XSAVE		".byte " REX_PREFIX "0x0f,0xae,0x27"
 #define XSAVEOPT	".byte " REX_PREFIX "0x0f,0xae,0x37"
+#define XSAVEC		".byte " REX_PREFIX "0x0f,0xc7,0x27"
 #define XSAVES		".byte " REX_PREFIX "0x0f,0xc7,0x2f"
 #define XRSTOR		".byte " REX_PREFIX "0x0f,0xae,0x2f"
 #define XRSTORS		".byte " REX_PREFIX "0x0f,0xc7,0x1f"
@@ -97,9 +98,11 @@ static inline u64 xfeatures_mask_indepen
 		     : "memory")
 
 /*
- * If XSAVES is enabled, it replaces XSAVEOPT because it supports a compact
- * format and supervisor states in addition to modified optimization in
- * XSAVEOPT.
+ * If XSAVES is enabled, it replaces XSAVEC because it supports supervisor
+ * states in addition to XSAVEC.
+ *
+ * Otherwise if XSAVEC is enabled, it replaces XSAVEOPT because it supports
+ * compacted storage format in addition to XSAVEOPT.
  *
  * Otherwise, if XSAVEOPT is enabled, XSAVEOPT replaces XSAVE because XSAVEOPT
  * supports modified optimization which is not supported by XSAVE.
@@ -111,8 +114,9 @@ static inline u64 xfeatures_mask_indepen
  * address of the instruction where we might get an exception at.
  */
 #define XSTATE_XSAVE(st, lmask, hmask, err)				\
-	asm volatile(ALTERNATIVE_2(XSAVE,				\
+	asm volatile(ALTERNATIVE_3(XSAVE,				\
 				   XSAVEOPT, X86_FEATURE_XSAVEOPT,	\
+				   XSAVEC,   X86_FEATURE_XSAVEC,	\
 				   XSAVES,   X86_FEATURE_XSAVES)	\
 		     "\n"						\
 		     "xor %[err], %[err]\n"				\


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1246050E144
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239409AbiDYNOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241943AbiDYNOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:14:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262AA27FF8;
        Mon, 25 Apr 2022 06:11:20 -0700 (PDT)
Date:   Mon, 25 Apr 2022 13:11:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650892278;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T1CgN4EZmGezGzf63+bczkRbPXZogg7gmP+jXi9RaXs=;
        b=gx5K2zytdLtooOdDmWb0l+uEPgaeB5dZlm5QYnSX4vpyioy6MO7ys9N0GFkBL8RRjYGh5R
        bwT0JXL6IFYnbuLDmTRRe/VG/BsqkuHLtEaZY2TxBTXL346kGAdrP7hv70BT4WzQL4H0B+
        xWBOjGei+PNGGjIHy8l1+GWa5EIMaeBCoSdj7ZO8HDVsLBEHav19Lc5HHI0Voq7B+3ikzJ
        sElgg6G09oXVtTeUSeD3hE3WA/64croANZ0Y/XK/V+ma7AywbUrBj4PNzRrJNHfbJwUJcX
        JRuir9dJAt47x4Pz5OhOBU6ERXmH0NZ//QtO4aAU3JTJOu85ltZUusZx6qEWsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650892278;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T1CgN4EZmGezGzf63+bczkRbPXZogg7gmP+jXi9RaXs=;
        b=sJsX6KvrIXjvW+pONFm9puarSi5Lic+HEK30LWF/R940fe8HVTRcNaCGTR2Pj3PKbZCzcg
        sWAghH2whbSlnrBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/xsave: Support XSAVEC in the kernel
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220404104820.598704095@linutronix.de>
References: <20220404104820.598704095@linutronix.de>
MIME-Version: 1.0
Message-ID: <165089227757.4207.17760609099020139556.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     8ad7e8f696951f192c6629a0cbda9ac94c773159
Gitweb:        https://git.kernel.org/tip/8ad7e8f696951f192c6629a0cbda9ac94c773159
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 04 Apr 2022 14:11:25 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 25 Apr 2022 15:05:37 +02:00

x86/fpu/xsave: Support XSAVEC in the kernel

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
Link: https://lore.kernel.org/r/20220404104820.598704095@linutronix.de

---
 arch/x86/include/asm/cpufeatures.h |  2 +-
 arch/x86/kernel/fpu/xstate.c       | 58 +++++++++++++++++++----------
 arch/x86/kernel/fpu/xstate.h       | 14 ++++---
 3 files changed, 48 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 73e643a..ff08da8 100644
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
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 39e1c86..31c12f4 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -142,7 +142,8 @@ static unsigned int xfeature_get_offset(u64 xcomp_bv, int xfeature)
 	 * Non-compacted format and legacy features use the cached fixed
 	 * offsets.
 	 */
-	if (!cpu_feature_enabled(X86_FEATURE_XSAVES) || xfeature <= XFEATURE_SSE)
+	if (!cpu_feature_enabled(X86_FEATURE_XCOMPACTED) ||
+	    xfeature <= XFEATURE_SSE)
 		return xstate_offsets[xfeature];
 
 	/*
@@ -369,12 +370,12 @@ static void __init setup_init_fpu_buf(void)
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
@@ -584,7 +585,8 @@ static unsigned int xstate_calculate_size(u64 xfeatures, bool compacted)
  */
 static bool __init paranoid_xstate_size_valid(unsigned int kernel_size)
 {
-	bool compacted = cpu_feature_enabled(X86_FEATURE_XSAVES);
+	bool compacted = cpu_feature_enabled(X86_FEATURE_XCOMPACTED);
+	bool xsaves = cpu_feature_enabled(X86_FEATURE_XSAVES);
 	unsigned int size = FXSAVE_SIZE + XSAVE_HDR_SIZE;
 	int i;
 
@@ -595,7 +597,7 @@ static bool __init paranoid_xstate_size_valid(unsigned int kernel_size)
 		 * Supervisor state components can be managed only by
 		 * XSAVES.
 		 */
-		if (!compacted && xfeature_is_supervisor(i)) {
+		if (!xsaves && xfeature_is_supervisor(i)) {
 			XSTATE_WARN_ON(1);
 			return false;
 		}
@@ -612,8 +614,11 @@ static bool __init paranoid_xstate_size_valid(unsigned int kernel_size)
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
@@ -623,6 +628,10 @@ static unsigned int __init get_xsaves_size(void)
 	 *    containing all the state components
 	 *    corresponding to bits currently set in
 	 *    XCR0 | IA32_XSS.
+	 *
+	 * When XSAVES is not available but XSAVEC is (virt), then there
+	 * are no supervisor states, but XSAVEC still uses compacted
+	 * format.
 	 */
 	cpuid_count(XSTATE_CPUID, 1, &eax, &ebx, &ecx, &edx);
 	return ebx;
@@ -632,13 +641,13 @@ static unsigned int __init get_xsaves_size(void)
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
@@ -647,7 +656,7 @@ static unsigned int __init get_xsaves_size_no_independent(void)
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
 
@@ -813,8 +823,11 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
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
@@ -837,6 +850,11 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 	 */
 	init_fpstate.xfd = fpu_user_cfg.max_features & XFEATURE_MASK_USER_DYNAMIC;
 
+	/* Set up compaction feature bit */
+	if (cpu_feature_enabled(X86_FEATURE_XSAVEC) ||
+	    cpu_feature_enabled(X86_FEATURE_XSAVES))
+		setup_force_cpu_cap(X86_FEATURE_XCOMPACTED);
+
 	/* Enable xstate instructions to be able to continue with initialization: */
 	fpu__init_cpu_xstate();
 
@@ -873,7 +891,7 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 	pr_info("x86/fpu: Enabled xstate features 0x%llx, context size is %d bytes, using '%s' format.\n",
 		fpu_kernel_cfg.max_features,
 		fpu_kernel_cfg.max_size,
-		boot_cpu_has(X86_FEATURE_XSAVES) ? "compacted" : "standard");
+		boot_cpu_has(X86_FEATURE_XCOMPACTED) ? "compacted" : "standard");
 	return;
 
 out_disable:
@@ -917,7 +935,7 @@ static void *__raw_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
 	if (WARN_ON_ONCE(!xfeature_enabled(xfeature_nr)))
 		return NULL;
 
-	if (cpu_feature_enabled(X86_FEATURE_XSAVES)) {
+	if (cpu_feature_enabled(X86_FEATURE_XCOMPACTED)) {
 		if (WARN_ON_ONCE(!(xcomp_bv & BIT_ULL(xfeature_nr))))
 			return NULL;
 	}
@@ -1525,7 +1543,7 @@ static int __xstate_request_perm(u64 permitted, u64 requested, bool guest)
 	 * vendors into extending XFD for the pre AMX states, especially
 	 * AVX512.
 	 */
-	bool compacted = cpu_feature_enabled(X86_FEATURE_XSAVES);
+	bool compacted = cpu_feature_enabled(X86_FEATURE_XCOMPACTED);
 	struct fpu *fpu = &current->group_leader->thread.fpu;
 	struct fpu_state_perm *perm;
 	unsigned int ksize, usize;
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index d22ace0..5ad4703 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -16,7 +16,7 @@ static inline void xstate_init_xcomp_bv(struct xregs_state *xsave, u64 mask)
 	 * XRSTORS requires these bits set in xcomp_bv, or it will
 	 * trigger #GP:
 	 */
-	if (cpu_feature_enabled(X86_FEATURE_XSAVES))
+	if (cpu_feature_enabled(X86_FEATURE_XCOMPACTED))
 		xsave->header.xcomp_bv = mask | XCOMP_BV_COMPACTED_FORMAT;
 }
 
@@ -79,6 +79,7 @@ static inline u64 xfeatures_mask_independent(void)
 /* These macros all use (%edi)/(%rdi) as the single memory argument. */
 #define XSAVE		".byte " REX_PREFIX "0x0f,0xae,0x27"
 #define XSAVEOPT	".byte " REX_PREFIX "0x0f,0xae,0x37"
+#define XSAVEC		".byte " REX_PREFIX "0x0f,0xc7,0x27"
 #define XSAVES		".byte " REX_PREFIX "0x0f,0xc7,0x2f"
 #define XRSTOR		".byte " REX_PREFIX "0x0f,0xae,0x2f"
 #define XRSTORS		".byte " REX_PREFIX "0x0f,0xc7,0x1f"
@@ -97,9 +98,11 @@ static inline u64 xfeatures_mask_independent(void)
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
@@ -111,8 +114,9 @@ static inline u64 xfeatures_mask_independent(void)
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

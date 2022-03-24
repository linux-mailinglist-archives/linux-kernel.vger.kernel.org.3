Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191404E6459
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 14:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350602AbiCXNtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 09:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350581AbiCXNsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 09:48:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE9FA94D9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:47:15 -0700 (PDT)
Message-ID: <20220324134623.627636809@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648129633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=2XKntiiVPPNJELg0vo1ejxeBcdE2A4TaubX0naDHtcM=;
        b=k1lOsjZ5Vbc8wdLVXOWUDW0faS4+rF0twMNJrE+BJgZojVAwZ5wveH4HJjibRNzatZkHg+
        A64IhA2LLtHKNf4o+Y2UTtAUW6rAv0G1cDXfoUZ5/SZVXpbUiEZTPGTQ7idAPFSn4f3H7I
        di2lZY4V210vsEJJFoEBKuYqyYfiMKyQrsCkZiWohTdWeM1Y3NSz4EV9H5yJ4cUPzSv2rq
        K24JQ+djdpSddUr1hJ9jWp1x2Fo28CMG2OdLyE+xrfmYWLZ5Qxk8XoefWA+HBr7oQLrLo4
        /nLq6sQs0h5Tquw2yfL/56t0lmdYDGJCRzeza0ZSkDGHhAuv+axA0GjFYq+Teg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648129633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=2XKntiiVPPNJELg0vo1ejxeBcdE2A4TaubX0naDHtcM=;
        b=2qe0JnWfgLR6R0eLdNvXqk6aUmNjox+TzF4TGLX4CNdKIZWXTOW/Ggc8sIlAScRnkIW6jf
        iR7oDWVxyz4Pg4Dw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Chang S. Bae" <chang.seok.bae@intel.com>,
        Paolo Bonzini <bonzini@gnu.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [patch 5/7] x86/fpu/xsave: Handle compacted offsets correctly with
 supervisor states
References: <20220324134548.432837672@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 24 Mar 2022 14:47:13 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far the cached fixed compacted offsets worked, but with (re)enabling of
ENQCMD this does not longer work with KVM fpstate.

KVM does not have supervisor features enabled for the guest FPU, which
means that KVM has then a different XSAVE area layout than the host FPU
state. This in turn breaks the copy from/to UABI functions when invoked for
a guest state.

Remove the precalculated compacted offsets and calculate the offset of each
component at runtime based on the XCOMP_BV field in the XSAVE header.

The runtime overhead is not interesting because these copy from/to UABI
functions are not used in critical fast paths. KVM uses them to save and
restore FPU state during migration. The host uses them for ptrace and for
the slow path of 32bit signal handling.

Fixes: 7c1ef59145f1 ("x86/cpufeatures: Re-enable ENQCMD")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Paolo Bonzini <bonzini@gnu.org>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/fpu/xstate.c |   86 ++++++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 45 deletions(-)

--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -81,8 +81,6 @@ static unsigned int xstate_offsets[XFEAT
 	{ [ 0 ... XFEATURE_MAX - 1] = -1};
 static unsigned int xstate_sizes[XFEATURE_MAX] __ro_after_init =
 	{ [ 0 ... XFEATURE_MAX - 1] = -1};
-static unsigned int xstate_comp_offsets[XFEATURE_MAX] __ro_after_init =
-	{ [ 0 ... XFEATURE_MAX - 1] = -1};
 static unsigned int xstate_flags[XFEATURE_MAX] __ro_after_init;
 
 #define XSTATE_FLAG_SUPERVISOR	BIT(0)
@@ -136,6 +134,33 @@ static bool xfeature_is_supervisor(int x
 	return xstate_flags[xfeature_nr] & XSTATE_FLAG_SUPERVISOR;
 }
 
+static unsigned int xfeature_get_offset(u64 xcomp_bv, int xfeature)
+{
+	unsigned int offs, i;
+
+	/*
+	 * Non-compacted format and legacy features use the cached fixed
+	 * offsets.
+	 */
+	if (!cpu_feature_enabled(X86_FEATURE_XSAVES) || xfeature <= XFEATURE_SSE)
+		return xstate_offsets[xfeature];
+
+	/*
+	 * Compacted format offsets depend on the actual content of the
+	 * compacted xsave area which is determined by the xcomp_bv header
+	 * field.
+	 */
+	offs = FXSAVE_SIZE + XSAVE_HDR_SIZE;
+	for_each_extended_xfeature(i, xcomp_bv) {
+		if (xfeature_is_aligned64(i))
+			offs = ALIGN(offs, 64);
+		if (i == xfeature)
+			break;
+		offs += xstate_sizes[i];
+	}
+	return offs;
+}
+
 /*
  * Enable the extended processor state save/restore feature.
  * Called once per CPU onlining.
@@ -264,42 +289,6 @@ static void __init print_xstate_features
 } while (0)
 
 /*
- * This function sets up offsets and sizes of all extended states in
- * xsave area. This supports both standard format and compacted format
- * of the xsave area.
- */
-static void __init setup_xstate_comp_offsets(void)
-{
-	unsigned int next_offset;
-	int i;
-
-	/*
-	 * The FP xstates and SSE xstates are legacy states. They are always
-	 * in the fixed offsets in the xsave area in either compacted form
-	 * or standard form.
-	 */
-	xstate_comp_offsets[XFEATURE_FP] = 0;
-	xstate_comp_offsets[XFEATURE_SSE] = offsetof(struct fxregs_state,
-						     xmm_space);
-
-	if (!cpu_feature_enabled(X86_FEATURE_XSAVES)) {
-		for_each_extended_xfeature(i, fpu_kernel_cfg.max_features)
-			xstate_comp_offsets[i] = xstate_offsets[i];
-		return;
-	}
-
-	next_offset = FXSAVE_SIZE + XSAVE_HDR_SIZE;
-
-	for_each_extended_xfeature(i, fpu_kernel_cfg.max_features) {
-		if (xfeature_is_aligned64(i))
-			next_offset = ALIGN(next_offset, 64);
-
-		xstate_comp_offsets[i] = next_offset;
-		next_offset += xstate_sizes[i];
-	}
-}
-
-/*
  * Print out xstate component offsets and sizes
  */
 static void __init print_xstate_offset_size(void)
@@ -308,7 +297,8 @@ static void __init print_xstate_offset_s
 
 	for_each_extended_xfeature(i, fpu_kernel_cfg.max_features) {
 		pr_info("x86/fpu: xstate_offset[%d]: %4d, xstate_sizes[%d]: %4d\n",
-			 i, xstate_comp_offsets[i], i, xstate_sizes[i]);
+			i, xfeature_get_offset(fpu_kernel_cfg.max_features, i),
+			i, xstate_sizes[i]);
 	}
 }
 
@@ -901,7 +891,6 @@ void __init fpu__init_system_xstate(unsi
 				  fpu_user_cfg.max_features);
 
 	setup_init_fpu_buf();
-	setup_xstate_comp_offsets();
 
 	/*
 	 * Paranoia check whether something in the setup modified the
@@ -956,13 +945,19 @@ void fpu__resume_cpu(void)
  */
 static void *__raw_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
 {
-	if (!xfeature_enabled(xfeature_nr)) {
-		WARN_ON_FPU(1);
+	u64 xcomp_bv = xsave->header.xcomp_bv;
+
+	if (WARN_ON_ONCE(!xfeature_enabled(xfeature_nr)))
 		return NULL;
+
+	if (cpu_feature_enabled(X86_FEATURE_XSAVES)) {
+		if (WARN_ON_ONCE(!(xcomp_bv & BIT_ULL(xfeature_nr))))
+			return NULL;
 	}
 
-	return (void *)xsave + xstate_comp_offsets[xfeature_nr];
+	return (void *)xsave + xfeature_get_offset(xcomp_bv, xfeature_nr);
 }
+
 /*
  * Given the xsave area and a state inside, this function returns the
  * address of the state.
@@ -993,8 +988,9 @@ void *get_xsave_addr(struct xregs_state
 	 * We should not ever be requesting features that we
 	 * have not enabled.
 	 */
-	WARN_ONCE(!(fpu_kernel_cfg.max_features & BIT_ULL(xfeature_nr)),
-		  "get of unsupported state");
+	if (WARN_ON_ONCE(!xfeature_enabled(xfeature_nr)))
+		return NULL;
+
 	/*
 	 * This assumes the last 'xsave*' instruction to
 	 * have requested that 'xfeature_nr' be saved.


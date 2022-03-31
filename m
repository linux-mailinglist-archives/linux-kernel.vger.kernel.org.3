Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82ADE4ED65E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 11:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbiCaJC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 05:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbiCaJCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:02:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8D120F7B;
        Thu, 31 Mar 2022 02:00:58 -0700 (PDT)
Date:   Thu, 31 Mar 2022 09:00:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648717257;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rjJlrYtsj8uTxWCscdGYCjMy50KDwmxsaFpJ8oCAvp8=;
        b=4WECOPf7BwOa/tDYa0B2bK6z/TCfZG7iVw78clP9NAPc4irFumK2XWacPCQK3H0/3EUC6u
        fDkNFI3c4UQ991wNcjOOjA7iN2VxDcmWQp37/eN6qQ7g9Bq558W8eL1X22QYZiUxfDnkmt
        sfoffFhSmMoa9JmIxHQIjDCqGGbHEzBsZmTjfFvEc1PDjJXFPvWbKQ9S74u3MAVKvbKr92
        zklO/IqXST61C9mbivz1r1gHjvI+7RcMHkwBLa3qJGww6wPEYZXJvvB5obriuR14HgP14T
        7xk1DkSg+CTViA1cAikB/IkJEaBI57n5BO2bbXTRj/4SS7ARL3C815Aedi0QeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648717257;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rjJlrYtsj8uTxWCscdGYCjMy50KDwmxsaFpJ8oCAvp8=;
        b=MrF+zRCNiJ5ryXwiiR9AJPPq4OVuhdbs7lEcHI39g9XY3HL5IUPdjGjhvoCttkhBX6g//i
        MMFm/cHnbgEhqpCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/fpu/xsave: Handle compacted offsets correctly
 with supervisor states
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220324134623.627636809@linutronix.de>
References: <20220324134623.627636809@linutronix.de>
MIME-Version: 1.0
Message-ID: <164871725613.389.9141180455154024348.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     7aa5128b5fea26cf224766303ea3b8df343f9a87
Gitweb:        https://git.kernel.org/tip/7aa5128b5fea26cf224766303ea3b8df343f9a87
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 24 Mar 2022 14:47:13 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 30 Mar 2022 11:20:36 +02:00

x86/fpu/xsave: Handle compacted offsets correctly with supervisor states

So far the cached fixed compacted offsets worked, but with (re-)enabling
of ENQCMD this does no longer work with KVM fpstate.

KVM does not have supervisor features enabled for the guest FPU, which
means that KVM has then a different XSAVE area layout than the host FPU
state. This in turn breaks the copy from/to UABI functions when invoked for
a guest state.

Remove the pre-calculated compacted offsets and calculate the offset
of each component at runtime based on the XCOMP_BV field in the XSAVE
header.

The runtime overhead is not interesting because these copy from/to UABI
functions are not used in critical fast paths. KVM uses them to save and
restore FPU state during migration. The host uses them for ptrace and for
the slow path of 32bit signal handling.

Fixes: 7c1ef59145f1 ("x86/cpufeatures: Re-enable ENQCMD")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220324134623.627636809@linutronix.de
---
 arch/x86/kernel/fpu/xstate.c | 86 ++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 45 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 5a069c2..c55f72e 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -81,8 +81,6 @@ static unsigned int xstate_offsets[XFEATURE_MAX] __ro_after_init =
 	{ [ 0 ... XFEATURE_MAX - 1] = -1};
 static unsigned int xstate_sizes[XFEATURE_MAX] __ro_after_init =
 	{ [ 0 ... XFEATURE_MAX - 1] = -1};
-static unsigned int xstate_comp_offsets[XFEATURE_MAX] __ro_after_init =
-	{ [ 0 ... XFEATURE_MAX - 1] = -1};
 static unsigned int xstate_flags[XFEATURE_MAX] __ro_after_init;
 
 #define XSTATE_FLAG_SUPERVISOR	BIT(0)
@@ -136,6 +134,33 @@ static bool xfeature_is_supervisor(int xfeature_nr)
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
@@ -264,42 +289,6 @@ static void __init print_xstate_features(void)
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
@@ -308,7 +297,8 @@ static void __init print_xstate_offset_size(void)
 
 	for_each_extended_xfeature(i, fpu_kernel_cfg.max_features) {
 		pr_info("x86/fpu: xstate_offset[%d]: %4d, xstate_sizes[%d]: %4d\n",
-			 i, xstate_comp_offsets[i], i, xstate_sizes[i]);
+			i, xfeature_get_offset(fpu_kernel_cfg.max_features, i),
+			i, xstate_sizes[i]);
 	}
 }
 
@@ -901,7 +891,6 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
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
@@ -993,8 +988,9 @@ void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE01F4ED65F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 11:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbiCaJDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 05:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbiCaJCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:02:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E4D167CF;
        Thu, 31 Mar 2022 02:00:59 -0700 (PDT)
Date:   Thu, 31 Mar 2022 09:00:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648717258;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=adqoSKKMxiOMmDFVxpkg24wC17L6Zx/Rvc0hW8piQR4=;
        b=iKsPOYA1AI6KkiXQaRN8BmiRJyFeTvRcQCi5H3r9EV4bks7Ax0KZ5DSUL9BQnCPKuIuhHV
        8fgKjUr/k4SKjvfdYOpSw/DS/ig8EvTMuctNPDS6WKdcRI4DaiX4KaRSowsxiNuOCbHA3Q
        gSCuCeYLGmKkGQO6pj4mg+NegtVxrJj0LON+ZzO3sqOlMxjB8PLr0reS1DQRZ1epXq6Yv+
        It9wlm4nxZS7t94IEfbPIphSR3fPBtzVd+W71xgu745pT7dIwDKVhuWSW0HoRsKw6INUi8
        kpbXSR6cAGsXUoQvEEhMbDz8V2RH5pfR4rkZleQj1LKhyHLIKdAsmWdykT7SnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648717258;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=adqoSKKMxiOMmDFVxpkg24wC17L6Zx/Rvc0hW8piQR4=;
        b=IEzqkzGIxJuR9q37jnKTWPAQ59lN7in7EzL0pj2pOXDuQxTvh3H55S8IBrWXQsu8RXPfl5
        ScVvSIC5H6ex4FCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/fpu: Cache xfeature flags from CPUID
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220324134623.573656209@linutronix.de>
References: <20220324134623.573656209@linutronix.de>
MIME-Version: 1.0
Message-ID: <164871725724.389.651739668307840512.tip-bot2@tip-bot2>
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

Commit-ID:     6afbb58cc2251c1d83472ca3005638206e73b6b8
Gitweb:        https://git.kernel.org/tip/6afbb58cc2251c1d83472ca3005638206e73b6b8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 24 Mar 2022 14:47:12 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 30 Mar 2022 11:05:32 +02:00

x86/fpu: Cache xfeature flags from CPUID

In preparation for runtime calculation of XSAVE offsets cache the feature
flags for each XSTATE component during feature enumeration via CPUID(0xD).

EDX has two relevant bits:
    0	Supervisor component
    1	Feature storage must be 64 byte aligned

These bits are currently only evaluated during init, but the alignment bit
must be cached to make runtime calculation of XSAVE offsets efficient.

Cache the full EDX content and use it for the existing alignment and
supervisor checks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220324134623.573656209@linutronix.de
---
 arch/x86/kernel/fpu/xstate.c | 49 +++++++++--------------------------
 1 file changed, 13 insertions(+), 36 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 814c2fd..5a069c2 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -83,6 +83,10 @@ static unsigned int xstate_sizes[XFEATURE_MAX] __ro_after_init =
 	{ [ 0 ... XFEATURE_MAX - 1] = -1};
 static unsigned int xstate_comp_offsets[XFEATURE_MAX] __ro_after_init =
 	{ [ 0 ... XFEATURE_MAX - 1] = -1};
+static unsigned int xstate_flags[XFEATURE_MAX] __ro_after_init;
+
+#define XSTATE_FLAG_SUPERVISOR	BIT(0)
+#define XSTATE_FLAG_ALIGNED64	BIT(1)
 
 /*
  * Return whether the system supports a given xfeature.
@@ -122,17 +126,14 @@ int cpu_has_xfeatures(u64 xfeatures_needed, const char **feature_name)
 }
 EXPORT_SYMBOL_GPL(cpu_has_xfeatures);
 
-static bool xfeature_is_supervisor(int xfeature_nr)
+static bool xfeature_is_aligned64(int xfeature_nr)
 {
-	/*
-	 * Extended State Enumeration Sub-leaves (EAX = 0DH, ECX = n, n > 1)
-	 * returns ECX[0] set to (1) for a supervisor state, and cleared (0)
-	 * for a user state.
-	 */
-	u32 eax, ebx, ecx, edx;
+	return xstate_flags[xfeature_nr] & XSTATE_FLAG_ALIGNED64;
+}
 
-	cpuid_count(XSTATE_CPUID, xfeature_nr, &eax, &ebx, &ecx, &edx);
-	return ecx & 1;
+static bool xfeature_is_supervisor(int xfeature_nr)
+{
+	return xstate_flags[xfeature_nr] & XSTATE_FLAG_SUPERVISOR;
 }
 
 /*
@@ -203,6 +204,7 @@ static void __init setup_xstate_cache(void)
 		cpuid_count(XSTATE_CPUID, i, &eax, &ebx, &ecx, &edx);
 
 		xstate_sizes[i] = eax;
+		xstate_flags[i] = ecx;
 
 		/*
 		 * If an xfeature is supervisor state, the offset in EBX is
@@ -262,31 +264,6 @@ static void __init print_xstate_features(void)
 } while (0)
 
 /*
- * We could cache this like xstate_size[], but we only use
- * it here, so it would be a waste of space.
- */
-static int xfeature_is_aligned(int xfeature_nr)
-{
-	u32 eax, ebx, ecx, edx;
-
-	CHECK_XFEATURE(xfeature_nr);
-
-	if (!xfeature_enabled(xfeature_nr)) {
-		WARN_ONCE(1, "Checking alignment of disabled xfeature %d\n",
-			  xfeature_nr);
-		return 0;
-	}
-
-	cpuid_count(XSTATE_CPUID, xfeature_nr, &eax, &ebx, &ecx, &edx);
-	/*
-	 * The value returned by ECX[1] indicates the alignment
-	 * of state component 'i' when the compacted format
-	 * of the extended region of an XSAVE area is used:
-	 */
-	return !!(ecx & 2);
-}
-
-/*
  * This function sets up offsets and sizes of all extended states in
  * xsave area. This supports both standard format and compacted format
  * of the xsave area.
@@ -314,7 +291,7 @@ static void __init setup_xstate_comp_offsets(void)
 	next_offset = FXSAVE_SIZE + XSAVE_HDR_SIZE;
 
 	for_each_extended_xfeature(i, fpu_kernel_cfg.max_features) {
-		if (xfeature_is_aligned(i))
+		if (xfeature_is_aligned64(i))
 			next_offset = ALIGN(next_offset, 64);
 
 		xstate_comp_offsets[i] = next_offset;
@@ -619,7 +596,7 @@ static unsigned int xstate_calculate_size(u64 xfeatures, bool compacted)
 
 	for_each_extended_xfeature(i, xfeatures) {
 		/* Align from the end of the previous feature */
-		if (xfeature_is_aligned(i))
+		if (xfeature_is_aligned64(i))
 			size = ALIGN(size, 64);
 		/*
 		 * In compacted format the enabled features are packed,

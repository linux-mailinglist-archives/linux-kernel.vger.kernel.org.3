Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BECA4E645B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 14:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350615AbiCXNtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 09:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350577AbiCXNsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 09:48:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E18FA94D5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:47:13 -0700 (PDT)
Message-ID: <20220324134623.573656209@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648129632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=FlS4rDJenRO6wkC0JNfcNEGDOUzk/9jo8hCEAjDstZo=;
        b=rmrVo/s1ODwYu0HnOGUT7eAg3WFoEuXeL0tUpdCsaePLqweClDRipWWresthvglwM0urGQ
        /XKN4m+KzDB1EnqlLc87acckS53pqVCciAf+lErK81GHY3SeSqdWyes5ffv2GFBi86279b
        9hM3Sf2Gu1dp/fcXiugSNg0bvoIXRndxR61vHP/O5Zo9klpwG7rWOVazif3B4pg/WMleuy
        DEJK9hWDpSDWX9mNnqYvaZHZXFDbBedl9Z68POjrA+Bb7Wa4Do0z/NNXguMKyB0KR75Rso
        devgcxiixtZMR/bPJ8ozGoDJHAU+h8Aw8MZE91fONbKXu3X3rDWCifJ7b1KwvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648129632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=FlS4rDJenRO6wkC0JNfcNEGDOUzk/9jo8hCEAjDstZo=;
        b=FAG7FSdVTHDktEb/RD0aHM9TV4wUNhx3uIeUaskfpWIEO9Dr1kmMt8K0RehEkkOzmV3Mp3
        HFWbAl4VLHX4DnAA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: [patch 4/7] x86/fpu: Cache xfeature flags from CPUID
References: <20220324134548.432837672@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 24 Mar 2022 14:47:12 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 arch/x86/kernel/fpu/xstate.c |   49 +++++++++++--------------------------------
 1 file changed, 13 insertions(+), 36 deletions(-)

--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -83,6 +83,10 @@ static unsigned int xstate_sizes[XFEATUR
 	{ [ 0 ... XFEATURE_MAX - 1] = -1};
 static unsigned int xstate_comp_offsets[XFEATURE_MAX] __ro_after_init =
 	{ [ 0 ... XFEATURE_MAX - 1] = -1};
+static unsigned int xstate_flags[XFEATURE_MAX] __ro_after_init;
+
+#define XSTATE_FLAG_SUPERVISOR	BIT(0)
+#define XSTATE_FLAG_ALIGNED64	BIT(1)
 
 /*
  * Return whether the system supports a given xfeature.
@@ -122,17 +126,14 @@ int cpu_has_xfeatures(u64 xfeatures_need
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
@@ -203,6 +204,7 @@ static void __init setup_xstate_cache(vo
 		cpuid_count(XSTATE_CPUID, i, &eax, &ebx, &ecx, &edx);
 
 		xstate_sizes[i] = eax;
+		xstate_flags[i] = ecx;
 
 		/*
 		 * If an xfeature is supervisor state, the offset in EBX is
@@ -262,31 +264,6 @@ static void __init print_xstate_features
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
@@ -314,7 +291,7 @@ static void __init setup_xstate_comp_off
 	next_offset = FXSAVE_SIZE + XSAVE_HDR_SIZE;
 
 	for_each_extended_xfeature(i, fpu_kernel_cfg.max_features) {
-		if (xfeature_is_aligned(i))
+		if (xfeature_is_aligned64(i))
 			next_offset = ALIGN(next_offset, 64);
 
 		xstate_comp_offsets[i] = next_offset;
@@ -619,7 +596,7 @@ static unsigned int xstate_calculate_siz
 
 	for_each_extended_xfeature(i, xfeatures) {
 		/* Align from the end of the previous feature */
-		if (xfeature_is_aligned(i))
+		if (xfeature_is_aligned64(i))
 			size = ALIGN(size, 64);
 		/*
 		 * In compacted format the enabled features are packed,


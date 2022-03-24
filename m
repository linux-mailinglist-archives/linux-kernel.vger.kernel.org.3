Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F944E6456
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 14:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350613AbiCXNs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 09:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350576AbiCXNsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 09:48:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73A18F9A9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:47:12 -0700 (PDT)
Message-ID: <20220324134623.519411939@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648129631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=mkdnb+b1Zmv6jwoILxAAtMLYCIJRUKxiXjyexb3mvlA=;
        b=Mu+EzWTBgKIHpxaq1AnEAX1K+gbnmR0RU9b3Ffo+n1SdY6JvSJQgPBP8rWccsOQuy8mPgX
        g0FO+UT1RksBZfZisj3fKshuJ9U20clfDMDjHpumeHKWyhrWVy+MVFMS5fnEQEjeV3Xs6e
        0fv5gBOywntqh5edJowL8NgGnuiBqFUSwV0FhmzopZnLF29QpwsX0eaayjp4+5Nw+5pRLR
        I/mZrwwznKTHmjGGwmQwtIQ3ZP3K+84/5PI40YRQACLhJRTw+PUtjkodBjiFAsGLxo49ai
        0nPe8ytoY5aJ+I/h3cgjPA0g4hBjui9x+Dn29oBM6Z/kJRI6dkR4GLUtnq0J/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648129631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=mkdnb+b1Zmv6jwoILxAAtMLYCIJRUKxiXjyexb3mvlA=;
        b=uuDif5DOITAoan4/wx31IbVAYrNBc+4hI0H66CtiwKIL6dfp4uCJYb94WVpud9cvrkTTFx
        8ExKi3x+XLs877AA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: [patch 3/7] x86/fpu/xsave: Initialize offset/size cache early
References: <20220324134548.432837672@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 24 Mar 2022 14:47:11 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reading XSTATE feature information from CPUID over and over does not make
sense. The information has to be cached anyway, so it can be done early.

This prepares for runtime calculation of XSTATE offsets and allows
consolidation of the size calculation functions in a later step.

Rename the function while at it as it does not setup any features.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/fpu/xstate.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -180,7 +180,7 @@ static bool xfeature_enabled(enum xfeatu
  * Record the offsets and sizes of various xstates contained
  * in the XSAVE state memory layout.
  */
-static void __init setup_xstate_features(void)
+static void __init setup_xstate_cache(void)
 {
 	u32 eax, ebx, ecx, edx, i;
 	/* start at the beginning of the "extended state" */
@@ -390,7 +390,6 @@ static void __init setup_init_fpu_buf(vo
 	if (!boot_cpu_has(X86_FEATURE_XSAVE))
 		return;
 
-	setup_xstate_features();
 	print_xstate_features();
 
 	xstate_init_xcomp_bv(&init_fpstate.regs.xsave, fpu_kernel_cfg.max_features);
@@ -906,6 +905,10 @@ void __init fpu__init_system_xstate(unsi
 
 	/* Enable xstate instructions to be able to continue with initialization: */
 	fpu__init_cpu_xstate();
+
+	/* Cache size, offset and flags for initialization */
+	setup_xstate_cache();
+
 	err = init_xstate_size();
 	if (err)
 		goto out_disable;


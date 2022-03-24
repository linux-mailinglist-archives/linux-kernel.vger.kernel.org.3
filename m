Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32C24E6454
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 14:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350597AbiCXNsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 09:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350563AbiCXNsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 09:48:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F777CDD0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:47:11 -0700 (PDT)
Message-ID: <20220324134623.465066249@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648129630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=dhbG1adkOE8R+sSmMcE/7esFfa52zfgf9U61mYJxyYw=;
        b=NEYa9909YrtsAWAufxNgT+hBwo+G/s5ZXsE6I1Cwsg2rFoHX5hBKycmuhL6/DeBbPAseoN
        PRieKodSwQx+EgOqy/GawS2nIumvDAX3cIoFG3vB3ZYdaDDVT2BFdvnQ3WW8ceRPOQNwCG
        jd0oiwJWwMUmFyiqmXwG43JG+M9eVYgow0z57GNErKOaccSgGE3hw3j3CwU3jAFMYJvZiT
        eHaDBCMAsOEIFYJLvy99VojwrJ6JVALz83Mo2+ZvKZonmAmI88/A7cI5NaVwhwlPv6w93d
        1QiIFHWK18LOPNNS26tnB5dqb6KgxJom1a9XgWzzVCdEG9z6UrbREOFoY4CpGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648129630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=dhbG1adkOE8R+sSmMcE/7esFfa52zfgf9U61mYJxyYw=;
        b=WI9lMIfXdT+CqFDMctIkehPGZ5k1Ul7EltWd8i3tpjN9ysbIrq2xv/Dp9ubeBjPHzH18sK
        wsLYlT7156aS4BBQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: [patch 2/7] x86/fpu: Remove unused supervisor only offsets
References: <20220324134548.432837672@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 24 Mar 2022 14:47:09 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/fpu/xstate.c |   30 ------------------------------
 1 file changed, 30 deletions(-)

--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -83,8 +83,6 @@ static unsigned int xstate_sizes[XFEATUR
 	{ [ 0 ... XFEATURE_MAX - 1] = -1};
 static unsigned int xstate_comp_offsets[XFEATURE_MAX] __ro_after_init =
 	{ [ 0 ... XFEATURE_MAX - 1] = -1};
-static unsigned int xstate_supervisor_only_offsets[XFEATURE_MAX] __ro_after_init =
-	{ [ 0 ... XFEATURE_MAX - 1] = -1};
 
 /*
  * Return whether the system supports a given xfeature.
@@ -325,33 +323,6 @@ static void __init setup_xstate_comp_off
 }
 
 /*
- * Setup offsets of a supervisor-state-only XSAVES buffer:
- *
- * The offsets stored in xstate_comp_offsets[] only work for one specific
- * value of the Requested Feature BitMap (RFBM).  In cases where a different
- * RFBM value is used, a different set of offsets is required.  This set of
- * offsets is for when RFBM=xfeatures_mask_supervisor().
- */
-static void __init setup_supervisor_only_offsets(void)
-{
-	unsigned int next_offset;
-	int i;
-
-	next_offset = FXSAVE_SIZE + XSAVE_HDR_SIZE;
-
-	for_each_extended_xfeature(i, fpu_kernel_cfg.max_features) {
-		if (!xfeature_is_supervisor(i))
-			continue;
-
-		if (xfeature_is_aligned(i))
-			next_offset = ALIGN(next_offset, 64);
-
-		xstate_supervisor_only_offsets[i] = next_offset;
-		next_offset += xstate_sizes[i];
-	}
-}
-
-/*
  * Print out xstate component offsets and sizes
  */
 static void __init print_xstate_offset_size(void)
@@ -951,7 +922,6 @@ void __init fpu__init_system_xstate(unsi
 
 	setup_init_fpu_buf();
 	setup_xstate_comp_offsets();
-	setup_supervisor_only_offsets();
 
 	/*
 	 * Paranoia check whether something in the setup modified the


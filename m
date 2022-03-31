Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAC74ED667
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 11:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbiCaJDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 05:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbiCaJCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:02:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C15E20F7B;
        Thu, 31 Mar 2022 02:01:00 -0700 (PDT)
Date:   Thu, 31 Mar 2022 09:00:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648717259;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TuDqgi7e/2x3v2Yism8NZG1egzT20igyTpQegLDdnh0=;
        b=R6fGnBUvY4QQPPOcoYUTOMks8RNrwyQsJG4vxz4UWB1ofBYCryBob9zDyBPj2q3cqGUHNS
        QO4JVNdd4x5oY7XJK9WBxwzasc7gGI7P0sH+SWi2TBa9wY2I6u1SfGVIfuG/rYlZu1bcoq
        CpewcdxHZ7rIMfxgCE38mKNCrv92IfX72kGuEig0CAlBtIPPIbyxY0HkdawcHAMJymrV1L
        zflvrt/2uoiffTi6i7bSGbKf3N8vctFvZquSUTyugXB9STssGfNZYSR1qlJ1RVv7ocDwZA
        nbYglDZq4kWFD/Am88K9TTAGga/o5WPeqIqiVlcRZKqUokbGmx/GCqUzwnaRoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648717259;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TuDqgi7e/2x3v2Yism8NZG1egzT20igyTpQegLDdnh0=;
        b=80acQ4ixlUd6tpUtwZqp+cyX/q4PDFY0zV3jYWxqs4hlXXgqcgV76ErG0eDJBHoSsts0de
        uh0QXKVqJlyrlWCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/fpu/xsave: Initialize offset/size cache early
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220324134623.519411939@linutronix.de>
References: <20220324134623.519411939@linutronix.de>
MIME-Version: 1.0
Message-ID: <164871725829.389.689709349673865983.tip-bot2@tip-bot2>
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

Commit-ID:     35a77d4503d9d9d0e19e3a2a0d3fc9ab09fb6857
Gitweb:        https://git.kernel.org/tip/35a77d4503d9d9d0e19e3a2a0d3fc9ab09fb6857
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 24 Mar 2022 14:47:11 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 30 Mar 2022 10:55:44 +02:00

x86/fpu/xsave: Initialize offset/size cache early

Reading XSTATE feature information from CPUID over and over does not make
sense. The information has to be cached anyway, so it can be done early.

Prepare for runtime calculation of XSTATE offsets and allow
consolidation of the size calculation functions in a later step.

Rename the function while at it as it does not setup any features.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220324134623.519411939@linutronix.de
---
 arch/x86/kernel/fpu/xstate.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index dc33556..814c2fd 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -180,7 +180,7 @@ static bool xfeature_enabled(enum xfeature xfeature)
  * Record the offsets and sizes of various xstates contained
  * in the XSAVE state memory layout.
  */
-static void __init setup_xstate_features(void)
+static void __init setup_xstate_cache(void)
 {
 	u32 eax, ebx, ecx, edx, i;
 	/* start at the beginning of the "extended state" */
@@ -390,7 +390,6 @@ static void __init setup_init_fpu_buf(void)
 	if (!boot_cpu_has(X86_FEATURE_XSAVE))
 		return;
 
-	setup_xstate_features();
 	print_xstate_features();
 
 	xstate_init_xcomp_bv(&init_fpstate.regs.xsave, fpu_kernel_cfg.max_features);
@@ -906,6 +905,10 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 
 	/* Enable xstate instructions to be able to continue with initialization: */
 	fpu__init_cpu_xstate();
+
+	/* Cache size, offset and flags for initialization */
+	setup_xstate_cache();
+
 	err = init_xstate_size();
 	if (err)
 		goto out_disable;

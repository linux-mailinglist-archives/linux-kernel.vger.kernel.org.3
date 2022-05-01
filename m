Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA5D51677F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 21:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353946AbiEATfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 15:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349167AbiEATfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 15:35:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F1D4EA0D
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 12:31:47 -0700 (PDT)
Message-ID: <20220501193102.647328777@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651433505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=v+9fFLHr/r9ZBLxNWhpzb94rMAgopHuWB0AJT/8ddKg=;
        b=eGtwhc+QBZi1YdFqmtGrp5p+Th+WoXuSO2++6ssLMDNgFpGTsy9Uj+dmQDueSsvBN5GS7H
        72TRA1diVbdd+SkYjVumwiy4e887jD2rrizSCx+q1Xe7v0DbJJN1znsZ5QKexL8qsFsUZl
        2vL6vT24MeixrAiiz3HRO+An86nBghRXYAfkUF7J1YJJDhouNiwNfmd9F0bgvpGUSf4eJd
        pKlmIJS8xoqJof34s39f1T4mop0dHfF37BpD+tO6t8UillLrWC3EwUBfXyw/jIl7TpfRHx
        3c+PsszqwAMLS5W/s1bzTVUxDbAN3F4skiuOrjNDWXk2Wi4zdPh+fetegbYMaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651433505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=v+9fFLHr/r9ZBLxNWhpzb94rMAgopHuWB0AJT/8ddKg=;
        b=J+bagRZ6UzP1AwhFr5tWI4cxwd3UnSW7FZkyQ6cENZRy2BguA6WOWOae1nlHrW6IO5gHV3
        LD5MDKrumNArnoAQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [patch 2/3] x86/fpu: Rename irq_fpu_usable()
References: <20220501192740.203963477@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun,  1 May 2022 21:31:45 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This can be invoked from almost any context, except NMI. The only
requirement is that the context is not migrateable.

Rename it to kernel_fpu_usable().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/um/include/asm/fpu/api.h       |    2 +-
 arch/x86/include/asm/fpu/api.h      |    4 ++--
 arch/x86/include/asm/simd.h         |    2 +-
 arch/x86/kernel/fpu/core.c          |   13 +++++++------
 net/netfilter/nft_set_pipapo_avx2.c |    2 +-
 5 files changed, 12 insertions(+), 11 deletions(-)

--- a/arch/um/include/asm/fpu/api.h
+++ b/arch/um/include/asm/fpu/api.h
@@ -11,7 +11,7 @@
 #define kernel_fpu_begin() (void)0
 #define kernel_fpu_end() (void)0
 
-static inline bool irq_fpu_usable(void)
+static inline bool kernel_fpu_usable(void)
 {
 	return true;
 }
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -19,7 +19,7 @@
  * disables preemption so be careful if you intend to use it for long periods
  * of time.
  * If you intend to use the FPU in irq/softirq you need to check first with
- * irq_fpu_usable() if it is possible.
+ * kernel_fpu_usable() if it is possible.
  */
 
 /* Kernel FPU states to initialize in kernel_fpu_begin_mask() */
@@ -28,7 +28,7 @@
 
 extern void kernel_fpu_begin_mask(unsigned int kfpu_mask);
 extern void kernel_fpu_end(void);
-extern bool irq_fpu_usable(void);
+extern bool kernel_fpu_usable(void);
 extern void fpregs_mark_activate(void);
 
 /* Code that is unaware of kernel_fpu_begin_mask() can use this */
--- a/arch/x86/include/asm/simd.h
+++ b/arch/x86/include/asm/simd.h
@@ -8,5 +8,5 @@
  */
 static __must_check inline bool may_use_simd(void)
 {
-	return irq_fpu_usable();
+	return kernel_fpu_usable();
 }
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -49,11 +49,12 @@ static DEFINE_PER_CPU(bool, in_kernel_fp
  */
 DEFINE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
 
-/*
- * Can we use the FPU in kernel mode with the
- * whole "kernel_fpu_begin/end()" sequence?
+/**
+ * kernel_fpu_usable - Check whether kernel FPU usage is possible
+ *
+ * Has to be invoked before calling kernel_fpu_begin().
  */
-bool irq_fpu_usable(void)
+bool kernel_fpu_usable(void)
 {
 	if (WARN_ON_ONCE(in_nmi()))
 		return false;
@@ -81,7 +82,7 @@ bool irq_fpu_usable(void)
 	 */
 	return !softirq_count();
 }
-EXPORT_SYMBOL(irq_fpu_usable);
+EXPORT_SYMBOL(kernel_fpu_usable);
 
 /*
  * Track AVX512 state use because it is known to slow the max clock
@@ -409,7 +410,7 @@ void kernel_fpu_begin_mask(unsigned int
 {
 	preempt_disable();
 
-	WARN_ON_FPU(!irq_fpu_usable());
+	WARN_ON_FPU(!kernel_fpu_usable());
 	WARN_ON_FPU(this_cpu_read(in_kernel_fpu));
 
 	this_cpu_write(in_kernel_fpu, true);
--- a/net/netfilter/nft_set_pipapo_avx2.c
+++ b/net/netfilter/nft_set_pipapo_avx2.c
@@ -1128,7 +1128,7 @@ bool nft_pipapo_avx2_lookup(const struct
 	bool map_index;
 	int i, ret = 0;
 
-	if (unlikely(!irq_fpu_usable()))
+	if (unlikely(!kernel_fpu_usable()))
 		return nft_pipapo_lookup(net, set, key, ext);
 
 	m = rcu_dereference(priv->match);


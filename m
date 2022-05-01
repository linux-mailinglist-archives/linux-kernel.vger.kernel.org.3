Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FFF51677D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 21:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355107AbiEATf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 15:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350172AbiEATfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 15:35:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD5B4ECD4
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 12:31:48 -0700 (PDT)
Message-ID: <20220501193102.704267030@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651433507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=VhCINNAHjctUPAk0XN6VM4ogLWSiR8LdSlWPAIPLcPQ=;
        b=fIsebEYWSTYkwhrz4w4tzNXjuW8+RGrpRF8B0Mbh8dAVYWg0el+Jit5x8deho7O7Y8VZe3
        acK5gViad1A5iE2kAa/6PbEvs1hvacsCL4d4yoMb1hBGKvcxginRG98a+QBvB5J19lKtyO
        xYIkX9hfbT5F20f3erOYdyp2HLadD8QU2WBSW1TS+3VW8YKN0CKkgpasvT3CAyzEVNQ8iG
        2Box9HBH1AQ3mAhUO3hBLCPKoLvBNswX3gtSoBPCzaqwZM3pmyIlfLQDJcJTgXNNgXOF40
        wHyWjq7d1zIQkqB56LfDNyrHWWcdmT+O/LQyXKAPzo9YJG3T5YzPESnsYw2FmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651433507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=VhCINNAHjctUPAk0XN6VM4ogLWSiR8LdSlWPAIPLcPQ=;
        b=XGFDMO/58UfDmodWSpSg/Trgc9OmNYuIH34uhLJ3VFnfk8CAvwb6F3Q03QQnVP4y3flscM
        Oapktq4pRxr6JCAg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [patch 3/3] x86/fpu: Make FPU protection more robust
References: <20220501192740.203963477@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun,  1 May 2022 21:31:47 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FPU state maintenance is protected by fpregs_lock(), which is a wrapper
around local_bh_disable() on non-RT kernels and preempt_disable() on RT
kernels. In-kernel FPU usage has it's own protection via a per CPU
variable.

This separation is pointless and error-prone as a recently discovered wrong
condition for granting in-kernel FPU usage has shown.

Make the whole FPU state protection simpler and more robust by using the
per CPU usage variable for all FPU operations so state is tracked
consistently.

Change related WARN_ON_FPU() instances to WARN_ON_ONCE() as the usage of
CONFIG_X86_DEBUG_FPU is optional and hides inconsistencies for a
potentially long time.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/fpu/api.h |   17 +-------
 arch/x86/kernel/fpu/core.c     |   78 ++++++++++++++++++++++++++---------------
 2 files changed, 52 insertions(+), 43 deletions(-)

--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -66,21 +66,8 @@ static inline void kernel_fpu_begin(void
  *
  * Disabling preemption also serializes against kernel_fpu_begin().
  */
-static inline void fpregs_lock(void)
-{
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
-		local_bh_disable();
-	else
-		preempt_disable();
-}
-
-static inline void fpregs_unlock(void)
-{
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
-		local_bh_enable();
-	else
-		preempt_enable();
-}
+extern void fpregs_lock(void);
+extern void fpregs_unlock(void);
 
 #ifdef CONFIG_X86_DEBUG_FPU
 extern void fpregs_assert_state_consistent(void);
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -42,7 +42,7 @@ struct fpu_state_config fpu_user_cfg __r
 struct fpstate init_fpstate __ro_after_init;
 
 /* Track in-kernel FPU usage */
-static DEFINE_PER_CPU(bool, in_kernel_fpu);
+static DEFINE_PER_CPU(bool, fpu_in_use);
 
 /*
  * Track which context is using the FPU on the CPU:
@@ -50,6 +50,50 @@ static DEFINE_PER_CPU(bool, in_kernel_fp
 DEFINE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
 
 /**
+ * fpregs_lock - Lock FPU state for maintenance operations
+ *
+ * This protects against preemption, soft interrupts and in-kernel FPU
+ * usage on both !RT and RT enabled kernels.
+ *
+ * !RT kernels use local_bh_disable() to prevent soft interrupt processing
+ * and preemption.
+ *
+ * On RT kernels local_bh_disable() is not sufficient because it only
+ * serializes soft interrupt related sections via a local lock, but stays
+ * preemptible. Disabling preemption is the right choice here as bottom
+ * half processing is always in thread context on RT kernels so it
+ * implicitly prevents bottom half processing as well.
+ */
+void fpregs_lock(void)
+{
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_bh_disable();
+	else
+		preempt_disable();
+
+	WARN_ON_ONCE(this_cpu_read(fpu_in_use));
+	this_cpu_write(fpu_in_use, true);
+}
+EXPORT_SYMBOL_GPL(fpregs_lock);
+
+/**
+ * fpregs_unlock - Unlock FPU state after maintenance operations
+ *
+ * Counterpart to fpregs_lock().
+ */
+void fpregs_unlock(void)
+{
+	WARN_ON_ONCE(!this_cpu_read(fpu_in_use));
+	this_cpu_write(fpu_in_use, false);
+
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_bh_enable();
+	else
+		preempt_enable();
+}
+EXPORT_SYMBOL_GPL(fpregs_unlock);
+
+/**
  * kernel_fpu_usable - Check whether kernel FPU usage is possible
  *
  * Has to be invoked before calling kernel_fpu_begin().
@@ -59,28 +103,7 @@ bool kernel_fpu_usable(void)
 	if (WARN_ON_ONCE(in_nmi()))
 		return false;
 
-	/* In kernel FPU usage already active? */
-	if (this_cpu_read(in_kernel_fpu))
-		return false;
-
-	/*
-	 * When not in NMI or hard interrupt context, FPU can be used:
-	 *
-	 * - Task context is safe except from within fpregs_lock()'ed
-	 *   critical regions.
-	 *
-	 * - Soft interrupt processing context which cannot happen
-	 *   while in a fpregs_lock()'ed critical region.
-	 */
-	if (!in_hardirq())
-		return true;
-
-	/*
-	 * In hard interrupt context it's safe when soft interrupts
-	 * are enabled, which means the interrupt did not hit in
-	 * a fpregs_lock()'ed critical region.
-	 */
-	return !softirq_count();
+	return !this_cpu_read(fpu_in_use);
 }
 EXPORT_SYMBOL(kernel_fpu_usable);
 
@@ -410,10 +433,9 @@ void kernel_fpu_begin_mask(unsigned int
 {
 	preempt_disable();
 
-	WARN_ON_FPU(!kernel_fpu_usable());
-	WARN_ON_FPU(this_cpu_read(in_kernel_fpu));
+	WARN_ON_ONCE(!kernel_fpu_usable());
 
-	this_cpu_write(in_kernel_fpu, true);
+	this_cpu_write(fpu_in_use, true);
 
 	if (!(current->flags & PF_KTHREAD) &&
 	    !test_thread_flag(TIF_NEED_FPU_LOAD)) {
@@ -433,9 +455,9 @@ EXPORT_SYMBOL_GPL(kernel_fpu_begin_mask)
 
 void kernel_fpu_end(void)
 {
-	WARN_ON_FPU(!this_cpu_read(in_kernel_fpu));
+	WARN_ON_ONCE(!this_cpu_read(fpu_in_use));
 
-	this_cpu_write(in_kernel_fpu, false);
+	this_cpu_write(fpu_in_use, false);
 	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(kernel_fpu_end);


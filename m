Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC9C51B4DE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 02:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbiEEA7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 20:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbiEEA7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 20:59:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CCD220DD;
        Wed,  4 May 2022 17:56:00 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651712159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eSaIto3OoJM5YrMehH+RUk/ocOpovvT/T2zd3b8zloI=;
        b=ChjceuLigOKRhGOaZWB+uOck10tzRRlFAxwlYD76YIMBCuXsAm286nVajLayJdWnw+iqxZ
        8sVBWSsusulX9ajW/3koDnXXSkKDADadvNnphdqkMHOutuCH7sJNsLkRKNkAtHbjHsOvsX
        pgskj1XOKoH7BZkJFKKWs6iuaJMKAJ62N0KAcLeluixWjUzviBX8HL4brG5rHAM2E4X5D3
        D35837UGj0+mrbXllfx+Y6GHdEqbNfvLqUOC/YRLK5kWHtGmcZ+gi61wtTrg3smsYhVCVY
        gRa6bVAoOcMPmA5odd24NAD2ZO3QtOs0o5/j4O56TMDJRZWfhphdxTLSn4hubQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651712159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eSaIto3OoJM5YrMehH+RUk/ocOpovvT/T2zd3b8zloI=;
        b=lVdQyaeMu5PyvuVTLXji2iOW7BPTVU4fizmHpDGy4TUHBc5+yZn67cwiYtx4cApGrKXqAG
        prvw0wx8gOs9T4Ag==
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Filipe Manana <fdmanana@suse.com>, linux-crypto@vger.kernel.org
Subject: Re: [patch 3/3] x86/fpu: Make FPU protection more robust
In-Reply-To: <YnMRwPFfvB0RlBow@zx2c4.com>
References: <20220501192740.203963477@linutronix.de>
 <20220501193102.704267030@linutronix.de> <Ym/sHqKqmLOJubgE@zn.tnic>
 <87k0b4lydr.ffs@tglx> <YnDwjjdiSQ5Yml6E@hirez.programming.kicks-ass.net>
 <87fslpjomx.ffs@tglx> <YnKh96isoB7jiFrv@zx2c4.com> <87czgtjlfq.ffs@tglx>
 <YnLOXZp6WgH7ULVU@zx2c4.com> <87wnf1huwj.ffs@tglx>
 <YnMRwPFfvB0RlBow@zx2c4.com>
Date:   Thu, 05 May 2022 02:55:58 +0200
Message-ID: <87mtfwiyqp.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason,

On Thu, May 05 2022 at 01:52, Jason A. Donenfeld wrote:
> On Wed, May 04, 2022 at 11:04:12PM +0200, Thomas Gleixner wrote:
>
>> > The second stance seems easier and more conservative from a certain
>> > perspective -- we don't need to change anything -- so I'm more inclined
>> > toward it.
>> 
>> That's not conservative, that's lazy and lame. Staying with the status
>> quo and piling more stuff on top because we can is just increasing
>> technical debt. Works for a while by some definition of works.
>
> I actually find this minorly upsetting :(.

I'm glad it's only minorly. This was not meant offensive, but I have
heard the "let's be more conservative -- we don't need to change
anything -- " song so many times that it became of of those buttons...

> Considering the amount of technical debt I've been tirelessly cleaning
> up over the last 5 months, "lazy" certainly can't be correct here.

I'm aware of this and I'm thankful that you are tackling these things.

> So if truly the only user of this is random.c as of 5.18 (is it? I'm
> assuming from a not very thorough survey...), and if the performance
> boost doesn't even exist, then yeah, I think it'd make sense to just get
> rid of it, and have kernel_fpu_usable() return false in those cases.
>
> I'll run some benchmarks on a little bit more hardware in representative
> cases and see.

Find below a combo patch which makes use of strict softirq serialization
for the price of not supporting the hardirq FPU usage. 

Thanks,

        tglx
---
diff --git a/arch/um/include/asm/fpu/api.h b/arch/um/include/asm/fpu/api.h
index 71bfd9ef3938..e3deb051b596 100644
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
diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index c83b3020350a..21b7ef7e0cfb 100644
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
@@ -66,21 +66,8 @@ static inline void kernel_fpu_begin(void)
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
diff --git a/arch/x86/include/asm/simd.h b/arch/x86/include/asm/simd.h
index a341c878e977..bdc0629bd987 100644
--- a/arch/x86/include/asm/simd.h
+++ b/arch/x86/include/asm/simd.h
@@ -8,5 +8,5 @@
  */
 static __must_check inline bool may_use_simd(void)
 {
-	return irq_fpu_usable();
+	return kernel_fpu_usable();
 }
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index c049561f373a..7361583a5cfb 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -41,62 +41,127 @@ struct fpu_state_config fpu_user_cfg __ro_after_init;
  */
 struct fpstate init_fpstate __ro_after_init;
 
+/* Track in-kernel FPU usage */
+static DEFINE_PER_CPU(bool, fpu_in_use);
+
 /*
- * Track whether the kernel is using the FPU state
- * currently.
- *
- * This flag is used:
+ * This protects against preemption, soft interrupts and in-kernel FPU
+ * usage on both !RT and RT enabled kernels.
  *
- *   - by IRQ context code to potentially use the FPU
- *     if it's unused.
+ * !RT kernels use local_bh_disable() to prevent soft interrupt processing
+ * and preemption.
  *
- *   - to debug kernel_fpu_begin()/end() correctness
+ * On RT kernels local_bh_disable() is not sufficient because it only
+ * serializes soft interrupt related sections via a local lock, but stays
+ * preemptible. Disabling preemption is the right choice here as bottom
+ * half processing is always in thread context on RT kernels so disabling
+ * preemption implicitly prevents bottom half processing.
  */
-static DEFINE_PER_CPU(bool, in_kernel_fpu);
+static inline void fpu_in_use_begin(void)
+{
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_bh_disable();
+	else
+		preempt_disable();
+
+	WARN_ON_ONCE(__this_cpu_read(fpu_in_use));
+	__this_cpu_write(fpu_in_use, true);
+}
+
+static inline void fpu_in_use_end(void)
+{
+	WARN_ON_ONCE(!__this_cpu_read(fpu_in_use));
+	__this_cpu_write(fpu_in_use, false);
+
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_bh_enable();
+	else
+		preempt_enable();
+}
 
 /*
  * Track which context is using the FPU on the CPU:
  */
 DEFINE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
 
-static bool kernel_fpu_disabled(void)
+/**
+ * fpregs_lock - Lock FPU state for current's FPU state maintenance operations
+ *
+ * For FPU internal usage to initialize, safe, restore FPU state of
+ * the current task. Not for in-kernel FPU usage.
+ */
+void fpregs_lock(void)
 {
-	return this_cpu_read(in_kernel_fpu);
+	fpu_in_use_begin();
 }
+EXPORT_SYMBOL_GPL(fpregs_lock);
 
-static bool interrupted_kernel_fpu_idle(void)
+/**
+ * fpregs_unlock - Unlock FPU state after maintenance operations
+ *
+ * Counterpart to fpregs_lock().
+ */
+void fpregs_unlock(void)
 {
-	return !kernel_fpu_disabled();
+	fpu_in_use_end();
 }
+EXPORT_SYMBOL_GPL(fpregs_unlock);
 
-/*
- * Were we in user mode (or vm86 mode) when we were
- * interrupted?
+/**
+ * kernel_fpu_usable - Check whether kernel FPU usage is possible
  *
- * Doing kernel_fpu_begin/end() is ok if we are running
- * in an interrupt context from user mode - we'll just
- * save the FPU state as required.
+ * Must be checked before calling kernel_fpu_begin().
  */
-static bool interrupted_user_mode(void)
+bool kernel_fpu_usable(void)
 {
-	struct pt_regs *regs = get_irq_regs();
-	return regs && user_mode(regs);
+	if (WARN_ON_ONCE(in_nmi()))
+		return false;
+
+	return !in_hardirq() && !this_cpu_read(fpu_in_use);
 }
+EXPORT_SYMBOL(kernel_fpu_usable);
 
-/*
- * Can we use the FPU in kernel mode with the
- * whole "kernel_fpu_begin/end()" sequence?
+/**
+ * kernel_fpu_begin_mask - Start a in-kernel FPU usage section
+ * @kfpu_mask:		Bitmask to indicate initialization requirements
  *
- * It's always ok in process context (ie "not interrupt")
- * but it is sometimes ok even from an irq.
+ * Has to be invoked before in-kernel FPU usage. This saves the current
+ * tasks FPU register state if necessary and initializes MXCSR and/or the
+ * legacy FPU depending on @kfpu_mask.
+ *
+ * The function returns with softirqs disabled, so the call site has to
+ * ensure that the FPU usage is limited in terms of runtime.
  */
-bool irq_fpu_usable(void)
+void kernel_fpu_begin_mask(unsigned int kfpu_mask)
 {
-	return !in_interrupt() ||
-		interrupted_user_mode() ||
-		interrupted_kernel_fpu_idle();
+	fpu_in_use_begin();
+
+	if (!(current->flags & PF_KTHREAD) &&
+	    !test_thread_flag(TIF_NEED_FPU_LOAD)) {
+		set_thread_flag(TIF_NEED_FPU_LOAD);
+		save_fpregs_to_fpstate(&current->thread.fpu);
+	}
+	__cpu_invalidate_fpregs_state();
+
+	/* Put sane initial values into the control registers. */
+	if (likely(kfpu_mask & KFPU_MXCSR) && boot_cpu_has(X86_FEATURE_XMM))
+		ldmxcsr(MXCSR_DEFAULT);
+
+	if (unlikely(kfpu_mask & KFPU_387) && boot_cpu_has(X86_FEATURE_FPU))
+		asm volatile ("fninit");
 }
-EXPORT_SYMBOL(irq_fpu_usable);
+EXPORT_SYMBOL_GPL(kernel_fpu_begin_mask);
+
+/**
+ * kernel_fpu_end - End a in-kernel FPU usage section
+ *
+ * Counterpart to kernel_fpu_begin_mask().
+ */
+void kernel_fpu_end(void)
+{
+	fpu_in_use_end();
+}
+EXPORT_SYMBOL_GPL(kernel_fpu_end);
 
 /*
  * Track AVX512 state use because it is known to slow the max clock
@@ -420,40 +485,6 @@ int fpu_copy_uabi_to_guest_fpstate(struct fpu_guest *gfpu, const void *buf,
 EXPORT_SYMBOL_GPL(fpu_copy_uabi_to_guest_fpstate);
 #endif /* CONFIG_KVM */
 
-void kernel_fpu_begin_mask(unsigned int kfpu_mask)
-{
-	preempt_disable();
-
-	WARN_ON_FPU(!irq_fpu_usable());
-	WARN_ON_FPU(this_cpu_read(in_kernel_fpu));
-
-	this_cpu_write(in_kernel_fpu, true);
-
-	if (!(current->flags & PF_KTHREAD) &&
-	    !test_thread_flag(TIF_NEED_FPU_LOAD)) {
-		set_thread_flag(TIF_NEED_FPU_LOAD);
-		save_fpregs_to_fpstate(&current->thread.fpu);
-	}
-	__cpu_invalidate_fpregs_state();
-
-	/* Put sane initial values into the control registers. */
-	if (likely(kfpu_mask & KFPU_MXCSR) && boot_cpu_has(X86_FEATURE_XMM))
-		ldmxcsr(MXCSR_DEFAULT);
-
-	if (unlikely(kfpu_mask & KFPU_387) && boot_cpu_has(X86_FEATURE_FPU))
-		asm volatile ("fninit");
-}
-EXPORT_SYMBOL_GPL(kernel_fpu_begin_mask);
-
-void kernel_fpu_end(void)
-{
-	WARN_ON_FPU(!this_cpu_read(in_kernel_fpu));
-
-	this_cpu_write(in_kernel_fpu, false);
-	preempt_enable();
-}
-EXPORT_SYMBOL_GPL(kernel_fpu_end);
-
 /*
  * Sync the FPU register state to current's memory register state when the
  * current task owns the FPU. The hardware register state is preserved.
diff --git a/net/netfilter/nft_set_pipapo_avx2.c b/net/netfilter/nft_set_pipapo_avx2.c
index 52e0d026d30a..dde1d2260f51 100644
--- a/net/netfilter/nft_set_pipapo_avx2.c
+++ b/net/netfilter/nft_set_pipapo_avx2.c
@@ -1128,7 +1128,7 @@ bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 	bool map_index;
 	int i, ret = 0;
 
-	if (unlikely(!irq_fpu_usable()))
+	if (unlikely(!kernel_fpu_usable()))
 		return nft_pipapo_lookup(net, set, key, ext);
 
 	m = rcu_dereference(priv->match);

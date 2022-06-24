Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC53655976B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 12:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiFXKLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 06:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbiFXKLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 06:11:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43CE7A6D8;
        Fri, 24 Jun 2022 03:11:50 -0700 (PDT)
Date:   Fri, 24 Jun 2022 12:11:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1656065507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=csDPMOXNFgDIJIk3DugQUJIEzimRXTNd5s+pvEzXB4w=;
        b=4enjfq/+p0F3vdgkMD+3kAyD93qRyu+CniLJG8ban8XZvBGalao2v9qYCcizq3dwKEqCXD
        nWscu2uWerrJumEcD+y3RZQ5BZP1WDyUQJZrPJ5Xxkls/pS0Kf8eZYUj7HpBGeGeAbNaf1
        uD9q657lIif7YntoJeE6dDEdc35hTpjR84zV9S5oIh+/QnpcYheQ61xjkL0NulS557zP2V
        LXBiKlBOUT5kZla8XOHhf4IYW0sz8ywoq1qWVKkaQ/uBc51uml0gnCBZh7kCFv0otBWAXQ
        j+fgHSod9IYE924rA+4cdjgc0660zhwik4wAce5Ca7a1MM4m0QmYHMlDza7lyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1656065507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=csDPMOXNFgDIJIk3DugQUJIEzimRXTNd5s+pvEzXB4w=;
        b=wBBSjgvwP+L9MzdnwGcRvEiXdtD9sh3WJFGpqimiFcC7yQSipQWPwqUIefftgIyTSoU/ZV
        7cUAlsbOxrzMAFBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.19-rc3-rt5
Message-ID: <YrWN4gP70wUtLpQk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.19-rc3-rt5 patch set. 

Changes since v5.19-rc3-rt4:

  - Merge the "disable softirqs stack" patch that was applied upstream.

  - Merge the "don't disable preemption" patch that was applied
    upstream.

  - Slighly update the signal and ptrace patch. There is no visible
    change code wise.

  - Backport a patch from upstream to address a kfence warning. Reported
    by Mike Galbraith, patch by Jason A. Donenfeld.

Known issues
     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

The delta patch against v5.19-rc3-rt4 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.19/incr/patch-5.19-rc3-rt4-rt5.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.19-rc3-rt5

The RT patch against v5.19-rc3 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.19/older/patch-5.19-rc3-rt5.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.19/older/patches-5.19-rc3-rt5.tar.xz

Sebastian

diff --git a/arch/parisc/kernel/irq.c b/arch/parisc/kernel/irq.c
index 0fe2d79fb123f..eba193bcdab1b 100644
--- a/arch/parisc/kernel/irq.c
+++ b/arch/parisc/kernel/irq.c
@@ -480,10 +480,12 @@ static void execute_on_irq_stack(void *func, unsigned long param1)
 	*irq_stack_in_use = 1;
 }
 
+#ifndef CONFIG_PREEMPT_RT
 void do_softirq_own_stack(void)
 {
 	execute_on_irq_stack(__do_softirq, 0);
 }
+#endif
 #endif /* CONFIG_IRQSTACKS */
 
 /* ONLY called from entry.S:intr_extint() */
diff --git a/arch/s390/include/asm/softirq_stack.h b/arch/s390/include/asm/softirq_stack.h
index fd17f25704bd5..af68d6c1d5840 100644
--- a/arch/s390/include/asm/softirq_stack.h
+++ b/arch/s390/include/asm/softirq_stack.h
@@ -5,9 +5,10 @@
 #include <asm/lowcore.h>
 #include <asm/stacktrace.h>
 
+#ifndef CONFIG_PREEMPT_RT
 static inline void do_softirq_own_stack(void)
 {
 	call_on_stack(0, S390_lowcore.async_stack, void, __do_softirq);
 }
-
+#endif
 #endif /* __ASM_S390_SOFTIRQ_STACK_H */
diff --git a/block/blk-mq.c b/block/blk-mq.c
index cc4c56ff1d473..dafe6cdeaf63b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2085,14 +2085,10 @@ static void __blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async,
 		return;
 
 	if (!async && !(hctx->flags & BLK_MQ_F_BLOCKING)) {
-		migrate_disable();
 		if (cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask)) {
 			__blk_mq_run_hw_queue(hctx);
-			migrate_enable();
 			return;
 		}
-
-		migrate_enable();
 	}
 
 	kblockd_mod_delayed_work_on(blk_mq_hctx_next_cpu(hctx), &hctx->run_work,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index be53049028a13..1d4660a1915b3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3345,20 +3345,22 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 		 * is actually now running somewhere else!
 		 */
 		while (task_running(rq, p)) {
+
 			if (match_state) {
+				bool mismatch = false;
+#ifndef CONFIG_PREEMPT_RT
+				if (READ_ONCE(p->__state != match_state)
+					mismatch = true;
+#else
 				unsigned long flags;
-				bool missmatch = false;
 
 				raw_spin_lock_irqsave(&p->pi_lock, flags);
-#ifdef CONFIG_PREEMPT_RT
-				if ((READ_ONCE(p->__state) != match_state) &&
-				    (READ_ONCE(p->saved_state) != match_state))
-#else
-				if (READ_ONCE(p->__state) != match_state)
-#endif
-					missmatch = true;
+				if (READ_ONCE(p->__state) != match_state &&
+				    READ_ONCE(p->saved_state) != match_state)
+					mismatch = true;
 				raw_spin_unlock_irqrestore(&p->pi_lock, flags);
-				if (missmatch)
+#endif
+				if (mismatch)
 					return 0;
 			}
 			cpu_relax();
diff --git a/kernel/signal.c b/kernel/signal.c
index efd0fae3313bf..2a8622620d221 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2294,8 +2294,16 @@ static int ptrace_stop(int exit_code, int why, unsigned long message,
 	if (gstop_done && (!current->ptrace || ptrace_reparented(current)))
 		do_notify_parent_cldstop(current, false, why);
 
+	/*
+	 * Don't want to allow preemption here, because
+	 * sys_ptrace() needs this task to be inactive.
+	 */
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
 	read_unlock(&tasklist_lock);
 	cgroup_enter_frozen();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable_no_resched();
 	freezable_schedule();
 	cgroup_leave_frozen(true);
 
diff --git a/localversion-rt b/localversion-rt
index ad3da1bcab7e8..0efe7ba1930e1 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt4
+-rt5
diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 4e7cd4c8e687e..4b5e5a3d3a638 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -360,6 +360,9 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
 	unsigned long flags;
 	struct slab *slab;
 	void *addr;
+	const bool random_right_allocate = prandom_u32_max(2);
+	const bool random_fault = CONFIG_KFENCE_STRESS_TEST_FAULTS &&
+				  !prandom_u32_max(CONFIG_KFENCE_STRESS_TEST_FAULTS);
 
 	/* Try to obtain a free object. */
 	raw_spin_lock_irqsave(&kfence_freelist_lock, flags);
@@ -404,7 +407,7 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
 	 * is that the out-of-bounds accesses detected are deterministic for
 	 * such allocations.
 	 */
-	if (prandom_u32_max(2)) {
+	if (random_right_allocate) {
 		/* Allocate on the "right" side, re-calculate address. */
 		meta->addr += PAGE_SIZE - size;
 		meta->addr = ALIGN_DOWN(meta->addr, cache->align);
@@ -444,7 +447,7 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
 	if (cache->ctor)
 		cache->ctor(addr);
 
-	if (CONFIG_KFENCE_STRESS_TEST_FAULTS && !prandom_u32_max(CONFIG_KFENCE_STRESS_TEST_FAULTS))
+	if (random_fault)
 		kfence_protect(meta->addr); /* Random "faults" by protecting the object. */
 
 	atomic_long_inc(&counters[KFENCE_COUNTER_ALLOCATED]);

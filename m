Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771ED4FF7AA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 15:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235785AbiDMNdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 09:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235772AbiDMNd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 09:33:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260145D5E7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 06:31:07 -0700 (PDT)
Message-ID: <20220413133024.356509586@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649856665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=hndER118dmw7kYMFXyYuvsxJ9ycP9/DqyDamURXJ4cA=;
        b=nToUJbUjDp19tCC34fQsnLD80e9uEBpO6zMUv2CRiM2HdiUcrw6ShlgSs0RR8zYhBtZM7I
        XoTBDDcW2ZjEI94wQCnCc3V2oksdyEOz6lSaLbQJbRyhPEuuBDsDySfaDJtXA0r+89HD6P
        8AHc51vIafk+7BjKQAdtV+lFhwP6BdrkvdEsq8CwdAxgRDEBJWQ5GKIKAZhLyD4hMS0pTP
        wTcanuYI8LKoYa5yHp6avlOz/TNQ90Z6i1OiMC5HAOWauJONZeirom5YaIBt6Dyyse9Gcj
        CofXuJjtUlvaUyGI9ljjspjT/7mWAIE/zYYrTNVc3QqhNbmHXsa1nCgIq9ncRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649856665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=hndER118dmw7kYMFXyYuvsxJ9ycP9/DqyDamURXJ4cA=;
        b=mLHAnQn7pfVUUdyiJeOfFeqs6VtT74Sa7alLmxpMHxKolNUfcSJeQWITHXz1Q3c8Ommqha
        WD+dTyHgejoZYgCw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch V5 3/3] smp: Make softirq handling RT safe in
 flush_smp_call_function_queue()
References: <20220413132836.099363044@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 13 Apr 2022 15:31:05 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

flush_smp_call_function_queue() invokes do_softirq() which is not available
on PREEMPT_RT. flush_smp_call_function_queue() is invoked from the idle
task and the migration task with preemption or interrupts disabled.

So RT kernels cannot process soft interrupts in that context as that has to
acquire 'sleeping spinlocks' which is not possible with preemption or
interrupts disabled and forbidden from the idle task anyway.

The currently known SMP function call which raises a soft interrupt is in
the block layer, but this functionality is not enabled on RT kernels due to
latency and performance reasons.

RT could wake up ksoftirqd unconditionally, but this wants to be avoided if
there were soft interrupts pending already when this is invoked in the
context of the migration task. The migration task might have preempted a
threaded interrupt handler which raised a soft interrupt, but did not reach
the local_bh_enable() to process it. The "running" ksoftirqd might prevent
the handling in the interrupt thread context which is causing latency
issues.

Add a new function which handles this case explicitely for RT and falls
back to do_softirq() on !RT kernels. In the RT case this warns when one of
the flushed SMP function calls raised a soft interrupt so this can be
investigated.

[ tglx: Moved the RT part out of SMP code ]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/YgKgL6aPj8aBES6G@linutronix.de
---
v4:
  - Move the RT logic into softirq.c which also avoids the wakeup
    when softinterrupts are disabled. The enable will handle
    them anyway.
v3:
   - Only wake ksoftirqd if the softirqs were raised wthin
     flush_smp_call_function_queue().
   - Add a warning in the wake case.
v2: Drop an empty line.

 include/linux/interrupt.h |    9 +++++++++
 kernel/smp.c              |    5 ++++-
 kernel/softirq.c          |   13 +++++++++++++
 3 files changed, 26 insertions(+), 1 deletion(-)
---

--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -607,6 +607,15 @@ struct softirq_action
 asmlinkage void do_softirq(void);
 asmlinkage void __do_softirq(void);
 
+#ifdef CONFIG_PREEMPT_RT
+extern void do_softirq_post_smp_call_flush(unsigned int was_pending);
+#else
+static inline void do_softirq_post_smp_call_flush(unsigned int unused)
+{
+	do_softirq();
+}
+#endif
+
 extern void open_softirq(int nr, void (*action)(struct softirq_action *));
 extern void softirq_init(void);
 extern void __raise_softirq_irqoff(unsigned int nr);
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -696,6 +696,7 @@ static void __flush_smp_call_function_qu
  */
 void flush_smp_call_function_queue(void)
 {
+	unsigned int was_pending;
 	unsigned long flags;
 
 	if (llist_empty(this_cpu_ptr(&call_single_queue)))
@@ -704,9 +705,11 @@ void flush_smp_call_function_queue(void)
 	cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->idle, CFD_SEQ_NOCPU,
 		      smp_processor_id(), CFD_SEQ_IDLE);
 	local_irq_save(flags);
+	/* Get the already pending soft interrupts for RT enabled kernels */
+	was_pending = local_softirq_pending();
 	__flush_smp_call_function_queue(true);
 	if (local_softirq_pending())
-		do_softirq();
+		do_softirq_post_smp_call_flush(was_pending);
 
 	local_irq_restore(flags);
 }
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -294,6 +294,19 @@ static inline void invoke_softirq(void)
 		wakeup_softirqd();
 }
 
+/*
+ * flush_smp_call_function_queue() can raise a soft interrupt in a function
+ * call. On RT kernels this is undesired and the only known functionality
+ * in the block layer which does this is disabled on RT. If soft interrupts
+ * get raised which haven't been raised before the flush, warn so it can be
+ * investigated.
+ */
+void softirq_post_smp_call_flush(unsigned int was_pending)
+{
+	if (WARN_ON_ONCE(was_pending != local_softirq_pending()))
+		invoke_softirq();
+}
+
 #else /* CONFIG_PREEMPT_RT */
 
 /*


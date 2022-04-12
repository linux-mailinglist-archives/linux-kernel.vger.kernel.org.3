Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DBF4FE9BA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 22:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiDLU5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 16:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiDLU5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 16:57:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DB0C9B41
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 13:52:25 -0700 (PDT)
Message-ID: <20220412204353.712177025@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649796708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=hndER118dmw7kYMFXyYuvsxJ9ycP9/DqyDamURXJ4cA=;
        b=AmRwcY/LhGb9vNhP+WyUubPJbFc+2etjHtIp065eY+h3wqeHg6fkEeELkQDzX6b8Gwryoe
        Iqmxq2EcM6m4fWPmRGDklO0XngB85nyLrEQNvuVhR8IyuiKGroEaUO0oDaYSfUpIkQqoaD
        G3zdaN69kbndjLQgIT7cfKZUj3JOaw95laXDMqttXE5sRBoiSam80uq0KbSURbjqYbMZcq
        9ZSvI1ufcF3vOSEhpXUpnUWCRdCSZZ7rSWshUSn8OTyupuY4gLz+xXjJt/SFV1OENIR2cT
        xdopFgHYmq3GpawN5imMJD1pbEtE/jyndrweg1cclKmRz8tmdcgt3wkRVP7mGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649796708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=hndER118dmw7kYMFXyYuvsxJ9ycP9/DqyDamURXJ4cA=;
        b=RKZPDyIMtrgo2N2+DgcPZfB7tgeC4aJOd42vo0AKwK+Ehwfs2V4TgjDl9RWxJChp5NVyFN
        /nm4BKohR+tNKjBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch V4 2/2] smp: Make softirq handling RT safe in
 flush_smp_call_function_queue()
References: <20220412203649.956258017@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 12 Apr 2022 22:51:48 +0200 (CEST)
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3233E516290
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 10:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244106AbiEAIJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 04:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244156AbiEAII6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 04:08:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEC7BC9A;
        Sun,  1 May 2022 01:05:30 -0700 (PDT)
Date:   Sun, 01 May 2022 08:05:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651392328;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VO070gCuZJTgdUPpsLphHxZNRwVJ9QxlBcypKnh0Pk8=;
        b=ajJ7IMD9RViTurNoBkm3MWui+gO5eDx5wDr2/kF+dmDapqkpuJfKCWv2Tu29ilhd3yB+B3
        /0iDaVY+4nrinG5YoG+flDZpmEpEAhFJkzJtOaFnuG1kFGhXtjTqKuaZl8S83HUcBFtS4f
        rygz90CRHICVk4EbzlmlvXNTAVkAzA4cRMYNzD7dJVa4pMtzHRO0qfroXkCyhCc8NVS0mh
        GZD8FVC/+l8GKc4B2Bjmf3cC09qI0jXhWXe7fsafyxUWuXT1zgYrUsyxNyGPLyYA2I0fKV
        5ODRvVC0PmVStI207nTss5T3zhJ7tQKDuyU5vSzRn2qjhWcwx4HBcKvnpmDXUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651392328;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VO070gCuZJTgdUPpsLphHxZNRwVJ9QxlBcypKnh0Pk8=;
        b=UMd9eTYLrTLxkw4ZEbA5MIxTbCtOdg6GoqhHqBb4lbhPmGA6j8OEM+mF9gt65pjztHmR3h
        WkkbyQCypfW6gABw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] smp: Make softirq handling RT safe in
 flush_smp_call_function_queue()
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YgKgL6aPj8aBES6G@linutronix.de>
References: <YgKgL6aPj8aBES6G@linutronix.de>
MIME-Version: 1.0
Message-ID: <165139232730.4207.638214050053913440.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1a90bfd220201fbe050dfc15deaac20ca5f15638
Gitweb:        https://git.kernel.org/tip/1a90bfd220201fbe050dfc15deaac20ca5f15638
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 13 Apr 2022 15:31:05 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 01 May 2022 10:03:43 +02:00

smp: Make softirq handling RT safe in flush_smp_call_function_queue()

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
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/YgKgL6aPj8aBES6G@linutronix.de
Link: https://lore.kernel.org/r/20220413133024.356509586@linutronix.de

---
 include/linux/interrupt.h |  9 +++++++++
 kernel/smp.c              |  5 ++++-
 kernel/softirq.c          | 13 +++++++++++++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index f40754c..a49fe8d 100644
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
diff --git a/kernel/smp.c b/kernel/smp.c
index 8e85f22..d54c2fe 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -696,6 +696,7 @@ static void __flush_smp_call_function_queue(bool warn_cpu_offline)
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
diff --git a/kernel/softirq.c b/kernel/softirq.c
index fac8018..9f0aef8 100644
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
+void do_softirq_post_smp_call_flush(unsigned int was_pending)
+{
+	if (WARN_ON_ONCE(was_pending != local_softirq_pending()))
+		invoke_softirq();
+}
+
 #else /* CONFIG_PREEMPT_RT */
 
 /*

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3B151628E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 10:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239452AbiEAIJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 04:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244147AbiEAII6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 04:08:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409601B7AD;
        Sun,  1 May 2022 01:05:30 -0700 (PDT)
Date:   Sun, 01 May 2022 08:05:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651392329;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FMMsyxDebCqcfMfUt3x2z0M4LYkBUArkvhpibzV5ukg=;
        b=q39xNY4UoNiNb5L5kmlYYrjtrTDDUAtYn3yZw9csr1V2iXmUFXZqg/DnKwbZkVqqzVK1eR
        faqcqt+V4wG80BEK4H8UDPKBfHJ2BU5t/XlrjsVXijmV7btM78X3K7Meh7PP2OHjTa9sov
        KvYVWVGInBkbEhNHkxWUDFQmeCnZb+S5Ddds6mjmEbkjk0N/oCmSYahZdBuF18tEp95zRm
        lo9BoLMC/88uP+yxGRW9J3y0PpsKceglQNoeoEQQhD8ypGdhWzzdFLAZkhGNNDX98jJ+Xl
        SVWjL3CZMzlYQ+CwQevId1uTOXhMoL4g4RqnHg9HVT2z3AE1ZGUClf+D2KQ1Rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651392329;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FMMsyxDebCqcfMfUt3x2z0M4LYkBUArkvhpibzV5ukg=;
        b=C0CWj8nNW4zUsozU9GuKL2bMJAuQfAmLhQPQheoVX/LsG/5lg+H5zi7/S/z/EPaPZk+2/i
        danOB9iw/uV1SJCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] smp: Rename flush_smp_call_function_from_idle()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220413133024.305001096@linutronix.de>
References: <20220413133024.305001096@linutronix.de>
MIME-Version: 1.0
Message-ID: <165139232833.4207.2835999584883686606.tip-bot2@tip-bot2>
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

Commit-ID:     16bf5a5e1ec56474ed2a19d72f272ed09a5d3ea1
Gitweb:        https://git.kernel.org/tip/16bf5a5e1ec56474ed2a19d72f272ed09a5d3ea1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 13 Apr 2022 15:31:03 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 01 May 2022 10:03:43 +02:00

smp: Rename flush_smp_call_function_from_idle()

This is invoked from the stopper thread too, which is definitely not idle.
Rename it to flush_smp_call_function_queue() and fixup the callers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220413133024.305001096@linutronix.de

---
 kernel/sched/core.c |  2 +-
 kernel/sched/idle.c |  2 +-
 kernel/sched/smp.h  |  4 ++--
 kernel/smp.c        | 27 ++++++++++++++++++++-------
 4 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e644578..07bacb0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2411,7 +2411,7 @@ static int migration_cpu_stop(void *data)
 	 * __migrate_task() such that we will not miss enforcing cpus_ptr
 	 * during wakeups, see set_cpus_allowed_ptr()'s TASK_WAKING test.
 	 */
-	flush_smp_call_function_from_idle();
+	flush_smp_call_function_queue();
 
 	raw_spin_lock(&p->pi_lock);
 	rq_lock(rq, &rf);
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 8f8b502..60295db 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -327,7 +327,7 @@ static void do_idle(void)
 	 * RCU relies on this call to be done outside of an RCU read-side
 	 * critical section.
 	 */
-	flush_smp_call_function_from_idle();
+	flush_smp_call_function_queue();
 	schedule_idle();
 
 	if (unlikely(klp_patch_pending(current)))
diff --git a/kernel/sched/smp.h b/kernel/sched/smp.h
index 5719bf9..2eb23dd 100644
--- a/kernel/sched/smp.h
+++ b/kernel/sched/smp.h
@@ -9,7 +9,7 @@ extern void sched_ttwu_pending(void *arg);
 extern void send_call_function_single_ipi(int cpu);
 
 #ifdef CONFIG_SMP
-extern void flush_smp_call_function_from_idle(void);
+extern void flush_smp_call_function_queue(void);
 #else
-static inline void flush_smp_call_function_from_idle(void) { }
+static inline void flush_smp_call_function_queue(void) { }
 #endif
diff --git a/kernel/smp.c b/kernel/smp.c
index 01a7c17..8e85f22 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -96,7 +96,7 @@ static DEFINE_PER_CPU_ALIGNED(struct call_function_data, cfd_data);
 
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct llist_head, call_single_queue);
 
-static void flush_smp_call_function_queue(bool warn_cpu_offline);
+static void __flush_smp_call_function_queue(bool warn_cpu_offline);
 
 int smpcfd_prepare_cpu(unsigned int cpu)
 {
@@ -141,7 +141,7 @@ int smpcfd_dying_cpu(unsigned int cpu)
 	 * ensure that the outgoing CPU doesn't go offline with work
 	 * still pending.
 	 */
-	flush_smp_call_function_queue(false);
+	__flush_smp_call_function_queue(false);
 	irq_work_run();
 	return 0;
 }
@@ -541,11 +541,11 @@ void generic_smp_call_function_single_interrupt(void)
 {
 	cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->gotipi, CFD_SEQ_NOCPU,
 		      smp_processor_id(), CFD_SEQ_GOTIPI);
-	flush_smp_call_function_queue(true);
+	__flush_smp_call_function_queue(true);
 }
 
 /**
- * flush_smp_call_function_queue - Flush pending smp-call-function callbacks
+ * __flush_smp_call_function_queue - Flush pending smp-call-function callbacks
  *
  * @warn_cpu_offline: If set to 'true', warn if callbacks were queued on an
  *		      offline CPU. Skip this check if set to 'false'.
@@ -558,7 +558,7 @@ void generic_smp_call_function_single_interrupt(void)
  * Loop through the call_single_queue and run all the queued callbacks.
  * Must be called with interrupts disabled.
  */
-static void flush_smp_call_function_queue(bool warn_cpu_offline)
+static void __flush_smp_call_function_queue(bool warn_cpu_offline)
 {
 	call_single_data_t *csd, *csd_next;
 	struct llist_node *entry, *prev;
@@ -681,7 +681,20 @@ static void flush_smp_call_function_queue(bool warn_cpu_offline)
 		      smp_processor_id(), CFD_SEQ_HDLEND);
 }
 
-void flush_smp_call_function_from_idle(void)
+
+/**
+ * flush_smp_call_function_queue - Flush pending smp-call-function callbacks
+ *				   from task context (idle, migration thread)
+ *
+ * When TIF_POLLING_NRFLAG is supported and a CPU is in idle and has it
+ * set, then remote CPUs can avoid sending IPIs and wake the idle CPU by
+ * setting TIF_NEED_RESCHED. The idle task on the woken up CPU has to
+ * handle queued SMP function calls before scheduling.
+ *
+ * The migration thread has to ensure that an eventually pending wakeup has
+ * been handled before it migrates a task.
+ */
+void flush_smp_call_function_queue(void)
 {
 	unsigned long flags;
 
@@ -691,7 +704,7 @@ void flush_smp_call_function_from_idle(void)
 	cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->idle, CFD_SEQ_NOCPU,
 		      smp_processor_id(), CFD_SEQ_IDLE);
 	local_irq_save(flags);
-	flush_smp_call_function_queue(true);
+	__flush_smp_call_function_queue(true);
 	if (local_softirq_pending())
 		do_softirq();
 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421994FE9BE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 22:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiDLU51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 16:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiDLU5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 16:57:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582F61480F3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 13:52:24 -0700 (PDT)
Message-ID: <20220412204353.655068649@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649796707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=fMHxW+I+DB5whhm2iNZXozQYgZvT3uBymP8I1OaqnYo=;
        b=Pm6IDzVTfJMphP8dUyw7QekdepbBvV0tCoeXvtoWvD7MB4gXsW8LI7rUNc2EvRQKBRIE4U
        XVg7rZUewqymqVzX7uQTFKhysxz5AEYTvvlB/3P7ftM8oLziYB+v10dQlMDx0LQvqkGfKi
        TnHVaBdklr+JuzXrTs2SA88miQvc01c67+53qb5ADsm4slqUtOkXNa+KCj2GDQldm40V/I
        Wy+AYssgsnXky2NctYFfEkZzXOItVlKfrXA5tyG1ibH+Cnk9ZFsOAqbgq5UfOBpSm4cMVL
        cVLWaLuD/+f+DfwCFJahq9b1m/ebemQv8ztAUcSmQaa2trg4Lj9uNL5LG/Fg9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649796707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=fMHxW+I+DB5whhm2iNZXozQYgZvT3uBymP8I1OaqnYo=;
        b=B8LvWhv7tWGrAsm5jFRabEbTRYAjPohDeRTte93V6vyXkvGMaQzU4sz9Fxdq+NZ76P2IEN
        Fjuryv73X5VPedBg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch V4 1/2] smp: Rename flush_smp_call_function_from_idle()
References: <20220412203649.956258017@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 12 Apr 2022 22:51:46 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is invoked from the stopper thread too, which is definitely not idle.
Rename it to flush_smp_call_function_queue() and fixup the callers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V4: New patch
---
 kernel/sched/core.c  |    2 +-
 kernel/sched/idle.c  |    2 +-
 kernel/sched/sched.h |    4 ++--
 kernel/smp.c         |   27 ++++++++++++++++++++-------
 4 files changed, 24 insertions(+), 11 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2408,7 +2408,7 @@ static int migration_cpu_stop(void *data
 	 * __migrate_task() such that we will not miss enforcing cpus_ptr
 	 * during wakeups, see set_cpus_allowed_ptr()'s TASK_WAKING test.
 	 */
-	flush_smp_call_function_from_idle();
+	flush_smp_call_function_queue();
 
 	raw_spin_lock(&p->pi_lock);
 	rq_lock(rq, &rf);
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
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1834,10 +1834,10 @@ static inline void dirty_sched_domain_sy
 
 extern int sched_update_scaling(void);
 
-extern void flush_smp_call_function_from_idle(void);
+extern void flush_smp_call_function_queue(void);
 
 #else /* !CONFIG_SMP: */
-static inline void flush_smp_call_function_from_idle(void) { }
+static inline void flush_smp_call_function_queue(void) { }
 #endif
 
 #include "stats.h"
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -96,7 +96,7 @@ static DEFINE_PER_CPU_ALIGNED(struct cal
 
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
@@ -541,11 +541,11 @@ void generic_smp_call_function_single_in
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
@@ -558,7 +558,7 @@ void generic_smp_call_function_single_in
  * Loop through the call_single_queue and run all the queued callbacks.
  * Must be called with interrupts disabled.
  */
-static void flush_smp_call_function_queue(bool warn_cpu_offline)
+static void __flush_smp_call_function_queue(bool warn_cpu_offline)
 {
 	call_single_data_t *csd, *csd_next;
 	struct llist_node *entry, *prev;
@@ -681,7 +681,20 @@ static void flush_smp_call_function_queu
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
 
@@ -691,7 +704,7 @@ void flush_smp_call_function_from_idle(v
 	cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->idle, CFD_SEQ_NOCPU,
 		      smp_processor_id(), CFD_SEQ_IDLE);
 	local_irq_save(flags);
-	flush_smp_call_function_queue(true);
+	__flush_smp_call_function_queue(true);
 	if (local_softirq_pending())
 		do_softirq();
 


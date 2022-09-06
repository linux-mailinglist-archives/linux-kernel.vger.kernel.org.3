Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D195ADDBC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 05:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238202AbiIFDF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 23:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbiIFDFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 23:05:51 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1B926AD8
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 20:05:48 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id u5so3131084qvv.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 20:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=xrztfIBxcLZWqAo3sXNQleEud0dZnB3eo/plRJ1W6mA=;
        b=opmOb+ChFUsMQweShBsLbhTJh8og9Q/SOgxSiVbZTR9VdNPa5i0VHO9DRe/NsEj8BX
         Q8PxypvOvKsraFLXBy6l+fgcdK0DWBtEQdRKjUHy7ScgO28A+jzYIkEACMUyl5ETLZt4
         KBbC2QdRoI0zqhJR/kqwL2oStoSmvtaimaRqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=xrztfIBxcLZWqAo3sXNQleEud0dZnB3eo/plRJ1W6mA=;
        b=K5KeJ2ijNczlQ993kWhfjoy3bSb6i7gJ09y/1NcwfflR7eBVfYVjUQcMO4qrw8uGCa
         rm9Q4zOkh9QUX4mio2NcT6g+5Q8CMKVgIHQZoqMHJO8WUmlVd0slLB8Tn57xZulZ5p+R
         uHQuvR8olkKw2oruEJv0NCFOPHvPjN4UPc7VtACcVtlLeImdH6kyETf2F0TKA2n2LkZo
         ksmqAz+FevHStx11Z1a7BUZerY5Wv2Ozp4QV5UzGCScdfYtrBaUIYuRexXts8hJ156zT
         IXnwB3cgNMN4sz545V7tIyT49p9iuFThtw70mVwEvKhUN2FIpeqWPdDbm8eyj/x2RDo8
         xxqg==
X-Gm-Message-State: ACgBeo2cSSlrrM6uA3nZlhVzlQH+R3Mw8wOB/vA00ctat5BmpXV851YZ
        7rc+PsY8yC2a4Qh843a4f4D+4A==
X-Google-Smtp-Source: AA6agR41kGQSi3/YdSTwShwxLQSHfISA+GvvAih14XmpOwXuJkp47U8Zf8jpZSWmwSQSojcD54p32Q==
X-Received: by 2002:a05:6214:768:b0:499:aed:e635 with SMTP id f8-20020a056214076800b004990aede635mr32830059qvz.11.1662433546984;
        Mon, 05 Sep 2022 20:05:46 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id c4-20020ac84e04000000b00344f936bfc0sm8300185qtw.33.2022.09.05.20.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 20:05:46 -0700 (PDT)
Date:   Tue, 6 Sep 2022 03:05:46 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org, boqun.feng@gmail.com
Subject: Re: [PATCH v5 06/18] rcu: Introduce call_rcu_lazy() API
 implementation
Message-ID: <Yxa5Ch574cRZxRdo@google.com>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-7-joel@joelfernandes.org>
 <20220902152132.GA115525@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902152132.GA115525@lothringen>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 05:21:32PM +0200, Frederic Weisbecker wrote:
> On Thu, Sep 01, 2022 at 10:17:08PM +0000, Joel Fernandes (Google) wrote:
> > Implement timer-based RCU lazy callback batching. The batch is flushed
> > whenever a certain amount of time has passed, or the batch on a
> > particular CPU grows too big. Also memory pressure will flush it in a
> > future patch.
> > 
> > To handle several corner cases automagically (such as rcu_barrier() and
> > hotplug), we re-use bypass lists to handle lazy CBs. The bypass list
> > length has the lazy CB length included in it. A separate lazy CB length
> > counter is also introduced to keep track of the number of lazy CBs.
> > 
> > Suggested-by: Paul McKenney <paulmck@kernel.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---

Here is the updated version of this patch for further testing and review.
Paul, you could consider updating your test branch. I have tested it in
ChromeOS as well, and rcuscale. The laziness and boot times are looking good.
There was at least one bug that I fixed that got introduced with the moving
of the length field to rcu_data.  Thanks a lot Frederic for the review
comments.

I will look at the rcu torture issue next... I suspect the length field issue
may have been causing it.

---8<-----------------------

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v6] rcu: Introduce call_rcu_lazy() API implementation

Implement timer-based RCU lazy callback batching. The batch is flushed
whenever a certain amount of time has passed, or the batch on a
particular CPU grows too big. Also memory pressure will flush it in a
future patch.

To handle several corner cases automagically (such as rcu_barrier() and
hotplug), we re-use bypass lists to handle lazy CBs. The bypass list
length has the lazy CB length included in it. A separate lazy CB length
counter is also introduced to keep track of the number of lazy CBs.

v5->v6:

[ Frederic Weisbec: Program the lazy timer only if WAKE_NOT, since other
  deferral levels wake much earlier so for those it is not needed. ]

[ Frederic Weisbec: Use flush flags to keep bypass API code clean. ]

[ Joel: Fix issue where I was not resetting lazy_len after moving it to rdp ]

Suggested-by: Paul McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/rcupdate.h |   6 ++
 kernel/rcu/Kconfig       |   8 ++
 kernel/rcu/rcu.h         |  11 +++
 kernel/rcu/tree.c        | 133 +++++++++++++++++++----------
 kernel/rcu/tree.h        |  17 +++-
 kernel/rcu/tree_nocb.h   | 175 ++++++++++++++++++++++++++++++++-------
 6 files changed, 269 insertions(+), 81 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 08605ce7379d..82e8a07e0856 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -108,6 +108,12 @@ static inline int rcu_preempt_depth(void)
 
 #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
 
+#ifdef CONFIG_RCU_LAZY
+void call_rcu_lazy(struct rcu_head *head, rcu_callback_t func);
+#else
+#define call_rcu_lazy(head, func) call_rcu(head, func)
+#endif
+
 /* Internal to kernel */
 void rcu_init(void);
 extern int rcu_scheduler_active;
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index d471d22a5e21..3128d01427cb 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -311,4 +311,12 @@ config TASKS_TRACE_RCU_READ_MB
 	  Say N here if you hate read-side memory barriers.
 	  Take the default if you are unsure.
 
+config RCU_LAZY
+	bool "RCU callback lazy invocation functionality"
+	depends on RCU_NOCB_CPU
+	default n
+	help
+	  To save power, batch RCU callbacks and flush after delay, memory
+	  pressure or callback list growing too big.
+
 endmenu # "RCU Subsystem"
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index be5979da07f5..94675f14efe8 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -474,6 +474,14 @@ enum rcutorture_type {
 	INVALID_RCU_FLAVOR
 };
 
+#if defined(CONFIG_RCU_LAZY)
+unsigned long rcu_lazy_get_jiffies_till_flush(void);
+void rcu_lazy_set_jiffies_till_flush(unsigned long j);
+#else
+static inline unsigned long rcu_lazy_get_jiffies_till_flush(void) { return 0; }
+static inline void rcu_lazy_set_jiffies_till_flush(unsigned long j) { }
+#endif
+
 #if defined(CONFIG_TREE_RCU)
 void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
 			    unsigned long *gp_seq);
@@ -483,6 +491,8 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
 			       unsigned long c_old,
 			       unsigned long c);
 void rcu_gp_set_torture_wait(int duration);
+void rcu_force_call_rcu_to_lazy(bool force);
+
 #else
 static inline void rcutorture_get_gp_data(enum rcutorture_type test_type,
 					  int *flags, unsigned long *gp_seq)
@@ -501,6 +511,7 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
 	do { } while (0)
 #endif
 static inline void rcu_gp_set_torture_wait(int duration) { }
+static inline void rcu_force_call_rcu_to_lazy(bool force) { }
 #endif
 
 #if IS_ENABLED(CONFIG_RCU_TORTURE_TEST) || IS_MODULE(CONFIG_RCU_TORTURE_TEST)
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9fe581be8696..dbd25b8c080e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2728,47 +2728,8 @@ static void check_cb_ovld(struct rcu_data *rdp)
 	raw_spin_unlock_rcu_node(rnp);
 }
 
-/**
- * call_rcu() - Queue an RCU callback for invocation after a grace period.
- * @head: structure to be used for queueing the RCU updates.
- * @func: actual callback function to be invoked after the grace period
- *
- * The callback function will be invoked some time after a full grace
- * period elapses, in other words after all pre-existing RCU read-side
- * critical sections have completed.  However, the callback function
- * might well execute concurrently with RCU read-side critical sections
- * that started after call_rcu() was invoked.
- *
- * RCU read-side critical sections are delimited by rcu_read_lock()
- * and rcu_read_unlock(), and may be nested.  In addition, but only in
- * v5.0 and later, regions of code across which interrupts, preemption,
- * or softirqs have been disabled also serve as RCU read-side critical
- * sections.  This includes hardware interrupt handlers, softirq handlers,
- * and NMI handlers.
- *
- * Note that all CPUs must agree that the grace period extended beyond
- * all pre-existing RCU read-side critical section.  On systems with more
- * than one CPU, this means that when "func()" is invoked, each CPU is
- * guaranteed to have executed a full memory barrier since the end of its
- * last RCU read-side critical section whose beginning preceded the call
- * to call_rcu().  It also means that each CPU executing an RCU read-side
- * critical section that continues beyond the start of "func()" must have
- * executed a memory barrier after the call_rcu() but before the beginning
- * of that RCU read-side critical section.  Note that these guarantees
- * include CPUs that are offline, idle, or executing in user mode, as
- * well as CPUs that are executing in the kernel.
- *
- * Furthermore, if CPU A invoked call_rcu() and CPU B invoked the
- * resulting RCU callback function "func()", then both CPU A and CPU B are
- * guaranteed to execute a full memory barrier during the time interval
- * between the call to call_rcu() and the invocation of "func()" -- even
- * if CPU A and CPU B are the same CPU (but again only if the system has
- * more than one CPU).
- *
- * Implementation of these memory-ordering guarantees is described here:
- * Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst.
- */
-void call_rcu(struct rcu_head *head, rcu_callback_t func)
+static void
+__call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy)
 {
 	static atomic_t doublefrees;
 	unsigned long flags;
@@ -2818,7 +2779,7 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
 		trace_rcu_callback(rcu_state.name, head,
 				   rcu_segcblist_n_cbs(&rdp->cblist));
 
-	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags))
+	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags, lazy))
 		return; // Enqueued onto ->nocb_bypass, so just leave.
 	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
 	rcu_segcblist_enqueue(&rdp->cblist, head);
@@ -2833,8 +2794,86 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
 		local_irq_restore(flags);
 	}
 }
-EXPORT_SYMBOL_GPL(call_rcu);
 
+#ifdef CONFIG_RCU_LAZY
+/**
+ * call_rcu_lazy() - Lazily queue RCU callback for invocation after grace period.
+ * @head: structure to be used for queueing the RCU updates.
+ * @func: actual callback function to be invoked after the grace period
+ *
+ * The callback function will be invoked some time after a full grace
+ * period elapses, in other words after all pre-existing RCU read-side
+ * critical sections have completed.
+ *
+ * Use this API instead of call_rcu() if you don't mind the callback being
+ * invoked after very long periods of time on systems without memory pressure
+ * and on systems which are lightly loaded or mostly idle.
+ *
+ * Other than the extra delay in callbacks being invoked, this function is
+ * identical to, and reuses call_rcu()'s logic. Refer to call_rcu() for more
+ * details about memory ordering and other functionality.
+ */
+void call_rcu_lazy(struct rcu_head *head, rcu_callback_t func)
+{
+	return __call_rcu_common(head, func, true);
+}
+EXPORT_SYMBOL_GPL(call_rcu_lazy);
+#endif
+
+static bool force_call_rcu_to_lazy;
+
+void rcu_force_call_rcu_to_lazy(bool force)
+{
+	if (IS_ENABLED(CONFIG_RCU_SCALE_TEST))
+		WRITE_ONCE(force_call_rcu_to_lazy, force);
+}
+EXPORT_SYMBOL_GPL(rcu_force_call_rcu_to_lazy);
+
+/**
+ * call_rcu() - Queue an RCU callback for invocation after a grace period.
+ * @head: structure to be used for queueing the RCU updates.
+ * @func: actual callback function to be invoked after the grace period
+ *
+ * The callback function will be invoked some time after a full grace
+ * period elapses, in other words after all pre-existing RCU read-side
+ * critical sections have completed.  However, the callback function
+ * might well execute concurrently with RCU read-side critical sections
+ * that started after call_rcu() was invoked.
+ *
+ * RCU read-side critical sections are delimited by rcu_read_lock()
+ * and rcu_read_unlock(), and may be nested.  In addition, but only in
+ * v5.0 and later, regions of code across which interrupts, preemption,
+ * or softirqs have been disabled also serve as RCU read-side critical
+ * sections.  This includes hardware interrupt handlers, softirq handlers,
+ * and NMI handlers.
+ *
+ * Note that all CPUs must agree that the grace period extended beyond
+ * all pre-existing RCU read-side critical section.  On systems with more
+ * than one CPU, this means that when "func()" is invoked, each CPU is
+ * guaranteed to have executed a full memory barrier since the end of its
+ * last RCU read-side critical section whose beginning preceded the call
+ * to call_rcu().  It also means that each CPU executing an RCU read-side
+ * critical section that continues beyond the start of "func()" must have
+ * executed a memory barrier after the call_rcu() but before the beginning
+ * of that RCU read-side critical section.  Note that these guarantees
+ * include CPUs that are offline, idle, or executing in user mode, as
+ * well as CPUs that are executing in the kernel.
+ *
+ * Furthermore, if CPU A invoked call_rcu() and CPU B invoked the
+ * resulting RCU callback function "func()", then both CPU A and CPU B are
+ * guaranteed to execute a full memory barrier during the time interval
+ * between the call to call_rcu() and the invocation of "func()" -- even
+ * if CPU A and CPU B are the same CPU (but again only if the system has
+ * more than one CPU).
+ *
+ * Implementation of these memory-ordering guarantees is described here:
+ * Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst.
+ */
+void call_rcu(struct rcu_head *head, rcu_callback_t func)
+{
+	return __call_rcu_common(head, func, force_call_rcu_to_lazy);
+}
+EXPORT_SYMBOL_GPL(call_rcu);
 
 /* Maximum number of jiffies to wait before draining a batch. */
 #define KFREE_DRAIN_JIFFIES (5 * HZ)
@@ -3904,7 +3943,11 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 	rdp->barrier_head.func = rcu_barrier_callback;
 	debug_rcu_head_queue(&rdp->barrier_head);
 	rcu_nocb_lock(rdp);
-	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
+        /*
+         * Flush the bypass list, but also wake up the GP thread as otherwise
+         * bypass/lazy CBs maynot be noticed, and can cause real long delays!
+         */
+	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, FLUSH_BP_WAKE));
 	if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
 		atomic_inc(&rcu_state.barrier_cpu_count);
 	} else {
@@ -4325,7 +4368,7 @@ void rcutree_migrate_callbacks(int cpu)
 	my_rdp = this_cpu_ptr(&rcu_data);
 	my_rnp = my_rdp->mynode;
 	rcu_nocb_lock(my_rdp); /* irqs already disabled. */
-	WARN_ON_ONCE(!rcu_nocb_flush_bypass(my_rdp, NULL, jiffies));
+	WARN_ON_ONCE(!rcu_nocb_flush_bypass(my_rdp, NULL, jiffies, FLUSH_BP_NONE));
 	raw_spin_lock_rcu_node(my_rnp); /* irqs already disabled. */
 	/* Leverage recent GPs and set GP for new callbacks. */
 	needwake = rcu_advance_cbs(my_rnp, rdp) ||
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index d4a97e40ea9c..361c41d642c7 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -263,14 +263,16 @@ struct rcu_data {
 	unsigned long last_fqs_resched;	/* Time of last rcu_resched(). */
 	unsigned long last_sched_clock;	/* Jiffies of last rcu_sched_clock_irq(). */
 
+	long lazy_len;			/* Length of buffered lazy callbacks. */
 	int cpu;
 };
 
 /* Values for nocb_defer_wakeup field in struct rcu_data. */
 #define RCU_NOCB_WAKE_NOT	0
 #define RCU_NOCB_WAKE_BYPASS	1
-#define RCU_NOCB_WAKE		2
-#define RCU_NOCB_WAKE_FORCE	3
+#define RCU_NOCB_WAKE_LAZY	2
+#define RCU_NOCB_WAKE		3
+#define RCU_NOCB_WAKE_FORCE	4
 
 #define RCU_JIFFIES_TILL_FORCE_QS (1 + (HZ > 250) + (HZ > 500))
 					/* For jiffies_till_first_fqs and */
@@ -439,10 +441,17 @@ static void zero_cpu_stall_ticks(struct rcu_data *rdp);
 static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
 static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
 static void rcu_init_one_nocb(struct rcu_node *rnp);
+
+#define FLUSH_BP_NONE 0
+/* Is the CB being enqueued after the flush, a lazy CB? */
+#define FLUSH_BP_LAZY BIT(0)
+/* Wake up nocb-GP thread after flush? */
+#define FLUSH_BP_WAKE BIT(1)
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
-				  unsigned long j);
+				  unsigned long j, unsigned long flush_flags);
 static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
-				bool *was_alldone, unsigned long flags);
+				bool *was_alldone, unsigned long flags,
+				bool lazy);
 static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_empty,
 				 unsigned long flags);
 static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp, int level);
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 4dc86274b3e8..b201606f7c4f 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -256,6 +256,31 @@ static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
 	return __wake_nocb_gp(rdp_gp, rdp, force, flags);
 }
 
+/*
+ * LAZY_FLUSH_JIFFIES decides the maximum amount of time that
+ * can elapse before lazy callbacks are flushed. Lazy callbacks
+ * could be flushed much earlier for a number of other reasons
+ * however, LAZY_FLUSH_JIFFIES will ensure no lazy callbacks are
+ * left unsubmitted to RCU after those many jiffies.
+ */
+#define LAZY_FLUSH_JIFFIES (10 * HZ)
+unsigned long jiffies_till_flush = LAZY_FLUSH_JIFFIES;
+
+#ifdef CONFIG_RCU_LAZY
+// To be called only from test code.
+void rcu_lazy_set_jiffies_till_flush(unsigned long jif)
+{
+	jiffies_till_flush = jif;
+}
+EXPORT_SYMBOL(rcu_lazy_set_jiffies_till_flush);
+
+unsigned long rcu_lazy_get_jiffies_till_flush(void)
+{
+	return jiffies_till_flush;
+}
+EXPORT_SYMBOL(rcu_lazy_get_jiffies_till_flush);
+#endif
+
 /*
  * Arrange to wake the GP kthread for this NOCB group at some future
  * time when it is safe to do so.
@@ -269,10 +294,14 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
 	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
 
 	/*
-	 * Bypass wakeup overrides previous deferments. In case
-	 * of callback storm, no need to wake up too early.
+	 * Bypass wakeup overrides previous deferments. In case of
+	 * callback storm, no need to wake up too early.
 	 */
-	if (waketype == RCU_NOCB_WAKE_BYPASS) {
+	if (waketype == RCU_NOCB_WAKE_LAZY
+		&& READ_ONCE(rdp->nocb_defer_wakeup) == RCU_NOCB_WAKE_NOT) {
+		mod_timer(&rdp_gp->nocb_timer, jiffies + jiffies_till_flush);
+		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
+	} else if (waketype == RCU_NOCB_WAKE_BYPASS) {
 		mod_timer(&rdp_gp->nocb_timer, jiffies + 2);
 		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
 	} else {
@@ -293,12 +322,16 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
  * proves to be initially empty, just return false because the no-CB GP
  * kthread may need to be awakened in this case.
  *
+ * Return true if there was something to be flushed and it succeeded, otherwise
+ * false.
+ *
  * Note that this function always returns true if rhp is NULL.
  */
 static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
-				     unsigned long j)
+				     unsigned long j, unsigned long flush_flags)
 {
 	struct rcu_cblist rcl;
+	bool lazy = flush_flags & FLUSH_BP_LAZY;
 
 	WARN_ON_ONCE(!rcu_rdp_is_offloaded(rdp));
 	rcu_lockdep_assert_cblist_protected(rdp);
@@ -310,7 +343,20 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	/* Note: ->cblist.len already accounts for ->nocb_bypass contents. */
 	if (rhp)
 		rcu_segcblist_inc_len(&rdp->cblist); /* Must precede enqueue. */
-	rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
+
+	/*
+	 * If the new CB requested was a lazy one, queue it onto the main
+	 * ->cblist so we can take advantage of a sooner grade period.
+	 */
+	if (lazy && rhp) {
+		rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, NULL);
+		rcu_cblist_enqueue(&rcl, rhp);
+		WRITE_ONCE(rdp->lazy_len, 0);
+	} else {
+		rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
+		WRITE_ONCE(rdp->lazy_len, 0);
+	}
+
 	rcu_segcblist_insert_pend_cbs(&rdp->cblist, &rcl);
 	WRITE_ONCE(rdp->nocb_bypass_first, j);
 	rcu_nocb_bypass_unlock(rdp);
@@ -326,13 +372,20 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
  * Note that this function always returns true if rhp is NULL.
  */
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
-				  unsigned long j)
+				  unsigned long j, unsigned long flush_flags)
 {
+	bool ret;
+
 	if (!rcu_rdp_is_offloaded(rdp))
 		return true;
 	rcu_lockdep_assert_cblist_protected(rdp);
 	rcu_nocb_bypass_lock(rdp);
-	return rcu_nocb_do_flush_bypass(rdp, rhp, j);
+	ret = rcu_nocb_do_flush_bypass(rdp, rhp, j, flush_flags);
+
+	if (flush_flags & FLUSH_BP_WAKE)
+		wake_nocb_gp(rdp, true);
+
+	return ret;
 }
 
 /*
@@ -345,7 +398,7 @@ static void rcu_nocb_try_flush_bypass(struct rcu_data *rdp, unsigned long j)
 	if (!rcu_rdp_is_offloaded(rdp) ||
 	    !rcu_nocb_bypass_trylock(rdp))
 		return;
-	WARN_ON_ONCE(!rcu_nocb_do_flush_bypass(rdp, NULL, j));
+	WARN_ON_ONCE(!rcu_nocb_do_flush_bypass(rdp, NULL, j, FLUSH_BP_NONE));
 }
 
 /*
@@ -367,12 +420,14 @@ static void rcu_nocb_try_flush_bypass(struct rcu_data *rdp, unsigned long j)
  * there is only one CPU in operation.
  */
 static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
-				bool *was_alldone, unsigned long flags)
+				bool *was_alldone, unsigned long flags,
+				bool lazy)
 {
 	unsigned long c;
 	unsigned long cur_gp_seq;
 	unsigned long j = jiffies;
 	long ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
+	bool bypass_is_lazy = (ncbs == READ_ONCE(rdp->lazy_len));
 
 	lockdep_assert_irqs_disabled();
 
@@ -417,25 +472,30 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	// If there hasn't yet been all that many ->cblist enqueues
 	// this jiffy, tell the caller to enqueue onto ->cblist.  But flush
 	// ->nocb_bypass first.
-	if (rdp->nocb_nobypass_count < nocb_nobypass_lim_per_jiffy) {
+	// Lazy CBs throttle this back and do immediate bypass queuing.
+	if (rdp->nocb_nobypass_count < nocb_nobypass_lim_per_jiffy && !lazy) {
 		rcu_nocb_lock(rdp);
 		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
 		if (*was_alldone)
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("FirstQ"));
-		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j));
+
+		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j, FLUSH_BP_NONE));
 		WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
 		return false; // Caller must enqueue the callback.
 	}
 
 	// If ->nocb_bypass has been used too long or is too full,
 	// flush ->nocb_bypass to ->cblist.
-	if ((ncbs && j != READ_ONCE(rdp->nocb_bypass_first)) ||
+	if ((ncbs && !bypass_is_lazy && j != READ_ONCE(rdp->nocb_bypass_first)) ||
+	    (ncbs &&  bypass_is_lazy &&
+		(time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies_till_flush))) ||
 	    ncbs >= qhimark) {
 		rcu_nocb_lock(rdp);
 		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
 
-		if (!rcu_nocb_flush_bypass(rdp, rhp, j)) {
+		if (!rcu_nocb_flush_bypass(rdp, rhp, j,
+					   lazy ? FLUSH_BP_LAZY : FLUSH_BP_NONE)) {
 			if (*was_alldone)
 				trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 						    TPS("FirstQ"));
@@ -461,16 +521,29 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	// We need to use the bypass.
 	rcu_nocb_wait_contended(rdp);
 	rcu_nocb_bypass_lock(rdp);
+
 	ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
 	rcu_segcblist_inc_len(&rdp->cblist); /* Must precede enqueue. */
 	rcu_cblist_enqueue(&rdp->nocb_bypass, rhp);
+
+	if (IS_ENABLED(CONFIG_RCU_LAZY) && lazy)
+		WRITE_ONCE(rdp->lazy_len, rdp->lazy_len + 1);
+
 	if (!ncbs) {
 		WRITE_ONCE(rdp->nocb_bypass_first, j);
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("FirstBQ"));
 	}
+
 	rcu_nocb_bypass_unlock(rdp);
 	smp_mb(); /* Order enqueue before wake. */
-	if (ncbs) {
+
+	// We had CBs in the bypass list before. There is nothing else to do if:
+	// There were only non-lazy CBs before, in this case, the bypass timer
+	// or GP-thread will handle the CBs including any new lazy ones.
+	// Or, the new CB is lazy and the old bypass-CBs were also lazy. In this
+	// case the old lazy timer would have been setup. When that expires,
+	// the new lazy one will be handled.
+	if (ncbs && (!bypass_is_lazy || lazy)) {
 		local_irq_restore(flags);
 	} else {
 		// No-CBs GP kthread might be indefinitely asleep, if so, wake.
@@ -479,6 +552,10 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("FirstBQwake"));
 			__call_rcu_nocb_wake(rdp, true, flags);
+		} else if (bypass_is_lazy && !lazy) {
+			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
+					    TPS("FirstBQwakeLazy2Non"));
+			__call_rcu_nocb_wake(rdp, true, flags);
 		} else {
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("FirstBQnoWake"));
@@ -500,7 +577,7 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 {
 	unsigned long cur_gp_seq;
 	unsigned long j;
-	long len;
+	long len, lazy_len, bypass_len;
 	struct task_struct *t;
 
 	// If we are being polled or there is no kthread, just leave.
@@ -513,9 +590,16 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 	}
 	// Need to actually to a wakeup.
 	len = rcu_segcblist_n_cbs(&rdp->cblist);
+	bypass_len = rcu_cblist_n_cbs(&rdp->nocb_bypass);
+	lazy_len = READ_ONCE(rdp->lazy_len);
 	if (was_alldone) {
 		rdp->qlen_last_fqs_check = len;
-		if (!irqs_disabled_flags(flags)) {
+		// Only lazy CBs in bypass list
+		if (lazy_len && bypass_len == lazy_len) {
+			rcu_nocb_unlock_irqrestore(rdp, flags);
+			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_LAZY,
+					   TPS("WakeLazy"));
+		} else if (!irqs_disabled_flags(flags)) {
 			/* ... if queue was empty ... */
 			rcu_nocb_unlock_irqrestore(rdp, flags);
 			wake_nocb_gp(rdp, false);
@@ -605,8 +689,8 @@ static void nocb_gp_sleep(struct rcu_data *my_rdp, int cpu)
  */
 static void nocb_gp_wait(struct rcu_data *my_rdp)
 {
-	bool bypass = false;
-	long bypass_ncbs;
+	bool bypass = false, lazy = false;
+	long bypass_ncbs, lazy_ncbs;
 	int __maybe_unused cpu = my_rdp->cpu;
 	unsigned long cur_gp_seq;
 	unsigned long flags;
@@ -641,24 +725,41 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 	 * won't be ignored for long.
 	 */
 	list_for_each_entry(rdp, &my_rdp->nocb_head_rdp, nocb_entry_rdp) {
+		bool flush_bypass = false;
+
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"));
 		rcu_nocb_lock_irqsave(rdp, flags);
 		lockdep_assert_held(&rdp->nocb_lock);
 		bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
-		if (bypass_ncbs &&
+		lazy_ncbs = READ_ONCE(rdp->lazy_len);
+
+		if (bypass_ncbs && (lazy_ncbs == bypass_ncbs) &&
+		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies_till_flush) ||
+		     bypass_ncbs > 2 * qhimark)) {
+			flush_bypass = true;
+		} else if (bypass_ncbs && (lazy_ncbs != bypass_ncbs) &&
 		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + 1) ||
 		     bypass_ncbs > 2 * qhimark)) {
-			// Bypass full or old, so flush it.
-			(void)rcu_nocb_try_flush_bypass(rdp, j);
-			bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
+			flush_bypass = true;
 		} else if (!bypass_ncbs && rcu_segcblist_empty(&rdp->cblist)) {
 			rcu_nocb_unlock_irqrestore(rdp, flags);
 			continue; /* No callbacks here, try next. */
 		}
+
+		if (flush_bypass) {
+			// Bypass full or old, so flush it.
+			(void)rcu_nocb_try_flush_bypass(rdp, j);
+			bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
+			lazy_ncbs = READ_ONCE(rdp->lazy_len);
+		}
+
 		if (bypass_ncbs) {
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
-					    TPS("Bypass"));
-			bypass = true;
+				    bypass_ncbs == lazy_ncbs ? TPS("Lazy") : TPS("Bypass"));
+			if (bypass_ncbs == lazy_ncbs)
+				lazy = true;
+			else
+				bypass = true;
 		}
 		rnp = rdp->mynode;
 
@@ -706,12 +807,21 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 	my_rdp->nocb_gp_gp = needwait_gp;
 	my_rdp->nocb_gp_seq = needwait_gp ? wait_gp_seq : 0;
 
-	if (bypass && !rcu_nocb_poll) {
-		// At least one child with non-empty ->nocb_bypass, so set
-		// timer in order to avoid stranding its callbacks.
-		wake_nocb_gp_defer(my_rdp, RCU_NOCB_WAKE_BYPASS,
-				   TPS("WakeBypassIsDeferred"));
+	// At least one child with non-empty ->nocb_bypass, so set
+	// timer in order to avoid stranding its callbacks.
+	if (!rcu_nocb_poll) {
+		// If bypass list only has lazy CBs. Add a deferred
+		// lazy wake up.
+		if (lazy && !bypass) {
+			wake_nocb_gp_defer(my_rdp, RCU_NOCB_WAKE_LAZY,
+					TPS("WakeLazyIsDeferred"));
+		// Otherwise add a deferred bypass wake up.
+		} else if (bypass) {
+			wake_nocb_gp_defer(my_rdp, RCU_NOCB_WAKE_BYPASS,
+					TPS("WakeBypassIsDeferred"));
+		}
 	}
+
 	if (rcu_nocb_poll) {
 		/* Polling, so trace if first poll in the series. */
 		if (gotcbs)
@@ -1037,7 +1147,7 @@ static long rcu_nocb_rdp_deoffload(void *arg)
 	 * return false, which means that future calls to rcu_nocb_try_bypass()
 	 * will refuse to put anything into the bypass.
 	 */
-	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
+	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, FLUSH_BP_NONE));
 	/*
 	 * Start with invoking rcu_core() early. This way if the current thread
 	 * happens to preempt an ongoing call to rcu_core() in the middle,
@@ -1291,6 +1401,7 @@ static void __init rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp)
 	raw_spin_lock_init(&rdp->nocb_gp_lock);
 	timer_setup(&rdp->nocb_timer, do_nocb_deferred_wakeup_timer, 0);
 	rcu_cblist_init(&rdp->nocb_bypass);
+	WRITE_ONCE(rdp->lazy_len, 0);
 	mutex_init(&rdp->nocb_gp_kthread_mutex);
 }
 
@@ -1572,13 +1683,13 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
 }
 
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
-				  unsigned long j)
+				  unsigned long j, unsigned long flush_flags)
 {
 	return true;
 }
 
 static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
-				bool *was_alldone, unsigned long flags)
+				bool *was_alldone, unsigned long flags, bool lazy)
 {
 	return false;
 }
-- 
2.37.2.789.g6183377224-goog


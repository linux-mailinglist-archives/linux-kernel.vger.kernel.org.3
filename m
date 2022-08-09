Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2BA58D276
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 05:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbiHIDqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 23:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbiHIDpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 23:45:31 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23335DDA
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 20:45:25 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id h22so7965807qta.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 20:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6vzODQCSamwcBaoIAB0oU6qXyD58O6jqri9X5LXTnJs=;
        b=Ztj5gy3sqPK583JAxNxAnhztdi/Tose+cm8X3tkF3EtPIPn/4G6XjnuNpcFZaypgpZ
         u1PC1ua9NQky+Dg9a6rEc1d1X0Er8jwCiDh5VLN7wYIsZcRa/G9lNdW37wlgSfrwnLUF
         +IO36HZlHA/+CyukEpkdFI1L2qpeJigAmK9KY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6vzODQCSamwcBaoIAB0oU6qXyD58O6jqri9X5LXTnJs=;
        b=6QVorWi/JVXA7ksm1j5NaVkPt0c676GgsC7sCPQ1WkZu+UU8ccAK+yOF1sHYYm+yd3
         xbKrxdIPIR4STNtSJFwngR6VBmFcjyvw1nFZUkfOGDIR+DStzPxuWKpQgdWpTKtMNegm
         iOhRCIBI7fQSMaAdxWXOlBcsDiZRH9s0aXweEOOY1BcpqzR6Q+mBrz+Gd38e/xtQu4lw
         IU2fHL7POodCizlHJSmd0p1S5aah3FZ/LUnpU9xvPlIqjAinn7FfvibCc7IWscLtKmwB
         Z8jey4pHhART1mEdtgQ4Ef0jIt2oafUtXDmRtGiwB9x53bTj/dtlyQLVq32/mS2L/EXu
         uPOA==
X-Gm-Message-State: ACgBeo0Gms0KT0YgcqVKxYF+/V5KQKd2RqhM2j+5H+4Q5NHIZ7qR1Hi9
        txhJHPjS6qb1r04ybG261WAVHefTdur0aQ==
X-Google-Smtp-Source: AA6agR6LO4FGq/ba+/9dbxS6Xy149wW+pCUr7QRpc6Kko18Y5SmKFq86Kxkq9u3xeaTdcngnXeAoag==
X-Received: by 2002:ac8:5f54:0:b0:31f:4cbf:b2ad with SMTP id y20-20020ac85f54000000b0031f4cbfb2admr19230491qta.474.1660016723646;
        Mon, 08 Aug 2022 20:45:23 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id ca8-20020a05622a1f0800b0031f0b43629dsm9170979qtb.23.2022.08.08.20.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 20:45:23 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Paul McKenney <paulmck@kernel.org>,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        rcu@vger.kernel.org
Subject: [PATCH v3 resend 1/6] rcu: Introduce call_rcu_lazy() API implementation
Date:   Tue,  9 Aug 2022 03:45:12 +0000
Message-Id: <20220809034517.3867176-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
In-Reply-To: <20220809034517.3867176-1-joel@joelfernandes.org>
References: <20220809034517.3867176-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement timer-based RCU lazy callback batching. The batch is flushed
whenever a certain amount of time has passed, or the batch on a
particular CPU grows too big. Also memory pressure will flush it in a
future patch.

To handle several corner cases automagically (such as rcu_barrier() and
hotplug), we re-use bypass lists to handle lazy CBs. The bypass list
length has the lazy CB length included in it. A separate lazy CB length
counter is also introduced to keep track of the number of lazy CBs.

Suggested-by: Paul McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/rcu_segcblist.h |   1 +
 include/linux/rcupdate.h      |   6 ++
 kernel/rcu/Kconfig            |   8 ++
 kernel/rcu/rcu.h              |  11 ++
 kernel/rcu/rcu_segcblist.c    |  15 ++-
 kernel/rcu/rcu_segcblist.h    |  20 +++-
 kernel/rcu/tree.c             | 130 +++++++++++++++---------
 kernel/rcu/tree.h             |  10 +-
 kernel/rcu/tree_nocb.h        | 185 ++++++++++++++++++++++++++--------
 9 files changed, 289 insertions(+), 97 deletions(-)

diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
index 659d13a7ddaa..9a992707917b 100644
--- a/include/linux/rcu_segcblist.h
+++ b/include/linux/rcu_segcblist.h
@@ -22,6 +22,7 @@ struct rcu_cblist {
 	struct rcu_head *head;
 	struct rcu_head **tail;
 	long len;
+	long lazy_len;
 };
 
 #define RCU_CBLIST_INITIALIZER(n) { .head = NULL, .tail = &n.head }
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 1a32036c918c..9191a3d88087 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -82,6 +82,12 @@ static inline int rcu_preempt_depth(void)
 
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
index 27aab870ae4c..779b6e84006b 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -293,4 +293,12 @@ config TASKS_TRACE_RCU_READ_MB
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
index 4916077119f3..608f6ab76c7f 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -463,6 +463,14 @@ enum rcutorture_type {
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
@@ -472,6 +480,8 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
 			       unsigned long c_old,
 			       unsigned long c);
 void rcu_gp_set_torture_wait(int duration);
+void rcu_force_call_rcu_to_lazy(bool force);
+
 #else
 static inline void rcutorture_get_gp_data(enum rcutorture_type test_type,
 					  int *flags, unsigned long *gp_seq)
@@ -490,6 +500,7 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
 	do { } while (0)
 #endif
 static inline void rcu_gp_set_torture_wait(int duration) { }
+static inline void rcu_force_call_rcu_to_lazy(bool force) { }
 #endif
 
 #if IS_ENABLED(CONFIG_RCU_TORTURE_TEST) || IS_MODULE(CONFIG_RCU_TORTURE_TEST)
diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index c54ea2b6a36b..776647cd2d6c 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -20,16 +20,21 @@ void rcu_cblist_init(struct rcu_cblist *rclp)
 	rclp->head = NULL;
 	rclp->tail = &rclp->head;
 	rclp->len = 0;
+	rclp->lazy_len = 0;
 }
 
 /*
  * Enqueue an rcu_head structure onto the specified callback list.
  */
-void rcu_cblist_enqueue(struct rcu_cblist *rclp, struct rcu_head *rhp)
+void rcu_cblist_enqueue(struct rcu_cblist *rclp, struct rcu_head *rhp,
+			bool lazy)
 {
 	*rclp->tail = rhp;
 	rclp->tail = &rhp->next;
 	WRITE_ONCE(rclp->len, rclp->len + 1);
+
+	if (IS_ENABLED(CONFIG_RCU_LAZY) && lazy)
+		WRITE_ONCE(rclp->lazy_len, rclp->lazy_len + 1);
 }
 
 /*
@@ -38,11 +43,12 @@ void rcu_cblist_enqueue(struct rcu_cblist *rclp, struct rcu_head *rhp)
  * element of the second rcu_cblist structure, but ensuring that the second
  * rcu_cblist structure, if initially non-empty, always appears non-empty
  * throughout the process.  If rdp is NULL, the second rcu_cblist structure
- * is instead initialized to empty.
+ * is instead initialized to empty. Also account for lazy_len for lazy CBs.
  */
 void rcu_cblist_flush_enqueue(struct rcu_cblist *drclp,
 			      struct rcu_cblist *srclp,
-			      struct rcu_head *rhp)
+			      struct rcu_head *rhp,
+			      bool lazy)
 {
 	drclp->head = srclp->head;
 	if (drclp->head)
@@ -58,6 +64,9 @@ void rcu_cblist_flush_enqueue(struct rcu_cblist *drclp,
 		srclp->tail = &rhp->next;
 		WRITE_ONCE(srclp->len, 1);
 	}
+
+	if (IS_ENABLED(CONFIG_RCU_LAZY) && rhp && lazy)
+		WRITE_ONCE(srclp->lazy_len, 1);
 }
 
 /*
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 431cee212467..8e90b34adb00 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -15,14 +15,30 @@ static inline long rcu_cblist_n_cbs(struct rcu_cblist *rclp)
 	return READ_ONCE(rclp->len);
 }
 
+/* Return number of callbacks in the specified callback list. */
+static inline long rcu_cblist_n_lazy_cbs(struct rcu_cblist *rclp)
+{
+	if (IS_ENABLED(CONFIG_RCU_LAZY))
+		return READ_ONCE(rclp->lazy_len);
+	return 0;
+}
+
+static inline void rcu_cblist_reset_lazy_len(struct rcu_cblist *rclp)
+{
+	if (IS_ENABLED(CONFIG_RCU_LAZY))
+		WRITE_ONCE(rclp->lazy_len, 0);
+}
+
 /* Return number of callbacks in segmented callback list by summing seglen. */
 long rcu_segcblist_n_segment_cbs(struct rcu_segcblist *rsclp);
 
 void rcu_cblist_init(struct rcu_cblist *rclp);
-void rcu_cblist_enqueue(struct rcu_cblist *rclp, struct rcu_head *rhp);
+void rcu_cblist_enqueue(struct rcu_cblist *rclp, struct rcu_head *rhp,
+			bool lazy);
 void rcu_cblist_flush_enqueue(struct rcu_cblist *drclp,
 			      struct rcu_cblist *srclp,
-			      struct rcu_head *rhp);
+			      struct rcu_head *rhp,
+			      bool lazy);
 struct rcu_head *rcu_cblist_dequeue(struct rcu_cblist *rclp);
 
 /*
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c25ba442044a..e76fef8031be 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3058,47 +3058,8 @@ static void check_cb_ovld(struct rcu_data *rdp)
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
@@ -3139,7 +3100,7 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
 	}
 
 	check_cb_ovld(rdp);
-	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags))
+	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags, lazy))
 		return; // Enqueued onto ->nocb_bypass, so just leave.
 	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
 	rcu_segcblist_enqueue(&rdp->cblist, head);
@@ -3161,8 +3122,86 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
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
 #define KFREE_DRAIN_JIFFIES (HZ / 50)
@@ -4056,7 +4095,8 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 	rdp->barrier_head.func = rcu_barrier_callback;
 	debug_rcu_head_queue(&rdp->barrier_head);
 	rcu_nocb_lock(rdp);
-	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
+	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false,
+		     /* wake gp thread */ true));
 	if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
 		atomic_inc(&rcu_state.barrier_cpu_count);
 	} else {
@@ -4476,7 +4516,7 @@ void rcutree_migrate_callbacks(int cpu)
 	my_rdp = this_cpu_ptr(&rcu_data);
 	my_rnp = my_rdp->mynode;
 	rcu_nocb_lock(my_rdp); /* irqs already disabled. */
-	WARN_ON_ONCE(!rcu_nocb_flush_bypass(my_rdp, NULL, jiffies));
+	WARN_ON_ONCE(!rcu_nocb_flush_bypass(my_rdp, NULL, jiffies, false, false));
 	raw_spin_lock_rcu_node(my_rnp); /* irqs already disabled. */
 	/* Leverage recent GPs and set GP for new callbacks. */
 	needwake = rcu_advance_cbs(my_rnp, rdp) ||
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 2ccf5845957d..7b1ddee6a159 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -267,8 +267,9 @@ struct rcu_data {
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
@@ -436,9 +437,10 @@ static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
 static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
 static void rcu_init_one_nocb(struct rcu_node *rnp);
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
-				  unsigned long j);
+				  unsigned long j, bool lazy, bool wakegp);
 static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
-				bool *was_alldone, unsigned long flags);
+				bool *was_alldone, unsigned long flags,
+				bool lazy);
 static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_empty,
 				 unsigned long flags);
 static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp, int level);
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index e369efe94fda..61b1409bd4d6 100644
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
@@ -265,6 +290,7 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
 {
 	unsigned long flags;
 	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
+	unsigned long mod_jif = 0;
 
 	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
 
@@ -272,16 +298,32 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
 	 * Bypass wakeup overrides previous deferments. In case
 	 * of callback storm, no need to wake up too early.
 	 */
-	if (waketype == RCU_NOCB_WAKE_BYPASS) {
-		mod_timer(&rdp_gp->nocb_timer, jiffies + 2);
-		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
-	} else {
+	switch (waketype) {
+	case RCU_NOCB_WAKE_LAZY:
+		if (rdp->nocb_defer_wakeup != RCU_NOCB_WAKE_LAZY)
+			mod_jif = jiffies_till_flush;
+		break;
+
+	case RCU_NOCB_WAKE_BYPASS:
+		mod_jif = 2;
+		break;
+
+	case RCU_NOCB_WAKE:
+	case RCU_NOCB_WAKE_FORCE:
+		// If the type of deferred wake is "stronger"
+		// than it was before, make it wake up the soonest.
 		if (rdp_gp->nocb_defer_wakeup < RCU_NOCB_WAKE)
-			mod_timer(&rdp_gp->nocb_timer, jiffies + 1);
-		if (rdp_gp->nocb_defer_wakeup < waketype)
-			WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
+			mod_jif = 1;
+		break;
 	}
 
+	if (mod_jif)
+		mod_timer(&rdp_gp->nocb_timer, jiffies + mod_jif);
+
+	// If new type of wake up is stronger than before, promote.
+	if (rdp_gp->nocb_defer_wakeup < waketype)
+		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
+
 	raw_spin_unlock_irqrestore(&rdp_gp->nocb_gp_lock, flags);
 
 	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, reason);
@@ -296,7 +338,7 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
  * Note that this function always returns true if rhp is NULL.
  */
 static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
-				     unsigned long j)
+				     unsigned long j, bool lazy)
 {
 	struct rcu_cblist rcl;
 
@@ -310,7 +352,9 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	/* Note: ->cblist.len already accounts for ->nocb_bypass contents. */
 	if (rhp)
 		rcu_segcblist_inc_len(&rdp->cblist); /* Must precede enqueue. */
-	rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
+
+	/* The lazy CBs are being flushed, but a new one might be enqueued. */
+	rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp, lazy);
 	rcu_segcblist_insert_pend_cbs(&rdp->cblist, &rcl);
 	WRITE_ONCE(rdp->nocb_bypass_first, j);
 	rcu_nocb_bypass_unlock(rdp);
@@ -326,13 +370,20 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
  * Note that this function always returns true if rhp is NULL.
  */
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
-				  unsigned long j)
+				  unsigned long j, bool lazy, bool wake_gp)
 {
+	bool ret;
+
 	if (!rcu_rdp_is_offloaded(rdp))
 		return true;
 	rcu_lockdep_assert_cblist_protected(rdp);
 	rcu_nocb_bypass_lock(rdp);
-	return rcu_nocb_do_flush_bypass(rdp, rhp, j);
+	ret = rcu_nocb_do_flush_bypass(rdp, rhp, j, lazy);
+
+	if (wake_gp)
+		wake_nocb_gp(rdp, true);
+
+	return ret;
 }
 
 /*
@@ -345,7 +396,7 @@ static void rcu_nocb_try_flush_bypass(struct rcu_data *rdp, unsigned long j)
 	if (!rcu_rdp_is_offloaded(rdp) ||
 	    !rcu_nocb_bypass_trylock(rdp))
 		return;
-	WARN_ON_ONCE(!rcu_nocb_do_flush_bypass(rdp, NULL, j));
+	WARN_ON_ONCE(!rcu_nocb_do_flush_bypass(rdp, NULL, j, false));
 }
 
 /*
@@ -367,12 +418,14 @@ static void rcu_nocb_try_flush_bypass(struct rcu_data *rdp, unsigned long j)
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
+	long n_lazy_cbs = rcu_cblist_n_lazy_cbs(&rdp->nocb_bypass);
 
 	lockdep_assert_irqs_disabled();
 
@@ -414,30 +467,37 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	}
 	WRITE_ONCE(rdp->nocb_nobypass_count, c);
 
-	// If there hasn't yet been all that many ->cblist enqueues
-	// this jiffy, tell the caller to enqueue onto ->cblist.  But flush
-	// ->nocb_bypass first.
-	if (rdp->nocb_nobypass_count < nocb_nobypass_lim_per_jiffy) {
+	// If caller passed a non-lazy CB and there hasn't yet been all that
+	// many ->cblist enqueues this jiffy, tell the caller to enqueue it
+	// onto ->cblist.  But flush ->nocb_bypass first. Also do so, if total
+	// number of CBs (lazy + non-lazy) grows too much.
+	//
+	// Note that if the bypass list has lazy CBs, and the main list is
+	// empty, and rhp happens to be non-lazy, then we end up flushing all
+	// the lazy CBs to the main list as well. That's the right thing to do,
+	// since we are kick-starting RCU GP processing anyway for the non-lazy
+	// one, we can just reuse that GP for the already queued-up lazy ones.
+	if ((rdp->nocb_nobypass_count < nocb_nobypass_lim_per_jiffy && !lazy) ||
+	    (lazy && n_lazy_cbs >= qhimark)) {
 		rcu_nocb_lock(rdp);
 		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
 		if (*was_alldone)
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
-					    TPS("FirstQ"));
-		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j));
+					    lazy ? TPS("FirstLazyQ") : TPS("FirstQ"));
+		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j, lazy, false));
 		WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
 		return false; // Caller must enqueue the callback.
 	}
 
 	// If ->nocb_bypass has been used too long or is too full,
 	// flush ->nocb_bypass to ->cblist.
-	if ((ncbs && j != READ_ONCE(rdp->nocb_bypass_first)) ||
-	    ncbs >= qhimark) {
+	if ((ncbs && j != READ_ONCE(rdp->nocb_bypass_first)) || ncbs >= qhimark) {
 		rcu_nocb_lock(rdp);
-		if (!rcu_nocb_flush_bypass(rdp, rhp, j)) {
+		if (!rcu_nocb_flush_bypass(rdp, rhp, j, lazy, false)) {
 			*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
 			if (*was_alldone)
 				trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
-						    TPS("FirstQ"));
+						    lazy ? TPS("FirstLazyQ") : TPS("FirstQ"));
 			WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
 			return false; // Caller must enqueue the callback.
 		}
@@ -455,12 +515,18 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	rcu_nocb_wait_contended(rdp);
 	rcu_nocb_bypass_lock(rdp);
 	ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
+	n_lazy_cbs = rcu_cblist_n_lazy_cbs(&rdp->nocb_bypass);
 	rcu_segcblist_inc_len(&rdp->cblist); /* Must precede enqueue. */
-	rcu_cblist_enqueue(&rdp->nocb_bypass, rhp);
+	rcu_cblist_enqueue(&rdp->nocb_bypass, rhp, lazy);
+
 	if (!ncbs) {
 		WRITE_ONCE(rdp->nocb_bypass_first, j);
-		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("FirstBQ"));
+		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
+				    lazy ? TPS("FirstLazyBQ") : TPS("FirstBQ"));
+	} else if (!n_lazy_cbs && lazy) {
+		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("FirstLazyBQ"));
 	}
+
 	rcu_nocb_bypass_unlock(rdp);
 	smp_mb(); /* Order enqueue before wake. */
 	if (ncbs) {
@@ -493,7 +559,7 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 {
 	unsigned long cur_gp_seq;
 	unsigned long j;
-	long len;
+	long len, lazy_len, bypass_len;
 	struct task_struct *t;
 
 	// If we are being polled or there is no kthread, just leave.
@@ -506,9 +572,16 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 	}
 	// Need to actually to a wakeup.
 	len = rcu_segcblist_n_cbs(&rdp->cblist);
+	bypass_len = rcu_cblist_n_cbs(&rdp->nocb_bypass);
+	lazy_len = rcu_cblist_n_lazy_cbs(&rdp->nocb_bypass);
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
@@ -599,8 +672,8 @@ static inline bool nocb_gp_update_state_deoffloading(struct rcu_data *rdp,
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
@@ -636,6 +709,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 	 */
 	list_for_each_entry_rcu(rdp, &my_rdp->nocb_head_rdp, nocb_entry_rdp, 1) {
 		bool needwake_state = false;
+		bool flush_bypass = false;
 
 		if (!nocb_gp_enabled_cb(rdp))
 			continue;
@@ -648,22 +722,37 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 			continue;
 		}
 		bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
-		if (bypass_ncbs &&
+		lazy_ncbs = rcu_cblist_n_lazy_cbs(&rdp->nocb_bypass);
+
+		if (lazy_ncbs &&
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
 			if (needwake_state)
 				swake_up_one(&rdp->nocb_state_wq);
 			continue; /* No callbacks here, try next. */
 		}
+
+		if (flush_bypass) {
+			// Bypass full or old, so flush it.
+			(void)rcu_nocb_try_flush_bypass(rdp, j);
+			bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
+			lazy_ncbs = rcu_cblist_n_lazy_cbs(&rdp->nocb_bypass);
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
 
@@ -713,12 +802,21 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
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
@@ -999,7 +1097,7 @@ static long rcu_nocb_rdp_deoffload(void *arg)
 	 * return false, which means that future calls to rcu_nocb_try_bypass()
 	 * will refuse to put anything into the bypass.
 	 */
-	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
+	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false, false));
 	/*
 	 * Start with invoking rcu_core() early. This way if the current thread
 	 * happens to preempt an ongoing call to rcu_core() in the middle,
@@ -1500,13 +1598,14 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
 }
 
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
-				  unsigned long j)
+				  unsigned long j, bool lazy, bool wakegp)
 {
 	return true;
 }
 
 static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
-				bool *was_alldone, unsigned long flags)
+				bool *was_alldone, unsigned long flags,
+				bool lazy)
 {
 	return false;
 }
-- 
2.37.1.559.g78731f0fdb-goog


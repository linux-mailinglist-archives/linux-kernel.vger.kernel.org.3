Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B7E539E3C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 09:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350215AbiFAHdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 03:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345986AbiFAHdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 03:33:31 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA03712D8
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 00:33:28 -0700 (PDT)
Received: from fsav311.sakura.ne.jp (fsav311.sakura.ne.jp [153.120.85.142])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 2517XEX5030266;
        Wed, 1 Jun 2022 16:33:14 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav311.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp);
 Wed, 01 Jun 2022 16:33:14 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 2517WpPU029972
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 1 Jun 2022 16:33:14 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f8c281cd-6ce7-818d-8c43-6024a7b3b481@I-love.SAKURA.ne.jp>
Date:   Wed, 1 Jun 2022 16:32:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH v5] workqueue: Wrap flush_workqueue() using a macro
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since flush operation synchronously waits for completion, flushing
system-wide WQs (e.g. system_wq) might introduce possibility of deadlock
due to unexpected locking dependency. Tejun Heo commented at [1] that it
makes no sense at all to call flush_workqueue() on the shared WQs as the
caller has no idea what it's gonna end up waiting for.

Although there is flush_scheduled_work() which flushes system_wq WQ with
"Think twice before calling this function! It's very easy to get into
trouble if you don't take great care." warning message, syzbot found a
circular locking dependency caused by flushing system_wq WQ [2].

Therefore, let's change the direction to that developers had better use
their local WQs if flush_scheduled_work()/flush_workqueue(system_*_wq) is
inevitable.

Steps for converting system-wide WQs into local WQs are explained at [3],
and a conversion to stop flushing system-wide WQs is in progress. Now we
want some mechanism for preventing developers who are not aware of this
conversion from again start flushing system-wide WQs.

Since I found that WARN_ON() is complete but awkward approach for teaching
developers about this problem, let's use __compiletime_warning() for
incomplete but handy approach. For completeness, we will also insert
WARN_ON() into __flush_workqueue() after all in-tree users stopped calling
flush_scheduled_work().

Link: https://lore.kernel.org/all/YgnQGZWT%2Fn3VAITX@slm.duckdns.org/ [1]
Link: https://syzkaller.appspot.com/bug?extid=bde0f89deacca7c765b8 [2]
Link: https://lkml.kernel.org/r/49925af7-78a8-a3dd-bce6-cfc02e1a9236@I-love.SAKURA.ne.jp [3]
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Changes in v5:
  Revert use of inline function, for it turned out that clang emits warning with
  the line of where flush_workqueue() being defined (i.e. some fixed value in
  include/linux/workqueue.h) rather than where flush_workqueue() being called
  if flush_workqueue() is defined as an inline function. We need to use a macro
  in order to report where flush_workqueue() is called. (Since frontend became
  a macro, we might no longer need to rename backend to __flush_workqueue()...)

  Add comment about why not to emit warning from flush_scheduled_work()
  and why not to use BUILD_BUG_ON() from flush_workqueue().

v4 is at https://lkml.kernel.org/r/f9743e46-d467-82aa-effc-597b38e7377d@I-love.SAKURA.ne.jp

 include/linux/workqueue.h | 64 ++++++++++++++++++++++++++++++++++-----
 kernel/workqueue.c        | 16 +++++++---
 2 files changed, 68 insertions(+), 12 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 7fee9b6cfede..e1f1c8b1121b 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -445,7 +445,7 @@ extern bool mod_delayed_work_on(int cpu, struct workqueue_struct *wq,
 			struct delayed_work *dwork, unsigned long delay);
 extern bool queue_rcu_work(struct workqueue_struct *wq, struct rcu_work *rwork);
 
-extern void flush_workqueue(struct workqueue_struct *wq);
+extern void __flush_workqueue(struct workqueue_struct *wq);
 extern void drain_workqueue(struct workqueue_struct *wq);
 
 extern int schedule_on_each_cpu(work_func_t func);
@@ -563,15 +563,23 @@ static inline bool schedule_work(struct work_struct *work)
 	return queue_work(system_wq, work);
 }
 
+/*
+ * Detect attempt to flush system-wide workqueues at compile time when possible.
+ *
+ * See https://lkml.kernel.org/r/49925af7-78a8-a3dd-bce6-cfc02e1a9236@I-love.SAKURA.ne.jp
+ * for reasons and steps for converting system-wide workqueues into local workqueues.
+ */
+extern void __warn_flushing_systemwide_wq(void)
+	__compiletime_warning("Please avoid flushing system-wide workqueues.");
+
 /**
  * flush_scheduled_work - ensure that any scheduled work has run to completion.
  *
  * Forces execution of the kernel-global workqueue and blocks until its
  * completion.
  *
- * Think twice before calling this function!  It's very easy to get into
- * trouble if you don't take great care.  Either of the following situations
- * will lead to deadlock:
+ * It's very easy to get into trouble if you don't take great care.
+ * Either of the following situations will lead to deadlock:
  *
  *	One of the work items currently on the workqueue needs to acquire
  *	a lock held by your code or its caller.
@@ -586,11 +594,51 @@ static inline bool schedule_work(struct work_struct *work)
  * need to know that a particular work item isn't queued and isn't running.
  * In such cases you should use cancel_delayed_work_sync() or
  * cancel_work_sync() instead.
+ *
+ * Please stop calling this function! A conversion to stop flushing system-wide
+ * workqueues is in progress. This function will be removed after all in-tree
+ * users stopped calling this function.
  */
-static inline void flush_scheduled_work(void)
-{
-	flush_workqueue(system_wq);
-}
+/*
+ * The background of commit 771c035372a036f8 ("deprecate the
+ * '__deprecated' attribute warnings entirely and for good") is that,
+ * since Linus builds all modules between every single pull he does,
+ * the standard kernel build needs to be _clean_ in order to be able to
+ * notice when new problems happen. Therefore, don't emit warning while
+ * there are in-tree users.
+ */
+#define flush_scheduled_work()						\
+({									\
+	if (0)								\
+		__warn_flushing_systemwide_wq();			\
+	__flush_workqueue(system_wq);					\
+})
+
+/*
+ * Although there is no longer in-tree caller, for now just emit warning
+ * in order to give out-of-tree callers time to update.
+ */
+#define flush_workqueue(wq)						\
+({									\
+	struct workqueue_struct *_wq = (wq);				\
+									\
+	if ((__builtin_constant_p(_wq == system_wq) &&			\
+	     _wq == system_wq) ||					\
+	    (__builtin_constant_p(_wq == system_highpri_wq) &&		\
+	     _wq == system_highpri_wq) ||				\
+	    (__builtin_constant_p(_wq == system_long_wq) &&		\
+	     _wq == system_long_wq) ||					\
+	    (__builtin_constant_p(_wq == system_unbound_wq) &&		\
+	     _wq == system_unbound_wq) ||				\
+	    (__builtin_constant_p(_wq == system_freezable_wq) &&	\
+	     _wq == system_freezable_wq) ||				\
+	    (__builtin_constant_p(_wq == system_power_efficient_wq) &&	\
+	     _wq == system_power_efficient_wq) ||			\
+	    (__builtin_constant_p(_wq == system_freezable_power_efficient_wq) && \
+	     _wq == system_freezable_power_efficient_wq))		\
+		__warn_flushing_systemwide_wq();			\
+	__flush_workqueue(_wq);						\
+})
 
 /**
  * schedule_delayed_work_on - queue work in global workqueue on CPU after delay
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 4056f2a3f9d5..1ea50f6be843 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2788,13 +2788,13 @@ static bool flush_workqueue_prep_pwqs(struct workqueue_struct *wq,
 }
 
 /**
- * flush_workqueue - ensure that any scheduled work has run to completion.
+ * __flush_workqueue - ensure that any scheduled work has run to completion.
  * @wq: workqueue to flush
  *
  * This function sleeps until all work items which were queued on entry
  * have finished execution, but it is not livelocked by new incoming ones.
  */
-void flush_workqueue(struct workqueue_struct *wq)
+void __flush_workqueue(struct workqueue_struct *wq)
 {
 	struct wq_flusher this_flusher = {
 		.list = LIST_HEAD_INIT(this_flusher.list),
@@ -2943,7 +2943,7 @@ void flush_workqueue(struct workqueue_struct *wq)
 out_unlock:
 	mutex_unlock(&wq->mutex);
 }
-EXPORT_SYMBOL(flush_workqueue);
+EXPORT_SYMBOL(__flush_workqueue);
 
 /**
  * drain_workqueue - drain a workqueue
@@ -2971,7 +2971,7 @@ void drain_workqueue(struct workqueue_struct *wq)
 		wq->flags |= __WQ_DRAINING;
 	mutex_unlock(&wq->mutex);
 reflush:
-	flush_workqueue(wq);
+	__flush_workqueue(wq);
 
 	mutex_lock(&wq->mutex);
 
@@ -6111,3 +6111,11 @@ void __init workqueue_init(void)
 	wq_online = true;
 	wq_watchdog_init();
 }
+
+/*
+ * Despite the naming, this is a no-op function which is here only for avoiding
+ * link error. Since compile-time warning may fail to catch, we will need to
+ * emit run-time warning from __flush_workqueue().
+ */
+void __warn_flushing_systemwide_wq(void) { }
+EXPORT_SYMBOL(__warn_flushing_systemwide_wq);
-- 
2.18.4


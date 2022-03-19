Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23724DE5FB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 05:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241888AbiCSEod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 00:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiCSEoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 00:44:30 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FD62FE53
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 21:43:08 -0700 (PDT)
Received: from fsav114.sakura.ne.jp (fsav114.sakura.ne.jp [27.133.134.241])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 22J4h00x080510;
        Sat, 19 Mar 2022 13:43:00 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav114.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp);
 Sat, 19 Mar 2022 13:43:00 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 22J4gx5J080507
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 19 Mar 2022 13:43:00 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <2efd5461-fccd-f1d9-7138-0a6767cbf5fe@I-love.SAKURA.ne.jp>
Date:   Sat, 19 Mar 2022 13:42:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH v3 (repost)] workqueue: Warn flushing of kernel-global
 workqueues
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,RCVD_IN_SBL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since flush operation synchronously waits for completion, flushing
kernel-global WQs (e.g. system_wq) might introduce possibility of deadlock
due to unexpected locking dependency. Tejun Heo commented that it makes no
sense at all to call flush_workqueue() on the shared WQs as the caller has
no idea what it's gonna end up waiting for.

Although there is flush_scheduled_work() which flushes system_wq WQ with
"Think twice before calling this function! It's very easy to get into
trouble if you don't take great care." warning message, syzbot found a
circular locking dependency caused by flushing system_long_wq WQ [1].
Therefore, let's change the direction to that developers had better use
their local WQs if flush_workqueue() is inevitable.

To give developers time to update their modules, for now just emit
a warning message with ratelimit when flush_workqueue() is called on
kernel-global WQs. We will eventually convert this warning message into
WARN_ON() and kill flush_scheduled_work().

This patch introduces __WQ_NO_FLUSH flag for emitting warning. Don't set
this flag when creating your local WQs while updating your module, for
destroy_workqueue() will involve flush operation.

Theoretically, flushing specific work item using flush_work() queued on
kernel-global WQs (which are !WQ_MEM_RECLAIM) has possibility of deadlock.
But this patch does not emit warning when flush_work() is called on work
items queued on kernel-global WQs, based on assumption that we can create
kworker threads as needed and we won't hit max_active limit.

Link: https://syzkaller.appspot.com/bug?extid=831661966588c802aae9 [1]
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
This patch has been in linux-next.git as commit b9c20da356db1b39 ("workqueue:
Warn flushing of kernel-global workqueues") since next-20220301, and I got no
failure reports. I think that this patch is safe to go to linux.git; then
developers will find this patch and update their modules to use their local WQ.

Changes in v3:
  Don't check flush_work() attempt.
  Use a private WQ_ flag.
Changes in v2:
  Removed #ifdef CONFIG_PROVE_LOCKING=y check.
  Also check flush_work() attempt.
  Shorten warning message.
  Introduced a public WQ_ flag, which is initially meant for use by
  only system-wide WQs, but allows private WQs used by built-in modules
  to use this flag for detecting unexpected flush attempts if they want.

 include/linux/workqueue.h | 15 +++------------
 kernel/workqueue.c        | 36 +++++++++++++++++++++++++++++-------
 2 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 7fee9b6cfede..7b13fae377e2 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -339,6 +339,7 @@ enum {
 	__WQ_ORDERED		= 1 << 17, /* internal: workqueue is ordered */
 	__WQ_LEGACY		= 1 << 18, /* internal: create*_workqueue() */
 	__WQ_ORDERED_EXPLICIT	= 1 << 19, /* internal: alloc_ordered_workqueue() */
+	__WQ_NO_FLUSH           = 1 << 20, /* internal: warn flush_workqueue() */
 
 	WQ_MAX_ACTIVE		= 512,	  /* I like 512, better ideas? */
 	WQ_MAX_UNBOUND_PER_CPU	= 4,	  /* 4 * #cpus for unbound wq */
@@ -569,18 +570,8 @@ static inline bool schedule_work(struct work_struct *work)
  * Forces execution of the kernel-global workqueue and blocks until its
  * completion.
  *
- * Think twice before calling this function!  It's very easy to get into
- * trouble if you don't take great care.  Either of the following situations
- * will lead to deadlock:
- *
- *	One of the work items currently on the workqueue needs to acquire
- *	a lock held by your code or its caller.
- *
- *	Your code is running in the context of a work routine.
- *
- * They will be detected by lockdep when they occur, but the first might not
- * occur very often.  It depends on what work items are on the workqueue and
- * what locks they need, which you have no control over.
+ * Please stop calling this function. If you need to flush kernel-global
+ * workqueue, please use your local workqueue.
  *
  * In most situations flushing the entire workqueue is overkill; you merely
  * need to know that a particular work item isn't queued and isn't running.
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 33f1106b4f99..bc271579704f 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2805,6 +2805,25 @@ static bool flush_workqueue_prep_pwqs(struct workqueue_struct *wq,
 	return wait;
 }
 
+static void warn_flush_attempt(struct workqueue_struct *wq)
+{
+	/*
+	 * Since there are known in-tree modules which will emit this warning,
+	 * for now don't use WARN_ON() in order not to break kernel testing.
+	 *
+	 * Print whole traces with ratelimit, in order to make sure that
+	 * this warning is not overlooked while this warning does not flood
+	 * console and kernel log buffer.
+	 */
+	static DEFINE_RATELIMIT_STATE(flush_warn_rs, 600 * HZ, 1);
+
+	ratelimit_set_flags(&flush_warn_rs, RATELIMIT_MSG_ON_RELEASE);
+	if (!__ratelimit(&flush_warn_rs))
+		return;
+	pr_warn("Please do not flush %s WQ.\n", wq->name);
+	dump_stack();
+}
+
 /**
  * flush_workqueue - ensure that any scheduled work has run to completion.
  * @wq: workqueue to flush
@@ -2824,6 +2843,9 @@ void flush_workqueue(struct workqueue_struct *wq)
 	if (WARN_ON(!wq_online))
 		return;
 
+	if (unlikely(wq->flags & __WQ_NO_FLUSH))
+		warn_flush_attempt(wq);
+
 	lock_map_acquire(&wq->lockdep_map);
 	lock_map_release(&wq->lockdep_map);
 
@@ -6054,17 +6076,17 @@ void __init workqueue_init_early(void)
 		ordered_wq_attrs[i] = attrs;
 	}
 
-	system_wq = alloc_workqueue("events", 0, 0);
-	system_highpri_wq = alloc_workqueue("events_highpri", WQ_HIGHPRI, 0);
-	system_long_wq = alloc_workqueue("events_long", 0, 0);
-	system_unbound_wq = alloc_workqueue("events_unbound", WQ_UNBOUND,
+	system_wq = alloc_workqueue("events", __WQ_NO_FLUSH, 0);
+	system_highpri_wq = alloc_workqueue("events_highpri", __WQ_NO_FLUSH | WQ_HIGHPRI, 0);
+	system_long_wq = alloc_workqueue("events_long", __WQ_NO_FLUSH, 0);
+	system_unbound_wq = alloc_workqueue("events_unbound", __WQ_NO_FLUSH | WQ_UNBOUND,
 					    WQ_UNBOUND_MAX_ACTIVE);
 	system_freezable_wq = alloc_workqueue("events_freezable",
-					      WQ_FREEZABLE, 0);
+					      __WQ_NO_FLUSH | WQ_FREEZABLE, 0);
 	system_power_efficient_wq = alloc_workqueue("events_power_efficient",
-					      WQ_POWER_EFFICIENT, 0);
+					      __WQ_NO_FLUSH | WQ_POWER_EFFICIENT, 0);
 	system_freezable_power_efficient_wq = alloc_workqueue("events_freezable_power_efficient",
-					      WQ_FREEZABLE | WQ_POWER_EFFICIENT,
+					      __WQ_NO_FLUSH | WQ_FREEZABLE | WQ_POWER_EFFICIENT,
 					      0);
 	BUG_ON(!system_wq || !system_highpri_wq || !system_long_wq ||
 	       !system_unbound_wq || !system_freezable_wq ||
-- 
2.32.0



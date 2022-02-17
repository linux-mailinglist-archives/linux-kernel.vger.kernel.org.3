Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1934C4B9E7E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 12:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239695AbiBQLX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 06:23:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbiBQLX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 06:23:27 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E4B1285B5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 03:23:10 -0800 (PST)
Received: from fsav111.sakura.ne.jp (fsav111.sakura.ne.jp [27.133.134.238])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 21HBMWwN049591;
        Thu, 17 Feb 2022 20:22:32 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav111.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp);
 Thu, 17 Feb 2022 20:22:32 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 21HBMWDC049588
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 17 Feb 2022 20:22:32 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <2f887679-c783-bf18-a2aa-aa9a709bfb38@I-love.SAKURA.ne.jp>
Date:   Thu, 17 Feb 2022 20:22:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: [PATCH v2] workqueue: Warn flush attempt using system-wide workqueues
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Haakon Bugge <haakon.bugge@oracle.com>
References: <0000000000005975a605d7aef05e@google.com>
 <8ea57ddf-a09c-43f2-4285-4dfb908ad967@acm.org>
 <ccd04d8a-154b-543e-e1c3-84bc655508d1@I-love.SAKURA.ne.jp>
 <71d6f14e-46af-cc5a-bc70-af1cdc6de8d5@acm.org>
 <309c86b7-2a4c-1332-585f-7bcd59cfd762@I-love.SAKURA.ne.jp>
 <aa2bf24e-981a-a811-c5d8-a75f0b8f693a@acm.org>
 <2959649d-cfbc-bdf2-02ac-053b8e7af030@I-love.SAKURA.ne.jp>
 <YgnQGZWT/n3VAITX@slm.duckdns.org>
 <8ebd003c-f748-69b4-3a4f-fb80a3f39d36@I-love.SAKURA.ne.jp>
 <YgqSsuSN5C7StvKx@slm.duckdns.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <YgqSsuSN5C7StvKx@slm.duckdns.org>
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

syzbot found a circular locking dependency which is caused by flushing
system_long_wq WQ [1]. Tejun Heo commented that it makes no sense at all
to call flush_workqueue() on the shared workqueues as the caller has no
idea what it's gonna end up waiting for.

Although there is flush_scheduled_work() which flushes system_wq WQ with
"Think twice before calling this function! It's very easy to get into
trouble if you don't take great care." warning message, it will be too
difficult to guarantee that all users safely flush system-wide WQs.

Therefore, let's change the direction to that developers had better use
their own WQs if flushing is inevitable. To give developers time to update
their modules, for now just emit a warning message when flush_workqueue()
or flush_work() is called on system-wide WQs. We will eventually convert
this warning message into WARN_ON() and kill flush_scheduled_work().

Link: https://syzkaller.appspot.com/bug?extid=831661966588c802aae9 [1]
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Changes in v2:
  Removed #ifdef CONFIG_PROVE_LOCKING=y check.
  Also check flush_work() attempt.
  Shorten warning message.
  Introduced a public WQ_ flag, which is initially meant for use by
  only system-wide WQs, but allows private WQs used by built-in modules
  to use this flag for detecting unexpected flush attempts if they want.

 include/linux/workqueue.h | 26 +++++++++++++------------
 kernel/workqueue.c        | 41 ++++++++++++++++++++++++++++-----------
 2 files changed, 44 insertions(+), 23 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 7fee9b6cfede..4b698917b9d5 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -335,6 +335,18 @@ enum {
 	 */
 	WQ_POWER_EFFICIENT	= 1 << 7,
 
+	/*
+	 * Since flush operation synchronously waits for completion, flushing
+	 * system-wide workqueues (e.g. system_wq) or a work on a system-wide
+	 * workqueue might introduce possibility of deadlock due to unexpected
+	 * locking dependency.
+	 *
+	 * This flag emits warning if flush operation is attempted. Don't set
+	 * this flag on user-defined workqueues, for destroy_workqueue() will
+	 * involve flush operation.
+	 */
+	WQ_WARN_FLUSH_ATTEMPT   = 1 << 8,
+
 	__WQ_DRAINING		= 1 << 16, /* internal: workqueue is draining */
 	__WQ_ORDERED		= 1 << 17, /* internal: workqueue is ordered */
 	__WQ_LEGACY		= 1 << 18, /* internal: create*_workqueue() */
@@ -569,18 +581,8 @@ static inline bool schedule_work(struct work_struct *work)
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
+ * Please stop calling this function. If you need to flush, please use your
+ * own workqueue.
  *
  * In most situations flushing the entire workqueue is overkill; you merely
  * need to know that a particular work item isn't queued and isn't running.
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 33f1106b4f99..8e6e64372441 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2618,6 +2618,20 @@ static int rescuer_thread(void *__rescuer)
 	goto repeat;
 }
 
+static void warn_flush_attempt(struct workqueue_struct *wq)
+{
+	static DEFINE_RATELIMIT_STATE(flush_warn_rs, 600 * HZ, 1);
+
+
+	/* Use ratelimit for now in order not to flood warning messages. */
+	ratelimit_set_flags(&flush_warn_rs, RATELIMIT_MSG_ON_RELEASE);
+	if (!__ratelimit(&flush_warn_rs))
+		return;
+	/* Don't use WARN_ON() for now in order not to break kernel testing. */
+	pr_warn("Please do not flush %s WQ.\n", wq->name);
+	dump_stack();
+}
+
 /**
  * check_flush_dependency - check for flush dependency sanity
  * @target_wq: workqueue being flushed
@@ -2635,6 +2649,9 @@ static void check_flush_dependency(struct workqueue_struct *target_wq,
 	work_func_t target_func = target_work ? target_work->func : NULL;
 	struct worker *worker;
 
+	if (unlikely(target_wq->flags & WQ_WARN_FLUSH_ATTEMPT))
+		warn_flush_attempt(target_wq);
+
 	if (target_wq->flags & WQ_MEM_RECLAIM)
 		return;
 
@@ -6054,18 +6071,20 @@ void __init workqueue_init_early(void)
 		ordered_wq_attrs[i] = attrs;
 	}
 
-	system_wq = alloc_workqueue("events", 0, 0);
-	system_highpri_wq = alloc_workqueue("events_highpri", WQ_HIGHPRI, 0);
-	system_long_wq = alloc_workqueue("events_long", 0, 0);
-	system_unbound_wq = alloc_workqueue("events_unbound", WQ_UNBOUND,
+	system_wq = alloc_workqueue("events", WQ_WARN_FLUSH_ATTEMPT, 0);
+	system_highpri_wq = alloc_workqueue("events_highpri",
+					    WQ_WARN_FLUSH_ATTEMPT | WQ_HIGHPRI, 0);
+	system_long_wq = alloc_workqueue("events_long", WQ_WARN_FLUSH_ATTEMPT, 0);
+	system_unbound_wq = alloc_workqueue("events_unbound", WQ_WARN_FLUSH_ATTEMPT | WQ_UNBOUND,
 					    WQ_UNBOUND_MAX_ACTIVE);
-	system_freezable_wq = alloc_workqueue("events_freezable",
-					      WQ_FREEZABLE, 0);
-	system_power_efficient_wq = alloc_workqueue("events_power_efficient",
-					      WQ_POWER_EFFICIENT, 0);
-	system_freezable_power_efficient_wq = alloc_workqueue("events_freezable_power_efficient",
-					      WQ_FREEZABLE | WQ_POWER_EFFICIENT,
-					      0);
+	system_freezable_wq =
+		alloc_workqueue("events_freezable", WQ_WARN_FLUSH_ATTEMPT | WQ_FREEZABLE, 0);
+	system_power_efficient_wq =
+		alloc_workqueue("events_power_efficient",
+				WQ_WARN_FLUSH_ATTEMPT | WQ_POWER_EFFICIENT, 0);
+	system_freezable_power_efficient_wq =
+		alloc_workqueue("events_freezable_power_efficient",
+				WQ_WARN_FLUSH_ATTEMPT | WQ_FREEZABLE | WQ_POWER_EFFICIENT, 0);
 	BUG_ON(!system_wq || !system_highpri_wq || !system_long_wq ||
 	       !system_unbound_wq || !system_freezable_wq ||
 	       !system_power_efficient_wq ||
-- 
2.32.0



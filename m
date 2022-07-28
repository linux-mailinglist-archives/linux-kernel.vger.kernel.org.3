Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8603D583EBB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238338AbiG1MXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235980AbiG1MXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:23:48 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DC915828
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 05:23:47 -0700 (PDT)
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 26SCNTq3090536;
        Thu, 28 Jul 2022 21:23:29 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Thu, 28 Jul 2022 21:23:29 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 26SCNSPB090528
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 28 Jul 2022 21:23:29 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <21b9c1ac-64b7-7f4b-1e62-bf2f021fffcd@I-love.SAKURA.ne.jp>
Date:   Thu, 28 Jul 2022 21:23:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Hillf Danton <hdanton@sina.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] workqueue: don't skip lockdep wq dependency in
 cancel_work_sync()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like Hillf Danton mentioned

  syzbot should have been able to catch cancel_work_sync() in work context
  by checking lockdep_map in __flush_work() for both flush and cancel.

in [1], being unable to report an obvious deadlock scenario shown below is
broken. From locking dependency perspective, sync version of cancel request
should behave as if flush request, for it waits for completion of work if
that work has already started execution.

  ----------
  #include <linux/module.h>
  #include <linux/sched.h>
  static DEFINE_MUTEX(mutex);
  static void work_fn(struct work_struct *work)
  {
    schedule_timeout_uninterruptible(HZ / 5);
    mutex_lock(&mutex);
    mutex_unlock(&mutex);
  }
  static DECLARE_WORK(work, work_fn);
  static int __init test_init(void)
  {
    schedule_work(&work);
    schedule_timeout_uninterruptible(HZ / 10);
    mutex_lock(&mutex);
    cancel_work_sync(&work);
    mutex_unlock(&mutex);
    return -EINVAL;
  }
  module_init(test_init);
  MODULE_LICENSE("GPL");
  ----------

Link: https://lkml.kernel.org/r/20220504044800.4966-1-hdanton@sina.com [1]
Reported-by: Hillf Danton <hdanton@sina.com>
Fixes: d6e89786bed977f3 ("workqueue: skip lockdep wq dependency in cancel_work_sync()")
Cc: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 kernel/workqueue.c | 45 ++++++++++++++++++---------------------------
 1 file changed, 18 insertions(+), 27 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 1ea50f6be843..e6df688f84db 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3000,8 +3000,7 @@ void drain_workqueue(struct workqueue_struct *wq)
 }
 EXPORT_SYMBOL_GPL(drain_workqueue);
 
-static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
-			     bool from_cancel)
+static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr)
 {
 	struct worker *worker = NULL;
 	struct worker_pool *pool;
@@ -3043,8 +3042,7 @@ static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
 	 * workqueues the deadlock happens when the rescuer stalls, blocking
 	 * forward progress.
 	 */
-	if (!from_cancel &&
-	    (pwq->wq->saved_max_active == 1 || pwq->wq->rescuer)) {
+	if (pwq->wq->saved_max_active == 1 || pwq->wq->rescuer) {
 		lock_map_acquire(&pwq->wq->lockdep_map);
 		lock_map_release(&pwq->wq->lockdep_map);
 	}
@@ -3056,7 +3054,18 @@ static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
 	return false;
 }
 
-static bool __flush_work(struct work_struct *work, bool from_cancel)
+/**
+ * flush_work - wait for a work to finish executing the last queueing instance
+ * @work: the work to flush
+ *
+ * Wait until @work has finished execution.  @work is guaranteed to be idle
+ * on return if it hasn't been requeued since flush started.
+ *
+ * Return:
+ * %true if flush_work() waited for the work to finish execution,
+ * %false if it was already idle.
+ */
+bool flush_work(struct work_struct *work)
 {
 	struct wq_barrier barr;
 
@@ -3066,12 +3075,10 @@ static bool __flush_work(struct work_struct *work, bool from_cancel)
 	if (WARN_ON(!work->func))
 		return false;
 
-	if (!from_cancel) {
-		lock_map_acquire(&work->lockdep_map);
-		lock_map_release(&work->lockdep_map);
-	}
+	lock_map_acquire(&work->lockdep_map);
+	lock_map_release(&work->lockdep_map);
 
-	if (start_flush_work(work, &barr, from_cancel)) {
+	if (start_flush_work(work, &barr)) {
 		wait_for_completion(&barr.done);
 		destroy_work_on_stack(&barr.work);
 		return true;
@@ -3079,22 +3086,6 @@ static bool __flush_work(struct work_struct *work, bool from_cancel)
 		return false;
 	}
 }
-
-/**
- * flush_work - wait for a work to finish executing the last queueing instance
- * @work: the work to flush
- *
- * Wait until @work has finished execution.  @work is guaranteed to be idle
- * on return if it hasn't been requeued since flush started.
- *
- * Return:
- * %true if flush_work() waited for the work to finish execution,
- * %false if it was already idle.
- */
-bool flush_work(struct work_struct *work)
-{
-	return __flush_work(work, false);
-}
 EXPORT_SYMBOL_GPL(flush_work);
 
 struct cwt_wait {
@@ -3159,7 +3150,7 @@ static bool __cancel_work_timer(struct work_struct *work, bool is_dwork)
 	 * isn't executing.
 	 */
 	if (wq_online)
-		__flush_work(work, true);
+		flush_work(work);
 
 	clear_work_data(work);
 
-- 
2.18.4

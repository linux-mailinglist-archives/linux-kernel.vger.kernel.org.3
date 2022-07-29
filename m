Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31845849F7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 04:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbiG2CyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 22:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiG2CyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 22:54:23 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7718E7393A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 19:54:22 -0700 (PDT)
Received: from fsav314.sakura.ne.jp (fsav314.sakura.ne.jp [153.120.85.145])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 26T2s20D085518;
        Fri, 29 Jul 2022 11:54:02 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav314.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp);
 Fri, 29 Jul 2022 11:54:02 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 26T2s2nj085515
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 29 Jul 2022 11:54:02 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <0a85696a-b0b9-0f4a-7c00-cd89edc9304c@I-love.SAKURA.ne.jp>
Date:   Fri, 29 Jul 2022 11:54:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH v2] workqueue: don't skip lockdep work dependency in
 cancel_work_sync()
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Johannes Berg <johannes.berg@intel.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Tejun Heo <tj@kernel.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <21b9c1ac-64b7-7f4b-1e62-bf2f021fffcd@I-love.SAKURA.ne.jp>
 <YuK78Jiy12BJG/Tp@slm.duckdns.org>
 <0ad532b2-df5f-331a-ae7f-21460fc62fe2@I-love.SAKURA.ne.jp>
 <97cbf8a9-d5e1-376f-6a49-3474871ea6b4@I-love.SAKURA.ne.jp>
 <afa1ac2c-a023-a91e-e596-60931b38247e@I-love.SAKURA.ne.jp>
 <7d034f7b-af42-4dbc-0887-60f4bdb3dcca@I-love.SAKURA.ne.jp>
In-Reply-To: <7d034f7b-af42-4dbc-0887-60f4bdb3dcca@I-love.SAKURA.ne.jp>
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
Fixes: 87915adc3f0acdf0 ("workqueue: re-add lockdep dependencies for flushing")
Cc: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Changes in v2:
  Check work's dependency and do not check workqueue's dependency.

 kernel/workqueue.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 1ea50f6be843..01c5abf7fc61 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3066,10 +3066,8 @@ static bool __flush_work(struct work_struct *work, bool from_cancel)
 	if (WARN_ON(!work->func))
 		return false;
 
-	if (!from_cancel) {
-		lock_map_acquire(&work->lockdep_map);
-		lock_map_release(&work->lockdep_map);
-	}
+	lock_map_acquire(&work->lockdep_map);
+	lock_map_release(&work->lockdep_map);
 
 	if (start_flush_work(work, &barr, from_cancel)) {
 		wait_for_completion(&barr.done);
-- 
2.18.4


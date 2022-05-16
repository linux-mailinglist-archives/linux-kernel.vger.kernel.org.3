Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488A1527CFC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 07:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237760AbiEPFAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 01:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbiEPFAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 01:00:51 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E652D63EF
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 22:00:48 -0700 (PDT)
Received: from fsav314.sakura.ne.jp (fsav314.sakura.ne.jp [153.120.85.145])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 24G50hc8065238;
        Mon, 16 May 2022 14:00:43 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav314.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp);
 Mon, 16 May 2022 14:00:43 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 24G50fbo065226
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 16 May 2022 14:00:42 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <1c1b272b-239c-e1d1-84de-47d02feb911e@I-love.SAKURA.ne.jp>
Date:   Mon, 16 May 2022 14:00:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: [PATCH v3] workqueue: Wrap flush_workqueue() using a macro
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Tejun Heo <tj@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <d34dac10-c12f-8bda-35c4-9cb158781db2@I-love.SAKURA.ne.jp>
 <a6288570ed3534b0316723061f5604e3871accef.camel@perches.com>
 <6e4ed62e-888b-6e7a-c13d-67656f39ca94@I-love.SAKURA.ne.jp>
 <738afe71-2983-05d5-f0fc-d94efbdf7634@I-love.SAKURA.ne.jp>
 <YnQKNea6KWFaWNis@slm.duckdns.org>
 <a0d6b5e4-b9c8-1a43-570f-4c73b0f6fc0c@I-love.SAKURA.ne.jp>
 <Yn0538VavQPv+/Ws@slm.duckdns.org>
 <7b2fecdb-59ae-2c54-5a5b-774ef7054d1b@I-love.SAKURA.ne.jp>
In-Reply-To: <7b2fecdb-59ae-2c54-5a5b-774ef7054d1b@I-love.SAKURA.ne.jp>
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
developers about this problem, let's use BUILD_BUG_ON() for incomplete but
handy approach. For completeness, we will also insert WARN_ON() into
flush_workqueue() after all users stopped calling flush_scheduled_work().

Link: https://lore.kernel.org/all/YgnQGZWT%2Fn3VAITX@slm.duckdns.org/ [1]
Link: https://syzkaller.appspot.com/bug?extid=bde0f89deacca7c765b8 [2]
Link: https://lkml.kernel.org/r/49925af7-78a8-a3dd-bce6-cfc02e1a9236@I-love.SAKURA.ne.jp [3]
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Changes in v3:
  Revert suggested change in v2, for kernel test robot <lkp@intel.com> found

    warning: Function parameter or member 'flush_workqueue' not described in 'void'
    warning: expecting prototype for flush_workqueue(). Prototype was for void() instead

  when built with W=1 option.

Changes in v2:
  Use "void (flush_workqueue)(struct workqueue_struct *wq)" and remove
  "#undef flush_workqueue", suggested by Joe Perches <joe@perches.com>.

This patch is expected to be sent to linux.git immediately before the merge
window for 5.19 closes, for we need to wait until patches for removing
flush_workqueue(system_*_wq) calls reached linux.git during the merge window
for 5.19. Due to this ordering dependency, the kernel build bots complain like
https://lkml.kernel.org/r/202205021448.6SzhD1Cz-lkp@intel.com , but it seems
that simply ignoring these reports is the best choice.

If it is inconvenient for you to send pull request twice from your wq.git tree
(once for immediately after 5.18 is released, the other for immediately before
the merge window for 5.19 closes), I can send pull request for this patch from
my tree. In that case, please give me Acked-by: or Reviewed-by: response regarding
this patch.

 include/linux/workqueue.h | 31 +++++++++++++++++++++++++++++++
 kernel/workqueue.c        |  1 +
 2 files changed, 32 insertions(+)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 7fee9b6cfede..5bad503925de 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -663,4 +663,35 @@ int workqueue_offline_cpu(unsigned int cpu);
 void __init workqueue_init_early(void);
 void __init workqueue_init(void);
 
+/*
+ * Detect attempt to flush system-wide workqueues at compile time when possible.
+ * See https://lkml.kernel.org/r/49925af7-78a8-a3dd-bce6-cfc02e1a9236@I-love.SAKURA.ne.jp for
+ * reasons and steps for converting system-wide workqueues into local workqueues.
+ */
+#define flush_workqueue(wq)						\
+({									\
+	BUILD_BUG_ON_MSG(__builtin_constant_p(&(wq) == &system_wq) &&	\
+			 &(wq) == &system_wq,				\
+			 "Please avoid flushing system_wq.");		\
+	BUILD_BUG_ON_MSG(__builtin_constant_p(&(wq) == &system_highpri_wq) && \
+			 &(wq) == &system_highpri_wq,			\
+			 "Please avoid flushing system_highpri_wq.");	\
+	BUILD_BUG_ON_MSG(__builtin_constant_p(&(wq) == &system_long_wq) && \
+			 &(wq) == &system_long_wq,			\
+			 "Please avoid flushing system_long_wq.");	\
+	BUILD_BUG_ON_MSG(__builtin_constant_p(&(wq) == &system_unbound_wq) && \
+			 &(wq) == &system_unbound_wq,			\
+			 "Please avoid flushing system_unbound_wq.");	\
+	BUILD_BUG_ON_MSG(__builtin_constant_p(&(wq) == &system_freezable_wq) &&	\
+			 &(wq) == &system_freezable_wq,			\
+			 "Please avoid flushing system_freezable_wq."); \
+	BUILD_BUG_ON_MSG(__builtin_constant_p(&(wq) == &system_power_efficient_wq) && \
+			 &(wq) == &system_power_efficient_wq,		\
+			 "Please avoid flushing system_power_efficient_wq."); \
+	BUILD_BUG_ON_MSG(__builtin_constant_p(&(wq) == &system_freezable_power_efficient_wq) &&	\
+			 &(wq) == &system_freezable_power_efficient_wq, \
+			 "Please avoid flushing system_freezable_power_efficient_wq."); \
+	flush_workqueue(wq);						\
+})
+
 #endif
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0d2514b4ff0d..08255c332e4b 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2794,6 +2794,7 @@ static bool flush_workqueue_prep_pwqs(struct workqueue_struct *wq,
  * This function sleeps until all work items which were queued on entry
  * have finished execution, but it is not livelocked by new incoming ones.
  */
+#undef flush_workqueue
 void flush_workqueue(struct workqueue_struct *wq)
 {
 	struct wq_flusher this_flusher = {
-- 
2.34.1


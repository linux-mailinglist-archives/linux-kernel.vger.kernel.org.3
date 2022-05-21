Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910EF52FC12
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 13:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243077AbiEULhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 07:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240191AbiEULhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 07:37:33 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602CD4A3D1
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 04:37:31 -0700 (PDT)
Received: from fsav120.sakura.ne.jp (fsav120.sakura.ne.jp [27.133.134.247])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 24LBbO7W055564;
        Sat, 21 May 2022 20:37:24 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav120.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp);
 Sat, 21 May 2022 20:37:24 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 24LBbNsB055561
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 21 May 2022 20:37:24 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e9df5f75-2958-db1b-462d-dba4a0455f44@I-love.SAKURA.ne.jp>
Date:   Sat, 21 May 2022 20:37:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3] workqueue: Wrap flush_workqueue() using a macro
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <a0d6b5e4-b9c8-1a43-570f-4c73b0f6fc0c@I-love.SAKURA.ne.jp>
 <Yn0538VavQPv+/Ws@slm.duckdns.org>
 <7b2fecdb-59ae-2c54-5a5b-774ef7054d1b@I-love.SAKURA.ne.jp>
 <1c1b272b-239c-e1d1-84de-47d02feb911e@I-love.SAKURA.ne.jp>
 <YodK1czmhZtGmJ8E@slm.duckdns.org>
 <5f417d30-34a7-8da1-0ad5-33bd750582c7@I-love.SAKURA.ne.jp>
 <Yod3S8jmle+LYlES@slm.duckdns.org>
 <1a1634ac-db0e-a44c-b286-a3aba55ad695@I-love.SAKURA.ne.jp>
 <YofLmMTAjNVM+9nQ@slm.duckdns.org>
 <d05f4745-ba08-61eb-4780-ddfe50d0f1b9@I-love.SAKURA.ne.jp>
 <YohxUC45xk523g9I@slm.duckdns.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <YohxUC45xk523g9I@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/05/21 13:57, Tejun Heo wrote:
> How is that better tho? If we can just trigger build warning, that's way
> better than asking people to hunt down some random define and shoot it down.
> How would they do that?

Subset of this patch already in linux-next.git without problems suggests that
in-tree kernel modules (including the ones which will be added during next merge
window) will not hit build failures with this patch.

We don't take care of build failures for out-of-tree kernel modules, but
some out-of-tree kernel module which cannot rewrite in a timely manner can
workaround by just adding a #undef line. Patching out-of-tree kernel module is
easier than patching .config or Makefile or include/linux/workqueue.h .

> We're talking in circles. If we can trigger warning, I don't see a reason
> why we'd want to trigger build failures. It's a really bad user experience
> for anybody who doesn't know what is going on exactly. So, nack on the
> current patch.

I wonder if we can trigger warning using __compiletime_warning, for init/Kconfig
recommends CONFIG_WERROR=y (i.e. __compiletime_warning == __compiletime_error).

----------
config WERROR
	bool "Compile the kernel with warnings as errors"
	default COMPILE_TEST
	help
	  A kernel build should not cause any compiler warnings, and this
	  enables the '-Werror' flag to enforce that rule by default.

	  However, if you have a new (or very old) compiler with odd and
	  unusual warnings, or you have some architecture with problems,
	  you may need to disable this config option in order to
	  successfully build the kernel.

	  If in doubt, say Y.
----------

Anyway, something like below updated approach?

---
 include/linux/workqueue.h | 49 ++++++++++++++++++++++++++++++++++++---
 kernel/workqueue.c        |  9 +++++++
 2 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 7fee9b6cfede..243d87fc0b85 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -563,15 +563,21 @@ static inline bool schedule_work(struct work_struct *work)
 	return queue_work(system_wq, work);
 }
 
+/*
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
@@ -586,6 +592,10 @@ static inline bool schedule_work(struct work_struct *work)
  * need to know that a particular work item isn't queued and isn't running.
  * In such cases you should use cancel_delayed_work_sync() or
  * cancel_work_sync() instead.
+ *
+ * Please stop calling this function! A conversion to stop flushing system-wide
+ * workqueues is in progress. This function will be removed after all in-tree
+ * users stopped calling this function.
  */
 static inline void flush_scheduled_work(void)
 {
@@ -663,4 +673,37 @@ int workqueue_offline_cpu(unsigned int cpu);
 void __init workqueue_init_early(void);
 void __init workqueue_init(void);
 
+/*
+ * Detect attempt to flush system-wide workqueues at compile time when possible.
+ *
+ * Always warn, for there is no in-tree flush_workqueue(system_*_wq) user.
+ */
+#define flush_workqueue(wq)						\
+do {									\
+	if ((__builtin_constant_p(&(wq) == &system_wq) &&		\
+	     &(wq) == &system_wq) ||					\
+	    (__builtin_constant_p(&(wq) == &system_highpri_wq) &&	\
+	     &(wq) == &system_highpri_wq) ||				\
+	    (__builtin_constant_p(&(wq) == &system_long_wq) &&		\
+	     &(wq) == &system_long_wq) ||				\
+	    (__builtin_constant_p(&(wq) == &system_unbound_wq) &&	\
+	     &(wq) == &system_unbound_wq) ||				\
+	    (__builtin_constant_p(&(wq) == &system_freezable_wq) &&	\
+	     &(wq) == &system_freezable_wq) ||				\
+	    (__builtin_constant_p(&(wq) == &system_power_efficient_wq) && \
+	     &(wq) == &system_power_efficient_wq) ||			\
+	    (__builtin_constant_p(&(wq) == &system_freezable_power_efficient_wq) && \
+	     &(wq) == &system_freezable_power_efficient_wq))		\
+		__warn_flushing_systemwide_wq();			\
+	flush_workqueue(wq);						\
+} while (0)
+
+/*
+ * Warn only if emitting warning message does not cause build failure and
+ * the developer wants warning about possibility of deadlock.
+ */
+#if !defined(CONFIG_WERROR) && defined(CONFIG_PROVE_LOCKING)
+#define flush_scheduled_work() flush_workqueue(system_wq)
+#endif
+
 #endif
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0d2514b4ff0d..3391e0d10f90 100644
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
@@ -6111,3 +6112,11 @@ void __init workqueue_init(void)
 	wq_online = true;
 	wq_watchdog_init();
 }
+
+/*
+ * Despite the naming, this is a no-op function which is here only for avoiding
+ * link error. Since compile-time warning may fail to catch, we will need to
+ * emit run-time warning from flush_workqueue().
+ */
+void __warn_flushing_systemwide_wq(void) { }
+EXPORT_SYMBOL(__warn_flushing_systemwide_wq);
-- 
2.18.4


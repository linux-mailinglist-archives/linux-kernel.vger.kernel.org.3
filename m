Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A0E57DBAF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbiGVICL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiGVICH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:02:07 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92419B1BF;
        Fri, 22 Jul 2022 01:02:02 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id n10-20020a17090a670a00b001f22ebae50aso3539905pjj.3;
        Fri, 22 Jul 2022 01:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M6s/8RD5zBTdM6tKCdA9Hka8E+QmLLY/fIYD1VeQ3LA=;
        b=qLjWeFhX9qG4ExjvfWt7Qpo4TWsZiV+bNpSso3zL9QzLJOhsspPztaRgG0CWwMy0jp
         kPWD2f7z4AgKxVSBobv3OSD54qGV3PB88/mnQlQwg7HghXwVwKU0hJOIyP/OIhYPWsf4
         CJkvAsvCtXffD3pBHJbQ8jDqAVUuK4GtqE1V8V1x6j/h45OGtl59tqOK+nRovVkFbFs/
         NCXDR+AFVyaans6Gk+eh1JYvcDH735B4gRHb4oTh4JtcCdFil0U85ujQ9VRPHv3S3lBV
         rRAR4xqJnx8zynNfmt19XSjwJXopuwRboOdWkpvkpkLgECqTQrd12oTh+osu40F+zMVA
         Ub9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M6s/8RD5zBTdM6tKCdA9Hka8E+QmLLY/fIYD1VeQ3LA=;
        b=3Sa0uZROcD8TZvweYCa61Jo0+c8jY8BLDswf8svjpbhekZ0mHEeIRSCkW062PIOW8K
         Uj0QSI0WDsOo9xptcSO4nkxEt/MFer4VISLlxk9IOpwCA67zMJq6v9YtoOIoAZl1kjVb
         +Rk5mURhSXfaiHGsYoKPd47Nsp5xvi9WMl5SMQFEXbnNLtECIsXV3o5PaZ+SpM4Vjx3y
         pZTn8ZXrD8uzCEQ5+D8HBxzzukvzLv93PAies5GNI1pqt0ZAyvWjgDvlr3zFgPXJ/Dlm
         zb7F3vZ49HnZ/amCeGp8Z9yBc7OD10F4mwZ2ZLv3LS1PFfoaHu7bgaytl/6BNAfTyWVn
         CZcQ==
X-Gm-Message-State: AJIora9xVfxeS9++vSVuXD56uvUHOutT1fjYj3IlO96FORdXoclVZpuO
        cswjAek9yTjCixDIxVxJBDg=
X-Google-Smtp-Source: AGRyM1t60nfPpUpNB2VNbbCRTLt77BVWu0RpeX1UTh7qRllYRt2S4nRF5E4VhtD2xnfJuHXDupXiSw==
X-Received: by 2002:a17:902:d490:b0:16b:fb09:50ea with SMTP id c16-20020a170902d49000b0016bfb0950eamr2210466plg.77.1658476922210;
        Fri, 22 Jul 2022 01:02:02 -0700 (PDT)
Received: from ubuntu (61-216-121-34.hinet-ip.hinet.net. [61.216.121.34])
        by smtp.gmail.com with ESMTPSA id d72-20020a621d4b000000b0052bae7a9722sm3162392pfd.116.2022.07.22.01.01.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jul 2022 01:02:01 -0700 (PDT)
Date:   Fri, 22 Jul 2022 01:01:55 -0700
From:   "yuxin.ye" <yeyuxin0925@gmail.com>
To:     Waiman Long <longman@redhat.com>, linux-rt-users@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] rtmutex: Fix BUG_ON at kernel/locking/rtmutex.c:1331!
Message-ID: <20220722080153.GA11228@ubuntu>
References: <20220720072806.43445-1-yeyuxin0925@gmail.com>
 <62de0805-a6ec-f2a1-00f2-1b24a95c72f0@redhat.com>
 <20220721071656.GA8109@ubuntu>
 <4953388d-bce4-37cd-f2b9-28dc3627c17d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <4953388d-bce4-37cd-f2b9-28dc3627c17d@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 21, 2022 at 02:14:16PM -0400, Waiman Long wrote:
> 
> On 7/21/22 03:17, yuxin.ye wrote:
> > On Wed, Jul 20, 2022 at 10:25:17PM -0400, Waiman Long wrote:
> > > On 7/20/22 03:28, yuxin.ye wrote:
> > > > before rt_mutex_adjust_prio_chain(),unlock lock->wait_lock will cause
> > > > BUG_ON at kernel/locking/rtmutex.c:1331:
> > > The current upstream kernel/locking/rtmutex.c has no BUG_ON() call. Which
> > > version of the kernel are you using?
> > > 
> > > Cheers,
> > > Longman
> > > 
> > The Linux version is 5.10.
> > The upstream has indeed removed the BUG_ON, But in rt_mutex_adjust_prio_chain()
> > it is still possible to have a thread is blocked by two locks. Can this situation
> > be ignored without BUG_ON?
> 
> No. However, we don't remove the lock like what you do with your patch. It
> will corrupt the data if multiple CPUs are allowed to run
> rt_mutex_adjust_prio_chain() for the same rt_mutex simultaneously. You need
> to find a way to fix the underlying problem.
> 
> BTW, I still can't see a BUG_ON at line 1331 of rtmutex.c with a v5.10
> kernel. Does your source tree have some out-of-tree patches that modifies
> rtmutex?
> 
> Cheers,
> Longman
>

Yes, I'm sorry I overlooked that earlier. We applied the RT patch,and
the BUG_ON are also introduced by these patches.

Back to the question, I think remove the wait_lock unlock before
rt_mutex_adjust_prio_chain() is more likely to protect some data. The
commont on task_blocks_on_rt_mutex() indicates that must be called with
wait_lock held, but it unlock before call rt_mutex_adjust_prio_chain().
This may cause the owner thread to unlock the orig_lock and exit the
thead. Finally, when calling put_task_struct(owner) in
rt_mutex_adjust_prio_chain(), the thread is blocked by another lock that
is deeply hidden.

Actully, I'm not sure why rt_mutex_adjust_prio_chain()
dosen't need wait_lock protection.

Thanks again.

--17pEHd4RhPHOinZp
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0162-locking-rtmutex-Handle-the-various-new-futex-race-co.patch"

From 785a93a55536c33b674ef5d794f545a9d333852e Mon Sep 17 00:00:00 2001
From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 10 Jun 2011 11:04:15 +0200
Subject: [PATCH 162/304] locking/rtmutex: Handle the various new futex race
 conditions

RT opens a few new interesting race conditions in the rtmutex/futex
combo due to futex hash bucket lock being a 'sleeping' spinlock and
therefor not disabling preemption.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/futex.c                  | 77 ++++++++++++++++++++++++++-------
 kernel/locking/rtmutex.c        | 36 ++++++++++++---
 kernel/locking/rtmutex_common.h |  2 +
 3 files changed, 94 insertions(+), 21 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 98a6e1b80bfe..c2fe58c34409 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2155,6 +2155,16 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 				 */
 				requeue_pi_wake_futex(this, &key2, hb2);
 				continue;
+			} else if (ret == -EAGAIN) {
+				/*
+				 * Waiter was woken by timeout or
+				 * signal and has set pi_blocked_on to
+				 * PI_WAKEUP_INPROGRESS before we
+				 * tried to enqueue it on the rtmutex.
+				 */
+				this->pi_state = NULL;
+				put_pi_state(pi_state);
+				continue;
 			} else if (ret) {
 				/*
 				 * rt_mutex_start_proxy_lock() detected a
@@ -3172,7 +3182,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 {
 	struct hrtimer_sleeper timeout, *to;
 	struct rt_mutex_waiter rt_waiter;
-	struct futex_hash_bucket *hb;
+	struct futex_hash_bucket *hb, *hb2;
 	union futex_key key2 = FUTEX_KEY_INIT;
 	struct futex_q q = futex_q_init;
 	int res, ret;
@@ -3224,20 +3234,55 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 	/* Queue the futex_q, drop the hb lock, wait for wakeup. */
 	futex_wait_queue_me(hb, &q, to);
 
-	spin_lock(&hb->lock);
-	ret = handle_early_requeue_pi_wakeup(hb, &q, &key2, to);
-	spin_unlock(&hb->lock);
-	if (ret)
-		goto out;
+	/*
+	 * On RT we must avoid races with requeue and trying to block
+	 * on two mutexes (hb->lock and uaddr2's rtmutex) by
+	 * serializing access to pi_blocked_on with pi_lock.
+	 */
+	raw_spin_lock_irq(&current->pi_lock);
+	if (current->pi_blocked_on) {
+		/*
+		 * We have been requeued or are in the process of
+		 * being requeued.
+		 */
+		raw_spin_unlock_irq(&current->pi_lock);
+	} else {
+		/*
+		 * Setting pi_blocked_on to PI_WAKEUP_INPROGRESS
+		 * prevents a concurrent requeue from moving us to the
+		 * uaddr2 rtmutex. After that we can safely acquire
+		 * (and possibly block on) hb->lock.
+		 */
+		current->pi_blocked_on = PI_WAKEUP_INPROGRESS;
+		raw_spin_unlock_irq(&current->pi_lock);
+
+		spin_lock(&hb->lock);
+
+		/*
+		 * Clean up pi_blocked_on. We might leak it otherwise
+		 * when we succeeded with the hb->lock in the fast
+		 * path.
+		 */
+		raw_spin_lock_irq(&current->pi_lock);
+		current->pi_blocked_on = NULL;
+		raw_spin_unlock_irq(&current->pi_lock);
+
+		ret = handle_early_requeue_pi_wakeup(hb, &q, &key2, to);
+		spin_unlock(&hb->lock);
+		if (ret)
+			goto out;
+	}
 
 	/*
-	 * In order for us to be here, we know our q.key == key2, and since
-	 * we took the hb->lock above, we also know that futex_requeue() has
-	 * completed and we no longer have to concern ourselves with a wakeup
-	 * race with the atomic proxy lock acquisition by the requeue code. The
-	 * futex_requeue dropped our key1 reference and incremented our key2
-	 * reference count.
+	 * In order to be here, we have either been requeued, are in
+	 * the process of being requeued, or requeue successfully
+	 * acquired uaddr2 on our behalf.  If pi_blocked_on was
+	 * non-null above, we may be racing with a requeue.  Do not
+	 * rely on q->lock_ptr to be hb2->lock until after blocking on
+	 * hb->lock or hb2->lock. The futex_requeue dropped our key1
+	 * reference and incremented our key2 reference count.
 	 */
+	hb2 = hash_futex(&key2);
 
 	/* Check if the requeue code acquired the second futex for us. */
 	if (!q.rt_waiter) {
@@ -3246,14 +3291,15 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 		 * did a lock-steal - fix up the PI-state in that case.
 		 */
 		if (q.pi_state && (q.pi_state->owner != current)) {
-			spin_lock(q.lock_ptr);
+			spin_lock(&hb2->lock);
+			BUG_ON(&hb2->lock != q.lock_ptr);
 			ret = fixup_pi_state_owner(uaddr2, &q, current);
 			/*
 			 * Drop the reference to the pi state which
 			 * the requeue_pi() code acquired for us.
 			 */
 			put_pi_state(q.pi_state);
-			spin_unlock(q.lock_ptr);
+			spin_unlock(&hb2->lock);
 			/*
 			 * Adjust the return value. It's either -EFAULT or
 			 * success (1) but the caller expects 0 for success.
@@ -3272,7 +3318,8 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 		pi_mutex = &q.pi_state->pi_mutex;
 		ret = rt_mutex_wait_proxy_lock(pi_mutex, to, &rt_waiter);
 
-		spin_lock(q.lock_ptr);
+		spin_lock(&hb2->lock);
+		BUG_ON(&hb2->lock != q.lock_ptr);
 		if (ret && !rt_mutex_cleanup_proxy_lock(pi_mutex, &rt_waiter))
 			ret = 0;
 
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 1d0e9bf0487a..97a5fb19119d 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -136,6 +136,11 @@ static void fixup_rt_mutex_waiters(struct rt_mutex *lock)
 		WRITE_ONCE(*p, owner & ~RT_MUTEX_HAS_WAITERS);
 }
 
+static int rt_mutex_real_waiter(struct rt_mutex_waiter *waiter)
+{
+	return waiter && waiter != PI_WAKEUP_INPROGRESS;
+}
+
 /*
  * We can speed up the acquire/release, if there's no debugging state to be
  * set up.
@@ -378,7 +383,8 @@ int max_lock_depth = 1024;
 
 static inline struct rt_mutex *task_blocked_on_lock(struct task_struct *p)
 {
-	return p->pi_blocked_on ? p->pi_blocked_on->lock : NULL;
+	return rt_mutex_real_waiter(p->pi_blocked_on) ?
+		p->pi_blocked_on->lock : NULL;
 }
 
 /*
@@ -514,7 +520,7 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 	 * reached or the state of the chain has changed while we
 	 * dropped the locks.
 	 */
-	if (!waiter)
+	if (!rt_mutex_real_waiter(waiter))
 		goto out_unlock_pi;
 
 	/*
@@ -947,6 +953,22 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 		return -EDEADLK;
 
 	raw_spin_lock(&task->pi_lock);
+	/*
+	 * In the case of futex requeue PI, this will be a proxy
+	 * lock. The task will wake unaware that it is enqueueed on
+	 * this lock. Avoid blocking on two locks and corrupting
+	 * pi_blocked_on via the PI_WAKEUP_INPROGRESS
+	 * flag. futex_wait_requeue_pi() sets this when it wakes up
+	 * before requeue (due to a signal or timeout). Do not enqueue
+	 * the task if PI_WAKEUP_INPROGRESS is set.
+	 */
+	if (task != current && task->pi_blocked_on == PI_WAKEUP_INPROGRESS) {
+		raw_spin_unlock(&task->pi_lock);
+		return -EAGAIN;
+	}
+
+       BUG_ON(rt_mutex_real_waiter(task->pi_blocked_on));
+
 	waiter->task = task;
 	waiter->lock = lock;
 	waiter->prio = task->prio;
@@ -970,7 +992,7 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 		rt_mutex_enqueue_pi(owner, waiter);
 
 		rt_mutex_adjust_prio(owner);
-		if (owner->pi_blocked_on)
+		if (rt_mutex_real_waiter(owner->pi_blocked_on))
 			chain_walk = 1;
 	} else if (rt_mutex_cond_detect_deadlock(waiter, chwalk)) {
 		chain_walk = 1;
@@ -1066,7 +1088,7 @@ static void remove_waiter(struct rt_mutex *lock,
 {
 	bool is_top_waiter = (waiter == rt_mutex_top_waiter(lock));
 	struct task_struct *owner = rt_mutex_owner(lock);
-	struct rt_mutex *next_lock;
+	struct rt_mutex *next_lock = NULL;
 
 	lockdep_assert_held(&lock->wait_lock);
 
@@ -1092,7 +1114,8 @@ static void remove_waiter(struct rt_mutex *lock,
 	rt_mutex_adjust_prio(owner);
 
 	/* Store the lock on which owner is blocked or NULL */
-	next_lock = task_blocked_on_lock(owner);
+	if (rt_mutex_real_waiter(owner->pi_blocked_on))
+		next_lock = task_blocked_on_lock(owner);
 
 	raw_spin_unlock(&owner->pi_lock);
 
@@ -1128,7 +1151,8 @@ void rt_mutex_adjust_pi(struct task_struct *task)
 	raw_spin_lock_irqsave(&task->pi_lock, flags);
 
 	waiter = task->pi_blocked_on;
-	if (!waiter || rt_mutex_waiter_equal(waiter, task_to_waiter(task))) {
+	if (!rt_mutex_real_waiter(waiter) ||
+	    rt_mutex_waiter_equal(waiter, task_to_waiter(task))) {
 		raw_spin_unlock_irqrestore(&task->pi_lock, flags);
 		return;
 	}
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index b1455dc2366f..096b16cfb096 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -125,6 +125,8 @@ enum rtmutex_chainwalk {
 /*
  * PI-futex support (proxy locking functions, etc.):
  */
+#define PI_WAKEUP_INPROGRESS	((struct rt_mutex_waiter *) 1)
+
 extern struct task_struct *rt_mutex_next_owner(struct rt_mutex *lock);
 extern void rt_mutex_init_proxy_locked(struct rt_mutex *lock,
 				       struct task_struct *proxy_owner);
-- 
2.32.0


--17pEHd4RhPHOinZp--

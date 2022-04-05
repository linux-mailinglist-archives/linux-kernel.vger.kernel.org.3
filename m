Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FA34F3811
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 16:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376278AbiDELVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 07:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240862AbiDEIsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:48:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE72826556;
        Tue,  5 Apr 2022 01:36:29 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:36:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649147778;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/H97JURZa9dNCGiFULd/1CDfo6q3JOnJ/6JZOf9Odhc=;
        b=syWxcyvkzyxJ/2ujMH7S/vz5+BSlUrZJrnJY+SlK1LMSxn6vI5eysA9hJfR4DOCqaYh7kC
        XnpJbLHPh5SxY5vjFryvRRS2mngk6hetrvkYiYX25Njb5WOLy9XlBenwqg+/H6izifCRHV
        w0D415iR1XvNycp7CspaKGkYP3MK6OVggZ9z2Kt9h+HAY01IbqZsmzAui1pG8e8jwbW/M1
        Xh0wrd71gpSVHSGcJsWCzcZ2PxJLejJxdXPQ/XEYZM04B1Zt2FHVzvgZJhwsnUYNurIUPQ
        ouv9ZdJwQ0oUSlbBil5uMf6KA5Cst62UM+NobI8hsGTmKRE4ba04/PfZHXNgmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649147778;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/H97JURZa9dNCGiFULd/1CDfo6q3JOnJ/6JZOf9Odhc=;
        b=/cXkKg/vyxzq5nmu5Ys6gRkR1mKKF35lFOHvjmzBh1FQqsIsZPTAwcITxX6yxub/fTVvmf
        oaQRImFUTVnb28BQ==
From:   "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking: Apply contention tracepoints in the slow path
Cc:     Namhyung Kim <namhyung@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220322185709.141236-3-namhyung@kernel.org>
References: <20220322185709.141236-3-namhyung@kernel.org>
MIME-Version: 1.0
Message-ID: <164914777781.389.14813436830233349525.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     ee042be16cb455116d0fe99b77c6bc8baf87c8c6
Gitweb:        https://git.kernel.org/tip/ee042be16cb455116d0fe99b77c6bc8baf87c8c6
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Tue, 22 Mar 2022 11:57:09 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Apr 2022 10:24:35 +02:00

locking: Apply contention tracepoints in the slow path

Adding the lock contention tracepoints in various lock function slow
paths.  Note that each arch can define spinlock differently, I only
added it only to the generic qspinlock for now.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Link: https://lkml.kernel.org/r/20220322185709.141236-3-namhyung@kernel.org
---
 kernel/locking/mutex.c        |  3 +++
 kernel/locking/percpu-rwsem.c |  5 +++++
 kernel/locking/qrwlock.c      |  9 +++++++++
 kernel/locking/qspinlock.c    |  5 +++++
 kernel/locking/rtmutex.c      | 11 +++++++++++
 kernel/locking/rwbase_rt.c    |  7 +++++++
 kernel/locking/rwsem.c        |  9 +++++++++
 kernel/locking/semaphore.c    | 15 ++++++++++++++-
 8 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index ee2fd76..c88deda 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -644,6 +644,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	}
 
 	set_current_state(state);
+	trace_contention_begin(lock, 0);
 	for (;;) {
 		bool first;
 
@@ -710,6 +711,7 @@ acquired:
 skip_wait:
 	/* got the lock - cleanup and rejoice! */
 	lock_acquired(&lock->dep_map, ip);
+	trace_contention_end(lock, 0);
 
 	if (ww_ctx)
 		ww_mutex_lock_acquired(ww, ww_ctx);
@@ -721,6 +723,7 @@ skip_wait:
 err:
 	__set_current_state(TASK_RUNNING);
 	__mutex_remove_waiter(lock, &waiter);
+	trace_contention_end(lock, ret);
 err_early_kill:
 	raw_spin_unlock(&lock->wait_lock);
 	debug_mutex_free_waiter(&waiter);
diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index c9fdae9..5fe4c54 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -9,6 +9,7 @@
 #include <linux/sched/task.h>
 #include <linux/sched/debug.h>
 #include <linux/errno.h>
+#include <trace/events/lock.h>
 
 int __percpu_init_rwsem(struct percpu_rw_semaphore *sem,
 			const char *name, struct lock_class_key *key)
@@ -171,9 +172,11 @@ bool __sched __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
 	if (try)
 		return false;
 
+	trace_contention_begin(sem, LCB_F_PERCPU | LCB_F_READ);
 	preempt_enable();
 	percpu_rwsem_wait(sem, /* .reader = */ true);
 	preempt_disable();
+	trace_contention_end(sem, 0);
 
 	return true;
 }
@@ -216,6 +219,7 @@ void __sched percpu_down_write(struct percpu_rw_semaphore *sem)
 {
 	might_sleep();
 	rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
+	trace_contention_begin(sem, LCB_F_PERCPU | LCB_F_WRITE);
 
 	/* Notify readers to take the slow path. */
 	rcu_sync_enter(&sem->rss);
@@ -237,6 +241,7 @@ void __sched percpu_down_write(struct percpu_rw_semaphore *sem)
 
 	/* Wait for all active readers to complete. */
 	rcuwait_wait_event(&sem->writer, readers_active_check(sem), TASK_UNINTERRUPTIBLE);
+	trace_contention_end(sem, 0);
 }
 EXPORT_SYMBOL_GPL(percpu_down_write);
 
diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index ec36b73..7f42e52 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -12,6 +12,7 @@
 #include <linux/percpu.h>
 #include <linux/hardirq.h>
 #include <linux/spinlock.h>
+#include <trace/events/lock.h>
 
 /**
  * queued_read_lock_slowpath - acquire read lock of a queue rwlock
@@ -34,6 +35,8 @@ void queued_read_lock_slowpath(struct qrwlock *lock)
 	}
 	atomic_sub(_QR_BIAS, &lock->cnts);
 
+	trace_contention_begin(lock, LCB_F_SPIN | LCB_F_READ);
+
 	/*
 	 * Put the reader into the wait queue
 	 */
@@ -51,6 +54,8 @@ void queued_read_lock_slowpath(struct qrwlock *lock)
 	 * Signal the next one in queue to become queue head
 	 */
 	arch_spin_unlock(&lock->wait_lock);
+
+	trace_contention_end(lock, 0);
 }
 EXPORT_SYMBOL(queued_read_lock_slowpath);
 
@@ -62,6 +67,8 @@ void queued_write_lock_slowpath(struct qrwlock *lock)
 {
 	int cnts;
 
+	trace_contention_begin(lock, LCB_F_SPIN | LCB_F_WRITE);
+
 	/* Put the writer into the wait queue */
 	arch_spin_lock(&lock->wait_lock);
 
@@ -79,5 +86,7 @@ void queued_write_lock_slowpath(struct qrwlock *lock)
 	} while (!atomic_try_cmpxchg_acquire(&lock->cnts, &cnts, _QW_LOCKED));
 unlock:
 	arch_spin_unlock(&lock->wait_lock);
+
+	trace_contention_end(lock, 0);
 }
 EXPORT_SYMBOL(queued_write_lock_slowpath);
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index cbff6ba..65a9a10 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -22,6 +22,7 @@
 #include <linux/prefetch.h>
 #include <asm/byteorder.h>
 #include <asm/qspinlock.h>
+#include <trace/events/lock.h>
 
 /*
  * Include queued spinlock statistics code
@@ -401,6 +402,8 @@ pv_queue:
 	idx = node->count++;
 	tail = encode_tail(smp_processor_id(), idx);
 
+	trace_contention_begin(lock, LCB_F_SPIN);
+
 	/*
 	 * 4 nodes are allocated based on the assumption that there will
 	 * not be nested NMIs taking spinlocks. That may not be true in
@@ -554,6 +557,8 @@ locked:
 	pv_kick_node(lock, next);
 
 release:
+	trace_contention_end(lock, 0);
+
 	/*
 	 * release the node
 	 */
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 8555c4e..7779ee8 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -24,6 +24,8 @@
 #include <linux/sched/wake_q.h>
 #include <linux/ww_mutex.h>
 
+#include <trace/events/lock.h>
+
 #include "rtmutex_common.h"
 
 #ifndef WW_RT
@@ -1579,6 +1581,8 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
 
 	set_current_state(state);
 
+	trace_contention_begin(lock, LCB_F_RT);
+
 	ret = task_blocks_on_rt_mutex(lock, waiter, current, ww_ctx, chwalk);
 	if (likely(!ret))
 		ret = rt_mutex_slowlock_block(lock, ww_ctx, state, NULL, waiter);
@@ -1601,6 +1605,9 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
 	 * unconditionally. We might have to fix that up.
 	 */
 	fixup_rt_mutex_waiters(lock);
+
+	trace_contention_end(lock, ret);
+
 	return ret;
 }
 
@@ -1683,6 +1690,8 @@ static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock)
 	/* Save current state and set state to TASK_RTLOCK_WAIT */
 	current_save_and_set_rtlock_wait_state();
 
+	trace_contention_begin(lock, LCB_F_RT);
+
 	task_blocks_on_rt_mutex(lock, &waiter, current, NULL, RT_MUTEX_MIN_CHAINWALK);
 
 	for (;;) {
@@ -1712,6 +1721,8 @@ static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock)
 	 */
 	fixup_rt_mutex_waiters(lock);
 	debug_rt_mutex_free_waiter(&waiter);
+
+	trace_contention_end(lock, 0);
 }
 
 static __always_inline void __sched rtlock_slowlock(struct rt_mutex_base *lock)
diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index 6fd3162..c201aad 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -112,6 +112,8 @@ static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
 	 * Reader2 to call up_read(), which might be unbound.
 	 */
 
+	trace_contention_begin(rwb, LCB_F_RT | LCB_F_READ);
+
 	/*
 	 * For rwlocks this returns 0 unconditionally, so the below
 	 * !ret conditionals are optimized out.
@@ -130,6 +132,8 @@ static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
 	raw_spin_unlock_irq(&rtm->wait_lock);
 	if (!ret)
 		rwbase_rtmutex_unlock(rtm);
+
+	trace_contention_end(rwb, ret);
 	return ret;
 }
 
@@ -247,11 +251,13 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
 		goto out_unlock;
 
 	rwbase_set_and_save_current_state(state);
+	trace_contention_begin(rwb, LCB_F_RT | LCB_F_WRITE);
 	for (;;) {
 		/* Optimized out for rwlocks */
 		if (rwbase_signal_pending_state(state, current)) {
 			rwbase_restore_current_state();
 			__rwbase_write_unlock(rwb, 0, flags);
+			trace_contention_end(rwb, -EINTR);
 			return -EINTR;
 		}
 
@@ -265,6 +271,7 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
 		set_current_state(state);
 	}
 	rwbase_restore_current_state();
+	trace_contention_end(rwb, 0);
 
 out_unlock:
 	raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 16b532b..9d1db4a 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -27,6 +27,7 @@
 #include <linux/export.h>
 #include <linux/rwsem.h>
 #include <linux/atomic.h>
+#include <trace/events/lock.h>
 
 #ifndef CONFIG_PREEMPT_RT
 #include "lock_events.h"
@@ -1056,6 +1057,8 @@ queue:
 	if (!wake_q_empty(&wake_q))
 		wake_up_q(&wake_q);
 
+	trace_contention_begin(sem, LCB_F_READ);
+
 	/* wait to be given the lock */
 	for (;;) {
 		set_current_state(state);
@@ -1077,12 +1080,14 @@ queue:
 
 	__set_current_state(TASK_RUNNING);
 	lockevent_inc(rwsem_rlock);
+	trace_contention_end(sem, 0);
 	return sem;
 
 out_nolock:
 	rwsem_del_wake_waiter(sem, &waiter, &wake_q);
 	__set_current_state(TASK_RUNNING);
 	lockevent_inc(rwsem_rlock_fail);
+	trace_contention_end(sem, -EINTR);
 	return ERR_PTR(-EINTR);
 }
 
@@ -1132,6 +1137,8 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 
 	/* wait until we successfully acquire the lock */
 	set_current_state(state);
+	trace_contention_begin(sem, LCB_F_WRITE);
+
 	for (;;) {
 		if (rwsem_try_write_lock(sem, &waiter)) {
 			/* rwsem_try_write_lock() implies ACQUIRE on success */
@@ -1171,6 +1178,7 @@ trylock_again:
 	__set_current_state(TASK_RUNNING);
 	raw_spin_unlock_irq(&sem->wait_lock);
 	lockevent_inc(rwsem_wlock);
+	trace_contention_end(sem, 0);
 	return sem;
 
 out_nolock:
@@ -1178,6 +1186,7 @@ out_nolock:
 	raw_spin_lock_irq(&sem->wait_lock);
 	rwsem_del_wake_waiter(sem, &waiter, &wake_q);
 	lockevent_inc(rwsem_wlock_fail);
+	trace_contention_end(sem, -EINTR);
 	return ERR_PTR(-EINTR);
 }
 
diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
index 9ee381e..f2654d2 100644
--- a/kernel/locking/semaphore.c
+++ b/kernel/locking/semaphore.c
@@ -32,6 +32,7 @@
 #include <linux/semaphore.h>
 #include <linux/spinlock.h>
 #include <linux/ftrace.h>
+#include <trace/events/lock.h>
 
 static noinline void __down(struct semaphore *sem);
 static noinline int __down_interruptible(struct semaphore *sem);
@@ -205,7 +206,7 @@ struct semaphore_waiter {
  * constant, and thus optimised away by the compiler.  Likewise the
  * 'timeout' parameter for the cases without timeouts.
  */
-static inline int __sched __down_common(struct semaphore *sem, long state,
+static inline int __sched ___down_common(struct semaphore *sem, long state,
 								long timeout)
 {
 	struct semaphore_waiter waiter;
@@ -236,6 +237,18 @@ static inline int __sched __down_common(struct semaphore *sem, long state,
 	return -EINTR;
 }
 
+static inline int __sched __down_common(struct semaphore *sem, long state,
+					long timeout)
+{
+	int ret;
+
+	trace_contention_begin(sem, 0);
+	ret = ___down_common(sem, state, timeout);
+	trace_contention_end(sem, ret);
+
+	return ret;
+}
+
 static noinline void __sched __down(struct semaphore *sem)
 {
 	__down_common(sem, TASK_UNINTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA286469E8D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357140AbhLFPjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385666AbhLFPZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:25:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7B0C08EB50;
        Mon,  6 Dec 2021 07:15:44 -0800 (PST)
Date:   Mon, 06 Dec 2021 15:15:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638803742;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8bMc8Ucgr5slchTdgqdiq+r9zqD0nZOwVt28idzt7fE=;
        b=iD9GwfuWRX4fqReaaJnWRnncFFNVUZg3saDWK5ej6nRYxvwbhKj8JvalIrBmGLYjlTXddP
        zL5mnLelgHawD1eYS4o6M4vUzyuQFRkL5mHhRys8tU9UESSfxv2yZ0jPNnF+EyLkStuL9R
        +5geYg5WKWEpMr3cqe0egTYJqpNIOZgZVBpsKrmRRMtX85yMuNdqc6n9noXeGVeBU/wc5S
        bgFUvDdYajJ5bfb9LuNKADbX/HTtvhD5hNnw8SYoi4DFKQulzYgdb2zHe1R4JuKiv6ZFfN
        P14FRaZCwJAAAG2lkVu+/BBq8KwaEysL85Ofpfz5JeQONjXwPonjXeUgqQ9Slg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638803742;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8bMc8Ucgr5slchTdgqdiq+r9zqD0nZOwVt28idzt7fE=;
        b=ZCQfEsAYmYV6+Xzno02l5hOV8QMc7atpV1P9/U4Tbom3SZfX30VkwlrEIKIiVyPC/OtIwD
        xiw1mEbfjBcSoOAA==
From:   "tip-bot2 for Kefeng Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking: Make owner_on_cpu() into <linux/sched.h>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211203075935.136808-2-wangkefeng.wang@huawei.com>
References: <20211203075935.136808-2-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Message-ID: <163880374192.11128.17839358961793759820.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     c0bed69daf4b67809b58cc7cd81a8fa4f45bc161
Gitweb:        https://git.kernel.org/tip/c0bed69daf4b67809b58cc7cd81a8fa4f45bc161
Author:        Kefeng Wang <wangkefeng.wang@huawei.com>
AuthorDate:    Fri, 03 Dec 2021 15:59:34 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 04 Dec 2021 10:56:25 +01:00

locking: Make owner_on_cpu() into <linux/sched.h>

Move the owner_on_cpu() from kernel/locking/rwsem.c into
include/linux/sched.h with under CONFIG_SMP, then use it
in the mutex/rwsem/rtmutex to simplify the code.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20211203075935.136808-2-wangkefeng.wang@huawei.com
---
 include/linux/sched.h    |  9 +++++++++
 kernel/locking/mutex.c   | 11 ++---------
 kernel/locking/rtmutex.c |  5 ++---
 kernel/locking/rwsem.c   |  9 ---------
 4 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 78c351e..ff609d9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2171,6 +2171,15 @@ extern long sched_getaffinity(pid_t pid, struct cpumask *mask);
 #endif
 
 #ifdef CONFIG_SMP
+static inline bool owner_on_cpu(struct task_struct *owner)
+{
+	/*
+	 * As lock holder preemption issue, we both skip spinning if
+	 * task is not on cpu or its cpu is preempted
+	 */
+	return owner->on_cpu && !vcpu_is_preempted(task_cpu(owner));
+}
+
 /* Returns effective CPU energy utilization, as seen by the scheduler */
 unsigned long sched_cpu_util(int cpu, unsigned long max);
 #endif /* CONFIG_SMP */
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index db19136..5e35859 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -367,8 +367,7 @@ bool mutex_spin_on_owner(struct mutex *lock, struct task_struct *owner,
 		/*
 		 * Use vcpu_is_preempted to detect lock holder preemption issue.
 		 */
-		if (!owner->on_cpu || need_resched() ||
-				vcpu_is_preempted(task_cpu(owner))) {
+		if (!owner_on_cpu(owner) || need_resched()) {
 			ret = false;
 			break;
 		}
@@ -403,14 +402,8 @@ static inline int mutex_can_spin_on_owner(struct mutex *lock)
 	 * structure won't go away during the spinning period.
 	 */
 	owner = __mutex_owner(lock);
-
-	/*
-	 * As lock holder preemption issue, we both skip spinning if task is not
-	 * on cpu or its cpu is preempted
-	 */
-
 	if (owner)
-		retval = owner->on_cpu && !vcpu_is_preempted(task_cpu(owner));
+		retval = owner_on_cpu(owner);
 
 	/*
 	 * If lock->owner is not set, the mutex has been released. Return true
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index f896208..0c1f2e3 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1382,9 +1382,8 @@ static bool rtmutex_spin_on_owner(struct rt_mutex_base *lock,
 		 *    for CONFIG_PREEMPT_RCU=y)
 		 *  - the VCPU on which owner runs is preempted
 		 */
-		if (!owner->on_cpu || need_resched() ||
-		    rt_mutex_waiter_is_top_waiter(lock, waiter) ||
-		    vcpu_is_preempted(task_cpu(owner))) {
+		if (!owner_on_cpu(owner) || need_resched() ||
+		    rt_mutex_waiter_is_top_waiter(lock, waiter)) {
 			res = false;
 			break;
 		}
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index c51387a..b92d0a8 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -613,15 +613,6 @@ static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem)
 	return false;
 }
 
-static inline bool owner_on_cpu(struct task_struct *owner)
-{
-	/*
-	 * As lock holder preemption issue, we both skip spinning if
-	 * task is not on cpu or its cpu is preempted
-	 */
-	return owner->on_cpu && !vcpu_is_preempted(task_cpu(owner));
-}
-
 static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 {
 	struct task_struct *owner;

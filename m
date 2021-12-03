Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A004672E7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 08:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351131AbhLCHwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 02:52:19 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:32875 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350252AbhLCHwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 02:52:18 -0500
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J54hD3ZPDzcbpX;
        Fri,  3 Dec 2021 15:48:44 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 15:48:52 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 15:48:52 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 1/2] locking: Make owner_on_cpu() into <linux/sched.h>
Date:   Fri, 3 Dec 2021 15:59:34 +0800
Message-ID: <20211203075935.136808-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211203075935.136808-1-wangkefeng.wang@huawei.com>
References: <20211203075935.136808-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the owner_on_cpu() from kernel/locking/rwsem.c into
include/linux/sched.h with under CONFIG_SMP, then use it
in the mutex/rwsem/rtmutex to simplify the code.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/sched.h    |  9 +++++++++
 kernel/locking/mutex.c   | 11 ++---------
 kernel/locking/rtmutex.c |  5 ++---
 kernel/locking/rwsem.c   |  9 ---------
 4 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 78c351e35fec..ff609d9c2f21 100644
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
index db1913611192..5e3585950ec8 100644
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
index 0c6a48dfcecb..41152e8e799a 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1379,9 +1379,8 @@ static bool rtmutex_spin_on_owner(struct rt_mutex_base *lock,
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
index 04a74d040a6d..69aba4abe104 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -658,15 +658,6 @@ static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem)
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
-- 
2.26.2


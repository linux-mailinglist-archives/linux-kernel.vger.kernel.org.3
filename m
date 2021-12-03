Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD174672E8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 08:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378970AbhLCHwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 02:52:21 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:27340 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351054AbhLCHwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 02:52:18 -0500
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J54hD59c9zbjJb;
        Fri,  3 Dec 2021 15:48:44 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 15:48:53 +0800
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
        Marco Elver <elver@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 2/2] locking: Mark racy reads of owner->on_cpu
Date:   Fri, 3 Dec 2021 15:59:35 +0800
Message-ID: <20211203075935.136808-3-wangkefeng.wang@huawei.com>
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

From: Marco Elver <elver@google.com>

One of the more frequent data races reported by KCSAN is the racy read
in mutex_spin_on_owner(), which is usually reported as "race of unknown
origin" without showing the writer. This is due to the racing write
occurring in kernel/sched. Locally enabling KCSAN in kernel/sched shows:

 | write (marked) to 0xffff97f205079934 of 4 bytes by task 316 on cpu 6:
 |  finish_task                kernel/sched/core.c:4632 [inline]
 |  finish_task_switch         kernel/sched/core.c:4848
 |  context_switch             kernel/sched/core.c:4975 [inline]
 |  __schedule                 kernel/sched/core.c:6253
 |  schedule                   kernel/sched/core.c:6326
 |  schedule_preempt_disabled  kernel/sched/core.c:6385
 |  __mutex_lock_common        kernel/locking/mutex.c:680
 |  __mutex_lock               kernel/locking/mutex.c:740 [inline]
 |  __mutex_lock_slowpath      kernel/locking/mutex.c:1028
 |  mutex_lock                 kernel/locking/mutex.c:283
 |  tty_open_by_driver         drivers/tty/tty_io.c:2062 [inline]
 |  ...
 |
 | read to 0xffff97f205079934 of 4 bytes by task 322 on cpu 3:
 |  mutex_spin_on_owner        kernel/locking/mutex.c:370
 |  mutex_optimistic_spin      kernel/locking/mutex.c:480
 |  __mutex_lock_common        kernel/locking/mutex.c:610
 |  __mutex_lock               kernel/locking/mutex.c:740 [inline]
 |  __mutex_lock_slowpath      kernel/locking/mutex.c:1028
 |  mutex_lock                 kernel/locking/mutex.c:283
 |  tty_open_by_driver         drivers/tty/tty_io.c:2062 [inline]
 |  ...
 |
 | value changed: 0x00000001 -> 0x00000000

This race is clearly intentional, and the potential for miscompilation
is slim due to surrounding barrier() and cpu_relax(), and the value
being used as a boolean.

Nevertheless, marking this reader would more clearly denote intent and
make it obvious that concurrency is expected. Use READ_ONCE() to avoid
having to reason about compiler optimizations now and in future.

With previous refactor, mark the read to owner->on_cpu in owner_on_cpu(),
which immediately precedes the loop executing mutex_spin_on_owner().

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index ff609d9c2f21..0b9b0e3f4791 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2177,7 +2177,7 @@ static inline bool owner_on_cpu(struct task_struct *owner)
 	 * As lock holder preemption issue, we both skip spinning if
 	 * task is not on cpu or its cpu is preempted
 	 */
-	return owner->on_cpu && !vcpu_is_preempted(task_cpu(owner));
+	return READ_ONCE(owner->on_cpu) && !vcpu_is_preempted(task_cpu(owner));
 }
 
 /* Returns effective CPU energy utilization, as seen by the scheduler */
-- 
2.26.2


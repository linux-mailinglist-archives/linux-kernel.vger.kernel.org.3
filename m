Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047354929B5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 16:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345834AbiARPfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 10:35:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54331 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238270AbiARPfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 10:35:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642520109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=03W0CajDsWL8nkNyBb+ZXdbNP0dR+eVZouhyVqFR/1Q=;
        b=ML9IYD2Hk0dhejM1/T5Rf2uKX9POsmYZZEF0+WloeMmNs1bhJrmsxY9/dwE/ybjYptDQSX
        VxziXil5JuoH44OfTp2KH0cGifuIndydnyLclqe2Kfd7Mb1hZ1JcRNoU4ElIBxka/0TLJp
        e9ys4ZT5JKpQSgbJK2UUB7Nru2vMU9U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121-wv9rVZS0PC-dp6oha4b2sg-1; Tue, 18 Jan 2022 10:35:06 -0500
X-MC-Unique: wv9rVZS0PC-dp6oha4b2sg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED18A1825174;
        Tue, 18 Jan 2022 15:33:10 +0000 (UTC)
Received: from llong.com (unknown [10.22.35.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E3946753EF;
        Tue, 18 Jan 2022 15:33:09 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH] locking/semaphore: Use wake_q to wake up processes outside lock critical section
Date:   Tue, 18 Jan 2022 10:32:54 -0500
Message-Id: <20220118153254.358748-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following lockdep splat was observed:

[ 9776.459819] ======================================================
[ 9776.459820] WARNING: possible circular locking dependency detected
[ 9776.459821] 5.14.0-0.rc4.35.el9.x86_64+debug #1 Not tainted
[ 9776.459823] ------------------------------------------------------
[ 9776.459824] stress-ng/117708 is trying to acquire lock:
[ 9776.459825] ffffffff892d41d8 ((console_sem).lock){-...}-{2:2}, at: down_trylock+0x13/0x70

[ 9776.459831] but task is already holding lock:
[ 9776.459832] ffff888e005f6d18 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x27/0x130

[ 9776.459837] which lock already depends on the new lock.
      :
[ 9776.459857] -> #1 (&p->pi_lock){-.-.}-{2:2}:
[ 9776.459860]        __lock_acquire+0xb72/0x1870
[ 9776.459861]        lock_acquire+0x1ca/0x570
[ 9776.459862]        _raw_spin_lock_irqsave+0x40/0x90
[ 9776.459863]        try_to_wake_up+0x9d/0x1210
[ 9776.459864]        up+0x7a/0xb0
[ 9776.459864]        __up_console_sem+0x33/0x70
[ 9776.459865]        console_unlock+0x3a1/0x5f0
[ 9776.459866]        vprintk_emit+0x23b/0x2b0
[ 9776.459867]        devkmsg_emit.constprop.0+0xab/0xdc
[ 9776.459868]        devkmsg_write.cold+0x4e/0x78
[ 9776.459869]        do_iter_readv_writev+0x343/0x690
[ 9776.459870]        do_iter_write+0x123/0x340
[ 9776.459871]        vfs_writev+0x19d/0x520
[ 9776.459871]        do_writev+0x110/0x290
[ 9776.459872]        do_syscall_64+0x3b/0x90
[ 9776.459873]        entry_SYSCALL_64_after_hwframe+0x44/0xae
      :
[ 9776.459905] Chain exists of:
[ 9776.459906]   (console_sem).lock --> &p->pi_lock --> &rq->__lock

[ 9776.459911]  Possible unsafe locking scenario:

[ 9776.459913]        CPU0                    CPU1
[ 9776.459914]        ----                    ----
[ 9776.459914]   lock(&rq->__lock);
[ 9776.459917]                                lock(&p->pi_lock);
[ 9776.459919]                                lock(&rq->__lock);
[ 9776.459921]   lock((console_sem).lock);

[ 9776.459923]  *** DEADLOCK ***

The problematic locking sequence ((console_sem).lock --> &p->pi_lock)
was caused by the fact the semaphore up() function is calling
wake_up_process() while holding the semaphore raw spinlock.

By moving the wake_up_processs() call out of the raw spinlock critical
section using wake_q, it will break the problematic locking sequence as
well as reducing raw spinlock hold time which will be good for
PREEMPT_RT.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/semaphore.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
index 9ee381e4d2a4..a26c915430ba 100644
--- a/kernel/locking/semaphore.c
+++ b/kernel/locking/semaphore.c
@@ -29,6 +29,7 @@
 #include <linux/export.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
+#include <linux/sched/wake_q.h>
 #include <linux/semaphore.h>
 #include <linux/spinlock.h>
 #include <linux/ftrace.h>
@@ -37,7 +38,7 @@ static noinline void __down(struct semaphore *sem);
 static noinline int __down_interruptible(struct semaphore *sem);
 static noinline int __down_killable(struct semaphore *sem);
 static noinline int __down_timeout(struct semaphore *sem, long timeout);
-static noinline void __up(struct semaphore *sem);
+static noinline void __up(struct semaphore *sem, struct wake_q_head *wake_q);
 
 /**
  * down - acquire the semaphore
@@ -182,13 +183,16 @@ EXPORT_SYMBOL(down_timeout);
 void up(struct semaphore *sem)
 {
 	unsigned long flags;
+	DEFINE_WAKE_Q(wake_q);
 
 	raw_spin_lock_irqsave(&sem->lock, flags);
 	if (likely(list_empty(&sem->wait_list)))
 		sem->count++;
 	else
-		__up(sem);
+		__up(sem, &wake_q);
 	raw_spin_unlock_irqrestore(&sem->lock, flags);
+	if (!wake_q_empty(&wake_q))
+		wake_up_q(&wake_q);
 }
 EXPORT_SYMBOL(up);
 
@@ -256,11 +260,12 @@ static noinline int __sched __down_timeout(struct semaphore *sem, long timeout)
 	return __down_common(sem, TASK_UNINTERRUPTIBLE, timeout);
 }
 
-static noinline void __sched __up(struct semaphore *sem)
+static noinline void __sched __up(struct semaphore *sem,
+				  struct wake_q_head *wake_q)
 {
 	struct semaphore_waiter *waiter = list_first_entry(&sem->wait_list,
 						struct semaphore_waiter, list);
 	list_del(&waiter->list);
 	waiter->up = true;
-	wake_up_process(waiter->task);
+	wake_q_add(wake_q, waiter->task);
 }
-- 
2.27.0


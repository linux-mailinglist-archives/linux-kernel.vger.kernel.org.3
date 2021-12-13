Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2562472C6E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbhLMMkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:40:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30690 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236851AbhLMMkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:40:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639399217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NK/4X4SVplBV/d2WQkR15TolXv79Z6sovnlVcWNu2ko=;
        b=TgofbcQxzHgy2M2xZX1krjOO7biUbPAYwMDQpF46pnQDCpDQl95geYR/v/39siVtcd0pZr
        l2Jh8wlUwmcUhUGI92c2wOfN4sluv02bl+FnMjuJ/WVSIrwDxq3z3k6E5dlmT8alVWA2HV
        B2zN9+wtiUZlQXSxHjIMHadldaqn9zE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-23-PWbM3UJBOQmjqn3I9y3CUw-1; Mon, 13 Dec 2021 07:40:14 -0500
X-MC-Unique: PWbM3UJBOQmjqn3I9y3CUw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F33593925;
        Mon, 13 Dec 2021 12:40:13 +0000 (UTC)
Received: from wcosta.com (ovpn-116-142.gru2.redhat.com [10.97.116.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B3B79779D2;
        Mon, 13 Dec 2021 12:40:03 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org,
        Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH v2 2/2] blktrace: switch trace spinlock to a raw spinlock
Date:   Mon, 13 Dec 2021 09:37:37 -0300
Message-Id: <20211213123737.9147-3-wander@redhat.com>
In-Reply-To: <20211213123737.9147-1-wander@redhat.com>
References: <20211213123737.9147-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TRACE_EVENT disables preemption before calling the callback. Because of
that blktrace triggers the following bug under PREEMPT_RT:

 BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:35
 in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 119, name: kworker/u2:2
 5 locks held by kworker/u2:2/119:
  #0: ffff8c2e4a88f538 ((wq_completion)xfs-cil/dm-0){+.+.}-{0:0}, at: process_one_work+0x200/0x450
  #1: ffffab3840ac7e68 ((work_completion)(&cil->xc_push_work)){+.+.}-{0:0}, at: process_one_work+0x200/0x450
  #2: ffff8c2e4a887128 (&cil->xc_ctx_lock){++++}-{3:3}, at: xlog_cil_push_work+0xb7/0x670 [xfs]
  #3: ffffffffa6a63780 (rcu_read_lock){....}-{1:2}, at: blk_add_trace_bio+0x0/0x1f0
  #4: ffffffffa6610620 (running_trace_lock){+.+.}-{2:2}, at: __blk_add_trace+0x3ef/0x480
 Preemption disabled at:
 [<ffffffffa4d35c05>] migrate_enable+0x45/0x140
 CPU: 0 PID: 119 Comm: kworker/u2:2 Kdump: loaded Not tainted 5.14.0-25.rt21.25.light.el9.x86_64+debug #1
 Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
 Workqueue: xfs-cil/dm-0 xlog_cil_push_work [xfs]
 Call Trace:
  ? migrate_enable+0x45/0x140
  dump_stack_lvl+0x57/0x7d
  ___might_sleep.cold+0xe3/0xf7
  rt_spin_lock+0x3a/0xd0
  ? __blk_add_trace+0x3ef/0x480
  __blk_add_trace+0x3ef/0x480
  blk_add_trace_bio+0x18d/0x1f0
  trace_block_bio_queue+0xb5/0x150
  submit_bio_checks+0x1f0/0x520
  ? sched_clock_cpu+0xb/0x100
  submit_bio_noacct+0x30/0x1d0
  ? bio_associate_blkg+0x66/0x190
  xlog_cil_push_work+0x1b6/0x670 [xfs]
  ? register_lock_class+0x43/0x4f0
  ? xfs_swap_extents+0x5f0/0x5f0 [xfs]
  process_one_work+0x275/0x450
  ? process_one_work+0x200/0x450
  worker_thread+0x55/0x3c0
  ? process_one_work+0x450/0x450
  kthread+0x188/0x1a0
  ? set_kthread_struct+0x40/0x40
  ret_from_fork+0x22/0x30

To avoid this bug, we switch the trace lock to a raw spinlock.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 kernel/trace/blktrace.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 1183c88634aa..a86e022f7155 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -34,7 +34,7 @@ static struct trace_array *blk_tr;
 static bool blk_tracer_enabled __read_mostly;
 
 static LIST_HEAD(running_trace_list);
-static __cacheline_aligned_in_smp DEFINE_SPINLOCK(running_trace_lock);
+static __cacheline_aligned_in_smp DEFINE_RAW_SPINLOCK(running_trace_lock);
 
 /* Select an alternative, minimalistic output than the original one */
 #define TRACE_BLK_OPT_CLASSIC	0x1
@@ -121,12 +121,12 @@ static void trace_note_tsk(struct task_struct *tsk)
 	struct blk_trace *bt;
 
 	tsk->btrace_seq = blktrace_seq;
-	spin_lock_irqsave(&running_trace_lock, flags);
+	raw_spin_lock_irqsave(&running_trace_lock, flags);
 	list_for_each_entry(bt, &running_trace_list, running_list) {
 		trace_note(bt, tsk->pid, BLK_TN_PROCESS, tsk->comm,
 			   sizeof(tsk->comm), 0);
 	}
-	spin_unlock_irqrestore(&running_trace_lock, flags);
+	raw_spin_unlock_irqrestore(&running_trace_lock, flags);
 }
 
 static void trace_note_time(struct blk_trace *bt)
@@ -666,9 +666,9 @@ static int __blk_trace_startstop(struct request_queue *q, int start)
 			blktrace_seq++;
 			smp_mb();
 			bt->trace_state = Blktrace_running;
-			spin_lock_irq(&running_trace_lock);
+			raw_spin_lock_irq(&running_trace_lock);
 			list_add(&bt->running_list, &running_trace_list);
-			spin_unlock_irq(&running_trace_lock);
+			raw_spin_unlock_irq(&running_trace_lock);
 
 			trace_note_time(bt);
 			ret = 0;
@@ -676,9 +676,9 @@ static int __blk_trace_startstop(struct request_queue *q, int start)
 	} else {
 		if (bt->trace_state == Blktrace_running) {
 			bt->trace_state = Blktrace_stopped;
-			spin_lock_irq(&running_trace_lock);
+			raw_spin_lock_irq(&running_trace_lock);
 			list_del_init(&bt->running_list);
-			spin_unlock_irq(&running_trace_lock);
+			raw_spin_unlock_irq(&running_trace_lock);
 			relay_flush(bt->rchan);
 			ret = 0;
 		}
@@ -1608,9 +1608,9 @@ static int blk_trace_remove_queue(struct request_queue *q)
 
 	if (bt->trace_state == Blktrace_running) {
 		bt->trace_state = Blktrace_stopped;
-		spin_lock_irq(&running_trace_lock);
+		raw_spin_lock_irq(&running_trace_lock);
 		list_del_init(&bt->running_list);
-		spin_unlock_irq(&running_trace_lock);
+		raw_spin_unlock_irq(&running_trace_lock);
 		relay_flush(bt->rchan);
 	}
 
-- 
2.27.0


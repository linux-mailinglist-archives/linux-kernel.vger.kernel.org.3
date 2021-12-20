Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1B647B3B6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 20:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240821AbhLTT3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 14:29:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40035 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234110AbhLTT25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 14:28:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640028535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dlC9IUKSwMHS+sDIJAVY7Vo/B/vSajwJC4Cbdvt/YHo=;
        b=MVJ7UIdogOyYkSRhWJQuxDIi6aQjf2jzyICIAmPoxvWSuBfU7TLQqkIk96N5cLtvgy23Ae
        oiNmoPW55+9kdMEqCm5nHP6+nUL2D0UfGnpqKa5f8w0FE1uL1DY4JqU8Hr6VG5OuJB30P+
        kDS67yplyCL1nhm/QQ1NRwQfp4uTk1A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-CMdFZ3a_PN-GIiiDeKPKIQ-1; Mon, 20 Dec 2021 14:28:52 -0500
X-MC-Unique: CMdFZ3a_PN-GIiiDeKPKIQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3280D1923B83;
        Mon, 20 Dec 2021 19:28:51 +0000 (UTC)
Received: from wcosta.com (ovpn-116-93.gru2.redhat.com [10.97.116.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB5405BD25;
        Mon, 20 Dec 2021 19:28:38 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER)
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH v5 1/1] blktrace: switch trace spinlock to a raw spinlock
Date:   Mon, 20 Dec 2021 16:28:27 -0300
Message-Id: <20211220192827.38297-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The running_trace_lock protects running_trace_list and is acquired
within the tracepoint which implies disabled preemption. The spinlock_t
typed lock can not be acquired with disabled preemption on PREEMPT_RT
because it becomes a sleeping lock.
The runtime of the tracepoint depends on the number of entries in
running_trace_list and has no limit. The blk-tracer is considered debug
code and higher latencies here are okay.

Make running_trace_lock a raw_spinlock_t.

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


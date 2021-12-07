Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D2746B413
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 08:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhLGHjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 02:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbhLGHjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 02:39:43 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279B1C0611F7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 23:36:12 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id q16so12988268pgq.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 23:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n+cZhPTYm1urZ+YBNkTg4x7hD/7gSRC87lXtYVYV9Cs=;
        b=nFV9kIhyjolmv81GIDRhAV1i2lNrZMOVBKYMNo+K5nWNdY0TK/G1XzuJBUck7OIVkO
         T6yUs5YrOPp75JtZu0lqzoh9UoBikEqNiZszfN+xKePacuGIITpX/ozcwLybYhmByb1u
         cfOlf6IZrMRUF8qqewYm0kIW3w2Nd9vsbIiPRYQYW5lvrqRvPPGcGrb4TCskjgO16WFr
         115quDNsy+zkVaC3+k9PC4QHNHLCIiiuu3RxMJsv2ehF0rtS0CheGM5Frmuf6xh+FCDB
         ogJtLlIavbPLTdoGPj4QB9EqVeq3pFzkprqc2k/k7XDuYeBExeCw1nkR1HM+ylvW3QP3
         dIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n+cZhPTYm1urZ+YBNkTg4x7hD/7gSRC87lXtYVYV9Cs=;
        b=4D/3QcqmUJnEbUr+TIlU0hQzLRi0a7m16y1sOeRDhZ9zE2uvklRjIhtEZ0HnzW7C4P
         Eys0LwA1vQ6f5yt2NZsEc7DhXPHtMRev5e8xGq1j30lSvzSAyC6VGJZnUn5XtN1Q0/9/
         ZAOmIH9ZVy0uoHvF18xNjwghJ+exY65+s2V1MdkgxEMW6CNvSt3txFsuFSO6uNjR04Co
         P2iWc9Kmv6oArSBordSDLBiRzrFsO/E1TNAIMKY1YQO/7eHq1taOdPLCODcMvVrV8fUa
         fpLG+2IqhX/X6WpVoqd0rkCSz+qIhURiHVhnYcBdH4gDN8SaZcXyAPgm9AbJSRS0dac+
         hUlQ==
X-Gm-Message-State: AOAM530fXJxa91ontJx5+OnqGZnLfXsYqI8y6rouTh77C54zqIpSyXDz
        kki4p0cWuQqOKdkoyUGwGNGUJPx/02w=
X-Google-Smtp-Source: ABdhPJzzw7kh2vSGcbXfyIcueZFrB/VrN+dKfN3SWxmUXsMWUxP2lp92YDCpDaIju5kV8bLHI43Mxg==
X-Received: by 2002:a05:6a00:16c6:b0:4a8:261d:6013 with SMTP id l6-20020a056a0016c600b004a8261d6013mr40848074pfc.82.1638862571561;
        Mon, 06 Dec 2021 23:36:11 -0800 (PST)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id lx15sm1742848pjb.44.2021.12.06.23.36.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Dec 2021 23:36:11 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [RFC PATCH 7/7] workqueue: Replace pool lock with preemption disabling in wq_worker_sleeping()
Date:   Tue,  7 Dec 2021 15:35:43 +0800
Message-Id: <20211207073543.61092-8-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211207073543.61092-1-jiangshanlai@gmail.com>
References: <20211207073543.61092-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Once upon a time,  wq_worker_sleeping() was called with rq lock held,
so wq_worker_sleeping() can not use pool lock.  Instead it used "X:"
protection: preemption disabled on local cpu and wq_worker_sleeping()
didn't depend on rq lock to work even with it held.

Now, wq_worker_sleeping() isn't called with rq lock held and is using
pool lock.  But the functionality of "X:" protection isn't removed and
wq_worker_running() is still using it.

So we can also use "X:" protection in wq_worker_sleeping() and avoid
locking the pool lock.

This patch also documents that only idle_list.next is under "X:"
protection, not the whole idle_list because destroy_worker() in idle
timer can remove non-first idle workers.  Idle timer can be possible
strayed in different CPU, or even in the same CPU, it can interrupt
preemption disabled context.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 33f1106b4f99..6c30edbe2fc2 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -162,7 +162,8 @@ struct worker_pool {
 	int			nr_workers;	/* L: total number of workers */
 	int			nr_idle;	/* L: currently idle workers */
 
-	struct list_head	idle_list;	/* X: list of idle workers */
+	/* idle_list.next and first_idle_worker(): X: first idle worker */
+	struct list_head	idle_list;	/* L: list of idle workers */
 	struct timer_list	idle_timer;	/* L: worker idle timeout */
 	struct timer_list	mayday_timer;	/* L: SOS timer for workers */
 
@@ -819,6 +820,11 @@ static bool too_many_workers(struct worker_pool *pool)
 	int nr_idle = pool->nr_idle + managing; /* manager is considered idle */
 	int nr_busy = pool->nr_workers - nr_idle;
 
+	/*
+	 * nr_idle must be at least 2 to allow a manager and at least an idle
+	 * worker in idle_list so that idle_worker_timeout() doesn't touch
+	 * idle_list.next.
+	 */
 	return nr_idle > 2 && (nr_idle - 2) * MAX_IDLE_WORKERS_RATIO >= nr_busy;
 }
 
@@ -826,7 +832,7 @@ static bool too_many_workers(struct worker_pool *pool)
  * Wake up functions.
  */
 
-/* Return the first idle worker.  Safe with preemption disabled */
+/* Return the first idle worker.  Safe with "X:" protection */
 static struct worker *first_idle_worker(struct worker_pool *pool)
 {
 	if (unlikely(list_empty(&pool->idle_list)))
@@ -905,7 +911,7 @@ void wq_worker_sleeping(struct task_struct *task)
 		return;
 
 	worker->sleeping = 1;
-	raw_spin_lock_irq(&pool->lock);
+	preempt_disable();
 
 	/*
 	 * Recheck in case unbind_workers() preempted us. We don't
@@ -913,7 +919,7 @@ void wq_worker_sleeping(struct task_struct *task)
 	 * and nr_running has been reset.
 	 */
 	if (worker->flags & WORKER_NOT_RUNNING) {
-		raw_spin_unlock_irq(&pool->lock);
+		preempt_enable();
 		return;
 	}
 
@@ -923,10 +929,9 @@ void wq_worker_sleeping(struct task_struct *task)
 	 * Please read comment there.
 	 *
 	 * NOT_RUNNING is clear.  This means that we're bound to and
-	 * running on the local cpu w/ rq lock held and preemption
-	 * disabled, which in turn means that none else could be
-	 * manipulating idle_list, so dereferencing idle_list without pool
-	 * lock is safe.
+	 * running on the local cpu with preemption disabled, which in turn
+	 * means that no one else could be manipulating idle_list.next
+	 * so dereferencing idle_list.next without pool lock is safe.
 	 */
 	if (atomic_dec_and_test(&pool->nr_running) &&
 	    !list_empty(&pool->worklist)) {
@@ -934,7 +939,7 @@ void wq_worker_sleeping(struct task_struct *task)
 		if (next)
 			wake_up_process(next->task);
 	}
-	raw_spin_unlock_irq(&pool->lock);
+	preempt_enable();
 }
 
 /**
-- 
2.19.1.6.gb485710b


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C98589966
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 10:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239485AbiHDIlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 04:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239472AbiHDIky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 04:40:54 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95196555B
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 01:40:50 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id iw1so18716256plb.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 01:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=vpxp3Y0BUl7k1Sv2yf06jUzgIsGTyq0WB4+2EoOmdIE=;
        b=L6sYZu3JbPkBfj4VwzAkVoJzbP+Il6yh8lyxMDDPavhRCJdZqNaas1+erN7EIW9tL7
         wcC3/hcgL1gV8s6qmpNCOv92QKGK6ePa81LQsLp8zg28yxKR2bLoPd4vRcLDn8FUOjvW
         8zMxRZAW5tVcV0vLRYsmqNbfcXhcYwj7Ql224xGEQpXuuYBYwplxwHY7bw4LYzaJHmae
         NEIj4sD2ePPtyBuA4E4iNuyj6C5GPtdsghjkgOxPIibZUl5xq5CQ4NfEoy7lUADPkdKA
         gnZ1+0XjhbK3aetpPOAu5dBqrYf2F8K4S9fcqrf3RyRRCWmjztfKQ5NReYcJqGR06BkR
         UkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=vpxp3Y0BUl7k1Sv2yf06jUzgIsGTyq0WB4+2EoOmdIE=;
        b=yMNVbI+UGnz6KbOUPJGAdh9RnGTCvhilvC5ygmTGTuJRQ1v5V0RQ5Pn9TOFC5LDzDG
         7z+mQcDYChW3pIsKK3YoR+zLCeRxsmzG4+r7Y8lYnF3JeG6HUnnL4pD0EXQqNarDCOBv
         MuMARrqEWTChqLq0Zcpf/gGaWXs60yFR70Xl6Dcf2PNX/W+/yKPUoq43G63o6M7hc4Q+
         OOQ2CaSRsvIWM2UHq5ivKj3eLw1AC1xOIMsTe9dBmT4ajnUpr0RxUBFvwwozPIu2sVrO
         pIJZrhybJ7cnMO4Gig7WknVtevoqfMDJxZq4yJ+HM+xWS7NBLQIokNutuuPHNUN0EeNs
         1Dzg==
X-Gm-Message-State: ACgBeo2fAnTooHXRtDIXXZl5H3gyzCS4JvB9gOtsrNIKDGxl4sG46gcu
        CRVXj1TglY2MygvKieP9YTUufeldq+U=
X-Google-Smtp-Source: AA6agR4d2+wq7SSECl5UjW0pU3ZA1/+lrjNacIkvDNV6O+q/fXMcpPTrg1JQC/x+5U1uRBj61wJElQ==
X-Received: by 2002:a17:90b:3ec9:b0:1f5:62d5:4157 with SMTP id rm9-20020a17090b3ec900b001f562d54157mr2607732pjb.183.1659602450058;
        Thu, 04 Aug 2022 01:40:50 -0700 (PDT)
Received: from localhost ([47.254.32.37])
        by smtp.gmail.com with ESMTPSA id f187-20020a62dbc4000000b0052d98fbf8f3sm361442pfg.56.2022.08.04.01.40.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Aug 2022 01:40:49 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Tejun Heo <tj@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [RFC PATCH 2/8] workqueue: Make create_worker() safe against prematurely wakeups
Date:   Thu,  4 Aug 2022 16:41:29 +0800
Message-Id: <20220804084135.92425-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220804084135.92425-1-jiangshanlai@gmail.com>
References: <20220804084135.92425-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

A system crashed with the following BUG() report:

  [115147.050484] BUG: kernel NULL pointer dereference, address: 0000000000000000
  [115147.050488] #PF: supervisor write access in kernel mode
  [115147.050489] #PF: error_code(0x0002) - not-present page
  [115147.050490] PGD 0 P4D 0
  [115147.050494] Oops: 0002 [#1] PREEMPT_RT SMP NOPTI
  [115147.050498] CPU: 1 PID: 16213 Comm: kthreadd Kdump: loaded Tainted: G           O   X    5.3.18-2-rt #1 SLE15-SP2 (unreleased)
  [115147.050510] RIP: 0010:_raw_spin_lock_irq+0x14/0x30
  [115147.050513] Code: 89 c6 e8 5f 7a 9b ff 66 90 c3 66 66 2e 0f 1f 84 00 00 00 00 00 90 0f 1f 44 00 00 fa 65 ff 05 fb 53 6c 55 31 c0 ba 01 00 00 00 <f0> 0f b1 17 75 01 c3 89 c6 e8 2e 7a 9b ff 66 90 c3 90 90 90 90 90
  [115147.050514] RSP: 0018:ffffb0f68822fed8 EFLAGS: 00010046
  [115147.050515] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
  [115147.050516] RDX: 0000000000000001 RSI: 0000000000000002 RDI: 0000000000000000
  [115147.050517] RBP: ffff9ca73af40a40 R08: 0000000000000001 R09: 0000000000027340
  [115147.050519] R10: ffffb0f68822fe70 R11: 00000000000000a9 R12: ffffb0f688067dc0
  [115147.050520] R13: ffff9ca77e9a8000 R14: ffff9ca7634ca780 R15: ffff9ca7634ca780
  [115147.050521] FS:  0000000000000000(0000) GS:ffff9ca77fb00000(0000) knlGS:0000000000000000
  [115147.050523] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [115147.050524] CR2: 00000000000000b8 CR3: 000000004472e000 CR4: 00000000003406e0
  [115147.050524] Call Trace:
  [115147.050533]  worker_thread+0xb4/0x3c0
  [115147.050538]  ? process_one_work+0x4a0/0x4a0
  [115147.050540]  kthread+0x152/0x170
  [115147.050542]  ? kthread_park+0xa0/0xa0
  [115147.050544]  ret_from_fork+0x35/0x40

Further debugging shown that the worker thread was woken before
worker_attach_to_pool() finished in create_worker() though the reason
why it was woken up is unknown yet which might be some real-time kernel
activities.

Any kthread is supposed to stay in TASK_UNINTERRUPTIBLE sleep
until it is explicitly woken. But a spurious wakeup might
break this expectation.

As a result, worker_thread() might read worker->pool before
it was set in worker create_worker() by worker_attach_to_pool().
Or it might leave idle before entering idle or process work items
before attached for the pool.

Also manage_workers() might want to create yet another worker
before worker->pool->nr_workers is updated. It is a kind off
a chicken & egg problem.

Synchronize these operations using a completion API.  There are two
ways for the synchronization: either the manager does the worker
initialization and the newly created worker waits for the completion of
the initialization or the newly created worker does the worker
initialization for itself and the manager waits for the completion.

In current code, the manager does the worker initialization with the
dependence that kthread API ensure the worker to be TASK_UNINTERRUPTIBLE.

The ensuring is fragile, so one way of the synchronizations should be
chosen and the dependence should be avoided.

The newly created worker doing the worker initialization can simplify
the code further, so the second way is chosen.

Note that worker->pool might be then read without wq_pool_attach_mutex.
Normal worker always belongs to the same pool and the locking rules
for it is updated a bit.

Also note that rescuer_thread() does not need this because all
needed values are set before the kthreads is created. It is
connected with a particular workqueue. It is attached to different
pools when needed.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Tejun Heo <tj@kernel.org>,
Cc: Petr Mladek <pmladek@suse.com>
Cc: Michal Hocko <mhocko@suse.com>,
Cc: Peter Zijlstra <peterz@infradead.org>,
Cc: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c          | 22 ++++++++++++++--------
 kernel/workqueue_internal.h | 11 +++++++++--
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 928aad7d6123..f5b12c6778cc 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -176,6 +176,7 @@ struct worker_pool {
 						/* L: hash of busy workers */
 
 	struct worker		*manager;	/* L: purely informational */
+	struct completion	created;	/* create_worker(): worker created */
 	struct list_head	workers;	/* A: attached workers */
 	struct completion	*detach_completion; /* all workers detached */
 
@@ -1942,6 +1943,7 @@ static struct worker *create_worker(struct worker_pool *pool)
 		goto fail;
 
 	worker->id = id;
+	worker->pool = pool;
 
 	if (pool->cpu >= 0)
 		snprintf(id_buf, sizeof(id_buf), "%d:%d%s", pool->cpu, id,
@@ -1949,6 +1951,7 @@ static struct worker *create_worker(struct worker_pool *pool)
 	else
 		snprintf(id_buf, sizeof(id_buf), "u%d:%d", pool->id, id);
 
+	reinit_completion(&pool->created);
 	worker->task = kthread_create_on_node(worker_thread, worker, pool->node,
 					      "kworker/%s", id_buf);
 	if (IS_ERR(worker->task))
@@ -1957,15 +1960,9 @@ static struct worker *create_worker(struct worker_pool *pool)
 	set_user_nice(worker->task, pool->attrs->nice);
 	kthread_bind_mask(worker->task, pool->attrs->cpumask);
 
-	/* successful, attach the worker to the pool */
-	worker_attach_to_pool(worker, pool);
-
 	/* start the newly created worker */
-	raw_spin_lock_irq(&pool->lock);
-	worker->pool->nr_workers++;
-	worker_enter_idle(worker);
 	wake_up_process(worker->task);
-	raw_spin_unlock_irq(&pool->lock);
+	wait_for_completion(&pool->created);
 
 	return worker;
 
@@ -2383,10 +2380,17 @@ static int worker_thread(void *__worker)
 	struct worker *worker = __worker;
 	struct worker_pool *pool = worker->pool;
 
+	/* attach the worker to the pool */
+	worker_attach_to_pool(worker, pool);
+
 	/* tell the scheduler that this is a workqueue worker */
 	set_pf_worker(true);
-woke_up:
+
 	raw_spin_lock_irq(&pool->lock);
+	worker->pool->nr_workers++;
+	worker_enter_idle(worker);
+	complete(&pool->created);
+woke_up:
 
 	/* am I supposed to die? */
 	if (unlikely(worker->flags & WORKER_DIE)) {
@@ -2458,6 +2462,7 @@ static int worker_thread(void *__worker)
 	__set_current_state(TASK_IDLE);
 	raw_spin_unlock_irq(&pool->lock);
 	schedule();
+	raw_spin_lock_irq(&pool->lock);
 	goto woke_up;
 }
 
@@ -3461,6 +3466,7 @@ static int init_worker_pool(struct worker_pool *pool)
 
 	timer_setup(&pool->mayday_timer, pool_mayday_timeout, 0);
 
+	init_completion(&pool->created);
 	INIT_LIST_HEAD(&pool->workers);
 
 	ida_init(&pool->worker_ida);
diff --git a/kernel/workqueue_internal.h b/kernel/workqueue_internal.h
index e00b1204a8e9..025861c4d1f6 100644
--- a/kernel/workqueue_internal.h
+++ b/kernel/workqueue_internal.h
@@ -37,8 +37,15 @@ struct worker {
 	/* 64 bytes boundary on 64bit, 32 on 32bit */
 
 	struct task_struct	*task;		/* I: worker task */
-	struct worker_pool	*pool;		/* A: the associated pool */
-						/* L: for rescuers */
+
+	/*
+	 * The associated pool, locking rules:
+	 *   PF_WQ_WORKER: from the current worker
+	 *   PF_WQ_WORKER && wq_pool_attach_mutex: from remote tasks
+	 *   None: from the current worker when the worker is coming up
+	 */
+	struct worker_pool	*pool;
+
 	struct list_head	node;		/* A: anchored at pool->workers */
 						/* A: runs through worker->node */
 
-- 
2.19.1.6.gb485710b


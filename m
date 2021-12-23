Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10ECE47E35F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 13:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348362AbhLWMbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 07:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236408AbhLWMbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:31:47 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64439C061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 04:31:47 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 2so4789350pgb.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 04:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n3LbEIHSAy4aZ6BukInpsT+tqwoZ3Dci0kxWJnZUoNE=;
        b=Z21y9vbhKX4m0kjIHWBjyYvl5h7LajawSzlNCEsdCdAhhqInRa2ushpKW5MPzhq33J
         peYXFFvNnBF+iMTqKcmhRfNUQhgaXOu7MVFSmi5jlqOHARiI7g7afQCJhefb8EmpJLTY
         yS5gp79GCnyUOz8UrBbE8ARjB0TX2m9puV5q8DZtXzf/cIJmOQj+LLpG1E2iZ2M8cNFP
         5okc2kai9spFv0MV3woB1ZMnSbGqQPahdT21bfbAHMK2LN0KLDNsZJzUUEaMBilNB9Q5
         AsTSBMJlLbuTNCaEWaoun9ySE6U2OBQXOF7NngJGk33fHlPtY/jwFn8KB/T6klt5MaDL
         bStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n3LbEIHSAy4aZ6BukInpsT+tqwoZ3Dci0kxWJnZUoNE=;
        b=ES0hKcTT1Ch15NShfJApdtVnF4p1lBpkuP9zSnNyDn6rGC+tZgiujigKa//wsPc3HG
         iVEcE+GCKTfCUeskuEhfOyQa6XyhKilX/tfTUrWLVOeELEC8w60v0y++RKtB3JZkS+Tf
         b//X3Mlwt6VMSxqLmAkRtczFHrffjfwKLpcx+hWGeL7er1R3PuCPYGtmbO7sDkrJHGcJ
         10/TQ58CCw7CkGE7JBvS5CQbJDFIFUUlhp29jpmoJXIOFOs/sbuVLlUw0lk/SSaM5k3z
         vBljSX5QE4bmvQrIaf0kIO8jU2jInTLi7cteelivZ/PGFbEWOoKA6dstWReMfJ0GNwgV
         oRJw==
X-Gm-Message-State: AOAM532+wVjgzSTDuFRMAAJyvFBhFF3Ni5rs0o065RX2eCOdMT3oMFKA
        Auw0Pr7etELEOdQ/zt3b+OVhpGqjN8k=
X-Google-Smtp-Source: ABdhPJxAiGQq4uDrq/ZH0atUPVbSvawao7pnOom4YDIj21AA2t5soy4r5Mq5a/vALqBh2vRCM+RR8A==
X-Received: by 2002:a63:4004:: with SMTP id n4mr1931625pga.216.1640262706777;
        Thu, 23 Dec 2021 04:31:46 -0800 (PST)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id v1sm5809717pfg.169.2021.12.23.04.31.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Dec 2021 04:31:46 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 4/4] workqueue: Convert the type of pool->nr_running to int
Date:   Thu, 23 Dec 2021 20:31:40 +0800
Message-Id: <20211223123140.3789-5-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211223123140.3789-1-jiangshanlai@gmail.com>
References: <20211223123140.3789-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

It is only modified in associated CPU, so it doesn't need to be atomic.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 69cbe9e62bf1..dd3b3aa68954 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -154,8 +154,13 @@ struct worker_pool {
 
 	unsigned long		watchdog_ts;	/* L: watchdog timestamp */
 
-	/* The current concurrency level. */
-	atomic_t		nr_running;
+	/*
+	 * The current concurrency level.
+	 * increase: process context in associated CPU (preemption disabled).
+	 * decrease and reset: process context in associated CPU & pool->lock.
+	 * read: pool->lock. Ensured to be seen when decreased or reset to zero.
+	 */
+	int			nr_running;
 
 	struct list_head	worklist;	/* L: list of pending works */
 
@@ -777,7 +782,7 @@ static bool work_is_canceling(struct work_struct *work)
 
 static bool __need_more_worker(struct worker_pool *pool)
 {
-	return !atomic_read(&pool->nr_running);
+	return !pool->nr_running;
 }
 
 /*
@@ -802,8 +807,7 @@ static bool may_start_working(struct worker_pool *pool)
 /* Do I need to keep working?  Called from currently running workers. */
 static bool keep_working(struct worker_pool *pool)
 {
-	return !list_empty(&pool->worklist) &&
-		atomic_read(&pool->nr_running) <= 1;
+	return !list_empty(&pool->worklist) && (pool->nr_running <= 1);
 }
 
 /* Do we need a new worker?  Called from manager. */
@@ -873,7 +877,7 @@ void wq_worker_running(struct task_struct *task)
 	 */
 	preempt_disable();
 	if (!(worker->flags & WORKER_NOT_RUNNING))
-		atomic_inc(&worker->pool->nr_running);
+		worker->pool->nr_running++;
 	preempt_enable();
 	worker->sleeping = 0;
 }
@@ -917,8 +921,8 @@ void wq_worker_sleeping(struct task_struct *task)
 		return;
 	}
 
-	if (atomic_dec_and_test(&pool->nr_running) &&
-	    !list_empty(&pool->worklist))
+	pool->nr_running--;
+	if (need_more_worker(pool))
 		wake_up_worker(pool);
 	raw_spin_unlock_irq(&pool->lock);
 }
@@ -973,7 +977,7 @@ static inline void worker_set_flags(struct worker *worker, unsigned int flags)
 	/* If transitioning into NOT_RUNNING, adjust nr_running. */
 	if ((flags & WORKER_NOT_RUNNING) &&
 	    !(worker->flags & WORKER_NOT_RUNNING)) {
-		atomic_dec(&pool->nr_running);
+		pool->nr_running--;
 	}
 
 	worker->flags |= flags;
@@ -1005,7 +1009,7 @@ static inline void worker_clr_flags(struct worker *worker, unsigned int flags)
 	 */
 	if ((flags & WORKER_NOT_RUNNING) && (oflags & WORKER_NOT_RUNNING))
 		if (!(worker->flags & WORKER_NOT_RUNNING))
-			atomic_inc(&pool->nr_running);
+			pool->nr_running++;
 }
 
 /**
@@ -1806,8 +1810,7 @@ static void worker_enter_idle(struct worker *worker)
 		mod_timer(&pool->idle_timer, jiffies + IDLE_WORKER_TIMEOUT);
 
 	/* Sanity check nr_running. */
-	WARN_ON_ONCE(pool->nr_workers == pool->nr_idle &&
-		     atomic_read(&pool->nr_running));
+	WARN_ON_ONCE(pool->nr_workers == pool->nr_idle && pool->nr_running);
 }
 
 /**
@@ -4985,7 +4988,7 @@ static void unbind_workers(int cpu)
 		 * an unbound (in terms of concurrency management) pool which
 		 * are served by workers tied to the pool.
 		 */
-		atomic_set(&pool->nr_running, 0);
+		pool->nr_running = 0;
 
 		/*
 		 * With concurrency management just turned off, a busy
-- 
2.19.1.6.gb485710b


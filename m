Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4268546B40E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 08:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhLGHja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 02:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbhLGHj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 02:39:28 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9D7C061748
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 23:35:59 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id u11so8835538plf.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 23:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s/IwE2oULWXqnz2G4pDyic+4IqEa0Rt9MotXX1WP6cw=;
        b=N6ycMQneHQvqhIi81EjQ9i+mdqKTuLzLjGoCE50FfNck0LfNUXDlvpg+khgfyRdDBP
         VXFQ8BPTK0DLVQllig2wrd5J7HjCyliO5oHxY2A35XVCj0G6yO5WY6iYylLd6cPSRLAb
         yNrm8TfNiaUqRIaDx76Dp/af/KTwLuWP/tuVlIkWP8PxNgC/RKAUesJGoDjbZ7uwwmpp
         TQGqKCJk9QvUveQYhBxw0vAHigTgN3HPM+7LX70Ke6CHqFMICF+dOlk8kWx0boU1LgfF
         ElIYDXjonYXcJJkmLC3mqOhKZNnkEussVUZKhWyySW3CaCO2TULkeHle/dOONbpRk5zy
         F9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s/IwE2oULWXqnz2G4pDyic+4IqEa0Rt9MotXX1WP6cw=;
        b=ZUnvjJNM4zRtCMizQyNdbI+xM/kdIPIq5UowjbA0wO4TZfubawdp0epEE1gUyoud9V
         g6ablg2mczizjRbicQ1BB+E+lEictb6V6sOqvoNKkzdvjdJ0ZP6KJ7fxHY1vaxpBo8df
         /xZquNAFWOrt3yr9KmwkI82nk/sPF5ONsZQFl+hMekfIuUUqI5B5/TiuHeuBQEgsA+kf
         2uwCzjMhCZTZJ3phuEfc6DhNdUk9FBOMjvk8YL79XiIWzHwjYDotsZdBgPUuqYTgLuQG
         ArREceBEbxdejgPdwvGVsDektt6cXC80Ls5t5QDlKubBfNqzInCVqfxCasBSECQa2GjD
         nYlQ==
X-Gm-Message-State: AOAM531DRgMQ+ATtWvSMWv0x/TU+Jepmc1ck34438GLBT8S2rSsrAUvJ
        y/SnECzslGy7duR1/4/P1qoso90i1kI=
X-Google-Smtp-Source: ABdhPJzlKkOI1uES88+LPfP2auST2o+wAXvTvSSMH0vbwLN1vTDSTH9dytJdS4ht+abT2SU2A3gntg==
X-Received: by 2002:a17:902:aa43:b0:143:e20b:f37f with SMTP id c3-20020a170902aa4300b00143e20bf37fmr48955837plr.65.1638862558539;
        Mon, 06 Dec 2021 23:35:58 -0800 (PST)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id y18sm7922429pfp.190.2021.12.06.23.35.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Dec 2021 23:35:58 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 5/7] workqueue: Move the code of waking a worker up in unbind_workers()
Date:   Tue,  7 Dec 2021 15:35:41 +0800
Message-Id: <20211207073543.61092-6-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211207073543.61092-1-jiangshanlai@gmail.com>
References: <20211207073543.61092-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

In unbind_workers(), there are two pool->lock held sections separated
by the code of zapping nr_running.  wake_up_worker() needs to be in
pool->lock held section and after zapping nr_running.  And zapping
nr_running had to be after schedule() when the local wake up
functionality was in use.  Now, the call to schedule() has been removed
along with the local wake up functionality, so the code can be merged
into the same pool->lock held section.

The diffstat shows that it is other code moved down because the diff
tools can not know the meaning of merging lock sections by swapping
two code blocks.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 595f9bd5ad29..256f552e9513 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1830,14 +1830,8 @@ static void worker_enter_idle(struct worker *worker)
 	if (too_many_workers(pool) && !timer_pending(&pool->idle_timer))
 		mod_timer(&pool->idle_timer, jiffies + IDLE_WORKER_TIMEOUT);
 
-	/*
-	 * Sanity check nr_running.  Because unbind_workers() releases
-	 * pool->lock between setting %WORKER_UNBOUND and zapping
-	 * nr_running, the warning may trigger spuriously.  Check iff
-	 * unbind is not in progress.
-	 */
-	WARN_ON_ONCE(!(pool->flags & POOL_DISASSOCIATED) &&
-		     pool->nr_workers == pool->nr_idle &&
+	/* Sanity check nr_running. */
+	WARN_ON_ONCE(pool->nr_workers == pool->nr_idle &&
 		     atomic_read(&pool->nr_running));
 }
 
@@ -5008,21 +5002,12 @@ static void unbind_workers(int cpu)
 
 		pool->flags |= POOL_DISASSOCIATED;
 
-		raw_spin_unlock_irq(&pool->lock);
-
-		for_each_pool_worker(worker, pool) {
-			kthread_set_per_cpu(worker->task, -1);
-			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
-		}
-
-		mutex_unlock(&wq_pool_attach_mutex);
-
 		/*
-		 * Sched callbacks are disabled now.  Zap nr_running.
-		 * After this, nr_running stays zero and need_more_worker()
-		 * and keep_working() are always true as long as the
-		 * worklist is not empty.  This pool now behaves as an
-		 * unbound (in terms of concurrency management) pool which
+		 * The handling of nr_running in sched callbacks are disabled
+		 * now.  Zap nr_running.  After this, nr_running stays zero and
+		 * need_more_worker() and keep_working() are always true as
+		 * long as the worklist is not empty.  This pool now behaves as
+		 * an unbound (in terms of concurrency management) pool which
 		 * are served by workers tied to the pool.
 		 */
 		atomic_set(&pool->nr_running, 0);
@@ -5032,9 +5017,16 @@ static void unbind_workers(int cpu)
 		 * worker blocking could lead to lengthy stalls.  Kick off
 		 * unbound chain execution of currently pending work items.
 		 */
-		raw_spin_lock_irq(&pool->lock);
 		wake_up_worker(pool);
+
 		raw_spin_unlock_irq(&pool->lock);
+
+		for_each_pool_worker(worker, pool) {
+			kthread_set_per_cpu(worker->task, -1);
+			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
+		}
+
+		mutex_unlock(&wq_pool_attach_mutex);
 	}
 }
 
-- 
2.19.1.6.gb485710b


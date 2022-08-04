Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72E2589968
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 10:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239509AbiHDIlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 04:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239310AbiHDIlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 04:41:14 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3139C65839
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 01:40:57 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id bh13so17355652pgb.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 01:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=a8SD/ZTcIF1U9sLR5IbPm2YAiCCIs0oujdhG7j3kthQ=;
        b=TSARr/wBgWs1BYKva0hT7u5aUB+RzkIk2TDdNOXLBpKSGsARD/1R8u4rHx6ukA8Kwk
         ed9yP0FwBDWiV6aS2uUh68aSdsP9l7zVNxVVPa3UlW1WpBpbUTbonFKXvW38AMHRFtuA
         6i+L6cTdBfCvEs3JLMoi83g2okH89EU8hmPl8WNpKp4RiHQxzaMtDgzj+HrxyPVXW+1g
         21qOM+IzI3c0l3mLPU+1rGMUz5TUVH8NCvZ6SBhDz3NcaTlP68HXD4udRCCkOA7PIM4F
         1RH3cK8Sh5NaUv6G+GWnL6YG2R0B4DKjWED+x9UDTLmdOWbXkp/uOvOkXKLzILaxBL/d
         //TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=a8SD/ZTcIF1U9sLR5IbPm2YAiCCIs0oujdhG7j3kthQ=;
        b=R5npVG8+ZVbitC6Yhag72LmUIRj/N0upTR12A+lsYaBDG9eYlPq4bTAX/ISgWCTkpg
         x6dd3aRMHcezwvCOeez43CqPBGokgcvNvn56Z7nIagvlumG2IxqF2beoLp9ekFiTEFhg
         W5G/j2mq2JERe0TJDWSC3bdd6LkLqzPQeoAn4N1OL8YbOU++Cqwf38WJcp6Aga4n5/M5
         565f+kSMqU4fHMnVFR4CCb5LQO0vkm4gziGMy2MIdgA6phm339ONqr+/pzEo+IrQNXgH
         Y+8ZQ43XQcUbbGFQPx+c7b1dci5Nm87z6OcZqTpDTzDtSR6noKRvd3ylQSJZ0bsgkwMr
         9FSA==
X-Gm-Message-State: ACgBeo0zRzK/sssQ3SOSNzoY+/9xVwioYRRVrLotIUPVrW5DOuivKT1S
        oRg7qMmshq93hVa1Sv+GqCqESGNi04o=
X-Google-Smtp-Source: AA6agR7jp2Wnbdp+IZ/ad1CRu9OgCfyZomNnK7lsjcwmsKk3v4ZmdPoJg9wBUlIK8/z7x/hVMlY5Og==
X-Received: by 2002:a05:6a00:10ca:b0:4f7:5af4:47b6 with SMTP id d10-20020a056a0010ca00b004f75af447b6mr747251pfu.6.1659602456264;
        Thu, 04 Aug 2022 01:40:56 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id i6-20020a170902c94600b0016f1d578f71sm315347pla.139.2022.08.04.01.40.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Aug 2022 01:40:55 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [RFC PATCH 4/8] workqueue: Set/Clear PF_WQ_WORKER while attaching/detaching
Date:   Thu,  4 Aug 2022 16:41:31 +0800
Message-Id: <20220804084135.92425-5-jiangshanlai@gmail.com>
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

PF_WQ_WORKER is only needed when the worker is attached.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 82937c0fb21f..7fc4c2fa21d6 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1861,6 +1861,8 @@ static struct worker *alloc_worker(int node)
 static void worker_attach_to_pool(struct worker *worker,
 				   struct worker_pool *pool)
 {
+	WARN_ON_ONCE(worker->task != current);
+
 	mutex_lock(&wq_pool_attach_mutex);
 
 	/*
@@ -1882,6 +1884,9 @@ static void worker_attach_to_pool(struct worker *worker,
 	list_add_tail(&worker->node, &pool->workers);
 	worker->pool = pool;
 
+	/* tell the scheduler that this is a workqueue worker */
+	current->flags |= PF_WQ_WORKER;
+
 	mutex_unlock(&wq_pool_attach_mutex);
 }
 
@@ -1898,8 +1903,11 @@ static void worker_detach_from_pool(struct worker *worker)
 	struct worker_pool *pool = worker->pool;
 	struct completion *detach_completion = NULL;
 
+	WARN_ON_ONCE(worker->task != current);
+
 	mutex_lock(&wq_pool_attach_mutex);
 
+	current->flags &= ~PF_WQ_WORKER;
 	kthread_set_per_cpu(worker->task, -1);
 	list_del(&worker->node);
 	worker->pool = NULL;
@@ -2352,16 +2360,6 @@ static void process_scheduled_works(struct worker *worker)
 	}
 }
 
-static void set_pf_worker(bool val)
-{
-	mutex_lock(&wq_pool_attach_mutex);
-	if (val)
-		current->flags |= PF_WQ_WORKER;
-	else
-		current->flags &= ~PF_WQ_WORKER;
-	mutex_unlock(&wq_pool_attach_mutex);
-}
-
 /**
  * worker_thread - the worker thread function
  * @__worker: self
@@ -2384,9 +2382,6 @@ static int worker_thread(void *__worker)
 	/* attach the worker to the pool */
 	worker_attach_to_pool(worker, pool);
 
-	/* tell the scheduler that this is a workqueue worker */
-	set_pf_worker(true);
-
 	raw_spin_lock_irq(&pool->lock);
 	worker->pool->nr_workers++;
 	worker_enter_idle(worker);
@@ -2397,7 +2392,6 @@ static int worker_thread(void *__worker)
 	if (unlikely(worker->flags & WORKER_DIE)) {
 		raw_spin_unlock_irq(&pool->lock);
 		WARN_ON_ONCE(!list_empty(&worker->entry));
-		set_pf_worker(false);
 
 		set_task_comm(worker->task, "kworker/dying");
 		ida_free(&pool->worker_ida, worker->id);
@@ -2498,11 +2492,6 @@ static int rescuer_thread(void *__rescuer)
 	current->flags |= PF_NO_SETAFFINITY;
 	set_user_nice(current, RESCUER_NICE_LEVEL);
 
-	/*
-	 * Mark rescuer as worker too.  As WORKER_PREP is never cleared, it
-	 * doesn't participate in concurrency management.
-	 */
-	set_pf_worker(true);
 repeat:
 	set_current_state(TASK_IDLE);
 
@@ -2531,6 +2520,10 @@ static int rescuer_thread(void *__rescuer)
 
 		raw_spin_unlock_irq(&wq_mayday_lock);
 
+		/*
+		 * Attach the rescuer.  As WORKER_PREP is never cleared, it
+		 * doesn't participate in concurrency management.
+		 */
 		worker_attach_to_pool(rescuer, pool);
 
 		raw_spin_lock_irq(&pool->lock);
@@ -2600,7 +2593,6 @@ static int rescuer_thread(void *__rescuer)
 
 	if (should_stop) {
 		__set_current_state(TASK_RUNNING);
-		set_pf_worker(false);
 		return 0;
 	}
 
-- 
2.19.1.6.gb485710b


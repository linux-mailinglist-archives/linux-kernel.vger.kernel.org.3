Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5685825EE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 13:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbiG0LyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 07:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbiG0LyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 07:54:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 215F53247F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 04:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658922846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2oLtdvvBWAtUMJ3htBB4Qz85ldyVmTKr8rY6BlTDhh0=;
        b=YguB/v+LwhTQYnzmEfbUkSEyOqATMflr32tL3Lfti+XTkP3JdIFC4HZsZv1DLhewVUACyG
        a1odrSc6Q+9mq0kr+YhyJWSpPihSpITILvuYQ7msoLStPxa1zHF3+J22bNEuZWlSOmvoq5
        9Xx1Rhg8YpCnW3rVazyv27dyq0ivFTY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-7SwLwAm3NgmJHtE4NtEQfA-1; Wed, 27 Jul 2022 07:54:05 -0400
X-MC-Unique: 7SwLwAm3NgmJHtE4NtEQfA-1
Received: by mail-wm1-f70.google.com with SMTP id i133-20020a1c3b8b000000b003a2fe4c345cso1080168wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 04:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2oLtdvvBWAtUMJ3htBB4Qz85ldyVmTKr8rY6BlTDhh0=;
        b=6EEnsP4qsAveEcNt/eUuxuVMty0A4ZKy+eihlEOEXKyZJdvdSdaX3kDsjCf1eFf2nZ
         w6jvsimL4VSfOaSJo1R6mJG0x2mMQey9rm3UGBFaBNpai0JR5oZxMROMnhbVvdZAiiYe
         bQmi661Bjcf2VgoK04TjQ/ZLWhm0gso+0A0ab0kUfLVpaJijMTq6ZCqhnoIycy4VhVq3
         tSumKxU4UDxklHk9IsIyqMcP68jPBV5t/Q+i0lhrgxC0/YFACYh+7thajQQBALTShpEX
         vQucqd5QzBBmt0ZqsBPeJn/c3G0XzfYQJTXS3OG2wFOhrW0RzvE5FQK5xk2LGTpTaTfE
         3Ijw==
X-Gm-Message-State: AJIora/s5B6C+nZH8OupqHbSegWbQQXyzRXoAkw+BLKG6nxH6RyAPZcf
        sFtAdBgTUB1fDAe6BGawOBFrkCN8s71trgwFo+TRjLN2zaumouYiKYfI4AtV6OEm+MXDTigurBm
        fGTZTm3f4t7h0AdA1wj19MW1DBFfkcLOa1KlQnZZS8SQwASv4x5flx/PJ81aNLIJSzgpib8jyhD
        +2
X-Received: by 2002:a05:600c:3caa:b0:394:8fb8:716 with SMTP id bg42-20020a05600c3caa00b003948fb80716mr2791905wmb.105.1658922843160;
        Wed, 27 Jul 2022 04:54:03 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uaS9KCLG0eegE5ML7yRXuWnOxt44ghgB+lXokqt3kfBmeh9n4rAmsdgiaaFKkCBotA4tcxoQ==
X-Received: by 2002:a05:600c:3caa:b0:394:8fb8:716 with SMTP id bg42-20020a05600c3caa00b003948fb80716mr2791869wmb.105.1658922842743;
        Wed, 27 Jul 2022 04:54:02 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id m64-20020a1c2643000000b003a30af0ec83sm2046838wmm.25.2022.07.27.04.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 04:54:01 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [RFC PATCH v2 1/2] workqueue: Unbind workers before sending them to exit()
Date:   Wed, 27 Jul 2022 12:53:26 +0100
Message-Id: <20220727115327.2273547-2-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220727115327.2273547-1-vschneid@redhat.com>
References: <20220727115327.2273547-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has been reported that isolated CPUs can suffer from interference due to
per-CPU kworkers waking up just to die.

A surge of workqueue activity during initial setup of a latency-sensitive
application (refresh_vm_stats() being one of the culprits) can cause extra
per-CPU kworkers to be spawned. Then, said latency-sensitive task can be
running merrily on an isolated CPU only to be interrupted sometime later by
a kworker marked for death (cf. IDLE_WORKER_TIMEOUT, 5 minutes after last
kworker activity).

Prevent this by affining kworkers to the wq_unbound_cpumask (which doesn't
contain isolated CPUs, cf. HK_TYPE_WQ) before waking them up after marking
them with WORKER_DIE.

Changing the affinity does require a sleepable context, so get rid of the
pool->idle_timer and use a delayed_work instead.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/workqueue.c | 109 +++++++++++++++++++++++++++++++++------------
 1 file changed, 81 insertions(+), 28 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 1ea50f6be843..27642166dcc5 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -167,9 +167,9 @@ struct worker_pool {
 	int			nr_workers;	/* L: total number of workers */
 	int			nr_idle;	/* L: currently idle workers */
 
-	struct list_head	idle_list;	/* L: list of idle workers */
-	struct timer_list	idle_timer;	/* L: worker idle timeout */
-	struct timer_list	mayday_timer;	/* L: SOS timer for workers */
+	struct list_head	idle_list;	  /* L: list of idle workers */
+	struct delayed_work     idle_reaper_work; /* L: worker idle timeout */
+	struct timer_list	mayday_timer;	  /* L: SOS timer for workers */
 
 	/* a workers is either on busy_hash or idle_list, or the manager */
 	DECLARE_HASHTABLE(busy_hash, BUSY_WORKER_HASH_ORDER);
@@ -1806,8 +1806,10 @@ static void worker_enter_idle(struct worker *worker)
 	/* idle_list is LIFO */
 	list_add(&worker->entry, &pool->idle_list);
 
-	if (too_many_workers(pool) && !timer_pending(&pool->idle_timer))
-		mod_timer(&pool->idle_timer, jiffies + IDLE_WORKER_TIMEOUT);
+	if (too_many_workers(pool) && !delayed_work_pending(&pool->idle_reaper_work))
+		mod_delayed_work(system_unbound_wq,
+				 &pool->idle_reaper_work,
+				 IDLE_WORKER_TIMEOUT);
 
 	/* Sanity check nr_running. */
 	WARN_ON_ONCE(pool->nr_workers == pool->nr_idle && pool->nr_running);
@@ -1972,9 +1974,29 @@ static struct worker *create_worker(struct worker_pool *pool)
 	return NULL;
 }
 
+static void unbind_worker(struct worker *worker)
+{
+	kthread_set_per_cpu(worker->task, -1);
+	WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, wq_unbound_cpumask) < 0);
+}
+
+static void rebind_worker(struct worker *worker, struct worker_pool *pool)
+{
+	kthread_set_per_cpu(worker->task, pool->cpu);
+	WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask) < 0);
+}
+
+static void reap_worker(struct worker *worker)
+{
+	list_del_init(&worker->entry);
+	unbind_worker(worker);
+	wake_up_process(worker->task);
+}
+
 /**
  * destroy_worker - destroy a workqueue worker
  * @worker: worker to be destroyed
+ * @list: transfer worker away from its pool->idle_list and into list
  *
  * Destroy @worker and adjust @pool stats accordingly.  The worker should
  * be idle.
@@ -1982,7 +2004,7 @@ static struct worker *create_worker(struct worker_pool *pool)
  * CONTEXT:
  * raw_spin_lock_irq(pool->lock).
  */
-static void destroy_worker(struct worker *worker)
+static void destroy_worker(struct worker *worker, struct list_head *list)
 {
 	struct worker_pool *pool = worker->pool;
 
@@ -1997,34 +2019,64 @@ static void destroy_worker(struct worker *worker)
 	pool->nr_workers--;
 	pool->nr_idle--;
 
-	list_del_init(&worker->entry);
+	list_del(&worker->entry);
 	worker->flags |= WORKER_DIE;
-	wake_up_process(worker->task);
+
+	list_add(&worker->entry, list);
 }
 
-static void idle_worker_timeout(struct timer_list *t)
+/**
+ * idle_reaper_fn - reap workers that have been idle for too long.
+ *
+ * Unbinding marked-for-destruction workers requires a sleepable context, as
+ * changing a task's affinity is not an atomic operation, and we don't want
+ * to disturb isolated CPUs IDLE_WORKER_TIMEOUT in the future just for a kworker
+ * to do_exit().
+ *
+ * Percpu kworkers should meet the conditions for the affinity change to not
+ * block (not migration-disabled and not running), but there is no *hard*
+ * guarantee that they are not running when we get here.
+ *
+ * The delayed_work is only ever modified under raw_spin_lock_irq(pool->lock).
+ */
+static void idle_reaper_fn(struct work_struct *work)
 {
-	struct worker_pool *pool = from_timer(pool, t, idle_timer);
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct worker_pool *pool = container_of(dwork, struct worker_pool, idle_reaper_work);
+	struct list_head reaplist;
+	struct worker *worker, *tmp;
+
+	INIT_LIST_HEAD(&reaplist);
 
 	raw_spin_lock_irq(&pool->lock);
 
 	while (too_many_workers(pool)) {
-		struct worker *worker;
 		unsigned long expires;
+		unsigned long now = jiffies;
 
 		/* idle_list is kept in LIFO order, check the last one */
 		worker = list_entry(pool->idle_list.prev, struct worker, entry);
 		expires = worker->last_active + IDLE_WORKER_TIMEOUT;
 
-		if (time_before(jiffies, expires)) {
-			mod_timer(&pool->idle_timer, expires);
+		/*
+		 * Careful: queueing a work item from here can and will cause a
+		 * self-deadlock when dealing with an unbound pool. However,
+		 * here the delay *cannot* be zero and *has* to be in the
+		 * future, which works.
+		 */
+		if (time_before(now, expires)) {
+			mod_delayed_work(system_unbound_wq,
+					 &pool->idle_reaper_work,
+					 expires - now);
 			break;
 		}
 
-		destroy_worker(worker);
+		destroy_worker(worker, &reaplist);
 	}
-
 	raw_spin_unlock_irq(&pool->lock);
+
+	list_for_each_entry_safe(worker, tmp, &reaplist, entry)
+		reap_worker(worker);
 }
 
 static void send_mayday(struct work_struct *work)
@@ -3454,7 +3506,7 @@ static int init_worker_pool(struct worker_pool *pool)
 	INIT_LIST_HEAD(&pool->idle_list);
 	hash_init(pool->busy_hash);
 
-	timer_setup(&pool->idle_timer, idle_worker_timeout, TIMER_DEFERRABLE);
+	INIT_DEFERRABLE_WORK(&pool->idle_reaper_work, idle_reaper_fn);
 
 	timer_setup(&pool->mayday_timer, pool_mayday_timeout, 0);
 
@@ -3559,7 +3611,10 @@ static bool wq_manager_inactive(struct worker_pool *pool)
 static void put_unbound_pool(struct worker_pool *pool)
 {
 	DECLARE_COMPLETION_ONSTACK(detach_completion);
-	struct worker *worker;
+	struct list_head dlist;
+	struct worker *worker, *tmp;
+
+	INIT_LIST_HEAD(&dlist);
 
 	lockdep_assert_held(&wq_pool_mutex);
 
@@ -3588,10 +3643,13 @@ static void put_unbound_pool(struct worker_pool *pool)
 	pool->flags |= POOL_MANAGER_ACTIVE;
 
 	while ((worker = first_idle_worker(pool)))
-		destroy_worker(worker);
+		destroy_worker(worker, &dlist);
 	WARN_ON(pool->nr_workers || pool->nr_idle);
 	raw_spin_unlock_irq(&pool->lock);
 
+	list_for_each_entry_safe(worker, tmp, &dlist, entry)
+		reap_worker(worker);
+
 	mutex_lock(&wq_pool_attach_mutex);
 	if (!list_empty(&pool->workers))
 		pool->detach_completion = &detach_completion;
@@ -3601,7 +3659,7 @@ static void put_unbound_pool(struct worker_pool *pool)
 		wait_for_completion(pool->detach_completion);
 
 	/* shut down the timers */
-	del_timer_sync(&pool->idle_timer);
+	cancel_delayed_work_sync(&pool->idle_reaper_work);
 	del_timer_sync(&pool->mayday_timer);
 
 	/* RCU protected to allow dereferences from get_work_pool() */
@@ -4999,10 +5057,8 @@ static void unbind_workers(int cpu)
 
 		raw_spin_unlock_irq(&pool->lock);
 
-		for_each_pool_worker(worker, pool) {
-			kthread_set_per_cpu(worker->task, -1);
-			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, wq_unbound_cpumask) < 0);
-		}
+		for_each_pool_worker(worker, pool)
+			unbind_worker(worker);
 
 		mutex_unlock(&wq_pool_attach_mutex);
 	}
@@ -5027,11 +5083,8 @@ static void rebind_workers(struct worker_pool *pool)
 	 * of all workers first and then clear UNBOUND.  As we're called
 	 * from CPU_ONLINE, the following shouldn't fail.
 	 */
-	for_each_pool_worker(worker, pool) {
-		kthread_set_per_cpu(worker->task, pool->cpu);
-		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
-						  pool->attrs->cpumask) < 0);
-	}
+	for_each_pool_worker(worker, pool)
+		rebind_worker(worker, pool);
 
 	raw_spin_lock_irq(&pool->lock);
 
-- 
2.31.1


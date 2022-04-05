Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145F74F3828
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 16:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376376AbiDELVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 07:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241051AbiDEIsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:48:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6EF286F3;
        Tue,  5 Apr 2022 01:36:40 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:36:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649147781;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H1j+1viOhjYFA2aOC4qMU0dl994UvA/jRgO733fewgY=;
        b=qNwYHfonmBSk5z6ghXsoeVlY/xkLpuHa+EOzjxKm2nxSELm8pI0uQOTWk9m54Bn3CLI6Pg
        KONDjw+PqYQdkTX+tuTIhgSqaC/veyFx3o0W0lvOplu6Nt4nv5ba2JPJJFrSppLX7EvQxx
        jFgC93wuziiSWK1TOz1q/M6riiBXzh7vYMo/91TjIX8QMloGa72m/VAEBSbL73iJ/m0Yxp
        tbhy39QXMrRm7gbTPrS7iZwd4Bv29M/0ejBCj+H3i8o6q6W5rDWnM9HaEF7bSpDkv4s6UT
        6/oKISmppEwIOHYKUYakxSgkjbBJPbLLVV41wkawRU0hsb4OKmgm6WR7ww01Gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649147781;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H1j+1viOhjYFA2aOC4qMU0dl994UvA/jRgO733fewgY=;
        b=uiWKXwtjrHq+Z35ZJSS6elAe7ucgfAE3xIfMzRzGdk2/EPXRF8ByJP6IKV1gVg812mA82f
        RpF+GM9thTIbkKAw==
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rwsem: Always try to wake waiters in
 out_nolock path
Cc:     Waiman Long <longman@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220322152059.2182333-4-longman@redhat.com>
References: <20220322152059.2182333-4-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <164914777984.389.6359255161349263835.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     1ee326196c66583006b0c95356a4b7dc51bf3531
Gitweb:        https://git.kernel.org/tip/1ee326196c66583006b0c95356a4b7dc51bf3531
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Tue, 22 Mar 2022 11:20:59 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Apr 2022 10:24:35 +02:00

locking/rwsem: Always try to wake waiters in out_nolock path

For writers, the out_nolock path will always attempt to wake up waiters.
This may not be really necessary if the waiter to be removed is not the
first one.

For readers, no attempt to wake up waiter is being made. However, if
the HANDOFF bit is set and the reader to be removed is the first waiter,
the waiter behind it will inherit the HANDOFF bit and for a write lock
waiter waking it up will allow it to spin on the lock to acquire it
faster. So it can be beneficial to do a wakeup in this case.

Add a new rwsem_del_wake_waiter() helper function to do that consistently
for both reader and writer out_nolock paths.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220322152059.2182333-4-longman@redhat.com
---
 kernel/locking/rwsem.c | 44 +++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 03cb97a..16b532b 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -375,16 +375,19 @@ rwsem_add_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
  *
  * Both rwsem_mark_wake() and rwsem_try_write_lock() contain a full 'copy' of
  * this function. Modify with care.
+ *
+ * Return: true if wait_list isn't empty and false otherwise
  */
-static inline void
+static inline bool
 rwsem_del_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
 {
 	lockdep_assert_held(&sem->wait_lock);
 	list_del(&waiter->list);
 	if (likely(!list_empty(&sem->wait_list)))
-		return;
+		return true;
 
 	atomic_long_andnot(RWSEM_FLAG_HANDOFF | RWSEM_FLAG_WAITERS, &sem->count);
+	return false;
 }
 
 /*
@@ -559,6 +562,33 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 }
 
 /*
+ * Remove a waiter and try to wake up other waiters in the wait queue
+ * This function is called from the out_nolock path of both the reader and
+ * writer slowpaths with wait_lock held. It releases the wait_lock and
+ * optionally wake up waiters before it returns.
+ */
+static inline void
+rwsem_del_wake_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter,
+		      struct wake_q_head *wake_q)
+		      __releases(&sem->wait_lock)
+{
+	bool first = rwsem_first_waiter(sem) == waiter;
+
+	wake_q_init(wake_q);
+
+	/*
+	 * If the wait_list isn't empty and the waiter to be deleted is
+	 * the first waiter, we wake up the remaining waiters as they may
+	 * be eligible to acquire or spin on the lock.
+	 */
+	if (rwsem_del_waiter(sem, waiter) && first)
+		rwsem_mark_wake(sem, RWSEM_WAKE_ANY, wake_q);
+	raw_spin_unlock_irq(&sem->wait_lock);
+	if (!wake_q_empty(wake_q))
+		wake_up_q(wake_q);
+}
+
+/*
  * This function must be called with the sem->wait_lock held to prevent
  * race conditions between checking the rwsem wait list and setting the
  * sem->count accordingly.
@@ -1050,8 +1080,7 @@ queue:
 	return sem;
 
 out_nolock:
-	rwsem_del_waiter(sem, &waiter);
-	raw_spin_unlock_irq(&sem->wait_lock);
+	rwsem_del_wake_waiter(sem, &waiter, &wake_q);
 	__set_current_state(TASK_RUNNING);
 	lockevent_inc(rwsem_rlock_fail);
 	return ERR_PTR(-EINTR);
@@ -1095,7 +1124,6 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 			 */
 			raw_spin_unlock_irq(&sem->wait_lock);
 			wake_up_q(&wake_q);
-			wake_q_init(&wake_q);	/* Used again, reinit */
 			raw_spin_lock_irq(&sem->wait_lock);
 		}
 	} else {
@@ -1148,11 +1176,7 @@ trylock_again:
 out_nolock:
 	__set_current_state(TASK_RUNNING);
 	raw_spin_lock_irq(&sem->wait_lock);
-	rwsem_del_waiter(sem, &waiter);
-	if (!list_empty(&sem->wait_list))
-		rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
-	raw_spin_unlock_irq(&sem->wait_lock);
-	wake_up_q(&wake_q);
+	rwsem_del_wake_waiter(sem, &waiter, &wake_q);
 	lockevent_inc(rwsem_wlock_fail);
 	return ERR_PTR(-EINTR);
 }

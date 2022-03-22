Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB954E42DD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 16:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238498AbiCVPXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 11:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238380AbiCVPXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:23:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 122735D1BB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 08:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647962500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gAuFrsj1h4Cg7KfoKxWaVEp6NQvks0mc1AOVzBtu78M=;
        b=VOfIrapbwsf/SOOicQZk/x+x6lEgBvXXwcBmRMPs4JMPkToVSieB8B8Qpp4A2Mb8a+xvy7
        QUQ20EAx0PmTL2summUZDeyypK4vhOTIlzmcZyvKdwzKRMRAD47VswZA0jCLKtuMRgzGqD
        sW9HgQYC4kQ9859+//MpQBSchLd3u2k=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-597-_dhxCymSNGeKx_wRoWWAig-1; Tue, 22 Mar 2022 11:21:36 -0400
X-MC-Unique: _dhxCymSNGeKx_wRoWWAig-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 252323C01C05;
        Tue, 22 Mar 2022 15:21:36 +0000 (UTC)
Received: from llong.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 01D0540D2822;
        Tue, 22 Mar 2022 15:21:34 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH v2 3/3] locking/rwsem: Always try to wake waiters in out_nolock path
Date:   Tue, 22 Mar 2022 11:20:59 -0400
Message-Id: <20220322152059.2182333-4-longman@redhat.com>
In-Reply-To: <20220322152059.2182333-1-longman@redhat.com>
References: <20220322152059.2182333-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 kernel/locking/rwsem.c | 44 ++++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index b4864dea66c4..45c1dc753269 100644
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
@@ -558,6 +561,33 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 	}
 }
 
+/*
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
 /*
  * This function must be called with the sem->wait_lock held to prevent
  * race conditions between checking the rwsem wait list and setting the
@@ -1050,8 +1080,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
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
@@ -1148,11 +1176,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
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
-- 
2.27.0


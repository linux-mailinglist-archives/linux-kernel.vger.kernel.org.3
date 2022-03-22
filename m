Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3402C4E42D9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 16:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238486AbiCVPXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 11:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237034AbiCVPXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:23:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8102026579
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 08:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647962498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=szKE9b5zifr5pUQVERSCwG97tFibKXOBRDyf0aS4yKI=;
        b=GvP17zavD1RbRy+GCwsHgzPQb3u8HiQP6pRskiFwcELprPjXFZKZZF4Wb4sD/fG1SwcfwU
        kpnQWBbtx8KsobTXu9AZhTuaaVqaLgI1NM/NhvCeqeTH9Z35zYMrO37ArybFHCDGibeN8Z
        1RB606ZmExHjUXe9Aqd5FAQKfNO0epU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-332-e7uUO6AwN-aejqJ1IBpXng-1; Tue, 22 Mar 2022 11:21:35 -0400
X-MC-Unique: e7uUO6AwN-aejqJ1IBpXng-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED53082A682;
        Tue, 22 Mar 2022 15:21:34 +0000 (UTC)
Received: from llong.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE9784010A02;
        Tue, 22 Mar 2022 15:21:34 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH v2 2/3] locking/rwsem: Conditionally wake waiters in reader/writer slowpaths
Date:   Tue, 22 Mar 2022 11:20:58 -0400
Message-Id: <20220322152059.2182333-3-longman@redhat.com>
In-Reply-To: <20220322152059.2182333-1-longman@redhat.com>
References: <20220322152059.2182333-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In an analysis of a recent vmcore, a reader-owned rwsem was found with
385 readers but no writer in the wait queue. That is kind of unusual
but it may be caused by some race conditions that we have not fully
understood yet. In such a case, all the readers in the wait queue should
join the other reader-owners and acquire the read lock.

In rwsem_down_write_slowpath(), an incoming writer will try to
wake up the front readers under such circumstance. That is not
the case for rwsem_down_read_slowpath(), add a new helper function
rwsem_cond_wake_waiter() to do wakeup and use it in both reader and
writer slowpaths to have a consistent and correct behavior.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem.c | 68 ++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 36 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index f71a9693d05a..b4864dea66c4 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -901,7 +901,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
  */
 static inline void clear_nonspinnable(struct rw_semaphore *sem)
 {
-	if (rwsem_test_oflags(sem, RWSEM_NONSPINNABLE))
+	if (unlikely(rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)))
 		atomic_long_andnot(RWSEM_NONSPINNABLE, &sem->owner);
 }
 
@@ -925,6 +925,31 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
 }
 #endif
 
+/*
+ * Prepare to wake up waiter(s) in the wait queue by putting them into the
+ * given wake_q if the rwsem lock owner isn't a writer. If rwsem is likely
+ * reader-owned, wake up read lock waiters in queue front or wake up any
+ * front waiter otherwise.
+
+ * This is being called from both reader and writer slow paths.
+ */
+static inline void rwsem_cond_wake_waiter(struct rw_semaphore *sem, long count,
+					  struct wake_q_head *wake_q)
+{
+	enum rwsem_wake_type wake_type;
+
+	if (count & RWSEM_WRITER_MASK)
+		return;
+
+	if (count & RWSEM_READER_MASK) {
+		wake_type = RWSEM_WAKE_READERS;
+	} else {
+		wake_type = RWSEM_WAKE_ANY;
+		clear_nonspinnable(sem);
+	}
+	rwsem_mark_wake(sem, wake_type, wake_q);
+}
+
 /*
  * Wait for the read lock to be granted
  */
@@ -935,7 +960,6 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 	long rcnt = (count >> RWSEM_READER_SHIFT);
 	struct rwsem_waiter waiter;
 	DEFINE_WAKE_Q(wake_q);
-	bool wake = false;
 
 	/*
 	 * To prevent a constant stream of readers from starving a sleeping
@@ -996,22 +1020,11 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 	/* we're now waiting on the lock, but no longer actively locking */
 	count = atomic_long_add_return(adjustment, &sem->count);
 
-	/*
-	 * If there are no active locks, wake the front queued process(es).
-	 *
-	 * If there are no writers and we are first in the queue,
-	 * wake our own waiter to join the existing active readers !
-	 */
-	if (!(count & RWSEM_LOCK_MASK)) {
-		clear_nonspinnable(sem);
-		wake = true;
-	}
-	if (wake || (!(count & RWSEM_WRITER_MASK) &&
-		    (adjustment & RWSEM_FLAG_WAITERS)))
-		rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
-
+	rwsem_cond_wake_waiter(sem, count, &wake_q);
 	raw_spin_unlock_irq(&sem->wait_lock);
-	wake_up_q(&wake_q);
+
+	if (!wake_q_empty(&wake_q))
+		wake_up_q(&wake_q);
 
 	/* wait to be given the lock */
 	for (;;) {
@@ -1050,7 +1063,6 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 static struct rw_semaphore *
 rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 {
-	long count;
 	struct rwsem_waiter waiter;
 	DEFINE_WAKE_Q(wake_q);
 
@@ -1074,23 +1086,8 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 
 	/* we're now waiting on the lock */
 	if (rwsem_first_waiter(sem) != &waiter) {
-		count = atomic_long_read(&sem->count);
-
-		/*
-		 * If there were already threads queued before us and:
-		 *  1) there are no active locks, wake the front
-		 *     queued process(es) as the handoff bit might be set.
-		 *  2) there are no active writers and some readers, the lock
-		 *     must be read owned; so we try to wake any read lock
-		 *     waiters that were queued ahead of us.
-		 */
-		if (count & RWSEM_WRITER_MASK)
-			goto wait;
-
-		rwsem_mark_wake(sem, (count & RWSEM_READER_MASK)
-					? RWSEM_WAKE_READERS
-					: RWSEM_WAKE_ANY, &wake_q);
-
+		rwsem_cond_wake_waiter(sem, atomic_long_read(&sem->count),
+				       &wake_q);
 		if (!wake_q_empty(&wake_q)) {
 			/*
 			 * We want to minimize wait_lock hold time especially
@@ -1105,7 +1102,6 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 		atomic_long_or(RWSEM_FLAG_WAITERS, &sem->count);
 	}
 
-wait:
 	/* wait until we successfully acquire the lock */
 	set_current_state(state);
 	for (;;) {
-- 
2.27.0


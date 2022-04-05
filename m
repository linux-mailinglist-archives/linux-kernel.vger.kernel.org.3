Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AA34F3806
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 16:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359852AbiDELVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 07:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240884AbiDEIsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:48:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909B126AEC;
        Tue,  5 Apr 2022 01:36:31 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:36:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649147782;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LlyyhZndPnvcy5nfN53MWTJX71/79zdUHy9i3aRA1h0=;
        b=2JdY2tm31WVKh9o3V/wWtoKP+UOlpFLIEPhJmnfyjH1ADf7j4tJbzxntJG9ViWKlhOanT4
        CJqRj/OZTH1bu7SYNbE1lzJ9EelNrtgeiwnAJiRiurY6jpNwyNl+YFQ2JK2c7fV5ncScmA
        +JFoDmYJpJBAPziqPEsq3wtZ580aToH2FjBhp+k+A4Lfi8xQ3SA7HDFfvhCwmPYMslfwC9
        WKkkWBm8/wClMhvMVYQqHWiXXG4Vj12ACifAvQ9uXnc/CZnac04KXOx3XCAJNtqMWAoftr
        sodUujwKkYZ99FZ2BNmV+NZ8+YQwqzvPRPxJa2AkvwCR16ywYZPO+pBzV3ZYxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649147782;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LlyyhZndPnvcy5nfN53MWTJX71/79zdUHy9i3aRA1h0=;
        b=ZZdxrQSkXS3qqw9oaihlh5zsRVFA7o0Ds5KHroCM2LkGPn30p66n1C5uwtQ+n5jB5uysG3
        ZxAfFW5/E4Z4BNAQ==
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rwsem: Conditionally wake waiters in
 reader/writer slowpaths
Cc:     Waiman Long <longman@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220322152059.2182333-3-longman@redhat.com>
References: <20220322152059.2182333-3-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <164914778087.389.3823809721121975683.tip-bot2@tip-bot2>
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

Commit-ID:     54c1ee4d614d52844cf24c46d8415bf1392021d0
Gitweb:        https://git.kernel.org/tip/54c1ee4d614d52844cf24c46d8415bf1392021d0
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Tue, 22 Mar 2022 11:20:58 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Apr 2022 10:24:35 +02:00

locking/rwsem: Conditionally wake waiters in reader/writer slowpaths

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220322152059.2182333-3-longman@redhat.com
---
 kernel/locking/rwsem.c | 68 +++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 36 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index b077b1b..03cb97a 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -901,7 +901,7 @@ done:
  */
 static inline void clear_nonspinnable(struct rw_semaphore *sem)
 {
-	if (rwsem_test_oflags(sem, RWSEM_NONSPINNABLE))
+	if (unlikely(rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)))
 		atomic_long_andnot(RWSEM_NONSPINNABLE, &sem->owner);
 }
 
@@ -926,6 +926,31 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
 #endif
 
 /*
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
+/*
  * Wait for the read lock to be granted
  */
 static struct rw_semaphore __sched *
@@ -935,7 +960,6 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 	long rcnt = (count >> RWSEM_READER_SHIFT);
 	struct rwsem_waiter waiter;
 	DEFINE_WAKE_Q(wake_q);
-	bool wake = false;
 
 	/*
 	 * To prevent a constant stream of readers from starving a sleeping
@@ -996,22 +1020,11 @@ queue:
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
@@ -1050,7 +1063,6 @@ out_nolock:
 static struct rw_semaphore __sched *
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

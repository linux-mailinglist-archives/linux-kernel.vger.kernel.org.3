Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC935859A7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 11:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbiG3JgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 05:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbiG3Jf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 05:35:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DA618E37;
        Sat, 30 Jul 2022 02:35:58 -0700 (PDT)
Date:   Sat, 30 Jul 2022 09:35:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659173756;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LeIxic/k3kF48XBgfzV0cYUall+6Yn4slRoomda4PTg=;
        b=aAIHYto0xIDQBS47rBx1ch0qDHMbCk+kUJ64QaHf2yrDHT0pZSLO841oEkgzGFQkuyodmm
        PMod66XwNiWSMDK8LFflP/9TdGEg1s15GEP2FD9ryvrNuN0x5lgumSbeYUOgU/uBHiJ/Gy
        T1H5hwBVzImcaZPB+US2kNgx7AqRe+8Qh0Idehxs6fHn1XosbuuGEqQDJhye8NAb3VG2tx
        aXJw40SYDe1TlO6lYFn1K0SUDTtFsO9EEHF0oAZ3dj4ykvQZL6Rr1MCeXVGfezQbRzvAL2
        uJmjAdVJRTDVLfQS1gAKuVU4wROxwHllunj5DIR7atlqZAX7k1KrKuBqmkeCqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659173756;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LeIxic/k3kF48XBgfzV0cYUall+6Yn4slRoomda4PTg=;
        b=KRksxc8iwgZXbzqLZbfAF1Yr8rTMSPnvUiK0iIkqyWK3ChG7NhGj/x6K1oQ8FBIGTdkzXZ
        LE3aTCe8ezyL5CAA==
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking/rwsem: Allow slowpath writer to ignore
 handoff bit if not set by first waiter
Cc:     Waiman Long <longman@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        John Donnelly <john.p.donnelly@oracle.com>,
        Mel Gorman <mgorman@techsingularity.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220622200419.778799-1-longman@redhat.com>
References: <20220622200419.778799-1-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <165917375432.15455.2614303631221531501.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     6eebd5fb20838f5971ba17df9f55cc4f84a31053
Gitweb:        https://git.kernel.org/tip/6eebd5fb20838f5971ba17df9f55cc4f84a31053
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Wed, 22 Jun 2022 16:04:19 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 30 Jul 2022 10:58:28 +02:00

locking/rwsem: Allow slowpath writer to ignore handoff bit if not set by first waiter

With commit d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more
consistent"), the writer that sets the handoff bit can be interrupted
out without clearing the bit if the wait queue isn't empty. This disables
reader and writer optimistic lock spinning and stealing.

Now if a non-first writer in the queue is somehow woken up or a new
waiter enters the slowpath, it can't acquire the lock.  This is not the
case before commit d257cc8cb8d5 as the writer that set the handoff bit
will clear it when exiting out via the out_nolock path. This is less
efficient as the busy rwsem stays in an unlock state for a longer time.

In some cases, this new behavior may cause lockups as shown in [1] and
[2].

This patch allows a non-first writer to ignore the handoff bit if it
is not originally set or initiated by the first waiter. This patch is
shown to be effective in fixing the lockup problem reported in [1].

[1] https://lore.kernel.org/lkml/20220617134325.GC30825@techsingularity.net/
[2] https://lore.kernel.org/lkml/3f02975c-1a9d-be20-32cf-f1d8e3dfafcc@oracle.com/

Fixes: d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more consistent")
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: John Donnelly <john.p.donnelly@oracle.com>
Tested-by: Mel Gorman <mgorman@techsingularity.net>
Link: https://lore.kernel.org/r/20220622200419.778799-1-longman@redhat.com
---
 kernel/locking/rwsem.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 9d1db4a..65f0262 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -335,8 +335,6 @@ struct rwsem_waiter {
 	struct task_struct *task;
 	enum rwsem_waiter_type type;
 	unsigned long timeout;
-
-	/* Writer only, not initialized in reader */
 	bool handoff_set;
 };
 #define rwsem_first_waiter(sem) \
@@ -459,10 +457,12 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 			 * to give up the lock), request a HANDOFF to
 			 * force the issue.
 			 */
-			if (!(oldcount & RWSEM_FLAG_HANDOFF) &&
-			    time_after(jiffies, waiter->timeout)) {
-				adjustment -= RWSEM_FLAG_HANDOFF;
-				lockevent_inc(rwsem_rlock_handoff);
+			if (time_after(jiffies, waiter->timeout)) {
+				if (!(oldcount & RWSEM_FLAG_HANDOFF)) {
+					adjustment -= RWSEM_FLAG_HANDOFF;
+					lockevent_inc(rwsem_rlock_handoff);
+				}
+				waiter->handoff_set = true;
 			}
 
 			atomic_long_add(-adjustment, &sem->count);
@@ -599,7 +599,7 @@ rwsem_del_wake_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter,
 static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
 					struct rwsem_waiter *waiter)
 {
-	bool first = rwsem_first_waiter(sem) == waiter;
+	struct rwsem_waiter *first = rwsem_first_waiter(sem);
 	long count, new;
 
 	lockdep_assert_held(&sem->wait_lock);
@@ -609,11 +609,20 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
 		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
 
 		if (has_handoff) {
-			if (!first)
+			/*
+			 * Honor handoff bit and yield only when the first
+			 * waiter is the one that set it. Otherwisee, we
+			 * still try to acquire the rwsem.
+			 */
+			if (first->handoff_set && (waiter != first))
 				return false;
 
-			/* First waiter inherits a previously set handoff bit */
-			waiter->handoff_set = true;
+			/*
+			 * First waiter can inherit a previously set handoff
+			 * bit and spin on rwsem if lock acquisition fails.
+			 */
+			if (waiter == first)
+				waiter->handoff_set = true;
 		}
 
 		new = count;
@@ -1027,6 +1036,7 @@ queue:
 	waiter.task = current;
 	waiter.type = RWSEM_WAITING_FOR_READ;
 	waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
+	waiter.handoff_set = false;
 
 	raw_spin_lock_irq(&sem->wait_lock);
 	if (list_empty(&sem->wait_list)) {

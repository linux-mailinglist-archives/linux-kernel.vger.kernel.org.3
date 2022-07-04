Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DEA5658CB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbiGDOi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234408AbiGDOin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:38:43 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B22DB4A4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:38:41 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id b12-20020a17090a6acc00b001ec2b181c98so13962777pjm.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 07:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sT9qOYSF74DDh91Es5esuTKdKBvO8DYK5RYWFWTsIig=;
        b=ZJ1ZLy5nNkrTYNCiJ8uUZz3e0hPb6Pp1R+NN1nFblK1X4atDwRTksk0HsArzdQ9feT
         iwMHc9KBjlQFVZoqZxz6N4xGx0ACHGqw7bdu539OoADa41mH8mDRfJsbx6WN2eOrkn2/
         ZGX7o1p6BwVa8ocfULlkOr5kFHKrZCY3lFiAuN2FL1Zuz5fnVLr5qRmiTf5PgU57sxar
         OmkNbhwxBTQJstpxtTSy8aAnNRmT1BqkNJCkiULGjmVAk2gD1ZgcTfUSHABmimAXs1d9
         YdFfqq9Oe9BoyIcgbubzqJMQbIofcwNebLRX7Cc3okGuk6PQ33qmC01gRg8sNi77kpsA
         LqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sT9qOYSF74DDh91Es5esuTKdKBvO8DYK5RYWFWTsIig=;
        b=OXpPcIGHLJqe5K3uI861pQORitAQEWDLAoLggEsDbcM/J517WkKFO4UsMTQZ+FFWwt
         DTajCrj+ts2P4WB34GMSPiCylkVuD8f3MgJEjTWISFdOHwbadbYPDWqaoBiUtf5y7wxf
         5/NQPzo/EMZiXugCe9nofDUUs57905pzyk6WjMzW1F6YGWRHUxmtMiftELOcNMSuqmeg
         ff4w7qUzR6dTmzDShSXCXGot0L/G2HVp/nryvUXO7t6xdjqpnl4ie2fKDmQJXNW4xuz9
         etBdWYu2FjrCZZpY7vhQEY5xolRf39GvEzrxvI4uLR8sZLzxH8lqnGgOtBfgmdUyPvSE
         9x9w==
X-Gm-Message-State: AJIora9oqxV6NfAItZlhkx7lJwj8HGthHxU68s+L59Jyld7mGd5M6nMu
        dhisEtNOzV+/7NgaMcu9OY0=
X-Google-Smtp-Source: AGRyM1s8OsmPnAxfdjYw0hc6+ssdQM1L7uKkVAosGTQHotboKfbghzqN2RGAfWxDWVC8h7VYyjcx1A==
X-Received: by 2002:a17:90b:1982:b0:1ec:e2fa:99ae with SMTP id mv2-20020a17090b198200b001ece2fa99aemr36639154pjb.228.1656945520631;
        Mon, 04 Jul 2022 07:38:40 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com ([203.221.247.188])
        by smtp.gmail.com with ESMTPSA id u13-20020a63454d000000b0040d2224ae04sm20534365pgk.76.2022.07.04.07.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 07:38:40 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 03/13] locking/qspinlock: split common mcs queueing code into its own function
Date:   Tue,  5 Jul 2022 00:38:10 +1000
Message-Id: <20220704143820.3071004-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220704143820.3071004-1-npiggin@gmail.com>
References: <20220704143820.3071004-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pv qspinlocks jumps over a bunch of slowpath code directly to the
queueing part. Split the queueing code into its own function and call it
explicitly in each pv and !pv cases. This will help to untangle the two
cases with subsequent changes.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/locking/qspinlock.c | 208 +++++++++++++++++++------------------
 1 file changed, 108 insertions(+), 100 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 32f401e966ab..7360d643de29 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -294,112 +294,14 @@ static __always_inline u32  __pv_wait_head_or_lock(struct qspinlock *lock,
 
 #endif /* _GEN_PV_LOCK_SLOWPATH */
 
-/**
- * queued_spin_lock_slowpath - acquire the queued spinlock
- * @lock: Pointer to queued spinlock structure
- * @val: Current value of the queued spinlock 32-bit word
- *
- * (queue tail, pending bit, lock value)
- *
- *              fast     :    slow                                  :    unlock
- *                       :                                          :
- * uncontended  (0,0,0) -:--> (0,0,1) ------------------------------:--> (*,*,0)
- *                       :       | ^--------.------.             /  :
- *                       :       v           \      \            |  :
- * pending               :    (0,1,1) +--> (0,1,0)   \           |  :
- *                       :       | ^--'              |           |  :
- *                       :       v                   |           |  :
- * uncontended           :    (n,x,y) +--> (n,0,0) --'           |  :
- *   queue               :       | ^--'                          |  :
- *                       :       v                               |  :
- * contended             :    (*,x,y) +--> (*,0,0) ---> (*,0,1) -'  :
- *   queue               :         ^--'                             :
- */
-void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
+static inline void queued_spin_lock_mcs_queue(struct qspinlock *lock)
 {
 	struct qnode *prev, *next, *node;
-	u32 old, tail;
+	u32 val, old, tail;
 	int idx;
 
 	BUILD_BUG_ON(CONFIG_NR_CPUS >= (1U << _Q_TAIL_CPU_BITS));
 
-	if (pv_enabled())
-		goto pv_queue;
-
-	if (virt_spin_lock(lock))
-		return;
-
-	/*
-	 * Wait for in-progress pending->locked hand-overs with a bounded
-	 * number of spins so that we guarantee forward progress.
-	 *
-	 * 0,1,0 -> 0,0,1
-	 */
-	if (val == _Q_PENDING_VAL) {
-		int cnt = _Q_PENDING_LOOPS;
-		val = atomic_cond_read_relaxed(&lock->val,
-					       (VAL != _Q_PENDING_VAL) || !cnt--);
-	}
-
-	/*
-	 * If we observe any contention; queue.
-	 */
-	if (val & ~_Q_LOCKED_MASK)
-		goto queue;
-
-	/*
-	 * trylock || pending
-	 *
-	 * 0,0,* -> 0,1,* -> 0,0,1 pending, trylock
-	 */
-	val = queued_fetch_set_pending_acquire(lock);
-
-	/*
-	 * If we observe contention, there is a concurrent locker.
-	 *
-	 * Undo and queue; our setting of PENDING might have made the
-	 * n,0,0 -> 0,0,0 transition fail and it will now be waiting
-	 * on @next to become !NULL.
-	 */
-	if (unlikely(val & ~_Q_LOCKED_MASK)) {
-
-		/* Undo PENDING if we set it. */
-		if (!(val & _Q_PENDING_MASK))
-			clear_pending(lock);
-
-		goto queue;
-	}
-
-	/*
-	 * We're pending, wait for the owner to go away.
-	 *
-	 * 0,1,1 -> 0,1,0
-	 *
-	 * this wait loop must be a load-acquire such that we match the
-	 * store-release that clears the locked bit and create lock
-	 * sequentiality; this is because not all
-	 * clear_pending_set_locked() implementations imply full
-	 * barriers.
-	 */
-	if (val & _Q_LOCKED_MASK)
-		atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_MASK));
-
-	/*
-	 * take ownership and clear the pending bit.
-	 *
-	 * 0,1,0 -> 0,0,1
-	 */
-	clear_pending_set_locked(lock);
-	lockevent_inc(lock_pending);
-	return;
-
-	/*
-	 * End of pending bit optimistic spinning and beginning of MCS
-	 * queuing.
-	 */
-queue:
-	lockevent_inc(lock_slowpath);
-pv_queue:
 	node = this_cpu_ptr(&qnodes[0]);
 	idx = node->count++;
 	tail = encode_tail(smp_processor_id(), idx);
@@ -567,6 +469,110 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 */
 	__this_cpu_dec(qnodes[0].count);
 }
+
+/**
+ * queued_spin_lock_slowpath - acquire the queued spinlock
+ * @lock: Pointer to queued spinlock structure
+ * @val: Current value of the queued spinlock 32-bit word
+ *
+ * (queue tail, pending bit, lock value)
+ *
+ *              fast     :    slow                                  :    unlock
+ *                       :                                          :
+ * uncontended  (0,0,0) -:--> (0,0,1) ------------------------------:--> (*,*,0)
+ *                       :       | ^--------.------.             /  :
+ *                       :       v           \      \            |  :
+ * pending               :    (0,1,1) +--> (0,1,0)   \           |  :
+ *                       :       | ^--'              |           |  :
+ *                       :       v                   |           |  :
+ * uncontended           :    (n,x,y) +--> (n,0,0) --'           |  :
+ *   queue               :       | ^--'                          |  :
+ *                       :       v                               |  :
+ * contended             :    (*,x,y) +--> (*,0,0) ---> (*,0,1) -'  :
+ *   queue               :         ^--'                             :
+ */
+void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
+{
+	if (pv_enabled()) {
+		queued_spin_lock_mcs_queue(lock);
+		return;
+	}
+
+	if (virt_spin_lock(lock))
+		return;
+
+	/*
+	 * Wait for in-progress pending->locked hand-overs with a bounded
+	 * number of spins so that we guarantee forward progress.
+	 *
+	 * 0,1,0 -> 0,0,1
+	 */
+	if (val == _Q_PENDING_VAL) {
+		int cnt = _Q_PENDING_LOOPS;
+		val = atomic_cond_read_relaxed(&lock->val,
+					       (VAL != _Q_PENDING_VAL) || !cnt--);
+	}
+
+	/*
+	 * If we observe any contention; queue.
+	 */
+	if (val & ~_Q_LOCKED_MASK)
+		goto queue;
+
+	/*
+	 * trylock || pending
+	 *
+	 * 0,0,* -> 0,1,* -> 0,0,1 pending, trylock
+	 */
+	val = queued_fetch_set_pending_acquire(lock);
+
+	/*
+	 * If we observe contention, there is a concurrent locker.
+	 *
+	 * Undo and queue; our setting of PENDING might have made the
+	 * n,0,0 -> 0,0,0 transition fail and it will now be waiting
+	 * on @next to become !NULL.
+	 */
+	if (unlikely(val & ~_Q_LOCKED_MASK)) {
+
+		/* Undo PENDING if we set it. */
+		if (!(val & _Q_PENDING_MASK))
+			clear_pending(lock);
+
+		goto queue;
+	}
+
+	/*
+	 * We're pending, wait for the owner to go away.
+	 *
+	 * 0,1,1 -> 0,1,0
+	 *
+	 * this wait loop must be a load-acquire such that we match the
+	 * store-release that clears the locked bit and create lock
+	 * sequentiality; this is because not all
+	 * clear_pending_set_locked() implementations imply full
+	 * barriers.
+	 */
+	if (val & _Q_LOCKED_MASK)
+		atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_MASK));
+
+	/*
+	 * take ownership and clear the pending bit.
+	 *
+	 * 0,1,0 -> 0,0,1
+	 */
+	clear_pending_set_locked(lock);
+	lockevent_inc(lock_pending);
+	return;
+
+	/*
+	 * End of pending bit optimistic spinning and beginning of MCS
+	 * queuing.
+	 */
+queue:
+	lockevent_inc(lock_slowpath);
+	queued_spin_lock_mcs_queue(lock);
+}
 EXPORT_SYMBOL(queued_spin_lock_slowpath);
 
 /*
@@ -583,6 +589,8 @@ EXPORT_SYMBOL(queued_spin_lock_slowpath);
 #undef pv_kick_node
 #undef pv_wait_head_or_lock
 
+#define queued_spin_lock_mcs_queue	__pv_queued_spin_lock_mcs_queue
+
 #undef  queued_spin_lock_slowpath
 #define queued_spin_lock_slowpath	__pv_queued_spin_lock_slowpath
 
-- 
2.35.1


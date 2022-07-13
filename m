Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DC7572EC5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbiGMHHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbiGMHH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:07:26 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426A3E2A0B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:07:24 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id f65so413133pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sT9qOYSF74DDh91Es5esuTKdKBvO8DYK5RYWFWTsIig=;
        b=NYG8nlUEVkv6JqnRV5lzyZ9TWggIIm2WeOLhCxyzTSmuJmfyWFJGRsDUlux3t4AhBy
         JlXdh5fRun3SpJ7JqBmIpyZCCLVgg8si+rx8/sDDMDKnI6N7j3+p5xqiN3GWhN9Xib5D
         Wuz/yAmeeuU7wEdEQ3UKrgviwSmAI/WgIJezQLbmXTR4MM6bwC5zQ5BrvU1qA1m/KrGd
         AZmISVkCabm0z41veLk+Qflxk8Srf0jq78GjA+6f2xs3QwD+ykL3xO6atjRybsYApNQ1
         7RegRnObHKys/fSMzV3ZQGHMzt5hnakYgU5v9ShDn+aa4LQXOk64iEyVJhd3EBW1qHFX
         nY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sT9qOYSF74DDh91Es5esuTKdKBvO8DYK5RYWFWTsIig=;
        b=S+YMqGMRV5R4feI8EUQkkln4OIUULh/P6YpwXBtjcNEaxJ+Uodm3XF6TrVawt8P/OA
         /inW7y9cDwbOzEGZXuw6TuunXbKzuWTvmDthpCkS1Tq+Rmh/rSlKZHAXVOUw6nmJ59nH
         PhT5P/bngmVjS4+bwV56hmrCGkRullZZ9P22C0etYPOSURiON/I3U3Nr+xV9JSjVFl/9
         2rGzHxTC/NwxBBCT6lWlJcacZoYYs2/gKHiRWr6HTDMKNus/gKbcOQ7Bs5OPV3a4lBLx
         cz+yOvmfCAvfbZe1XQ12g6rw6nzkFCU3wphRgNI3a2FUMeMXxc09tqEV1ZMDana4c4zv
         RNIg==
X-Gm-Message-State: AJIora/C1W7xMG/xeTXyru+zWdXwa3Y8r43Pibvi/x+st+gLIK5H+4Ht
        kIrvPm9rYxEATt9FT87NFTg=
X-Google-Smtp-Source: AGRyM1uIx6UcyGfU+hyhrlQ7rl7xNRpkvodQifCLyUbffLM4y1ltjuOG+DkneD8XMfLfzDrrHk4S4g==
X-Received: by 2002:a63:f95c:0:b0:412:9d5b:fbfd with SMTP id q28-20020a63f95c000000b004129d5bfbfdmr1785942pgk.103.1657696043357;
        Wed, 13 Jul 2022 00:07:23 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (193-116-203-247.tpgi.com.au. [193.116.203.247])
        by smtp.gmail.com with ESMTPSA id d11-20020a170902cecb00b0016bd5da20casm8099061plg.134.2022.07.13.00.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 00:07:22 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 03/12] locking/qspinlock: split common mcs queueing code into its own function
Date:   Wed, 13 Jul 2022 17:06:55 +1000
Message-Id: <20220713070704.308394-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220713070704.308394-1-npiggin@gmail.com>
References: <20220713070704.308394-1-npiggin@gmail.com>
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


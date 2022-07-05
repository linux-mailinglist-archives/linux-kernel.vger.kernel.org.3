Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B9B567617
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbiGER7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbiGER7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:59:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1F219C07
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 10:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=od2v9+fAqfLGNC1xRMwbfRO7vsWFz9nVzIv8mh52p24=; b=RSzo2vQO++0KgjPOrCHnvrvDV1
        7tbxg7aVNb3E/tF9Q0+EkqIsQZmwItna3/wCQmGCaygYoAEi/G1QhP1khKtRKhj4SMojrjabHVqyW
        PwFKsQ7wc2fUH+ZtanvyHmdvtVLQGaYkcTs4/Q5KRgMzkhQyYrXpLwJ4KruFXxNp1/4b7AUWx1LxM
        ZKm9osLCpxW/lmXECbyeLipHYsyLX8qCRuF1GrlKZ6ds2at52hRJsljviWRkVtN7S1GQ3psVfmeos
        oijYyNm/zXII4WVbBS1O25mLTulXflCanWQyKw0MNHUox1m3EzJgSeLlDEbgBSi6zWCGOOFDPUn35
        Bbh1LYwQ==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8mph-0005I4-68; Tue, 05 Jul 2022 17:59:34 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6C47298005C; Tue,  5 Jul 2022 19:59:32 +0200 (CEST)
Date:   Tue, 5 Jul 2022 19:59:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] locking/qspinlock: simplify code generation
Message-ID: <YsR8BIyrSCQ8AlEo@worktop.programming.kicks-ass.net>
References: <20220704143820.3071004-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704143820.3071004-1-npiggin@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 12:38:07AM +1000, Nicholas Piggin wrote:
> Hi,
> 
> Been recently looking a bit closer at queued spinlock code, and
> found it's a little tricky to follow especially the pv generation.
> This series tries to improve the situation. It's not well tested
> outside powerpc, but it's really the x86 pv code that is the
> other major complexity that should need some review and testing.
> Opinions?

perhaps something like so on top/instead? This would still allow
slotting in other implementations with relative ease and the compilers
should constant fold all this.

--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -609,7 +609,7 @@ static void pv_kick_node(struct qspinloc
  *
  * The current value of the lock will be returned for additional processing.
  */
-static void pv_wait_head_or_lock(struct qspinlock *lock, struct qnode *node)
+static u32 pv_wait_head_or_lock(struct qspinlock *lock, struct qnode *node)
 {
 	struct qspinlock **lp = NULL;
 	int waitcnt = 0;
@@ -641,7 +641,7 @@ static void pv_wait_head_or_lock(struct
 		set_pending(lock);
 		for (loop = SPIN_THRESHOLD; loop; loop--) {
 			if (trylock_clear_pending(lock))
-				return; /* got lock */
+				goto out; /* got lock */
 			cpu_relax();
 		}
 		clear_pending(lock);
@@ -669,7 +669,7 @@ static void pv_wait_head_or_lock(struct
 				 */
 				WRITE_ONCE(lock->locked, _Q_LOCKED_VAL);
 				WRITE_ONCE(*lp, NULL);
-				return; /* got lock */
+				goto out; /* got lock */
 			}
 		}
 		WRITE_ONCE(node->state, vcpu_hashed);
@@ -683,12 +683,22 @@ static void pv_wait_head_or_lock(struct
 		 */
 	}
 
+out:
 	/*
 	 * The cmpxchg() or xchg() call before coming here provides the
 	 * acquire semantics for locking.
 	 */
+	return atomic_read(&lock->val);
 }
 
+static const struct queue_ops pv_ops = {
+	.init_node		= pv_init_node,
+	.trylock		= pv_hybrid_queued_unfair_trylock,
+	.wait_node		= pv_wait_node,
+	.wait_head_or_lock	= pv_wait_head_or_lock,
+	.kick_node		= pv_kick_node,
+};
+
 /*
  * PV versions of the unlock fastpath and slowpath functions to be used
  * instead of queued_spin_unlock().
@@ -756,18 +766,18 @@ __visible void __pv_queued_spin_unlock(s
 EXPORT_SYMBOL(__pv_queued_spin_unlock);
 #endif
 
-#else /* CONFIG_PARAVIRT_SPINLOCKS */
-static __always_inline void pv_init_node(struct qnode *node) { }
-static __always_inline void pv_wait_node(struct qnode *node,
-					 struct qnode *prev) { }
-static __always_inline void pv_kick_node(struct qspinlock *lock,
-					 struct qnode *node) { }
-static __always_inline void pv_wait_head_or_lock(struct qspinlock *lock,
-						 struct qnode *node) { }
-static __always_inline bool pv_hybrid_queued_unfair_trylock(struct qspinlock *lock) { BUILD_BUG(); }
 #endif /* CONFIG_PARAVIRT_SPINLOCKS */
 
-static inline void queued_spin_lock_mcs_queue(struct qspinlock *lock, bool paravirt)
+struct queue_ops {
+	void (*init_node)(struct qnode *node);
+	bool (*trylock)(struct qspinlock *lock);
+	void (*wait_node)(struct qnode *node, struct qnode *prev);
+	u32 (*wait_head_or_lock)(struct qspinlock *lock, struct qnode *node);
+	void (*kick_node)(struct qspinlock *lock, struct qnode *node);
+};
+
+static __always_inline
+void queued_spin_lock_mcs_queue(struct qspinlock *lock, const struct queue_ops *ops)
 {
 	struct qnode *prev, *next, *node;
 	u32 val, old, tail;
@@ -813,16 +823,16 @@ static inline void queued_spin_lock_mcs_
 
 	node->locked = 0;
 	node->next = NULL;
-	if (paravirt)
-		pv_init_node(node);
+	if (ops && ops->init_node)
+		ops->init_node(node);
 
 	/*
 	 * We touched a (possibly) cold cacheline in the per-cpu queue node;
 	 * attempt the trylock once more in the hope someone let go while we
 	 * weren't watching.
 	 */
-	if (paravirt) {
-		if (pv_hybrid_queued_unfair_trylock(lock))
+	if (ops && ops->trylock) {
+		if (ops->trylock(lock))
 			goto release;
 	} else {
 		if (queued_spin_trylock(lock))
@@ -857,8 +867,8 @@ static inline void queued_spin_lock_mcs_
 		WRITE_ONCE(prev->next, node);
 
 		/* Wait for mcs node lock to be released */
-		if (paravirt)
-			pv_wait_node(node, prev);
+		if (ops && ops->wait_node)
+			ops->wait_node(node, prev);
 		else
 			smp_cond_load_acquire(&node->locked, VAL);
 
@@ -893,12 +903,11 @@ static inline void queued_spin_lock_mcs_
 	 * If PV isn't active, 0 will be returned instead.
 	 *
 	 */
-	if (paravirt) {
-		pv_wait_head_or_lock(lock, node);
-		val = atomic_read(&lock->val);
+	if (ops && ops->wait_head_or_lock) {
+		val = ops->wait_head_or_lock(lock, node);
 	} else {
 		val = atomic_cond_read_acquire(&lock->val,
-				!(VAL & _Q_LOCKED_PENDING_MASK));
+					       !(VAL & _Q_LOCKED_PENDING_MASK));
 	}
 
 	/*
@@ -1049,14 +1058,14 @@ void queued_spin_lock_slowpath(struct qs
 	 */
 queue:
 	lockevent_inc(lock_slowpath);
-	queued_spin_lock_mcs_queue(lock, false);
+	queued_spin_lock_mcs_queue(lock, NULL);
 }
 EXPORT_SYMBOL(queued_spin_lock_slowpath);
 
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
 void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 {
-	queued_spin_lock_mcs_queue(lock, true);
+	queued_spin_lock_mcs_queue(lock, &pv_ops);
 }
 EXPORT_SYMBOL(__pv_queued_spin_lock_slowpath);
 

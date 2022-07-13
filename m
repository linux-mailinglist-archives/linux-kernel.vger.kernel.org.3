Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC63A572EC9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbiGMHIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234636AbiGMHHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:07:44 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FD7E3071
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:07:35 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id e132so9676157pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=40ncgsOAwyc3rCPX0MCyCkrSp4LjXOzqrt5qmZficko=;
        b=HpxmwBGS3Nt71I3tzKp85f/MhFjS/L+EKFCZH2f7IBMra7ekXRZfXSAg9bjYdBhJWy
         rAF4dbWfOZmAZJDkeTp551N9hlRAMSPH8pF5xCJzsvcwBdCcGhfK6WhEK6KMXfLSyRDm
         T8Y33S+4NVDq9qOui0gfLPGnQ6bxRAOsGvzNh03/toGY1YFANRSe8QxvF8+QeX0FiMHA
         jnLrVygOZjL4MoSCnKKo3rikl838U4p1tgxbLMRmuvEbymE73Ge+E3XdaYktC9qFuaBJ
         KP+LvTmpDbbKwl7C2Aowc/UaQ55xSkBrDR/QPWhsT1aTmmq99Dj35qZyBet2C48Ots4H
         4ijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=40ncgsOAwyc3rCPX0MCyCkrSp4LjXOzqrt5qmZficko=;
        b=CndQSEvwO6G1ACCARPwN8RIPuw+Eg0iG56GhaqIF/ckK0KgBCEONyc0Tmfh7eoaCEk
         c+ssNwJbNAVUhe8Zgrota0I7TO9XMc2UmQrRR5pVJuFtMnvUX98vxtyKGe3jqK7s7Bi3
         IxKPDKtCX7AfycVu1MwPLU/mrP2TJxRNjya+pXEWG94G5B6KVGxdqXFu4K3so57Fxkzk
         GUL2OVfpp52Ao1wVU9DMMCi9nzp7cvGkRAJxqqXWIGS9dLL1Lh/QsHh//VWbLE2xDm/1
         Vyj2F+fKrHHftZdNaP+9m70XQhzi52VeOEyFfThBCfY6oHjRIiJDWF6jaYg0lau1eZVp
         1KWw==
X-Gm-Message-State: AJIora9Bc+UoxXuXDWZu5DyQkh+NcjcQZ/DfmSS4Z+2Lq6ztf//CqhXd
        O3fhIvA3JoXsJNf71+DS9oEIo2ha0OQ=
X-Google-Smtp-Source: AGRyM1sThATjQCJocj+atU5BLGVrjfjQQYzOS6wKnOgBV2rMhB8uK0kJM7/2nEQZjwiiWHfrYi2aug==
X-Received: by 2002:a65:6786:0:b0:415:c67a:49a9 with SMTP id e6-20020a656786000000b00415c67a49a9mr1776095pgr.395.1657696055012;
        Wed, 13 Jul 2022 00:07:35 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (193-116-203-247.tpgi.com.au. [193.116.203.247])
        by smtp.gmail.com with ESMTPSA id d11-20020a170902cecb00b0016bd5da20casm8099061plg.134.2022.07.13.00.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 00:07:34 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 06/12] locking/qspinlock: merge qspinlock_paravirt.h into qspinlock.c
Date:   Wed, 13 Jul 2022 17:06:58 +1000
Message-Id: <20220713070704.308394-7-npiggin@gmail.com>
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

There isn't much reason to keep these separate.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/locking/qspinlock.c          | 488 ++++++++++++++++++++++++++-
 kernel/locking/qspinlock_paravirt.h | 490 ----------------------------
 2 files changed, 487 insertions(+), 491 deletions(-)
 delete mode 100644 kernel/locking/qspinlock_paravirt.h

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 037bd5440cfd..3b3663d15402 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -16,6 +16,7 @@
 #include <linux/cpumask.h>
 #include <linux/percpu.h>
 #include <linux/hardirq.h>
+#include <linux/memblock.h>
 #include <linux/mutex.h>
 #include <linux/prefetch.h>
 #include <asm/byteorder.h>
@@ -286,7 +287,492 @@ static __always_inline void set_locked(struct qspinlock *lock)
 }
 
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
-#include "qspinlock_paravirt.h"
+/*
+ * Implement paravirt qspinlocks; the general idea is to halt the vcpus instead
+ * of spinning them.
+ *
+ * This relies on the architecture to provide two paravirt hypercalls:
+ *
+ *   pv_wait(u8 *ptr, u8 val) -- suspends the vcpu if *ptr == val
+ *   pv_kick(cpu)             -- wakes a suspended vcpu
+ *
+ * Using these we implement __pv_queued_spin_lock_slowpath() and
+ * __pv_queued_spin_unlock() to replace native_queued_spin_lock_slowpath() and
+ * native_queued_spin_unlock().
+ */
+
+#define _Q_SLOW_VAL	(3U << _Q_LOCKED_OFFSET)
+
+/*
+ * Queue Node Adaptive Spinning
+ *
+ * A queue node vCPU will stop spinning if the vCPU in the previous node is
+ * not running. The one lock stealing attempt allowed at slowpath entry
+ * mitigates the slight slowdown for non-overcommitted guest with this
+ * aggressive wait-early mechanism.
+ *
+ * The status of the previous node will be checked at fixed interval
+ * controlled by PV_PREV_CHECK_MASK. This is to ensure that we won't
+ * pound on the cacheline of the previous node too heavily.
+ */
+#define PV_PREV_CHECK_MASK	0xff
+
+/*
+ * Queue node uses: vcpu_running & vcpu_halted.
+ * Queue head uses: vcpu_running & vcpu_hashed.
+ */
+enum vcpu_state {
+	vcpu_running = 0,
+	vcpu_halted,		/* Used only in pv_wait_node */
+	vcpu_hashed,		/* = pv_hash'ed + vcpu_halted */
+};
+
+/*
+ * Hybrid PV queued/unfair lock
+ *
+ * This function is called once when a lock waiter enters the PV slowpath
+ * before being queued.
+ *
+ * The pending bit is set by the queue head vCPU of the MCS wait queue in
+ * pv_wait_head_or_lock() to signal that it is ready to spin on the lock.
+ * When that bit becomes visible to the incoming waiters, no lock stealing
+ * is allowed. The function will return immediately to make the waiters
+ * enter the MCS wait queue. So lock starvation shouldn't happen as long
+ * as the queued mode vCPUs are actively running to set the pending bit
+ * and hence disabling lock stealing.
+ *
+ * When the pending bit isn't set, the lock waiters will stay in the unfair
+ * mode spinning on the lock unless the MCS wait queue is empty. In this
+ * case, the lock waiters will enter the queued mode slowpath trying to
+ * become the queue head and set the pending bit.
+ *
+ * This hybrid PV queued/unfair lock combines the best attributes of a
+ * queued lock (no lock starvation) and an unfair lock (good performance
+ * on not heavily contended locks).
+ */
+static inline bool pv_hybrid_queued_unfair_trylock(struct qspinlock *lock)
+{
+	/*
+	 * Stay in unfair lock mode as long as queued mode waiters are
+	 * present in the MCS wait queue but the pending bit isn't set.
+	 */
+	for (;;) {
+		int val = atomic_read(&lock->val);
+
+		if (!(val & _Q_LOCKED_PENDING_MASK) &&
+		   (cmpxchg_acquire(&lock->locked, 0, _Q_LOCKED_VAL) == 0)) {
+			lockevent_inc(pv_lock_stealing);
+			return true;
+		}
+		if (!(val & _Q_TAIL_MASK) || (val & _Q_PENDING_MASK))
+			break;
+
+		cpu_relax();
+	}
+
+	return false;
+}
+
+/*
+ * Lock and MCS node addresses hash table for fast lookup
+ *
+ * Hashing is done on a per-cacheline basis to minimize the need to access
+ * more than one cacheline.
+ *
+ * Dynamically allocate a hash table big enough to hold at least 4X the
+ * number of possible cpus in the system. Allocation is done on page
+ * granularity. So the minimum number of hash buckets should be at least
+ * 256 (64-bit) or 512 (32-bit) to fully utilize a 4k page.
+ *
+ * Since we should not be holding locks from NMI context (very rare indeed) the
+ * max load factor is 0.75, which is around the point where open addressing
+ * breaks down.
+ *
+ */
+struct pv_hash_entry {
+	struct qspinlock *lock;
+	struct qnode   *node;
+};
+
+#define PV_HE_PER_LINE	(SMP_CACHE_BYTES / sizeof(struct pv_hash_entry))
+#define PV_HE_MIN	(PAGE_SIZE / sizeof(struct pv_hash_entry))
+
+static struct pv_hash_entry *pv_lock_hash;
+static unsigned int pv_lock_hash_bits __read_mostly;
+
+/*
+ * Allocate memory for the PV qspinlock hash buckets
+ *
+ * This function should be called from the paravirt spinlock initialization
+ * routine.
+ */
+void __init __pv_init_lock_hash(void)
+{
+	int pv_hash_size = ALIGN(4 * num_possible_cpus(), PV_HE_PER_LINE);
+
+	if (pv_hash_size < PV_HE_MIN)
+		pv_hash_size = PV_HE_MIN;
+
+	/*
+	 * Allocate space from bootmem which should be page-size aligned
+	 * and hence cacheline aligned.
+	 */
+	pv_lock_hash = alloc_large_system_hash("PV qspinlock",
+					       sizeof(struct pv_hash_entry),
+					       pv_hash_size, 0,
+					       HASH_EARLY | HASH_ZERO,
+					       &pv_lock_hash_bits, NULL,
+					       pv_hash_size, pv_hash_size);
+}
+
+#define for_each_hash_entry(he, offset, hash)						\
+	for (hash &= ~(PV_HE_PER_LINE - 1), he = &pv_lock_hash[hash], offset = 0;	\
+	     offset < (1 << pv_lock_hash_bits);						\
+	     offset++, he = &pv_lock_hash[(hash + offset) & ((1 << pv_lock_hash_bits) - 1)])
+
+static struct qspinlock **pv_hash(struct qspinlock *lock, struct qnode *node)
+{
+	unsigned long offset, hash = hash_ptr(lock, pv_lock_hash_bits);
+	struct pv_hash_entry *he;
+	int hopcnt = 0;
+
+	for_each_hash_entry(he, offset, hash) {
+		hopcnt++;
+		if (!cmpxchg(&he->lock, NULL, lock)) {
+			WRITE_ONCE(he->node, node);
+			lockevent_pv_hop(hopcnt);
+			return &he->lock;
+		}
+	}
+	/*
+	 * Hard assume there is a free entry for us.
+	 *
+	 * This is guaranteed by ensuring every blocked lock only ever consumes
+	 * a single entry, and since we only have 4 nesting levels per CPU
+	 * and allocated 4*nr_possible_cpus(), this must be so.
+	 *
+	 * The single entry is guaranteed by having the lock owner unhash
+	 * before it releases.
+	 */
+	BUG();
+}
+
+static struct qnode *pv_unhash(struct qspinlock *lock)
+{
+	unsigned long offset, hash = hash_ptr(lock, pv_lock_hash_bits);
+	struct pv_hash_entry *he;
+	struct qnode *node;
+
+	for_each_hash_entry(he, offset, hash) {
+		if (READ_ONCE(he->lock) == lock) {
+			node = READ_ONCE(he->node);
+			WRITE_ONCE(he->lock, NULL);
+			return node;
+		}
+	}
+	/*
+	 * Hard assume we'll find an entry.
+	 *
+	 * This guarantees a limited lookup time and is itself guaranteed by
+	 * having the lock owner do the unhash -- IFF the unlock sees the
+	 * SLOW flag, there MUST be a hash entry.
+	 */
+	BUG();
+}
+
+/*
+ * Return true if when it is time to check the previous node which is not
+ * in a running state.
+ */
+static inline bool
+pv_wait_early(struct qnode *prev, int loop)
+{
+	if ((loop & PV_PREV_CHECK_MASK) != 0)
+		return false;
+
+	return READ_ONCE(prev->state) != vcpu_running;
+}
+
+/*
+ * Initialize the PV part of the qnode.
+ */
+static void pv_init_node(struct qnode *node)
+{
+	node->cpu = smp_processor_id();
+	node->state = vcpu_running;
+}
+
+/*
+ * Wait for node->locked to become true, halt the vcpu after a short spin.
+ * pv_kick_node() is used to set _Q_SLOW_VAL and fill in hash table on its
+ * behalf.
+ */
+static void pv_wait_node(struct qnode *node, struct qnode *prev)
+{
+	int loop;
+	bool wait_early;
+
+	for (;;) {
+		for (wait_early = false, loop = SPIN_THRESHOLD; loop; loop--) {
+			if (READ_ONCE(node->locked))
+				return;
+			if (pv_wait_early(prev, loop)) {
+				wait_early = true;
+				break;
+			}
+			cpu_relax();
+		}
+
+		/*
+		 * Order node->state vs node->locked thusly:
+		 *
+		 * [S] node->state = vcpu_halted  [S] next->locked = 1
+		 *     MB                             MB
+		 * [L] node->locked             [RmW] node->state = vcpu_hashed
+		 *
+		 * Matches the cmpxchg() from pv_kick_node().
+		 */
+		smp_store_mb(node->state, vcpu_halted);
+
+		if (!READ_ONCE(node->locked)) {
+			lockevent_inc(pv_wait_node);
+			lockevent_cond_inc(pv_wait_early, wait_early);
+			pv_wait(&node->state, vcpu_halted);
+		}
+
+		/*
+		 * If pv_kick_node() changed us to vcpu_hashed, retain that
+		 * value so that pv_wait_head_or_lock() knows to not also try
+		 * to hash this lock.
+		 */
+		cmpxchg(&node->state, vcpu_halted, vcpu_running);
+
+		/*
+		 * If the locked flag is still not set after wakeup, it is a
+		 * spurious wakeup and the vCPU should wait again. However,
+		 * there is a pretty high overhead for CPU halting and kicking.
+		 * So it is better to spin for a while in the hope that the
+		 * MCS lock will be released soon.
+		 */
+		lockevent_cond_inc(pv_spurious_wakeup,
+				  !READ_ONCE(node->locked));
+	}
+
+	/*
+	 * By now our node->locked should be 1 and our caller will not actually
+	 * spin-wait for it. We do however rely on our caller to do a
+	 * load-acquire for us.
+	 */
+}
+
+/*
+ * Called after setting next->locked = 1 when we're the lock owner.
+ *
+ * Instead of waking the waiters stuck in pv_wait_node() advance their state
+ * such that they're waiting in pv_wait_head_or_lock(), this avoids a
+ * wake/sleep cycle.
+ */
+static void pv_kick_node(struct qspinlock *lock, struct qnode *node)
+{
+	/*
+	 * If the vCPU is indeed halted, advance its state to match that of
+	 * pv_wait_node(). If OTOH this fails, the vCPU was running and will
+	 * observe its next->locked value and advance itself.
+	 *
+	 * Matches with smp_store_mb() and cmpxchg() in pv_wait_node()
+	 *
+	 * The write to next->locked in arch_mcs_spin_unlock_contended()
+	 * must be ordered before the read of node->state in the cmpxchg()
+	 * below for the code to work correctly. To guarantee full ordering
+	 * irrespective of the success or failure of the cmpxchg(),
+	 * a relaxed version with explicit barrier is used. The control
+	 * dependency will order the reading of node->state before any
+	 * subsequent writes.
+	 */
+	smp_mb__before_atomic();
+	if (cmpxchg_relaxed(&node->state, vcpu_halted, vcpu_hashed)
+	    != vcpu_halted)
+		return;
+
+	/*
+	 * Put the lock into the hash table and set the _Q_SLOW_VAL.
+	 *
+	 * As this is the same vCPU that will check the _Q_SLOW_VAL value and
+	 * the hash table later on at unlock time, no atomic instruction is
+	 * needed.
+	 */
+	WRITE_ONCE(lock->locked, _Q_SLOW_VAL);
+	(void)pv_hash(lock, node);
+}
+
+/*
+ * Wait for l->locked to become clear and acquire the lock;
+ * halt the vcpu after a short spin.
+ * __pv_queued_spin_unlock() will wake us.
+ *
+ * The current value of the lock will be returned for additional processing.
+ */
+static u32
+pv_wait_head_or_lock(struct qspinlock *lock, struct qnode *node)
+{
+	struct qspinlock **lp = NULL;
+	int waitcnt = 0;
+	int loop;
+
+	/*
+	 * If pv_kick_node() already advanced our state, we don't need to
+	 * insert ourselves into the hash table anymore.
+	 */
+	if (READ_ONCE(node->state) == vcpu_hashed)
+		lp = (struct qspinlock **)1;
+
+	/*
+	 * Tracking # of slowpath locking operations
+	 */
+	lockevent_inc(lock_slowpath);
+
+	for (;; waitcnt++) {
+		/*
+		 * Set correct vCPU state to be used by queue node wait-early
+		 * mechanism.
+		 */
+		WRITE_ONCE(node->state, vcpu_running);
+
+		/*
+		 * Set the pending bit in the active lock spinning loop to
+		 * disable lock stealing before attempting to acquire the lock.
+		 */
+		set_pending(lock);
+		for (loop = SPIN_THRESHOLD; loop; loop--) {
+			if (trylock_clear_pending(lock))
+				goto gotlock;
+			cpu_relax();
+		}
+		clear_pending(lock);
+
+
+		if (!lp) { /* ONCE */
+			lp = pv_hash(lock, node);
+
+			/*
+			 * We must hash before setting _Q_SLOW_VAL, such that
+			 * when we observe _Q_SLOW_VAL in __pv_queued_spin_unlock()
+			 * we'll be sure to be able to observe our hash entry.
+			 *
+			 *   [S] <hash>                 [Rmw] l->locked == _Q_SLOW_VAL
+			 *       MB                           RMB
+			 * [RmW] l->locked = _Q_SLOW_VAL  [L] <unhash>
+			 *
+			 * Matches the smp_rmb() in __pv_queued_spin_unlock().
+			 */
+			if (xchg(&lock->locked, _Q_SLOW_VAL) == 0) {
+				/*
+				 * The lock was free and now we own the lock.
+				 * Change the lock value back to _Q_LOCKED_VAL
+				 * and unhash the table.
+				 */
+				WRITE_ONCE(lock->locked, _Q_LOCKED_VAL);
+				WRITE_ONCE(*lp, NULL);
+				goto gotlock;
+			}
+		}
+		WRITE_ONCE(node->state, vcpu_hashed);
+		lockevent_inc(pv_wait_head);
+		lockevent_cond_inc(pv_wait_again, waitcnt);
+		pv_wait(&lock->locked, _Q_SLOW_VAL);
+
+		/*
+		 * Because of lock stealing, the queue head vCPU may not be
+		 * able to acquire the lock before it has to wait again.
+		 */
+	}
+
+	/*
+	 * The cmpxchg() or xchg() call before coming here provides the
+	 * acquire semantics for locking. The dummy ORing of _Q_LOCKED_VAL
+	 * here is to indicate to the compiler that the value will always
+	 * be nozero to enable better code optimization.
+	 */
+gotlock:
+	return (u32)(atomic_read(&lock->val) | _Q_LOCKED_VAL);
+}
+
+/*
+ * PV versions of the unlock fastpath and slowpath functions to be used
+ * instead of queued_spin_unlock().
+ */
+__visible void
+__pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
+{
+	struct qnode *node;
+
+	if (unlikely(locked != _Q_SLOW_VAL)) {
+		WARN(!debug_locks_silent,
+		     "pvqspinlock: lock 0x%lx has corrupted value 0x%x!\n",
+		     (unsigned long)lock, atomic_read(&lock->val));
+		return;
+	}
+
+	/*
+	 * A failed cmpxchg doesn't provide any memory-ordering guarantees,
+	 * so we need a barrier to order the read of the node data in
+	 * pv_unhash *after* we've read the lock being _Q_SLOW_VAL.
+	 *
+	 * Matches the cmpxchg() in pv_wait_head_or_lock() setting _Q_SLOW_VAL.
+	 */
+	smp_rmb();
+
+	/*
+	 * Since the above failed to release, this must be the SLOW path.
+	 * Therefore start by looking up the blocked node and unhashing it.
+	 */
+	node = pv_unhash(lock);
+
+	/*
+	 * Now that we have a reference to the (likely) blocked qnode,
+	 * release the lock.
+	 */
+	smp_store_release(&lock->locked, 0);
+
+	/*
+	 * At this point the memory pointed at by lock can be freed/reused,
+	 * however we can still use the qnode to kick the CPU.
+	 * The other vCPU may not really be halted, but kicking an active
+	 * vCPU is harmless other than the additional latency in completing
+	 * the unlock.
+	 */
+	lockevent_inc(pv_kick_unlock);
+	pv_kick(node->cpu);
+}
+
+/*
+ * Include the architecture specific callee-save thunk of the
+ * __pv_queued_spin_unlock(). This thunk is put together with
+ * __pv_queued_spin_unlock() to make the callee-save thunk and the real unlock
+ * function close to each other sharing consecutive instruction cachelines.
+ * Alternatively, architecture specific version of __pv_queued_spin_unlock()
+ * can be defined.
+ */
+#include <asm/qspinlock_paravirt.h>
+
+#ifndef __pv_queued_spin_unlock
+__visible void __pv_queued_spin_unlock(struct qspinlock *lock)
+{
+	u8 locked;
+
+	/*
+	 * We must not unlock if SLOW, because in that case we must first
+	 * unhash. Otherwise it would be possible to have multiple @lock
+	 * entries, which would be BAD.
+	 */
+	locked = cmpxchg_release(&lock->locked, _Q_LOCKED_VAL, 0);
+	if (likely(locked == _Q_LOCKED_VAL))
+		return;
+
+	__pv_queued_spin_unlock_slowpath(lock, locked);
+}
+#endif
+
 #else /* CONFIG_PARAVIRT_SPINLOCKS */
 static __always_inline void pv_init_node(struct qnode *node) { }
 static __always_inline void pv_wait_node(struct qnode *node,
diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
deleted file mode 100644
index f1922e3a0f7d..000000000000
--- a/kernel/locking/qspinlock_paravirt.h
+++ /dev/null
@@ -1,490 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <linux/hash.h>
-#include <linux/memblock.h>
-#include <linux/debug_locks.h>
-
-/*
- * Implement paravirt qspinlocks; the general idea is to halt the vcpus instead
- * of spinning them.
- *
- * This relies on the architecture to provide two paravirt hypercalls:
- *
- *   pv_wait(u8 *ptr, u8 val) -- suspends the vcpu if *ptr == val
- *   pv_kick(cpu)             -- wakes a suspended vcpu
- *
- * Using these we implement __pv_queued_spin_lock_slowpath() and
- * __pv_queued_spin_unlock() to replace native_queued_spin_lock_slowpath() and
- * native_queued_spin_unlock().
- */
-
-#define _Q_SLOW_VAL	(3U << _Q_LOCKED_OFFSET)
-
-/*
- * Queue Node Adaptive Spinning
- *
- * A queue node vCPU will stop spinning if the vCPU in the previous node is
- * not running. The one lock stealing attempt allowed at slowpath entry
- * mitigates the slight slowdown for non-overcommitted guest with this
- * aggressive wait-early mechanism.
- *
- * The status of the previous node will be checked at fixed interval
- * controlled by PV_PREV_CHECK_MASK. This is to ensure that we won't
- * pound on the cacheline of the previous node too heavily.
- */
-#define PV_PREV_CHECK_MASK	0xff
-
-/*
- * Queue node uses: vcpu_running & vcpu_halted.
- * Queue head uses: vcpu_running & vcpu_hashed.
- */
-enum vcpu_state {
-	vcpu_running = 0,
-	vcpu_halted,		/* Used only in pv_wait_node */
-	vcpu_hashed,		/* = pv_hash'ed + vcpu_halted */
-};
-
-/*
- * Hybrid PV queued/unfair lock
- *
- * This function is called once when a lock waiter enters the PV slowpath
- * before being queued.
- *
- * The pending bit is set by the queue head vCPU of the MCS wait queue in
- * pv_wait_head_or_lock() to signal that it is ready to spin on the lock.
- * When that bit becomes visible to the incoming waiters, no lock stealing
- * is allowed. The function will return immediately to make the waiters
- * enter the MCS wait queue. So lock starvation shouldn't happen as long
- * as the queued mode vCPUs are actively running to set the pending bit
- * and hence disabling lock stealing.
- *
- * When the pending bit isn't set, the lock waiters will stay in the unfair
- * mode spinning on the lock unless the MCS wait queue is empty. In this
- * case, the lock waiters will enter the queued mode slowpath trying to
- * become the queue head and set the pending bit.
- *
- * This hybrid PV queued/unfair lock combines the best attributes of a
- * queued lock (no lock starvation) and an unfair lock (good performance
- * on not heavily contended locks).
- */
-static inline bool pv_hybrid_queued_unfair_trylock(struct qspinlock *lock)
-{
-	/*
-	 * Stay in unfair lock mode as long as queued mode waiters are
-	 * present in the MCS wait queue but the pending bit isn't set.
-	 */
-	for (;;) {
-		int val = atomic_read(&lock->val);
-
-		if (!(val & _Q_LOCKED_PENDING_MASK) &&
-		   (cmpxchg_acquire(&lock->locked, 0, _Q_LOCKED_VAL) == 0)) {
-			lockevent_inc(pv_lock_stealing);
-			return true;
-		}
-		if (!(val & _Q_TAIL_MASK) || (val & _Q_PENDING_MASK))
-			break;
-
-		cpu_relax();
-	}
-
-	return false;
-}
-
-/*
- * Lock and MCS node addresses hash table for fast lookup
- *
- * Hashing is done on a per-cacheline basis to minimize the need to access
- * more than one cacheline.
- *
- * Dynamically allocate a hash table big enough to hold at least 4X the
- * number of possible cpus in the system. Allocation is done on page
- * granularity. So the minimum number of hash buckets should be at least
- * 256 (64-bit) or 512 (32-bit) to fully utilize a 4k page.
- *
- * Since we should not be holding locks from NMI context (very rare indeed) the
- * max load factor is 0.75, which is around the point where open addressing
- * breaks down.
- *
- */
-struct pv_hash_entry {
-	struct qspinlock *lock;
-	struct qnode   *node;
-};
-
-#define PV_HE_PER_LINE	(SMP_CACHE_BYTES / sizeof(struct pv_hash_entry))
-#define PV_HE_MIN	(PAGE_SIZE / sizeof(struct pv_hash_entry))
-
-static struct pv_hash_entry *pv_lock_hash;
-static unsigned int pv_lock_hash_bits __read_mostly;
-
-/*
- * Allocate memory for the PV qspinlock hash buckets
- *
- * This function should be called from the paravirt spinlock initialization
- * routine.
- */
-void __init __pv_init_lock_hash(void)
-{
-	int pv_hash_size = ALIGN(4 * num_possible_cpus(), PV_HE_PER_LINE);
-
-	if (pv_hash_size < PV_HE_MIN)
-		pv_hash_size = PV_HE_MIN;
-
-	/*
-	 * Allocate space from bootmem which should be page-size aligned
-	 * and hence cacheline aligned.
-	 */
-	pv_lock_hash = alloc_large_system_hash("PV qspinlock",
-					       sizeof(struct pv_hash_entry),
-					       pv_hash_size, 0,
-					       HASH_EARLY | HASH_ZERO,
-					       &pv_lock_hash_bits, NULL,
-					       pv_hash_size, pv_hash_size);
-}
-
-#define for_each_hash_entry(he, offset, hash)						\
-	for (hash &= ~(PV_HE_PER_LINE - 1), he = &pv_lock_hash[hash], offset = 0;	\
-	     offset < (1 << pv_lock_hash_bits);						\
-	     offset++, he = &pv_lock_hash[(hash + offset) & ((1 << pv_lock_hash_bits) - 1)])
-
-static struct qspinlock **pv_hash(struct qspinlock *lock, struct qnode *node)
-{
-	unsigned long offset, hash = hash_ptr(lock, pv_lock_hash_bits);
-	struct pv_hash_entry *he;
-	int hopcnt = 0;
-
-	for_each_hash_entry(he, offset, hash) {
-		hopcnt++;
-		if (!cmpxchg(&he->lock, NULL, lock)) {
-			WRITE_ONCE(he->node, node);
-			lockevent_pv_hop(hopcnt);
-			return &he->lock;
-		}
-	}
-	/*
-	 * Hard assume there is a free entry for us.
-	 *
-	 * This is guaranteed by ensuring every blocked lock only ever consumes
-	 * a single entry, and since we only have 4 nesting levels per CPU
-	 * and allocated 4*nr_possible_cpus(), this must be so.
-	 *
-	 * The single entry is guaranteed by having the lock owner unhash
-	 * before it releases.
-	 */
-	BUG();
-}
-
-static struct qnode *pv_unhash(struct qspinlock *lock)
-{
-	unsigned long offset, hash = hash_ptr(lock, pv_lock_hash_bits);
-	struct pv_hash_entry *he;
-	struct qnode *node;
-
-	for_each_hash_entry(he, offset, hash) {
-		if (READ_ONCE(he->lock) == lock) {
-			node = READ_ONCE(he->node);
-			WRITE_ONCE(he->lock, NULL);
-			return node;
-		}
-	}
-	/*
-	 * Hard assume we'll find an entry.
-	 *
-	 * This guarantees a limited lookup time and is itself guaranteed by
-	 * having the lock owner do the unhash -- IFF the unlock sees the
-	 * SLOW flag, there MUST be a hash entry.
-	 */
-	BUG();
-}
-
-/*
- * Return true if when it is time to check the previous node which is not
- * in a running state.
- */
-static inline bool
-pv_wait_early(struct qnode *prev, int loop)
-{
-	if ((loop & PV_PREV_CHECK_MASK) != 0)
-		return false;
-
-	return READ_ONCE(prev->state) != vcpu_running;
-}
-
-/*
- * Initialize the PV part of the qnode.
- */
-static void pv_init_node(struct qnode *node)
-{
-	node->cpu = smp_processor_id();
-	node->state = vcpu_running;
-}
-
-/*
- * Wait for node->locked to become true, halt the vcpu after a short spin.
- * pv_kick_node() is used to set _Q_SLOW_VAL and fill in hash table on its
- * behalf.
- */
-static void pv_wait_node(struct qnode *node, struct qnode *prev)
-{
-	int loop;
-	bool wait_early;
-
-	for (;;) {
-		for (wait_early = false, loop = SPIN_THRESHOLD; loop; loop--) {
-			if (READ_ONCE(node->locked))
-				return;
-			if (pv_wait_early(prev, loop)) {
-				wait_early = true;
-				break;
-			}
-			cpu_relax();
-		}
-
-		/*
-		 * Order node->state vs node->locked thusly:
-		 *
-		 * [S] node->state = vcpu_halted  [S] next->locked = 1
-		 *     MB                             MB
-		 * [L] node->locked             [RmW] node->state = vcpu_hashed
-		 *
-		 * Matches the cmpxchg() from pv_kick_node().
-		 */
-		smp_store_mb(node->state, vcpu_halted);
-
-		if (!READ_ONCE(node->locked)) {
-			lockevent_inc(pv_wait_node);
-			lockevent_cond_inc(pv_wait_early, wait_early);
-			pv_wait(&node->state, vcpu_halted);
-		}
-
-		/*
-		 * If pv_kick_node() changed us to vcpu_hashed, retain that
-		 * value so that pv_wait_head_or_lock() knows to not also try
-		 * to hash this lock.
-		 */
-		cmpxchg(&node->state, vcpu_halted, vcpu_running);
-
-		/*
-		 * If the locked flag is still not set after wakeup, it is a
-		 * spurious wakeup and the vCPU should wait again. However,
-		 * there is a pretty high overhead for CPU halting and kicking.
-		 * So it is better to spin for a while in the hope that the
-		 * MCS lock will be released soon.
-		 */
-		lockevent_cond_inc(pv_spurious_wakeup,
-				  !READ_ONCE(node->locked));
-	}
-
-	/*
-	 * By now our node->locked should be 1 and our caller will not actually
-	 * spin-wait for it. We do however rely on our caller to do a
-	 * load-acquire for us.
-	 */
-}
-
-/*
- * Called after setting next->locked = 1 when we're the lock owner.
- *
- * Instead of waking the waiters stuck in pv_wait_node() advance their state
- * such that they're waiting in pv_wait_head_or_lock(), this avoids a
- * wake/sleep cycle.
- */
-static void pv_kick_node(struct qspinlock *lock, struct qnode *node)
-{
-	/*
-	 * If the vCPU is indeed halted, advance its state to match that of
-	 * pv_wait_node(). If OTOH this fails, the vCPU was running and will
-	 * observe its next->locked value and advance itself.
-	 *
-	 * Matches with smp_store_mb() and cmpxchg() in pv_wait_node()
-	 *
-	 * The write to next->locked in arch_mcs_spin_unlock_contended()
-	 * must be ordered before the read of node->state in the cmpxchg()
-	 * below for the code to work correctly. To guarantee full ordering
-	 * irrespective of the success or failure of the cmpxchg(),
-	 * a relaxed version with explicit barrier is used. The control
-	 * dependency will order the reading of node->state before any
-	 * subsequent writes.
-	 */
-	smp_mb__before_atomic();
-	if (cmpxchg_relaxed(&node->state, vcpu_halted, vcpu_hashed)
-	    != vcpu_halted)
-		return;
-
-	/*
-	 * Put the lock into the hash table and set the _Q_SLOW_VAL.
-	 *
-	 * As this is the same vCPU that will check the _Q_SLOW_VAL value and
-	 * the hash table later on at unlock time, no atomic instruction is
-	 * needed.
-	 */
-	WRITE_ONCE(lock->locked, _Q_SLOW_VAL);
-	(void)pv_hash(lock, node);
-}
-
-/*
- * Wait for l->locked to become clear and acquire the lock;
- * halt the vcpu after a short spin.
- * __pv_queued_spin_unlock() will wake us.
- *
- * The current value of the lock will be returned for additional processing.
- */
-static u32
-pv_wait_head_or_lock(struct qspinlock *lock, struct qnode *node)
-{
-	struct qspinlock **lp = NULL;
-	int waitcnt = 0;
-	int loop;
-
-	/*
-	 * If pv_kick_node() already advanced our state, we don't need to
-	 * insert ourselves into the hash table anymore.
-	 */
-	if (READ_ONCE(node->state) == vcpu_hashed)
-		lp = (struct qspinlock **)1;
-
-	/*
-	 * Tracking # of slowpath locking operations
-	 */
-	lockevent_inc(lock_slowpath);
-
-	for (;; waitcnt++) {
-		/*
-		 * Set correct vCPU state to be used by queue node wait-early
-		 * mechanism.
-		 */
-		WRITE_ONCE(node->state, vcpu_running);
-
-		/*
-		 * Set the pending bit in the active lock spinning loop to
-		 * disable lock stealing before attempting to acquire the lock.
-		 */
-		set_pending(lock);
-		for (loop = SPIN_THRESHOLD; loop; loop--) {
-			if (trylock_clear_pending(lock))
-				goto gotlock;
-			cpu_relax();
-		}
-		clear_pending(lock);
-
-
-		if (!lp) { /* ONCE */
-			lp = pv_hash(lock, node);
-
-			/*
-			 * We must hash before setting _Q_SLOW_VAL, such that
-			 * when we observe _Q_SLOW_VAL in __pv_queued_spin_unlock()
-			 * we'll be sure to be able to observe our hash entry.
-			 *
-			 *   [S] <hash>                 [Rmw] l->locked == _Q_SLOW_VAL
-			 *       MB                           RMB
-			 * [RmW] l->locked = _Q_SLOW_VAL  [L] <unhash>
-			 *
-			 * Matches the smp_rmb() in __pv_queued_spin_unlock().
-			 */
-			if (xchg(&lock->locked, _Q_SLOW_VAL) == 0) {
-				/*
-				 * The lock was free and now we own the lock.
-				 * Change the lock value back to _Q_LOCKED_VAL
-				 * and unhash the table.
-				 */
-				WRITE_ONCE(lock->locked, _Q_LOCKED_VAL);
-				WRITE_ONCE(*lp, NULL);
-				goto gotlock;
-			}
-		}
-		WRITE_ONCE(node->state, vcpu_hashed);
-		lockevent_inc(pv_wait_head);
-		lockevent_cond_inc(pv_wait_again, waitcnt);
-		pv_wait(&lock->locked, _Q_SLOW_VAL);
-
-		/*
-		 * Because of lock stealing, the queue head vCPU may not be
-		 * able to acquire the lock before it has to wait again.
-		 */
-	}
-
-	/*
-	 * The cmpxchg() or xchg() call before coming here provides the
-	 * acquire semantics for locking. The dummy ORing of _Q_LOCKED_VAL
-	 * here is to indicate to the compiler that the value will always
-	 * be nozero to enable better code optimization.
-	 */
-gotlock:
-	return (u32)(atomic_read(&lock->val) | _Q_LOCKED_VAL);
-}
-
-/*
- * PV versions of the unlock fastpath and slowpath functions to be used
- * instead of queued_spin_unlock().
- */
-__visible void
-__pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
-{
-	struct qnode *node;
-
-	if (unlikely(locked != _Q_SLOW_VAL)) {
-		WARN(!debug_locks_silent,
-		     "pvqspinlock: lock 0x%lx has corrupted value 0x%x!\n",
-		     (unsigned long)lock, atomic_read(&lock->val));
-		return;
-	}
-
-	/*
-	 * A failed cmpxchg doesn't provide any memory-ordering guarantees,
-	 * so we need a barrier to order the read of the node data in
-	 * pv_unhash *after* we've read the lock being _Q_SLOW_VAL.
-	 *
-	 * Matches the cmpxchg() in pv_wait_head_or_lock() setting _Q_SLOW_VAL.
-	 */
-	smp_rmb();
-
-	/*
-	 * Since the above failed to release, this must be the SLOW path.
-	 * Therefore start by looking up the blocked node and unhashing it.
-	 */
-	node = pv_unhash(lock);
-
-	/*
-	 * Now that we have a reference to the (likely) blocked qnode,
-	 * release the lock.
-	 */
-	smp_store_release(&lock->locked, 0);
-
-	/*
-	 * At this point the memory pointed at by lock can be freed/reused,
-	 * however we can still use the qnode to kick the CPU.
-	 * The other vCPU may not really be halted, but kicking an active
-	 * vCPU is harmless other than the additional latency in completing
-	 * the unlock.
-	 */
-	lockevent_inc(pv_kick_unlock);
-	pv_kick(node->cpu);
-}
-
-/*
- * Include the architecture specific callee-save thunk of the
- * __pv_queued_spin_unlock(). This thunk is put together with
- * __pv_queued_spin_unlock() to make the callee-save thunk and the real unlock
- * function close to each other sharing consecutive instruction cachelines.
- * Alternatively, architecture specific version of __pv_queued_spin_unlock()
- * can be defined.
- */
-#include <asm/qspinlock_paravirt.h>
-
-#ifndef __pv_queued_spin_unlock
-__visible void __pv_queued_spin_unlock(struct qspinlock *lock)
-{
-	u8 locked;
-
-	/*
-	 * We must not unlock if SLOW, because in that case we must first
-	 * unhash. Otherwise it would be possible to have multiple @lock
-	 * entries, which would be BAD.
-	 */
-	locked = cmpxchg_release(&lock->locked, _Q_LOCKED_VAL, 0);
-	if (likely(locked == _Q_LOCKED_VAL))
-		return;
-
-	__pv_queued_spin_unlock_slowpath(lock, locked);
-}
-#endif /* __pv_queued_spin_unlock */
-- 
2.35.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1EA5658D1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbiGDOkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbiGDOjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:39:24 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A987DF80
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:39:16 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o31-20020a17090a0a2200b001ef7bd037bbso4500482pjo.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 07:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jFQES6MzxIEnn6pHmTEvGwQZiT4CpKtMxO5c3rFPXa8=;
        b=AX273GvMt9xAf208ZIqoMvp+Kbema18tuZkWCr+YL6wSVcdjkFVC3ZMVhIH9dZjBIb
         rAHTYLyFAkuUzTz48SBcxWusHWNeVav/bO4CvMcREaJxmpn+9ZUmGcQOuyZP3X4XpqPO
         NgdKgVr7aglmmERiB1ypzzqrFrwOnmnnYKVjby9//9yMC1YmAWWYcmgc7Sy88kv8viMv
         vnQL5mWx0MzXkSuG/Z1azCJSlFynUb8z4egBRwdPyjkr+Kr9M3ErhbTFD/vldG4RM0JX
         agTHks697JUgF2r5e+CQDPhsaHk7/StgIW6nHTXAGqfF/t9e1rFbePhUcbu1l2DGRBj2
         IJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jFQES6MzxIEnn6pHmTEvGwQZiT4CpKtMxO5c3rFPXa8=;
        b=RwUcOL0Q/AY0HFTNus7ihGgipYQ1uHoYx/tWKZhyOnrpnAtJdLnwySP+psLfSumX7O
         Iz9rt0LyPtT6oSoCFOpRbf8Np/m/lPzJAGqdLuzry9oBhxMbid4BESktjIywWQw3LUUO
         xcozlQg3Ghzn8lp7VXC+SRkvDGZT2ak+bwYlPToXp1lDJA510Mn9uzt3u9/f5TieIin7
         VVqm5qAH8bNxYsrDXct+fTkvtmdl5nkJlt0Wxx7poyTWW2HaAV55bZcnbifklG745yr3
         W8JMJCkg58tgMfZQ1xteS6KROOJfp4LZ5Vbz76fHBqlRRf2ycFMAwGG5vGLTD3w6x77w
         fdLg==
X-Gm-Message-State: AJIora8+qLSK0wQlvNCEEdTgeToLT7qKe9eoHacT3c8HzGtOjDO4CVg3
        4alQuIQ7GajQUek/f50tzlU=
X-Google-Smtp-Source: AGRyM1uIrnAlF+1lfBP5W4tioNYEYP0f/J2LJDXc6zLr8CjOGkw8OeajkVXek2Drj1iEZQWFE5ZMmw==
X-Received: by 2002:a17:903:18e:b0:16a:5f55:c4e with SMTP id z14-20020a170903018e00b0016a5f550c4emr35786598plg.33.1656945556142;
        Mon, 04 Jul 2022 07:39:16 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com ([203.221.247.188])
        by smtp.gmail.com with ESMTPSA id u13-20020a63454d000000b0040d2224ae04sm20534365pgk.76.2022.07.04.07.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 07:39:15 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] locking/qspinlock: simplify pv_wait_head_or_lock calling scheme
Date:   Tue,  5 Jul 2022 00:38:20 +1000
Message-Id: <20220704143820.3071004-14-npiggin@gmail.com>
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

pv_wait_head_or_lock returns the lock word value ORed with a constant,
which was done to achieve a constant folding compiler optimisation
when the code was generated for both pv and !pv cases. This is no
longer necessary with the explicit paravirt test, so make the calling
convention simpler.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/locking/qspinlock.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 19e2f286be0a..97f95bedfa66 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -609,8 +609,7 @@ static void pv_kick_node(struct qspinlock *lock, struct qnode *node)
  *
  * The current value of the lock will be returned for additional processing.
  */
-static u32
-pv_wait_head_or_lock(struct qspinlock *lock, struct qnode *node)
+static void pv_wait_head_or_lock(struct qspinlock *lock, struct qnode *node)
 {
 	struct qspinlock **lp = NULL;
 	int waitcnt = 0;
@@ -642,7 +641,7 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct qnode *node)
 		set_pending(lock);
 		for (loop = SPIN_THRESHOLD; loop; loop--) {
 			if (trylock_clear_pending(lock))
-				goto gotlock;
+				return; /* got lock */
 			cpu_relax();
 		}
 		clear_pending(lock);
@@ -670,7 +669,7 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct qnode *node)
 				 */
 				WRITE_ONCE(lock->locked, _Q_LOCKED_VAL);
 				WRITE_ONCE(*lp, NULL);
-				goto gotlock;
+				return; /* got lock */
 			}
 		}
 		WRITE_ONCE(node->state, vcpu_hashed);
@@ -686,12 +685,8 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct qnode *node)
 
 	/*
 	 * The cmpxchg() or xchg() call before coming here provides the
-	 * acquire semantics for locking. The dummy ORing of _Q_LOCKED_VAL
-	 * here is to indicate to the compiler that the value will always
-	 * be nozero to enable better code optimization.
+	 * acquire semantics for locking.
 	 */
-gotlock:
-	return (u32)(atomic_read(&lock->val) | _Q_LOCKED_VAL);
 }
 
 /*
@@ -767,9 +762,8 @@ static __always_inline void pv_wait_node(struct qnode *node,
 					 struct qnode *prev) { }
 static __always_inline void pv_kick_node(struct qspinlock *lock,
 					 struct qnode *node) { }
-static __always_inline u32  pv_wait_head_or_lock(struct qspinlock *lock,
-						 struct qnode *node)
-						   { return 0; }
+static __always_inline void pv_wait_head_or_lock(struct qspinlock *lock,
+						 struct qnode *node) { }
 static __always_inline bool pv_hybrid_queued_unfair_trylock(struct qspinlock *lock) { BUILD_BUG(); }
 #endif /* CONFIG_PARAVIRT_SPINLOCKS */
 
@@ -890,24 +884,23 @@ static inline void queued_spin_lock_mcs_queue(struct qspinlock *lock, bool parav
 	 * sequentiality; this is because the set_locked() function below
 	 * does not imply a full barrier.
 	 *
-	 * The PV pv_wait_head_or_lock function, if active, will acquire
-	 * the lock and return a non-zero value. So we have to skip the
-	 * atomic_cond_read_acquire() call. As the next PV queue head hasn't
-	 * been designated yet, there is no way for the locked value to become
-	 * _Q_SLOW_VAL. So both the set_locked() and the
+	 * The PV pv_wait_head_or_lock function will acquire the lock, so
+	 * skip the atomic_cond_read_acquire() call. As the next PV queue head
+	 * hasn't been designated yet, there is no way for the locked value to
+	 * become _Q_SLOW_VAL. So both the set_locked() and the
 	 * atomic_cmpxchg_relaxed() calls will be safe.
 	 *
 	 * If PV isn't active, 0 will be returned instead.
 	 *
 	 */
 	if (paravirt) {
-		if ((val = pv_wait_head_or_lock(lock, node)))
-			goto locked;
+		pv_wait_head_or_lock(lock, node);
+		val = atomic_read(&lock->val);
+	} else {
+		val = atomic_cond_read_acquire(&lock->val,
+				!(VAL & _Q_LOCKED_PENDING_MASK));
 	}
 
-	val = atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK));
-
-locked:
 	/*
 	 * claim the lock:
 	 *
-- 
2.35.1


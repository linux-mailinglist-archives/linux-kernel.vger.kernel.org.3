Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE20572ECF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbiGMHIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbiGMHIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:08:17 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39FBE3040
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:07:57 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id bh13so9676972pgb.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KnPsdcwpQ6/HQ7udB+nfFkQyTndFGEtXQDYIXdw9bEk=;
        b=PLK7bYe85Cz+0uz8atHvvMpo9qGTWHUXGvGGlyMJo31WZFkqhtWTOXNSWXKjq6Ce2/
         vQ3OrCVv1GKVRnMViqSVhjttJnmif33+dTNDBjOmiWvjzmNhwkRejjtg9IW4mXhH50kT
         KXSoX8XBgZhvu1eJu25dbPck28ETryRCX1GICM2cLjG53X7Hmd1dpaae3065E9AFt0J2
         egCs5Uxfxngncyv1GmD4bset3emzypyEHATQyZQPHLmRpf1PC8MyJae3BbsvLELPrkLr
         X0I0mOxPH9OwNeTO3QY327VjgphadnVM2Au2cFu2L9xgLDzk2d4ntbRZb6cCVKc9kBIg
         9oEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KnPsdcwpQ6/HQ7udB+nfFkQyTndFGEtXQDYIXdw9bEk=;
        b=cAFmDDcFxErvfNavi5XFkhXtMvG7wZ8J/hHMGvZuGI0LcgU5YeUsvEWNhkErZhmkVc
         igSpdoGPwuMztnyJw2SCur89YjfdDOcEeqjp7gQYjXkjjxLqFpSHvFfHvkZjEnMRSlU8
         tDKLByt8gH+6+rAoZmwHB+O3a+7ppE6G9ma3A97yrHYHDXuLeU/JcDDy70PUe5uRB2LA
         YpAEzIWd5p0QhOQD5VmeTZt7C9Uw2k4aZf2a3E0F6XVBU6GN3iE6JgtDpv3mQUCvZ62v
         8FMzcZEWH9s2Pv6FoWnAgnE9bLggOkrzLU7hFZ2BabGhwermJzpO2fC49gQfnN8QVmOj
         eeUg==
X-Gm-Message-State: AJIora+h1pIWanhOjBzk3HhJA7RJzGK3Z5AMH2R134IhWP7ihdXqiSlX
        uMB9OIRC6h0NUJGr09Jrx0w=
X-Google-Smtp-Source: AGRyM1v85scKwcrTA7w9VhbsWNy4SnwwYrtxNZ9GzmAAXjSEmP85SYKD7FToZencVhaEeh+MLZPKdA==
X-Received: by 2002:a63:d341:0:b0:412:ace8:b0ed with SMTP id u1-20020a63d341000000b00412ace8b0edmr1770283pgi.169.1657696077187;
        Wed, 13 Jul 2022 00:07:57 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (193-116-203-247.tpgi.com.au. [193.116.203.247])
        by smtp.gmail.com with ESMTPSA id d11-20020a170902cecb00b0016bd5da20casm8099061plg.134.2022.07.13.00.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 00:07:56 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 12/12] locking/qspinlock: simplify pv_wait_head_or_lock calling scheme
Date:   Wed, 13 Jul 2022 17:07:04 +1000
Message-Id: <20220713070704.308394-13-npiggin@gmail.com>
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
index 3255e7804842..251980783079 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -608,8 +608,7 @@ static void pv_kick_node(struct qspinlock *lock, struct qnode *node)
  *
  * The current value of the lock will be returned for additional processing.
  */
-static u32
-pv_wait_head_or_lock(struct qspinlock *lock, struct qnode *node)
+static void pv_wait_head_or_lock(struct qspinlock *lock, struct qnode *node)
 {
 	struct qspinlock **lp = NULL;
 	int waitcnt = 0;
@@ -641,7 +640,7 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct qnode *node)
 		set_pending(lock);
 		for (loop = SPIN_THRESHOLD; loop; loop--) {
 			if (trylock_clear_pending(lock))
-				goto gotlock;
+				return; /* got lock */
 			cpu_relax();
 		}
 		clear_pending(lock);
@@ -669,7 +668,7 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct qnode *node)
 				 */
 				WRITE_ONCE(lock->locked, _Q_LOCKED_VAL);
 				WRITE_ONCE(*lp, NULL);
-				goto gotlock;
+				return; /* got lock */
 			}
 		}
 		WRITE_ONCE(node->state, vcpu_hashed);
@@ -685,12 +684,8 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct qnode *node)
 
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
@@ -766,9 +761,8 @@ static __always_inline void pv_wait_node_acquire(struct qnode *node,
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
 
@@ -889,24 +883,23 @@ static __always_inline void queued_spin_lock_mcs_queue(struct qspinlock *lock, b
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


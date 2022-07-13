Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F343572EC7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbiGMHH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbiGMHHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:07:38 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8372BF552
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:07:31 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so2121850pjf.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P/55yRVKMzcZl/sxLnf9XPYi5esP6NCSmAVTv603IGU=;
        b=drjTDyKdCjLycUT+Rt1sWIyeHzUOG/WJ4uut6Ul7s2rbwdf0MoFexnxUC5xBybIuWe
         Sb8dhzZ1Dv+sAqD/LqnrIbONlpnP2+o4yMtuDa3YkTnEIyVgk0zXdIH8etmSTXW8GUiG
         dIHTHgNcUBgxIxdSPs0DyiTyzEpTSALxN7lMeKVGaYt7dC81imfG5Imqy7QuVgiPUwYS
         N+t2aHoJzTwy29SKwA3Tb2mvzaM6+CnLmhQZiZIMhVvUMTKd14/H4AoAwqmyFC1xmSD8
         LJGO83vPdCLPYLlVEY0EpotV6T41IttYy2pDcD/9oA09a4Sz8dR6fJpAHNH7f9PS4wcx
         ugug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P/55yRVKMzcZl/sxLnf9XPYi5esP6NCSmAVTv603IGU=;
        b=vblzXBa1UGDXkGZLK0Z74lsQrnucKYtutTv5Rukfa+5eG6KO9jxN3ETDdazc57ycR1
         tvbVxZTY0yyOIAwOKuIRAR1m4KAUnMz7YAHF4aiRLJE7MRj1B3+x/d05mMGa1eOKJjzk
         rWIVDENXj95TA6z9QCgFx8d1isjhry4ldGfdO1TPmHYZbakAMOeV/mw1ygVVshT/B+sB
         1Aq4L3h+ASn9ZcXLxJot49tss97VQSoLXnJ7pi/88dzm0Ap+z1FZALJpT/lo/rms9boA
         6zgBykG1ZbPBUDcdMryJainG+sNiAc4vKBWzIPMPCTvFC6zxNhz0QAN89L7cs2A1oUt/
         bO7Q==
X-Gm-Message-State: AJIora/rigiGv9mWISmoUECdxvBGYhqj7e7C+FrrtIifqImjNE/+Kc3s
        K2hTr8jd0mfk7hsTsZDW9Gs=
X-Google-Smtp-Source: AGRyM1vV/vP4cCrjQCnEbXlugcs1RH3z7KsgGgtG9MXcwKr9JUuIRd0zLPPvIAg97NdlTiTbUVQF+g==
X-Received: by 2002:a17:902:ba91:b0:16c:6b8e:cd06 with SMTP id k17-20020a170902ba9100b0016c6b8ecd06mr1856753pls.33.1657696050936;
        Wed, 13 Jul 2022 00:07:30 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (193-116-203-247.tpgi.com.au. [193.116.203.247])
        by smtp.gmail.com with ESMTPSA id d11-20020a170902cecb00b0016bd5da20casm8099061plg.134.2022.07.13.00.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 00:07:30 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 05/12] locking/qspinlock: be less clever with the preprocessor
Date:   Wed, 13 Jul 2022 17:06:57 +1000
Message-Id: <20220713070704.308394-6-npiggin@gmail.com>
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

Stop qspinlock.c including itself and avoid most of the function
renaming with the preprocessor.

This is mostly done by having the common slowpath code take a 'bool
paravirt' argument and adjusting code based on that. __always_inline
ensures the paravirt and non-paravirt cases are kept separate and
the compiler can constant-fold the 'paravirt' tests.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/locking/qspinlock.c          | 116 ++++++++++++----------------
 kernel/locking/qspinlock_paravirt.h |  10 +--
 2 files changed, 52 insertions(+), 74 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 95bf24d276c3..037bd5440cfd 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -11,8 +11,6 @@
  *          Peter Zijlstra <peterz@infradead.org>
  */
 
-#ifndef _GEN_PV_LOCK_SLOWPATH
-
 #include <linux/smp.h>
 #include <linux/bug.h>
 #include <linux/cpumask.h>
@@ -287,35 +285,21 @@ static __always_inline void set_locked(struct qspinlock *lock)
 	WRITE_ONCE(lock->locked, _Q_LOCKED_VAL);
 }
 
-
-/*
- * Generate the native code for queued_spin_unlock_slowpath(); provide NOPs for
- * all the PV callbacks.
- */
-
-static __always_inline void __pv_init_node(struct qnode *node) { }
-static __always_inline void __pv_wait_node(struct qnode *node,
-					   struct qnode *prev) { }
-static __always_inline void __pv_kick_node(struct qspinlock *lock,
-					   struct qnode *node) { }
-static __always_inline u32  __pv_wait_head_or_lock(struct qspinlock *lock,
-						   struct qnode *node)
-						   { return 0; }
-
-#define pv_enabled()		false
-
-#define pv_init_node		__pv_init_node
-#define pv_wait_node		__pv_wait_node
-#define pv_kick_node		__pv_kick_node
-#define pv_wait_head_or_lock	__pv_wait_head_or_lock
-
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
-#define queued_spin_lock_slowpath	native_queued_spin_lock_slowpath
-#endif
-
-#endif /* _GEN_PV_LOCK_SLOWPATH */
+#include "qspinlock_paravirt.h"
+#else /* CONFIG_PARAVIRT_SPINLOCKS */
+static __always_inline void pv_init_node(struct qnode *node) { }
+static __always_inline void pv_wait_node(struct qnode *node,
+					 struct qnode *prev) { }
+static __always_inline void pv_kick_node(struct qspinlock *lock,
+					 struct qnode *node) { }
+static __always_inline u32  pv_wait_head_or_lock(struct qspinlock *lock,
+						 struct qnode *node)
+						   { return 0; }
+static __always_inline bool pv_hybrid_queued_unfair_trylock(struct qspinlock *lock) { BUILD_BUG(); }
+#endif /* CONFIG_PARAVIRT_SPINLOCKS */
 
-static inline void queued_spin_lock_mcs_queue(struct qspinlock *lock)
+static __always_inline void queued_spin_lock_mcs_queue(struct qspinlock *lock, bool paravirt)
 {
 	struct qnode *prev, *next, *node;
 	u32 val, old, tail;
@@ -340,8 +324,13 @@ static inline void queued_spin_lock_mcs_queue(struct qspinlock *lock)
 	 */
 	if (unlikely(idx >= MAX_NODES)) {
 		lockevent_inc(lock_no_node);
-		while (!queued_spin_trylock(lock))
-			cpu_relax();
+		if (paravirt) {
+			while (!pv_hybrid_queued_unfair_trylock(lock))
+				cpu_relax();
+		} else {
+			while (!queued_spin_trylock(lock))
+				cpu_relax();
+		}
 		goto release;
 	}
 
@@ -361,15 +350,21 @@ static inline void queued_spin_lock_mcs_queue(struct qspinlock *lock)
 
 	node->locked = 0;
 	node->next = NULL;
-	pv_init_node(node);
+	if (paravirt)
+		pv_init_node(node);
 
 	/*
 	 * We touched a (possibly) cold cacheline in the per-cpu queue node;
 	 * attempt the trylock once more in the hope someone let go while we
 	 * weren't watching.
 	 */
-	if (queued_spin_trylock(lock))
-		goto release;
+	if (paravirt) {
+		if (pv_hybrid_queued_unfair_trylock(lock))
+			goto release;
+	} else {
+		if (queued_spin_trylock(lock))
+			goto release;
+	}
 
 	/*
 	 * Ensure that the initialisation of @node is complete before we
@@ -398,7 +393,8 @@ static inline void queued_spin_lock_mcs_queue(struct qspinlock *lock)
 		/* Link @node into the waitqueue. */
 		WRITE_ONCE(prev->next, node);
 
-		pv_wait_node(node, prev);
+		if (paravirt)
+			pv_wait_node(node, prev);
 		/* Wait for mcs node lock to be released */
 		smp_cond_load_acquire(&node->locked, VAL);
 
@@ -434,8 +430,10 @@ static inline void queued_spin_lock_mcs_queue(struct qspinlock *lock)
 	 * If PV isn't active, 0 will be returned instead.
 	 *
 	 */
-	if ((val = pv_wait_head_or_lock(lock, node)))
-		goto locked;
+	if (paravirt) {
+		if ((val = pv_wait_head_or_lock(lock, node)))
+			goto locked;
+	}
 
 	val = atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK));
 
@@ -480,7 +478,8 @@ static inline void queued_spin_lock_mcs_queue(struct qspinlock *lock)
 		next = smp_cond_load_relaxed(&node->next, (VAL));
 
 	smp_store_release(&next->locked, 1); /* unlock the mcs node lock */
-	pv_kick_node(lock, next);
+	if (paravirt)
+		pv_kick_node(lock, next);
 
 release:
 	trace_contention_end(lock, 0);
@@ -512,13 +511,12 @@ static inline void queued_spin_lock_mcs_queue(struct qspinlock *lock)
  * contended             :    (*,x,y) +--> (*,0,0) ---> (*,0,1) -'  :
  *   queue               :         ^--'                             :
  */
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+#define queued_spin_lock_slowpath	native_queued_spin_lock_slowpath
+#endif
+
 void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 {
-	if (pv_enabled()) {
-		queued_spin_lock_mcs_queue(lock);
-		return;
-	}
-
 	if (virt_spin_lock(lock))
 		return;
 
@@ -592,31 +590,17 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 */
 queue:
 	lockevent_inc(lock_slowpath);
-	queued_spin_lock_mcs_queue(lock);
+	queued_spin_lock_mcs_queue(lock, false);
 }
 EXPORT_SYMBOL(queued_spin_lock_slowpath);
 
-/*
- * Generate the paravirt code for queued_spin_unlock_slowpath().
- */
-#if !defined(_GEN_PV_LOCK_SLOWPATH) && defined(CONFIG_PARAVIRT_SPINLOCKS)
-#define _GEN_PV_LOCK_SLOWPATH
-
-#undef  pv_enabled
-#define pv_enabled()	true
-
-#undef pv_init_node
-#undef pv_wait_node
-#undef pv_kick_node
-#undef pv_wait_head_or_lock
-
-#define queued_spin_lock_mcs_queue	__pv_queued_spin_lock_mcs_queue
-
-#undef  queued_spin_lock_slowpath
-#define queued_spin_lock_slowpath	__pv_queued_spin_lock_slowpath
-
-#include "qspinlock_paravirt.h"
-#include "qspinlock.c"
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+#undef queued_spin_lock_slowpath
+void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
+{
+	queued_spin_lock_mcs_queue(lock, true);
+}
+EXPORT_SYMBOL(__pv_queued_spin_lock_slowpath);
 
 bool nopvspin __initdata;
 static __init int parse_nopvspin(char *arg)
@@ -625,4 +609,4 @@ static __init int parse_nopvspin(char *arg)
 	return 0;
 }
 early_param("nopvspin", parse_nopvspin);
-#endif
+#endif /* CONFIG_PARAVIRT_SPINLOCKS */
diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index 97385861adc2..f1922e3a0f7d 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -1,8 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _GEN_PV_LOCK_SLOWPATH
-#error "do not include this file"
-#endif
-
 #include <linux/hash.h>
 #include <linux/memblock.h>
 #include <linux/debug_locks.h>
@@ -50,9 +46,8 @@ enum vcpu_state {
 /*
  * Hybrid PV queued/unfair lock
  *
- * By replacing the regular queued_spin_trylock() with the function below,
- * it will be called once when a lock waiter enter the PV slowpath before
- * being queued.
+ * This function is called once when a lock waiter enters the PV slowpath
+ * before being queued.
  *
  * The pending bit is set by the queue head vCPU of the MCS wait queue in
  * pv_wait_head_or_lock() to signal that it is ready to spin on the lock.
@@ -71,7 +66,6 @@ enum vcpu_state {
  * queued lock (no lock starvation) and an unfair lock (good performance
  * on not heavily contended locks).
  */
-#define queued_spin_trylock(l)	pv_hybrid_queued_unfair_trylock(l)
 static inline bool pv_hybrid_queued_unfair_trylock(struct qspinlock *lock)
 {
 	/*
-- 
2.35.1


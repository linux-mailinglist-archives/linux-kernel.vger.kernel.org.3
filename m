Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BD85658CC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbiGDOjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbiGDOi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:38:58 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5B4DEE4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:38:48 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c13so4986044pla.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 07:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=84Y9XBk0SNt7frn8fBT+xPbBuKdfBamXXetJsZuNdKo=;
        b=Xds/lY9Q9ABZS5tRHRNEA5ciu7hreU6q4iFzlIxh+Lp5LoqFJz0heK0gCmzF4xE4cE
         MoEUqPoTwWc8xKraHxCOPJ45aMCoa7Hcef5EBu5I0moJRRAI/irspbl8nSrVdwXoJJ9p
         KNEEHuCXfWhn6jXurm2dO0i9g60C07FlDGBASiACQM0+ACWUe24u8/5qw9XXJrNLfwoo
         pQkBwhsuPD15Z2LcdeT9hUsXBdM/9U+pwp0PKnNOUTyB6ZVGGxmLL+KHuR4iUxRB6zKR
         V6uNH+1Pz0cXoSJjT+sPm9SWqgGmI1Z0l/E2cFICkwlIOAIChpwp3BRAgx5+Ei9G7ku1
         Uxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=84Y9XBk0SNt7frn8fBT+xPbBuKdfBamXXetJsZuNdKo=;
        b=x00FBCRo88t3DXynwBWo5Y/a6P2UGB8s0/ApcKzYrZDwOwr+Qtdwp6pLXUf3isUogw
         g0Fr2gz1mnNZyJEM8AgdoRT2gHmWKSlTSF54K7vBZr3UOCJBTrx47lz2FrfKpU7wKsht
         Y+Rl6YVAARGC+3+bV4+YE+y4eedtxwLBF6CnKlhlDnS2sEWI9kJp1SYvhxv9dsD2kVTT
         Z+x+LzZeEcUhrrlTR0rv4QbQ2wK4tk+qP/NRlTK9TQjuYfY4I6QDYAXpoBRnL/Op8Zd/
         jrIgImc/kX4F/Y8cnUAjCLCkWIGD6EPxiOfRCdIYIWx6+X+/lGycoBXRa7NHBFhqX1aj
         rADw==
X-Gm-Message-State: AJIora+cxA4zexsxZt0XdNOtpXzFOD9blKayCnZaHREiFOu931eCC+Cb
        cbv1eAhvK6KVfSKgWAVeFwA=
X-Google-Smtp-Source: AGRyM1uPMaiyyCyarBVdymWgr8Lm38UFlPexkFVEv0hOM9Ugp5w8kmtluo2cX2rI8CJ3jUreJy+mgg==
X-Received: by 2002:a17:90b:1e0e:b0:1ec:b2a6:c9d0 with SMTP id pg14-20020a17090b1e0e00b001ecb2a6c9d0mr38149101pjb.230.1656945527609;
        Mon, 04 Jul 2022 07:38:47 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com ([203.221.247.188])
        by smtp.gmail.com with ESMTPSA id u13-20020a63454d000000b0040d2224ae04sm20534365pgk.76.2022.07.04.07.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 07:38:47 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 05/13] locking/qspinlock: be less clever with the preprocessor
Date:   Tue,  5 Jul 2022 00:38:12 +1000
Message-Id: <20220704143820.3071004-6-npiggin@gmail.com>
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

Stop qspinlock.c including itself and avoid most of the function
renaming with the preprocessor.

This is mostly done by having the common slowpath code take a 'bool
paravirt' argument and adjusting code based on that.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/locking/qspinlock.c          | 116 ++++++++++++----------------
 kernel/locking/qspinlock_paravirt.h |  10 +--
 2 files changed, 52 insertions(+), 74 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 8f2173e22479..b96c58ca51de 100644
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
@@ -285,35 +283,21 @@ static __always_inline void set_locked(struct qspinlock *lock)
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
+static inline void queued_spin_lock_mcs_queue(struct qspinlock *lock, bool paravirt)
 {
 	struct qnode *prev, *next, *node;
 	u32 val, old, tail;
@@ -338,8 +322,13 @@ static inline void queued_spin_lock_mcs_queue(struct qspinlock *lock)
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
 
@@ -359,15 +348,21 @@ static inline void queued_spin_lock_mcs_queue(struct qspinlock *lock)
 
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
@@ -396,7 +391,8 @@ static inline void queued_spin_lock_mcs_queue(struct qspinlock *lock)
 		/* Link @node into the waitqueue. */
 		WRITE_ONCE(prev->next, node);
 
-		pv_wait_node(node, prev);
+		if (paravirt)
+			pv_wait_node(node, prev);
 		/* Wait for mcs node lock to be released */
 		smp_cond_load_acquire(&node->locked, VAL);
 
@@ -432,8 +428,10 @@ static inline void queued_spin_lock_mcs_queue(struct qspinlock *lock)
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
 
@@ -478,7 +476,8 @@ static inline void queued_spin_lock_mcs_queue(struct qspinlock *lock)
 		next = smp_cond_load_relaxed(&node->next, (VAL));
 
 	smp_store_release(&next->locked, 1); /* unlock the mcs node lock */
-	pv_kick_node(lock, next);
+	if (paravirt)
+		pv_kick_node(lock, next);
 
 release:
 	trace_contention_end(lock, 0);
@@ -510,13 +509,12 @@ static inline void queued_spin_lock_mcs_queue(struct qspinlock *lock)
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
 
@@ -590,31 +588,17 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
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
@@ -623,4 +607,4 @@ static __init int parse_nopvspin(char *arg)
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


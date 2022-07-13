Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE15F572EC6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbiGMHHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbiGMHHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:07:35 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BDEE2A19
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:07:27 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y141so9474318pfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=canSSO8tPQl0HCPeUzAGvF6YloaempkmnCz8lazbEZE=;
        b=mbBhLQqoKGOEvA3aKocs8l9QK5MA37IeptZGZcJtu8SGy0HvvrXupxyfSMEarYxiru
         2HVdls33pseJ61HFDw9xkg0YGEkDNOk3SkFDN1dXPDnatz2juc8bS9/MbXEfC+iJGKng
         SpIW2yandu/Fs2TFSDzCxmb5etHq1jySkS+qNeVoCvvKoRTiudKZbe6PMjpAlClXoB8C
         qmxrCPWQBnkAWmXCYlIC8yVT7HC2UzuWxngtm56UyzsKJKUudYdb2BfSo9E7LHaLKQX5
         8iq5DBr65LJ7l5FoZuJY6z/0r9oNvKHkeKItMJmb+TfxUGLzmkIZ4KFX4EHd5QX3+/1w
         VKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=canSSO8tPQl0HCPeUzAGvF6YloaempkmnCz8lazbEZE=;
        b=pdjbVx0hhMb9koO3WMdvrEk+Yde27T0qKol35HF3XzT4YhUvMhT7vxuF50lqSulUvx
         F8nk0xPd1ux5YgGnIafc+bQfAmw9RxjIQPYw+sC6/0n6DubyOlzT1UyDr/zcu31wnOv6
         83+SNfARnme92xtQ+kpZsW/7je2xoe+FVVOXj68xlDZUl2InTemc1bG572h01aI1secV
         19l7A5K4n3YZ3oTN6uQzjb6J+giR6MBfv06wdr2lph7bvwSH0UhyktRNR36EJlXF9xg9
         AV5XF70hXqO5kkQxVUNtPwQ/Oyrd25OLLQN9C7PBQOfvuRgGZhyNPdjMs8Yv661UC/4n
         XaYw==
X-Gm-Message-State: AJIora9W5NHq7On66+E7nxqvarDiXhDV/HkikdxB1xyDwF0oRPtBWZdk
        t3j8gwzJT+9WfxQ7I5inrRE=
X-Google-Smtp-Source: AGRyM1t2Do9K6rddRIlGiObzzUOWIfmjeKY8x5oYLDeGQA9CzUDJUMkmvp5z9jMhJ2Ao7eAuxSVV/g==
X-Received: by 2002:a65:6cc8:0:b0:3fe:2b89:cc00 with SMTP id g8-20020a656cc8000000b003fe2b89cc00mr1785200pgw.599.1657696047165;
        Wed, 13 Jul 2022 00:07:27 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (193-116-203-247.tpgi.com.au. [193.116.203.247])
        by smtp.gmail.com with ESMTPSA id d11-20020a170902cecb00b0016bd5da20casm8099061plg.134.2022.07.13.00.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 00:07:26 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 04/12] locking/qspinlock: move pv lock word helpers into qspinlock.c
Date:   Wed, 13 Jul 2022 17:06:56 +1000
Message-Id: <20220713070704.308394-5-npiggin@gmail.com>
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

There is no real reason not to keep all the bit manipulation together.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/locking/qspinlock.c          | 109 +++++++++++++++++-----------
 kernel/locking/qspinlock_paravirt.h |  51 -------------
 2 files changed, 65 insertions(+), 95 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 7360d643de29..95bf24d276c3 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -141,7 +141,26 @@ struct qnode *grab_qnode(struct qnode *base, int idx)
 
 #define _Q_LOCKED_PENDING_MASK (_Q_LOCKED_MASK | _Q_PENDING_MASK)
 
+/**
+ * set_pending - set the pending bit.
+ * @lock: Pointer to queued spinlock structure
+ *
+ * *,0,* -> *,1,*
+ *
+ * For paravirt, the pending bit is used by the queue head vCPU to indicate
+ * that it is actively spinning on the lock and no lock stealing is allowed.
+ * Non-paravirt, the pending bit is used to avoid loading the extra node
+ * cacheline in the likely contended case.
+ */
+static __always_inline void set_pending(struct qspinlock *lock)
+{
 #if _Q_PENDING_BITS == 8
+	WRITE_ONCE(lock->pending, 1);
+#else
+	atomic_or(_Q_PENDING_VAL, &lock->val);
+#endif
+}
+
 /**
  * clear_pending - clear the pending bit.
  * @lock: Pointer to queued spinlock structure
@@ -150,7 +169,11 @@ struct qnode *grab_qnode(struct qnode *base, int idx)
  */
 static __always_inline void clear_pending(struct qspinlock *lock)
 {
+#if _Q_PENDING_BITS == 8
 	WRITE_ONCE(lock->pending, 0);
+#else
+	atomic_andnot(_Q_PENDING_VAL, &lock->val);
+#endif
 }
 
 /**
@@ -163,74 +186,72 @@ static __always_inline void clear_pending(struct qspinlock *lock)
  */
 static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
 {
+#if _Q_PENDING_BITS == 8
 	WRITE_ONCE(lock->locked_pending, _Q_LOCKED_VAL);
+#else
+	atomic_add(-_Q_PENDING_VAL + _Q_LOCKED_VAL, &lock->val);
+#endif
 }
 
-/*
- * xchg_tail - Put in the new queue tail code word & retrieve previous one
- * @lock : Pointer to queued spinlock structure
- * @tail : The new queue tail code word
- * Return: The previous queue tail code word
- *
- * xchg(lock, tail), which heads an address dependency
- *
- * p,*,* -> n,*,* ; prev = xchg(lock, node)
- */
-static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
-{
-	/*
-	 * We can use relaxed semantics since the caller ensures that the
-	 * MCS node is properly initialized before updating the tail.
-	 */
-	return (u32)xchg_relaxed(&lock->tail,
-				 tail >> _Q_TAIL_OFFSET) << _Q_TAIL_OFFSET;
-}
-
-#else /* _Q_PENDING_BITS == 8 */
-
 /**
- * clear_pending - clear the pending bit.
+ * trylock_clear_pending - try to take ownership and clear the pending bit
  * @lock: Pointer to queued spinlock structure
  *
- * *,1,* -> *,0,*
+ * 0,1,0 -> 0,0,1
  */
-static __always_inline void clear_pending(struct qspinlock *lock)
+static __always_inline int trylock_clear_pending(struct qspinlock *lock)
 {
-	atomic_andnot(_Q_PENDING_VAL, &lock->val);
-}
+#if _Q_PENDING_BITS == 8
+	return !READ_ONCE(lock->locked) &&
+	       (cmpxchg_acquire(&lock->locked_pending, _Q_PENDING_VAL,
+				_Q_LOCKED_VAL) == _Q_PENDING_VAL);
+#else
+	int val = atomic_read(&lock->val);
 
-/**
- * clear_pending_set_locked - take ownership and clear the pending bit.
- * @lock: Pointer to queued spinlock structure
- *
- * *,1,0 -> *,0,1
- */
-static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
-{
-	atomic_add(-_Q_PENDING_VAL + _Q_LOCKED_VAL, &lock->val);
+	for (;;) {
+		int old, new;
+
+		if (val  & _Q_LOCKED_MASK)
+			break;
+
+		/*
+		 * Try to clear pending bit & set locked bit
+		 */
+		old = val;
+		new = (val & ~_Q_PENDING_MASK) | _Q_LOCKED_VAL;
+		val = atomic_cmpxchg_acquire(&lock->val, old, new);
+
+		if (val == old)
+			return 1;
+	}
+	return 0;
+#endif
 }
 
-/**
+/*
  * xchg_tail - Put in the new queue tail code word & retrieve previous one
  * @lock : Pointer to queued spinlock structure
  * @tail : The new queue tail code word
  * Return: The previous queue tail code word
  *
- * xchg(lock, tail)
+ * xchg(lock, tail), which heads an address dependency
  *
  * p,*,* -> n,*,* ; prev = xchg(lock, node)
  */
 static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
 {
+	/*
+	 * We can use relaxed semantics since the caller ensures that the
+	 * MCS node is properly initialized before updating the tail.
+	 */
+#if _Q_PENDING_BITS == 8
+	return (u32)xchg_relaxed(&lock->tail,
+				 tail >> _Q_TAIL_OFFSET) << _Q_TAIL_OFFSET;
+#else
 	u32 old, new, val = atomic_read(&lock->val);
 
 	for (;;) {
 		new = (val & _Q_LOCKED_PENDING_MASK) | tail;
-		/*
-		 * We can use relaxed semantics since the caller ensures that
-		 * the MCS node is properly initialized before updating the
-		 * tail.
-		 */
 		old = atomic_cmpxchg_relaxed(&lock->val, val, new);
 		if (old == val)
 			break;
@@ -238,8 +259,8 @@ static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
 		val = old;
 	}
 	return old;
+#endif
 }
-#endif /* _Q_PENDING_BITS == 8 */
 
 /**
  * queued_fetch_set_pending_acquire - fetch the whole lock value and set pending
diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index cce3d3dde216..97385861adc2 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -95,57 +95,6 @@ static inline bool pv_hybrid_queued_unfair_trylock(struct qspinlock *lock)
 	return false;
 }
 
-/*
- * The pending bit is used by the queue head vCPU to indicate that it
- * is actively spinning on the lock and no lock stealing is allowed.
- */
-#if _Q_PENDING_BITS == 8
-static __always_inline void set_pending(struct qspinlock *lock)
-{
-	WRITE_ONCE(lock->pending, 1);
-}
-
-/*
- * The pending bit check in pv_queued_spin_steal_lock() isn't a memory
- * barrier. Therefore, an atomic cmpxchg_acquire() is used to acquire the
- * lock just to be sure that it will get it.
- */
-static __always_inline int trylock_clear_pending(struct qspinlock *lock)
-{
-	return !READ_ONCE(lock->locked) &&
-	       (cmpxchg_acquire(&lock->locked_pending, _Q_PENDING_VAL,
-				_Q_LOCKED_VAL) == _Q_PENDING_VAL);
-}
-#else /* _Q_PENDING_BITS == 8 */
-static __always_inline void set_pending(struct qspinlock *lock)
-{
-	atomic_or(_Q_PENDING_VAL, &lock->val);
-}
-
-static __always_inline int trylock_clear_pending(struct qspinlock *lock)
-{
-	int val = atomic_read(&lock->val);
-
-	for (;;) {
-		int old, new;
-
-		if (val  & _Q_LOCKED_MASK)
-			break;
-
-		/*
-		 * Try to clear pending bit & set locked bit
-		 */
-		old = val;
-		new = (val & ~_Q_PENDING_MASK) | _Q_LOCKED_VAL;
-		val = atomic_cmpxchg_acquire(&lock->val, old, new);
-
-		if (val == old)
-			return 1;
-	}
-	return 0;
-}
-#endif /* _Q_PENDING_BITS == 8 */
-
 /*
  * Lock and MCS node addresses hash table for fast lookup
  *
-- 
2.35.1


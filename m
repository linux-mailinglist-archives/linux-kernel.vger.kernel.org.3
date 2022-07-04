Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1BE5658CA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbiGDOjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234692AbiGDOiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:38:55 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE73BE2C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:38:44 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id b12-20020a17090a6acc00b001ec2b181c98so13962891pjm.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 07:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sQX1btfhEReMr9q0OWNBdMs36tQogolU1yyeQWb4e7U=;
        b=Yc7QDKjooePhdGKRSV7xaCFguyrG37KEol4bV/gP7Mr3DjfOEpx0nmeWBAIDFiel8p
         0m0MDZpQqvlI0daGuMkssDHv3nfjuuK/dN3N75WsnGt750oD5/KXiFx2RhihS8S6QPKj
         5tvh4X/1VzYY6WHapgdG1J2pIHm50UlYLeb7YKXMbQ+9PbWyCsZVoBkb40yp1TuGWAp1
         sO/gsPIDDdzRJlgKWBN23RarmM2XOe0a04uH+8F74ZXe0tm7J1fHKGm/yNArh3lO+twk
         sttbbtck7nm+Hwg9Evdwc4+ZoVlUoZpHFoHOMMzRaHWLlW7jthjOm8LXKKCPEmGTQpjy
         5nwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sQX1btfhEReMr9q0OWNBdMs36tQogolU1yyeQWb4e7U=;
        b=DJhDKSMrlCFr+shhc9aoEEXNmYxG+34tHRRv17D+DOR8g+5Dvtahne508yf4vg6fRR
         TB+c/DMOhQx7HTQeksbMhKHOmCo0Eat30N6wTJ7NoQVxyQUhrTDAUYIfqdiMZW385Vwp
         TV1zNREoiziwtidnPXl6hoh27x93dGrOj+cZgjby7QivHogcHeqbYwZOU/T+lTmndURB
         fo+RJ+SngZog9L33kJm/voGcx2JKiAcc8/WwpF0rTR8PzbCt/RkFzcq49Wk6F2UEQ4nn
         nCHAt0Dgqw49gbDhrAgttbG9Zt5sjT7Z0L/aX9i+8fBV71VwMZu0iDnCsa6tEXQoyska
         Cucg==
X-Gm-Message-State: AJIora+6wuNqdt5+WqBfhPJQzXxIrCsL7dRd5OAwaA9BJF4Vb4yfvKgq
        PNjQ66vK/BC9akwWQkJXQ5A=
X-Google-Smtp-Source: AGRyM1vdrLtiKH7wi9hO4VmuuorYBQT8JVOOA0eRXxK5wrGoVnmGb1diriQk3204eQTmPIK10ASaNw==
X-Received: by 2002:a17:90a:1305:b0:1ef:7b0a:366f with SMTP id h5-20020a17090a130500b001ef7b0a366fmr13103243pja.146.1656945523997;
        Mon, 04 Jul 2022 07:38:43 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com ([203.221.247.188])
        by smtp.gmail.com with ESMTPSA id u13-20020a63454d000000b0040d2224ae04sm20534365pgk.76.2022.07.04.07.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 07:38:43 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 04/13] locking/qspinlock: move pv lock word helpers into qspinlock.c
Date:   Tue,  5 Jul 2022 00:38:11 +1000
Message-Id: <20220704143820.3071004-5-npiggin@gmail.com>
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

There is no real reason not to keep all the bit manipulation together.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/locking/qspinlock.c          | 107 ++++++++++++++++------------
 kernel/locking/qspinlock_paravirt.h |  51 -------------
 2 files changed, 63 insertions(+), 95 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 7360d643de29..8f2173e22479 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -141,7 +141,24 @@ struct qnode *grab_qnode(struct qnode *base, int idx)
 
 #define _Q_LOCKED_PENDING_MASK (_Q_LOCKED_MASK | _Q_PENDING_MASK)
 
+/**
+ * set_pending - set the pending bit.
+ * @lock: Pointer to queued spinlock structure
+ *
+ * *,0,* -> *,1,*
+ *
+ * The pending bit is used by the queue head vCPU to indicate that it
+ * is actively spinning on the lock and no lock stealing is allowed.
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
@@ -150,7 +167,11 @@ struct qnode *grab_qnode(struct qnode *base, int idx)
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
@@ -163,74 +184,72 @@ static __always_inline void clear_pending(struct qspinlock *lock)
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
@@ -238,8 +257,8 @@ static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751E659742F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241046AbiHQQ1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 12:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236463AbiHQQ1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:27:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B515FA0326
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:27:37 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660753656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wiRzqGd4tF+H6l5Mpr46iPb7Iqjo75nyCRDmhTMfrBU=;
        b=q8KvGO/BxuB0m+9l8pbSRGxWaSIsfwgo/OI7ry39vBOkoqPWERrWsH75Dn5BlgsdwY6cYO
        USAWE72Uet8ZT6/Tjk0HKWLJeR/E6R9gKCE7rW1B3MjGDdb4AOQGCZEFAGN8la5QrYoadO
        rhVnmDufo2AuPuHxz6uMHkWS01BxpOk8h/yBQEVvFk8FZXfJlZy/UgjV/mNfuPUskjVQpl
        ot+Z+JAKtbnOGw7mqxpNJWdjPIiUkHpACE8ds73O6jcVweHre7dgtXg/97kPK5OUcU5Sjj
        ETY24DRJy65Sul1qjGAA6u/3AL//cw8pj4pTFOMU2MMaiBETekdC+uDmLCCzcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660753656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wiRzqGd4tF+H6l5Mpr46iPb7Iqjo75nyCRDmhTMfrBU=;
        b=W/30GvMvGlOlQIUvbaTWlnADOD2PKDbdwCvsDvpT8PIE9hDi9tNJue2Jum01uAmt4IMFBc
        sMHHIVmCW86MpoAQ==
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/9] slub: Make PREEMPT_RT support less convoluted
Date:   Wed, 17 Aug 2022 18:26:55 +0200
Message-Id: <20220817162703.728679-2-bigeasy@linutronix.de>
In-Reply-To: <20220817162703.728679-1-bigeasy@linutronix.de>
References: <20220817162703.728679-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The slub code already has a few helpers depending on PREEMPT_RT. Add a few
more and get rid of the CONFIG_PREEMPT_RT conditionals all over the place.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 mm/slub.c | 66 +++++++++++++++++++++++++------------------------------
 1 file changed, 30 insertions(+), 36 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 862dbd9af4f52..5f7c5b5bd49f9 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -100,9 +100,11 @@
  *   except the stat counters. This is a percpu structure manipulated only=
 by
  *   the local cpu, so the lock protects against being preempted or interr=
upted
  *   by an irq. Fast path operations rely on lockless operations instead.
- *   On PREEMPT_RT, the local lock does not actually disable irqs (and thus
- *   prevent the lockless operations), so fastpath operations also need to=
 take
- *   the lock and are no longer lockless.
+ *
+ *   On PREEMPT_RT, the local lock neither disables interrupts nor preempt=
ion
+ *   which means the lockless fastpath cannot be used as it might interfer=
e with
+ *   an in-progress slow path operations. In this case the local lock is a=
lways
+ *   taken but it still utilizes the freelist for the common operations.
  *
  *   lockless fastpaths
  *
@@ -163,8 +165,11 @@
  * function call even on !PREEMPT_RT, use inline preempt_disable() there.
  */
 #ifndef CONFIG_PREEMPT_RT
-#define slub_get_cpu_ptr(var)	get_cpu_ptr(var)
-#define slub_put_cpu_ptr(var)	put_cpu_ptr(var)
+#define slub_get_cpu_ptr(var)		get_cpu_ptr(var)
+#define slub_put_cpu_ptr(var)		put_cpu_ptr(var)
+#define use_lockless_fast_path()	(true)
+#define slub_local_irq_save(flags)	local_irq_save(flags)
+#define slub_local_irq_restore(flags)	local_irq_restore(flags)
 #else
 #define slub_get_cpu_ptr(var)		\
 ({					\
@@ -176,6 +181,9 @@ do {					\
 	(void)(var);			\
 	migrate_enable();		\
 } while (0)
+#define use_lockless_fast_path()	(false)
+#define slub_local_irq_save(flags)	do { } while (0)
+#define slub_local_irq_restore(flags)	do { } while (0)
 #endif
=20
 #ifdef CONFIG_SLUB_DEBUG
@@ -460,16 +468,14 @@ static __always_inline void __slab_unlock(struct slab=
 *slab)
=20
 static __always_inline void slab_lock(struct slab *slab, unsigned long *fl=
ags)
 {
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		local_irq_save(*flags);
+	slub_local_irq_save(*flags);
 	__slab_lock(slab);
 }
=20
 static __always_inline void slab_unlock(struct slab *slab, unsigned long *=
flags)
 {
 	__slab_unlock(slab);
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		local_irq_restore(*flags);
+	slub_local_irq_restore(*flags);
 }
=20
 /*
@@ -482,7 +488,7 @@ static inline bool __cmpxchg_double_slab(struct kmem_ca=
che *s, struct slab *slab
 		void *freelist_new, unsigned long counters_new,
 		const char *n)
 {
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+	if (use_lockless_fast_path())
 		lockdep_assert_irqs_disabled();
 #if defined(CONFIG_HAVE_CMPXCHG_DOUBLE) && \
     defined(CONFIG_HAVE_ALIGNED_STRUCT_PAGE)
@@ -3197,14 +3203,8 @@ static __always_inline void *slab_alloc_node(struct =
kmem_cache *s, struct list_l
=20
 	object =3D c->freelist;
 	slab =3D c->slab;
-	/*
-	 * We cannot use the lockless fastpath on PREEMPT_RT because if a
-	 * slowpath has taken the local_lock_irqsave(), it is not protected
-	 * against a fast path operation in an irq handler. So we need to take
-	 * the slow path which uses local_lock. It is still relatively fast if
-	 * there is a suitable cpu freelist.
-	 */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT) ||
+
+	if (!use_lockless_fast_path() ||
 	    unlikely(!object || !slab || !node_match(slab, node))) {
 		object =3D __slab_alloc(s, gfpflags, node, addr, c);
 	} else {
@@ -3463,6 +3463,7 @@ static __always_inline void do_slab_free(struct kmem_=
cache *s,
 	void *tail_obj =3D tail ? : head;
 	struct kmem_cache_cpu *c;
 	unsigned long tid;
+	void **freelist;
=20
 redo:
 	/*
@@ -3477,9 +3478,13 @@ static __always_inline void do_slab_free(struct kmem=
_cache *s,
 	/* Same with comment on barrier() in slab_alloc_node() */
 	barrier();
=20
-	if (likely(slab =3D=3D c->slab)) {
-#ifndef CONFIG_PREEMPT_RT
-		void **freelist =3D READ_ONCE(c->freelist);
+	if (unlikely(slab !=3D c->slab)) {
+		__slab_free(s, slab, head, tail_obj, cnt, addr);
+		return;
+	}
+
+	if (use_lockless_fast_path()) {
+		freelist =3D READ_ONCE(c->freelist);
=20
 		set_freepointer(s, tail_obj, freelist);
=20
@@ -3491,16 +3496,8 @@ static __always_inline void do_slab_free(struct kmem=
_cache *s,
 			note_cmpxchg_failure("slab_free", s, tid);
 			goto redo;
 		}
-#else /* CONFIG_PREEMPT_RT */
-		/*
-		 * We cannot use the lockless fastpath on PREEMPT_RT because if
-		 * a slowpath has taken the local_lock_irqsave(), it is not
-		 * protected against a fast path operation in an irq handler. So
-		 * we need to take the local_lock. We shouldn't simply defer to
-		 * __slab_free() as that wouldn't use the cpu freelist at all.
-		 */
-		void **freelist;
-
+	} else {
+		/* Update the free list under the local lock */
 		local_lock(&s->cpu_slab->lock);
 		c =3D this_cpu_ptr(s->cpu_slab);
 		if (unlikely(slab !=3D c->slab)) {
@@ -3515,11 +3512,8 @@ static __always_inline void do_slab_free(struct kmem=
_cache *s,
 		c->tid =3D next_tid(tid);
=20
 		local_unlock(&s->cpu_slab->lock);
-#endif
-		stat(s, FREE_FASTPATH);
-	} else
-		__slab_free(s, slab, head, tail_obj, cnt, addr);
-
+	}
+	stat(s, FREE_FASTPATH);
 }
=20
 static __always_inline void slab_free(struct kmem_cache *s, struct slab *s=
lab,
--=20
2.37.2


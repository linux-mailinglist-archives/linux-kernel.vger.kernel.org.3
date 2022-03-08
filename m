Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F6B4D1679
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346646AbiCHLoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346648AbiCHLoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:44:05 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFB92DD7B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 03:42:56 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id t5so17122461pfg.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 03:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m3bFV+3u+b20rLT2oE1x5BZUmsdi1StL5opiJFj+i8I=;
        b=msT3CPaR0QmzW3OWcptkBem5LvGFEvg0MsV/reuAXN4rWovYrN8BklX4XTjXn0X4du
         LecYWX9tvkKhwOwwqYtkGDE+7OITrNvPS/PxHlTUGfif9cMJPEivvYNqGISa702U8o7Q
         v2p6wQZYTL9tRWNtPNwSuBHyhrAGf61pQWSbjq01Ysf25RWJ8/qx7aNG94nBoLH/MVEB
         MUgSS/wLRHcgof19BFiwc/XEZZKhBhua2xIHGKocKz4UANgtuss1M2C3Ue0FxpiQuNpr
         4UJMTj56ERdeEz5skTmqV7GddYycyy75IxPePaGUYTg5DXSVAEzVctI8ipkTEBv1YzEc
         eIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m3bFV+3u+b20rLT2oE1x5BZUmsdi1StL5opiJFj+i8I=;
        b=3NvwAjbNpgSBUF6sMhfZvl9dbhynFgM3oZ3vTmj08swVkmmVR3EDuL8xmgZFGYQW81
         +Ex13o72mD3QmHVtxPxKxCAu5jHR+KXtxUuYd/nyvRnoR/0YU0w97C5M+/YO87yRqQaK
         xSCSeQTz44iDo5PXFSB6wUaefBVmzcmBQmkJFwUKS1q0rwK48zImUO/AbJ5j1nXvzs5a
         K3C1i7H0ufzhDYBKZ5qSWAnfCa3Sg6YRHJQxCxENmeA/cvEPt3Rt8W+CHox4X4bXLW22
         RUg2RWXwxJsGlDQrh9vy3h7DuJKZ7jbqwpfzvPkP3u3QihXO8boMuxzcFTCBT032oIK8
         H86Q==
X-Gm-Message-State: AOAM533ueW9PpnDmuZ7VaoSt8lJLXwzz5hQUX1DVrCuwXZ9/99KLBQif
        CLt/o+zQz0W1LpnAOiefz521cwhfQjOcrg==
X-Google-Smtp-Source: ABdhPJzBXCF0MdHOPb9x1fIzLSJK4GfnxVP0UvnudAy7USYm8sbaDp2nRaF6HMydgDbkhJjuVYQNBA==
X-Received: by 2002:a63:110e:0:b0:375:89f4:b54e with SMTP id g14-20020a63110e000000b0037589f4b54emr13785935pgl.430.1646739775771;
        Tue, 08 Mar 2022 03:42:55 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090ac40200b001bd0e552d27sm2578285pjt.11.2022.03.08.03.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 03:42:55 -0800 (PST)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     linux-mm@kvack.org
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org, 42.hyeyoo@gmail.com
Subject: [RFC PATCH v1 12/15] mm/sl[au]b: generalize kmalloc subsystem
Date:   Tue,  8 Mar 2022 11:41:39 +0000
Message-Id: <20220308114142.1744229-13-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220308114142.1744229-1-42.hyeyoo@gmail.com>
References: <20220308114142.1744229-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now everything in kmalloc subsystem can be generalized.
Let's do it!

Generalize __kmalloc_node_track_caller(), kfree(), __ksize(),
and move them to slab_common.c.

Make __kmalloc_node() wrapper of __kmalloc_node_track_caller().
They are duplicate.

To keep caller address unchanged in kmalloc/kfree tracepoints, implement
__kmem_cache_{alloc_node,free}() that takes caller address.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 include/linux/slab.h |  79 ++++++++++++++++++-------
 mm/slab.c            | 135 ++++---------------------------------------
 mm/slab_common.c     |  75 ++++++++++++++++++++++++
 mm/slob.c            |  32 +++++-----
 mm/slub.c            | 105 +++------------------------------
 5 files changed, 166 insertions(+), 260 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 9ced225a3ea3..6b632137f799 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -401,14 +401,53 @@ static_assert(PAGE_SHIFT <= 20);
 #define kmalloc_index(s) __kmalloc_index(s, true)
 #endif /* !CONFIG_SLOB */
 
-void *__kmalloc_node(size_t size, gfp_t flags, int node) __assume_kmalloc_alignment
-							 __alloc_size(1);
-void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t flags, int node) __assume_slab_alignment
-									 __malloc;
+extern void *__kmalloc_node_track_caller(size_t size, gfp_t flags, int node,
+					 unsigned long caller) __alloc_size(1);
+#define kmalloc_node_track_caller(size, flags, node) \
+	__kmalloc_node_track_caller(size, flags, node, \
+			_RET_IP_)
+/*
+ * kmalloc_track_caller is a special version of kmalloc that records the
+ * calling function of the routine calling it for slab leak tracking instead
+ * of just the calling function (confusing, eh?).
+ * It's useful when the call to kmalloc comes from a widely-used standard
+ * allocator where we care about the real place the memory allocation
+ * request comes from.
+ */
+#define kmalloc_track_caller(size, flags) \
+	__kmalloc_node_track_caller(size, flags, NUMA_NO_NODE, _RET_IP_)
+
+static __always_inline void *__kmalloc_node(size_t size, gfp_t flags, int node)
+{
+	return __kmalloc_node_track_caller(size, flags, node, _RET_IP_);
+}
 
 static __always_inline void *__kmalloc(size_t size, gfp_t flags)
 {
-	return __kmalloc_node(size, flags, NUMA_NO_NODE);
+	return __kmalloc_node_track_caller(size, flags, NUMA_NO_NODE, _RET_IP_);
+}
+
+void __kmem_cache_free(struct kmem_cache *s, void *x, unsigned long caller);
+void *__kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags,
+			      int node, unsigned long caller);
+
+/**
+ * kmem_cache_alloc_node - Allocate an object on the specified node
+ * @cachep: The cache to allocate from.
+ * @flags: See kmalloc().
+ * @nodeid: node number of the target node.
+ *
+ * Identical to kmem_cache_alloc but it will allocate memory on the given
+ * node, which can improve the performance for cpu bound structures.
+ *
+ * Fallback to other node is possible if __GFP_THISNODE is not set.
+ *
+ * Return: pointer to the new object or %NULL in case of error
+ */
+static __always_inline void *
+kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
+{
+	return __kmem_cache_alloc_node(s, gfpflags, node, _RET_IP_);
 }
 
 /**
@@ -423,10 +462,21 @@ static __always_inline void *__kmalloc(size_t size, gfp_t flags)
  */
 static __always_inline void *kmem_cache_alloc(struct kmem_cache *s, gfp_t flags)
 {
-	return kmem_cache_alloc_node(s, flags, NUMA_NO_NODE);
+	return __kmem_cache_alloc_node(s, flags, NUMA_NO_NODE, _RET_IP_);
 }
 
-void kmem_cache_free(struct kmem_cache *s, void *objp);
+/**
+ * kmem_cache_free - Deallocate an object
+ * @cachep: The cache the allocation was from.
+ * @objp: The previously allocated object.
+ *
+ * Free an object which was previously allocated from this
+ * cache.
+ */
+static __always_inline void kmem_cache_free(struct kmem_cache *s, void *x)
+{
+	__kmem_cache_free(s, x, _RET_IP_);
+}
 
 /*
  * Bulk allocation and freeing operations. These are accelerated in an
@@ -613,21 +663,6 @@ static inline __alloc_size(1, 2) void *kcalloc_node(size_t n, size_t size, gfp_t
 	return kmalloc_array_node(n, size, flags | __GFP_ZERO, node);
 }
 
-extern void *__kmalloc_node_track_caller(size_t size, gfp_t flags, int node,
-					 unsigned long caller) __alloc_size(1);
-#define kmalloc_node_track_caller(size, flags, node) \
-	__kmalloc_node_track_caller(size, flags, node, \
-			_RET_IP_)
-/*
- * kmalloc_track_caller is a special version of kmalloc that records the
- * calling function of the routine calling it for slab leak tracking instead
- * of just the calling function (confusing, eh?).
- * It's useful when the call to kmalloc comes from a widely-used standard
- * allocator where we care about the real place the memory allocation
- * request comes from.
- */
-#define kmalloc_track_caller(size, flags) \
-	__kmalloc_node_track_caller(size, flags, NUMA_NO_NODE, _RET_IP_)
 /*
  * Shortcuts
  */
diff --git a/mm/slab.c b/mm/slab.c
index 702a78f64b44..2f4d13bb511b 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3519,30 +3519,19 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 }
 EXPORT_SYMBOL(kmem_cache_alloc_bulk);
 
-/**
- * kmem_cache_alloc_node - Allocate an object on the specified node
- * @cachep: The cache to allocate from.
- * @flags: See kmalloc().
- * @nodeid: node number of the target node.
- *
- * Identical to kmem_cache_alloc but it will allocate memory on the given
- * node, which can improve the performance for cpu bound structures.
- *
- * Fallback to other node is possible if __GFP_THISNODE is not set.
- *
- * Return: pointer to the new object or %NULL in case of error
- */
-void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)
+void *__kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags,
+			      int nodeid, unsigned long caller)
 {
-	void *ret = slab_alloc_node(cachep, flags, nodeid, cachep->object_size, _RET_IP_);
+	void *ret = slab_alloc_node(cachep, flags, nodeid,
+				    cachep->object_size, caller);
 
-	trace_kmem_cache_alloc_node(cachep->name, _RET_IP_, ret,
+	trace_kmem_cache_alloc_node(cachep->name, caller, ret,
 				    cachep->object_size, cachep->size,
 				    flags, nodeid);
 
 	return ret;
 }
-EXPORT_SYMBOL(kmem_cache_alloc_node);
+EXPORT_SYMBOL(__kmem_cache_alloc_node);
 
 void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
 				  gfp_t flags,
@@ -3561,36 +3550,6 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
 }
 EXPORT_SYMBOL(kmem_cache_alloc_node_trace);
 
-static __always_inline void *
-__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
-{
-	struct kmem_cache *cachep;
-	void *ret;
-
-	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
-		return kmalloc_large_node(size, flags, node);
-	cachep = kmalloc_slab(size, flags);
-	if (unlikely(ZERO_OR_NULL_PTR(cachep)))
-		return cachep;
-	ret = kmem_cache_alloc_node_trace(cachep, flags, node, size);
-	ret = kasan_kmalloc(cachep, ret, size, flags);
-
-	return ret;
-}
-
-void *__kmalloc_node(size_t size, gfp_t flags, int node)
-{
-	return __do_kmalloc_node(size, flags, node, _RET_IP_);
-}
-EXPORT_SYMBOL(__kmalloc_node);
-
-void *__kmalloc_node_track_caller(size_t size, gfp_t flags,
-		int node, unsigned long caller)
-{
-	return __do_kmalloc_node(size, flags, node, caller);
-}
-EXPORT_SYMBOL(__kmalloc_node_track_caller);
-
 #ifdef CONFIG_PRINTK
 void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
 {
@@ -3613,30 +3572,23 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
 }
 #endif
 
-/**
- * kmem_cache_free - Deallocate an object
- * @cachep: The cache the allocation was from.
- * @objp: The previously allocated object.
- *
- * Free an object which was previously allocated from this
- * cache.
- */
-void kmem_cache_free(struct kmem_cache *cachep, void *objp)
+void __kmem_cache_free(struct kmem_cache *cachep, void *objp,
+		       unsigned long caller)
 {
 	unsigned long flags;
 	cachep = cache_from_obj(cachep, objp);
 	if (!cachep)
 		return;
 
-	trace_kmem_cache_free(cachep->name, _RET_IP_, objp);
+	trace_kmem_cache_free(cachep->name, caller, objp);
 	local_irq_save(flags);
 	debug_check_no_locks_freed(objp, cachep->object_size);
 	if (!(cachep->flags & SLAB_DEBUG_OBJECTS))
 		debug_check_no_obj_freed(objp, cachep->object_size);
-	__cache_free(cachep, objp, _RET_IP_);
+	__cache_free(cachep, objp, caller);
 	local_irq_restore(flags);
 }
-EXPORT_SYMBOL(kmem_cache_free);
+EXPORT_SYMBOL(__kmem_cache_free);
 
 void kmem_cache_free_bulk(struct kmem_cache *orig_s, size_t size, void **p)
 {
@@ -3676,44 +3628,6 @@ void kmem_cache_free_bulk(struct kmem_cache *orig_s, size_t size, void **p)
 }
 EXPORT_SYMBOL(kmem_cache_free_bulk);
 
-/**
- * kfree - free previously allocated memory
- * @objp: pointer returned by kmalloc.
- *
- * If @objp is NULL, no operation is performed.
- *
- * Don't free memory not originally allocated by kmalloc()
- * or you will run into trouble.
- */
-void kfree(const void *objp)
-{
-	struct kmem_cache *c;
-	unsigned long flags;
-	struct folio *folio;
-	void *x = (void *) objp;
-
-
-	if (unlikely(ZERO_OR_NULL_PTR(objp)))
-		return;
-
-	folio = virt_to_folio(objp);
-	if (!folio_test_slab(folio)) {
-		free_large_kmalloc(folio, x);
-		return;
-	}
-
-	c = folio_slab(folio)->slab_cache;
-	trace_kmem_cache_free(c->name, _RET_IP_, objp);
-
-	local_irq_save(flags);
-	kfree_debugcheck(objp);
-	debug_check_no_locks_freed(objp, c->object_size);
-	debug_check_no_obj_freed(objp, c->object_size);
-	__cache_free(c, (void *)objp, _RET_IP_);
-	local_irq_restore(flags);
-}
-EXPORT_SYMBOL(kfree);
-
 /*
  * This initializes kmem_cache_node or resizes various caches for all nodes.
  */
@@ -4116,30 +4030,3 @@ void __check_heap_object(const void *ptr, unsigned long n,
 	usercopy_abort("SLAB object", cachep->name, to_user, offset, n);
 }
 #endif /* CONFIG_HARDENED_USERCOPY */
-
-/**
- * __ksize -- Uninstrumented ksize.
- * @objp: pointer to the object
- *
- * Unlike ksize(), __ksize() is uninstrumented, and does not provide the same
- * safety checks as ksize() with KASAN instrumentation enabled.
- *
- * Return: size of the actual memory used by @objp in bytes
- */
-size_t __ksize(const void *objp)
-{
-	struct kmem_cache *c;
-	struct folio *folio;
-
-	BUG_ON(!objp);
-	if (unlikely(objp == ZERO_SIZE_PTR))
-		return 0;
-
-	folio = virt_to_folio(objp);
-	if (!folio_test_slab(folio))
-		return folio_size(folio);
-
-	c = folio_slab(folio)->slab_cache;
-	return c->object_size;
-}
-EXPORT_SYMBOL(__ksize);
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 8a8330a777f5..6533026b4a6b 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -925,6 +925,81 @@ void free_large_kmalloc(struct folio *folio, void *object)
 			      -(PAGE_SIZE << order));
 	__free_pages(folio_page(folio, 0), order);
 }
+
+void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
+					int node, unsigned long caller)
+{
+	struct kmem_cache *s;
+	void *ret;
+
+	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
+		return kmalloc_large_node(size, gfpflags, node);
+
+	s = kmalloc_slab(size, gfpflags);
+
+	if (unlikely(ZERO_OR_NULL_PTR(s)))
+		return s;
+
+	ret = __kmem_cache_alloc_node(s, gfpflags, node, caller);
+	ret = kasan_kmalloc(s, ret, size, gfpflags);
+
+	return ret;
+}
+EXPORT_SYMBOL(__kmalloc_node_track_caller);
+
+/**
+ * kfree - free previously allocated memory
+ * @objp: pointer returned by kmalloc.
+ *
+ * If @objp is NULL, no operation is performed.
+ *
+ * Don't free memory not originally allocated by kmalloc()
+ * or you will run into trouble.
+ */
+void kfree(const void *x)
+{
+	struct folio *folio;
+	void *object = (void *)x;
+	struct kmem_cache *s;
+
+	if (unlikely(ZERO_OR_NULL_PTR(x)))
+		return;
+
+	folio = virt_to_folio(x);
+	if (unlikely(!folio_test_slab(folio))) {
+		free_large_kmalloc(folio, object);
+		return;
+	}
+
+	s = folio_slab(folio)->slab_cache;
+	__kmem_cache_free(s, object, _RET_IP_);
+}
+EXPORT_SYMBOL(kfree);
+
+/**
+ * __ksize -- Uninstrumented ksize.
+ * @objp: pointer to the object
+ *
+ * Unlike ksize(), __ksize() is uninstrumented, and does not provide the same
+ * safety checks as ksize() with KASAN instrumentation enabled.
+ *
+ * Return: size of the actual memory used by @objp in bytes
+ */
+size_t __ksize(const void *object)
+{
+	struct folio *folio;
+
+	if (unlikely(object == ZERO_SIZE_PTR))
+		return 0;
+
+	folio = virt_to_folio(object);
+
+	if (unlikely(!folio_test_slab(folio)))
+		return folio_size(folio);
+
+	return slab_ksize(folio_slab(folio)->slab_cache);
+}
+EXPORT_SYMBOL(__ksize);
 #endif /* !CONFIG_SLOB */
 
 gfp_t kmalloc_fix_flags(gfp_t flags)
diff --git a/mm/slob.c b/mm/slob.c
index 3726b77a066b..836a7d1ae996 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -588,7 +588,8 @@ int __kmem_cache_create(struct kmem_cache *c, slab_flags_t flags)
 	return 0;
 }
 
-static void *slob_alloc_node(struct kmem_cache *c, gfp_t flags, int node)
+static void *slob_alloc_node(struct kmem_cache *c, gfp_t flags,
+			     int node, unsigned long caller)
 {
 	void *b;
 
@@ -598,12 +599,12 @@ static void *slob_alloc_node(struct kmem_cache *c, gfp_t flags, int node)
 
 	if (c->size < PAGE_SIZE) {
 		b = slob_alloc(c->size, flags, c->align, node, 0);
-		trace_kmem_cache_alloc_node(c->name, _RET_IP_, b, c->object_size,
+		trace_kmem_cache_alloc_node(c->name, caller, b, c->object_size,
 					    SLOB_UNITS(c->size) * SLOB_UNIT,
 					    flags, node);
 	} else {
 		b = slob_new_pages(flags, get_order(c->size), node);
-		trace_kmem_cache_alloc_node(c->name, _RET_IP_, b, c->object_size,
+		trace_kmem_cache_alloc_node(c->name, caller, b, c->object_size,
 					    PAGE_SIZE << get_order(c->size),
 					    flags, node);
 	}
@@ -617,19 +618,14 @@ static void *slob_alloc_node(struct kmem_cache *c, gfp_t flags, int node)
 	return b;
 }
 
-void *__kmalloc_node(size_t size, gfp_t gfp, int node)
+void *__kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t gfp,
+			      int node, unsigned long caller)
 {
-	return __do_kmalloc_node(size, gfp, node, _RET_IP_);
+	return slob_alloc_node(cachep, gfp, node, caller);
 }
-EXPORT_SYMBOL(__kmalloc_node);
+EXPORT_SYMBOL(__kmem_cache_alloc_node);
 
-void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t gfp, int node)
-{
-	return slob_alloc_node(cachep, gfp, node);
-}
-EXPORT_SYMBOL(kmem_cache_alloc_node);
-
-static void __kmem_cache_free(void *b, int size)
+static void ___kmem_cache_free(void *b, int size)
 {
 	if (size < PAGE_SIZE)
 		slob_free(b, size);
@@ -642,23 +638,23 @@ static void kmem_rcu_free(struct rcu_head *head)
 	struct slob_rcu *slob_rcu = (struct slob_rcu *)head;
 	void *b = (void *)slob_rcu - (slob_rcu->size - sizeof(struct slob_rcu));
 
-	__kmem_cache_free(b, slob_rcu->size);
+	___kmem_cache_free(b, slob_rcu->size);
 }
 
-void kmem_cache_free(struct kmem_cache *c, void *b)
+void __kmem_cache_free(struct kmem_cache *c, void *b, unsigned long caller)
 {
 	kmemleak_free_recursive(b, c->flags);
-	trace_kmem_cache_free(c->name, _RET_IP_, b);
+	trace_kmem_cache_free(c->name, caller, b);
 	if (unlikely(c->flags & SLAB_TYPESAFE_BY_RCU)) {
 		struct slob_rcu *slob_rcu;
 		slob_rcu = b + (c->size - sizeof(struct slob_rcu));
 		slob_rcu->size = c->size;
 		call_rcu(&slob_rcu->head, kmem_rcu_free);
 	} else {
-		__kmem_cache_free(b, c->size);
+		___kmem_cache_free(b, c->size);
 	}
 }
-EXPORT_SYMBOL(kmem_cache_free);
+EXPORT_SYMBOL(__kmem_cache_free);
 
 void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p)
 {
diff --git a/mm/slub.c b/mm/slub.c
index c2e713bdb26c..f8fdb6b4fbd2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3224,16 +3224,17 @@ static __always_inline void *slab_alloc(struct kmem_cache *s,
 	return slab_alloc_node(s, gfpflags, NUMA_NO_NODE, addr, orig_size);
 }
 
-void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
+void *__kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags,
+			      int node, unsigned long caller)
 {
-	void *ret = slab_alloc_node(s, gfpflags, node, _RET_IP_, s->object_size);
+	void *ret = slab_alloc_node(s, gfpflags, node, caller, s->object_size);
 
-	trace_kmem_cache_alloc_node(s->name, _RET_IP_, ret,
+	trace_kmem_cache_alloc_node(s->name, caller, ret,
 				    s->object_size, s->size, gfpflags, node);
 
 	return ret;
 }
-EXPORT_SYMBOL(kmem_cache_alloc_node);
+EXPORT_SYMBOL(__kmem_cache_alloc_node);
 
 void *kmem_cache_alloc_node_trace(struct kmem_cache *s,
 				    gfp_t gfpflags,
@@ -3477,15 +3478,15 @@ void ___cache_free(struct kmem_cache *cache, void *x, unsigned long addr)
 }
 #endif
 
-void kmem_cache_free(struct kmem_cache *s, void *x)
+void __kmem_cache_free(struct kmem_cache *s, void *x, unsigned long caller)
 {
 	s = cache_from_obj(s, x);
 	if (!s)
 		return;
-	trace_kmem_cache_free(s->name, _RET_IP_, x);
-	slab_free(s, virt_to_slab(x), x, NULL, 1, _RET_IP_);
+	trace_kmem_cache_free(s->name, caller, x);
+	slab_free(s, virt_to_slab(x), x, NULL, 1, caller);
 }
-EXPORT_SYMBOL(kmem_cache_free);
+EXPORT_SYMBOL(__kmem_cache_free);
 
 struct detached_freelist {
 	struct slab *slab;
@@ -4351,30 +4352,6 @@ static int __init setup_slub_min_objects(char *str)
 
 __setup("slub_min_objects=", setup_slub_min_objects);
 
-void *__kmalloc_node(size_t size, gfp_t flags, int node)
-{
-	struct kmem_cache *s;
-	void *ret;
-
-	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
-		return kmalloc_large_node(size, flags, node);
-
-	s = kmalloc_slab(size, flags);
-
-	if (unlikely(ZERO_OR_NULL_PTR(s)))
-		return s;
-
-	ret = slab_alloc_node(s, flags, node, _RET_IP_, size);
-
-	trace_kmem_cache_alloc_node(s->name, _RET_IP_, ret, size,
-				    s->size, flags, node);
-
-	ret = kasan_kmalloc(s, ret, size, flags);
-
-	return ret;
-}
-EXPORT_SYMBOL(__kmalloc_node);
-
 #ifdef CONFIG_HARDENED_USERCOPY
 /*
  * Rejects incorrectly sized objects and objects that are to be copied
@@ -4425,46 +4402,6 @@ void __check_heap_object(const void *ptr, unsigned long n,
 }
 #endif /* CONFIG_HARDENED_USERCOPY */
 
-size_t __ksize(const void *object)
-{
-	struct folio *folio;
-
-	if (unlikely(object == ZERO_SIZE_PTR))
-		return 0;
-
-	folio = virt_to_folio(object);
-
-	if (unlikely(!folio_test_slab(folio)))
-		return folio_size(folio);
-
-	return slab_ksize(folio_slab(folio)->slab_cache);
-}
-EXPORT_SYMBOL(__ksize);
-
-void kfree(const void *x)
-{
-	struct folio *folio;
-	struct slab *slab;
-	void *object = (void *)x;
-	struct kmem_cache *s;
-
-	if (unlikely(ZERO_OR_NULL_PTR(x)))
-		return;
-
-	folio = virt_to_folio(x);
-	if (unlikely(!folio_test_slab(folio))) {
-		free_large_kmalloc(folio, object);
-		return;
-	}
-
-	slab = folio_slab(folio);
-	s = slab->slab_cache;
-
-	trace_kmem_cache_free(s->name, _RET_IP_, x);
-	slab_free(s, slab, object, NULL, 1, _RET_IP_);
-}
-EXPORT_SYMBOL(kfree);
-
 #define SHRINK_PROMOTE_MAX 32
 
 /*
@@ -4812,30 +4749,6 @@ int __kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
 	return 0;
 }
 
-void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
-					int node, unsigned long caller)
-{
-	struct kmem_cache *s;
-	void *ret;
-
-	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
-		return kmalloc_large_node(size, gfpflags, node);
-
-	s = kmalloc_slab(size, gfpflags);
-
-	if (unlikely(ZERO_OR_NULL_PTR(s)))
-		return s;
-
-	ret = slab_alloc_node(s, gfpflags, node, caller, size);
-
-	/* Honor the call site pointer we received. */
-	trace_kmem_cache_alloc_node(s->name, caller, ret, size,
-				    s->size, gfpflags, node);
-
-	return ret;
-}
-EXPORT_SYMBOL(__kmalloc_node_track_caller);
-
 #ifdef CONFIG_SYSFS
 static int count_inuse(struct slab *slab)
 {
-- 
2.33.1


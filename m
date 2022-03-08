Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0983D4D166F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346541AbiCHLnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346521AbiCHLnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:43:22 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF0F2E687
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 03:42:24 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id m2so10850687pll.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 03:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0uAYYVPs60JRCJbDB7Ptx2zuTygUKkzVc0YEvytONEk=;
        b=mnMXwAKPz38DFrMEbASiEBNVRBOWfMSF2dF1QXoWyWc059niybLo/YHiFLH0pANPOl
         ZbQZTU9NjZQxq2GW8+1v7JeVybmrQWyr0K8Okfv7nRb5lCbk1KRDlX+jlxdZIITHRssB
         Tr4XrZtRoin3226yrsWrQOm8pSLNbKmlM6NpX6FR6drKV8yRl2XfvthDVH0Q3VS9yJWK
         FQGLDjlLZFl3Qyx1oq6F6fu6cygllU1f9WTfPweE3Mv5aLYQyezPa5KVhqVOSPvR0tRx
         olHiCGJQSG+dmP01d/QAwSDldN2TqJWUf5pisdKMeLGZuWUifbqQaIcsrWMtIMr29Mfu
         HnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0uAYYVPs60JRCJbDB7Ptx2zuTygUKkzVc0YEvytONEk=;
        b=uL7lN209jEXTprQISB04z2HGTy6sUiL6R73WPUFv1FeSr42zb1cgIN1Mp2RQTRm1/i
         WS4bEgnqsMZU+jSXk7gKQ6Eh9+CFDnTiJfw4gJc1LYyPnEZql9qggZ57Tc9CmsLrmLOz
         V1cBQ3pEP/qiWidHpbnBh1FDixGV/zjvbydTkdVWnI9rnoX+/NGy9DcetRJJQDsgvg/Y
         dRuAmQgjloygJxmPpMe0cyd4A58nejomj8Vw3M7FjMq/Pqf4h6XE56DwWkq6rSh7BvPV
         uiebM/ZPyq/g6us2+l1Xk7+LbdIRR7UwUpwqIRk8i1JYyn4k1mz9U00qYmcHXXUuDCni
         TvoQ==
X-Gm-Message-State: AOAM530ZUI5pibOi3sZmf5cp/1JTSTyu5u6CdvsyXxN7zLd5gjWK6uTr
        fG2G6Qb8shVpxHupJab21Aw=
X-Google-Smtp-Source: ABdhPJxaajBP1wZxh/cNev7TD+7syKbaVCwqBJztpPaX2/UmhKpITbk2Xed6yt4xd7nKDAl96aF8OA==
X-Received: by 2002:a17:902:e5ca:b0:152:54c1:f860 with SMTP id u10-20020a170902e5ca00b0015254c1f860mr184865plf.35.1646739743783;
        Tue, 08 Mar 2022 03:42:23 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090ac40200b001bd0e552d27sm2578285pjt.11.2022.03.08.03.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 03:42:23 -0800 (PST)
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
Subject: [RFC PATCH v1 02/15] mm/sl[auo]b: remove CONFIG_NUMA ifdefs for common functions
Date:   Tue,  8 Mar 2022 11:41:29 +0000
Message-Id: <20220308114142.1744229-3-42.hyeyoo@gmail.com>
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

Now that slab_alloc_node() is available regardless of CONFIG_NUMA
on SLAB, just remove CONFIG_NUMA ifdefs and make non-NUMA version
of functions wrapper of NUMA version.

This makes slab allocators use NUMA version of tracepoints.
In later patch, tracepoints will be also cleaned up.

Remove now unused __do_kmalloc() in SLAB.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 include/linux/slab.h | 85 ++++++++++++++++++--------------------------
 mm/slab.c            | 63 --------------------------------
 mm/slob.c            | 22 ------------
 mm/slub.c            | 62 --------------------------------
 4 files changed, 35 insertions(+), 197 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 37bde99b74af..df8e5dca00a2 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -414,8 +414,31 @@ static __always_inline unsigned int __kmalloc_index(size_t size,
 #define kmalloc_index(s) __kmalloc_index(s, true)
 #endif /* !CONFIG_SLOB */
 
-void *__kmalloc(size_t size, gfp_t flags) __assume_kmalloc_alignment __alloc_size(1);
-void *kmem_cache_alloc(struct kmem_cache *s, gfp_t flags) __assume_slab_alignment __malloc;
+void *__kmalloc_node(size_t size, gfp_t flags, int node) __assume_kmalloc_alignment
+							 __alloc_size(1);
+void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t flags, int node) __assume_slab_alignment
+									 __malloc;
+
+static __always_inline void *__kmalloc(size_t size, gfp_t flags)
+{
+	return __kmalloc_node(size, flags, NUMA_NO_NODE);
+}
+
+/**
+ * kmem_cache_alloc - Allocate an object
+ * @cachep: The cache to allocate from.
+ * @flags: See kmalloc().
+ *
+ * Allocate an object from this cache.  The flags are only relevant
+ * if the cache has no available objects.
+ *
+ * Return: pointer to the new object or %NULL in case of error
+ */
+static __always_inline void *kmem_cache_alloc(struct kmem_cache *s, gfp_t flags)
+{
+	return kmem_cache_alloc_node(s, flags, NUMA_NO_NODE);
+}
+
 void kmem_cache_free(struct kmem_cache *s, void *objp);
 
 /*
@@ -437,38 +460,13 @@ static __always_inline void kfree_bulk(size_t size, void **p)
 	kmem_cache_free_bulk(NULL, size, p);
 }
 
-#ifdef CONFIG_NUMA
-void *__kmalloc_node(size_t size, gfp_t flags, int node) __assume_kmalloc_alignment
-							 __alloc_size(1);
-void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t flags, int node) __assume_slab_alignment
-									 __malloc;
-#else
-static __always_inline __alloc_size(1) void *__kmalloc_node(size_t size, gfp_t flags, int node)
-{
-	return __kmalloc(size, flags);
-}
-
-static __always_inline void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t flags, int node)
-{
-	return kmem_cache_alloc(s, flags);
-}
-#endif
-
 #ifdef CONFIG_TRACING
 extern void *kmem_cache_alloc_trace(struct kmem_cache *s, gfp_t flags, size_t size)
 				   __assume_slab_alignment __alloc_size(3);
 
-#ifdef CONFIG_NUMA
 extern void *kmem_cache_alloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
 					 int node, size_t size) __assume_slab_alignment
 								__alloc_size(4);
-#else
-static __always_inline __alloc_size(4) void *kmem_cache_alloc_node_trace(struct kmem_cache *s,
-						 gfp_t gfpflags, int node, size_t size)
-{
-	return kmem_cache_alloc_trace(s, gfpflags, size);
-}
-#endif /* CONFIG_NUMA */
 
 #else /* CONFIG_TRACING */
 static __always_inline __alloc_size(3) void *kmem_cache_alloc_trace(struct kmem_cache *s,
@@ -652,19 +650,6 @@ static inline __alloc_size(1, 2) void *kcalloc(size_t n, size_t size, gfp_t flag
 	return kmalloc_array(n, size, flags | __GFP_ZERO);
 }
 
-/*
- * kmalloc_track_caller is a special version of kmalloc that records the
- * calling function of the routine calling it for slab leak tracking instead
- * of just the calling function (confusing, eh?).
- * It's useful when the call to kmalloc comes from a widely-used standard
- * allocator where we care about the real place the memory allocation
- * request comes from.
- */
-extern void *__kmalloc_track_caller(size_t size, gfp_t flags, unsigned long caller)
-				   __alloc_size(1);
-#define kmalloc_track_caller(size, flags) \
-	__kmalloc_track_caller(size, flags, _RET_IP_)
-
 static inline __alloc_size(1, 2) void *kmalloc_array_node(size_t n, size_t size, gfp_t flags,
 							  int node)
 {
@@ -682,21 +667,21 @@ static inline __alloc_size(1, 2) void *kcalloc_node(size_t n, size_t size, gfp_t
 	return kmalloc_array_node(n, size, flags | __GFP_ZERO, node);
 }
 
-
-#ifdef CONFIG_NUMA
 extern void *__kmalloc_node_track_caller(size_t size, gfp_t flags, int node,
 					 unsigned long caller) __alloc_size(1);
 #define kmalloc_node_track_caller(size, flags, node) \
 	__kmalloc_node_track_caller(size, flags, node, \
 			_RET_IP_)
-
-#else /* CONFIG_NUMA */
-
-#define kmalloc_node_track_caller(size, flags, node) \
-	kmalloc_track_caller(size, flags)
-
-#endif /* CONFIG_NUMA */
-
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
 /*
  * Shortcuts
  */
diff --git a/mm/slab.c b/mm/slab.c
index 5d102aaf1629..b41124a1efd9 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3468,27 +3468,6 @@ void ___cache_free(struct kmem_cache *cachep, void *objp,
 	__free_one(ac, objp);
 }
 
-/**
- * kmem_cache_alloc - Allocate an object
- * @cachep: The cache to allocate from.
- * @flags: See kmalloc().
- *
- * Allocate an object from this cache.  The flags are only relevant
- * if the cache has no available objects.
- *
- * Return: pointer to the new object or %NULL in case of error
- */
-void *kmem_cache_alloc(struct kmem_cache *cachep, gfp_t flags)
-{
-	void *ret = slab_alloc(cachep, flags, cachep->object_size, _RET_IP_);
-
-	trace_kmem_cache_alloc(_RET_IP_, ret,
-			       cachep->object_size, cachep->size, flags);
-
-	return ret;
-}
-EXPORT_SYMBOL(kmem_cache_alloc);
-
 static __always_inline void
 cache_alloc_debugcheck_after_bulk(struct kmem_cache *s, gfp_t flags,
 				  size_t size, void **p, unsigned long caller)
@@ -3556,7 +3535,6 @@ kmem_cache_alloc_trace(struct kmem_cache *cachep, gfp_t flags, size_t size)
 EXPORT_SYMBOL(kmem_cache_alloc_trace);
 #endif
 
-#ifdef CONFIG_NUMA
 /**
  * kmem_cache_alloc_node - Allocate an object on the specified node
  * @cachep: The cache to allocate from.
@@ -3630,7 +3608,6 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t flags,
 	return __do_kmalloc_node(size, flags, node, caller);
 }
 EXPORT_SYMBOL(__kmalloc_node_track_caller);
-#endif /* CONFIG_NUMA */
 
 #ifdef CONFIG_PRINTK
 void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
@@ -3654,46 +3631,6 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
 }
 #endif
 
-/**
- * __do_kmalloc - allocate memory
- * @size: how many bytes of memory are required.
- * @flags: the type of memory to allocate (see kmalloc).
- * @caller: function caller for debug tracking of the caller
- *
- * Return: pointer to the allocated memory or %NULL in case of error
- */
-static __always_inline void *__do_kmalloc(size_t size, gfp_t flags,
-					  unsigned long caller)
-{
-	struct kmem_cache *cachep;
-	void *ret;
-
-	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
-		return NULL;
-	cachep = kmalloc_slab(size, flags);
-	if (unlikely(ZERO_OR_NULL_PTR(cachep)))
-		return cachep;
-	ret = slab_alloc(cachep, flags, size, caller);
-
-	ret = kasan_kmalloc(cachep, ret, size, flags);
-	trace_kmalloc(caller, ret,
-		      size, cachep->size, flags);
-
-	return ret;
-}
-
-void *__kmalloc(size_t size, gfp_t flags)
-{
-	return __do_kmalloc(size, flags, _RET_IP_);
-}
-EXPORT_SYMBOL(__kmalloc);
-
-void *__kmalloc_track_caller(size_t size, gfp_t flags, unsigned long caller)
-{
-	return __do_kmalloc(size, flags, caller);
-}
-EXPORT_SYMBOL(__kmalloc_track_caller);
-
 /**
  * kmem_cache_free - Deallocate an object
  * @cachep: The cache the allocation was from.
diff --git a/mm/slob.c b/mm/slob.c
index 60c5842215f1..c4f9c83900b0 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -522,26 +522,12 @@ __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
 	return ret;
 }
 
-void *__kmalloc(size_t size, gfp_t gfp)
-{
-	return __do_kmalloc_node(size, gfp, NUMA_NO_NODE, _RET_IP_);
-}
-EXPORT_SYMBOL(__kmalloc);
-
-void *__kmalloc_track_caller(size_t size, gfp_t gfp, unsigned long caller)
-{
-	return __do_kmalloc_node(size, gfp, NUMA_NO_NODE, caller);
-}
-EXPORT_SYMBOL(__kmalloc_track_caller);
-
-#ifdef CONFIG_NUMA
 void *__kmalloc_node_track_caller(size_t size, gfp_t gfp,
 					int node, unsigned long caller)
 {
 	return __do_kmalloc_node(size, gfp, node, caller);
 }
 EXPORT_SYMBOL(__kmalloc_node_track_caller);
-#endif
 
 void kfree(const void *block)
 {
@@ -629,13 +615,6 @@ static void *slob_alloc_node(struct kmem_cache *c, gfp_t flags, int node)
 	return b;
 }
 
-void *kmem_cache_alloc(struct kmem_cache *cachep, gfp_t flags)
-{
-	return slob_alloc_node(cachep, flags, NUMA_NO_NODE);
-}
-EXPORT_SYMBOL(kmem_cache_alloc);
-
-#ifdef CONFIG_NUMA
 void *__kmalloc_node(size_t size, gfp_t gfp, int node)
 {
 	return __do_kmalloc_node(size, gfp, node, _RET_IP_);
@@ -647,7 +626,6 @@ void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t gfp, int node)
 	return slob_alloc_node(cachep, gfp, node);
 }
 EXPORT_SYMBOL(kmem_cache_alloc_node);
-#endif
 
 static void __kmem_cache_free(void *b, int size)
 {
diff --git a/mm/slub.c b/mm/slub.c
index 261474092e43..74369cadc243 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3238,17 +3238,6 @@ static __always_inline void *slab_alloc(struct kmem_cache *s,
 	return slab_alloc_node(s, gfpflags, NUMA_NO_NODE, addr, orig_size);
 }
 
-void *kmem_cache_alloc(struct kmem_cache *s, gfp_t gfpflags)
-{
-	void *ret = slab_alloc(s, gfpflags, _RET_IP_, s->object_size);
-
-	trace_kmem_cache_alloc(_RET_IP_, ret, s->object_size,
-				s->size, gfpflags);
-
-	return ret;
-}
-EXPORT_SYMBOL(kmem_cache_alloc);
-
 #ifdef CONFIG_TRACING
 void *kmem_cache_alloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
 {
@@ -3260,7 +3249,6 @@ void *kmem_cache_alloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
 EXPORT_SYMBOL(kmem_cache_alloc_trace);
 #endif
 
-#ifdef CONFIG_NUMA
 void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
 {
 	void *ret = slab_alloc_node(s, gfpflags, node, _RET_IP_, s->object_size);
@@ -3287,7 +3275,6 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *s,
 }
 EXPORT_SYMBOL(kmem_cache_alloc_node_trace);
 #endif
-#endif	/* CONFIG_NUMA */
 
 /*
  * Slow path handling. This may still be called frequently since objects
@@ -4404,30 +4391,6 @@ static int __init setup_slub_min_objects(char *str)
 
 __setup("slub_min_objects=", setup_slub_min_objects);
 
-void *__kmalloc(size_t size, gfp_t flags)
-{
-	struct kmem_cache *s;
-	void *ret;
-
-	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
-		return kmalloc_large(size, flags);
-
-	s = kmalloc_slab(size, flags);
-
-	if (unlikely(ZERO_OR_NULL_PTR(s)))
-		return s;
-
-	ret = slab_alloc(s, flags, _RET_IP_, size);
-
-	trace_kmalloc(_RET_IP_, ret, size, s->size, flags);
-
-	ret = kasan_kmalloc(s, ret, size, flags);
-
-	return ret;
-}
-EXPORT_SYMBOL(__kmalloc);
-
-#ifdef CONFIG_NUMA
 static void *kmalloc_large_node(size_t size, gfp_t flags, int node)
 {
 	struct page *page;
@@ -4474,7 +4437,6 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node)
 	return ret;
 }
 EXPORT_SYMBOL(__kmalloc_node);
-#endif	/* CONFIG_NUMA */
 
 #ifdef CONFIG_HARDENED_USERCOPY
 /*
@@ -4910,29 +4872,6 @@ int __kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
 	return 0;
 }
 
-void *__kmalloc_track_caller(size_t size, gfp_t gfpflags, unsigned long caller)
-{
-	struct kmem_cache *s;
-	void *ret;
-
-	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
-		return kmalloc_large(size, gfpflags);
-
-	s = kmalloc_slab(size, gfpflags);
-
-	if (unlikely(ZERO_OR_NULL_PTR(s)))
-		return s;
-
-	ret = slab_alloc(s, gfpflags, caller, size);
-
-	/* Honor the call site pointer we received. */
-	trace_kmalloc(caller, ret, size, s->size, gfpflags);
-
-	return ret;
-}
-EXPORT_SYMBOL(__kmalloc_track_caller);
-
-#ifdef CONFIG_NUMA
 void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
 					int node, unsigned long caller)
 {
@@ -4962,7 +4901,6 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
 	return ret;
 }
 EXPORT_SYMBOL(__kmalloc_node_track_caller);
-#endif
 
 #ifdef CONFIG_SYSFS
 static int count_inuse(struct slab *slab)
-- 
2.33.1


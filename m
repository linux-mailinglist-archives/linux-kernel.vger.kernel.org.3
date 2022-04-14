Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C17500906
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241371AbiDNJB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241413AbiDNJBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:01:12 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F276AA70
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:58:41 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id t12so4118531pll.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ZJfCekWiq8F6LeclLH2EX7WmH3vxid4PPYVPgU+XNY=;
        b=PyS26MG52EA2v+5qrmXqDD8CMoZcoJx9HU6Uai/EzLFXfEPQlmK2xSu8EsFyKnzVSW
         3vRReMigOKnc98w8pNi8tKC54o+q14hAA8NwSV3DbvPKBYWyRDFoE+ebTbuTSchT0Zx9
         4P83K+mYXIxDW9x2YNJ4sBykq30udXIWXw658qVKKmkARp591P0alHbjbtvxESJOoMYd
         Sgy4svqTChxrEFHi5x5fG11cpzi83w4dPdY0sZkCidu/P47e7SDNo3ufaA4JaYrgw2s6
         2RUtiVm5F6/lyqQB2PEZXTAFvrjq67heL6RXDPqkt3+DHuu4et/MFIEoMhk/ZhFSf3kd
         yXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ZJfCekWiq8F6LeclLH2EX7WmH3vxid4PPYVPgU+XNY=;
        b=OrUNR3RpvotwwCGYLgvEUea6nEj3mjoqdg2MjfoTkQZE4jHs4oF/F7EKFCeD+i5dvR
         dSuqUfttqoTYNjnYcuSXhE6HnVYOb7oBnnQCppGmNn9JVD9zccESxQmqMOgpPEqgAE8v
         gXlVu0rtT3vKLvjdpWh1eObokaBbJmNqA5s0kBYli1vFW61aHFt7BFlPUgysmji3RecU
         5maaPREImqVJWPqeb+NlkeqhFaGYeNV5l7+p+R/vZpd8cPLyBqf7dehI+leoF4kJTcEg
         aCGjBKSeIxP1tUXS7BjRXITb0ORdnATDyupNoqDvRh1O0OaRbIhJUPe0RIbeJfELITVZ
         Cywg==
X-Gm-Message-State: AOAM5301gN0jpyDPXykfUN8cwlk6m01iCANvSOOLGWLBHinExtY7MY7S
        Ff2tP2vfXUKvvg0b8JYSNsY=
X-Google-Smtp-Source: ABdhPJzgzBkSAWIuFJ1GQ7GPARwXR+mujiRe6H6Cuue9w2lWjEi1HI79ZBHiGxGceGxOZ0pObNzVAQ==
X-Received: by 2002:a17:902:e1d4:b0:158:91b8:edea with SMTP id t20-20020a170902e1d400b0015891b8edeamr10257201pla.167.1649926720992;
        Thu, 14 Apr 2022 01:58:40 -0700 (PDT)
Received: from hyeyoo.. ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id p9-20020aa79e89000000b00505fada20dfsm1403537pfq.117.2022.04.14.01.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:58:39 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/23] mm/slab_common: cleanup kmem_cache_alloc{,node,lru}
Date:   Thu, 14 Apr 2022 17:57:14 +0900
Message-Id: <20220414085727.643099-11-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220414085727.643099-1-42.hyeyoo@gmail.com>
References: <20220414085727.643099-1-42.hyeyoo@gmail.com>
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

Implement only __kmem_cache_alloc_node() in slab allocators and make
kmem_cache_alloc{,node,lru} wrapper of it.

Now that kmem_cache_alloc{,node,lru} is inline function, we should
use _THIS_IP_ instead of _RET_IP_ for consistency.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 include/linux/slab.h | 52 ++++++++++++++++++++++++++++++++-----
 mm/slab.c            | 61 +++++---------------------------------------
 mm/slob.c            | 27 ++++++--------------
 mm/slub.c            | 35 +++++--------------------
 4 files changed, 67 insertions(+), 108 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 143830f57a7f..1b5bdcb0fd31 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -429,9 +429,52 @@ void *__kmalloc(size_t size, gfp_t flags)
 	return __kmalloc_node(size, flags, NUMA_NO_NODE);
 }
 
-void *kmem_cache_alloc(struct kmem_cache *s, gfp_t flags) __assume_slab_alignment __malloc;
-void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
-			   gfp_t gfpflags) __assume_slab_alignment __malloc;
+
+void *__kmem_cache_alloc_node(struct kmem_cache *s, struct list_lru *lru,
+			   gfp_t gfpflags, int node, unsigned long caller __maybe_unused)
+			    __assume_slab_alignment __malloc;
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
+static __always_inline __malloc
+void *kmem_cache_alloc(struct kmem_cache *s, gfp_t flags)
+{
+	return __kmem_cache_alloc_node(s, NULL, flags, NUMA_NO_NODE, _THIS_IP_);
+}
+
+/**
+ * kmem_cache_alloc_node - Allocate an object on the specified node
+ * @s: The cache to allocate from.
+ * @flags: See kmalloc().
+ * @node: node number of the target node.
+ *
+ * Identical to kmem_cache_alloc but it will allocate memory on the given
+ * node, which can improve the performance for cpu bound structures.
+ *
+ * Fallback to other node is possible if __GFP_THISNODE is not set.
+ *
+ * Return: pointer to the new object or %NULL in case of error
+ */
+static __always_inline __malloc
+void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t flags, int node)
+{
+	return __kmem_cache_alloc_node(s, NULL, flags, node, _THIS_IP_);
+}
+
+static __always_inline __malloc
+void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru, gfp_t gfpflags)
+{
+	return __kmem_cache_alloc_node(s, lru, gfpflags, NUMA_NO_NODE, _THIS_IP_);
+}
+
 void kmem_cache_free(struct kmem_cache *s, void *objp);
 
 /*
@@ -453,9 +496,6 @@ static __always_inline void kfree_bulk(size_t size, void **p)
 	kmem_cache_free_bulk(NULL, size, p);
 }
 
-void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t flags, int node) __assume_slab_alignment
-									 __malloc;
-
 #ifdef CONFIG_TRACING
 extern void *kmem_cache_alloc_trace(struct kmem_cache *s, gfp_t flags, size_t size)
 				   __assume_slab_alignment __alloc_size(3);
diff --git a/mm/slab.c b/mm/slab.c
index db7eab9e2e9f..c5ffe54c207a 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3442,40 +3442,18 @@ void ___cache_free(struct kmem_cache *cachep, void *objp,
 	__free_one(ac, objp);
 }
 
-static __always_inline
-void *__kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru,
-			     gfp_t flags)
+void *__kmem_cache_alloc_node(struct kmem_cache *cachep, struct list_lru *lru,
+			      gfp_t flags, int nodeid, unsigned long caller)
 {
-	void *ret = slab_alloc(cachep, lru, flags, cachep->object_size, _RET_IP_);
+	void *ret = slab_alloc_node(cachep, lru, flags, nodeid,
+				    cachep->object_size, caller);
 
-	trace_kmem_cache_alloc(_RET_IP_, ret,
-			       cachep->object_size, cachep->size, flags);
+	trace_kmem_cache_alloc_node(caller, ret, cachep->object_size,
+				    cachep->size, flags, nodeid);
 
 	return ret;
 }
-
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
-	return __kmem_cache_alloc_lru(cachep, NULL, flags);
-}
-EXPORT_SYMBOL(kmem_cache_alloc);
-
-void *kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru,
-			   gfp_t flags)
-{
-	return __kmem_cache_alloc_lru(cachep, lru, flags);
-}
-EXPORT_SYMBOL(kmem_cache_alloc_lru);
+EXPORT_SYMBOL(__kmem_cache_alloc_node);
 
 static __always_inline void
 cache_alloc_debugcheck_after_bulk(struct kmem_cache *s, gfp_t flags,
@@ -3545,31 +3523,6 @@ kmem_cache_alloc_trace(struct kmem_cache *cachep, gfp_t flags, size_t size)
 EXPORT_SYMBOL(kmem_cache_alloc_trace);
 #endif
 
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
-{
-	void *ret = slab_alloc_node(cachep, NULL, flags, nodeid, cachep->object_size, _RET_IP_);
-
-	trace_kmem_cache_alloc_node(_RET_IP_, ret,
-				    cachep->object_size, cachep->size,
-				    flags, nodeid);
-
-	return ret;
-}
-EXPORT_SYMBOL(kmem_cache_alloc_node);
-
 #ifdef CONFIG_TRACING
 void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
 				  gfp_t flags,
diff --git a/mm/slob.c b/mm/slob.c
index ab67c8219e8d..6c7c30845056 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -586,7 +586,8 @@ int __kmem_cache_create(struct kmem_cache *c, slab_flags_t flags)
 	return 0;
 }
 
-static void *slob_alloc_node(struct kmem_cache *c, gfp_t flags, int node)
+static void *slob_alloc_node(struct kmem_cache *c, gfp_t flags, int node,
+			     unsigned long caller)
 {
 	void *b;
 
@@ -596,12 +597,12 @@ static void *slob_alloc_node(struct kmem_cache *c, gfp_t flags, int node)
 
 	if (c->size < PAGE_SIZE) {
 		b = slob_alloc(c->size, flags, c->align, node, 0);
-		trace_kmem_cache_alloc_node(_RET_IP_, b, c->object_size,
+		trace_kmem_cache_alloc_node(caller, b, c->object_size,
 					    SLOB_UNITS(c->size) * SLOB_UNIT,
 					    flags, node);
 	} else {
 		b = slob_new_pages(flags, get_order(c->size), node);
-		trace_kmem_cache_alloc_node(_RET_IP_, b, c->object_size,
+		trace_kmem_cache_alloc_node(caller, b, c->object_size,
 					    PAGE_SIZE << get_order(c->size),
 					    flags, node);
 	}
@@ -615,30 +616,18 @@ static void *slob_alloc_node(struct kmem_cache *c, gfp_t flags, int node)
 	return b;
 }
 
-void *kmem_cache_alloc(struct kmem_cache *cachep, gfp_t flags)
-{
-	return slob_alloc_node(cachep, flags, NUMA_NO_NODE);
-}
-EXPORT_SYMBOL(kmem_cache_alloc);
-
-
-void *kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru, gfp_t flags)
-{
-	return slob_alloc_node(cachep, flags, NUMA_NO_NODE);
-}
-EXPORT_SYMBOL(kmem_cache_alloc_lru);
-
 void *__kmalloc_node(size_t size, gfp_t gfp, int node)
 {
 	return __do_kmalloc_node(size, gfp, node, _RET_IP_);
 }
 EXPORT_SYMBOL(__kmalloc_node);
 
-void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t gfp, int node)
+void *__kmem_cache_alloc_node(struct kmem_cache *cachep, struct list_lru *lru __maybe_unused,
+			      gfp_t gfp, int node, unsigned long caller __maybe_unused)
 {
-	return slob_alloc_node(cachep, gfp, node);
+	return slob_alloc_node(cachep, gfp, node, caller);
 }
-EXPORT_SYMBOL(kmem_cache_alloc_node);
+EXPORT_SYMBOL(__kmem_cache_alloc_node);
 
 static void __kmem_cache_free(void *b, int size)
 {
diff --git a/mm/slub.c b/mm/slub.c
index f10a892f1772..2a2be2a8a5d0 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3216,30 +3216,6 @@ static __always_inline void *slab_alloc(struct kmem_cache *s, struct list_lru *l
 	return slab_alloc_node(s, lru, gfpflags, NUMA_NO_NODE, addr, orig_size);
 }
 
-static __always_inline
-void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
-			     gfp_t gfpflags)
-{
-	void *ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);
-
-	trace_kmem_cache_alloc(_RET_IP_, ret, s->object_size,
-				s->size, gfpflags);
-
-	return ret;
-}
-
-void *kmem_cache_alloc(struct kmem_cache *s, gfp_t gfpflags)
-{
-	return __kmem_cache_alloc_lru(s, NULL, gfpflags);
-}
-EXPORT_SYMBOL(kmem_cache_alloc);
-
-void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
-			   gfp_t gfpflags)
-{
-	return __kmem_cache_alloc_lru(s, lru, gfpflags);
-}
-EXPORT_SYMBOL(kmem_cache_alloc_lru);
 
 #ifdef CONFIG_TRACING
 void *kmem_cache_alloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
@@ -3252,16 +3228,17 @@ void *kmem_cache_alloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
 EXPORT_SYMBOL(kmem_cache_alloc_trace);
 #endif
 
-void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
+void *__kmem_cache_alloc_node(struct kmem_cache *s, struct list_lru *lru, gfp_t gfpflags,
+			      int node, unsigned long caller __maybe_unused)
 {
-	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, s->object_size);
+	void *ret = slab_alloc_node(s, lru, gfpflags, node, caller, s->object_size);
 
-	trace_kmem_cache_alloc_node(_RET_IP_, ret,
-				    s->object_size, s->size, gfpflags, node);
+	trace_kmem_cache_alloc_node(caller, ret, s->object_size,
+				    s->size, gfpflags, node);
 
 	return ret;
 }
-EXPORT_SYMBOL(kmem_cache_alloc_node);
+EXPORT_SYMBOL(__kmem_cache_alloc_node);
 
 #ifdef CONFIG_TRACING
 void *kmem_cache_alloc_node_trace(struct kmem_cache *s,
-- 
2.32.0


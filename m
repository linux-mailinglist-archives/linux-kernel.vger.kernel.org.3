Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A81596CBC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 12:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239000AbiHQKTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 06:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238994AbiHQKTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:19:41 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512F77C307
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:19:24 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id ch17-20020a17090af41100b001fa74771f61so3279093pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=paupgt1G6cH3RqeKhiTalrXFR+ytTeKPfHkaPAB0YdA=;
        b=bK1aYHR1zgO31MEYMp0z27Z1q5eFMJ+tzZkZPU/xUi7QSEqc9gJgYHZt9kOlcxyZiS
         l7ibFrX6CclG1r7qw3jgmSgOkKp/IdIrlIVH9ewekQmF9WODMD0nStvwZw7chdKQEsRo
         uY/mDnL/2e/Ac/izgf03aEtmPtRgcUeBJFudRS3LJlSPla97U7S29W0QH4L/lqMEpGpZ
         veX1hxijOV7f9qs7xnEiiXbnoobxzdA5MMvAKhA6uiRDKnGKAXdSpRhL+hzJGLvv4CDp
         rgA2OfPYtOnydhMw3vtTwO1eo/x8yi4gzdShPaxj1bvxTxnz7N7RRKksHrVlKaFyeEdq
         FdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=paupgt1G6cH3RqeKhiTalrXFR+ytTeKPfHkaPAB0YdA=;
        b=jylDK1bNMZkqWOwJb6Um9RfXM1/OV5FNF3LeSuOC1Q2CpZBDiUW/1uxsUVtxDuV48m
         pO2St3oROdgG8w7Jh04+JvTaOvIVz55HBmTH7uMntpoUVNRqWmjC5h2FdQOJqGp1hcU9
         7ekbzlxV7vE+zyaQ7cw8eXUQ/Xzkxa58Ow5xfvI91yBkZQaYjTKRsxM6++n864TBQVf0
         lGxCW4BQxc3OA1jKjlmfp4v/hOj8w7rfNFweQ2j1yh+1aOQ3X73pHZxJXJEwjBSmUPbp
         HGiU64XW3AO2g1b440f9WMtvcAhm7MQNWxTkoYOH9cCkJC8UQNRQ1YzgK49auI2UNKju
         /gNA==
X-Gm-Message-State: ACgBeo0eb9FU8+KUT0y9Td2ow2WTF1a+VVlaiiIIf3C1doj7KdFSSrIX
        /z4Isq/p7v0kgKY1eoQT2J0=
X-Google-Smtp-Source: AA6agR4LT57t3RNaykBg4K7+bvNe5zXr5bsxJoXJ3gs6cRtgISyVA95RK4nraz+NxdIVhKsWrJ/jeg==
X-Received: by 2002:a17:903:11c7:b0:171:2818:4cd7 with SMTP id q7-20020a17090311c700b0017128184cd7mr25306274plh.136.1660731563319;
        Wed, 17 Aug 2022 03:19:23 -0700 (PDT)
Received: from hyeyoo.. ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id d8-20020a170903230800b00172633fc236sm1071318plh.174.2022.08.17.03.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 03:19:22 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/17] mm/slab: kmalloc: pass requests larger than order-1 page to page allocator
Date:   Wed, 17 Aug 2022 19:18:19 +0900
Message-Id: <20220817101826.236819-11-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220817101826.236819-1-42.hyeyoo@gmail.com>
References: <20220817101826.236819-1-42.hyeyoo@gmail.com>
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

There is not much benefit for serving large objects in kmalloc().
Let's pass large requests to page allocator like SLUB for better
maintenance of common code.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slab.h | 23 ++++-------------
 mm/slab.c            | 60 +++++++++++++++++++++++++++++++-------------
 mm/slab.h            |  3 +++
 mm/slab_common.c     | 25 ++++++++++++------
 mm/slub.c            | 19 --------------
 5 files changed, 68 insertions(+), 62 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index fd2e129fc813..4ee5b2fed164 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -243,27 +243,17 @@ static inline unsigned int arch_slab_minalign(void)
 
 #ifdef CONFIG_SLAB
 /*
- * The largest kmalloc size supported by the SLAB allocators is
- * 32 megabyte (2^25) or the maximum allocatable page order if that is
- * less than 32 MB.
- *
- * WARNING: Its not easy to increase this value since the allocators have
- * to do various tricks to work around compiler limitations in order to
- * ensure proper constant folding.
+ * SLAB and SLUB directly allocates requests fitting in to an order-1 page
+ * (PAGE_SIZE*2).  Larger requests are passed to the page allocator.
  */
-#define KMALLOC_SHIFT_HIGH	((MAX_ORDER + PAGE_SHIFT - 1) <= 25 ? \
-				(MAX_ORDER + PAGE_SHIFT - 1) : 25)
-#define KMALLOC_SHIFT_MAX	KMALLOC_SHIFT_HIGH
+#define KMALLOC_SHIFT_HIGH	(PAGE_SHIFT + 1)
+#define KMALLOC_SHIFT_MAX	(MAX_ORDER + PAGE_SHIFT - 1)
 #ifndef KMALLOC_SHIFT_LOW
 #define KMALLOC_SHIFT_LOW	5
 #endif
 #endif
 
 #ifdef CONFIG_SLUB
-/*
- * SLUB directly allocates requests fitting in to an order-1 page
- * (PAGE_SIZE*2).  Larger requests are passed to the page allocator.
- */
 #define KMALLOC_SHIFT_HIGH	(PAGE_SHIFT + 1)
 #define KMALLOC_SHIFT_MAX	(MAX_ORDER + PAGE_SHIFT - 1)
 #ifndef KMALLOC_SHIFT_LOW
@@ -415,10 +405,6 @@ static __always_inline unsigned int __kmalloc_index(size_t size,
 	if (size <= 512 * 1024) return 19;
 	if (size <= 1024 * 1024) return 20;
 	if (size <=  2 * 1024 * 1024) return 21;
-	if (size <=  4 * 1024 * 1024) return 22;
-	if (size <=  8 * 1024 * 1024) return 23;
-	if (size <=  16 * 1024 * 1024) return 24;
-	if (size <=  32 * 1024 * 1024) return 25;
 
 	if (!IS_ENABLED(CONFIG_PROFILE_ALL_BRANCHES) && size_is_constant)
 		BUILD_BUG_ON_MSG(1, "unexpected size in kmalloc_index()");
@@ -428,6 +414,7 @@ static __always_inline unsigned int __kmalloc_index(size_t size,
 	/* Will never be reached. Needed because the compiler may complain */
 	return -1;
 }
+static_assert(PAGE_SHIFT <= 20);
 #define kmalloc_index(s) __kmalloc_index(s, true)
 #endif /* !CONFIG_SLOB */
 
diff --git a/mm/slab.c b/mm/slab.c
index 8c08d7f3dead..10c9af904410 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3585,11 +3585,19 @@ __do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
 	struct kmem_cache *cachep;
 	void *ret;
 
-	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
-		return NULL;
+	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
+		ret = kmalloc_large_node_notrace(size, flags, node);
+
+		trace_kmalloc_node(caller, ret, NULL, size,
+				   PAGE_SIZE << get_order(size),
+				   flags, node);
+		return ret;
+	}
+
 	cachep = kmalloc_slab(size, flags);
 	if (unlikely(ZERO_OR_NULL_PTR(cachep)))
 		return cachep;
+
 	ret = kmem_cache_alloc_node_trace(cachep, flags, node, size);
 	ret = kasan_kmalloc(cachep, ret, size, flags);
 
@@ -3664,17 +3672,27 @@ EXPORT_SYMBOL(kmem_cache_free);
 
 void kmem_cache_free_bulk(struct kmem_cache *orig_s, size_t size, void **p)
 {
-	struct kmem_cache *s;
-	size_t i;
 
 	local_irq_disable();
-	for (i = 0; i < size; i++) {
+	for (int i = 0; i < size; i++) {
 		void *objp = p[i];
+		struct kmem_cache *s;
 
-		if (!orig_s) /* called via kfree_bulk */
-			s = virt_to_cache(objp);
-		else
+		if (!orig_s) {
+			struct folio *folio = virt_to_folio(objp);
+
+			/* called via kfree_bulk */
+			if (!folio_test_slab(folio)) {
+				local_irq_enable();
+				free_large_kmalloc(folio, objp);
+				local_irq_disable();
+				continue;
+			}
+			s = folio_slab(folio)->slab_cache;
+		} else {
 			s = cache_from_obj(orig_s, objp);
+		}
+
 		if (!s)
 			continue;
 
@@ -3703,20 +3721,24 @@ void kfree(const void *objp)
 {
 	struct kmem_cache *c;
 	unsigned long flags;
+	struct folio *folio;
 
 	trace_kfree(_RET_IP_, objp);
 
 	if (unlikely(ZERO_OR_NULL_PTR(objp)))
 		return;
-	local_irq_save(flags);
-	kfree_debugcheck(objp);
-	c = virt_to_cache(objp);
-	if (!c) {
-		local_irq_restore(flags);
+
+	folio = virt_to_folio(objp);
+	if (!folio_test_slab(folio)) {
+		free_large_kmalloc(folio, (void *)objp);
 		return;
 	}
-	debug_check_no_locks_freed(objp, c->object_size);
 
+	c = folio_slab(folio)->slab_cache;
+
+	local_irq_save(flags);
+	kfree_debugcheck(objp);
+	debug_check_no_locks_freed(objp, c->object_size);
 	debug_check_no_obj_freed(objp, c->object_size);
 	__cache_free(c, (void *)objp, _RET_IP_);
 	local_irq_restore(flags);
@@ -4138,15 +4160,17 @@ void __check_heap_object(const void *ptr, unsigned long n,
 size_t __ksize(const void *objp)
 {
 	struct kmem_cache *c;
-	size_t size;
+	struct folio *folio;
 
 	BUG_ON(!objp);
 	if (unlikely(objp == ZERO_SIZE_PTR))
 		return 0;
 
-	c = virt_to_cache(objp);
-	size = c ? c->object_size : 0;
+	folio = virt_to_folio(objp);
+	if (!folio_test_slab(folio))
+		return folio_size(folio);
 
-	return size;
+	c = folio_slab(folio)->slab_cache;
+	return c->object_size;
 }
 EXPORT_SYMBOL(__ksize);
diff --git a/mm/slab.h b/mm/slab.h
index 40322bcf07be..381ba3e6b2a1 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -660,6 +660,9 @@ static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
 		print_tracking(cachep, x);
 	return cachep;
 }
+
+void free_large_kmalloc(struct folio *folio, void *object);
+
 #endif /* CONFIG_SLOB */
 
 static inline size_t slab_ksize(const struct kmem_cache *s)
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 51ccd0545816..5a2e81f42ee9 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -744,8 +744,8 @@ struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags)
 
 /*
  * kmalloc_info[] is to make slub_debug=,kmalloc-xx option work at boot time.
- * kmalloc_index() supports up to 2^25=32MB, so the final entry of the table is
- * kmalloc-32M.
+ * kmalloc_index() supports up to 2^21=2MB, so the final entry of the table is
+ * kmalloc-2M.
  */
 const struct kmalloc_info_struct kmalloc_info[] __initconst = {
 	INIT_KMALLOC_INFO(0, 0),
@@ -769,11 +769,7 @@ const struct kmalloc_info_struct kmalloc_info[] __initconst = {
 	INIT_KMALLOC_INFO(262144, 256k),
 	INIT_KMALLOC_INFO(524288, 512k),
 	INIT_KMALLOC_INFO(1048576, 1M),
-	INIT_KMALLOC_INFO(2097152, 2M),
-	INIT_KMALLOC_INFO(4194304, 4M),
-	INIT_KMALLOC_INFO(8388608, 8M),
-	INIT_KMALLOC_INFO(16777216, 16M),
-	INIT_KMALLOC_INFO(33554432, 32M)
+	INIT_KMALLOC_INFO(2097152, 2M)
 };
 
 /*
@@ -886,6 +882,21 @@ void __init create_kmalloc_caches(slab_flags_t flags)
 	/* Kmalloc array is now usable */
 	slab_state = UP;
 }
+
+void free_large_kmalloc(struct folio *folio, void *object)
+{
+	unsigned int order = folio_order(folio);
+
+	if (WARN_ON_ONCE(order == 0))
+		pr_warn_once("object pointer: 0x%p\n", object);
+
+	kmemleak_free(object);
+	kasan_kfree_large(object);
+
+	mod_lruvec_page_state(folio_page(folio, 0), NR_SLAB_UNRECLAIMABLE_B,
+			      -(PAGE_SIZE << order));
+	__free_pages(folio_page(folio, 0), order);
+}
 #endif /* !CONFIG_SLOB */
 
 gfp_t kmalloc_fix_flags(gfp_t flags)
diff --git a/mm/slub.c b/mm/slub.c
index 165fe87af204..a659874c5d44 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1704,12 +1704,6 @@ static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
  * Hooks for other subsystems that check memory allocations. In a typical
  * production configuration these hooks all should produce no code at all.
  */
-static __always_inline void kfree_hook(void *x)
-{
-	kmemleak_free(x);
-	kasan_kfree_large(x);
-}
-
 static __always_inline bool slab_free_hook(struct kmem_cache *s,
 						void *x, bool init)
 {
@@ -3550,19 +3544,6 @@ struct detached_freelist {
 	struct kmem_cache *s;
 };
 
-static inline void free_large_kmalloc(struct folio *folio, void *object)
-{
-	unsigned int order = folio_order(folio);
-
-	if (WARN_ON_ONCE(order == 0))
-		pr_warn_once("object pointer: 0x%p\n", object);
-
-	kfree_hook(object);
-	mod_lruvec_page_state(folio_page(folio, 0), NR_SLAB_UNRECLAIMABLE_B,
-			      -(PAGE_SIZE << order));
-	__free_pages(folio_page(folio, 0), order);
-}
-
 /*
  * This function progressively scans the array with free objects (with
  * a limited look ahead) and extract objects belonging to the same
-- 
2.32.0


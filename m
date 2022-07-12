Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970FE571B85
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiGLNlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbiGLNkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:40:37 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67513B7D50
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:40:27 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id f11so7285525plr.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UEhl6T7JwJfq9mYpwmLIICqK7OGzKtmxP+Xgk7Rgr5I=;
        b=VfzlsmyPKS4RGFcclo5FLhS8osdWOEhR+Jqwqhr/QM+QUjAEvcd+RyOT/erFEEtYxH
         uHNrqffbyv2dEjbzq4CEBS8CKZiDVv8Y3uodO4BrgFFj8JBOFe25LP3YNYwGkF2V7R5F
         C9VtW37dvIobXngEBKRhJkMkby4c/TSC4IuO9ZhD9xCdV+j0nzGi8DzBD2K5r9URcyqN
         B5QUKHRR1Fh8zmQi5hh2DMH0tA4H3dGOo5qDx9P8aaKpvDSDk13O0mAOFBPBhvXABk3D
         fAh0k8aqOFuMa0NGkLZqju70Csp2Y+y4qyiWnZDcvvcVYjVlgYYyHoDYZhyUFDS1OyfG
         xF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UEhl6T7JwJfq9mYpwmLIICqK7OGzKtmxP+Xgk7Rgr5I=;
        b=5FE6b4WKcq6G8Ztnm0+Ob7tBrfKsuqjgF16Hj9mSWEEmgJu/8RFNd8syl2UM5HoE3h
         QlukApJFU/bkYAUKNYe9kDznzX0pBz95wixPSSeli0ykxJ8kRiaXRpVrD4PSa01JBmYR
         Hg6BHFspC47qAG9GKCvkjTsgylno4GzL3aGoyKB+BBzWJqBd0ItKDLZHt+KWgevSHY6+
         9+gkpxThTrWhUDdERmpeGyijfTe7trp7cFkx/hYi4EbqO0E8RADpu7UpFguaF3YrjSNz
         A61OHv//AM06f9EpPREn+0oylx5pkzEUoY1Y7s6b4PxE8RTvK2T33JKNz5gI5BvfrXcB
         DJQQ==
X-Gm-Message-State: AJIora+35hnCYP/miUwOEl7IF/tXcRNOHelNiyIiESNH0SMmyxJ1U9p3
        jdVfmSsYFxtcNUZoUMxxw/I=
X-Google-Smtp-Source: AGRyM1uCSfhNnwjw6E02QINgM8ULAMKmayJizjx5NtuRwfakBCV/YUViYbSAwoVZxFy75U3AgNSEcw==
X-Received: by 2002:a17:902:a9c9:b0:161:5b73:5ac9 with SMTP id b9-20020a170902a9c900b001615b735ac9mr23919033plr.14.1657633226853;
        Tue, 12 Jul 2022 06:40:26 -0700 (PDT)
Received: from ip-172-31-24-42.ap-northeast-1.compute.internal (ec2-35-75-15-180.ap-northeast-1.compute.amazonaws.com. [35.75.15.180])
        by smtp.gmail.com with ESMTPSA id r6-20020aa79886000000b0052ae3bcb807sm1947178pfl.188.2022.07.12.06.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 06:40:26 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Joe Perches <joe@perches.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        Matthew WilCox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v3 10/15] mm/slab: kmalloc: pass requests larger than order-1 page to page allocator
Date:   Tue, 12 Jul 2022 13:39:40 +0000
Message-Id: <20220712133946.307181-11-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220712133946.307181-1-42.hyeyoo@gmail.com>
References: <20220712133946.307181-1-42.hyeyoo@gmail.com>
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
---
v2->v3: 
	This patch is basically same but it now depends on
	kmalloc_large_node_notrace().

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
index ab34727d61b2..a2f43425a0ae 100644
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
index 7cb51ff44f0c..c81c92d421f1 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -669,6 +669,9 @@ static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
 		print_tracking(cachep, x);
 	return cachep;
 }
+
+void free_large_kmalloc(struct folio *folio, void *object);
+
 #endif /* CONFIG_SLOB */
 
 static inline size_t slab_ksize(const struct kmem_cache *s)
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 9c46e2f9589f..0dff46fb7193 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -771,8 +771,8 @@ struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags)
 
 /*
  * kmalloc_info[] is to make slub_debug=,kmalloc-xx option work at boot time.
- * kmalloc_index() supports up to 2^25=32MB, so the final entry of the table is
- * kmalloc-32M.
+ * kmalloc_index() supports up to 2^21=2MB, so the final entry of the table is
+ * kmalloc-2M.
  */
 const struct kmalloc_info_struct kmalloc_info[] __initconst = {
 	INIT_KMALLOC_INFO(0, 0),
@@ -796,11 +796,7 @@ const struct kmalloc_info_struct kmalloc_info[] __initconst = {
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
@@ -913,6 +909,21 @@ void __init create_kmalloc_caches(slab_flags_t flags)
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
index 3d02cf44adf7..6cb7ca27f3b7 100644
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
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCCA4D1678
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346572AbiCHLoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346566AbiCHLoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:44:03 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17A812603
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 03:42:46 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id cx5so16935379pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 03:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c/6FsH9M7AVD3jGPPCGPRjlLtrkmXgfcT3rZLTHDFFQ=;
        b=D95hcByh+lQtvolKIcyrASR0tOCSL6jj3KPZpRijEfknmUmSHlKzi8oDjcJT8KumHO
         ENfgR/VShuEYly+JJrWiGeeL9zcXgY7VVsooCeRXKEUEu8OdmzvlT/aymdhKXGMwGkhY
         ckzl1+jAdyNrulWA5Cx5dzZKUo/pUiRQ9rOGiNH4jJr8fb2zUfDG7cHYt+iXSNNT96EX
         6K87SmnL8jGZHbWy+Y3qhIqqQA6PKPHirqIrA/Yx5/bx8qHI9p5zNMLnH/87thVJ20mi
         FbjemkNc1RY2vrSrCJguYriVWF4CsvUyth8O1NomYi+KSHlFnZp+ojfwZbVHo/9q/t2w
         IRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c/6FsH9M7AVD3jGPPCGPRjlLtrkmXgfcT3rZLTHDFFQ=;
        b=DJJxOtLA1OpHhP6oKq/WM+OmjnIO6KV6hYsJHOFBUbkKtSUytmwF2YFMZGdfczORDj
         ZM33Ga7vWcdT7baLPRSmhtquBd02OIQgNJLUeu2aAf6Q2nocsxV4y/2AQh2dv0sGbzri
         128GLm3sUiwlpgRoXKrgbioEVgeWYRrLUX+AXMjUMBe49V6a95hRIMOi0ZvHI0/dGM4v
         QYD5uhy3ROfgnOnO1l08VYK40OBJ5nPbVF48iEYo/cjqK9TYdmNIU/M3fkuvAvvE1Izz
         WksjV++bUVOX2TLWQmZoJszG/yYQQ7TVR0wrC2AUV9pM6xCnUCGztxMB+5F/A3Prc2CB
         d+pQ==
X-Gm-Message-State: AOAM5313y9QbE/srJ83nDq2CD7l9UhGwrGS7HmoDhu9sm5TAPtYt0OF4
        jfJZ9Dy1CuPxQzXKHNRCbK8=
X-Google-Smtp-Source: ABdhPJx5PZlsfmmsghAY5+JfSGQI2qk5dKdlXSn1QyQVWvD43D9f/JLoOERpbkm4fs7Az/jKgv1VSg==
X-Received: by 2002:a17:90b:517:b0:1be:dde4:f848 with SMTP id r23-20020a17090b051700b001bedde4f848mr4179725pjz.233.1646739766216;
        Tue, 08 Mar 2022 03:42:46 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090ac40200b001bd0e552d27sm2578285pjt.11.2022.03.08.03.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 03:42:45 -0800 (PST)
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
Subject: [RFC PATCH v1 09/15] mm/slab: kmalloc: pass requests larger than order-1 page to page allocator
Date:   Tue,  8 Mar 2022 11:41:36 +0000
Message-Id: <20220308114142.1744229-10-42.hyeyoo@gmail.com>
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

There is not much benefit for serving large objects in kmalloc().
Let's pass large requests to page allocator like SLUB for better
maintenance of common code.

[ vbabka@suse.cz: Enable and disable irq around free_large_kmalloc().
  Do not lose NUMA locality in __do_kmalloc_node().
  Use folio_slab(folio)->slab_cache instead of virt_to_cache().
  Remove large sizes in __kmalloc_index(). ]

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 include/linux/slab.h | 23 +++++-----------------
 mm/slab.c            | 45 ++++++++++++++++++++++++++++++--------------
 mm/slab.h            |  3 +++
 mm/slab_common.c     | 25 +++++++++++++++++-------
 mm/slub.c            | 19 -------------------
 5 files changed, 57 insertions(+), 58 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index dfcc8301d969..9ced225a3ea3 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -226,27 +226,17 @@ void kmem_dump_obj(void *object);
 
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
@@ -398,10 +388,6 @@ static __always_inline unsigned int __kmalloc_index(size_t size,
 	if (size <= 512 * 1024) return 19;
 	if (size <= 1024 * 1024) return 20;
 	if (size <=  2 * 1024 * 1024) return 21;
-	if (size <=  4 * 1024 * 1024) return 22;
-	if (size <=  8 * 1024 * 1024) return 23;
-	if (size <=  16 * 1024 * 1024) return 24;
-	if (size <=  32 * 1024 * 1024) return 25;
 
 	if (!IS_ENABLED(CONFIG_PROFILE_ALL_BRANCHES) && size_is_constant)
 		BUILD_BUG_ON_MSG(1, "unexpected size in kmalloc_index()");
@@ -411,6 +397,7 @@ static __always_inline unsigned int __kmalloc_index(size_t size,
 	/* Will never be reached. Needed because the compiler may complain */
 	return -1;
 }
+static_assert(PAGE_SHIFT <= 20);
 #define kmalloc_index(s) __kmalloc_index(s, true)
 #endif /* !CONFIG_SLOB */
 
diff --git a/mm/slab.c b/mm/slab.c
index 6ebf509bf2de..f0041f0125ba 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3568,7 +3568,7 @@ __do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
 	void *ret;
 
 	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
-		return NULL;
+		return kmalloc_large_node(size, flags, node);
 	cachep = kmalloc_slab(size, flags);
 	if (unlikely(ZERO_OR_NULL_PTR(cachep)))
 		return cachep;
@@ -3642,15 +3642,25 @@ void kmem_cache_free_bulk(struct kmem_cache *orig_s, size_t size, void **p)
 {
 	struct kmem_cache *s;
 	size_t i;
+	struct folio *folio;
 
 	local_irq_disable();
 	for (i = 0; i < size; i++) {
 		void *objp = p[i];
 
-		if (!orig_s) /* called via kfree_bulk */
-			s = virt_to_cache(objp);
-		else
+		if (!orig_s) {
+			folio = virt_to_folio(objp);
+			/* called via kfree_bulk */
+			if (!folio_test_slab(folio)) {
+				local_irq_enable();
+				free_large_kmalloc(folio, objp);
+				local_irq_disable();
+				continue;
+			}
+			s = folio_slab(folio)->slab_cache;
+		} else
 			s = cache_from_obj(orig_s, objp);
+
 		if (!s)
 			continue;
 
@@ -3679,20 +3689,25 @@ void kfree(const void *objp)
 {
 	struct kmem_cache *c;
 	unsigned long flags;
+	struct folio *folio;
+	void *x = (void *) objp;
 
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
+		free_large_kmalloc(folio, x);
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
@@ -4114,15 +4129,17 @@ void __check_heap_object(const void *ptr, unsigned long n,
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
index c7f2abc2b154..eb6e26784d69 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -664,6 +664,9 @@ static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
 		print_tracking(cachep, x);
 	return cachep;
 }
+
+void free_large_kmalloc(struct folio *folio, void *object);
+
 #endif /* CONFIG_SLOB */
 
 static inline size_t slab_ksize(const struct kmem_cache *s)
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 1fe2f2a7326d..af67005a151f 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -759,8 +759,8 @@ struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags)
 
 /*
  * kmalloc_info[] is to make slub_debug=,kmalloc-xx option work at boot time.
- * kmalloc_index() supports up to 2^25=32MB, so the final entry of the table is
- * kmalloc-32M.
+ * kmalloc_index() supports up to 2^21=2MB, so the final entry of the table is
+ * kmalloc-2M.
  */
 const struct kmalloc_info_struct kmalloc_info[] __initconst = {
 	INIT_KMALLOC_INFO(0, 0),
@@ -784,11 +784,7 @@ const struct kmalloc_info_struct kmalloc_info[] __initconst = {
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
 	}
 #endif
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
index d8fb987ff7e0..283c4ac92ffe 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1678,12 +1678,6 @@ static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
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
@@ -3501,19 +3495,6 @@ struct detached_freelist {
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
2.33.1


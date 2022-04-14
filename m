Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8340E500930
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241373AbiDNJEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241453AbiDNJBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:01:24 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC02F6A03E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:58:59 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id c12-20020a17090a020c00b001cba1ebb20cso5848373pjc.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=anpXLhQ6pJWpmFj8SKm1BnkWTcdROH9kMWzOdPADW34=;
        b=LenyhKHFzD+n2vYe7925mlD8BIH5F+MaLSbAXusG6eUaQCPtXx6mhz+ylnS5SG4cbh
         lIzOAJ4kYKEswmVcWMxdBKIk9JvcgveLd6eW5tvJGFBzB2GBoBceuyM0veJTxsVl3d7v
         kCk4k5Yw/uGM1FBYsDq6pvALqwmvZ6mLj4pKR85OFlOT9JuL7TU/a0I2orbYwGaAGwD5
         ZI/5v60Avg044pNPCNtu88H4aV3Tdwov7MNM6WmkLfJD+nm5i0q9w0TU5bg40iwj2yWQ
         70wxiXOEPsVJlltigb4Et7SUYyAgktCjmUVnS2sAVHKml8F6xoGWGMS/SV4OgQQrGJNi
         AnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=anpXLhQ6pJWpmFj8SKm1BnkWTcdROH9kMWzOdPADW34=;
        b=VhBUh85eOaFTiF4pzbcNt8FvnIMvf9wNLpzoStbUf64Rf+jdKlXD10pDazwQil2a1D
         rOteZAaflwNtpKOIRy91Gn9ArGhwtV/dL5vYbgSI0WbKfOArQKzID+yFSksiD1jGdi3f
         TAUDu7SOxChNi7T/W3SuR0WLjwb0/owRsrjWpD9gU3rwONR13tNe3ZEn7ARy1T2+B/Hv
         xL8clawi2a+u5GG5bzIqmpoW+2Z5V+jfLSyf1hSYhoWeuCKieyVP65Ipz+x125wYuITl
         saS0d9mbQpwt/55f+9twBviwPtdAJ4ex54+c+5ByMWo17k66i+VeOxZs6c8rO1udDleU
         DM0Q==
X-Gm-Message-State: AOAM533L2xPSWzwII9e3Wz5LGEVl0yoSsAfrEu4LFmNjIabcVUcrXT3B
        Rn9+vx1VtdNFrFuf/jy9zlk=
X-Google-Smtp-Source: ABdhPJwHNxp2vapxB+MLkK7ET2sv+h8Elix+TFHRPcGof4ZmEDdRc7uB882QarF1ebs+ae78TNfHzg==
X-Received: by 2002:a17:90a:8b91:b0:1be:db25:eecd with SMTP id z17-20020a17090a8b9100b001bedb25eecdmr2634323pjn.10.1649926739224;
        Thu, 14 Apr 2022 01:58:59 -0700 (PDT)
Received: from hyeyoo.. ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id p9-20020aa79e89000000b00505fada20dfsm1403537pfq.117.2022.04.14.01.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:58:57 -0700 (PDT)
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
Subject: [PATCH v2 13/23] mm/slab: kmalloc: pass requests larger than order-1 page to page allocator
Date:   Thu, 14 Apr 2022 17:57:17 +0900
Message-Id: <20220414085727.643099-14-42.hyeyoo@gmail.com>
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

There is not much benefit for serving large objects in kmalloc().
Let's pass large requests to page allocator like SLUB for better
maintenance of common code.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---

Changes from previous series (Thanks to Vlastimil):
- Disable/Enable irqs around free_large_kmalloc()
- Do not lose NUMA locality in __do_kmalloc
- Some style fixes (use slab->slab_cache instead of virt_to_cache)
- Remove unsupported sizes in __kmalloc_index

Changes from v1:
- instead of defining varaible x, just casting to (void *) while calling free_large_kmalloc().


 include/linux/slab.h | 23 +++++------------------
 mm/slab.c            | 44 ++++++++++++++++++++++++++++++--------------
 mm/slab.h            |  3 +++
 mm/slab_common.c     | 25 ++++++++++++++++++-------
 mm/slub.c            | 19 -------------------
 5 files changed, 56 insertions(+), 58 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index ea168f8a248d..c8c82087c3f9 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -231,27 +231,17 @@ void kmem_dump_obj(void *object);
 
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
@@ -403,10 +393,6 @@ static __always_inline unsigned int __kmalloc_index(size_t size,
 	if (size <= 512 * 1024) return 19;
 	if (size <= 1024 * 1024) return 20;
 	if (size <=  2 * 1024 * 1024) return 21;
-	if (size <=  4 * 1024 * 1024) return 22;
-	if (size <=  8 * 1024 * 1024) return 23;
-	if (size <=  16 * 1024 * 1024) return 24;
-	if (size <=  32 * 1024 * 1024) return 25;
 
 	if (!IS_ENABLED(CONFIG_PROFILE_ALL_BRANCHES) && size_is_constant)
 		BUILD_BUG_ON_MSG(1, "unexpected size in kmalloc_index()");
@@ -416,6 +402,7 @@ static __always_inline unsigned int __kmalloc_index(size_t size,
 	/* Will never be reached. Needed because the compiler may complain */
 	return -1;
 }
+static_assert(PAGE_SHIFT <= 20);
 #define kmalloc_index(s) __kmalloc_index(s, true)
 #endif /* !CONFIG_SLOB */
 
diff --git a/mm/slab.c b/mm/slab.c
index b0aaca017f42..1dfe0f9d5882 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3533,7 +3533,7 @@ __do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
 	void *ret;
 
 	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
-		return NULL;
+		return kmalloc_large_node(size, flags, node);
 	cachep = kmalloc_slab(size, flags);
 	if (unlikely(ZERO_OR_NULL_PTR(cachep)))
 		return cachep;
@@ -3607,15 +3607,25 @@ void kmem_cache_free_bulk(struct kmem_cache *orig_s, size_t size, void **p)
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
 
@@ -3644,20 +3654,24 @@ void kfree(const void *objp)
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
@@ -4079,15 +4093,17 @@ void __check_heap_object(const void *ptr, unsigned long n,
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
index f7d018100994..b864c5bc4c25 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -681,6 +681,9 @@ static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
 		print_tracking(cachep, x);
 	return cachep;
 }
+
+void free_large_kmalloc(struct folio *folio, void *object);
+
 #endif /* CONFIG_SLOB */
 
 static inline size_t slab_ksize(const struct kmem_cache *s)
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 30684efc89d7..960cc07c3a91 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -764,8 +764,8 @@ struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags)
 
 /*
  * kmalloc_info[] is to make slub_debug=,kmalloc-xx option work at boot time.
- * kmalloc_index() supports up to 2^25=32MB, so the final entry of the table is
- * kmalloc-32M.
+ * kmalloc_index() supports up to 2^21=2MB, so the final entry of the table is
+ * kmalloc-2M.
  */
 const struct kmalloc_info_struct kmalloc_info[] __initconst = {
 	INIT_KMALLOC_INFO(0, 0),
@@ -789,11 +789,7 @@ const struct kmalloc_info_struct kmalloc_info[] __initconst = {
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
@@ -906,6 +902,21 @@ void __init create_kmalloc_caches(slab_flags_t flags)
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
index 892988990da7..1dc9e8eebb62 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1679,12 +1679,6 @@ static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
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
@@ -3490,19 +3484,6 @@ struct detached_freelist {
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


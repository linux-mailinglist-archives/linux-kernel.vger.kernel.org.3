Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42644CCDE2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 07:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238469AbiCDGgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 01:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238492AbiCDGgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 01:36:15 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19BF18CC5A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 22:34:44 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id cx5so6621347pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 22:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TVdYQpXFu0DWrIT8aY3Z6KXTWb1Uch1rx+HdjmDRFcE=;
        b=LsASEabx8/b3sjb/G+RHgJLKsqZzcmnsQpo7M0GFhPCRRcuFrPFU7DM1g1X9MwHM21
         PCXAVQsHx+MY8cnF0ZNt6zIq0IoAZxJ+YDgCqdORaHNDX7Fz8BwvxFmSI3Z+xQzxLh33
         BUyMjlWWgmy5H4BIxoTuTqf3UE5ZxGD7UwaXXV0XkkZ/t7lFPk5JmQnFpv5BflK6/4Xa
         rKVoS4CylYDxBNLDH1+HfxM1pKl0ZoCw1xFctB8g1uqKLagtbseDlW1WFBCZiHTwGO2N
         mZrCNFxqr5JLCxO3V2BqG1pVkczUxsM4IWh7nFxGKarULxMOmvPb/3v9bRDemWr79jBL
         YoEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TVdYQpXFu0DWrIT8aY3Z6KXTWb1Uch1rx+HdjmDRFcE=;
        b=Kc9u92y18j8+96p4YFV/joqk8WCw/fzdmOO07x+EEs9h7Ty+WnVO0qzCzUwz3ZuwJf
         RemP4U0cdyzCpAjj8N5P8zjyNgteLS4HWLsPpi1xupAhzXGnwzTwpJTwsXJ/a7p3/Krv
         9NfyUAGF5ts7hitpGkXPj05AQR/wlSW1eoTNPl21Ahft7pG/LSvEBd0hofs7yTNFQXvG
         zXqzkx06xtuEuK1+PLY+yKS/8psStH8ocvCY0mp4stSCAUPou+lFEpm5NFIFn6Q/GVyE
         F1KjwBiNhk9scR9PTeMHxZWCY6pTIMhoS3f0v3pyt2BjhuHEjYC00Gf8l+qIzug7jSao
         mA8A==
X-Gm-Message-State: AOAM530y7ansV+mWQRBhEcLjaAVZumuhTOZoFsMlm4OdRYB69zO4Mg+W
        FmoNPAtO1+v1BFH9+GlBR2w=
X-Google-Smtp-Source: ABdhPJwrb7HJV9HhwNvNZ4oa0OmTF8RoFPyx59jmPxqApPtPntlDOJEcyLgJkbpsXbKA494+Pn+H8w==
X-Received: by 2002:a17:90a:9306:b0:1bc:9256:5477 with SMTP id p6-20020a17090a930600b001bc92565477mr9339370pjo.170.1646375684474;
        Thu, 03 Mar 2022 22:34:44 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id v10-20020a056a00148a00b004e0f420dd90sm4900007pfu.40.2022.03.03.22.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 22:34:44 -0800 (PST)
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
Subject: [PATCH v2 1/5] mm/slab: kmalloc: pass requests larger than order-1 page to page allocator
Date:   Fri,  4 Mar 2022 06:34:23 +0000
Message-Id: <20220304063427.372145-2-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220304063427.372145-1-42.hyeyoo@gmail.com>
References: <20220304063427.372145-1-42.hyeyoo@gmail.com>
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
 include/linux/slab.h | 35 ++++++++++++++++-------------------
 mm/slab.c            | 31 +++++++++++++++++++++++++++----
 mm/slab.h            | 19 +++++++++++++++++++
 mm/slub.c            | 19 -------------------
 4 files changed, 62 insertions(+), 42 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 37bde99b74af..e7b3330db4f3 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -224,29 +224,19 @@ void kmem_dump_obj(void *object);
  * Kmalloc array related definitions
  */
 
-#ifdef CONFIG_SLAB
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
+#ifdef CONFIG_SLAB
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
@@ -564,15 +554,15 @@ static __always_inline __alloc_size(1) void *kmalloc_large(size_t size, gfp_t fl
  *	Try really hard to succeed the allocation but fail
  *	eventually.
  */
+#ifndef CONFIG_SLOB
 static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
 {
 	if (__builtin_constant_p(size)) {
-#ifndef CONFIG_SLOB
 		unsigned int index;
-#endif
+
 		if (size > KMALLOC_MAX_CACHE_SIZE)
 			return kmalloc_large(size, flags);
-#ifndef CONFIG_SLOB
+
 		index = kmalloc_index(size);
 
 		if (!index)
@@ -581,10 +571,17 @@ static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
 		return kmem_cache_alloc_trace(
 				kmalloc_caches[kmalloc_type(flags)][index],
 				flags, size);
-#endif
 	}
 	return __kmalloc(size, flags);
 }
+#else
+static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
+{
+	if (__builtin_constant_p(size) && size > KMALLOC_MAX_CACHE_SIZE)
+		return kmalloc_large(size, flags);
+	return __kmalloc(size, flags);
+}
+#endif
 
 static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
 {
diff --git a/mm/slab.c b/mm/slab.c
index ddf5737c63d9..570af6dc3478 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3624,7 +3624,8 @@ __do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
 	void *ret;
 
 	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
-		return NULL;
+		return kmalloc_large(size, flags);
+
 	cachep = kmalloc_slab(size, flags);
 	if (unlikely(ZERO_OR_NULL_PTR(cachep)))
 		return cachep;
@@ -3685,7 +3686,8 @@ static __always_inline void *__do_kmalloc(size_t size, gfp_t flags,
 	void *ret;
 
 	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
-		return NULL;
+		return kmalloc_large(size, flags);
+
 	cachep = kmalloc_slab(size, flags);
 	if (unlikely(ZERO_OR_NULL_PTR(cachep)))
 		return cachep;
@@ -3739,14 +3741,21 @@ void kmem_cache_free_bulk(struct kmem_cache *orig_s, size_t size, void **p)
 {
 	struct kmem_cache *s;
 	size_t i;
+	struct folio *folio;
 
 	local_irq_disable();
 	for (i = 0; i < size; i++) {
 		void *objp = p[i];
 
-		if (!orig_s) /* called via kfree_bulk */
+		if (!orig_s) {
+			/* called via kfree_bulk */
+			folio = virt_to_folio(objp);
+			if (unlikely(!folio_test_slab(folio))) {
+				free_large_kmalloc(folio, objp);
+				continue;
+			}
 			s = virt_to_cache(objp);
-		else
+		} else
 			s = cache_from_obj(orig_s, objp);
 		if (!s)
 			continue;
@@ -3776,11 +3785,20 @@ void kfree(const void *objp)
 {
 	struct kmem_cache *c;
 	unsigned long flags;
+	struct folio *folio;
+	void *object = (void *) objp;
 
 	trace_kfree(_RET_IP_, objp);
 
 	if (unlikely(ZERO_OR_NULL_PTR(objp)))
 		return;
+
+	folio = virt_to_folio(objp);
+	if (unlikely(!folio_test_slab(folio))) {
+		free_large_kmalloc(folio, object);
+		return;
+	}
+
 	local_irq_save(flags);
 	kfree_debugcheck(objp);
 	c = virt_to_cache(objp);
@@ -4211,12 +4229,17 @@ void __check_heap_object(const void *ptr, unsigned long n,
 size_t __ksize(const void *objp)
 {
 	struct kmem_cache *c;
+	struct folio *folio;
 	size_t size;
 
 	BUG_ON(!objp);
 	if (unlikely(objp == ZERO_SIZE_PTR))
 		return 0;
 
+	folio = virt_to_folio(objp);
+	if (!folio_test_slab(folio))
+		return folio_size(folio);
+
 	c = virt_to_cache(objp);
 	size = c ? c->object_size : 0;
 
diff --git a/mm/slab.h b/mm/slab.h
index c7f2abc2b154..31e98beb47a3 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -664,6 +664,25 @@ static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
 		print_tracking(cachep, x);
 	return cachep;
 }
+
+static __always_inline void kfree_hook(void *x)
+{
+	kmemleak_free(x);
+	kasan_kfree_large(x);
+}
+
+static inline void free_large_kmalloc(struct folio *folio, void *object)
+{
+	unsigned int order = folio_order(folio);
+
+	if (WARN_ON_ONCE(order == 0))
+		pr_warn_once("object pointer: 0x%p\n", object);
+
+	kfree_hook(object);
+	mod_lruvec_page_state(folio_page(folio, 0), NR_SLAB_UNRECLAIMABLE_B,
+			      -(PAGE_SIZE << order));
+	__free_pages(folio_page(folio, 0), order);
+}
 #endif /* CONFIG_SLOB */
 
 static inline size_t slab_ksize(const struct kmem_cache *s)
diff --git a/mm/slub.c b/mm/slub.c
index 261474092e43..04fd084f4709 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1686,12 +1686,6 @@ static inline void *kmalloc_large_node_hook(void *ptr, size_t size, gfp_t flags)
 	return ptr;
 }
 
-static __always_inline void kfree_hook(void *x)
-{
-	kmemleak_free(x);
-	kasan_kfree_large(x);
-}
-
 static __always_inline bool slab_free_hook(struct kmem_cache *s,
 						void *x, bool init)
 {
@@ -3535,19 +3529,6 @@ struct detached_freelist {
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


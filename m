Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C642A5ADAB5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 23:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237224AbiIEVJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 17:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbiIEVJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 17:09:25 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D9067466
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 14:09:10 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662412148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oe1I5rgVNwQpGV6INl9iERGx4SyKKLbT68poGoo1Dv4=;
        b=PL+hF7kcBhca/C4p85FTUxrzhI/jk7IqFqEgnbp+mNCuejb3QovS4fDjFZxPFMvXxsDzwF
        g0l2igLCasWBjG8OFV/mbVfQMjnHBprq0kdFmrgZ8bykcDoB9fBsI4LLIDOHt6ufDiS5Xn
        hfAcmnNKK8mT/DRfcNyM2+Wxf5EXGyk=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm v3 18/34] kasan: only define kasan_cache_create for Generic mode
Date:   Mon,  5 Sep 2022 23:05:33 +0200
Message-Id: <61faa2aa1906e2d02c97d00ddf99ce8911dda095.1662411799.git.andreyknvl@google.com>
In-Reply-To: <cover.1662411799.git.andreyknvl@google.com>
References: <cover.1662411799.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Right now, kasan_cache_create() assigns SLAB_KASAN for all KASAN modes
and then sets up metadata-related cache parameters for the Generic mode.

SLAB_KASAN is used in two places:

1. In slab_ksize() to account for per-object metadata when
   calculating the size of the accessible memory within the object.
2. In slab_common.c via kasan_never_merge() to prevent merging of
   caches with per-object metadata.

Both cases are only relevant when per-object metadata is present, which
is only the case with the Generic mode.

Thus, assign SLAB_KASAN and define kasan_cache_create() only for the
Generic mode.

Also update the SLAB_KASAN-related comment.

Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/kasan.h | 18 ++++++------------
 include/linux/slab.h  |  2 +-
 mm/kasan/common.c     | 16 ----------------
 mm/kasan/generic.c    | 17 ++++++++++++++++-
 4 files changed, 23 insertions(+), 30 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index a212c2e3f32d..d811b3d7d2a1 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -128,15 +128,6 @@ static __always_inline void kasan_unpoison_pages(struct page *page,
 		__kasan_unpoison_pages(page, order, init);
 }
 
-void __kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
-				slab_flags_t *flags);
-static __always_inline void kasan_cache_create(struct kmem_cache *cache,
-				unsigned int *size, slab_flags_t *flags)
-{
-	if (kasan_enabled())
-		__kasan_cache_create(cache, size, flags);
-}
-
 void __kasan_cache_create_kmalloc(struct kmem_cache *cache);
 static __always_inline void kasan_cache_create_kmalloc(struct kmem_cache *cache)
 {
@@ -260,9 +251,6 @@ static inline void kasan_poison_pages(struct page *page, unsigned int order,
 				      bool init) {}
 static inline void kasan_unpoison_pages(struct page *page, unsigned int order,
 					bool init) {}
-static inline void kasan_cache_create(struct kmem_cache *cache,
-				      unsigned int *size,
-				      slab_flags_t *flags) {}
 static inline void kasan_cache_create_kmalloc(struct kmem_cache *cache) {}
 static inline void kasan_poison_slab(struct slab *slab) {}
 static inline void kasan_unpoison_object_data(struct kmem_cache *cache,
@@ -316,6 +304,8 @@ static inline void kasan_unpoison_task_stack(struct task_struct *task) {}
 
 size_t kasan_metadata_size(struct kmem_cache *cache);
 slab_flags_t kasan_never_merge(void);
+void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
+			slab_flags_t *flags);
 
 void kasan_cache_shrink(struct kmem_cache *cache);
 void kasan_cache_shutdown(struct kmem_cache *cache);
@@ -334,6 +324,10 @@ static inline slab_flags_t kasan_never_merge(void)
 {
 	return 0;
 }
+/* And no cache-related metadata initialization is required. */
+static inline void kasan_cache_create(struct kmem_cache *cache,
+				      unsigned int *size,
+				      slab_flags_t *flags) {}
 
 static inline void kasan_cache_shrink(struct kmem_cache *cache) {}
 static inline void kasan_cache_shutdown(struct kmem_cache *cache) {}
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 0fefdf528e0d..1c6b7362e82b 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -106,7 +106,7 @@
 # define SLAB_ACCOUNT		0
 #endif
 
-#ifdef CONFIG_KASAN
+#ifdef CONFIG_KASAN_GENERIC
 #define SLAB_KASAN		((slab_flags_t __force)0x08000000U)
 #else
 #define SLAB_KASAN		0
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index c2690e938030..8efa63190951 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -110,22 +110,6 @@ void __kasan_poison_pages(struct page *page, unsigned int order, bool init)
 			     KASAN_PAGE_FREE, init);
 }
 
-void __kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
-			  slab_flags_t *flags)
-{
-	/*
-	 * SLAB_KASAN is used to mark caches as ones that are sanitized by
-	 * KASAN. Currently this flag is used in two places:
-	 * 1. In slab_ksize() when calculating the size of the accessible
-	 *    memory within the object.
-	 * 2. In slab_common.c to prevent merging of sanitized caches.
-	 */
-	*flags |= SLAB_KASAN;
-
-	if (kasan_requires_meta())
-		kasan_init_cache_meta(cache, size);
-}
-
 void __kasan_cache_create_kmalloc(struct kmem_cache *cache)
 {
 	cache->kasan_info.is_kmalloc = true;
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 25333bf3c99f..f6bef347de87 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -352,11 +352,26 @@ static inline unsigned int optimal_redzone(unsigned int object_size)
 		object_size <= (1 << 16) - 1024 ? 1024 : 2048;
 }
 
-void kasan_init_cache_meta(struct kmem_cache *cache, unsigned int *size)
+void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
+			  slab_flags_t *flags)
 {
 	unsigned int ok_size;
 	unsigned int optimal_size;
 
+	if (!kasan_requires_meta())
+		return;
+
+	/*
+	 * SLAB_KASAN is used to mark caches that are sanitized by KASAN
+	 * and that thus have per-object metadata.
+	 * Currently this flag is used in two places:
+	 * 1. In slab_ksize() to account for per-object metadata when
+	 *    calculating the size of the accessible memory within the object.
+	 * 2. In slab_common.c via kasan_never_merge() to prevent merging of
+	 *    caches with per-object metadata.
+	 */
+	*flags |= SLAB_KASAN;
+
 	ok_size = *size;
 
 	/* Add alloc meta into redzone. */
-- 
2.25.1


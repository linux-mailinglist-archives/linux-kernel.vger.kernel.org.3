Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA9754A065
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347293AbiFMUzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351491AbiFMUxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:53:38 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11CE18350
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:17:34 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655151452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=juoeL9iVysZjLYrCYEKOizkTpbFJJdb8UyU7Sz7zXtQ=;
        b=RPTEnN3Q+Vk+b3sRFX80S/7v5i2XXhKAb7u9lQ7UwKhpB0xwKo8Vr26yP54OM3zYd3Olbf
        hSqLBs1FP8L9MNdW523biACQ14ecqL+rTnJBNVUWPRe8BAqZWh9Je146iyCwBfYCmvkoha
        TtmVe6o8a0gp1z+s1bkEeyR24gle/Ns=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 12/32] kasan: introduce kasan_init_cache_meta
Date:   Mon, 13 Jun 2022 22:14:03 +0200
Message-Id: <d86bbe1cc39eacb71bfaf05961d2e62109e9b0d9.1655150842.git.andreyknvl@google.com>
In-Reply-To: <cover.1655150842.git.andreyknvl@google.com>
References: <cover.1655150842.git.andreyknvl@google.com>
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

Add a kasan_init_cache_meta() helper that initializes metadata-related
cache parameters and use this helper in the common KASAN code.

Put the implementation of this new helper into generic.c, as only the
Generic mode uses per-object metadata.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/common.c  | 80 ++--------------------------------------------
 mm/kasan/generic.c | 79 +++++++++++++++++++++++++++++++++++++++++++++
 mm/kasan/kasan.h   |  2 ++
 3 files changed, 83 insertions(+), 78 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index a3dee7cead89..8a83ca9ad738 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -117,28 +117,9 @@ void __kasan_poison_pages(struct page *page, unsigned int order, bool init)
 			     KASAN_PAGE_FREE, init);
 }
 
-/*
- * Adaptive redzone policy taken from the userspace AddressSanitizer runtime.
- * For larger allocations larger redzones are used.
- */
-static inline unsigned int optimal_redzone(unsigned int object_size)
-{
-	return
-		object_size <= 64        - 16   ? 16 :
-		object_size <= 128       - 32   ? 32 :
-		object_size <= 512       - 64   ? 64 :
-		object_size <= 4096      - 128  ? 128 :
-		object_size <= (1 << 14) - 256  ? 256 :
-		object_size <= (1 << 15) - 512  ? 512 :
-		object_size <= (1 << 16) - 1024 ? 1024 : 2048;
-}
-
 void __kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 			  slab_flags_t *flags)
 {
-	unsigned int ok_size;
-	unsigned int optimal_size;
-
 	/*
 	 * SLAB_KASAN is used to mark caches as ones that are sanitized by
 	 * KASAN. Currently this flag is used in two places:
@@ -148,65 +129,8 @@ void __kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 	 */
 	*flags |= SLAB_KASAN;
 
-	if (!kasan_requires_meta())
-		return;
-
-	ok_size = *size;
-
-	/* Add alloc meta into redzone. */
-	cache->kasan_info.alloc_meta_offset = *size;
-	*size += sizeof(struct kasan_alloc_meta);
-
-	/*
-	 * If alloc meta doesn't fit, don't add it.
-	 * This can only happen with SLAB, as it has KMALLOC_MAX_SIZE equal
-	 * to KMALLOC_MAX_CACHE_SIZE and doesn't fall back to page_alloc for
-	 * larger sizes.
-	 */
-	if (*size > KMALLOC_MAX_SIZE) {
-		cache->kasan_info.alloc_meta_offset = 0;
-		*size = ok_size;
-		/* Continue, since free meta might still fit. */
-	}
-
-	/* Only the generic mode uses free meta or flexible redzones. */
-	if (!IS_ENABLED(CONFIG_KASAN_GENERIC)) {
-		cache->kasan_info.free_meta_offset = KASAN_NO_FREE_META;
-		return;
-	}
-
-	/*
-	 * Add free meta into redzone when it's not possible to store
-	 * it in the object. This is the case when:
-	 * 1. Object is SLAB_TYPESAFE_BY_RCU, which means that it can
-	 *    be touched after it was freed, or
-	 * 2. Object has a constructor, which means it's expected to
-	 *    retain its content until the next allocation, or
-	 * 3. Object is too small.
-	 * Otherwise cache->kasan_info.free_meta_offset = 0 is implied.
-	 */
-	if ((cache->flags & SLAB_TYPESAFE_BY_RCU) || cache->ctor ||
-	    cache->object_size < sizeof(struct kasan_free_meta)) {
-		ok_size = *size;
-
-		cache->kasan_info.free_meta_offset = *size;
-		*size += sizeof(struct kasan_free_meta);
-
-		/* If free meta doesn't fit, don't add it. */
-		if (*size > KMALLOC_MAX_SIZE) {
-			cache->kasan_info.free_meta_offset = KASAN_NO_FREE_META;
-			*size = ok_size;
-		}
-	}
-
-	/* Calculate size with optimal redzone. */
-	optimal_size = cache->object_size + optimal_redzone(cache->object_size);
-	/* Limit it with KMALLOC_MAX_SIZE (relevant for SLAB only). */
-	if (optimal_size > KMALLOC_MAX_SIZE)
-		optimal_size = KMALLOC_MAX_SIZE;
-	/* Use optimal size if the size with added metas is not large enough. */
-	if (*size < optimal_size)
-		*size = optimal_size;
+	if (kasan_requires_meta())
+		kasan_init_cache_meta(cache, size);
 }
 
 void __kasan_cache_create_kmalloc(struct kmem_cache *cache)
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index fa654cb96a0d..73aea784040a 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -328,6 +328,85 @@ DEFINE_ASAN_SET_SHADOW(f3);
 DEFINE_ASAN_SET_SHADOW(f5);
 DEFINE_ASAN_SET_SHADOW(f8);
 
+/*
+ * Adaptive redzone policy taken from the userspace AddressSanitizer runtime.
+ * For larger allocations larger redzones are used.
+ */
+static inline unsigned int optimal_redzone(unsigned int object_size)
+{
+	return
+		object_size <= 64        - 16   ? 16 :
+		object_size <= 128       - 32   ? 32 :
+		object_size <= 512       - 64   ? 64 :
+		object_size <= 4096      - 128  ? 128 :
+		object_size <= (1 << 14) - 256  ? 256 :
+		object_size <= (1 << 15) - 512  ? 512 :
+		object_size <= (1 << 16) - 1024 ? 1024 : 2048;
+}
+
+void kasan_init_cache_meta(struct kmem_cache *cache, unsigned int *size)
+{
+	unsigned int ok_size;
+	unsigned int optimal_size;
+
+	ok_size = *size;
+
+	/* Add alloc meta into redzone. */
+	cache->kasan_info.alloc_meta_offset = *size;
+	*size += sizeof(struct kasan_alloc_meta);
+
+	/*
+	 * If alloc meta doesn't fit, don't add it.
+	 * This can only happen with SLAB, as it has KMALLOC_MAX_SIZE equal
+	 * to KMALLOC_MAX_CACHE_SIZE and doesn't fall back to page_alloc for
+	 * larger sizes.
+	 */
+	if (*size > KMALLOC_MAX_SIZE) {
+		cache->kasan_info.alloc_meta_offset = 0;
+		*size = ok_size;
+		/* Continue, since free meta might still fit. */
+	}
+
+	/* Only the generic mode uses free meta or flexible redzones. */
+	if (!IS_ENABLED(CONFIG_KASAN_GENERIC)) {
+		cache->kasan_info.free_meta_offset = KASAN_NO_FREE_META;
+		return;
+	}
+
+	/*
+	 * Add free meta into redzone when it's not possible to store
+	 * it in the object. This is the case when:
+	 * 1. Object is SLAB_TYPESAFE_BY_RCU, which means that it can
+	 *    be touched after it was freed, or
+	 * 2. Object has a constructor, which means it's expected to
+	 *    retain its content until the next allocation, or
+	 * 3. Object is too small.
+	 * Otherwise cache->kasan_info.free_meta_offset = 0 is implied.
+	 */
+	if ((cache->flags & SLAB_TYPESAFE_BY_RCU) || cache->ctor ||
+	    cache->object_size < sizeof(struct kasan_free_meta)) {
+		ok_size = *size;
+
+		cache->kasan_info.free_meta_offset = *size;
+		*size += sizeof(struct kasan_free_meta);
+
+		/* If free meta doesn't fit, don't add it. */
+		if (*size > KMALLOC_MAX_SIZE) {
+			cache->kasan_info.free_meta_offset = KASAN_NO_FREE_META;
+			*size = ok_size;
+		}
+	}
+
+	/* Calculate size with optimal redzone. */
+	optimal_size = cache->object_size + optimal_redzone(cache->object_size);
+	/* Limit it with KMALLOC_MAX_SIZE (relevant for SLAB only). */
+	if (optimal_size > KMALLOC_MAX_SIZE)
+		optimal_size = KMALLOC_MAX_SIZE;
+	/* Use optimal size if the size with added metas is not large enough. */
+	if (*size < optimal_size)
+		*size = optimal_size;
+}
+
 struct kasan_alloc_meta *kasan_get_alloc_meta(struct kmem_cache *cache,
 					      const void *object)
 {
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index cf123d99f2fe..ab2cd3ff10f3 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -296,12 +296,14 @@ struct page *kasan_addr_to_page(const void *addr);
 struct slab *kasan_addr_to_slab(const void *addr);
 
 #ifdef CONFIG_KASAN_GENERIC
+void kasan_init_cache_meta(struct kmem_cache *cache, unsigned int *size);
 void kasan_init_object_meta(struct kmem_cache *cache, const void *object);
 struct kasan_alloc_meta *kasan_get_alloc_meta(struct kmem_cache *cache,
 						const void *object);
 struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
 						const void *object);
 #else
+static inline void kasan_init_cache_meta(struct kmem_cache *cache, unsigned int *size) { }
 static inline void kasan_init_object_meta(struct kmem_cache *cache, const void *object) { }
 #endif
 
-- 
2.25.1


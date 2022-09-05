Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5286C5ADAA9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 23:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237251AbiIEVI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 17:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbiIEVII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 17:08:08 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDED6582E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 14:08:06 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662412085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nkqQis8OrAGkyhzJVWYxF7zMQuECBh17BdvtUxTmMSg=;
        b=RcfZDHJeMLUdGqMtnfKqZMz7fLZdYTp/zYz7sC412igzxqZy0V/hZZKnZv1nkDhSEvSxn2
        xh65uRPFPT6zMJ7hkFV709oQ1L9jk0b4bODRlufgLQe0uLbcuzas1XRqZThBe0M4uDL6RT
        L86vnqhTzpUFFOamPk5laMJWlNYKqHU=
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
Subject: [PATCH mm v3 14/34] kasan: only define kasan_metadata_size for Generic mode
Date:   Mon,  5 Sep 2022 23:05:29 +0200
Message-Id: <8f81d4938b80446bc72538a08217009f328a3e23.1662411799.git.andreyknvl@google.com>
In-Reply-To: <cover.1662411799.git.andreyknvl@google.com>
References: <cover.1662411799.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

KASAN provides a helper for calculating the size of per-object metadata
stored in the redzone.

As now only the Generic mode uses per-object metadata, only define
kasan_metadata_size() for this mode.

Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/kasan.h | 17 ++++++++---------
 mm/kasan/common.c     | 11 -----------
 mm/kasan/generic.c    | 11 +++++++++++
 3 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index b092277bf48d..027df7599573 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -150,14 +150,6 @@ static __always_inline void kasan_cache_create_kmalloc(struct kmem_cache *cache)
 		__kasan_cache_create_kmalloc(cache);
 }
 
-size_t __kasan_metadata_size(struct kmem_cache *cache);
-static __always_inline size_t kasan_metadata_size(struct kmem_cache *cache)
-{
-	if (kasan_enabled())
-		return __kasan_metadata_size(cache);
-	return 0;
-}
-
 void __kasan_poison_slab(struct slab *slab);
 static __always_inline void kasan_poison_slab(struct slab *slab)
 {
@@ -282,7 +274,6 @@ static inline void kasan_cache_create(struct kmem_cache *cache,
 				      unsigned int *size,
 				      slab_flags_t *flags) {}
 static inline void kasan_cache_create_kmalloc(struct kmem_cache *cache) {}
-static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
 static inline void kasan_poison_slab(struct slab *slab) {}
 static inline void kasan_unpoison_object_data(struct kmem_cache *cache,
 					void *object) {}
@@ -333,6 +324,8 @@ static inline void kasan_unpoison_task_stack(struct task_struct *task) {}
 
 #ifdef CONFIG_KASAN_GENERIC
 
+size_t kasan_metadata_size(struct kmem_cache *cache);
+
 void kasan_cache_shrink(struct kmem_cache *cache);
 void kasan_cache_shutdown(struct kmem_cache *cache);
 void kasan_record_aux_stack(void *ptr);
@@ -340,6 +333,12 @@ void kasan_record_aux_stack_noalloc(void *ptr);
 
 #else /* CONFIG_KASAN_GENERIC */
 
+/* Tag-based KASAN modes do not use per-object metadata. */
+static inline size_t kasan_metadata_size(struct kmem_cache *cache)
+{
+	return 0;
+}
+
 static inline void kasan_cache_shrink(struct kmem_cache *cache) {}
 static inline void kasan_cache_shutdown(struct kmem_cache *cache) {}
 static inline void kasan_record_aux_stack(void *ptr) {}
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index b6a74fe5e740..7c79c560315d 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -139,17 +139,6 @@ void __kasan_cache_create_kmalloc(struct kmem_cache *cache)
 	cache->kasan_info.is_kmalloc = true;
 }
 
-size_t __kasan_metadata_size(struct kmem_cache *cache)
-{
-	if (!kasan_requires_meta())
-		return 0;
-	return (cache->kasan_info.alloc_meta_offset ?
-		sizeof(struct kasan_alloc_meta) : 0) +
-		((cache->kasan_info.free_meta_offset &&
-		  cache->kasan_info.free_meta_offset != KASAN_NO_FREE_META) ?
-		 sizeof(struct kasan_free_meta) : 0);
-}
-
 void __kasan_poison_slab(struct slab *slab)
 {
 	struct page *page = slab_page(slab);
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 5125fad76f70..806ab92032c3 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -427,6 +427,17 @@ void kasan_init_object_meta(struct kmem_cache *cache, const void *object)
 		__memset(alloc_meta, 0, sizeof(*alloc_meta));
 }
 
+size_t kasan_metadata_size(struct kmem_cache *cache)
+{
+	if (!kasan_requires_meta())
+		return 0;
+	return (cache->kasan_info.alloc_meta_offset ?
+		sizeof(struct kasan_alloc_meta) : 0) +
+		((cache->kasan_info.free_meta_offset &&
+		  cache->kasan_info.free_meta_offset != KASAN_NO_FREE_META) ?
+		 sizeof(struct kasan_free_meta) : 0);
+}
+
 static void __kasan_record_aux_stack(void *addr, bool can_alloc)
 {
 	struct slab *slab = kasan_addr_to_slab(addr);
-- 
2.25.1


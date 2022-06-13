Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0EB54A056
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351389AbiFMUzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351370AbiFMUxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:53:30 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCE8C6C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:16:33 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655151391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AqRJE5kHmUhU9DFMHo/l5MzOgI3EbkZf7j3BisUrZdo=;
        b=mIrxUO6yNmISFxVhORrnTzrHOpEeL/kLpMCN1K+a49yMcpUcxAigtTULezvJf30sL+wAyw
        Rp+NlTsOVqQfavGkK1yhonDcpWAej72Zl00+ifLviSvZ4cQgAtAzp1qpKRljb0D6kNe9Xl
        dJWXbiRA4Ni/5pltLo+AqeQNQWK+Duk=
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
Subject: [PATCH 11/32] kasan: introduce kasan_requires_meta
Date:   Mon, 13 Jun 2022 22:14:02 +0200
Message-Id: <4201bc563d9553bca0278124e5ee4f1fe9a84ba6.1655150842.git.andreyknvl@google.com>
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

Add a kasan_requires_meta() helper that indicates whether the enabled
KASAN mode requires per-object metadata and use this helper in the common
code.

Also hide kasan_init_object_meta() under CONFIG_KASAN_GENERIC ifdef check,
as Generic is the only mode that uses per-object metadata.

To allow for a potential future change that makes Generic KASAN support
the kasan.stacktrace command-line parameter, let kasan_requires_meta()
return kasan_stack_collection_enabled() instead of simply returning true.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/common.c | 13 +++++--------
 mm/kasan/kasan.h  | 33 +++++++++++++++++++++++++++++----
 mm/kasan/tags.c   |  4 ----
 3 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 226eaa714da2..a3dee7cead89 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -88,13 +88,10 @@ asmlinkage void kasan_unpoison_task_stack_below(const void *watermark)
 }
 #endif /* CONFIG_KASAN_STACK */
 
-/*
- * Only allow cache merging when stack collection is disabled and no metadata
- * is present.
- */
+/* Only allow cache merging when no per-object metadata is present. */
 slab_flags_t __kasan_never_merge(void)
 {
-	if (kasan_stack_collection_enabled())
+	if (kasan_requires_meta())
 		return SLAB_KASAN;
 	return 0;
 }
@@ -151,7 +148,7 @@ void __kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 	 */
 	*flags |= SLAB_KASAN;
 
-	if (!kasan_stack_collection_enabled())
+	if (!kasan_requires_meta())
 		return;
 
 	ok_size = *size;
@@ -219,7 +216,7 @@ void __kasan_cache_create_kmalloc(struct kmem_cache *cache)
 
 size_t __kasan_metadata_size(struct kmem_cache *cache)
 {
-	if (!kasan_stack_collection_enabled())
+	if (!kasan_requires_meta())
 		return 0;
 	return (cache->kasan_info.alloc_meta_offset ?
 		sizeof(struct kasan_alloc_meta) : 0) +
@@ -294,7 +291,7 @@ void * __must_check __kasan_init_slab_obj(struct kmem_cache *cache,
 						const void *object)
 {
 	/* Initialize per-object metadata if it is present. */
-	if (kasan_stack_collection_enabled())
+	if (kasan_requires_meta())
 		kasan_init_object_meta(cache, object);
 
 	/* Tag is ignored in set_tag() without CONFIG_KASAN_SW/HW_TAGS */
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index ff7a1597aa51..cf123d99f2fe 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -43,7 +43,7 @@ static inline bool kasan_sync_fault_possible(void)
 	return kasan_mode == KASAN_MODE_SYNC || kasan_mode == KASAN_MODE_ASYMM;
 }
 
-#else
+#else /* CONFIG_KASAN_HW_TAGS */
 
 static inline bool kasan_stack_collection_enabled(void)
 {
@@ -60,7 +60,31 @@ static inline bool kasan_sync_fault_possible(void)
 	return true;
 }
 
-#endif
+#endif /* CONFIG_KASAN_HW_TAGS */
+
+#ifdef CONFIG_KASAN_GENERIC
+
+/* Generic KASAN uses per-object metadata to store stack traces. */
+static inline bool kasan_requires_meta(void)
+{
+	/*
+	 * Technically, Generic KASAN always collects stack traces right now.
+	 * However, let's use kasan_stack_collection_enabled() in case the
+	 * kasan.stacktrace command-line argument is changed to affect
+	 * Generic KASAN.
+	 */
+	return kasan_stack_collection_enabled();
+}
+
+#else /* CONFIG_KASAN_GENERIC */
+
+/* Tag-based KASAN modes do not use per-object metadata. */
+static inline bool kasan_requires_meta(void)
+{
+	return false;
+}
+
+#endif /* CONFIG_KASAN_GENERIC */
 
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 #define KASAN_GRANULE_SIZE	(1UL << KASAN_SHADOW_SCALE_SHIFT)
@@ -271,13 +295,14 @@ void kasan_report_invalid_free(void *object, unsigned long ip);
 struct page *kasan_addr_to_page(const void *addr);
 struct slab *kasan_addr_to_slab(const void *addr);
 
-void kasan_init_object_meta(struct kmem_cache *cache, const void *object);
-
 #ifdef CONFIG_KASAN_GENERIC
+void kasan_init_object_meta(struct kmem_cache *cache, const void *object);
 struct kasan_alloc_meta *kasan_get_alloc_meta(struct kmem_cache *cache,
 						const void *object);
 struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
 						const void *object);
+#else
+static inline void kasan_init_object_meta(struct kmem_cache *cache, const void *object) { }
 #endif
 
 depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc);
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index f11c89505c77..4f24669085e9 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -17,10 +17,6 @@
 
 #include "kasan.h"
 
-void kasan_init_object_meta(struct kmem_cache *cache, const void *object)
-{
-}
-
 void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
 {
 }
-- 
2.25.1


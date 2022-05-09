Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1600F5201A7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238671AbiEIPzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238662AbiEIPzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:55:41 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF03239817
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 08:51:44 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652111503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cdChAqh9Z1Z7THY7s/iFk3WWip4uaed5XjcYAp3h5fU=;
        b=r755JKWNBGsueymij3j5+7Y+YW5Gp9glsQWky2Gh4qo2euPzhl+iZyoqVOTDd5+sq6fWX2
        T8a3jRwZ9ZDrdIhIvuCADabJ++CpP99tgjZgNZoSSnXvy+bNTe0hSU5KlSfvc30LjaFnpn
        96xKsXTVXXgnrcY8uHky58sPLCGe6Gg=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 3/3] kasan: give better names to shadow values
Date:   Mon,  9 May 2022 17:51:36 +0200
Message-Id: <bebcaf4eafdb0cabae0401a69c0af956aa87fcaa.1652111464.git.andreyknvl@google.com>
In-Reply-To: <a0680ff30035b56cb7bdd5f59fd400e71712ceb5.1652111464.git.andreyknvl@google.com>
References: <a0680ff30035b56cb7bdd5f59fd400e71712ceb5.1652111464.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Rename KASAN_KMALLOC_* shadow values to KASAN_SLAB_*, as they are used
for all slab allocations, not only for kmalloc.

Also rename KASAN_FREE_PAGE to KASAN_PAGE_FREE to be consistent with
KASAN_PAGE_REDZONE and KASAN_SLAB_FREE.

Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/common.c         | 12 ++++++------
 mm/kasan/generic.c        |  6 +++---
 mm/kasan/kasan.h          | 14 +++++++-------
 mm/kasan/quarantine.c     |  2 +-
 mm/kasan/report_generic.c |  8 ++++----
 5 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index d9079ec11f31..c40c0e7b3b5f 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -117,7 +117,7 @@ void __kasan_poison_pages(struct page *page, unsigned int order, bool init)
 {
 	if (likely(!PageHighMem(page)))
 		kasan_poison(page_address(page), PAGE_SIZE << order,
-			     KASAN_FREE_PAGE, init);
+			     KASAN_PAGE_FREE, init);
 }
 
 /*
@@ -254,7 +254,7 @@ void __kasan_poison_slab(struct slab *slab)
 	for (i = 0; i < compound_nr(page); i++)
 		page_kasan_tag_reset(page + i);
 	kasan_poison(page_address(page), page_size(page),
-		     KASAN_KMALLOC_REDZONE, false);
+		     KASAN_SLAB_REDZONE, false);
 }
 
 void __kasan_unpoison_object_data(struct kmem_cache *cache, void *object)
@@ -265,7 +265,7 @@ void __kasan_unpoison_object_data(struct kmem_cache *cache, void *object)
 void __kasan_poison_object_data(struct kmem_cache *cache, void *object)
 {
 	kasan_poison(object, round_up(cache->object_size, KASAN_GRANULE_SIZE),
-			KASAN_KMALLOC_REDZONE, false);
+			KASAN_SLAB_REDZONE, false);
 }
 
 /*
@@ -357,7 +357,7 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
 	}
 
 	kasan_poison(object, round_up(cache->object_size, KASAN_GRANULE_SIZE),
-			KASAN_KMALLOC_FREE, init);
+			KASAN_SLAB_FREE, init);
 
 	if ((IS_ENABLED(CONFIG_KASAN_GENERIC) && !quarantine))
 		return false;
@@ -414,7 +414,7 @@ void __kasan_slab_free_mempool(void *ptr, unsigned long ip)
 	if (unlikely(!folio_test_slab(folio))) {
 		if (____kasan_kfree_large(ptr, ip))
 			return;
-		kasan_poison(ptr, folio_size(folio), KASAN_FREE_PAGE, false);
+		kasan_poison(ptr, folio_size(folio), KASAN_PAGE_FREE, false);
 	} else {
 		struct slab *slab = folio_slab(folio);
 
@@ -505,7 +505,7 @@ static inline void *____kasan_kmalloc(struct kmem_cache *cache,
 	redzone_end = round_up((unsigned long)(object + cache->object_size),
 				KASAN_GRANULE_SIZE);
 	kasan_poison((void *)redzone_start, redzone_end - redzone_start,
-			   KASAN_KMALLOC_REDZONE, false);
+			   KASAN_SLAB_REDZONE, false);
 
 	/*
 	 * Save alloc info (if possible) for kmalloc() allocations.
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index a25ad4090615..437fcc7e77cf 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -369,14 +369,14 @@ void kasan_set_free_info(struct kmem_cache *cache,
 
 	kasan_set_track(&free_meta->free_track, GFP_NOWAIT);
 	/* The object was freed and has free track set. */
-	*(u8 *)kasan_mem_to_shadow(object) = KASAN_KMALLOC_FREETRACK;
+	*(u8 *)kasan_mem_to_shadow(object) = KASAN_SLAB_FREETRACK;
 }
 
 struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
 				void *object, u8 tag)
 {
-	if (*(u8 *)kasan_mem_to_shadow(object) != KASAN_KMALLOC_FREETRACK)
+	if (*(u8 *)kasan_mem_to_shadow(object) != KASAN_SLAB_FREETRACK)
 		return NULL;
-	/* Free meta must be present with KASAN_KMALLOC_FREETRACK. */
+	/* Free meta must be present with KASAN_SLAB_FREETRACK. */
 	return &kasan_get_free_meta(cache, object)->free_track;
 }
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index a60ed636e899..610d60d6e5b8 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -74,22 +74,22 @@ static inline bool kasan_sync_fault_possible(void)
 #define KASAN_MEMORY_PER_SHADOW_PAGE	(KASAN_GRANULE_SIZE << PAGE_SHIFT)
 
 #ifdef CONFIG_KASAN_GENERIC
-#define KASAN_FREE_PAGE		0xFF  /* freed page */
+#define KASAN_PAGE_FREE		0xFF  /* freed page */
 #define KASAN_PAGE_REDZONE	0xFE  /* redzone for kmalloc_large allocation */
-#define KASAN_KMALLOC_REDZONE	0xFC  /* redzone for slab object */
-#define KASAN_KMALLOC_FREE	0xFB  /* freed slab object */
+#define KASAN_SLAB_REDZONE	0xFC  /* redzone for slab object */
+#define KASAN_SLAB_FREE		0xFB  /* freed slab object */
 #define KASAN_VMALLOC_INVALID	0xF8  /* inaccessible space in vmap area */
 #else
-#define KASAN_FREE_PAGE		KASAN_TAG_INVALID
+#define KASAN_PAGE_FREE		KASAN_TAG_INVALID
 #define KASAN_PAGE_REDZONE	KASAN_TAG_INVALID
-#define KASAN_KMALLOC_REDZONE	KASAN_TAG_INVALID
-#define KASAN_KMALLOC_FREE	KASAN_TAG_INVALID
+#define KASAN_SLAB_REDZONE	KASAN_TAG_INVALID
+#define KASAN_SLAB_FREE		KASAN_TAG_INVALID
 #define KASAN_VMALLOC_INVALID	KASAN_TAG_INVALID /* only used for SW_TAGS */
 #endif
 
 #ifdef CONFIG_KASAN_GENERIC
 
-#define KASAN_KMALLOC_FREETRACK	0xFA  /* freed slab object with free track */
+#define KASAN_SLAB_FREETRACK	0xFA  /* freed slab object with free track */
 #define KASAN_GLOBAL_REDZONE	0xF9  /* redzone for global variable */
 
 /* Stack redzone shadow values. Compiler ABI, do not change. */
diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
index 0a9def8ce5e8..fac4befb9ef2 100644
--- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@ -152,7 +152,7 @@ static void qlink_free(struct qlist_node *qlink, struct kmem_cache *cache)
 	 * As the object now gets freed from the quarantine, assume that its
 	 * free track is no longer valid.
 	 */
-	*(u8 *)kasan_mem_to_shadow(object) = KASAN_KMALLOC_FREE;
+	*(u8 *)kasan_mem_to_shadow(object) = KASAN_SLAB_FREE;
 
 	___cache_free(cache, object, _THIS_IP_);
 
diff --git a/mm/kasan/report_generic.c b/mm/kasan/report_generic.c
index efc5e79a103f..6689fb9a919b 100644
--- a/mm/kasan/report_generic.c
+++ b/mm/kasan/report_generic.c
@@ -66,7 +66,7 @@ static const char *get_shadow_bug_type(struct kasan_report_info *info)
 		bug_type = "out-of-bounds";
 		break;
 	case KASAN_PAGE_REDZONE:
-	case KASAN_KMALLOC_REDZONE:
+	case KASAN_SLAB_REDZONE:
 		bug_type = "slab-out-of-bounds";
 		break;
 	case KASAN_GLOBAL_REDZONE:
@@ -78,9 +78,9 @@ static const char *get_shadow_bug_type(struct kasan_report_info *info)
 	case KASAN_STACK_PARTIAL:
 		bug_type = "stack-out-of-bounds";
 		break;
-	case KASAN_FREE_PAGE:
-	case KASAN_KMALLOC_FREE:
-	case KASAN_KMALLOC_FREETRACK:
+	case KASAN_PAGE_FREE:
+	case KASAN_SLAB_FREE:
+	case KASAN_SLAB_FREETRACK:
 		bug_type = "use-after-free";
 		break;
 	case KASAN_ALLOCA_LEFT:
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82840578ED5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbiGSALA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236501AbiGSAKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:10:54 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9A032D9A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:10:53 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658189421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BHknbGRO3VLc1Ld9zukA6zQR173/1lpbGzpiOKO/Yio=;
        b=vN5sLA/6UAhoUw9xxX7J66yyS5N7YCSn1cn4qW03CkBA43e2jbEV33dsoGMi/tpIqp12VT
        CrNd25fxAZGUM/8ArGQ8rnVG7AXZIr4Ik53jw01QI7SfTxf45DbrjT2Dc57TFRJHVzWJNj
        FFz1haT75GX+deYbyUD7iJQwbanFD2o=
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
Subject: [PATCH mm v2 04/33] kasan: split save_alloc_info implementations
Date:   Tue, 19 Jul 2022 02:09:44 +0200
Message-Id: <891eb09a249af9bc79939b5be0a5076d65a34220.1658189199.git.andreyknvl@google.com>
In-Reply-To: <cover.1658189199.git.andreyknvl@google.com>
References: <cover.1658189199.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Provide standalone implementations of save_alloc_info() for the Generic
and tag-based modes.

For now, the implementations are the same, but they will diverge later
in the series.

Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/common.c  | 13 ++-----------
 mm/kasan/generic.c |  9 +++++++++
 mm/kasan/kasan.h   |  1 +
 mm/kasan/tags.c    |  9 +++++++++
 4 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index a6fd597f73f5..6156c6f0e303 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -423,15 +423,6 @@ void __kasan_slab_free_mempool(void *ptr, unsigned long ip)
 	}
 }
 
-static void save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
-{
-	struct kasan_alloc_meta *alloc_meta;
-
-	alloc_meta = kasan_get_alloc_meta(cache, object);
-	if (alloc_meta)
-		kasan_set_track(&alloc_meta->alloc_track, flags);
-}
-
 void * __must_check __kasan_slab_alloc(struct kmem_cache *cache,
 					void *object, gfp_t flags, bool init)
 {
@@ -462,7 +453,7 @@ void * __must_check __kasan_slab_alloc(struct kmem_cache *cache,
 
 	/* Save alloc info (if possible) for non-kmalloc() allocations. */
 	if (kasan_stack_collection_enabled() && !cache->kasan_info.is_kmalloc)
-		save_alloc_info(cache, (void *)object, flags);
+		kasan_save_alloc_info(cache, (void *)object, flags);
 
 	return tagged_object;
 }
@@ -508,7 +499,7 @@ static inline void *____kasan_kmalloc(struct kmem_cache *cache,
 	 * This also rewrites the alloc info when called from kasan_krealloc().
 	 */
 	if (kasan_stack_collection_enabled() && cache->kasan_info.is_kmalloc)
-		save_alloc_info(cache, (void *)object, flags);
+		kasan_save_alloc_info(cache, (void *)object, flags);
 
 	/* Keep the tag that was set by kasan_slab_alloc(). */
 	return (void *)object;
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 03a3770cfeae..98c451a3b01f 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -358,6 +358,15 @@ void kasan_record_aux_stack_noalloc(void *addr)
 	return __kasan_record_aux_stack(addr, false);
 }
 
+void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
+{
+	struct kasan_alloc_meta *alloc_meta;
+
+	alloc_meta = kasan_get_alloc_meta(cache, object);
+	if (alloc_meta)
+		kasan_set_track(&alloc_meta->alloc_track, flags);
+}
+
 void kasan_save_free_info(struct kmem_cache *cache,
 				void *object, u8 tag)
 {
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index bf16a74dc027..d401fb770f67 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -285,6 +285,7 @@ struct slab *kasan_addr_to_slab(const void *addr);
 
 depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc);
 void kasan_set_track(struct kasan_track *track, gfp_t flags);
+void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags);
 void kasan_save_free_info(struct kmem_cache *cache, void *object, u8 tag);
 struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
 				void *object, u8 tag);
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index b453a353bc86..1ba3c8399f72 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -17,6 +17,15 @@
 
 #include "kasan.h"
 
+void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
+{
+	struct kasan_alloc_meta *alloc_meta;
+
+	alloc_meta = kasan_get_alloc_meta(cache, object);
+	if (alloc_meta)
+		kasan_set_track(&alloc_meta->alloc_track, flags);
+}
+
 void kasan_save_free_info(struct kmem_cache *cache,
 				void *object, u8 tag)
 {
-- 
2.25.1


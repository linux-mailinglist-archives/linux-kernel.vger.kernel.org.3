Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA375ADA8F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 23:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbiIEVGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 17:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiIEVF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 17:05:56 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0930F5925E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 14:05:56 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662411954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sMNzQ3fOnw2gnA7sk+p5VzcTC4OOC9AXjNxA2irzgT8=;
        b=o/wYk110SnvNpmdpgFW7mgNCIG8PDUEYplEC/UmJOD4qpL5VOSNcEyj8ntOYoG5aXFrg2F
        N4iAmZPPmp7Y7noOdkyUX2ds07R4uX686zDgLFck4xpCVaSUYfnFdRCA/d744BEVQybSt2
        y5Jp17HWnhhU3fR7++LCuOJ7zn4Ibr4=
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
Subject: [PATCH mm v3 02/34] kasan: rename kasan_set_*_info to kasan_save_*_info
Date:   Mon,  5 Sep 2022 23:05:17 +0200
Message-Id: <9f04777a15cb9d96bf00331da98e021d732fe1c9.1662411799.git.andreyknvl@google.com>
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

Rename set_alloc_info() and kasan_set_free_info() to save_alloc_info()
and kasan_save_free_info(). The new names make more sense.

Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/common.c  | 8 ++++----
 mm/kasan/generic.c | 2 +-
 mm/kasan/kasan.h   | 2 +-
 mm/kasan/tags.c    | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index f6a6c7d0d8b8..90b6cadd2dac 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -365,7 +365,7 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
 		return false;
 
 	if (kasan_stack_collection_enabled())
-		kasan_set_free_info(cache, object, tag);
+		kasan_save_free_info(cache, object, tag);
 
 	return kasan_quarantine_put(cache, object);
 }
@@ -424,7 +424,7 @@ void __kasan_slab_free_mempool(void *ptr, unsigned long ip)
 	}
 }
 
-static void set_alloc_info(struct kmem_cache *cache, void *object,
+static void save_alloc_info(struct kmem_cache *cache, void *object,
 				gfp_t flags, bool is_kmalloc)
 {
 	struct kasan_alloc_meta *alloc_meta;
@@ -468,7 +468,7 @@ void * __must_check __kasan_slab_alloc(struct kmem_cache *cache,
 
 	/* Save alloc info (if possible) for non-kmalloc() allocations. */
 	if (kasan_stack_collection_enabled())
-		set_alloc_info(cache, (void *)object, flags, false);
+		save_alloc_info(cache, (void *)object, flags, false);
 
 	return tagged_object;
 }
@@ -514,7 +514,7 @@ static inline void *____kasan_kmalloc(struct kmem_cache *cache,
 	 * This also rewrites the alloc info when called from kasan_krealloc().
 	 */
 	if (kasan_stack_collection_enabled())
-		set_alloc_info(cache, (void *)object, flags, true);
+		save_alloc_info(cache, (void *)object, flags, true);
 
 	/* Keep the tag that was set by kasan_slab_alloc(). */
 	return (void *)object;
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 437fcc7e77cf..03a3770cfeae 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -358,7 +358,7 @@ void kasan_record_aux_stack_noalloc(void *addr)
 	return __kasan_record_aux_stack(addr, false);
 }
 
-void kasan_set_free_info(struct kmem_cache *cache,
+void kasan_save_free_info(struct kmem_cache *cache,
 				void *object, u8 tag)
 {
 	struct kasan_free_meta *free_meta;
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 01c03e45acd4..bf16a74dc027 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -285,7 +285,7 @@ struct slab *kasan_addr_to_slab(const void *addr);
 
 depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc);
 void kasan_set_track(struct kasan_track *track, gfp_t flags);
-void kasan_set_free_info(struct kmem_cache *cache, void *object, u8 tag);
+void kasan_save_free_info(struct kmem_cache *cache, void *object, u8 tag);
 struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
 				void *object, u8 tag);
 
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index 8f48b9502a17..b453a353bc86 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -17,7 +17,7 @@
 
 #include "kasan.h"
 
-void kasan_set_free_info(struct kmem_cache *cache,
+void kasan_save_free_info(struct kmem_cache *cache,
 				void *object, u8 tag)
 {
 	struct kasan_alloc_meta *alloc_meta;
-- 
2.25.1


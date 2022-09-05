Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0825ADA9A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 23:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbiIEVHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 17:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbiIEVHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 17:07:01 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE377659C2
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 14:06:59 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662412018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1P0OL5eJBC/VWyzrUzzXy/PpMlaQ+HYTExB/Z4qpTio=;
        b=c7RNoemtm3886h57GZrb9bp9dbKY8BHyEdLoeGuTV6OWHu8zVRr6CV9DDfuLM4RSCgdRfk
        pUa2nCKCnLBEPBYUjz7IW1G0iZTUHAdOnMmJq3qasZPugDW3kQ/p3aTp/w+tMgJzyxB9qs
        LY1+XUr2FejQDPa3UE140sEFXPXpBYI=
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
Subject: [PATCH mm v3 07/34] kasan: introduce kasan_get_alloc_track
Date:   Mon,  5 Sep 2022 23:05:22 +0200
Message-Id: <0c365a35f4a833fff46f9d42c3212b32f7166556.1662411799.git.andreyknvl@google.com>
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

Add a kasan_get_alloc_track() helper that fetches alloc_track for a slab
object and use this helper in the common reporting code.

For now, the implementations of this helper are the same for the Generic
and tag-based modes, but they will diverge later in the series.

This change hides references to alloc_meta from the common reporting code.
This is desired as only the Generic mode will be using per-object metadata
after this series.

Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/generic.c | 14 +++++++++++++-
 mm/kasan/kasan.h   |  4 +++-
 mm/kasan/report.c  |  8 ++++----
 mm/kasan/tags.c    | 14 +++++++++++++-
 4 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 98c451a3b01f..f212b9ae57b5 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -381,8 +381,20 @@ void kasan_save_free_info(struct kmem_cache *cache,
 	*(u8 *)kasan_mem_to_shadow(object) = KASAN_SLAB_FREETRACK;
 }
 
+struct kasan_track *kasan_get_alloc_track(struct kmem_cache *cache,
+						void *object)
+{
+	struct kasan_alloc_meta *alloc_meta;
+
+	alloc_meta = kasan_get_alloc_meta(cache, object);
+	if (!alloc_meta)
+		return NULL;
+
+	return &alloc_meta->alloc_track;
+}
+
 struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
-				void *object, u8 tag)
+						void *object, u8 tag)
 {
 	if (*(u8 *)kasan_mem_to_shadow(object) != KASAN_SLAB_FREETRACK)
 		return NULL;
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 30ff341b6d35..b65a51349c51 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -283,8 +283,10 @@ depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc);
 void kasan_set_track(struct kasan_track *track, gfp_t flags);
 void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags);
 void kasan_save_free_info(struct kmem_cache *cache, void *object, u8 tag);
+struct kasan_track *kasan_get_alloc_track(struct kmem_cache *cache,
+						void *object);
 struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
-				void *object, u8 tag);
+						void *object, u8 tag);
 
 #if defined(CONFIG_KASAN_GENERIC) && \
 	(defined(CONFIG_SLAB) || defined(CONFIG_SLUB))
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index cd9f5c7fc6db..5d225d7d9c4c 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -255,12 +255,12 @@ static void describe_object_addr(struct kmem_cache *cache, void *object,
 static void describe_object_stacks(struct kmem_cache *cache, void *object,
 					const void *addr, u8 tag)
 {
-	struct kasan_alloc_meta *alloc_meta;
+	struct kasan_track *alloc_track;
 	struct kasan_track *free_track;
 
-	alloc_meta = kasan_get_alloc_meta(cache, object);
-	if (alloc_meta) {
-		print_track(&alloc_meta->alloc_track, "Allocated");
+	alloc_track = kasan_get_alloc_track(cache, object);
+	if (alloc_track) {
+		print_track(alloc_track, "Allocated");
 		pr_err("\n");
 	}
 
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index e0e5de8ce834..7b1fc8e7c99c 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -38,8 +38,20 @@ void kasan_save_free_info(struct kmem_cache *cache,
 	kasan_set_track(&alloc_meta->free_track, GFP_NOWAIT);
 }
 
+struct kasan_track *kasan_get_alloc_track(struct kmem_cache *cache,
+						void *object)
+{
+	struct kasan_alloc_meta *alloc_meta;
+
+	alloc_meta = kasan_get_alloc_meta(cache, object);
+	if (!alloc_meta)
+		return NULL;
+
+	return &alloc_meta->alloc_track;
+}
+
 struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
-				void *object, u8 tag)
+						void *object, u8 tag)
 {
 	struct kasan_alloc_meta *alloc_meta;
 
-- 
2.25.1


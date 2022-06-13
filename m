Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB80454A053
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351293AbiFMUzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351356AbiFMUxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:53:30 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219B338BD
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:16:32 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655151390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d1nMQkX323PpKYmvfsU+42+pLQR/Ix0WXYjxZevQJDs=;
        b=tkqmGQlVmT9T10yy+r5O66k2aRn1tP1CX+k8oCDGFj5Snxv9t4TZYZ7Vi9HZvOZ3BbqGsM
        MGvdG/umQJR++l04hOTWkanxJx/3wT+/ttiN2hygbiL8++91Fpu+AaahgdJp87G2k6mOes
        Ye+OlgpaL8/h62wvLV2Z4Xew87cJWuY=
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
Subject: [PATCH 10/32] kasan: move kasan_get_*_meta to generic.c
Date:   Mon, 13 Jun 2022 22:14:01 +0200
Message-Id: <cb77ebceeb6da2a721989ec2031dac2186f8b7b4.1655150842.git.andreyknvl@google.com>
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

Move the implementations of kasan_get_alloc/free_meta() to generic.c,
as the common KASAN code does not use these functions anymore.

Also drop kasan_reset_tag() from the implementation, as the Generic
mode does not tag pointers.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/common.c  | 19 -------------------
 mm/kasan/generic.c | 17 +++++++++++++++++
 mm/kasan/kasan.h   | 14 +++++++-------
 3 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index f0ee1c1b4b3c..226eaa714da2 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -228,25 +228,6 @@ size_t __kasan_metadata_size(struct kmem_cache *cache)
 		 sizeof(struct kasan_free_meta) : 0);
 }
 
-struct kasan_alloc_meta *kasan_get_alloc_meta(struct kmem_cache *cache,
-					      const void *object)
-{
-	if (!cache->kasan_info.alloc_meta_offset)
-		return NULL;
-	return kasan_reset_tag(object) + cache->kasan_info.alloc_meta_offset;
-}
-
-#ifdef CONFIG_KASAN_GENERIC
-struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
-					    const void *object)
-{
-	BUILD_BUG_ON(sizeof(struct kasan_free_meta) > 32);
-	if (cache->kasan_info.free_meta_offset == KASAN_NO_FREE_META)
-		return NULL;
-	return kasan_reset_tag(object) + cache->kasan_info.free_meta_offset;
-}
-#endif
-
 void __kasan_poison_slab(struct slab *slab)
 {
 	struct page *page = slab_page(slab);
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 5462ddbc21e6..fa654cb96a0d 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -328,6 +328,23 @@ DEFINE_ASAN_SET_SHADOW(f3);
 DEFINE_ASAN_SET_SHADOW(f5);
 DEFINE_ASAN_SET_SHADOW(f8);
 
+struct kasan_alloc_meta *kasan_get_alloc_meta(struct kmem_cache *cache,
+					      const void *object)
+{
+	if (!cache->kasan_info.alloc_meta_offset)
+		return NULL;
+	return (void *)object + cache->kasan_info.alloc_meta_offset;
+}
+
+struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
+					    const void *object)
+{
+	BUILD_BUG_ON(sizeof(struct kasan_free_meta) > 32);
+	if (cache->kasan_info.free_meta_offset == KASAN_NO_FREE_META)
+		return NULL;
+	return (void *)object + cache->kasan_info.free_meta_offset;
+}
+
 void kasan_init_object_meta(struct kmem_cache *cache, const void *object)
 {
 	struct kasan_alloc_meta *alloc_meta;
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 751c3b17749a..ff7a1597aa51 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -208,13 +208,6 @@ struct kunit_kasan_status {
 };
 #endif
 
-struct kasan_alloc_meta *kasan_get_alloc_meta(struct kmem_cache *cache,
-						const void *object);
-#ifdef CONFIG_KASAN_GENERIC
-struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
-						const void *object);
-#endif
-
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 
 static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
@@ -280,6 +273,13 @@ struct slab *kasan_addr_to_slab(const void *addr);
 
 void kasan_init_object_meta(struct kmem_cache *cache, const void *object);
 
+#ifdef CONFIG_KASAN_GENERIC
+struct kasan_alloc_meta *kasan_get_alloc_meta(struct kmem_cache *cache,
+						const void *object);
+struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
+						const void *object);
+#endif
+
 depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc);
 void kasan_set_track(struct kasan_track *track, gfp_t flags);
 void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags);
-- 
2.25.1


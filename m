Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3CB5ADAB7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 23:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237816AbiIEVJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 17:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238007AbiIEVJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 17:09:25 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DD76747D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 14:09:11 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662412149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GJNa42EfTEJvCRozp6uSNsCmZYGjNgR5hCDWvh6WqdM=;
        b=EOUi110qiL5m6CYlGoiFzJCMtAnTBi37TtlW/2SzC9QtukUQtLPWx4amH0NMBwNUFxb9ld
        XYcbQdK/gf0nFsypgmgSgQH+jmRWIQsy+KSrcLT0mOD4ZA1eYsv87PY3uLuH7mdxd2LPcf
        +6yhl00URNOUMloET/QVp0Od9C2aCFk=
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
Subject: [PATCH mm v3 19/34] kasan: pass tagged pointers to kasan_save_alloc/free_info
Date:   Mon,  5 Sep 2022 23:05:34 +0200
Message-Id: <d5bc48cfcf0dca8269dc3ed863047e4d4d2030f1.1662411799.git.andreyknvl@google.com>
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

Pass tagged pointers to kasan_save_alloc/free_info().

This is a preparatory patch to simplify other changes in the series.

Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v1->v2:
- Drop unused variable tag from ____kasan_slab_free().
---
 mm/kasan/common.c  | 6 ++----
 mm/kasan/generic.c | 3 +--
 mm/kasan/kasan.h   | 2 +-
 mm/kasan/tags.c    | 3 +--
 4 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 8efa63190951..f8e16a242197 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -193,13 +193,11 @@ void * __must_check __kasan_init_slab_obj(struct kmem_cache *cache,
 static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
 				unsigned long ip, bool quarantine, bool init)
 {
-	u8 tag;
 	void *tagged_object;
 
 	if (!kasan_arch_is_ready())
 		return false;
 
-	tag = get_tag(object);
 	tagged_object = object;
 	object = kasan_reset_tag(object);
 
@@ -228,7 +226,7 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
 		return false;
 
 	if (kasan_stack_collection_enabled())
-		kasan_save_free_info(cache, object, tag);
+		kasan_save_free_info(cache, tagged_object);
 
 	return kasan_quarantine_put(cache, object);
 }
@@ -317,7 +315,7 @@ void * __must_check __kasan_slab_alloc(struct kmem_cache *cache,
 
 	/* Save alloc info (if possible) for non-kmalloc() allocations. */
 	if (kasan_stack_collection_enabled() && !cache->kasan_info.is_kmalloc)
-		kasan_save_alloc_info(cache, (void *)object, flags);
+		kasan_save_alloc_info(cache, tagged_object, flags);
 
 	return tagged_object;
 }
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index f6bef347de87..aff39af3c532 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -500,8 +500,7 @@ void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
 		kasan_set_track(&alloc_meta->alloc_track, flags);
 }
 
-void kasan_save_free_info(struct kmem_cache *cache,
-				void *object, u8 tag)
+void kasan_save_free_info(struct kmem_cache *cache, void *object)
 {
 	struct kasan_free_meta *free_meta;
 
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index cae60e4d8842..cca49ab029f1 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -309,7 +309,7 @@ static inline void kasan_init_object_meta(struct kmem_cache *cache, const void *
 depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc);
 void kasan_set_track(struct kasan_track *track, gfp_t flags);
 void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags);
-void kasan_save_free_info(struct kmem_cache *cache, void *object, u8 tag);
+void kasan_save_free_info(struct kmem_cache *cache, void *object);
 struct kasan_track *kasan_get_alloc_track(struct kmem_cache *cache,
 						void *object);
 struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index 4f24669085e9..fd11d10a4ffc 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -21,8 +21,7 @@ void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
 {
 }
 
-void kasan_save_free_info(struct kmem_cache *cache,
-				void *object, u8 tag)
+void kasan_save_free_info(struct kmem_cache *cache, void *object)
 {
 }
 
-- 
2.25.1


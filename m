Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0865A54A076
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350654AbiFMU4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351900AbiFMUyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:54:02 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D7225C6B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:18:40 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655151519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jgPdc9N08SZf7w3C2n6o7Rgh7KKDeUV8LWJsDjGx3bA=;
        b=NmokpH+0cZI1My+Kia6o4N/O4CH1Ohkjye7zoCZBpU1Oofm2/IDEHcGCtizwC2kU/Qynz0
        kCcd+7/0tQh3lhwo+1v6s5zZk7oX4ARtAEv77wfd1kD14waBO/6XQfX/fRbKwWkaT26638
        Eap9dZbPU9cl4Q2BDYbidCoIAg6Cj8c=
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
Subject: [PATCH 19/32] kasan: pass tagged pointers to kasan_save_alloc/free_info
Date:   Mon, 13 Jun 2022 22:14:10 +0200
Message-Id: <9363b16202fb04a3223de714e70b7a6b72c4367e.1655150842.git.andreyknvl@google.com>
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

Pass tagged pointers to kasan_save_alloc/free_info().

This is a preparatory patch to simplify other changes in the series.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/common.c  | 4 ++--
 mm/kasan/generic.c | 3 +--
 mm/kasan/kasan.h   | 2 +-
 mm/kasan/tags.c    | 3 +--
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index f937b6c9e86a..519fd0b3040b 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -227,7 +227,7 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
 		return false;
 
 	if (kasan_stack_collection_enabled())
-		kasan_save_free_info(cache, object, tag);
+		kasan_save_free_info(cache, tagged_object);
 
 	return kasan_quarantine_put(cache, object);
 }
@@ -316,7 +316,7 @@ void * __must_check __kasan_slab_alloc(struct kmem_cache *cache,
 
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
index 30ec9ebf52c3..e8329935fbfb 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -308,7 +308,7 @@ static inline void kasan_init_object_meta(struct kmem_cache *cache, const void *
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


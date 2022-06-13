Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BF954A0AA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351667AbiFMU6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347654AbiFMUxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:53:17 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF60DFC0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:15:26 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655151325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j0yWL0nsrOMOMqm9cWej2oW3wFadR2W9VWyegnjYrXA=;
        b=B7wM0RDK6hT1iWd1oUZiXw42RuPFZUK3/bZLcb0cf6S+yJLUMeFAXOOhzQih3C24QAGjKu
        ePUXricowL++fSJ9e4X99sgTfnTXB5Gb7y6BsYumoyibHSSIGQKAHwJJtceNv7t7xMo8tQ
        2bSz7OqlMXc+P6DOs7u4kWu0lyWZllE=
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
Subject: [PATCH 02/32] kasan: rename kasan_set_*_info to kasan_save_*_info
Date:   Mon, 13 Jun 2022 22:13:53 +0200
Message-Id: <50cdd8e8d696a8958b7b59c940561c6ed8042436.1655150842.git.andreyknvl@google.com>
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

Rename set_alloc_info() and kasan_set_free_info() to save_alloc_info()
and kasan_save_free_info(). The new names make more sense.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/common.c  | 8 ++++----
 mm/kasan/generic.c | 2 +-
 mm/kasan/kasan.h   | 2 +-
 mm/kasan/tags.c    | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 968d2365d8c1..753775b894b6 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -364,7 +364,7 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
 		return false;
 
 	if (kasan_stack_collection_enabled())
-		kasan_set_free_info(cache, object, tag);
+		kasan_save_free_info(cache, object, tag);
 
 	return kasan_quarantine_put(cache, object);
 }
@@ -423,7 +423,7 @@ void __kasan_slab_free_mempool(void *ptr, unsigned long ip)
 	}
 }
 
-static void set_alloc_info(struct kmem_cache *cache, void *object,
+static void save_alloc_info(struct kmem_cache *cache, void *object,
 				gfp_t flags, bool is_kmalloc)
 {
 	struct kasan_alloc_meta *alloc_meta;
@@ -467,7 +467,7 @@ void * __must_check __kasan_slab_alloc(struct kmem_cache *cache,
 
 	/* Save alloc info (if possible) for non-kmalloc() allocations. */
 	if (kasan_stack_collection_enabled())
-		set_alloc_info(cache, (void *)object, flags, false);
+		save_alloc_info(cache, (void *)object, flags, false);
 
 	return tagged_object;
 }
@@ -513,7 +513,7 @@ static inline void *____kasan_kmalloc(struct kmem_cache *cache,
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
index 610d60d6e5b8..6df8d7b01073 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -284,7 +284,7 @@ struct slab *kasan_addr_to_slab(const void *addr);
 
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


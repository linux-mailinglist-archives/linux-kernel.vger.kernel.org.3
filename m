Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54AC054A050
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351211AbiFMUyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350763AbiFMUxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:53:18 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0363DDFDE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:15:27 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655151325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5YxZt8AJdg20zeg5mlaLc0cE80lCSk74fkwRwLQH28g=;
        b=vNtdLTu/n3uZXNxwSADnWXXhRvSCEmqvLH3FjLwQYNnr7TcYt1H3qoRfDAzhIfr++YtDwz
        DKhTZe2bKI12WI17MUbeLtNkumWSZskhDTHfG69P2kj/KpodD0zAj2B3BsQUqDUogXpISQ
        4ac6Q6f0pE/XLiSdQl54Sxg/q37QO3s=
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
Subject: [PATCH 03/32] kasan: move is_kmalloc check out of save_alloc_info
Date:   Mon, 13 Jun 2022 22:13:54 +0200
Message-Id: <ad7b6cfa3fbe10d2d9c4d15a9d30c2db9a41362c.1655150842.git.andreyknvl@google.com>
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

Move kasan_info.is_kmalloc check out of save_alloc_info().

This is a preparatory change that simplifies the following patches
in this series.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/common.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 753775b894b6..a6107e8375e0 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -423,15 +423,10 @@ void __kasan_slab_free_mempool(void *ptr, unsigned long ip)
 	}
 }
 
-static void save_alloc_info(struct kmem_cache *cache, void *object,
-				gfp_t flags, bool is_kmalloc)
+static void save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
 {
 	struct kasan_alloc_meta *alloc_meta;
 
-	/* Don't save alloc info for kmalloc caches in kasan_slab_alloc(). */
-	if (cache->kasan_info.is_kmalloc && !is_kmalloc)
-		return;
-
 	alloc_meta = kasan_get_alloc_meta(cache, object);
 	if (alloc_meta)
 		kasan_set_track(&alloc_meta->alloc_track, flags);
@@ -466,8 +461,8 @@ void * __must_check __kasan_slab_alloc(struct kmem_cache *cache,
 	kasan_unpoison(tagged_object, cache->object_size, init);
 
 	/* Save alloc info (if possible) for non-kmalloc() allocations. */
-	if (kasan_stack_collection_enabled())
-		save_alloc_info(cache, (void *)object, flags, false);
+	if (kasan_stack_collection_enabled() && !cache->kasan_info.is_kmalloc)
+		save_alloc_info(cache, (void *)object, flags);
 
 	return tagged_object;
 }
@@ -512,8 +507,8 @@ static inline void *____kasan_kmalloc(struct kmem_cache *cache,
 	 * Save alloc info (if possible) for kmalloc() allocations.
 	 * This also rewrites the alloc info when called from kasan_krealloc().
 	 */
-	if (kasan_stack_collection_enabled())
-		save_alloc_info(cache, (void *)object, flags, true);
+	if (kasan_stack_collection_enabled() && cache->kasan_info.is_kmalloc)
+		save_alloc_info(cache, (void *)object, flags);
 
 	/* Keep the tag that was set by kasan_slab_alloc(). */
 	return (void *)object;
-- 
2.25.1


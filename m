Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E06750090C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241351AbiDNJBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241334AbiDNJAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:00:34 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CD46A035
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:58:10 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id s8so4256307pfk.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=puoTxozYPPe1WBJOeEiOmhEKhJO+f8Zoi/BnyAhKQd8=;
        b=cdksr7EV49IyEJgLUz1YWDTL9lJ/zdfWCGdXtI9Bh0TKKCe9eNh2TlIy4BlUAgAKC6
         pUG2zCtCjSVzx33NAuhCNZLPINqhW5RFCGOTvuSw6R9sdp9BRwMW+slA01wYuSmUIHUJ
         QOWhpVTp1JVhPuHxZO5FvGsP6u76460r6QxrVOKjXOGFqhLVMPGKuTv0Y5GFDi4JRz1B
         0trDBxOgXfgi7wNmvFjM9EbAa+QLrLxC+iXRis/JYgzqurNP6MiMTeQ/pjG4lh21Ymkl
         ixXRImK43ZXqcpydtsny7uQVxBezw9010hdqZWsIQd1hZgE+ssHU28Cse+Jcs3es+08b
         Is9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=puoTxozYPPe1WBJOeEiOmhEKhJO+f8Zoi/BnyAhKQd8=;
        b=JhqIprXv7DOwvGH9Uxv3d6BmPpffapqFEHU/PgKN0m0eyGQ7OI5Xln1sL6jnk4upNy
         B69elEl7BQNDhprL358LMY+LzoF5i8/X7oZVeSNoR7gP0JO9n2x1mNygD1KgjvFt3UR1
         ZwD/R1Abqp8wrJluYfJJjouldhwcr1oJI5JMs8Fg3qoow+4MDWWtKcNC/vQ/p/zPrac8
         rkksochSNfL4r1R8Rbrh0nZT4tark9u/Genm/psY4tdspBlejwJU7HvCOUJ0bcl0LmYi
         h2/231JIKJ6UTojdvQTAZrWvoeIvXFJXBx16+nzxvUoU+wdCr12rUFaAT3gYwqdqgwcq
         YpdA==
X-Gm-Message-State: AOAM530VX+JjtjZ0e3kLTR70cRVBA9wGzVT+t3dlO4LAzVSL4sCNja3E
        v+s09gKwpYol7Zw9a972Vx4=
X-Google-Smtp-Source: ABdhPJzR2qAtqNLzPfNtBk/cK7xehrYa7p742CXwvRI/dSLx9v1+BABWqj52kjI0Nkv1Qjq5r9dLmw==
X-Received: by 2002:a05:6a00:a12:b0:504:e93f:2dd9 with SMTP id p18-20020a056a000a1200b00504e93f2dd9mr2886591pfh.49.1649926689688;
        Thu, 14 Apr 2022 01:58:09 -0700 (PDT)
Received: from hyeyoo.. ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id p9-20020aa79e89000000b00505fada20dfsm1403537pfq.117.2022.04.14.01.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:58:07 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/23] mm/slab_common: cleanup __kmalloc()
Date:   Thu, 14 Apr 2022 17:57:09 +0900
Message-Id: <20220414085727.643099-6-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220414085727.643099-1-42.hyeyoo@gmail.com>
References: <20220414085727.643099-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make __kmalloc() wrapper of __kmalloc_node().

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 include/linux/slab.h | 13 ++++++++++---
 mm/slab.c            | 34 ----------------------------------
 mm/slob.c            |  6 ------
 mm/slub.c            | 23 -----------------------
 4 files changed, 10 insertions(+), 66 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index acdb4b7428f9..4c06d15f731c 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -419,7 +419,16 @@ static __always_inline unsigned int __kmalloc_index(size_t size,
 #define kmalloc_index(s) __kmalloc_index(s, true)
 #endif /* !CONFIG_SLOB */
 
-void *__kmalloc(size_t size, gfp_t flags) __assume_kmalloc_alignment __alloc_size(1);
+extern void *__kmalloc_node(size_t size, gfp_t flags, int node)
+			    __assume_kmalloc_alignment
+			    __alloc_size(1);
+
+static __always_inline __alloc_size(1) __assume_kmalloc_alignment
+void *__kmalloc(size_t size, gfp_t flags)
+{
+	return __kmalloc_node(size, flags, NUMA_NO_NODE);
+}
+
 void *kmem_cache_alloc(struct kmem_cache *s, gfp_t flags) __assume_slab_alignment __malloc;
 void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
 			   gfp_t gfpflags) __assume_slab_alignment __malloc;
@@ -444,8 +453,6 @@ static __always_inline void kfree_bulk(size_t size, void **p)
 	kmem_cache_free_bulk(NULL, size, p);
 }
 
-void *__kmalloc_node(size_t size, gfp_t flags, int node) __assume_kmalloc_alignment
-							 __alloc_size(1);
 void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t flags, int node) __assume_slab_alignment
 									 __malloc;
 
diff --git a/mm/slab.c b/mm/slab.c
index 5f20efc7a330..db7eab9e2e9f 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3641,40 +3641,6 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
 }
 #endif
 
-/**
- * __do_kmalloc - allocate memory
- * @size: how many bytes of memory are required.
- * @flags: the type of memory to allocate (see kmalloc).
- * @caller: function caller for debug tracking of the caller
- *
- * Return: pointer to the allocated memory or %NULL in case of error
- */
-static __always_inline void *__do_kmalloc(size_t size, gfp_t flags,
-					  unsigned long caller)
-{
-	struct kmem_cache *cachep;
-	void *ret;
-
-	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
-		return NULL;
-	cachep = kmalloc_slab(size, flags);
-	if (unlikely(ZERO_OR_NULL_PTR(cachep)))
-		return cachep;
-	ret = slab_alloc(cachep, NULL, flags, size, caller);
-
-	ret = kasan_kmalloc(cachep, ret, size, flags);
-	trace_kmalloc(caller, ret,
-		      size, cachep->size, flags);
-
-	return ret;
-}
-
-void *__kmalloc(size_t size, gfp_t flags)
-{
-	return __do_kmalloc(size, flags, _RET_IP_);
-}
-EXPORT_SYMBOL(__kmalloc);
-
 /**
  * kmem_cache_free - Deallocate an object
  * @cachep: The cache the allocation was from.
diff --git a/mm/slob.c b/mm/slob.c
index 6d0fc6ad1413..ab67c8219e8d 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -522,12 +522,6 @@ __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
 	return ret;
 }
 
-void *__kmalloc(size_t size, gfp_t gfp)
-{
-	return __do_kmalloc_node(size, gfp, NUMA_NO_NODE, _RET_IP_);
-}
-EXPORT_SYMBOL(__kmalloc);
-
 void *__kmalloc_node_track_caller(size_t size, gfp_t gfp,
 					int node, unsigned long caller)
 {
diff --git a/mm/slub.c b/mm/slub.c
index e425c5c372de..44170b4f084b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4399,29 +4399,6 @@ static int __init setup_slub_min_objects(char *str)
 
 __setup("slub_min_objects=", setup_slub_min_objects);
 
-void *__kmalloc(size_t size, gfp_t flags)
-{
-	struct kmem_cache *s;
-	void *ret;
-
-	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
-		return kmalloc_large(size, flags);
-
-	s = kmalloc_slab(size, flags);
-
-	if (unlikely(ZERO_OR_NULL_PTR(s)))
-		return s;
-
-	ret = slab_alloc(s, NULL, flags, _RET_IP_, size);
-
-	trace_kmalloc(_RET_IP_, ret, size, s->size, flags);
-
-	ret = kasan_kmalloc(s, ret, size, flags);
-
-	return ret;
-}
-EXPORT_SYMBOL(__kmalloc);
-
 static void *kmalloc_large_node(size_t size, gfp_t flags, int node)
 {
 	struct page *page;
-- 
2.32.0


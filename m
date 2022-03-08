Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BC94D1677
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346655AbiCHLoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346583AbiCHLnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:43:51 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC4CDF06
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 03:42:43 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id k92so7800582pjh.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 03:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WyJUzAbm9yHjJ4QKSKKsRPqOaZ/q3Aw9wGC8avt4y3A=;
        b=SPOB2Is9v5XHsx3KQKzQnq3I+g7W8LG2kR7QM7TXpvg7Yy/WQuHZEsBvJVobSOf7TL
         S0Y5M5vqJcfdS51VXiGAzQe5WwhM5NXOmkw5bdY5Q5WSxRN4ffqzxXZnkMpWzqC0nsGC
         pQKd/G9pyhqk62HNgFxlL3PPLu7a4u7RKHj6qguBWeNrl81xQHwFBaXc4YcGDx74fQ6H
         /EQeI77O1+2AC+zZFbojMcQ+ZmaVDV00jrpTjS7YIaHHMzUUkSb1zVu9+gaXwFZ2+jW0
         ZYZooIb73Psyq0sG1WsaQl+lPMt4gf+lSMEp5zDZXy+VfkO2Jr+iNY9O2vezybOEWf6O
         wwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WyJUzAbm9yHjJ4QKSKKsRPqOaZ/q3Aw9wGC8avt4y3A=;
        b=j28bD6tILI+DBjS1g7TQfKc8UbWZ/3qYckA7q7ouzVvsFhkG0/QWgTSHvH+5tytaei
         o1oWGq0JyckD0D54zaH02qDt8qFr+cZEPfzK2ppvON4v+AWlLFJ9T3/1GuBxmY3bFGeD
         40yhxWinP4HBmrbrq8Oz34bbHb/7BZgZUX87l27gSjDP5RcfFsq8jsZW1U8nKguTGLZn
         re3DUSSsrOt8ipD16v9mrrwMPovqNtT6J9IGjoKnmMbMRgJoZWUcPCKBxDgbcdXsoINS
         yJugPtTnzyfALfw9XpifBj89+g3qERJIcysP2LoEImny2N7HTLRxHl5Cd7icpyA+/lUH
         pcWQ==
X-Gm-Message-State: AOAM532+oqU+BJJytVLa2ucItceAFOEfDuFP09gtnd3AGLDpTCq5jLCb
        VWX60YVILaueEcC4E8baV0k=
X-Google-Smtp-Source: ABdhPJwBBmcQhwZHwUbPZucQH/JdiAMEHfLJ+/PU4B7VIoOPrR4kHVV3U6pLD61NDo5NAPt4lomuqA==
X-Received: by 2002:a17:902:7298:b0:151:842b:a241 with SMTP id d24-20020a170902729800b00151842ba241mr16959617pll.115.1646739762983;
        Tue, 08 Mar 2022 03:42:42 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090ac40200b001bd0e552d27sm2578285pjt.11.2022.03.08.03.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 03:42:42 -0800 (PST)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     linux-mm@kvack.org
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org, 42.hyeyoo@gmail.com
Subject: [RFC PATCH v1 08/15] mm/sl[auo]b: cleanup kmalloc()
Date:   Tue,  8 Mar 2022 11:41:35 +0000
Message-Id: <20220308114142.1744229-9-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220308114142.1744229-1-42.hyeyoo@gmail.com>
References: <20220308114142.1744229-1-42.hyeyoo@gmail.com>
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

Now that kmalloc() and kmalloc_node() do same job, make kmalloc()
wrapper of kmalloc_node().

Remove kmalloc_trace() that is now unused. This patch makes slab
allocator use kmalloc_node tracepoints in kmalloc().

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 include/linux/slab.h | 82 +++++++++++++++++---------------------------
 mm/slab.c            | 14 --------
 mm/slub.c            |  9 -----
 3 files changed, 31 insertions(+), 74 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 33d4260bce8b..dfcc8301d969 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -460,9 +460,6 @@ static __always_inline void kfree_bulk(size_t size, void **p)
 	kmem_cache_free_bulk(NULL, size, p);
 }
 
-extern void *kmem_cache_alloc_trace(struct kmem_cache *s, gfp_t flags, size_t size)
-				   __assume_slab_alignment __alloc_size(3);
-
 extern void *kmem_cache_alloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
 					 int node, size_t size) __assume_slab_alignment
 								__alloc_size(4);
@@ -475,6 +472,36 @@ static __always_inline void *kmalloc_large(size_t size, gfp_t flags)
 	return kmalloc_large_node(size, flags, NUMA_NO_NODE);
 }
 
+#ifndef CONFIG_SLOB
+static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
+{
+	if (__builtin_constant_p(size)) {
+		unsigned int index;
+
+		if (size > KMALLOC_MAX_CACHE_SIZE)
+			return kmalloc_large(size, flags);
+
+		index = kmalloc_index(size);
+
+		if (!index)
+			return ZERO_SIZE_PTR;
+
+		return kmem_cache_alloc_node_trace(
+				kmalloc_caches[kmalloc_type(flags)][index],
+						flags, node, size);
+	}
+	return __kmalloc_node(size, flags, node);
+}
+#else
+static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
+{
+	if (__builtin_constant_p(size) && size > KMALLOC_MAX_CACHE_SIZE)
+		return kmalloc_large(size, flags);
+
+	return __kmalloc_node(size, flags, node);
+}
+#endif
+
 /**
  * kmalloc - allocate memory
  * @size: how many bytes of memory are required.
@@ -531,55 +558,8 @@ static __always_inline void *kmalloc_large(size_t size, gfp_t flags)
  */
 static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
 {
-	if (__builtin_constant_p(size)) {
-#ifndef CONFIG_SLOB
-		unsigned int index;
-#endif
-		if (size > KMALLOC_MAX_CACHE_SIZE)
-			return kmalloc_large(size, flags);
-#ifndef CONFIG_SLOB
-		index = kmalloc_index(size);
-
-		if (!index)
-			return ZERO_SIZE_PTR;
-
-		return kmem_cache_alloc_trace(
-				kmalloc_caches[kmalloc_type(flags)][index],
-				flags, size);
-#endif
-	}
-	return __kmalloc(size, flags);
-}
-
-#ifndef CONFIG_SLOB
-static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
-{
-	if (__builtin_constant_p(size)) {
-		unsigned int index;
-
-		if (size > KMALLOC_MAX_CACHE_SIZE)
-			return kmalloc_large_node(size, flags, node);
-
-		index = kmalloc_index(size);
-
-		if (!index)
-			return ZERO_SIZE_PTR;
-
-		return kmem_cache_alloc_node_trace(
-				kmalloc_caches[kmalloc_type(flags)][i],
-						flags, node, size);
-	}
-	return __kmalloc_node(size, flags, node);
-}
-#else
-static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
-{
-	if (__builtin_constant_p(size) && size > KMALLOC_MAX_CACHE_SIZE)
-		return kmalloc_large_node(size, flags, node);
-
-	return __kmalloc_node(size, flags, node);
+	return kmalloc_node(size, flags, NUMA_NO_NODE);
 }
-#endif
 
 /**
  * kmalloc_array - allocate memory for an array.
diff --git a/mm/slab.c b/mm/slab.c
index 1f3195344bdf..6ebf509bf2de 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3519,20 +3519,6 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 }
 EXPORT_SYMBOL(kmem_cache_alloc_bulk);
 
-void *
-kmem_cache_alloc_trace(struct kmem_cache *cachep, gfp_t flags, size_t size)
-{
-	void *ret;
-
-	ret = slab_alloc(cachep, flags, size, _RET_IP_);
-
-	ret = kasan_kmalloc(cachep, ret, size, flags);
-	trace_kmalloc(_RET_IP_, ret,
-		      size, cachep->size, flags);
-	return ret;
-}
-EXPORT_SYMBOL(kmem_cache_alloc_trace);
-
 /**
  * kmem_cache_alloc_node - Allocate an object on the specified node
  * @cachep: The cache to allocate from.
diff --git a/mm/slub.c b/mm/slub.c
index cdbbf0e97637..d8fb987ff7e0 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3230,15 +3230,6 @@ static __always_inline void *slab_alloc(struct kmem_cache *s,
 	return slab_alloc_node(s, gfpflags, NUMA_NO_NODE, addr, orig_size);
 }
 
-void *kmem_cache_alloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
-{
-	void *ret = slab_alloc(s, gfpflags, _RET_IP_, size);
-	trace_kmalloc(_RET_IP_, ret, size, s->size, gfpflags);
-	ret = kasan_kmalloc(s, ret, size, gfpflags);
-	return ret;
-}
-EXPORT_SYMBOL(kmem_cache_alloc_trace);
-
 void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
 {
 	void *ret = slab_alloc_node(s, gfpflags, node, _RET_IP_, s->object_size);
-- 
2.33.1


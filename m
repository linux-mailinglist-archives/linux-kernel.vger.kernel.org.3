Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D55D571B7B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbiGLNkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbiGLNkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:40:08 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50DAB655E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:40:03 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id o3-20020a17090a744300b001ef8f7f3dddso8014839pjk.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1gwXwcTxbtqS306f0SRAhtNxfxeXqjslTrtEUxnOJNw=;
        b=BCoKGtiIYwndVeEjknYETv1h9O/+3SP5RRacoN1ak4QTh9SzE6i/tUYYmWh8zFxNmY
         Pkdd6EOifVnZwZkTUQjvG8AvF3GpJ9JF3iauraj4OLKEYUouc1RtQk/iXIsvzyMnsVmu
         cwoXbEtFkGrj8ynvr03lfdsu4HAps3BNvgNDYglyC0LliGKQ0+m3OOOBYgN4mma4vyGh
         jqe6H5gf5Be7uy9KdoRK01ZYeXy+VwFkttgU7IG/pVLyQ9Fa9vZ0Mr4e6GIKP/bPmzSY
         NjVqWUAdKh/+r5iv3rHasQ3Niq7pnidg/B4ojuMciWxPpM/940QOqakFDP6cvBDEHF4u
         35LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1gwXwcTxbtqS306f0SRAhtNxfxeXqjslTrtEUxnOJNw=;
        b=GSn+RTMKU5iVzI1ctGF8C3SRr6sVLqr+9n5R8YGqydkFpXcvfH+iFV3VLeElpnPVtn
         2H5XOBJZYb2VjVSHteVt1a59fRpgBfrh0ThBcE4DcrjghJQCeMnIr0Z7AH3QII/YJKru
         yq4UFz1z0Xr+/rlp2HL3aRe/XM3G3xn0ax+WaJwTvOHHXrpaejYRHUhPrj7joKRzP7Cd
         lS43zhjtI2jkJsbsuHpMiZTZQFiHmnxsOKIZjxPZWNBl5kR/aNexrHHESuZqMW2v2L7f
         z9NyQeZwJSLjyV/+1xGXbrxobrDpwKc0EHra0wPoDlIPowRlZCTUjeb1diVK4WzfCChS
         oBlQ==
X-Gm-Message-State: AJIora/dL9VZUwxoKEOgoyE79zVFpiX3+Taw7cZqc5ZnIrvALBZCrfL+
        iYgERDfUFw0amehSLMpiqbQ=
X-Google-Smtp-Source: AGRyM1vcwqPEhg/cIcX+w8wud4nD7jfJS5OlGxdHMSCzwYC+DiGDAkESXL3iUAr1hyBm3yP+P3AQSA==
X-Received: by 2002:a17:90b:3841:b0:1ef:f0ac:de55 with SMTP id nl1-20020a17090b384100b001eff0acde55mr4565802pjb.35.1657633202990;
        Tue, 12 Jul 2022 06:40:02 -0700 (PDT)
Received: from ip-172-31-24-42.ap-northeast-1.compute.internal (ec2-35-75-15-180.ap-northeast-1.compute.amazonaws.com. [35.75.15.180])
        by smtp.gmail.com with ESMTPSA id r6-20020aa79886000000b0052ae3bcb807sm1947178pfl.188.2022.07.12.06.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 06:40:02 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Joe Perches <joe@perches.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        Matthew WilCox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v3 03/15] mm/slab_common: remove CONFIG_NUMA ifdefs for common kmalloc functions
Date:   Tue, 12 Jul 2022 13:39:33 +0000
Message-Id: <20220712133946.307181-4-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220712133946.307181-1-42.hyeyoo@gmail.com>
References: <20220712133946.307181-1-42.hyeyoo@gmail.com>
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

Now that slab_alloc_node() is available for SLAB when CONFIG_NUMA=n,
remove CONFIG_NUMA ifdefs for common kmalloc functions.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slab.h | 28 ----------------------------
 mm/slab.c            |  2 --
 mm/slob.c            |  5 +----
 mm/slub.c            |  6 ------
 4 files changed, 1 insertion(+), 40 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 0fefdf528e0d..4754c834b0e3 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -456,38 +456,18 @@ static __always_inline void kfree_bulk(size_t size, void **p)
 	kmem_cache_free_bulk(NULL, size, p);
 }
 
-#ifdef CONFIG_NUMA
 void *__kmalloc_node(size_t size, gfp_t flags, int node) __assume_kmalloc_alignment
 							 __alloc_size(1);
 void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t flags, int node) __assume_slab_alignment
 									 __malloc;
-#else
-static __always_inline __alloc_size(1) void *__kmalloc_node(size_t size, gfp_t flags, int node)
-{
-	return __kmalloc(size, flags);
-}
-
-static __always_inline void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t flags, int node)
-{
-	return kmem_cache_alloc(s, flags);
-}
-#endif
 
 #ifdef CONFIG_TRACING
 extern void *kmem_cache_alloc_trace(struct kmem_cache *s, gfp_t flags, size_t size)
 				   __assume_slab_alignment __alloc_size(3);
 
-#ifdef CONFIG_NUMA
 extern void *kmem_cache_alloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
 					 int node, size_t size) __assume_slab_alignment
 								__alloc_size(4);
-#else
-static __always_inline __alloc_size(4) void *kmem_cache_alloc_node_trace(struct kmem_cache *s,
-						 gfp_t gfpflags, int node, size_t size)
-{
-	return kmem_cache_alloc_trace(s, gfpflags, size);
-}
-#endif /* CONFIG_NUMA */
 
 #else /* CONFIG_TRACING */
 static __always_inline __alloc_size(3) void *kmem_cache_alloc_trace(struct kmem_cache *s,
@@ -701,20 +681,12 @@ static inline __alloc_size(1, 2) void *kcalloc_node(size_t n, size_t size, gfp_t
 }
 
 
-#ifdef CONFIG_NUMA
 extern void *__kmalloc_node_track_caller(size_t size, gfp_t flags, int node,
 					 unsigned long caller) __alloc_size(1);
 #define kmalloc_node_track_caller(size, flags, node) \
 	__kmalloc_node_track_caller(size, flags, node, \
 			_RET_IP_)
 
-#else /* CONFIG_NUMA */
-
-#define kmalloc_node_track_caller(size, flags, node) \
-	kmalloc_track_caller(size, flags)
-
-#endif /* CONFIG_NUMA */
-
 /*
  * Shortcuts
  */
diff --git a/mm/slab.c b/mm/slab.c
index 5ca8bb7335dc..81804921c538 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3535,7 +3535,6 @@ kmem_cache_alloc_trace(struct kmem_cache *cachep, gfp_t flags, size_t size)
 EXPORT_SYMBOL(kmem_cache_alloc_trace);
 #endif
 
-#ifdef CONFIG_NUMA
 /**
  * kmem_cache_alloc_node - Allocate an object on the specified node
  * @cachep: The cache to allocate from.
@@ -3609,7 +3608,6 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t flags,
 	return __do_kmalloc_node(size, flags, node, caller);
 }
 EXPORT_SYMBOL(__kmalloc_node_track_caller);
-#endif /* CONFIG_NUMA */
 
 #ifdef CONFIG_PRINTK
 void __kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
diff --git a/mm/slob.c b/mm/slob.c
index 56421fe461c4..c54aad6b106c 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -536,14 +536,12 @@ void *__kmalloc_track_caller(size_t size, gfp_t gfp, unsigned long caller)
 }
 EXPORT_SYMBOL(__kmalloc_track_caller);
 
-#ifdef CONFIG_NUMA
 void *__kmalloc_node_track_caller(size_t size, gfp_t gfp,
 					int node, unsigned long caller)
 {
 	return __do_kmalloc_node(size, gfp, node, caller);
 }
 EXPORT_SYMBOL(__kmalloc_node_track_caller);
-#endif
 
 void kfree(const void *block)
 {
@@ -647,7 +645,7 @@ void *kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru, gfp_
 	return slob_alloc_node(cachep, flags, NUMA_NO_NODE);
 }
 EXPORT_SYMBOL(kmem_cache_alloc_lru);
-#ifdef CONFIG_NUMA
+
 void *__kmalloc_node(size_t size, gfp_t gfp, int node)
 {
 	return __do_kmalloc_node(size, gfp, node, _RET_IP_);
@@ -659,7 +657,6 @@ void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t gfp, int node)
 	return slob_alloc_node(cachep, gfp, node);
 }
 EXPORT_SYMBOL(kmem_cache_alloc_node);
-#endif
 
 static void __kmem_cache_free(void *b, int size)
 {
diff --git a/mm/slub.c b/mm/slub.c
index 26b00951aad1..a5b3a4484263 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3287,7 +3287,6 @@ void *kmem_cache_alloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
 EXPORT_SYMBOL(kmem_cache_alloc_trace);
 #endif
 
-#ifdef CONFIG_NUMA
 void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
 {
 	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, s->object_size);
@@ -3314,7 +3313,6 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *s,
 }
 EXPORT_SYMBOL(kmem_cache_alloc_node_trace);
 #endif
-#endif	/* CONFIG_NUMA */
 
 /*
  * Slow path handling. This may still be called frequently since objects
@@ -4427,7 +4425,6 @@ void *__kmalloc(size_t size, gfp_t flags)
 }
 EXPORT_SYMBOL(__kmalloc);
 
-#ifdef CONFIG_NUMA
 static void *kmalloc_large_node(size_t size, gfp_t flags, int node)
 {
 	struct page *page;
@@ -4474,7 +4471,6 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node)
 	return ret;
 }
 EXPORT_SYMBOL(__kmalloc_node);
-#endif	/* CONFIG_NUMA */
 
 #ifdef CONFIG_HARDENED_USERCOPY
 /*
@@ -4930,7 +4926,6 @@ void *__kmalloc_track_caller(size_t size, gfp_t gfpflags, unsigned long caller)
 }
 EXPORT_SYMBOL(__kmalloc_track_caller);
 
-#ifdef CONFIG_NUMA
 void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
 					int node, unsigned long caller)
 {
@@ -4960,7 +4955,6 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
 	return ret;
 }
 EXPORT_SYMBOL(__kmalloc_node_track_caller);
-#endif
 
 #ifdef CONFIG_SYSFS
 static int count_inuse(struct slab *slab)
-- 
2.34.1


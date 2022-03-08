Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E8A4D1671
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343615AbiCHLnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346528AbiCHLnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:43:24 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACCDCF2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 03:42:27 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 15-20020a17090a098f00b001bef0376d5cso2138789pjo.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 03:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eynsZq3RW1+TrCJLl32w1TfmJK+jtWer17/XHi0Tnm8=;
        b=SD2+kTPAaRYy6LvnWQzAtcz8OTYBz917eB0UJ7koHUv9emT9HrKjarOJc1Kf75V27D
         +/NFn6ehrBBaEgwO0Mui0zNAZu8SJuRda2D/t/uOGSvhCHLxF73JT3Y1BaXvMOO3OhvB
         vL99ihHbrHmHShERq7w417PAoNoUw+0NOIZISUUs3VpuFukZ69t1S3dLVG7wgUVA1R4b
         A4mP0eYtO4wWznu1IFfqbe0MeNTSz1SdbTnkefnlqdu6r4bTDwqk4U+M7aVhUHKh4UH1
         M21qZ+V9oKFFmGya3CndW2e3A1DEdff9X/B+W3sqmzOhCuzzFlh0TT3lTSvGB1LUEMXk
         OxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eynsZq3RW1+TrCJLl32w1TfmJK+jtWer17/XHi0Tnm8=;
        b=P1MxhPNXk+x/FVzXZiy0w19o0/Yfnghd+G2dswudZSvwr4rTdhU0j/QrbHs4UyvVgS
         5d+0fKl80IqhNgPdVnZzV/5Ap6KS5Cm7sFNmNc84aUj0z4P3M7G1DexPFPHCQkmjIUkx
         Y8bBzwpbJZu9yyrqx7StQITsjvjZ2zY5uke8iGaxWPIriBoLdLeIsOxZ1fYFvwzggM0X
         6PlSXNFjLfyJFaX5VeEr5A+BaqQTom3UtZL+LJKgc28ov9hNftfniZPVtLaTSIs/nKhD
         lMr7trNqYKUhzR1ReN7huuk4Nh5qwlvbc/BLuW+mOGCj0poeYjkdx70jisTM5oP4Kr1T
         mBFQ==
X-Gm-Message-State: AOAM532iLkLERYb0IcOpImLd0MSMzd3IW6GDJv8PVuxGSgy6dNiELra1
        jGc2u/uTfdIhIhLt57Nm+1g=
X-Google-Smtp-Source: ABdhPJz9hCYwesf444Cvu2tnyBCQn0mYU/k5pynV7fTDn9ijc9L1PChHZtiv1m5TXgjgYNt+59OGQA==
X-Received: by 2002:a17:902:db0d:b0:14f:b047:8d22 with SMTP id m13-20020a170902db0d00b0014fb0478d22mr16624592plx.90.1646739747029;
        Tue, 08 Mar 2022 03:42:27 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090ac40200b001bd0e552d27sm2578285pjt.11.2022.03.08.03.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 03:42:26 -0800 (PST)
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
Subject: [RFC PATCH v1 03/15] mm/sl[au]b: remove CONFIG_TRACING ifdefs for tracing functions
Date:   Tue,  8 Mar 2022 11:41:30 +0000
Message-Id: <20220308114142.1744229-4-42.hyeyoo@gmail.com>
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

CONFIG_TRACING ifdefs are not necessary because tracepoints do nothing
on kernels without CONFIG_TRACING.

In later cleanup these functions will be removed.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 include/linux/slab.h | 29 -----------------------------
 mm/slab.c            |  4 ----
 mm/slab_common.c     |  2 --
 mm/slub.c            |  4 ----
 4 files changed, 39 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index df8e5dca00a2..a5e3ad058817 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -460,7 +460,6 @@ static __always_inline void kfree_bulk(size_t size, void **p)
 	kmem_cache_free_bulk(NULL, size, p);
 }
 
-#ifdef CONFIG_TRACING
 extern void *kmem_cache_alloc_trace(struct kmem_cache *s, gfp_t flags, size_t size)
 				   __assume_slab_alignment __alloc_size(3);
 
@@ -468,39 +467,11 @@ extern void *kmem_cache_alloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
 					 int node, size_t size) __assume_slab_alignment
 								__alloc_size(4);
 
-#else /* CONFIG_TRACING */
-static __always_inline __alloc_size(3) void *kmem_cache_alloc_trace(struct kmem_cache *s,
-								    gfp_t flags, size_t size)
-{
-	void *ret = kmem_cache_alloc(s, flags);
-
-	ret = kasan_kmalloc(s, ret, size, flags);
-	return ret;
-}
-
-static __always_inline void *kmem_cache_alloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
-							 int node, size_t size)
-{
-	void *ret = kmem_cache_alloc_node(s, gfpflags, node);
-
-	ret = kasan_kmalloc(s, ret, size, gfpflags);
-	return ret;
-}
-#endif /* CONFIG_TRACING */
-
 extern void *kmalloc_order(size_t size, gfp_t flags, unsigned int order) __assume_page_alignment
 									 __alloc_size(1);
 
-#ifdef CONFIG_TRACING
 extern void *kmalloc_order_trace(size_t size, gfp_t flags, unsigned int order)
 				__assume_page_alignment __alloc_size(1);
-#else
-static __always_inline __alloc_size(1) void *kmalloc_order_trace(size_t size, gfp_t flags,
-								 unsigned int order)
-{
-	return kmalloc_order(size, flags, order);
-}
-#endif
 
 static __always_inline __alloc_size(1) void *kmalloc_large(size_t size, gfp_t flags)
 {
diff --git a/mm/slab.c b/mm/slab.c
index b41124a1efd9..1f3195344bdf 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3519,7 +3519,6 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 }
 EXPORT_SYMBOL(kmem_cache_alloc_bulk);
 
-#ifdef CONFIG_TRACING
 void *
 kmem_cache_alloc_trace(struct kmem_cache *cachep, gfp_t flags, size_t size)
 {
@@ -3533,7 +3532,6 @@ kmem_cache_alloc_trace(struct kmem_cache *cachep, gfp_t flags, size_t size)
 	return ret;
 }
 EXPORT_SYMBOL(kmem_cache_alloc_trace);
-#endif
 
 /**
  * kmem_cache_alloc_node - Allocate an object on the specified node
@@ -3560,7 +3558,6 @@ void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)
 }
 EXPORT_SYMBOL(kmem_cache_alloc_node);
 
-#ifdef CONFIG_TRACING
 void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
 				  gfp_t flags,
 				  int nodeid,
@@ -3577,7 +3574,6 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
 	return ret;
 }
 EXPORT_SYMBOL(kmem_cache_alloc_node_trace);
-#endif
 
 static __always_inline void *
 __do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 23f2ab0713b7..2edb77056adc 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -954,7 +954,6 @@ void *kmalloc_order(size_t size, gfp_t flags, unsigned int order)
 }
 EXPORT_SYMBOL(kmalloc_order);
 
-#ifdef CONFIG_TRACING
 void *kmalloc_order_trace(size_t size, gfp_t flags, unsigned int order)
 {
 	void *ret = kmalloc_order(size, flags, order);
@@ -962,7 +961,6 @@ void *kmalloc_order_trace(size_t size, gfp_t flags, unsigned int order)
 	return ret;
 }
 EXPORT_SYMBOL(kmalloc_order_trace);
-#endif
 
 #ifdef CONFIG_SLAB_FREELIST_RANDOM
 /* Randomize a generic freelist */
diff --git a/mm/slub.c b/mm/slub.c
index 74369cadc243..267f700abac1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3238,7 +3238,6 @@ static __always_inline void *slab_alloc(struct kmem_cache *s,
 	return slab_alloc_node(s, gfpflags, NUMA_NO_NODE, addr, orig_size);
 }
 
-#ifdef CONFIG_TRACING
 void *kmem_cache_alloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
 {
 	void *ret = slab_alloc(s, gfpflags, _RET_IP_, size);
@@ -3247,7 +3246,6 @@ void *kmem_cache_alloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
 	return ret;
 }
 EXPORT_SYMBOL(kmem_cache_alloc_trace);
-#endif
 
 void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
 {
@@ -3260,7 +3258,6 @@ void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
 }
 EXPORT_SYMBOL(kmem_cache_alloc_node);
 
-#ifdef CONFIG_TRACING
 void *kmem_cache_alloc_node_trace(struct kmem_cache *s,
 				    gfp_t gfpflags,
 				    int node, size_t size)
@@ -3274,7 +3271,6 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *s,
 	return ret;
 }
 EXPORT_SYMBOL(kmem_cache_alloc_node_trace);
-#endif
 
 /*
  * Slow path handling. This may still be called frequently since objects
-- 
2.33.1


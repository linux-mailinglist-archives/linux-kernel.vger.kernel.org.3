Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A8E50092C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239375AbiDNJEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241466AbiDNJCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:02:13 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEB62657F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:59:49 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c23so4173530plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l9QL4BycKE4eFXdrmUENq07WhnIQYOOU7butyGlrlts=;
        b=oLxmbrdrrSYOas267DSbgnV7X8Q/M59tbvkzw39YowuMa64Stzy1Sc8jRluxQdezP0
         l1U5kP+u3MOVEuii/WM2XiAh4B58+UWrMK8YwohsdbefFYmO/oHVr8S66x2ZpuxhG44x
         4Z4Oc+GPnUvwz/ShIKcgm74rGBZLYTuHCRpl+x/SbY11vbucdT/KaTNwb4B6O35Y4NAg
         Ka3rTgD2CJnenUkq3d2MuHWGZneo6s2DoYCL5GSoIM8BvRFOjFLb+MDcs6cQ2Zod9Y9v
         qW8iJh3R5ZK/Rihp8i1pWxhoUpxne6sbZs/VxMXWAMdjRn/cNTEWx5lrUVSUNwpnjhJS
         w8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l9QL4BycKE4eFXdrmUENq07WhnIQYOOU7butyGlrlts=;
        b=5pQew7exTuE9ZSLiw6j0guM4t87P3pZ3DsPzcFqUgxSpg4OAM3d2EK2UlebafAwAE5
         plhZzcM4sOxhIPqTaMzxkuJkX35c6G3aJuHKqDBefgf0O1fuZ/Ng9ooxjxjHgb3ty2K9
         OXTiN6NPgnSjdm1m3jMyI0OovlxlhhlqXVX7hf2V0J+46Q2dwkGgGCMWPTpz7PV9wMmc
         YyGiY0CwBdPf21/X2GV3Nje54ZjqOXwk2faJyxWh+TPy65yq0ZK9TSkRn2mW5ghCjhm5
         qVzaNrY3YrtrlqSL8TlqogL2qSsChofPIi0KQAq1k38kwoPykfP+emAykS34s+2tJgOk
         kyuA==
X-Gm-Message-State: AOAM5333ex5z3IqIhT+rV1Epwf7byn7YmVAQX1Fpmlp5BLCWK54XSZD1
        9QHscFNErzsWeJ4eFRvoUGE=
X-Google-Smtp-Source: ABdhPJwMF9eGt5BVU1QUVYQqLceYeeGQhDCgIiFSWMMEQ+Qv2jWmAMGkEiShivvQT1P6HAfwJXPljg==
X-Received: by 2002:a17:90b:4f8d:b0:1c6:408b:6b0d with SMTP id qe13-20020a17090b4f8d00b001c6408b6b0dmr3217496pjb.90.1649926789022;
        Thu, 14 Apr 2022 01:59:49 -0700 (PDT)
Received: from hyeyoo.. ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id p9-20020aa79e89000000b00505fada20dfsm1403537pfq.117.2022.04.14.01.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:59:47 -0700 (PDT)
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
Subject: [PATCH v2 21/23] mm/sl[au]b: remove kmem_cache_alloc_node_trace()
Date:   Thu, 14 Apr 2022 17:57:25 +0900
Message-Id: <20220414085727.643099-22-42.hyeyoo@gmail.com>
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

kmem_cache_alloc_node_trace() was introduced by commit 4a92379bdfb4
("slub tracing: move trace calls out of always inlined functions to reduce
kernel code size") to avoid inlining tracepoints for inlined kmalloc
function calls.

Now that we use same tracepoint in kmalloc and normal caches,
kmem_cache_alloc_node_trace() can be replaced with
__kmem_cache_alloc_node() and kasan_kmalloc().

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 include/linux/slab.h | 26 ++++++++------------------
 mm/slab.c            | 19 -------------------
 mm/slub.c            | 16 ----------------
 3 files changed, 8 insertions(+), 53 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 0630c37ee630..c1aed9d97cf2 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -497,21 +497,6 @@ static __always_inline void kfree_bulk(size_t size, void **p)
 	kmem_cache_free_bulk(NULL, size, p);
 }
 
-#ifdef CONFIG_TRACING
-extern void *kmem_cache_alloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
-					 int node, size_t size) __assume_slab_alignment
-								__alloc_size(4);
-#else /* CONFIG_TRACING */
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
 extern void *kmalloc_large_node(size_t size, gfp_t flags, int node)
 				__assume_page_alignment __alloc_size(1);
 
@@ -523,6 +508,9 @@ static __always_inline void *kmalloc_large(size_t size, gfp_t flags)
 #ifndef CONFIG_SLOB
 static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
 {
+	struct kmem_cache *s;
+	void *objp;
+
 	if (__builtin_constant_p(size)) {
 		unsigned int index;
 
@@ -534,9 +522,11 @@ static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t fla
 		if (!index)
 			return ZERO_SIZE_PTR;
 
-		return kmem_cache_alloc_node_trace(
-				kmalloc_caches[kmalloc_type(flags)][index],
-						flags, node, size);
+		s = kmalloc_caches[kmalloc_type(flags)][index];
+
+		objp = __kmem_cache_alloc_node(s, NULL, flags, node, _RET_IP_);
+		objp = kasan_kmalloc(s, objp, size, flags);
+		return objp;
 	}
 	return __kmalloc_node(size, flags, node);
 }
diff --git a/mm/slab.c b/mm/slab.c
index fc00aca62ae3..24010e72f603 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3508,25 +3508,6 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 }
 EXPORT_SYMBOL(kmem_cache_alloc_bulk);
 
-#ifdef CONFIG_TRACING
-void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
-				  gfp_t flags,
-				  int nodeid,
-				  size_t size)
-{
-	void *ret;
-
-	ret = slab_alloc_node(cachep, NULL, flags, nodeid, size, _RET_IP_);
-
-	ret = kasan_kmalloc(cachep, ret, size, flags);
-	trace_kmem_cache_alloc(cachep->name, _RET_IP_, ret,
-			       size, cachep->size,
-			       flags, nodeid);
-	return ret;
-}
-EXPORT_SYMBOL(kmem_cache_alloc_node_trace);
-#endif
-
 #ifdef CONFIG_PRINTK
 void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
 {
diff --git a/mm/slub.c b/mm/slub.c
index bc9c96ce0521..1899c7e1de10 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3222,22 +3222,6 @@ void *__kmem_cache_alloc_node(struct kmem_cache *s, struct list_lru *lru, gfp_t
 }
 EXPORT_SYMBOL(__kmem_cache_alloc_node);
 
-#ifdef CONFIG_TRACING
-void *kmem_cache_alloc_node_trace(struct kmem_cache *s,
-				    gfp_t gfpflags,
-				    int node, size_t size)
-{
-	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, size);
-
-	trace_kmem_cache_alloc(s->name, _RET_IP_, ret,
-			       size, s->size, gfpflags, node);
-
-	ret = kasan_kmalloc(s, ret, size, gfpflags);
-	return ret;
-}
-EXPORT_SYMBOL(kmem_cache_alloc_node_trace);
-#endif
-
 /*
  * Slow path handling. This may still be called frequently since objects
  * have a longer lifetime than the cpu slabs in most processing loads.
-- 
2.32.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9391D500902
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239536AbiDNJAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241332AbiDNJAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:00:25 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDC26A058
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:57:57 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id u2so4224284pgq.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SBtfUMUo5AKJFVkDupZX+/F7Ml8C31Xorc4nBPBe7Xo=;
        b=HX/bbJRHO3U3FJx3/b3hVoAzs392gVgvfWPhItFLKedHkoAlVEE6foru+q1MleQcYK
         +9E+XntVlp3ohUJMNnB7WZ3DtVaNzJ3FICs50O1Mm7NAz90b57jM9QlpR/mOXNfYt1ot
         wV4qA5Uw0PO8s0OfpVPXxFBXn6XmaKg2foj0E5bgqSA/mX3e1O1wPAAyQ/PTAzWtIMRe
         +86gWMlWrPb62XPH1F8W7bdxTllnFnSuKCKrtSBtlxV7DQ28IPCLj3xjUqTpCbw/Em2r
         hwArpFKwFIswZNegyfJZxAR/ejUX/PtFbB/XewBFCHv/yshHXtl5cr0Zbvp4AYfqWahD
         2wTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SBtfUMUo5AKJFVkDupZX+/F7Ml8C31Xorc4nBPBe7Xo=;
        b=SeWJJlSQStTBu+Bmvo5YaYWu+qkkZkez0yxDgZ+GnfUaON+X09DqulUA7rxI3NFH/K
         ZwlLv5AUposIxbTiHQQUACDcu1hXN7DBECGnG0xJkJQT0UNHvsv37kUuIVL75EXkNlRl
         R0dbBmm1azgJaB0D9Ys8VUbNnj5vMbB24SapVfKQrLv5bG/7LRmFcipb7fuuMwko8uXz
         2lVrzgFn2E1agFfNEvkdW1AG8QUhvnEiCaXqrcxhJOQtzuq/JpoN5jaeBrk0iWWnv4yn
         JQMkQ/SFg+lKGNdlCnq7R4FmgNa6XQRpBF2QeZszX/WeOzoCxc324nRTmYV83uGNxNhQ
         ATqQ==
X-Gm-Message-State: AOAM5330OtbtYATt8vkRC5gnZvSXwQjlcdqiEeTScj2uEdJqMt/4QQXu
        qlgzS+LFW0ZFC+U8NoL9wIg=
X-Google-Smtp-Source: ABdhPJwdf6PDIV9iYxCmyC0U1BopJSIt85+zGKggzLDKYsaXkFCXCFJ6KkO4FwiQNT+ofldpajL/qA==
X-Received: by 2002:a63:5648:0:b0:398:dfcf:c9c6 with SMTP id g8-20020a635648000000b00398dfcfc9c6mr1485952pgm.0.1649926676999;
        Thu, 14 Apr 2022 01:57:56 -0700 (PDT)
Received: from hyeyoo.. ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id p9-20020aa79e89000000b00505fada20dfsm1403537pfq.117.2022.04.14.01.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:57:55 -0700 (PDT)
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
Subject: [PATCH v2 03/23] mm/slab_common: remove CONFIG_NUMA ifdefs for common kmalloc functions
Date:   Thu, 14 Apr 2022 17:57:07 +0900
Message-Id: <20220414085727.643099-4-42.hyeyoo@gmail.com>
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

Now that slab_alloc_node() is available for SLAB when CONFIG_NUMA=n,
remove CONFIG_NUMA ifdefs for common kmalloc functions.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 include/linux/slab.h | 28 ----------------------------
 mm/slab.c            |  2 --
 mm/slob.c            |  5 +----
 mm/slub.c            |  6 ------
 4 files changed, 1 insertion(+), 40 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 11ceddcae9f4..a3b9d4c20d7e 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -444,38 +444,18 @@ static __always_inline void kfree_bulk(size_t size, void **p)
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
@@ -689,20 +669,12 @@ static inline __alloc_size(1, 2) void *kcalloc_node(size_t n, size_t size, gfp_t
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
index f033d5b4fefb..5ad55ca96ab6 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3545,7 +3545,6 @@ kmem_cache_alloc_trace(struct kmem_cache *cachep, gfp_t flags, size_t size)
 EXPORT_SYMBOL(kmem_cache_alloc_trace);
 #endif
 
-#ifdef CONFIG_NUMA
 /**
  * kmem_cache_alloc_node - Allocate an object on the specified node
  * @cachep: The cache to allocate from.
@@ -3619,7 +3618,6 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t flags,
 	return __do_kmalloc_node(size, flags, node, caller);
 }
 EXPORT_SYMBOL(__kmalloc_node_track_caller);
-#endif /* CONFIG_NUMA */
 
 #ifdef CONFIG_PRINTK
 void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
diff --git a/mm/slob.c b/mm/slob.c
index dfa6808dff36..c8c3b5662edf 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -534,14 +534,12 @@ void *__kmalloc_track_caller(size_t size, gfp_t gfp, unsigned long caller)
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
@@ -641,7 +639,7 @@ void *kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru, gfp_
 	return slob_alloc_node(cachep, flags, NUMA_NO_NODE);
 }
 EXPORT_SYMBOL(kmem_cache_alloc_lru);
-#ifdef CONFIG_NUMA
+
 void *__kmalloc_node(size_t size, gfp_t gfp, int node)
 {
 	return __do_kmalloc_node(size, gfp, node, _RET_IP_);
@@ -653,7 +651,6 @@ void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t gfp, int node)
 	return slob_alloc_node(cachep, gfp, node);
 }
 EXPORT_SYMBOL(kmem_cache_alloc_node);
-#endif
 
 static void __kmem_cache_free(void *b, int size)
 {
diff --git a/mm/slub.c b/mm/slub.c
index d7e8355b2f08..e36c148e5069 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3260,7 +3260,6 @@ void *kmem_cache_alloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
 EXPORT_SYMBOL(kmem_cache_alloc_trace);
 #endif
 
-#ifdef CONFIG_NUMA
 void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
 {
 	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, s->object_size);
@@ -3287,7 +3286,6 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *s,
 }
 EXPORT_SYMBOL(kmem_cache_alloc_node_trace);
 #endif
-#endif	/* CONFIG_NUMA */
 
 /*
  * Slow path handling. This may still be called frequently since objects
@@ -4424,7 +4422,6 @@ void *__kmalloc(size_t size, gfp_t flags)
 }
 EXPORT_SYMBOL(__kmalloc);
 
-#ifdef CONFIG_NUMA
 static void *kmalloc_large_node(size_t size, gfp_t flags, int node)
 {
 	struct page *page;
@@ -4471,7 +4468,6 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node)
 	return ret;
 }
 EXPORT_SYMBOL(__kmalloc_node);
-#endif	/* CONFIG_NUMA */
 
 #ifdef CONFIG_HARDENED_USERCOPY
 /*
@@ -4929,7 +4925,6 @@ void *__kmalloc_track_caller(size_t size, gfp_t gfpflags, unsigned long caller)
 }
 EXPORT_SYMBOL(__kmalloc_track_caller);
 
-#ifdef CONFIG_NUMA
 void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
 					int node, unsigned long caller)
 {
@@ -4959,7 +4954,6 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
 	return ret;
 }
 EXPORT_SYMBOL(__kmalloc_node_track_caller);
-#endif
 
 #ifdef CONFIG_SYSFS
 static int count_inuse(struct slab *slab)
-- 
2.32.0


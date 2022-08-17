Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA392596CAB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 12:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238886AbiHQKTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 06:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235722AbiHQKS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:18:58 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7120E65250
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:18:57 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id z187so11655975pfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=dErSdygiPBNsBAP9y5F3S7ekn7p7kWL1SSm4SRF+jts=;
        b=KIqkM8kQCeSA6lOVWRvpaj88kdiJxGl/Ysg2mgJZh2bmi8Z7ykNum+Sat5cbEwzI4o
         tJ9CQgyQ2lQHwfH1rn/NIri+J4RdqujaoQE4celkgwmqnSgxb6MM9n8Ugfl0YgQFVCCF
         qbEJkWrfYGeokUQ2kxtj6TpA/TmzBVhMBFIYW4H9R2DnFRc9UgPJp8ELDkGVqgXWUlSa
         7qDrKZStXLbr9GKkt0ktkM2F1xg/QoZIRR2LRd6Tqjdmq9bkvc6nUDi99zje8wiX0TWW
         DTJx/nZe3iCU60gnNHxi+W3B5sZTCWYzMNPsAJAV2wB1I7IouxSJYPE29lRRuHDGYAVK
         kYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=dErSdygiPBNsBAP9y5F3S7ekn7p7kWL1SSm4SRF+jts=;
        b=PeDIxdHuwliqtRBhS65jykmcbHK19IvtCaLcER3vgXlpND8cjcYqB/IOc5u6vOA409
         NJsVKdwcnCIfZz3ebs3kVh6DwSTbrgck7DpTeYQ0W34lSqf4vlDk5n+onkaetmh2tZ3B
         AygztVEvMzvDgSSc9g7/L7J9mgWZ126hG5aDGaJc1bNPsjgDC4/5L07W4orLb/WLk23P
         3O3ui/hISo9gY/KLEJE+UKG0HvwATK63mNhzpDDVjIR7BtaqtAI4Ipe5iATmFQysV1gE
         i//TpzPfJNTBP5oVIbbYM1tNmNg4tkJ38oQhYjWE7ltRXlZGzTAfS5DIvcGdFZBNzRZM
         GcSQ==
X-Gm-Message-State: ACgBeo1E2SXmzTJaJBqRfONEJnR3wgYHfjQlzxbeTGVmqpJSvpZtGAsX
        zFxoUNBveI2Dr8XKuuuemxs=
X-Google-Smtp-Source: AA6agR50UeU3HEpeP9GVa1wNnr14Ztlk2ksOg095VJMlH8rYkzaa0EC00mWPps4A86HdPSen/TmygQ==
X-Received: by 2002:a05:6a00:1910:b0:52f:13d7:44c4 with SMTP id y16-20020a056a00191000b0052f13d744c4mr24266690pfi.32.1660731536946;
        Wed, 17 Aug 2022 03:18:56 -0700 (PDT)
Received: from hyeyoo.. ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id d8-20020a170903230800b00172633fc236sm1071318plh.174.2022.08.17.03.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 03:18:56 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/17] mm/slab_common: remove CONFIG_NUMA ifdefs for common kmalloc functions
Date:   Wed, 17 Aug 2022 19:18:12 +0900
Message-Id: <20220817101826.236819-4-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220817101826.236819-1-42.hyeyoo@gmail.com>
References: <20220817101826.236819-1-42.hyeyoo@gmail.com>
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
index 748dd085f38e..0acd65358c83 100644
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
index 2bd4f476c340..74d850967213 100644
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
index 862dbd9af4f5..b29b3c9d3175 100644
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
2.32.0


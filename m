Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0568550090F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240665AbiDNJB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241439AbiDNJBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:01:23 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACA26D38B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:58:53 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id s8so4257618pfk.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6hxL75KFeP2qi1GRuhGW4keQJz0+ExPc+GiFqWwmOVw=;
        b=KXURwW+dd0r1EwDdcia61oDDeDZOkH2JDLvuDit1QPWsQbh8zV5QqtL8HcPxiPPOp1
         6kgJavCCKYQ50eZESfleZyqDHMC1P8+g/MXDcGxE45Ty9PtJ2wQD//Oq5ySu3YsSiw4O
         lVWCkof3OXtnMscc9ZirN2sv7RjxChA6QIkKPh68hAI2TZZKP4KHuPANhQJUo5cfdb8K
         R79jVwVnqhhtn1UQWI7PW1rbEmTkeLFKGsWk3cSmQ+PUDP1N4jlogGHn+a/2TVm59UOc
         UjmPdALdxv0sZrq//TMSeSaVmonLCInzEK381vKQfmqIQX+M7mHnI40z2tdyY59jGZ0k
         vmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6hxL75KFeP2qi1GRuhGW4keQJz0+ExPc+GiFqWwmOVw=;
        b=POuQX/AtVFa5wZp3a+Z01K9It38AI+aTGE3lrgMimvRQ9NILiStQiRKcTlzaLFPy53
         nXbIpY6GLE5gkOIK17VJ3/D3ZfJjcFLfIrjRngCrKI2yn8iNHz4uVDgQ2oY2wb+h8Uvf
         lxVifmz68YNnjgJba8cVED0cNQH3xWrRuypahnwvn97hotIrDDrP51Nm1jGIbsh/t9AU
         88k1yPCE1FM2Y5UIJNkP8OZ2aKRp01PYRzYk2XpbJGXp1CIa+ut5n8/oGgdqHUssPcxw
         4e1E3rwLnI6WbypYGE0BdbwlbmIZm1wx3JkUE0v3i2T8UbuxqwZXDfgnREMxHSwC+EgZ
         sDSA==
X-Gm-Message-State: AOAM533s+DIQEfqbPQa4meota92eISxoSql0AFTxSHjNwpOz4qo6y+6Y
        SQ/eSq2TZ0k/o05TEpqxrkc=
X-Google-Smtp-Source: ABdhPJyXSchgrJoVMijeZDC4c/X4LGGEpbmRQ/w4nF5EeMTTozyFoFqFsK3/RsNvjtnq5YSI+P5HOQ==
X-Received: by 2002:a63:3d0b:0:b0:37f:ef34:1431 with SMTP id k11-20020a633d0b000000b0037fef341431mr1424935pga.547.1649926733078;
        Thu, 14 Apr 2022 01:58:53 -0700 (PDT)
Received: from hyeyoo.. ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id p9-20020aa79e89000000b00505fada20dfsm1403537pfq.117.2022.04.14.01.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:58:51 -0700 (PDT)
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
Subject: [PATCH v2 12/23] mm/slab_common: cleanup kmalloc()
Date:   Thu, 14 Apr 2022 17:57:16 +0900
Message-Id: <20220414085727.643099-13-42.hyeyoo@gmail.com>
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

Now that kmalloc() and kmalloc_node() do same job, make kmalloc()
wrapper of kmalloc_node().

Remove kmem_cache_alloc_trace() that is now unused.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 include/linux/slab.h | 93 +++++++++++++++-----------------------------
 mm/slab.c            | 16 --------
 mm/slub.c            | 12 ------
 3 files changed, 32 insertions(+), 89 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index eb457f20f415..ea168f8a248d 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -497,23 +497,10 @@ static __always_inline void kfree_bulk(size_t size, void **p)
 }
 
 #ifdef CONFIG_TRACING
-extern void *kmem_cache_alloc_trace(struct kmem_cache *s, gfp_t flags, size_t size)
-				   __assume_slab_alignment __alloc_size(3);
-
 extern void *kmem_cache_alloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
 					 int node, size_t size) __assume_slab_alignment
 								__alloc_size(4);
-
 #else /* CONFIG_TRACING */
-static __always_inline __alloc_size(3) void *kmem_cache_alloc_trace(struct kmem_cache *s,
-								    gfp_t flags, size_t size)
-{
-	void *ret = kmem_cache_alloc(s, flags);
-
-	ret = kasan_kmalloc(s, ret, size, flags);
-	return ret;
-}
-
 static __always_inline void *kmem_cache_alloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
 							 int node, size_t size)
 {
@@ -532,6 +519,37 @@ static __always_inline void *kmalloc_large(size_t size, gfp_t flags)
 	return kmalloc_large_node(size, flags, NUMA_NO_NODE);
 }
 
+#ifndef CONFIG_SLOB
+static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
+{
+	if (__builtin_constant_p(size)) {
+		unsigned int index;
+
+		if (size > KMALLOC_MAX_CACHE_SIZE)
+			return kmalloc_large_node(size, flags, node);
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
+		return kmalloc_large_node(size, flags, node);
+
+	return __kmalloc_node(size, flags, node);
+}
+#endif
+
+
 /**
  * kmalloc - allocate memory
  * @size: how many bytes of memory are required.
@@ -588,55 +606,8 @@ static __always_inline void *kmalloc_large(size_t size, gfp_t flags)
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
-				kmalloc_caches[kmalloc_type(flags)][index],
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
index c5ffe54c207a..b0aaca017f42 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3507,22 +3507,6 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 }
 EXPORT_SYMBOL(kmem_cache_alloc_bulk);
 
-#ifdef CONFIG_TRACING
-void *
-kmem_cache_alloc_trace(struct kmem_cache *cachep, gfp_t flags, size_t size)
-{
-	void *ret;
-
-	ret = slab_alloc(cachep, NULL, flags, size, _RET_IP_);
-
-	ret = kasan_kmalloc(cachep, ret, size, flags);
-	trace_kmalloc(_RET_IP_, ret,
-		      size, cachep->size, flags);
-	return ret;
-}
-EXPORT_SYMBOL(kmem_cache_alloc_trace);
-#endif
-
 #ifdef CONFIG_TRACING
 void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
 				  gfp_t flags,
diff --git a/mm/slub.c b/mm/slub.c
index 2a2be2a8a5d0..892988990da7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3216,18 +3216,6 @@ static __always_inline void *slab_alloc(struct kmem_cache *s, struct list_lru *l
 	return slab_alloc_node(s, lru, gfpflags, NUMA_NO_NODE, addr, orig_size);
 }
 
-
-#ifdef CONFIG_TRACING
-void *kmem_cache_alloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
-{
-	void *ret = slab_alloc(s, NULL, gfpflags, _RET_IP_, size);
-	trace_kmalloc(_RET_IP_, ret, size, s->size, gfpflags);
-	ret = kasan_kmalloc(s, ret, size, gfpflags);
-	return ret;
-}
-EXPORT_SYMBOL(kmem_cache_alloc_trace);
-#endif
-
 void *__kmem_cache_alloc_node(struct kmem_cache *s, struct list_lru *lru, gfp_t gfpflags,
 			      int node, unsigned long caller __maybe_unused)
 {
-- 
2.32.0


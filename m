Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E268F596CC0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 12:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238999AbiHQKUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 06:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239037AbiHQKTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:19:52 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB91816A7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:19:35 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id x63-20020a17090a6c4500b001fabbf8debfso502206pjj.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ec/2ehXn71Tv+L2UuMNScuaYO4eN7Mil3n5xQnD/usM=;
        b=NE0QMyh9rN6jdYaOFqchLIWssHGMXYg5VraHfgM7OQRM+zrFJ0sZt1cK5vRqGOJIjs
         2sumSFJ9OzlmGQJknoSvF79MKY7HzOVwM+FMBsmM/NtUaYtVtJah0x/V08MPUBJu9G0r
         USMvaDN/IxXCi+icvzS/yp1yXqo25FI3uXLQuapSGVQAS9dq/PLRMO7builXKV3vcD6U
         Bfs1iFowef9AILGtXjTVAd9///7WkTRoBf4C0iDUl8UJmAbbf3gKs+1JPrsmgbSng7lH
         uHZys+ZJYWdTwKwL7D74AL4ZVVEa1WlVDGTTUFtctN72UkextK+408oGudwHSofmY0Ly
         mnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ec/2ehXn71Tv+L2UuMNScuaYO4eN7Mil3n5xQnD/usM=;
        b=dzZC5BhnjSYj/80CfUfx5fbZHqYcYIY52OWS5DG2uI/DrHi0sQtddcxqM8b9g0t6Mf
         0HqYI0Jpmh+lRSyUD3trWJcuLhmDkDkIyLn44eMAss+CaEuBUXnwEl08GADE59uhgsBV
         jXux51Dka6HkVA4RJlDFhWU9iAnrYu4mk1p7ppsnbwUMkQs+VGtH2vHsZyzRa7h2GvQe
         B0hV6AmLjEDyodLW05DuGy+XGlcAXUDMQ8VsMJzkaM8O3NfUUWZ11kqeywo1kGAtvfKJ
         x8W/jKR5hCxvBM636z18csAkFli/1kyfYBy7oHd9spGfxXGKj27jovKSaxyAEhZaU+wn
         fsbw==
X-Gm-Message-State: ACgBeo14qe8TelZ6dSzKcbePZhrYHuPmqmotT7WmfPJF7/zArZku55vT
        C7lkZbMpcBdo7hTL0AlfTpk=
X-Google-Smtp-Source: AA6agR42HTFa0hi7Z2W2UpfZGw0BiJjZK6mjVfVq8nVA2E4qeRRVezYO2uWKdvXuyzgFXyIJ29hflA==
X-Received: by 2002:a17:90b:17c9:b0:1f3:3a7c:a3a7 with SMTP id me9-20020a17090b17c900b001f33a7ca3a7mr3137221pjb.76.1660731574780;
        Wed, 17 Aug 2022 03:19:34 -0700 (PDT)
Received: from hyeyoo.. ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id d8-20020a170903230800b00172633fc236sm1071318plh.174.2022.08.17.03.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 03:19:33 -0700 (PDT)
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
Subject: [PATCH v4 13/17] mm/sl[au]b: cleanup kmem_cache_alloc[_node]_trace()
Date:   Wed, 17 Aug 2022 19:18:22 +0900
Message-Id: <20220817101826.236819-14-42.hyeyoo@gmail.com>
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

This patch does:
	- Despite its name, kmem_cache_alloc[_node]_trace() is hook for
	  inlined kmalloc. So rename it to kmalloc[_node]_trace().

	- Move its implementation to slab_common.c by using
          __kmem_cache_alloc_node(), but keep CONFIG_TRACING=n varients to
	  save a function call when CONFIG_TRACING=n.

	- Use __assume_kmalloc_alignment for kmalloc[_node]_trace
	  instead of __assume_slab_alignement. Generally kmalloc has
	  larger alignment requirements.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 include/linux/slab.h | 27 ++++++++++++++-------------
 mm/slab.c            | 35 -----------------------------------
 mm/slab_common.c     | 27 +++++++++++++++++++++++++++
 mm/slub.c            | 27 ---------------------------
 4 files changed, 41 insertions(+), 75 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 4ee5b2fed164..c8e485ce8815 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -449,16 +449,16 @@ void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t flags, int node) __assum
 									 __malloc;
 
 #ifdef CONFIG_TRACING
-extern void *kmem_cache_alloc_trace(struct kmem_cache *s, gfp_t flags, size_t size)
-				   __assume_slab_alignment __alloc_size(3);
-
-extern void *kmem_cache_alloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
-					 int node, size_t size) __assume_slab_alignment
-								__alloc_size(4);
+void *kmalloc_trace(struct kmem_cache *s, gfp_t flags, size_t size)
+		    __assume_kmalloc_alignment __alloc_size(3);
 
+void *kmalloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
+			 int node, size_t size) __assume_kmalloc_alignment
+						__alloc_size(4);
 #else /* CONFIG_TRACING */
-static __always_inline __alloc_size(3) void *kmem_cache_alloc_trace(struct kmem_cache *s,
-								    gfp_t flags, size_t size)
+/* Save a function call when CONFIG_TRACING=n */
+static __always_inline __alloc_size(3)
+void *kmalloc_trace(struct kmem_cache *s, gfp_t flags, size_t size)
 {
 	void *ret = kmem_cache_alloc(s, flags);
 
@@ -466,8 +466,9 @@ static __always_inline __alloc_size(3) void *kmem_cache_alloc_trace(struct kmem_
 	return ret;
 }
 
-static __always_inline void *kmem_cache_alloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
-							 int node, size_t size)
+static __always_inline __alloc_size(4)
+void *kmalloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
+			 int node, size_t size)
 {
 	void *ret = kmem_cache_alloc_node(s, gfpflags, node);
 
@@ -550,7 +551,7 @@ static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
 		if (!index)
 			return ZERO_SIZE_PTR;
 
-		return kmem_cache_alloc_trace(
+		return kmalloc_trace(
 				kmalloc_caches[kmalloc_type(flags)][index],
 				flags, size);
 #endif
@@ -572,9 +573,9 @@ static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t fla
 		if (!index)
 			return ZERO_SIZE_PTR;
 
-		return kmem_cache_alloc_node_trace(
+		return kmalloc_node_trace(
 				kmalloc_caches[kmalloc_type(flags)][index],
-						flags, node, size);
+				flags, node, size);
 	}
 	return __kmalloc_node(size, flags, node);
 }
diff --git a/mm/slab.c b/mm/slab.c
index 5b234e3ab165..8d9d0fbf9792 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3519,22 +3519,6 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
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
-	trace_kmalloc(_RET_IP_, ret, cachep,
-		      size, cachep->size, flags);
-	return ret;
-}
-EXPORT_SYMBOL(kmem_cache_alloc_trace);
-#endif
-
 /**
  * kmem_cache_alloc_node - Allocate an object on the specified node
  * @cachep: The cache to allocate from.
@@ -3568,25 +3552,6 @@ void *__kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags,
 			       orig_size, caller);
 }
 
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
-	trace_kmalloc_node(_RET_IP_, ret, cachep,
-			   size, cachep->size,
-			   flags, nodeid);
-	return ret;
-}
-EXPORT_SYMBOL(kmem_cache_alloc_node_trace);
-#endif
-
 #ifdef CONFIG_PRINTK
 void __kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
 {
diff --git a/mm/slab_common.c b/mm/slab_common.c
index c8242b4e2223..d8e8c41c12f1 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1000,6 +1000,33 @@ size_t __ksize(const void *object)
 	return slab_ksize(folio_slab(folio)->slab_cache);
 }
 EXPORT_SYMBOL(__ksize);
+
+#ifdef CONFIG_TRACING
+void *kmalloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
+{
+	void *ret = __kmem_cache_alloc_node(s, gfpflags, NUMA_NO_NODE,
+					    size, _RET_IP_);
+
+	trace_kmalloc_node(_RET_IP_, ret, s, size, s->size,
+			   gfpflags, NUMA_NO_NODE);
+
+	ret = kasan_kmalloc(s, ret, size, gfpflags);
+	return ret;
+}
+EXPORT_SYMBOL(kmalloc_trace);
+
+void *kmalloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
+			 int node, size_t size)
+{
+	void *ret = __kmem_cache_alloc_node(s, gfpflags, node, size, _RET_IP_);
+
+	trace_kmalloc_node(_RET_IP_, ret, s, size, s->size, gfpflags, node);
+
+	ret = kasan_kmalloc(s, ret, size, gfpflags);
+	return ret;
+}
+EXPORT_SYMBOL(kmalloc_node_trace);
+#endif /* !CONFIG_TRACING */
 #endif /* !CONFIG_SLOB */
 
 gfp_t kmalloc_fix_flags(gfp_t flags)
diff --git a/mm/slub.c b/mm/slub.c
index cd49785d59e1..7d7fd9d4e8fa 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3270,17 +3270,6 @@ void *__kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags,
 			       caller, orig_size);
 }
 
-#ifdef CONFIG_TRACING
-void *kmem_cache_alloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
-{
-	void *ret = slab_alloc(s, NULL, gfpflags, _RET_IP_, size);
-	trace_kmalloc(_RET_IP_, ret, s, size, s->size, gfpflags);
-	ret = kasan_kmalloc(s, ret, size, gfpflags);
-	return ret;
-}
-EXPORT_SYMBOL(kmem_cache_alloc_trace);
-#endif
-
 void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
 {
 	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, s->object_size);
@@ -3292,22 +3281,6 @@ void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
 }
 EXPORT_SYMBOL(kmem_cache_alloc_node);
 
-#ifdef CONFIG_TRACING
-void *kmem_cache_alloc_node_trace(struct kmem_cache *s,
-				    gfp_t gfpflags,
-				    int node, size_t size)
-{
-	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, size);
-
-	trace_kmalloc_node(_RET_IP_, ret, s,
-			   size, s->size, gfpflags, node);
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


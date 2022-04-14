Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE3950092E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241358AbiDNJEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241495AbiDNJB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:01:59 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D650123BF4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:59:31 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id h5so4226766pgc.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VXU9f8brElqQjQUQyo4iKTj+TdVz9PS035pWXZROjPs=;
        b=CMsTgOCmxpH9Ya24bTQBUOlRMe8yjhRIe9zC3tPsZTskOcuJ8mb3Cphb6DXR0p6KDJ
         bsYdwi1vMMybsPx64eS8pO386Q0GhssSVrBfdy8I1gNtmnFAhJKaH1sreyl7+r0bLUG9
         PrPYb4xCSzo6XXo8iqJxcfv9vD9UqMDcq4R+O5hHMJUZohK/UMAQc8g3Ws5x7ivvCrir
         m1Dj8YQD2ZlnD4vUpu+jmQgxn1siLSmZh8k9eM7oEqK37KPx+vzf7MqnN/D6750AK9eQ
         Uxm5LJF8mJpXNCes2xnd8zVQIfH58lrEQG7KNNsUzaR7nCSiftL5VQ2RT6Jg1EnERwbv
         psFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VXU9f8brElqQjQUQyo4iKTj+TdVz9PS035pWXZROjPs=;
        b=n2ZamBVsK3YggWciWAaqsNaIV6gwuCykVcauJRXnZ3lxQIhN35th1WR7ew3h5Bb73P
         bORB7qQ59enTOIE0PdluFBxXnSjfbw86y3UwMkWlUVqEb+lquxdBtq05Ex46kk6qilkx
         CtpkNzkCJXlhSjEdF2zDvEd88GH+y/2wQQZW489F79VIlZm8S1Yl17CKGHvqg/cEba+i
         vOY05PuWS93Di4CfR23PAZtwqlBISMWDB//49q/btGqdJaFv+7xZEtLN4uK82NPsoX+A
         YrLOLMSOzVm5h1+oyDZcHg1DDRZCkPHsWjpd8C0vSE5I6MeObssykq1l8EbNVYruAmJ4
         8o9w==
X-Gm-Message-State: AOAM531yHctxU+htbFwEsJSP33pjOBKcgkBObwoDeky5t+0huqIfPgXV
        /D8bDm0QGJvY98mulc7v14g=
X-Google-Smtp-Source: ABdhPJyWukxNFbT9XT5Je4C9MNigf2VP/qCuFkDFIKDtoulNW7LOXhOtKS3m58upU+oMh1k3yvO1RA==
X-Received: by 2002:a05:6a00:1141:b0:506:d0e:6640 with SMTP id b1-20020a056a00114100b005060d0e6640mr2875392pfm.73.1649926771272;
        Thu, 14 Apr 2022 01:59:31 -0700 (PDT)
Received: from hyeyoo.. ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id p9-20020aa79e89000000b00505fada20dfsm1403537pfq.117.2022.04.14.01.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:59:29 -0700 (PDT)
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
Subject: [PATCH v2 18/23] mm/sl[au]b: generalize kmalloc subsystem
Date:   Thu, 14 Apr 2022 17:57:22 +0900
Message-Id: <20220414085727.643099-19-42.hyeyoo@gmail.com>
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

Now everything in kmalloc subsystem can be generalized.
Let's do it!

Generalize __kmalloc_node_track_caller(), kfree(), __ksize(),
__kmalloc_node() and move them to slab_common.c.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/slab.c        | 94 -----------------------------------------------
 mm/slab_common.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++
 mm/slub.c        | 88 --------------------------------------------
 3 files changed, 95 insertions(+), 182 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index d35873da5572..fc00aca62ae3 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3527,36 +3527,6 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
 EXPORT_SYMBOL(kmem_cache_alloc_node_trace);
 #endif
 
-static __always_inline void *
-__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
-{
-	struct kmem_cache *cachep;
-	void *ret;
-
-	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
-		return kmalloc_large_node(size, flags, node);
-	cachep = kmalloc_slab(size, flags);
-	if (unlikely(ZERO_OR_NULL_PTR(cachep)))
-		return cachep;
-	ret = kmem_cache_alloc_node_trace(cachep, flags, node, size);
-	ret = kasan_kmalloc(cachep, ret, size, flags);
-
-	return ret;
-}
-
-void *__kmalloc_node(size_t size, gfp_t flags, int node)
-{
-	return __do_kmalloc_node(size, flags, node, _RET_IP_);
-}
-EXPORT_SYMBOL(__kmalloc_node);
-
-void *__kmalloc_node_track_caller(size_t size, gfp_t flags,
-		int node, unsigned long caller)
-{
-	return __do_kmalloc_node(size, flags, node, caller);
-}
-EXPORT_SYMBOL(__kmalloc_node_track_caller);
-
 #ifdef CONFIG_PRINTK
 void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
 {
@@ -3635,43 +3605,6 @@ void kmem_cache_free_bulk(struct kmem_cache *orig_s, size_t size, void **p)
 }
 EXPORT_SYMBOL(kmem_cache_free_bulk);
 
-/**
- * kfree - free previously allocated memory
- * @objp: pointer returned by kmalloc.
- *
- * If @objp is NULL, no operation is performed.
- *
- * Don't free memory not originally allocated by kmalloc()
- * or you will run into trouble.
- */
-void kfree(const void *objp)
-{
-	struct kmem_cache *c;
-	unsigned long flags;
-	struct folio *folio;
-
-
-	if (unlikely(ZERO_OR_NULL_PTR(objp)))
-		return;
-
-	folio = virt_to_folio(objp);
-	if (!folio_test_slab(folio)) {
-		free_large_kmalloc(folio, (void *)objp);
-		return;
-	}
-
-	c = folio_slab(folio)->slab_cache;
-	trace_kmem_cache_free(c->name, _RET_IP_, objp);
-
-	local_irq_save(flags);
-	kfree_debugcheck(objp);
-	debug_check_no_locks_freed(objp, c->object_size);
-	debug_check_no_obj_freed(objp, c->object_size);
-	__cache_free(c, (void *)objp, _RET_IP_);
-	local_irq_restore(flags);
-}
-EXPORT_SYMBOL(kfree);
-
 /*
  * This initializes kmem_cache_node or resizes various caches for all nodes.
  */
@@ -4074,30 +4007,3 @@ void __check_heap_object(const void *ptr, unsigned long n,
 	usercopy_abort("SLAB object", cachep->name, to_user, offset, n);
 }
 #endif /* CONFIG_HARDENED_USERCOPY */
-
-/**
- * __ksize -- Uninstrumented ksize.
- * @objp: pointer to the object
- *
- * Unlike ksize(), __ksize() is uninstrumented, and does not provide the same
- * safety checks as ksize() with KASAN instrumentation enabled.
- *
- * Return: size of the actual memory used by @objp in bytes
- */
-size_t __ksize(const void *objp)
-{
-	struct kmem_cache *c;
-	struct folio *folio;
-
-	BUG_ON(!objp);
-	if (unlikely(objp == ZERO_SIZE_PTR))
-		return 0;
-
-	folio = virt_to_folio(objp);
-	if (!folio_test_slab(folio))
-		return folio_size(folio);
-
-	c = folio_slab(folio)->slab_cache;
-	return c->object_size;
-}
-EXPORT_SYMBOL(__ksize);
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 3cd5d7a47ec7..daf626e25e12 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -918,6 +918,101 @@ void free_large_kmalloc(struct folio *folio, void *object)
 			      -(PAGE_SIZE << order));
 	__free_pages(folio_page(folio, 0), order);
 }
+
+void *__kmalloc_node(size_t size, gfp_t flags, int node)
+{
+	struct kmem_cache *s;
+	void *ret;
+
+	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
+		return kmalloc_large_node(size, flags, node);
+
+	s = kmalloc_slab(size, flags);
+
+	if (unlikely(ZERO_OR_NULL_PTR(s)))
+		return s;
+
+	ret = __kmem_cache_alloc_node(s, NULL, flags, node, _RET_IP_);
+	ret = kasan_kmalloc(s, ret, size, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL(__kmalloc_node);
+
+void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
+					int node, unsigned long caller)
+{
+	struct kmem_cache *s;
+	void *ret;
+
+	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
+		return kmalloc_large_node(size, gfpflags, node);
+
+	s = kmalloc_slab(size, gfpflags);
+
+	if (unlikely(ZERO_OR_NULL_PTR(s)))
+		return s;
+
+	ret = __kmem_cache_alloc_node(s, NULL, gfpflags, node, caller);
+
+	return ret;
+}
+EXPORT_SYMBOL(__kmalloc_node_track_caller);
+
+/**
+ * kfree - free previously allocated memory
+ * @objp: pointer returned by kmalloc.
+ *
+ * If @objp is NULL, no operation is performed.
+ *
+ * Don't free memory not originally allocated by kmalloc()
+ * or you will run into trouble.
+ */
+void kfree(const void *object)
+{
+	struct folio *folio;
+	struct slab *slab;
+	struct kmem_cache *s;
+
+	if (unlikely(ZERO_OR_NULL_PTR(object)))
+		return;
+
+	folio = virt_to_folio(object);
+	if (unlikely(!folio_test_slab(folio))) {
+		free_large_kmalloc(folio, (void *)object);
+		return;
+	}
+
+	slab = folio_slab(folio);
+	s = slab->slab_cache;
+	__kmem_cache_free(s, object, _RET_IP_);
+}
+EXPORT_SYMBOL(kfree);
+
+/**
+ * __ksize -- Uninstrumented ksize.
+ * @objp: pointer to the object
+ *
+ * Unlike ksize(), __ksize() is uninstrumented, and does not provide the same
+ * safety checks as ksize() with KASAN instrumentation enabled.
+ *
+ * Return: size of the actual memory used by @objp in bytes
+ */
+size_t __ksize(const void *object)
+{
+	struct folio *folio;
+
+	if (unlikely(object == ZERO_SIZE_PTR))
+		return 0;
+
+	folio = virt_to_folio(object);
+
+	if (unlikely(!folio_test_slab(folio)))
+		return folio_size(folio);
+
+	return slab_ksize(folio_slab(folio)->slab_cache);
+}
+EXPORT_SYMBOL(__ksize);
 #endif /* !CONFIG_SLOB */
 
 gfp_t kmalloc_fix_flags(gfp_t flags)
diff --git a/mm/slub.c b/mm/slub.c
index a72a2d08e793..bc9c96ce0521 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4338,30 +4338,6 @@ static int __init setup_slub_min_objects(char *str)
 
 __setup("slub_min_objects=", setup_slub_min_objects);
 
-void *__kmalloc_node(size_t size, gfp_t flags, int node)
-{
-	struct kmem_cache *s;
-	void *ret;
-
-	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
-		return kmalloc_large_node(size, flags, node);
-
-	s = kmalloc_slab(size, flags);
-
-	if (unlikely(ZERO_OR_NULL_PTR(s)))
-		return s;
-
-	ret = slab_alloc_node(s, NULL, flags, node, _RET_IP_, size);
-
-	trace_kmem_cache_alloc(s->name, _RET_IP_, ret, size,
-			       s->size, flags, node);
-
-	ret = kasan_kmalloc(s, ret, size, flags);
-
-	return ret;
-}
-EXPORT_SYMBOL(__kmalloc_node);
-
 #ifdef CONFIG_HARDENED_USERCOPY
 /*
  * Rejects incorrectly sized objects and objects that are to be copied
@@ -4412,46 +4388,6 @@ void __check_heap_object(const void *ptr, unsigned long n,
 }
 #endif /* CONFIG_HARDENED_USERCOPY */
 
-size_t __ksize(const void *object)
-{
-	struct folio *folio;
-
-	if (unlikely(object == ZERO_SIZE_PTR))
-		return 0;
-
-	folio = virt_to_folio(object);
-
-	if (unlikely(!folio_test_slab(folio)))
-		return folio_size(folio);
-
-	return slab_ksize(folio_slab(folio)->slab_cache);
-}
-EXPORT_SYMBOL(__ksize);
-
-void kfree(const void *x)
-{
-	struct folio *folio;
-	struct slab *slab;
-	void *object = (void *)x;
-	struct kmem_cache *s;
-
-	if (unlikely(ZERO_OR_NULL_PTR(x)))
-		return;
-
-	folio = virt_to_folio(x);
-	if (unlikely(!folio_test_slab(folio))) {
-		free_large_kmalloc(folio, object);
-		return;
-	}
-
-	slab = folio_slab(folio);
-	s = slab->slab_cache;
-
-	trace_kmem_cache_free(s->name, _RET_IP_, x);
-	slab_free(s, slab, object, NULL, 1, _RET_IP_);
-}
-EXPORT_SYMBOL(kfree);
-
 #define SHRINK_PROMOTE_MAX 32
 
 /*
@@ -4799,30 +4735,6 @@ int __kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
 	return 0;
 }
 
-void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
-					int node, unsigned long caller)
-{
-	struct kmem_cache *s;
-	void *ret;
-
-	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
-		return kmalloc_large_node(size, gfpflags, node);
-
-	s = kmalloc_slab(size, gfpflags);
-
-	if (unlikely(ZERO_OR_NULL_PTR(s)))
-		return s;
-
-	ret = slab_alloc_node(s, NULL, gfpflags, node, caller, size);
-
-	/* Honor the call site pointer we received. */
-	trace_kmem_cache_alloc(s->name, caller, ret, size,
-			       s->size, gfpflags, node);
-
-	return ret;
-}
-EXPORT_SYMBOL(__kmalloc_node_track_caller);
-
 #ifdef CONFIG_SYSFS
 static int count_inuse(struct slab *slab)
 {
-- 
2.32.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BFB571B88
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbiGLNlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbiGLNk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:40:57 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1E3B852D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:40:34 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id j3so7511476pfb.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wm1f+oB3jG+iWra85ZdjG4EuPpOPh0bKcAoaTDQxDpQ=;
        b=TSDYRkQQJryf1S+KvrrcZzRC++k4TCCFHzx7q1+B8dGEDRldr3l8i94LRXAGHnMyfO
         NpIdXqQe3g4rSx0WTg6t656Fyv/PBvu/PpcXTbhzpSuJoilLAdrAqnTsInKgneVSGNGl
         +QYw8QmOiA7hzE+qfv+f8T6Q9ORtccOjvqxmskJiXr5QHOnTIDZGEoIW939s1dvqqK07
         7w6JkWwOdq9yz5Qlh7NiTE6Bdm/9jIOuhAp/f8X/AjcjJKinjE61IqV6XvCbj+KffGoO
         02E93ZWLz6d/EDCJOKyFUwbof8zBCAQi6BsVZwSE6NIl3w/+FWEYgLnyG3gAEzVQMwhR
         R1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wm1f+oB3jG+iWra85ZdjG4EuPpOPh0bKcAoaTDQxDpQ=;
        b=cKuBQFt0i0q6oN/PDDlVwwdGWU58u/HZYUQO2pw4QLbVm7oHx0izs/hYcyCzsOfjSb
         ZHMA8GUCgKcsKenwleZcgOekiWitvC9z8jgvLWVXytZDBoxGIF2vh7wtd9ANOep2zOV4
         qCg4E/xe1446HvlX89mX9mToXmEg8H7m4IhADq9s2CWMQ2PgAmi+EzxWxKp1c19SjDFH
         mvmCk4sfUbnIXQogoBABZ10N5WUZ8TLKgFbZ7y+iCv/GHa8wsZvXWnzcBcM2cNp7Jz1J
         nuVEn7+cdB5VjveWrLU565I0OOENME8eOSXq03LwD6yaYMW4X24o5NYxhzTD2C8uWX8i
         Q9nA==
X-Gm-Message-State: AJIora8sB3sGOOzMAbFs/M0P8+/ACmGtNZdX+5FGzrCqfTg1pqBlRPf+
        W/ldCW55T6dfCcoq9jnakt8=
X-Google-Smtp-Source: AGRyM1tCUagSJA9NBaVy2H+L/IKHO61UygWvEJXJgCvDVDV1MZm5D3Z7H44T6bxvef4k8fp42uP8Fg==
X-Received: by 2002:a05:6a00:ac7:b0:528:7acb:e445 with SMTP id c7-20020a056a000ac700b005287acbe445mr23942137pfl.14.1657633233818;
        Tue, 12 Jul 2022 06:40:33 -0700 (PDT)
Received: from ip-172-31-24-42.ap-northeast-1.compute.internal (ec2-35-75-15-180.ap-northeast-1.compute.amazonaws.com. [35.75.15.180])
        by smtp.gmail.com with ESMTPSA id r6-20020aa79886000000b0052ae3bcb807sm1947178pfl.188.2022.07.12.06.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 06:40:33 -0700 (PDT)
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
Subject: [PATCH v3 12/15] mm/sl[au]b: generalize kmalloc subsystem
Date:   Tue, 12 Jul 2022 13:39:42 +0000
Message-Id: <20220712133946.307181-13-42.hyeyoo@gmail.com>
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

Now everything in kmalloc subsystem can be generalized.
Let's do it!

Generalize __do_kmalloc_node(), __kmalloc_node_track_caller(),
kfree(), __ksize(), __kmalloc(), __kmalloc_node() and move them
to slab_common.c.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/slab.c        | 108 -----------------------------------------------
 mm/slab_common.c | 102 ++++++++++++++++++++++++++++++++++++++++++++
 mm/slub.c        |  87 --------------------------------------
 3 files changed, 102 insertions(+), 195 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 375e35c14430..6407dad13d5c 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3587,44 +3587,6 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
 EXPORT_SYMBOL(kmem_cache_alloc_node_trace);
 #endif
 
-static __always_inline void *
-__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
-{
-	struct kmem_cache *cachep;
-	void *ret;
-
-	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
-		ret = kmalloc_large_node_notrace(size, flags, node);
-
-		trace_kmalloc_node(caller, ret, NULL, size,
-				   PAGE_SIZE << get_order(size),
-				   flags, node);
-		return ret;
-	}
-
-	cachep = kmalloc_slab(size, flags);
-	if (unlikely(ZERO_OR_NULL_PTR(cachep)))
-		return cachep;
-
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
 void __kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
 {
@@ -3647,12 +3609,6 @@ void __kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
 }
 #endif
 
-void *__kmalloc(size_t size, gfp_t flags)
-{
-	return __do_kmalloc_node(size, flags, NUMA_NO_NODE, _RET_IP_);
-}
-EXPORT_SYMBOL(__kmalloc);
-
 static __always_inline
 void __do_kmem_cache_free(struct kmem_cache *cachep, void *objp,
 			  unsigned long caller)
@@ -3730,43 +3686,6 @@ void kmem_cache_free_bulk(struct kmem_cache *orig_s, size_t size, void **p)
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
-	trace_kfree(_RET_IP_, objp);
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
@@ -4169,30 +4088,3 @@ void __check_heap_object(const void *ptr, unsigned long n,
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
index 0dff46fb7193..1000e05c77df 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -924,6 +924,108 @@ void free_large_kmalloc(struct folio *folio, void *object)
 			      -(PAGE_SIZE << order));
 	__free_pages(folio_page(folio, 0), order);
 }
+
+static __always_inline
+void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
+{
+	struct kmem_cache *s;
+	void *ret;
+
+	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
+		ret = kmalloc_large_node_notrace(size, flags, node);
+		trace_kmalloc_node(caller, ret, NULL,
+				   size, PAGE_SIZE << get_order(size),
+				   flags, node);
+		return ret;
+	}
+
+	s = kmalloc_slab(size, flags);
+
+	if (unlikely(ZERO_OR_NULL_PTR(s)))
+		return s;
+
+	ret = __kmem_cache_alloc_node(s, flags, node, size, caller);
+	ret = kasan_kmalloc(s, ret, size, flags);
+	trace_kmalloc_node(caller, ret, s, size,
+			   s->size, flags, node);
+	return ret;
+}
+
+void *__kmalloc_node(size_t size, gfp_t flags, int node)
+{
+	return __do_kmalloc_node(size, flags, node, _RET_IP_);
+}
+EXPORT_SYMBOL(__kmalloc_node);
+
+void *__kmalloc(size_t size, gfp_t flags)
+{
+	return __do_kmalloc_node(size, flags, NUMA_NO_NODE, _RET_IP_);
+}
+EXPORT_SYMBOL(__kmalloc);
+
+void *__kmalloc_node_track_caller(size_t size, gfp_t flags,
+				  int node, unsigned long caller)
+{
+	return __do_kmalloc_node(size, flags, node, caller);
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
+	trace_kfree(_RET_IP_, object);
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
+	__kmem_cache_free(s, (void *)object, _RET_IP_);
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
index 74eb78678c98..836292c32e58 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4388,49 +4388,6 @@ static int __init setup_slub_min_objects(char *str)
 
 __setup("slub_min_objects=", setup_slub_min_objects);
 
-static __always_inline
-void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
-{
-	struct kmem_cache *s;
-	void *ret;
-
-	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
-		ret = kmalloc_large_node_notrace(size, flags, node);
-
-		trace_kmalloc_node(caller, ret, NULL,
-				   size, PAGE_SIZE << get_order(size),
-				   flags, node);
-
-		return ret;
-	}
-
-	s = kmalloc_slab(size, flags);
-
-	if (unlikely(ZERO_OR_NULL_PTR(s)))
-		return s;
-
-	ret = slab_alloc_node(s, NULL, flags, node, caller, size);
-
-	trace_kmalloc_node(caller, ret, s, size, s->size, flags, node);
-
-	ret = kasan_kmalloc(s, ret, size, flags);
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
-void *__kmalloc(size_t size, gfp_t flags)
-{
-	return __do_kmalloc_node(size, flags, NUMA_NO_NODE, _RET_IP_);
-}
-EXPORT_SYMBOL(__kmalloc);
-
-
 #ifdef CONFIG_HARDENED_USERCOPY
 /*
  * Rejects incorrectly sized objects and objects that are to be copied
@@ -4481,43 +4438,6 @@ void __check_heap_object(const void *ptr, unsigned long n,
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
-
-	trace_kfree(_RET_IP_, x);
-
-	if (unlikely(ZERO_OR_NULL_PTR(x)))
-		return;
-
-	folio = virt_to_folio(x);
-	if (unlikely(!folio_test_slab(folio))) {
-		free_large_kmalloc(folio, object);
-		return;
-	}
-	slab = folio_slab(folio);
-	slab_free(slab->slab_cache, slab, object, NULL, &object, 1, _RET_IP_);
-}
-EXPORT_SYMBOL(kfree);
-
 #define SHRINK_PROMOTE_MAX 32
 
 /*
@@ -4863,13 +4783,6 @@ int __kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
 	return 0;
 }
 
-void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
-				  int node, unsigned long caller)
-{
-	return __do_kmalloc_node(size, gfpflags, node, caller);
-}
-EXPORT_SYMBOL(__kmalloc_node_track_caller);
-
 #ifdef CONFIG_SYSFS
 static int count_inuse(struct slab *slab)
 {
-- 
2.34.1


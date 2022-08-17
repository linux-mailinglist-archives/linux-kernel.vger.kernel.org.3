Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CE3596CBD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 12:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238865AbiHQKUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 06:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238987AbiHQKTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:19:48 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA5280EBB
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:19:32 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id s5-20020a17090a13c500b001f4da9ffe5fso1381372pjf.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=dz+RrLrwLk+xXgnSRFPm4loOb+4mn5KEX029pojpz/g=;
        b=EdO5lWBDyEtukF9A+7HE/7DKzG4hdASyYOEZ0XAIe1KW64g4FGZU0PT5I44da9T14r
         IfuRLAlAV1vA2pc/+jQLC+Uv3+XB+6ENROPFDzWCZItxwMAZW3aKEcignejNQHZnS0w3
         VNeiIXv5pqy7syFwbox3b58swjVbRQ/DM0zAQmAmO6b5FbZhZkG4GjSr4DfIK9n//X72
         79GBOmBfEyoeThZ2Y+E+smekrYZ2hNpLD1+YdJcM/8ILL1YoeOguDTMgnhsfT2Ey9TfY
         iwowPTAIsytcKB5vefJo2FvI5tXF+ZS/7TPm1i73WqbCDQ3PuaF/wE/u1ru8Vt0oZjvx
         jQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=dz+RrLrwLk+xXgnSRFPm4loOb+4mn5KEX029pojpz/g=;
        b=zgVF5o1UgAwsRv4rtPpJ32QacDPpdFQbUsJ28P56bIieBFa85Md6oDe9H6pAPqiuFY
         4lw+1l8U/FwWbnd1dB3a8AC2okRDYQw98Oa6UIaL7T++K3fUwyJ20hwy+hXRdkPuJOT9
         9iMo/khCX/LGSHMmMkIkiIBBbiijz1nucXs+g6yP8yAmBgN7/DnAlWl3aOkqaJlmccnW
         iLi2873eCuB0DMyvOyC/SFl1CzA4X38WVmtYVI1cPLkxiDEspG8yJLcpSpKLVTCC6wBU
         48vRPr6t09BcWxEbTbQ+KS511/ZEMrrYKq1uAIp+i6Lj0fgj7SCjfMv0N/dYMBWF2Q9Z
         EVZA==
X-Gm-Message-State: ACgBeo2FbVs1GDRFPu4uterSJf/ARwAy1RzyrY4cIQK7LcT66q1G8Ive
        tA2ED3wwk8SmEnCBoEm3fwk=
X-Google-Smtp-Source: AA6agR6s+Wo7cDyxpJkmcNzbA+ig037E6IsZ/0zdxuBesVy8M5k0aYhgK97VFdOKH8n82GyYTPWJyg==
X-Received: by 2002:a17:90b:4b47:b0:1f7:2e06:5752 with SMTP id mi7-20020a17090b4b4700b001f72e065752mr2997195pjb.187.1660731570997;
        Wed, 17 Aug 2022 03:19:30 -0700 (PDT)
Received: from hyeyoo.. ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id d8-20020a170903230800b00172633fc236sm1071318plh.174.2022.08.17.03.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 03:19:29 -0700 (PDT)
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
Subject: [PATCH v4 12/17] mm/sl[au]b: generalize kmalloc subsystem
Date:   Wed, 17 Aug 2022 19:18:21 +0900
Message-Id: <20220817101826.236819-13-42.hyeyoo@gmail.com>
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

Now everything in kmalloc subsystem can be generalized.
Let's do it!

Generalize __do_kmalloc_node(), __kmalloc_node_track_caller(),
kfree(), __ksize(), __kmalloc(), __kmalloc_node() and move them
to slab_common.c.

In the meantime, rename kmalloc_large_node_notrace()
to __kmalloc_large_node() and make it static as it's now only called in
slab_common.c.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab.c        | 108 ----------------------------------------------
 mm/slab.h        |   1 -
 mm/slab_common.c | 109 +++++++++++++++++++++++++++++++++++++++++++++--
 mm/slub.c        |  87 -------------------------------------
 4 files changed, 106 insertions(+), 199 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index aa61851b0a07..5b234e3ab165 100644
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
diff --git a/mm/slab.h b/mm/slab.h
index 4e90ed0ab635..4d8330d57573 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -274,7 +274,6 @@ void create_kmalloc_caches(slab_flags_t);
 /* Find the kmalloc slab corresponding for a certain size */
 struct kmem_cache *kmalloc_slab(size_t, gfp_t);
 
-void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node);
 void *__kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags,
 			      int node, size_t orig_size,
 			      unsigned long caller);
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 5a2e81f42ee9..c8242b4e2223 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -897,6 +897,109 @@ void free_large_kmalloc(struct folio *folio, void *object)
 			      -(PAGE_SIZE << order));
 	__free_pages(folio_page(folio, 0), order);
 }
+
+static void *__kmalloc_large_node(size_t size, gfp_t flags, int node);
+static __always_inline
+void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
+{
+	struct kmem_cache *s;
+	void *ret;
+
+	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
+		ret = __kmalloc_large_node(size, flags, node);
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
@@ -917,7 +1020,7 @@ gfp_t kmalloc_fix_flags(gfp_t flags)
  * know the allocation order to free the pages properly in kfree.
  */
 
-void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
+void *__kmalloc_large_node(size_t size, gfp_t flags, int node)
 {
 	struct page *page;
 	void *ptr = NULL;
@@ -943,7 +1046,7 @@ void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
 
 void *kmalloc_large(size_t size, gfp_t flags)
 {
-	void *ret = kmalloc_large_node_notrace(size, flags, NUMA_NO_NODE);
+	void *ret = __kmalloc_large_node(size, flags, NUMA_NO_NODE);
 
 	trace_kmalloc(_RET_IP_, ret, NULL, size,
 		      PAGE_SIZE << get_order(size), flags);
@@ -953,7 +1056,7 @@ EXPORT_SYMBOL(kmalloc_large);
 
 void *kmalloc_large_node(size_t size, gfp_t flags, int node)
 {
-	void *ret = kmalloc_large_node_notrace(size, flags, node);
+	void *ret = __kmalloc_large_node(size, flags, node);
 
 	trace_kmalloc_node(_RET_IP_, ret, NULL, size,
 			   PAGE_SIZE << get_order(size), flags, node);
diff --git a/mm/slub.c b/mm/slub.c
index a11f78c2647c..cd49785d59e1 100644
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
2.32.0


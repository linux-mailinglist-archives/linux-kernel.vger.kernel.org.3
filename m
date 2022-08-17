Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C66C596CBA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 12:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbiHQKTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 06:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238865AbiHQKTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:19:12 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9EA65250
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:19:09 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id s206so11610575pgs.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=mA3ow7hUqSccT7bNwtvWTEd/QzJvQLSRyOCnJvDyp6U=;
        b=KSORlivSY1gDZvvmSEL4PxisN5IhBGQ1AeMvUGp8veSEXXByVMSzBjP4EJs747a5pq
         EofZUC/QfmHd03v73+6exjCC4vKOklIzSLxg0nltRXkCXFS4Sc0OwHmR9KIl6TyAEJrc
         fHJBGiEwu0cAFe0dzqsjwmqN5xt8ff032WOB4BvTPxYzEfZz7b1pP7lJm08KccLkCQHJ
         jt569vdr1+djQJL67jwzVOqUDjxqN7XyixPqfbCIXDwsI35VKNdGOl8hek/QXE1J67DP
         RNLPeV6A5AyUr6bx88K6xfAy8EGoftktHop8hdTCXciIpaf7F43jIYcW+0Qxx8yVYu8U
         qlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=mA3ow7hUqSccT7bNwtvWTEd/QzJvQLSRyOCnJvDyp6U=;
        b=CZ8/6Qsr3gOe7MeO9t9yB+w/kbM7L8FBcZsUJnkAd/fZO+Th/Dc3UlXFa+lmfTyQ2a
         40lgViEOoAJJr/7UTQPHDCZ+RXaiYk1+wA1z6oRDDOOES3xPJn7LaRkc0G5iQbgzXPUa
         32TALZSUvfEsPvq08cH/4PkujcT3tFiQfWlTDQEZ4mekGyDykQ3xal1X7q4TVwBGjOvv
         zEu500ckyjVbgFeWGxWCfC2aOKLT/jJaGztf/vOjnH0QPjSuO6ZcMMUvRPbfdaLWBj/T
         jtgYIH8zuKp5y29KQMs3uOVC/YLZjOpIcM4O99kVY+ujg3i8JImPiOiyfQb+JA0dMTJR
         C5AA==
X-Gm-Message-State: ACgBeo1jUNk8dJITJELYH1scDYeD+8sksjdeohgiNYtk9dz69Fbwy7Em
        ETE3431dpdhlSubp4Du/8eU=
X-Google-Smtp-Source: AA6agR7yr6u/vBTtWdBbY4Pd43tYRkW3wO6YJeVXJ+XtjSNhD6MsvXydP/mxQVwJjej0KHAHrH/4tQ==
X-Received: by 2002:a63:494a:0:b0:41c:f29e:2a2e with SMTP id y10-20020a63494a000000b0041cf29e2a2emr21247258pgk.477.1660731548139;
        Wed, 17 Aug 2022 03:19:08 -0700 (PDT)
Received: from hyeyoo.. ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id d8-20020a170903230800b00172633fc236sm1071318plh.174.2022.08.17.03.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 03:19:07 -0700 (PDT)
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
Subject: [PATCH v4 06/17] mm/slab_common: fold kmalloc_order_trace() into kmalloc_large()
Date:   Wed, 17 Aug 2022 19:18:15 +0900
Message-Id: <20220817101826.236819-7-42.hyeyoo@gmail.com>
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

There is no caller of kmalloc_order_trace() except kmalloc_large().
Fold it into kmalloc_large() and remove kmalloc_order{,_trace}().

Also add tracepoint in kmalloc_large() that was previously
in kmalloc_order_trace().

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slab.h | 22 ++--------------------
 mm/slab_common.c     | 17 ++++-------------
 2 files changed, 6 insertions(+), 33 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index a0e57df3d5a4..15a4c59da59e 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -489,26 +489,8 @@ static __always_inline void *kmem_cache_alloc_node_trace(struct kmem_cache *s, g
 }
 #endif /* CONFIG_TRACING */
 
-extern void *kmalloc_order(size_t size, gfp_t flags, unsigned int order) __assume_page_alignment
-									 __alloc_size(1);
-
-#ifdef CONFIG_TRACING
-extern void *kmalloc_order_trace(size_t size, gfp_t flags, unsigned int order)
-				__assume_page_alignment __alloc_size(1);
-#else
-static __always_inline __alloc_size(1) void *kmalloc_order_trace(size_t size, gfp_t flags,
-								 unsigned int order)
-{
-	return kmalloc_order(size, flags, order);
-}
-#endif
-
-static __always_inline __alloc_size(1) void *kmalloc_large(size_t size, gfp_t flags)
-{
-	unsigned int order = get_order(size);
-	return kmalloc_order_trace(size, flags, order);
-}
-
+void *kmalloc_large(size_t size, gfp_t flags) __assume_page_alignment
+					      __alloc_size(1);
 /**
  * kmalloc - allocate memory
  * @size: how many bytes of memory are required.
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 17996649cfe3..8b1988544b89 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -905,16 +905,16 @@ gfp_t kmalloc_fix_flags(gfp_t flags)
  * directly to the page allocator. We use __GFP_COMP, because we will need to
  * know the allocation order to free the pages properly in kfree.
  */
-void *kmalloc_order(size_t size, gfp_t flags, unsigned int order)
+void *kmalloc_large(size_t size, gfp_t flags)
 {
 	void *ret = NULL;
 	struct page *page;
+	unsigned int order = get_order(size);
 
 	if (unlikely(flags & GFP_SLAB_BUG_MASK))
 		flags = kmalloc_fix_flags(flags);
 
-	flags |= __GFP_COMP;
-	page = alloc_pages(flags, order);
+	page = alloc_pages(flags | __GFP_COMP, order);
 	if (likely(page)) {
 		ret = page_address(page);
 		mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B,
@@ -923,19 +923,10 @@ void *kmalloc_order(size_t size, gfp_t flags, unsigned int order)
 	ret = kasan_kmalloc_large(ret, size, flags);
 	/* As ret might get tagged, call kmemleak hook after KASAN. */
 	kmemleak_alloc(ret, size, 1, flags);
-	return ret;
-}
-EXPORT_SYMBOL(kmalloc_order);
-
-#ifdef CONFIG_TRACING
-void *kmalloc_order_trace(size_t size, gfp_t flags, unsigned int order)
-{
-	void *ret = kmalloc_order(size, flags, order);
 	trace_kmalloc(_RET_IP_, ret, NULL, size, PAGE_SIZE << order, flags);
 	return ret;
 }
-EXPORT_SYMBOL(kmalloc_order_trace);
-#endif
+EXPORT_SYMBOL(kmalloc_large);
 
 #ifdef CONFIG_SLAB_FREELIST_RANDOM
 /* Randomize a generic freelist */
-- 
2.32.0


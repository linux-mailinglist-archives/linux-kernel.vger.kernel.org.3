Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F9C571B7F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbiGLNkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbiGLNkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:40:19 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F92B7D5D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:40:16 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id v21so4772748plo.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5zXey38vmjUFb+GfMhB6B68P1VCpS6kNFrksbY6msJM=;
        b=IUUUzFdICndGH31XMdqciHNS9TD8lB55IEPCUzQuALBEjHxdz1FTzdzsTu2vzzp3Vg
         VK5l7grM5ZJsDCS7/gwbtCmeD4NXHTJHcbfOQgVPjxNqS3Kh6Fhev+0pY//YNvStMXl9
         CkCb0f9PjSeW/e8nEkGo+4LkwfziN6UZYtXOOADKQHknRZZU1N3Z1FIral8v/0F6B1Wd
         5Zpv6NzPgFq9dl49L2UabaepUujksbXbFMOt4uM9znrUDwMUdOOeZ7uKCRoUaLtneEDD
         rRh9PFfuWGsTafq6oZdXoDuKCXsAW4c9J/cvAQTlX3goprFNtltR8SZE7Io7i2mLtRwK
         pRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5zXey38vmjUFb+GfMhB6B68P1VCpS6kNFrksbY6msJM=;
        b=f8E5YC4+6tpi6cc0n8+COdskhvjZMl2FAhMqtdJiEZsx0v42BFI1C/82lYUqcZYSWf
         fSe1ka13eU9b6wP5giCp05zMXiJ3vvSZNMcXFOw/Sj5FmSXfM8coCD+39uI5CdRIucVv
         wLK0xiuX2SYsujXtCVc3tHxRnvf/Bv6L9eOY4Qc/sZw9U0fCSRd3hWYZnSsaoCME6Eit
         5IVwZ3+10BDacCJd9cJkystWcZap1wWTI2prDLGntvYduu64+CW4TOfK+FdLaw6jfed/
         5FLUQqDvKlrxcLcSwCtKXAHNXApc6CM7R6m4KBxXKC88F8ldjGBdSi0+zwwNAoM9G43Q
         oSFA==
X-Gm-Message-State: AJIora/s7wF26xpVVMoloCdjqxTYFZBPfFVkTCiNDa0Z3R10GSQknZVA
        Fsw3CAaG/8A0yp2f0vUSQj8=
X-Google-Smtp-Source: AGRyM1vtmYPKNJBp2rYSh/8vXIvdTgbEVgesyhLxMtq2Di+VDK83fYVktlc+wENFfd7ZfYqw2CJS+g==
X-Received: by 2002:a17:902:eccf:b0:16b:f555:d42e with SMTP id a15-20020a170902eccf00b0016bf555d42emr23624458plh.75.1657633216463;
        Tue, 12 Jul 2022 06:40:16 -0700 (PDT)
Received: from ip-172-31-24-42.ap-northeast-1.compute.internal (ec2-35-75-15-180.ap-northeast-1.compute.amazonaws.com. [35.75.15.180])
        by smtp.gmail.com with ESMTPSA id r6-20020aa79886000000b0052ae3bcb807sm1947178pfl.188.2022.07.12.06.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 06:40:15 -0700 (PDT)
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
Subject: [PATCH v3 07/15] mm/slub: move kmalloc_large_node() to slab_common.c
Date:   Tue, 12 Jul 2022 13:39:37 +0000
Message-Id: <20220712133946.307181-8-42.hyeyoo@gmail.com>
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

In later patch SLAB will also pass requests larger than order-1 page
to page allocator. Move kmalloc_large_node() to slab_common.c.

Fold kmalloc_large_node_hook() into kmalloc_large_node() as there is
no other caller.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slab.h |  4 ++++
 mm/slab_common.c     | 22 ++++++++++++++++++++++
 mm/slub.c            | 25 -------------------------
 3 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 15a4c59da59e..082499306098 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -491,6 +491,10 @@ static __always_inline void *kmem_cache_alloc_node_trace(struct kmem_cache *s, g
 
 void *kmalloc_large(size_t size, gfp_t flags) __assume_page_alignment
 					      __alloc_size(1);
+
+void *kmalloc_large_node(size_t size, gfp_t flags, int node) __assume_page_alignment
+							     __alloc_size(1);
+
 /**
  * kmalloc - allocate memory
  * @size: how many bytes of memory are required.
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 1f8af2106df0..6f855587b635 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -956,6 +956,28 @@ void *kmalloc_large(size_t size, gfp_t flags)
 }
 EXPORT_SYMBOL(kmalloc_large);
 
+void *kmalloc_large_node(size_t size, gfp_t flags, int node)
+{
+	struct page *page;
+	void *ptr = NULL;
+	unsigned int order = get_order(size);
+
+	flags |= __GFP_COMP;
+	page = alloc_pages_node(node, flags, order);
+	if (page) {
+		ptr = page_address(page);
+		mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B,
+				      PAGE_SIZE << order);
+	}
+
+	ptr = kasan_kmalloc_large(ptr, size, flags);
+	/* As ptr might get tagged, call kmemleak hook after KASAN. */
+	kmemleak_alloc(ptr, size, 1, flags);
+
+	return ptr;
+}
+EXPORT_SYMBOL(kmalloc_large_node);
+
 #ifdef CONFIG_SLAB_FREELIST_RANDOM
 /* Randomize a generic freelist */
 static void freelist_randomize(struct rnd_state *state, unsigned int *list,
diff --git a/mm/slub.c b/mm/slub.c
index 2ccc473e0ae7..f22a84dd27de 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1704,14 +1704,6 @@ static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
  * Hooks for other subsystems that check memory allocations. In a typical
  * production configuration these hooks all should produce no code at all.
  */
-static inline void *kmalloc_large_node_hook(void *ptr, size_t size, gfp_t flags)
-{
-	ptr = kasan_kmalloc_large(ptr, size, flags);
-	/* As ptr might get tagged, call kmemleak hook after KASAN. */
-	kmemleak_alloc(ptr, size, 1, flags);
-	return ptr;
-}
-
 static __always_inline void kfree_hook(void *x)
 {
 	kmemleak_free(x);
@@ -4402,23 +4394,6 @@ static int __init setup_slub_min_objects(char *str)
 
 __setup("slub_min_objects=", setup_slub_min_objects);
 
-static void *kmalloc_large_node(size_t size, gfp_t flags, int node)
-{
-	struct page *page;
-	void *ptr = NULL;
-	unsigned int order = get_order(size);
-
-	flags |= __GFP_COMP;
-	page = alloc_pages_node(node, flags, order);
-	if (page) {
-		ptr = page_address(page);
-		mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B,
-				      PAGE_SIZE << order);
-	}
-
-	return kmalloc_large_node_hook(ptr, size, flags);
-}
-
 static __always_inline
 void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
 {
-- 
2.34.1


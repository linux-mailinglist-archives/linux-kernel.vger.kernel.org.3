Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF874D1673
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346589AbiCHLnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346550AbiCHLng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:43:36 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E55110E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 03:42:33 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id k92so7800216pjh.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 03:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a35SrEad/eAQMCxQWVEvT242oxRfWtKIsHLOiwjxy8Q=;
        b=nhM/WVD4SmMuSmGF9+Jzs/aSOEKIsVgjY5Hme43ZybRCajPFs1+LOYEJO5ztiNbZDC
         EOnE8q2d4+SHYzYkqUtIjugISLfUUpp2iS+sE7wGwW3MH4pfLyfZXCJEw5BkErk4+IVw
         nOUAvIqURjrO8mKadDL6uWMWqxzbjvp5JaYVpqX9YTNA6cEAntuljvhzBH+qqOHAkeQK
         PHbJ9vL2SNJezF2BrMRP1tTIV8Dc/AEqvG0htaemDXFf7uHDU2XvsAy4WDpwYGBR4tfY
         SbtS3B8PwbtzeC7dXvb6oDWWSNiEtWjIFlfBUN9Es1vjWulLyZe5dvhksnnui8ZYRJrL
         p9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a35SrEad/eAQMCxQWVEvT242oxRfWtKIsHLOiwjxy8Q=;
        b=ua3hNnl8c0yp6AIaOH52PTOu0sX77YR9TeTy1sV0NRo1PK3+Mzo+ee6HbLpf5BwxJj
         XMMmqB3R8yUWjrWut6pMNMizc4PgGP/NvWF81FBjgT9ZJqeCHWOQElAYLEvSODDLZ9B4
         711/h+AXFr7ppIPFP+JiXoUsD5mA8ozVoNNZ704OYHuoptzwXIxc3ty5+pjzGmIAhy4/
         chfpUzqCdyUt9mDABfYfBb8nmW89Y2/cuDbCk7y2wLVwm5GS+OwwCM3mYTMnTH97FaU3
         irDy+VDMrLfA2HkEZOWE+TrgTAfwH3HbKYqD4XRR7CN4MoaIbOCtP7WLLPcLU8KHl+m5
         4y6g==
X-Gm-Message-State: AOAM530xGmxFfa44chusWWlw4oAZ6jDR735PfIMHt2UvSwEGd4C/57XK
        2ojEfvJ9+Rx9W+WE9ghAjHKaf2QE/ETz0A==
X-Google-Smtp-Source: ABdhPJw/Ns1qLFibCI3qywPljP+oYhIxKSBnkRalG1lLXwiRtHEak6SE9Xl/VvnxhdZmdRBZuPvwoQ==
X-Received: by 2002:a17:903:2290:b0:151:e50c:bb50 with SMTP id b16-20020a170903229000b00151e50cbb50mr10886509plh.95.1646739753350;
        Tue, 08 Mar 2022 03:42:33 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090ac40200b001bd0e552d27sm2578285pjt.11.2022.03.08.03.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 03:42:32 -0800 (PST)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     linux-mm@kvack.org
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org, 42.hyeyoo@gmail.com
Subject: [RFC PATCH v1 05/15] mm/slub: move kmalloc_large_node() to slab_common.c
Date:   Tue,  8 Mar 2022 11:41:32 +0000
Message-Id: <20220308114142.1744229-6-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220308114142.1744229-1-42.hyeyoo@gmail.com>
References: <20220308114142.1744229-1-42.hyeyoo@gmail.com>
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

Move tracepoint in kmalloc_large_node().

Add flag fix code. This exist in kmalloc_large() but omitted in
kmalloc_large_node().

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 include/linux/slab.h |  3 +++
 mm/slab_common.c     | 26 ++++++++++++++++++++++++
 mm/slub.c            | 47 ++++----------------------------------------
 3 files changed, 33 insertions(+), 43 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index aa14aba2b068..60d27635c13d 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -470,6 +470,9 @@ extern void *kmem_cache_alloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
 extern void *kmalloc_large(size_t size, gfp_t flags) __assume_page_alignment
 						     __alloc_size(1);
 
+extern void *kmalloc_large_node(size_t size, gfp_t flags, int node)
+				__assume_page_alignment __alloc_size(1);
+
 /**
  * kmalloc - allocate memory
  * @size: how many bytes of memory are required.
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 1ba479f9d143..f61ac7458829 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -956,6 +956,32 @@ void *kmalloc_large(size_t size, gfp_t flags)
 }
 EXPORT_SYMBOL(kmalloc_large);
 
+void *kmalloc_large_node(size_t size, gfp_t flags, int node)
+{
+	struct page *page;
+	void *ptr = NULL;
+	unsigned int order = get_order(size);
+
+	if (unlikely(flags & GFP_SLAB_BUG_MASK))
+		flags = kmalloc_fix_flags(flags);
+
+	flags |= __GFP_COMP;
+	page = alloc_pages_node(node, flags, order);
+	if (page) {
+		ptr = page_address(page);
+		mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B,
+				      PAGE_SIZE << order);
+	}
+	ptr = kasan_kmalloc_large(ptr, size, flags);
+	/* As ptr might get tagged, call kmemleak hook after KASAN. */
+	kmemleak_alloc(ptr, size, 1, flags);
+	trace_kmalloc_node(_RET_IP_, ptr, size, PAGE_SIZE << order, flags,
+			   node);
+	return ptr;
+
+}
+EXPORT_SYMBOL(kmalloc_large_node);
+
 #ifdef CONFIG_SLAB_FREELIST_RANDOM
 /* Randomize a generic freelist */
 static void freelist_randomize(struct rnd_state *state, unsigned int *list,
diff --git a/mm/slub.c b/mm/slub.c
index 267f700abac1..cdbbf0e97637 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1678,14 +1678,6 @@ static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
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
@@ -4387,37 +4379,13 @@ static int __init setup_slub_min_objects(char *str)
 
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
 void *__kmalloc_node(size_t size, gfp_t flags, int node)
 {
 	struct kmem_cache *s;
 	void *ret;
 
-	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
-		ret = kmalloc_large_node(size, flags, node);
-
-		trace_kmalloc_node(_RET_IP_, ret,
-				   size, PAGE_SIZE << get_order(size),
-				   flags, node);
-
-		return ret;
-	}
+	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
+		return kmalloc_large_node(size, flags, node);
 
 	s = kmalloc_slab(size, flags);
 
@@ -4874,15 +4842,8 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
 	struct kmem_cache *s;
 	void *ret;
 
-	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
-		ret = kmalloc_large_node(size, gfpflags, node);
-
-		trace_kmalloc_node(caller, ret,
-				   size, PAGE_SIZE << get_order(size),
-				   gfpflags, node);
-
-		return ret;
-	}
+	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
+		return kmalloc_large_node(size, gfpflags, node);
 
 	s = kmalloc_slab(size, gfpflags);
 
-- 
2.33.1


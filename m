Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E9C500909
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241365AbiDNJBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238973AbiDNJAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:00:50 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C396C927
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:58:22 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c12so4123957plr.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RAAeRzDkd8VHwI1btUNFRYh6M+YjRVYA6C41AKkMgWk=;
        b=LviAtoyKtaKBlZ2FL6h97l5iQCipPPEbnpaURSu/Q6d31pZSaLfk737UHtPjVNNsya
         8UjFYt0XMpXiAj6EBZwDZVB762UoYzBR2Lzj9I3sMXWCZ8YFQ8tYaOt1+aE2v0m9SmXH
         1kAPmDPsZ8J3ypTav1BKdu93hoc1ICkpd0CgIAdtvDBuioCInx4v2XMaSw2rMgpRmQ0V
         x8zQIQ3/oGnkXGZ+54jI0wCM1PCUt+vZfoGONGUa2q+VSonlhy6okbOOfU2p36TJPYAS
         r3WdtXJQHOamPnjAmWsDfakB80v3/UcMgboUJRkgjAUuGThAWyyCkumDxlZIQvS0PPPQ
         0zBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RAAeRzDkd8VHwI1btUNFRYh6M+YjRVYA6C41AKkMgWk=;
        b=0bbed0SfElJxsD5k6Pbo+5d4BoLqvxoeK2Qc+Xpi2bcLOLnaqmEb8gzNdYWoyM/Se/
         JKBoJ9zBn7H44PHmuuP2xbNQfqUFiMsgjsHq1PVstILoXzPE6zytjT4VmWrCI+eOkDtg
         uug5oicV/YdVaFwzZpq3mXVH6IY6M8rq2wANyKW94ZMWHBpyeDnqnE0gjcBkqa4jdtCn
         MlytNNYqkbhV9icXFLLZLEa/y42acxgEGe2Ka6q1sQ9Cyz6NEcWpXKjENMg5f+ytZR7X
         Lv2eQ03y8SoaeSsOslk14BQnhg6SOTYPA/H5q0IPylu9+l51CwmKPiOf5NNcNr1NlgZS
         SDsw==
X-Gm-Message-State: AOAM533FPxI6vOgdGcPUPKluKeron0B9ylKFW70CKxvp9xLOhVqCYA5s
        FgfiOq1B1ZdAySYkY9DNZ3c=
X-Google-Smtp-Source: ABdhPJyC2Gz8AiXe//HxfShI0SN9Ulacz6Yh5OZH2akI/9dzq5MTL9VvmXVj1hdw+LWLAjf1fwUBCw==
X-Received: by 2002:a17:90b:4d01:b0:1cd:46e8:215a with SMTP id mw1-20020a17090b4d0100b001cd46e8215amr2635214pjb.73.1649926702169;
        Thu, 14 Apr 2022 01:58:22 -0700 (PDT)
Received: from hyeyoo.. ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id p9-20020aa79e89000000b00505fada20dfsm1403537pfq.117.2022.04.14.01.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:58:20 -0700 (PDT)
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
Subject: [PATCH v2 07/23] mm/slub: move kmalloc_large_node() to slab_common.c
Date:   Thu, 14 Apr 2022 17:57:11 +0900
Message-Id: <20220414085727.643099-8-42.hyeyoo@gmail.com>
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

In later patch SLAB will also pass requests larger than order-1 page
to page allocator. Move kmalloc_large_node() to slab_common.c.

Fold kmalloc_large_node_hook() into kmalloc_large_node() as there is
no other caller.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 include/linux/slab.h |  3 +++
 mm/slab_common.c     | 22 ++++++++++++++++++++++
 mm/slub.c            | 25 -------------------------
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 6f6e22959b39..97336acbebbf 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -486,6 +486,9 @@ static __always_inline void *kmem_cache_alloc_node_trace(struct kmem_cache *s, g
 
 extern void *kmalloc_large(size_t size, gfp_t flags) __assume_page_alignment
 						     __alloc_size(1);
+
+extern void *kmalloc_large_node(size_t size, gfp_t flags, int node)
+				__assume_page_alignment __alloc_size(1);
 /**
  * kmalloc - allocate memory
  * @size: how many bytes of memory are required.
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 308cd5449285..e72089515030 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -949,6 +949,28 @@ void *kmalloc_large(size_t size, gfp_t flags)
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
index 44170b4f084b..640712706f2b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1679,14 +1679,6 @@ static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
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
@@ -4399,23 +4391,6 @@ static int __init setup_slub_min_objects(char *str)
 
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
-- 
2.32.0


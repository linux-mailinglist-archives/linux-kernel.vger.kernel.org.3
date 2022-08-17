Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B82596CB4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 12:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238974AbiHQKT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 06:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238915AbiHQKTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:19:14 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8429771980
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:19:12 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id h28so11653613pfq.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=V13eBLL+I9iGduc+JnUgsCOIMqteurACvuOFaESMVck=;
        b=npKhTo3ktjcY8GrNZPcQJecpqhpmyjY86O+1b2c9YapnvSiuEYHiYe5hnCn/sUP0QT
         qNkoC7kX+tJi8lPw28MEQm733wFAvgSGKZHtoE1lhSMoCOdt3XXcAE+Mv7OAcQdFAvX+
         HhH7RPa6voDdqpdjNP0u52d2Qik1vWrHYJBtcDSAmM+IC8xz9TstXJaxtT7fK2MNa8tY
         a+XUbmdJlWpmSC7QsgIfWYyubzXveHLy0AUl6kjCLyHahj3m/nD1qZPHeIe6fNarqGw7
         QA4ZQNVBFjw1Ozp+l5pBhj89GteMBMwljxJ7dQawuvf0VZQXj9hzJhJRJy8QSr8Qix4u
         YK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=V13eBLL+I9iGduc+JnUgsCOIMqteurACvuOFaESMVck=;
        b=p41uaZFf7ZZ3A0wx5wM9VBbzbzcDIpFnXRIKDXz8kkoTNh4V9V2QUjGFXIzRxTLvsj
         mgTPAH28Ptf4bhJZaZa93QnLr0XzdNz3yV/2r5MA/jHHaBtzf6rERqomAHGlQMBHDMea
         eC2ofAgqTsVejJ5HN+RFqmAwq5h3JTDrWzmvuW2HaDab6tvHyj3+sWLwbbkS2EpWKrdL
         CmylFWTQPhJYLr9Z+q66fDZJwv9pgpXzD+dmJ+j0UjblN1cUJ1cQ0Ep/h8pxYEIIETVb
         QE2eRqIfDG/yrOP14YG03Se86v4b08pNeNOcdH9hwawX8PhqhjUXoUwyqZeR8tdEgq3R
         m4JA==
X-Gm-Message-State: ACgBeo1kirbMdQuJvhU6ZBp9n4xgQfUEG9xdB8WxbXiC9maSxI3gTrFm
        aUOUeTQT2iyjI16PTFO480k=
X-Google-Smtp-Source: AA6agR5Ow2fAgG6PDOU6KesG5RJ+Tea/+u3A+H4XdF3ir3eqFdhtzZcFsxZkt3rDAsMg+9NGYF8LDg==
X-Received: by 2002:a65:4605:0:b0:41c:3d73:9385 with SMTP id v5-20020a654605000000b0041c3d739385mr20546331pgq.168.1660731551918;
        Wed, 17 Aug 2022 03:19:11 -0700 (PDT)
Received: from hyeyoo.. ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id d8-20020a170903230800b00172633fc236sm1071318plh.174.2022.08.17.03.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 03:19:11 -0700 (PDT)
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
Subject: [PATCH v4 07/17] mm/slub: move kmalloc_large_node() to slab_common.c
Date:   Wed, 17 Aug 2022 19:18:16 +0900
Message-Id: <20220817101826.236819-8-42.hyeyoo@gmail.com>
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
index 8b1988544b89..1b9101f9cb21 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -928,6 +928,28 @@ void *kmalloc_large(size_t size, gfp_t flags)
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
index f9929ba858ec..5e7819ade2c4 100644
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
2.32.0


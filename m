Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FB9500913
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236160AbiDNJBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241374AbiDNJBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:01:03 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A2E6BDD1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:58:35 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id f3so4287564pfe.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FlV8ZEK41ZdMIfwkF7+gZmKxcQ8uBvSWc85Gpkn7FwU=;
        b=RubjxjJED6Mw2ADHs9bC6pFF/8ixEw2g9qX1cjRSx/QoRTFS+aCl/M/LClPmVSB/Ar
         hUcRjn3NB0Pm8HSMAvEpsHx0mw/7A3gGoqxg5WHW6wo/VbNffgIDqlwAZJJqRqh6iqnl
         V2aVPMB/JyjUFKCu0HnMMjO7f9F9eAahWb3d5YeUosdMbdlAHGcYG8RxoSNToK1zZ0Tw
         hjfZen2/EZsE0tEprZfscu94f65wy7/H5Xqp94d01zPuaU7+0yHqgI9oLcR4l73SRYqH
         M5UB6pkQkTYLn7GOirpdaaHFy7F/7drJz6a4hDl6a5igt9StPR8Y0lNVzY6tKbADs5te
         yHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FlV8ZEK41ZdMIfwkF7+gZmKxcQ8uBvSWc85Gpkn7FwU=;
        b=EfcLo7hv1I/ALfsaSlD4snLJpjmkraKVFYdXOL56uzuPAK/tGnbZy/P2DurFf6sNZ6
         gj7VrKk8jLIz3+n4ZiUVPPjOrceyEvsZsSEOXdCVDGWroBtykhc4ypc6OTiyj5mgJyFm
         CwXR89MVoCHBIP+ZXF5b8tewR0ReDG8vGuex63ufDkQluwAyMI3o6deOudWapV6aXiey
         YNSk6kRF9t+e/Ec/siKpguIczdJJeoPoRjkshRLCrOfkHa0LDC2UHsZ2wis8xKd1BizD
         we8Tlpp6I6eMzhY0R9UQ4p0SQaDpVIyQntt+n9LxbxFFWzuEhkclRzJUfYU/p2rw0Vj3
         aNuA==
X-Gm-Message-State: AOAM533ggVmUe0+RhcteTv/piP06M9pgOgT8jxZlJHPDwBiGII8TwhrC
        JNIA5R5bLdBLfn4uj5qiCQQ=
X-Google-Smtp-Source: ABdhPJzxZfc9soDCUGa8twuzUynuxNIiT+1ORj/tjvMAiS1C7RpfPC5rAYNf51IGF11gXFeOROr0JQ==
X-Received: by 2002:a05:6a00:1341:b0:4fa:a3af:6ba3 with SMTP id k1-20020a056a00134100b004faa3af6ba3mr2847232pfu.51.1649926714563;
        Thu, 14 Apr 2022 01:58:34 -0700 (PDT)
Received: from hyeyoo.. ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id p9-20020aa79e89000000b00505fada20dfsm1403537pfq.117.2022.04.14.01.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:58:33 -0700 (PDT)
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
Subject: [PATCH v2 09/23] mm/slab_common: cleanup kmalloc_large()
Date:   Thu, 14 Apr 2022 17:57:13 +0900
Message-Id: <20220414085727.643099-10-42.hyeyoo@gmail.com>
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

Now that kmalloc_large() and kmalloc_large_node() do same job,
make kmalloc_large() wrapper of kmalloc_large_node().

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 include/linux/slab.h |  9 ++++++---
 mm/slab_common.c     | 24 ------------------------
 2 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 97336acbebbf..143830f57a7f 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -484,11 +484,14 @@ static __always_inline void *kmem_cache_alloc_node_trace(struct kmem_cache *s, g
 }
 #endif /* CONFIG_TRACING */
 
-extern void *kmalloc_large(size_t size, gfp_t flags) __assume_page_alignment
-						     __alloc_size(1);
-
 extern void *kmalloc_large_node(size_t size, gfp_t flags, int node)
 				__assume_page_alignment __alloc_size(1);
+
+static __always_inline void *kmalloc_large(size_t size, gfp_t flags)
+{
+	return kmalloc_large_node(size, flags, NUMA_NO_NODE);
+}
+
 /**
  * kmalloc - allocate memory
  * @size: how many bytes of memory are required.
diff --git a/mm/slab_common.c b/mm/slab_common.c
index cf17be8cd9ad..30684efc89d7 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -925,30 +925,6 @@ gfp_t kmalloc_fix_flags(gfp_t flags)
  * directly to the page allocator. We use __GFP_COMP, because we will need to
  * know the allocation order to free the pages properly in kfree.
  */
-void *kmalloc_large(size_t size, gfp_t flags)
-{
-	void *ret = NULL;
-	struct page *page;
-	unsigned int order = get_order(size);
-
-	if (unlikely(flags & GFP_SLAB_BUG_MASK))
-		flags = kmalloc_fix_flags(flags);
-
-	flags |= __GFP_COMP;
-	page = alloc_pages(flags, order);
-	if (likely(page)) {
-		ret = page_address(page);
-		mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B,
-				      PAGE_SIZE << order);
-	}
-	ret = kasan_kmalloc_large(ret, size, flags);
-	/* As ret might get tagged, call kmemleak hook after KASAN. */
-	kmemleak_alloc(ret, size, 1, flags);
-	trace_kmalloc(_RET_IP_, ret, size, PAGE_SIZE << order, flags);
-	return ret;
-}
-EXPORT_SYMBOL(kmalloc_large);
-
 void *kmalloc_large_node(size_t size, gfp_t flags, int node)
 {
 	struct page *page;
-- 
2.32.0


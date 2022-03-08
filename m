Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4517E4D1674
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346593AbiCHLn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346558AbiCHLni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:43:38 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BACF5FD2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 03:42:37 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id w37so16223202pga.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 03:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NJODWLWI7+P4Y4wf9Goyx7nWejvl0xaH4jd1S+sBpGc=;
        b=k8DqROsNj3BWSNG2HVRj2m3y+wA/g1RB5ufaW5G7A1VfyTlpqnavG7Y+AXEIbYf6LO
         CQeU9DHNU7Uk2GkBYnTLXY2YE/UEppE8Qj1TSTiTEAu4/qVWu4fCymEufSGdwNM/IbkR
         9mnZcPZDvpVlpepo9JHszhsl/PntsBcfeLgsA+CXe29/GkjBeBEelKB+saVHeAv5yHZ+
         PF4wn+R5lVgcCz+a1R7wELDHwKDHEPc8kXdVdX1T9gx6EHcnem8AyUhc41CMP82Ff8UA
         obfS73XrO2zVNOq4kkECRHvM6D+DybvJKPdPsA9VX0LwkA9ct45SLx6GLyJCZ/2DPbMV
         nmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NJODWLWI7+P4Y4wf9Goyx7nWejvl0xaH4jd1S+sBpGc=;
        b=fSRyttv992634ouHQIaVR3ajA+4gLfgim5ZTfHZAlBIo2gNW49o8kzr8gTtb5mYj6m
         pcfNM/q0f1caWrJyOPxF5DMMXFf9p94FxwsJfKOOg7e5rX9wb+oT38mPQLxH8tV55lIR
         43k4HD+NccGE9bcJpftMpp1h6mLy/kXDbc9k5qYR9ab9wyfciz6v3jpTw2P3iIqJfp1e
         FLsFIFd1+YBzPko2ppz8brqVv9iHvL94ozJlC7jZsgYV0dya0o2th6ClE3Pl5XDJ6095
         G2aU5zqHOBzjDxvsADunxpQ/a6vXB1QQF6ZAXHs8l9LFGbR520mghaRoPjUOqQKyF6n2
         rkSQ==
X-Gm-Message-State: AOAM533MQ2yU2GcfacmDmWNBtGIZw2YKY9KdwwSSO2a3HRYIC2EigrgP
        EX08YTbsuPZJFYgou4izbKs=
X-Google-Smtp-Source: ABdhPJyfjhk94lYAce75iEXeUf2t8Pcrxd7uSvQMXJhrHla2T9WmCnuYSkcYeNf816yPaaO3IIbsMg==
X-Received: by 2002:a63:8742:0:b0:37c:94b7:4fba with SMTP id i63-20020a638742000000b0037c94b74fbamr13501881pge.507.1646739756570;
        Tue, 08 Mar 2022 03:42:36 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090ac40200b001bd0e552d27sm2578285pjt.11.2022.03.08.03.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 03:42:36 -0800 (PST)
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
Subject: [RFC PATCH v1 06/15] mm/slab_common: cleanup kmalloc_large()
Date:   Tue,  8 Mar 2022 11:41:33 +0000
Message-Id: <20220308114142.1744229-7-42.hyeyoo@gmail.com>
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

Now that kmalloc_large() and kmalloc_large_node() do same job,
make kmalloc_large() wrapper of kmalloc_large_node().

This makes slab allocators to use kmalloc_node tracepoint in
kmalloc_large().

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 include/linux/slab.h |  8 +++++---
 mm/slab_common.c     | 24 ------------------------
 2 files changed, 5 insertions(+), 27 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 60d27635c13d..8840b2d55567 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -467,12 +467,14 @@ extern void *kmem_cache_alloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
 					 int node, size_t size) __assume_slab_alignment
 								__alloc_size(4);
 
-extern void *kmalloc_large(size_t size, gfp_t flags) __assume_page_alignment
-						     __alloc_size(1);
-
 extern void *kmalloc_large_node(size_t size, gfp_t flags, int node)
 				__assume_page_alignment __alloc_size(1);
 
+static __always_inline void *kmalloc_large(size_t size, gfp_t flags)
+{
+	return kmalloc_large_node(size, flags, NUMA_NO_NODE);
+}
+
 /**
  * kmalloc - allocate memory
  * @size: how many bytes of memory are required.
diff --git a/mm/slab_common.c b/mm/slab_common.c
index f61ac7458829..1fe2f2a7326d 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -932,30 +932,6 @@ gfp_t kmalloc_fix_flags(gfp_t flags)
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
2.33.1


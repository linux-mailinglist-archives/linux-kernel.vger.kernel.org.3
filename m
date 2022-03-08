Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E384D1672
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346576AbiCHLnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346525AbiCHLna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:43:30 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A978F134
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 03:42:30 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id kx6-20020a17090b228600b001bf859159bfso1980008pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 03:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LZZ8fVjHeh5I8K2sKzZs1QzAUbB02xCOg/5s4cz8cRE=;
        b=Z0oYgAKXyrIqwEuVfeU9cRh9YSUCIwuYqlBz0A5lt34OhAd57AXF+Y0lX9rXFz8x6p
         FZkwKTbRMbsc5VcJOvSnTnqF+ngaUmOfPl1gV73IolqJwlLp8C5GBcY6UW031L/IvigT
         6g89/ykep7HdizJ/gZeGckX5WtQTwPl1CFYr9dSZbd07d7kK4K0lyTBoEU6EBnr30E7r
         bF7bTM437Fs15hzqWQAfxCgxKFpg952oWG4TMO1wz82Xc6v2IYuh5bTkhZxU0liQax7y
         WWW27wEXdq3cJcesxWt0yPziZhPrG74pZPUxNNm5U5mSQjTGTzvHA07W+2mWOXJ2zhL1
         PRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LZZ8fVjHeh5I8K2sKzZs1QzAUbB02xCOg/5s4cz8cRE=;
        b=tDg3R9iOTywP+Z02u7JpxpisMkQMl/Qa8Rlo8Av17wfpCr/6vBdeo8XghG6Gc6rZ53
         aoqItfRiTRrQ+6Z62Q5Vbf7jY+nv+kMhMld6h5hDLSnuZKBc+x6tgIhPlJmoEIYrzvUk
         PdssHBz6I1W7LLpUJ1UOZ5HdywFMleBFEMVwlBF4w8wM/H8uRC+fEHvt4NpmN7+5OODG
         TVeClo3lRwWyzScw6PwRrvPDY/TUnZsxKO+ZZJHynf7M+roOQTAGeIAc+9CG9wi6sQFZ
         wF2bBHMr+V+bn61qUpjz/zgGfHOk9UCAfkLIfcVNQZHsf6213rQcyBHC8XHVNktSTtRn
         DEhw==
X-Gm-Message-State: AOAM532BtfKq/F3c/2+0vXbGvXId85uf22AK/evAJ5K9QoF6g8VRvXww
        XkqF8F/lSnqMi3VRobzbDgc=
X-Google-Smtp-Source: ABdhPJx+ihLWlNgAYhaAy4bGA/WKuwXn/5j/3Ommdre35Kbi9XjhlStDw4zZU1DSbUDjF8uSjpmUEg==
X-Received: by 2002:a17:902:d4c9:b0:151:d074:cbe8 with SMTP id o9-20020a170902d4c900b00151d074cbe8mr16210397plg.102.1646739750183;
        Tue, 08 Mar 2022 03:42:30 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090ac40200b001bd0e552d27sm2578285pjt.11.2022.03.08.03.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 03:42:29 -0800 (PST)
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
Subject: [RFC PATCH v1 04/15] mm/sl[auo]b: fold kmalloc_order() into kmalloc_large()
Date:   Tue,  8 Mar 2022 11:41:31 +0000
Message-Id: <20220308114142.1744229-5-42.hyeyoo@gmail.com>
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

There is no caller of kmalloc_order() except kmalloc_large().
Fold it into kmalloc_large() and remove kmalloc_order{,_trace}().

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 include/linux/slab.h | 13 ++-----------
 mm/slab_common.c     | 12 +++---------
 2 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index a5e3ad058817..aa14aba2b068 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -467,17 +467,8 @@ extern void *kmem_cache_alloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
 					 int node, size_t size) __assume_slab_alignment
 								__alloc_size(4);
 
-extern void *kmalloc_order(size_t size, gfp_t flags, unsigned int order) __assume_page_alignment
-									 __alloc_size(1);
-
-extern void *kmalloc_order_trace(size_t size, gfp_t flags, unsigned int order)
-				__assume_page_alignment __alloc_size(1);
-
-static __always_inline __alloc_size(1) void *kmalloc_large(size_t size, gfp_t flags)
-{
-	unsigned int order = get_order(size);
-	return kmalloc_order_trace(size, flags, order);
-}
+extern void *kmalloc_large(size_t size, gfp_t flags) __assume_page_alignment
+						     __alloc_size(1);
 
 /**
  * kmalloc - allocate memory
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 2edb77056adc..1ba479f9d143 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -932,10 +932,11 @@ gfp_t kmalloc_fix_flags(gfp_t flags)
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
@@ -950,17 +951,10 @@ void *kmalloc_order(size_t size, gfp_t flags, unsigned int order)
 	ret = kasan_kmalloc_large(ret, size, flags);
 	/* As ret might get tagged, call kmemleak hook after KASAN. */
 	kmemleak_alloc(ret, size, 1, flags);
-	return ret;
-}
-EXPORT_SYMBOL(kmalloc_order);
-
-void *kmalloc_order_trace(size_t size, gfp_t flags, unsigned int order)
-{
-	void *ret = kmalloc_order(size, flags, order);
 	trace_kmalloc(_RET_IP_, ret, size, PAGE_SIZE << order, flags);
 	return ret;
 }
-EXPORT_SYMBOL(kmalloc_order_trace);
+EXPORT_SYMBOL(kmalloc_large);
 
 #ifdef CONFIG_SLAB_FREELIST_RANDOM
 /* Randomize a generic freelist */
-- 
2.33.1


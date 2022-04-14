Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B921500901
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241348AbiDNJAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241357AbiDNJAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:00:49 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF756BDD1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:58:16 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id h5so4224488pgc.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Flouc9x4YW1EROU8wB1b7QSoEspFYDh7fC18OAMupnU=;
        b=oony/Txz5UItxFolta6iBfVnB8Y1xpXvK3iNV5pZyj98ppFo9RkGtVpwBS+DKI8QWO
         VwGRSP+JOqEQKfBIFD3st+33YwNN2BP25EYis48bexbK4VejcsLUZYH6XDcLI9Him/Cc
         pdL4JgTE8s4JX3p8FES71ZLoECOOogMnaangOCqpr0OoafDq3QrY56Or4zqI6gg3Rl4I
         6PJpps2bvqQyRG8B5sAjDr83OMcBN8MiYs6T12aHSnzK6ovfvPD4vpB0khpULee6lrlv
         lMsscFikXRKquMov+dpptRT9c7vJXLJ4n2ViPI2dPNKB+x+S5Mt3HpQnOIq2ER68Z3th
         5ltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Flouc9x4YW1EROU8wB1b7QSoEspFYDh7fC18OAMupnU=;
        b=HytLoPdyMFqf2tDr2TWq0eFPvOJ1OVoLqvBjAozSuQo5hk1FV7racS0TKIyG61CdhU
         ZNGloXhKZY7jU04B1VvcCa+pCzUVsdNYb4W/zM7GxYNkDCKzrNJSkJhrfu91xP/OWJuW
         UrQDARvdu09+tVpVwSeQqUzW1IIOLoGCq43fDSeVW7E19jBdx+srvBMXYpqX0iEDn2di
         P3sPD8yd48cCU8kIRO4bk+F5NiQ0ZlpZUoFbbxJIpc6wt84n9z86sV1FtgqUtGEXMzcw
         84lTzqrwgudEQ5jAkPzrZBanutVP30Uzc4PpY99RjIIipH3o+4u5C4FLT6TXoHl5JDi1
         DdaQ==
X-Gm-Message-State: AOAM531vQlPFbx1xxBsM1ULzt++ynMn8eJwKwQv/7L/dDRFdLaM3kK3M
        gb59K2ztv7RAohEiUPe2KYY=
X-Google-Smtp-Source: ABdhPJyHufbjJAEzA9QC+Uba/N3QwSoEgPj/JV96DrZ1cwqz0NEioGGRA5GL0D2mSmMpFjxGqs7n6g==
X-Received: by 2002:a05:6a00:1bca:b0:505:ac8b:cc4b with SMTP id o10-20020a056a001bca00b00505ac8bcc4bmr14022293pfw.26.1649926696025;
        Thu, 14 Apr 2022 01:58:16 -0700 (PDT)
Received: from hyeyoo.. ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id p9-20020aa79e89000000b00505fada20dfsm1403537pfq.117.2022.04.14.01.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:58:14 -0700 (PDT)
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
Subject: [PATCH v2 06/23] mm/sl[auo]b: fold kmalloc_order_trace() into kmalloc_large()
Date:   Thu, 14 Apr 2022 17:57:10 +0900
Message-Id: <20220414085727.643099-7-42.hyeyoo@gmail.com>
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

There is no caller of kmalloc_order_trace() except kmalloc_large().
Fold it into kmalloc_large() and remove kmalloc_order{,_trace}().

Also add tracepoint in kmalloc_large() that was previously
in kmalloc_order_trace().

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
Changes from v1:
- updated some changelog (kmalloc_order() -> kmalloc_order_trace())

 include/linux/slab.h | 22 ++--------------------
 mm/slab_common.c     | 14 +++-----------
 2 files changed, 5 insertions(+), 31 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 4c06d15f731c..6f6e22959b39 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -484,26 +484,8 @@ static __always_inline void *kmem_cache_alloc_node_trace(struct kmem_cache *s, g
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
+extern void *kmalloc_large(size_t size, gfp_t flags) __assume_page_alignment
+						     __alloc_size(1);
 /**
  * kmalloc - allocate memory
  * @size: how many bytes of memory are required.
diff --git a/mm/slab_common.c b/mm/slab_common.c
index c4d63f2c78b8..308cd5449285 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -925,10 +925,11 @@ gfp_t kmalloc_fix_flags(gfp_t flags)
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
@@ -943,19 +944,10 @@ void *kmalloc_order(size_t size, gfp_t flags, unsigned int order)
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
 	trace_kmalloc(_RET_IP_, ret, size, PAGE_SIZE << order, flags);
 	return ret;
 }
-EXPORT_SYMBOL(kmalloc_order_trace);
-#endif
+EXPORT_SYMBOL(kmalloc_large);
 
 #ifdef CONFIG_SLAB_FREELIST_RANDOM
 /* Randomize a generic freelist */
-- 
2.32.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C999850090B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241369AbiDNJBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241363AbiDNJAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:00:54 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97C66A03E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:58:28 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id md4so4512073pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mklZHMW5WaloeJehusu1yiX1f4fRcVma2Hx+8tQuib8=;
        b=GYW1lVzkhSeESKJQugH4CvCpPCnM0yPtooYZPpJUL6/o3mTK9iJDo6dDN9vtod3Tgb
         hIfURH8rHJq9vbAWy4FYs6rd2oixfZmowPP4xMb6FvHfcTvY2MMjGKgxqZRMiSUIXenf
         3gtIboofh9pvDm4R8qhwIzmlgIBKfYIH17OyeN8t9ltupuXBZWK+nFkoopWnfj3LfdbU
         5TPi9waabu9rOMIsIS2YJ/2qwe+RZav6Mlhi/yu8/1S0sF/zXnI2CzP8KZwBeWWwrAmC
         JCFSArnAlY2GARjH5PlUy6sgyKvZN65XnLSiD3kdqnrakHEeNNu8Mhkzy0bAfZwbM7tv
         XH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mklZHMW5WaloeJehusu1yiX1f4fRcVma2Hx+8tQuib8=;
        b=3uXrsFN2GEE2a+i28U34yiCuX41gsReyV0qOR+Vwdd9SA8y3P1wX0+JEANiqqEdJJb
         WFe0MaGTOaOeJldrQrSCeE0UWDa2cx5wROKgz5rmkCUT03IuRP7TgfUsihXFdHDnZSLy
         Qi82BbI5n77aj8VlNcBen38B6rFx5gWwvH/hthXWPPUpIOlzdN8wOikl0KKgV7EDvs7/
         o4u6jvuuyDbRa7itC1LaXb7ReL9dXngBYHACHugvW+EW+HsNaE4LEh+9FIYt0HNqyvUt
         wHcZ1iceDOXnnbmwrOd0Erg0yT++E20SlVC+Y5kc4yBhpNIpgpYh4ZziB5e8ajAalH5B
         k6Gw==
X-Gm-Message-State: AOAM530iObbMOUyi2ups3ws/6erpQZGBuCoeuSqVYGEXnhCFiTAS7/R6
        D7Etz0WyvzP7ZExrvXhQY7o=
X-Google-Smtp-Source: ABdhPJz5Qe3GUHD4nEk7hJm0HJO2KG9nnWXjtA/yZzhLdrdjyrKfgdCsRiLJZQUTpyory4+gb0nIgQ==
X-Received: by 2002:a17:90b:4f44:b0:1cb:c539:5acc with SMTP id pj4-20020a17090b4f4400b001cbc5395accmr3233335pjb.152.1649926708329;
        Thu, 14 Apr 2022 01:58:28 -0700 (PDT)
Received: from hyeyoo.. ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id p9-20020aa79e89000000b00505fada20dfsm1403537pfq.117.2022.04.14.01.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:58:26 -0700 (PDT)
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
Subject: [PATCH v2 08/23] mm/slab_common: make kmalloc_large_node() consistent with kmalloc_large()
Date:   Thu, 14 Apr 2022 17:57:12 +0900
Message-Id: <20220414085727.643099-9-42.hyeyoo@gmail.com>
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

Move tracepoints into kmalloc_large_node() and add missing flag fix code.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/slab_common.c |  6 ++++++
 mm/slub.c        | 22 ++++------------------
 2 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index e72089515030..cf17be8cd9ad 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -955,6 +955,9 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node)
 	void *ptr = NULL;
 	unsigned int order = get_order(size);
 
+	if (unlikely(flags & GFP_SLAB_BUG_MASK))
+		flags = kmalloc_fix_flags(flags);
+
 	flags |= __GFP_COMP;
 	page = alloc_pages_node(node, flags, order);
 	if (page) {
@@ -966,6 +969,9 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node)
 	ptr = kasan_kmalloc_large(ptr, size, flags);
 	/* As ptr might get tagged, call kmemleak hook after KASAN. */
 	kmemleak_alloc(ptr, size, 1, flags);
+	trace_kmalloc_node(_RET_IP_, ptr,
+			   size, PAGE_SIZE << order,
+			   flags, node);
 
 	return ptr;
 }
diff --git a/mm/slub.c b/mm/slub.c
index 640712706f2b..f10a892f1772 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4396,15 +4396,8 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node)
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
 
@@ -4861,15 +4854,8 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
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
2.32.0


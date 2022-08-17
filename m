Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABDB596CAE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 12:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238923AbiHQKTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 06:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238963AbiHQKTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:19:24 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECA869F6B
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:19:16 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id l64so11623309pge.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=tUizZNwzs6wrGKQx11/4tG0R+Fhf4KT2C7xsd5j/OPo=;
        b=bY7PoNXTNun67H8bazC4lB6u5PTF5Ax0sm7RPZ5xOp0oXn6dZLFedj/4unFw/BlDDL
         mqTrR5AxcbSlSpRA45N8LaKISXNbmmfAewTh4D/t5lrPW/t+REUE7SsxahxsKg0Srcp6
         dbyfTNerch1YbEmDg9hmcmdCMQm4UMFLr5EzYYzC3g/dLOYmxFQBLsyr6pG8YE4an+oZ
         WndXjF7Fgvn7VRcUho4F+SN/MWvoYbwWZJRjMjiuRkbB/PM7TYriAIlcffJhkczVh74l
         Osfzb/vU+aEncSSEVKo4JlhOnKOHr2lS5Th50FdOQLTxUyRRZQTVfbg2+BChABSBVcSI
         IbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=tUizZNwzs6wrGKQx11/4tG0R+Fhf4KT2C7xsd5j/OPo=;
        b=61930GL3rBnGibzva45ezhC1WJK7J8Uf5/I/0CD8BobzWp946T0exGrz3uBXCy4E03
         5xHizgo9EyQYbVqlH5Nm31vew2iO/nk6hyAX7llLA/FPkA0ujleUt8JjlC8gdTUERvvs
         rAvSY5qJAM6X0kFMxoWCQgii5maCD50JFWOMFuSo3i6U8A9HcujYJgaXFMx9JK1WE6Iu
         qNtdegoMwGl64d0yufqxRu9gP+Q3lkP4nh4LFUi3+mp3CZjyJLVRE2MGQfWW9Q5OQSE1
         ttd6SPWFhKcCxC9PyAv/WwNaVSP+7GCVnRcUyPfkJ0VWxo+MnXfv6iuGNxpYrGfu5FmM
         LM3w==
X-Gm-Message-State: ACgBeo2sjzw1AX6Svb4x2vA27/WL0MjVU1L1dT7x7NRhIXkyEEI3Vas+
        yRUtZldprMmfW8Tb/fqaXfU=
X-Google-Smtp-Source: AA6agR4P3TPHzp2fITNYUXY7GsNidyO6PDhQ+K8ehcHtYRDvNqx9oqwhJcudXfK2S6wxGaR7sSRMSA==
X-Received: by 2002:a63:5916:0:b0:41d:2c8c:7492 with SMTP id n22-20020a635916000000b0041d2c8c7492mr20956775pgb.81.1660731555697;
        Wed, 17 Aug 2022 03:19:15 -0700 (PDT)
Received: from hyeyoo.. ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id d8-20020a170903230800b00172633fc236sm1071318plh.174.2022.08.17.03.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 03:19:14 -0700 (PDT)
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
Subject: [PATCH v4 08/17] mm/slab_common: kmalloc_node: pass large requests to page allocator
Date:   Wed, 17 Aug 2022 19:18:17 +0900
Message-Id: <20220817101826.236819-9-42.hyeyoo@gmail.com>
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

Now that kmalloc_large_node() is in common code, pass large requests
to page allocator in kmalloc_node() using kmalloc_large_node().

One problem is that currently there is no tracepoint in
kmalloc_large_node(). Instead of simply putting tracepoint in it,
use kmalloc_large_node{,_notrace} depending on its caller to show
useful address for both inlined kmalloc_node() and
__kmalloc_node_track_caller() when large objects are allocated.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slab.h | 26 +++++++++++++++++++-------
 mm/slab.h            |  2 ++
 mm/slab_common.c     | 11 ++++++++++-
 mm/slub.c            |  2 +-
 4 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 082499306098..fd2e129fc813 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -571,23 +571,35 @@ static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
 	return __kmalloc(size, flags);
 }
 
+#ifndef CONFIG_SLOB
 static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
 {
-#ifndef CONFIG_SLOB
-	if (__builtin_constant_p(size) &&
-		size <= KMALLOC_MAX_CACHE_SIZE) {
-		unsigned int i = kmalloc_index(size);
+	if (__builtin_constant_p(size)) {
+		unsigned int index;
 
-		if (!i)
+		if (size > KMALLOC_MAX_CACHE_SIZE)
+			return kmalloc_large_node(size, flags, node);
+
+		index = kmalloc_index(size);
+
+		if (!index)
 			return ZERO_SIZE_PTR;
 
 		return kmem_cache_alloc_node_trace(
-				kmalloc_caches[kmalloc_type(flags)][i],
+				kmalloc_caches[kmalloc_type(flags)][index],
 						flags, node, size);
 	}
-#endif
 	return __kmalloc_node(size, flags, node);
 }
+#else
+static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
+{
+	if (__builtin_constant_p(size) && size > KMALLOC_MAX_CACHE_SIZE)
+		return kmalloc_large_node(size, flags, node);
+
+	return __kmalloc_node(size, flags, node);
+}
+#endif
 
 /**
  * kmalloc_array - allocate memory for an array.
diff --git a/mm/slab.h b/mm/slab.h
index 4ec82bec15ec..40322bcf07be 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -273,6 +273,8 @@ void create_kmalloc_caches(slab_flags_t);
 
 /* Find the kmalloc slab corresponding for a certain size */
 struct kmem_cache *kmalloc_slab(size_t, gfp_t);
+
+void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node);
 #endif
 
 gfp_t kmalloc_fix_flags(gfp_t flags);
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 1b9101f9cb21..7a0942d54424 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -928,7 +928,7 @@ void *kmalloc_large(size_t size, gfp_t flags)
 }
 EXPORT_SYMBOL(kmalloc_large);
 
-void *kmalloc_large_node(size_t size, gfp_t flags, int node)
+void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
 {
 	struct page *page;
 	void *ptr = NULL;
@@ -948,6 +948,15 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node)
 
 	return ptr;
 }
+
+void *kmalloc_large_node(size_t size, gfp_t flags, int node)
+{
+	void *ret = kmalloc_large_node_notrace(size, flags, node);
+
+	trace_kmalloc_node(_RET_IP_, ret, NULL, size,
+			   PAGE_SIZE << get_order(size), flags, node);
+	return ret;
+}
 EXPORT_SYMBOL(kmalloc_large_node);
 
 #ifdef CONFIG_SLAB_FREELIST_RANDOM
diff --git a/mm/slub.c b/mm/slub.c
index 5e7819ade2c4..165fe87af204 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4401,7 +4401,7 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller
 	void *ret;
 
 	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
-		ret = kmalloc_large_node(size, flags, node);
+		ret = kmalloc_large_node_notrace(size, flags, node);
 
 		trace_kmalloc_node(caller, ret, NULL,
 				   size, PAGE_SIZE << get_order(size),
-- 
2.32.0


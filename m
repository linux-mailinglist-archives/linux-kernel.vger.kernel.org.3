Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54E0571B82
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbiGLNlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbiGLNkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:40:23 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81801B8506
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:40:20 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id fz10so7643775pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q05RXXWJycZ1P59/mp0uhe2gutuzKOhr4XAdWhZ9Oj4=;
        b=Z2yvwOEeqLzlkysX3tAzh98KlM9fDBJZWvwk/jHI28aqsj3dgNo4OXlx4xGiU/PUOL
         hMX475+QpEsnX3L7CV0avgMlQzZXQKnVFqo+ix0FNpw6i/yJ6A+fVFXyd0YoX62i5/Gu
         KXl4bJGNnLvIIgBmXXLYvWZZeWXZAremP1z/CKu5XgBKzOe0b0JjL/R1YpIF99Pbzok0
         6WXbOFEgbd7aCfzzRLZV4iU+aiJgGnLFQ1Y2XmODraA6PNtKuL86I8oh8xORR93tdZRC
         2qHCylrHfqUOjyVV0z3Vx545hBF87H9lHT5MPU05JkJ7w0ZiOSHL20lPc6N4Bns4MivH
         Py1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q05RXXWJycZ1P59/mp0uhe2gutuzKOhr4XAdWhZ9Oj4=;
        b=EFmh4IjHL7q/qYMpsThoAmT/7XHG86lKkZq7xX6j9aNsW7uVKYzdBDIV7crYMOOHAJ
         Y8ZAZLHXUXcg/9X8XZsJAX42ZCF/P7mDPwVJiUxKzCchTFtC9EIGt4CXrutXGWyn28h1
         aMP3q6KaynLOfKaEIwTjbw5bT5l7R/Q+vfzcedYm897QwJdsTAdFwvNWl6eE4l1XMsUe
         CwEiVadu3IJrnS/P0A1EmxhYqNExoTKQy8GXJ3EGDa2oDS1WsxHpTc9k0QCuMdVc1ARZ
         QutrXMs3Dv02z4F7ObsHkFMk9/BXOzpkfDkr4U+giKdkdZyEoWwLAMyyS0uRcr6ZWzhS
         /l/A==
X-Gm-Message-State: AJIora9uSmll6FK6NzXvuLdGPi5AfExnPRWbCyveT5Izj+U875wTySGL
        4BxVUHV/Ua/4LKJvboZ15Ak=
X-Google-Smtp-Source: AGRyM1t65LKcTddXYYGzUV8MUChdpiaqqiK6HwnsR9t+AA9zssLUWZ9aL/V+mESwNPFA8YEPjFrUhg==
X-Received: by 2002:a17:902:b08a:b0:16c:68b6:311 with SMTP id p10-20020a170902b08a00b0016c68b60311mr712737plr.166.1657633219946;
        Tue, 12 Jul 2022 06:40:19 -0700 (PDT)
Received: from ip-172-31-24-42.ap-northeast-1.compute.internal (ec2-35-75-15-180.ap-northeast-1.compute.amazonaws.com. [35.75.15.180])
        by smtp.gmail.com with ESMTPSA id r6-20020aa79886000000b0052ae3bcb807sm1947178pfl.188.2022.07.12.06.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 06:40:19 -0700 (PDT)
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
Subject: [PATCH v3 08/15] mm/slab_common: kmalloc_node: pass large requests to page allocator
Date:   Tue, 12 Jul 2022 13:39:38 +0000
Message-Id: <20220712133946.307181-9-42.hyeyoo@gmail.com>
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

Now that kmalloc_large_node() is in common code, pass large requests
to page allocator in kmalloc_node() using kmalloc_large_node().

One problem is that currently there is no tracepoint in
kmalloc_large_node(). Instead of simply putting tracepoint in it,
use kmalloc_large_node{,_notrace} depending on its caller to show
useful address for both inlined kmalloc_node() and
__kmalloc_node_track_caller() when large objects are allocated.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 v3:
	This patch is new in v3 and this avoids
	missing caller in __kmalloc_large_node_track_caller()
	when kmalloc_large_node() is called.

 include/linux/slab.h | 26 +++++++++++++++++++-------
 mm/slab.h            |  2 ++
 mm/slab_common.c     | 17 ++++++++++++++++-
 mm/slub.c            |  2 +-
 4 files changed, 38 insertions(+), 9 deletions(-)

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
index a8d5eb1c323f..7cb51ff44f0c 100644
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
index 6f855587b635..dc872e0ef0fc 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -956,7 +956,8 @@ void *kmalloc_large(size_t size, gfp_t flags)
 }
 EXPORT_SYMBOL(kmalloc_large);
 
-void *kmalloc_large_node(size_t size, gfp_t flags, int node)
+static __always_inline
+void *__kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
 {
 	struct page *page;
 	void *ptr = NULL;
@@ -976,6 +977,20 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node)
 
 	return ptr;
 }
+
+void *kmalloc_large_node_notrace(size_t size, gfp_t flags, int node)
+{
+	return __kmalloc_large_node_notrace(size, flags, node);
+}
+
+void *kmalloc_large_node(size_t size, gfp_t flags, int node)
+{
+	void *ret = __kmalloc_large_node_notrace(size, flags, node);
+
+	trace_kmalloc_node(_RET_IP_, ret, NULL, size,
+			   PAGE_SIZE << get_order(size), flags, node);
+	return ret;
+}
 EXPORT_SYMBOL(kmalloc_large_node);
 
 #ifdef CONFIG_SLAB_FREELIST_RANDOM
diff --git a/mm/slub.c b/mm/slub.c
index f22a84dd27de..3d02cf44adf7 100644
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
2.34.1


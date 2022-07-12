Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA80571B7E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbiGLNki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbiGLNkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:40:14 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3556BB79F3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:40:10 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id f11so6719728pgj.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ti9NktoQFsWdX4hu+k0KGe8MY0mLyAlR/eRab2R9rEQ=;
        b=ThsouO6vHYVO9wZ6HVSglUj9qGd+WEyZjOmXsK1l2F9xrvQrbQGR0JkLp94pRUcVyy
         0JuVUYZufPEbar4+20VlXfJXzD/YREBs+HqTEUyJ9dza5nY8HbVXlxttZr7aRzLgrbL5
         XV2OtLLkL76cB9B2Uts67ZO8pjpnm8KGDX4fmOZ+iIWYP7buo5leMp2OKTb139/oGv9q
         gVlF+nDglEgWpcwIKbS3NlZbMtrtRd2Ng6dQ8th5Od8C48QDkqIsHzrB+mpfDRaeq8Fb
         RierjCgrRwJNMkUEPFdapaCH8CZ1HuOcdgYydNt7s7fbBmDBO3MvFponw6ACAeoi4VHY
         m1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ti9NktoQFsWdX4hu+k0KGe8MY0mLyAlR/eRab2R9rEQ=;
        b=GzSWkkBEyEbqua6gNNB32LsrBHXqic7hzQwA9AIS7+C4IEI5GXftWpGOTfunczP2PQ
         RKqgLtwZVzrDyFpGp0oW+2sJpYju8CEgSumlIdoYGSzwgxj3E0xL1qvA0rlE1YZy0DPy
         WJCO0zsjAmySqfly23/Y+6vdtmTyIF9SZgtmudtSJlgA1HX9u87m3sMasl7z9txNiN9X
         3uHL/NxXBpv40OPhKOzLPYcFq3q5tBhczep2D4tSACRYpDtpTdlRXU/FGKh2VQ3QVv7j
         NXAZqm4xIKERrVONTs+kq8xR2Cvhhmh2QRnvh3vcfYDvvH/cN4TElgXVPDhjIMpoioXC
         hSSw==
X-Gm-Message-State: AJIora96MPoDp0b2uaMgC7B/N3LsA8DXXbdB8Qmk0adEdFOTT6/w9bU8
        P++bpLqsy7zaxKZ+kfZZJc4=
X-Google-Smtp-Source: AGRyM1tcJ8LvhNY1blwZS1ll3lYp4SL+tU513CYHvlgfsd43chQOMW2DATB/G8tJYHwwoaYncOvzfw==
X-Received: by 2002:a63:1607:0:b0:412:8fc0:756b with SMTP id w7-20020a631607000000b004128fc0756bmr20201203pgl.142.1657633209739;
        Tue, 12 Jul 2022 06:40:09 -0700 (PDT)
Received: from ip-172-31-24-42.ap-northeast-1.compute.internal (ec2-35-75-15-180.ap-northeast-1.compute.amazonaws.com. [35.75.15.180])
        by smtp.gmail.com with ESMTPSA id r6-20020aa79886000000b0052ae3bcb807sm1947178pfl.188.2022.07.12.06.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 06:40:09 -0700 (PDT)
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
Subject: [PATCH v3 05/15] mm/sl[au]b: factor out __do_kmalloc_node()
Date:   Tue, 12 Jul 2022 13:39:35 +0000
Message-Id: <20220712133946.307181-6-42.hyeyoo@gmail.com>
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

__kmalloc(), __kmalloc_node(), __kmalloc_node_track_caller()
mostly do same job. Factor out common code into __do_kmalloc_node().

Note that this patch also fixes missing kasan_kmalloc() in SLUB's
__kmalloc_node_track_caller().

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/slab.c | 30 +----------------------
 mm/slub.c | 71 +++++++++++++++----------------------------------------
 2 files changed, 20 insertions(+), 81 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index da2f6a5dd8fa..ab34727d61b2 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3631,37 +3631,9 @@ void __kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
 }
 #endif
 
-/**
- * __do_kmalloc - allocate memory
- * @size: how many bytes of memory are required.
- * @flags: the type of memory to allocate (see kmalloc).
- * @caller: function caller for debug tracking of the caller
- *
- * Return: pointer to the allocated memory or %NULL in case of error
- */
-static __always_inline void *__do_kmalloc(size_t size, gfp_t flags,
-					  unsigned long caller)
-{
-	struct kmem_cache *cachep;
-	void *ret;
-
-	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
-		return NULL;
-	cachep = kmalloc_slab(size, flags);
-	if (unlikely(ZERO_OR_NULL_PTR(cachep)))
-		return cachep;
-	ret = slab_alloc(cachep, NULL, flags, size, caller);
-
-	ret = kasan_kmalloc(cachep, ret, size, flags);
-	trace_kmalloc(caller, ret, cachep,
-		      size, cachep->size, flags);
-
-	return ret;
-}
-
 void *__kmalloc(size_t size, gfp_t flags)
 {
-	return __do_kmalloc(size, flags, _RET_IP_);
+	return __do_kmalloc_node(size, flags, NUMA_NO_NODE, _RET_IP_);
 }
 EXPORT_SYMBOL(__kmalloc);
 
diff --git a/mm/slub.c b/mm/slub.c
index 7c284535a62b..2ccc473e0ae7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4402,29 +4402,6 @@ static int __init setup_slub_min_objects(char *str)
 
 __setup("slub_min_objects=", setup_slub_min_objects);
 
-void *__kmalloc(size_t size, gfp_t flags)
-{
-	struct kmem_cache *s;
-	void *ret;
-
-	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
-		return kmalloc_large(size, flags);
-
-	s = kmalloc_slab(size, flags);
-
-	if (unlikely(ZERO_OR_NULL_PTR(s)))
-		return s;
-
-	ret = slab_alloc(s, NULL, flags, _RET_IP_, size);
-
-	trace_kmalloc(_RET_IP_, ret, s, size, s->size, flags);
-
-	ret = kasan_kmalloc(s, ret, size, flags);
-
-	return ret;
-}
-EXPORT_SYMBOL(__kmalloc);
-
 static void *kmalloc_large_node(size_t size, gfp_t flags, int node)
 {
 	struct page *page;
@@ -4442,7 +4419,8 @@ static void *kmalloc_large_node(size_t size, gfp_t flags, int node)
 	return kmalloc_large_node_hook(ptr, size, flags);
 }
 
-void *__kmalloc_node(size_t size, gfp_t flags, int node)
+static __always_inline
+void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
 {
 	struct kmem_cache *s;
 	void *ret;
@@ -4450,7 +4428,7 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node)
 	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
 		ret = kmalloc_large_node(size, flags, node);
 
-		trace_kmalloc_node(_RET_IP_, ret, NULL,
+		trace_kmalloc_node(caller, ret, NULL,
 				   size, PAGE_SIZE << get_order(size),
 				   flags, node);
 
@@ -4462,16 +4440,28 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node)
 	if (unlikely(ZERO_OR_NULL_PTR(s)))
 		return s;
 
-	ret = slab_alloc_node(s, NULL, flags, node, _RET_IP_, size);
+	ret = slab_alloc_node(s, NULL, flags, node, caller, size);
 
-	trace_kmalloc_node(_RET_IP_, ret, s, size, s->size, flags, node);
+	trace_kmalloc_node(caller, ret, s, size, s->size, flags, node);
 
 	ret = kasan_kmalloc(s, ret, size, flags);
 
 	return ret;
 }
+
+void *__kmalloc_node(size_t size, gfp_t flags, int node)
+{
+	return __do_kmalloc_node(size, flags, node, _RET_IP_);
+}
 EXPORT_SYMBOL(__kmalloc_node);
 
+void *__kmalloc(size_t size, gfp_t flags)
+{
+	return __do_kmalloc_node(size, flags, NUMA_NO_NODE, _RET_IP_);
+}
+EXPORT_SYMBOL(__kmalloc);
+
+
 #ifdef CONFIG_HARDENED_USERCOPY
 /*
  * Rejects incorrectly sized objects and objects that are to be copied
@@ -4905,32 +4895,9 @@ int __kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
 }
 
 void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
-					int node, unsigned long caller)
+				  int node, unsigned long caller)
 {
-	struct kmem_cache *s;
-	void *ret;
-
-	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
-		ret = kmalloc_large_node(size, gfpflags, node);
-
-		trace_kmalloc_node(caller, ret, NULL,
-				   size, PAGE_SIZE << get_order(size),
-				   gfpflags, node);
-
-		return ret;
-	}
-
-	s = kmalloc_slab(size, gfpflags);
-
-	if (unlikely(ZERO_OR_NULL_PTR(s)))
-		return s;
-
-	ret = slab_alloc_node(s, NULL, gfpflags, node, caller, size);
-
-	/* Honor the call site pointer we received. */
-	trace_kmalloc_node(caller, ret, s, size, s->size, gfpflags, node);
-
-	return ret;
+	return __do_kmalloc_node(size, gfpflags, node, caller);
 }
 EXPORT_SYMBOL(__kmalloc_node_track_caller);
 
-- 
2.34.1


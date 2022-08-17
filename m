Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FAE596CB9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 12:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238929AbiHQKTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 06:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238846AbiHQKTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:19:05 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A9B52FE9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:19:05 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id r15-20020a17090a1bcf00b001fabf42a11cso91372pjr.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Mkyu1siQR2SpurMp6n+bbzTxyYWe6qfMz+gCu1SCQOw=;
        b=X2p/rtQnRcbuMgMv2/g/yUiUfAVdUulEF3feqNKVrhUZdVHitdHgnz7ivcfoIx3igS
         9Z7pzrer2u1uWO9TpTToV0JMowwrebRH/hn+zxBes/WTZLmiFHlUGg7OV0x5mQF4pjhB
         iS/yUR/5G8ydpytcdtAmTFV+6le+Id6p15CCQLrcCZWXGI3QhrohoOLenisPn6QjWiGy
         JzoqVv0xOpVNZBCBu0TEVHqg1wrUi1Oik2yLS5IoO0sHdi9QJXDhyqQtgZRsySjh/8K9
         9Q4DS66jOw0tidDJfbl5N9ohtrw9R9K/zkSMZ1hFq3Br1VS0pgECuG97fzQC//gJ1w4s
         qyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Mkyu1siQR2SpurMp6n+bbzTxyYWe6qfMz+gCu1SCQOw=;
        b=GKZCrz0oEPx/kgpGLM9OPODa7xZuKgVIp17I1GqSJEW7zsHt8FOe0r7ScvBjK17CJc
         osifOme6x6yhGQIWR9lrsQFDY2dK7qZps6Out7MWPSI+NIW+7HqcTRrDzux5wicUvVti
         NKGCb0ddYwpqxb3uwaaccmLbgSM2AJd1L3NtXbwcgZMp7G31VfHFfUdhsE0XnOfHVxEK
         /hYdu9u3j1eE+jKP/FMS5ZAIXmVbPv1/C6SgFSn+KtTj6PPbE4JLi5pPRQ6JVso9h++r
         14q3KRdw1hIYc98wwZPlRCSoxjAf7Ts0ApDzksvMadDIfK2MUvMAPugEIN8xNJ3p7Rn8
         dv6g==
X-Gm-Message-State: ACgBeo1nyYint0YXn3nkZsVADEc1Bic0LVulgbQ7jXiUur8scPxxF1xu
        +zTH694Qday0GUBIM+4eQZo=
X-Google-Smtp-Source: AA6agR6pvX9vtBet0UY+NHp3e4BoO2UXGfR8fh/YGIkfc65JKCmnJtMLBxUCK0a3mVeWGiCp0plydA==
X-Received: by 2002:a17:902:7883:b0:170:d646:7f00 with SMTP id q3-20020a170902788300b00170d6467f00mr25919187pll.164.1660731544517;
        Wed, 17 Aug 2022 03:19:04 -0700 (PDT)
Received: from hyeyoo.. ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id d8-20020a170903230800b00172633fc236sm1071318plh.174.2022.08.17.03.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 03:19:03 -0700 (PDT)
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
Subject: [PATCH v4 05/17] mm/sl[au]b: factor out __do_kmalloc_node()
Date:   Wed, 17 Aug 2022 19:18:14 +0900
Message-Id: <20220817101826.236819-6-42.hyeyoo@gmail.com>
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

__kmalloc(), __kmalloc_node(), __kmalloc_node_track_caller()
mostly do same job. Factor out common code into __do_kmalloc_node().

Note that this patch also fixes missing kasan_kmalloc() in SLUB's
__kmalloc_node_track_caller().

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab.c | 30 +----------------------
 mm/slub.c | 71 +++++++++++++++----------------------------------------
 2 files changed, 20 insertions(+), 81 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 611e630ff860..8c08d7f3dead 100644
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
index c82a4062f730..f9929ba858ec 100644
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
2.32.0


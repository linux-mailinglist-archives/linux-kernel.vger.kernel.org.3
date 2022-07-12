Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D00B571B7A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbiGLNkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbiGLNkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:40:03 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75E5B79F9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:40:00 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id q5-20020a17090a304500b001efcc885cc4so8009369pjl.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r/sC4QUhXRkGGh2bMZjIx8vUi/+M03CaD7v75Vc4qIM=;
        b=Q4gF1YgEyhsTFkNHPaBVgVWmoB1UycH55o77nMikgwe0GbIhxDa72n1fUGC5vQe/QD
         Il9OHSXdBMCafC0e5otobL4t+Nwc7Cep5xa5y7tGgixwBwz0A4fO9F37XXfglBp11Pyt
         7YhwCUoQcUh3fao2+JVDsNZrMz3SuZvF6CFZCenkPXSvDumwz/NLcRaOdC9dPGrHXm6M
         PTTMEWYUBKk4lYq3dYSSRqLl+xRm9yvnUq8luiT8pqvwQt4Dgm+DxmXKjFJL5bJVGwPy
         1Cp6APIWKaZgmAcOs58RclTepUEjVTJJoQjwsoApSvNuDBHiGGsvuR0S6i12eiblMIDB
         s8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r/sC4QUhXRkGGh2bMZjIx8vUi/+M03CaD7v75Vc4qIM=;
        b=xB/+ST/XGMxaf/x3ctHswoz9odRZLmeOYDXCUvUKDsWY9EdKUApT4EEpQwukDM5QIm
         daNkUYM6iDFZEiF4VnvAwx6tSFRrwFVFgxh+T0fiwrZqGlN8V8zoL2r8QqFBEOy3eiG5
         fsg2KenGGdbrgnGF4DDaB+YuSQHRb+pyvYidMb5cIrm+88txQSTSg+Dos94bkWqk7DKQ
         hRTnoZFlr1YwQO/74EEN7ec87SJjQ8fh4zdSuR3YCbRx9kyD5yUfnEbQNY9HXKkMz25X
         8SpAgJtbIY5oXavUhQhg2eokLqyf+SAwDACoZJ8XDoU4pU2eZZGLYtpoRuFCVft8A4a1
         cJXQ==
X-Gm-Message-State: AJIora+0iqn9T3BdKm8YaQqQB/S4I5uBQ2NQYerhfQxTJQ31WmpqrVAl
        gPI+8ODPwyKZQzVgfBOfBOU=
X-Google-Smtp-Source: AGRyM1vJg6rHv6f9xZ16nqyAOzl+pygP2/nWo+HF7ZxNCw7rYTwZRTp22u80Y8t30cgdcqSc0Zg+3A==
X-Received: by 2002:a17:90b:4f4a:b0:1f0:65d:d888 with SMTP id pj10-20020a17090b4f4a00b001f0065dd888mr4576679pjb.136.1657633199556;
        Tue, 12 Jul 2022 06:39:59 -0700 (PDT)
Received: from ip-172-31-24-42.ap-northeast-1.compute.internal (ec2-35-75-15-180.ap-northeast-1.compute.amazonaws.com. [35.75.15.180])
        by smtp.gmail.com with ESMTPSA id r6-20020aa79886000000b0052ae3bcb807sm1947178pfl.188.2022.07.12.06.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 06:39:58 -0700 (PDT)
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
Subject: [PATCH v3 2/15] mm/slab: cleanup slab_alloc() and slab_alloc_node()
Date:   Tue, 12 Jul 2022 13:39:32 +0000
Message-Id: <20220712133946.307181-3-42.hyeyoo@gmail.com>
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

Make slab_alloc_node() available even when CONFIG_NUMA=n and
make slab_alloc() wrapper of slab_alloc_node().

This is necessary for further cleanup.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab.c | 50 +++++++++++++-------------------------------------
 1 file changed, 13 insertions(+), 37 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 3d83d17ff3b3..5bcd2b62b5a2 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3186,38 +3186,6 @@ static void *____cache_alloc_node(struct kmem_cache *cachep, gfp_t flags,
 	return obj ? obj : fallback_alloc(cachep, flags);
 }
 
-static void *__do_cache_alloc(struct kmem_cache *cachep, gfp_t flags, int nodeid);
-
-static __always_inline void *
-slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid, size_t orig_size,
-		   unsigned long caller)
-{
-	unsigned long save_flags;
-	void *ptr;
-	struct obj_cgroup *objcg = NULL;
-	bool init = false;
-
-	flags &= gfp_allowed_mask;
-	cachep = slab_pre_alloc_hook(cachep, NULL, &objcg, 1, flags);
-	if (unlikely(!cachep))
-		return NULL;
-
-	ptr = kfence_alloc(cachep, orig_size, flags);
-	if (unlikely(ptr))
-		goto out_hooks;
-
-	cache_alloc_debugcheck_before(cachep, flags);
-	local_irq_save(save_flags);
-	ptr = __do_cache_alloc(cachep, flags, nodeid);
-	local_irq_restore(save_flags);
-	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr, caller);
-	init = slab_want_init_on_alloc(flags, cachep);
-
-out_hooks:
-	slab_post_alloc_hook(cachep, objcg, flags, 1, &ptr, init);
-	return ptr;
-}
-
 static __always_inline void *
 __do_cache_alloc(struct kmem_cache *cachep, gfp_t flags, int nodeid)
 {
@@ -3266,8 +3234,8 @@ __do_cache_alloc(struct kmem_cache *cachep, gfp_t flags, int nodeid __maybe_unus
 #endif /* CONFIG_NUMA */
 
 static __always_inline void *
-slab_alloc(struct kmem_cache *cachep, struct list_lru *lru, gfp_t flags,
-	   size_t orig_size, unsigned long caller)
+slab_alloc_node(struct kmem_cache *cachep, struct list_lru *lru, gfp_t flags,
+		int nodeid, size_t orig_size, unsigned long caller)
 {
 	unsigned long save_flags;
 	void *objp;
@@ -3285,7 +3253,7 @@ slab_alloc(struct kmem_cache *cachep, struct list_lru *lru, gfp_t flags,
 
 	cache_alloc_debugcheck_before(cachep, flags);
 	local_irq_save(save_flags);
-	objp = __do_cache_alloc(cachep, flags, NUMA_NO_NODE);
+	objp = __do_cache_alloc(cachep, flags, nodeid);
 	local_irq_restore(save_flags);
 	objp = cache_alloc_debugcheck_after(cachep, flags, objp, caller);
 	prefetchw(objp);
@@ -3296,6 +3264,14 @@ slab_alloc(struct kmem_cache *cachep, struct list_lru *lru, gfp_t flags,
 	return objp;
 }
 
+static __always_inline void *
+slab_alloc(struct kmem_cache *cachep, struct list_lru *lru, gfp_t flags,
+	   size_t orig_size, unsigned long caller)
+{
+	return slab_alloc_node(cachep, lru, flags, NUMA_NO_NODE, orig_size,
+			       caller);
+}
+
 /*
  * Caller needs to acquire correct kmem_cache_node's list_lock
  * @list: List of detached free slabs should be freed by caller
@@ -3584,7 +3560,7 @@ EXPORT_SYMBOL(kmem_cache_alloc_trace);
  */
 void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)
 {
-	void *ret = slab_alloc_node(cachep, flags, nodeid, cachep->object_size, _RET_IP_);
+	void *ret = slab_alloc_node(cachep, NULL, flags, nodeid, cachep->object_size, _RET_IP_);
 
 	trace_kmem_cache_alloc_node(_RET_IP_, ret, cachep,
 				    cachep->object_size, cachep->size,
@@ -3602,7 +3578,7 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
 {
 	void *ret;
 
-	ret = slab_alloc_node(cachep, flags, nodeid, size, _RET_IP_);
+	ret = slab_alloc_node(cachep, NULL, flags, nodeid, size, _RET_IP_);
 
 	ret = kasan_kmalloc(cachep, ret, size, flags);
 	trace_kmalloc_node(_RET_IP_, ret, cachep,
-- 
2.34.1


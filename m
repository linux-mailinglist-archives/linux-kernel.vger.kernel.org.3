Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71325596CB5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 12:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237422AbiHQKS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 06:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234670AbiHQKSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:18:55 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB57B5FF52
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:18:53 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id s36-20020a17090a69a700b001faad0a7a34so1387331pjj.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=3U+8LTY1y1RiFgIZBWF6u26rllF04yVkQZAKSsbfV88=;
        b=o+eLIVEt1kKstQYEPuqhNvCnf19Ci8D4sguN4nwyRDg+FIafrV/2wNuYCQ2hFw3zGm
         S6N7ygUZ8Y3rRkuN6woRRJ+Quhna5GnJ2uHgH0Q9rBOQfQqNAV7WITAIQeyeoNrsvKml
         Jpb+Vrz1P+0ZDV94y7bs9t7AvX0CKI1ML3eaeNBRxGzAeTOEKamIM5xHaBoRzs5/Ezfr
         VwBcXDv+0j2RdEMV+SS/24NpVShba96jr/Gh84kADiL2bA2natEjWxx0V3htEPQJU204
         MYfnMt26N2c4+oh7JQl/ePMkQ/TZMX9uSZxy7tqjfgkNazF5/K7U2pMO1gQc9rOg7+Yg
         uK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3U+8LTY1y1RiFgIZBWF6u26rllF04yVkQZAKSsbfV88=;
        b=DU7O1G5UQKEk0U8bezNjIlPoN12+sa7ZI6C2uiajc20sBYsU62qr1GAvgLlO+iCyRV
         n5Bs/PKh68qMMULd0FMwX4xAyeKMKk/bZlmyN0FMo+oRc64RYS3LNkSiVaQVUWljIhgT
         bYGtkQ3GuqVczne/iLMIP0aD1UdDr0Lt8gIQVBQOGfd81b6/e/jA1gWsgbG+w9klY6zA
         07NWzEhuBP2RrKAE4C03Hw58pkQucLBf/0zSnQXG5CUsGZAI+SkvsQII9o+cvXWRyzAA
         a0ePSerNL21iSI4AvTRttb4jxr9kIqwtFxZ+aMYka1zaWDbdS/J2SWB8T2Zvfj/dLGP1
         idjg==
X-Gm-Message-State: ACgBeo1F576c91B6b/PI6DVcVcTfgkO/+7h8IoVUBbxF2cAeZV0ap5Aa
        Ilefvml5KHzvjvhmHn3GI9g=
X-Google-Smtp-Source: AA6agR5y8J8WikcfzF1i0kGroiRKnzVfSzPJ1UB2rSumOIO5ossoFYJ0lYdU+nkXvjiUEBedYMvovg==
X-Received: by 2002:a17:902:d2c6:b0:16e:d285:c602 with SMTP id n6-20020a170902d2c600b0016ed285c602mr25604783plc.81.1660731533224;
        Wed, 17 Aug 2022 03:18:53 -0700 (PDT)
Received: from hyeyoo.. ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id d8-20020a170903230800b00172633fc236sm1071318plh.174.2022.08.17.03.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 03:18:52 -0700 (PDT)
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
Subject: [PATCH v4 02/17] mm/slab: cleanup slab_alloc() and slab_alloc_node()
Date:   Wed, 17 Aug 2022 19:18:11 +0900
Message-Id: <20220817101826.236819-3-42.hyeyoo@gmail.com>
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

Make slab_alloc_node() available even when CONFIG_NUMA=n and
make slab_alloc() wrapper of slab_alloc_node().

This is necessary for further cleanup.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab.c | 49 +++++++++++++------------------------------------
 1 file changed, 13 insertions(+), 36 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 1656393f55cb..748dd085f38e 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3180,37 +3180,6 @@ static void *____cache_alloc_node(struct kmem_cache *cachep, gfp_t flags,
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
@@ -3259,8 +3228,8 @@ __do_cache_alloc(struct kmem_cache *cachep, gfp_t flags, int nodeid __maybe_unus
 #endif /* CONFIG_NUMA */
 
 static __always_inline void *
-slab_alloc(struct kmem_cache *cachep, struct list_lru *lru, gfp_t flags,
-	   size_t orig_size, unsigned long caller)
+slab_alloc_node(struct kmem_cache *cachep, struct list_lru *lru, gfp_t flags,
+		int nodeid, size_t orig_size, unsigned long caller)
 {
 	unsigned long save_flags;
 	void *objp;
@@ -3277,7 +3246,7 @@ slab_alloc(struct kmem_cache *cachep, struct list_lru *lru, gfp_t flags,
 		goto out;
 
 	local_irq_save(save_flags);
-	objp = __do_cache_alloc(cachep, flags, NUMA_NO_NODE);
+	objp = __do_cache_alloc(cachep, flags, nodeid);
 	local_irq_restore(save_flags);
 	objp = cache_alloc_debugcheck_after(cachep, flags, objp, caller);
 	prefetchw(objp);
@@ -3288,6 +3257,14 @@ slab_alloc(struct kmem_cache *cachep, struct list_lru *lru, gfp_t flags,
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
@@ -3574,7 +3551,7 @@ EXPORT_SYMBOL(kmem_cache_alloc_trace);
  */
 void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)
 {
-	void *ret = slab_alloc_node(cachep, flags, nodeid, cachep->object_size, _RET_IP_);
+	void *ret = slab_alloc_node(cachep, NULL, flags, nodeid, cachep->object_size, _RET_IP_);
 
 	trace_kmem_cache_alloc_node(_RET_IP_, ret, cachep,
 				    cachep->object_size, cachep->size,
@@ -3592,7 +3569,7 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
 {
 	void *ret;
 
-	ret = slab_alloc_node(cachep, flags, nodeid, size, _RET_IP_);
+	ret = slab_alloc_node(cachep, NULL, flags, nodeid, size, _RET_IP_);
 
 	ret = kasan_kmalloc(cachep, ret, size, flags);
 	trace_kmalloc_node(_RET_IP_, ret, cachep,
-- 
2.32.0


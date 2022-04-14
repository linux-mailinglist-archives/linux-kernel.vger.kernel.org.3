Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F2750090E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241328AbiDNJAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241323AbiDNJAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:00:09 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0026A69CDD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:57:44 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id t12so4116898pll.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BH7DV9U/vu2jtDErAITdUqLyoGxX/jkJAwwizEZv+Js=;
        b=JJCBD1YAeoPMhuIjVfylzRv0NxsFdBPMH+kZzmPcRUHMX5TQEv+wea9a8orZanf8p/
         iQBR9sZAT+j7gUSeUw5x+S3c7HxDHcxVHwjYCdK64Ubqco6qU/RZDbVHtMfKFNqWUVmP
         O3nytkKNxVblG0o8Nm0u+CZV0R5UyGqV/FOYrYzfKFjL4Bnc7sOFMZdfj6D4b2M0/r+b
         TqmA3PW8ykLEUpurPiQU+4bjY8J77+tYoh5W+qyYIXtfWC3/zHTrhaDEEx0IXBPcZFgh
         jzHWoU+t+KbP9vrRpNLtvi96RB8dbsJo5Oj8NiPQCGf25lX0J3QbY8w05i/odEi4GOc7
         WqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BH7DV9U/vu2jtDErAITdUqLyoGxX/jkJAwwizEZv+Js=;
        b=fbBwlsokueLCavIJtm3hGTL8LIC/1AJPr+UH0KywpWQ0357Poed3zEGpaFyaXMxbrF
         ZnPruaOw2hyAvEYaYqIG+fsWE/on7cK/0F2OKV5218TkZiU856LVudp4p9KPA7i3qgVI
         JlTqTGzQwG8Penmc+eSrDbthLTf7FGrUwGJLMP3n5mhItBYkEURxPOEP2TFi24BCIrZR
         Ov9qnprOEQPoxFIwNT992TdzlxNShXwykZOKh3Bew+BuKln8hk56sP7h7m9kcJHsk+MH
         95h6JwsEq0j5huxx6hqXMj1YFD0ed8iMK+fVk7xZjCUbZ/D/PvtqE/01z/wP2AJw/UuE
         1Nfg==
X-Gm-Message-State: AOAM531Syx8aVTofd5gBZJiKtY3ypbA5VozBKSXJdYPtM9beiFwkSkUi
        uKfxEdLYdkYcyQzxwTyZmBI=
X-Google-Smtp-Source: ABdhPJxsUXct5U3lD2WN+lLx+SB2iXDsebklAp6DajrSrorvr3K71YGlQGb2/NbFbsSvuQLhCUWLBg==
X-Received: by 2002:a17:90a:e7d2:b0:1c7:b410:ccfc with SMTP id kb18-20020a17090ae7d200b001c7b410ccfcmr2567374pjb.209.1649926664449;
        Thu, 14 Apr 2022 01:57:44 -0700 (PDT)
Received: from hyeyoo.. ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id p9-20020aa79e89000000b00505fada20dfsm1403537pfq.117.2022.04.14.01.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:57:42 -0700 (PDT)
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
Subject: [PATCH v2 01/23] mm/slab: move NUMA-related code to __do_cache_alloc()
Date:   Thu, 14 Apr 2022 17:57:05 +0900
Message-Id: <20220414085727.643099-2-42.hyeyoo@gmail.com>
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

To implement slab_alloc_node() independent of NUMA configuration,
move NUMA fallback/alternate allocation code into __do_cache_alloc().

One functional change here is not to check availability of node
when allocating from local node.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
Changes from v1:
- Undo removing path to alternate_node_alloc code when node id is not specified (which
  was mistake.)

 mm/slab.c | 68 +++++++++++++++++++++++++------------------------------
 1 file changed, 31 insertions(+), 37 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index e882657c1494..d854c24d5f5a 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3187,13 +3187,14 @@ static void *____cache_alloc_node(struct kmem_cache *cachep, gfp_t flags,
 	return obj ? obj : fallback_alloc(cachep, flags);
 }
 
+static void *__do_cache_alloc(struct kmem_cache *cachep, gfp_t flags, int nodeid);
+
 static __always_inline void *
 slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid, size_t orig_size,
 		   unsigned long caller)
 {
 	unsigned long save_flags;
 	void *ptr;
-	int slab_node = numa_mem_id();
 	struct obj_cgroup *objcg = NULL;
 	bool init = false;
 
@@ -3208,30 +3209,7 @@ slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid, size_t orig_
 
 	cache_alloc_debugcheck_before(cachep, flags);
 	local_irq_save(save_flags);
-
-	if (nodeid == NUMA_NO_NODE)
-		nodeid = slab_node;
-
-	if (unlikely(!get_node(cachep, nodeid))) {
-		/* Node not bootstrapped yet */
-		ptr = fallback_alloc(cachep, flags);
-		goto out;
-	}
-
-	if (nodeid == slab_node) {
-		/*
-		 * Use the locally cached objects if possible.
-		 * However ____cache_alloc does not allow fallback
-		 * to other nodes. It may fail while we still have
-		 * objects on other nodes available.
-		 */
-		ptr = ____cache_alloc(cachep, flags);
-		if (ptr)
-			goto out;
-	}
-	/* ___cache_alloc_node can fall back to other nodes */
-	ptr = ____cache_alloc_node(cachep, flags, nodeid);
-  out:
+	ptr = __do_cache_alloc(cachep, flags, nodeid);
 	local_irq_restore(save_flags);
 	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr, caller);
 	init = slab_want_init_on_alloc(flags, cachep);
@@ -3242,31 +3220,46 @@ slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid, size_t orig_
 }
 
 static __always_inline void *
-__do_cache_alloc(struct kmem_cache *cache, gfp_t flags)
+__do_cache_alloc(struct kmem_cache *cachep, gfp_t flags, int nodeid)
 {
 	void *objp;
+	int slab_node = numa_mem_id();
 
-	if (current->mempolicy || cpuset_do_slab_mem_spread()) {
-		objp = alternate_node_alloc(cache, flags);
-		if (objp)
-			goto out;
+	if (nodeid == NUMA_NO_NODE) {
+		if (current->mempolicy || cpuset_do_slab_mem_spread()) {
+			objp = alternate_node_alloc(cachep, flags);
+			if (objp)
+				goto out;
+		}
+		/*
+		 * Use the locally cached objects if possible.
+		 * However ____cache_alloc does not allow fallback
+		 * to other nodes. It may fail while we still have
+		 * objects on other nodes available.
+		 */
+		objp = ____cache_alloc(cachep, flags);
+		nodeid = slab_node;
+	} else if (nodeid == slab_node) {
+		objp = ____cache_alloc(cachep, flags);
+	} else if (!get_node(cachep, nodeid)) {
+		/* Node not bootstrapped yet */
+		objp = fallback_alloc(cachep, flags);
+		goto out;
 	}
-	objp = ____cache_alloc(cache, flags);
 
 	/*
 	 * We may just have run out of memory on the local node.
 	 * ____cache_alloc_node() knows how to locate memory on other nodes
 	 */
 	if (!objp)
-		objp = ____cache_alloc_node(cache, flags, numa_mem_id());
-
-  out:
+		objp = ____cache_alloc_node(cachep, flags, nodeid);
+out:
 	return objp;
 }
 #else
 
 static __always_inline void *
-__do_cache_alloc(struct kmem_cache *cachep, gfp_t flags)
+__do_cache_alloc(struct kmem_cache *cachep, gfp_t flags, int nodeid __maybe_unused)
 {
 	return ____cache_alloc(cachep, flags);
 }
@@ -3293,7 +3286,7 @@ slab_alloc(struct kmem_cache *cachep, struct list_lru *lru, gfp_t flags,
 
 	cache_alloc_debugcheck_before(cachep, flags);
 	local_irq_save(save_flags);
-	objp = __do_cache_alloc(cachep, flags);
+	objp = __do_cache_alloc(cachep, flags, NUMA_NO_NODE);
 	local_irq_restore(save_flags);
 	objp = cache_alloc_debugcheck_after(cachep, flags, objp, caller);
 	prefetchw(objp);
@@ -3532,7 +3525,8 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 
 	local_irq_disable();
 	for (i = 0; i < size; i++) {
-		void *objp = kfence_alloc(s, s->object_size, flags) ?: __do_cache_alloc(s, flags);
+		void *objp = kfence_alloc(s, s->object_size, flags) ?:
+			     __do_cache_alloc(s, flags, NUMA_NO_NODE);
 
 		if (unlikely(!objp))
 			goto error;
-- 
2.32.0


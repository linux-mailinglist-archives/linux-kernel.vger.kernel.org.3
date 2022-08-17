Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41317596CB1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 12:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbiHQKSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 06:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbiHQKSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:18:50 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED51152E70
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:18:49 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id w14so11619133plp.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=YF+ekAMEny9NvsTn9a4lw7RA5UzOw69huq16Y0TTu/E=;
        b=UfKWZydc6cWoE65QiAxGGqIjSiAtD0FTW2ouaiH24BCMLqRxnKci1GLgS3gQ0c38ek
         h0RdQwvcWm8nSdGolt0rJF9eWWHjgf55b7AQqnT8MrSz7KCgCBMK18+jtkbyltSBiYT7
         GeQFS07ovAMivSBIlqQUviSC17HCZxz/u98IdnOkiuGW0dsKh6bqUINMIoYBWrTEU/FL
         E8jRoYD9dG4GB74/3ZIBuyUptfi6z7J/NpbxwzIrwwqUmrRO4wLe8XtVhJ48Sxvv92XM
         aYiFRioz4iekqq1KWjYcFnBXtIVDWLY53Ua9PQmCFRHAhGcsl5HcgVlOCk64KtGLNm1j
         XqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=YF+ekAMEny9NvsTn9a4lw7RA5UzOw69huq16Y0TTu/E=;
        b=f7lHz4jraXKUUcSsMSd8FWvgjWOI19FpWLWw8yPmpC8thHCdLLUXPqsMeEdHaLecTn
         NP2UkbLD4vBxIOuDMsQ/aoaG7GmF6LqBuJ5AQ2lD3CipzXUHDYuEk5RxgBhG0VVoIIT2
         gJZ13iJvsvEsawodefinTUdfqEa/g5xKYaghqz4LAKu6NvPY9474tQZ7SVCVDVjUepTV
         gS45HjaK3BZV1ZV9w11UYxcDOeNc3IH/khszzql/I/gQNX1kMcO5+gNA1M/3sj39+s8R
         X3qOJNXd0g8gJfUcgaO/xz4w1YfnC7gjJ3kKe8CplGdU1HZZtppSDuOJm8lTuUzwRdzb
         zYBg==
X-Gm-Message-State: ACgBeo37+/j7XBVgD+kaAyopEbcaLAp7tI1lvUS/igOUPqMVcgzibZnP
        +lItMASjzPi/tmWz2546SIc=
X-Google-Smtp-Source: AA6agR54kAAuhdp73DFDVedKK36Zsc3Hl4XZr1ca5vnebvrjU6WllrJ9ITzm7kSiuXYJqzEV6/nhpQ==
X-Received: by 2002:a17:902:bd41:b0:172:74c9:2a08 with SMTP id b1-20020a170902bd4100b0017274c92a08mr10779640plx.9.1660731529461;
        Wed, 17 Aug 2022 03:18:49 -0700 (PDT)
Received: from hyeyoo.. ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id d8-20020a170903230800b00172633fc236sm1071318plh.174.2022.08.17.03.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 03:18:48 -0700 (PDT)
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
Subject: [PATCH v4 01/17] mm/slab: move NUMA-related code to __do_cache_alloc()
Date:   Wed, 17 Aug 2022 19:18:10 +0900
Message-Id: <20220817101826.236819-2-42.hyeyoo@gmail.com>
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

To implement slab_alloc_node() independent of NUMA configuration,
move NUMA fallback/alternate allocation code into __do_cache_alloc().

One functional change here is not to check availability of node
when allocating from local node.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab.c | 68 +++++++++++++++++++++++++------------------------------
 1 file changed, 31 insertions(+), 37 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 10e96137b44f..1656393f55cb 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3180,13 +3180,14 @@ static void *____cache_alloc_node(struct kmem_cache *cachep, gfp_t flags,
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
 
@@ -3200,30 +3201,7 @@ slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid, size_t orig_
 		goto out_hooks;
 
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
-out:
+	ptr = __do_cache_alloc(cachep, flags, nodeid);
 	local_irq_restore(save_flags);
 	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr, caller);
 	init = slab_want_init_on_alloc(flags, cachep);
@@ -3234,31 +3212,46 @@ slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid, size_t orig_
 }
 
 static __always_inline void *
-__do_cache_alloc(struct kmem_cache *cache, gfp_t flags)
+__do_cache_alloc(struct kmem_cache *cachep, gfp_t flags, int nodeid)
 {
-	void *objp;
+	void *objp = NULL;
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
+		objp = ____cache_alloc_node(cachep, flags, nodeid);
 out:
 	return objp;
 }
 #else
 
 static __always_inline void *
-__do_cache_alloc(struct kmem_cache *cachep, gfp_t flags)
+__do_cache_alloc(struct kmem_cache *cachep, gfp_t flags, int nodeid __maybe_unused)
 {
 	return ____cache_alloc(cachep, flags);
 }
@@ -3284,7 +3277,7 @@ slab_alloc(struct kmem_cache *cachep, struct list_lru *lru, gfp_t flags,
 		goto out;
 
 	local_irq_save(save_flags);
-	objp = __do_cache_alloc(cachep, flags);
+	objp = __do_cache_alloc(cachep, flags, NUMA_NO_NODE);
 	local_irq_restore(save_flags);
 	objp = cache_alloc_debugcheck_after(cachep, flags, objp, caller);
 	prefetchw(objp);
@@ -3521,7 +3514,8 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 
 	local_irq_disable();
 	for (i = 0; i < size; i++) {
-		void *objp = kfence_alloc(s, s->object_size, flags) ?: __do_cache_alloc(s, flags);
+		void *objp = kfence_alloc(s, s->object_size, flags) ?:
+			     __do_cache_alloc(s, flags, NUMA_NO_NODE);
 
 		if (unlikely(!objp))
 			goto error;
-- 
2.32.0


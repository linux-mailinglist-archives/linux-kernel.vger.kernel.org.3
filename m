Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28ABE571B79
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbiGLNkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbiGLNj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:39:57 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4ECCB6D96
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:39:56 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id s21so7625589pjq.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6rRFJ0xVh5ABORNo5ssv3zp+HF72hGoY2m+vDB2j/5A=;
        b=j66iaT+jljhuBXI/FcmS1Ljzo3XHqUsiIheAG10WlV1Ku/9yi7MlhWLmsZuiXwEgSG
         IykzHuntgUkrgpiVpOi1lVYG8PvbQm2BQToVyI2vVE8xX9Z8UA6ZDZItF582+QgVXWgm
         OnStF0hYaRWgwBEJSvVjboluOqwfEyMEly8ggpKj7K1Hlt/7qZ9VUTdoLl3GD6+8WI8g
         SnN8GJg+HJjwXeV5XzOcFNrQzxrhrE7HP38XNHCEnzJ9zYqVXikCDU4bJylBcdFOcUzm
         F/cCcELaJceKC8dJVpfhxXdQzH/5DGuzzRNmlaWF7Ygj/VgQfuAWWuFLlmH2evYtbSgR
         k6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6rRFJ0xVh5ABORNo5ssv3zp+HF72hGoY2m+vDB2j/5A=;
        b=jKG7u7EyjZdKGCMk84NqT+bdfBMooUQ8hmPy5DtU+x77ENMqzvFPeDTnd8RccrWIQN
         AO+9SXMylYNGiFDPo2O1dN23poPbwFY1rHzyQ+rQg0LBczSUDv331WbhCULXVfDLVSq/
         E2V3wsHYnaM1CzbtaKGii4R+DBGke3LU1taDx9mBlE8Zz3Ne7cIZX1zALjWYgmnp7Ikg
         GkAYocoBA6NIQmgOsFpMJ60iX17DX5y160dF6BIADbdeSMLu//DC7YAJnwrIY3PFKVep
         1U7SlTbDG52qQMnqmbvpNDwmFZAWYmjMtbkfuPFM5QMAPRdrv+Jk4fEVMgiHvAv387LE
         8S9g==
X-Gm-Message-State: AJIora+ISXugMS4ZRC6KgxsbLFSe4LdhzSo4F6mKKAdgiitHUsKU5zbY
        jg13kFLd/UQccRn/y9FAswE=
X-Google-Smtp-Source: AGRyM1v1TLiXCxd2XqyR+KXoLhBqLyQ1wHNby5FzNlOmnNN+pMCAzAHTJilkftrp2vgWo3ANSltsKg==
X-Received: by 2002:a17:902:eec2:b0:16b:e389:7efe with SMTP id h2-20020a170902eec200b0016be3897efemr24530998plb.84.1657633196101;
        Tue, 12 Jul 2022 06:39:56 -0700 (PDT)
Received: from ip-172-31-24-42.ap-northeast-1.compute.internal (ec2-35-75-15-180.ap-northeast-1.compute.amazonaws.com. [35.75.15.180])
        by smtp.gmail.com with ESMTPSA id r6-20020aa79886000000b0052ae3bcb807sm1947178pfl.188.2022.07.12.06.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 06:39:55 -0700 (PDT)
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
Subject: [PATCH v3 1/15] mm/slab: move NUMA-related code to __do_cache_alloc()
Date:   Tue, 12 Jul 2022 13:39:31 +0000
Message-Id: <20220712133946.307181-2-42.hyeyoo@gmail.com>
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

To implement slab_alloc_node() independent of NUMA configuration,
move NUMA fallback/alternate allocation code into __do_cache_alloc().

One functional change here is not to check availability of node
when allocating from local node.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---

v3:
	Fixed uninitialized variable bug due to missing
	NULL-initialization of variable objp.

 mm/slab.c | 68 +++++++++++++++++++++++++------------------------------
 1 file changed, 31 insertions(+), 37 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 764cbadba69c..3d83d17ff3b3 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3186,13 +3186,14 @@ static void *____cache_alloc_node(struct kmem_cache *cachep, gfp_t flags,
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
 
@@ -3207,30 +3208,7 @@ slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid, size_t orig_
 
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
-out:
+	ptr = __do_cache_alloc(cachep, flags, nodeid);
 	local_irq_restore(save_flags);
 	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr, caller);
 	init = slab_want_init_on_alloc(flags, cachep);
@@ -3241,31 +3219,46 @@ slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid, size_t orig_
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
@@ -3292,7 +3285,7 @@ slab_alloc(struct kmem_cache *cachep, struct list_lru *lru, gfp_t flags,
 
 	cache_alloc_debugcheck_before(cachep, flags);
 	local_irq_save(save_flags);
-	objp = __do_cache_alloc(cachep, flags);
+	objp = __do_cache_alloc(cachep, flags, NUMA_NO_NODE);
 	local_irq_restore(save_flags);
 	objp = cache_alloc_debugcheck_after(cachep, flags, objp, caller);
 	prefetchw(objp);
@@ -3531,7 +3524,8 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 
 	local_irq_disable();
 	for (i = 0; i < size; i++) {
-		void *objp = kfence_alloc(s, s->object_size, flags) ?: __do_cache_alloc(s, flags);
+		void *objp = kfence_alloc(s, s->object_size, flags) ?:
+			     __do_cache_alloc(s, flags, NUMA_NO_NODE);
 
 		if (unlikely(!objp))
 			goto error;
-- 
2.34.1


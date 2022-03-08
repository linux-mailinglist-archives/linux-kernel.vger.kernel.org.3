Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0C94D166E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346518AbiCHLn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346519AbiCHLnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:43:18 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3933C2E6A6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 03:42:21 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id e13so16837510plh.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 03:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CvChe1Nx5QM82i5sMEtLWw0W8b5zEMFWykl/RZ7HcKk=;
        b=lrQARZIbg6zKFpFazaRiPu+2pB6jdM9vBa23U+KrHIi6moyefe5oBwfnXHbcrMGd1u
         9FCk//aQX0m0rZmdOe2RsuQp3QKMoFuQsOQfhlt3sYQYVrLy2ttEmGIDELJ8eZ41xTx5
         o/4ZOe7LoQjZSZQrTYHmYIhLWLjPsiHDUUXLKsZYnqwsuG4UtHFJleJxm48RmTNzG0KV
         xE3EBjTQOJsguaBxkzu/qfLA408wOR/EGWDgbNx+Z01+A7nLgWpB2KBXpAH6fPvOKD4n
         5rXL5+o/bVWraQjrUz7pNy5csAtWYciNG5NCyVBmnl9K5lu9LK9BdQzd8t1T83QdOvhz
         M/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CvChe1Nx5QM82i5sMEtLWw0W8b5zEMFWykl/RZ7HcKk=;
        b=0+H9PgxZ+dDEsv0y97kkd0ttYmNjCm8ugHdK4bpGerCRL16p4SuxEGMjO3J3BYiiCw
         io8mlairIR71Oa9VKEoAUMxMQ/plEnB2tFqKRJxcN+UxCY0xROvy4J01oUXA0wQlW1K3
         F/b/FANmvLgkQYd3zIbgXo7HznxYdSRMJbdPBWIiknttPxmwgcQlNq9Q7ddiqOIl3kNj
         NEQxHc3Y4REvmBr1vkktw0/Y8lL/ao0ktAh3fLkRKxJotK1tByzONFQnPXIsWbRKm017
         rZOCcLXAMWr2vCm97Ifs6koG2FA72uds6si6GxLLOt9RVf3+28NO+cK8p0p8ayhYjZNi
         E4Tw==
X-Gm-Message-State: AOAM531FEPr52Ago+CcvmiwRPDW1KqLbVzqOUohpnB9lvWf1GahiNUo9
        WGx1z3OEv1OuP392BcGk3hc=
X-Google-Smtp-Source: ABdhPJxSdPT1uqVF9ZNoFsseoMYuGupVSa9y0mdlo7pCI66JTfN53RgQfS/FDGbDBCK8yrS+hUeKoA==
X-Received: by 2002:a17:902:7fc1:b0:151:f80f:494a with SMTP id t1-20020a1709027fc100b00151f80f494amr5769354plb.81.1646739740665;
        Tue, 08 Mar 2022 03:42:20 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090ac40200b001bd0e552d27sm2578285pjt.11.2022.03.08.03.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 03:42:20 -0800 (PST)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     linux-mm@kvack.org
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org, 42.hyeyoo@gmail.com
Subject: [RFC PATCH v1 01/15] mm/slab: cleanup slab_alloc() and slab_alloc_node()
Date:   Tue,  8 Mar 2022 11:41:28 +0000
Message-Id: <20220308114142.1744229-2-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220308114142.1744229-1-42.hyeyoo@gmail.com>
References: <20220308114142.1744229-1-42.hyeyoo@gmail.com>
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

Make slab_alloc_node() available for non-NUMA configurations and make
slab_alloc() wrapper of slab_alloc_node(). This is necessary for further
cleanup.

Do not check availability of node when allocating from locally cached
objects. It's redundant.

This patch was tested on both CONFIG_NUMA=y and n.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/slab.c | 116 +++++++++++++++++++++++-------------------------------
 1 file changed, 50 insertions(+), 66 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index ddf5737c63d9..5d102aaf1629 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3200,60 +3200,6 @@ static void *____cache_alloc_node(struct kmem_cache *cachep, gfp_t flags,
 	return obj ? obj : fallback_alloc(cachep, flags);
 }
 
-static __always_inline void *
-slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid, size_t orig_size,
-		   unsigned long caller)
-{
-	unsigned long save_flags;
-	void *ptr;
-	int slab_node = numa_mem_id();
-	struct obj_cgroup *objcg = NULL;
-	bool init = false;
-
-	flags &= gfp_allowed_mask;
-	cachep = slab_pre_alloc_hook(cachep, &objcg, 1, flags);
-	if (unlikely(!cachep))
-		return NULL;
-
-	ptr = kfence_alloc(cachep, orig_size, flags);
-	if (unlikely(ptr))
-		goto out_hooks;
-
-	cache_alloc_debugcheck_before(cachep, flags);
-	local_irq_save(save_flags);
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
 __do_cache_alloc(struct kmem_cache *cache, gfp_t flags)
 {
@@ -3283,14 +3229,24 @@ __do_cache_alloc(struct kmem_cache *cachep, gfp_t flags)
 {
 	return ____cache_alloc(cachep, flags);
 }
-
 #endif /* CONFIG_NUMA */
 
+static __always_inline bool node_match(int nodeid, int slab_node)
+{
+#ifdef CONFIG_NUMA
+	if (nodeid != NUMA_NO_NODE && nodeid != slab_node)
+		return false;
+#endif
+	return true;
+}
+
 static __always_inline void *
-slab_alloc(struct kmem_cache *cachep, gfp_t flags, size_t orig_size, unsigned long caller)
+slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid, size_t orig_size,
+		   unsigned long caller)
 {
 	unsigned long save_flags;
-	void *objp;
+	void *ptr;
+	int slab_node = numa_mem_id();
 	struct obj_cgroup *objcg = NULL;
 	bool init = false;
 
@@ -3299,21 +3255,49 @@ slab_alloc(struct kmem_cache *cachep, gfp_t flags, size_t orig_size, unsigned lo
 	if (unlikely(!cachep))
 		return NULL;
 
-	objp = kfence_alloc(cachep, orig_size, flags);
-	if (unlikely(objp))
-		goto out;
+	ptr = kfence_alloc(cachep, orig_size, flags);
+	if (unlikely(ptr))
+		goto out_hooks;
 
 	cache_alloc_debugcheck_before(cachep, flags);
 	local_irq_save(save_flags);
-	objp = __do_cache_alloc(cachep, flags);
+
+	if (node_match(nodeid, slab_node)) {
+		/*
+		 * Use the locally cached objects if possible.
+		 * However ____cache_alloc does not allow fallback
+		 * to other nodes. It may fail while we still have
+		 * objects on other nodes available.
+		 */
+		ptr = ____cache_alloc(cachep, flags);
+		if (ptr)
+			goto out;
+	}
+#ifdef CONFIG_NUMA
+	else if (unlikely(!get_node(cachep, nodeid))) {
+		/* Node not bootstrapped yet */
+		ptr = fallback_alloc(cachep, flags);
+		goto out;
+	}
+
+	/* ___cache_alloc_node can fall back to other nodes */
+	ptr = ____cache_alloc_node(cachep, flags, nodeid);
+#endif
+out:
 	local_irq_restore(save_flags);
-	objp = cache_alloc_debugcheck_after(cachep, flags, objp, caller);
-	prefetchw(objp);
+	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr, caller);
+	prefetchw(ptr);
 	init = slab_want_init_on_alloc(flags, cachep);
 
-out:
-	slab_post_alloc_hook(cachep, objcg, flags, 1, &objp, init);
-	return objp;
+out_hooks:
+	slab_post_alloc_hook(cachep, objcg, flags, 1, &ptr, init);
+	return ptr;
+}
+
+static __always_inline void *
+slab_alloc(struct kmem_cache *cachep, gfp_t flags, size_t orig_size, unsigned long caller)
+{
+	return slab_alloc_node(cachep, flags, NUMA_NO_NODE, orig_size, caller);
 }
 
 /*
-- 
2.33.1


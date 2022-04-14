Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082E4500914
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238667AbiDNJA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbiDNJAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:00:25 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07245694BA
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:57:51 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id t4so4258607pgc.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1FPkm/TLzLTQMHUsixIGcuD+OLSdW/9rH0hk3KXQQRs=;
        b=nEVcOqG+5eRBSzUKW8iulIUpYNphwv7RdkQabP5oXTmOBF1Ho2/hsibWym9Lfx4IYu
         k96SHmurryzNiATsEe3/EJMtIEvHiOX07ahOn/YMby4d3Vx6ITx9bYpPoA1OQ7ZANpHh
         ernORsqx2XRP+ELWlZ/MXN+6nHQYIo44e/Gnuyx3HxLtCwWmpPYaJEK/+pvwD0yxFY7+
         AELf4iNxECWm80YQMJ//H7PvCPhGuqkqOPt6/nrwmWz41b9289t5Sf0Sq1XE+jVtITTG
         IzWYeH9u7fJWdTQXzBMkVvyiRXg2sekJF3JZYq17DVddoqee2/o6f4TkQWpLWKWpfyZp
         E+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1FPkm/TLzLTQMHUsixIGcuD+OLSdW/9rH0hk3KXQQRs=;
        b=x1E8d1eUNyaVVYaEpIYlAHc/XEb4Iok9jHeT/4sz+WHSio4Pl2krp3VVFfAjtXy3sj
         QmliyJEd603t0bmuONVWSUu6xhRUU7xMSoRSsm/Tk5t5GBb3cmRctpUORsFhr0oT/T8i
         TNM43EF0m6mTg7Ar5PUA9s2Es/GmUgM/KuorGG6v9G6OJo8dXnMQnay8nqxbEZuLmA/e
         EBnqQOzcI4CCe1e5wsc9GEXkhdpI252j1UfIYdNPmr1NM9Kr4SP0IGkOndbwqO07uWh4
         mmiJfRYZNJOLqtBVQ3LTR1ZR8MmFIY8PrgEGIhJ3AWeQ7iGseZSEanNR4Y98Yb2nAYVW
         pI/w==
X-Gm-Message-State: AOAM530H+WPd+ciMJrICukgvRJIft+UG/FxlpmZaZ/9KSU8noNo6Xq2C
        pz5phlfkkN2YU4gZNOYxkZs=
X-Google-Smtp-Source: ABdhPJzebzesCCi5YprbRSNLDIjE6SUmQD82KtTQFMn1URgYcQqctqNOi9eF2IZnCysdbjBJWvsqSw==
X-Received: by 2002:aa7:888b:0:b0:4fb:10e1:8983 with SMTP id z11-20020aa7888b000000b004fb10e18983mr2848126pfe.62.1649926670569;
        Thu, 14 Apr 2022 01:57:50 -0700 (PDT)
Received: from hyeyoo.. ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id p9-20020aa79e89000000b00505fada20dfsm1403537pfq.117.2022.04.14.01.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:57:49 -0700 (PDT)
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
Subject: [PATCH v2 02/23] mm/slab: cleanup slab_alloc() and slab_alloc_node()
Date:   Thu, 14 Apr 2022 17:57:06 +0900
Message-Id: <20220414085727.643099-3-42.hyeyoo@gmail.com>
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

Make slab_alloc_node() available even when CONFIG_NUMA=n and
make slab_alloc() wrapper of slab_alloc_node().

This is necessary for further cleanup.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/slab.c | 50 +++++++++++++-------------------------------------
 1 file changed, 13 insertions(+), 37 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index d854c24d5f5a..f033d5b4fefb 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3187,38 +3187,6 @@ static void *____cache_alloc_node(struct kmem_cache *cachep, gfp_t flags,
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
@@ -3267,8 +3235,8 @@ __do_cache_alloc(struct kmem_cache *cachep, gfp_t flags, int nodeid __maybe_unus
 #endif /* CONFIG_NUMA */
 
 static __always_inline void *
-slab_alloc(struct kmem_cache *cachep, struct list_lru *lru, gfp_t flags,
-	   size_t orig_size, unsigned long caller)
+slab_alloc_node(struct kmem_cache *cachep, struct list_lru *lru, gfp_t flags,
+		int nodeid, size_t orig_size, unsigned long caller)
 {
 	unsigned long save_flags;
 	void *objp;
@@ -3286,7 +3254,7 @@ slab_alloc(struct kmem_cache *cachep, struct list_lru *lru, gfp_t flags,
 
 	cache_alloc_debugcheck_before(cachep, flags);
 	local_irq_save(save_flags);
-	objp = __do_cache_alloc(cachep, flags, NUMA_NO_NODE);
+	objp = __do_cache_alloc(cachep, flags, nodeid);
 	local_irq_restore(save_flags);
 	objp = cache_alloc_debugcheck_after(cachep, flags, objp, caller);
 	prefetchw(objp);
@@ -3297,6 +3265,14 @@ slab_alloc(struct kmem_cache *cachep, struct list_lru *lru, gfp_t flags,
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
@@ -3585,7 +3561,7 @@ EXPORT_SYMBOL(kmem_cache_alloc_trace);
  */
 void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)
 {
-	void *ret = slab_alloc_node(cachep, flags, nodeid, cachep->object_size, _RET_IP_);
+	void *ret = slab_alloc_node(cachep, NULL, flags, nodeid, cachep->object_size, _RET_IP_);
 
 	trace_kmem_cache_alloc_node(_RET_IP_, ret,
 				    cachep->object_size, cachep->size,
@@ -3603,7 +3579,7 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
 {
 	void *ret;
 
-	ret = slab_alloc_node(cachep, flags, nodeid, size, _RET_IP_);
+	ret = slab_alloc_node(cachep, NULL, flags, nodeid, size, _RET_IP_);
 
 	ret = kasan_kmalloc(cachep, ret, size, flags);
 	trace_kmalloc_node(_RET_IP_, ret,
-- 
2.32.0


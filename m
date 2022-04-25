Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7632950D7E4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 05:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238583AbiDYD6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 23:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240804AbiDYD5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 23:57:39 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38F0326DF
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 20:54:33 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id a15so13637537pfv.11
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 20:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nQMh4D1p1qUFFd/ENYkyd6a4ed7ywJDvuoHtnCfZxxc=;
        b=Bs0SRpa23sDZt6vNjRxBBzhpJC2UblN1G1+OnEPlhxziULEeoQFpwo0xDvIopvMUCw
         HkRZBGO9PVA8JBB/Gk2o5EuqWtpCSwli9tTSv0h42Nc8NJ5Bo+TWbzAM8dvz5FtEjf3E
         cQ+EVzcjWpy+yA9XpPno1xouHknR0/juYvLghHsHM67P1w69KYKHwkUEY91aDFg0+tFq
         mySeuKbFId0BCa6P8IqsQs89ri/KTOMpk/ASf1aVoFA4abENNFyqlDcrqZRr0TObUiRc
         bf6ViEub7tSVYfrsECpiJ6hqALK/TWiIpXYS458+rMtD5Ei8Ny4gud8sRl5Dr9fdKK3f
         ZvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nQMh4D1p1qUFFd/ENYkyd6a4ed7ywJDvuoHtnCfZxxc=;
        b=nfb2gejU6M8BCHWnROR2k1LsRlr88lRzrcSd/vb2RATm/iRNFO5rM4avCM96LnZ7LD
         oAgGgyoTPu7auu2M/4Si+MHYkCvEMStX4ODGIlAG93/z+tFWkFA061nPvYf0ZE/3UruK
         rL6UXgXz9CLPZ1VbKglt6kSFuF4gmfDkEO7/FqxEUBqsDuwD1SfgjncKGjhRr00x7jXt
         CEJlMMl1YtOBvxpCuXwEFHc2jtlKn6mTjBkqnbOrZ9oTv+INIe5ycbNXkb34qvdw6KoG
         nc/z8JkcnqaDVlizfum5i+pr40mJvcA/iS5gi8TTLy7bQEUudZVUzxkZAva50swcgtnv
         Ha/w==
X-Gm-Message-State: AOAM532IVO3J2X+pqTzrpvNeTirkHnz+5AMiPgKx9UsLj9wjIVfDAp72
        yPO2d7RMO6yw/VM/oBMQ9n+6CA==
X-Google-Smtp-Source: ABdhPJw3MQhqUGTALqOLtdCdPnevRR163RkOrfRhAO8+KyCaQAzLIwl5Jeo54ZZFWuFgMxcxdRKUCQ==
X-Received: by 2002:a05:6a00:22cd:b0:50a:69c9:1806 with SMTP id f13-20020a056a0022cd00b0050a69c91806mr17026948pfj.51.1650858873463;
        Sun, 24 Apr 2022 20:54:33 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id n16-20020a17090a091000b001d2bff34228sm6958176pjn.9.2022.04.24.20.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 20:54:33 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        smuchun@gmail.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: slab: optimize memcg_slab_free_hook()
Date:   Mon, 25 Apr 2022 11:54:06 +0800
Message-Id: <20220425035406.9337-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most callers of memcg_slab_free_hook() already know the slab,  which could
be passed to memcg_slab_free_hook() directly to reduce the overhead of an
another call of virt_to_slab().  For bulk freeing of objects, the call of
slab_objcgs() in the loop in memcg_slab_free_hook() is redundant as well.
Rework memcg_slab_free_hook() and build_detached_freelist() to reduce
those unnecessary overhead and make memcg_slab_free_hook() can handle bulk
freeing in slab_free().

Move the calling site of memcg_slab_free_hook() from do_slab_free() to
slab_free() for slub to make the code clearer since the logic is weird
(e.g. the caller need to judge whether it needs to call
memcg_slab_free_hook()). It is easy to make mistakes like missing calling
of memcg_slab_free_hook() like fixes of:

  commit d1b2cf6cb84a ("mm: memcg/slab: uncharge during kmem_cache_free_bulk()")
  commit ae085d7f9365 ("mm: kfence: fix missing objcg housekeeping for SLAB")

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/slab.c |  4 ++--
 mm/slab.h | 30 ++++++++---------------------
 mm/slub.c | 66 +++++++++++++++++++++------------------------------------------
 3 files changed, 32 insertions(+), 68 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index a301f266efd1..e868b4af4346 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3407,9 +3407,10 @@ static __always_inline void __cache_free(struct kmem_cache *cachep, void *objp,
 {
 	bool init;
 
+	memcg_slab_free_hook(cachep, virt_to_slab(objp), &objp, 1);
+
 	if (is_kfence_address(objp)) {
 		kmemleak_free_recursive(objp, cachep->flags);
-		memcg_slab_free_hook(cachep, &objp, 1);
 		__kfence_free(objp);
 		return;
 	}
@@ -3442,7 +3443,6 @@ void ___cache_free(struct kmem_cache *cachep, void *objp,
 	check_irq_off();
 	kmemleak_free_recursive(objp, cachep->flags);
 	objp = cache_free_debugcheck(cachep, objp, caller);
-	memcg_slab_free_hook(cachep, &objp, 1);
 
 	/*
 	 * Skip calling cache_free_alien() when the platform is not numa.
diff --git a/mm/slab.h b/mm/slab.h
index db9fb5c8dae7..a8d5eb1c323f 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -547,36 +547,22 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
 	obj_cgroup_put(objcg);
 }
 
-static inline void memcg_slab_free_hook(struct kmem_cache *s_orig,
+static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 					void **p, int objects)
 {
-	struct kmem_cache *s;
 	struct obj_cgroup **objcgs;
-	struct obj_cgroup *objcg;
-	struct slab *slab;
-	unsigned int off;
 	int i;
 
 	if (!memcg_kmem_enabled())
 		return;
 
-	for (i = 0; i < objects; i++) {
-		if (unlikely(!p[i]))
-			continue;
-
-		slab = virt_to_slab(p[i]);
-		/* we could be given a kmalloc_large() object, skip those */
-		if (!slab)
-			continue;
-
-		objcgs = slab_objcgs(slab);
-		if (!objcgs)
-			continue;
+	objcgs = slab_objcgs(slab);
+	if (!objcgs)
+		return;
 
-		if (!s_orig)
-			s = slab->slab_cache;
-		else
-			s = s_orig;
+	for (i = 0; i < objects; i++) {
+		struct obj_cgroup *objcg;
+		unsigned int off;
 
 		off = obj_to_index(s, slab, p[i]);
 		objcg = objcgs[off];
@@ -628,7 +614,7 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
 {
 }
 
-static inline void memcg_slab_free_hook(struct kmem_cache *s,
+static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 					void **p, int objects)
 {
 }
diff --git a/mm/slub.c b/mm/slub.c
index 6dc703488d30..86c50eb6c670 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3437,9 +3437,6 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
 	struct kmem_cache_cpu *c;
 	unsigned long tid;
 
-	/* memcg_slab_free_hook() is already called for bulk free. */
-	if (!tail)
-		memcg_slab_free_hook(s, &head, 1);
 redo:
 	/*
 	 * Determine the currently cpus per cpu slab.
@@ -3499,9 +3496,10 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
 }
 
 static __always_inline void slab_free(struct kmem_cache *s, struct slab *slab,
-				      void *head, void *tail, int cnt,
+				      void *head, void *tail, void **p, int cnt,
 				      unsigned long addr)
 {
+	memcg_slab_free_hook(s, slab, p, cnt);
 	/*
 	 * With KASAN enabled slab_free_freelist_hook modifies the freelist
 	 * to remove objects, whose reuse must be delayed.
@@ -3523,7 +3521,7 @@ void kmem_cache_free(struct kmem_cache *s, void *x)
 	if (!s)
 		return;
 	trace_kmem_cache_free(_RET_IP_, x, s->name);
-	slab_free(s, virt_to_slab(x), x, NULL, 1, _RET_IP_);
+	slab_free(s, virt_to_slab(x), x, NULL, &x, 1, _RET_IP_);
 }
 EXPORT_SYMBOL(kmem_cache_free);
 
@@ -3564,79 +3562,59 @@ static inline
 int build_detached_freelist(struct kmem_cache *s, size_t size,
 			    void **p, struct detached_freelist *df)
 {
-	size_t first_skipped_index = 0;
 	int lookahead = 3;
 	void *object;
 	struct folio *folio;
-	struct slab *slab;
-
-	/* Always re-init detached_freelist */
-	df->slab = NULL;
-
-	do {
-		object = p[--size];
-		/* Do we need !ZERO_OR_NULL_PTR(object) here? (for kfree) */
-	} while (!object && size);
-
-	if (!object)
-		return 0;
+	size_t same;
 
+	object = p[--size];
 	folio = virt_to_folio(object);
 	if (!s) {
 		/* Handle kalloc'ed objects */
 		if (unlikely(!folio_test_slab(folio))) {
 			free_large_kmalloc(folio, object);
-			p[size] = NULL; /* mark object processed */
+			df->slab = NULL;
 			return size;
 		}
 		/* Derive kmem_cache from object */
-		slab = folio_slab(folio);
-		df->s = slab->slab_cache;
+		df->slab = folio_slab(folio);
+		df->s = df->slab->slab_cache;
 	} else {
-		slab = folio_slab(folio);
+		df->slab = folio_slab(folio);
 		df->s = cache_from_obj(s, object); /* Support for memcg */
 	}
 
-	if (is_kfence_address(object)) {
-		slab_free_hook(df->s, object, false);
-		__kfence_free(object);
-		p[size] = NULL; /* mark object processed */
-		return size;
-	}
-
 	/* Start new detached freelist */
-	df->slab = slab;
-	set_freepointer(df->s, object, NULL);
 	df->tail = object;
 	df->freelist = object;
-	p[size] = NULL; /* mark object processed */
 	df->cnt = 1;
 
+	if (is_kfence_address(object))
+		return size;
+
+	set_freepointer(df->s, object, NULL);
+
+	same = size;
 	while (size) {
 		object = p[--size];
-		if (!object)
-			continue; /* Skip processed objects */
-
 		/* df->slab is always set at this point */
 		if (df->slab == virt_to_slab(object)) {
 			/* Opportunity build freelist */
 			set_freepointer(df->s, object, df->freelist);
 			df->freelist = object;
 			df->cnt++;
-			p[size] = NULL; /* mark object processed */
-
+			same--;
+			if (size != same)
+				swap(p[size], p[same]);
 			continue;
 		}
 
 		/* Limit look ahead search */
 		if (!--lookahead)
 			break;
-
-		if (!first_skipped_index)
-			first_skipped_index = size + 1;
 	}
 
-	return first_skipped_index;
+	return same;
 }
 
 /* Note that interrupts must be enabled when calling this function. */
@@ -3645,7 +3623,6 @@ void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p)
 	if (WARN_ON(!size))
 		return;
 
-	memcg_slab_free_hook(s, p, size);
 	do {
 		struct detached_freelist df;
 
@@ -3653,7 +3630,8 @@ void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p)
 		if (!df.slab)
 			continue;
 
-		slab_free(df.s, df.slab, df.freelist, df.tail, df.cnt, _RET_IP_);
+		slab_free(df.s, df.slab, df.freelist, df.tail, &p[size], df.cnt,
+			  _RET_IP_);
 	} while (likely(size));
 }
 EXPORT_SYMBOL(kmem_cache_free_bulk);
@@ -4556,7 +4534,7 @@ void kfree(const void *x)
 		return;
 	}
 	slab = folio_slab(folio);
-	slab_free(slab->slab_cache, slab, object, NULL, 1, _RET_IP_);
+	slab_free(slab->slab_cache, slab, object, NULL, &object, 1, _RET_IP_);
 }
 EXPORT_SYMBOL(kfree);
 
-- 
2.11.0


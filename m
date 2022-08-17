Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8478596CC3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 12:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239033AbiHQKUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 06:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239059AbiHQKUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:20:06 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2E382862
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:19:43 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id f192so11662219pfa.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=NUhisoUUDw6CQz+v9YGeettBV60tR4WaAKuvhlxdtBs=;
        b=lhCz68I4EgFx+wWyEe5AMNw5KeaZgl8syXATH2qGGWEIgxjlpooCBpohcHeUeiDDsE
         jE8b0xGnKbCNY75aS6eBlqIEMXv82HseRtahkUw/WZmYNK8Z0Bgd/loYGY6xdUlksdXB
         ejx/2wQqBg1/WgEWz7oJjb404IHTLZVdjcTqTdLd+wEoTDTG4nCVWq82n37zykZW865K
         Cg4LGy5uNJUROcc0ZUoLdjKM4mi4+x1DtxpbT6uTD6JP7qiP5WVhOWmgsDvCYx54yIjd
         ZyzQDLn7MI3DGfQlRiRQA4A1roAGqH/PC4LR/WxOSi/4R6FkzBpxeipD6+7yv162wSUP
         83+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=NUhisoUUDw6CQz+v9YGeettBV60tR4WaAKuvhlxdtBs=;
        b=sSnzZGZUOGTlA5f4TKUuyviNfehS4VdHJA0s/OBU+WKGKxKKcrMq4TQD1ZTwhiK8F4
         iUcqGQXn/jG/0bsE8ryA4ZPgDn9SrXTW4eyxK+ehwCAnwyGisNXp6P/h0r2IdzQR+710
         OdTZ4irYEe1gj45MuiX7WX+aHUQ8e4sVYg5DqvpMpZMqjGMs/E4FGit1AC8Eg4q206EN
         mE0zXMhw/gOfk6hs9WAfgfBxWM9vkjuS7OVwT/gqS9M1RBlphzpRK0SrNzKBOpr3ct5E
         Yv6lLq71DRQ+maMc84BVo0KfScOS8zeha+iS4/nAtxSIgCXjPRv+CiBeLqT81Q3qL0bF
         qucQ==
X-Gm-Message-State: ACgBeo3vXddVDIIB1rlM5GUhtB9zdeKA3C0MK/wCCo70C5StGSLCsaKG
        y2payPTnBMVlHwm2CBewa1o=
X-Google-Smtp-Source: AA6agR5UJmaMtf04/yHbQgrf6h8TvXMUUhoRNtxO3WVLNbTHMdy2nAQOOKD3bg2S2eKBtrYQEnSLbg==
X-Received: by 2002:a62:4ed3:0:b0:52d:9b4a:d91a with SMTP id c202-20020a624ed3000000b0052d9b4ad91amr24901250pfb.8.1660731582428;
        Wed, 17 Aug 2022 03:19:42 -0700 (PDT)
Received: from hyeyoo.. ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id d8-20020a170903230800b00172633fc236sm1071318plh.174.2022.08.17.03.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 03:19:41 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Vasily Averin <vasily.averin@linux.dev>
Subject: [PATCH v4 15/17] mm/slab_common: drop kmem_alloc & avoid dereferencing fields when not using
Date:   Wed, 17 Aug 2022 19:18:24 +0900
Message-Id: <20220817101826.236819-16-42.hyeyoo@gmail.com>
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

Drop kmem_alloc event class, and define kmalloc and kmem_cache_alloc
using TRACE_EVENT() macro.

And then this patch does:
   - Do not pass pointer to struct kmem_cache to trace_kmalloc.
     gfp flag is enough to know if it's accounted or not.
   - Avoid dereferencing s->object_size and s->size when not using kmem_cache_alloc event.
   - Avoid dereferencing s->name in when not using kmem_cache_free event.
   - Adjust s->size to SLOB_UNITS(s->size) * SLOB_UNIT in SLOB

Cc: Vasily Averin <vasily.averin@linux.dev>
Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/trace/events/kmem.h | 64 ++++++++++++++++++++++++-------------
 mm/slab.c                   |  8 ++---
 mm/slab_common.c            | 16 +++++-----
 mm/slob.c                   | 19 +++++------
 mm/slub.c                   |  8 ++---
 5 files changed, 64 insertions(+), 51 deletions(-)

diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index e078ebcdc4b1..8c6f96604244 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -9,17 +9,15 @@
 #include <linux/tracepoint.h>
 #include <trace/events/mmflags.h>
 
-DECLARE_EVENT_CLASS(kmem_alloc,
+TRACE_EVENT(kmem_cache_alloc,
 
 	TP_PROTO(unsigned long call_site,
 		 const void *ptr,
 		 struct kmem_cache *s,
-		 size_t bytes_req,
-		 size_t bytes_alloc,
 		 gfp_t gfp_flags,
 		 int node),
 
-	TP_ARGS(call_site, ptr, s, bytes_req, bytes_alloc, gfp_flags, node),
+	TP_ARGS(call_site, ptr, s, gfp_flags, node),
 
 	TP_STRUCT__entry(
 		__field(	unsigned long,	call_site	)
@@ -34,13 +32,13 @@ DECLARE_EVENT_CLASS(kmem_alloc,
 	TP_fast_assign(
 		__entry->call_site	= call_site;
 		__entry->ptr		= ptr;
-		__entry->bytes_req	= bytes_req;
-		__entry->bytes_alloc	= bytes_alloc;
+		__entry->bytes_req	= s->object_size;
+		__entry->bytes_alloc	= s->size;
 		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
 		__entry->node		= node;
 		__entry->accounted	= IS_ENABLED(CONFIG_MEMCG_KMEM) ?
 					  ((gfp_flags & __GFP_ACCOUNT) ||
-					  (s && s->flags & SLAB_ACCOUNT)) : false;
+					  (s->flags & SLAB_ACCOUNT)) : false;
 	),
 
 	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s node=%d accounted=%s",
@@ -53,22 +51,44 @@ DECLARE_EVENT_CLASS(kmem_alloc,
 		__entry->accounted ? "true" : "false")
 );
 
-DEFINE_EVENT(kmem_alloc, kmalloc,
+TRACE_EVENT(kmalloc,
 
-	TP_PROTO(unsigned long call_site, const void *ptr,
-		 struct kmem_cache *s, size_t bytes_req, size_t bytes_alloc,
-		 gfp_t gfp_flags, int node),
+	TP_PROTO(unsigned long call_site,
+		 const void *ptr,
+		 size_t bytes_req,
+		 size_t bytes_alloc,
+		 gfp_t gfp_flags,
+		 int node),
 
-	TP_ARGS(call_site, ptr, s, bytes_req, bytes_alloc, gfp_flags, node)
-);
+	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags, node),
 
-DEFINE_EVENT(kmem_alloc, kmem_cache_alloc,
+	TP_STRUCT__entry(
+		__field(	unsigned long,	call_site	)
+		__field(	const void *,	ptr		)
+		__field(	size_t,		bytes_req	)
+		__field(	size_t,		bytes_alloc	)
+		__field(	unsigned long,	gfp_flags	)
+		__field(	int,		node		)
+	),
 
-	TP_PROTO(unsigned long call_site, const void *ptr,
-		 struct kmem_cache *s, size_t bytes_req, size_t bytes_alloc,
-		 gfp_t gfp_flags, int node),
+	TP_fast_assign(
+		__entry->call_site	= call_site;
+		__entry->ptr		= ptr;
+		__entry->bytes_req	= bytes_req;
+		__entry->bytes_alloc	= bytes_alloc;
+		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
+		__entry->node		= node;
+	),
 
-	TP_ARGS(call_site, ptr, s, bytes_req, bytes_alloc, gfp_flags, node)
+	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s node=%d accounted=%s",
+		(void *)__entry->call_site,
+		__entry->ptr,
+		__entry->bytes_req,
+		__entry->bytes_alloc,
+		show_gfp_flags(__entry->gfp_flags),
+		__entry->node,
+		(IS_ENABLED(CONFIG_MEMCG_KMEM) &&
+		 (__entry->gfp_flags & __GFP_ACCOUNT)) ? "true" : "false")
 );
 
 TRACE_EVENT(kfree,
@@ -93,20 +113,20 @@ TRACE_EVENT(kfree,
 
 TRACE_EVENT(kmem_cache_free,
 
-	TP_PROTO(unsigned long call_site, const void *ptr, const char *name),
+	TP_PROTO(unsigned long call_site, const void *ptr, const struct kmem_cache *s),
 
-	TP_ARGS(call_site, ptr, name),
+	TP_ARGS(call_site, ptr, s),
 
 	TP_STRUCT__entry(
 		__field(	unsigned long,	call_site	)
 		__field(	const void *,	ptr		)
-		__string(	name,	name	)
+		__string(	name,		s->name		)
 	),
 
 	TP_fast_assign(
 		__entry->call_site	= call_site;
 		__entry->ptr		= ptr;
-		__assign_str(name, name);
+		__assign_str(name, s->name);
 	),
 
 	TP_printk("call_site=%pS ptr=%p name=%s",
diff --git a/mm/slab.c b/mm/slab.c
index 2fd400203ac2..a5486ff8362a 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3440,8 +3440,7 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru,
 {
 	void *ret = slab_alloc(cachep, lru, flags, cachep->object_size, _RET_IP_);
 
-	trace_kmem_cache_alloc(_RET_IP_, ret, cachep, cachep->object_size,
-			       cachep->size, flags, NUMA_NO_NODE);
+	trace_kmem_cache_alloc(_RET_IP_, ret, cachep, flags, NUMA_NO_NODE);
 
 	return ret;
 }
@@ -3536,8 +3535,7 @@ void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)
 {
 	void *ret = slab_alloc_node(cachep, NULL, flags, nodeid, cachep->object_size, _RET_IP_);
 
-	trace_kmem_cache_alloc(_RET_IP_, ret, cachep, cachep->object_size,
-			       cachep->size, flags, nodeid);
+	trace_kmem_cache_alloc(_RET_IP_, ret, cachep, flags, nodeid);
 
 	return ret;
 }
@@ -3607,7 +3605,7 @@ void kmem_cache_free(struct kmem_cache *cachep, void *objp)
 	if (!cachep)
 		return;
 
-	trace_kmem_cache_free(_RET_IP_, objp, cachep->name);
+	trace_kmem_cache_free(_RET_IP_, objp, cachep);
 	__do_kmem_cache_free(cachep, objp, _RET_IP_);
 }
 EXPORT_SYMBOL(kmem_cache_free);
diff --git a/mm/slab_common.c b/mm/slab_common.c
index f34be57b00c8..e53016c9a6e9 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -907,7 +907,7 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller
 
 	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
 		ret = __kmalloc_large_node(size, flags, node);
-		trace_kmalloc(_RET_IP_, ret, NULL, size,
+		trace_kmalloc(_RET_IP_, ret, size,
 			      PAGE_SIZE << get_order(size), flags, node);
 		return ret;
 	}
@@ -919,7 +919,7 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller
 
 	ret = __kmem_cache_alloc_node(s, flags, node, size, caller);
 	ret = kasan_kmalloc(s, ret, size, flags);
-	trace_kmalloc(_RET_IP_, ret, s, size, s->size, flags, node);
+	trace_kmalloc(_RET_IP_, ret, size, s->size, flags, node);
 	return ret;
 }
 
@@ -1005,7 +1005,7 @@ void *kmalloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
 	void *ret = __kmem_cache_alloc_node(s, gfpflags, NUMA_NO_NODE,
 					    size, _RET_IP_);
 
-	trace_kmalloc(_RET_IP_, ret, s, size, s->size, gfpflags, NUMA_NO_NODE);
+	trace_kmalloc(_RET_IP_, ret, size, s->size, gfpflags, NUMA_NO_NODE);
 
 	ret = kasan_kmalloc(s, ret, size, gfpflags);
 	return ret;
@@ -1017,7 +1017,7 @@ void *kmalloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
 {
 	void *ret = __kmem_cache_alloc_node(s, gfpflags, node, size, _RET_IP_);
 
-	trace_kmalloc(_RET_IP_, ret, s, size, s->size, gfpflags, node);
+	trace_kmalloc(_RET_IP_, ret, size, s->size, gfpflags, node);
 
 	ret = kasan_kmalloc(s, ret, size, gfpflags);
 	return ret;
@@ -1072,8 +1072,8 @@ void *kmalloc_large(size_t size, gfp_t flags)
 {
 	void *ret = __kmalloc_large_node(size, flags, NUMA_NO_NODE);
 
-	trace_kmalloc(_RET_IP_, ret, NULL, size,
-		      PAGE_SIZE << get_order(size), flags, NUMA_NO_NODE);
+	trace_kmalloc(_RET_IP_, ret, size, PAGE_SIZE << get_order(size),
+		      flags, NUMA_NO_NODE);
 	return ret;
 }
 EXPORT_SYMBOL(kmalloc_large);
@@ -1082,8 +1082,8 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node)
 {
 	void *ret = __kmalloc_large_node(size, flags, node);
 
-	trace_kmalloc(_RET_IP_, ret, NULL, size,
-		      PAGE_SIZE << get_order(size), flags, node);
+	trace_kmalloc(_RET_IP_, ret, size, PAGE_SIZE << get_order(size),
+		      flags, node);
 	return ret;
 }
 EXPORT_SYMBOL(kmalloc_large_node);
diff --git a/mm/slob.c b/mm/slob.c
index 3208c56d8f82..771af84576bf 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -507,8 +507,7 @@ __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
 		*m = size;
 		ret = (void *)m + minalign;
 
-		trace_kmalloc(caller, ret, NULL, size,
-			      size + minalign, gfp, node);
+		trace_kmalloc(caller, ret, size, size + minalign, gfp, node);
 	} else {
 		unsigned int order = get_order(size);
 
@@ -516,8 +515,7 @@ __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
 			gfp |= __GFP_COMP;
 		ret = slob_new_pages(gfp, order, node);
 
-		trace_kmalloc(caller, ret, NULL, size,
-			      PAGE_SIZE << order, gfp, node);
+		trace_kmalloc(caller, ret, size, PAGE_SIZE << order, gfp, node);
 	}
 
 	kmemleak_alloc(ret, size, 1, gfp);
@@ -594,6 +592,9 @@ int __kmem_cache_create(struct kmem_cache *c, slab_flags_t flags)
 		/* leave room for rcu footer at the end of object */
 		c->size += sizeof(struct slob_rcu);
 	}
+
+	/* Actual size allocated */
+	c->size = SLOB_UNITS(c->size) * SLOB_UNIT;
 	c->flags = flags;
 	return 0;
 }
@@ -608,14 +609,10 @@ static void *slob_alloc_node(struct kmem_cache *c, gfp_t flags, int node)
 
 	if (c->size < PAGE_SIZE) {
 		b = slob_alloc(c->size, flags, c->align, node, 0);
-		trace_kmem_cache_alloc(_RET_IP_, b, NULL, c->object_size,
-				       SLOB_UNITS(c->size) * SLOB_UNIT,
-				       flags, node);
+		trace_kmem_cache_alloc(_RET_IP_, b, c, flags, node);
 	} else {
 		b = slob_new_pages(flags, get_order(c->size), node);
-		trace_kmem_cache_alloc(_RET_IP_, b, NULL, c->object_size,
-				       PAGE_SIZE << get_order(c->size),
-				       flags, node);
+		trace_kmem_cache_alloc(_RET_IP_, b, c, flags, node);
 	}
 
 	if (b && c->ctor) {
@@ -671,7 +668,7 @@ static void kmem_rcu_free(struct rcu_head *head)
 void kmem_cache_free(struct kmem_cache *c, void *b)
 {
 	kmemleak_free_recursive(b, c->flags);
-	trace_kmem_cache_free(_RET_IP_, b, c->name);
+	trace_kmem_cache_free(_RET_IP_, b, c);
 	if (unlikely(c->flags & SLAB_TYPESAFE_BY_RCU)) {
 		struct slob_rcu *slob_rcu;
 		slob_rcu = b + (c->size - sizeof(struct slob_rcu));
diff --git a/mm/slub.c b/mm/slub.c
index 22e4ccf06638..8083a6ee5f15 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3243,8 +3243,7 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
 {
 	void *ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);
 
-	trace_kmem_cache_alloc(_RET_IP_, ret, s, s->object_size,
-				s->size, gfpflags, NUMA_NO_NODE);
+	trace_kmem_cache_alloc(_RET_IP_, ret, s, gfpflags, NUMA_NO_NODE);
 
 	return ret;
 }
@@ -3274,8 +3273,7 @@ void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
 {
 	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, s->object_size);
 
-	trace_kmem_cache_alloc(_RET_IP_, ret, s, s->object_size,
-			       s->size, gfpflags, node);
+	trace_kmem_cache_alloc(_RET_IP_, ret, s, gfpflags, node);
 
 	return ret;
 }
@@ -3517,7 +3515,7 @@ void kmem_cache_free(struct kmem_cache *s, void *x)
 	s = cache_from_obj(s, x);
 	if (!s)
 		return;
-	trace_kmem_cache_free(_RET_IP_, x, s->name);
+	trace_kmem_cache_free(_RET_IP_, x, s);
 	slab_free(s, virt_to_slab(x), x, NULL, &x, 1, _RET_IP_);
 }
 EXPORT_SYMBOL(kmem_cache_free);
-- 
2.32.0


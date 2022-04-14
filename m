Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27C4500919
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241375AbiDNJCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241464AbiDNJBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:01:45 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FFE6D96B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:59:05 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id t4so4260969pgc.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7nL+6Lqmsphi23eQHyx3PjMEoO6jPBsPY6a/e/Mn+GM=;
        b=FxWh7U87zLedE8esjk7IcRw92WnQY7kx0n9GtXR7T/DBbCmrRqfpYk9BUV/Si7UCOI
         QkMCtjKIskmGztFstDW8OE2tpj3XkQK2P1SsBJBNPlakcVYuA9vp97I9s46MadowmUNv
         VYMnJhAgn34FOHW9mU/3jXQgzNcod00X7Bnr8sSZ8rq1mF3hBfdx3dFBoabnB44ap5Ko
         2l+U0qlqxeQOK8L5IBTcGzgd4Q1SmCc1sIn4nzXN8aRbYlQYyZGTK/K2DNruRfNA4QWT
         4Hq8Iw1vyLI611psCz0Zu3dDhV/siul56BdxJvX+1Ydv+TCf70lyPlXWNH79i1aWd+ql
         6ogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7nL+6Lqmsphi23eQHyx3PjMEoO6jPBsPY6a/e/Mn+GM=;
        b=tGnNCH93Q5lPmbTb1HrNqb2NcI4frwYtguj1oeZX4j+GFo2ZY8J53wwmcJTmCpspZP
         X+bMIVbfLkVNMrrAih1jEE6RuTejRc0H49PAiMJBWB9YRjiRY3PrbYGlLahYfhfE0/PO
         5/NyMUT163VII2Q+Nvm/RH6cpuug6p2KZqAGnOpVpOW1+8JHj8mSUTzSqjPtzS0+uaBz
         YRhZDE0Be7mlxzjvfq9xlvSGChSuLQP2JM7NU0JFOKG1ApeLOy7j5UKjRNvp/1DGMatB
         5+EwcghETPua4iLpXuHtvs6f8x/v8dHyBkQuwsuohwkhBbY2JQeRc79vRTSdN9DUH7p3
         ZnpQ==
X-Gm-Message-State: AOAM533hYsxQSoBnCuH8VObWczZEpoTN9IDVcIo1/CZb4n6kIOW/vZZ4
        h5Bn2uCF//2HYC9r5QNklFhcmHKFJ90=
X-Google-Smtp-Source: ABdhPJwBssAVf7hlNzo0QSt/qFMFzQCGzIzZo1icW6TkNDqIq87qRBwgYLPWhmDxpZA12aT0XMYX8A==
X-Received: by 2002:a63:4142:0:b0:39c:dd63:27a2 with SMTP id o63-20020a634142000000b0039cdd6327a2mr1470742pga.119.1649926745388;
        Thu, 14 Apr 2022 01:59:05 -0700 (PDT)
Received: from hyeyoo.. ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id p9-20020aa79e89000000b00505fada20dfsm1403537pfq.117.2022.04.14.01.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:59:03 -0700 (PDT)
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
Subject: [PATCH v2 14/23] mm/slab_common: print cache name in tracepoints
Date:   Thu, 14 Apr 2022 17:57:18 +0900
Message-Id: <20220414085727.643099-15-42.hyeyoo@gmail.com>
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

Print cache name in tracepoints. If there is no corresponding cache
(kmalloc in SLOB or kmalloc_large_node), use KMALLOC_{,LARGE_}NAME
macro.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 include/trace/events/kmem.h | 34 +++++++++++++++++++---------------
 mm/slab.c                   |  9 +++++----
 mm/slab.h                   |  4 ++++
 mm/slab_common.c            |  6 ++----
 mm/slob.c                   | 10 +++++-----
 mm/slub.c                   | 10 +++++-----
 6 files changed, 40 insertions(+), 33 deletions(-)

diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index ddc8c944f417..35e6887c6101 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -61,16 +61,18 @@ DEFINE_EVENT(kmem_alloc, kmem_cache_alloc,
 
 DECLARE_EVENT_CLASS(kmem_alloc_node,
 
-	TP_PROTO(unsigned long call_site,
+	TP_PROTO(const char *name,
+		 unsigned long call_site,
 		 const void *ptr,
 		 size_t bytes_req,
 		 size_t bytes_alloc,
 		 gfp_t gfp_flags,
 		 int node),
 
-	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags, node),
+	TP_ARGS(name, call_site, ptr, bytes_req, bytes_alloc, gfp_flags, node),
 
 	TP_STRUCT__entry(
+		__string(	name,		name		)
 		__field(	unsigned long,	call_site	)
 		__field(	const void *,	ptr		)
 		__field(	size_t,		bytes_req	)
@@ -80,6 +82,7 @@ DECLARE_EVENT_CLASS(kmem_alloc_node,
 	),
 
 	TP_fast_assign(
+		__assign_str(name, name);
 		__entry->call_site	= call_site;
 		__entry->ptr		= ptr;
 		__entry->bytes_req	= bytes_req;
@@ -88,7 +91,8 @@ DECLARE_EVENT_CLASS(kmem_alloc_node,
 		__entry->node		= node;
 	),
 
-	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s node=%d",
+	TP_printk("name=%s call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s node=%d",
+		__get_str(name),
 		(void *)__entry->call_site,
 		__entry->ptr,
 		__entry->bytes_req,
@@ -99,20 +103,20 @@ DECLARE_EVENT_CLASS(kmem_alloc_node,
 
 DEFINE_EVENT(kmem_alloc_node, kmalloc_node,
 
-	TP_PROTO(unsigned long call_site, const void *ptr,
-		 size_t bytes_req, size_t bytes_alloc,
+	TP_PROTO(const char *name, unsigned long call_site,
+		 const void *ptr, size_t bytes_req, size_t bytes_alloc,
 		 gfp_t gfp_flags, int node),
 
-	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags, node)
+	TP_ARGS(name, call_site, ptr, bytes_req, bytes_alloc, gfp_flags, node)
 );
 
 DEFINE_EVENT(kmem_alloc_node, kmem_cache_alloc_node,
 
-	TP_PROTO(unsigned long call_site, const void *ptr,
-		 size_t bytes_req, size_t bytes_alloc,
+	TP_PROTO(const char *name, unsigned long call_site,
+		 const void *ptr, size_t bytes_req, size_t bytes_alloc,
 		 gfp_t gfp_flags, int node),
 
-	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags, node)
+	TP_ARGS(name, call_site, ptr, bytes_req, bytes_alloc, gfp_flags, node)
 );
 
 TRACE_EVENT(kfree,
@@ -137,24 +141,24 @@ TRACE_EVENT(kfree,
 
 TRACE_EVENT(kmem_cache_free,
 
-	TP_PROTO(unsigned long call_site, const void *ptr, const char *name),
+	TP_PROTO(const char *name, unsigned long call_site, const void *ptr),
 
-	TP_ARGS(call_site, ptr, name),
+	TP_ARGS(name, call_site, ptr),
 
 	TP_STRUCT__entry(
+		__string(	name,	name	)
 		__field(	unsigned long,	call_site	)
 		__field(	const void *,	ptr		)
-		__string(	name,	name	)
 	),
 
 	TP_fast_assign(
+		__assign_str(name, name);
 		__entry->call_site	= call_site;
 		__entry->ptr		= ptr;
-		__assign_str(name, name);
 	),
 
-	TP_printk("call_site=%pS ptr=%p name=%s",
-		  (void *)__entry->call_site, __entry->ptr, __get_str(name))
+	TP_printk("name=%s call_site=%pS ptr=%p",
+		  __get_str(name), (void *)__entry->call_site, __entry->ptr)
 );
 
 TRACE_EVENT(mm_page_free,
diff --git a/mm/slab.c b/mm/slab.c
index 1dfe0f9d5882..3c47d0979706 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3448,8 +3448,9 @@ void *__kmem_cache_alloc_node(struct kmem_cache *cachep, struct list_lru *lru,
 	void *ret = slab_alloc_node(cachep, lru, flags, nodeid,
 				    cachep->object_size, caller);
 
-	trace_kmem_cache_alloc_node(caller, ret, cachep->object_size,
-				    cachep->size, flags, nodeid);
+	trace_kmem_cache_alloc_node(cachep->name, caller, ret,
+				    cachep->object_size, cachep->size,
+				    flags, nodeid);
 
 	return ret;
 }
@@ -3518,7 +3519,7 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
 	ret = slab_alloc_node(cachep, NULL, flags, nodeid, size, _RET_IP_);
 
 	ret = kasan_kmalloc(cachep, ret, size, flags);
-	trace_kmalloc_node(_RET_IP_, ret,
+	trace_kmalloc_node(cachep->name, _RET_IP_, ret,
 			   size, cachep->size,
 			   flags, nodeid);
 	return ret;
@@ -3593,7 +3594,7 @@ void kmem_cache_free(struct kmem_cache *cachep, void *objp)
 	if (!cachep)
 		return;
 
-	trace_kmem_cache_free(_RET_IP_, objp, cachep->name);
+	trace_kmem_cache_free(cachep->name, _RET_IP_, objp);
 	local_irq_save(flags);
 	debug_check_no_locks_freed(objp, cachep->object_size);
 	if (!(cachep->flags & SLAB_DEBUG_OBJECTS))
diff --git a/mm/slab.h b/mm/slab.h
index b864c5bc4c25..45ddb19df319 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -275,6 +275,10 @@ void create_kmalloc_caches(slab_flags_t);
 struct kmem_cache *kmalloc_slab(size_t, gfp_t);
 #endif
 
+/* cache names for tracepoints where it has no corresponding cache  */
+#define KMALLOC_LARGE_NAME "kmalloc_large_node"
+#define KMALLOC_NAME "kmalloc_node"
+
 gfp_t kmalloc_fix_flags(gfp_t flags);
 
 /* Functions provided by the slab allocators */
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 960cc07c3a91..416f0a1f17a6 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -956,10 +956,8 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node)
 	ptr = kasan_kmalloc_large(ptr, size, flags);
 	/* As ptr might get tagged, call kmemleak hook after KASAN. */
 	kmemleak_alloc(ptr, size, 1, flags);
-	trace_kmalloc_node(_RET_IP_, ptr,
-			   size, PAGE_SIZE << order,
-			   flags, node);
-
+	trace_kmalloc_node(KMALLOC_LARGE_NAME, _RET_IP_, ptr, size,
+			   PAGE_SIZE << order, flags, node);
 	return ptr;
 }
 EXPORT_SYMBOL(kmalloc_large_node);
diff --git a/mm/slob.c b/mm/slob.c
index 6c7c30845056..8abde6037d95 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -505,7 +505,7 @@ __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
 		*m = size;
 		ret = (void *)m + minalign;
 
-		trace_kmalloc_node(caller, ret,
+		trace_kmalloc_node(KMALLOC_NAME, caller, ret,
 				   size, size + minalign, gfp, node);
 	} else {
 		unsigned int order = get_order(size);
@@ -514,7 +514,7 @@ __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
 			gfp |= __GFP_COMP;
 		ret = slob_new_pages(gfp, order, node);
 
-		trace_kmalloc_node(caller, ret,
+		trace_kmalloc_node(KMALLOC_LARGE_NAME, caller, ret,
 				   size, PAGE_SIZE << order, gfp, node);
 	}
 
@@ -597,12 +597,12 @@ static void *slob_alloc_node(struct kmem_cache *c, gfp_t flags, int node,
 
 	if (c->size < PAGE_SIZE) {
 		b = slob_alloc(c->size, flags, c->align, node, 0);
-		trace_kmem_cache_alloc_node(caller, b, c->object_size,
+		trace_kmem_cache_alloc_node(c->name, caller, b, c->object_size,
 					    SLOB_UNITS(c->size) * SLOB_UNIT,
 					    flags, node);
 	} else {
 		b = slob_new_pages(flags, get_order(c->size), node);
-		trace_kmem_cache_alloc_node(caller, b, c->object_size,
+		trace_kmem_cache_alloc_node(c->name, caller, b, c->object_size,
 					    PAGE_SIZE << get_order(c->size),
 					    flags, node);
 	}
@@ -648,7 +648,7 @@ static void kmem_rcu_free(struct rcu_head *head)
 void kmem_cache_free(struct kmem_cache *c, void *b)
 {
 	kmemleak_free_recursive(b, c->flags);
-	trace_kmem_cache_free(_RET_IP_, b, c->name);
+	trace_kmem_cache_free(c->name, _RET_IP_, b);
 	if (unlikely(c->flags & SLAB_TYPESAFE_BY_RCU)) {
 		struct slob_rcu *slob_rcu;
 		slob_rcu = b + (c->size - sizeof(struct slob_rcu));
diff --git a/mm/slub.c b/mm/slub.c
index 1dc9e8eebb62..de03fa1f5667 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3215,7 +3215,7 @@ void *__kmem_cache_alloc_node(struct kmem_cache *s, struct list_lru *lru, gfp_t
 {
 	void *ret = slab_alloc_node(s, lru, gfpflags, node, caller, s->object_size);
 
-	trace_kmem_cache_alloc_node(caller, ret, s->object_size,
+	trace_kmem_cache_alloc_node(s->name, caller, ret, s->object_size,
 				    s->size, gfpflags, node);
 
 	return ret;
@@ -3229,7 +3229,7 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *s,
 {
 	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, size);
 
-	trace_kmalloc_node(_RET_IP_, ret,
+	trace_kmalloc_node(s->name, _RET_IP_, ret,
 			   size, s->size, gfpflags, node);
 
 	ret = kasan_kmalloc(s, ret, size, gfpflags);
@@ -3471,7 +3471,7 @@ void kmem_cache_free(struct kmem_cache *s, void *x)
 	s = cache_from_obj(s, x);
 	if (!s)
 		return;
-	trace_kmem_cache_free(_RET_IP_, x, s->name);
+	trace_kmem_cache_free(s->name, _RET_IP_, x);
 	slab_free(s, virt_to_slab(x), x, NULL, 1, _RET_IP_);
 }
 EXPORT_SYMBOL(kmem_cache_free);
@@ -4352,7 +4352,7 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node)
 
 	ret = slab_alloc_node(s, NULL, flags, node, _RET_IP_, size);
 
-	trace_kmalloc_node(_RET_IP_, ret, size, s->size, flags, node);
+	trace_kmalloc_node(s->name, _RET_IP_, ret, size, s->size, flags, node);
 
 	ret = kasan_kmalloc(s, ret, size, flags);
 
@@ -4811,7 +4811,7 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
 	ret = slab_alloc_node(s, NULL, gfpflags, node, caller, size);
 
 	/* Honor the call site pointer we received. */
-	trace_kmalloc_node(caller, ret, size, s->size, gfpflags, node);
+	trace_kmalloc_node(s->name, caller, ret, size, s->size, gfpflags, node);
 
 	return ret;
 }
-- 
2.32.0


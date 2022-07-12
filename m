Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CFF571B8A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbiGLNll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbiGLNlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:41:00 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C61B62BC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:40:37 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id l12so7259064plk.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b4Q2DizgZQ7+TOz0Lfpsus9sxOwctEnm3EGP0luNKvc=;
        b=Acp7Bhbzyn+BRSc46G6x84g73Tw4ndAXZDLldyVmCJ+U20+G3ciC+yKKrfTvwDE6pG
         pQk1btbM2obsHmUCgSE/PTl7RxG55Ej0Pd4NjjG3vQrJfV87P9dgOMSJv9O2t4dHUbuh
         XoJVa5Be5JIoWCpPJ0T435LMyzlz7GuVTZCbgrPNY0yZlIdWzCyLnidk//LtPJEkXbBg
         8VFWiaSyg96ki4IbCaIcOqag/dOsmzKkC8KgKeHROonDba2qt7L75wuLEoD/StNuCXrE
         7L958AhQNtelYlCQrvewCcG/2Xa0YLETnPj3+OQtaPDIYn9TkGQ+YJ/IgrYNO5KkinEJ
         jkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b4Q2DizgZQ7+TOz0Lfpsus9sxOwctEnm3EGP0luNKvc=;
        b=sE+UmdN6lN6lO3NG7WHVdjUH4rlSRRQ2JZY/mP75jBLSzIoqAh+CwCXfhUzhPKVL+n
         suzRPWo87nwWvsvpkp160DOGk9U/cigI6rFrC1dJ/FKnSugWrQOu4rb+s+YE0rUl9/GR
         gL23UeKznzxxoH3XQM06rARltlO8bL4OIuzSfdpXN+CX7Vugeg6eSoFLLLDtAmKcPnos
         hcDjn00RvhEF7paa7u+AZuVZqTZGnC3p4jXKmjnY5f2EUs5ws3Zfwr8oiBzD4h79YS21
         0LarVoRbG5p/o/SLtRXvZLS3T5cgXNfWpatocDTR/Jp1vFHpdOXyJ5VwWKM4QyZLgpDS
         BI8g==
X-Gm-Message-State: AJIora8vJswYqoVI0xThe8EZOcaA5N1g1znUzByE+j5Rbz3J0TDBJItz
        QjNjrvdqwRX1tjpxdzubuuc=
X-Google-Smtp-Source: AGRyM1sgMYok3oEVFyOdPn8DbpTggXv3T7w8m3KYlxLN5tpjjqCL6r0ashabKK5/3Nn7FtX+QyDF0g==
X-Received: by 2002:a17:90b:4acb:b0:1f0:62ab:2956 with SMTP id mh11-20020a17090b4acb00b001f062ab2956mr3298811pjb.178.1657633237177;
        Tue, 12 Jul 2022 06:40:37 -0700 (PDT)
Received: from ip-172-31-24-42.ap-northeast-1.compute.internal (ec2-35-75-15-180.ap-northeast-1.compute.amazonaws.com. [35.75.15.180])
        by smtp.gmail.com with ESMTPSA id r6-20020aa79886000000b0052ae3bcb807sm1947178pfl.188.2022.07.12.06.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 06:40:36 -0700 (PDT)
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
Subject: [PATCH v3 13/15] mm/slab_common: unify NUMA and UMA version of tracepoints
Date:   Tue, 12 Jul 2022 13:39:43 +0000
Message-Id: <20220712133946.307181-14-42.hyeyoo@gmail.com>
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

Drop kmem_alloc event class, rename kmem_alloc_node to kmem_alloc, and
remove _node postfix for NUMA version of tracepoints.

This will break some tools that depend on {kmem_cache_alloc,kmalloc}_node,
but at this point maintaining both kmem_alloc and kmem_alloc_node
event classes does not makes sense at all.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 include/trace/events/kmem.h | 60 ++-----------------------------------
 mm/slab.c                   | 18 +++++------
 mm/slab_common.c            | 18 +++++------
 mm/slob.c                   | 20 ++++++-------
 mm/slub.c                   | 12 ++++----
 5 files changed, 35 insertions(+), 93 deletions(-)

diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index 4cb51ace600d..e078ebcdc4b1 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -11,62 +11,6 @@
 
 DECLARE_EVENT_CLASS(kmem_alloc,
 
-	TP_PROTO(unsigned long call_site,
-		 const void *ptr,
-		 struct kmem_cache *s,
-		 size_t bytes_req,
-		 size_t bytes_alloc,
-		 gfp_t gfp_flags),
-
-	TP_ARGS(call_site, ptr, s, bytes_req, bytes_alloc, gfp_flags),
-
-	TP_STRUCT__entry(
-		__field(	unsigned long,	call_site	)
-		__field(	const void *,	ptr		)
-		__field(	size_t,		bytes_req	)
-		__field(	size_t,		bytes_alloc	)
-		__field(	unsigned long,	gfp_flags	)
-		__field(	bool,		accounted	)
-	),
-
-	TP_fast_assign(
-		__entry->call_site	= call_site;
-		__entry->ptr		= ptr;
-		__entry->bytes_req	= bytes_req;
-		__entry->bytes_alloc	= bytes_alloc;
-		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
-		__entry->accounted	= IS_ENABLED(CONFIG_MEMCG_KMEM) ?
-					  ((gfp_flags & __GFP_ACCOUNT) ||
-					  (s && s->flags & SLAB_ACCOUNT)) : false;
-	),
-
-	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s accounted=%s",
-		(void *)__entry->call_site,
-		__entry->ptr,
-		__entry->bytes_req,
-		__entry->bytes_alloc,
-		show_gfp_flags(__entry->gfp_flags),
-		__entry->accounted ? "true" : "false")
-);
-
-DEFINE_EVENT(kmem_alloc, kmalloc,
-
-	TP_PROTO(unsigned long call_site, const void *ptr, struct kmem_cache *s,
-		 size_t bytes_req, size_t bytes_alloc, gfp_t gfp_flags),
-
-	TP_ARGS(call_site, ptr, s, bytes_req, bytes_alloc, gfp_flags)
-);
-
-DEFINE_EVENT(kmem_alloc, kmem_cache_alloc,
-
-	TP_PROTO(unsigned long call_site, const void *ptr, struct kmem_cache *s,
-		 size_t bytes_req, size_t bytes_alloc, gfp_t gfp_flags),
-
-	TP_ARGS(call_site, ptr, s, bytes_req, bytes_alloc, gfp_flags)
-);
-
-DECLARE_EVENT_CLASS(kmem_alloc_node,
-
 	TP_PROTO(unsigned long call_site,
 		 const void *ptr,
 		 struct kmem_cache *s,
@@ -109,7 +53,7 @@ DECLARE_EVENT_CLASS(kmem_alloc_node,
 		__entry->accounted ? "true" : "false")
 );
 
-DEFINE_EVENT(kmem_alloc_node, kmalloc_node,
+DEFINE_EVENT(kmem_alloc, kmalloc,
 
 	TP_PROTO(unsigned long call_site, const void *ptr,
 		 struct kmem_cache *s, size_t bytes_req, size_t bytes_alloc,
@@ -118,7 +62,7 @@ DEFINE_EVENT(kmem_alloc_node, kmalloc_node,
 	TP_ARGS(call_site, ptr, s, bytes_req, bytes_alloc, gfp_flags, node)
 );
 
-DEFINE_EVENT(kmem_alloc_node, kmem_cache_alloc_node,
+DEFINE_EVENT(kmem_alloc, kmem_cache_alloc,
 
 	TP_PROTO(unsigned long call_site, const void *ptr,
 		 struct kmem_cache *s, size_t bytes_req, size_t bytes_alloc,
diff --git a/mm/slab.c b/mm/slab.c
index 6407dad13d5c..a361d2f9d4d9 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3440,8 +3440,8 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru,
 {
 	void *ret = slab_alloc(cachep, lru, flags, cachep->object_size, _RET_IP_);
 
-	trace_kmem_cache_alloc(_RET_IP_, ret, cachep,
-			       cachep->object_size, cachep->size, flags);
+	trace_kmem_cache_alloc(_RET_IP_, ret, cachep, cachep->object_size,
+			       cachep->size, flags, NUMA_NO_NODE);
 
 	return ret;
 }
@@ -3529,7 +3529,7 @@ kmem_cache_alloc_trace(struct kmem_cache *cachep, gfp_t flags, size_t size)
 
 	ret = kasan_kmalloc(cachep, ret, size, flags);
 	trace_kmalloc(_RET_IP_, ret, cachep,
-		      size, cachep->size, flags);
+		      size, cachep->size, flags, NUMA_NO_NODE);
 	return ret;
 }
 EXPORT_SYMBOL(kmem_cache_alloc_trace);
@@ -3552,9 +3552,9 @@ void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)
 {
 	void *ret = slab_alloc_node(cachep, NULL, flags, nodeid, cachep->object_size, _RET_IP_);
 
-	trace_kmem_cache_alloc_node(_RET_IP_, ret, cachep,
-				    cachep->object_size, cachep->size,
-				    flags, nodeid);
+	trace_kmem_cache_alloc(_RET_IP_, ret, cachep,
+			       cachep->object_size, cachep->size,
+			       flags, nodeid);
 
 	return ret;
 }
@@ -3579,9 +3579,9 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
 	ret = slab_alloc_node(cachep, NULL, flags, nodeid, size, _RET_IP_);
 
 	ret = kasan_kmalloc(cachep, ret, size, flags);
-	trace_kmalloc_node(_RET_IP_, ret, cachep,
-			   size, cachep->size,
-			   flags, nodeid);
+	trace_kmalloc(_RET_IP_, ret, cachep,
+		      size, cachep->size,
+		      flags, nodeid);
 	return ret;
 }
 EXPORT_SYMBOL(kmem_cache_alloc_node_trace);
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 1000e05c77df..0e66b4911ebf 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -933,9 +933,9 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller
 
 	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
 		ret = kmalloc_large_node_notrace(size, flags, node);
-		trace_kmalloc_node(caller, ret, NULL,
-				   size, PAGE_SIZE << get_order(size),
-				   flags, node);
+		trace_kmalloc(_RET_IP_, ret, NULL,
+			      size, PAGE_SIZE << get_order(size),
+			      flags, node);
 		return ret;
 	}
 
@@ -946,8 +946,8 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller
 
 	ret = __kmem_cache_alloc_node(s, flags, node, size, caller);
 	ret = kasan_kmalloc(s, ret, size, flags);
-	trace_kmalloc_node(caller, ret, s, size,
-			   s->size, flags, node);
+	trace_kmalloc(_RET_IP_, ret, s, size,
+		      s->size, flags, node);
 	return ret;
 }
 
@@ -1076,7 +1076,7 @@ void *kmalloc_large(size_t size, gfp_t flags)
 	void *ret = __kmalloc_large_node_notrace(size, flags, NUMA_NO_NODE);
 
 	trace_kmalloc(_RET_IP_, ret, NULL, size,
-		      PAGE_SIZE << get_order(size), flags);
+		      PAGE_SIZE << get_order(size), flags, NUMA_NO_NODE);
 	return ret;
 }
 EXPORT_SYMBOL(kmalloc_large);
@@ -1090,8 +1090,8 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node)
 {
 	void *ret = __kmalloc_large_node_notrace(size, flags, node);
 
-	trace_kmalloc_node(_RET_IP_, ret, NULL, size,
-			   PAGE_SIZE << get_order(size), flags, node);
+	trace_kmalloc(_RET_IP_, ret, NULL, size,
+		      PAGE_SIZE << get_order(size), flags, node);
 	return ret;
 }
 EXPORT_SYMBOL(kmalloc_large_node);
@@ -1426,8 +1426,6 @@ EXPORT_SYMBOL(ksize);
 /* Tracepoints definitions. */
 EXPORT_TRACEPOINT_SYMBOL(kmalloc);
 EXPORT_TRACEPOINT_SYMBOL(kmem_cache_alloc);
-EXPORT_TRACEPOINT_SYMBOL(kmalloc_node);
-EXPORT_TRACEPOINT_SYMBOL(kmem_cache_alloc_node);
 EXPORT_TRACEPOINT_SYMBOL(kfree);
 EXPORT_TRACEPOINT_SYMBOL(kmem_cache_free);
 
diff --git a/mm/slob.c b/mm/slob.c
index 80cdbe4f0d67..a4d50d957c25 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -507,8 +507,8 @@ __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
 		*m = size;
 		ret = (void *)m + minalign;
 
-		trace_kmalloc_node(caller, ret, NULL,
-				   size, size + minalign, gfp, node);
+		trace_kmalloc(caller, ret, NULL,
+			      size, size + minalign, gfp, node);
 	} else {
 		unsigned int order = get_order(size);
 
@@ -516,8 +516,8 @@ __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
 			gfp |= __GFP_COMP;
 		ret = slob_new_pages(gfp, order, node);
 
-		trace_kmalloc_node(caller, ret, NULL,
-				   size, PAGE_SIZE << order, gfp, node);
+		trace_kmalloc(caller, ret, NULL,
+			      size, PAGE_SIZE << order, gfp, node);
 	}
 
 	kmemleak_alloc(ret, size, 1, gfp);
@@ -608,14 +608,14 @@ static void *slob_alloc_node(struct kmem_cache *c, gfp_t flags, int node)
 
 	if (c->size < PAGE_SIZE) {
 		b = slob_alloc(c->size, flags, c->align, node, 0);
-		trace_kmem_cache_alloc_node(_RET_IP_, b, NULL, c->object_size,
-					    SLOB_UNITS(c->size) * SLOB_UNIT,
-					    flags, node);
+		trace_kmem_cache_alloc(_RET_IP_, b, NULL, c->object_size,
+				       SLOB_UNITS(c->size) * SLOB_UNIT,
+				       flags, node);
 	} else {
 		b = slob_new_pages(flags, get_order(c->size), node);
-		trace_kmem_cache_alloc_node(_RET_IP_, b, NULL, c->object_size,
-					    PAGE_SIZE << get_order(c->size),
-					    flags, node);
+		trace_kmem_cache_alloc(_RET_IP_, b, NULL, c->object_size,
+				       PAGE_SIZE << get_order(c->size),
+				       flags, node);
 	}
 
 	if (b && c->ctor) {
diff --git a/mm/slub.c b/mm/slub.c
index 836292c32e58..f1aa51480dc4 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3244,7 +3244,7 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
 	void *ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);
 
 	trace_kmem_cache_alloc(_RET_IP_, ret, s, s->object_size,
-				s->size, gfpflags);
+				s->size, gfpflags, NUMA_NO_NODE);
 
 	return ret;
 }
@@ -3274,7 +3274,7 @@ void *__kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags,
 void *kmem_cache_alloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
 {
 	void *ret = slab_alloc(s, NULL, gfpflags, _RET_IP_, size);
-	trace_kmalloc(_RET_IP_, ret, s, size, s->size, gfpflags);
+	trace_kmalloc(_RET_IP_, ret, s, size, s->size, gfpflags, NUMA_NO_NODE);
 	ret = kasan_kmalloc(s, ret, size, gfpflags);
 	return ret;
 }
@@ -3285,8 +3285,8 @@ void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
 {
 	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, s->object_size);
 
-	trace_kmem_cache_alloc_node(_RET_IP_, ret, s,
-				    s->object_size, s->size, gfpflags, node);
+	trace_kmem_cache_alloc(_RET_IP_, ret, s,
+			       s->object_size, s->size, gfpflags, node);
 
 	return ret;
 }
@@ -3299,8 +3299,8 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *s,
 {
 	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, size);
 
-	trace_kmalloc_node(_RET_IP_, ret, s,
-			   size, s->size, gfpflags, node);
+	trace_kmalloc(_RET_IP_, ret, s,
+		      size, s->size, gfpflags, node);
 
 	ret = kasan_kmalloc(s, ret, size, gfpflags);
 	return ret;
-- 
2.34.1


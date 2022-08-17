Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC10596CC2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 12:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239005AbiHQKU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 06:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238934AbiHQKTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:19:54 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C72482774
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:19:39 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id 2so426642pll.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=CyypfYVW40Zxy99wL/B3ZBuo0BqIs8lbgANQnRCbVC4=;
        b=VUPnz/D4yt281vtciG3zIkCG8wzFEAcCtpanFMktSXNw3J+m8nk9VhKsXldatbEuVk
         7veCFdOCyM5L9juZ7+zaNNDNbCjir0zuhAChAv4ze6fHgRbYNrEp3oGaQe/U+Sf+d5pt
         Yy77QuS5zhR6dRA2l8LZNj5iKE52sp0+6qq2dWEJQDCtO3kbgU9yuiKEqLRhQ36QXUvm
         cULrJbg6FjbXLKN6MOoYW7eIV6hEb5Cl7DuKhA/L7MymZs1HFm2qm8JBfheXLZsYkKbI
         3wuFAByfXclzWmoQct96dE06Q21O52/t2mBW2qED00il5VbqLfUSj0ljRzMRYFcLB7DR
         P65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=CyypfYVW40Zxy99wL/B3ZBuo0BqIs8lbgANQnRCbVC4=;
        b=YNJcw2Tgsa+B8rhruhGe/kP2YJJtRHMfAW5EXBkolwU1EhF6DruMYQLf26ZYNcJNlj
         I7c67xDm9VfyG8JpHzk5Q/su3IfAWwO+Oa2IodIUgr/c6fdr920UmmXdNM8zDO0LJhZu
         EDAvbIOR+rgg9sq8C8fYICVsg5Bi0DBaxX8XGhXwrW8U/eIyrSJD1UyMCfPcGZqu5USL
         uIAM+RtL9YpTYzVJXmkUkyjOhBqI1Hq/nEDgq4Ik5VuKDCXi2UcYXTxzW4WRESDYuxsd
         zdPKWfUJg0iYlYYB+nAfqcpKwnu5pfery9HaJGHUE6Xf7KU7boSOnkFVGqYZJ/MEK+NG
         23bA==
X-Gm-Message-State: ACgBeo2Y6TNzbJS2IBq3orvErId5CTUzGN8BDwccOWnNFGSmdTbqtGDh
        jy3fl1AdBqr0olqRPBZ84WE=
X-Google-Smtp-Source: AA6agR4ltHmPKihrwg6pI9XNaqqOJ7qEKaijv1U195SEBQTrbkQ2dpNmYsxi6ciIdPMPJQ90fxJE7g==
X-Received: by 2002:a17:90b:390c:b0:1f5:5bbc:2e8 with SMTP id ob12-20020a17090b390c00b001f55bbc02e8mr3047899pjb.233.1660731578454;
        Wed, 17 Aug 2022 03:19:38 -0700 (PDT)
Received: from hyeyoo.. ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id d8-20020a170903230800b00172633fc236sm1071318plh.174.2022.08.17.03.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 03:19:37 -0700 (PDT)
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
Subject: [PATCH v4 14/17] mm/slab_common: unify NUMA and UMA version of tracepoints
Date:   Wed, 17 Aug 2022 19:18:23 +0900
Message-Id: <20220817101826.236819-15-42.hyeyoo@gmail.com>
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

Drop kmem_alloc event class, rename kmem_alloc_node to kmem_alloc, and
remove _node postfix for NUMA version of tracepoints.

This will break some tools that depend on {kmem_cache_alloc,kmalloc}_node,
but at this point maintaining both kmem_alloc and kmem_alloc_node
event classes does not makes sense at all.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/trace/events/kmem.h | 60 ++-----------------------------------
 mm/slab.c                   |  9 +++---
 mm/slab_common.c            | 21 +++++--------
 mm/slob.c                   | 20 ++++++-------
 mm/slub.c                   |  6 ++--
 5 files changed, 27 insertions(+), 89 deletions(-)

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
index 8d9d0fbf9792..2fd400203ac2 100644
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
@@ -3536,9 +3536,8 @@ void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)
 {
 	void *ret = slab_alloc_node(cachep, NULL, flags, nodeid, cachep->object_size, _RET_IP_);
 
-	trace_kmem_cache_alloc_node(_RET_IP_, ret, cachep,
-				    cachep->object_size, cachep->size,
-				    flags, nodeid);
+	trace_kmem_cache_alloc(_RET_IP_, ret, cachep, cachep->object_size,
+			       cachep->size, flags, nodeid);
 
 	return ret;
 }
diff --git a/mm/slab_common.c b/mm/slab_common.c
index d8e8c41c12f1..f34be57b00c8 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -907,9 +907,8 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller
 
 	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
 		ret = __kmalloc_large_node(size, flags, node);
-		trace_kmalloc_node(caller, ret, NULL,
-				   size, PAGE_SIZE << get_order(size),
-				   flags, node);
+		trace_kmalloc(_RET_IP_, ret, NULL, size,
+			      PAGE_SIZE << get_order(size), flags, node);
 		return ret;
 	}
 
@@ -920,8 +919,7 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller
 
 	ret = __kmem_cache_alloc_node(s, flags, node, size, caller);
 	ret = kasan_kmalloc(s, ret, size, flags);
-	trace_kmalloc_node(caller, ret, s, size,
-			   s->size, flags, node);
+	trace_kmalloc(_RET_IP_, ret, s, size, s->size, flags, node);
 	return ret;
 }
 
@@ -1007,8 +1005,7 @@ void *kmalloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
 	void *ret = __kmem_cache_alloc_node(s, gfpflags, NUMA_NO_NODE,
 					    size, _RET_IP_);
 
-	trace_kmalloc_node(_RET_IP_, ret, s, size, s->size,
-			   gfpflags, NUMA_NO_NODE);
+	trace_kmalloc(_RET_IP_, ret, s, size, s->size, gfpflags, NUMA_NO_NODE);
 
 	ret = kasan_kmalloc(s, ret, size, gfpflags);
 	return ret;
@@ -1020,7 +1017,7 @@ void *kmalloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
 {
 	void *ret = __kmem_cache_alloc_node(s, gfpflags, node, size, _RET_IP_);
 
-	trace_kmalloc_node(_RET_IP_, ret, s, size, s->size, gfpflags, node);
+	trace_kmalloc(_RET_IP_, ret, s, size, s->size, gfpflags, node);
 
 	ret = kasan_kmalloc(s, ret, size, gfpflags);
 	return ret;
@@ -1076,7 +1073,7 @@ void *kmalloc_large(size_t size, gfp_t flags)
 	void *ret = __kmalloc_large_node(size, flags, NUMA_NO_NODE);
 
 	trace_kmalloc(_RET_IP_, ret, NULL, size,
-		      PAGE_SIZE << get_order(size), flags);
+		      PAGE_SIZE << get_order(size), flags, NUMA_NO_NODE);
 	return ret;
 }
 EXPORT_SYMBOL(kmalloc_large);
@@ -1085,8 +1082,8 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node)
 {
 	void *ret = __kmalloc_large_node(size, flags, node);
 
-	trace_kmalloc_node(_RET_IP_, ret, NULL, size,
-			   PAGE_SIZE << get_order(size), flags, node);
+	trace_kmalloc(_RET_IP_, ret, NULL, size,
+		      PAGE_SIZE << get_order(size), flags, node);
 	return ret;
 }
 EXPORT_SYMBOL(kmalloc_large_node);
@@ -1421,8 +1418,6 @@ EXPORT_SYMBOL(ksize);
 /* Tracepoints definitions. */
 EXPORT_TRACEPOINT_SYMBOL(kmalloc);
 EXPORT_TRACEPOINT_SYMBOL(kmem_cache_alloc);
-EXPORT_TRACEPOINT_SYMBOL(kmalloc_node);
-EXPORT_TRACEPOINT_SYMBOL(kmem_cache_alloc_node);
 EXPORT_TRACEPOINT_SYMBOL(kfree);
 EXPORT_TRACEPOINT_SYMBOL(kmem_cache_free);
 
diff --git a/mm/slob.c b/mm/slob.c
index 96b08acd72ce..3208c56d8f82 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -507,8 +507,8 @@ __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
 		*m = size;
 		ret = (void *)m + minalign;
 
-		trace_kmalloc_node(caller, ret, NULL,
-				   size, size + minalign, gfp, node);
+		trace_kmalloc(caller, ret, NULL, size,
+			      size + minalign, gfp, node);
 	} else {
 		unsigned int order = get_order(size);
 
@@ -516,8 +516,8 @@ __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
 			gfp |= __GFP_COMP;
 		ret = slob_new_pages(gfp, order, node);
 
-		trace_kmalloc_node(caller, ret, NULL,
-				   size, PAGE_SIZE << order, gfp, node);
+		trace_kmalloc(caller, ret, NULL, size,
+			      PAGE_SIZE << order, gfp, node);
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
index 7d7fd9d4e8fa..22e4ccf06638 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3244,7 +3244,7 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
 	void *ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);
 
 	trace_kmem_cache_alloc(_RET_IP_, ret, s, s->object_size,
-				s->size, gfpflags);
+				s->size, gfpflags, NUMA_NO_NODE);
 
 	return ret;
 }
@@ -3274,8 +3274,8 @@ void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
 {
 	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, s->object_size);
 
-	trace_kmem_cache_alloc_node(_RET_IP_, ret, s,
-				    s->object_size, s->size, gfpflags, node);
+	trace_kmem_cache_alloc(_RET_IP_, ret, s, s->object_size,
+			       s->size, gfpflags, node);
 
 	return ret;
 }
-- 
2.32.0


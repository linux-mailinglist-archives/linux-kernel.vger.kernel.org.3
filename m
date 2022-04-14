Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA929500928
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241410AbiDNJCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241390AbiDNJBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:01:46 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7363A6E4EB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:59:12 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id j8so4102602pll.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zvTeNbwSFjzmp95ydPU9GCtKAlIW9evNe2EP9XmPg9o=;
        b=hmWMAwYx5oUL6Wp1vBwdgXwIs13Q82Au0zsJ0XWS5lPSR0hfPBYvajbkN6qAoJ8byF
         Ehy6dZvmsU1vgtuxXzAv8G4WRBh0JrSQ4mdLJrZtn3CXWroWBp0IHkf6cR2dkSA6Lk3t
         2J9uBipPAZox0QxR1ftuERIiFWcQW88Anpmeyw6rxE6Dn2DrRWab3XbnMNVauFoqOIAN
         6E3ngfB68K0eg1wm9ONKS/wdheLAGTGkPrZWfHyyg8jeHae3uw33bTDlHIjJZd0IIrtn
         zpFyZ7+az7oHtTl84AG24h1/PDCZSsqUxrF6Q4z9a8avFhEQ/Be5CuwkRqjuSs6YddXW
         a/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zvTeNbwSFjzmp95ydPU9GCtKAlIW9evNe2EP9XmPg9o=;
        b=XB7AqFivhuDcMvNkPY5ijFh4WcbiXNfP4/NAhbf3xvctz5eOmSHUVy3/sjmmmU+nwO
         KD1C/xPOgJNoIftunTpH7oco9xtorgrrVwIE2gDICjm43o1o9CxVfsez+RkTZrZTD8xF
         FyoeMNY0ehzakj0BTEzPtwhA/TlN2whi2doDXlyByZ426zeFsRAEofzzn48x+GEjSMGI
         lT2L6DQk5QPxrpR274+nqpxeTE4FhQrm8hENDjW97PD+ZrMFQrpP4Su1hk4lw1mOu1w2
         NtdcpEaZd9iWvojTgsWuoF2IZdh4o1GfD8xrB/Cxq20ytYQbIkGANxS6eK6TKeQ7clGL
         eCrw==
X-Gm-Message-State: AOAM533ERe+vIBnKZ8c1S5fBkjKap8ZdyAMl+1v9QWZkWFRN5xdW19jj
        Zvyyadjpx9tMKepYwf1E4C4=
X-Google-Smtp-Source: ABdhPJx7jNnY5ayXMUX9R/+plcepj453EBGZ/mxvajewMlzF9iepLcw0FshfUCuRkFyU9HwD+z7yfA==
X-Received: by 2002:a17:90b:33ca:b0:1cb:d0c:e1b5 with SMTP id lk10-20020a17090b33ca00b001cb0d0ce1b5mr3165304pjb.178.1649926751818;
        Thu, 14 Apr 2022 01:59:11 -0700 (PDT)
Received: from hyeyoo.. ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id p9-20020aa79e89000000b00505fada20dfsm1403537pfq.117.2022.04.14.01.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:59:10 -0700 (PDT)
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
Subject: [PATCH v2 15/23] mm/slab_common: use same tracepoint in kmalloc and normal caches
Date:   Thu, 14 Apr 2022 17:57:19 +0900
Message-Id: <20220414085727.643099-16-42.hyeyoo@gmail.com>
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

Now that tracepoints print cache names, we can distinguish kmalloc and
normal cache allocations.

Use same tracepoint in kmalloc and normal caches. After this patch,
there is only two tracepoints in slab allocators: kmem_cache_alloc_node
and kmem_cache_free.

Remove all unused tracepoints.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 include/trace/events/kmem.h | 79 -------------------------------------
 mm/slab.c                   |  8 ++--
 mm/slab_common.c            |  9 ++---
 mm/slob.c                   | 14 ++++---
 mm/slub.c                   | 19 +++++----
 5 files changed, 27 insertions(+), 102 deletions(-)

diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index 35e6887c6101..ca67ba5fd76a 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -9,56 +9,6 @@
 #include <linux/tracepoint.h>
 #include <trace/events/mmflags.h>
 
-DECLARE_EVENT_CLASS(kmem_alloc,
-
-	TP_PROTO(unsigned long call_site,
-		 const void *ptr,
-		 size_t bytes_req,
-		 size_t bytes_alloc,
-		 gfp_t gfp_flags),
-
-	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags),
-
-	TP_STRUCT__entry(
-		__field(	unsigned long,	call_site	)
-		__field(	const void *,	ptr		)
-		__field(	size_t,		bytes_req	)
-		__field(	size_t,		bytes_alloc	)
-		__field(	gfp_t,		gfp_flags	)
-	),
-
-	TP_fast_assign(
-		__entry->call_site	= call_site;
-		__entry->ptr		= ptr;
-		__entry->bytes_req	= bytes_req;
-		__entry->bytes_alloc	= bytes_alloc;
-		__entry->gfp_flags	= gfp_flags;
-	),
-
-	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s",
-		(void *)__entry->call_site,
-		__entry->ptr,
-		__entry->bytes_req,
-		__entry->bytes_alloc,
-		show_gfp_flags(__entry->gfp_flags))
-);
-
-DEFINE_EVENT(kmem_alloc, kmalloc,
-
-	TP_PROTO(unsigned long call_site, const void *ptr,
-		 size_t bytes_req, size_t bytes_alloc, gfp_t gfp_flags),
-
-	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags)
-);
-
-DEFINE_EVENT(kmem_alloc, kmem_cache_alloc,
-
-	TP_PROTO(unsigned long call_site, const void *ptr,
-		 size_t bytes_req, size_t bytes_alloc, gfp_t gfp_flags),
-
-	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags)
-);
-
 DECLARE_EVENT_CLASS(kmem_alloc_node,
 
 	TP_PROTO(const char *name,
@@ -101,15 +51,6 @@ DECLARE_EVENT_CLASS(kmem_alloc_node,
 		__entry->node)
 );
 
-DEFINE_EVENT(kmem_alloc_node, kmalloc_node,
-
-	TP_PROTO(const char *name, unsigned long call_site,
-		 const void *ptr, size_t bytes_req, size_t bytes_alloc,
-		 gfp_t gfp_flags, int node),
-
-	TP_ARGS(name, call_site, ptr, bytes_req, bytes_alloc, gfp_flags, node)
-);
-
 DEFINE_EVENT(kmem_alloc_node, kmem_cache_alloc_node,
 
 	TP_PROTO(const char *name, unsigned long call_site,
@@ -119,26 +60,6 @@ DEFINE_EVENT(kmem_alloc_node, kmem_cache_alloc_node,
 	TP_ARGS(name, call_site, ptr, bytes_req, bytes_alloc, gfp_flags, node)
 );
 
-TRACE_EVENT(kfree,
-
-	TP_PROTO(unsigned long call_site, const void *ptr),
-
-	TP_ARGS(call_site, ptr),
-
-	TP_STRUCT__entry(
-		__field(	unsigned long,	call_site	)
-		__field(	const void *,	ptr		)
-	),
-
-	TP_fast_assign(
-		__entry->call_site	= call_site;
-		__entry->ptr		= ptr;
-	),
-
-	TP_printk("call_site=%pS ptr=%p",
-		  (void *)__entry->call_site, __entry->ptr)
-);
-
 TRACE_EVENT(kmem_cache_free,
 
 	TP_PROTO(const char *name, unsigned long call_site, const void *ptr),
diff --git a/mm/slab.c b/mm/slab.c
index 3c47d0979706..b9959a6b5c48 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3519,9 +3519,9 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
 	ret = slab_alloc_node(cachep, NULL, flags, nodeid, size, _RET_IP_);
 
 	ret = kasan_kmalloc(cachep, ret, size, flags);
-	trace_kmalloc_node(cachep->name, _RET_IP_, ret,
-			   size, cachep->size,
-			   flags, nodeid);
+	trace_kmem_cache_alloc_node(cachep->name, _RET_IP_, ret,
+				    size, cachep->size,
+				    flags, nodeid);
 	return ret;
 }
 EXPORT_SYMBOL(kmem_cache_alloc_node_trace);
@@ -3657,7 +3657,6 @@ void kfree(const void *objp)
 	unsigned long flags;
 	struct folio *folio;
 
-	trace_kfree(_RET_IP_, objp);
 
 	if (unlikely(ZERO_OR_NULL_PTR(objp)))
 		return;
@@ -3669,6 +3668,7 @@ void kfree(const void *objp)
 	}
 
 	c = folio_slab(folio)->slab_cache;
+	trace_kmem_cache_free(c->name, _RET_IP_, objp);
 
 	local_irq_save(flags);
 	kfree_debugcheck(objp);
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 416f0a1f17a6..3d1569085c54 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -910,6 +910,7 @@ void free_large_kmalloc(struct folio *folio, void *object)
 	if (WARN_ON_ONCE(order == 0))
 		pr_warn_once("object pointer: 0x%p\n", object);
 
+	trace_kmem_cache_free(KMALLOC_LARGE_NAME, _RET_IP_, object);
 	kmemleak_free(object);
 	kasan_kfree_large(object);
 
@@ -956,8 +957,8 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node)
 	ptr = kasan_kmalloc_large(ptr, size, flags);
 	/* As ptr might get tagged, call kmemleak hook after KASAN. */
 	kmemleak_alloc(ptr, size, 1, flags);
-	trace_kmalloc_node(KMALLOC_LARGE_NAME, _RET_IP_, ptr, size,
-			   PAGE_SIZE << order, flags, node);
+	trace_kmem_cache_alloc_node(KMALLOC_LARGE_NAME, _RET_IP_, ptr, size,
+				    PAGE_SIZE << order, flags, node);
 	return ptr;
 }
 EXPORT_SYMBOL(kmalloc_large_node);
@@ -1290,11 +1291,7 @@ size_t ksize(const void *objp)
 EXPORT_SYMBOL(ksize);
 
 /* Tracepoints definitions. */
-EXPORT_TRACEPOINT_SYMBOL(kmalloc);
-EXPORT_TRACEPOINT_SYMBOL(kmem_cache_alloc);
-EXPORT_TRACEPOINT_SYMBOL(kmalloc_node);
 EXPORT_TRACEPOINT_SYMBOL(kmem_cache_alloc_node);
-EXPORT_TRACEPOINT_SYMBOL(kfree);
 EXPORT_TRACEPOINT_SYMBOL(kmem_cache_free);
 
 int should_failslab(struct kmem_cache *s, gfp_t gfpflags)
diff --git a/mm/slob.c b/mm/slob.c
index 8abde6037d95..b1f291128e94 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -505,8 +505,8 @@ __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
 		*m = size;
 		ret = (void *)m + minalign;
 
-		trace_kmalloc_node(KMALLOC_NAME, caller, ret,
-				   size, size + minalign, gfp, node);
+		trace_kmem_cache_alloc_node(KMALLOC_NAME, caller, ret,
+					    size, size + minalign, gfp, node);
 	} else {
 		unsigned int order = get_order(size);
 
@@ -514,8 +514,9 @@ __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
 			gfp |= __GFP_COMP;
 		ret = slob_new_pages(gfp, order, node);
 
-		trace_kmalloc_node(KMALLOC_LARGE_NAME, caller, ret,
-				   size, PAGE_SIZE << order, gfp, node);
+		trace_kmem_cache_alloc_node(KMALLOC_LARGE_NAME, caller,
+					    ret, size, PAGE_SIZE << order,
+					    gfp, node);
 	}
 
 	kmemleak_alloc(ret, size, 1, gfp);
@@ -533,8 +534,6 @@ void kfree(const void *block)
 {
 	struct folio *sp;
 
-	trace_kfree(_RET_IP_, block);
-
 	if (unlikely(ZERO_OR_NULL_PTR(block)))
 		return;
 	kmemleak_free(block);
@@ -543,10 +542,13 @@ void kfree(const void *block)
 	if (folio_test_slab(sp)) {
 		int align = max_t(size_t, ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN);
 		unsigned int *m = (unsigned int *)(block - align);
+
+		trace_kmem_cache_free(KMALLOC_LARGE_NAME, _RET_IP_, block);
 		slob_free(m, *m + align);
 	} else {
 		unsigned int order = folio_order(sp);
 
+		trace_kmem_cache_free(KMALLOC_NAME, _RET_IP_, block);
 		mod_node_page_state(folio_pgdat(sp), NR_SLAB_UNRECLAIMABLE_B,
 				    -(PAGE_SIZE << order));
 		__free_pages(folio_page(sp, 0), order);
diff --git a/mm/slub.c b/mm/slub.c
index de03fa1f5667..d53e9e22d67e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3229,8 +3229,8 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *s,
 {
 	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, size);
 
-	trace_kmalloc_node(s->name, _RET_IP_, ret,
-			   size, s->size, gfpflags, node);
+	trace_kmem_cache_alloc_node(s->name, _RET_IP_, ret,
+				    size, s->size, gfpflags, node);
 
 	ret = kasan_kmalloc(s, ret, size, gfpflags);
 	return ret;
@@ -4352,7 +4352,8 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node)
 
 	ret = slab_alloc_node(s, NULL, flags, node, _RET_IP_, size);
 
-	trace_kmalloc_node(s->name, _RET_IP_, ret, size, s->size, flags, node);
+	trace_kmem_cache_alloc_node(s->name, _RET_IP_, ret, size,
+				    s->size, flags, node);
 
 	ret = kasan_kmalloc(s, ret, size, flags);
 
@@ -4431,8 +4432,7 @@ void kfree(const void *x)
 	struct folio *folio;
 	struct slab *slab;
 	void *object = (void *)x;
-
-	trace_kfree(_RET_IP_, x);
+	struct kmem_cache *s;
 
 	if (unlikely(ZERO_OR_NULL_PTR(x)))
 		return;
@@ -4442,8 +4442,12 @@ void kfree(const void *x)
 		free_large_kmalloc(folio, object);
 		return;
 	}
+
 	slab = folio_slab(folio);
-	slab_free(slab->slab_cache, slab, object, NULL, 1, _RET_IP_);
+	s = slab->slab_cache;
+
+	trace_kmem_cache_free(s->name, _RET_IP_, x);
+	slab_free(s, slab, object, NULL, 1, _RET_IP_);
 }
 EXPORT_SYMBOL(kfree);
 
@@ -4811,7 +4815,8 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
 	ret = slab_alloc_node(s, NULL, gfpflags, node, caller, size);
 
 	/* Honor the call site pointer we received. */
-	trace_kmalloc_node(s->name, caller, ret, size, s->size, gfpflags, node);
+	trace_kmem_cache_alloc_node(s->name, caller, ret, size,
+				    s->size, gfpflags, node);
 
 	return ret;
 }
-- 
2.32.0


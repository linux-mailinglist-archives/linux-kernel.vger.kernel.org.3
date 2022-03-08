Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7A94D167F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbiCHLo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346630AbiCHLoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:44:05 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FE41FCD3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 03:42:53 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id q11so16809955pln.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 03:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EY3E1MPvA1t7e/Kt56kr9/Hv8whIDrpsa4b0BxWIZKk=;
        b=VVpxcdo9FtcdTxXq+rHzHfEYxY1vnrmOyim9KCBAKXxTRqUs3+/ILCw0C9eO8HYMV4
         hI56Lm/QPs7re3spSrvPvokQ7UmPjRo1dVAOwK5s4wAIRD0nzHegrc5xJlVSXkrC4rPT
         FGD/YcxJyqFPCnYy6JFKu/eWHjHddKK9Re2/a8kINssbT1LwBtHiS3TgQIqMTX7QvfIC
         NFnMhIm6iShaC/VofQjlMt1wc38zEk/YyXy5JxQKDiM/zs3Se7QPM7e+/NtgDmrGc1dD
         2p32tyPgV2Wb84dgCviy2ftACV8prclw69ggZhW7M7zoT9AP2K9f9pSEekEEZy5DscPS
         +4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EY3E1MPvA1t7e/Kt56kr9/Hv8whIDrpsa4b0BxWIZKk=;
        b=r41pXhhVI0VJp7YZ10p1OTfQw+OttYrsIQaEVzrpTVlBPhuDbAfAEeri8zH9cSFq1+
         AgPmOffZJOwVkxdW6KwWZMeqNBpJDOKJbpZdR/DyKA2z14zRIeAagVWSCq54Z18HodAS
         J+OVJ//pQiBK0nGjDU7/NH7hgkRUCc0uhoT/opqLqple/nc0EmZtr536bbWFplCkVYrL
         4b4HrWaK0+KnwjEoml41cFJ0ZWq8+ae9z+t1qsb2w/bLv9D27uuk9hQxcwlekxqC8/1o
         S6KRt/RPpD1nQf2qQ0rp2TwMkoiiFDa7JtIukTa75l/yN4TbZyoD3OqLjGBiuJFpDrje
         XxcA==
X-Gm-Message-State: AOAM530X2soyo49aOStvCULQE5tJRHQkLhX6t2Iqo0Zr853O2vKy+x2W
        NEGuk70NmtRRqUQSFDfUZtM=
X-Google-Smtp-Source: ABdhPJzy9xk6Fl6a/TMkxCpgxDYIH9ok/AIGZ/pNatXCWBpe2m5/fCkr73+hsKNMzxXlulkfTk/f9g==
X-Received: by 2002:a17:90b:4d8a:b0:1be:f5f1:89d3 with SMTP id oj10-20020a17090b4d8a00b001bef5f189d3mr4258302pjb.79.1646739772579;
        Tue, 08 Mar 2022 03:42:52 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090ac40200b001bd0e552d27sm2578285pjt.11.2022.03.08.03.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 03:42:52 -0800 (PST)
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
Subject: [RFC PATCH v1 11/15] mm/sl[auo]b: use same tracepoint in kmalloc and normal caches
Date:   Tue,  8 Mar 2022 11:41:38 +0000
Message-Id: <20220308114142.1744229-12-42.hyeyoo@gmail.com>
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
 mm/slab_common.c            |  5 ++-
 mm/slob.c                   | 14 ++++---
 mm/slub.c                   | 19 +++++----
 5 files changed, 27 insertions(+), 98 deletions(-)

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
index e451f8136066..702a78f64b44 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3554,9 +3554,9 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
 	ret = slab_alloc_node(cachep, flags, nodeid, size, _RET_IP_);
 
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
@@ -3692,7 +3692,6 @@ void kfree(const void *objp)
 	struct folio *folio;
 	void *x = (void *) objp;
 
-	trace_kfree(_RET_IP_, objp);
 
 	if (unlikely(ZERO_OR_NULL_PTR(objp)))
 		return;
@@ -3704,6 +3703,7 @@ void kfree(const void *objp)
 	}
 
 	c = folio_slab(folio)->slab_cache;
+	trace_kmem_cache_free(c->name, _RET_IP_, objp);
 
 	local_irq_save(flags);
 	kfree_debugcheck(objp);
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 03949445c5fc..8a8330a777f5 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -917,6 +917,7 @@ void free_large_kmalloc(struct folio *folio, void *object)
 	if (WARN_ON_ONCE(order == 0))
 		pr_warn_once("object pointer: 0x%p\n", object);
 
+	trace_kmem_cache_free(KMALLOC_LARGE_NAME, _RET_IP_, object);
 	kmemleak_free(object);
 	kasan_kfree_large(object);
 
@@ -962,8 +963,8 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node)
 	ptr = kasan_kmalloc_large(ptr, size, flags);
 	/* As ptr might get tagged, call kmemleak hook after KASAN. */
 	kmemleak_alloc(ptr, size, 1, flags);
-	trace_kmalloc_node(KMALLOC_LARGE_NAME, _RET_IP_, ptr, size,
-			   PAGE_SIZE << order, flags, node);
+	trace_kmem_cache_alloc_node(KMALLOC_LARGE_NAME, _RET_IP_, ptr, size,
+				    PAGE_SIZE << order, flags, node);
 	return ptr;
 
 }
diff --git a/mm/slob.c b/mm/slob.c
index d60175c9bb1b..3726b77a066b 100644
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
index 8a23d1f9507d..c2e713bdb26c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3241,8 +3241,8 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *s,
 {
 	void *ret = slab_alloc_node(s, gfpflags, node, _RET_IP_, size);
 
-	trace_kmalloc_node(s->name, _RET_IP_, ret,
-			   size, s->size, gfpflags, node);
+	trace_kmem_cache_alloc_node(s->name, _RET_IP_, ret,
+				    size, s->size, gfpflags, node);
 
 	ret = kasan_kmalloc(s, ret, size, gfpflags);
 	return ret;
@@ -4366,7 +4366,8 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node)
 
 	ret = slab_alloc_node(s, flags, node, _RET_IP_, size);
 
-	trace_kmalloc_node(s->name, _RET_IP_, ret, size, s->size, flags, node);
+	trace_kmem_cache_alloc_node(s->name, _RET_IP_, ret, size,
+				    s->size, flags, node);
 
 	ret = kasan_kmalloc(s, ret, size, flags);
 
@@ -4445,8 +4446,7 @@ void kfree(const void *x)
 	struct folio *folio;
 	struct slab *slab;
 	void *object = (void *)x;
-
-	trace_kfree(_RET_IP_, x);
+	struct kmem_cache *s;
 
 	if (unlikely(ZERO_OR_NULL_PTR(x)))
 		return;
@@ -4456,8 +4456,12 @@ void kfree(const void *x)
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
 
@@ -4825,7 +4829,8 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
 	ret = slab_alloc_node(s, gfpflags, node, caller, size);
 
 	/* Honor the call site pointer we received. */
-	trace_kmalloc_node(s->name, caller, ret, size, s->size, gfpflags, node);
+	trace_kmem_cache_alloc_node(s->name, caller, ret, size,
+				    s->size, gfpflags, node);
 
 	return ret;
 }
-- 
2.33.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C444D1676
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346584AbiCHLoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346609AbiCHLoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:44:03 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1911AF00
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 03:42:50 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id t14so16232374pgr.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 03:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XKf/iqJDpGTI9wtLvHAGUNI7LJwe6P2neDLVrQRTFRI=;
        b=q1Od24w4Tf+snqyvnattUx0RFmfogqMnczlUVrKOWVMhj4xApjQspsebHG4nsXHY4i
         WPa8noaO603ML05jATKHlqLGYX+jhX+iaLMGbnHQbpqRXPr6BCbWfbv54E6TvZKcyXhm
         jq3c39jQeU9k5iZ5L5UxXEAUI6O3gkNF0/iApp+9KCT2U0PtEkXJ49Oh/hDV8mtWOuXV
         ++GRjFna+Kinv6qQlJpaSVEFB3HgXzgcQe9c4qEnUYOzopxqeiOhEcOhJRv6e1r6deM/
         vByz90tVO0PbmWu4bceKgXtITvMnlnyKc5+0m1L6KVEkFgDZYXuxZQIJw+E6hZ5dfWuc
         yyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XKf/iqJDpGTI9wtLvHAGUNI7LJwe6P2neDLVrQRTFRI=;
        b=1RNQRVjOe/xuubUeUguyFT4804dwpgUB8MuCFeYoaZUBlR3zLQ88vooHMRUvvR30zZ
         13X6E8VvlecKmthTbmQff9j378CCwVFKhbcLWYqTGluS9evyyfm7ntOEWEiR+A2kixAo
         1i5BfAq7KhnhF1m7XPm09CnZ5HiZGoHekuo0o61MPNnbmJuCdwcN2iKNoXt6vK2xfHoz
         aURXVd7g7y3eANMGYZFRMOkrxzClSjTB9yp9mkpSewP7Zj8xD6NsYhENGUos8w9RjGKT
         IBpizgfyKQ7J1zCQ79Ysk2D1BPyegJFn9t0RUQzBc7Gs1hLyVroGCzicnHekSPbtpi2r
         ww/g==
X-Gm-Message-State: AOAM530TepTpwqkP+Eo+QgZ0di1fcSAR8JFmGNrcOEMP8vo9yMPQztDy
        tYkwX2q1gydkk+PqTbeZToE=
X-Google-Smtp-Source: ABdhPJwNTwWDUFchB/w2OL99S+LVAP0tnY/Bi7fUH+GehJyk3z+FJYzWGHZbe6+TUZ04AdVzCOp9Mg==
X-Received: by 2002:a65:568b:0:b0:378:86b8:9426 with SMTP id v11-20020a65568b000000b0037886b89426mr13429924pgs.70.1646739769485;
        Tue, 08 Mar 2022 03:42:49 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090ac40200b001bd0e552d27sm2578285pjt.11.2022.03.08.03.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 03:42:48 -0800 (PST)
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
Subject: [RFC PATCH v1 10/15] mm/sl[auo]b: print cache name in tracepoints
Date:   Tue,  8 Mar 2022 11:41:37 +0000
Message-Id: <20220308114142.1744229-11-42.hyeyoo@gmail.com>
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

Print cache name in tracepoints. If there is no corresponding cache
(kmalloc in SLOB or kmalloc_large_node), use KMALLOC_{,LARGE_}NAME
macro.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 include/trace/events/kmem.h | 34 +++++++++++++++++++---------------
 mm/slab.c                   |  6 +++---
 mm/slab.h                   |  4 ++++
 mm/slab_common.c            |  4 ++--
 mm/slob.c                   | 10 +++++-----
 mm/slub.c                   | 10 +++++-----
 6 files changed, 38 insertions(+), 30 deletions(-)

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
index f0041f0125ba..e451f8136066 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3536,7 +3536,7 @@ void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)
 {
 	void *ret = slab_alloc_node(cachep, flags, nodeid, cachep->object_size, _RET_IP_);
 
-	trace_kmem_cache_alloc_node(_RET_IP_, ret,
+	trace_kmem_cache_alloc_node(cachep->name, _RET_IP_, ret,
 				    cachep->object_size, cachep->size,
 				    flags, nodeid);
 
@@ -3554,7 +3554,7 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
 	ret = slab_alloc_node(cachep, flags, nodeid, size, _RET_IP_);
 
 	ret = kasan_kmalloc(cachep, ret, size, flags);
-	trace_kmalloc_node(_RET_IP_, ret,
+	trace_kmalloc_node(cachep->name, _RET_IP_, ret,
 			   size, cachep->size,
 			   flags, nodeid);
 	return ret;
@@ -3628,7 +3628,7 @@ void kmem_cache_free(struct kmem_cache *cachep, void *objp)
 	if (!cachep)
 		return;
 
-	trace_kmem_cache_free(_RET_IP_, objp, cachep->name);
+	trace_kmem_cache_free(cachep->name, _RET_IP_, objp);
 	local_irq_save(flags);
 	debug_check_no_locks_freed(objp, cachep->object_size);
 	if (!(cachep->flags & SLAB_DEBUG_OBJECTS))
diff --git a/mm/slab.h b/mm/slab.h
index eb6e26784d69..bfedfe3900bb 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -274,6 +274,10 @@ void create_kmalloc_caches(slab_flags_t);
 struct kmem_cache *kmalloc_slab(size_t, gfp_t);
 #endif
 
+/* cache names for tracepoints where it has no corresponding cache  */
+#define KMALLOC_LARGE_NAME "kmalloc_large_node"
+#define KMALLOC_NAME "kmalloc_node"
+
 gfp_t kmalloc_fix_flags(gfp_t flags);
 
 /* Functions provided by the slab allocators */
diff --git a/mm/slab_common.c b/mm/slab_common.c
index af67005a151f..03949445c5fc 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -962,8 +962,8 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node)
 	ptr = kasan_kmalloc_large(ptr, size, flags);
 	/* As ptr might get tagged, call kmemleak hook after KASAN. */
 	kmemleak_alloc(ptr, size, 1, flags);
-	trace_kmalloc_node(_RET_IP_, ptr, size, PAGE_SIZE << order, flags,
-			   node);
+	trace_kmalloc_node(KMALLOC_LARGE_NAME, _RET_IP_, ptr, size,
+			   PAGE_SIZE << order, flags, node);
 	return ptr;
 
 }
diff --git a/mm/slob.c b/mm/slob.c
index c4f9c83900b0..d60175c9bb1b 100644
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
 
@@ -596,12 +596,12 @@ static void *slob_alloc_node(struct kmem_cache *c, gfp_t flags, int node)
 
 	if (c->size < PAGE_SIZE) {
 		b = slob_alloc(c->size, flags, c->align, node, 0);
-		trace_kmem_cache_alloc_node(_RET_IP_, b, c->object_size,
+		trace_kmem_cache_alloc_node(c->name, _RET_IP_, b, c->object_size,
 					    SLOB_UNITS(c->size) * SLOB_UNIT,
 					    flags, node);
 	} else {
 		b = slob_new_pages(flags, get_order(c->size), node);
-		trace_kmem_cache_alloc_node(_RET_IP_, b, c->object_size,
+		trace_kmem_cache_alloc_node(c->name, _RET_IP_, b, c->object_size,
 					    PAGE_SIZE << get_order(c->size),
 					    flags, node);
 	}
@@ -646,7 +646,7 @@ static void kmem_rcu_free(struct rcu_head *head)
 void kmem_cache_free(struct kmem_cache *c, void *b)
 {
 	kmemleak_free_recursive(b, c->flags);
-	trace_kmem_cache_free(_RET_IP_, b, c->name);
+	trace_kmem_cache_free(c->name, _RET_IP_, b);
 	if (unlikely(c->flags & SLAB_TYPESAFE_BY_RCU)) {
 		struct slob_rcu *slob_rcu;
 		slob_rcu = b + (c->size - sizeof(struct slob_rcu));
diff --git a/mm/slub.c b/mm/slub.c
index 283c4ac92ffe..8a23d1f9507d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3228,7 +3228,7 @@ void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
 {
 	void *ret = slab_alloc_node(s, gfpflags, node, _RET_IP_, s->object_size);
 
-	trace_kmem_cache_alloc_node(_RET_IP_, ret,
+	trace_kmem_cache_alloc_node(s->name, _RET_IP_, ret,
 				    s->object_size, s->size, gfpflags, node);
 
 	return ret;
@@ -3241,7 +3241,7 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *s,
 {
 	void *ret = slab_alloc_node(s, gfpflags, node, _RET_IP_, size);
 
-	trace_kmalloc_node(_RET_IP_, ret,
+	trace_kmalloc_node(s->name, _RET_IP_, ret,
 			   size, s->size, gfpflags, node);
 
 	ret = kasan_kmalloc(s, ret, size, gfpflags);
@@ -3482,7 +3482,7 @@ void kmem_cache_free(struct kmem_cache *s, void *x)
 	s = cache_from_obj(s, x);
 	if (!s)
 		return;
-	trace_kmem_cache_free(_RET_IP_, x, s->name);
+	trace_kmem_cache_free(s->name, _RET_IP_, x);
 	slab_free(s, virt_to_slab(x), x, NULL, 1, _RET_IP_);
 }
 EXPORT_SYMBOL(kmem_cache_free);
@@ -4366,7 +4366,7 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node)
 
 	ret = slab_alloc_node(s, flags, node, _RET_IP_, size);
 
-	trace_kmalloc_node(_RET_IP_, ret, size, s->size, flags, node);
+	trace_kmalloc_node(s->name, _RET_IP_, ret, size, s->size, flags, node);
 
 	ret = kasan_kmalloc(s, ret, size, flags);
 
@@ -4825,7 +4825,7 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
 	ret = slab_alloc_node(s, gfpflags, node, caller, size);
 
 	/* Honor the call site pointer we received. */
-	trace_kmalloc_node(caller, ret, size, s->size, gfpflags, node);
+	trace_kmalloc_node(s->name, caller, ret, size, s->size, gfpflags, node);
 
 	return ret;
 }
-- 
2.33.1


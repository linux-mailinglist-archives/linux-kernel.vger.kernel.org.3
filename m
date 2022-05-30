Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5605375C6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbiE3Hrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbiE3Hrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:47:32 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2D71A801
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:47:30 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id g18so3672369ljd.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=vQGJKgRzfPh+zLw3K4r44KW8AB/wTdbG5qQFXAAeL1Y=;
        b=C3PCXh6en7FGTOCmwOGZe9+b5R1e1tZSovKnVSyfMM51cU80O+Apqqj+wAu9CjeYQu
         RB4ZoCIHT+wPuG+gAXHpjx8pl5vOoZiVaJ1UUojxsuuVibYBvTDPHFdj838ob5mnl28F
         KX12P4w7vliJtnjdR/vDgGYi7Y4qY5bmvabeo0+t4z3Dwj+/pyvtgcG+gf9r3KpvBVgK
         nK1aDCS1miqV8vIbpx+RXBKnwudvXGCjar8YaDQuDvfmnhGJjZTyRgIGOEjIOk89BNdZ
         EgeLaK7X+kTnSmkmuEwCHBUeIVHz+pJwys4zR5twxIDjn1Vf+eq5bQ8XQiWnye4quy1c
         0ioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=vQGJKgRzfPh+zLw3K4r44KW8AB/wTdbG5qQFXAAeL1Y=;
        b=nScQkLEdnnjDsT7uyhZ8ZARngu3G6sHIhm5++05mOYejEH+OgEFpVWONBJHWc8/+Sh
         3NuKiDZ+xmfSYypjCHVZiD0LQYVZDSfKQynV1Ljav5nvvVQsKnS0ZfI3vF9da7VP9rzU
         h/9KujdQAyU7Xd4Rpo4hDduKodM7WX1LKH3iiX+QGiuMn+U1CqDUawMB2zOh+1ZUBnT4
         X1YgXhT+PpCFvRofGmjIuzvp5K8avNRlbyDN4fI1aFImt6/nZUE/ygaX9dQL5h2+lVo2
         KXAmEh+7nd4k4/CaYT6EewLXQCpiX1YSg06bkOGyWKMwt9KYacDzx2FCoD0DJXdXsQ8X
         rLMQ==
X-Gm-Message-State: AOAM532UoZ1oVycCl6FNET3TgTZO1fYHUiNSbttbzazHAOyBAZl4goTY
        bDMBC9FUSN9ruw/DE/ZHmOVJzQ==
X-Google-Smtp-Source: ABdhPJwutMt/7y+ox2Egav6GHlJ+Iwg76V5bx0TF7uSGjH7CtaInGdkN1WAo99qreLrEdqX5VNdurw==
X-Received: by 2002:a05:651c:118:b0:253:ccc6:d174 with SMTP id a24-20020a05651c011800b00253ccc6d174mr30969316ljb.440.1653896848340;
        Mon, 30 May 2022 00:47:28 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id 14-20020a2e154e000000b002554d343f48sm764354ljv.133.2022.05.30.00.47.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 00:47:27 -0700 (PDT)
Message-ID: <80bcb043-3782-1d81-d8a2-4bdcb213cf30@openvz.org>
Date:   Mon, 30 May 2022 10:47:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH v5] tracing: add 'accounted' entry into output of allocation
 tracepoints
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Matthew Wilcox <willy@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@suse.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>
References: <c7f687a8-637c-b119-6e3a-7dacc885b851@suse.cz>
Content-Language: en-US
In-Reply-To: <c7f687a8-637c-b119-6e3a-7dacc885b851@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Slab caches marked with SLAB_ACCOUNT force accounting for every
allocation from this cache even if __GFP_ACCOUNT flag is not passed.
Unfortunately, at the moment this flag is not visible in ftrace output,
and this makes it difficult to analyze the accounted allocations.

This patch adds boolean "accounted" entry into trace output,
and set it to 'true' for calls used __GFP_ACCOUNT flag and
for allocations from caches marked with SLAB_ACCOUNT.

Signed-off-by: Vasily Averin <vvs@openvz.org>
Acked-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

---
v5:
 1) re-based to current upstream (v5.18-11267-gb00ed48bb0a7)
 2) added "Acked-by" from Roman
 3) re-addressed to slab maintaiers

v4:
 1) replaced in patch descripion: "accounted" instead of "allocated"
 2) added "Acked-by" from Shakeel,
 3) re-addressed to akpm@

v3:
 1) rework kmem_cache_alloc* tracepoints once again,
    added struct kmem_cache argument into existing templates,
	thanks to Matthew Wilcox
 2) updated according trace_* calls
 3) added boolean "allocated" entry into trace output,
	thanks to Roman
 4) updated patch subject and description

v2:
 1) handle kmem_cache_alloc_node(), thanks to Shakeel
 2) rework kmem_cache_alloc* tracepoints to use cachep instead
    of current cachep->*size parameters.
    NB: kmem_cache_alloc_node tracepoint in SLOB cannot use cachep,
        and therefore it was replaced by kmalloc_node.
---
 include/trace/events/kmem.h | 38 +++++++++++++++++++++++--------------
 mm/slab.c                   | 10 +++++-----
 mm/slab_common.c            |  9 ++++-----
 mm/slob.c                   |  8 ++++----
 mm/slub.c                   | 20 +++++++++----------
 5 files changed, 47 insertions(+), 38 deletions(-)

diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index f76668305ac5..8d8736a5b654 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -13,11 +13,12 @@ DECLARE_EVENT_CLASS(kmem_alloc,
 
 	TP_PROTO(unsigned long call_site,
 		 const void *ptr,
+		 struct kmem_cache *s,
 		 size_t bytes_req,
 		 size_t bytes_alloc,
 		 gfp_t gfp_flags),
 
-	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags),
+	TP_ARGS(call_site, ptr, s, bytes_req, bytes_alloc, gfp_flags),
 
 	TP_STRUCT__entry(
 		__field(	unsigned long,	call_site	)
@@ -25,6 +26,7 @@ DECLARE_EVENT_CLASS(kmem_alloc,
 		__field(	size_t,		bytes_req	)
 		__field(	size_t,		bytes_alloc	)
 		__field(	unsigned long,	gfp_flags	)
+		__field(	bool,		accounted	)
 	),
 
 	TP_fast_assign(
@@ -33,42 +35,46 @@ DECLARE_EVENT_CLASS(kmem_alloc,
 		__entry->bytes_req	= bytes_req;
 		__entry->bytes_alloc	= bytes_alloc;
 		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
+		__entry->accounted	= (gfp_flags & __GFP_ACCOUNT) ||
+					  (s && s->flags & SLAB_ACCOUNT);
 	),
 
-	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s",
+	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s accounted=%s",
 		(void *)__entry->call_site,
 		__entry->ptr,
 		__entry->bytes_req,
 		__entry->bytes_alloc,
-		show_gfp_flags(__entry->gfp_flags))
+		show_gfp_flags(__entry->gfp_flags),
+		__entry->accounted ? "true" : "false")
 );
 
 DEFINE_EVENT(kmem_alloc, kmalloc,
 
-	TP_PROTO(unsigned long call_site, const void *ptr,
+	TP_PROTO(unsigned long call_site, const void *ptr, struct kmem_cache *s,
 		 size_t bytes_req, size_t bytes_alloc, gfp_t gfp_flags),
 
-	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags)
+	TP_ARGS(call_site, ptr, s, bytes_req, bytes_alloc, gfp_flags)
 );
 
 DEFINE_EVENT(kmem_alloc, kmem_cache_alloc,
 
-	TP_PROTO(unsigned long call_site, const void *ptr,
+	TP_PROTO(unsigned long call_site, const void *ptr, struct kmem_cache *s,
 		 size_t bytes_req, size_t bytes_alloc, gfp_t gfp_flags),
 
-	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags)
+	TP_ARGS(call_site, ptr, s, bytes_req, bytes_alloc, gfp_flags)
 );
 
 DECLARE_EVENT_CLASS(kmem_alloc_node,
 
 	TP_PROTO(unsigned long call_site,
 		 const void *ptr,
+		 struct kmem_cache *s,
 		 size_t bytes_req,
 		 size_t bytes_alloc,
 		 gfp_t gfp_flags,
 		 int node),
 
-	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags, node),
+	TP_ARGS(call_site, ptr, s, bytes_req, bytes_alloc, gfp_flags, node),
 
 	TP_STRUCT__entry(
 		__field(	unsigned long,	call_site	)
@@ -77,6 +83,7 @@ DECLARE_EVENT_CLASS(kmem_alloc_node,
 		__field(	size_t,		bytes_alloc	)
 		__field(	unsigned long,	gfp_flags	)
 		__field(	int,		node		)
+		__field(	bool,		accounted	)
 	),
 
 	TP_fast_assign(
@@ -86,33 +93,36 @@ DECLARE_EVENT_CLASS(kmem_alloc_node,
 		__entry->bytes_alloc	= bytes_alloc;
 		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
 		__entry->node		= node;
+		__entry->accounted	= (gfp_flags & __GFP_ACCOUNT) ||
+					  (s && s->flags & SLAB_ACCOUNT);
 	),
 
-	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s node=%d",
+	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s node=%d accounted=%s",
 		(void *)__entry->call_site,
 		__entry->ptr,
 		__entry->bytes_req,
 		__entry->bytes_alloc,
 		show_gfp_flags(__entry->gfp_flags),
-		__entry->node)
+		__entry->node,
+		__entry->accounted ? "true" : "false")
 );
 
 DEFINE_EVENT(kmem_alloc_node, kmalloc_node,
 
 	TP_PROTO(unsigned long call_site, const void *ptr,
-		 size_t bytes_req, size_t bytes_alloc,
+		 struct kmem_cache *s, size_t bytes_req, size_t bytes_alloc,
 		 gfp_t gfp_flags, int node),
 
-	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags, node)
+	TP_ARGS(call_site, ptr, s, bytes_req, bytes_alloc, gfp_flags, node)
 );
 
 DEFINE_EVENT(kmem_alloc_node, kmem_cache_alloc_node,
 
 	TP_PROTO(unsigned long call_site, const void *ptr,
-		 size_t bytes_req, size_t bytes_alloc,
+		 struct kmem_cache *s, size_t bytes_req, size_t bytes_alloc,
 		 gfp_t gfp_flags, int node),
 
-	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags, node)
+	TP_ARGS(call_site, ptr, s, bytes_req, bytes_alloc, gfp_flags, node)
 );
 
 TRACE_EVENT(kfree,
diff --git a/mm/slab.c b/mm/slab.c
index f8cd00f4ba13..1f7864ff41e3 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3478,7 +3478,7 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru,
 {
 	void *ret = slab_alloc(cachep, lru, flags, cachep->object_size, _RET_IP_);
 
-	trace_kmem_cache_alloc(_RET_IP_, ret,
+	trace_kmem_cache_alloc(_RET_IP_, ret, cachep,
 			       cachep->object_size, cachep->size, flags);
 
 	return ret;
@@ -3567,7 +3567,7 @@ kmem_cache_alloc_trace(struct kmem_cache *cachep, gfp_t flags, size_t size)
 	ret = slab_alloc(cachep, NULL, flags, size, _RET_IP_);
 
 	ret = kasan_kmalloc(cachep, ret, size, flags);
-	trace_kmalloc(_RET_IP_, ret,
+	trace_kmalloc(_RET_IP_, ret, cachep,
 		      size, cachep->size, flags);
 	return ret;
 }
@@ -3592,7 +3592,7 @@ void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)
 {
 	void *ret = slab_alloc_node(cachep, flags, nodeid, cachep->object_size, _RET_IP_);
 
-	trace_kmem_cache_alloc_node(_RET_IP_, ret,
+	trace_kmem_cache_alloc_node(_RET_IP_, ret, cachep,
 				    cachep->object_size, cachep->size,
 				    flags, nodeid);
 
@@ -3611,7 +3611,7 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
 	ret = slab_alloc_node(cachep, flags, nodeid, size, _RET_IP_);
 
 	ret = kasan_kmalloc(cachep, ret, size, flags);
-	trace_kmalloc_node(_RET_IP_, ret,
+	trace_kmalloc_node(_RET_IP_, ret, cachep,
 			   size, cachep->size,
 			   flags, nodeid);
 	return ret;
@@ -3694,7 +3694,7 @@ static __always_inline void *__do_kmalloc(size_t size, gfp_t flags,
 	ret = slab_alloc(cachep, NULL, flags, size, caller);
 
 	ret = kasan_kmalloc(cachep, ret, size, flags);
-	trace_kmalloc(caller, ret,
+	trace_kmalloc(caller, ret, cachep,
 		      size, cachep->size, flags);
 
 	return ret;
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 77c3adf40e50..6c9aac5d8f4a 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -26,13 +26,12 @@
 #include <linux/memcontrol.h>
 #include <linux/stackdepot.h>
 
-#define CREATE_TRACE_POINTS
-#include <trace/events/kmem.h>
-
 #include "internal.h"
-
 #include "slab.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/kmem.h>
+
 enum slab_state slab_state;
 LIST_HEAD(slab_caches);
 DEFINE_MUTEX(slab_mutex);
@@ -959,7 +958,7 @@ EXPORT_SYMBOL(kmalloc_order);
 void *kmalloc_order_trace(size_t size, gfp_t flags, unsigned int order)
 {
 	void *ret = kmalloc_order(size, flags, order);
-	trace_kmalloc(_RET_IP_, ret, size, PAGE_SIZE << order, flags);
+	trace_kmalloc(_RET_IP_, ret, NULL, size, PAGE_SIZE << order, flags);
 	return ret;
 }
 EXPORT_SYMBOL(kmalloc_order_trace);
diff --git a/mm/slob.c b/mm/slob.c
index f47811f09aca..56421fe461c4 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -507,7 +507,7 @@ __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
 		*m = size;
 		ret = (void *)m + minalign;
 
-		trace_kmalloc_node(caller, ret,
+		trace_kmalloc_node(caller, ret, NULL,
 				   size, size + minalign, gfp, node);
 	} else {
 		unsigned int order = get_order(size);
@@ -516,7 +516,7 @@ __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
 			gfp |= __GFP_COMP;
 		ret = slob_new_pages(gfp, order, node);
 
-		trace_kmalloc_node(caller, ret,
+		trace_kmalloc_node(caller, ret, NULL,
 				   size, PAGE_SIZE << order, gfp, node);
 	}
 
@@ -616,12 +616,12 @@ static void *slob_alloc_node(struct kmem_cache *c, gfp_t flags, int node)
 
 	if (c->size < PAGE_SIZE) {
 		b = slob_alloc(c->size, flags, c->align, node, 0);
-		trace_kmem_cache_alloc_node(_RET_IP_, b, c->object_size,
+		trace_kmem_cache_alloc_node(_RET_IP_, b, NULL, c->object_size,
 					    SLOB_UNITS(c->size) * SLOB_UNIT,
 					    flags, node);
 	} else {
 		b = slob_new_pages(flags, get_order(c->size), node);
-		trace_kmem_cache_alloc_node(_RET_IP_, b, c->object_size,
+		trace_kmem_cache_alloc_node(_RET_IP_, b, NULL, c->object_size,
 					    PAGE_SIZE << get_order(c->size),
 					    flags, node);
 	}
diff --git a/mm/slub.c b/mm/slub.c
index e5535020e0fd..c323dd916b08 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3228,7 +3228,7 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
 {
 	void *ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);
 
-	trace_kmem_cache_alloc(_RET_IP_, ret, s->object_size,
+	trace_kmem_cache_alloc(_RET_IP_, ret, s, s->object_size,
 				s->size, gfpflags);
 
 	return ret;
@@ -3251,7 +3251,7 @@ EXPORT_SYMBOL(kmem_cache_alloc_lru);
 void *kmem_cache_alloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
 {
 	void *ret = slab_alloc(s, NULL, gfpflags, _RET_IP_, size);
-	trace_kmalloc(_RET_IP_, ret, size, s->size, gfpflags);
+	trace_kmalloc(_RET_IP_, ret, s, size, s->size, gfpflags);
 	ret = kasan_kmalloc(s, ret, size, gfpflags);
 	return ret;
 }
@@ -3263,7 +3263,7 @@ void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
 {
 	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, s->object_size);
 
-	trace_kmem_cache_alloc_node(_RET_IP_, ret,
+	trace_kmem_cache_alloc_node(_RET_IP_, ret, s,
 				    s->object_size, s->size, gfpflags, node);
 
 	return ret;
@@ -3277,7 +3277,7 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *s,
 {
 	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, size);
 
-	trace_kmalloc_node(_RET_IP_, ret,
+	trace_kmalloc_node(_RET_IP_, ret, s,
 			   size, s->size, gfpflags, node);
 
 	ret = kasan_kmalloc(s, ret, size, gfpflags);
@@ -4412,7 +4412,7 @@ void *__kmalloc(size_t size, gfp_t flags)
 
 	ret = slab_alloc(s, NULL, flags, _RET_IP_, size);
 
-	trace_kmalloc(_RET_IP_, ret, size, s->size, flags);
+	trace_kmalloc(_RET_IP_, ret, s, size, s->size, flags);
 
 	ret = kasan_kmalloc(s, ret, size, flags);
 
@@ -4446,7 +4446,7 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node)
 	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
 		ret = kmalloc_large_node(size, flags, node);
 
-		trace_kmalloc_node(_RET_IP_, ret,
+		trace_kmalloc_node(_RET_IP_, ret, NULL,
 				   size, PAGE_SIZE << get_order(size),
 				   flags, node);
 
@@ -4460,7 +4460,7 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node)
 
 	ret = slab_alloc_node(s, NULL, flags, node, _RET_IP_, size);
 
-	trace_kmalloc_node(_RET_IP_, ret, size, s->size, flags, node);
+	trace_kmalloc_node(_RET_IP_, ret, s, size, s->size, flags, node);
 
 	ret = kasan_kmalloc(s, ret, size, flags);
 
@@ -4919,7 +4919,7 @@ void *__kmalloc_track_caller(size_t size, gfp_t gfpflags, unsigned long caller)
 	ret = slab_alloc(s, NULL, gfpflags, caller, size);
 
 	/* Honor the call site pointer we received. */
-	trace_kmalloc(caller, ret, size, s->size, gfpflags);
+	trace_kmalloc(caller, ret, s, size, s->size, gfpflags);
 
 	return ret;
 }
@@ -4935,7 +4935,7 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
 	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
 		ret = kmalloc_large_node(size, gfpflags, node);
 
-		trace_kmalloc_node(caller, ret,
+		trace_kmalloc_node(caller, ret, NULL,
 				   size, PAGE_SIZE << get_order(size),
 				   gfpflags, node);
 
@@ -4950,7 +4950,7 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
 	ret = slab_alloc_node(s, NULL, gfpflags, node, caller, size);
 
 	/* Honor the call site pointer we received. */
-	trace_kmalloc_node(caller, ret, size, s->size, gfpflags, node);
+	trace_kmalloc_node(caller, ret, s, size, s->size, gfpflags, node);
 
 	return ret;
 }
-- 
2.31.1


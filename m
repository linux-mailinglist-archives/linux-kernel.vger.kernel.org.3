Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A0352B25A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 08:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbiERGZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 02:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiERGY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 02:24:58 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D40D4104
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:24:56 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id bx33so1283984ljb.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:reply-to:content-transfer-encoding;
        bh=Ewk55++Gp6T3M6fiW+YquVxP2Y8LxYJuTsNlyW8yg58=;
        b=y5TZgbNXfIKFhAeTtAb0TIQmSB0lf7vl88Yz/NTIT1eQVb7lZDFQgK1EebJik0Nq11
         vmR6wmium6CKW3e0CQFmWkHt8H5fXw2XagvCt80A3cZqfNNGh+lKG8yyTw5tiOo/qMTD
         Wg3f+d3fAyWSTY/a5k8fGtMbBR1iLmQ73WAYgc98A81sTu0BarkhFdvxwllAmBZ+VugB
         Jxo04Mi7cQg77UNLfc1xagyWqJ6WSzyzQ3FVKlidx23pTZ1olXBZ+3uzSrpJZPIUQu1X
         KlmdC27Ed86qEDObW84moEABAyTSdZlJfcn8C8PWitr5hRELqwfak1hkReNUKDfoElZl
         9h+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:reply-to:content-transfer-encoding;
        bh=Ewk55++Gp6T3M6fiW+YquVxP2Y8LxYJuTsNlyW8yg58=;
        b=ZSUGlSTSlkvVQgoPoqy+7pqiQ2v4I4iCBou1VazVEUe4nxrlccG3glKdeAJ8yDjXeO
         gAUanHM7Sx7SsffPoz3eTidSREHV5o2yopa+sxgqja1pxRqCivxsPypQHQ7PVJOnMpnK
         5i1uDczx10lcZrW8dvNvQ8VtVxOLFSndQCwMkPLVROFNuF57yXKGj0+PE2zYzmFibe72
         aay1ehz7eHzKUDv0Ea3lkfUNipWR//w1KBRgQvSGf5wEPA12Ch1dq1DUizMPuUNb5ghR
         ya2QYZK2DsY4E3X9gY2VcC5JM19TR86lrlf3ejDMNKszandCu++DVPMNe+mt4CRZ5Zll
         VTcA==
X-Gm-Message-State: AOAM530OhLi13jM+TYCR+p+4o2YmslpcuSxb0BGPFkK0Bttu+1GTBLgW
        txXGaEEeixmtw8H/vtqOYv3P3Q==
X-Google-Smtp-Source: ABdhPJwye7N4TdFIN8h49zvhWdAJKKNU8LM9HWhLYiE44Mgc4w/96poV4HI+BcjSuLzlQgwebeB9Vg==
X-Received: by 2002:a05:651c:4cb:b0:24f:5201:b2ca with SMTP id e11-20020a05651c04cb00b0024f5201b2camr15854605lji.173.1652855094566;
        Tue, 17 May 2022 23:24:54 -0700 (PDT)
Received: from [192.168.43.196] ([185.174.128.243])
        by smtp.gmail.com with ESMTPSA id q17-20020a2e7511000000b0024f3d1daed1sm107627ljc.89.2022.05.17.23.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 23:24:54 -0700 (PDT)
Message-ID: <f6625cd8-90f9-6d48-50f6-7bb052bf479f@openvz.org>
Date:   Wed, 18 May 2022 09:24:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH v3] tracing: add 'accounted' entry into output of allocation
 tracepoints
To:     Steven Rostedt <rostedt@goodmis.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@suse.com>
Content-Language: en-US
Reply-To: YoPOhRctb8wwbmY5@carbon
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

This patch adds boolean "allocated" entry into trace output,
and set it to 'true' for calls used __GFP_ACCOUNT flag and
for allocations from caches marked with SLAB_ACCOUNT.

Signed-off-by: Vasily Averin <vvs@openvz.org>
---
v3:
 1) rework kmem_cache_alloc* tracepoints once again,
    added struct kmem_cache argument into existing templates,
	thanks to Matthew Wilcox
 2) updated the corresponding ding trace_* calls
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
Now kmem tracing output looks like this:

kmem_cache_alloc:     (getname_flags.part.0+0x2c) call_site=getname_flags.part.0+0x2c ptr=0xffff8fff022e9000 bytes_req=4096 bytes_alloc=4096 gfp_flags=GFP_KERNEL accounted=false
kmalloc:              (alloc_bprm+0x32) call_site=alloc_bprm+0x32 ptr=0xffff8fff2b408a00 bytes_req=416 bytes_alloc=512 gfp_flags=GFP_KERNEL|__GFP_ZERO accounted=false
kmem_cache_alloc:     (mm_alloc+0x16) call_site=mm_alloc+0x16 ptr=0xffff8fff0894d500 bytes_req=1048 bytes_alloc=1088 gfp_flags=GFP_KERNEL accounted=true
mm_page_alloc:        page=0xffffffffa4ab8d42 pfn=0x12ad72 order=1 migratetype=0 gfp_flags=GFP_USER|__GFP_ZERO|__GFP_ACCOUNT
kmem_cache_alloc:     (vm_area_alloc+0x1a) call_site=vm_area_alloc+0x1a ptr=0xffff8fff2af27000 bytes_req=200 bytes_alloc=200 gfp_flags=GFP_KERNEL accounted=true
---
 include/trace/events/kmem.h | 38 +++++++++++++++++++++++--------------
 mm/slab.c                   | 10 +++++-----
 mm/slab_common.c            |  9 ++++-----
 mm/slob.c                   |  8 ++++----
 mm/slub.c                   | 20 +++++++++----------
 5 files changed, 47 insertions(+), 38 deletions(-)

diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index 71c141804222..5bfeb6f276f1 100644
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
index 0edb474edef1..e5802445c7d6 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3492,7 +3492,7 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru,
 {
 	void *ret = slab_alloc(cachep, lru, flags, cachep->object_size, _RET_IP_);
 
-	trace_kmem_cache_alloc(_RET_IP_, ret,
+	trace_kmem_cache_alloc(_RET_IP_, ret, cachep,
 			       cachep->object_size, cachep->size, flags);
 
 	return ret;
@@ -3581,7 +3581,7 @@ kmem_cache_alloc_trace(struct kmem_cache *cachep, gfp_t flags, size_t size)
 	ret = slab_alloc(cachep, NULL, flags, size, _RET_IP_);
 
 	ret = kasan_kmalloc(cachep, ret, size, flags);
-	trace_kmalloc(_RET_IP_, ret,
+	trace_kmalloc(_RET_IP_, ret, cachep,
 		      size, cachep->size, flags);
 	return ret;
 }
@@ -3606,7 +3606,7 @@ void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)
 {
 	void *ret = slab_alloc_node(cachep, flags, nodeid, cachep->object_size, _RET_IP_);
 
-	trace_kmem_cache_alloc_node(_RET_IP_, ret,
+	trace_kmem_cache_alloc_node(_RET_IP_, ret, cachep,
 				    cachep->object_size, cachep->size,
 				    flags, nodeid);
 
@@ -3625,7 +3625,7 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
 	ret = slab_alloc_node(cachep, flags, nodeid, size, _RET_IP_);
 
 	ret = kasan_kmalloc(cachep, ret, size, flags);
-	trace_kmalloc_node(_RET_IP_, ret,
+	trace_kmalloc_node(_RET_IP_, ret, cachep,
 			   size, cachep->size,
 			   flags, nodeid);
 	return ret;
@@ -3708,7 +3708,7 @@ static __always_inline void *__do_kmalloc(size_t size, gfp_t flags,
 	ret = slab_alloc(cachep, NULL, flags, size, caller);
 
 	ret = kasan_kmalloc(cachep, ret, size, flags);
-	trace_kmalloc(caller, ret,
+	trace_kmalloc(caller, ret, cachep,
 		      size, cachep->size, flags);
 
 	return ret;
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 2b3206a2c3b5..a345e8600e00 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -25,13 +25,12 @@
 #include <asm/page.h>
 #include <linux/memcontrol.h>
 
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
@@ -967,7 +966,7 @@ EXPORT_SYMBOL(kmalloc_order);
 void *kmalloc_order_trace(size_t size, gfp_t flags, unsigned int order)
 {
 	void *ret = kmalloc_order(size, flags, order);
-	trace_kmalloc(_RET_IP_, ret, size, PAGE_SIZE << order, flags);
+	trace_kmalloc(_RET_IP_, ret, NULL, size, PAGE_SIZE << order, flags);
 	return ret;
 }
 EXPORT_SYMBOL(kmalloc_order_trace);
diff --git a/mm/slob.c b/mm/slob.c
index 40ea6e2d4ccd..dbefa0da0dfc 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -505,7 +505,7 @@ __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
 		*m = size;
 		ret = (void *)m + minalign;
 
-		trace_kmalloc_node(caller, ret,
+		trace_kmalloc_node(caller, ret, NULL,
 				   size, size + minalign, gfp, node);
 	} else {
 		unsigned int order = get_order(size);
@@ -514,7 +514,7 @@ __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
 			gfp |= __GFP_COMP;
 		ret = slob_new_pages(gfp, order, node);
 
-		trace_kmalloc_node(caller, ret,
+		trace_kmalloc_node(caller, ret, NULL,
 				   size, PAGE_SIZE << order, gfp, node);
 	}
 
@@ -610,12 +610,12 @@ static void *slob_alloc_node(struct kmem_cache *c, gfp_t flags, int node)
 
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
index ed5c2c03a47a..9b10591646dd 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3231,7 +3231,7 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
 {
 	void *ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);
 
-	trace_kmem_cache_alloc(_RET_IP_, ret, s->object_size,
+	trace_kmem_cache_alloc(_RET_IP_, ret, s, s->object_size,
 				s->size, gfpflags);
 
 	return ret;
@@ -3254,7 +3254,7 @@ EXPORT_SYMBOL(kmem_cache_alloc_lru);
 void *kmem_cache_alloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
 {
 	void *ret = slab_alloc(s, NULL, gfpflags, _RET_IP_, size);
-	trace_kmalloc(_RET_IP_, ret, size, s->size, gfpflags);
+	trace_kmalloc(_RET_IP_, ret, s, size, s->size, gfpflags);
 	ret = kasan_kmalloc(s, ret, size, gfpflags);
 	return ret;
 }
@@ -3266,7 +3266,7 @@ void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
 {
 	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, s->object_size);
 
-	trace_kmem_cache_alloc_node(_RET_IP_, ret,
+	trace_kmem_cache_alloc_node(_RET_IP_, ret, s,
 				    s->object_size, s->size, gfpflags, node);
 
 	return ret;
@@ -3280,7 +3280,7 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *s,
 {
 	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, size);
 
-	trace_kmalloc_node(_RET_IP_, ret,
+	trace_kmalloc_node(_RET_IP_, ret, s,
 			   size, s->size, gfpflags, node);
 
 	ret = kasan_kmalloc(s, ret, size, gfpflags);
@@ -4409,7 +4409,7 @@ void *__kmalloc(size_t size, gfp_t flags)
 
 	ret = slab_alloc(s, NULL, flags, _RET_IP_, size);
 
-	trace_kmalloc(_RET_IP_, ret, size, s->size, flags);
+	trace_kmalloc(_RET_IP_, ret, s, size, s->size, flags);
 
 	ret = kasan_kmalloc(s, ret, size, flags);
 
@@ -4443,7 +4443,7 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node)
 	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
 		ret = kmalloc_large_node(size, flags, node);
 
-		trace_kmalloc_node(_RET_IP_, ret,
+		trace_kmalloc_node(_RET_IP_, ret, NULL,
 				   size, PAGE_SIZE << get_order(size),
 				   flags, node);
 
@@ -4457,7 +4457,7 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node)
 
 	ret = slab_alloc_node(s, NULL, flags, node, _RET_IP_, size);
 
-	trace_kmalloc_node(_RET_IP_, ret, size, s->size, flags, node);
+	trace_kmalloc_node(_RET_IP_, ret, s, size, s->size, flags, node);
 
 	ret = kasan_kmalloc(s, ret, size, flags);
 
@@ -4916,7 +4916,7 @@ void *__kmalloc_track_caller(size_t size, gfp_t gfpflags, unsigned long caller)
 	ret = slab_alloc(s, NULL, gfpflags, caller, size);
 
 	/* Honor the call site pointer we received. */
-	trace_kmalloc(caller, ret, size, s->size, gfpflags);
+	trace_kmalloc(caller, ret, s, size, s->size, gfpflags);
 
 	return ret;
 }
@@ -4932,7 +4932,7 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
 	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
 		ret = kmalloc_large_node(size, gfpflags, node);
 
-		trace_kmalloc_node(caller, ret,
+		trace_kmalloc_node(caller, ret, NULL,
 				   size, PAGE_SIZE << get_order(size),
 				   gfpflags, node);
 
@@ -4947,7 +4947,7 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
 	ret = slab_alloc_node(s, NULL, gfpflags, node, caller, size);
 
 	/* Honor the call site pointer we received. */
-	trace_kmalloc_node(caller, ret, size, s->size, gfpflags, node);
+	trace_kmalloc_node(caller, ret, s, size, s->size, gfpflags, node);
 
 	return ret;
 }
-- 
2.31.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F8A529E64
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245448AbiEQJp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245391AbiEQJoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:44:37 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED0447AF5
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 02:44:17 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id j4so30297083lfh.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 02:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:reply-to:content-transfer-encoding;
        bh=4Y7GTp06m87sjrCjAMpmQ5sQb3h3R2MyluXYoWhziFQ=;
        b=MghXAnMT6KgtejKHKI+m5S8SyqmUYagS+dMS6d3Siyt9TDQsrCRUjWc6Af1jh3cJbV
         Tqh+DfBGiOkHXNOEJMxbR7HlMjwq+wlzQD8Tnm6peub57oQqy3FrQM0iz2qatq17+g+G
         vW64ljpV+gwxahaKaIZQlLdLl1wvofEtn20vw4bQDgnqbyetV3Ry6IsomfwJmeSIscUg
         pV2pqY0Nzgs/8/xNTdyZtztvcr7anhSOTIrBB8HqZu/AZrudcrUXsNhCaJ8sgvtLRDrc
         zJYjHz/fXOkFcwwbWB5v3Q5F8Pc88geDcDWRqusZeZ38rnDv5PD+1L+sa1IPyotMGU8n
         tusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:reply-to:content-transfer-encoding;
        bh=4Y7GTp06m87sjrCjAMpmQ5sQb3h3R2MyluXYoWhziFQ=;
        b=5grYqm3fIJu7cvRA/swqlKc8Zh/4gpEgzYd6D+YjjBOqno85dPdhhLtTcyGdQOia+5
         wAMkzz8WMaa1n8opw7g0WHkCeCJDGdb4M4Jo+mirczlN3tVuN+dKbBWYN72ZMO1H/Xnj
         XzD76jbBPcDh5lsh/nDzwJ/PXEvxDRnHb0rtF3FwK1n/E6ac/OkXzJXwqJkcjO9wBYdw
         A417RSiOnNmXB7Pf5JkPi9g8K+N1njKS0tzzmaiR4KIX1KLGXONi/TKSiuFm+KmoImHo
         8FZSJ+pwLzq0+tCoY1FCnZGP5QGqvm5L8YDJh18JlZgUQl/V/Sli9mKyft3LCWh3wLKF
         AFsA==
X-Gm-Message-State: AOAM530fBz/bOtI0UEeVAhdNlCmCazOuv7U9okLWVhS5RgIXoHWt5Piv
        WIoZINuWyVrxo6a+QmX3yZZYgQ==
X-Google-Smtp-Source: ABdhPJzcUizreDjMj6lesjstMRBHyYVo4l8fnzb8tHWmpwpORw+SWixzfqsvuUJJjw6CTjr+uQJjjw==
X-Received: by 2002:a05:6512:2350:b0:472:6182:955c with SMTP id p16-20020a056512235000b004726182955cmr16059189lfu.214.1652780656167;
        Tue, 17 May 2022 02:44:16 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.177])
        by smtp.gmail.com with ESMTPSA id y16-20020ac24e70000000b0047255d211aasm1536573lfs.217.2022.05.17.02.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 02:44:15 -0700 (PDT)
Message-ID: <8ef9de6a-7497-07f7-852c-befcc3843771@openvz.org>
Date:   Tue, 17 May 2022 12:44:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH v2] tracing: add ACCOUNT flag for allocations from marked slab
 caches
To:     Steven Rostedt <rostedt@goodmis.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@suse.com>
Content-Language: en-US
Reply-To: YoMccU66auLAPEHa@casper.infradead.org
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

dSlab caches marked with SLAB_ACCOUNT force accounting for every
allocation from this cache even if __GFP_ACCOUNT flag is not passed.
Unfortunately, at the moment this flag is not visible in ftrace output,
and this makes it difficult to analyze the accounted allocations.

This patch adds the __GFP_ACCOUNT flag for allocations from slab caches
marked with SLAB_ACCOUNT to the ftrace output
---
v2:
 1) handle kmem_cache_alloc_node() too, thanks to Shakeel
 2) rework kmem_cache_alloc* tracepoints to use cachep instead
    of current cachep->*size parameters. Now kmalloc[_node] and
    kmem_cache_alloc[_node] tracepoints do not use common template

NB: kmem_cache_alloc_node tracepoint in SLOB cannot be switched to cachep,
    therefore it was replaced by kmalloc_node tracepoint.
---
VvS: is this acceptable? Maybe I should split this patch?

Signed-off-by: Vasily Averin <vvs@openvz.org>
---
 include/trace/events/kmem.h | 82 +++++++++++++++++++++++++++----------
 mm/slab.c                   |  7 +---
 mm/slab_common.c            |  7 ++--
 mm/slob.c                   | 10 ++---
 mm/slub.c                   |  6 +--
 5 files changed, 71 insertions(+), 41 deletions(-)

diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index 71c141804222..3b4f96e4a607 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -9,7 +9,7 @@
 #include <linux/tracepoint.h>
 #include <trace/events/mmflags.h>
 
-DECLARE_EVENT_CLASS(kmem_alloc,
+TRACE_EVENT(kmalloc,
 
 	TP_PROTO(unsigned long call_site,
 		 const void *ptr,
@@ -43,23 +43,41 @@ DECLARE_EVENT_CLASS(kmem_alloc,
 		show_gfp_flags(__entry->gfp_flags))
 );
 
-DEFINE_EVENT(kmem_alloc, kmalloc,
+TRACE_EVENT(kmem_cache_alloc,
 
-	TP_PROTO(unsigned long call_site, const void *ptr,
-		 size_t bytes_req, size_t bytes_alloc, gfp_t gfp_flags),
+	TP_PROTO(unsigned long call_site,
+		 const void *ptr,
+		 struct kmem_cache *s,
+		 gfp_t gfp_flags),
 
-	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags)
-);
+	TP_ARGS(call_site, ptr, s, gfp_flags),
 
-DEFINE_EVENT(kmem_alloc, kmem_cache_alloc,
+	TP_STRUCT__entry(
+		__field(	unsigned long,	call_site	)
+		__field(	const void *,	ptr		)
+		__field(	size_t,		bytes_req	)
+		__field(	size_t,		bytes_alloc	)
+		__field(	unsigned long,	gfp_flags	)
+	),
 
-	TP_PROTO(unsigned long call_site, const void *ptr,
-		 size_t bytes_req, size_t bytes_alloc, gfp_t gfp_flags),
+	TP_fast_assign(
+		__entry->call_site	= call_site;
+		__entry->ptr		= ptr;
+		__entry->bytes_req	= s->object_size;
+		__entry->bytes_alloc	= s->size;
+		__entry->gfp_flags	= (__force unsigned long)gfp_flags |
+				(s->flags & SLAB_ACCOUNT ? __GFP_ACCOUNT : 0);
+	),
 
-	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags)
+	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s",
+		(void *)__entry->call_site,
+		__entry->ptr,
+		__entry->bytes_req,
+		__entry->bytes_alloc,
+		show_gfp_flags(__entry->gfp_flags))
 );
 
-DECLARE_EVENT_CLASS(kmem_alloc_node,
+TRACE_EVENT(kmalloc_node,
 
 	TP_PROTO(unsigned long call_site,
 		 const void *ptr,
@@ -97,22 +115,42 @@ DECLARE_EVENT_CLASS(kmem_alloc_node,
 		__entry->node)
 );
 
-DEFINE_EVENT(kmem_alloc_node, kmalloc_node,
+TRACE_EVENT(kmem_cache_alloc_node,
 
-	TP_PROTO(unsigned long call_site, const void *ptr,
-		 size_t bytes_req, size_t bytes_alloc,
-		 gfp_t gfp_flags, int node),
+	TP_PROTO(unsigned long call_site,
+		 const void *ptr,
+		 struct kmem_cache *s,
+		 gfp_t gfp_flags,
+		 int node),
 
-	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags, node)
-);
+	TP_ARGS(call_site, ptr, s, gfp_flags, node),
 
-DEFINE_EVENT(kmem_alloc_node, kmem_cache_alloc_node,
+	TP_STRUCT__entry(
+		__field(	unsigned long,	call_site	)
+		__field(	const void *,	ptr		)
+		__field(	size_t,		bytes_req	)
+		__field(	size_t,		bytes_alloc	)
+		__field(	unsigned long,	gfp_flags	)
+		__field(	int,		node		)
+	),
 
-	TP_PROTO(unsigned long call_site, const void *ptr,
-		 size_t bytes_req, size_t bytes_alloc,
-		 gfp_t gfp_flags, int node),
+	TP_fast_assign(
+		__entry->call_site	= call_site;
+		__entry->ptr		= ptr;
+		__entry->bytes_req	= s->object_size;
+		__entry->bytes_alloc	= s->size;
+		__entry->gfp_flags	= (__force unsigned long)gfp_flags |
+				(s->flags & SLAB_ACCOUNT ? __GFP_ACCOUNT : 0);
+		__entry->node		= node;
+	),
 
-	TP_ARGS(call_site, ptr, bytes_req, bytes_alloc, gfp_flags, node)
+	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s node=%d",
+		(void *)__entry->call_site,
+		__entry->ptr,
+		__entry->bytes_req,
+		__entry->bytes_alloc,
+		show_gfp_flags(__entry->gfp_flags),
+		__entry->node)
 );
 
 TRACE_EVENT(kfree,
diff --git a/mm/slab.c b/mm/slab.c
index 0edb474edef1..935b1c90d7f0 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3492,8 +3492,7 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru,
 {
 	void *ret = slab_alloc(cachep, lru, flags, cachep->object_size, _RET_IP_);
 
-	trace_kmem_cache_alloc(_RET_IP_, ret,
-			       cachep->object_size, cachep->size, flags);
+	trace_kmem_cache_alloc(_RET_IP_, ret, cachep, flags);
 
 	return ret;
 }
@@ -3606,9 +3605,7 @@ void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)
 {
 	void *ret = slab_alloc_node(cachep, flags, nodeid, cachep->object_size, _RET_IP_);
 
-	trace_kmem_cache_alloc_node(_RET_IP_, ret,
-				    cachep->object_size, cachep->size,
-				    flags, nodeid);
+	trace_kmem_cache_alloc_node(_RET_IP_, ret, cachep, flags, nodeid);
 
 	return ret;
 }
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 2b3206a2c3b5..12299cf450fe 100644
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
diff --git a/mm/slob.c b/mm/slob.c
index 40ea6e2d4ccd..69875419769c 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -610,14 +610,12 @@ static void *slob_alloc_node(struct kmem_cache *c, gfp_t flags, int node)
 
 	if (c->size < PAGE_SIZE) {
 		b = slob_alloc(c->size, flags, c->align, node, 0);
-		trace_kmem_cache_alloc_node(_RET_IP_, b, c->object_size,
-					    SLOB_UNITS(c->size) * SLOB_UNIT,
-					    flags, node);
+		trace_kmalloc_node(_RET_IP_, b, c->object_size,
+				   SLOB_UNITS(c->size) * SLOB_UNIT, flags, node);
 	} else {
 		b = slob_new_pages(flags, get_order(c->size), node);
-		trace_kmem_cache_alloc_node(_RET_IP_, b, c->object_size,
-					    PAGE_SIZE << get_order(c->size),
-					    flags, node);
+		trace_kmalloc_node(_RET_IP_, b, c->object_size,
+				   PAGE_SIZE << get_order(c->size), flags, node);
 	}
 
 	if (b && c->ctor) {
diff --git a/mm/slub.c b/mm/slub.c
index ed5c2c03a47a..fc6678269db0 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3231,8 +3231,7 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
 {
 	void *ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);
 
-	trace_kmem_cache_alloc(_RET_IP_, ret, s->object_size,
-				s->size, gfpflags);
+	trace_kmem_cache_alloc(_RET_IP_, ret, s, gfpflags);
 
 	return ret;
 }
@@ -3266,8 +3265,7 @@ void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
 {
 	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, s->object_size);
 
-	trace_kmem_cache_alloc_node(_RET_IP_, ret,
-				    s->object_size, s->size, gfpflags, node);
+	trace_kmem_cache_alloc_node(_RET_IP_, ret, s, gfpflags, node);
 
 	return ret;
 }
-- 
2.31.1


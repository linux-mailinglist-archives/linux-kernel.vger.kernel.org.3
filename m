Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB29C500931
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241492AbiDNJCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241436AbiDNJBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:01:54 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B34219
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:59:18 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id a16-20020a17090a6d9000b001c7d6c1bb13so5055016pjk.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hsQvWpubllx7PdWg9lbvyVRg4B3WKq0E84Aji7H3XUg=;
        b=RcI79TDVfUjEI+i7r0zv9DyFEarSCFOyyJ0yAe7QADd7JMamrld0EL4b0MRQQtrJFP
         yl5lGZBKoYaISvBtIUFjkwkE4uRd4hqa75Q8rX2cOSKVe7/OSGuDyPqfJVYs2ji6ZbGH
         jwAFBBf00cMN6ViOCeY6jFXivsR0+KSCaodvMFqGNHgQPtoYlW7W7OuOywUtOkIw6o2A
         4oxeUjuOGCfQ6MpC3ZvHMcRv6IJnmXTXjN5djExNqEzEFYByKGuvntX4KDlBhmv+ZQDE
         1Ph97XF0XJ3amt/G8ZzZcNMasQKt7vl8pveXq3v2fOc9v7JM1R58uRuyFHh3lu0WYjj7
         T8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hsQvWpubllx7PdWg9lbvyVRg4B3WKq0E84Aji7H3XUg=;
        b=ni1dX/0oWEt+TnrH9nFn9S21ZZckJx3GR3LUwvH8Eaup0VsMDtnEc5nDOS67Uwbdwc
         Qp5jYDe8KVhrPE8qtlBzlxoh8BIeWn7hKTuafyS2jiOz9GGa+iNqvxw6yr5q9VPXAWwr
         YKexrOL3ZquJMclhEzqASxE5zqZy8rUy5O2kW/HUiyzk5xtchOOJ4tJsa4K3AsT+DdIf
         PghQcO018mgw1QESfZi8x2GFAF/GBZYzOa9049/l8lLR3qOd4ILPgfjaP5sFMSW6pPyj
         OfS7+dRdWGdxUTpmgi0U5aM87nAiHIOHNavmIDXjnByA9I0UVS6lp3PsdD0iFAP5eZ8B
         SfLQ==
X-Gm-Message-State: AOAM5326/IDvij4T8/zit21oV5ooiWtE++AOpBBdZDXdm4GSyektOYrU
        eSCPUOKXQBQQQrAOqnegHOk=
X-Google-Smtp-Source: ABdhPJz7HfWYTCuY7TqGCZq82ODBwRzEgJAykfwr5rZXPv7yJZnkLjt8584O0Wr3hN6glVAZ5QpD3g==
X-Received: by 2002:a17:902:aa85:b0:155:ceb9:3710 with SMTP id d5-20020a170902aa8500b00155ceb93710mr12561403plr.59.1649926758443;
        Thu, 14 Apr 2022 01:59:18 -0700 (PDT)
Received: from hyeyoo.. ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id p9-20020aa79e89000000b00505fada20dfsm1403537pfq.117.2022.04.14.01.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:59:16 -0700 (PDT)
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
Subject: [PATCH v2 16/23] mm/slab_common: rename tracepoint
Date:   Thu, 14 Apr 2022 17:57:20 +0900
Message-Id: <20220414085727.643099-17-42.hyeyoo@gmail.com>
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

To reduce overhead of printing tracepoint name,
rename trace_kmem_cache_alloc_node to kmem_cache_alloc.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 include/trace/events/kmem.h |  4 ++--
 mm/slab.c                   |  8 ++++----
 mm/slab_common.c            |  6 +++---
 mm/slob.c                   | 22 +++++++++++-----------
 mm/slub.c                   | 16 ++++++++--------
 5 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index ca67ba5fd76a..58edb2e3e5a4 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -9,7 +9,7 @@
 #include <linux/tracepoint.h>
 #include <trace/events/mmflags.h>
 
-DECLARE_EVENT_CLASS(kmem_alloc_node,
+DECLARE_EVENT_CLASS(kmem_alloc,
 
 	TP_PROTO(const char *name,
 		 unsigned long call_site,
@@ -51,7 +51,7 @@ DECLARE_EVENT_CLASS(kmem_alloc_node,
 		__entry->node)
 );
 
-DEFINE_EVENT(kmem_alloc_node, kmem_cache_alloc_node,
+DEFINE_EVENT(kmem_alloc, kmem_cache_alloc,
 
 	TP_PROTO(const char *name, unsigned long call_site,
 		 const void *ptr, size_t bytes_req, size_t bytes_alloc,
diff --git a/mm/slab.c b/mm/slab.c
index b9959a6b5c48..424168b96790 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3448,7 +3448,7 @@ void *__kmem_cache_alloc_node(struct kmem_cache *cachep, struct list_lru *lru,
 	void *ret = slab_alloc_node(cachep, lru, flags, nodeid,
 				    cachep->object_size, caller);
 
-	trace_kmem_cache_alloc_node(cachep->name, caller, ret,
+	trace_kmem_cache_alloc(cachep->name, caller, ret,
 				    cachep->object_size, cachep->size,
 				    flags, nodeid);
 
@@ -3519,9 +3519,9 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
 	ret = slab_alloc_node(cachep, NULL, flags, nodeid, size, _RET_IP_);
 
 	ret = kasan_kmalloc(cachep, ret, size, flags);
-	trace_kmem_cache_alloc_node(cachep->name, _RET_IP_, ret,
-				    size, cachep->size,
-				    flags, nodeid);
+	trace_kmem_cache_alloc(cachep->name, _RET_IP_, ret,
+			       size, cachep->size,
+			       flags, nodeid);
 	return ret;
 }
 EXPORT_SYMBOL(kmem_cache_alloc_node_trace);
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 3d1569085c54..3cd5d7a47ec7 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -957,8 +957,8 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node)
 	ptr = kasan_kmalloc_large(ptr, size, flags);
 	/* As ptr might get tagged, call kmemleak hook after KASAN. */
 	kmemleak_alloc(ptr, size, 1, flags);
-	trace_kmem_cache_alloc_node(KMALLOC_LARGE_NAME, _RET_IP_, ptr, size,
-				    PAGE_SIZE << order, flags, node);
+	trace_kmem_cache_alloc(KMALLOC_LARGE_NAME, _RET_IP_, ptr, size,
+			       PAGE_SIZE << order, flags, node);
 	return ptr;
 }
 EXPORT_SYMBOL(kmalloc_large_node);
@@ -1291,7 +1291,7 @@ size_t ksize(const void *objp)
 EXPORT_SYMBOL(ksize);
 
 /* Tracepoints definitions. */
-EXPORT_TRACEPOINT_SYMBOL(kmem_cache_alloc_node);
+EXPORT_TRACEPOINT_SYMBOL(kmem_cache_alloc);
 EXPORT_TRACEPOINT_SYMBOL(kmem_cache_free);
 
 int should_failslab(struct kmem_cache *s, gfp_t gfpflags)
diff --git a/mm/slob.c b/mm/slob.c
index b1f291128e94..1bb4c577b908 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -505,8 +505,8 @@ __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
 		*m = size;
 		ret = (void *)m + minalign;
 
-		trace_kmem_cache_alloc_node(KMALLOC_NAME, caller, ret,
-					    size, size + minalign, gfp, node);
+		trace_kmem_cache_alloc(KMALLOC_NAME, caller, ret,
+				       size, size + minalign, gfp, node);
 	} else {
 		unsigned int order = get_order(size);
 
@@ -514,9 +514,9 @@ __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
 			gfp |= __GFP_COMP;
 		ret = slob_new_pages(gfp, order, node);
 
-		trace_kmem_cache_alloc_node(KMALLOC_LARGE_NAME, caller,
-					    ret, size, PAGE_SIZE << order,
-					    gfp, node);
+		trace_kmem_cache_alloc(KMALLOC_LARGE_NAME, caller,
+				       ret, size, PAGE_SIZE << order,
+				       gfp, node);
 	}
 
 	kmemleak_alloc(ret, size, 1, gfp);
@@ -599,14 +599,14 @@ static void *slob_alloc_node(struct kmem_cache *c, gfp_t flags, int node,
 
 	if (c->size < PAGE_SIZE) {
 		b = slob_alloc(c->size, flags, c->align, node, 0);
-		trace_kmem_cache_alloc_node(c->name, caller, b, c->object_size,
-					    SLOB_UNITS(c->size) * SLOB_UNIT,
-					    flags, node);
+		trace_kmem_cache_alloc(c->name, caller, b, c->object_size,
+				       SLOB_UNITS(c->size) * SLOB_UNIT,
+				       flags, node);
 	} else {
 		b = slob_new_pages(flags, get_order(c->size), node);
-		trace_kmem_cache_alloc_node(c->name, caller, b, c->object_size,
-					    PAGE_SIZE << get_order(c->size),
-					    flags, node);
+		trace_kmem_cache_alloc(c->name, caller, b, c->object_size,
+				       PAGE_SIZE << get_order(c->size),
+				       flags, node);
 	}
 
 	if (b && c->ctor) {
diff --git a/mm/slub.c b/mm/slub.c
index d53e9e22d67e..a088d4fa1062 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3215,8 +3215,8 @@ void *__kmem_cache_alloc_node(struct kmem_cache *s, struct list_lru *lru, gfp_t
 {
 	void *ret = slab_alloc_node(s, lru, gfpflags, node, caller, s->object_size);
 
-	trace_kmem_cache_alloc_node(s->name, caller, ret, s->object_size,
-				    s->size, gfpflags, node);
+	trace_kmem_cache_alloc(s->name, caller, ret, s->object_size,
+			       s->size, gfpflags, node);
 
 	return ret;
 }
@@ -3229,8 +3229,8 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *s,
 {
 	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, size);
 
-	trace_kmem_cache_alloc_node(s->name, _RET_IP_, ret,
-				    size, s->size, gfpflags, node);
+	trace_kmem_cache_alloc(s->name, _RET_IP_, ret,
+			       size, s->size, gfpflags, node);
 
 	ret = kasan_kmalloc(s, ret, size, gfpflags);
 	return ret;
@@ -4352,8 +4352,8 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node)
 
 	ret = slab_alloc_node(s, NULL, flags, node, _RET_IP_, size);
 
-	trace_kmem_cache_alloc_node(s->name, _RET_IP_, ret, size,
-				    s->size, flags, node);
+	trace_kmem_cache_alloc(s->name, _RET_IP_, ret, size,
+			       s->size, flags, node);
 
 	ret = kasan_kmalloc(s, ret, size, flags);
 
@@ -4815,8 +4815,8 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
 	ret = slab_alloc_node(s, NULL, gfpflags, node, caller, size);
 
 	/* Honor the call site pointer we received. */
-	trace_kmem_cache_alloc_node(s->name, caller, ret, size,
-				    s->size, gfpflags, node);
+	trace_kmem_cache_alloc(s->name, caller, ret, size,
+			       s->size, gfpflags, node);
 
 	return ret;
 }
-- 
2.32.0


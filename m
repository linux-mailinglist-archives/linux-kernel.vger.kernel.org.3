Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C1651E94D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 21:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446810AbiEGTF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 15:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiEGTF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 15:05:56 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6143F2A251
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 12:02:08 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id b18so17531561lfv.9
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 12:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=jEFAPBPCoyxEbePRic1lFbFmMEMA0csnFnlbXq62ZMI=;
        b=LrlPZfcZIIyGLXNrQ1w8Dh0b5aW6SFgmAa4d2R1HX9229xaUN/2tqvZ66zTGxCuoFL
         qakqX2ExWorzFyrMdf0fzzXK9T2jch+w/mGaneFtrES0oQrNVwjREyRaGUMdx4utV0Ub
         7NkOStQ1pRi+aGkxbg7478nE4hh/IUn/woznJkeVQZ/tnidDAnjeYwk6Rg3eZy3h/8wa
         wS4uy63DvsMCP01oh8VVaFnM9XAzdRqbTcsIjjWIit70EN/TLVIQTMelMbHt/78ZH9F8
         G9d6sOBN98AQ4bqtHdpo2GbRtX1jaHd7e8OsBPQw1LIwtHbqz6RvskKJd/zVHl2x386y
         Tdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=jEFAPBPCoyxEbePRic1lFbFmMEMA0csnFnlbXq62ZMI=;
        b=dj4NCrR6X/n1CXIimd0BtASSOQvnmfrdyu1xNaB2eVzjxDyoBcf3EmyJZE9m0kAwbv
         M+cn8FK596rHwyZhNMN1dKXPjo24sDTe8jdivZkR0uaxuH6qBFpkoA04ghqy9d3Dlsbg
         PXoz9uvx+DIeHk99OLQKYmtSdXPOd1Qyn4QpSXH6d1CACZ9n2G5WVNm8RewULUvoTYu/
         OthC7QYpiPoZ36yFiO+N4M8hGTgYgfRwgkN+gC/zI28pXK01sU1Zhwu1h0pPsqeHIenp
         kMmckIOQdDUQ76QieOkzfwBN01r2txsSLZcsHHnojQLr3jvlcdFd4HUgz/HxkCvS/W9T
         a2jA==
X-Gm-Message-State: AOAM533FTHiZhLaA8jybbfkWKl317WIlA3U9ogYEB++CKlnJIRwQMFY1
        bE9xJ+sB3zSMhAz3ELyPBI0lgBxuy5nAzg==
X-Google-Smtp-Source: ABdhPJxEtp3s22FKYc/SpmLf10zoZH155Cma1LWgy0PF0lM6rz6MPujbOpEM+Uzadeh4Fm38NbZhug==
X-Received: by 2002:a19:e01e:0:b0:473:c404:230c with SMTP id x30-20020a19e01e000000b00473c404230cmr6835921lfg.194.1651950126679;
        Sat, 07 May 2022 12:02:06 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.177])
        by smtp.gmail.com with ESMTPSA id m18-20020ac24252000000b00473c87152besm525220lfl.178.2022.05.07.12.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 May 2022 12:02:06 -0700 (PDT)
Message-ID: <331d88fe-f4f7-657c-02a2-d977f15fbff6@openvz.org>
Date:   Sat, 7 May 2022 22:02:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm] tracing: incorrect gfp_t conversion
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <e1c09bbb-2c58-a986-c704-1db538da905a@openvz.org>
Content-Language: en-US
In-Reply-To: <e1c09bbb-2c58-a986-c704-1db538da905a@openvz.org>
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

Fixes the following sparse warnings:

include/trace/events/*: sparse: cast to restricted gfp_t
include/trace/events/*: sparse: restricted gfp_t degrades to integer

gfp_t type is bitwise and requires __force attributes for any casts.

Signed-off-by: Vasily Averin <vvs@openvz.org>
---
 include/linux/gfp.h               |  2 +-
 include/trace/events/btrfs.h      |  4 +-
 include/trace/events/compaction.h |  4 +-
 include/trace/events/kmem.h       | 12 ++---
 include/trace/events/mmflags.h    | 74 +++++++++++++++----------------
 include/trace/events/vmscan.h     | 16 +++----
 mm/compaction.c                   |  2 +-
 7 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 80f63c862be5..5f44c49abab7 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -352,7 +352,7 @@ static inline int gfp_migratetype(const gfp_t gfp_flags)
 		return MIGRATE_UNMOVABLE;
 
 	/* Group based on mobility */
-	return (gfp_flags & GFP_MOVABLE_MASK) >> GFP_MOVABLE_SHIFT;
+	return (__force unsigned long)(gfp_flags & GFP_MOVABLE_MASK) >> GFP_MOVABLE_SHIFT;
 }
 #undef GFP_MOVABLE_MASK
 #undef GFP_MOVABLE_SHIFT
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 0d729664b4b4..ea7a05ac49c3 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -1343,13 +1343,13 @@ TRACE_EVENT(alloc_extent_state,
 
 	TP_STRUCT__entry(
 		__field(const struct extent_state *, state)
-		__field(gfp_t, mask)
+		__field(unsigned long, mask)
 		__field(const void*, ip)
 	),
 
 	TP_fast_assign(
 		__entry->state	= state,
-		__entry->mask	= mask,
+		__entry->mask	= (__force unsigned long)mask,
 		__entry->ip	= (const void *)IP
 	),
 
diff --git a/include/trace/events/compaction.h b/include/trace/events/compaction.h
index 7d48e7079e48..915c11ee28e4 100644
--- a/include/trace/events/compaction.h
+++ b/include/trace/events/compaction.h
@@ -162,13 +162,13 @@ TRACE_EVENT(mm_compaction_try_to_compact_pages,
 
 	TP_STRUCT__entry(
 		__field(int, order)
-		__field(gfp_t, gfp_mask)
+		__field(unsigned long, gfp_mask)
 		__field(int, prio)
 	),
 
 	TP_fast_assign(
 		__entry->order = order;
-		__entry->gfp_mask = gfp_mask;
+		__entry->gfp_mask = (__force unsigned long)gfp_mask;
 		__entry->prio = prio;
 	),
 
diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index ddc8c944f417..71c141804222 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -24,7 +24,7 @@ DECLARE_EVENT_CLASS(kmem_alloc,
 		__field(	const void *,	ptr		)
 		__field(	size_t,		bytes_req	)
 		__field(	size_t,		bytes_alloc	)
-		__field(	gfp_t,		gfp_flags	)
+		__field(	unsigned long,	gfp_flags	)
 	),
 
 	TP_fast_assign(
@@ -32,7 +32,7 @@ DECLARE_EVENT_CLASS(kmem_alloc,
 		__entry->ptr		= ptr;
 		__entry->bytes_req	= bytes_req;
 		__entry->bytes_alloc	= bytes_alloc;
-		__entry->gfp_flags	= gfp_flags;
+		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
 	),
 
 	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s",
@@ -75,7 +75,7 @@ DECLARE_EVENT_CLASS(kmem_alloc_node,
 		__field(	const void *,	ptr		)
 		__field(	size_t,		bytes_req	)
 		__field(	size_t,		bytes_alloc	)
-		__field(	gfp_t,		gfp_flags	)
+		__field(	unsigned long,	gfp_flags	)
 		__field(	int,		node		)
 	),
 
@@ -84,7 +84,7 @@ DECLARE_EVENT_CLASS(kmem_alloc_node,
 		__entry->ptr		= ptr;
 		__entry->bytes_req	= bytes_req;
 		__entry->bytes_alloc	= bytes_alloc;
-		__entry->gfp_flags	= gfp_flags;
+		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
 		__entry->node		= node;
 	),
 
@@ -208,14 +208,14 @@ TRACE_EVENT(mm_page_alloc,
 	TP_STRUCT__entry(
 		__field(	unsigned long,	pfn		)
 		__field(	unsigned int,	order		)
-		__field(	gfp_t,		gfp_flags	)
+		__field(	unsigned long,	gfp_flags	)
 		__field(	int,		migratetype	)
 	),
 
 	TP_fast_assign(
 		__entry->pfn		= page ? page_to_pfn(page) : -1UL;
 		__entry->order		= order;
-		__entry->gfp_flags	= gfp_flags;
+		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
 		__entry->migratetype	= migratetype;
 	),
 
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 116ed4d5d0f8..51d4fa6f3f39 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -14,43 +14,43 @@
  */
 
 #define __def_gfpflag_names						\
-	{(unsigned long)GFP_TRANSHUGE,		"GFP_TRANSHUGE"},	\
-	{(unsigned long)GFP_TRANSHUGE_LIGHT,	"GFP_TRANSHUGE_LIGHT"}, \
-	{(unsigned long)GFP_HIGHUSER_MOVABLE,	"GFP_HIGHUSER_MOVABLE"},\
-	{(unsigned long)GFP_HIGHUSER,		"GFP_HIGHUSER"},	\
-	{(unsigned long)GFP_USER,		"GFP_USER"},		\
-	{(unsigned long)GFP_KERNEL_ACCOUNT,	"GFP_KERNEL_ACCOUNT"},	\
-	{(unsigned long)GFP_KERNEL,		"GFP_KERNEL"},		\
-	{(unsigned long)GFP_NOFS,		"GFP_NOFS"},		\
-	{(unsigned long)GFP_ATOMIC,		"GFP_ATOMIC"},		\
-	{(unsigned long)GFP_NOIO,		"GFP_NOIO"},		\
-	{(unsigned long)GFP_NOWAIT,		"GFP_NOWAIT"},		\
-	{(unsigned long)GFP_DMA,		"GFP_DMA"},		\
-	{(unsigned long)__GFP_HIGHMEM,		"__GFP_HIGHMEM"},	\
-	{(unsigned long)GFP_DMA32,		"GFP_DMA32"},		\
-	{(unsigned long)__GFP_HIGH,		"__GFP_HIGH"},		\
-	{(unsigned long)__GFP_ATOMIC,		"__GFP_ATOMIC"},	\
-	{(unsigned long)__GFP_IO,		"__GFP_IO"},		\
-	{(unsigned long)__GFP_FS,		"__GFP_FS"},		\
-	{(unsigned long)__GFP_NOWARN,		"__GFP_NOWARN"},	\
-	{(unsigned long)__GFP_RETRY_MAYFAIL,	"__GFP_RETRY_MAYFAIL"},	\
-	{(unsigned long)__GFP_NOFAIL,		"__GFP_NOFAIL"},	\
-	{(unsigned long)__GFP_NORETRY,		"__GFP_NORETRY"},	\
-	{(unsigned long)__GFP_COMP,		"__GFP_COMP"},		\
-	{(unsigned long)__GFP_ZERO,		"__GFP_ZERO"},		\
-	{(unsigned long)__GFP_NOMEMALLOC,	"__GFP_NOMEMALLOC"},	\
-	{(unsigned long)__GFP_MEMALLOC,		"__GFP_MEMALLOC"},	\
-	{(unsigned long)__GFP_HARDWALL,		"__GFP_HARDWALL"},	\
-	{(unsigned long)__GFP_THISNODE,		"__GFP_THISNODE"},	\
-	{(unsigned long)__GFP_RECLAIMABLE,	"__GFP_RECLAIMABLE"},	\
-	{(unsigned long)__GFP_MOVABLE,		"__GFP_MOVABLE"},	\
-	{(unsigned long)__GFP_ACCOUNT,		"__GFP_ACCOUNT"},	\
-	{(unsigned long)__GFP_WRITE,		"__GFP_WRITE"},		\
-	{(unsigned long)__GFP_RECLAIM,		"__GFP_RECLAIM"},	\
-	{(unsigned long)__GFP_DIRECT_RECLAIM,	"__GFP_DIRECT_RECLAIM"},\
-	{(unsigned long)__GFP_KSWAPD_RECLAIM,	"__GFP_KSWAPD_RECLAIM"},\
-	{(unsigned long)__GFP_ZEROTAGS,		"__GFP_ZEROTAGS"},	\
-	{(unsigned long)__GFP_SKIP_KASAN_POISON,"__GFP_SKIP_KASAN_POISON"}\
+	{(__force unsigned long)GFP_TRANSHUGE,		"GFP_TRANSHUGE"},	\
+	{(__force unsigned long)GFP_TRANSHUGE_LIGHT,	"GFP_TRANSHUGE_LIGHT"}, \
+	{(__force unsigned long)GFP_HIGHUSER_MOVABLE,	"GFP_HIGHUSER_MOVABLE"},\
+	{(__force unsigned long)GFP_HIGHUSER,		"GFP_HIGHUSER"},	\
+	{(__force unsigned long)GFP_USER,		"GFP_USER"},		\
+	{(__force unsigned long)GFP_KERNEL_ACCOUNT,	"GFP_KERNEL_ACCOUNT"},	\
+	{(__force unsigned long)GFP_KERNEL,		"GFP_KERNEL"},		\
+	{(__force unsigned long)GFP_NOFS,		"GFP_NOFS"},		\
+	{(__force unsigned long)GFP_ATOMIC,		"GFP_ATOMIC"},		\
+	{(__force unsigned long)GFP_NOIO,		"GFP_NOIO"},		\
+	{(__force unsigned long)GFP_NOWAIT,		"GFP_NOWAIT"},		\
+	{(__force unsigned long)GFP_DMA,		"GFP_DMA"},		\
+	{(__force unsigned long)__GFP_HIGHMEM,		"__GFP_HIGHMEM"},	\
+	{(__force unsigned long)GFP_DMA32,		"GFP_DMA32"},		\
+	{(__force unsigned long)__GFP_HIGH,		"__GFP_HIGH"},		\
+	{(__force unsigned long)__GFP_ATOMIC,		"__GFP_ATOMIC"},	\
+	{(__force unsigned long)__GFP_IO,		"__GFP_IO"},		\
+	{(__force unsigned long)__GFP_FS,		"__GFP_FS"},		\
+	{(__force unsigned long)__GFP_NOWARN,		"__GFP_NOWARN"},	\
+	{(__force unsigned long)__GFP_RETRY_MAYFAIL,	"__GFP_RETRY_MAYFAIL"},	\
+	{(__force unsigned long)__GFP_NOFAIL,		"__GFP_NOFAIL"},	\
+	{(__force unsigned long)__GFP_NORETRY,		"__GFP_NORETRY"},	\
+	{(__force unsigned long)__GFP_COMP,		"__GFP_COMP"},		\
+	{(__force unsigned long)__GFP_ZERO,		"__GFP_ZERO"},		\
+	{(__force unsigned long)__GFP_NOMEMALLOC,	"__GFP_NOMEMALLOC"},	\
+	{(__force unsigned long)__GFP_MEMALLOC,		"__GFP_MEMALLOC"},	\
+	{(__force unsigned long)__GFP_HARDWALL,		"__GFP_HARDWALL"},	\
+	{(__force unsigned long)__GFP_THISNODE,		"__GFP_THISNODE"},	\
+	{(__force unsigned long)__GFP_RECLAIMABLE,	"__GFP_RECLAIMABLE"},	\
+	{(__force unsigned long)__GFP_MOVABLE,		"__GFP_MOVABLE"},	\
+	{(__force unsigned long)__GFP_ACCOUNT,		"__GFP_ACCOUNT"},	\
+	{(__force unsigned long)__GFP_WRITE,		"__GFP_WRITE"},		\
+	{(__force unsigned long)__GFP_RECLAIM,		"__GFP_RECLAIM"},	\
+	{(__force unsigned long)__GFP_DIRECT_RECLAIM,	"__GFP_DIRECT_RECLAIM"},\
+	{(__force unsigned long)__GFP_KSWAPD_RECLAIM,	"__GFP_KSWAPD_RECLAIM"},\
+	{(__force unsigned long)__GFP_ZEROTAGS,		"__GFP_ZEROTAGS"},	\
+	{(__force unsigned long)__GFP_SKIP_KASAN_POISON, "__GFP_SKIP_KASAN_POISON"} \
 
 #define show_gfp_flags(flags)						\
 	(flags) ? __print_flags(flags, "|",				\
diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index ca2e9009a651..b1db02c1aa6f 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -96,14 +96,14 @@ TRACE_EVENT(mm_vmscan_wakeup_kswapd,
 		__field(	int,	nid		)
 		__field(	int,	zid		)
 		__field(	int,	order		)
-		__field(	gfp_t,	gfp_flags	)
+		__field(	unsigned long,	gfp_flags	)
 	),
 
 	TP_fast_assign(
 		__entry->nid		= nid;
 		__entry->zid		= zid;
 		__entry->order		= order;
-		__entry->gfp_flags	= gfp_flags;
+		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
 	),
 
 	TP_printk("nid=%d order=%d gfp_flags=%s",
@@ -120,12 +120,12 @@ DECLARE_EVENT_CLASS(mm_vmscan_direct_reclaim_begin_template,
 
 	TP_STRUCT__entry(
 		__field(	int,	order		)
-		__field(	gfp_t,	gfp_flags	)
+		__field(	unsigned long,	gfp_flags	)
 	),
 
 	TP_fast_assign(
 		__entry->order		= order;
-		__entry->gfp_flags	= gfp_flags;
+		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
 	),
 
 	TP_printk("order=%d gfp_flags=%s",
@@ -210,7 +210,7 @@ TRACE_EVENT(mm_shrink_slab_start,
 		__field(void *, shrink)
 		__field(int, nid)
 		__field(long, nr_objects_to_shrink)
-		__field(gfp_t, gfp_flags)
+		__field(unsigned long, gfp_flags)
 		__field(unsigned long, cache_items)
 		__field(unsigned long long, delta)
 		__field(unsigned long, total_scan)
@@ -222,7 +222,7 @@ TRACE_EVENT(mm_shrink_slab_start,
 		__entry->shrink = shr->scan_objects;
 		__entry->nid = sc->nid;
 		__entry->nr_objects_to_shrink = nr_objects_to_shrink;
-		__entry->gfp_flags = sc->gfp_mask;
+		__entry->gfp_flags = (__force unsigned long)sc->gfp_mask;
 		__entry->cache_items = cache_items;
 		__entry->delta = delta;
 		__entry->total_scan = total_scan;
@@ -446,13 +446,13 @@ TRACE_EVENT(mm_vmscan_node_reclaim_begin,
 	TP_STRUCT__entry(
 		__field(int, nid)
 		__field(int, order)
-		__field(gfp_t, gfp_flags)
+		__field(unsigned long, gfp_flags)
 	),
 
 	TP_fast_assign(
 		__entry->nid = nid;
 		__entry->order = order;
-		__entry->gfp_flags = gfp_flags;
+		__entry->gfp_flags = (__force unsigned long)gfp_flags;
 	),
 
 	TP_printk("nid=%d order=%d gfp_flags=%s",
diff --git a/mm/compaction.c b/mm/compaction.c
index b4e94cda3019..746dafa4e6eb 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2558,7 +2558,7 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
 		unsigned int alloc_flags, const struct alloc_context *ac,
 		enum compact_priority prio, struct page **capture)
 {
-	int may_perform_io = gfp_mask & __GFP_IO;
+	int may_perform_io = (__force int)(gfp_mask & __GFP_IO);
 	struct zoneref *z;
 	struct zone *zone;
 	enum compact_result rc = COMPACT_SKIPPED;
-- 
2.31.1


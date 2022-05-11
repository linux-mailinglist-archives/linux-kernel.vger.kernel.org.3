Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B68522D0C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242760AbiEKHUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242759AbiEKHUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:20:48 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA447645E
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:20:43 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id i10so1912450lfg.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=mndkUjMrhSmFkIAWUld7bCBDBLYn0OkTU8SQN2+aYv0=;
        b=WheWdRFmwhIcAzJX2KQiUtLhiwiAjeG9cfPi5UpYlfkB4yL5wHupzJsBRhcqgP1VVm
         fS0pX2HN/BA8JxkzjDUYkdETP/LNl3VGZd722jxtP+FNC2nRoBb9jjjbAl7dEo/lGYx7
         rCjbsoC1e2+vfmVkIXWQdfETZe79ry9COhew02QNMHDi1cXbSZ5MBn92ikVF+w05Zqqr
         wXF3fsx2JlIeLqG7Xj0bm8lMQ0F9HSc46S84NE6jwQlHIbpfEkSlPaJc47aVcz1kbfOC
         FWjGxCVeH+PEbNe/1/3DfDkK/VNSbu8MlKuGPKILzyfOiECl3KHj6pKsrwEZ4HfYrcdf
         rX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=mndkUjMrhSmFkIAWUld7bCBDBLYn0OkTU8SQN2+aYv0=;
        b=rhHuaktURcKzy2EJLoTeGjaowTObgVMoZk2gJqDOrsuKY0vjrQbn0yEEp1TQX5xDU8
         qd7sxcn1XBiOzKLb7VxkGTA/AunpXhlgCjKSH7yhXcHa9dWrt46LsuxnAlxxCFdO4drr
         HK6Dyo4CTd9WM6BOwLnUtl4s6XUqlOcDoVAevZPjDVVf8/Xfyy19tZByUp96pWhE8VgO
         DG/fnMUFd0VAZKAWLzPxQLJo4d69GMHxGvbgb/27tZgBsYVbeVbReB4Rwnvl9WK5GGAK
         CJ/75MmTpPbOj3vk7eOJZrATv8V0T5qByIyHSDnWdMI+UJbRzKRKol6bI7HChV6A/e8W
         NdaA==
X-Gm-Message-State: AOAM530ImaJgyrfa9lpXe4uL74F63ZibTZ+G/erlSpWjCUTyrEncVL4I
        TvzQbsbQZPxCMzHyIlmZ6XrTaw==
X-Google-Smtp-Source: ABdhPJwH+R18HUC6i+B0eSB5B6WAFoh9uHwhTGJ/MSX8VJzurObkAE9tzxebWz83t8oI0GU5I/LfYw==
X-Received: by 2002:a05:6512:2398:b0:473:9cf5:1750 with SMTP id c24-20020a056512239800b004739cf51750mr18896516lfv.300.1652253641654;
        Wed, 11 May 2022 00:20:41 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.177])
        by smtp.gmail.com with ESMTPSA id g20-20020a0565123b9400b0047255d2114bsm153404lfv.122.2022.05.11.00.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 00:20:40 -0700 (PDT)
Message-ID: <8b9ba8ce-7376-2ef2-95f5-30e53cb46914@openvz.org>
Date:   Wed, 11 May 2022 10:20:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v2] tracing: incorrect gfp_t conversion
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Joe Perches <joe@perches.com>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <b8feb625dd2ba0d0dfc298a2f39ca1d8368ba5c9.camel@perches.com>
Content-Language: en-US
In-Reply-To: <b8feb625dd2ba0d0dfc298a2f39ca1d8368ba5c9.camel@perches.com>
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

Signed-off-by:	Vasily Averin <vvs@openvz.org>
---
v2: 1) re-based to 5.18-rc6
    2) re-defined __def_gfpflag_names array according to
	akpm@, willy@ and Joe Perches recommendations
---
 include/linux/gfp.h               |  2 +-
 include/trace/events/btrfs.h      |  4 +-
 include/trace/events/compaction.h |  4 +-
 include/trace/events/kmem.h       | 12 ++---
 include/trace/events/mmflags.h    | 84 ++++++++++++++++---------------
 include/trace/events/vmscan.h     | 16 +++---
 mm/compaction.c                   |  2 +-
 7 files changed, 63 insertions(+), 61 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 3e3d36fc2109..ac6d750d512c 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -367,7 +367,7 @@ static inline int gfp_migratetype(const gfp_t gfp_flags)
 		return MIGRATE_UNMOVABLE;
 
 	/* Group based on mobility */
-	return (gfp_flags & GFP_MOVABLE_MASK) >> GFP_MOVABLE_SHIFT;
+	return (__force unsigned long)(gfp_flags & GFP_MOVABLE_MASK) >> GFP_MOVABLE_SHIFT;
 }
 #undef GFP_MOVABLE_MASK
 #undef GFP_MOVABLE_SHIFT
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index f068ff30d654..ed92c80331ea 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -1344,13 +1344,13 @@ TRACE_EVENT(alloc_extent_state,
 
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
index c6d5d70dc7a5..3313eb83c117 100644
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
index 6532119a6bf1..bbef42058a7e 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -13,49 +13,51 @@
  * Thus most bits set go first.
  */
 
-#define __def_gfpflag_names						\
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
-	{(unsigned long)__GFP_ZEROTAGS,		"__GFP_ZEROTAGS"}	\
+#define gfpflag_string(flag) {(__force unsigned long)flag, #flag}
+
+#define __def_gfpflag_names				\
+	gfpflag_string(GFP_TRANSHUGE),			\
+	gfpflag_string(GFP_TRANSHUGE_LIGHT),		\
+	gfpflag_string(GFP_HIGHUSER_MOVABLE),		\
+	gfpflag_string(GFP_HIGHUSER),			\
+	gfpflag_string(GFP_USER),			\
+	gfpflag_string(GFP_KERNEL_ACCOUNT),		\
+	gfpflag_string(GFP_KERNEL),			\
+	gfpflag_string(GFP_NOFS),			\
+	gfpflag_string(GFP_ATOMIC),			\
+	gfpflag_string(GFP_NOIO),			\
+	gfpflag_string(GFP_NOWAIT),			\
+	gfpflag_string(GFP_DMA),			\
+	gfpflag_string(__GFP_HIGHMEM),			\
+	gfpflag_string(GFP_DMA32),			\
+	gfpflag_string(__GFP_HIGH),			\
+	gfpflag_string(__GFP_ATOMIC),			\
+	gfpflag_string(__GFP_IO),			\
+	gfpflag_string(__GFP_FS),			\
+	gfpflag_string(__GFP_NOWARN),			\
+	gfpflag_string(__GFP_RETRY_MAYFAIL),		\
+	gfpflag_string(__GFP_NOFAIL),			\
+	gfpflag_string(__GFP_NORETRY),			\
+	gfpflag_string(__GFP_COMP),			\
+	gfpflag_string(__GFP_ZERO),			\
+	gfpflag_string(__GFP_NOMEMALLOC),		\
+	gfpflag_string(__GFP_MEMALLOC),			\
+	gfpflag_string(__GFP_HARDWALL),			\
+	gfpflag_string(__GFP_THISNODE),			\
+	gfpflag_string(__GFP_RECLAIMABLE),		\
+	gfpflag_string(__GFP_MOVABLE),			\
+	gfpflag_string(__GFP_ACCOUNT),			\
+	gfpflag_string(__GFP_WRITE),			\
+	gfpflag_string(__GFP_RECLAIM),			\
+	gfpflag_string(__GFP_DIRECT_RECLAIM),		\
+	gfpflag_string(__GFP_KSWAPD_RECLAIM),		\
+	gfpflag_string(__GFP_ZEROTAGS)
 
 #ifdef CONFIG_KASAN_HW_TAGS
-#define __def_gfpflag_names_kasan ,					       \
-	{(unsigned long)__GFP_SKIP_ZERO,	   "__GFP_SKIP_ZERO"},	       \
-	{(unsigned long)__GFP_SKIP_KASAN_POISON,   "__GFP_SKIP_KASAN_POISON"}, \
-	{(unsigned long)__GFP_SKIP_KASAN_UNPOISON, "__GFP_SKIP_KASAN_UNPOISON"}
+#define __def_gfpflag_names_kasan ,			\
+	gfpflag_string(__GFP_SKIP_ZERO),		\
+	gfpflag_string(__GFP_SKIP_KASAN_POISON),	\
+	gfpflag_string(__GFP_SKIP_KASAN_UNPOISON)
 #else
 #define __def_gfpflag_names_kasan
 #endif
diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index de136dbd623a..408c86244d64 100644
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
index fe915db6149b..bcdf167ab286 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2592,7 +2592,7 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
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


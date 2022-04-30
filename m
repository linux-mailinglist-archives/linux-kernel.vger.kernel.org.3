Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C78515FD1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 20:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244042AbiD3SeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 14:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbiD3SeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 14:34:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B7519C03
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 11:30:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABF7260FE5
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 18:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7836C385AA;
        Sat, 30 Apr 2022 18:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651343430;
        bh=je0qEa622nci8qW7SzkBFXYuW1uflWlMNAwC8qm4DK8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kKuJJwTRgJkf+Sr1a2ilyG9RDRYoDYIUkySQycgsgBwWCZJ2ZTfLYVD3VdfyhpJPv
         2AebJRfizlgBXW2ICZ1b3R2bUedbtNYn7RMWIv0z7dW5Ikf1ScUpt6e2ihzwy+Fane
         uUcE/XK5DDfAUFeTphE3hxXV0fmUNCSHmXR+WIOE=
Date:   Sat, 30 Apr 2022 11:30:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] MM: discard __GFP_ATOMIC
Message-Id: <20220430113028.9daeebeedf679aa384da5945@linux-foundation.org>
In-Reply-To: <YZzvcjRYTL+XEHHz@dhcp22.suse.cz>
References: <163712397076.13692.4727608274002939094@noble.neil.brown.name>
        <YZvItUOgTgD11etC@dhcp22.suse.cz>
        <163764199967.7248.2528204111227925210@noble.neil.brown.name>
        <YZzvcjRYTL+XEHHz@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

Discussion seemed to meander then peter out.  What's the thinking on
this patch now?  

Thanks.



From: "NeilBrown" <neilb@suse.de>
Subject: mm: discard __GFP_ATOMIC

__GFP_ATOMIC serves little purpose.  Its main effect is to set
ALLOC_HARDER which adds a few little boosts to increase the chance of an
allocation succeeding, one of which is to lower the water-mark at which it
will succeed.

It is *always* paired with __GFP_HIGH which sets ALLOC_HIGH which also
adjusts this watermark.  It is probable that other users of __GFP_HIGH
should benefit from the other little bonuses that __GFP_ATOMIC gets.

__GFP_ATOMIC also gives a warning if used with __GFP_DIRECT_RECLAIM. 
There is little point to this.  We already get a might_sleep() warning if
__GFP_DIRECT_RECLAIM is set.

__GFP_ATOMIC allows the "watermark_boost" to be side-stepped.  It is
probable that testing ALLOC_HARDER is a better fit here.

__GFP_ATOMIC is used by tegra-smmu.c to check if the allocation might
sleep.  This should test __GFP_DIRECT_RECLAIM instead.

This patch:
 - removes __GFP_ATOMIC
 - causes __GFP_HIGH to set ALLOC_HARDER unless __GFP_NOMEMALLOC is set
   (as well as ALLOC_HIGH).
 - makes other adjustments as suggested by the above.

The net result is not change to GFP_ATOMIC allocations.  Other
allocations that use __GFP_HIGH will benefit from a few different extra
privileges.  This affects:
  xen, dm, md, ntfs3
  the vermillion frame buffer
  hibernation
  ksm
  swap
all of which likely produce more benefit than cost if these selected
allocation are more likely to succeed quickly.

Link: https://lkml.kernel.org/r/163712397076.13692.4727608274002939094@noble.neil.brown.name
Signed-off-by: NeilBrown <neilb@suse.de>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 Documentation/vm/balance.rst   |    2 +-
 drivers/iommu/tegra-smmu.c     |    4 ++--
 include/linux/gfp.h            |   12 ++++--------
 include/trace/events/mmflags.h |    1 -
 lib/test_printf.c              |    8 ++++----
 mm/internal.h                  |    2 +-
 mm/page_alloc.c                |   16 ++++------------
 tools/include/linux/gfp.h      |    3 +--
 tools/perf/builtin-kmem.c      |    1 -
 9 files changed, 17 insertions(+), 32 deletions(-)

--- a/Documentation/vm/balance.rst~mm-discard-__gfp_atomic
+++ a/Documentation/vm/balance.rst
@@ -6,7 +6,7 @@ Memory Balancing
 
 Started Jan 2000 by Kanoj Sarcar <kanoj@sgi.com>
 
-Memory balancing is needed for !__GFP_ATOMIC and !__GFP_KSWAPD_RECLAIM as
+Memory balancing is needed for !__GFP_HIGH and !__GFP_KSWAPD_RECLAIM as
 well as for non __GFP_IO allocations.
 
 The first reason why a caller may avoid reclaim is that the caller can not
--- a/drivers/iommu/tegra-smmu.c~mm-discard-__gfp_atomic
+++ a/drivers/iommu/tegra-smmu.c
@@ -671,12 +671,12 @@ static struct page *as_get_pde_page(stru
 	 * allocate page in a sleeping context if GFP flags permit. Hence
 	 * spinlock needs to be unlocked and re-locked after allocation.
 	 */
-	if (!(gfp & __GFP_ATOMIC))
+	if (gfp & __GFP_DIRECT_RECLAIM)
 		spin_unlock_irqrestore(&as->lock, *flags);
 
 	page = alloc_page(gfp | __GFP_DMA | __GFP_ZERO);
 
-	if (!(gfp & __GFP_ATOMIC))
+	if (gfp & __GFP_DIRECT_RECLAIM)
 		spin_lock_irqsave(&as->lock, *flags);
 
 	/*
--- a/include/linux/gfp.h~mm-discard-__gfp_atomic
+++ a/include/linux/gfp.h
@@ -39,7 +39,7 @@ struct vm_area_struct;
 #define ___GFP_IO		0x40u
 #define ___GFP_FS		0x80u
 #define ___GFP_ZERO		0x100u
-#define ___GFP_ATOMIC		0x200u
+/* 0x200u unused */
 #define ___GFP_DIRECT_RECLAIM	0x400u
 #define ___GFP_KSWAPD_RECLAIM	0x800u
 #define ___GFP_WRITE		0x1000u
@@ -124,11 +124,8 @@ struct vm_area_struct;
  *
  * %__GFP_HIGH indicates that the caller is high-priority and that granting
  * the request is necessary before the system can make forward progress.
- * For example, creating an IO context to clean pages.
- *
- * %__GFP_ATOMIC indicates that the caller cannot reclaim or sleep and is
- * high priority. Users are typically interrupt handlers. This may be
- * used in conjunction with %__GFP_HIGH
+ * For example creating an IO context to clean pages and requests
+ * from atomic context.
  *
  * %__GFP_MEMALLOC allows access to all memory. This should only be used when
  * the caller guarantees the allocation will allow more memory to be freed
@@ -143,7 +140,6 @@ struct vm_area_struct;
  * %__GFP_NOMEMALLOC is used to explicitly forbid access to emergency reserves.
  * This takes precedence over the %__GFP_MEMALLOC flag if both are set.
  */
-#define __GFP_ATOMIC	((__force gfp_t)___GFP_ATOMIC)
 #define __GFP_HIGH	((__force gfp_t)___GFP_HIGH)
 #define __GFP_MEMALLOC	((__force gfp_t)___GFP_MEMALLOC)
 #define __GFP_NOMEMALLOC ((__force gfp_t)___GFP_NOMEMALLOC)
@@ -337,7 +333,7 @@ struct vm_area_struct;
  * version does not attempt reclaim/compaction at all and is by default used
  * in page fault path, while the non-light is used by khugepaged.
  */
-#define GFP_ATOMIC	(__GFP_HIGH|__GFP_ATOMIC|__GFP_KSWAPD_RECLAIM)
+#define GFP_ATOMIC	(__GFP_HIGH|__GFP_KSWAPD_RECLAIM)
 #define GFP_KERNEL	(__GFP_RECLAIM | __GFP_IO | __GFP_FS)
 #define GFP_KERNEL_ACCOUNT (GFP_KERNEL | __GFP_ACCOUNT)
 #define GFP_NOWAIT	(__GFP_KSWAPD_RECLAIM)
--- a/include/trace/events/mmflags.h~mm-discard-__gfp_atomic
+++ a/include/trace/events/mmflags.h
@@ -29,7 +29,6 @@
 	{(unsigned long)__GFP_HIGHMEM,		"__GFP_HIGHMEM"},	\
 	{(unsigned long)GFP_DMA32,		"GFP_DMA32"},		\
 	{(unsigned long)__GFP_HIGH,		"__GFP_HIGH"},		\
-	{(unsigned long)__GFP_ATOMIC,		"__GFP_ATOMIC"},	\
 	{(unsigned long)__GFP_IO,		"__GFP_IO"},		\
 	{(unsigned long)__GFP_FS,		"__GFP_FS"},		\
 	{(unsigned long)__GFP_NOWARN,		"__GFP_NOWARN"},	\
--- a/lib/test_printf.c~mm-discard-__gfp_atomic
+++ a/lib/test_printf.c
@@ -673,17 +673,17 @@ flags(void)
 	gfp = GFP_ATOMIC|__GFP_DMA;
 	test("GFP_ATOMIC|GFP_DMA", "%pGg", &gfp);
 
-	gfp = __GFP_ATOMIC;
-	test("__GFP_ATOMIC", "%pGg", &gfp);
+	gfp = __GFP_HIGH;
+	test("__GFP_HIGH", "%pGg", &gfp);
 
 	/* Any flags not translated by the table should remain numeric */
 	gfp = ~__GFP_BITS_MASK;
 	snprintf(cmp_buffer, BUF_SIZE, "%#lx", (unsigned long) gfp);
 	test(cmp_buffer, "%pGg", &gfp);
 
-	snprintf(cmp_buffer, BUF_SIZE, "__GFP_ATOMIC|%#lx",
+	snprintf(cmp_buffer, BUF_SIZE, "__GFP_HIGH|%#lx",
 							(unsigned long) gfp);
-	gfp |= __GFP_ATOMIC;
+	gfp |= __GFP_HIGH;
 	test(cmp_buffer, "%pGg", &gfp);
 
 	kfree(cmp_buffer);
--- a/mm/internal.h~mm-discard-__gfp_atomic
+++ a/mm/internal.h
@@ -24,7 +24,7 @@ struct folio_batch;
 #define GFP_RECLAIM_MASK (__GFP_RECLAIM|__GFP_HIGH|__GFP_IO|__GFP_FS|\
 			__GFP_NOWARN|__GFP_RETRY_MAYFAIL|__GFP_NOFAIL|\
 			__GFP_NORETRY|__GFP_MEMALLOC|__GFP_NOMEMALLOC|\
-			__GFP_ATOMIC|__GFP_NOLOCKDEP)
+			__GFP_NOLOCKDEP)
 
 /* The GFP flags allowed during early boot */
 #define GFP_BOOT_MASK (__GFP_BITS_MASK & ~(__GFP_RECLAIM|__GFP_IO|__GFP_FS))
--- a/mm/page_alloc.c~mm-discard-__gfp_atomic
+++ a/mm/page_alloc.c
@@ -3918,12 +3918,12 @@ static inline bool zone_watermark_fast(s
 					free_pages))
 		return true;
 	/*
-	 * Ignore watermark boosting for GFP_ATOMIC order-0 allocations
+	 * Ignore watermark boosting for GFP_HIGH order-0 allocations
 	 * when checking the min watermark. The min watermark is the
 	 * point where boosting is ignored so that kswapd is woken up
 	 * when below the low watermark.
 	 */
-	if (unlikely(!order && (gfp_mask & __GFP_ATOMIC) && z->watermark_boost
+	if (unlikely(!order && (alloc_flags & ALLOC_HARDER) && z->watermark_boost
 		&& ((alloc_flags & ALLOC_WMARK_MASK) == WMARK_MIN))) {
 		mark = z->_watermark[WMARK_MIN];
 		return __zone_watermark_ok(z, order, mark, highest_zoneidx,
@@ -4657,12 +4657,12 @@ gfp_to_alloc_flags(gfp_t gfp_mask)
 	 * The caller may dip into page reserves a bit more if the caller
 	 * cannot run direct reclaim, or if the caller has realtime scheduling
 	 * policy or is asking for __GFP_HIGH memory.  GFP_ATOMIC requests will
-	 * set both ALLOC_HARDER (__GFP_ATOMIC) and ALLOC_HIGH (__GFP_HIGH).
+	 * set both ALLOC_HARDER (unless __GFP_NOMEMALLOC) and ALLOC_HIGH.
 	 */
 	alloc_flags |= (__force int)
 		(gfp_mask & (__GFP_HIGH | __GFP_KSWAPD_RECLAIM));
 
-	if (gfp_mask & __GFP_ATOMIC) {
+	if (gfp_mask & __GFP_HIGH) {
 		/*
 		 * Not worth trying to allocate harder for __GFP_NOMEMALLOC even
 		 * if it can't schedule.
@@ -4855,14 +4855,6 @@ __alloc_pages_slowpath(gfp_t gfp_mask, u
 	unsigned int cpuset_mems_cookie;
 	int reserve_flags;
 
-	/*
-	 * We also sanity check to catch abuse of atomic reserves being used by
-	 * callers that are not in atomic context.
-	 */
-	if (WARN_ON_ONCE((gfp_mask & (__GFP_ATOMIC|__GFP_DIRECT_RECLAIM)) ==
-				(__GFP_ATOMIC|__GFP_DIRECT_RECLAIM)))
-		gfp_mask &= ~__GFP_ATOMIC;
-
 retry_cpuset:
 	compaction_retries = 0;
 	no_progress_loops = 0;
--- a/tools/include/linux/gfp.h~mm-discard-__gfp_atomic
+++ a/tools/include/linux/gfp.h
@@ -12,7 +12,6 @@
 #define __GFP_FS		0x80u
 #define __GFP_NOWARN		0x200u
 #define __GFP_ZERO		0x8000u
-#define __GFP_ATOMIC		0x80000u
 #define __GFP_ACCOUNT		0x100000u
 #define __GFP_DIRECT_RECLAIM	0x400000u
 #define __GFP_KSWAPD_RECLAIM	0x2000000u
@@ -20,7 +19,7 @@
 #define __GFP_RECLAIM	(__GFP_DIRECT_RECLAIM | __GFP_KSWAPD_RECLAIM)
 
 #define GFP_ZONEMASK	0x0fu
-#define GFP_ATOMIC	(__GFP_HIGH | __GFP_ATOMIC | __GFP_KSWAPD_RECLAIM)
+#define GFP_ATOMIC	(__GFP_HIGH | __GFP_KSWAPD_RECLAIM)
 #define GFP_KERNEL	(__GFP_RECLAIM | __GFP_IO | __GFP_FS)
 #define GFP_NOWAIT	(__GFP_KSWAPD_RECLAIM)
 
--- a/tools/perf/builtin-kmem.c~mm-discard-__gfp_atomic
+++ a/tools/perf/builtin-kmem.c
@@ -640,7 +640,6 @@ static const struct {
 	{ "__GFP_HIGHMEM",		"HM" },
 	{ "GFP_DMA32",			"D32" },
 	{ "__GFP_HIGH",			"H" },
-	{ "__GFP_ATOMIC",		"_A" },
 	{ "__GFP_IO",			"I" },
 	{ "__GFP_FS",			"F" },
 	{ "__GFP_NOWARN",		"NWR" },
_


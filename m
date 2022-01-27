Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A7249DD0C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 09:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238022AbiA0I4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 03:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238000AbiA0I4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 03:56:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9B8C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 00:56:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C60E761B04
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 08:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B87C340EB;
        Thu, 27 Jan 2022 08:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643273781;
        bh=I6Lml67mMk2bEDGtoWeFKAaRqTkT3XAvz34UG78eTJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NfkytKX71EBL9008d5+S9NdWVxs0Ug/kMXoZCg6bE9Z1Ur3j9L8Fykz6sD9Y48fPQ
         2Maz2A6OwogWPgldiV3rj3uTw4W1p/TybH+D6z5W+kpyN5woFrsSh0SkKWB5SU9ter
         7CStMgXAzE6vM17fS/lz06mjnqFtQUrH7jJqWakLcJSIsUeMj87ci4ZYQSO048PRVm
         r08wi2Og7E7kuq46kd4WE6X+6SqTRCOUuc5eRTFB09iO22GjJbGu5zSUKbfGe3nrVT
         B8FfDlhteW3agBIqC5DfCeLQA3zE0E0Ces2ulVC1K6jz/8heMhcAxgH3z/yIBpvv09
         hv/L/+W030twg==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: [RFC PATCH 1/3] mm/page_alloc: introduce __GFP_UNMAPPED and MIGRATE_UNMAPPED
Date:   Thu, 27 Jan 2022 10:56:06 +0200
Message-Id: <20220127085608.306306-2-rppt@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220127085608.306306-1-rppt@kernel.org>
References: <20220127085608.306306-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

When set_memory or set_direct_map APIs used to change attribute or
permissions for chunks of several pages, the large PMD that maps these
pages in the direct map must be split. Fragmenting the direct map in such
manner causes TLB pressure and, eventually, performance degradation.

To avoid excessive direct map fragmentation, add ability to allocate
"unmapped" pages with __GFP_UNMAPPED flag and a new migrate type
MIGRATE_UNMAPPED that will contain pages that are mapped with PTEs in the
direct map.

When allocation flags include __GFP_UNMAPPED, the allocated page(s) are
remapped at PTE level in the direct map along with the other free pages in
the same pageblock. The free pages in that pageblock are placed on
MIGRATE_UNMAPPED free lists and subsequent __GFP_UNMAPPED request are
served from the MIGRATE_UNMAPPED free lists.

This way, a single split of a large PMD creates a cache of PTE-mapped pages
that can be used without the need to split another PMD.

The pages are removed from the direct map late during allocation to keep
the existing logic in prep_new_page() for clearing, poisoning and other
page content accesses.

When a page from MIGRATE_UNMAPPED pageblock is freed, it is restored in the
direct map to allow proper page contents access in free_pages_prepare().

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/Kconfig                   |   7 ++
 arch/x86/Kconfig               |   1 +
 include/linux/gfp.h            |  13 +++-
 include/linux/mmzone.h         |  11 +++
 include/trace/events/mmflags.h |   3 +-
 mm/internal.h                  |   2 +-
 mm/page_alloc.c                | 129 ++++++++++++++++++++++++++++++++-
 7 files changed, 160 insertions(+), 6 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 678a80713b21..e16a70ed0b2d 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1321,6 +1321,13 @@ config DYNAMIC_SIGFRAME
 # Select, if arch has a named attribute group bound to NUMA device nodes.
 config HAVE_ARCH_NODE_DEV_GROUP
 	bool
+#
+# Select if the architecture wants to minimize fragmentation of its
+# direct/linear map cauesd by set_memory and set_direct_map operations
+#
+config ARCH_WANTS_GFP_UNMAPPED
+	bool
+	depends on ARCH_HAS_SET_MEMORY || ARCH_HAS_SET_DIRECT_MAP
 
 source "kernel/gcov/Kconfig"
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ebe8fc76949a..564e97c88ef0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -120,6 +120,7 @@ config X86
 	select ARCH_WANTS_NO_INSTR
 	select ARCH_WANT_HUGE_PMD_SHARE
 	select ARCH_WANT_LD_ORPHAN_WARN
+	select ARCH_WANTS_GFP_UNMAPPED
 	select ARCH_WANTS_THP_SWAP		if X86_64
 	select ARCH_HAS_PARANOID_L1D_FLUSH
 	select BUILDTIME_TABLE_SORT
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 80f63c862be5..63b8d3b2711d 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -55,8 +55,9 @@ struct vm_area_struct;
 #define ___GFP_ACCOUNT		0x400000u
 #define ___GFP_ZEROTAGS		0x800000u
 #define ___GFP_SKIP_KASAN_POISON	0x1000000u
+#define ___GFP_UNMAPPED		0x2000000u
 #ifdef CONFIG_LOCKDEP
-#define ___GFP_NOLOCKDEP	0x2000000u
+#define ___GFP_NOLOCKDEP	0x4000000u
 #else
 #define ___GFP_NOLOCKDEP	0
 #endif
@@ -101,12 +102,15 @@ struct vm_area_struct;
  * node with no fallbacks or placement policy enforcements.
  *
  * %__GFP_ACCOUNT causes the allocation to be accounted to kmemcg.
+ *
+ * %__GFP_UNMAPPED removes the allocated pages from the direct map.
  */
 #define __GFP_RECLAIMABLE ((__force gfp_t)___GFP_RECLAIMABLE)
 #define __GFP_WRITE	((__force gfp_t)___GFP_WRITE)
 #define __GFP_HARDWALL   ((__force gfp_t)___GFP_HARDWALL)
 #define __GFP_THISNODE	((__force gfp_t)___GFP_THISNODE)
 #define __GFP_ACCOUNT	((__force gfp_t)___GFP_ACCOUNT)
+#define __GFP_UNMAPPED	((__force gfp_t)___GFP_UNMAPPED)
 
 /**
  * DOC: Watermark modifiers
@@ -249,7 +253,7 @@ struct vm_area_struct;
 #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
 
 /* Room for N __GFP_FOO bits */
-#define __GFP_BITS_SHIFT (25 + IS_ENABLED(CONFIG_LOCKDEP))
+#define __GFP_BITS_SHIFT (26 + IS_ENABLED(CONFIG_LOCKDEP))
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
 
 /**
@@ -348,6 +352,11 @@ static inline int gfp_migratetype(const gfp_t gfp_flags)
 	BUILD_BUG_ON((1UL << GFP_MOVABLE_SHIFT) != ___GFP_MOVABLE);
 	BUILD_BUG_ON((___GFP_MOVABLE >> GFP_MOVABLE_SHIFT) != MIGRATE_MOVABLE);
 
+#ifdef CONFIG_ARCH_WANTS_GFP_UNMAPPED
+	if (unlikely(gfp_flags & __GFP_UNMAPPED))
+		return MIGRATE_UNMAPPED;
+#endif
+
 	if (unlikely(page_group_by_mobility_disabled))
 		return MIGRATE_UNMOVABLE;
 
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index aed44e9b5d89..7971af97b6cf 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -43,6 +43,9 @@ enum migratetype {
 	MIGRATE_UNMOVABLE,
 	MIGRATE_MOVABLE,
 	MIGRATE_RECLAIMABLE,
+#ifdef CONFIG_ARCH_WANTS_GFP_UNMAPPED
+	MIGRATE_UNMAPPED,
+#endif
 	MIGRATE_PCPTYPES,	/* the number of types on the pcp lists */
 	MIGRATE_HIGHATOMIC = MIGRATE_PCPTYPES,
 #ifdef CONFIG_CMA
@@ -78,6 +81,14 @@ extern const char * const migratetype_names[MIGRATE_TYPES];
 #  define is_migrate_cma_page(_page) false
 #endif
 
+#ifdef CONFIG_ARCH_WANTS_GFP_UNMAPPED
+#  define is_migrate_unmapped(migratetype) unlikely((migratetype) == MIGRATE_UNMAPPED)
+#  define is_migrate_unmapped_page(_page) (get_pageblock_migratetype(_page) == MIGRATE_UNMAPPED)
+#else
+#  define is_migrate_unmapped(migratetype) false
+#  define is_migrate_unmapped_page(_page) false
+#endif
+
 static inline bool is_migrate_movable(int mt)
 {
 	return is_migrate_cma(mt) || mt == MIGRATE_MOVABLE;
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 116ed4d5d0f8..501f37f4095d 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -50,7 +50,8 @@
 	{(unsigned long)__GFP_DIRECT_RECLAIM,	"__GFP_DIRECT_RECLAIM"},\
 	{(unsigned long)__GFP_KSWAPD_RECLAIM,	"__GFP_KSWAPD_RECLAIM"},\
 	{(unsigned long)__GFP_ZEROTAGS,		"__GFP_ZEROTAGS"},	\
-	{(unsigned long)__GFP_SKIP_KASAN_POISON,"__GFP_SKIP_KASAN_POISON"}\
+	{(unsigned long)__GFP_SKIP_KASAN_POISON,"__GFP_SKIP_KASAN_POISON"},\
+	{(unsigned long)__GFP_UNMAPPED,		"__GFP_UNMAPPED"}	\
 
 #define show_gfp_flags(flags)						\
 	(flags) ? __print_flags(flags, "|",				\
diff --git a/mm/internal.h b/mm/internal.h
index d80300392a19..3edc3abf3f56 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -32,7 +32,7 @@ struct folio_batch;
 #define GFP_CONSTRAINT_MASK (__GFP_HARDWALL|__GFP_THISNODE)
 
 /* Do not use these with a slab allocator */
-#define GFP_SLAB_BUG_MASK (__GFP_DMA32|__GFP_HIGHMEM|~__GFP_BITS_MASK)
+#define GFP_SLAB_BUG_MASK (__GFP_DMA32|__GFP_HIGHMEM|__GFP_UNMAPPED|~__GFP_BITS_MASK)
 
 void page_writeback_init(void);
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3589febc6d31..da6b1bb912a8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -75,6 +75,7 @@
 #include <linux/khugepaged.h>
 #include <linux/buffer_head.h>
 #include <linux/delayacct.h>
+#include <linux/set_memory.h>
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -82,6 +83,12 @@
 #include "shuffle.h"
 #include "page_reporting.h"
 
+/*
+ * FIXME: add a proper definition in include/linux/mm.h once remaining
+ * definitions of PMD_ORDER in arch/ are updated
+ */
+#define PMD_ORDER      (PMD_SHIFT - PAGE_SHIFT)
+
 /* Free Page Internal flags: for internal, non-pcp variants of free_pages(). */
 typedef int __bitwise fpi_t;
 
@@ -319,6 +326,9 @@ const char * const migratetype_names[MIGRATE_TYPES] = {
 	"Unmovable",
 	"Movable",
 	"Reclaimable",
+#ifdef CONFIG_ARCH_WANTS_GFP_UNMAPPED
+	"Unmapped",
+#endif
 	"HighAtomic",
 #ifdef CONFIG_CMA
 	"CMA",
@@ -938,9 +948,10 @@ compaction_capture(struct capture_control *capc, struct page *page,
 	if (!capc || order != capc->cc->order)
 		return false;
 
-	/* Do not accidentally pollute CMA or isolated regions*/
+	/* Do not accidentally pollute CMA or isolated or unmapped regions */
 	if (is_migrate_cma(migratetype) ||
-	    is_migrate_isolate(migratetype))
+	    is_migrate_isolate(migratetype) ||
+	    is_migrate_unmapped(migratetype))
 		return false;
 
 	/*
@@ -1143,6 +1154,17 @@ static inline void __free_one_page(struct page *page,
 done_merging:
 	set_buddy_order(page, order);
 
+#if 0
+	/*
+	 * FIXME: collapse PMD-size page in the direct map and move the
+	 * pageblock from MIGRATE_UNMAPPED to another migrate type.
+	 */
+	if ((order == PMD_ORDER) && is_migrate_unmapped_page(page)) {
+		set_direct_map_PMD(page);
+		set_pageblock_migratetype(page, MIGRATE_MOVABLE);
+	}
+#endif
+
 	if (fpi_flags & FPI_TO_TAIL)
 		to_tail = true;
 	else if (is_shuffle_order(order))
@@ -1271,6 +1293,40 @@ static int free_tail_pages_check(struct page *head_page, struct page *page)
 	return ret;
 }
 
+static void migrate_unmapped_map_pages(struct page *page, unsigned int nr)
+{
+#ifdef CONFIG_ARCH_WANTS_GFP_UNMAPPED
+	int i;
+
+	if (!is_migrate_unmapped_page(page))
+		return;
+
+	for (i = 0; i < nr; i++)
+		set_direct_map_default_noflush(page + i);
+#endif
+}
+
+static void migrate_unmapped_unmap_pages(struct page *page, unsigned int nr,
+					 gfp_t gfp)
+{
+#ifdef CONFIG_ARCH_WANTS_GFP_UNMAPPED
+	unsigned long start = (unsigned long)page_address(page);
+	unsigned long end = start + nr * PAGE_SIZE;
+	int i;
+
+	if (!(gfp & __GFP_UNMAPPED))
+		return;
+
+	if (!is_migrate_unmapped_page(page))
+		return;
+
+	for (i = 0; i < nr; i++)
+		set_direct_map_invalid_noflush(page + i);
+
+	flush_tlb_kernel_range(start, end);
+#endif
+}
+
 static void kernel_init_free_pages(struct page *page, int numpages, bool zero_tags)
 {
 	int i;
@@ -1359,6 +1415,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 					   PAGE_SIZE << order);
 	}
 
+	migrate_unmapped_map_pages(page, 1 << order);
 	kernel_poison_pages(page, 1 << order);
 
 	/*
@@ -2426,6 +2483,7 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 
 	set_page_owner(page, order, gfp_flags);
 	page_table_check_alloc(page, order);
+	migrate_unmapped_unmap_pages(page, 1 << order, gfp_flags);
 }
 
 static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags,
@@ -2480,6 +2538,7 @@ struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
  * This array describes the order lists are fallen back to when
  * the free lists for the desirable migrate type are depleted
  */
+#ifndef CONFIG_ARCH_WANTS_GFP_UNMAPPED
 static int fallbacks[MIGRATE_TYPES][3] = {
 	[MIGRATE_UNMOVABLE]   = { MIGRATE_RECLAIMABLE, MIGRATE_MOVABLE,   MIGRATE_TYPES },
 	[MIGRATE_MOVABLE]     = { MIGRATE_RECLAIMABLE, MIGRATE_UNMOVABLE, MIGRATE_TYPES },
@@ -2492,6 +2551,22 @@ static int fallbacks[MIGRATE_TYPES][3] = {
 #endif
 };
 
+#else /*  CONFIG_ARCH_WANTS_GFP_UNMAPPED */
+
+static int fallbacks[MIGRATE_TYPES][4] = {
+	[MIGRATE_UNMOVABLE]   = { MIGRATE_RECLAIMABLE, MIGRATE_MOVABLE,     MIGRATE_UNMAPPED, MIGRATE_TYPES },
+	[MIGRATE_MOVABLE]     = { MIGRATE_RECLAIMABLE, MIGRATE_UNMOVABLE,   MIGRATE_UNMAPPED, MIGRATE_TYPES },
+	[MIGRATE_RECLAIMABLE] = { MIGRATE_UNMOVABLE,   MIGRATE_MOVABLE,     MIGRATE_UNMAPPED, MIGRATE_TYPES },
+	[MIGRATE_UNMAPPED]    = { MIGRATE_UNMOVABLE,   MIGRATE_RECLAIMABLE, MIGRATE_MOVABLE,  MIGRATE_TYPES },
+#ifdef CONFIG_CMA
+	[MIGRATE_CMA]         = { MIGRATE_TYPES }, /* Never used */
+#endif
+#ifdef CONFIG_MEMORY_ISOLATION
+	[MIGRATE_ISOLATE]     = { MIGRATE_TYPES }, /* Never used */
+#endif
+};
+#endif /*  CONFIG_ARCH_WANTS_GFP_UNMAPPED */
+
 #ifdef CONFIG_CMA
 static __always_inline struct page *__rmqueue_cma_fallback(struct zone *zone,
 					unsigned int order)
@@ -2567,6 +2642,39 @@ int move_freepages_block(struct zone *zone, struct page *page,
 								num_movable);
 }
 
+static int set_pageblock_unmapped(struct zone *zone, struct page *page,
+				  unsigned int order)
+{
+#ifdef CONFIG_ARCH_WANTS_GFP_UNMAPPED
+	int migratetype = get_pageblock_migratetype(page);
+	unsigned long err;
+
+	BUILD_BUG_ON(pageblock_order != PMD_ORDER);
+
+	if (is_migrate_unmapped_page(page))
+		return 0;
+
+	/*
+	 * Calling set_direct_map_invalid_noflush() for any page in a
+	 * pageblock will split PMD entry and the split may fail to allocate the
+	 * PMD page.
+	 * Subsequent calls to set_direct_map APIs within the same
+	 * pageblock will only update the PTEs, so they cannot fail.
+	 */
+	err = set_direct_map_invalid_noflush(page);
+	if (err) {
+		move_to_free_list(page, zone, order, migratetype);
+		return err;
+	}
+
+	set_direct_map_default_noflush(page);
+	set_pageblock_migratetype(page, MIGRATE_UNMAPPED);
+	move_freepages_block(zone, page, MIGRATE_UNMAPPED, NULL);
+#endif
+
+	return 0;
+}
+
 static void change_pageblock_range(struct page *pageblock_page,
 					int start_order, int migratetype)
 {
@@ -2605,6 +2713,7 @@ static bool can_steal_fallback(unsigned int order, int start_mt)
 	if (order >= pageblock_order / 2 ||
 		start_mt == MIGRATE_RECLAIMABLE ||
 		start_mt == MIGRATE_UNMOVABLE ||
+		is_migrate_unmapped(start_mt) ||
 		page_group_by_mobility_disabled)
 		return true;
 
@@ -2672,6 +2781,14 @@ static void steal_suitable_fallback(struct zone *zone, struct page *page,
 	if (is_migrate_highatomic(old_block_type))
 		goto single_page;
 
+	/*
+	 * If the new migrate type is MIGRATE_UNMAPPED, the entire
+	 * pageblock will be moved, but it is handled later in
+	 * get_page_from_freelist() to allow error handling and recovery
+	 */
+	if (is_migrate_unmapped(start_type))
+		goto single_page;
+
 	/* Take ownership for orders >= pageblock_order */
 	if (current_order >= pageblock_order) {
 		change_pageblock_range(page, current_order, start_type);
@@ -4162,6 +4279,10 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 		page = rmqueue(ac->preferred_zoneref->zone, zone, order,
 				gfp_mask, alloc_flags, ac->migratetype);
 		if (page) {
+			if ((gfp_mask & __GFP_UNMAPPED) &&
+			    set_pageblock_unmapped(zone, page, order))
+				return NULL;
+
 			prep_new_page(page, order, gfp_mask, alloc_flags);
 
 			/*
@@ -5241,6 +5362,10 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	if (nr_pages - nr_populated == 1)
 		goto failed;
 
+	/* Bulk allocator does not support __GFP_UNMAPPED */
+	if (gfp & __GFP_UNMAPPED)
+		goto failed;
+
 #ifdef CONFIG_PAGE_OWNER
 	/*
 	 * PAGE_OWNER may recurse into the allocator to allocate space to
-- 
2.34.1


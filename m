Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3214AA091
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 20:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbiBDT7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 14:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbiBDT7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB5FC061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Hh75mM7nJUaUD9YvTYVLdbgrwVtaY4e/fVpVR1m93I8=; b=tkUStSU0MDT4wPiOKjiKAJBRD1
        auJEReWQXPnRBH5dz+r/wkfR0qybLg9NVO8G9ajtrfDGjt9+VKiZMJGssRFlFvEe1VTrPBxHV3nvw
        JWlDTgpe/QwcwF+vqUG5i6Z8tm+5KA0chJZFZYceiI4KGfs866ULeAnZjb9cwI3i0ETfWZXc5ox+j
        WnuubNeE/WKdUUIwg2pYjFTOJ98evZJLOKeFbucs4ZK4zmZg1bBR254p1veS+cTIBVtVSBCfXhU61
        g5eaJa+pXeyUqtH9YxsEUlAA5483M7rBM1iGe4M8gwZNDm4dWow827keVtRIIb9pLQEriboLG47wN
        ZAR5NJxA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jT-007Ll1-K7; Fri, 04 Feb 2022 19:58:59 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/75] MM folio patches for 5.18
Date:   Fri,  4 Feb 2022 19:57:37 +0000
Message-Id: <20220204195852.1751729-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whole series availabke through git, and shortly in linux-next:
https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/for-next
or git://git.infradead.org/users/willy/pagecache.git for-next

The first few patches should look familiar to most; these are converting
the GUP code to folios (and a few other things).  Most are well-reviewed,
but I did have to make significant changes to a few patches to accommodate
John's recent bugfix, so I dropped the R-b from them.

After the GUP changes, I started working on vmscan, trying to convert
all of shrink_page_list() to use a folio.  The pages it works on are
folios by definition (since they're chained through ->lru and ->lru
occupies the same bytes of memory as ->compound_head, so they can't be
tail pages).  This is a ridiculously large function, and I'm only part
of the way through it.  I have, however, finished converting rmap_walk()
and friends to take a folio instead of a page.

Midway through, there's a short detour to fix up page_vma_mapped_walk to
work on an explicit PFN range instead of a page.  I had been intending to
convert that to use a folio, but with page_mapped_in_vma() really just
wanting to know about one page (even if it's a head page) and Muchun
wanting to walk pageless memory, making all the users use PFNs just
seemed like the right thing to do.

The last 9 patches actually start adding large folios to the page cache.
This is where I expect the most trouble, but they've been stable in my
testing for a while.

Matthew Wilcox (Oracle) (74):
  mm/gup: Increment the page refcount before the pincount
  mm/gup: Remove for_each_compound_range()
  mm/gup: Remove for_each_compound_head()
  mm/gup: Change the calling convention for compound_range_next()
  mm/gup: Optimise compound_range_next()
  mm/gup: Change the calling convention for compound_next()
  mm/gup: Fix some contiguous memmap assumptions
  mm/gup: Remove an assumption of a contiguous memmap
  mm/gup: Handle page split race more efficiently
  mm/gup: Remove hpage_pincount_add()
  mm/gup: Remove hpage_pincount_sub()
  mm: Make compound_pincount always available
  mm: Add folio_pincount_ptr()
  mm: Turn page_maybe_dma_pinned() into folio_maybe_dma_pinned()
  mm/gup: Add try_get_folio() and try_grab_folio()
  mm/gup: Convert try_grab_page() to use a folio
  mm: Remove page_cache_add_speculative() and
    page_cache_get_speculative()
  mm/gup: Add gup_put_folio()
  mm/hugetlb: Use try_grab_folio() instead of try_grab_compound_head()
  mm/gup: Convert gup_pte_range() to use a folio
  mm/gup: Convert gup_hugepte() to use a folio
  mm/gup: Convert gup_huge_pmd() to use a folio
  mm/gup: Convert gup_huge_pud() to use a folio
  mm/gup: Convert gup_huge_pgd() to use a folio
  mm/gup: Turn compound_next() into gup_folio_next()
  mm/gup: Turn compound_range_next() into gup_folio_range_next()
  mm: Turn isolate_lru_page() into folio_isolate_lru()
  mm/gup: Convert check_and_migrate_movable_pages() to use a folio
  mm/workingset: Convert workingset_eviction() to take a folio
  mm/memcg: Convert mem_cgroup_swapout() to take a folio
  mm: Add lru_to_folio()
  mm: Turn putback_lru_page() into folio_putback_lru()
  mm/vmscan: Convert __remove_mapping() to take a folio
  mm/vmscan: Turn page_check_dirty_writeback() into
    folio_check_dirty_writeback()
  mm: Turn head_compound_mapcount() into folio_entire_mapcount()
  mm: Add folio_mapcount()
  mm: Add split_folio_to_list()
  mm: Add folio_is_zone_device() and folio_is_device_private()
  mm: Add folio_pgoff()
  mm: Add pvmw_set_page() and pvmw_set_folio()
  hexagon: Add pmd_pfn()
  mm: Convert page_vma_mapped_walk to work on PFNs
  mm/page_idle: Convert page_idle_clear_pte_refs() to use a folio
  mm/rmap: Use a folio in page_mkclean_one()
  mm/rmap: Turn page_referenced() into folio_referenced()
  mm/mlock: Turn clear_page_mlock() into folio_end_mlock()
  mm/mlock: Turn mlock_vma_page() into mlock_vma_folio()
  mm/rmap: Turn page_mlock() into folio_mlock()
  mm/mlock: Turn munlock_vma_page() into munlock_vma_folio()
  mm/huge_memory: Convert __split_huge_pmd() to take a folio
  mm/rmap: Convert try_to_unmap() to take a folio
  mm/rmap: Convert try_to_migrate() to folios
  mm/rmap: Convert make_device_exclusive_range() to use folios
  mm/migrate: Convert remove_migration_ptes() to folios
  mm/damon: Convert damon_pa_mkold() to use a folio
  mm/damon: Convert damon_pa_young() to use a folio
  mm/rmap: Turn page_lock_anon_vma_read() into
    folio_lock_anon_vma_read()
  mm: Turn page_anon_vma() into folio_anon_vma()
  mm/rmap: Convert rmap_walk() to take a folio
  mm/rmap: Constify the rmap_walk_control argument
  mm/vmscan: Free non-shmem folios without splitting them
  mm/vmscan: Optimise shrink_page_list for non-PMD-sized folios
  mm/vmscan: Account large folios correctly
  mm/vmscan: Turn page_check_references() into folio_check_references()
  mm/vmscan: Convert pageout() to take a folio
  mm: Turn can_split_huge_page() into can_split_folio()
  mm/filemap: Allow large folios to be added to the page cache
  mm: Fix READ_ONLY_THP warning
  mm: Make large folios depend on THP
  mm: Support arbitrary THP sizes
  mm/readahead: Add large folio readahead
  mm/readahead: Switch to page_cache_ra_order
  mm/filemap: Support VM_HUGEPAGE for file mappings
  selftests/vm/transhuge-stress: Support file-backed PMD folios

William Kucharski (1):
  mm/readahead: Align file mappings for non-DAX

 Documentation/core-api/pin_user_pages.rst     |  18 +-
 arch/hexagon/include/asm/pgtable.h            |   3 +-
 arch/powerpc/include/asm/mmu_context.h        |   1 -
 include/linux/huge_mm.h                       |  59 +--
 include/linux/hugetlb.h                       |   5 +
 include/linux/ksm.h                           |   6 +-
 include/linux/mm.h                            | 145 +++---
 include/linux/mm_types.h                      |   7 +-
 include/linux/pagemap.h                       |  32 +-
 include/linux/rmap.h                          |  50 ++-
 include/linux/swap.h                          |   6 +-
 include/trace/events/vmscan.h                 |  10 +-
 kernel/events/uprobes.c                       |   2 +-
 mm/damon/paddr.c                              |  52 ++-
 mm/debug.c                                    |  18 +-
 mm/filemap.c                                  |  59 ++-
 mm/folio-compat.c                             |  34 ++
 mm/gup.c                                      | 383 +++++++---------
 mm/huge_memory.c                              | 127 +++---
 mm/hugetlb.c                                  |   7 +-
 mm/internal.h                                 |  52 ++-
 mm/ksm.c                                      |  17 +-
 mm/memcontrol.c                               |  22 +-
 mm/memory-failure.c                           |  10 +-
 mm/memory_hotplug.c                           |  13 +-
 mm/migrate.c                                  |  90 ++--
 mm/mlock.c                                    | 136 +++---
 mm/page_alloc.c                               |   3 +-
 mm/page_idle.c                                |  26 +-
 mm/page_vma_mapped.c                          |  58 ++-
 mm/readahead.c                                | 108 ++++-
 mm/rmap.c                                     | 416 +++++++++---------
 mm/util.c                                     |  36 +-
 mm/vmscan.c                                   | 280 ++++++------
 mm/workingset.c                               |  25 +-
 tools/testing/selftests/vm/transhuge-stress.c |  35 +-
 36 files changed, 1270 insertions(+), 1081 deletions(-)

-- 
2.34.1


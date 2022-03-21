Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01824E2F5E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 18:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350731AbiCURvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 13:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240444AbiCURu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 13:50:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B280E326D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 10:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=miTTOQjcVe/4t1ttK2wjyRDmE5Dgi+RgrVLWqKG9s9o=; b=OeHhBwbZvewmxEBtY6rFBx4nHJ
        SCEVGHNRPh7jXxoGzmSL9yux/T9yWV+ij3rkL5REu78Nn8A7+tLG7PyYvxq3putT7ZtwfSa0/Dyil
        lKZwszDJ7MUifNrvBzUHY7PRvTXds3eglPuKmUaJ7nzuneQMeAhvgEGCSI8K5LJQDiHRsLk8VAGgT
        naRV20Ky3l/QID+Avr8uYYFPeHUlCGKiz64Yw/mXMLEfxqrtuURiWEfzLwDKEZGoKuor6fUc683ZK
        LN+27Zwh9XahJdLNDIN3zVG7owTYsp0XFkjXqCeqCdG7KQK9lTDSMORfTYZFYMNEb71KmOQEfalAR
        /KFA5S7w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWM9m-00Anke-JG; Mon, 21 Mar 2022 17:49:26 +0000
Date:   Mon, 21 Mar 2022 17:49:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@kernel.org>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [GIT PULL] Folio patches for 5.18 (MM part)
Message-ID: <Yji6plPgEAeWuq38@casper.infradead.org>
References: <Yjh+EuacJURShtJI@casper.infradead.org>
 <9ae0a8e4-41b7-04f4-4435-17cbba9850fb@redhat.com>
 <d5676cf0-30f9-8497-95a8-332767dede46@redhat.com>
 <YjiaSbUBLJP+9Jtt@casper.infradead.org>
 <9ece8da5-ae0c-fe1c-ff2f-961f641c00fe@redhat.com>
 <YjittBLCYpft5ALc@casper.infradead.org>
 <74cd5e99-a52b-610c-89aa-a5fac43cdab6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74cd5e99-a52b-610c-89aa-a5fac43cdab6@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 06:03:11PM +0100, David Hildenbrand wrote:
> > OK, so you object to the last 12 patches from Alistair and Alex?  And
> > you're OK with the preceeding 15 patches from Christoph?  I can put
> > together a pull request for that combination.
> > 
> 
> Yes, I'm only concerned about the new feature (DEVICE_COHERENT),
> essentially what is still under discussion in [1] and [2]
>   [PATCH v6 00/10] Add MEMORY_DEVICE_COHERENT for coherent device memory
>   mapping
>   [PATCH v2 0/3] Migrate device coherent pages on get_user_pages()
> 
> I think these should be the patches from Alex and Alistair. I'm happy to
> see Christoph's ZONE_DEVICE refocunt changes upstream ;)

OK.  I've pushed out folio-5.18c:

The following changes since commit f71077a4d84bbe8c7b91b7db7c4ef815755ac5e3:

  Merge tag 'mmc-v5.17-rc1-2' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc (2022-02-16 12:09:22 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/willy/pagecache.git tags/folio-5.18c

for you to fetch changes up to 2a3c4bce3edb0d54983384aa8a88c0da330638f4:

  mm/damon: minor cleanup for damon_pa_young (2022-03-21 13:01:36 -0400)

----------------------------------------------------------------
Folio changes for 5.18

 - Rewrite how munlock works to massively reduce the contention
   on i_mmap_rwsem (Hugh Dickins):
   https://lore.kernel.org/linux-mm/8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com/
 - Sort out the page refcount mess for ZONE_DEVICE pages (Christoph Hellwig):
   https://lore.kernel.org/linux-mm/20220210072828.2930359-1-hch@lst.de/
 - Convert GUP to use folios and make pincount available for order-1
   pages. (Matthew Wilcox)
 - Convert a few more truncation functions to use folios (Matthew Wilcox)
 - Convert page_vma_mapped_walk to use PFNs instead of pages (Matthew Wilcox)
 - Convert rmap_walk to use folios (Matthew Wilcox)
 - Convert most of shrink_page_list() to use a folio (Matthew Wilcox)
 - Add support for creating large folios in readahead (Matthew Wilcox)

----------------------------------------------------------------
Christoph Hellwig (14):
      mm: remove a pointless CONFIG_ZONE_DEVICE check in memremap_pages
      mm: remove the __KERNEL__ guard from <linux/mm.h>
      mm: remove pointless includes from <linux/hmm.h>
      mm: move free_devmap_managed_page to memremap.c
      mm: simplify freeing of devmap managed pages
      mm: don't include <linux/memremap.h> in <linux/mm.h>
      mm: remove the extra ZONE_DEVICE struct page refcount
      fsdax: depend on ZONE_DEVICE || FS_DAX_LIMITED
      mm: generalize the pgmap based page_free infrastructure
      mm: refactor check_and_migrate_movable_pages
      mm: refactor the ZONE_DEVICE handling in migrate_vma_insert_page
      mm: refactor the ZONE_DEVICE handling in migrate_vma_pages
      mm: move the migrate_vma_* device migration code into its own file
      mm: build migrate_vma_* for all configs with ZONE_DEVICE support

Hugh Dickins (14):
      mm/munlock: delete page_mlock() and all its works
      mm/munlock: delete FOLL_MLOCK and FOLL_POPULATE
      mm/munlock: delete munlock_vma_pages_all(), allow oomreap
      mm/munlock: rmap call mlock_vma_page() munlock_vma_page()
      mm/munlock: replace clear_page_mlock() by final clearance
      mm/munlock: maintain page->mlock_count while unevictable
      mm/munlock: mlock_pte_range() when mlocking or munlocking
      mm/migrate: __unmap_and_move() push good newpage to LRU
      mm/munlock: delete smp_mb() from __pagevec_lru_add_fn()
      mm/munlock: mlock_page() munlock_page() batch by pagevec
      mm/munlock: page migration needs mlock pagevec drained
      mm/thp: collapse_file() do try_to_unmap(TTU_BATCH_FLUSH)
      mm/thp: shrink_page_list() avoid splitting VM_LOCKED THP
      mm/munlock: mlock_vma_page() check against VM_SPECIAL

Matthew Wilcox (Oracle) (83):
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
      mm: Remove page_cache_add_speculative() and page_cache_get_speculative()
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
      mm: Add three folio wrappers
      mm/gup: Convert check_and_migrate_movable_pages() to use a folio
      mm/workingset: Convert workingset_eviction() to take a folio
      mm/memcg: Convert mem_cgroup_swapout() to take a folio
      mm: Add lru_to_folio()
      mm: Turn putback_lru_page() into folio_putback_lru()
      mm/vmscan: Convert __remove_mapping() to take a folio
      splice: Use a folio in page_cache_pipe_buf_try_steal()
      mm/truncate: Inline invalidate_complete_page() into its one caller
      mm/truncate: Convert invalidate_inode_page() to use a folio
      mm/truncate: Replace page_mapped() call in invalidate_inode_page()
      mm: Convert remove_mapping() to take a folio
      mm/truncate: Split invalidate_inode_page() into mapping_evict_folio()
      mm/truncate: Convert __invalidate_mapping_pages() to use a folio
      mm: Turn deactivate_file_page() into deactivate_file_folio()
      mm/truncate: Combine invalidate_mapping_pagevec() and __invalidate_mapping_pages()
      fs: Move many prototypes to pagemap.h
      mm/vmscan: Turn page_check_dirty_writeback() into folio_check_dirty_writeback()
      mm: Turn head_compound_mapcount() into folio_entire_mapcount()
      mm: Add folio_mapcount()
      mm: Add split_folio_to_list()
      mm: Add folio_pgoff()
      mm: Add DEFINE_PAGE_VMA_WALK and DEFINE_FOLIO_VMA_WALK
      mips: Make pmd_pfn() available in all configurations
      powerpc: Add pmd_pfn()
      sparc32: Add pmd_pfn()
      mm: Convert page_vma_mapped_walk to work on PFNs
      mm/page_idle: Convert page_idle_clear_pte_refs() to use a folio
      mm/rmap: Use a folio in page_mkclean_one()
      mm/mlock: Add mlock_vma_folio()
      mm/rmap: Turn page_referenced() into folio_referenced()
      mm/huge_memory: Convert __split_huge_pmd() to take a folio
      mm/rmap: Convert try_to_unmap() to take a folio
      mm/rmap: Convert try_to_migrate() to folios
      mm/rmap: Convert make_device_exclusive_range() to use folios
      mm/migrate: Convert remove_migration_ptes() to folios
      mm/damon: Convert damon_pa_mkold() to use a folio
      mm/damon: Convert damon_pa_young() to use a folio
      mm/rmap: Turn page_lock_anon_vma_read() into folio_lock_anon_vma_read()
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

Miaohe Lin (1):
      mm/damon: minor cleanup for damon_pa_young

Mike Rapoport (1):
      arch: Add pmd_pfn() where it is missing

William Kucharski (1):
      mm/readahead: Align file mappings for non-DAX

 Documentation/core-api/pin_user_pages.rst     |  18 +-
 arch/alpha/include/asm/pgtable.h              |   1 +
 arch/arc/include/asm/hugepage.h               |   1 -
 arch/arc/include/asm/pgtable-levels.h         |   1 +
 arch/arm/include/asm/pgtable-2level.h         |   2 +
 arch/arm64/mm/mmu.c                           |   1 +
 arch/csky/include/asm/pgtable.h               |   1 +
 arch/hexagon/include/asm/pgtable.h            |   5 +
 arch/ia64/include/asm/pgtable.h               |   1 +
 arch/m68k/include/asm/mcf_pgtable.h           |   1 +
 arch/m68k/include/asm/motorola_pgtable.h      |   1 +
 arch/m68k/include/asm/sun3_pgtable.h          |   1 +
 arch/microblaze/include/asm/pgtable.h         |   3 +
 arch/mips/include/asm/pgtable.h               |  10 +-
 arch/nds32/include/asm/pgtable.h              |   1 +
 arch/nios2/include/asm/pgtable.h              |   1 +
 arch/openrisc/include/asm/pgtable.h           |   1 +
 arch/parisc/include/asm/pgtable.h             |   1 +
 arch/powerpc/include/asm/book3s/32/pgtable.h  |   4 +-
 arch/powerpc/include/asm/mmu_context.h        |   1 -
 arch/powerpc/include/asm/nohash/32/pgtable.h  |   7 +-
 arch/powerpc/include/asm/nohash/64/pgtable.h  |   1 +
 arch/powerpc/kvm/book3s_hv_uvmem.c            |   2 +-
 arch/powerpc/mm/book3s64/pgtable.c            |   1 +
 arch/sh/include/asm/pgtable_32.h              |   1 +
 arch/sparc/include/asm/pgtable_32.h           |   7 +-
 arch/um/include/asm/pgtable.h                 |   1 +
 arch/xtensa/include/asm/pgtable.h             |   1 +
 drivers/block/xen-blkback/xenbus.c            |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   1 +
 drivers/gpu/drm/drm_cache.c                   |   2 +-
 drivers/gpu/drm/nouveau/nouveau_dmem.c        |   3 +-
 drivers/gpu/drm/nouveau/nouveau_svm.c         |   1 +
 drivers/infiniband/core/rw.c                  |   1 +
 drivers/nvdimm/pmem.h                         |   1 +
 drivers/nvme/host/pci.c                       |   1 +
 drivers/nvme/target/io-cmd-bdev.c             |   1 +
 drivers/usb/gadget/function/f_mass_storage.c  |   1 +
 fs/Kconfig                                    |   2 +-
 fs/coda/file.c                                |   1 +
 fs/fuse/virtio_fs.c                           |   1 +
 fs/iomap/fiemap.c                             |   1 +
 fs/nfsd/filecache.c                           |   1 +
 fs/nfsd/vfs.c                                 |   1 +
 fs/proc/page.c                                |   1 +
 fs/splice.c                                   |  24 +-
 fs/vboxsf/utils.c                             |   1 +
 include/linux/fs.h                            | 120 ----
 include/linux/hmm.h                           |   9 +-
 include/linux/huge_mm.h                       |  59 +-
 include/linux/hugetlb.h                       |   5 +
 include/linux/ksm.h                           |   6 +-
 include/linux/memremap.h                      |  27 +-
 include/linux/mm.h                            | 296 ++++-----
 include/linux/mm_inline.h                     |  11 +-
 include/linux/mm_types.h                      |  26 +-
 include/linux/pagemap.h                       | 146 ++++-
 include/linux/rmap.h                          |  76 ++-
 include/linux/swap.h                          |   9 +-
 include/trace/events/vmscan.h                 |  10 +-
 kernel/events/uprobes.c                       |  13 +-
 kernel/futex/core.c                           |   2 +-
 lib/test_hmm.c                                |   4 +-
 mm/Kconfig                                    |   7 +-
 mm/Makefile                                   |   1 +
 mm/damon/paddr.c                              |  62 +-
 mm/debug.c                                    |  18 +-
 mm/filemap.c                                  |  59 +-
 mm/folio-compat.c                             |  13 +
 mm/gup.c                                      | 486 ++++++--------
 mm/huge_memory.c                              | 178 ++----
 mm/hugetlb.c                                  |  15 +-
 mm/internal.h                                 | 117 ++--
 mm/khugepaged.c                               |  15 +-
 mm/ksm.c                                      |  32 +-
 mm/madvise.c                                  |   5 +
 mm/memcontrol.c                               |  37 +-
 mm/memory-failure.c                           |  14 +-
 mm/memory.c                                   |  45 +-
 mm/memory_hotplug.c                           |  13 +-
 mm/memremap.c                                 |  65 +-
 mm/migrate.c                                  | 870 ++------------------------
 mm/migrate_device.c                           | 773 +++++++++++++++++++++++
 mm/mlock.c                                    | 638 ++++++++-----------
 mm/mmap.c                                     |  32 +-
 mm/mmzone.c                                   |   7 +
 mm/oom_kill.c                                 |   2 +-
 mm/page_alloc.c                               |   3 +-
 mm/page_idle.c                                |  30 +-
 mm/page_vma_mapped.c                          |  58 +-
 mm/readahead.c                                | 108 +++-
 mm/rmap.c                                     | 582 +++++++----------
 mm/swap.c                                     | 173 ++---
 mm/truncate.c                                 | 111 ++--
 mm/userfaultfd.c                              |  14 +-
 mm/util.c                                     |  36 +-
 mm/vmscan.c                                   | 305 ++++-----
 mm/workingset.c                               |  25 +-
 tools/testing/selftests/vm/transhuge-stress.c |  35 +-
 100 files changed, 2903 insertions(+), 3025 deletions(-)
 create mode 100644 mm/migrate_device.c


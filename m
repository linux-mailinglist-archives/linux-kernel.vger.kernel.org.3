Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CAF589354
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 22:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238602AbiHCUf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 16:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238780AbiHCUfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 16:35:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C7815839;
        Wed,  3 Aug 2022 13:35:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F10F3B82313;
        Wed,  3 Aug 2022 20:35:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82363C433C1;
        Wed,  3 Aug 2022 20:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1659558942;
        bh=KQlwZxFCVlS0nlAB6NOyQe/T4NTlty8Q6+9fR+/+Agk=;
        h=Date:From:To:Cc:Subject:From;
        b=paZHiFgudmad3iHXeu4vqD647Pk8m/SpjAM+wV7w7g31kQ6u20MfzAL6cjy2OZ9qr
         zBCHU8uV0rLBc8WbBQm1/8AyHdlSnJIKhXnrEShWT+lEYc7FEZzG8S6OrDfA+Y+Pq7
         jmeiTxoEVTmYCOpeNnb2ffEm2vdbbdI5KVJGaGjk=
Date:   Wed, 3 Aug 2022 13:35:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] MM updates for 5.20-rc1
Message-Id: <20220803133541.18b82ec9344ed0e8b975fe5b@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Linus.

Most of the MM queue.  A few things are still pending.

Liam's maple tree rework didn't make it.  This has resulted in a few
other minor patch series being held over for next time.

Multi-gen LRU still isn't merged as we were waiting for mapletree to
stabilize.  The current plan is to merge MGLRU into -mm soon and to
later reintroduce mapletree, with a view to hopefully getting both into
5.21-rc1.

There are 6-7 conflicts with your tree here.  All very minor, mainly
related to the rename of Documentation/vm to Documentation/mm.

Thanks.

The following changes since commit 03c765b0e3b4cb5063276b086c76f7a612856a9a:

  Linux 5.19-rc4 (2022-06-26 14:22:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-2022-08-03

for you to fetch changes up to 360614c01f81f48a89d8b13f8fa69c3ae0a1f5c7:

  tools/testing/selftests/vm/hmm-tests.c: fix build (2022-08-03 11:40:53 -0700)

----------------------------------------------------------------
- The usual batches of cleanups from Baoquan He, Muchun Song, Miaohe
  Lin, Yang Shi, Anshuman Khandual and Mike Rapoport

- Some kmemleak fixes from Patrick Wang and Waiman Long

- DAMON updates from SeongJae Park

- memcg debug/visibility work from Roman Gushchin

- vmalloc speedup from Uladzislau Rezki

- more folio conversion work from Matthew Wilcox

- enhancements for coherent device memory mapping from Alex Sierra

- addition of shared pages tracking and CoW support for fsdax, from
  Shiyang Ruan

- hugetlb optimizations from Mike Kravetz

- Mel Gorman has contributed some pagealloc changes to improve latency
  and realtime behaviour.

- mprotect soft-dirty checking has been improved by Peter Xu

- Many other singleton patches all over the place

----------------------------------------------------------------
Adam Sindelar (4):
      selftests/vm: only run 128TBswitch with 5-level paging
      selftests/vm: fix va_128TBswitch.sh permissions
      selftests/vm: fix errno handling in mrelease_test
      selftests/vm: skip 128TBswitch on unsupported arch

Alex Sierra (13):
      mm: rename is_pinnable_page() to is_longterm_pinnable_page()
      mm: move page zone helpers from mm.h to mmzone.h
      mm: add zone device coherent type memory support
      mm: handling Non-LRU pages returned by vm_normal_pages
      mm: add device coherent vma selection for memory migration
      drm/amdkfd: add SPM support for SVM
      lib: test_hmm add ioctl to get zone device type
      lib: test_hmm add module param for zone device type
      lib: add support for device coherent type in test_hmm
      tools: update hmm-test to support device coherent type
      tools: update test_hmm script to support SP config
      tools: add hmm gup tests for device coherent type
      tools: add selftests to hmm for COW in device memory

Alistair Popple (2):
      mm/gup: migrate device coherent pages when pinning instead of failing
      mm/gup.c: fix formatting in check_and_migrate_movable_page()

Andrew Morton (2):
      Merge branch 'master' into mm-stable
      tools/testing/selftests/vm/hmm-tests.c: fix build

Andrey Konovalov (3):
      mm: rename kernel_init_free_pages to kernel_init_pages
      mm: introduce clear_highpage_kasan_tagged
      kasan: fix zeroing vmalloc memory with HW_TAGS

Anshuman Khandual (27):
      mm/memory_hotplug: drop 'reason' argument from check_pfn_span()
      mm/mmap: build protect protection_map[] with __P000
      mm/mmap: define DECLARE_VM_GET_PAGE_PROT
      powerpc/mm: move protection_map[] inside the platform
      sparc/mm: move protection_map[] inside the platform
      arm64/mm: move protection_map[] inside the platform
      x86/mm: move protection_map[] inside the platform
      mm/mmap: build protect protection_map[] with ARCH_HAS_VM_GET_PAGE_PROT
      microblaze/mm: enable ARCH_HAS_VM_GET_PAGE_PROT
      loongarch/mm: enable ARCH_HAS_VM_GET_PAGE_PROT
      openrisc/mm: enable ARCH_HAS_VM_GET_PAGE_PROT
      xtensa/mm: enable ARCH_HAS_VM_GET_PAGE_PROT
      hexagon/mm: enable ARCH_HAS_VM_GET_PAGE_PROT
      parisc/mm: enable ARCH_HAS_VM_GET_PAGE_PROT
      alpha/mm: enable ARCH_HAS_VM_GET_PAGE_PROT
      nios2/mm: enable ARCH_HAS_VM_GET_PAGE_PROT
      riscv/mm: enable ARCH_HAS_VM_GET_PAGE_PROT
      csky/mm: enable ARCH_HAS_VM_GET_PAGE_PROT
      s390/mm: enable ARCH_HAS_VM_GET_PAGE_PROT
      ia64/mm: enable ARCH_HAS_VM_GET_PAGE_PROT
      mips/mm: enable ARCH_HAS_VM_GET_PAGE_PROT
      m68k/mm: enable ARCH_HAS_VM_GET_PAGE_PROT
      arc/mm: enable ARCH_HAS_VM_GET_PAGE_PROT
      arm/mm: enable ARCH_HAS_VM_GET_PAGE_PROT
      um/mm: enable ARCH_HAS_VM_GET_PAGE_PROT
      sh/mm: enable ARCH_HAS_VM_GET_PAGE_PROT
      mm/mmap: drop ARCH_HAS_VM_GET_PAGE_PROT

Axel Rasmussen (1):
      userfaultfd: don't fail on unrecognized features

Baolin Wang (3):
      mm/hugetlb: remove unnecessary huge_ptep_set_access_flags() in hugetlb_mcopy_atomic_pte()
      mm: rmap: simplify the hugetlb handling when unmapping or migration
      arm64/hugetlb: implement arm64 specific hugetlb_mask_last_page

Baoquan He (4):
      mm/vmalloc: invoke classify_va_fit_type() in adjust_va_to_fit_type()
      mm/vmalloc: remove the redundant boundary check
      mm/vmalloc: fix typo in local variable name
      mm/vmalloc: add code comment for find_vmap_area_exceed_addr()

Chengming Zhou (1):
      mm/damon: remove obsolete comments of kdamond_stop

Dan Carpenter (2):
      tools/testing/selftests/vm/hugetlb-madvise.c: silence uninitialized variable warning
      selftest/vm: uninitialized variable in main()

Daniel Vetter (3):
      mm/page_alloc: use might_alloc()
      mm/slab: delete cache_alloc_debugcheck_before()
      mm/mempool: use might_alloc()

David Hildenbrand (1):
      mm/mprotect: try avoiding write faults for exclusive anonymous pages when changing protection

Edward Liaw (1):
      userfaultfd: selftests: infinite loop in faulting_process

Fabio M. De Francesco (1):
      mm/highmem: delete memmove_page()

Fanjun Kong (1):
      mm: use PAGE_ALIGNED instead of IS_ALIGNED

Gang Li (1):
      mm, hugetlb: skip irrelevant nodes in show_free_areas()

Gautam Menghani (1):
      mm/sparse-vmemmap.c: remove unwanted initialization in vmemmap_populate_compound_pages()

Hui Zhu (1):
      zsmalloc: zs_malloc: return ERR_PTR on failure

Jianglei Nie (1):
      mm/damon/reclaim: fix potential memory leak in damon_reclaim_init()

Jiebin Sun (1):
      mm/memcontrol.c: remove the redundant updating of stats_flush_threshold

Joel Savitz (1):
      selftests: make use of GUP_TEST_FILE macro

Kalpana Shetty (1):
      selftests/vm: add protection_keys tests to run_vmtests

Kassey Li (1):
      mm/cma_debug.c: align the name buffer length as struct cma

Kefeng Wang (4):
      zram: fix unused 'zram_wb_devops' warning
      mm: cleanup is_highmem()
      mm: use is_zone_movable_page() helper
      mm: memory-failure: convert to pr_fmt()

Kuan-Ying Lee (1):
      kasan: separate double free case from invalid free

Liam Howlett (1):
      android: binder: fix lockdep check on clearing vma

Liam R. Howlett (2):
      mips: rename mt_init to mips_mt_init
      android: binder: stop saving a pointer to the VMA

Linus Walleij (5):
      lib/test_free_pages.c: pass a pointer to virt_to_page()
      mm/highmem: pass a pointer to virt_to_page()
      mm: kfence: pass a pointer to virt_to_page()
      mm: gup: pass a pointer to virt_to_page()
      mm: nommu: pass a pointer to virt_to_page()

Mark-PK Tsai (1):
      mm/page_alloc: correct the wrong cpuset file path in comment

Matthew Wilcox (Oracle) (28):
      mm/vmscan: convert reclaim_clean_pages_from_list() to folios
      mm/vmscan: convert isolate_lru_pages() to use a folio
      mm/vmscan: convert move_pages_to_lru() to use a folio
      mm/vmscan: convert shrink_active_list() to use a folio
      mm/vmscan: convert reclaim_pages() to use a folio
      mm: add folios_put()
      mm/swap: add folio_batch_move_lru()
      mm/swap: make __pagevec_lru_add static
      mm/swap: convert lru_add to a folio_batch
      mm/swap: convert lru_deactivate_file to a folio_batch
      mm/swap: convert lru_deactivate to a folio_batch
      mm/swap: convert lru_lazyfree to a folio_batch
      mm/swap: convert activate_page to a folio_batch
      mm/swap: rename lru_pvecs to cpu_fbatches
      mm/swap: pull the CPU conditional out of __lru_add_drain_all()
      mm/swap: optimise lru_add_drain_cpu()
      mm/swap: convert try_to_free_swap to use a folio
      mm/swap: convert release_pages to use a folio internally
      mm/swap: convert put_pages_list to use folios
      mm/swap: convert __put_page() to __folio_put()
      mm/swap: convert __put_single_page() to __folio_put_small()
      mm/swap: convert __put_compound_page() to __folio_put_large()
      mm/swap: convert __page_cache_release() to use a folio
      mm: convert destroy_compound_page() to destroy_large_folio()
      mm: convert page_swap_flags to folio_swap_flags
      mm/swap: convert delete_from_swap_cache() to take a folio
      mm/swap: convert __delete_from_swap_cache() to a folio
      mips: rename PMD_ORDER to PMD_TABLE_ORDER

Mel Gorman (6):
      mm/page_alloc: add page->buddy_list and page->pcp_list
      mm/page_alloc: use only one PCP list for THP-sized allocations
      mm/page_alloc: split out buddy removal code from rmqueue into separate helper
      mm/page_alloc: remove mistaken page == NULL check in rmqueue
      mm/page_alloc: protect PCP lists with a spinlock
      mm/page_alloc: replace local_lock with normal spinlock

Miaohe Lin (46):
      mm/shmem.c: clean up comment of shmem_swapin_folio
      mm/memremap: fix wrong function name above memremap_pages()
      lib/test_hmm: avoid accessing uninitialized pages
      mm/memremap: fix memunmap_pages() race with get_dev_pagemap()
      mm/migration: remove unneeded lock page and PageMovable check
      mm/migration: return errno when isolate_huge_page failed
      mm/migration: fix potential pte_unmap on an not mapped pte
      mm/swapfile: fix possible data races of inuse_pages
      mm/swap: remove swap_cache_info statistics
      mm/madvise: minor cleanup for swapin_walk_pmd_entry()
      mm/khugepaged: remove unneeded shmem_huge_enabled() check
      mm/khugepaged: stop swapping in page when VM_FAULT_RETRY occurs
      mm/khugepaged: trivial typo and codestyle cleanup
      mm/khugepaged: minor cleanup for collapse_file
      mm/khugepaged: use helper macro __ATTR_RW
      mm/khugepaged: remove unneeded return value of khugepaged_add_pte_mapped_thp()
      mm/khugepaged: try to free transhuge swapcache when possible
      mm/huge_memory: use flush_pmd_tlb_range in move_huge_pmd
      mm/huge_memory: access vm_page_prot with READ_ONCE in remove_migration_pmd
      mm/huge_memory: fix comment of __pud_trans_huge_lock
      mm/huge_memory: use helper touch_pud in huge_pud_set_accessed
      mm/huge_memory: use helper touch_pmd in huge_pmd_set_accessed
      mm/huge_memory: rename mmun_start to haddr in remove_migration_pmd
      mm/huge_memory: use helper function vma_lookup in split_huge_pages_pid
      mm/huge_memory: use helper macro __ATTR_RW
      mm/huge_memory: fix comment in zap_huge_pud
      mm/huge_memory: check pmd_present first in is_huge_zero_pmd
      mm/huge_memory: try to free subpage in swapcache when possible
      mm/huge_memory: minor cleanup for split_huge_pages_all
      mm/huge_memory: fix comment of page_deferred_list
      mm/huge_memory: correct comment of prep_transhuge_page
      mm/huge_memory: comment the subtly logic in __split_huge_pmd
      mm/huge_memory: use helper macro IS_ERR_OR_NULL in split_huge_pages_pid
      mm/page_vma_mapped.c: use helper function huge_pte_lock
      mm/mmap: fix obsolete comment of find_extend_vma
      mm/mmap.c: fix missing call to vm_unacct_memory in mmap_region
      filemap: minor cleanup for filemap_write_and_wait_range
      mm: remove obsolete comment in do_fault_around()
      mm: remove unneeded PageAnon check in restore_exclusive_pte()
      mm/mempolicy: remove unneeded out label
      hugetlb_cgroup: fix wrong hugetlb cgroup numa stat
      hugetlbfs: use helper macro SZ_1{K,M}
      hugetlbfs: remove unneeded hugetlbfs_ops forward declaration
      hugetlbfs: remove unneeded header file
      hugetlbfs: cleanup some comments in inode.c
      hugetlbfs: fix inaccurate comment in hugetlbfs_statfs()

Mike Kravetz (3):
      hugetlb: skip to end of PT page mapping when pte not present
      hugetlb: do not update address in huge_pmd_unshare
      hugetlb: lazy page table copies in fork()

Mike Rapoport (15):
      docs: rename Documentation/vm to Documentation/mm
      csky: drop definition of PTE_ORDER
      csky: drop definition of PGD_ORDER
      mips: rename PUD_ORDER to PUD_TABLE_ORDER
      mips: drop definitions of PTE_ORDER
      mips: rename PGD_ORDER to PGD_TABLE_ORDER
      nios2: drop definition of PTE_ORDER
      nios2: drop definition of PGD_ORDER
      loongarch: drop definition of PTE_ORDER
      loongarch: drop definition of PMD_ORDER
      loongarch: drop definition of PUD_ORDER
      loongarch: drop definition of PGD_ORDER
      parisc: rename PGD_ORDER to PGD_TABLE_ORDER
      xtensa: drop definition of PGD_ORDER
      ARM: head.S: rename PMD_ORDER to PMD_ENTRY_ORDER

Muchun Song (3):
      mm: memory_hotplug: enumerate all supported section flags
      mm: memory_hotplug: make hugetlb_optimize_vmemmap compatible with memmap_on_memory
      mm: hugetlb: remove minimum_order variable

Nicolas Saenz Julienne (1):
      mm/page_alloc: remotely drain per-cpu lists

Patrick Wang (5):
      mm: kmemleak: remove kmemleak_not_leak_phys() and the min_count argument to kmemleak_alloc_phys()
      mm: kmemleak: add OBJECT_PHYS flag for objects allocated with physical address
      mm: kmemleak: add rbtree and store physical address for objects allocated with PA
      mm: kmemleak: check physical address when scan
      mm: percpu: use kmemleak_ignore_phys() instead of kmemleak_free()

Peter Xu (5):
      mm/x86: remove dead code for hugetlbpage.c
      mm: avoid unnecessary page fault retires on shared memory types
      mm/mprotect: fix soft-dirty check in can_change_pte_writable()
      selftests: soft-dirty: add test for mprotect
      selftests: add soft-dirty into run_vmtests.sh

Qi Zheng (2):
      mm: memcontrol: add {pgscan,pgsteal}_{kswapd,direct} items in memory.stat of cgroup v2
      mm: hugetlb: kill set_huge_swap_pte_at()

Ralph Campbell (1):
      mm/hmm: add a test for cross device private faults

Roman Gushchin (8):
      mm: kmem: make mem_cgroup_from_obj() vmalloc()-safe
      mm: memcontrol: introduce mem_cgroup_ino() and mem_cgroup_get_from_ino()
      mm: shrinkers: introduce debugfs interface for memory shrinkers
      mm: shrinkers: provide shrinkers with names
      mm: docs: document shrinker debugfs
      tools: add memcg_shrinker.py
      mm: shrinkers: add scan interface for shrinker debugfs
      mm: memcontrol: do not miss MEMCG_MAX events for enforced allocations

SeongJae Park (15):
      Docs/admin-guide/damon/reclaim: remove a paragraph that been obsolete due to online tuning support
      mm/damon/{dbgfs,sysfs}: move target_has_pid() from dbgfs to damon.h
      mm/damon/reclaim: deduplicate 'commit_inputs' handling
      mm/damon/sysfs: deduplicate inputs applying
      mm/damon/reclaim: make 'enabled' checking timer simpler
      mm/damon/reclaim: add 'damon_reclaim_' prefix to 'enabled_store()'
      mm/damon/dbgfs: add and use mappings between 'schemes' action inputs and 'damos_action' values
      mm/damon/paddr: use a separate function for 'DAMOS_PAGEOUT' handling
      mm/damon/schemes: add 'LRU_PRIO' DAMOS action
      Docs/admin-guide/damon/sysfs: document 'LRU_PRIO' scheme action
      mm/damon/schemes: add 'LRU_DEPRIO' action
      Docs/admin-guide/damon/sysfs: document 'LRU_DEPRIO' scheme action
      mm/damon: introduce DAMON-based LRU-lists Sorting
      Docs/admin-guide/damon: add a document for DAMON_LRU_SORT
      mm/damon/lru_sort: fix potential memory leak in damon_lru_sort_init()

Sergey Senozhatsky (1):
      zram: do not lookup algorithm in backends table

Shiyang Ruan (15):
      dax: introduce holder for dax_device
      mm: factor helpers for memory_failure_dev_pagemap
      pagemap,pmem: introduce ->memory_failure()
      fsdax: introduce dax_lock_mapping_entry()
      mm: introduce mf_dax_kill_procs() for fsdax case
      xfs: implement ->notify_failure() for XFS
      fsdax: set a CoW flag when associate reflink mappings
      fsdax: output address in dax_iomap_pfn() and rename it
      fsdax: introduce dax_iomap_cow_copy()
      fsdax: replace mmap entry in case of CoW
      fsdax: add dax_iomap_cow_copy() for dax zero
      fsdax: dedup file range to use a compare function
      xfs: support CoW in fsdax mode
      xfs: add dax dedupe support
      xfs: fail dax mount if reflink is enabled on a partition

Sophia Gabriella (1):
      mm: Kconfig: fix typo

Tetsuo Handa (2):
      mm: shrinkers: fix double kfree on shrinker name
      mm: memcontrol: fix potential oom_lock recursion deadlock

Theodore Ts'o (1):
      mm/shmem: support FS_IOC_[SG]ETFLAGS in tmpfs

Tianyu Li (1):
      mm/mempolicy: fix get_nodes out of bound access

Uladzislau Rezki (Sony) (5):
      mm/vmalloc: make link_va()/unlink_va() common to different rb_root
      mm/vmalloc: extend __alloc_vmap_area() with extra arguments
      mm/vmalloc: initialize VA's list node after unlink
      mm/vmalloc: extend __find_vmap_area() with one more argument
      lib/test_vmalloc: switch to prandom_u32()

Uros Bizjak (1):
      mm/page_alloc: use try_cmpxchg in set_pfnblock_flags_mask

Vasily Averin (1):
      net: set proper memcg for net_init hooks allocations

Vincent Whitchurch (1):
      mm/smaps: add Pss_Dirty

Waiman Long (3):
      mm/kmemleak: use _irq lock/unlock variants in kmemleak_scan/_clear()
      mm/kmemleak: skip unlikely objects in kmemleak_scan() without taking lock
      mm/kmemleak: prevent soft lockup in first object iteration loop of kmemleak_scan()

William Lam (1):
      mm: compaction: include compound page count for scanning in pageblock isolation

Xiang Yang (1):
      mm/memcontrol.c: replace cgroup_memory_nokmem with mem_cgroup_kmem_disabled()

Xiang wangx (1):
      userfaultfd/selftests: fix typo in comment

Xiu Jianfeng (3):
      mm/mprotect: remove the redundant initialization for error
      writeback: cleanup bdi_sched_wait()
      writeback: remove inode_to_wb_is_valid()

XueBing Chen (1):
      mm: sparsemem: drop unexpected word 'a' in comments

Yang Shi (9):
      mm: rmap: use the correct parameter name for DEFINE_PAGE_VMA_WALK
      mm/page_vma_mapped.c: check possible huge PMD map with transhuge_vma_suitable()
      mm: khugepaged: check THP flag in hugepage_vma_check()
      mm: thp: consolidate vma size check to transhuge_vma_suitable
      mm: khugepaged: better comments for anon vma check in hugepage_vma_revalidate
      mm: thp: kill transparent_hugepage_active()
      mm: thp: kill __transhuge_page_enabled()
      mm: khugepaged: reorg some khugepaged helpers
      doc: proc: fix the description to THPeligible

Yang Yang (1):
      mm/page_alloc: make the annotations of available memory more accurate

Yixuan Cao (1):
      tools/vm/page_owner_sort.c: adjust the indent in is_need()

Yosry Ahmed (1):
      mm: vmpressure: don't count proactive reclaim in vmpressure

Yuanzheng Song (1):
      tools/vm/slabinfo: use alphabetic order when two values are equal

Yun-Ze Li (1):
      mm, docs: fix comments that mention mem_hotplug_end()

Zhou Guanghui (1):
      memblock,arm64: expand the static memblock memory table

 Documentation/ABI/testing/procfs-smaps_rollup      |   1 +
 Documentation/ABI/testing/sysfs-kernel-mm-ksm      |   2 +-
 Documentation/ABI/testing/sysfs-kernel-slab        |   4 +-
 Documentation/admin-guide/cgroup-v2.rst            |  31 +-
 Documentation/admin-guide/kernel-parameters.txt    |  32 +-
 Documentation/admin-guide/mm/concepts.rst          |   2 +-
 Documentation/admin-guide/mm/damon/index.rst       |   3 +-
 Documentation/admin-guide/mm/damon/lru_sort.rst    | 294 ++++++++++
 Documentation/admin-guide/mm/damon/reclaim.rst     |   8 +-
 Documentation/admin-guide/mm/damon/usage.rst       |  10 +-
 Documentation/admin-guide/mm/index.rst             |   1 +
 Documentation/admin-guide/mm/shrinker_debugfs.rst  | 135 +++++
 Documentation/admin-guide/sysctl/vm.rst            |   7 +-
 Documentation/core-api/index.rst                   |   2 +-
 Documentation/dev-tools/kmemleak.rst               |   1 -
 Documentation/filesystems/proc.rst                 |  11 +-
 Documentation/index.rst                            |   2 +-
 Documentation/{vm => mm}/active_mm.rst             |   0
 Documentation/{vm => mm}/arch_pgtable_helpers.rst  |   0
 Documentation/{vm => mm}/balance.rst               |   0
 Documentation/{vm => mm}/bootmem.rst               |   0
 Documentation/{vm => mm}/damon/api.rst             |   0
 Documentation/{vm => mm}/damon/design.rst          |   0
 Documentation/{vm => mm}/damon/faq.rst             |   0
 Documentation/{vm => mm}/damon/index.rst           |   0
 Documentation/{vm => mm}/free_page_reporting.rst   |   0
 Documentation/{vm => mm}/frontswap.rst             |   0
 Documentation/{vm => mm}/highmem.rst               |   0
 Documentation/{vm => mm}/hmm.rst                   |   0
 Documentation/{vm => mm}/hugetlbfs_reserv.rst      |   0
 Documentation/{vm => mm}/hwpoison.rst              |   0
 Documentation/{vm => mm}/index.rst                 |   0
 Documentation/{vm => mm}/ksm.rst                   |   0
 Documentation/{vm => mm}/memory-model.rst          |   2 +-
 Documentation/{vm => mm}/mmu_notifier.rst          |   0
 Documentation/{vm => mm}/numa.rst                  |   0
 Documentation/{vm => mm}/oom.rst                   |   0
 Documentation/{vm => mm}/overcommit-accounting.rst |   0
 Documentation/{vm => mm}/page_allocation.rst       |   0
 Documentation/{vm => mm}/page_cache.rst            |   0
 Documentation/{vm => mm}/page_frags.rst            |   0
 Documentation/{vm => mm}/page_migration.rst        |   0
 Documentation/{vm => mm}/page_owner.rst            |   0
 Documentation/{vm => mm}/page_reclaim.rst          |   0
 Documentation/{vm => mm}/page_table_check.rst      |   0
 Documentation/{vm => mm}/page_tables.rst           |   0
 Documentation/{vm => mm}/physical_memory.rst       |   0
 Documentation/{vm => mm}/process_addrs.rst         |   0
 Documentation/{vm => mm}/remap_file_pages.rst      |   0
 Documentation/{vm => mm}/shmfs.rst                 |   0
 Documentation/{vm => mm}/slab.rst                  |   0
 Documentation/{vm => mm}/slub.rst                  |   0
 Documentation/{vm => mm}/split_page_table_lock.rst |   0
 Documentation/{vm => mm}/swap.rst                  |   0
 Documentation/{vm => mm}/transhuge.rst             |   0
 Documentation/{vm => mm}/unevictable-lru.rst       |   0
 Documentation/{vm => mm}/vmalloc.rst               |   0
 .../{vm => mm}/vmalloced-kernel-stacks.rst         |   0
 Documentation/{vm => mm}/vmemmap_dedup.rst         |   0
 Documentation/{vm => mm}/z3fold.rst                |   0
 Documentation/{vm => mm}/zsmalloc.rst              |   0
 .../zh_CN/admin-guide/mm/damon/index.rst           |   2 +-
 .../zh_CN/admin-guide/mm/damon/reclaim.rst         |   2 +-
 .../zh_CN/admin-guide/mm/damon/usage.rst           |   8 +-
 .../translations/zh_CN/core-api/index.rst          |   2 +-
 Documentation/translations/zh_CN/index.rst         |   2 +-
 .../translations/zh_CN/{vm => mm}/active_mm.rst    |   2 +-
 .../translations/zh_CN/{vm => mm}/balance.rst      |   2 +-
 .../translations/zh_CN/{vm => mm}/damon/api.rst    |   2 +-
 .../translations/zh_CN/{vm => mm}/damon/design.rst |   2 +-
 .../translations/zh_CN/{vm => mm}/damon/faq.rst    |   2 +-
 .../translations/zh_CN/{vm => mm}/damon/index.rst  |   5 +-
 .../zh_CN/{vm => mm}/free_page_reporting.rst       |   2 +-
 .../translations/zh_CN/{vm => mm}/frontswap.rst    |   2 +-
 .../translations/zh_CN/{vm => mm}/highmem.rst      |   2 +-
 .../translations/zh_CN/{vm => mm}/hmm.rst          |   2 +-
 .../zh_CN/{vm => mm}/hugetlbfs_reserv.rst          |   2 +-
 .../translations/zh_CN/{vm => mm}/hwpoison.rst     |   2 +-
 .../translations/zh_CN/{vm => mm}/index.rst        |   2 +-
 .../translations/zh_CN/{vm => mm}/ksm.rst          |   2 +-
 .../translations/zh_CN/{vm => mm}/memory-model.rst |   4 +-
 .../translations/zh_CN/{vm => mm}/mmu_notifier.rst |   2 +-
 .../translations/zh_CN/{vm => mm}/numa.rst         |   2 +-
 .../zh_CN/{vm => mm}/overcommit-accounting.rst     |   2 +-
 .../translations/zh_CN/{vm => mm}/page_frags.rst   |   2 +-
 .../translations/zh_CN/{vm => mm}/page_owner.rst   |   2 +-
 .../zh_CN/{vm => mm}/page_table_check.rst          |   2 +-
 .../zh_CN/{vm => mm}/remap_file_pages.rst          |   2 +-
 .../zh_CN/{vm => mm}/split_page_table_lock.rst     |   2 +-
 .../translations/zh_CN/{vm => mm}/z3fold.rst       |   2 +-
 .../translations/zh_CN/{vm => mm}/zsmalloc.rst     |   2 +-
 Documentation/translations/zh_TW/index.rst         |   2 +-
 Documentation/vm/.gitignore                        |   3 -
 MAINTAINERS                                        |  12 +-
 arch/alpha/include/asm/pgtable.h                   |  17 -
 arch/alpha/mm/fault.c                              |   4 +
 arch/alpha/mm/init.c                               |  22 +
 arch/arc/include/asm/pgtable-bits-arcv2.h          |  18 -
 arch/arc/mm/fault.c                                |   4 +
 arch/arc/mm/mmap.c                                 |  20 +
 arch/arm/include/asm/pgtable.h                     |  17 -
 arch/arm/kernel/head.S                             |  34 +-
 arch/arm/lib/uaccess_with_memcpy.c                 |   2 +-
 arch/arm/mm/fault.c                                |   4 +
 arch/arm/mm/mmu.c                                  |  20 +
 arch/arm64/Kconfig                                 |   1 -
 arch/arm64/include/asm/hugetlb.h                   |   3 -
 arch/arm64/include/asm/memory.h                    |   9 +
 arch/arm64/include/asm/pgtable-prot.h              |  18 -
 arch/arm64/mm/fault.c                              |   4 +
 arch/arm64/mm/hugetlbpage.c                        |  56 +-
 arch/arm64/mm/mmap.c                               |  21 +
 arch/csky/include/asm/pgalloc.h                    |   2 +-
 arch/csky/include/asm/pgtable.h                    |  24 +-
 arch/csky/mm/fault.c                               |   4 +
 arch/csky/mm/init.c                                |  20 +
 arch/hexagon/include/asm/pgtable.h                 |  27 -
 arch/hexagon/mm/init.c                             |  42 ++
 arch/hexagon/mm/vm_fault.c                         |   4 +
 arch/ia64/include/asm/pgtable.h                    |  18 -
 arch/ia64/mm/fault.c                               |   4 +
 arch/ia64/mm/init.c                                |  28 +-
 arch/loongarch/Kconfig                             |   2 +-
 arch/loongarch/include/asm/pgalloc.h               |   6 +-
 arch/loongarch/include/asm/pgtable-bits.h          |  19 -
 arch/loongarch/include/asm/pgtable.h               |  27 +-
 arch/loongarch/kernel/asm-offsets.c                |   6 -
 arch/loongarch/mm/cache.c                          |  46 ++
 arch/loongarch/mm/pgtable.c                        |   2 +-
 arch/loongarch/mm/tlbex.S                          |   6 +-
 arch/m68k/include/asm/mcf_pgtable.h                |  59 --
 arch/m68k/include/asm/motorola_pgtable.h           |  29 -
 arch/m68k/include/asm/sun3_pgtable.h               |  23 -
 arch/m68k/mm/fault.c                               |   4 +
 arch/m68k/mm/mcfmmu.c                              |  55 ++
 arch/m68k/mm/motorola.c                            |  29 +
 arch/m68k/mm/sun3mmu.c                             |  20 +
 arch/microblaze/include/asm/pgtable.h              |  17 -
 arch/microblaze/mm/fault.c                         |   4 +
 arch/microblaze/mm/init.c                          |  20 +
 arch/mips/include/asm/pgalloc.h                    |   8 +-
 arch/mips/include/asm/pgtable-32.h                 |  19 +-
 arch/mips/include/asm/pgtable-64.h                 |  61 +--
 arch/mips/include/asm/pgtable.h                    |  22 -
 arch/mips/kernel/asm-offsets.c                     |   5 -
 arch/mips/kernel/mips-mt.c                         |   4 +-
 arch/mips/kvm/mmu.c                                |   2 +-
 arch/mips/mm/cache.c                               |   3 +
 arch/mips/mm/fault.c                               |   4 +
 arch/mips/mm/pgtable.c                             |   2 +-
 arch/mips/mm/tlbex.c                               |  14 +-
 arch/nios2/include/asm/pgtable.h                   |  23 +-
 arch/nios2/mm/fault.c                              |   4 +
 arch/nios2/mm/init.c                               |  25 +-
 arch/nios2/mm/pgtable.c                            |   2 +-
 arch/openrisc/include/asm/pgtable.h                |  18 -
 arch/openrisc/mm/fault.c                           |   4 +
 arch/openrisc/mm/init.c                            |  20 +
 arch/parisc/include/asm/pgalloc.h                  |   6 +-
 arch/parisc/include/asm/pgtable.h                  |  26 +-
 arch/parisc/mm/fault.c                             |   4 +
 arch/parisc/mm/init.c                              |  20 +
 arch/powerpc/Kconfig                               |   1 -
 arch/powerpc/include/asm/book3s/64/pgtable.h       |   2 +-
 arch/powerpc/include/asm/pgtable.h                 |  20 +-
 arch/powerpc/mm/copro_fault.c                      |   5 +
 arch/powerpc/mm/fault.c                            |   5 +
 arch/powerpc/mm/pgtable.c                          |  24 +
 arch/riscv/include/asm/pgtable.h                   |  20 -
 arch/riscv/mm/fault.c                              |   4 +
 arch/riscv/mm/init.c                               |  20 +
 arch/s390/include/asm/pgtable.h                    |  17 -
 arch/s390/mm/fault.c                               |  12 +
 arch/s390/mm/mmap.c                                |  20 +
 arch/sh/include/asm/pgtable.h                      |  17 -
 arch/sh/mm/fault.c                                 |   4 +
 arch/sh/mm/mmap.c                                  |  20 +
 arch/sparc/Kconfig                                 |   1 -
 arch/sparc/include/asm/pgtable_32.h                |  19 -
 arch/sparc/include/asm/pgtable_64.h                |  19 -
 arch/sparc/mm/fault_32.c                           |   4 +
 arch/sparc/mm/fault_64.c                           |   5 +
 arch/sparc/mm/init_32.c                            |  20 +
 arch/sparc/mm/init_64.c                            |   3 +
 arch/um/include/asm/pgtable.h                      |  17 -
 arch/um/kernel/mem.c                               |  20 +
 arch/um/kernel/trap.c                              |   4 +
 arch/x86/Kconfig                                   |   1 -
 arch/x86/include/asm/mem_encrypt.h                 |   2 +
 arch/x86/include/asm/pgtable_types.h               |  19 -
 arch/x86/kvm/mmu/mmu.c                             |   2 +-
 arch/x86/mm/fault.c                                |   4 +
 arch/x86/mm/hugetlbpage.c                          |  39 --
 arch/x86/mm/mem_encrypt_amd.c                      |   6 +-
 arch/x86/mm/pgprot.c                               |  28 +
 arch/x86/um/mem_32.c                               |   2 +-
 arch/xtensa/include/asm/pgalloc.h                  |   2 +-
 arch/xtensa/include/asm/pgtable.h                  |  19 -
 arch/xtensa/mm/fault.c                             |   4 +
 arch/xtensa/mm/init.c                              |  22 +
 drivers/android/binder_alloc.c                     |  37 +-
 drivers/android/binder_alloc.h                     |   2 +-
 drivers/android/binder_alloc_selftest.c            |   2 +-
 drivers/block/zram/zcomp.c                         |  11 +-
 drivers/block/zram/zram_drv.c                      |   6 +-
 drivers/dax/super.c                                |  67 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c           |  34 +-
 drivers/gpu/drm/i915/gem/i915_gem_shrinker.c       |   3 +-
 drivers/gpu/drm/msm/msm_gem_shrinker.c             |   2 +-
 drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c   |   2 +-
 drivers/gpu/drm/ttm/ttm_pool.c                     |   2 +-
 drivers/md/bcache/btree.c                          |   2 +-
 drivers/md/dm-bufio.c                              |   3 +-
 drivers/md/dm-zoned-metadata.c                     |   4 +-
 drivers/md/dm.c                                    |   2 +-
 drivers/md/raid5.c                                 |   2 +-
 drivers/misc/vmw_balloon.c                         |   2 +-
 drivers/nvdimm/pmem.c                              |  17 +
 drivers/of/fdt.c                                   |   2 +-
 drivers/virtio/virtio_balloon.c                    |   2 +-
 drivers/virtio/virtio_mem.c                        |   6 +-
 drivers/xen/xenbus/xenbus_probe_backend.c          |   2 +-
 fs/btrfs/super.c                                   |   2 +
 fs/dax.c                                           | 401 +++++++++++---
 fs/erofs/super.c                                   |  10 +-
 fs/erofs/utils.c                                   |   2 +-
 fs/ext2/super.c                                    |   7 +-
 fs/ext4/extents_status.c                           |   3 +-
 fs/ext4/super.c                                    |   9 +-
 fs/f2fs/super.c                                    |   2 +-
 fs/gfs2/glock.c                                    |   2 +-
 fs/gfs2/main.c                                     |   2 +-
 fs/hugetlbfs/inode.c                               |  13 +-
 fs/jbd2/journal.c                                  |   3 +-
 fs/mbcache.c                                       |   2 +-
 fs/nfs/nfs42xattr.c                                |   7 +-
 fs/nfs/super.c                                     |   2 +-
 fs/nfsd/filecache.c                                |   2 +-
 fs/nfsd/nfscache.c                                 |   3 +-
 fs/proc/task_mmu.c                                 |   7 +-
 fs/quota/dquot.c                                   |   2 +-
 fs/remap_range.c                                   |  31 +-
 fs/super.c                                         |   6 +-
 fs/ubifs/super.c                                   |   2 +-
 fs/userfaultfd.c                                   |   6 +-
 fs/xfs/Makefile                                    |   5 +
 fs/xfs/xfs_buf.c                                   |  13 +-
 fs/xfs/xfs_file.c                                  |  35 +-
 fs/xfs/xfs_fsops.c                                 |   3 +
 fs/xfs/xfs_icache.c                                |   2 +-
 fs/xfs/xfs_inode.c                                 |  69 ++-
 fs/xfs/xfs_inode.h                                 |   1 +
 fs/xfs/xfs_iomap.c                                 |  30 +-
 fs/xfs/xfs_iomap.h                                 |   1 +
 fs/xfs/xfs_mount.h                                 |   1 +
 fs/xfs/xfs_notify_failure.c                        | 220 ++++++++
 fs/xfs/xfs_qm.c                                    |   3 +-
 fs/xfs/xfs_reflink.c                               |  12 +-
 fs/xfs/xfs_super.c                                 |   6 +-
 fs/xfs/xfs_super.h                                 |   1 +
 include/linux/backing-dev.h                        |  23 -
 include/linux/damon.h                              |  25 +-
 include/linux/dax.h                                |  56 +-
 include/linux/fs.h                                 |  12 +-
 include/linux/highmem.h                            |  23 +-
 include/linux/hmm.h                                |   4 +-
 include/linux/huge_mm.h                            |  94 ++--
 include/linux/hugetlb.h                            |  28 +-
 include/linux/khugepaged.h                         |  30 --
 include/linux/kmemleak.h                           |   8 +-
 include/linux/memcontrol.h                         |  74 ++-
 include/linux/memory_hotplug.h                     |   9 -
 include/linux/memremap.h                           |  35 +-
 include/linux/migrate.h                            |   1 +
 include/linux/mm.h                                 | 133 ++---
 include/linux/mm_types.h                           |   7 +
 include/linux/mmu_notifier.h                       |   2 +-
 include/linux/mmzone.h                             | 159 +++++-
 include/linux/page-flags.h                         |  23 +
 include/linux/pagemap.h                            |   2 -
 include/linux/pagevec.h                            |   1 -
 include/linux/pgtable.h                            |  28 +
 include/linux/rmap.h                               |   4 +-
 include/linux/sched/mm.h                           |   4 +-
 include/linux/shmem_fs.h                           |  11 +
 include/linux/shrinker.h                           |  33 +-
 include/linux/swap.h                               |  12 +-
 include/linux/swapops.h                            |  12 +-
 kernel/rcu/tree.c                                  |   2 +-
 lib/Kconfig.debug                                  |   9 +
 lib/test_free_pages.c                              |   2 +-
 lib/test_hmm.c                                     | 347 +++++++++---
 lib/test_hmm_uapi.h                                |  19 +-
 lib/test_vmalloc.c                                 |  15 +-
 mm/Kconfig                                         |   7 +-
 mm/Makefile                                        |   1 +
 mm/cma_debug.c                                     |   2 +-
 mm/compaction.c                                    |   5 +-
 mm/damon/Kconfig                                   |   8 +
 mm/damon/Makefile                                  |   1 +
 mm/damon/dbgfs.c                                   |  79 ++-
 mm/damon/lru_sort.c                                | 548 +++++++++++++++++++
 mm/damon/ops-common.c                              |  42 ++
 mm/damon/ops-common.h                              |   2 +
 mm/damon/paddr.c                                   |  60 ++-
 mm/damon/reclaim.c                                 |  44 +-
 mm/damon/sysfs.c                                   |  69 +--
 mm/debug_vm_pgtable.c                              |   2 +-
 mm/filemap.c                                       |  18 +-
 mm/frontswap.c                                     |   2 +-
 mm/gup.c                                           |  90 +++-
 mm/gup_test.c                                      |   2 +-
 mm/highmem.c                                       |   2 +-
 mm/huge_memory.c                                   | 186 ++++---
 mm/hugetlb.c                                       | 169 +++---
 mm/hugetlb_cgroup.c                                |   1 +
 mm/hugetlb_vmemmap.c                               |  68 ++-
 mm/internal.h                                      |  19 +
 mm/kasan/common.c                                  |   8 +-
 mm/kasan/hw_tags.c                                 |  32 +-
 mm/kasan/kasan.h                                   |   3 +-
 mm/kasan/report.c                                  |  12 +-
 mm/kfence/core.c                                   |   4 +-
 mm/khugepaged.c                                    | 230 ++++----
 mm/kmemleak.c                                      | 260 ++++++---
 mm/ksm.c                                           |  10 +-
 mm/list_lru.c                                      |   2 +-
 mm/madvise.c                                       |  14 +-
 mm/memblock.c                                      |  28 +-
 mm/memcontrol.c                                    | 224 +++++---
 mm/memory-failure.c                                | 330 ++++++++----
 mm/memory.c                                        |  27 +-
 mm/memory_hotplug.c                                |  57 +-
 mm/mempolicy.c                                     |  10 +-
 mm/mempool.c                                       |   2 +-
 mm/memremap.c                                      |  16 +-
 mm/migrate.c                                       |  43 +-
 mm/migrate_device.c                                |  80 ++-
 mm/mlock.c                                         |   2 +-
 mm/mmap.c                                          |  53 +-
 mm/mprotect.c                                      |  81 ++-
 mm/nommu.c                                         |   2 +-
 mm/page_alloc.c                                    | 439 +++++++++------
 mm/page_vma_mapped.c                               |   5 +-
 mm/percpu.c                                        |   6 +-
 mm/rmap.c                                          | 114 ++--
 mm/shmem.c                                         |  78 ++-
 mm/shrinker_debug.c                                | 286 ++++++++++
 mm/slab.c                                          |  10 -
 mm/sparse-vmemmap.c                                |  10 +-
 mm/sparse.c                                        |   2 +-
 mm/swap.c                                          | 599 ++++++++++-----------
 mm/swap.h                                          |  19 +-
 mm/swap_state.c                                    |  56 +-
 mm/swapfile.c                                      |  31 +-
 mm/util.c                                          |   2 +-
 mm/vmalloc.c                                       | 148 ++---
 mm/vmscan.c                                        | 332 +++++++-----
 mm/workingset.c                                    |   2 +-
 mm/zsmalloc.c                                      |  16 +-
 net/core/net_namespace.c                           |   7 +
 net/core/page_pool.c                               |   2 +-
 net/sunrpc/auth.c                                  |   2 +-
 tools/cgroup/memcg_shrinker.py                     |  71 +++
 tools/testing/memblock/linux/kmemleak.h            |   2 +-
 tools/testing/selftests/vm/Makefile                |   1 +
 tools/testing/selftests/vm/hmm-tests.c             | 325 ++++++++++-
 tools/testing/selftests/vm/hugepage-mremap.c       |   2 +-
 tools/testing/selftests/vm/hugetlb-madvise.c       |   5 +-
 tools/testing/selftests/vm/mrelease_test.c         |  16 +-
 tools/testing/selftests/vm/run_vmtests.sh          |  15 +-
 tools/testing/selftests/vm/soft-dirty.c            |  67 ++-
 tools/testing/selftests/vm/test_hmm.sh             |  24 +-
 tools/testing/selftests/vm/userfaultfd.c           |   6 +-
 tools/testing/selftests/vm/va_128TBswitch.c        |   8 +-
 tools/testing/selftests/vm/va_128TBswitch.sh       |  54 ++
 tools/vm/page_owner_sort.c                         |  30 +-
 tools/vm/slabinfo.c                                |  32 +-
 378 files changed, 7159 insertions(+), 3215 deletions(-)
 create mode 100644 Documentation/admin-guide/mm/damon/lru_sort.rst
 create mode 100644 Documentation/admin-guide/mm/shrinker_debugfs.rst
 rename Documentation/{vm => mm}/active_mm.rst (100%)
 rename Documentation/{vm => mm}/arch_pgtable_helpers.rst (100%)
 rename Documentation/{vm => mm}/balance.rst (100%)
 rename Documentation/{vm => mm}/bootmem.rst (100%)
 rename Documentation/{vm => mm}/damon/api.rst (100%)
 rename Documentation/{vm => mm}/damon/design.rst (100%)
 rename Documentation/{vm => mm}/damon/faq.rst (100%)
 rename Documentation/{vm => mm}/damon/index.rst (100%)
 rename Documentation/{vm => mm}/free_page_reporting.rst (100%)
 rename Documentation/{vm => mm}/frontswap.rst (100%)
 rename Documentation/{vm => mm}/highmem.rst (100%)
 rename Documentation/{vm => mm}/hmm.rst (100%)
 rename Documentation/{vm => mm}/hugetlbfs_reserv.rst (100%)
 rename Documentation/{vm => mm}/hwpoison.rst (100%)
 rename Documentation/{vm => mm}/index.rst (100%)
 rename Documentation/{vm => mm}/ksm.rst (100%)
 rename Documentation/{vm => mm}/memory-model.rst (99%)
 rename Documentation/{vm => mm}/mmu_notifier.rst (100%)
 rename Documentation/{vm => mm}/numa.rst (100%)
 rename Documentation/{vm => mm}/oom.rst (100%)
 rename Documentation/{vm => mm}/overcommit-accounting.rst (100%)
 rename Documentation/{vm => mm}/page_allocation.rst (100%)
 rename Documentation/{vm => mm}/page_cache.rst (100%)
 rename Documentation/{vm => mm}/page_frags.rst (100%)
 rename Documentation/{vm => mm}/page_migration.rst (100%)
 rename Documentation/{vm => mm}/page_owner.rst (100%)
 rename Documentation/{vm => mm}/page_reclaim.rst (100%)
 rename Documentation/{vm => mm}/page_table_check.rst (100%)
 rename Documentation/{vm => mm}/page_tables.rst (100%)
 rename Documentation/{vm => mm}/physical_memory.rst (100%)
 rename Documentation/{vm => mm}/process_addrs.rst (100%)
 rename Documentation/{vm => mm}/remap_file_pages.rst (100%)
 rename Documentation/{vm => mm}/shmfs.rst (100%)
 rename Documentation/{vm => mm}/slab.rst (100%)
 rename Documentation/{vm => mm}/slub.rst (100%)
 rename Documentation/{vm => mm}/split_page_table_lock.rst (100%)
 rename Documentation/{vm => mm}/swap.rst (100%)
 rename Documentation/{vm => mm}/transhuge.rst (100%)
 rename Documentation/{vm => mm}/unevictable-lru.rst (100%)
 rename Documentation/{vm => mm}/vmalloc.rst (100%)
 rename Documentation/{vm => mm}/vmalloced-kernel-stacks.rst (100%)
 rename Documentation/{vm => mm}/vmemmap_dedup.rst (100%)
 rename Documentation/{vm => mm}/z3fold.rst (100%)
 rename Documentation/{vm => mm}/zsmalloc.rst (100%)
 rename Documentation/translations/zh_CN/{vm => mm}/active_mm.rst (98%)
 rename Documentation/translations/zh_CN/{vm => mm}/balance.rst (99%)
 rename Documentation/translations/zh_CN/{vm => mm}/damon/api.rst (91%)
 rename Documentation/translations/zh_CN/{vm => mm}/damon/design.rst (98%)
 rename Documentation/translations/zh_CN/{vm => mm}/damon/faq.rst (98%)
 rename Documentation/translations/zh_CN/{vm => mm}/damon/index.rst (90%)
 rename Documentation/translations/zh_CN/{vm => mm}/free_page_reporting.rst (97%)
 rename Documentation/translations/zh_CN/{vm => mm}/frontswap.rst (99%)
 rename Documentation/translations/zh_CN/{vm => mm}/highmem.rst (99%)
 rename Documentation/translations/zh_CN/{vm => mm}/hmm.rst (99%)
 rename Documentation/translations/zh_CN/{vm => mm}/hugetlbfs_reserv.rst (99%)
 rename Documentation/translations/zh_CN/{vm => mm}/hwpoison.rst (99%)
 rename Documentation/translations/zh_CN/{vm => mm}/index.rst (96%)
 rename Documentation/translations/zh_CN/{vm => mm}/ksm.rst (98%)
 rename Documentation/translations/zh_CN/{vm => mm}/memory-model.rst (98%)
 rename Documentation/translations/zh_CN/{vm => mm}/mmu_notifier.rst (98%)
 rename Documentation/translations/zh_CN/{vm => mm}/numa.rst (99%)
 rename Documentation/translations/zh_CN/{vm => mm}/overcommit-accounting.rst (98%)
 rename Documentation/translations/zh_CN/{vm => mm}/page_frags.rst (97%)
 rename Documentation/translations/zh_CN/{vm => mm}/page_owner.rst (99%)
 rename Documentation/translations/zh_CN/{vm => mm}/page_table_check.rst (97%)
 rename Documentation/translations/zh_CN/{vm => mm}/remap_file_pages.rst (97%)
 rename Documentation/translations/zh_CN/{vm => mm}/split_page_table_lock.rst (98%)
 rename Documentation/translations/zh_CN/{vm => mm}/z3fold.rst (96%)
 rename Documentation/translations/zh_CN/{vm => mm}/zsmalloc.rst (98%)
 delete mode 100644 Documentation/vm/.gitignore
 create mode 100644 fs/xfs/xfs_notify_failure.c
 create mode 100644 mm/damon/lru_sort.c
 create mode 100644 mm/shrinker_debug.c
 create mode 100644 tools/cgroup/memcg_shrinker.py
 create mode 100755 tools/testing/selftests/vm/va_128TBswitch.sh


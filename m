Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABE8534338
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 20:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbiEYSmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 14:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343850AbiEYSmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 14:42:16 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F11AE4B;
        Wed, 25 May 2022 11:42:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6D90ECE2014;
        Wed, 25 May 2022 18:42:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA08C385B8;
        Wed, 25 May 2022 18:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1653504129;
        bh=KCskJ71LhHd12rIdZPfJ/F033Lo7GPRsLrR4KX/QS9Q=;
        h=Date:From:To:Cc:Subject:From;
        b=MMfF1KO8G4fgXyd39zNyM6IyDmriTYe+t+Da//m410+EkdrBTDyHvBOtVXsOnTntA
         o3MsG7yU3t8VKy1ZlU5B2lyl3KFNfOpDWLQjCUhZlK3CoCql4fNrFp2WDeaIUpQrod
         X/xGQ1+svZFKfBAP4KDYEp+W2GdLPISclQIfp4LI=
Date:   Wed, 25 May 2022 11:42:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] MM updates for 5.19-rc1
Message-Id: <20220525114208.223f45e4b361d99b83be0c52@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Almost all of MM here.  A few things are still getting finished off,
reviewed, etc.

- there's a trivial conflict in arch/x86/mm/Makefile

- conflict in mm/page_io.c we resolved thusly:

	if (data_race(sis->flags & SWP_FS_OPS)) {
		swap_readpage_fs(page, plug);
		goto out;
	}

- conflict in fs/nfs/file.c thusly:

	.write_begin = nfs_write_begin,
	.write_end = nfs_write_end,
	.invalidate_folio = nfs_invalidate_folio,
	.release_folio = nfs_release_folio,
#ifdef CONFIG_MIGRATION
	.migratepage = nfs_migrate_page,
#endif



The following changes since commit 38d741cb70b30741c0e802cbed7bd9cf4fd15fa4:

  Merge tag 'drm-fixes-2022-04-29' of git://anongit.freedesktop.org/drm/drm (2022-04-28 18:00:34 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-2022-05-25

for you to fetch changes up to f403f22f8ccb12860b2b62fec3173c6ccd45938b:

  mm: kfence: use PAGE_ALIGNED helper (2022-05-25 10:47:49 -0700)

----------------------------------------------------------------
Yang Shi has improved the behaviour of khugepaged collapsing of readonly
file-backed transparent hugepages.

Johannes Weiner has arranged for zswap memory use to be tracked and
managed on a per-cgroup basis.

Munchun Song adds a /proc knob ("hugetlb_optimize_vmemmap") for runtime
enablement of the recent huge page vmemmap optimization feature.

Baolin Wang contributes a series to fix some issues around hugetlb
pagetable invalidation.

Zhenwei Pi has fixed some interactions between hwpoisoned pages and
virtualization.

Tong Tiangen has enabled the use of the presently x86-only
page_table_check debugging feature on arm64 and riscv.

David Vernet has done some fixup work on the memcg selftests.

Peter Xu has taught userfaultfd to handle write protection faults against
shmem- and hugetlbfs-backed files.

More DAMON development from SeongJae Park - adding online tuning of the
feature and support for monitoring of fixed virtual address ranges.  Also
easier discovery of which monitoring operations are available.

Nadav Amit has done some optimization of TLB flushing during mprotect().

Neil Brown continues to labor away at improving our swap-over-NFS support.

David Hildenbrand has some fixes to anon page COWing versus
get_user_pages().

Peng Liu fixed some errors in the core hugetlb code.

Joao Martins has reduced the amount of memory consumed by device-dax's
compound devmaps.

Some cleanups of the arch-specific pagemap code from Anshuman Khandual.

Muchun Song has found and fixed some errors in the TLB flushing of
transparent hugepages.

Roman Gushchin has done more work on the memcg selftests.

And, of course, many smaller fixes and cleanups.  Notably, the customary
million cleanup serieses from Miaohe Lin.

----------------------------------------------------------------
Adrian Huang (1):
      mm/rmap: Fix typos in comments

Akira Yokosawa (1):
      docs: vm/page_owner: tweak literal block in STANDARD FORMAT SPECIFIERS

Alexey Romanov (1):
      zram: remove double compression logic

Alistair Popple (1):
      mm: add selftests for migration entries

Andrey Konovalov (7):
      kasan: mark KASAN_VMALLOC flags as kasan_vmalloc_flags_t
      kasan: clean up comments in internal kasan.h
      kasan: use tabs to align shadow values
      kasan: give better names to shadow values
      kasan: update documentation
      kasan: move boot parameters section in documentation
      kasan: clean-up kconfig options descriptions

Anshuman Khandual (8):
      mm/debug_vm_pgtable: drop protection_map[] usage
      mm/mmap: clarify protection_map[] indices
      mm/mmap: add new config ARCH_HAS_VM_GET_PAGE_PROT
      powerpc/mm: enable ARCH_HAS_VM_GET_PAGE_PROT
      arm64/mm: enable ARCH_HAS_VM_GET_PAGE_PROT
      sparc/mm: enable ARCH_HAS_VM_GET_PAGE_PROT
      mm/mmap: drop arch_filter_pgprot()
      mm/mmap: drop arch_vm_get_page_pgprot()

Axel Rasmussen (2):
      selftests: vm: refactor run_vmtests.sh to reduce boilerplate
      selftests: vm: fix shellcheck warnings in run_vmtests.sh

Baolin Wang (8):
      mm: migrate: simplify the refcount validation when migrating hugetlb mapping
      mm: hugetlb: add missing cache flushing in hugetlb_unshare_all_pmds()
      mm: hugetlb: considering PMD sharing when flushing cache/TLBs
      mm: rmap: move the cache flushing to the correct place for hugetlb PMD sharing
      mm: rmap: use flush_cache_range() to flush cache for hugetlb pages
      mm: change huge_ptep_clear_flush() to return the original pte
      mm: rmap: fix CONT-PTE/PMD size hugetlb issue when migration
      mm: rmap: fix CONT-PTE/PMD size hugetlb issue when unmapping

Brian Geffon (1):
      zram: add a huge_idle writeback mode

Chen Wandun (2):
      mm: rework calculation of bdi_min_ratio in bdi_set_min_ratio
      mm/page_alloc: simplify update of pgdat in wake_all_kswapds

Christoph Hellwig (1):
      x86/mm: enable ARCH_HAS_VM_GET_PAGE_PROT

Christophe JAILLET (2):
      drivers/base/memory: fix an unlikely reference counting issue in __add_memory_block()
      cgroup: fix an error handling path in alloc_pagecache_max_30M()

Christophe de Dinechin (1):
      nodemask.h: fix compilation error with GCC12

David Hildenbrand (25):
      mm/rmap: fix missing swap_free() in try_to_unmap() after arch_unmap_one() failed
      mm/hugetlb: take src_mm->write_protect_seq in copy_hugetlb_page_range()
      mm/memory: slightly simplify copy_present_pte()
      mm/rmap: split page_dup_rmap() into page_dup_file_rmap() and page_try_dup_anon_rmap()
      mm/rmap: convert RMAP flags to a proper distinct rmap_t type
      mm/rmap: remove do_page_add_anon_rmap()
      mm/rmap: pass rmap flags to hugepage_add_anon_rmap()
      mm/rmap: drop "compound" parameter from page_add_new_anon_rmap()
      mm/rmap: use page_move_anon_rmap() when reusing a mapped PageAnon() page exclusively
      mm/huge_memory: remove outdated VM_WARN_ON_ONCE_PAGE from unmap_page()
      mm/page-flags: reuse PG_mappedtodisk as PG_anon_exclusive for PageAnon() pages
      mm: remember exclusively mapped anonymous pages with PG_anon_exclusive
      mm/rmap: fail try_to_migrate() early when setting a PMD migration entry fails
      mm/gup: disallow follow_page(FOLL_PIN)
      mm: support GUP-triggered unsharing of anonymous pages
      mm/gup: trigger FAULT_FLAG_UNSHARE when R/O-pinning a possibly shared anonymous page
      mm/gup: sanity-check with CONFIG_DEBUG_VM that anonymous pages are exclusive when (un)pinning
      mm/swap: remember PG_anon_exclusive via a swp pte bit
      mm/debug_vm_pgtable: add tests for __HAVE_ARCH_PTE_SWP_EXCLUSIVE
      x86/pgtable: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
      arm64/pgtable: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
      s390/pgtable: cleanup description of swp pte layout
      s390/pgtable: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
      powerpc/pgtable: remove _PAGE_BIT_SWAP_TYPE for book3s
      powerpc/pgtable: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE for book3s

David Vernet (5):
      cgroups: refactor children cgroups in memcg tests
      cgroup: account for memory_recursiveprot in test_memcg_low()
      cgroup: account for memory_localevents in test_memcg_oom_group_leaf_events()
      cgroup: remove racy check in test_memcg_sock()
      cgroup: fix racy check in alloc_pagecache_max_30M() helper function

Eric Dumazet (1):
      mm/page_owner: use strscpy() instead of strlcpy()

Fabio M. De Francesco (5):
      mm/highmem: VM_BUG_ON() if offset + len > PAGE_SIZE
      mm/highmem: fix kernel-doc warnings in highmem*.h
      Documentation/vm: include kdocs from highmem*.h into highmem.rst
      Documentation/vm: move "Using kmap-atomic" to highmem.h
      Documentation/vm: rework "Temporary Virtual Mappings" section

Fanjun Kong (1):
      mm/page_owner.c: add missing __initdata attribute

Florian Rommel (1):
      mmap locking API: fix missed mmap_sem references in comments

Gabriel Krisman Bertazi (1):
      selftests: vm: add test for Soft-Dirty PTE bit

Ganesan Rajagopal (1):
      mm/memcontrol: export memcg->watermark via sysfs for v2 memcg

Gautam Menghani (1):
      mm/damon: add documentation for Enum value

Guo Zhengkui (1):
      userfaultfd/selftests: use swap() instead of open coding it

Hailong Tu (1):
      mm/damon/reclaim: fix the timer always stays active

Haowen Bai (1):
      tools/vm/page_owner: support debug log to avoid huge log print

Hongchen Zhang (1):
      mm/swapops: make is_pmd_migration_entry more strict

Hugh Dickins (1):
      mm/shmem: fix shmem folio swapoff hang

Jackie Liu (1):
      mm/kfence: print disabling or re-enabling message

Jagdish Gediya (2):
      lib/kstrtox.c: add "false"/"true" support to kstrtobool()
      mm: convert sysfs input to bool using kstrtobool()

Jakob Koschel (1):
      hugetlb: remove use of list iterator variable after loop

Jiajian Ye (3):
      tools/vm/page_owner_sort.c: use fprintf() to send error messages to stderr
      tools/vm/page_owner_sort.c: support for multi-value selection in single argument
      tools/vm/page_owner_sort.c: support sorting blocks by multiple keys

Jianxing Wang (1):
      mm/mmu_gather: limit free batch count and add schedule point in tlb_batch_pages_flush

Jiapeng Chong (1):
      mm/damon/reclaim: use resource_size function on resource object

Joao Martins (5):
      mm/sparse-vmemmap: add a pgmap argument to section activation
      mm/sparse-vmemmap: refactor core of vmemmap_populate_basepages() to helper
      mm/hugetlb_vmemmap: move comment block to Documentation/vm
      mm/sparse-vmemmap: improve memory savings for compound devmaps
      mm/page_alloc: reuse tail struct pages for compound devmaps

Joel Savitz (2):
      Documentation/sysctl: document page_lock_unfairness
      selftests: clarify common error when running gup_test

Johannes Weiner (7):
      Documentation: filesystems: proc: update meminfo section
      mm: Kconfig: move swap and slab config options to the MM section
      mm: Kconfig: group swap, slab, hotplug and thp options into submenus
      mm: Kconfig: simplify zswap configuration
      mm: zswap: add basic meminfo and vmstat coverage
      zswap: memcg accounting
      Revert "mm/vmscan: never demote for memcg reclaim"

Julia Lawall (2):
      ksm: fix typo in comment
      selftests/vm/pkeys: fix typo in comment

Kefeng Wang (4):
      mm: page_table_check: move pxx_user_accessible_page into x86
      arm64/mm: enable ARCH_SUPPORTS_PAGE_TABLE_CHECK
      mm: damon: use HPAGE_PMD_SIZE
      mm: kfence: use PAGE_ALIGNED helper

Li kunyu (1):
      mm: functions may simplify the use of return values

Lu Jialin (2):
      mm/memcontrol.c: make cgroup_memory_noswap static
      mm/memcontrol.c: remove unused private flag of memory.oom_control

Luo Meng (1):
      tmpfs: fix undefined-behaviour in shmem_reconfigure()

Ma Wupeng (1):
      mm/page_alloc.c: calc the right pfn if page size is not 4K

Matthew Wilcox (Oracle) (26):
      shmem: convert shmem_alloc_hugepage() to use vma_alloc_folio()
      mm/huge_memory: convert do_huge_pmd_anonymous_page() to use vma_alloc_folio()
      alpha: fix alloc_zeroed_user_highpage_movable()
      mm: remove alloc_pages_vma()
      vmscan: use folio_mapped() in shrink_page_list()
      vmscan: convert the writeback handling in shrink_page_list() to folios
      swap: turn get_swap_page() into folio_alloc_swap()
      swap: convert add_to_swap() to take a folio
      vmscan: convert dirty page handling to folios
      vmscan: convert page buffer handling to use folios
      vmscan: convert lazy freeing to folios
      vmscan: move initialisation of mapping down
      vmscan: convert the activate_locked portion of shrink_page_list to folios
      mm: allow can_split_folio() to be called when THP are disabled
      vmscan: remove remaining uses of page in shrink_page_list
      mm/shmem: use a folio in shmem_unused_huge_shrink
      mm/swap: add folio_throttle_swaprate
      mm/shmem: convert shmem_add_to_page_cache to take a folio
      mm/shmem: turn shmem_should_replace_page into shmem_should_replace_folio
      mm/shmem: add shmem_alloc_folio()
      mm/shmem: convert shmem_alloc_and_acct_page to use a folio
      mm/shmem: convert shmem_getpage_gfp to use a folio
      mm/shmem: convert shmem_swapin_page() to shmem_swapin_folio()
      mm: add folio_mapping_flags()
      mm: add folio_test_movable()
      mm/migrate: convert move_to_new_page() into move_to_new_folio()

Miaohe Lin (63):
      mm: shmem: make shmem_init return void
      mm/memcg: remove unneeded nr_scanned
      mm/memory-failure.c: minor cleanup for HWPoisonHandlable
      mm/memory-failure.c: dissolve truncated hugetlb page
      mm/vmscan: remove obsolete comment in get_scan_count
      mm/vmscan: fix comment for current_may_throttle
      mm/vmscan: fix comment for isolate_lru_pages
      mm/z3fold: declare z3fold_mount with __init
      mm/z3fold: remove obsolete comment in z3fold_alloc
      mm/z3fold: minor clean up for z3fold_free
      mm/z3fold: remove unneeded page_mapcount_reset and ClearPagePrivate
      mm/z3fold: remove confusing local variable l reassignment
      mm/z3fold: move decrement of pool->pages_nr into __release_z3fold_page()
      mm/z3fold: remove redundant list_del_init of zhdr->buddy in z3fold_free
      mm/z3fold: remove unneeded PAGE_HEADLESS check in free_handle()
      mm: compaction: use helper isolation_suitable()
      drivers/base/node.c: fix compaction sysfs file leak
      mm/mempolicy: clean up the code logic in queue_pages_pte_range
      mm/migration: remove unneeded local variable mapping_locked
      mm/migration: remove unneeded local variable page_lru
      mm/migration: use helper function vma_lookup() in add_page_for_migration
      mm/migration: use helper macro min in do_pages_stat
      mm/migration: avoid unneeded nodemask_t initialization
      mm/migration: remove some duplicated codes in migrate_pages
      mm/migration: fix potential page refcounts leak in migrate_pages
      mm/migration: fix potential invalid node access for reclaim-based migration
      mm/migration: fix possible do_pages_stat_array racing with memory offline
      mm/madvise: fix potential pte_unmap_unlock pte error
      mm/mmap.c: use helper mlock_future_check()
      mm/mremap: use helper mlock_future_check()
      mm/mremap: avoid unneeded do_munmap call
      mm: compaction: remove unneeded return value of kcompactd_run
      mm: compaction: remove unneeded pfn update
      mm: compaction: remove unneeded assignment to isolate_start_pfn
      mm: compaction: clean up comment for sched contention
      mm: compaction: clean up comment about suitable migration target recheck
      mm: compaction: use COMPACT_CLUSTER_MAX in compaction.c
      mm: compaction: use helper compound_nr in isolate_migratepages_block
      mm: compaction: clean up comment about async compaction in isolate_migratepages
      mm: compaction: avoid possible NULL pointer dereference in kcompactd_cpu_online
      mm: compaction: make compaction_zonelist_suitable return false when COMPACT_SUCCESS
      mm: compaction: simplify the code in __compact_finished
      mm: compaction: make sure highest is above the min_pfn
      mm/vmscan: take min_slab_pages into account when try to call shrink_node
      mm/vmscan: add a comment about MADV_FREE pages check in folio_check_dirty_writeback
      mm/vmscan: introduce helper function reclaim_page_list()
      mm/vmscan: take all base pages of THP into account when race with speculative reference
      mm/vmscan: remove obsolete comment in kswapd_run
      mm/vmscan: use helper folio_is_file_lru()
      mm/swap: use helper is_swap_pte() in swap_vma_readahead
      mm/swap: use helper macro __ATTR_RW
      mm/swap: fold __swap_info_get() into its sole caller
      mm/swap: remove unneeded return value of free_swap_slot
      mm/swap: print bad swap offset entry in get_swap_device
      mm/swap: remove buggy cache->nr check in refill_swap_slots_cache
      mm/swap: remove unneeded p != NULL check in __swap_duplicate
      mm/swap: make page_swapcount and __lru_add_drain_all static
      mm/swap: avoid calling swp_swap_info when try to check SWP_STABLE_WRITES
      mm/swap: add helper swap_offset_available()
      mm/swap: fix the obsolete comment for SWP_TYPE_SHIFT
      mm/swap: clean up the comment of find_next_to_unuse
      mm/swap: fix the comment of get_kernel_pages
      mm/swap: fix comment about swap extent

Mina Almasry (1):
      hugetlbfs: fix hugetlbfs_statfs() locking

Minchan Kim (1):
      mm: don't be stuck to rmap lock on reclaim path

Muchun Song (16):
      mm: hugetlb_vmemmap: introduce ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP
      arm64: mm: hugetlb: enable HUGETLB_PAGE_FREE_VMEMMAP for arm64
      mm: rmap: fix cache flush on THP pages
      dax: fix cache flush on PMD-mapped pages
      mm: rmap: introduce pfn_mkclean_range() to cleans PTEs
      mm: pvmw: add support for walking devmap pages
      dax: fix missing writeprotect the pte entry
      mm: simplify follow_invalidate_pte()
      mm: hugetlb_vmemmap: cleanup hugetlb_vmemmap related functions
      mm: hugetlb_vmemmap: cleanup hugetlb_free_vmemmap_enabled*
      mm: hugetlb_vmemmap: cleanup CONFIG_HUGETLB_PAGE_FREE_VMEMMAP*
      mm: hugetlb_vmemmap: disable hugetlb_optimize_vmemmap when struct page crosses page boundaries
      mm: memory_hotplug: override memmap_on_memory when hugetlb_free_vmemmap=on
      mm: hugetlb_vmemmap: use kstrtobool for hugetlb_vmemmap param parsing
      mm: hugetlb_vmemmap: add hugetlb_optimize_vmemmap sysctl
      MAINTAINERS: add Muchun as co-maintainer for HugeTLB

Muhammad Usama Anjum (2):
      selftests: vm: bring common functions to a new file
      selftests: vm: add migration to the .gitignore

Nadav Amit (3):
      mm/mprotect: use mmu_gather
      mm/mprotect: do not flush when not required architecturally
      mm: avoid unnecessary flush on change_huge_pmd()

Naoya Horiguchi (3):
      mm/hwpoison: put page in already hwpoisoned case with MF_COUNT_INCREASED
      Revert "mm/memory-failure.c: fix race with changing page compound again"
      mm, hugetlb, hwpoison: separate branch for free and in-use hugepage

NeilBrown (13):
      mm: create new mm/swap.h header file
      mm: drop swap_dirty_folio
      mm: move responsibility for setting SWP_FS_OPS to ->swap_activate
      mm: reclaim mustn't enter FS for SWP_FS_OPS swap-space
      mm: introduce ->swap_rw and use it for reads from SWP_FS_OPS swap-space
      nfs: rename nfs_direct_IO and use as ->swap_rw
      mm: perform async writes to SWP_FS_OPS swap-space using ->swap_rw
      doc: update documentation for swap_activate and swap_rw
      mm: submit multipage reads for SWP_FS_OPS swap-space
      mm: submit multipage write for SWP_FS_OPS swap-space
      mm: handle THP in swap_*page_fs()
      MM: handle THP in swap_*page_fs() - count_vm_events()
      VFS: add FMODE_CAN_ODIRECT file flag

Niels Dossche (1):
      selftest/vm: test that mremap fails on non-existent vma

Oscar Salvador (1):
      mm: untangle config dependencies for demote-on-reclaim

Patrick Wang (3):
      selftests: vm: check numa_available() before operating "merge_across_nodes" in ksm_tests
      selftests: vm: add "test_hmm.sh" to TEST_FILES
      selftests: vm: add the "settings" file with timeout variable

Peng Liu (4):
      hugetlb: fix wrong use of nr_online_nodes
      hugetlb: fix hugepages_setup when deal with pernode
      hugetlb: fix return value of __setup handlers
      mm: use for_each_online_node and node_online instead of open coding

Peter Collingbourne (2):
      printk: stop including cache.h from printk.h
      mm: make minimum slab alignment a runtime property

Peter Xu (25):
      include/linux/swapops.h: remove stub for non_swap_entry()
      mm: introduce PTE_MARKER swap entry
      mm: teach core mm about pte markers
      mm: check against orig_pte for finish_fault()
      mm/uffd: PTE_MARKER_UFFD_WP
      mm/shmem: take care of UFFDIO_COPY_MODE_WP
      mm/shmem: handle uffd-wp special pte in page fault handler
      mm/shmem: persist uffd-wp bit across zapping for file-backed
      mm/shmem: allow uffd wr-protect none pte for file-backed mem
      mm/shmem: allows file-back mem to be uffd wr-protected on thps
      mm/shmem: handle uffd-wp during fork()
      mm/hugetlb: introduce huge pte version of uffd-wp helpers
      mm/hugetlb: hook page faults for uffd write protection
      mm/hugetlb: take care of UFFDIO_COPY_MODE_WP
      mm/hugetlb: handle UFFDIO_WRITEPROTECT
      mm/hugetlb: handle pte markers in page faults
      mm/hugetlb: allow uffd wr-protect none ptes
      mm/hugetlb: only drop uffd-wp special pte if required
      mm/hugetlb: handle uffd-wp during fork()
      mm/khugepaged: don't recycle vma pgtable if uffd-wp registered
      mm/pagemap: recognize uffd-wp bit for shmem/hugetlbfs
      mm/uffd: enable write protection for shmem & hugetlbfs
      mm: enable PTE markers by default
      selftests/uffd: enable uffd-wp for shmem/hugetlbfs
      mm/uffd: move USERFAULTFD configs into mm/

Qi Zheng (1):
      mm: fix missing handler for __GFP_NOWARN

Randy Dunlap (1):
      zram: fix Kconfig dependency warning

Rei Yamamoto (1):
      mm, compaction: fast_find_migrateblock() should return pfn in the target zone

Rolf Eike Beer (1):
      mm/mmap.c: use mmap_assert_write_locked() instead of open coding it

Roman Gushchin (4):
      kselftests: memcg: update the oom group leaf events test
      kselftests: memcg: speed up the memory.high test
      MAINTAINERS: add corresponding kselftests to cgroup entry
      MAINTAINERS: add corresponding kselftests to memcg entry

Sebastian Andrzej Siewior (1):
      mm/vmalloc: use raw_cpu_ptr() for vmap_block_queue access

SeongJae Park (22):
      mm/damon/core-test: add a kunit test case for ops registration
      mm/damon/core: add a function for damon_operations registration checks
      mm/damon/sysfs: add a file for listing available monitoring ops
      selftets/damon/sysfs: test existence and permission of avail_operations
      Docs/{ABI,admin-guide}/damon: document 'avail_operations' sysfs file
      mm/damon/vaddr: register a damon_operations for fixed virtual address ranges monitoring
      mm/damon/sysfs: support fixed virtual address ranges monitoring
      Docs/{ABI,admin-guide}/damon: update for fixed virtual address ranges monitoring
      mm/damon/core: add a new callback for watermarks checks
      mm/damon/core: finish kdamond as soon as any callback returns an error
      mm/damon/vaddr: generalize damon_va_apply_three_regions()
      mm/damon/vaddr: move 'damon_set_regions()' to core
      mm/damon/vaddr: remove damon_va_apply_three_regions()
      mm/damon/sysfs: prohibit multiple physical address space monitoring targets
      mm/damon/sysfs: move targets setup code to a separated function
      mm/damon/sysfs: reuse damon_set_regions() for regions setting
      mm/damon/sysfs: use enum for 'state' input handling
      mm/damon/sysfs: update schemes stat in the kdamond context
      mm/damon/sysfs: support online inputs update
      Docs/{ABI,admin-guide}/damon: Update for 'state' sysfs file input keyword, 'commit'
      mm/damon/reclaim: support online inputs update
      Docs/admin-guide/mm/damon/reclaim: document 'commit_inputs' parameter

Shakeel Butt (1):
      memcg: introduce per-memcg reclaim interface

Sidhartha Kumar (1):
      tools/testing/selftests/vm/gup_test.c: clarify error statement

Suren Baghdasaryan (1):
      selftests: vm: add process_mrelease tests

Tong Tiangen (6):
      mm: page_table_check: using PxD_SIZE instead of PxD_PAGE_SIZE
      mm: page_table_check: add hooks to public helpers
      mm: remove __HAVE_ARCH_PTEP_CLEAR in pgtable.h
      riscv/mm: enable ARCH_SUPPORTS_PAGE_TABLE_CHECK
      riscv/mm: fix two page table check related issues
      arm64/mm: fix page table check compile error for CONFIG_PGTABLE_LEVELS=2

Vasily Averin (5):
      percpu: improve percpu_alloc_percpu event trace
      tracing: incorrect gfp_t conversion
      tracing: incorrect isolate_mote_t cast in mm_vmscan_lru_isolate
      include/trace/events/mmflags.h: cleanup for "tracing: incorrect gfp_t conversion"
      include/trace/events/percpu.h: cleanup for "percpu: improve percpu_alloc_percpu event trace"

Wan Jiabing (1):
      mm/shmem: remove duplicate include in memory.c

Wang Cheng (1):
      mm/mempolicy: fix uninit-value in mpol_rebind_policy()

Wei Yang (12):
      mm/memcg: mz already removed from rb_tree if not NULL
      mm/memcg: set memcg after css verified and got reference
      mm/memcg: set pos explicitly for reclaim and !reclaim
      mm/memcg: move generation assignment and comparison together
      mm/memcg: non-hierarchical mode is deprecated
      mm/page_alloc: adding same penalty is enough to get round-robin order
      mm/vmscan: reclaim only affects managed_zones
      mm/vmscan: make sure wakeup_kswapd with managed zone
      mm/vmscan: sc->reclaim_idx must be a valid zone index
      mm/vmscan: not necessary to re-init the list for each iteration
      mm/vmscan: filter empty page_list at the beginning
      mm/vmscan: don't use NUMA_NO_NODE as indicator of page on different node

Wonhyuk Yang (2):
      mm/page_alloc: cache the result of node_dirty_ok()
      mm/page_alloc: fix tracepoint mm_page_alloc_zone_locked()

Xianting Tian (1):
      fs/proc/task_mmu.c: remove redundant page validation of pte_page

Xiaomeng Tong (1):
      damon: vaddr-test: tweak code to make the logic clearer

Yang Shi (8):
      sched: coredump.h: clarify the use of MMF_VM_HUGEPAGE
      mm: khugepaged: remove redundant check for VM_NO_KHUGEPAGED
      mm: khugepaged: skip DAX vma
      mm: thp: only regular file could be THP eligible
      mm: khugepaged: make khugepaged_enter() void function
      mm: khugepaged: make hugepage_vma_check() non-static
      mm: khugepaged: introduce khugepaged_enter_vma() helper
      mm: mmap: register suitable readonly file vmas for khugepaged

Yang Yang (1):
      mm/vmstat: add events for ksm cow

Yixuan Cao (3):
      tools/vm/page_owner_sort.c: provide allocator labelling and update --cull and --sort options
      tools/vm/page_owner_sort.c: avoid repeated judgments
      mm/vmalloc: fix a comment

Yosry Ahmed (3):
      selftests: cgroup: return -errno from cg_read()/cg_write() on failure
      selftests: cgroup: fix alloc_anon_noexit() instantly freeing memory
      selftests: cgroup: add a selftest for memory.reclaim

Yu Zhe (1):
      mm/damon: remove unnecessary type castings

Yury Norov (2):
      vmap(): don't allow invalid pages
      mm/gup: fix comments to pin_user_pages_*()

Zi Yan (9):
      mm: page_alloc: simplify pageblock migratetype check in __free_one_page()
      mm: wrap __find_buddy_pfn() with a necessary buddy page validation
      mm: page_isolation: move has_unmovable_pages() to mm/page_isolation.c
      mm: page_isolation: check specified range for unmovable pages
      mm: make alloc_contig_range work at pageblock granularity
      mm: page_isolation: enable arbitrary range page isolation.
      mm: cma: use pageblock_order as the single alignment
      drivers: virtio_mem: use pageblock size as the minimum virtio_mem size.
      mm: fix a potential infinite loop in start_isolate_page_range()

Zqiang (1):
      kasan: fix sleeping function called from invalid context on RT kernel

huangshaobo (1):
      kfence: enable check kfence canary on panic via boot param

liqiong (1):
      mm/memory-failure.c: remove unnecessary (void*) conversions

liusongtang (1):
      mm/memory_hotplug: use pgprot_val to get value of pgprot

xu xin (2):
      ksm: count ksm merging pages for each process
      mm/khugepaged: use vma_is_anonymous

zhenwei pi (5):
      mm/memory-failure.c: move clear_hwpoisoned_pages
      mm/memory-failure.c: simplify num_poisoned_pages_dec
      mm/memory-failure.c: add hwpoison_filter for soft offline
      mm/hwpoison: disable hwpoison filter during removing
      mm/memory-failure.c: simplify num_poisoned_pages_inc/dec

 Documentation/ABI/testing/sysfs-kernel-mm-damon   |  25 +-
 Documentation/admin-guide/blockdev/zram.rst       |   5 +
 Documentation/admin-guide/cgroup-v2.rst           |  49 ++
 Documentation/admin-guide/kernel-parameters.txt   |  10 +-
 Documentation/admin-guide/mm/damon/reclaim.rst    |  11 +
 Documentation/admin-guide/mm/damon/usage.rst      |  41 +-
 Documentation/admin-guide/mm/hugetlbpage.rst      |   2 +-
 Documentation/admin-guide/mm/ksm.rst              |  18 +
 Documentation/admin-guide/sysctl/vm.rst           |  48 ++
 Documentation/dev-tools/kasan.rst                 | 228 +++++----
 Documentation/filesystems/locking.rst             |  18 +-
 Documentation/filesystems/proc.rst                | 154 +++---
 Documentation/filesystems/vfs.rst                 |  17 +-
 Documentation/vm/highmem.rst                      | 100 ++--
 Documentation/vm/index.rst                        |   1 +
 Documentation/vm/page_owner.rst                   |  45 +-
 Documentation/vm/vmemmap_dedup.rst                | 223 +++++++++
 MAINTAINERS                                       |   9 +-
 arch/alpha/include/asm/page.h                     |   2 +-
 arch/arm64/Kconfig                                |   3 +
 arch/arm64/include/asm/cache.h                    |  17 +-
 arch/arm64/include/asm/hugetlb.h                  |   4 +-
 arch/arm64/include/asm/mman.h                     |  24 -
 arch/arm64/include/asm/mte-kasan.h                |   1 +
 arch/arm64/include/asm/percpu.h                   |   1 +
 arch/arm64/include/asm/pgtable-prot.h             |   1 +
 arch/arm64/include/asm/pgtable.h                  |  91 +++-
 arch/arm64/mm/flush.c                             |  14 +
 arch/arm64/mm/hugetlbpage.c                       |  12 +-
 arch/arm64/mm/mmap.c                              |  25 +
 arch/csky/include/asm/processor.h                 |   2 +-
 arch/ia64/include/asm/hugetlb.h                   |   5 +-
 arch/ia64/kernel/uncached.c                       |   2 +-
 arch/mips/include/asm/hugetlb.h                   |   9 +-
 arch/parisc/include/asm/hugetlb.h                 |   5 +-
 arch/powerpc/Kconfig                              |   1 +
 arch/powerpc/include/asm/book3s/64/pgtable.h      |  31 +-
 arch/powerpc/include/asm/hugetlb.h                |   9 +-
 arch/powerpc/include/asm/mman.h                   |  12 -
 arch/powerpc/mm/book3s64/pgtable.c                |  17 +
 arch/riscv/Kconfig                                |   1 +
 arch/riscv/include/asm/pgtable-64.h               |   5 +
 arch/riscv/include/asm/pgtable.h                  |  66 ++-
 arch/s390/include/asm/hugetlb.h                   |  26 +-
 arch/s390/include/asm/pgtable.h                   |  36 +-
 arch/sh/include/asm/hugetlb.h                     |   5 +-
 arch/sparc/Kconfig                                |   1 +
 arch/sparc/include/asm/hugetlb.h                  |   5 +-
 arch/sparc/include/asm/mman.h                     |   6 -
 arch/sparc/mm/init_64.c                           |  12 +
 arch/x86/Kconfig                                  |   3 +-
 arch/x86/include/asm/pgtable.h                    |  54 +-
 arch/x86/include/asm/pgtable_64.h                 |   4 +-
 arch/x86/include/asm/pgtable_64_types.h           |   5 +
 arch/x86/include/asm/pgtable_types.h              |   2 +
 arch/x86/include/asm/tlbflush.h                   |  97 ++++
 arch/x86/include/uapi/asm/mman.h                  |  14 -
 arch/x86/mm/Makefile                              |   2 +-
 arch/x86/mm/init_64.c                             |   2 +-
 arch/x86/mm/pgprot.c                              |  35 ++
 arch/x86/mm/pgtable.c                             |  13 +-
 drivers/base/memory.c                             |   5 +-
 drivers/base/node.c                               |   1 +
 drivers/block/loop.c                              |   4 +-
 drivers/block/zram/Kconfig                        |   3 +-
 drivers/block/zram/zram_drv.c                     |  52 +-
 drivers/block/zram/zram_drv.h                     |   1 -
 drivers/firmware/smccc/kvm_guest.c                |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c |   2 +-
 drivers/gpu/drm/ttm/ttm_bo_vm.c                   |   2 +-
 drivers/virtio/virtio_mem.c                       |   6 +-
 fs/Kconfig                                        |  22 +-
 fs/cifs/file.c                                    |   7 +-
 fs/dax.c                                          |  98 +---
 fs/exec.c                                         |   6 +-
 fs/fcntl.c                                        |   9 +-
 fs/hugetlbfs/inode.c                              |  19 +-
 fs/nfs/direct.c                                   |  23 +-
 fs/nfs/file.c                                     |  18 +-
 fs/open.c                                         |   9 +-
 fs/overlayfs/file.c                               |  13 +-
 fs/proc/base.c                                    |  22 +
 fs/proc/meminfo.c                                 |   7 +
 fs/proc/task_mmu.c                                |   9 +-
 fs/userfaultfd.c                                  |  32 +-
 include/asm-generic/hugetlb.h                     |  28 +-
 include/asm-generic/pgtable-nopmd.h               |   2 +
 include/asm-generic/tlb.h                         |  14 +
 include/linux/cma.h                               |   4 +-
 include/linux/compaction.h                        |   5 +-
 include/linux/damon.h                             |  14 +
 include/linux/fault-inject.h                      |   2 +
 include/linux/fs.h                                |   9 +
 include/linux/gfp.h                               |  20 +-
 include/linux/highmem-internal.h                  |  18 +-
 include/linux/highmem.h                           |  53 +-
 include/linux/huge_mm.h                           |  20 +-
 include/linux/hugetlb.h                           |  42 +-
 include/linux/kasan.h                             |   8 +-
 include/linux/khugepaged.h                        |  44 +-
 include/linux/ksm.h                               |   4 +-
 include/linux/memcontrol.h                        |  72 ++-
 include/linux/memory_hotplug.h                    |  14 +-
 include/linux/migrate.h                           |  39 +-
 include/linux/mm.h                                |  70 ++-
 include/linux/mm_inline.h                         |  43 ++
 include/linux/mm_types.h                          |  20 +
 include/linux/mman.h                              |   4 -
 include/linux/mmzone.h                            |   5 +-
 include/linux/nfs_fs.h                            |   2 +-
 include/linux/nodemask.h                          |  13 +-
 include/linux/page-flags.h                        |  62 ++-
 include/linux/page-isolation.h                    |   6 +-
 include/linux/pgtable.h                           |  84 +++-
 include/linux/printk.h                            |   1 -
 include/linux/rmap.h                              | 149 +++++-
 include/linux/sched/coredump.h                    |   3 +-
 include/linux/shmem_fs.h                          |   6 +-
 include/linux/slab.h                              |  12 +
 include/linux/swap.h                              | 191 ++-----
 include/linux/swap_slots.h                        |   2 +-
 include/linux/swapops.h                           | 124 ++++-
 include/linux/userfaultfd_k.h                     |  84 ++++
 include/linux/vm_event_item.h                     |   7 +
 include/linux/writeback.h                         |   7 +
 include/ras/ras_event.h                           |   1 -
 include/trace/events/btrfs.h                      |   4 +-
 include/trace/events/compaction.h                 |   4 +-
 include/trace/events/kmem.h                       |  26 +-
 include/trace/events/mmflags.h                    |  84 ++--
 include/trace/events/percpu.h                     |  23 +-
 include/trace/events/vmscan.h                     |  20 +-
 include/uapi/linux/userfaultfd.h                  |  10 +-
 init/Kconfig                                      | 140 ------
 kernel/bpf/bpf_lru_list.h                         |   1 +
 kernel/events/uprobes.c                           |   2 +-
 kernel/fork.c                                     |   4 +-
 lib/Kconfig.kasan                                 | 168 +++----
 lib/fault-inject.c                                |   3 +
 lib/kstrtox.c                                     |   6 +-
 mm/Kconfig                                        | 577 ++++++++++++++--------
 mm/Makefile                                       |   2 +-
 mm/compaction.c                                   |  93 ++--
 mm/damon/core-test.h                              |  36 ++
 mm/damon/core.c                                   | 115 ++++-
 mm/damon/ops-common.c                             |   3 +-
 mm/damon/paddr.c                                  |   2 +-
 mm/damon/reclaim.c                                | 124 +++--
 mm/damon/sysfs.c                                  | 406 ++++++++++++---
 mm/damon/vaddr-test.h                             |  14 +-
 mm/damon/vaddr.c                                  |  90 +---
 mm/debug_vm_pgtable.c                             |  46 +-
 mm/failslab.c                                     |   3 +
 mm/filemap.c                                      |   5 +
 mm/gup.c                                          | 127 ++++-
 mm/hmm.c                                          |   2 +-
 mm/huge_memory.c                                  | 177 +++++--
 mm/hugetlb.c                                      | 428 +++++++++++-----
 mm/hugetlb_vmemmap.c                              | 323 +++++-------
 mm/hugetlb_vmemmap.h                              |  24 +-
 mm/hwpoison-inject.c                              |   1 +
 mm/internal.h                                     | 177 +++++--
 mm/kasan/common.c                                 |  12 +-
 mm/kasan/generic.c                                |   6 +-
 mm/kasan/kasan.h                                  |  92 ++--
 mm/kasan/quarantine.c                             |  54 +-
 mm/kasan/report_generic.c                         |   8 +-
 mm/kfence/core.c                                  |  40 +-
 mm/kfence/kfence_test.c                           |   5 +-
 mm/khugepaged.c                                   |  81 +--
 mm/ksm.c                                          |  35 +-
 mm/madvise.c                                      |  17 +-
 mm/memcontrol.c                                   | 329 ++++++++++--
 mm/memory-failure.c                               | 126 ++---
 mm/memory.c                                       | 573 ++++++++++++++-------
 mm/memory_hotplug.c                               |  35 +-
 mm/mempolicy.c                                    |  74 +--
 mm/memremap.c                                     |  10 +
 mm/migrate.c                                      | 194 ++++----
 mm/migrate_device.c                               |  23 +-
 mm/mincore.c                                      |   4 +-
 mm/mmap.c                                         |  67 +--
 mm/mmu_gather.c                                   |  16 +-
 mm/mprotect.c                                     | 176 +++++--
 mm/mremap.c                                       |  16 +-
 mm/page-writeback.c                               |  17 +-
 mm/page_alloc.c                                   | 375 +++++---------
 mm/page_ext.c                                     |   2 +-
 mm/page_idle.c                                    |   7 +-
 mm/page_io.c                                      | 253 +++++++---
 mm/page_isolation.c                               | 391 ++++++++++++++-
 mm/page_owner.c                                   |   4 +-
 mm/page_table_check.c                             |  25 +-
 mm/page_vma_mapped.c                              |  17 +-
 mm/percpu-internal.h                              |   8 +-
 mm/percpu.c                                       |   5 +-
 mm/pgtable-generic.c                              |   8 +
 mm/rmap.c                                         | 409 ++++++++++-----
 mm/shmem.c                                        | 353 +++++++------
 mm/slab.c                                         |   7 +-
 mm/slab_common.c                                  |   3 +-
 mm/slob.c                                         |  16 +-
 mm/sparse-vmemmap.c                               | 176 ++++++-
 mm/sparse.c                                       |  53 +-
 mm/swap.c                                         |  10 +-
 mm/swap.h                                         | 157 ++++++
 mm/swap_slots.c                                   |  20 +-
 mm/swap_state.c                                   |  90 ++--
 mm/swapfile.c                                     | 135 ++---
 mm/userfaultfd.c                                  |  62 ++-
 mm/util.c                                         |   1 +
 mm/vmalloc.c                                      |  18 +-
 mm/vmscan.c                                       | 476 +++++++++---------
 mm/vmstat.c                                       |   9 +-
 mm/z3fold.c                                       |  64 +--
 mm/zswap.c                                        |  52 +-
 tools/testing/selftests/cgroup/cgroup_util.c      |  56 ++-
 tools/testing/selftests/cgroup/cgroup_util.h      |   1 +
 tools/testing/selftests/cgroup/test_memcontrol.c  | 199 ++++++--
 tools/testing/selftests/damon/sysfs.sh            |   1 +
 tools/testing/selftests/vm/.gitignore             |   3 +
 tools/testing/selftests/vm/Makefile               |  14 +-
 tools/testing/selftests/vm/config                 |   2 +
 tools/testing/selftests/vm/gup_test.c             |  24 +-
 tools/testing/selftests/vm/hugepage-mremap.c      |   6 +
 tools/testing/selftests/vm/ksm_tests.c            |   9 +-
 tools/testing/selftests/vm/madv_populate.c        |  34 +-
 tools/testing/selftests/vm/migration.c            | 193 ++++++++
 tools/testing/selftests/vm/mrelease_test.c        | 200 ++++++++
 tools/testing/selftests/vm/protection_keys.c      |   2 +-
 tools/testing/selftests/vm/run_vmtests.sh         | 525 ++++----------------
 tools/testing/selftests/vm/settings               |   1 +
 tools/testing/selftests/vm/soft-dirty.c           | 145 ++++++
 tools/testing/selftests/vm/split_huge_page_test.c |  79 +--
 tools/testing/selftests/vm/userfaultfd.c          |  13 +-
 tools/testing/selftests/vm/vm_util.c              | 108 ++++
 tools/testing/selftests/vm/vm_util.h              |   9 +
 tools/vm/page-types.c                             |   8 +-
 tools/vm/page_owner_sort.c                        | 386 ++++++++++++---
 240 files changed, 9207 insertions(+), 4664 deletions(-)
 create mode 100644 Documentation/vm/vmemmap_dedup.rst
 create mode 100644 arch/x86/mm/pgprot.c
 create mode 100644 mm/swap.h
 create mode 100644 tools/testing/selftests/vm/migration.c
 create mode 100644 tools/testing/selftests/vm/mrelease_test.c
 create mode 100644 tools/testing/selftests/vm/settings
 create mode 100644 tools/testing/selftests/vm/soft-dirty.c
 create mode 100644 tools/testing/selftests/vm/vm_util.c
 create mode 100644 tools/testing/selftests/vm/vm_util.h


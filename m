Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5FA4EB145
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239173AbiC2QGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 12:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239165AbiC2QGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:06:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27945554A9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648569893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gRGcsaICsPApO29gf0I7vkSWx3FLisU3esnKbbQUc9M=;
        b=P7Xsyh1eo90qISYXBwzd9nCDcyT6yjqjfBcE6pZDS7auAEeiAsAgK8SPn/BX0VFnOHdy1y
        SkI8WIvaDAlWdNRuQliFU+gimur3Lb1/XRvORuNTECW3SmBdi2vC3wyGaEtBp0JW+qqeY8
        GFTtuqiB2VpY7Nc0esZtco3SNp5qFq4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-576-uNknl0MpN5K24b4DMZT5ww-1; Tue, 29 Mar 2022 12:04:49 -0400
X-MC-Unique: uNknl0MpN5K24b4DMZT5ww-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55763100BAB2;
        Tue, 29 Mar 2022 16:04:48 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.134])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7948E401E2A;
        Tue, 29 Mar 2022 16:04:41 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Khalid Aziz <khalid.aziz@oracle.com>
Subject: [PATCH v3 00/16] mm: COW fixes part 2: reliable GUP pins of anonymous pages
Date:   Tue, 29 Mar 2022 18:04:24 +0200
Message-Id: <20220329160440.193848-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is the result of the discussion on the previous approach [2].
More information on the general COW issues can be found there. It is based
on latest linus/master (post v5.17, with relevant core-MM changes for
v5.18-rc1).

v3 is located at:
	https://github.com/davidhildenbrand/linux/tree/cow_fixes_part_2_v3


This series fixes memory corruptions when a GUP pin (FOLL_PIN) was taken
on an anonymous page and COW logic fails to detect exclusivity of the page
to then replacing the anonymous page by a copy in the page table: The
GUP pin lost synchronicity with the pages mapped into the page tables.

This issue, including other related COW issues, has been summarized in [3]
under 3):
"
  3. Intra Process Memory Corruptions due to Wrong COW (FOLL_PIN)

  page_maybe_dma_pinned() is used to check if a page may be pinned for
  DMA (using FOLL_PIN instead of FOLL_GET). While false positives are
  tolerable, false negatives are problematic: pages that are pinned for
  DMA must not be added to the swapcache. If it happens, the (now pinned)
  page could be faulted back from the swapcache into page tables
  read-only. Future write-access would detect the pinning and COW the
  page, losing synchronicity. For the interested reader, this is nicely
  documented in feb889fb40fa ("mm: don't put pinned pages into the swap
  cache").

  Peter reports [8] that page_maybe_dma_pinned() as used is racy in some
  cases and can result in a violation of the documented semantics:
  giving false negatives because of the race.

  There are cases where we call it without properly taking a per-process
  sequence lock, turning the usage of page_maybe_dma_pinned() racy. While
  one case (clear_refs SOFTDIRTY tracking, see below) seems to be easy to
  handle, there is especially one rmap case (shrink_page_list) that's hard
  to fix: in the rmap world, we're not limited to a single process.

  The shrink_page_list() issue is really subtle. If we race with
  someone pinning a page, we can trigger the same issue as in the FOLL_GET
  case. See the detail section at the end of this mail on a discussion how
  bad this can bite us with VFIO or other FOLL_PIN user.

  It's harder to reproduce, but I managed to modify the O_DIRECT
  reproducer to use io_uring fixed buffers [15] instead, which ends up
  using FOLL_PIN | FOLL_WRITE | FOLL_LONGTERM to pin buffer pages and can
  similarly trigger a loss of synchronicity and consequently a memory
  corruption.

  Again, the root issue is that a write-fault on a page that has
  additional references results in a COW and thereby a loss of
  synchronicity and consequently a memory corruption if two parties
  believe they are referencing the same page.
"

This series makes GUP pins (R/O and R/W) on anonymous pages fully reliable,
especially also taking care of concurrent pinning via GUP-fast,
for example, also fully fixing an issue reported regarding NUMA
balancing [4] recently. While doing that, it further reduces "unnecessary
COWs", especially when we don't fork()/KSM and don't swapout, and fixes the
COW security for hugetlb for FOLL_PIN.

In summary, we track via a pageflag (PG_anon_exclusive) whether a mapped
anonymous page is exclusive. Exclusive anonymous pages that are mapped
R/O can directly be mapped R/W by the COW logic in the write fault handler.
Exclusive anonymous pages that want to be shared (fork(), KSM) first have
to be marked shared -- which will fail if there are GUP pins on the page.
GUP is only allowed to take a pin on anonymous pages that are exclusive.
The PT lock is the primary mechanism to synchronize modifications of
PG_anon_exclusive. We synchronize against GUP-fast either via the
src_mm->write_protect_seq (during fork()) or via clear/invalidate+flush of
the relevant page table entry.

Special care has to be taken about swap, migration, and THPs (whereby a
PMD-mapping can be converted to a PTE mapping and we have to track
information for subpages). Besides these, we let the rmap code handle most
magic. For reliable R/O pins of anonymous pages, we need FAULT_FLAG_UNSHARE
logic as part of our previous approach [2], however, it's now 100% mapcount
free and I further simplified it a bit.

  #1 is a fix
  #3-#10 are mostly rmap preparations for PG_anon_exclusive handling
  #11 introduces PG_anon_exclusive
  #12 uses PG_anon_exclusive and make R/W pins of anonymous pages
   reliable
  #13 is a preparation for reliable R/O pins
  #14 and #15 is reused/modified GUP-triggered unsharing for R/O GUP pins
   make R/O pins of anonymous pages reliable
  #16 adds sanity check when (un)pinning anonymous pages


[1] https://lkml.kernel.org/r/20220131162940.210846-1-david@redhat.com
[2] https://lkml.kernel.org/r/20211217113049.23850-1-david@redhat.com
[3] https://lore.kernel.org/r/3ae33b08-d9ef-f846-56fb-645e3b9b4c66@redhat.com
[4] https://bugzilla.kernel.org/show_bug.cgi?id=215616


v2 -> v3:
* Note 1: Left the terminology "unshare" in place for now instead of
  switching to "make anon exclusive".
* Note 2: We might have to tackle undoing effects of arch_unmap_one() on
  sparc, to free some tag memory immediately instead of when tearing down
  the vma/mm; looks like this needs more care either way, so I'll ignore it
  for now.
* Rebased on top of core MM changes for v5.18-rc1 (most conflicts were due
  to folio and ZONE_DEVICE migration rework). No severe changes were
  necessary -- mostly folio conversion and code movement.
* Retested on aarch64, ppc64, s390x and x86_64
* "mm/rmap: convert RMAP flags to a proper distinct rmap_t type"
  -> Missed to convert one instance in restore_exclusive_pte()
* "mm/rmap: pass rmap flags to hugepage_add_anon_rmap()"
  -> Use "!!(flags & RMAP_EXCLUSIVE)" to avoid sparse warnings
* "mm/huge_memory: remove outdated VM_WARN_ON_ONCE_PAGE from unmap_page()"
  -> Added, as we can trigger that now more frequently
* "mm: remember exclusively mapped anonymous pages with PG_anon_exclusive"
  -> Use subpage in VM_BUG_ON_PAGE() in try_to_migrate_one()
  -> Move comment from folio_migrate_mapping() to folio_migrate_flags()
     regarding PG_anon_exclusive/PG_mappedtodisk
  -> s/int rmap_flags/rmap_t rmap_flags/ in remove_migration_pmd()
* "mm/gup: sanity-check with CONFIG_DEBUG_VM that anonymous pages are
   exclusive when (un)pinning"
  -> Use IS_ENABLED(CONFIG_DEBUG_VM) instead of ifdef

v1 -> v2:
* Tested on aarch64, ppc64, s390x and x86_64
* "mm/page-flags: reuse PG_mappedtodisk as PG_anon_exclusive for PageAnon()
   pages"
  -> Use PG_mappedtodisk instead of PG_slab (thanks Willy!), this simlifies
     the patch and necessary handling a lot. Add safety BUG_ON's
  -> Move most documentation to the patch description, to be placed in a
     proper documentation doc in the future, once everything's in place
* ""mm: remember exclusively mapped anonymous pages with PG_anon_exclusive
  -> Skip check+clearing in page_try_dup_anon_rmap(), otherwise we might
     trigger a wrong VM_BUG_ON() for KSM pages in ClearPageAnonExclusive()
  -> In __split_huge_pmd_locked(), call page_try_share_anon_rmap() only
     for "anon_exclusive", otherwise we might trigger a wrong VM_BUG_ON()
  -> In __split_huge_page_tail(), drop any remaining PG_anon_exclusive on
     tail pages, and document why that is fine

RFC -> v1:
* Rephrased/extended some patch descriptions+comments
* Tested on aarch64, ppc64 and x86_64
* "mm/rmap: convert RMAP flags to a proper distinct rmap_t type"
 -> Added
* "mm/rmap: drop "compound" parameter from page_add_new_anon_rmap()"
 -> Added
* "mm: remember exclusively mapped anonymous pages with PG_anon_exclusive"
 -> Fixed __do_huge_pmd_anonymous_page() to recheck after temporarily
    dropping the PT lock.
 -> Use "reuse" label in __do_huge_pmd_anonymous_page()
 -> Slightly simplify logic in hugetlb_cow()
 -> In remove_migration_pte(), remove unrelated changes around
    page_remove_rmap()
* "mm: support GUP-triggered unsharing of anonymous pages"
 -> In handle_pte_fault(), trigger pte_mkdirty() only with
    FAULT_FLAG_WRITE
 -> In __handle_mm_fault(), extend comment regarding anonymous PUDs
* "mm/gup: trigger FAULT_FLAG_UNSHARE when R/O-pinning a possibly shared
   anonymous page"
   -> Added unsharing logic to gup_hugepte() and gup_huge_pud()
   -> Changed return logic in __follow_hugetlb_must_fault(), making sure
      that "unshare" is always set
* "mm/gup: sanity-check with CONFIG_DEBUG_VM that anonymous pages are
   exclusive when (un)pinning"
  -> Slightly simplified sanity_check_pinned_pages()

David Hildenbrand (16):
  mm/rmap: fix missing swap_free() in try_to_unmap() after
    arch_unmap_one() failed
  mm/hugetlb: take src_mm->write_protect_seq in
    copy_hugetlb_page_range()
  mm/memory: slightly simplify copy_present_pte()
  mm/rmap: split page_dup_rmap() into page_dup_file_rmap() and
    page_try_dup_anon_rmap()
  mm/rmap: convert RMAP flags to a proper distinct rmap_t type
  mm/rmap: remove do_page_add_anon_rmap()
  mm/rmap: pass rmap flags to hugepage_add_anon_rmap()
  mm/rmap: drop "compound" parameter from page_add_new_anon_rmap()
  mm/rmap: use page_move_anon_rmap() when reusing a mapped PageAnon()
    page exclusively
  mm/huge_memory: remove outdated VM_WARN_ON_ONCE_PAGE from unmap_page()
  mm/page-flags: reuse PG_mappedtodisk as PG_anon_exclusive for
    PageAnon() pages
  mm: remember exclusively mapped anonymous pages with PG_anon_exclusive
  mm/gup: disallow follow_page(FOLL_PIN)
  mm: support GUP-triggered unsharing of anonymous pages
  mm/gup: trigger FAULT_FLAG_UNSHARE when R/O-pinning a possibly shared
    anonymous page
  mm/gup: sanity-check with CONFIG_DEBUG_VM that anonymous pages are
    exclusive when (un)pinning

 include/linux/mm.h         |  46 +++++++-
 include/linux/mm_types.h   |   8 ++
 include/linux/page-flags.h |  39 ++++++-
 include/linux/rmap.h       | 118 +++++++++++++++++--
 include/linux/swap.h       |  15 ++-
 include/linux/swapops.h    |  25 ++++
 kernel/events/uprobes.c    |   2 +-
 mm/gup.c                   | 106 ++++++++++++++++-
 mm/huge_memory.c           | 127 +++++++++++++++-----
 mm/hugetlb.c               | 135 ++++++++++++++-------
 mm/khugepaged.c            |   2 +-
 mm/ksm.c                   |  15 ++-
 mm/memory.c                | 234 +++++++++++++++++++++++--------------
 mm/memremap.c              |   9 ++
 mm/migrate.c               |  18 ++-
 mm/migrate_device.c        |  23 +++-
 mm/mprotect.c              |   8 +-
 mm/rmap.c                  |  97 +++++++++++----
 mm/swapfile.c              |   8 +-
 mm/userfaultfd.c           |   2 +-
 tools/vm/page-types.c      |   8 +-
 21 files changed, 825 insertions(+), 220 deletions(-)


base-commit: 1930a6e739c4b4a654a69164dbe39e554d228915
-- 
2.35.1


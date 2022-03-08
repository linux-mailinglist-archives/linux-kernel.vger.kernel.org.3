Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365084D1A28
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 15:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347392AbiCHOPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 09:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347377AbiCHOPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 09:15:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A93F94B1C5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 06:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646748893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cJl1M26B2u6OmUR1MUosbFk04JY52sbQY2FRAuiClCo=;
        b=es71nRGovlDv7vQmYBgweY0tAIFwpuceOSb0XgeRZeiwtjaS48oqx1JcU/D2g9y2hu2xOA
        00Uk7/p/uOkxLzahjBrCXEmI4P2wbrwr8I2GKU9C3nAC6XObav4nlCXvNiunzEC9CVyTBu
        DI6AN7B9mP+giej7khLVPmMpAMO5FAA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-8PscRXB-NoSAb9r9df9-Ow-1; Tue, 08 Mar 2022 09:14:50 -0500
X-MC-Unique: 8PscRXB-NoSAb9r9df9-Ow-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 398F61854E21;
        Tue,  8 Mar 2022 14:14:46 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.195.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F3DD7886F;
        Tue,  8 Mar 2022 14:14:38 +0000 (UTC)
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
Subject: [PATCH v1 00/15] mm: COW fixes part 2: reliable GUP pins of anonymous pages
Date:   Tue,  8 Mar 2022 15:14:22 +0100
Message-Id: <20220308141437.144919-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is the result of the discussion on the previous approach [2].
More information on the general COW issues can be found there. It is based
on v5.17-rc7 and [1], which resides in -mm and -next:
	[PATCH v3 0/9] mm: COW fixes part 1: fix the COW security issue for
	THP and swap

v1 is located at:
	https://github.com/davidhildenbrand/linux/tree/cow_fixes_part_2_v1

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
to mark a mapped anonymous page shared -- which will fail if there are
GUP pins on the page. GUP is only allowed to take a pin on anonymous pages
that is exclusive. The PT lock is the primary mechanism to synchronize
modifications of PG_anon_exclusive. GUP-fast is synchronized either via the
src_mm->write_protect_seq or via clear/invalidate+flush of the relevant
page table entry.

Special care has to be taken about swap, migration, and THPs (whereby a
PMD-mapping can be converted to a PTE mapping and we have to track
information for subpages). Besides these, we let the rmap code handle most
magic. For reliable R/O pins of anonymous pages, we need FAULT_FLAG_UNSHARE
logic as part of our previous approach [2], however, it's now 100% mapcount
free and I further simplified it a bit.

  #1 is a fix
  #3-#9 are mostly rmap preparations for PG_anon_exclusive handling
  #10 introduces PG_anon_exclusive
  #11 uses PG_anon_exclusive and make R/W pins of anonymous pages
   reliable
  #12 is a preparation for reliable R/O pins
  #13 and #14 is reused/modified GUP-triggered unsharing for R/O GUP pins
   make R/O pins of anonymous pages reliable
  #15 adds sanity check when (un)pinning anonymous pages

I'm not proud about patch #10, suggestions welcome. Patch #11 contains
excessive explanations and the main logic for R/W pins. #12 and #13
resemble what we proposed in the previous approach [2]. I consider the
general approach of #15 very nice and helpful, and I remember Linus even
envisioning something like that for finding BUGs, although we might want to
implement the sanity checks eventually differently

It passes my growing set of tests for "wrong COW" and "missed COW",
including the ones in [3] -- I'd really appreciate some experienced eyes
to take a close look at corner cases.

I'm planning on sending a part 3 that will remember PG_anon_exclusive for
ordinary swap entries: this will make FOLL_GET | FOLL_WRITE references
reliable and fix the memory corruptions for O_DIRECT -- as described in
[3] under 2) -- as well, as long as there is no fork().

The long term goal should be to convert relevant users of FOLL_GET to
FOLL_PIN, however, with part3 it wouldn't be required to fix the obvious
memory corruptions we are aware of. Once that's in place we can streamline
our COW logic for hugetlb to rely on page_count() as well and fix any
possible COW security issues.

[1] https://lkml.kernel.org/r/20220131162940.210846-1-david@redhat.com
[2] https://lkml.kernel.org/r/20211217113049.23850-1-david@redhat.com
[3] https://lore.kernel.org/r/3ae33b08-d9ef-f846-56fb-645e3b9b4c66@redhat.com
[4] https://bugzilla.kernel.org/show_bug.cgi?id=215616


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

David Hildenbrand (15):
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
  mm/page-flags: reuse PG_slab as PG_anon_exclusive for PageAnon() pages
  mm: remember exclusively mapped anonymous pages with PG_anon_exclusive
  mm/gup: disallow follow_page(FOLL_PIN)
  mm: support GUP-triggered unsharing of anonymous pages
  mm/gup: trigger FAULT_FLAG_UNSHARE when R/O-pinning a possibly shared
    anonymous page
  mm/gup: sanity-check with CONFIG_DEBUG_VM that anonymous pages are
    exclusive when (un)pinning

 fs/proc/page.c                 |   3 +-
 include/linux/mm.h             |  46 ++++++-
 include/linux/mm_types.h       |   8 ++
 include/linux/page-flags.h     | 124 +++++++++++++++++-
 include/linux/rmap.h           | 109 ++++++++++++++--
 include/linux/swap.h           |  15 ++-
 include/linux/swapops.h        |  25 ++++
 include/trace/events/mmflags.h |   2 +-
 kernel/events/uprobes.c        |   2 +-
 mm/gup.c                       | 103 ++++++++++++++-
 mm/huge_memory.c               | 122 +++++++++++++-----
 mm/hugetlb.c                   | 137 ++++++++++++++------
 mm/khugepaged.c                |   2 +-
 mm/ksm.c                       |  15 ++-
 mm/memory-failure.c            |  24 +++-
 mm/memory.c                    | 221 ++++++++++++++++++++-------------
 mm/memremap.c                  |  11 ++
 mm/migrate.c                   |  40 +++++-
 mm/mprotect.c                  |   8 +-
 mm/page_alloc.c                |  13 ++
 mm/rmap.c                      |  95 ++++++++++----
 mm/swapfile.c                  |   4 +-
 mm/userfaultfd.c               |   2 +-
 23 files changed, 904 insertions(+), 227 deletions(-)

-- 
2.35.1


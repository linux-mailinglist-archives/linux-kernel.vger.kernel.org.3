Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBF14C2BAC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 13:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbiBXM1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 07:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbiBXM1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 07:27:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D58AFF68F0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 04:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645705633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=L9tmzf6xkiy/OZgxsG8syLdqfMDOTNvu60rU9Nxz5Ow=;
        b=ckrGI9n18tfIdti5iltLBGK/bjzAYKZ0TbLB4rS+9/Tlc4nZV9RCdqVoKMD/SHUzjFgpQp
        U1SxGz4PFwhAStCLjGfE8dmYEn/Y0hBDvS1THUm6fO0kGarYZ+9oDS8A3WaUCDdT9jJ9h1
        6j7Q0n9mAdQU08ilGTiRTlLEDC1f8zg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37-WPmpDH2xPzSfDdRxY2HaIA-1; Thu, 24 Feb 2022 07:27:10 -0500
X-MC-Unique: WPmpDH2xPzSfDdRxY2HaIA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3187A804310;
        Thu, 24 Feb 2022 12:27:06 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B3C342634C;
        Thu, 24 Feb 2022 12:26:15 +0000 (UTC)
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
Subject: [PATCH RFC 00/13] mm: COW fixes part 2: reliable GUP pins of anonymous pages
Date:   Thu, 24 Feb 2022 13:26:01 +0100
Message-Id: <20220224122614.94921-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
on [1], which resides in -mm and -next:
	[PATCH v3 0/9] mm: COW fixes part 1: fix the COW security issue for
	THP and swap

I keep the latest state, including some hacky selftest on:
	https://github.com/davidhildenbrand/linux/tree/cow_fixes_part_2

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
  #3-#7 are mostly rmap preparations for PG_anon_exclusive handling
  #8 introduces PG_anon_exclusive
  #9 uses PG_anon_exclusive and make R/W pins of anonymous pages
   reliable
  #10 is a preparation for reliable R/O pins
  #11 and #12 is reused/modified GUP-triggered unsharing for R/O GUP pins
   make R/O pins of anonymous pages reliable
  #13 adds sanity check when (un)pinning anonymous pages

I'm not proud about patch #8, suggestions welcome. Patch #9 contains
excessive explanations and the main logic for R/W pins. #11 and #12
resemble what we proposed in the previous approach [2]. I consider the
general approach of #13 very nice and helpful, and I remember Linus even
envisioning something like that for finding BUGs, although we might want to
implement the sanity checks eventually differently

It passes my growing set of tests for "wrong COW" and "missed COW",
including the ones in [30 -- I'd really appreciate some experienced eyes
to take a close look at corner cases. Only tested on x86_64, testing with
CONT-mapped hugetlb pages on arm64 might be interesting.

Once we converted relevant users of FOLL_GET (e.g., O_DIRECT) to FOLL_PIN,
the issue described in [3] under 2) will be fixed as well. Further, once
that's in place we can streamline our COW logic for hugetlb to rely on
page_count() as well and fix any possible COW security issues.

Don't be scared by the diff stats, it includes a lot of comments and the
PG_anon_exclusive introduction is a bit "code consuming" due to PG_slab.

[1] https://lkml.kernel.org/r/20220131162940.210846-1-david@redhat.com
[2] https://lkml.kernel.org/r/20211217113049.23850-1-david@redhat.com
[3] https://lore.kernel.org/r/3ae33b08-d9ef-f846-56fb-645e3b9b4c66@redhat.com
[4] https://bugzilla.kernel.org/show_bug.cgi?id=215616

David Hildenbrand (13):
  mm/rmap: fix missing swap_free() in try_to_unmap() after
    arch_unmap_one() failed
  mm/hugetlb: take src_mm->write_protect_seq in
    copy_hugetlb_page_range()
  mm/memory: slightly simplify copy_present_pte()
  mm/rmap: split page_dup_rmap() into page_dup_file_rmap() and
    page_try_dup_anon_rmap()
  mm/rmap: remove do_page_add_anon_rmap()
  mm/rmap: pass rmap flags to hugepage_add_anon_rmap()
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
 include/linux/mm.h             |  46 +++++++-
 include/linux/mm_types.h       |   8 ++
 include/linux/page-flags.h     | 124 ++++++++++++++++++++-
 include/linux/rmap.h           |  87 ++++++++++++++-
 include/linux/swap.h           |  15 ++-
 include/linux/swapops.h        |  25 +++++
 include/trace/events/mmflags.h |   2 +-
 mm/gup.c                       |  96 +++++++++++++++-
 mm/huge_memory.c               | 125 ++++++++++++++++-----
 mm/hugetlb.c                   | 133 +++++++++++++++-------
 mm/ksm.c                       |  15 ++-
 mm/memory-failure.c            |  24 +++-
 mm/memory.c                    | 197 ++++++++++++++++++++-------------
 mm/memremap.c                  |  11 ++
 mm/migrate.c                   |  46 ++++++--
 mm/mprotect.c                  |   8 +-
 mm/page_alloc.c                |  13 +++
 mm/rmap.c                      |  75 +++++++++----
 mm/swapfile.c                  |   2 +-
 20 files changed, 849 insertions(+), 206 deletions(-)

-- 
2.35.1


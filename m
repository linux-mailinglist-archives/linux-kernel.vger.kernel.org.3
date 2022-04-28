Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878CD512EAC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344541AbiD1Il3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344532AbiD1Ikq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:40:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E38DFA6E14
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651134893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Pf+knG24vvJIItwhOX6Y7IacvMVYp6hj+Z6yCvvSVGk=;
        b=HeZNLcgCDz1mT/ltDjUOvnhq0xh48UehH4u2PMcQSmLTB0K1ufBbG2JqTOmz52TXWU42XP
        cOlWvfrafZJVHNnOCArKjYRfYtcGl4UEh1mpPJoVgm4L3ZKAnfGxrg29VoXgKzVebOuYun
        EVjNwg5y0dU55pgfkytEvaQK1+Y5D7w=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-38-TpMmYNGRM8-uO01k_f2yqg-1; Thu, 28 Apr 2022 04:34:49 -0400
X-MC-Unique: TpMmYNGRM8-uO01k_f2yqg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7DBC938337E0;
        Thu, 28 Apr 2022 08:34:48 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6FBCB55BA85;
        Thu, 28 Apr 2022 08:34:42 +0000 (UTC)
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
Subject: [PATCH v4 00/17] mm: COW fixes part 2: reliable GUP pins of anonymous pages
Date:   Thu, 28 Apr 2022 10:34:24 +0200
Message-Id: <20220428083441.37290-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is roughly what we have in -mm and -next, however, includes one
additional patch and some minor differences, especially minor fixes in the
patch descriptions.

v4 is located at:
	https://github.com/davidhildenbrand/linux/tree/cow_fixes_part_2_v4

Please refer to to v3 cover letter:
	https://lkml.kernel.org/r/20220329160440.193848-1-david@redhat.com


v3 -> v4:
* Minor changes/fixes in patch descriptions
* "mm/rmap: drop "compound" parameter from page_add_new_anon_rmap()"
 -> Remove VM_BUG_ON_PAGE(PageTransCompound(page), page);
* "mm/rmap: fail try_to_migrate() early when setting a PMD migration entry
   fails"
 -> Added
* "mm: support GUP-triggered unsharing of anonymous pages"
 -> unlikely(unshare) -> likely(!unshare) in wp_huge_pmd()
 -> "page_copied && !unshare" -> "(page_copied && !unshare)"
* "mm/gup: sanity-check with CONFIG_DEBUG_VM that anonymous pages are
   exclusive when (un)pinning"
 -> Use VM_BUG_ON_PAGE() instead of VM_BUG_ON()

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


David Hildenbrand (17):
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
  mm/rmap: fail try_to_migrate() early when setting a PMD migration
    entry fails
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
 include/linux/swapops.h    |  29 ++++-
 kernel/events/uprobes.c    |   2 +-
 mm/gup.c                   | 106 ++++++++++++++++-
 mm/huge_memory.c           | 133 ++++++++++++++++-----
 mm/hugetlb.c               | 135 ++++++++++++++-------
 mm/khugepaged.c            |   2 +-
 mm/ksm.c                   |  15 ++-
 mm/memory.c                | 234 +++++++++++++++++++++++--------------
 mm/memremap.c              |   9 ++
 mm/migrate.c               |  18 ++-
 mm/migrate_device.c        |  23 +++-
 mm/mprotect.c              |   8 +-
 mm/rmap.c                  | 105 ++++++++++++-----
 mm/swapfile.c              |   8 +-
 mm/userfaultfd.c           |   2 +-
 tools/vm/page-types.c      |   8 +-
 21 files changed, 836 insertions(+), 227 deletions(-)


base-commit: af2d861d4cd2a4da5137f795ee3509e6f944a25b
-- 
2.35.1


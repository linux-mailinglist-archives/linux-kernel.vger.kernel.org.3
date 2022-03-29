Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501D24EB179
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239262AbiC2QLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 12:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiC2QLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:11:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11B37B3C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648570173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ERYXkFPAgJ90WQxpwmtKMgvT2M98R0fhW2WQBYC6nEY=;
        b=h2zzqxvYn3zSHsmRcZPX1meFrIUddLAk+lzMtCiNJj+/oWhaHMbCI3SYiTK9jm7prb4jzx
        lKrivtOTw4bl3K8+AJ3YAlW0CMp6nmDqjiEHv6Eh0jVM7Gqj5reIxDvxlYw9OlhUGF1yI+
        OAeFGeAn8l0//5YGZZ6geGSmy8hoHo4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638--aqlv62UNI2ujlNLWdpVaQ-1; Tue, 29 Mar 2022 12:09:31 -0400
X-MC-Unique: -aqlv62UNI2ujlNLWdpVaQ-1
Received: by mail-wr1-f71.google.com with SMTP id 71-20020adf82cd000000b00203dc43d216so5209140wrc.22
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=ERYXkFPAgJ90WQxpwmtKMgvT2M98R0fhW2WQBYC6nEY=;
        b=DXFIVl5Ew6XV6wujEitapR4iJ2YeYLGJTGOE1YSpd3wPNlR8O5yeBdBvdTd3t3FKB+
         mbW9wPskAsW3yad10yiwpyanVqE7vxgSFKhOpEaZbCoNZ94uJvWWhkxcKQjTPqmAzjy1
         +9HsThEfyAnH7nZkGg9tF5tjxMVdEs0BYhaTCDneKGS5LzKAvh7yk2Y4hAloCQNJm2aA
         4XjJa7k1MxCF50CNFU2Hn2fsW1+zuNM/AhU75f1eMRq6lrP8MVIRwfavUwv6M7v4byG7
         Y0ycPvS8izD+pLbeB4nmZ0m7Pti+ypA5j68mWJ1EEvO+HNUrrji5qhOFLnVBbheAGd1l
         37XA==
X-Gm-Message-State: AOAM530IfgmUZzSWPxif5AG6zhzzCa6GwkGp1fzG6UyMjp+5FoZc79N2
        jZ/YahB4+o0H3iIL/b6I2Egfwvnw//IL2kunGfqmmGL444LBnaVwz+C+NJzHJFzjx13jpWBlUwv
        U32mWPWb5bep5ZTElXdwEX2tXkFeG81DVOGQiGezaYfweF64mGN0WM16cMJgSkmX6aHyri5xh
X-Received: by 2002:a5d:584f:0:b0:204:1749:2ce7 with SMTP id i15-20020a5d584f000000b0020417492ce7mr32146266wrf.584.1648570169933;
        Tue, 29 Mar 2022 09:09:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEEQSQ9mD0Qh2lecVnWyuFqbm6EG80NlcwqXtphIt7v3vSgjfFD2xoYKKg0A4ay0J5fhiznQ==
X-Received: by 2002:a5d:584f:0:b0:204:1749:2ce7 with SMTP id i15-20020a5d584f000000b0020417492ce7mr32146140wrf.584.1648570169153;
        Tue, 29 Mar 2022 09:09:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:af00:7a8a:46df:a7c3:c4c7? (p200300cbc708af007a8a46dfa7c3c4c7.dip0.t-ipconnect.de. [2003:cb:c708:af00:7a8a:46df:a7c3:c4c7])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c028700b0038cc9bfe6a4sm2450957wmk.37.2022.03.29.09.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 09:09:28 -0700 (PDT)
Message-ID: <44bbf475-7a78-95fc-3a2c-83f4878840ad@redhat.com>
Date:   Tue, 29 Mar 2022 18:09:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3 00/16] mm: COW fixes part 2: reliable GUP pins of
 anonymous pages
Content-Language: en-US
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
        Khalid Aziz <khalid.aziz@oracle.com>
References: <20220329160440.193848-1-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220329160440.193848-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.03.22 18:04, David Hildenbrand wrote:
> This series is the result of the discussion on the previous approach [2].
> More information on the general COW issues can be found there. It is based
> on latest linus/master (post v5.17, with relevant core-MM changes for
> v5.18-rc1).
> 
> v3 is located at:
> 	https://github.com/davidhildenbrand/linux/tree/cow_fixes_part_2_v3
> 
> 
> This series fixes memory corruptions when a GUP pin (FOLL_PIN) was taken
> on an anonymous page and COW logic fails to detect exclusivity of the page
> to then replacing the anonymous page by a copy in the page table: The
> GUP pin lost synchronicity with the pages mapped into the page tables.
> 
> This issue, including other related COW issues, has been summarized in [3]
> under 3):
> "
>   3. Intra Process Memory Corruptions due to Wrong COW (FOLL_PIN)
> 
>   page_maybe_dma_pinned() is used to check if a page may be pinned for
>   DMA (using FOLL_PIN instead of FOLL_GET). While false positives are
>   tolerable, false negatives are problematic: pages that are pinned for
>   DMA must not be added to the swapcache. If it happens, the (now pinned)
>   page could be faulted back from the swapcache into page tables
>   read-only. Future write-access would detect the pinning and COW the
>   page, losing synchronicity. For the interested reader, this is nicely
>   documented in feb889fb40fa ("mm: don't put pinned pages into the swap
>   cache").
> 
>   Peter reports [8] that page_maybe_dma_pinned() as used is racy in some
>   cases and can result in a violation of the documented semantics:
>   giving false negatives because of the race.
> 
>   There are cases where we call it without properly taking a per-process
>   sequence lock, turning the usage of page_maybe_dma_pinned() racy. While
>   one case (clear_refs SOFTDIRTY tracking, see below) seems to be easy to
>   handle, there is especially one rmap case (shrink_page_list) that's hard
>   to fix: in the rmap world, we're not limited to a single process.
> 
>   The shrink_page_list() issue is really subtle. If we race with
>   someone pinning a page, we can trigger the same issue as in the FOLL_GET
>   case. See the detail section at the end of this mail on a discussion how
>   bad this can bite us with VFIO or other FOLL_PIN user.
> 
>   It's harder to reproduce, but I managed to modify the O_DIRECT
>   reproducer to use io_uring fixed buffers [15] instead, which ends up
>   using FOLL_PIN | FOLL_WRITE | FOLL_LONGTERM to pin buffer pages and can
>   similarly trigger a loss of synchronicity and consequently a memory
>   corruption.
> 
>   Again, the root issue is that a write-fault on a page that has
>   additional references results in a COW and thereby a loss of
>   synchronicity and consequently a memory corruption if two parties
>   believe they are referencing the same page.
> "
> 
> This series makes GUP pins (R/O and R/W) on anonymous pages fully reliable,
> especially also taking care of concurrent pinning via GUP-fast,
> for example, also fully fixing an issue reported regarding NUMA
> balancing [4] recently. While doing that, it further reduces "unnecessary
> COWs", especially when we don't fork()/KSM and don't swapout, and fixes the
> COW security for hugetlb for FOLL_PIN.
> 
> In summary, we track via a pageflag (PG_anon_exclusive) whether a mapped
> anonymous page is exclusive. Exclusive anonymous pages that are mapped
> R/O can directly be mapped R/W by the COW logic in the write fault handler.
> Exclusive anonymous pages that want to be shared (fork(), KSM) first have
> to be marked shared -- which will fail if there are GUP pins on the page.
> GUP is only allowed to take a pin on anonymous pages that are exclusive.
> The PT lock is the primary mechanism to synchronize modifications of
> PG_anon_exclusive. We synchronize against GUP-fast either via the
> src_mm->write_protect_seq (during fork()) or via clear/invalidate+flush of
> the relevant page table entry.
> 
> Special care has to be taken about swap, migration, and THPs (whereby a
> PMD-mapping can be converted to a PTE mapping and we have to track
> information for subpages). Besides these, we let the rmap code handle most
> magic. For reliable R/O pins of anonymous pages, we need FAULT_FLAG_UNSHARE
> logic as part of our previous approach [2], however, it's now 100% mapcount
> free and I further simplified it a bit.
> 
>   #1 is a fix
>   #3-#10 are mostly rmap preparations for PG_anon_exclusive handling
>   #11 introduces PG_anon_exclusive
>   #12 uses PG_anon_exclusive and make R/W pins of anonymous pages
>    reliable
>   #13 is a preparation for reliable R/O pins
>   #14 and #15 is reused/modified GUP-triggered unsharing for R/O GUP pins
>    make R/O pins of anonymous pages reliable
>   #16 adds sanity check when (un)pinning anonymous pages
> 
> 
> [1] https://lkml.kernel.org/r/20220131162940.210846-1-david@redhat.com
> [2] https://lkml.kernel.org/r/20211217113049.23850-1-david@redhat.com
> [3] https://lore.kernel.org/r/3ae33b08-d9ef-f846-56fb-645e3b9b4c66@redhat.com
> [4] https://bugzilla.kernel.org/show_bug.cgi?id=215616
> 
> 
> v2 -> v3:
> * Note 1: Left the terminology "unshare" in place for now instead of
>   switching to "make anon exclusive".
> * Note 2: We might have to tackle undoing effects of arch_unmap_one() on
>   sparc, to free some tag memory immediately instead of when tearing down
>   the vma/mm; looks like this needs more care either way, so I'll ignore it
>   for now.
> * Rebased on top of core MM changes for v5.18-rc1 (most conflicts were due
>   to folio and ZONE_DEVICE migration rework). No severe changes were
>   necessary -- mostly folio conversion and code movement.
> * Retested on aarch64, ppc64, s390x and x86_64
> * "mm/rmap: convert RMAP flags to a proper distinct rmap_t type"
>   -> Missed to convert one instance in restore_exclusive_pte()
> * "mm/rmap: pass rmap flags to hugepage_add_anon_rmap()"
>   -> Use "!!(flags & RMAP_EXCLUSIVE)" to avoid sparse warnings
> * "mm/huge_memory: remove outdated VM_WARN_ON_ONCE_PAGE from unmap_page()"
>   -> Added, as we can trigger that now more frequently
> * "mm: remember exclusively mapped anonymous pages with PG_anon_exclusive"
>   -> Use subpage in VM_BUG_ON_PAGE() in try_to_migrate_one()
>   -> Move comment from folio_migrate_mapping() to folio_migrate_flags()
>      regarding PG_anon_exclusive/PG_mappedtodisk
>   -> s/int rmap_flags/rmap_t rmap_flags/ in remove_migration_pmd()
> * "mm/gup: sanity-check with CONFIG_DEBUG_VM that anonymous pages are
>    exclusive when (un)pinning"
>   -> Use IS_ENABLED(CONFIG_DEBUG_VM) instead of ifdef
> 
> v1 -> v2:
> * Tested on aarch64, ppc64, s390x and x86_64
> * "mm/page-flags: reuse PG_mappedtodisk as PG_anon_exclusive for PageAnon()
>    pages"
>   -> Use PG_mappedtodisk instead of PG_slab (thanks Willy!), this simlifies
>      the patch and necessary handling a lot. Add safety BUG_ON's
>   -> Move most documentation to the patch description, to be placed in a
>      proper documentation doc in the future, once everything's in place
> * ""mm: remember exclusively mapped anonymous pages with PG_anon_exclusive
>   -> Skip check+clearing in page_try_dup_anon_rmap(), otherwise we might
>      trigger a wrong VM_BUG_ON() for KSM pages in ClearPageAnonExclusive()
>   -> In __split_huge_pmd_locked(), call page_try_share_anon_rmap() only
>      for "anon_exclusive", otherwise we might trigger a wrong VM_BUG_ON()
>   -> In __split_huge_page_tail(), drop any remaining PG_anon_exclusive on
>      tail pages, and document why that is fine
> 
> RFC -> v1:
> * Rephrased/extended some patch descriptions+comments
> * Tested on aarch64, ppc64 and x86_64
> * "mm/rmap: convert RMAP flags to a proper distinct rmap_t type"
>  -> Added
> * "mm/rmap: drop "compound" parameter from page_add_new_anon_rmap()"
>  -> Added
> * "mm: remember exclusively mapped anonymous pages with PG_anon_exclusive"
>  -> Fixed __do_huge_pmd_anonymous_page() to recheck after temporarily
>     dropping the PT lock.
>  -> Use "reuse" label in __do_huge_pmd_anonymous_page()
>  -> Slightly simplify logic in hugetlb_cow()
>  -> In remove_migration_pte(), remove unrelated changes around
>     page_remove_rmap()
> * "mm: support GUP-triggered unsharing of anonymous pages"
>  -> In handle_pte_fault(), trigger pte_mkdirty() only with
>     FAULT_FLAG_WRITE
>  -> In __handle_mm_fault(), extend comment regarding anonymous PUDs
> * "mm/gup: trigger FAULT_FLAG_UNSHARE when R/O-pinning a possibly shared
>    anonymous page"
>    -> Added unsharing logic to gup_hugepte() and gup_huge_pud()
>    -> Changed return logic in __follow_hugetlb_must_fault(), making sure
>       that "unshare" is always set
> * "mm/gup: sanity-check with CONFIG_DEBUG_VM that anonymous pages are
>    exclusive when (un)pinning"
>   -> Slightly simplified sanity_check_pinned_pages()
> 
> David Hildenbrand (16):
>   mm/rmap: fix missing swap_free() in try_to_unmap() after
>     arch_unmap_one() failed
>   mm/hugetlb: take src_mm->write_protect_seq in
>     copy_hugetlb_page_range()
>   mm/memory: slightly simplify copy_present_pte()
>   mm/rmap: split page_dup_rmap() into page_dup_file_rmap() and
>     page_try_dup_anon_rmap()
>   mm/rmap: convert RMAP flags to a proper distinct rmap_t type
>   mm/rmap: remove do_page_add_anon_rmap()
>   mm/rmap: pass rmap flags to hugepage_add_anon_rmap()
>   mm/rmap: drop "compound" parameter from page_add_new_anon_rmap()
>   mm/rmap: use page_move_anon_rmap() when reusing a mapped PageAnon()
>     page exclusively
>   mm/huge_memory: remove outdated VM_WARN_ON_ONCE_PAGE from unmap_page()
>   mm/page-flags: reuse PG_mappedtodisk as PG_anon_exclusive for
>     PageAnon() pages
>   mm: remember exclusively mapped anonymous pages with PG_anon_exclusive
>   mm/gup: disallow follow_page(FOLL_PIN)
>   mm: support GUP-triggered unsharing of anonymous pages
>   mm/gup: trigger FAULT_FLAG_UNSHARE when R/O-pinning a possibly shared
>     anonymous page
>   mm/gup: sanity-check with CONFIG_DEBUG_VM that anonymous pages are
>     exclusive when (un)pinning
> 
>  include/linux/mm.h         |  46 +++++++-
>  include/linux/mm_types.h   |   8 ++
>  include/linux/page-flags.h |  39 ++++++-
>  include/linux/rmap.h       | 118 +++++++++++++++++--
>  include/linux/swap.h       |  15 ++-
>  include/linux/swapops.h    |  25 ++++
>  kernel/events/uprobes.c    |   2 +-
>  mm/gup.c                   | 106 ++++++++++++++++-
>  mm/huge_memory.c           | 127 +++++++++++++++-----
>  mm/hugetlb.c               | 135 ++++++++++++++-------
>  mm/khugepaged.c            |   2 +-
>  mm/ksm.c                   |  15 ++-
>  mm/memory.c                | 234 +++++++++++++++++++++++--------------
>  mm/memremap.c              |   9 ++
>  mm/migrate.c               |  18 ++-
>  mm/migrate_device.c        |  23 +++-
>  mm/mprotect.c              |   8 +-
>  mm/rmap.c                  |  97 +++++++++++----
>  mm/swapfile.c              |   8 +-
>  mm/userfaultfd.c           |   2 +-
>  tools/vm/page-types.c      |   8 +-
>  21 files changed, 825 insertions(+), 220 deletions(-)
> 
> 
> base-commit: 1930a6e739c4b4a654a69164dbe39e554d228915


The effective change on v5.17 *before rebasing* compared to v2 is:


diff --git a/mm/gup.c b/mm/gup.c
index 72e39b77da10..e1de0104cb19 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -48,7 +48,9 @@ static void hpage_pincount_sub(struct page *page, int refs)
 static inline void sanity_check_pinned_pages(struct page **pages,
 					     unsigned long npages)
 {
-#ifdef CONFIG_DEBUG_VM
+	if (!IS_ENABLED(CONFIG_DEBUG_VM))
+		return;
+
 	/*
 	 * We only pin anonymous pages if they are exclusive. Once pinned, we
 	 * can no longer turn them possibly shared and PageAnonExclusive() will
@@ -74,7 +76,6 @@ static inline void sanity_check_pinned_pages(struct page **pages,
 			VM_BUG_ON_PAGE(!PageAnonExclusive(head) &&
 				       !PageAnonExclusive(page), page);
 	}
-#endif /* CONFIG_DEBUG_VM */
 }
 
 /* Equivalent to calling put_page() @refs times. */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0cc34addd911..c53764b0640f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2316,8 +2316,6 @@ static void unmap_page(struct page *page)
 		try_to_migrate(page, ttu_flags);
 	else
 		try_to_unmap(page, ttu_flags | TTU_IGNORE_MLOCK);
-
-	VM_WARN_ON_ONCE_PAGE(page_mapped(page), page);
 }
 
 static void remap_page(struct page *page, unsigned int nr)
@@ -3187,7 +3185,7 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 
 	flush_cache_range(vma, mmun_start, mmun_start + HPAGE_PMD_SIZE);
 	if (PageAnon(new)) {
-		int rmap_flags = RMAP_COMPOUND;
+		rmap_t rmap_flags = RMAP_COMPOUND;
 
 		if (!is_readable_migration_entry(entry))
 			rmap_flags |= RMAP_EXCLUSIVE;
diff --git a/mm/memory.c b/mm/memory.c
index b0b9d07a2850..1c8b52771799 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -727,7 +727,7 @@ static void restore_exclusive_pte(struct vm_area_struct *vma,
 	 * created when the swap entry was made.
 	 */
 	if (PageAnon(page))
-		page_add_anon_rmap(page, vma, address, false);
+		page_add_anon_rmap(page, vma, address, RMAP_NONE);
 	else
 		/*
 		 * Currently device exclusive access only supports anonymous
diff --git a/mm/migrate.c b/mm/migrate.c
index 7f440d2103ce..013eb4f52fed 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -384,10 +384,6 @@ int folio_migrate_mapping(struct address_space *mapping,
 		/* No turning back from here */
 		newfolio->index = folio->index;
 		newfolio->mapping = folio->mapping;
-		/*
-		 * Note: PG_anon_exclusive is always migrated via migration
-		 * entries.
-		 */
 		if (folio_test_swapbacked(folio))
 			__folio_set_swapbacked(newfolio);
 
@@ -540,6 +536,12 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
 		folio_set_workingset(newfolio);
 	if (folio_test_checked(folio))
 		folio_set_checked(newfolio);
+	/*
+	 * PG_anon_exclusive (-> PG_mappedtodisk) is always migrated via
+	 * migration entries. We can still have PG_anon_exclusive set on an
+	 * effectively unmapped and unreferenced first sub-pages of an
+	 * anonymous THP: we can simply copy it here via PG_mappedtodisk.
+	 */
 	if (folio_test_mappedtodisk(folio))
 		folio_set_mappedtodisk(newfolio);
 
diff --git a/mm/rmap.c b/mm/rmap.c
index 9d2a7e11e8cc..c18f6d7891d0 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1939,7 +1939,7 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
 				break;
 			}
 			VM_BUG_ON_PAGE(pte_write(pteval) && PageAnon(page) &&
-				       !anon_exclusive, page);
+				       !anon_exclusive, subpage);
 			if (anon_exclusive &&
 			    page_try_share_anon_rmap(subpage)) {
 				set_pte_at(mm, address, pvmw.pte, pteval);
@@ -2476,7 +2476,7 @@ void hugepage_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 	VM_BUG_ON_PAGE(!first && PageAnonExclusive(page), page);
 	if (first)
 		__page_set_anon_rmap(page, vma, address,
-				     flags & RMAP_EXCLUSIVE);
+				     !!(flags & RMAP_EXCLUSIVE));
 }
 
 void hugepage_add_new_anon_rmap(struct page *page,

-- 
Thanks,

David / dhildenb


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0669E4D1A44
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 15:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242206AbiCHOU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 09:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiCHOU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 09:20:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 334884B1F9
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 06:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646749198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I7FfqfWQxZi7bimq9cJ3tmew+8HCpqU9f+VLORDq95E=;
        b=OUDLvxrXk33Z0pgwAvfBZF3ncPNsACxYGV4tbsxa3pfsuGW0mKZ9zBZgjEVjxxbtcp5VrA
        porzt+RfnspMVKPBrH15pIrfjqRuCbHqyHYk6p4IUlY2GMiyIolb04TZ3UTBenOXzo371l
        PsmuaJo2eRgdyfe8J8QWHmJFKD4W2As=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-474-jdXDIrC5OFKOHZZImhmbIQ-1; Tue, 08 Mar 2022 09:19:57 -0500
X-MC-Unique: jdXDIrC5OFKOHZZImhmbIQ-1
Received: by mail-wm1-f69.google.com with SMTP id d8-20020a05600c34c800b0037e3cd6225eso6505423wmq.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 06:19:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=I7FfqfWQxZi7bimq9cJ3tmew+8HCpqU9f+VLORDq95E=;
        b=JVffCAirL4uAsr+8Fs9icQtAiJyrjPRnXIzyN2yvGeTk+RSVNkvbasRqWmRp5dS0Uj
         uJzi92A6UsgGjhU/KZ8b7BVDGHf9jxAzLj3L8s0ILTQcdCWNJLzlqNhE0py5SNefZUcz
         RiCABcZEtHr+qULTC+3faUwCNLRMplTBgyrPjLPApExT49TqgzS8Xp/RdiR7NoBaAA8X
         4l6h53jxC/9Rft2jj9XGMpew2erhTVW/XmA1af3OV9OiqFjXEW3lWd5oVhPc16A4UaS2
         rvZGYMSg1fyCv8xD8rog3OpkvKIpCbPtwR+lU/gc3WU7FAO2LoQLhDWBfqyv6yKZTFCC
         EZvw==
X-Gm-Message-State: AOAM533L3LaWKYvEHmfnECE3cd3MOfk4tfjTbxBZGfNInK8tMqxvUuwM
        nHNyAxpOl2Yz9AGRZgQG+6TZdLZxulzOFQYBXC0UE10GnChxCOAt3kieV31d0P4ArD2HpmmAfFD
        SxtBaa/5SmpcRRgAeHoRTbS/JSYI1Y6DugMycz0e/O5Lhb82JzpvYLO6BwR/PyHpfi6HKRDUH
X-Received: by 2002:a05:600c:4f0c:b0:389:990e:d9f4 with SMTP id l12-20020a05600c4f0c00b00389990ed9f4mr3628995wmq.90.1646749195392;
        Tue, 08 Mar 2022 06:19:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJziLE88U2xGrHj1ynq6mA5WOLPH3Acwc5xzbjMutqcIk1ZX/dRuykRPPVb3ByD4FIFtzq6K4w==
X-Received: by 2002:a05:600c:4f0c:b0:389:990e:d9f4 with SMTP id l12-20020a05600c4f0c00b00389990ed9f4mr3628924wmq.90.1646749194663;
        Tue, 08 Mar 2022 06:19:54 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:b000:acda:b420:16aa:6b67? (p200300cbc708b000acdab42016aa6b67.dip0.t-ipconnect.de. [2003:cb:c708:b000:acda:b420:16aa:6b67])
        by smtp.gmail.com with ESMTPSA id bj7-20020a0560001e0700b001f1d7822865sm9786739wrb.43.2022.03.08.06.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 06:19:54 -0800 (PST)
Message-ID: <d676ffa7-eef1-3d17-7b3a-c4d80c8ed7b8@redhat.com>
Date:   Tue, 8 Mar 2022 15:19:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 00/15] mm: COW fixes part 2: reliable GUP pins of
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
References: <20220308141437.144919-1-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220308141437.144919-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.03.22 15:14, David Hildenbrand wrote:
> This series is the result of the discussion on the previous approach [2].
> More information on the general COW issues can be found there. It is based
> on v5.17-rc7 and [1], which resides in -mm and -next:
> 	[PATCH v3 0/9] mm: COW fixes part 1: fix the COW security issue for
> 	THP and swap
> 
> v1 is located at:
> 	https://github.com/davidhildenbrand/linux/tree/cow_fixes_part_2_v1
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
> to mark a mapped anonymous page shared -- which will fail if there are
> GUP pins on the page. GUP is only allowed to take a pin on anonymous pages
> that is exclusive. The PT lock is the primary mechanism to synchronize
> modifications of PG_anon_exclusive. GUP-fast is synchronized either via the
> src_mm->write_protect_seq or via clear/invalidate+flush of the relevant
> page table entry.
> 
> Special care has to be taken about swap, migration, and THPs (whereby a
> PMD-mapping can be converted to a PTE mapping and we have to track
> information for subpages). Besides these, we let the rmap code handle most
> magic. For reliable R/O pins of anonymous pages, we need FAULT_FLAG_UNSHARE
> logic as part of our previous approach [2], however, it's now 100% mapcount
> free and I further simplified it a bit.
> 
>   #1 is a fix
>   #3-#9 are mostly rmap preparations for PG_anon_exclusive handling
>   #10 introduces PG_anon_exclusive
>   #11 uses PG_anon_exclusive and make R/W pins of anonymous pages
>    reliable
>   #12 is a preparation for reliable R/O pins
>   #13 and #14 is reused/modified GUP-triggered unsharing for R/O GUP pins
>    make R/O pins of anonymous pages reliable
>   #15 adds sanity check when (un)pinning anonymous pages
> 
> I'm not proud about patch #10, suggestions welcome. Patch #11 contains
> excessive explanations and the main logic for R/W pins. #12 and #13
> resemble what we proposed in the previous approach [2]. I consider the
> general approach of #15 very nice and helpful, and I remember Linus even
> envisioning something like that for finding BUGs, although we might want to
> implement the sanity checks eventually differently
> 
> It passes my growing set of tests for "wrong COW" and "missed COW",
> including the ones in [3] -- I'd really appreciate some experienced eyes
> to take a close look at corner cases.
> 
> I'm planning on sending a part 3 that will remember PG_anon_exclusive for
> ordinary swap entries: this will make FOLL_GET | FOLL_WRITE references
> reliable and fix the memory corruptions for O_DIRECT -- as described in
> [3] under 2) -- as well, as long as there is no fork().
> 
> The long term goal should be to convert relevant users of FOLL_GET to
> FOLL_PIN, however, with part3 it wouldn't be required to fix the obvious
> memory corruptions we are aware of. Once that's in place we can streamline
> our COW logic for hugetlb to rely on page_count() as well and fix any
> possible COW security issues.
> 
> [1] https://lkml.kernel.org/r/20220131162940.210846-1-david@redhat.com
> [2] https://lkml.kernel.org/r/20211217113049.23850-1-david@redhat.com
> [3] https://lore.kernel.org/r/3ae33b08-d9ef-f846-56fb-645e3b9b4c66@redhat.com
> [4] https://bugzilla.kernel.org/show_bug.cgi?id=215616
> 
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
> David Hildenbrand (15):
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
>   mm/page-flags: reuse PG_slab as PG_anon_exclusive for PageAnon() pages
>   mm: remember exclusively mapped anonymous pages with PG_anon_exclusive
>   mm/gup: disallow follow_page(FOLL_PIN)
>   mm: support GUP-triggered unsharing of anonymous pages
>   mm/gup: trigger FAULT_FLAG_UNSHARE when R/O-pinning a possibly shared
>     anonymous page
>   mm/gup: sanity-check with CONFIG_DEBUG_VM that anonymous pages are
>     exclusive when (un)pinning
> 
>  fs/proc/page.c                 |   3 +-
>  include/linux/mm.h             |  46 ++++++-
>  include/linux/mm_types.h       |   8 ++
>  include/linux/page-flags.h     | 124 +++++++++++++++++-
>  include/linux/rmap.h           | 109 ++++++++++++++--
>  include/linux/swap.h           |  15 ++-
>  include/linux/swapops.h        |  25 ++++
>  include/trace/events/mmflags.h |   2 +-
>  kernel/events/uprobes.c        |   2 +-
>  mm/gup.c                       | 103 ++++++++++++++-
>  mm/huge_memory.c               | 122 +++++++++++++-----
>  mm/hugetlb.c                   | 137 ++++++++++++++------
>  mm/khugepaged.c                |   2 +-
>  mm/ksm.c                       |  15 ++-
>  mm/memory-failure.c            |  24 +++-
>  mm/memory.c                    | 221 ++++++++++++++++++++-------------
>  mm/memremap.c                  |  11 ++
>  mm/migrate.c                   |  40 +++++-
>  mm/mprotect.c                  |   8 +-
>  mm/page_alloc.c                |  13 ++
>  mm/rmap.c                      |  95 ++++++++++----
>  mm/swapfile.c                  |   4 +-
>  mm/userfaultfd.c               |   2 +-
>  23 files changed, 904 insertions(+), 227 deletions(-)
> 

Full diff to RFC:


diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index c4957bac4868..1bc522d28a78 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -158,23 +158,37 @@ static inline void anon_vma_merge(struct vm_area_struct *vma,
 
 struct anon_vma *page_get_anon_vma(struct page *page);
 
-/* bitflags for do_page_add_anon_rmap() */
-#define RMAP_EXCLUSIVE 0x01
-#define RMAP_COMPOUND 0x02
+/* RMAP flags, currently only relevant for some anon rmap operations. */
+typedef int __bitwise rmap_t;
+
+/*
+ * No special request: if the page is a subpage of a compound page, it is
+ * mapped via a PTE. The mapped (sub)page is possibly shared between processes.
+ */
+#define RMAP_NONE		((__force rmap_t)0)
+
+/* The (sub)page is exclusive to a single process. */
+#define RMAP_EXCLUSIVE		((__force rmap_t)BIT(0))
+
+/*
+ * The compound page is not mapped via PTEs, but instead via a single PMD and
+ * should be accounted accordingly.
+ */
+#define RMAP_COMPOUND		((__force rmap_t)BIT(1))
 
 /*
  * rmap interfaces called when adding or removing pte of page
  */
 void page_move_anon_rmap(struct page *, struct vm_area_struct *);
 void page_add_anon_rmap(struct page *, struct vm_area_struct *,
-		unsigned long, int);
+		unsigned long, rmap_t);
 void page_add_new_anon_rmap(struct page *, struct vm_area_struct *,
-		unsigned long, bool);
+		unsigned long);
 void page_add_file_rmap(struct page *, bool);
 void page_remove_rmap(struct page *, bool);
 
 void hugepage_add_anon_rmap(struct page *, struct vm_area_struct *,
-			    unsigned long, int);
+			    unsigned long, rmap_t);
 void hugepage_add_new_anon_rmap(struct page *, struct vm_area_struct *,
 				unsigned long);
 
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 6357c3580d07..b6fdb23fb3ea 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -184,7 +184,7 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 
 	if (new_page) {
 		get_page(new_page);
-		page_add_new_anon_rmap(new_page, vma, addr, false);
+		page_add_new_anon_rmap(new_page, vma, addr);
 		lru_cache_add_inactive_or_unevictable(new_page, vma);
 	} else
 		/* no new page, just dec_mm_counter for old_page */
diff --git a/mm/gup.c b/mm/gup.c
index df1ae29a1f5f..b36f02f2b720 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -50,30 +50,27 @@ static inline void sanity_check_pinned_pages(struct page **pages,
 {
 #ifdef CONFIG_DEBUG_VM
 	/*
-	 * We expect to only succeed in pinning anonymous pages if they are
-	 * exclusive. Once pinned, we can no longer mark them shared and the
-	 * PageAnonExclusive() will stick around until the page is freed
-	 * after it was unmapped.
+	 * We only pin anonymous pages if they are exclusive. Once pinned, we
+	 * can no longer turn them possibly shared and PageAnonExclusive() will
+	 * stick around until the page is freed.
 	 *
-	 * We'd like to verify that our pinned anonymous pages are mapped
+	 * We'd like to verify that our pinned anonymous pages are still mapped
 	 * exclusively. The issue with anon THP is that we don't know how
 	 * they are/were mapped when pinning them. However, for anon
 	 * THP we can assume that either the given page (PTE-mapped THP) or
 	 * the head page (PMD-mapped THP) should be PageAnonExclusive(). If
-	 * neither is the case there is certainly something wrong.
+	 * neither is the case, there is certainly something wrong.
 	 */
 	for (; npages; npages--, pages++) {
 		struct page *page = *pages;
 		struct page *head = compound_head(page);
 
-		if (!PageAnon(page))
+		if (!PageAnon(head))
 			continue;
-		if (!PageCompound(page))
-			VM_BUG_ON_PAGE(!PageAnonExclusive(page), page);
-		else if (PageHuge(page))
+		if (!PageCompound(head) || PageHuge(head))
 			VM_BUG_ON_PAGE(!PageAnonExclusive(head), page);
 		else
-			/* Either PTE-mapped or PMD-mapped, we don't know. */
+			/* Either a PTE-mapped or a PMD-mapped THP. */
 			VM_BUG_ON_PAGE(!PageAnonExclusive(head) &&
 				       !PageAnonExclusive(page), page);
 	}
@@ -449,7 +446,7 @@ static void unpin_user_pages_lockless(struct page **pages, unsigned long npages)
 
 	/*
 	 * Don't perform any sanity checks because we might have raced with
-	 * fork() and some anonymous pages might no actually be shared --
+	 * fork() and some anonymous pages might now actually be shared --
 	 * which is why we're unpinning after all.
 	 */
 	for_each_compound_head(index, pages, npages, head, ntails)
@@ -2607,6 +2604,11 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 		return 0;
 	}
 
+	if (!pte_write(pte) && gup_must_unshare(flags, head)) {
+		put_compound_head(head, refs, flags);
+		return 0;
+	}
+
 	*nr += refs;
 	SetPageReferenced(head);
 	return 1;
@@ -2706,6 +2708,11 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 		return 0;
 	}
 
+	if (!pud_write(orig) && gup_must_unshare(flags, head)) {
+		put_compound_head(head, refs, flags);
+		return 0;
+	}
+
 	*nr += refs;
 	SetPageReferenced(head);
 	return 1;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 72ed42d0ef3c..d9559341a5f1 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -647,7 +647,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 
 		entry = mk_huge_pmd(page, vma->vm_page_prot);
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
-		page_add_new_anon_rmap(page, vma, haddr, true);
+		page_add_new_anon_rmap(page, vma, haddr);
 		lru_cache_add_inactive_or_unevictable(page, vma);
 		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
 		set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
@@ -1296,22 +1296,9 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 	page = pmd_page(orig_pmd);
 	VM_BUG_ON_PAGE(!PageHead(page), page);
 
-	if (PageAnonExclusive(page)) {
-		pmd_t entry;
-
-		/* R/O and exclusive, nothing to do. */
-		if (unlikely(unshare)) {
-			spin_unlock(vmf->ptl);
-			return 0;
-		}
-
-		entry = pmd_mkyoung(orig_pmd);
-		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
-		if (pmdp_set_access_flags(vma, haddr, vmf->pmd, entry, 1))
-			update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
-		spin_unlock(vmf->ptl);
-		return VM_FAULT_WRITE;
-	}
+	/* Early check when only holding the PT lock. */
+	if (PageAnonExclusive(page))
+		goto reuse;
 
 	if (!trylock_page(page)) {
 		get_page(page);
@@ -1327,6 +1314,12 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 		put_page(page);
 	}
 
+	/* Recheck after temporarily dropping the PT lock. */
+	if (PageAnonExclusive(page)) {
+		unlock_page(page);
+		goto reuse;
+	}
+
 	/*
 	 * See do_wp_page(): we can only reuse the page exclusively if there are
 	 * no additional references. Note that we always drain the LRU
@@ -1340,8 +1333,9 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 		pmd_t entry;
 
 		page_move_anon_rmap(page, vma);
+		unlock_page(page);
+reuse:
 		if (unlikely(unshare)) {
-			unlock_page(page);
 			spin_unlock(vmf->ptl);
 			return 0;
 		}
@@ -1349,7 +1343,6 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
 		if (pmdp_set_access_flags(vma, haddr, vmf->pmd, entry, 1))
 			update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
-		unlock_page(page);
 		spin_unlock(vmf->ptl);
 		return VM_FAULT_WRITE;
 	}
@@ -2376,8 +2369,8 @@ static void __split_huge_page_tail(struct page *head, int tail,
 	 * After successful get_page_unless_zero() might follow flags change,
 	 * for example lock_page() which set PG_waiters.
 	 *
-	 * Keep PG_anon_exclusive information already maintained for all
-	 * subpages of a compound page untouched.
+	 * Keep PG_anon_exclusive information, already maintained for all
+	 * subpages of a compound page, untouched.
 	 */
 	page_tail->flags &= ~(PAGE_FLAGS_CHECK_AT_PREP & ~PG_anon_exclusive);
 	page_tail->flags |= (head->flags &
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7bac6ed93fea..0d150d100111 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5169,14 +5169,14 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * owner and can reuse this page.
 	 */
 	if (page_mapcount(old_page) == 1 && PageAnon(old_page)) {
-		if (unlikely(unshare) && PageAnonExclusive(old_page))
-			return 0;
-		page_move_anon_rmap(old_page, vma);
+		if (!PageAnonExclusive(old_page))
+			page_move_anon_rmap(old_page, vma);
 		if (likely(!unshare))
 			set_huge_ptep_writable(vma, haddr, ptep);
 		return 0;
 	}
-	VM_BUG_ON_PAGE(PageAnon(old_page) && PageAnonExclusive(old_page), old_page);
+	VM_BUG_ON_PAGE(PageAnon(old_page) && PageAnonExclusive(old_page),
+		       old_page);
 
 	/*
 	 * If the process that created a MAP_PRIVATE mapping is about to
@@ -5968,9 +5968,11 @@ static inline bool __follow_hugetlb_must_fault(unsigned int flags, pte_t *pte,
 		return false;
 	if (flags & FOLL_WRITE)
 		return true;
-	if (gup_must_unshare(flags, pte_page(pteval)))
+	if (gup_must_unshare(flags, pte_page(pteval))) {
 		*unshare = true;
-	return *unshare;
+		return true;
+	}
+	return false;
 }
 
 long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
@@ -5987,7 +5989,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 	while (vaddr < vma->vm_end && remainder) {
 		pte_t *pte;
 		spinlock_t *ptl = NULL;
-		bool unshare;
+		bool unshare = false;
 		int absent;
 		struct page *page;
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index a325a646be33..96cc903c4788 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1183,7 +1183,7 @@ static void collapse_huge_page(struct mm_struct *mm,
 
 	spin_lock(pmd_ptl);
 	BUG_ON(!pmd_none(*pmd));
-	page_add_new_anon_rmap(new_page, vma, address, true);
+	page_add_new_anon_rmap(new_page, vma, address);
 	lru_cache_add_inactive_or_unevictable(new_page, vma);
 	pgtable_trans_huge_deposit(mm, pmd, pgtable);
 	set_pmd_at(mm, address, pmd, _pmd);
diff --git a/mm/ksm.c b/mm/ksm.c
index c380c36f3ebd..350b46432d65 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1164,7 +1164,7 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 	 */
 	if (!is_zero_pfn(page_to_pfn(kpage))) {
 		get_page(kpage);
-		page_add_anon_rmap(kpage, vma, addr, 0);
+		page_add_anon_rmap(kpage, vma, addr, RMAP_NONE);
 		newpte = mk_pte(kpage, vma->vm_page_prot);
 	} else {
 		newpte = pte_mkspecial(pfn_pte(page_to_pfn(kpage),
diff --git a/mm/memory.c b/mm/memory.c
index 33d046c34819..94355bb34d8c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -899,7 +899,7 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 	*prealloc = NULL;
 	copy_user_highpage(new_page, page, addr, src_vma);
 	__SetPageUptodate(new_page);
-	page_add_new_anon_rmap(new_page, dst_vma, addr, false);
+	page_add_new_anon_rmap(new_page, dst_vma, addr);
 	lru_cache_add_inactive_or_unevictable(new_page, dst_vma);
 	rss[mm_counter(new_page)]++;
 
@@ -2948,6 +2948,7 @@ static inline void wp_page_reuse(struct vm_fault *vmf)
 	struct page *page = vmf->page;
 	pte_t entry;
 
+	VM_BUG_ON(!(vmf->flags & FAULT_FLAG_WRITE));
 	VM_BUG_ON(PageAnon(page) && !PageAnonExclusive(page));
 
 	/*
@@ -3068,7 +3069,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		 * some TLBs while the old PTE remains in others.
 		 */
 		ptep_clear_flush_notify(vma, vmf->address, vmf->pte);
-		page_add_new_anon_rmap(new_page, vma, vmf->address, false);
+		page_add_new_anon_rmap(new_page, vma, vmf->address);
 		lru_cache_add_inactive_or_unevictable(new_page, vma);
 		/*
 		 * We call the notify macro here because, when using secondary
@@ -3282,8 +3283,8 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 
 	vmf->page = vm_normal_page(vma, vmf->address, vmf->orig_pte);
 	if (!vmf->page) {
-		/* No anonymous page -> nothing to do. */
 		if (unlikely(unshare)) {
+			/* No anonymous page -> nothing to do. */
 			pte_unmap_unlock(vmf->pte, vmf->ptl);
 			return 0;
 		}
@@ -3565,10 +3566,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	struct page *page = NULL, *swapcache;
 	struct swap_info_struct *si = NULL;
+	rmap_t rmap_flags = RMAP_NONE;
 	swp_entry_t entry;
 	pte_t pte;
 	int locked;
-	int exclusive = 0;
 	vm_fault_t ret = 0;
 	void *shadow = NULL;
 
@@ -3744,7 +3745,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			vmf->flags &= ~FAULT_FLAG_WRITE;
 			ret |= VM_FAULT_WRITE;
 		}
-		exclusive = RMAP_EXCLUSIVE;
+		rmap_flags |= RMAP_EXCLUSIVE;
 	}
 	flush_icache_page(vma, page);
 	if (pte_swp_soft_dirty(vmf->orig_pte))
@@ -3757,10 +3758,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 	/* ksm created a completely new copy */
 	if (unlikely(page != swapcache && swapcache)) {
-		page_add_new_anon_rmap(page, vma, vmf->address, false);
+		page_add_new_anon_rmap(page, vma, vmf->address);
 		lru_cache_add_inactive_or_unevictable(page, vma);
 	} else {
-		page_add_anon_rmap(page, vma, vmf->address, exclusive);
+		page_add_anon_rmap(page, vma, vmf->address, rmap_flags);
 	}
 
 	VM_BUG_ON(!PageAnon(page) || (pte_write(pte) && !PageAnonExclusive(page)));
@@ -3908,7 +3909,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	}
 
 	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
-	page_add_new_anon_rmap(page, vma, vmf->address, false);
+	page_add_new_anon_rmap(page, vma, vmf->address);
 	lru_cache_add_inactive_or_unevictable(page, vma);
 setpte:
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
@@ -4085,7 +4086,7 @@ void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
 	/* copy-on-write page */
 	if (write && !(vma->vm_flags & VM_SHARED)) {
 		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
-		page_add_new_anon_rmap(page, vma, addr, false);
+		page_add_new_anon_rmap(page, vma, addr);
 		lru_cache_add_inactive_or_unevictable(page, vma);
 	} else {
 		inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
@@ -4682,7 +4683,8 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 	if (vmf->flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
 		if (!pte_write(entry))
 			return do_wp_page(vmf);
-		entry = pte_mkdirty(entry);
+		else if (likely(vmf->flags & FAULT_FLAG_WRITE))
+			entry = pte_mkdirty(entry);
 	}
 	entry = pte_mkyoung(entry);
 	if (ptep_set_access_flags(vmf->vma, vmf->address, vmf->pte, entry,
@@ -4746,8 +4748,10 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		barrier();
 		if (pud_trans_huge(orig_pud) || pud_devmap(orig_pud)) {
 
-			/* NUMA case for anonymous PUDs would go here */
-
+			/*
+			 * TODO once we support anonymous PUDs: NUMA case and
+			 * FAULT_FLAG_UNSHARE handling.
+			 */
 			if ((flags & FAULT_FLAG_WRITE) && !pud_write(orig_pud)) {
 				ret = wp_huge_pud(&vmf, orig_pud);
 				if (!(ret & VM_FAULT_FALLBACK))
diff --git a/mm/migrate.c b/mm/migrate.c
index 63a3241041e1..7f440d2103ce 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -188,7 +188,7 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
 
 	VM_BUG_ON_PAGE(PageTail(page), page);
 	while (page_vma_mapped_walk(&pvmw)) {
-		int rmap_flags = 0;
+		rmap_t rmap_flags = RMAP_NONE;
 
 		if (PageKsm(page))
 			new = page;
@@ -2357,12 +2357,12 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			set_pte_at(mm, addr, ptep, swp_pte);
 
 			/*
-			 * This is like regular unmap: we remove the
-			 * rmap and drop page refcount. Page won't be
-			 * freed, as we took a reference just above.
+			 * This is like regular unmap: we remove the rmap and
+			 * drop page refcount. Page won't be freed, as we took
+			 * a reference just above.
 			 */
-			put_page(page);
 			page_remove_rmap(page, false);
+			put_page(page);
 
 			if (pte_present(pte))
 				unmapped++;
@@ -2753,7 +2753,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 		goto unlock_abort;
 
 	inc_mm_counter(mm, MM_ANONPAGES);
-	page_add_new_anon_rmap(page, vma, addr, false);
+	page_add_new_anon_rmap(page, vma, addr);
 	if (!is_zone_device_page(page))
 		lru_cache_add_inactive_or_unevictable(page, vma);
 	get_page(page);
diff --git a/mm/rmap.c b/mm/rmap.c
index cc54bd1cce61..9d2a7e11e8cc 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1141,8 +1141,8 @@ static void __page_check_anon_rmap(struct page *page,
  * and to ensure that PageAnon is not being upgraded racily to PageKsm
  * (but PageKsm is never downgraded to PageAnon).
  */
-void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
-			unsigned long address, int flags)
+void page_add_anon_rmap(struct page *page,
+	struct vm_area_struct *vma, unsigned long address, rmap_t flags)
 {
 	bool compound = flags & RMAP_COMPOUND;
 	bool first;
@@ -1185,25 +1185,28 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 	/* address might be in next vma when migration races vma_adjust */
 	if (first)
 		__page_set_anon_rmap(page, vma, address,
-				flags & RMAP_EXCLUSIVE);
+				     !!(flags & RMAP_EXCLUSIVE));
 	else
 		__page_check_anon_rmap(page, vma, address);
 }
 
 /**
- * page_add_new_anon_rmap - add pte mapping to a new anonymous page
+ * page_add_new_anon_rmap - add mapping to a new anonymous page
  * @page:	the page to add the mapping to
  * @vma:	the vm area in which the mapping is added
  * @address:	the user virtual address mapped
- * @compound:	charge the page as compound or small page
+ *
+ * If it's a compound page, it is accounted as a compound page. As the page
+ * is new, it's assume to get mapped exclusively by a single process.
  *
  * Same as page_add_anon_rmap but must only be called on *new* pages.
  * This means the inc-and-test can be bypassed.
  * Page does not have to be locked.
  */
 void page_add_new_anon_rmap(struct page *page,
-	struct vm_area_struct *vma, unsigned long address, bool compound)
+	struct vm_area_struct *vma, unsigned long address)
 {
+	const bool compound = PageCompound(page);
 	int nr = compound ? thp_nr_pages(page) : 1;
 
 	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
@@ -1639,6 +1642,16 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 				page_vma_mapped_walk_done(&pvmw);
 				break;
 			}
+			/*
+			 * Note: We *don't* remember yet if the page was mapped
+			 * exclusively in the swap entry, so swapin code has
+			 * to re-determine that manually and might detect the
+			 * page as possibly shared, for example, if there are
+			 * other references on the page or if the page is under
+			 * writeback. We made sure that there are no GUP pins
+			 * on the page that would rely on it, so for GUP pins
+			 * this is fine.
+			 */
 			if (list_empty(&mm->mmlist)) {
 				spin_lock(&mmlist_lock);
 				if (list_empty(&mm->mmlist))
@@ -2450,7 +2463,7 @@ void rmap_walk_locked(struct page *page, struct rmap_walk_control *rwc)
  * RMAP_COMPOUND is ignored.
  */
 void hugepage_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
-			    unsigned long address, int flags)
+			    unsigned long address, rmap_t flags)
 {
 	struct anon_vma *anon_vma = vma->anon_vma;
 	int first;
@@ -2462,7 +2475,8 @@ void hugepage_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 	VM_BUG_ON_PAGE(!first && (flags & RMAP_EXCLUSIVE), page);
 	VM_BUG_ON_PAGE(!first && PageAnonExclusive(page), page);
 	if (first)
-		__page_set_anon_rmap(page, vma, address, flags & RMAP_EXCLUSIVE);
+		__page_set_anon_rmap(page, vma, address,
+				     flags & RMAP_EXCLUSIVE);
 }
 
 void hugepage_add_new_anon_rmap(struct page *page,
diff --git a/mm/swapfile.c b/mm/swapfile.c
index eacda7ca7ac9..7edc8e099b22 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1800,9 +1800,9 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
 	get_page(page);
 	if (page == swapcache) {
-		page_add_anon_rmap(page, vma, addr, 0);
+		page_add_anon_rmap(page, vma, addr, RMAP_NONE);
 	} else { /* ksm created a completely new copy */
-		page_add_new_anon_rmap(page, vma, addr, false);
+		page_add_new_anon_rmap(page, vma, addr);
 		lru_cache_add_inactive_or_unevictable(page, vma);
 	}
 	set_pte_at(vma->vm_mm, addr, pte,
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 0780c2a57ff1..4ca854ce14f0 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -98,7 +98,7 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 	if (page_in_cache)
 		page_add_file_rmap(page, false);
 	else
-		page_add_new_anon_rmap(page, dst_vma, dst_addr, false);
+		page_add_new_anon_rmap(page, dst_vma, dst_addr);
 
 	/*
 	 * Must happen after rmap, as mm_counter() checks mapping (via

-- 
Thanks,

David / dhildenb


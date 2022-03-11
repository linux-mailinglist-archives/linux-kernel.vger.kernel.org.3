Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410714D68C1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 19:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350994AbiCKSxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 13:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241658AbiCKSxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 13:53:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25D506149
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 10:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647024745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7CN4lo4QpIGW7+zMQEW1NbYm1hvzRkolxAtfGGUDNJM=;
        b=Arh18ZLUITORSSpcRT0anCU1+Z9fwW5wOdp6aUk4/zdj33SorYt8jFuiGrqt3uGApKce/X
        MAvQnbiAsINh9iu09ks7TWH/JvcoIawQDkcuXSkNfpGdeSCcZgE9iZwP4kYATCzD8EK/Zu
        XmNh4XIbPXPsZKB3ubAbi5C0+Bpd/bQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-204-82mafhw6NCibdI_YCj-UYg-1; Fri, 11 Mar 2022 13:52:24 -0500
X-MC-Unique: 82mafhw6NCibdI_YCj-UYg-1
Received: by mail-wm1-f72.google.com with SMTP id l13-20020a7bcf0d000000b0038982c6bf8fso3763201wmg.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 10:52:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=7CN4lo4QpIGW7+zMQEW1NbYm1hvzRkolxAtfGGUDNJM=;
        b=UneL4kdZ7D8DQEzwEG1u2LGpyrTmI31lmNK0GpwAao6+3uVxMUT4ILPEi+k0/9SMQC
         NEKA8piDWt69pMjGYloD29JqSpaDWf+UThT0s66Bn1JEezVn7UAHOUoAu3N7ATJMnIAP
         HC0k/b7n869RJ8/DM9Y08bJSfmlqd/9y47eNcDBkBN1+zLbNfyVp1BAdISyhy9FEmGj4
         P1mJYXEvOCwoi5mTmfzLhAhzosC1hxeNZBunJLHz2SJWq4DolGiDNGQdYVJUhV02bpro
         CVoqt3ucFaNOTOPTPIEYHngK4E4CEtdLhGWnIqxhQK6RK7w75f8gHRfwg3XGND0JO+Yj
         q6Mg==
X-Gm-Message-State: AOAM530cDwd0NXcH28OVOj/KWmQmqnwWdKVFuRW9VQEEdATFosvsbLVk
        6Jy9LwGKSM9YPNgdpjgE3zBpNRbODmp7gD0ouQ6gMwof1LlQBWJ0uxzk0V6oH5eV2GoaumifnFP
        DIOhbLdxsPwZCtL6PdFaIFjef8w/Uoj7MfAj2DcjLaXBJYukVoe7JGCQG5LoQ6V/QXEgjtZuk
X-Received: by 2002:adf:8b58:0:b0:1f0:241e:9b51 with SMTP id v24-20020adf8b58000000b001f0241e9b51mr8123037wra.539.1647024742557;
        Fri, 11 Mar 2022 10:52:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwboy6G1BbtMJB6fG936okMYpD2YKFVVMT+WJs1vDtpOkwxrvQKzVIJuLq7pccJUtPD89bacQ==
X-Received: by 2002:adf:8b58:0:b0:1f0:241e:9b51 with SMTP id v24-20020adf8b58000000b001f0241e9b51mr8122997wra.539.1647024742058;
        Fri, 11 Mar 2022 10:52:22 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:8200:163d:7a08:6e61:87a5? (p200300cbc7078200163d7a086e6187a5.dip0.t-ipconnect.de. [2003:cb:c707:8200:163d:7a08:6e61:87a5])
        by smtp.gmail.com with ESMTPSA id p18-20020adfba92000000b001e4ae791663sm7620511wrg.62.2022.03.11.10.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 10:52:21 -0800 (PST)
Message-ID: <01c4df9d-c64b-e5b5-1167-65d9f187b13b@redhat.com>
Date:   Fri, 11 Mar 2022 19:52:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v1 11/15] mm: remember exclusively mapped anonymous pages
 with PG_anon_exclusive
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
        Oded Gabbay <oded.gabbay@gmail.com>, linux-mm@kvack.org
References: <20220308141437.144919-1-david@redhat.com>
 <20220308141437.144919-12-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220308141437.144919-12-david@redhat.com>
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
> Let's mark exclusively mapped anonymous pages with PG_anon_exclusive as
> exclusive, and use that information to make GUP pins reliable and stay
> consistent with the page mapped into the page table even if the
> page table entry gets write-protected.
> 
> With that information at hand, we can extend our COW logic to always
> reuse anonymous pages that are exclusive. For anonymous pages that
> might be shared, the existing logic applies.
> 
> As already documented, PG_anon_exclusive is usually only expressive in
> combination with a page table entry. Especially PTE vs. PMD-mapped
> anonymous pages require more thought, some examples: due to mremap() we
> can easily have a single compound page PTE-mapped into multiple page tables
> exclusively in a single process -- multiple page table locks apply.
> Further, due to MADV_WIPEONFORK we might not necessarily write-protect
> all PTEs, and only some subpages might be pinned. Long story short: once
> PTE-mapped, we have to track information about exclusivity per sub-page,
> but until then, we can just track it for the compound page in the head
> page and not having to update a whole bunch of subpages all of the time
> for a simple PMD mapping of a THP.
> 
> For simplicity, this commit mostly talks about "anonymous pages", while
> it's for THP actually "the part of an anonymous folio referenced via
> a page table entry".
> 
> To not spill PG_anon_exclusive code all over the mm code-base, we let
> the anon rmap code to handle all PG_anon_exclusive logic it can easily
> handle.
> 
> If a writable, present page table entry points at an anonymous (sub)page,
> that (sub)page must be PG_anon_exclusive. If GUP wants to take a reliably
> pin (FOLL_PIN) on an anonymous page references via a present
> page table entry, it must only pin if PG_anon_exclusive is set for the
> mapped (sub)page.
> 
> This commit doesn't adjust GUP, so this is only implicitly handled for
> FOLL_WRITE, follow-up commits will teach GUP to also respect it for
> FOLL_PIN without !FOLL_WRITE, to make all GUP pins of anonymous pages
> fully reliable.
> 
> Whenever an anonymous page is to be shared (fork(), KSM), or when
> temporarily unmapping an anonymous page (swap, migration), the relevant
> PG_anon_exclusive bit has to be cleared to mark the anonymous page
> possibly shared. Clearing will fail if there are GUP pins on the page:
> * For fork(), this means having to copy the page and not being able to
>   share it. fork() protects against concurrent GUP using the PT lock and
>   the src_mm->write_protect_seq.
> * For KSM, this means sharing will fail. For swap this means, unmapping
>   will fail, For migration this means, migration will fail early. All
>   three cases protect against concurrent GUP using the PT lock and a
>   proper clear/invalidate+flush of the relevant page table entry.
> 
> This fixes memory corruptions reported for FOLL_PIN | FOLL_WRITE, when a
> pinned page gets mapped R/O and the successive write fault ends up
> replacing the page instead of reusing it. It improves the situation for
> O_DIRECT/vmsplice/... that still use FOLL_GET instead of FOLL_PIN,
> if fork() is *not* involved, however swapout and fork() are still
> problematic. Properly using FOLL_PIN instead of FOLL_GET for these
> GUP users will fix the issue for them.
> 
> I. Details about basic handling
> 
> I.1. Fresh anonymous pages
> 
> page_add_new_anon_rmap() and hugepage_add_new_anon_rmap() will mark the
> given page exclusive via __page_set_anon_rmap(exclusive=1). As that is
> the mechanism fresh anonymous pages come into life (besides migration
> code where we copy the page->mapping), all fresh anonymous pages will
> start out as exclusive.
> 
> I.2. COW reuse handling of anonymous pages
> 
> When a COW handler stumbles over a (sub)page that's marked exclusive, it
> simply reuses it. Otherwise, the handler tries harder under page lock to
> detect if the (sub)page is exclusive and can be reused. If exclusive,
> page_move_anon_rmap() will mark the given (sub)page exclusive.
> 
> Note that hugetlb code does not yet check for PageAnonExclusive(), as it
> still uses the old COW logic that is prone to the COW security issue
> because hugetlb code cannot really tolerate unnecessary/wrong COW as
> huge pages are a scarce resource.
> 
> I.3. Migration handling
> 
> try_to_migrate() has to try marking an exclusive anonymous page shared
> via page_try_share_anon_rmap(). If it fails because there are GUP pins
> on the page, unmap fails. migrate_vma_collect_pmd() and
> __split_huge_pmd_locked() are handled similarly.
> 
> Writable migration entries implicitly point at shared anonymous pages.
> For readable migration entries that information is stored via a new
> "readable-exclusive" migration entry, specific to anonymous pages.
> 
> When restoring a migration entry in remove_migration_pte(), information
> about exlusivity is detected via the migration entry type, and
> RMAP_EXCLUSIVE is set accordingly for
> page_add_anon_rmap()/hugepage_add_anon_rmap() to restore that
> information.
> 
> I.4. Swapout handling
> 
> try_to_unmap() has to try marking the mapped page possibly shared via
> page_try_share_anon_rmap(). If it fails because there are GUP pins on the
> page, unmap fails. For now, information about exclusivity is lost. In the
> future, we might want to remember that information in the swap entry in
> some cases, however, it requires more thought, care, and a way to store
> that information in swap entries.
> 
> I.5. Swapin handling
> 
> do_swap_page() will never stumble over exclusive anonymous pages in the
> swap cache, as try_to_migrate() prohibits that. do_swap_page() always has
> to detect manually if an anonymous page is exclusive and has to set
> RMAP_EXCLUSIVE for page_add_anon_rmap() accordingly.
> 
> I.6. THP handling
> 
> __split_huge_pmd_locked() has to move the information about exclusivity
> from the PMD to the PTEs.
> 
> a) In case we have a readable-exclusive PMD migration entry, simply insert
> readable-exclusive PTE migration entries.
> 
> b) In case we have a present PMD entry and we don't want to freeze
> ("convert to migration entries"), simply forward PG_anon_exclusive to
> all sub-pages, no need to temporarily clear the bit.
> 
> c) In case we have a present PMD entry and want to freeze, handle it
> similar to try_to_migrate(): try marking the page shared first. In case
> we fail, we ignore the "freeze" instruction and simply split ordinarily.
> try_to_migrate() will properly fail because the THP is still mapped via
> PTEs.
> 
> When splitting a compound anonymous folio (THP), the information about
> exclusivity is implicitly handled via the migration entries: no need to
> replicate PG_anon_exclusive manually.
> 
> I.7. fork() handling
> 
> fork() handling is relatively easy, because PG_anon_exclusive is only
> expressive for some page table entry types.
> 
> a) Present anonymous pages
> 
> page_try_dup_anon_rmap() will mark the given subpage shared -- which
> will fail if the page is pinned. If it failed, we have to copy (or
> PTE-map a PMD to handle it on the PTE level).
> 
> Note that device exclusive entries are just a pointer at a PageAnon()
> page. fork() will first convert a device exclusive entry to a present
> page table and handle it just like present anonymous pages.
> 
> b) Device private entry
> 
> Device private entries point at PageAnon() pages that cannot be mapped
> directly and, therefore, cannot get pinned.
> 
> page_try_dup_anon_rmap() will mark the given subpage shared, which
> cannot fail because they cannot get pinned.
> 
> c) HW poison entries
> 
> PG_anon_exclusive will remain untouched and is stale -- the page table
> entry is just a placeholder after all.
> 
> d) Migration entries
> 
> Writable and readable-exclusive entries are converted to readable
> entries: possibly shared.
> 
> I.8. mprotect() handling
> 
> mprotect() only has to properly handle the new readable-exclusive
> migration entry:
> 
> When write-protecting a migration entry that points at an anonymous
> page, remember the information about exclusivity via the
> "readable-exclusive" migration entry type.
> 
> II. Migration and GUP-fast
> 
> Whenever replacing a present page table entry that maps an exclusive
> anonymous page by a migration entry, we have to mark the page possibly
> shared and synchronize against GUP-fast by a proper
> clear/invalidate+flush to make the following scenario impossible:
> 
> 1. try_to_migrate() places a migration entry after checking for GUP pins
>    and marks the page possibly shared.
> 2. GUP-fast pins the page due to lack of synchronization
> 3. fork() converts the "writable/readable-exclusive" migration entry into a
>    readable migration entry
> 4. Migration fails due to the GUP pin (failing to freeze the refcount)
> 5. Migration entries are restored. PG_anon_exclusive is lost
> 
> -> We have a pinned page that is not marked exclusive anymore.
> 
> Note that we move information about exclusivity from the page to the
> migration entry as it otherwise highly overcomplicates fork() and
> PTE-mapping a THP.
> 
> III. Swapout and GUP-fast
> 
> Whenever replacing a present page table entry that maps an exclusive
> anonymous page by a swap entry, we have to mark the page possibly
> shared and synchronize against GUP-fast by a proper
> clear/invalidate+flush to make the following scenario impossible:
> 
> 1. try_to_unmap() places a swap entry after checking for GUP pins and
>    clears exclusivity information on the page.
> 2. GUP-fast pins the page due to lack of synchronization.
> 
> -> We have a pinned page that is not marked exclusive anymore.
> 
> If we'd ever store information about exclusivity in the swap entry,
> similar to migration handling, the same considerations as in II would
> apply. This is future work.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/rmap.h    | 33 ++++++++++++++++++
>  include/linux/swap.h    | 15 ++++++---
>  include/linux/swapops.h | 25 ++++++++++++++
>  mm/huge_memory.c        | 75 ++++++++++++++++++++++++++++++++++++-----
>  mm/hugetlb.c            | 15 ++++++---
>  mm/ksm.c                | 13 ++++++-
>  mm/memory.c             | 33 +++++++++++++-----
>  mm/migrate.c            | 34 +++++++++++++++++--
>  mm/mprotect.c           |  8 +++--
>  mm/rmap.c               | 59 +++++++++++++++++++++++++++++---
>  10 files changed, 275 insertions(+), 35 deletions(-)
> 

I'll be including the following two changes in the next version:



diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 1bc522d28a78..1aef834e1d60 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -224,6 +224,13 @@ static inline int page_try_dup_anon_rmap(struct page *page, bool compound,
 {
        VM_BUG_ON_PAGE(!PageAnon(page), page);
 
+       /*
+        * No need to check+clear for already shared pages, including KSM
+        * pages.
+        */
+       if (!PageAnonExclusive(page))
+               goto dup;
+
        /*
         * If this page may have been pinned by the parent process,
         * don't allow to duplicate the mapping but instead require to e.g.,
@@ -240,6 +247,7 @@ static inline int page_try_dup_anon_rmap(struct page *page, bool compound,
         * It's okay to share the anon page between both processes, mapping
         * the page R/O into both processes.
         */
+dup:
        __page_dup_rmap(page, compound);
        return 0;
 }
@@ -275,7 +283,6 @@ static inline int page_try_share_anon_rmap(struct page *page)
        return 0;
 }
 
-
 /*
  * Called from mm/vmscan.c to handle paging out
  */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0e83c1551da3..f94c66959531 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2083,7 +2083,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
                 * only and let try_to_migrate_one() fail later.
                 */
                anon_exclusive = PageAnon(page) && PageAnonExclusive(page);
-               if (freeze && page_try_share_anon_rmap(page))
+               if (freeze && anon_exclusive && page_try_share_anon_rmap(page))
                        freeze = false;
        }
        VM_BUG_ON_PAGE(!page_count(page), page);
@@ -2355,10 +2355,14 @@ static void __split_huge_page_tail(struct page *head, int tail,
         * After successful get_page_unless_zero() might follow flags change,
         * for example lock_page() which set PG_waiters.
         *
-        * Keep PG_anon_exclusive information, already maintained for all
-        * subpages of a compound page, untouched.
+        * Note that for anonymous pages, PG_anon_exclusive has been cleared
+        * in unmap_page() and is stored in the migration entry instead. It will
+        * be restored via remap_page(). We should never see PG_anon_exclusive
+        * at this point.
         */
-       page_tail->flags &= ~(PAGE_FLAGS_CHECK_AT_PREP & ~PG_anon_exclusive);
+       VM_BUG_ON_PAGE(PageAnon(head) && PageAnonExclusive(page_tail),
+                      page_tail);
+       page_tail->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
        page_tail->flags |= (head->flags &
                        ((1L << PG_referenced) |
                         (1L << PG_swapbacked) |



-- 
Thanks,

David / dhildenb


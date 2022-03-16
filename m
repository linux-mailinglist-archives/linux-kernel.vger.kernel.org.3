Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9094DBA0E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 22:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350040AbiCPVYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 17:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353394AbiCPVYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 17:24:36 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CE113EB7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 14:23:19 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id o13so1127962pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 14:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pnZka8Huc/DDCh1dvwZjlLjZfUF0eTr/lah0suIiY5M=;
        b=hhcUQtaXATwsx9Y72ymW1sTE9Tuulq+lnPYg3gwnkqIBfCK2cRcs71e2xWWkAMLwb4
         cZmYCMea9zpSJ11fgN1nYrmDoyNLV/Jqo2HS3pYwglRsWV7GC6d2WO9LgKTbmxdyX7hV
         vqaOzXy051vkZDsI4kKrnZkjcWZEuUYFdH3vAvxzTBf8tmzHEpsFRmaZcCsj6qGvo6Dc
         pSUk/6IOIYESVHTigb6E99KboYRUjm13CBGeChuV7Z7Gd6UrYcziQwsRZ2L2GPLV+J/v
         PV5ECkzSbqB5+2XDNWik/VuWLw3dVGM+WSJIt8qPwZ1+RM0ZZLUFQmjWsE8nzhuHsUMn
         7HZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pnZka8Huc/DDCh1dvwZjlLjZfUF0eTr/lah0suIiY5M=;
        b=jRZgSTktH1emk/XRnWBVQTjY8x7IX5mqg1vAQx8BKgVWdl/rH1QH7ipzfH9SmZxNom
         e6AcAkde4jpQaHGyHmyXSs0UN9hmeSI9Fskn4jtC277hz4fHuj3MntdvBr7RKWnOagX2
         TlTPPSE1Y6Vslulnvdrg3w38EiOuqEUdHA6DKqLPbWjNxioEg6gNHVc+m92mEWGpuCjr
         pabavuqxAmRzw2kLR9xIlhuF66aRUD9O64Y5f2/STiSsxLGNaDNTmXSWgO46F1ZnRH1G
         x0N0t63FzNNYgUhepkBw6C8H//f0c2P+ZnvJHhXQxzQI9NSoMC95goukJs5IisLXGu99
         CMBA==
X-Gm-Message-State: AOAM531rekLL4SppbTtYMBEwUoYqTo6V858mUZ9TlEokBCVFa1Dp86yK
        6pRsx3K0yFV0m1PXv33PoalUlYm60zdG43A6Eo4=
X-Google-Smtp-Source: ABdhPJyXHjADx0c9/SQLbJz4UFFwWyE7bdDOrLDECt9px5O1lJLH7gkjTQEObziP4ksuxvqdBxK5q6+TSzmsuBfJ2Fg=
X-Received: by 2002:a65:6951:0:b0:381:f10:ccaa with SMTP id
 w17-20020a656951000000b003810f10ccaamr1084102pgq.587.1647465798491; Wed, 16
 Mar 2022 14:23:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220315104741.63071-1-david@redhat.com> <20220315104741.63071-12-david@redhat.com>
In-Reply-To: <20220315104741.63071-12-david@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 16 Mar 2022 14:23:06 -0700
Message-ID: <CAHbLzkpTTf_16tDrS5TxWPif0ZOwFoJ1ys-PFtLhYK6XGowTYA@mail.gmail.com>
Subject: Re: [PATCH v2 11/15] mm: remember exclusively mapped anonymous pages
 with PG_anon_exclusive
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 3:52 AM David Hildenbrand <david@redhat.com> wrote:
>
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

How come will try_to_migrate() fail? The afterward pvmw will find
those PTEs then convert them to migration entries anyway IIUC.

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
>  include/linux/rmap.h    | 40 +++++++++++++++++++++
>  include/linux/swap.h    | 15 +++++---
>  include/linux/swapops.h | 25 +++++++++++++
>  mm/huge_memory.c        | 77 +++++++++++++++++++++++++++++++++++++----
>  mm/hugetlb.c            | 15 +++++---
>  mm/ksm.c                | 13 ++++++-
>  mm/memory.c             | 33 +++++++++++++-----
>  mm/migrate.c            | 34 ++++++++++++++++--
>  mm/mprotect.c           |  8 +++--
>  mm/rmap.c               | 59 ++++++++++++++++++++++++++++---
>  10 files changed, 285 insertions(+), 34 deletions(-)
>
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 51953bace0a3..1aef834e1d60 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -224,6 +224,13 @@ static inline int page_try_dup_anon_rmap(struct page *page, bool compound,
>  {
>         VM_BUG_ON_PAGE(!PageAnon(page), page);
>
> +       /*
> +        * No need to check+clear for already shared pages, including KSM
> +        * pages.
> +        */
> +       if (!PageAnonExclusive(page))
> +               goto dup;
> +
>         /*
>          * If this page may have been pinned by the parent process,
>          * don't allow to duplicate the mapping but instead require to e.g.,
> @@ -235,14 +242,47 @@ static inline int page_try_dup_anon_rmap(struct page *page, bool compound,
>             unlikely(page_needs_cow_for_dma(vma, page))))
>                 return -EBUSY;
>
> +       ClearPageAnonExclusive(page);
>         /*
>          * It's okay to share the anon page between both processes, mapping
>          * the page R/O into both processes.
>          */
> +dup:
>         __page_dup_rmap(page, compound);
>         return 0;
>  }
>
> +/**
> + * page_try_share_anon_rmap - try marking an exclusive anonymous page possibly
> + *                           shared to prepare for KSM or temporary unmapping
> + * @page: the exclusive anonymous page to try marking possibly shared
> + *
> + * The caller needs to hold the PT lock and has to have the page table entry
> + * cleared/invalidated+flushed, to properly sync against GUP-fast.
> + *
> + * This is similar to page_try_dup_anon_rmap(), however, not used during fork()
> + * to duplicate a mapping, but instead to prepare for KSM or temporarily
> + * unmapping a page (swap, migration) via page_remove_rmap().
> + *
> + * Marking the page shared can only fail if the page may be pinned; device
> + * private pages cannot get pinned and consequently this function cannot fail.
> + *
> + * Returns 0 if marking the page possibly shared succeeded. Returns -EBUSY
> + * otherwise.
> + */
> +static inline int page_try_share_anon_rmap(struct page *page)
> +{
> +       VM_BUG_ON_PAGE(!PageAnon(page) || !PageAnonExclusive(page), page);
> +
> +       /* See page_try_dup_anon_rmap(). */
> +       if (likely(!is_device_private_page(page) &&
> +           unlikely(page_maybe_dma_pinned(page))))
> +               return -EBUSY;
> +
> +       ClearPageAnonExclusive(page);
> +       return 0;
> +}
> +
>  /*
>   * Called from mm/vmscan.c to handle paging out
>   */
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index b546e4bd5c5a..422765d1141c 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -78,12 +78,19 @@ static inline int current_is_kswapd(void)
>  #endif
>
>  /*
> - * NUMA node memory migration support
> + * Page migration support.
> + *
> + * SWP_MIGRATION_READ_EXCLUSIVE is only applicable to anonymous pages and
> + * indicates that the referenced (part of) an anonymous page is exclusive to
> + * a single process. For SWP_MIGRATION_WRITE, that information is implicit:
> + * (part of) an anonymous page that are mapped writable are exclusive to a
> + * single process.
>   */
>  #ifdef CONFIG_MIGRATION
> -#define SWP_MIGRATION_NUM 2
> -#define SWP_MIGRATION_READ     (MAX_SWAPFILES + SWP_HWPOISON_NUM)
> -#define SWP_MIGRATION_WRITE    (MAX_SWAPFILES + SWP_HWPOISON_NUM + 1)
> +#define SWP_MIGRATION_NUM 3
> +#define SWP_MIGRATION_READ (MAX_SWAPFILES + SWP_HWPOISON_NUM)
> +#define SWP_MIGRATION_READ_EXCLUSIVE (MAX_SWAPFILES + SWP_HWPOISON_NUM + 1)
> +#define SWP_MIGRATION_WRITE (MAX_SWAPFILES + SWP_HWPOISON_NUM + 2)
>  #else
>  #define SWP_MIGRATION_NUM 0
>  #endif
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index d356ab4047f7..06280fc1c99b 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -194,6 +194,7 @@ static inline bool is_writable_device_exclusive_entry(swp_entry_t entry)
>  static inline int is_migration_entry(swp_entry_t entry)
>  {
>         return unlikely(swp_type(entry) == SWP_MIGRATION_READ ||
> +                       swp_type(entry) == SWP_MIGRATION_READ_EXCLUSIVE ||
>                         swp_type(entry) == SWP_MIGRATION_WRITE);
>  }
>
> @@ -202,11 +203,26 @@ static inline int is_writable_migration_entry(swp_entry_t entry)
>         return unlikely(swp_type(entry) == SWP_MIGRATION_WRITE);
>  }
>
> +static inline int is_readable_migration_entry(swp_entry_t entry)
> +{
> +       return unlikely(swp_type(entry) == SWP_MIGRATION_READ);
> +}
> +
> +static inline int is_readable_exclusive_migration_entry(swp_entry_t entry)
> +{
> +       return unlikely(swp_type(entry) == SWP_MIGRATION_READ_EXCLUSIVE);
> +}
> +
>  static inline swp_entry_t make_readable_migration_entry(pgoff_t offset)
>  {
>         return swp_entry(SWP_MIGRATION_READ, offset);
>  }
>
> +static inline swp_entry_t make_readable_exclusive_migration_entry(pgoff_t offset)
> +{
> +       return swp_entry(SWP_MIGRATION_READ_EXCLUSIVE, offset);
> +}
> +
>  static inline swp_entry_t make_writable_migration_entry(pgoff_t offset)
>  {
>         return swp_entry(SWP_MIGRATION_WRITE, offset);
> @@ -224,6 +240,11 @@ static inline swp_entry_t make_readable_migration_entry(pgoff_t offset)
>         return swp_entry(0, 0);
>  }
>
> +static inline swp_entry_t make_readable_exclusive_migration_entry(pgoff_t offset)
> +{
> +       return swp_entry(0, 0);
> +}
> +
>  static inline swp_entry_t make_writable_migration_entry(pgoff_t offset)
>  {
>         return swp_entry(0, 0);
> @@ -244,6 +265,10 @@ static inline int is_writable_migration_entry(swp_entry_t entry)
>  {
>         return 0;
>  }
> +static inline int is_readable_migration_entry(swp_entry_t entry)
> +{
> +       return 0;
> +}
>
>  #endif
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 0b6fb409b9e4..4872e7120ee1 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1054,7 +1054,7 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>                 swp_entry_t entry = pmd_to_swp_entry(pmd);
>
>                 VM_BUG_ON(!is_pmd_migration_entry(pmd));
> -               if (is_writable_migration_entry(entry)) {
> +               if (!is_readable_migration_entry(entry)) {
>                         entry = make_readable_migration_entry(
>                                                         swp_offset(entry));
>                         pmd = swp_entry_to_pmd(entry);
> @@ -1292,6 +1292,10 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
>         page = pmd_page(orig_pmd);
>         VM_BUG_ON_PAGE(!PageHead(page), page);
>
> +       /* Early check when only holding the PT lock. */
> +       if (PageAnonExclusive(page))
> +               goto reuse;
> +
>         if (!trylock_page(page)) {
>                 get_page(page);
>                 spin_unlock(vmf->ptl);
> @@ -1306,6 +1310,12 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
>                 put_page(page);
>         }
>
> +       /* Recheck after temporarily dropping the PT lock. */
> +       if (PageAnonExclusive(page)) {
> +               unlock_page(page);
> +               goto reuse;
> +       }
> +
>         /*
>          * See do_wp_page(): we can only map the page writable if there are
>          * no additional references. Note that we always drain the LRU
> @@ -1319,11 +1329,12 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
>                 pmd_t entry;
>
>                 page_move_anon_rmap(page, vma);
> +               unlock_page(page);
> +reuse:
>                 entry = pmd_mkyoung(orig_pmd);
>                 entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
>                 if (pmdp_set_access_flags(vma, haddr, vmf->pmd, entry, 1))
>                         update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
> -               unlock_page(page);
>                 spin_unlock(vmf->ptl);
>                 return VM_FAULT_WRITE;
>         }
> @@ -1741,6 +1752,7 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>  #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
>         if (is_swap_pmd(*pmd)) {
>                 swp_entry_t entry = pmd_to_swp_entry(*pmd);
> +               struct page *page = pfn_swap_entry_to_page(entry);
>
>                 VM_BUG_ON(!is_pmd_migration_entry(*pmd));
>                 if (is_writable_migration_entry(entry)) {
> @@ -1749,8 +1761,10 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>                          * A protection check is difficult so
>                          * just be safe and disable write
>                          */
> -                       entry = make_readable_migration_entry(
> -                                                       swp_offset(entry));
> +                       if (PageAnon(page))
> +                               entry = make_readable_exclusive_migration_entry(swp_offset(entry));
> +                       else
> +                               entry = make_readable_migration_entry(swp_offset(entry));
>                         newpmd = swp_entry_to_pmd(entry);
>                         if (pmd_swp_soft_dirty(*pmd))
>                                 newpmd = pmd_swp_mksoft_dirty(newpmd);
> @@ -1959,6 +1973,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>         pgtable_t pgtable;
>         pmd_t old_pmd, _pmd;
>         bool young, write, soft_dirty, pmd_migration = false, uffd_wp = false;
> +       bool anon_exclusive = false;
>         unsigned long addr;
>         int i;
>
> @@ -2040,6 +2055,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>                 entry = pmd_to_swp_entry(old_pmd);
>                 page = pfn_swap_entry_to_page(entry);
>                 write = is_writable_migration_entry(entry);
> +               if (PageAnon(page))
> +                       anon_exclusive = is_readable_exclusive_migration_entry(entry);
>                 young = false;
>                 soft_dirty = pmd_swp_soft_dirty(old_pmd);
>                 uffd_wp = pmd_swp_uffd_wp(old_pmd);
> @@ -2051,6 +2068,23 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>                 young = pmd_young(old_pmd);
>                 soft_dirty = pmd_soft_dirty(old_pmd);
>                 uffd_wp = pmd_uffd_wp(old_pmd);
> +
> +               /*
> +                * Without "freeze", we'll simply split the PMD, propagating the
> +                * PageAnonExclusive() flag for each PTE by setting it for
> +                * each subpage -- no need to (temporarily) clear.
> +                *
> +                * With "freeze" we want to replace mapped pages by
> +                * migration entries right away. This is only possible if we
> +                * managed to clear PageAnonExclusive() -- see
> +                * set_pmd_migration_entry().
> +                *
> +                * In case we cannot clear PageAnonExclusive(), split the PMD
> +                * only and let try_to_migrate_one() fail later.
> +                */
> +               anon_exclusive = PageAnon(page) && PageAnonExclusive(page);
> +               if (freeze && anon_exclusive && page_try_share_anon_rmap(page))
> +                       freeze = false;
>         }
>         VM_BUG_ON_PAGE(!page_count(page), page);
>         page_ref_add(page, HPAGE_PMD_NR - 1);
> @@ -2074,6 +2108,9 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>                         if (write)
>                                 swp_entry = make_writable_migration_entry(
>                                                         page_to_pfn(page + i));
> +                       else if (anon_exclusive)
> +                               swp_entry = make_readable_exclusive_migration_entry(
> +                                                       page_to_pfn(page + i));
>                         else
>                                 swp_entry = make_readable_migration_entry(
>                                                         page_to_pfn(page + i));
> @@ -2085,6 +2122,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>                 } else {
>                         entry = mk_pte(page + i, READ_ONCE(vma->vm_page_prot));
>                         entry = maybe_mkwrite(entry, vma);
> +                       if (anon_exclusive)
> +                               SetPageAnonExclusive(page + i);
>                         if (!write)
>                                 entry = pte_wrprotect(entry);
>                         if (!young)
> @@ -2315,6 +2354,13 @@ static void __split_huge_page_tail(struct page *head, int tail,
>          *
>          * After successful get_page_unless_zero() might follow flags change,
>          * for example lock_page() which set PG_waiters.
> +        *
> +        * Note that for mapped sub-pages of an anonymous THP,
> +        * PG_anon_exclusive has been cleared in unmap_page() and is stored in
> +        * the migration entry instead from where remap_page() will restore it.
> +        * We can still have PG_anon_exclusive set on effectively unmapped and
> +        * unreferenced sub-pages of an anonymous THP: we can simply drop
> +        * PG_anon_exclusive (-> PG_mappedtodisk) for these here.
>          */
>         page_tail->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
>         page_tail->flags |= (head->flags &
> @@ -3070,6 +3116,7 @@ void set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
>         struct vm_area_struct *vma = pvmw->vma;
>         struct mm_struct *mm = vma->vm_mm;
>         unsigned long address = pvmw->address;
> +       bool anon_exclusive;
>         pmd_t pmdval;
>         swp_entry_t entry;
>         pmd_t pmdswp;
> @@ -3079,10 +3126,19 @@ void set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
>
>         flush_cache_range(vma, address, address + HPAGE_PMD_SIZE);
>         pmdval = pmdp_invalidate(vma, address, pvmw->pmd);
> +
> +       anon_exclusive = PageAnon(page) && PageAnonExclusive(page);
> +       if (anon_exclusive && page_try_share_anon_rmap(page)) {
> +               set_pmd_at(mm, address, pvmw->pmd, pmdval);
> +               return;
> +       }
> +
>         if (pmd_dirty(pmdval))
>                 set_page_dirty(page);
>         if (pmd_write(pmdval))
>                 entry = make_writable_migration_entry(page_to_pfn(page));
> +       else if (anon_exclusive)
> +               entry = make_readable_exclusive_migration_entry(page_to_pfn(page));
>         else
>                 entry = make_readable_migration_entry(page_to_pfn(page));
>         pmdswp = swp_entry_to_pmd(entry);
> @@ -3116,10 +3172,17 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
>                 pmde = pmd_wrprotect(pmd_mkuffd_wp(pmde));
>
>         flush_cache_range(vma, mmun_start, mmun_start + HPAGE_PMD_SIZE);
> -       if (PageAnon(new))
> -               page_add_anon_rmap(new, vma, mmun_start, RMAP_COMPOUND);
> -       else
> +       if (PageAnon(new)) {
> +               int rmap_flags = RMAP_COMPOUND;
> +
> +               if (!is_readable_migration_entry(entry))
> +                       rmap_flags |= RMAP_EXCLUSIVE;
> +
> +               page_add_anon_rmap(new, vma, mmun_start, rmap_flags);
> +       } else {
>                 page_add_file_rmap(new, true);
> +       }
> +       VM_BUG_ON(pmd_write(pmde) && PageAnon(new) && !PageAnonExclusive(new));
>         set_pmd_at(mm, mmun_start, pvmw->pmd, pmde);
>         if ((vma->vm_flags & VM_LOCKED) && !PageDoubleMap(new))
>                 mlock_vma_page(new);
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 1ff0b9e1e28e..c0e19ea5ebb5 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4765,7 +4765,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>                                     is_hugetlb_entry_hwpoisoned(entry))) {
>                         swp_entry_t swp_entry = pte_to_swp_entry(entry);
>
> -                       if (is_writable_migration_entry(swp_entry) && cow) {
> +                       if (!is_readable_migration_entry(swp_entry) && cow) {
>                                 /*
>                                  * COW mappings require pages in both
>                                  * parent and child to be set to read.
> @@ -5165,6 +5165,8 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
>                 set_huge_ptep_writable(vma, haddr, ptep);
>                 return 0;
>         }
> +       VM_BUG_ON_PAGE(PageAnon(old_page) && PageAnonExclusive(old_page),
> +                      old_page);
>
>         /*
>          * If the process that created a MAP_PRIVATE mapping is about to
> @@ -6160,12 +6162,17 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
>                 }
>                 if (unlikely(is_hugetlb_entry_migration(pte))) {
>                         swp_entry_t entry = pte_to_swp_entry(pte);
> +                       struct page *page = pfn_swap_entry_to_page(entry);
>
> -                       if (is_writable_migration_entry(entry)) {
> +                       if (!is_readable_migration_entry(entry)) {
>                                 pte_t newpte;
>
> -                               entry = make_readable_migration_entry(
> -                                                       swp_offset(entry));
> +                               if (PageAnon(page))
> +                                       entry = make_readable_exclusive_migration_entry(
> +                                                               swp_offset(entry));
> +                               else
> +                                       entry = make_readable_migration_entry(
> +                                                               swp_offset(entry));
>                                 newpte = swp_entry_to_pte(entry);
>                                 set_huge_swap_pte_at(mm, address, ptep,
>                                                      newpte, huge_page_size(h));
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 9ff28097bc0a..350b46432d65 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -866,6 +866,7 @@ static inline struct stable_node *page_stable_node(struct page *page)
>  static inline void set_page_stable_node(struct page *page,
>                                         struct stable_node *stable_node)
>  {
> +       VM_BUG_ON_PAGE(PageAnon(page) && PageAnonExclusive(page), page);
>         page->mapping = (void *)((unsigned long)stable_node | PAGE_MAPPING_KSM);
>  }
>
> @@ -1041,6 +1042,7 @@ static int write_protect_page(struct vm_area_struct *vma, struct page *page,
>         int swapped;
>         int err = -EFAULT;
>         struct mmu_notifier_range range;
> +       bool anon_exclusive;
>
>         pvmw.address = page_address_in_vma(page, vma);
>         if (pvmw.address == -EFAULT)
> @@ -1058,9 +1060,10 @@ static int write_protect_page(struct vm_area_struct *vma, struct page *page,
>         if (WARN_ONCE(!pvmw.pte, "Unexpected PMD mapping?"))
>                 goto out_unlock;
>
> +       anon_exclusive = PageAnonExclusive(page);
>         if (pte_write(*pvmw.pte) || pte_dirty(*pvmw.pte) ||
>             (pte_protnone(*pvmw.pte) && pte_savedwrite(*pvmw.pte)) ||
> -                                               mm_tlb_flush_pending(mm)) {
> +           anon_exclusive || mm_tlb_flush_pending(mm)) {
>                 pte_t entry;
>
>                 swapped = PageSwapCache(page);
> @@ -1088,6 +1091,12 @@ static int write_protect_page(struct vm_area_struct *vma, struct page *page,
>                         set_pte_at(mm, pvmw.address, pvmw.pte, entry);
>                         goto out_unlock;
>                 }
> +
> +               if (anon_exclusive && page_try_share_anon_rmap(page)) {
> +                       set_pte_at(mm, pvmw.address, pvmw.pte, entry);
> +                       goto out_unlock;
> +               }
> +
>                 if (pte_dirty(entry))
>                         set_page_dirty(page);
>
> @@ -1146,6 +1155,8 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
>                 pte_unmap_unlock(ptep, ptl);
>                 goto out_mn;
>         }
> +       VM_BUG_ON_PAGE(PageAnonExclusive(page), page);
> +       VM_BUG_ON_PAGE(PageAnon(kpage) && PageAnonExclusive(kpage), kpage);
>
>         /*
>          * No need to check ksm_use_zero_pages here: we can only have a
> diff --git a/mm/memory.c b/mm/memory.c
> index d01fab481134..222aaf277af4 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -720,6 +720,8 @@ static void restore_exclusive_pte(struct vm_area_struct *vma,
>         else if (is_writable_device_exclusive_entry(entry))
>                 pte = maybe_mkwrite(pte_mkdirty(pte), vma);
>
> +       VM_BUG_ON(pte_write(pte) && !(PageAnon(page) && PageAnonExclusive(page)));
> +
>         /*
>          * No need to take a page reference as one was already
>          * created when the swap entry was made.
> @@ -799,11 +801,12 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>
>                 rss[mm_counter(page)]++;
>
> -               if (is_writable_migration_entry(entry) &&
> +               if (!is_readable_migration_entry(entry) &&
>                                 is_cow_mapping(vm_flags)) {
>                         /*
> -                        * COW mappings require pages in both
> -                        * parent and child to be set to read.
> +                        * COW mappings require pages in both parent and child
> +                        * to be set to read. A previously exclusive entry is
> +                        * now shared.
>                          */
>                         entry = make_readable_migration_entry(
>                                                         swp_offset(entry));
> @@ -954,6 +957,7 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>                 ptep_set_wrprotect(src_mm, addr, src_pte);
>                 pte = pte_wrprotect(pte);
>         }
> +       VM_BUG_ON(page && PageAnon(page) && PageAnonExclusive(page));
>
>         /*
>          * If it's a shared mapping, mark it clean in
> @@ -2943,6 +2947,9 @@ static inline void wp_page_reuse(struct vm_fault *vmf)
>         struct vm_area_struct *vma = vmf->vma;
>         struct page *page = vmf->page;
>         pte_t entry;
> +
> +       VM_BUG_ON(PageAnon(page) && !PageAnonExclusive(page));
> +
>         /*
>          * Clear the pages cpupid information as the existing
>          * information potentially belongs to a now completely
> @@ -3277,6 +3284,13 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>         if (PageAnon(vmf->page)) {
>                 struct page *page = vmf->page;
>
> +               /*
> +                * If the page is exclusive to this process we must reuse the
> +                * page without further checks.
> +                */
> +               if (PageAnonExclusive(page))
> +                       goto reuse;
> +
>                 /*
>                  * We have to verify under page lock: these early checks are
>                  * just an optimization to avoid locking the page and freeing
> @@ -3309,6 +3323,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>                  */
>                 page_move_anon_rmap(page, vma);
>                 unlock_page(page);
> +reuse:
>                 wp_page_reuse(vmf);
>                 return VM_FAULT_WRITE;
>         } else if (unlikely((vma->vm_flags & (VM_WRITE|VM_SHARED)) ==
> @@ -3700,11 +3715,12 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>          * that are certainly not shared because we just allocated them without
>          * exposing them to the swapcache.
>          */
> -       if ((vmf->flags & FAULT_FLAG_WRITE) && !PageKsm(page) &&
> -           (page != swapcache || page_count(page) == 1)) {
> -               pte = maybe_mkwrite(pte_mkdirty(pte), vma);
> -               vmf->flags &= ~FAULT_FLAG_WRITE;
> -               ret |= VM_FAULT_WRITE;
> +       if (!PageKsm(page) && (page != swapcache || page_count(page) == 1)) {
> +               if (vmf->flags & FAULT_FLAG_WRITE) {
> +                       pte = maybe_mkwrite(pte_mkdirty(pte), vma);
> +                       vmf->flags &= ~FAULT_FLAG_WRITE;
> +                       ret |= VM_FAULT_WRITE;
> +               }
>                 rmap_flags |= RMAP_EXCLUSIVE;
>         }
>         flush_icache_page(vma, page);
> @@ -3724,6 +3740,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>                 page_add_anon_rmap(page, vma, vmf->address, rmap_flags);
>         }
>
> +       VM_BUG_ON(!PageAnon(page) || (pte_write(pte) && !PageAnonExclusive(page)));
>         set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
>         arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index fd9eba33b34a..7f440d2103ce 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -188,6 +188,8 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
>
>         VM_BUG_ON_PAGE(PageTail(page), page);
>         while (page_vma_mapped_walk(&pvmw)) {
> +               rmap_t rmap_flags = RMAP_NONE;
> +
>                 if (PageKsm(page))
>                         new = page;
>                 else
> @@ -217,6 +219,9 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
>                 else if (pte_swp_uffd_wp(*pvmw.pte))
>                         pte = pte_mkuffd_wp(pte);
>
> +               if (PageAnon(new) && !is_readable_migration_entry(entry))
> +                       rmap_flags |= RMAP_EXCLUSIVE;
> +
>                 if (unlikely(is_device_private_page(new))) {
>                         if (pte_write(pte))
>                                 entry = make_writable_device_private_entry(
> @@ -239,7 +244,7 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
>                         pte = arch_make_huge_pte(pte, shift, vma->vm_flags);
>                         if (PageAnon(new))
>                                 hugepage_add_anon_rmap(new, vma, pvmw.address,
> -                                                      RMAP_NONE);
> +                                                      rmap_flags);
>                         else
>                                 page_dup_file_rmap(new, true);
>                         set_huge_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte);
> @@ -248,7 +253,7 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
>                 {
>                         if (PageAnon(new))
>                                 page_add_anon_rmap(new, vma, pvmw.address,
> -                                                  RMAP_NONE);
> +                                                  rmap_flags);
>                         else
>                                 page_add_file_rmap(new, false);
>                         set_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte);
> @@ -379,6 +384,10 @@ int folio_migrate_mapping(struct address_space *mapping,
>                 /* No turning back from here */
>                 newfolio->index = folio->index;
>                 newfolio->mapping = folio->mapping;
> +               /*
> +                * Note: PG_anon_exclusive is always migrated via migration
> +                * entries.
> +                */
>                 if (folio_test_swapbacked(folio))
>                         __folio_set_swapbacked(newfolio);
>
> @@ -2302,15 +2311,34 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>                  * set up a special migration page table entry now.
>                  */
>                 if (trylock_page(page)) {
> +                       bool anon_exclusive;
>                         pte_t swp_pte;
>
> +                       anon_exclusive = PageAnon(page) && PageAnonExclusive(page);
> +                       if (anon_exclusive) {
> +                               flush_cache_page(vma, addr, pte_pfn(*ptep));
> +                               ptep_clear_flush(vma, addr, ptep);
> +
> +                               if (page_try_share_anon_rmap(page)) {
> +                                       set_pte_at(mm, addr, ptep, pte);
> +                                       unlock_page(page);
> +                                       put_page(page);
> +                                       mpfn = 0;
> +                                       goto next;
> +                               }
> +                       } else {
> +                               ptep_get_and_clear(mm, addr, ptep);
> +                       }
> +
>                         migrate->cpages++;
> -                       ptep_get_and_clear(mm, addr, ptep);
>
>                         /* Setup special migration page table entry */
>                         if (mpfn & MIGRATE_PFN_WRITE)
>                                 entry = make_writable_migration_entry(
>                                                         page_to_pfn(page));
> +                       else if (anon_exclusive)
> +                               entry = make_readable_exclusive_migration_entry(
> +                                                       page_to_pfn(page));
>                         else
>                                 entry = make_readable_migration_entry(
>                                                         page_to_pfn(page));
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 2887644fd150..9441675e993c 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -141,6 +141,7 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>                         pages++;
>                 } else if (is_swap_pte(oldpte)) {
>                         swp_entry_t entry = pte_to_swp_entry(oldpte);
> +                       struct page *page = pfn_swap_entry_to_page(entry);
>                         pte_t newpte;
>
>                         if (is_writable_migration_entry(entry)) {
> @@ -148,8 +149,11 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>                                  * A protection check is difficult so
>                                  * just be safe and disable write
>                                  */
> -                               entry = make_readable_migration_entry(
> -                                                       swp_offset(entry));
> +                               if (PageAnon(page))
> +                                       entry = make_readable_exclusive_migration_entry(
> +                                                            swp_offset(entry));
> +                               else
> +                                       entry = make_readable_migration_entry(swp_offset(entry));
>                                 newpte = swp_entry_to_pte(entry);
>                                 if (pte_swp_soft_dirty(oldpte))
>                                         newpte = pte_swp_mksoft_dirty(newpte);
> diff --git a/mm/rmap.c b/mm/rmap.c
> index ebe7140c4493..9d2a7e11e8cc 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1048,6 +1048,7 @@ EXPORT_SYMBOL_GPL(folio_mkclean);
>  void page_move_anon_rmap(struct page *page, struct vm_area_struct *vma)
>  {
>         struct anon_vma *anon_vma = vma->anon_vma;
> +       struct page *subpage = page;
>
>         page = compound_head(page);
>
> @@ -1061,6 +1062,7 @@ void page_move_anon_rmap(struct page *page, struct vm_area_struct *vma)
>          * PageAnon()) will not see one without the other.
>          */
>         WRITE_ONCE(page->mapping, (struct address_space *) anon_vma);
> +       SetPageAnonExclusive(subpage);
>  }
>
>  /**
> @@ -1078,7 +1080,7 @@ static void __page_set_anon_rmap(struct page *page,
>         BUG_ON(!anon_vma);
>
>         if (PageAnon(page))
> -               return;
> +               goto out;
>
>         /*
>          * If the page isn't exclusively mapped into this vma,
> @@ -1097,6 +1099,9 @@ static void __page_set_anon_rmap(struct page *page,
>         anon_vma = (void *) anon_vma + PAGE_MAPPING_ANON;
>         WRITE_ONCE(page->mapping, (struct address_space *) anon_vma);
>         page->index = linear_page_index(vma, address);
> +out:
> +       if (exclusive)
> +               SetPageAnonExclusive(page);
>  }
>
>  /**
> @@ -1156,6 +1161,8 @@ void page_add_anon_rmap(struct page *page,
>         } else {
>                 first = atomic_inc_and_test(&page->_mapcount);
>         }
> +       VM_BUG_ON_PAGE(!first && (flags & RMAP_EXCLUSIVE), page);
> +       VM_BUG_ON_PAGE(!first && PageAnonExclusive(page), page);
>
>         if (first) {
>                 int nr = compound ? thp_nr_pages(page) : 1;
> @@ -1422,7 +1429,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>         };
>         pte_t pteval;
>         struct page *subpage;
> -       bool ret = true;
> +       bool anon_exclusive, ret = true;
>         struct mmu_notifier_range range;
>         enum ttu_flags flags = (enum ttu_flags)(long)arg;
>
> @@ -1485,6 +1492,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>
>                 subpage = page - page_to_pfn(page) + pte_pfn(*pvmw.pte);
>                 address = pvmw.address;
> +               anon_exclusive = PageAnon(page) && PageAnonExclusive(subpage);
>
>                 if (PageHuge(page) && !PageAnon(page)) {
>                         /*
> @@ -1520,9 +1528,12 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>                         }
>                 }
>
> -               /* Nuke the page table entry. */
> +               /*
> +                * Nuke the page table entry. When having to clear
> +                * PageAnonExclusive(), we always have to flush.
> +                */
>                 flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
> -               if (should_defer_flush(mm, flags)) {
> +               if (should_defer_flush(mm, flags) && !anon_exclusive) {
>                         /*
>                          * We clear the PTE but do not flush so potentially
>                          * a remote CPU could still be writing to the page.
> @@ -1623,6 +1634,24 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>                                 page_vma_mapped_walk_done(&pvmw);
>                                 break;
>                         }
> +                       if (anon_exclusive &&
> +                           page_try_share_anon_rmap(subpage)) {
> +                               swap_free(entry);
> +                               set_pte_at(mm, address, pvmw.pte, pteval);
> +                               ret = false;
> +                               page_vma_mapped_walk_done(&pvmw);
> +                               break;
> +                       }
> +                       /*
> +                        * Note: We *don't* remember yet if the page was mapped
> +                        * exclusively in the swap entry, so swapin code has
> +                        * to re-determine that manually and might detect the
> +                        * page as possibly shared, for example, if there are
> +                        * other references on the page or if the page is under
> +                        * writeback. We made sure that there are no GUP pins
> +                        * on the page that would rely on it, so for GUP pins
> +                        * this is fine.
> +                        */
>                         if (list_empty(&mm->mmlist)) {
>                                 spin_lock(&mmlist_lock);
>                                 if (list_empty(&mm->mmlist))
> @@ -1723,7 +1752,7 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
>         };
>         pte_t pteval;
>         struct page *subpage;
> -       bool ret = true;
> +       bool anon_exclusive, ret = true;
>         struct mmu_notifier_range range;
>         enum ttu_flags flags = (enum ttu_flags)(long)arg;
>
> @@ -1782,6 +1811,7 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
>
>                 subpage = page - page_to_pfn(page) + pte_pfn(*pvmw.pte);
>                 address = pvmw.address;
> +               anon_exclusive = PageAnon(page) && PageAnonExclusive(subpage);
>
>                 if (PageHuge(page) && !PageAnon(page)) {
>                         /*
> @@ -1833,6 +1863,9 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
>                         swp_entry_t entry;
>                         pte_t swp_pte;
>
> +                       if (anon_exclusive)
> +                               BUG_ON(page_try_share_anon_rmap(subpage));
> +
>                         /*
>                          * Store the pfn of the page in a special migration
>                          * pte. do_swap_page() will wait until the migration
> @@ -1841,6 +1874,8 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
>                         entry = pte_to_swp_entry(pteval);
>                         if (is_writable_device_private_entry(entry))
>                                 entry = make_writable_migration_entry(pfn);
> +                       else if (anon_exclusive)
> +                               entry = make_readable_exclusive_migration_entry(pfn);
>                         else
>                                 entry = make_readable_migration_entry(pfn);
>                         swp_pte = swp_entry_to_pte(entry);
> @@ -1903,6 +1938,15 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
>                                 page_vma_mapped_walk_done(&pvmw);
>                                 break;
>                         }
> +                       VM_BUG_ON_PAGE(pte_write(pteval) && PageAnon(page) &&
> +                                      !anon_exclusive, page);
> +                       if (anon_exclusive &&
> +                           page_try_share_anon_rmap(subpage)) {
> +                               set_pte_at(mm, address, pvmw.pte, pteval);
> +                               ret = false;
> +                               page_vma_mapped_walk_done(&pvmw);
> +                               break;
> +                       }
>
>                         /*
>                          * Store the pfn of the page in a special migration
> @@ -1912,6 +1956,9 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
>                         if (pte_write(pteval))
>                                 entry = make_writable_migration_entry(
>                                                         page_to_pfn(subpage));
> +                       else if (anon_exclusive)
> +                               entry = make_readable_exclusive_migration_entry(
> +                                                       page_to_pfn(subpage));
>                         else
>                                 entry = make_readable_migration_entry(
>                                                         page_to_pfn(subpage));
> @@ -2425,6 +2472,8 @@ void hugepage_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
>         BUG_ON(!anon_vma);
>         /* address might be in next vma when migration races vma_adjust */
>         first = atomic_inc_and_test(compound_mapcount_ptr(page));
> +       VM_BUG_ON_PAGE(!first && (flags & RMAP_EXCLUSIVE), page);
> +       VM_BUG_ON_PAGE(!first && PageAnonExclusive(page), page);
>         if (first)
>                 __page_set_anon_rmap(page, vma, address,
>                                      flags & RMAP_EXCLUSIVE);
> --
> 2.35.1
>

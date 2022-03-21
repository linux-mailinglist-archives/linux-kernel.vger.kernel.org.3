Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7074E3214
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 21:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236841AbiCUU6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 16:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbiCUU6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 16:58:23 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB0F199539
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:56:56 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id bc27so11152343pgb.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=klrycUV/09Xwf6oHyEFb9SP5ToWEkQQgoLcOxj1ZqBA=;
        b=Cg4nufAqZdO6jmN3Ea495gZ8lfFgsUkQtZkYnQCR1T6A9BUCJbz0nw5LNgJuPZsulc
         aA01jiHPzWT5Nwu2Lxc/8vWXJ4IozF0iYM3kGP7a0l18rXzkydfRNf0VXT/DQ9FrjM32
         hpof7UUeV+ziklYY9U45pMRCJpWPeKXTbK6WY5jNu0/NLxceE1CXkpvCsU53oFGhVbMF
         JhgrFIAlgGOW9YHyFKrsx/WEQ2boDXmONK0xxwAJUchknSVCBN8xRzPi2AW8XH/PtwlB
         rzSN7G/+gjEOTYqAtXxamWr57CRGiC129DIsDQQZGmb1wyLRjGrJu7DPMff4XPb2b74Z
         RoIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=klrycUV/09Xwf6oHyEFb9SP5ToWEkQQgoLcOxj1ZqBA=;
        b=Ig+bd6B+Vhi0Fl67q3FsSQJJ6NZLH/7+81+NmV+3a4Jji2CwSst0y/smCelEyYg/A6
         XDd3BkF9RjovLZ1KYI5vBNUdmfhSjfTeOmaB9fu7gddj6jKmV/mo1Zt1RTA349qeiws7
         PZpwdU4vecPPUmidg4k5fP2C4zroJvBnJCiKr2a/7CDZQaI1I5z9TpT3eNrDF7rpO13/
         6KNJP3ztzHzbJiOdcKA12nb4a+1uA4tCfCO2sHlMx9i4ZPJ6Bv2P2QqKZ8p5n/qRtUUI
         My22iGJnWAqOZd102AhnF4OYhxTZB1QcPLK7bzPZGZc7zmRN1rwGSH40Njv/Zy34twy5
         3fqw==
X-Gm-Message-State: AOAM532t1RYj414v86IVCQ4rD8y5vANbHVxpt23nXqo6kB7Sff7Z3dWg
        L8mNLQd04XSxNYVwNXg/H6tyOya6s2ugakWqDaA=
X-Google-Smtp-Source: ABdhPJwM8DSYOM1BuAPXdu9hIDLayNLTsAtMj8FwSb3k+G4BGSSWgGexiQ5qO2ZGVnDdH5sDuxnB0Tl5A1Lrz5l1xFA=
X-Received: by 2002:a05:6a00:b46:b0:4fa:ae95:cb59 with SMTP id
 p6-20020a056a000b4600b004faae95cb59mr3206644pfo.23.1647896216426; Mon, 21 Mar
 2022 13:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220315104741.63071-1-david@redhat.com> <20220315104741.63071-12-david@redhat.com>
 <CAHbLzkpTTf_16tDrS5TxWPif0ZOwFoJ1ys-PFtLhYK6XGowTYA@mail.gmail.com>
 <2b280ac6-9d39-58c5-b255-f39b1dac607b@redhat.com> <CAHbLzko_VjR6_rx+i8Qn9cKU3mvLC2A0t92ZtYqmE7QD5PH8pg@mail.gmail.com>
 <2505408d-6cc7-f14e-79a4-c5a1c716f737@redhat.com> <787e7ac7-917c-71eb-8050-a01f6a96a4cc@redhat.com>
In-Reply-To: <787e7ac7-917c-71eb-8050-a01f6a96a4cc@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 21 Mar 2022 13:56:44 -0700
Message-ID: <CAHbLzkoqVkSRQcfQbQ87F7mmAg1q=XapjGm_gxKV6njw7FJpGw@mail.gmail.com>
Subject: Re: [PATCH v2 11/15] mm: remember exclusively mapped anonymous pages
 with PG_anon_exclusive
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        Oded Gabbay <oded.gabbay@gmail.com>,
        Linux MM <linux-mm@kvack.org>
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

On Sat, Mar 19, 2022 at 3:50 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 19.03.22 11:21, David Hildenbrand wrote:
> > On 18.03.22 21:29, Yang Shi wrote:
> >> On Thu, Mar 17, 2022 at 2:06 AM David Hildenbrand <david@redhat.com> wrote:
> >>>
> >>> On 16.03.22 22:23, Yang Shi wrote:
> >>>> On Tue, Mar 15, 2022 at 3:52 AM David Hildenbrand <david@redhat.com> wrote:
> >>>>>
> >>>>> Let's mark exclusively mapped anonymous pages with PG_anon_exclusive as
> >>>>> exclusive, and use that information to make GUP pins reliable and stay
> >>>>> consistent with the page mapped into the page table even if the
> >>>>> page table entry gets write-protected.
> >>>>>
> >>>>> With that information at hand, we can extend our COW logic to always
> >>>>> reuse anonymous pages that are exclusive. For anonymous pages that
> >>>>> might be shared, the existing logic applies.
> >>>>>
> >>>>> As already documented, PG_anon_exclusive is usually only expressive in
> >>>>> combination with a page table entry. Especially PTE vs. PMD-mapped
> >>>>> anonymous pages require more thought, some examples: due to mremap() we
> >>>>> can easily have a single compound page PTE-mapped into multiple page tables
> >>>>> exclusively in a single process -- multiple page table locks apply.
> >>>>> Further, due to MADV_WIPEONFORK we might not necessarily write-protect
> >>>>> all PTEs, and only some subpages might be pinned. Long story short: once
> >>>>> PTE-mapped, we have to track information about exclusivity per sub-page,
> >>>>> but until then, we can just track it for the compound page in the head
> >>>>> page and not having to update a whole bunch of subpages all of the time
> >>>>> for a simple PMD mapping of a THP.
> >>>>>
> >>>>> For simplicity, this commit mostly talks about "anonymous pages", while
> >>>>> it's for THP actually "the part of an anonymous folio referenced via
> >>>>> a page table entry".
> >>>>>
> >>>>> To not spill PG_anon_exclusive code all over the mm code-base, we let
> >>>>> the anon rmap code to handle all PG_anon_exclusive logic it can easily
> >>>>> handle.
> >>>>>
> >>>>> If a writable, present page table entry points at an anonymous (sub)page,
> >>>>> that (sub)page must be PG_anon_exclusive. If GUP wants to take a reliably
> >>>>> pin (FOLL_PIN) on an anonymous page references via a present
> >>>>> page table entry, it must only pin if PG_anon_exclusive is set for the
> >>>>> mapped (sub)page.
> >>>>>
> >>>>> This commit doesn't adjust GUP, so this is only implicitly handled for
> >>>>> FOLL_WRITE, follow-up commits will teach GUP to also respect it for
> >>>>> FOLL_PIN without !FOLL_WRITE, to make all GUP pins of anonymous pages
> >>>>> fully reliable.
> >>>>>
> >>>>> Whenever an anonymous page is to be shared (fork(), KSM), or when
> >>>>> temporarily unmapping an anonymous page (swap, migration), the relevant
> >>>>> PG_anon_exclusive bit has to be cleared to mark the anonymous page
> >>>>> possibly shared. Clearing will fail if there are GUP pins on the page:
> >>>>> * For fork(), this means having to copy the page and not being able to
> >>>>>   share it. fork() protects against concurrent GUP using the PT lock and
> >>>>>   the src_mm->write_protect_seq.
> >>>>> * For KSM, this means sharing will fail. For swap this means, unmapping
> >>>>>   will fail, For migration this means, migration will fail early. All
> >>>>>   three cases protect against concurrent GUP using the PT lock and a
> >>>>>   proper clear/invalidate+flush of the relevant page table entry.
> >>>>>
> >>>>> This fixes memory corruptions reported for FOLL_PIN | FOLL_WRITE, when a
> >>>>> pinned page gets mapped R/O and the successive write fault ends up
> >>>>> replacing the page instead of reusing it. It improves the situation for
> >>>>> O_DIRECT/vmsplice/... that still use FOLL_GET instead of FOLL_PIN,
> >>>>> if fork() is *not* involved, however swapout and fork() are still
> >>>>> problematic. Properly using FOLL_PIN instead of FOLL_GET for these
> >>>>> GUP users will fix the issue for them.
> >>>>>
> >>>>> I. Details about basic handling
> >>>>>
> >>>>> I.1. Fresh anonymous pages
> >>>>>
> >>>>> page_add_new_anon_rmap() and hugepage_add_new_anon_rmap() will mark the
> >>>>> given page exclusive via __page_set_anon_rmap(exclusive=1). As that is
> >>>>> the mechanism fresh anonymous pages come into life (besides migration
> >>>>> code where we copy the page->mapping), all fresh anonymous pages will
> >>>>> start out as exclusive.
> >>>>>
> >>>>> I.2. COW reuse handling of anonymous pages
> >>>>>
> >>>>> When a COW handler stumbles over a (sub)page that's marked exclusive, it
> >>>>> simply reuses it. Otherwise, the handler tries harder under page lock to
> >>>>> detect if the (sub)page is exclusive and can be reused. If exclusive,
> >>>>> page_move_anon_rmap() will mark the given (sub)page exclusive.
> >>>>>
> >>>>> Note that hugetlb code does not yet check for PageAnonExclusive(), as it
> >>>>> still uses the old COW logic that is prone to the COW security issue
> >>>>> because hugetlb code cannot really tolerate unnecessary/wrong COW as
> >>>>> huge pages are a scarce resource.
> >>>>>
> >>>>> I.3. Migration handling
> >>>>>
> >>>>> try_to_migrate() has to try marking an exclusive anonymous page shared
> >>>>> via page_try_share_anon_rmap(). If it fails because there are GUP pins
> >>>>> on the page, unmap fails. migrate_vma_collect_pmd() and
> >>>>> __split_huge_pmd_locked() are handled similarly.
> >>>>>
> >>>>> Writable migration entries implicitly point at shared anonymous pages.
> >>>>> For readable migration entries that information is stored via a new
> >>>>> "readable-exclusive" migration entry, specific to anonymous pages.
> >>>>>
> >>>>> When restoring a migration entry in remove_migration_pte(), information
> >>>>> about exlusivity is detected via the migration entry type, and
> >>>>> RMAP_EXCLUSIVE is set accordingly for
> >>>>> page_add_anon_rmap()/hugepage_add_anon_rmap() to restore that
> >>>>> information.
> >>>>>
> >>>>> I.4. Swapout handling
> >>>>>
> >>>>> try_to_unmap() has to try marking the mapped page possibly shared via
> >>>>> page_try_share_anon_rmap(). If it fails because there are GUP pins on the
> >>>>> page, unmap fails. For now, information about exclusivity is lost. In the
> >>>>> future, we might want to remember that information in the swap entry in
> >>>>> some cases, however, it requires more thought, care, and a way to store
> >>>>> that information in swap entries.
> >>>>>
> >>>>> I.5. Swapin handling
> >>>>>
> >>>>> do_swap_page() will never stumble over exclusive anonymous pages in the
> >>>>> swap cache, as try_to_migrate() prohibits that. do_swap_page() always has
> >>>>> to detect manually if an anonymous page is exclusive and has to set
> >>>>> RMAP_EXCLUSIVE for page_add_anon_rmap() accordingly.
> >>>>>
> >>>>> I.6. THP handling
> >>>>>
> >>>>> __split_huge_pmd_locked() has to move the information about exclusivity
> >>>>> from the PMD to the PTEs.
> >>>>>
> >>>>> a) In case we have a readable-exclusive PMD migration entry, simply insert
> >>>>> readable-exclusive PTE migration entries.
> >>>>>
> >>>>> b) In case we have a present PMD entry and we don't want to freeze
> >>>>> ("convert to migration entries"), simply forward PG_anon_exclusive to
> >>>>> all sub-pages, no need to temporarily clear the bit.
> >>>>>
> >>>>> c) In case we have a present PMD entry and want to freeze, handle it
> >>>>> similar to try_to_migrate(): try marking the page shared first. In case
> >>>>> we fail, we ignore the "freeze" instruction and simply split ordinarily.
> >>>>> try_to_migrate() will properly fail because the THP is still mapped via
> >>>>> PTEs.
> >>>
> >>> Hi,
> >>>
> >>> thanks for the review!
> >>>
> >>>>
> >>>> How come will try_to_migrate() fail? The afterward pvmw will find
> >>>> those PTEs then convert them to migration entries anyway IIUC.
> >>>>
> >>>
> >>> It will run into that code:
> >>>
> >>>>> @@ -1903,6 +1938,15 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
> >>>>>                                 page_vma_mapped_walk_done(&pvmw);
> >>>>>                                 break;
> >>>>>                         }
> >>>>> +                       VM_BUG_ON_PAGE(pte_write(pteval) && PageAnon(page) &&
> >>>>> +                                      !anon_exclusive, page);
> >>>>> +                       if (anon_exclusive &&
> >>>>> +                           page_try_share_anon_rmap(subpage)) {
> >>>>> +                               set_pte_at(mm, address, pvmw.pte, pteval);
> >>>>> +                               ret = false;
> >>>>> +                               page_vma_mapped_walk_done(&pvmw);
> >>>>> +                               break;
> >>>>> +                       }
> >>>
> >>> and similarly fail the page_try_share_anon_rmap(), at which point
> >>> try_to_migrate() stops and the caller will still observe a
> >>> "page_mapped() == true".
> >>
> >> Thanks, I missed that. Yes, the page will still be mapped. This should
> >> trigger the VM_WARN_ON_ONCE in unmap_page(), if this change will make
> >> this happen more often, we may consider removing that warning even
> >> though it is "once" since seeing a mapped page may become a normal
> >> case (once DIO is switched to FOLL_PIN, it may be more often). Anyway
> >> we don't have to remove it right now.
> >
> > Oh, very good catch! I wasn't able to trigger that warning in my testing
> > so far. Interestingly, arch_unmap_one() could theoretically make this
> > fail already and trigger the warning.
> >
> > Apart from that warning, split_huge_page_to_list() should work as
> > expected: freezing the refcount will fail if still mapped and we'll remap.
> >
> > I'll include a separate patch to just remove that VM_WARN_ON_ONCE -- thanks!
> >
>
> From e6e983d841cd2aa2a9c8dc71779211881cf0d96f Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Sat, 19 Mar 2022 11:49:39 +0100
> Subject: [PATCH] mm/huge_memory: remove outdated VM_WARN_ON_ONCE_PAGE from
>  unmap_page()
>
> We can already theoretically fail to unmap (still having page_mapped()) in
> case arch_unmap_one() fails. Although this applies only to anonymous pages
> for now, get rid of the VM_WARN_ON_ONCE_PAGE() completely: the caller --
> split_huge_page_to_list() -- will fail to freeze the refcount and
> remap the page via remap_page(). So the caller can handle unmap errors
> just fine.
>
> This is a preparation for making try_to_migrate() fail on anonymous pages
> with GUP pins.

Better to mention "making try_to_migrate() fail on pinned anonymous
pages may make this happen more usual".

>
> Reported-by: Yang Shi <shy828301@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Fine to me. Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  mm/huge_memory.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 0b6fb409b9e4..0fe0ab3ec3fc 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2263,8 +2263,6 @@ static void unmap_page(struct page *page)
>                 try_to_migrate(page, ttu_flags);
>         else
>                 try_to_unmap(page, ttu_flags | TTU_IGNORE_MLOCK);
> -
> -       VM_WARN_ON_ONCE_PAGE(page_mapped(page), page);
>  }
>
>  static void remap_page(struct page *page, unsigned int nr)
> --
> 2.35.1
>
>
> --
> Thanks,
>
> David / dhildenb
>

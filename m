Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C4356057B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbiF2QLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbiF2QLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:11:08 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30BB30F6D
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:11:03 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id e132so187924pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QNGWyKk7b7OH2uoXfGLlgbosCtDAoP4ImNMPROj2AzI=;
        b=qM2+WP3NRFaf4WYrXWOZpW2B8d6z3I/tgsa0zNU7KHL9wJl1oKSVa67x0UqOiq6stC
         r+7VkOVeUA9IGogWN8nnlKrETvu9nf1uow079WedbfFc4IooPDT+VN1w11KsgeDnpt14
         4hjLaqzI1A5L+raNkDcAMDDDmrhlByzWW2vs/AlqzYmgAuiREwGlavsRTZYbbQTB0dVO
         +MgdG22YNOBxdwwmWbSy8cvn0blRdvs8LMs9Cye+7yHW/8mCULOo6DuL/Ajk2vImKzNq
         cAxvRxZSHXWABIS9tbF+p1kuNK2cAAw0+UNBEKFVqbkNFN3tg4jpAWCAW5cvMP1MgF2J
         kFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QNGWyKk7b7OH2uoXfGLlgbosCtDAoP4ImNMPROj2AzI=;
        b=0A9uS58czChSQHfq9HBV/NA7uyIXQqGbMaPM7pVeJm8GYBudy0iAABGi2352GwTDn+
         d5Ws6wKWMF6p3ujw2/dtyzzFd9dQLp9UiKuihVBWn3IBswt9jmOjE3sMDBry7paeBx4s
         xj+phyW7XIZz/huXAuVgMYQLL6VzfIeLwxtxLV9gMZuM1kSN4Kqaz6ZlnbCp9QgLH2sO
         F1sFk8OjP+JOBJJ/CGhqaMMHXgFmXSeH0E8Vl3uTYgZKPm6jJq4v+PWFSoPlHhj0rVpg
         e1dYyP/B6r71baq7RP8y/btCZ7bEkoAQzhvnUXo6K/4CXzDA6/TWcX81LWU7uPBIo+JT
         ya+A==
X-Gm-Message-State: AJIora/TvjSpVYDQV8wjE7kI/ONeadxe/UZ8W8MdZNBOsAiIdOYHhCf2
        SNwsnbKue5PqMpXyKe5nb/hIJhK9ZM2e0QUGdOvqaA==
X-Google-Smtp-Source: AGRyM1vWHTZK4sOOG39AoVUnM0BpQXEFUcvFDkwKfvwQMAUgV4SZLSj0NfZmGZYl0bbj9R9oFqyWfk9rMl5oTBkIclg=
X-Received: by 2002:a63:5449:0:b0:40d:c8d4:ed6a with SMTP id
 e9-20020a635449000000b0040dc8d4ed6amr3556661pgm.9.1656519063000; Wed, 29 Jun
 2022 09:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-13-jthoughton@google.com> <142229ce-fb50-992b-3b11-a1fb5f9175f9@nutanix.com>
In-Reply-To: <142229ce-fb50-992b-3b11-a1fb5f9175f9@nutanix.com>
From:   James Houghton <jthoughton@google.com>
Date:   Wed, 29 Jun 2022 09:10:52 -0700
Message-ID: <CADrL8HU4dAC13JgGjxNCyf5gut_pscEyVi9iB3BOaBxHsBrs-g@mail.gmail.com>
Subject: Re: [RFC PATCH 12/26] hugetlb: add HugeTLB splitting functionality
To:     "manish.mishra" <manish.mishra@nutanix.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 6:51 AM manish.mishra <manish.mishra@nutanix.com> wrote:
>
>
> On 24/06/22 11:06 pm, James Houghton wrote:
> > The new function, hugetlb_split_to_shift, will optimally split the page
> > table to map a particular address at a particular granularity.
> >
> > This is useful for punching a hole in the mapping and for mapping small
> > sections of a HugeTLB page (via UFFDIO_CONTINUE, for example).
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
> > ---
> >   mm/hugetlb.c | 122 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 122 insertions(+)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 3ec2a921ee6f..eaffe7b4f67c 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -102,6 +102,18 @@ struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
> >   /* Forward declaration */
> >   static int hugetlb_acct_memory(struct hstate *h, long delta);
> >
> > +/*
> > + * Find the subpage that corresponds to `addr` in `hpage`.
> > + */
> > +static struct page *hugetlb_find_subpage(struct hstate *h, struct page *hpage,
> > +                              unsigned long addr)
> > +{
> > +     size_t idx = (addr & ~huge_page_mask(h))/PAGE_SIZE;
> > +
> > +     BUG_ON(idx >= pages_per_huge_page(h));
> > +     return &hpage[idx];
> > +}
> > +
> >   static inline bool subpool_is_free(struct hugepage_subpool *spool)
> >   {
> >       if (spool->count)
> > @@ -7044,6 +7056,116 @@ static unsigned int __shift_for_hstate(struct hstate *h)
> >       for ((tmp_h) = hstate; (shift) = __shift_for_hstate(tmp_h), \
> >                              (tmp_h) <= &hstates[hugetlb_max_hstate]; \
> >                              (tmp_h)++)
> > +
> > +/*
> > + * Given a particular address, split the HugeTLB PTE that currently maps it
> > + * so that, for the given address, the PTE that maps it is `desired_shift`.
> > + * This function will always split the HugeTLB PTE optimally.
> > + *
> > + * For example, given a HugeTLB 1G page that is mapped from VA 0 to 1G. If we
> > + * call this function with addr=0 and desired_shift=PAGE_SHIFT, will result in
> > + * these changes to the page table:
> > + * 1. The PUD will be split into 2M PMDs.
> > + * 2. The first PMD will be split again into 4K PTEs.
> > + */
> > +static int hugetlb_split_to_shift(struct mm_struct *mm, struct vm_area_struct *vma,
> > +                        const struct hugetlb_pte *hpte,
> > +                        unsigned long addr, unsigned long desired_shift)
> > +{
> > +     unsigned long start, end, curr;
> > +     unsigned long desired_sz = 1UL << desired_shift;
> > +     struct hstate *h = hstate_vma(vma);
> > +     int ret;
> > +     struct hugetlb_pte new_hpte;
> > +     struct mmu_notifier_range range;
> > +     struct page *hpage = NULL;
> > +     struct page *subpage;
> > +     pte_t old_entry;
> > +     struct mmu_gather tlb;
> > +
> > +     BUG_ON(!hpte->ptep);
> > +     BUG_ON(hugetlb_pte_size(hpte) == desired_sz);
> can it be BUG_ON(hugetlb_pte_size(hpte) <= desired_sz)

Sure -- I think that's better.

> > +
> > +     start = addr & hugetlb_pte_mask(hpte);
> > +     end = start + hugetlb_pte_size(hpte);
> > +
> > +     i_mmap_assert_write_locked(vma->vm_file->f_mapping);
>
> As it is just changing mappings is holding f_mapping required? I mean in future
>
> is it any paln or way to use some per process level sub-lock?

We don't need to hold a per-mapping lock here, you're right; a per-VMA
lock will do just fine. I'll replace this with a per-VMA lock for the
next version.

>
> > +
> > +     BUG_ON(!hpte->ptep);
> > +     /* This function only works if we are looking at a leaf-level PTE. */
> > +     BUG_ON(!hugetlb_pte_none(hpte) && !hugetlb_pte_present_leaf(hpte));
> > +
> > +     /*
> > +      * Clear the PTE so that we will allocate the PT structures when
> > +      * walking the page table.
> > +      */
> > +     old_entry = huge_ptep_get_and_clear(mm, start, hpte->ptep);
> > +
> > +     if (!huge_pte_none(old_entry))
> > +             hpage = pte_page(old_entry);
> > +
> > +     BUG_ON(!IS_ALIGNED(start, desired_sz));
> > +     BUG_ON(!IS_ALIGNED(end, desired_sz));
> > +
> > +     for (curr = start; curr < end;) {
> > +             struct hstate *tmp_h;
> > +             unsigned int shift;
> > +
> > +             for_each_hgm_shift(h, tmp_h, shift) {
> > +                     unsigned long sz = 1UL << shift;
> > +
> > +                     if (!IS_ALIGNED(curr, sz) || curr + sz > end)
> > +                             continue;
> > +                     /*
> > +                      * If we are including `addr`, we need to make sure
> > +                      * splitting down to the correct size. Go to a smaller
> > +                      * size if we are not.
> > +                      */
> > +                     if (curr <= addr && curr + sz > addr &&
> > +                                     shift > desired_shift)
> > +                             continue;
> > +
> > +                     /*
> > +                      * Continue the page table walk to the level we want,
> > +                      * allocate PT structures as we go.
> > +                      */
>
> As i understand this for_each_hgm_shift loop is just to find right size of shift,
>
> then code below this line can be put out of loop, no strong feeling but it looks
>
> more proper may make code easier to understand.

Agreed. I'll clean this up.

>
> > +                     hugetlb_pte_copy(&new_hpte, hpte);
> > +                     ret = hugetlb_walk_to(mm, &new_hpte, curr, sz,
> > +                                           /*stop_at_none=*/false);
> > +                     if (ret)
> > +                             goto err;
> > +                     BUG_ON(hugetlb_pte_size(&new_hpte) != sz);
> > +                     if (hpage) {
> > +                             pte_t new_entry;
> > +
> > +                             subpage = hugetlb_find_subpage(h, hpage, curr);
> > +                             new_entry = make_huge_pte_with_shift(vma, subpage,
> > +                                                                  huge_pte_write(old_entry),
> > +                                                                  shift);
> > +                             set_huge_pte_at(mm, curr, new_hpte.ptep, new_entry);
> > +                     }
> > +                     curr += sz;
> > +                     goto next;
> > +             }
> > +             /* We couldn't find a size that worked. */
> > +             BUG();
> > +next:
> > +             continue;
> > +     }
> > +
> > +     mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
> > +                             start, end);
> > +     mmu_notifier_invalidate_range_start(&range);
>
> sorry did not understand where tlb flush will be taken care in case of success?
>
> I see set_huge_pte_at does not do it internally by self.

A TLB flush isn't necessary in the success case -- pages that were
mapped before will continue to be mapped the same way, so the TLB
entries will still be valid. If we're splitting a none P*D, then
there's nothing to flush. If we're splitting a present P*D, then the
flush will come if/when we clear any of the page table entries below
the P*D.

>
> > +     return 0;
> > +err:
> > +     tlb_gather_mmu(&tlb, mm);
> > +     /* Free any newly allocated page table entries. */
> > +     hugetlb_free_range(&tlb, hpte, start, curr);
> > +     /* Restore the old entry. */
> > +     set_huge_pte_at(mm, start, hpte->ptep, old_entry);
> > +     tlb_finish_mmu(&tlb);
> > +     return ret;
> > +}
> >   #endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
> >
> >   /*

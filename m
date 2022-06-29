Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0B25605A8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiF2QVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiF2QVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:21:00 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44143467D
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:20:59 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so19939367pjl.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4L513XqZtWyyXUpVXOUXgB+Yz/acGiL267AM+UDrZNg=;
        b=qkxMekTBZItQ/zNOCfAfRi3/DzuqeFleQ6plx9DO7uL6976c/L4h/6OGCmIOfGlmEF
         0m8LQRebbvSxS0fZazNR+by/7NyILW7ChgGq+TBwqfBNOwumgMw0E19ylcDVWn7EM+eX
         WtjfN6xjq9iMM+rSZzlA3e4D+LBNLytD2d7XI6M9+JIMDiUhMcYB7cPbOv6kObSfQVre
         ejdLKaTZ8w7iRdor6E1YZjUaocwm442pWZAd0xsOda93WTJu1lYhoj7HD17qBBDZjn3z
         Ze95ZmXGmOrEaXcR/EjqX2eT0gLlY/HN2beoynH/hn7WysVc4nObdGZ09Lb53SCu2xsm
         J2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4L513XqZtWyyXUpVXOUXgB+Yz/acGiL267AM+UDrZNg=;
        b=HVKRqRWkdMDtUTwVEdFCsbwEE86xXjAFCfW1WCIfSk/hJ86lhgrMnbBw37KQ3aRYjl
         Yf8S0Ucm8HwfcGDbB4jP+2Q7YGsquusN87//S8+QZBbK7qAAnWR1EEc3UjyRtuGyYTio
         SqT3vw0jdeNVjp3HRrSQpbLFIniTrufOjXcMDxkKNS+NSci21hZvmMEmOYMM28hUR4mq
         fYjCZpq/qprZyTraCXSKD4MJLaqCjamLCdtRSfEQNTKsBY+RG2YTPwyJeeumPURqgz7p
         LbaOV9aQTNOzRxnAIN5aSz4RVgcEPj0+3rzJo/rfKnV+cJWvn5Yxr13lIUZ2qHAyLhw3
         dWAQ==
X-Gm-Message-State: AJIora+DJ51M2I0xnmU9eb7/uIrAj/BwNwAvDPcPmqpiC6k8bluB/tti
        e+6rNY2r7b5KOkEsrN9uf5kkjYPSjk/uCGlsfcHKWQ==
X-Google-Smtp-Source: AGRyM1s9UrL6/EZvDiVNq4UVHYHW7ilzb1nDLUZxhfQu9FHb+sgfsvcNZQnmwK/2jxuacobw4Y9WcAxxSMWELyNTsb8=
X-Received: by 2002:a17:902:e94f:b0:16a:214e:46c1 with SMTP id
 b15-20020a170902e94f00b0016a214e46c1mr9880791pll.89.1656519659052; Wed, 29
 Jun 2022 09:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-13-jthoughton@google.com> <54e46486-8886-f5d4-4900-8a250bb5e805@nutanix.com>
In-Reply-To: <54e46486-8886-f5d4-4900-8a250bb5e805@nutanix.com>
From:   James Houghton <jthoughton@google.com>
Date:   Wed, 29 Jun 2022 09:20:48 -0700
Message-ID: <CADrL8HVALkfnwKQHyMBAxH0uNnZv1XJk8Z3teYepZyeJ4TJ2Xw@mail.gmail.com>
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

On Wed, Jun 29, 2022 at 7:33 AM manish.mishra <manish.mishra@nutanix.com> wrote:
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
> > +
> > +     start = addr & hugetlb_pte_mask(hpte);
> > +     end = start + hugetlb_pte_size(hpte);
> > +
> > +     i_mmap_assert_write_locked(vma->vm_file->f_mapping);
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
>
> Sorry missed it last time, what if hgm mapping present here and current hpte is
>
> at higher level. Where we will clear and free child page-table pages.
>
> I see it does not happen in huge_ptep_get_and_clear.

This shouldn't happen because earlier we have
BUG_ON(!hugetlb_pte_none(hpte) && !hugetlb_pte_present_leaf(hpte));

i.e., hpte must either be none or present and leaf-level.

>
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

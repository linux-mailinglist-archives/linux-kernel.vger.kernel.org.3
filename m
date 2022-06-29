Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD9D560503
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 17:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbiF2P47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 11:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbiF2P4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:56:49 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F6935243
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:56:45 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id jb13so14514239plb.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kCUdWx+8zFeiI8p1yBdUCZt9pfPgQmq59LSNKgh/kkw=;
        b=XcQ9EcpwZKZ+kR/xYk6otxffbGP+FN/1PkBK0Hm7RNs8GdUPI9DSOC/Hg2yw4wA2DK
         NJ799+xduKX53xJgUy+uXYWnIXbl/hHCi/8jzgQUmUweGnJm5/S8nexZQthnobOOGhuK
         JHszkaJyGubFmLTmbgJf5Rnvtx/zaDo7bigtWsUk3QTqUhsiTjROyRcaeEsLWNl/mUac
         6YwNru5JRRuN4v4az+RmqAniECyXRzeZWTAkT4uXGyfe0LbQLTfi8RyyoGf4vuzPyV5u
         Vm2HUC1u1Vqf99KX5S/ODrLTnJ1rcPf0/h0fGZcXXfnFaSnPgjoqh7dOeKqJupwR0jqA
         4LVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kCUdWx+8zFeiI8p1yBdUCZt9pfPgQmq59LSNKgh/kkw=;
        b=ped0Rafe1Bmmdbd3IYFIgHAAKpcZwVIdPIBELK2lQ2JsdDifK6YiLZmHwvIiJ+yB2Z
         r9cRBzlR9CGTZL7kGQUcjzyucqdjRu8Y+E9Sxa21wwvkL576u69frBAEZQqGbfNIf8Ze
         xXHMtpYjvUN/RxFAT8ZJrEhQ1S7NIIPlxV91fPl2MWkMCThxJWteruOr52iqcDpQZU9o
         js3fHmMWIvZVnnCBgxRBhM9Kt4LZxt7wofRMrA76x5PrCCStuljQc5h1LBGVwUgfy0cw
         z7uz8CTIrS5KeEOl8zHKrymuFQODRFNwVO75RRv+nBPK135an6nRQYmnQXFGDtodCyJU
         X7Hw==
X-Gm-Message-State: AJIora/qT/KqoCIEWl3jJ+ccQsRwnLh30FoeRP+IZO5P/sWd3M0RpPku
        26qjG6SGlj559G0EddsvYnxW8C+kXgJC0eqr5vkiJQ==
X-Google-Smtp-Source: AGRyM1t5jFpp2nPpnHCYV0jEoYsSRYyG8o8JbTi+Iu3pNbi16ZTWkuxmW/NaewXKaCfOG5lnqGGPd/Bvb+wkq0MLUag=
X-Received: by 2002:a17:903:2281:b0:16a:674e:8949 with SMTP id
 b1-20020a170903228100b0016a674e8949mr11161490plh.49.1656518204270; Wed, 29
 Jun 2022 08:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-15-jthoughton@google.com> <95d96d47-b72d-6089-b14f-d66fa882c16f@nutanix.com>
In-Reply-To: <95d96d47-b72d-6089-b14f-d66fa882c16f@nutanix.com>
From:   James Houghton <jthoughton@google.com>
Date:   Wed, 29 Jun 2022 08:56:32 -0700
Message-ID: <CADrL8HWQXXUEsuq5-6WXqkqLdUr6x0Ssk4BXREXHP+wGNgWv0g@mail.gmail.com>
Subject: Re: [RFC PATCH 14/26] hugetlb: add HGM support for hugetlb_fault and hugetlb_no_page
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

On Wed, Jun 29, 2022 at 7:41 AM manish.mishra <manish.mishra@nutanix.com> wrote:
>
>
> On 24/06/22 11:06 pm, James Houghton wrote:
> > This CL is the first main functional HugeTLB change. Together, these
> > changes allow the HugeTLB fault path to handle faults on HGM-enabled
> > VMAs. The two main behaviors that can be done now:
> >    1. Faults can be passed to handle_userfault. (Userspace will want to
> >       use UFFD_FEATURE_REAL_ADDRESS to get the real address to know which
> >       region they should be call UFFDIO_CONTINUE on later.)
> >    2. Faults on pages that have been partially mapped (and userfaultfd is
> >       not being used) will get mapped at the largest possible size.
> >       For example, if a 1G page has been partially mapped at 2M, and we
> >       fault on an unmapped 2M section, hugetlb_no_page will create a 2M
> >       PMD to map the faulting address.
> >
> > This commit does not handle hugetlb_wp right now, and it doesn't handle
> > HugeTLB page migration and swap entries.
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
> > ---
> >   include/linux/hugetlb.h |  12 ++++
> >   mm/hugetlb.c            | 121 +++++++++++++++++++++++++++++++---------
> >   2 files changed, 106 insertions(+), 27 deletions(-)
> >
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index 321f5745d87f..ac4ac8fbd901 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -1185,6 +1185,9 @@ enum split_mode {
> >   #ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> >   /* If HugeTLB high-granularity mappings are enabled for this VMA. */
> >   bool hugetlb_hgm_enabled(struct vm_area_struct *vma);
> > +int hugetlb_alloc_largest_pte(struct hugetlb_pte *hpte, struct mm_struct *mm,
> > +                           struct vm_area_struct *vma, unsigned long start,
> > +                           unsigned long end);
> >   int huge_pte_alloc_high_granularity(struct hugetlb_pte *hpte,
> >                                   struct mm_struct *mm,
> >                                   struct vm_area_struct *vma,
> > @@ -1197,6 +1200,15 @@ static inline bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
> >   {
> >       return false;
> >   }
> > +
> > +static inline
> > +int hugetlb_alloc_largest_pte(struct hugetlb_pte *hpte, struct mm_struct *mm,
> > +                           struct vm_area_struct *vma, unsigned long start,
> > +                           unsigned long end)
> > +{
> > +             BUG();
> > +}
> > +
> >   static inline int huge_pte_alloc_high_granularity(struct hugetlb_pte *hpte,
> >                                          struct mm_struct *mm,
> >                                          struct vm_area_struct *vma,
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 6e0c5fbfe32c..da30621656b8 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -5605,18 +5605,24 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
> >   static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
> >                       struct vm_area_struct *vma,
> >                       struct address_space *mapping, pgoff_t idx,
> > -                     unsigned long address, pte_t *ptep,
> > +                     unsigned long address, struct hugetlb_pte *hpte,
> >                       pte_t old_pte, unsigned int flags)
> >   {
> >       struct hstate *h = hstate_vma(vma);
> >       vm_fault_t ret = VM_FAULT_SIGBUS;
> >       int anon_rmap = 0;
> >       unsigned long size;
> > -     struct page *page;
> > +     struct page *page, *subpage;
> >       pte_t new_pte;
> >       spinlock_t *ptl;
> >       unsigned long haddr = address & huge_page_mask(h);
> > +     unsigned long haddr_hgm = address & hugetlb_pte_mask(hpte);
> >       bool new_page, new_pagecache_page = false;
> > +     /*
> > +      * This page is getting mapped for the first time, in which case we
> > +      * want to increment its mapcount.
> > +      */
> > +     bool new_mapping = hpte->shift == huge_page_shift(h);
> >
> >       /*
> >        * Currently, we are forced to kill the process in the event the
> > @@ -5665,9 +5671,9 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
> >                        * here.  Before returning error, get ptl and make
> >                        * sure there really is no pte entry.
> >                        */
> > -                     ptl = huge_pte_lock(h, mm, ptep);
> > +                     ptl = hugetlb_pte_lock(mm, hpte);
> >                       ret = 0;
> > -                     if (huge_pte_none(huge_ptep_get(ptep)))
> > +                     if (hugetlb_pte_none(hpte))
> >                               ret = vmf_error(PTR_ERR(page));
> >                       spin_unlock(ptl);
> >                       goto out;
> > @@ -5731,18 +5737,25 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
> >               vma_end_reservation(h, vma, haddr);
> >       }
> >
> > -     ptl = huge_pte_lock(h, mm, ptep);
> > +     ptl = hugetlb_pte_lock(mm, hpte);
> >       ret = 0;
> >       /* If pte changed from under us, retry */
> > -     if (!pte_same(huge_ptep_get(ptep), old_pte))
> > +     if (!pte_same(hugetlb_ptep_get(hpte), old_pte))
> >               goto backout;
> >
> > -     if (anon_rmap) {
> > -             ClearHPageRestoreReserve(page);
> > -             hugepage_add_new_anon_rmap(page, vma, haddr);
> > -     } else
> > -             page_dup_file_rmap(page, true);
> > -     new_pte = make_huge_pte(vma, page, ((vma->vm_flags & VM_WRITE)
> > +     if (new_mapping) {
> > +             /* Only increment this page's mapcount if we are mapping it
> > +              * for the first time.
> > +              */
> > +             if (anon_rmap) {
> > +                     ClearHPageRestoreReserve(page);
> > +                     hugepage_add_new_anon_rmap(page, vma, haddr);
> > +             } else
> > +                     page_dup_file_rmap(page, true);
> > +     }
> > +
> > +     subpage = hugetlb_find_subpage(h, page, haddr_hgm);
>
>                sorry did not understand why make_huge_pte we may be mapping just PAGE_SIZE
>
>                too here.
>

This should be make_huge_pte_with_shift(), with shift =
hugetlb_pte_shift(hpte). Thanks.

> > +     new_pte = make_huge_pte(vma, subpage, ((vma->vm_flags & VM_WRITE)
> >                               && (vma->vm_flags & VM_SHARED)));
> >       /*
> >        * If this pte was previously wr-protected, keep it wr-protected even
> > @@ -5750,12 +5763,13 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
> >        */
> >       if (unlikely(pte_marker_uffd_wp(old_pte)))
> >               new_pte = huge_pte_wrprotect(huge_pte_mkuffd_wp(new_pte));
> > -     set_huge_pte_at(mm, haddr, ptep, new_pte);
> > +     set_huge_pte_at(mm, haddr_hgm, hpte->ptep, new_pte);
> >
> > -     hugetlb_count_add(pages_per_huge_page(h), mm);
> > +     hugetlb_count_add(hugetlb_pte_size(hpte) / PAGE_SIZE, mm);
> >       if ((flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
> > +             BUG_ON(hugetlb_pte_size(hpte) != huge_page_size(h));
> >               /* Optimization, do the COW without a second fault */
> > -             ret = hugetlb_wp(mm, vma, address, ptep, flags, page, ptl);
> > +             ret = hugetlb_wp(mm, vma, address, hpte->ptep, flags, page, ptl);
> >       }
> >
> >       spin_unlock(ptl);
> > @@ -5816,11 +5830,15 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
> >       u32 hash;
> >       pgoff_t idx;
> >       struct page *page = NULL;
> > +     struct page *subpage = NULL;
> >       struct page *pagecache_page = NULL;
> >       struct hstate *h = hstate_vma(vma);
> >       struct address_space *mapping;
> >       int need_wait_lock = 0;
> >       unsigned long haddr = address & huge_page_mask(h);
> > +     unsigned long haddr_hgm;
> > +     bool hgm_enabled = hugetlb_hgm_enabled(vma);
> > +     struct hugetlb_pte hpte;
> >
> >       ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
> >       if (ptep) {
> > @@ -5866,11 +5884,22 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
> >       hash = hugetlb_fault_mutex_hash(mapping, idx);
> >       mutex_lock(&hugetlb_fault_mutex_table[hash]);
> >
> > -     entry = huge_ptep_get(ptep);
> > +     hugetlb_pte_populate(&hpte, ptep, huge_page_shift(h));
> > +
> > +     if (hgm_enabled) {
> > +             ret = hugetlb_walk_to(mm, &hpte, address,
> > +                                   PAGE_SIZE, /*stop_at_none=*/true);
> > +             if (ret) {
> > +                     ret = vmf_error(ret);
> > +                     goto out_mutex;
> > +             }
> > +     }
> > +
> > +     entry = hugetlb_ptep_get(&hpte);
> >       /* PTE markers should be handled the same way as none pte */
> > -     if (huge_pte_none_mostly(entry)) {
> > -             ret = hugetlb_no_page(mm, vma, mapping, idx, address, ptep,
> > -                                   entry, flags);
> > +     if (hugetlb_pte_none_mostly(&hpte)) {
> > +             ret = hugetlb_no_page(mm, vma, mapping, idx, address, &hpte,
> > +                             entry, flags);
> >               goto out_mutex;
> >       }
> >
> > @@ -5908,14 +5937,17 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
> >                                                               vma, haddr);
> >       }
> >
> > -     ptl = huge_pte_lock(h, mm, ptep);
> > +     ptl = hugetlb_pte_lock(mm, &hpte);
> >
> >       /* Check for a racing update before calling hugetlb_wp() */
> > -     if (unlikely(!pte_same(entry, huge_ptep_get(ptep))))
> > +     if (unlikely(!pte_same(entry, hugetlb_ptep_get(&hpte))))
> >               goto out_ptl;
> >
> > +     /* haddr_hgm is the base address of the region that hpte maps. */
> > +     haddr_hgm = address & hugetlb_pte_mask(&hpte);
> > +
> >       /* Handle userfault-wp first, before trying to lock more pages */
> > -     if (userfaultfd_wp(vma) && huge_pte_uffd_wp(huge_ptep_get(ptep)) &&
> > +     if (userfaultfd_wp(vma) && huge_pte_uffd_wp(hugetlb_ptep_get(&hpte)) &&
> >           (flags & FAULT_FLAG_WRITE) && !huge_pte_write(entry)) {
> >               struct vm_fault vmf = {
> >                       .vma = vma,
> > @@ -5939,7 +5971,8 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
> >        * pagecache_page, so here we need take the former one
> >        * when page != pagecache_page or !pagecache_page.
> >        */
> > -     page = pte_page(entry);
> > +     subpage = pte_page(entry);
> > +     page = compound_head(subpage);
> >       if (page != pagecache_page)
> >               if (!trylock_page(page)) {
> >                       need_wait_lock = 1;
> > @@ -5950,7 +5983,8 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
> >
> >       if (flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
> >               if (!huge_pte_write(entry)) {
> > -                     ret = hugetlb_wp(mm, vma, address, ptep, flags,
> > +                     BUG_ON(hugetlb_pte_size(&hpte) != huge_page_size(h));
>
> is it in respect to fact that userfault_wp is not support with HGM mapping currently? Not
>
> sure yet though how it is controlled may be next patches will have more details.

Yeah this BUG_ON is just because I haven't implemented support for
userfaultfd_wp yet (userfaultfd_wp for HugeTLB was added pretty
recently, while I was working on this patch series). I'll improve WP
support for the next version.

>
> > +                     ret = hugetlb_wp(mm, vma, address, hpte.ptep, flags,
> >                                        pagecache_page, ptl);
> >                       goto out_put_page;
> >               } else if (likely(flags & FAULT_FLAG_WRITE)) {
> > @@ -5958,9 +5992,9 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
> >               }
> >       }
> >       entry = pte_mkyoung(entry);
> > -     if (huge_ptep_set_access_flags(vma, haddr, ptep, entry,
> > +     if (huge_ptep_set_access_flags(vma, haddr_hgm, hpte.ptep, entry,
> >                                               flags & FAULT_FLAG_WRITE))
> > -             update_mmu_cache(vma, haddr, ptep);
> > +             update_mmu_cache(vma, haddr_hgm, hpte.ptep);
> >   out_put_page:
> >       if (page != pagecache_page)
> >               unlock_page(page);
> > @@ -6951,7 +6985,8 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
> >                               pte = (pte_t *)pmd_alloc(mm, pud, addr);
> >               }
> >       }
> > -     BUG_ON(pte && pte_present(*pte) && !pte_huge(*pte));
> > +     if (!hugetlb_hgm_enabled(vma))
> > +             BUG_ON(pte && pte_present(*pte) && !pte_huge(*pte));
> >
> >       return pte;
> >   }
> > @@ -7057,6 +7092,38 @@ static unsigned int __shift_for_hstate(struct hstate *h)
> >                              (tmp_h) <= &hstates[hugetlb_max_hstate]; \
> >                              (tmp_h)++)
> >
> > +/*
> > + * Allocate a HugeTLB PTE that maps as much of [start, end) as possible with a
> > + * single page table entry. The allocated HugeTLB PTE is returned in hpte.
> > + */
>
> Will it be used for madvise_collapase? If so will it make sense to keep it in different patch
>
> as this one title says just for handle_page_fault routines.

This is used by userfaultfd/UFFDIO_CONTINUE -- I will move this diff
to the patch that uses it (certainly shouldn't be in this patch).

>
> > +int hugetlb_alloc_largest_pte(struct hugetlb_pte *hpte, struct mm_struct *mm,
> > +                           struct vm_area_struct *vma, unsigned long start,
> > +                           unsigned long end)
> > +{
> > +     struct hstate *h = hstate_vma(vma), *tmp_h;
> > +     unsigned int shift;
> > +     int ret;
> > +
> > +     for_each_hgm_shift(h, tmp_h, shift) {
> > +             unsigned long sz = 1UL << shift;
> > +
> > +             if (!IS_ALIGNED(start, sz) || start + sz > end)
> > +                     continue;
> > +             ret = huge_pte_alloc_high_granularity(hpte, mm, vma, start,
> > +                                                   shift, HUGETLB_SPLIT_NONE,
> > +                                                   /*write_locked=*/false);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             if (hpte->shift > shift)
> > +                     return -EEXIST;
> > +
> > +             BUG_ON(hpte->shift != shift);
> > +             return 0;
> > +     }
> > +     return -EINVAL;
> > +}
> > +
> >   /*
> >    * Given a particular address, split the HugeTLB PTE that currently maps it
> >    * so that, for the given address, the PTE that maps it is `desired_shift`.

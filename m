Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC7B57A3D5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 17:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238621AbiGSP7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 11:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbiGSP7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 11:59:02 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AC85B79B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:59:00 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id o7so25565144lfq.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X1S5TtoSQXqK5WqybYLUxhmaSOZ2u6wrxsL5YiBhSlg=;
        b=jDY/hPetXJ/awjaBDcvbp+BF/EZNAfW3YImmfPTEDDQeTy2EXH1d7oWerkIicxi5J0
         sN+RAl8O7EP93p6mDWVINNjuENWwRZnAlAE/hjbAQu0k0DCOaeg4/5u309kzvRq6P2//
         m62lzwn1yKgXiBm4LXqa9oJrTGAaXj2FzcqeyjUgnicSsth5O8yRZRM7ErnSO6x/Z0Fo
         +FBZB0rQwVAtntI5TSYHWVJomNBH0ZkJvE4isgl1fj/T1385APhLmT5lQjBiseWJTgxq
         ce2QfSq9wunQFtMV+/C8WeyOgcq6rWm6+3MWMOvwkgXMOXvT9XozGaEBnsy9/f3GphIt
         9gqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X1S5TtoSQXqK5WqybYLUxhmaSOZ2u6wrxsL5YiBhSlg=;
        b=wK1ZIskRfDx762uKkl1dT1or1kOxpq0o+Rv4vAShjND8/6BYMcc/Ho8unJR22prpy1
         YDW+7WWqL7tsUsWFive+6STCeWJH1Dib6FQRmTKERc8aMxDqA0xmS9FQos3IEQFr2fD4
         +RLrBhzrUNDpyWuvI1cXSlwWPrrKUpdH/aLEXRVCH1qUEsmrLK3MWsuwmtWWltXJSCdb
         KkghrMVKHsGpqIvbMGtSjfJFU6lWPRUZPLKg8MHUO7+KuWEkX5WrJqiMyKz59IxCrpj0
         iKWjDt0GzMPrSog6M4qupWzVnRqOBNeS6ct20jz8kG8jeoNR5pf+dUNfKJjpfofCzet3
         2kgw==
X-Gm-Message-State: AJIora9TRYkV8jf+W2BgLec3g0f0OwRZtj2sGqk/avW3ElEkYDXyjp7F
        +/ZsaQQ1CoPXo3JGAAEeAu9R1bctsE3EkR09wWfjUg==
X-Google-Smtp-Source: AGRyM1tcfKUdWtrIwPmfry5TmGJLZZCKHdoMkL4f54xMW69je9PVb9qT13RT89mLIuR8fQeCsSVXVImpZmzuitTk0Y8=
X-Received: by 2002:a05:6512:3ed:b0:48a:23fe:765f with SMTP id
 n13-20020a05651203ed00b0048a23fe765fmr12187257lfq.592.1658246338717; Tue, 19
 Jul 2022 08:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-16-jthoughton@google.com> <22b5aa01-239d-8a06-3aaf-18bbd109ede8@nutanix.com>
In-Reply-To: <22b5aa01-239d-8a06-3aaf-18bbd109ede8@nutanix.com>
From:   James Houghton <jthoughton@google.com>
Date:   Tue, 19 Jul 2022 08:58:46 -0700
Message-ID: <CADrL8HUdPNuH6=p_Js617E55U_eyaR2+pYgpBnGNo=sKdxyvkQ@mail.gmail.com>
Subject: Re: [RFC PATCH 15/26] hugetlb: make unmapping compatible with
 high-granularity mappings
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 3:20 AM manish.mishra <manish.mishra@nutanix.com> wrote:
>
>
> On 24/06/22 11:06 pm, James Houghton wrote:
> > This enlightens __unmap_hugepage_range to deal with high-granularity
> > mappings. This doesn't change its API; it still must be called with
> > hugepage alignment, but it will correctly unmap hugepages that have been
> > mapped at high granularity.
> >
> > Analogous to the mapcount rules introduced by hugetlb_no_page, we only
> > drop mapcount in this case if we are unmapping an entire hugepage in one
> > operation. This is the case when a VMA is destroyed.
> >
> > Eventually, functionality here can be expanded to allow users to call
> > MADV_DONTNEED on PAGE_SIZE-aligned sections of a hugepage, but that is
> > not done here.
>
> Sorry i may have misunderstood something here, but allowing something like
>
> MADV_DONTNEED on PAGE_SIZE in hugetlbfs can cause fragmentation
>
> in hugetlbfs pool which kind of looks opposite of prupose of hugetlbfs?

It can be helpful for some applications, like if we want to get page
fault notifications through userfaultfd on a 4K piece of a hugepage.
It kind of goes against the purpose of HugeTLB, but we sort of get
this functionality automatically with this patch.

>
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
> > ---
> >   include/asm-generic/tlb.h |  6 +--
> >   mm/hugetlb.c              | 85 ++++++++++++++++++++++++++-------------
> >   2 files changed, 59 insertions(+), 32 deletions(-)
> >
> > diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> > index ff3e82553a76..8daa3ae460d9 100644
> > --- a/include/asm-generic/tlb.h
> > +++ b/include/asm-generic/tlb.h
> > @@ -562,9 +562,9 @@ static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
> >               __tlb_remove_tlb_entry(tlb, ptep, address);     \
> >       } while (0)
> >
> > -#define tlb_remove_huge_tlb_entry(h, tlb, ptep, address)     \
> > +#define tlb_remove_huge_tlb_entry(tlb, hpte, address)        \
> >       do {                                                    \
> > -             unsigned long _sz = huge_page_size(h);          \
> > +             unsigned long _sz = hugetlb_pte_size(&hpte);    \
> >               if (_sz >= P4D_SIZE)                            \
> >                       tlb_flush_p4d_range(tlb, address, _sz); \
> >               else if (_sz >= PUD_SIZE)                       \
> > @@ -573,7 +573,7 @@ static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
> >                       tlb_flush_pmd_range(tlb, address, _sz); \
> >               else                                            \
> >                       tlb_flush_pte_range(tlb, address, _sz); \
> > -             __tlb_remove_tlb_entry(tlb, ptep, address);     \
> > +             __tlb_remove_tlb_entry(tlb, hpte.ptep, address);\
> >       } while (0)
> >
> >   /**
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index da30621656b8..51fc1d3f122f 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -5120,24 +5120,20 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
> >   {
> >       struct mm_struct *mm = vma->vm_mm;
> >       unsigned long address;
> > -     pte_t *ptep;
> > +     struct hugetlb_pte hpte;
> >       pte_t pte;
> >       spinlock_t *ptl;
> > -     struct page *page;
> > +     struct page *hpage, *subpage;
> >       struct hstate *h = hstate_vma(vma);
> >       unsigned long sz = huge_page_size(h);
> >       struct mmu_notifier_range range;
> >       bool force_flush = false;
> > +     bool hgm_enabled = hugetlb_hgm_enabled(vma);
> >
> >       WARN_ON(!is_vm_hugetlb_page(vma));
> >       BUG_ON(start & ~huge_page_mask(h));
> >       BUG_ON(end & ~huge_page_mask(h));
> >
> > -     /*
> > -      * This is a hugetlb vma, all the pte entries should point
> > -      * to huge page.
> > -      */
> > -     tlb_change_page_size(tlb, sz);
> >       tlb_start_vma(tlb, vma);
> >
> >       /*
> > @@ -5148,25 +5144,43 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
> >       adjust_range_if_pmd_sharing_possible(vma, &range.start, &range.end);
> >       mmu_notifier_invalidate_range_start(&range);
> >       address = start;
> > -     for (; address < end; address += sz) {
> > -             ptep = huge_pte_offset(mm, address, sz);
> > -             if (!ptep)
> > +
> > +     while (address < end) {
> > +             pte_t *ptep = huge_pte_offset(mm, address, sz);
> > +
> > +             if (!ptep) {
> > +                     address += sz;
> >                       continue;
> > +             }
> > +             hugetlb_pte_populate(&hpte, ptep, huge_page_shift(h));
> > +             if (hgm_enabled) {
> > +                     int ret = huge_pte_alloc_high_granularity(
> > +                                     &hpte, mm, vma, address, PAGE_SHIFT,
> > +                                     HUGETLB_SPLIT_NEVER,
> > +                                     /*write_locked=*/true);
>
> I see huge_pte_alloc_high_granularity with HUGETLB_SPLIT_NEVER just
>
> do huge_tlb_walk. So is HUGETLB_SPLIT_NEVER even required, i mean
>
> for those cases you can directly do huge_tlb_walk? I mean name
>
> huge_pte_alloc_high_granularity confuses for those cases.

Agreed. huge_pte_alloc_high_granularity with HUGETLB_SPLIT_NEVER is
pretty much the same as hugetlb_walk_to (+hugetlb_pte_init). It is
confusing to have two ways of doing the exact same thing, so I'll get
rid of HUGETLB_SPLIT_NEVER (and the "alloc" name is confusing in this
case too, yeah).

>
> > +                     /*
> > +                      * We will never split anything, so this should always
> > +                      * succeed.
> > +                      */
> > +                     BUG_ON(ret);
> > +             }
> >
> > -             ptl = huge_pte_lock(h, mm, ptep);
> > -             if (huge_pmd_unshare(mm, vma, &address, ptep)) {
> > +             ptl = hugetlb_pte_lock(mm, &hpte);
> > +             if (!hgm_enabled && huge_pmd_unshare(
> > +                                     mm, vma, &address, hpte.ptep)) {
> >                       spin_unlock(ptl);
> >                       tlb_flush_pmd_range(tlb, address & PUD_MASK, PUD_SIZE);
> >                       force_flush = true;
> > -                     continue;
> > +                     goto next_hpte;
> >               }
> >
> > -             pte = huge_ptep_get(ptep);
> > -             if (huge_pte_none(pte)) {
> > +             if (hugetlb_pte_none(&hpte)) {
> >                       spin_unlock(ptl);
> > -                     continue;
> > +                     goto next_hpte;
> >               }
> >
> > +             pte = hugetlb_ptep_get(&hpte);
> > +
> >               /*
> >                * Migrating hugepage or HWPoisoned hugepage is already
> >                * unmapped and its refcount is dropped, so just clear pte here.
> > @@ -5180,24 +5194,27 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
> >                        */
> >                       if (pte_swp_uffd_wp_any(pte) &&
> >                           !(zap_flags & ZAP_FLAG_DROP_MARKER))
> > -                             set_huge_pte_at(mm, address, ptep,
> > +                             set_huge_pte_at(mm, address, hpte.ptep,
> >                                               make_pte_marker(PTE_MARKER_UFFD_WP));
> >                       else
> > -                             huge_pte_clear(mm, address, ptep, sz);
> > +                             huge_pte_clear(mm, address, hpte.ptep,
> > +                                             hugetlb_pte_size(&hpte));
> >                       spin_unlock(ptl);
> > -                     continue;
> > +                     goto next_hpte;
> >               }
> >
> > -             page = pte_page(pte);
> > +             subpage = pte_page(pte);
> > +             BUG_ON(!subpage);
> > +             hpage = compound_head(subpage);
> >               /*
> >                * If a reference page is supplied, it is because a specific
> >                * page is being unmapped, not a range. Ensure the page we
> >                * are about to unmap is the actual page of interest.
> >                */
> >               if (ref_page) {
> > -                     if (page != ref_page) {
> > +                     if (hpage != ref_page) {
> >                               spin_unlock(ptl);
> > -                             continue;
> > +                             goto next_hpte;
> >                       }
> >                       /*
> >                        * Mark the VMA as having unmapped its page so that
> > @@ -5207,25 +5224,35 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
> >                       set_vma_resv_flags(vma, HPAGE_RESV_UNMAPPED);
> >               }
> >
> > -             pte = huge_ptep_get_and_clear(mm, address, ptep);
> > -             tlb_remove_huge_tlb_entry(h, tlb, ptep, address);
> > +             pte = huge_ptep_get_and_clear(mm, address, hpte.ptep);
> > +             tlb_change_page_size(tlb, hugetlb_pte_size(&hpte));
> > +             tlb_remove_huge_tlb_entry(tlb, hpte, address);
> >               if (huge_pte_dirty(pte))
> > -                     set_page_dirty(page);
> > +                     set_page_dirty(hpage);
> >               /* Leave a uffd-wp pte marker if needed */
> >               if (huge_pte_uffd_wp(pte) &&
> >                   !(zap_flags & ZAP_FLAG_DROP_MARKER))
> > -                     set_huge_pte_at(mm, address, ptep,
> > +                     set_huge_pte_at(mm, address, hpte.ptep,
> >                                       make_pte_marker(PTE_MARKER_UFFD_WP));
> > -             hugetlb_count_sub(pages_per_huge_page(h), mm);
> > -             page_remove_rmap(page, vma, true);
> > +
> > +             hugetlb_count_sub(hugetlb_pte_size(&hpte)/PAGE_SIZE, mm);
> > +
> > +             /*
> > +              * If we are unmapping the entire page, remove it from the
> > +              * rmap.
> > +              */
> > +             if (IS_ALIGNED(address, sz) && address + sz <= end)
> > +                     page_remove_rmap(hpage, vma, true);
> >
> >               spin_unlock(ptl);
> > -             tlb_remove_page_size(tlb, page, huge_page_size(h));
> > +             tlb_remove_page_size(tlb, subpage, hugetlb_pte_size(&hpte));
> >               /*
> >                * Bail out after unmapping reference page if supplied
> >                */
> >               if (ref_page)
> >                       break;
> > +next_hpte:
> > +             address += hugetlb_pte_size(&hpte);
> >       }
> >       mmu_notifier_invalidate_range_end(&range);
> >       tlb_end_vma(tlb, vma);

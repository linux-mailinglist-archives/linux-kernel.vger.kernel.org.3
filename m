Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810F357A419
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 18:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbiGSQTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 12:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbiGSQTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 12:19:44 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE914F6B9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 09:19:43 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id q7so17937879lji.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 09:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BrqvVrOaDm2mbyP/RnfrNJ8rtAxk2BgRZfLzeM1+qLc=;
        b=Fk6lMSj51AUQX4dJS5Q2Kb0tfTfor4DoshfwFoKqjvNkOiduxXwJEIju1MzkIOm1p9
         g83YE66Q5BYok/Oblfr7qAA7/y5PjXLmDei1U4f50WuZZ+O3OnNx+rR9kPIRi0SGkcz4
         +4dQERTJBKGO0TfzbYaTtnM5ycSaT5tA423vIwe/Rv/UJ850JZ0xANli9XKdHqjXaZ5p
         I86p78NN/+0lbPZsJJ+hH7KsVCn/lELJdIFFHAVyleOFkmPVEHYxcg1BFzT47OM8GtM/
         yobhEhitHSeLHzdaOx4jOMBnoeoDi4kWkWBSlee7TnBm+3KuJN50ninNi3j55FpCGPfj
         R0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BrqvVrOaDm2mbyP/RnfrNJ8rtAxk2BgRZfLzeM1+qLc=;
        b=IkWZAzmEsXQTB78RNxHjkZKQcwOySVWBqkZXl3lEwlF7ppeYpPnwIxguuzRyaPvkAY
         6SkX0kIVhWd+ZynvAeF6wk7sBsGigGJ6DmoCq7BiQHPU+CHkNt0yWP7EKKkBBziGgXkw
         6w369IRuySsW2tVnGp48HFMpvoB6Awc4aT3Na4buDLO+WYdwa5uXUxXB27IN62/+zofS
         PJBoIwfO5V1MWerxjcK4bmtCPU4sBqUr+07l9O3sOtaz/ylVoAvmE+ybc5XOraUrTelm
         NDanSc7MoLSjuvH6oH4hMo3DdhK07KMoI9c58CrWYlL6zFSC+i/AiEaSI/duSR9BnNo4
         C+EA==
X-Gm-Message-State: AJIora9u5HolEjQkkXtzgR6W5um/xPsG/ojVtxL4zMoDrP64hUUbe94W
        HLajX1H8EPhSvxMr1awEoIU3737NvuP87mcoTtpR4Q==
X-Google-Smtp-Source: AGRyM1s3zNzRHlduviUIC8xxk6nzKcSddZSv4/5KWyNs43Q4TF497LJ02HtDbh6DIQIo40ErvfWF+Dg0VsyvfC+qdow=
X-Received: by 2002:a2e:7006:0:b0:25d:80b0:d16b with SMTP id
 l6-20020a2e7006000000b0025d80b0d16bmr15834985ljc.436.1658247581361; Tue, 19
 Jul 2022 09:19:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-18-jthoughton@google.com> <673a3024-bf82-3770-b737-4c7e53e70fe5@nutanix.com>
In-Reply-To: <673a3024-bf82-3770-b737-4c7e53e70fe5@nutanix.com>
From:   James Houghton <jthoughton@google.com>
Date:   Tue, 19 Jul 2022 09:19:29 -0700
Message-ID: <CADrL8HVFWidxaMZ++WfMfYb6pO2pEsDiVghe+8kKzE2kTvO9YA@mail.gmail.com>
Subject: Re: [RFC PATCH 17/26] hugetlb: update follow_hugetlb_page to support HGM
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

On Tue, Jul 19, 2022 at 3:48 AM manish.mishra <manish.mishra@nutanix.com> wrote:
>
>
> On 24/06/22 11:06 pm, James Houghton wrote:
> > This enables support for GUP, and it is needed for the KVM demand paging
> > self-test to work.
> >
> > One important change here is that, before, we never needed to grab the
> > i_mmap_sem, but now, to prevent someone from collapsing the page tables
> > out from under us, we grab it for reading when doing high-granularity PT
> > walks.
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
> > ---
> >   mm/hugetlb.c | 70 ++++++++++++++++++++++++++++++++++++++++++----------
> >   1 file changed, 57 insertions(+), 13 deletions(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index f9c7daa6c090..aadfcee947cf 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -6298,14 +6298,18 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
> >       unsigned long vaddr = *position;
> >       unsigned long remainder = *nr_pages;
> >       struct hstate *h = hstate_vma(vma);
> > +     struct address_space *mapping = vma->vm_file->f_mapping;
> >       int err = -EFAULT, refs;
> > +     bool has_i_mmap_sem = false;
> >
> >       while (vaddr < vma->vm_end && remainder) {
> >               pte_t *pte;
> >               spinlock_t *ptl = NULL;
> >               bool unshare = false;
> >               int absent;
> > +             unsigned long pages_per_hpte;
> >               struct page *page;
> > +             struct hugetlb_pte hpte;
> >
> >               /*
> >                * If we have a pending SIGKILL, don't keep faulting pages and
> > @@ -6325,9 +6329,23 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
> >                */
> >               pte = huge_pte_offset(mm, vaddr & huge_page_mask(h),
> >                                     huge_page_size(h));
> > -             if (pte)
> > -                     ptl = huge_pte_lock(h, mm, pte);
> > -             absent = !pte || huge_pte_none(huge_ptep_get(pte));
> > +             if (pte) {
> > +                     hugetlb_pte_populate(&hpte, pte, huge_page_shift(h));
> > +                     if (hugetlb_hgm_enabled(vma)) {
> > +                             BUG_ON(has_i_mmap_sem);
>
> Just thinking can we do without i_mmap_lock_read in most cases. Like earlier
>
> this function was good without i_mmap_lock_read doing almost everything
>
> which is happening now?

We need something to prevent the page tables from being rearranged
while we're walking them. In this RFC, I used the i_mmap_lock. I'm
going to change it, probably to a per-VMA lock (or maybe a per-hpage
lock. I'm trying to figure out if a system with PTLs/hugetlb_pte_lock
could work too :)).

>
> > +                             i_mmap_lock_read(mapping);
> > +                             /*
> > +                              * Need to hold the mapping semaphore for
> > +                              * reading to do a HGM walk.
> > +                              */
> > +                             has_i_mmap_sem = true;
> > +                             hugetlb_walk_to(mm, &hpte, vaddr, PAGE_SIZE,
> > +                                             /*stop_at_none=*/true);
> > +                     }
> > +                     ptl = hugetlb_pte_lock(mm, &hpte);
> > +             }
> > +
> > +             absent = !pte || hugetlb_pte_none(&hpte);
> >
> >               /*
> >                * When coredumping, it suits get_dump_page if we just return
> > @@ -6338,8 +6356,13 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
> >                */
> >               if (absent && (flags & FOLL_DUMP) &&
> >                   !hugetlbfs_pagecache_present(h, vma, vaddr)) {
> > -                     if (pte)
> > +                     if (pte) {
> > +                             if (has_i_mmap_sem) {
> > +                                     i_mmap_unlock_read(mapping);
> > +                                     has_i_mmap_sem = false;
> > +                             }
> >                               spin_unlock(ptl);
> > +                     }
> >                       remainder = 0;
> >                       break;
> >               }
> > @@ -6359,8 +6382,13 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
> >                       vm_fault_t ret;
> >                       unsigned int fault_flags = 0;
> >
> > -                     if (pte)
> > +                     if (pte) {
> > +                             if (has_i_mmap_sem) {
> > +                                     i_mmap_unlock_read(mapping);
> > +                                     has_i_mmap_sem = false;
> > +                             }
> >                               spin_unlock(ptl);
> > +                     }
> >                       if (flags & FOLL_WRITE)
> >                               fault_flags |= FAULT_FLAG_WRITE;
> >                       else if (unshare)
> > @@ -6403,8 +6431,11 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
> >                       continue;
> >               }
> >
> > -             pfn_offset = (vaddr & ~huge_page_mask(h)) >> PAGE_SHIFT;
> > -             page = pte_page(huge_ptep_get(pte));
> > +             pfn_offset = (vaddr & ~hugetlb_pte_mask(&hpte)) >> PAGE_SHIFT;
> > +             page = pte_page(hugetlb_ptep_get(&hpte));
> > +             pages_per_hpte = hugetlb_pte_size(&hpte) / PAGE_SIZE;
> > +             if (hugetlb_hgm_enabled(vma))
> > +                     page = compound_head(page);
> >
> >               VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
> >                              !PageAnonExclusive(page), page);
> > @@ -6414,17 +6445,21 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
> >                * and skip the same_page loop below.
> >                */
> >               if (!pages && !vmas && !pfn_offset &&
> > -                 (vaddr + huge_page_size(h) < vma->vm_end) &&
> > -                 (remainder >= pages_per_huge_page(h))) {
> > -                     vaddr += huge_page_size(h);
> > -                     remainder -= pages_per_huge_page(h);
> > -                     i += pages_per_huge_page(h);
> > +                 (vaddr + pages_per_hpte < vma->vm_end) &&
> > +                 (remainder >= pages_per_hpte)) {
> > +                     vaddr += pages_per_hpte;
> > +                     remainder -= pages_per_hpte;
> > +                     i += pages_per_hpte;
> >                       spin_unlock(ptl);
> > +                     if (has_i_mmap_sem) {
> > +                             has_i_mmap_sem = false;
> > +                             i_mmap_unlock_read(mapping);
> > +                     }
> >                       continue;
> >               }
> >
> >               /* vaddr may not be aligned to PAGE_SIZE */
> > -             refs = min3(pages_per_huge_page(h) - pfn_offset, remainder,
> > +             refs = min3(pages_per_hpte - pfn_offset, remainder,
> >                   (vma->vm_end - ALIGN_DOWN(vaddr, PAGE_SIZE)) >> PAGE_SHIFT);
> >
> >               if (pages || vmas)
> > @@ -6447,6 +6482,10 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
> >                       if (WARN_ON_ONCE(!try_grab_folio(pages[i], refs,
> >                                                        flags))) {
> >                               spin_unlock(ptl);
> > +                             if (has_i_mmap_sem) {
> > +                                     has_i_mmap_sem = false;
> > +                                     i_mmap_unlock_read(mapping);
> > +                             }
> >                               remainder = 0;
> >                               err = -ENOMEM;
> >                               break;
> > @@ -6458,8 +6497,13 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
> >               i += refs;
> >
> >               spin_unlock(ptl);
> > +             if (has_i_mmap_sem) {
> > +                     has_i_mmap_sem = false;
> > +                     i_mmap_unlock_read(mapping);
> > +             }
> >       }
> >       *nr_pages = remainder;
> > +     BUG_ON(has_i_mmap_sem);
> >       /*
> >        * setting position is actually required only if remainder is
> >        * not zero but it's faster not to add a "if (remainder)"
>
> Thanks
>
> Manish Mishra
>

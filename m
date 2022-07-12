Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499875727BE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 22:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbiGLUwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 16:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiGLUwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 16:52:22 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563B7C912D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 13:52:21 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id bf9so15893372lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 13:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iz3LrBt6Ku3myI5IwwlOusoVA0/X3ThdIo77BcqKEIY=;
        b=TvNekszX27wYHpN0/ZUw28oRMTdMI3ObkgaeKYJs55ORez5/V/UFePB6/aa7leY3F8
         Q2+OIT5QhqRY2mYJlnSn+sa3+Wom5ByQ7sHv5CH7fS77fKadZaNnvENGGE0isTfyRhmI
         eo/mBtgsAUI3Kg1RbGK1ocfcgg0GuTJAJdkcImTBGgRke+/+PWoHsidMPI/meUedaNKZ
         T89TObUdphEW2tB1mI/HAG6diFljiJ8Lt08Pa1tkf0B0OHGkC0//cspqEYq4YNnrIaVm
         K/WnNicP2YGDzbMBvzni/FwGhA3HQNR3QypCrcPxgkqTqL6P+JGGGUGNuks1OSXYO0CT
         8aWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iz3LrBt6Ku3myI5IwwlOusoVA0/X3ThdIo77BcqKEIY=;
        b=2frYCzpoBpR2k/mRhujU5jGiGKjv9drOLALNiBRneLbGY4rODR6znLS3VA7mmLgzYb
         Gaa2YvHuXoRH4a8rM3NwKuE2QEPIYZTom221u67VNibh4dZu2DG7MZeLEooF6yoSAOW8
         knwLmehzPaTl95/sbUvxyN1FsgATovr6xtbTetSFXRG+GmfBeYDGOnpZ9hwy0lJS1p98
         cWw8fwz1VPYs4oG7+VU9GKOq3mbgc7LZ0JmaJ5URoX/GxuHDvbbnX4n83IEuR81GTpVg
         n3HJlaKbEePt9wW3ZVjnbr5EnluP2imjHrClv5P6RGpxurqrrhoTVUsDQi7+5hmqquPi
         +XBA==
X-Gm-Message-State: AJIora/vQNOIKoKrnH9rAgjKkImodYhRXzrzAZ58Ohvvo+rd6XNn6BWN
        5/G0fjNp0U+HDQV/n7anWtwuMIzBCrW738r/NaIiig==
X-Google-Smtp-Source: AGRyM1tLpvyWd82tlSu90Ie0vUUnPmmjMdRdN7kOuJSQxjdEpGJ2aV8pRsQaQLXnt40GsSJHL2g5MiFaOEf1Eq0GxBs=
X-Received: by 2002:a05:6512:3f14:b0:47d:e011:f19b with SMTP id
 y20-20020a0565123f1400b0047de011f19bmr15571994lfa.427.1657659139495; Tue, 12
 Jul 2022 13:52:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-7-jthoughton@google.com> <Yrtl/4zHIzSzoc6p@monkey>
In-Reply-To: <Yrtl/4zHIzSzoc6p@monkey>
From:   James Houghton <jthoughton@google.com>
Date:   Tue, 12 Jul 2022 13:52:08 -0700
Message-ID: <CADrL8HX0rRY+2PWQHDSvL4yTqmyQ-tv9ouJXScKbUKDuC1yh2g@mail.gmail.com>
Subject: Re: [RFC PATCH 06/26] mm: make free_p?d_range functions public
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
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

On Tue, Jun 28, 2022 at 1:35 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 06/24/22 17:36, James Houghton wrote:
> > This makes them usable for HugeTLB page table freeing operations.
> > After HugeTLB high-granularity mapping, the page table for a HugeTLB VMA
> > can get more complex, and these functions handle freeing page tables
> > generally.
> >
>
> Hmmmm?
>
> free_pgd_range is not generally called directly for hugetlb mappings.
> There is a wrapper hugetlb_free_pgd_range which can have architecture
> specific implementations.  It makes me wonder if these lower level
> routines can be directly used on hugetlb mappings.  My 'guess' is that any
> such details will be hidden in the callers.  Suspect this will become clear
> in later patches.

Thanks for pointing out hugetlb_free_pgd_range. I think I'll need to
change how freeing HugeTLB HGM PTEs is written, because as written, we
don't do any architecture-specific things. I think I have a good idea
for what I need to do, probably something like this: make
`hugetlb_free_range` overridable, and then provide an implementation
for it for all the architectures that
HAVE_ARCH_HUGETLB_FREE_PGD_RANGE. Making the regular `free_p?d_range`
functions public *does* help with implementing the regular/general
`hugetlb_free_range` function though, so I think this commit is still
useful.

- James

> --
> Mike Kravetz
>
> > Signed-off-by: James Houghton <jthoughton@google.com>
> > ---
> >  include/linux/mm.h | 7 +++++++
> >  mm/memory.c        | 8 ++++----
> >  2 files changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index bc8f326be0ce..07f5da512147 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -1847,6 +1847,13 @@ void unmap_vmas(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
> >
> >  struct mmu_notifier_range;
> >
> > +void free_pte_range(struct mmu_gather *tlb, pmd_t *pmd, unsigned long addr);
> > +void free_pmd_range(struct mmu_gather *tlb, pud_t *pud, unsigned long addr,
> > +             unsigned long end, unsigned long floor, unsigned long ceiling);
> > +void free_pud_range(struct mmu_gather *tlb, p4d_t *p4d, unsigned long addr,
> > +             unsigned long end, unsigned long floor, unsigned long ceiling);
> > +void free_p4d_range(struct mmu_gather *tlb, pgd_t *pgd, unsigned long addr,
> > +             unsigned long end, unsigned long floor, unsigned long ceiling);
> >  void free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
> >               unsigned long end, unsigned long floor, unsigned long ceiling);
> >  int
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 7a089145cad4..bb3b9b5b94fb 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -227,7 +227,7 @@ static void check_sync_rss_stat(struct task_struct *task)
> >   * Note: this doesn't free the actual pages themselves. That
> >   * has been handled earlier when unmapping all the memory regions.
> >   */
> > -static void free_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
> > +void free_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
> >                          unsigned long addr)
> >  {
> >       pgtable_t token = pmd_pgtable(*pmd);
> > @@ -236,7 +236,7 @@ static void free_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
> >       mm_dec_nr_ptes(tlb->mm);
> >  }
> >
> > -static inline void free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
> > +inline void free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
> >                               unsigned long addr, unsigned long end,
> >                               unsigned long floor, unsigned long ceiling)
> >  {
> > @@ -270,7 +270,7 @@ static inline void free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
> >       mm_dec_nr_pmds(tlb->mm);
> >  }
> >
> > -static inline void free_pud_range(struct mmu_gather *tlb, p4d_t *p4d,
> > +inline void free_pud_range(struct mmu_gather *tlb, p4d_t *p4d,
> >                               unsigned long addr, unsigned long end,
> >                               unsigned long floor, unsigned long ceiling)
> >  {
> > @@ -304,7 +304,7 @@ static inline void free_pud_range(struct mmu_gather *tlb, p4d_t *p4d,
> >       mm_dec_nr_puds(tlb->mm);
> >  }
> >
> > -static inline void free_p4d_range(struct mmu_gather *tlb, pgd_t *pgd,
> > +inline void free_p4d_range(struct mmu_gather *tlb, pgd_t *pgd,
> >                               unsigned long addr, unsigned long end,
> >                               unsigned long floor, unsigned long ceiling)
> >  {
> > --
> > 2.37.0.rc0.161.g10f37bed90-goog
> >

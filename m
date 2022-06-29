Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB625605CC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiF2QZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiF2QZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:25:11 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EC12F3B7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:25:10 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id a15so15560636pfv.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N6VvmJRQtuo2S3B0wFS50nilldsbpYvrHHd8lXi05Kk=;
        b=TOjMeHu+OnMZK6JeEQD7qZfyQMON8FqsSxo1kf2SDRb7LP2cNuFWkSnELD/Umaa4v6
         OXrp5q9HdUjm1/HTr7wqymtDbtAPogv0qZZ++B8En2UEG9z22gCjPkdPugS0j+lPNowL
         pG0l8KK4teAjTSVKNVB5Sek2n2UkPh3MsIUtGUW/GCIww1HvPSJ76e8xgT+iXv4eyuu1
         CQmC6Dp7TzZ5VGPf4IQBHfIAMoQV+372LI4p44Rg8pEqeOndRqenwboWciXLzpmHa4PJ
         MXj4VGSCrNYf0yhU0vFTf9WqOO6EoBOdIjZdr7G/z8wZC00Jcn/8IuSvg+1fpswJUvaF
         dLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N6VvmJRQtuo2S3B0wFS50nilldsbpYvrHHd8lXi05Kk=;
        b=sKn+3/L/+096rVO2uN4K67eQvJHpwSF4aWNG1NrWcR6KeIzIFDrlTSKcyju+i4uTDT
         9sp14tsWSOiiK4TidD0Nh9hlY3JWME+nT6FIO4k6QS5Y9Xj6TM3XfSWK/E3uxDWSnatg
         HuSGRi+RLhT8tTuYXCU7oxk5815vx6ZsLoC9hsnCyxvuNNsfy+pegh0AGrygew5tCBZ0
         ZHFFcrCNYfeiZaKn+FgZn0kJCFOYL7EXjfwRcLu0cDcJX4sT+S7OSWbec3eJChMFFZ2D
         W7cP5VfLU9gjfRxEHpqQdKlwPVfFZLpXp0p/q0ycr2hCC8cOuQny6bwsxIbbgRejvMVj
         vE8g==
X-Gm-Message-State: AJIora/kCprhvpfKEFBINF5xQsUcSds+owc8byxyAUDDhc/2Kxs67rug
        hyMTyOmt73RnMqNuIIr7N/YtH2TEGHHdKZY8BSUF8g==
X-Google-Smtp-Source: AGRyM1sAEp+t8LFAqg8hLkws7EFa50iXlCRKyBackdYpXI7jNyBPL4iq/SpxayTxed2mDE7xKSnGpZHE37IhDB9rUjY=
X-Received: by 2002:a05:6a00:139b:b0:525:3e1b:f630 with SMTP id
 t27-20020a056a00139b00b005253e1bf630mr9865844pfg.54.1656519909758; Wed, 29
 Jun 2022 09:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-8-jthoughton@google.com> <YrtoSyxPLGTauptZ@monkey>
In-Reply-To: <YrtoSyxPLGTauptZ@monkey>
From:   James Houghton <jthoughton@google.com>
Date:   Wed, 29 Jun 2022 09:24:59 -0700
Message-ID: <CADrL8HVFAVuZ68TFimF2z1CymL6xRRdmGRcK8wCDo6hpfcxx=g@mail.gmail.com>
Subject: Re: [RFC PATCH 07/26] hugetlb: add hugetlb_pte to track HugeTLB page
 table entries
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

On Tue, Jun 28, 2022 at 1:45 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 06/24/22 17:36, James Houghton wrote:
> > After high-granularity mapping, page table entries for HugeTLB pages can
> > be of any size/type. (For example, we can have a 1G page mapped with a
> > mix of PMDs and PTEs.) This struct is to help keep track of a HugeTLB
> > PTE after we have done a page table walk.
> >
> > Without this, we'd have to pass around the "size" of the PTE everywhere.
> > We effectively did this before; it could be fetched from the hstate,
> > which we pass around pretty much everywhere.
> >
> > This commit includes definitions for some basic helper functions that
> > are used later. These helper functions wrap existing PTE
> > inspection/modification functions, where the correct version is picked
> > depending on if the HugeTLB PTE is actually "huge" or not. (Previously,
> > all HugeTLB PTEs were "huge").
> >
> > For example, hugetlb_ptep_get wraps huge_ptep_get and ptep_get, where
> > ptep_get is used when the HugeTLB PTE is PAGE_SIZE, and huge_ptep_get is
> > used in all other cases.
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
> > ---
> >  include/linux/hugetlb.h | 84 +++++++++++++++++++++++++++++++++++++++++
> >  mm/hugetlb.c            | 57 ++++++++++++++++++++++++++++
> >  2 files changed, 141 insertions(+)
>
> There is nothing 'wrong' with this patch, but it does make me wonder.
> After introducing hugetlb_pte, is all code dealing with hugetlb mappings
> going to be using hugetlb_ptes?  It would be quite confusing if there is
> a mix of hugetlb_ptes and non-hugetlb_ptes.  This will be revealed later
> in the series, but a comment about suture direction would be helpful
> here.

That is indeed the direction I am trying to go -- I'll make sure to
comment on this in this patch. I am planning to replace all other
non-hugetlb_pte uses with hugetlb_pte in the next version of this
series (I see it as necessary to get HGM merged).

> --
> Mike Kravetz
>
> >
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index 5fe1db46d8c9..1d4ec9dfdebf 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -46,6 +46,68 @@ enum {
> >       __NR_USED_SUBPAGE,
> >  };
> >
> > +struct hugetlb_pte {
> > +     pte_t *ptep;
> > +     unsigned int shift;
> > +};
> > +
> > +static inline
> > +void hugetlb_pte_init(struct hugetlb_pte *hpte)
> > +{
> > +     hpte->ptep = NULL;
> > +}
> > +
> > +static inline
> > +void hugetlb_pte_populate(struct hugetlb_pte *hpte, pte_t *ptep,
> > +                       unsigned int shift)
> > +{
> > +     BUG_ON(!ptep);
> > +     hpte->ptep = ptep;
> > +     hpte->shift = shift;
> > +}
> > +
> > +static inline
> > +unsigned long hugetlb_pte_size(const struct hugetlb_pte *hpte)
> > +{
> > +     BUG_ON(!hpte->ptep);
> > +     return 1UL << hpte->shift;
> > +}
> > +
> > +static inline
> > +unsigned long hugetlb_pte_mask(const struct hugetlb_pte *hpte)
> > +{
> > +     BUG_ON(!hpte->ptep);
> > +     return ~(hugetlb_pte_size(hpte) - 1);
> > +}
> > +
> > +static inline
> > +unsigned int hugetlb_pte_shift(const struct hugetlb_pte *hpte)
> > +{
> > +     BUG_ON(!hpte->ptep);
> > +     return hpte->shift;
> > +}
> > +
> > +static inline
> > +bool hugetlb_pte_huge(const struct hugetlb_pte *hpte)
> > +{
> > +     return !IS_ENABLED(CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING) ||
> > +             hugetlb_pte_shift(hpte) > PAGE_SHIFT;
> > +}
> > +
> > +static inline
> > +void hugetlb_pte_copy(struct hugetlb_pte *dest, const struct hugetlb_pte *src)
> > +{
> > +     dest->ptep = src->ptep;
> > +     dest->shift = src->shift;
> > +}
> > +
> > +bool hugetlb_pte_present_leaf(const struct hugetlb_pte *hpte);
> > +bool hugetlb_pte_none(const struct hugetlb_pte *hpte);
> > +bool hugetlb_pte_none_mostly(const struct hugetlb_pte *hpte);
> > +pte_t hugetlb_ptep_get(const struct hugetlb_pte *hpte);
> > +void hugetlb_pte_clear(struct mm_struct *mm, const struct hugetlb_pte *hpte,
> > +                    unsigned long address);
> > +
> >  struct hugepage_subpool {
> >       spinlock_t lock;
> >       long count;
> > @@ -1130,6 +1192,28 @@ static inline spinlock_t *huge_pte_lock_shift(unsigned int shift,
> >       return ptl;
> >  }
> >
> > +static inline
> > +spinlock_t *hugetlb_pte_lockptr(struct mm_struct *mm, struct hugetlb_pte *hpte)
> > +{
> > +
> > +     BUG_ON(!hpte->ptep);
> > +     // Only use huge_pte_lockptr if we are at leaf-level. Otherwise use
> > +     // the regular page table lock.
> > +     if (hugetlb_pte_none(hpte) || hugetlb_pte_present_leaf(hpte))
> > +             return huge_pte_lockptr(hugetlb_pte_shift(hpte),
> > +                             mm, hpte->ptep);
> > +     return &mm->page_table_lock;
> > +}
> > +
> > +static inline
> > +spinlock_t *hugetlb_pte_lock(struct mm_struct *mm, struct hugetlb_pte *hpte)
> > +{
> > +     spinlock_t *ptl = hugetlb_pte_lockptr(mm, hpte);
> > +
> > +     spin_lock(ptl);
> > +     return ptl;
> > +}
> > +
> >  #if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_CMA)
> >  extern void __init hugetlb_cma_reserve(int order);
> >  extern void __init hugetlb_cma_check(void);
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index d6d0d4c03def..1a1434e29740 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1120,6 +1120,63 @@ static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
> >       return false;
> >  }
> >
> > +bool hugetlb_pte_present_leaf(const struct hugetlb_pte *hpte)
> > +{
> > +     pgd_t pgd;
> > +     p4d_t p4d;
> > +     pud_t pud;
> > +     pmd_t pmd;
> > +
> > +     BUG_ON(!hpte->ptep);
> > +     if (hugetlb_pte_size(hpte) >= PGDIR_SIZE) {
> > +             pgd = *(pgd_t *)hpte->ptep;
> > +             return pgd_present(pgd) && pgd_leaf(pgd);
> > +     } else if (hugetlb_pte_size(hpte) >= P4D_SIZE) {
> > +             p4d = *(p4d_t *)hpte->ptep;
> > +             return p4d_present(p4d) && p4d_leaf(p4d);
> > +     } else if (hugetlb_pte_size(hpte) >= PUD_SIZE) {
> > +             pud = *(pud_t *)hpte->ptep;
> > +             return pud_present(pud) && pud_leaf(pud);
> > +     } else if (hugetlb_pte_size(hpte) >= PMD_SIZE) {
> > +             pmd = *(pmd_t *)hpte->ptep;
> > +             return pmd_present(pmd) && pmd_leaf(pmd);
> > +     } else if (hugetlb_pte_size(hpte) >= PAGE_SIZE)
> > +             return pte_present(*hpte->ptep);
> > +     BUG();
> > +}
> > +
> > +bool hugetlb_pte_none(const struct hugetlb_pte *hpte)
> > +{
> > +     if (hugetlb_pte_huge(hpte))
> > +             return huge_pte_none(huge_ptep_get(hpte->ptep));
> > +     return pte_none(ptep_get(hpte->ptep));
> > +}
> > +
> > +bool hugetlb_pte_none_mostly(const struct hugetlb_pte *hpte)
> > +{
> > +     if (hugetlb_pte_huge(hpte))
> > +             return huge_pte_none_mostly(huge_ptep_get(hpte->ptep));
> > +     return pte_none_mostly(ptep_get(hpte->ptep));
> > +}
> > +
> > +pte_t hugetlb_ptep_get(const struct hugetlb_pte *hpte)
> > +{
> > +     if (hugetlb_pte_huge(hpte))
> > +             return huge_ptep_get(hpte->ptep);
> > +     return ptep_get(hpte->ptep);
> > +}
> > +
> > +void hugetlb_pte_clear(struct mm_struct *mm, const struct hugetlb_pte *hpte,
> > +                    unsigned long address)
> > +{
> > +     BUG_ON(!hpte->ptep);
> > +     unsigned long sz = hugetlb_pte_size(hpte);
> > +
> > +     if (sz > PAGE_SIZE)
> > +             return huge_pte_clear(mm, address, hpte->ptep, sz);
> > +     return pte_clear(mm, address, hpte->ptep);
> > +}
> > +
> >  static void enqueue_huge_page(struct hstate *h, struct page *page)
> >  {
> >       int nid = page_to_nid(page);
> > --
> > 2.37.0.rc0.161.g10f37bed90-goog
> >

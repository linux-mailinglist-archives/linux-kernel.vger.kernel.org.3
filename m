Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EB55605E0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiF2Q23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiF2Q21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:28:27 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D6B1570C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:28:26 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id r1so14591245plo.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WMEgdAPQQye8Glp/fnIVfSYmpfNv27jLqCeyqgk1SYg=;
        b=cskqQl27Eh/L6xT4K43hvIpFanC+2rxDxc2vbwABvbS8xJgnkFMf3qxc9WoYUAK0NJ
         x8dNHh2btINl7Z4CepbwBjUyJ777VKxn9sDBDuyjc6LassDD/VzlCFUTaqAWWQpFmmPk
         XSg1BDOZmA9egOqEeOS/NOLG0SlpkVewGpGh3uYGz3dLItQWCnhZGoSptmAsml7/JHpQ
         C89H39ZEWnNEMQT7qFq3wrGAVRN1LMLmiDdyisFCRRX6pa8fHp77aKubB2ihpLuih/8X
         ljj1krUZq2hImxt27eFaaIG+Htln3J9xq1jEcdE0y+LLIWRSSjdI1n9/eNJXRSqbjo4M
         IVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WMEgdAPQQye8Glp/fnIVfSYmpfNv27jLqCeyqgk1SYg=;
        b=Elrek5WX/Wwrv0kz8PXqUQVeYAz37G0NdF+NiZo6tr6gyBQ7E40yHTGdPE6lbXIgQW
         VlPSTrYLU1rmwLub014/lETeM/dgGWEon3mClAI2DqeuLyhwSrgvtnW5XL7hHOrRAFxr
         UKoflnqisJTJMoYISgTerfGUUGbnG5/MQWUj6nTGZfmytrLF0Rrm2nhQI/wqrSGmBuGd
         R6RQfmusLTB6v/qviHEcDoxs5uvyVIGGDizOoqRnWI9BKRBCJDbIt1sHHoUUL2AwnL62
         G4NvsSPpqAqkjhcI1ciIOUYzMr43PMgL2jIDfD9DOwaGYJDQTRzWcnIsgSySZcpdcL7p
         BTrQ==
X-Gm-Message-State: AJIora+Bcn7/wPGhTBKEBBdmEYD1i7D27IIP6WfQ7KYpKj2ooQC8Zzhe
        MOE7JnZntvh351lPtS7c0p8LN7/t38iYiR6oRDnGgw==
X-Google-Smtp-Source: AGRyM1vOxUrB/PCyZARy8yxJh1/PuS4phGx0yEQ2cd2T1khgKhwvgcFxZAXOr8Ms1XTuH5AoTc2IvaH4O02HuB0BMkU=
X-Received: by 2002:a17:90a:9705:b0:1ef:1f35:12f1 with SMTP id
 x5-20020a17090a970500b001ef1f3512f1mr3793928pjo.235.1656520105947; Wed, 29
 Jun 2022 09:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-8-jthoughton@google.com> <562b3cbf-19dd-0453-855c-d4bc1c599230@nutanix.com>
In-Reply-To: <562b3cbf-19dd-0453-855c-d4bc1c599230@nutanix.com>
From:   James Houghton <jthoughton@google.com>
Date:   Wed, 29 Jun 2022 09:28:15 -0700
Message-ID: <CADrL8HXR-Le=kc+Vwznn4m=HJOKa3zj4SMLavFb81f_Rigoa_Q@mail.gmail.com>
Subject: Re: [RFC PATCH 07/26] hugetlb: add hugetlb_pte to track HugeTLB page
 table entries
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

On Mon, Jun 27, 2022 at 5:47 AM manish.mishra <manish.mishra@nutanix.com> wrote:
>
>
> On 24/06/22 11:06 pm, James Houghton wrote:
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
> >   include/linux/hugetlb.h | 84 +++++++++++++++++++++++++++++++++++++++++
> >   mm/hugetlb.c            | 57 ++++++++++++++++++++++++++++
> >   2 files changed, 141 insertions(+)
> >
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index 5fe1db46d8c9..1d4ec9dfdebf 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -46,6 +46,68 @@ enum {
> >       __NR_USED_SUBPAGE,
> >   };
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
> I agree it does not matter but still will hpte->shift = 0 too be better?
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
> >   struct hugepage_subpool {
> >       spinlock_t lock;
> >       long count;
> > @@ -1130,6 +1192,28 @@ static inline spinlock_t *huge_pte_lock_shift(unsigned int shift,
> >       return ptl;
> >   }
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
> >   #if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_CMA)
> >   extern void __init hugetlb_cma_reserve(int order);
> >   extern void __init hugetlb_cma_check(void);
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index d6d0d4c03def..1a1434e29740 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1120,6 +1120,63 @@ static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
> >       return false;
> >   }
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
>
> sorry did not understand in these conditions why
>
> hugetlb_pte_size(hpte) >= PGDIR_SIZE. I mean why >= check
>
> and not just == check?

I did >= PGDIR_SIZE just because it was consistent with the rest of
the sizes, but, indeed, > PGDIR_SIZE makes little sense, so I'll
replace it with ==.

>
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
>
> just for cosistency something like above?
>
> if (hugetlb_pte_huge(hpte))
> +               return huge_pte_clear
> ;

Will do, yes. (I added hugetlb_pte_huge quite late, and I guess I
missed updating this spot. :))

>
> > +     return pte_clear(mm, address, hpte->ptep);
> > +}
> > +
> >   static void enqueue_huge_page(struct hstate *h, struct page *page)
> >   {
> >       int nid = page_to_nid(page);

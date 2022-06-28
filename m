Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D9555EF96
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 22:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbiF1U2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 16:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbiF1U2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:28:18 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5D91C937
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:25:38 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id z66so13143979vsb.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Enhe/nonN+cjOXq0VkfmEAmv3jt9mvt8AKrDL/yyTa4=;
        b=Rx5Sf1FiofQmqFlsHUKetNpDiqLe6X3tIU4aiSmJvBRAYqoE9sL+qBVERKwWnwMfbx
         I3T5xfw85xlU+iQZvHg7QGgJTVPand15b7S3gi8JQu+bZLutZokdnkvKhRd1XxhASkYL
         4k4P4r012MlC/z4Mp/mwZFm4pIqsvPQF/oNQHsI5xhcJhw6KKsOLEwgzXhXrsMW7Ip5e
         15oSy2weWA5aVhX0PBO0xv1S9Rw+NF7vPODlhu2oWBrTK457zvxzlehOW8tr50P0g5Rl
         zE3cZ8Y/4hwS7mUAyetOFxPq0PwO1r5FETxIAUhQY5LtVkYx0xQMaRv/z5ov1cwqbv17
         ep2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Enhe/nonN+cjOXq0VkfmEAmv3jt9mvt8AKrDL/yyTa4=;
        b=r45JprW8DalRaCgDLRs8PW+waSpV3R1emKS7IK/vIhEmyYsM18z8eJVdPfYWnj8enn
         kvLEkEoWt2fCWywS8CMRsmEGrtv9i4CZwKdT9LNAmAVwnfMnmMdqt7BKu7wmj38B+lDg
         EXtE9rMIQ1Qg2SWtR5q36QXB4u0xy59qyV8V7tC2qMvv16bX0w5VbBHlPAFWAJD/hvQ6
         txf2tY0NoRzQR+cgpR0q5ywxMp4baTaoh2v4sgTwyEC61Brd1I02w++7hWk7ZUtX7S06
         QpktiKU4vREqgAw59MG/F/LyEHIkJ6qmSQdVBOpBCE8t9K8qd+IkqSDMoElMK5mvamQs
         Wsuw==
X-Gm-Message-State: AJIora/7I+IRSc+Ss6fGr2dEenwbW84U8uEc7doGdDe8B82AmwNzdcze
        OLajhdNYmIUoCQwICb+Yimv3LLKkooiabbbs8pgwAw==
X-Google-Smtp-Source: AGRyM1t0zvxZV+6K5EnJlEG+JRDrvBQyifa/s+ZMlTRWe7hYhBOlX03K5Qu9qT+JlLR85kbBFRgfWQiHtCZKYj80XRI=
X-Received: by 2002:a05:6102:f81:b0:354:3967:118a with SMTP id
 e1-20020a0561020f8100b003543967118amr2538942vsv.67.1656447937672; Tue, 28 Jun
 2022 13:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com> <20220624173656.2033256-8-jthoughton@google.com>
In-Reply-To: <20220624173656.2033256-8-jthoughton@google.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 28 Jun 2022 13:25:26 -0700
Message-ID: <CAHS8izM-xWCA6EuZP4=n3sg4OSVuD_NMJS6gCZHbLs7YN8Z+cg@mail.gmail.com>
Subject: Re: [RFC PATCH 07/26] hugetlb: add hugetlb_pte to track HugeTLB page
 table entries
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
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

On Fri, Jun 24, 2022 at 10:37 AM James Houghton <jthoughton@google.com> wrote:
>
> After high-granularity mapping, page table entries for HugeTLB pages can
> be of any size/type. (For example, we can have a 1G page mapped with a
> mix of PMDs and PTEs.) This struct is to help keep track of a HugeTLB
> PTE after we have done a page table walk.
>
> Without this, we'd have to pass around the "size" of the PTE everywhere.
> We effectively did this before; it could be fetched from the hstate,
> which we pass around pretty much everywhere.
>
> This commit includes definitions for some basic helper functions that
> are used later. These helper functions wrap existing PTE
> inspection/modification functions, where the correct version is picked
> depending on if the HugeTLB PTE is actually "huge" or not. (Previously,
> all HugeTLB PTEs were "huge").
>
> For example, hugetlb_ptep_get wraps huge_ptep_get and ptep_get, where
> ptep_get is used when the HugeTLB PTE is PAGE_SIZE, and huge_ptep_get is
> used in all other cases.
>
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  include/linux/hugetlb.h | 84 +++++++++++++++++++++++++++++++++++++++++
>  mm/hugetlb.c            | 57 ++++++++++++++++++++++++++++
>  2 files changed, 141 insertions(+)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 5fe1db46d8c9..1d4ec9dfdebf 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -46,6 +46,68 @@ enum {
>         __NR_USED_SUBPAGE,
>  };
>
> +struct hugetlb_pte {
> +       pte_t *ptep;
> +       unsigned int shift;
> +};
> +
> +static inline
> +void hugetlb_pte_init(struct hugetlb_pte *hpte)
> +{
> +       hpte->ptep = NULL;

shift = 0; ?

> +}
> +
> +static inline
> +void hugetlb_pte_populate(struct hugetlb_pte *hpte, pte_t *ptep,
> +                         unsigned int shift)
> +{
> +       BUG_ON(!ptep);
> +       hpte->ptep = ptep;
> +       hpte->shift = shift;
> +}
> +
> +static inline
> +unsigned long hugetlb_pte_size(const struct hugetlb_pte *hpte)
> +{
> +       BUG_ON(!hpte->ptep);
> +       return 1UL << hpte->shift;
> +}
> +

This helper is quite redundant in my opinion.

> +static inline
> +unsigned long hugetlb_pte_mask(const struct hugetlb_pte *hpte)
> +{
> +       BUG_ON(!hpte->ptep);
> +       return ~(hugetlb_pte_size(hpte) - 1);
> +}
> +
> +static inline
> +unsigned int hugetlb_pte_shift(const struct hugetlb_pte *hpte)
> +{
> +       BUG_ON(!hpte->ptep);
> +       return hpte->shift;
> +}
> +

This one jumps as quite redundant too.

> +static inline
> +bool hugetlb_pte_huge(const struct hugetlb_pte *hpte)
> +{
> +       return !IS_ENABLED(CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING) ||
> +               hugetlb_pte_shift(hpte) > PAGE_SHIFT;
> +}
> +

I'm guessing the !IS_ENABLED() check is because only the HGM code
would store a non-huge pte in a hugetlb_pte struct. I think it's a bit
fragile because anyone can add code in the future that uses
hugetlb_pte in unexpected ways, but I will concede that it is correct
as written.

> +static inline
> +void hugetlb_pte_copy(struct hugetlb_pte *dest, const struct hugetlb_pte *src)
> +{
> +       dest->ptep = src->ptep;
> +       dest->shift = src->shift;
> +}
> +
> +bool hugetlb_pte_present_leaf(const struct hugetlb_pte *hpte);
> +bool hugetlb_pte_none(const struct hugetlb_pte *hpte);
> +bool hugetlb_pte_none_mostly(const struct hugetlb_pte *hpte);
> +pte_t hugetlb_ptep_get(const struct hugetlb_pte *hpte);
> +void hugetlb_pte_clear(struct mm_struct *mm, const struct hugetlb_pte *hpte,
> +                      unsigned long address);
> +
>  struct hugepage_subpool {
>         spinlock_t lock;
>         long count;
> @@ -1130,6 +1192,28 @@ static inline spinlock_t *huge_pte_lock_shift(unsigned int shift,
>         return ptl;
>  }
>
> +static inline

Maybe for organization, move all the static functions you're adding
above the hugetlb_pte_* declarations you're adding?

> +spinlock_t *hugetlb_pte_lockptr(struct mm_struct *mm, struct hugetlb_pte *hpte)
> +{
> +
> +       BUG_ON(!hpte->ptep);
> +       // Only use huge_pte_lockptr if we are at leaf-level. Otherwise use
> +       // the regular page table lock.

Does checkpatch.pl not complain about // style comments? I think those
are not allowed, no?

> +       if (hugetlb_pte_none(hpte) || hugetlb_pte_present_leaf(hpte))
> +               return huge_pte_lockptr(hugetlb_pte_shift(hpte),
> +                               mm, hpte->ptep);
> +       return &mm->page_table_lock;
> +}
> +
> +static inline
> +spinlock_t *hugetlb_pte_lock(struct mm_struct *mm, struct hugetlb_pte *hpte)
> +{
> +       spinlock_t *ptl = hugetlb_pte_lockptr(mm, hpte);
> +
> +       spin_lock(ptl);
> +       return ptl;
> +}
> +
>  #if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_CMA)
>  extern void __init hugetlb_cma_reserve(int order);
>  extern void __init hugetlb_cma_check(void);
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index d6d0d4c03def..1a1434e29740 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1120,6 +1120,63 @@ static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
>         return false;
>  }
>
> +bool hugetlb_pte_present_leaf(const struct hugetlb_pte *hpte)
> +{
> +       pgd_t pgd;
> +       p4d_t p4d;
> +       pud_t pud;
> +       pmd_t pmd;
> +
> +       BUG_ON(!hpte->ptep);
> +       if (hugetlb_pte_size(hpte) >= PGDIR_SIZE) {
> +               pgd = *(pgd_t *)hpte->ptep;
> +               return pgd_present(pgd) && pgd_leaf(pgd);
> +       } else if (hugetlb_pte_size(hpte) >= P4D_SIZE) {
> +               p4d = *(p4d_t *)hpte->ptep;
> +               return p4d_present(p4d) && p4d_leaf(p4d);
> +       } else if (hugetlb_pte_size(hpte) >= PUD_SIZE) {
> +               pud = *(pud_t *)hpte->ptep;
> +               return pud_present(pud) && pud_leaf(pud);
> +       } else if (hugetlb_pte_size(hpte) >= PMD_SIZE) {
> +               pmd = *(pmd_t *)hpte->ptep;
> +               return pmd_present(pmd) && pmd_leaf(pmd);
> +       } else if (hugetlb_pte_size(hpte) >= PAGE_SIZE)
> +               return pte_present(*hpte->ptep);

The use of >= is a bit curious to me. Shouldn't these be ==?

Also probably doesn't matter but I was thinking to use *_SHIFTs
instead of *_SIZE so you don't have to calculate the size 5 times in
this routine, or calculate hugetlb_pte_size() once for some less code
duplication and re-use?

> +       BUG();
> +}
> +
> +bool hugetlb_pte_none(const struct hugetlb_pte *hpte)
> +{
> +       if (hugetlb_pte_huge(hpte))
> +               return huge_pte_none(huge_ptep_get(hpte->ptep));
> +       return pte_none(ptep_get(hpte->ptep));
> +}
> +
> +bool hugetlb_pte_none_mostly(const struct hugetlb_pte *hpte)
> +{
> +       if (hugetlb_pte_huge(hpte))
> +               return huge_pte_none_mostly(huge_ptep_get(hpte->ptep));
> +       return pte_none_mostly(ptep_get(hpte->ptep));
> +}
> +
> +pte_t hugetlb_ptep_get(const struct hugetlb_pte *hpte)
> +{
> +       if (hugetlb_pte_huge(hpte))
> +               return huge_ptep_get(hpte->ptep);
> +       return ptep_get(hpte->ptep);
> +}
> +
> +void hugetlb_pte_clear(struct mm_struct *mm, const struct hugetlb_pte *hpte,
> +                      unsigned long address)
> +{
> +       BUG_ON(!hpte->ptep);
> +       unsigned long sz = hugetlb_pte_size(hpte);
> +
> +       if (sz > PAGE_SIZE)
> +               return huge_pte_clear(mm, address, hpte->ptep, sz);
> +       return pte_clear(mm, address, hpte->ptep);
> +}
> +
>  static void enqueue_huge_page(struct hstate *h, struct page *page)
>  {
>         int nid = page_to_nid(page);
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>

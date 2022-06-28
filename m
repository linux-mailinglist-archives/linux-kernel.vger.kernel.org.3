Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF4455EF9B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 22:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbiF1U3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 16:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbiF1U3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:29:00 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807001A5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:27:57 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id q28so917818vsp.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2jLxzzGBS8SBXC6kEJLju797m9m9QFRVwbOOwePPZP8=;
        b=FXKxKU9S+Ca0kD67fbB4DM3QhjswVAkP5EfG/bmwZd9+oS/viVeF0g3nMSgjbgBjQD
         BTm0nkhvSHeFop49uJLDPAH+QUnh6aSOMJA/pNg4SqNw0RnB/Pve0FNEiGCmoamXZ7qw
         CxodY02mcA0FwKCgEdmRhHse5+Oa/5nLGexobXlYHnZc+NDAbkWkwT05Cwd8JVb5kxRK
         h9htBiCNZp0kHS0yI7m32r4d9Wlsrv4v3yobGATxY9IKnHeZriW6HpjtIHCvDDj27Kjs
         Cm16lEcK50A6DI2PZRLp35l58GgOGYxYbqd2FoFliqSp2toRJeSPuLGP2Wt2LpJVXe11
         0NXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2jLxzzGBS8SBXC6kEJLju797m9m9QFRVwbOOwePPZP8=;
        b=XdnWnMEt7TErX3JFXxcJN1KS4VBNB6tH6X8yBtplzwMZg158mzlChSq0ui9Aik2NMN
         Lo48aW8HAb6BcpKAXM6NUOXwolByN6JxT/BVxQc4e98u7981A4JpKhBM4jl5SMv7Oh7Q
         ZadshySFjsyA/38B1bAusGaNzB1F1S1isH1Uhg76gARiOO9AQ1HhK0udOaaX4lKiKSP8
         d99I9wd8ybQv2aapnmTga0lsfPqS4vKBQNgbo9vCdudaw7QWyONDzA6tVet83KH5/Hb4
         mak8xTM/0pIotOpKWm0xf1dWJxBlXztjuypxLRX3lgRuyRqciJb1Ylz8Mxaefmm5dzpy
         fDGg==
X-Gm-Message-State: AJIora/P9o3ZFOqzFGS1pyUctCfoX0PTt1tOui4wRhPrfzujFD/1ecrT
        yv+o03pxDDEsQiLxC2g28kVVlOWIovVaat6KM+ViCw==
X-Google-Smtp-Source: AGRyM1uEm5rLU/ghy5u7cLmUbBpWxSZfpFCDhs61n6N0NJIXCa3r5y/zwUxUQOzoSpyd/kmgK7Wu2MgsrA2V7UQLYPE=
X-Received: by 2002:a05:6102:101:b0:354:355b:711b with SMTP id
 z1-20020a056102010100b00354355b711bmr2710147vsq.61.1656448076572; Tue, 28 Jun
 2022 13:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com> <20220624173656.2033256-9-jthoughton@google.com>
In-Reply-To: <20220624173656.2033256-9-jthoughton@google.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 28 Jun 2022 13:27:44 -0700
Message-ID: <CAHS8izOhmp7PF++AaQTf403LpfW7ta1YyWQwRLkzopP0FADArQ@mail.gmail.com>
Subject: Re: [RFC PATCH 08/26] hugetlb: add hugetlb_free_range to free PT structures
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
> This is a helper function for freeing the bits of the page table that
> map a particular HugeTLB PTE.
>
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  include/linux/hugetlb.h |  2 ++
>  mm/hugetlb.c            | 17 +++++++++++++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 1d4ec9dfdebf..33ba48fac551 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -107,6 +107,8 @@ bool hugetlb_pte_none_mostly(const struct hugetlb_pte *hpte);
>  pte_t hugetlb_ptep_get(const struct hugetlb_pte *hpte);
>  void hugetlb_pte_clear(struct mm_struct *mm, const struct hugetlb_pte *hpte,
>                        unsigned long address);
> +void hugetlb_free_range(struct mmu_gather *tlb, const struct hugetlb_pte *hpte,
> +                       unsigned long start, unsigned long end);
>
>  struct hugepage_subpool {
>         spinlock_t lock;
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 1a1434e29740..a2d2ffa76173 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1120,6 +1120,23 @@ static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
>         return false;
>  }
>
> +void hugetlb_free_range(struct mmu_gather *tlb, const struct hugetlb_pte *hpte,
> +                       unsigned long start, unsigned long end)
> +{
> +       unsigned long floor = start & hugetlb_pte_mask(hpte);
> +       unsigned long ceiling = floor + hugetlb_pte_size(hpte);
> +
> +       if (hugetlb_pte_size(hpte) >= PGDIR_SIZE) {
> +               free_p4d_range(tlb, (pgd_t *)hpte->ptep, start, end, floor, ceiling);
> +       } else if (hugetlb_pte_size(hpte) >= P4D_SIZE) {
> +               free_pud_range(tlb, (p4d_t *)hpte->ptep, start, end, floor, ceiling);
> +       } else if (hugetlb_pte_size(hpte) >= PUD_SIZE) {
> +               free_pmd_range(tlb, (pud_t *)hpte->ptep, start, end, floor, ceiling);
> +       } else if (hugetlb_pte_size(hpte) >= PMD_SIZE) {
> +               free_pte_range(tlb, (pmd_t *)hpte->ptep, start);
> +       }

Same as the previous patch: I wonder about >=, and if possible
calculate hugetlb_pte_size() once, or use *_SHIFT comparison.

> +}
> +
>  bool hugetlb_pte_present_leaf(const struct hugetlb_pte *hpte)
>  {
>         pgd_t pgd;
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>

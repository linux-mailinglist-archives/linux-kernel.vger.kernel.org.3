Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70C94D6034
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348091AbiCKK4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbiCKK4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:56:34 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243B81B510C;
        Fri, 11 Mar 2022 02:55:31 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2d07ae0b1c4so88330117b3.11;
        Fri, 11 Mar 2022 02:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qlwCyDk8qlleYrAYeX+7n1Ivn6nloAFSh4xt8Gq150o=;
        b=oaYU4zv7z2lQ1xabpxAZyjYx0RA1wJsVPblkE5xVDqUf7Z10PTPs6cEpwKyIXaEZLp
         OR7FHaerSmPEUm9vpiREI5PHgfQIUR3LNKbaTrJ59BzycE9q6bxoG23jcyuHsza1KufN
         EQuoGUhNP4ua9p4MDDqkY+Hi1KIDssycuBolb6ZYVVVVJHBAHd4uoSOkZaAo2ZmSqaHi
         IpLg/FGBIvKw5JoL6Pgz+YTfcBHOi3war4xtv5GFc9k+2vDi+KNJx9qTZqgOdMCUymG2
         602cuilghZfUlapRNuKVU6exzuh6x5ooe3mnoP70gdJq9Ojs0rAhGMKT0SOjjlPu4NfP
         5tAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qlwCyDk8qlleYrAYeX+7n1Ivn6nloAFSh4xt8Gq150o=;
        b=LtmB0q4THveFr5dTMjzWBmosn9j58EuQRNmxsvhwdfiJjmMAiDg7CwNccvvdBJXNhu
         ZKiyfN9Oe7e08iQ0abW2a4uBxUuA8opGcmNDlOPwiWHx/YnUY8u5cQvtNEzjHhY/zwaO
         J2TMvSRYFSavCSAf9vaFmrFVvT3CRmsgK9fthyq7rm/XwA6uVsaZ6ihlyPqzB8AvVT1z
         WH6CgXdixGWiImnP+T13cioYU2HDC5+2S2D3GgI46F8WbEPKjjQW94LzY7Tj29SRz7EM
         8zPoK5szQ+QpY/60r1CJyTAm40FCYO5HspI+dzjIhpcqUiS1i5lyJWkdnBCEgNQsLoP7
         0fuw==
X-Gm-Message-State: AOAM532X3trf0O5CGwcTpPTcL0T33DfY7xIs1rSbUFSoLrcDZRZxZ/AN
        jp1bVNzTD9h2sUyl3zGREXYB8Ng0rF2mQrouKnU=
X-Google-Smtp-Source: ABdhPJxW4CPn/wNnPf2NhXuDc0qbrCNkJ5zhS0YrB60/r/3wkqcqNNWHHLNWpmFub9ERdIkvwy2HwUOOIS4OoJKLLp8=
X-Received: by 2002:a81:19c3:0:b0:2dc:2686:14e3 with SMTP id
 186-20020a8119c3000000b002dc268614e3mr7479905ywz.515.1646996130236; Fri, 11
 Mar 2022 02:55:30 -0800 (PST)
MIME-Version: 1.0
References: <20220309021230.721028-1-yuzhao@google.com> <20220309021230.721028-2-yuzhao@google.com>
In-Reply-To: <20220309021230.721028-2-yuzhao@google.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Fri, 11 Mar 2022 23:55:19 +1300
Message-ID: <CAGsJ_4yt_q4=pPW1M6fHN9HrV5JuTo9_9GQ0wv4-VT7tivU1+Q@mail.gmail.com>
Subject: Re: [PATCH v9 01/14] mm: x86, arm64: add arch_has_hw_pte_young()
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, page-reclaim@google.com,
        x86 <x86@kernel.org>, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 9, 2022 at 3:47 PM Yu Zhao <yuzhao@google.com> wrote:
>
> Some architectures automatically set the accessed bit in PTEs, e.g.,
> x86 and arm64 v8.2. On architectures that do not have this capability,
> clearing the accessed bit in a PTE usually triggers a page fault
> following the TLB miss of this PTE (to emulate the accessed bit).
>
> Being aware of this capability can help make better decisions, e.g.,
> whether to spread the work out over a period of time to reduce bursty
> page faults when trying to clear the accessed bit in many PTEs.
>
> Note that theoretically this capability can be unreliable, e.g.,
> hotplugged CPUs might be different from builtin ones. Therefore it
> should not be used in architecture-independent code that involves
> correctness, e.g., to determine whether TLB flushes are required (in
> combination with the accessed bit).
>
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> Acked-by: Brian Geffon <bgeffon@google.com>
> Acked-by: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
> Acked-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Acked-by: Steven Barrett <steven@liquorix.net>
> Acked-by: Suleiman Souhlal <suleiman@google.com>
> Acked-by: Will Deacon <will@kernel.org>
> Tested-by: Daniel Byrne <djbyrne@mtu.edu>
> Tested-by: Donald Carr <d@chaos-reins.com>
> Tested-by: Holger Hoffst=C3=A4tte <holger@applied-asynchrony.com>
> Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
> Tested-by: Shuang Zhai <szhai2@cs.rochester.edu>
> Tested-by: Sofia Trinh <sofia.trinh@edi.works>
> Tested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---

Reviewed-by: Barry Song <baohua@kernel.org>

i guess arch_has_hw_pte_young() isn't called that often in either
mm/memory.c or mm/vmscan.c.
Otherwise, moving to a static key might help. Is it?


>  arch/arm64/include/asm/pgtable.h | 14 ++------------
>  arch/x86/include/asm/pgtable.h   |  6 +++---
>  include/linux/pgtable.h          | 13 +++++++++++++
>  mm/memory.c                      | 14 +-------------
>  4 files changed, 19 insertions(+), 28 deletions(-)
>
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pg=
table.h
> index c4ba047a82d2..990358eca359 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -999,23 +999,13 @@ static inline void update_mmu_cache(struct vm_area_=
struct *vma,
>   * page after fork() + CoW for pfn mappings. We don't always have a
>   * hardware-managed access flag on arm64.
>   */
> -static inline bool arch_faults_on_old_pte(void)
> -{
> -       WARN_ON(preemptible());
> -
> -       return !cpu_has_hw_af();
> -}
> -#define arch_faults_on_old_pte         arch_faults_on_old_pte
> +#define arch_has_hw_pte_young          cpu_has_hw_af
>
>  /*
>   * Experimentally, it's cheap to set the access flag in hardware and we
>   * benefit from prefaulting mappings as 'old' to start with.
>   */
> -static inline bool arch_wants_old_prefaulted_pte(void)
> -{
> -       return !arch_faults_on_old_pte();
> -}
> -#define arch_wants_old_prefaulted_pte  arch_wants_old_prefaulted_pte
> +#define arch_wants_old_prefaulted_pte  cpu_has_hw_af
>
>  static inline pgprot_t arch_filter_pgprot(pgprot_t prot)
>  {
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtabl=
e.h
> index 8a9432fb3802..60b6ce45c2e3 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1423,10 +1423,10 @@ static inline bool arch_has_pfn_modify_check(void=
)
>         return boot_cpu_has_bug(X86_BUG_L1TF);
>  }
>
> -#define arch_faults_on_old_pte arch_faults_on_old_pte
> -static inline bool arch_faults_on_old_pte(void)
> +#define arch_has_hw_pte_young arch_has_hw_pte_young
> +static inline bool arch_has_hw_pte_young(void)
>  {
> -       return false;
> +       return true;
>  }
>
>  #endif /* __ASSEMBLY__ */
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index f4f4077b97aa..79f64dcff07d 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -259,6 +259,19 @@ static inline int pmdp_clear_flush_young(struct vm_a=
rea_struct *vma,
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  #endif
>
> +#ifndef arch_has_hw_pte_young
> +/*
> + * Return whether the accessed bit is supported on the local CPU.
> + *
> + * This stub assumes accessing through an old PTE triggers a page fault.
> + * Architectures that automatically set the access bit should overwrite =
it.
> + */
> +static inline bool arch_has_hw_pte_young(void)
> +{
> +       return false;
> +}
> +#endif
> +
>  #ifndef __HAVE_ARCH_PTEP_CLEAR
>  static inline void ptep_clear(struct mm_struct *mm, unsigned long addr,
>                               pte_t *ptep)
> diff --git a/mm/memory.c b/mm/memory.c
> index c125c4969913..a7379196a47e 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -122,18 +122,6 @@ int randomize_va_space __read_mostly =3D
>                                         2;
>  #endif
>
> -#ifndef arch_faults_on_old_pte
> -static inline bool arch_faults_on_old_pte(void)
> -{
> -       /*
> -        * Those arches which don't have hw access flag feature need to
> -        * implement their own helper. By default, "true" means pagefault
> -        * will be hit on old pte.
> -        */
> -       return true;
> -}
> -#endif
> -
>  #ifndef arch_wants_old_prefaulted_pte
>  static inline bool arch_wants_old_prefaulted_pte(void)
>  {
> @@ -2778,7 +2766,7 @@ static inline bool cow_user_page(struct page *dst, =
struct page *src,
>          * On architectures with software "accessed" bits, we would
>          * take a double page fault, so mark it accessed here.
>          */
> -       if (arch_faults_on_old_pte() && !pte_young(vmf->orig_pte)) {
> +       if (!arch_has_hw_pte_young() && !pte_young(vmf->orig_pte)) {
>                 pte_t entry;
>
>                 vmf->pte =3D pte_offset_map_lock(mm, vmf->pmd, addr, &vmf=
->ptl);
> --
> 2.35.1.616.g0bdcbb4464-goog
>

Thanks
Barry

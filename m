Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC07A5377FC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbiE3Jxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 05:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbiE3Jxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 05:53:53 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3694F4C7A2
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 02:53:52 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id q21so19820910ejm.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 02:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/GvOu9jW6S5+4oVzMixcNVhLNdEnzCcYD3edjuwGPVc=;
        b=HdW9GQCx+bCgSir5dMDLeeLq2QHB53EoPq91QzyFDy+2zT+XTRoKJwZHWUmt1ycWY6
         Gqg+hTu08GU/njqz49VVtX1sZjOv2NORFOSU6KCp1VDpUjNJgwL5QrPqrL8LLCuBEdNa
         0f066HUuOsd1O8m9MQ02uRUbteFTpKYwX7g1eeixbUbsroiREirUxltACpTNbBay/7jT
         Df1F9lr94la2ALlXMeUoraGe+fDS3XBR47iypamZ8O0WfCFJuwMCEM7QdlBeqsm81BUO
         +aNKYqomwLUshUUi7JWXF8exxoWC3Yx6LT65M8j/MQ1UUBrZOvuM0Jf9YX7Ag2K9LrKg
         WpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/GvOu9jW6S5+4oVzMixcNVhLNdEnzCcYD3edjuwGPVc=;
        b=4K7sStAC3WvKVS5UFDV9K34un+bquHZRIt0Wku7J5Ttzs6eMHaeZGeaz93yQjsrn+1
         pS6gx3o6Aj8gP1FGhg9CoxjBgY9KlZo6amGsWOwMv1JiK0WPhIjPlAJiuU+Wq6mGUc0H
         RnqchcMzNOPJek3S+Yg/3ifizPHzv0pf9RcPAf/UxbZ2KVCT/D+cHVqYnVVciyC/sk71
         q4PKpbs6XNj/ky4eFrfvjj831VyFruFJyapdFXLSv9ArP7H+x597QYZKKlH4dKC/nZil
         ZEYA1n5FRLNTZQ5SFe3FMTjm8kO1nJpNW/mdxhv23+DraaKwcgURepBuTI20iw2M2yeQ
         k/lw==
X-Gm-Message-State: AOAM533s5gxCjkzLhrKw0S+FXjhVKiBqYtf/8G641KpIHYPRr47kPe+v
        QasLBxI06qYA6XLDSuJPVnoUwNc3vFwqhFRdXAM=
X-Google-Smtp-Source: ABdhPJytOq9yrNqUOUH6v74F2jFDXshfmB/n4ZzKZr8SaFqO2WaA5koUnyJagRfJskJ1ZCbJwgripOABeowskfQOrFI=
X-Received: by 2002:a17:907:d87:b0:6fe:a2a0:2331 with SMTP id
 go7-20020a1709070d8700b006fea2a02331mr42654194ejc.702.1653904430683; Mon, 30
 May 2022 02:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220527100644.293717-1-21cnbao@gmail.com> <b2694573-a696-8435-70eb-ebc9c06500a0@arm.com>
In-Reply-To: <b2694573-a696-8435-70eb-ebc9c06500a0@arm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Mon, 30 May 2022 21:53:39 +1200
Message-ID: <CAGsJ_4yF_5DvBuvNfsUcywv8uzXHy2x9saVdhXz8xh=wvt01iA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: enable THP_SWAP for arm64
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?5byg6K+X5piOKFNpbW9uIFpoYW5nKQ==?= 
        <zhangshiming@oppo.com>, =?UTF-8?B?6YOt5YGl?= <guojian@oppo.com>,
        hanchuanhua <hanchuanhua@oppo.com>,
        Barry Song <v-songbaohua@oppo.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Steven Price <steven.price@arm.com>,
        Yang Shi <shy828301@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 7:07 PM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> Hello Barry,

Hi Anshuman,
thanks!

>
> On 5/27/22 15:36, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > THP_SWAP has been proved to improve the swap throughput significantly
> > on x86_64 according to commit bd4c82c22c367e ("mm, THP, swap: delay
> > splitting THP after swapped out").
> It will be useful to run similar experiments on arm64 platform to
> demonstrate tangible benefit, else we might be just enabling this
> feature just because x86 has it. Do you have some data points ?
>
> > As long as arm64 uses 4K page size, it is quite similar with x86_64
> > by having 2MB PMD THP. So we are going to get similar improvement.
>
> This is an assumption without any data points (until now). Please
> do provide some results.

Fair enough though I believe THP_SWP is arch-independent. Our testing
will post data. Plus, we do need it for real use cases with some possible
out-of-tree code for this moment. so this patch does not originate only
because x86 has it :-)

>
> > For other page sizes such as 16KB and 64KB, PMD might be too large.
> > Negative side effects such as IO latency might be a problem. Thus,
> > we can only safely enable the counterpart of X86_64.
>
> Incorrect reasoning. Although sometimes it might be okay to enable
> a feature on platforms with possible assumptions about its benefits,
> but to claim 'similar improvement, safely, .. etc' while comparing
> against x86 4K page config without data points, is not very helpful.
>
> > A corner case is that MTE has an assumption that only base pages
> > can be swapped. We won't enable THP_SWP for ARM64 hardware with
> > MTE support until MTE is re-arched.
>
> re-arched ?? Did you imply that MTE is reworked to support THP ?

I think at least MTE should be able to coexist with THP_SWP though
I am not quite sure if MTE can be re-worked to fully support THP.

>
> >
> > Cc: "Huang, Ying" <ying.huang@intel.com>
> > Cc: Minchan Kim <minchan@kernel.org>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> > Cc: Steven Price <steven.price@arm.com>
> > Cc: Yang Shi <shy828301@gmail.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  arch/arm64/Kconfig               |  1 +
> >  arch/arm64/include/asm/pgtable.h |  2 ++
> >  include/linux/huge_mm.h          | 12 ++++++++++++
> >  mm/swap_slots.c                  |  2 +-
> >  4 files changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index a4968845e67f..5306009df2dc 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -101,6 +101,7 @@ config ARM64
> >       select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> >       select ARCH_WANT_LD_ORPHAN_WARN
> >       select ARCH_WANTS_NO_INSTR
> > +     select ARCH_WANTS_THP_SWAP if ARM64_4K_PAGES
> >       select ARCH_HAS_UBSAN_SANITIZE_ALL
> >       select ARM_AMBA
> >       select ARM_ARCH_TIMER
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> > index 0b6632f18364..06076139c72c 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -45,6 +45,8 @@
> >       __flush_tlb_range(vma, addr, end, PUD_SIZE, false, 1)
> >  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> >
> > +#define arch_thp_swp_supported !system_supports_mte
>
> Does it check for 'system_supports_mte' as a symbol or call system_supports_mte()
> to ascertain runtime MTE support ? It might well be correct, but just does not
> look much intuitive.

yep. looks a bit weird. but considering we only need this for arm64
and arch_thp_swp_supported
is a macro, I can't find a better way to make code modification
smaller than this in mm core, arm64
and x86. and probably we will totally remove it once we make MTE
co-exist with THP_SWP.

Do you have any suggestions for a better solution?

>
> > +
> >  /*
> >   * Outside of a few very special situations (e.g. hibernation), we always
> >   * use broadcast TLB invalidation instructions, therefore a spurious page
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index de29821231c9..4ddaf6ad73ef 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -461,4 +461,16 @@ static inline int split_folio_to_list(struct folio *folio,
> >       return split_huge_page_to_list(&folio->page, list);
> >  }
> >
> > +/*
> > + * archs that select ARCH_WANTS_THP_SWAP but don't support THP_SWP due to
> > + * limitations in the implementation like arm64 MTE can override this to
>
> A small nit.
>
> A 'comma' here will be better. s/arm64 MTE can/arm64 MTE, can/

yep.

>
> > + * false
>
> Similarly a 'full stop' here will be better as well.
>

yep.

> > + */
> > +#ifndef arch_thp_swp_supported
> > +static inline bool arch_thp_swp_supported(void)
> > +{
> > +     return true;
> > +}
> > +#endif
> > +
> >  #endif /* _LINUX_HUGE_MM_H */
> > diff --git a/mm/swap_slots.c b/mm/swap_slots.c
> > index 2a65a89b5b4d..10b94d64cc25 100644
> > --- a/mm/swap_slots.c
> > +++ b/mm/swap_slots.c
> > @@ -307,7 +307,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
> >       entry.val = 0;
> >
> >       if (folio_test_large(folio)) {
> > -             if (IS_ENABLED(CONFIG_THP_SWAP))
> > +             if (IS_ENABLED(CONFIG_THP_SWAP) && arch_thp_swp_supported())
> >                       get_swap_pages(1, &entry, folio_nr_pages(folio));
> >               goto out;
> >       }
>
> - Anshuman

Thanks
Barry

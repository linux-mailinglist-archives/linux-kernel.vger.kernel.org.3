Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92E8578FCD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 03:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbiGSBXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 21:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiGSBXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 21:23:50 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2535C1DA7E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 18:23:49 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bp15so24483418ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 18:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mclhOC//AY1uYc+UCEJjIg2QXiyEbUhA2mv2jsaHI0Q=;
        b=QH9oQt2AEOu/ewN8sG04rqeKIyhjM3uQCrgAmmKg+uit4Wet7FLbO+lshXPn9esk8H
         2KXsCezB/KzbiTVTTBteCzvMshM2IHUY7C6vaDmW4rzYTdCyYQ+RQ+MErt14paRNd5HF
         OdblL6RLTTO94xskT1ymHhik0g2rmMze+HmNrtiZxjlou5kPJGEYcsjirxSEbzyuV0fe
         jVJK4m1PxxV+w4bBmLbM/4WsQYpsC2BG9cNZwk5FQbSSuBRAH+C+dABBprnxZ2wvJLR5
         odLGphU1nbK0Gxs235ejeV4ErK8NsAACKIuES+yfJnDZQJ1M2+G/2oSGx1ZP5J9nADTj
         NjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mclhOC//AY1uYc+UCEJjIg2QXiyEbUhA2mv2jsaHI0Q=;
        b=ogqrQmuPVMIUVv0Of39u4aGXtDuOmgH2VlGhqU3vpLV9zfjs9TIB70RlGF88sL5cEd
         H1HMw2HI9DKciJ3Bo4It/FlKLvlf2ye7pAFSy4N5kOPKV1CvQjVW6Omh+XfOcJLlk2aN
         FD8coSMQpSrZezOPXpDOmlLrtR4VMugUBv6Agfr5GTTlG7B0FYqXqkQ9nk7zu7380fin
         qFZzFNcxP4OUSqucl7VVEtyXsvZlgzfx3Avdkxqq2xB+uRrCgb2A25r4+NTU6k52uzXw
         qxxsN9TVInSH/TY3q27ioffSrF5Rb0Me65qO2R94qhEA7fhxutDUMTDtTkKZUy+kpSQH
         KHlQ==
X-Gm-Message-State: AJIora+M6T2tHGCxGVGPYIwTzBU3cOi+LixTj9Nra7V5HU4EkNpbPU0+
        xYvnvCMGHWiIjux8IHXSoBLyh79yRzPUrFUNVhE=
X-Google-Smtp-Source: AGRyM1u+Gp1Og86llNQtUdoP0OumsIscdyImPWSOUWgC0+1DmrWxc9MlqAIdHgS+8jCVRiYYdxFZJFypE6Fujh2dueE=
X-Received: by 2002:a17:906:93ef:b0:72b:44e2:bdd8 with SMTP id
 yl15-20020a17090693ef00b0072b44e2bdd8mr28310989ejb.192.1658193827745; Mon, 18
 Jul 2022 18:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220718090050.2261-1-21cnbao@gmail.com> <87mtd62apo.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87mtd62apo.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Tue, 19 Jul 2022 13:23:36 +1200
Message-ID: <CAGsJ_4zsNNb0mbR7Sm-=Hd7+fW4rXbnivCY1cF-wyio2EeETvA@mail.gmail.com>
Subject: Re: [RESEND PATCH v3] arm64: enable THP_SWAP for arm64
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        =?UTF-8?B?6YOt5YGl?= <guojian@oppo.com>,
        hanchuanhua <hanchuanhua@oppo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Barry Song <v-songbaohua@oppo.com>,
        =?UTF-8?B?5byg6K+X5piOKFNpbW9uIFpoYW5nKQ==?= 
        <zhangshiming@oppo.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 12:44 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > THP_SWAP has been proven to improve the swap throughput significantly
> > on x86_64 according to commit bd4c82c22c367e ("mm, THP, swap: delay
> > splitting THP after swapped out").
> > As long as arm64 uses 4K page size, it is quite similar with x86_64
> > by having 2MB PMD THP. THP_SWAP is architecture-independent, thus,
> > enabling it on arm64 will benefit arm64 as well.
> > A corner case is that MTE has an assumption that only base pages
> > can be swapped. We won't enable THP_SWAP for ARM64 hardware with
> > MTE support until MTE is reworked to coexist with THP_SWAP.
> >
> > A micro-benchmark is written to measure thp swapout throughput as
> > below,
> >
> >  unsigned long long tv_to_ms(struct timeval tv)
> >  {
> >       return tv.tv_sec * 1000 + tv.tv_usec / 1000;
> >  }
> >
> >  main()
> >  {
> >       struct timeval tv_b, tv_e;;
> >  #define SIZE 400*1024*1024
> >       volatile void *p = mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
> >                               MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> >       if (!p) {
> >               perror("fail to get memory");
> >               exit(-1);
> >       }
> >
> >       madvise(p, SIZE, MADV_HUGEPAGE);
> >       memset(p, 0x11, SIZE); /* write to get mem */
> >
> >       gettimeofday(&tv_b, NULL);
> >       madvise(p, SIZE, MADV_PAGEOUT);
> >       gettimeofday(&tv_e, NULL);
> >
> >       printf("swp out bandwidth: %ld bytes/ms\n",
> >                       SIZE/(tv_to_ms(tv_e) - tv_to_ms(tv_b)));
> >  }
> >
> > Testing is done on rk3568 64bit quad core processor Quad Core
> > Cortex-A55 platform - ROCK 3A.
> > thp swp throughput w/o patch: 2734bytes/ms (mean of 10 tests)
> > thp swp throughput w/  patch: 3331bytes/ms (mean of 10 tests)
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
> >  -v3:
> >  * refine the commit log;
> >  * add a benchmark result;
> >  * refine the macro of arch_thp_swp_supported
> >  Thanks to the comments of Anshuman, Andrew, Steven
> >
> >  arch/arm64/Kconfig               |  1 +
> >  arch/arm64/include/asm/pgtable.h |  6 ++++++
> >  include/linux/huge_mm.h          | 12 ++++++++++++
> >  mm/swap_slots.c                  |  2 +-
> >  4 files changed, 20 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 1652a9800ebe..e1c540e80eec 100644
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
> > index 0b6632f18364..78d6f6014bfb 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -45,6 +45,12 @@
> >       __flush_tlb_range(vma, addr, end, PUD_SIZE, false, 1)
> >  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> >
> > +static inline bool arch_thp_swp_supported(void)
> > +{
> > +     return !system_supports_mte();
> > +}
> > +#define arch_thp_swp_supported arch_thp_swp_supported
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
> > + * false
> > + */
> > +#ifndef arch_thp_swp_supported
> > +static inline bool arch_thp_swp_supported(void)
> > +{
> > +     return true;
> > +}
>
> How about the following?
>
> static inline bool arch_wants_thp_swap(void)
> {
>      return IS_ENABLED(ARCH_WANTS_THP_SWAP);
> }

This looks good. then i'll need to change arm64 to

 +static inline bool arch_thp_swp_supported(void)
 +{
 +     return IS_ENABLED(ARCH_WANTS_THP_SWAP) &&  !system_supports_mte();
 +}

>
> Best Regards,
> Huang, Ying
>
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

Thanks
Barry

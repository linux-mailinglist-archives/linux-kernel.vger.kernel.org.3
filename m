Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8162578B91
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 22:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbiGRUO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 16:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiGRUOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 16:14:54 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD95DF3B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 13:14:53 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id e15so16881781edj.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 13:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mRyn3MyNya4veUrOXgtJFR/zBUEHQj0h1AhfGm3iIco=;
        b=IvCsntT+j1o8ydquNf78ux6p0FEWCxes4Vy/KghbteDCngVUn4KGoDBYG0IZhJ9bID
         qZuve7mxNdJwTBZDLVBmi8QC3hIbNkvj1Gd973nydY8GnmGJmz4FVs7ZpPEtNJorGML7
         p1KmgXRb2qh5nwyei8Qi+xY/FKD4aUMqFk+FavBoqYx3iImvrxpUzprvnWID76ucPfhb
         559nnaC73OOTg8dGV+RpB9d62tZ3NGKIPlgZ/as/2SJH0fVczLBkyONCzUxPhowGMjYo
         53KOcK+QeWENhg+mt68F5X9vGJ3KtFKSBwBnSs5/dqSGTLsDNtbA2lyZmPh3xV/q2SiR
         451g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mRyn3MyNya4veUrOXgtJFR/zBUEHQj0h1AhfGm3iIco=;
        b=dwGq6H1MhQ1MTEQHo2rM3DRG1b1/NXSlmunZGl2qwMi1M860ZcIzaNp9uqA3ea/L76
         TB/TqHvZ3uLXZquUWXL46iCfF6XHP/4Bb5pApUNC67CwdXD3qlWOQ3/qOfE60Z18mqTJ
         j0Zdn63VllSrpW/Mjexrs96vzLfEvnxRJ9c22V8zF1iEFilg9m3Y4XPwKOLjrxd9ki2A
         0nAYyfRSI+D7BnYeowcuceVuYjlKKk+gGqgzvC+5Et3xje0bE37aV6Td0zsVV1DQ235L
         DJXt60Mcea2ewRuKvMpVcrt6EWZHElqPUAUx0nKakH5BHmHtza4AuNN6egHxUbx2GBQq
         bxPw==
X-Gm-Message-State: AJIora+e75WP5Vq+6JfQPj7MC9YQE5B107/oqeMMSlTQVHJedD4kHJ4F
        N6e9TPwQo7UuWBnwRQnv+0ZvPbEjQHxP19S7xbQ=
X-Google-Smtp-Source: AGRyM1ujH4q9O+GFp2uWJAq/DyFBbuRu/KGVUdEc1NNoa8rx3EWtW/29PG+u3BLLLD9Vp0I0fc2/Sw0OD3rPIgvKJew=
X-Received: by 2002:a05:6402:c47:b0:437:ce2d:c30d with SMTP id
 cs7-20020a0564020c4700b00437ce2dc30dmr38710042edb.395.1658175292390; Mon, 18
 Jul 2022 13:14:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220718090050.2261-1-21cnbao@gmail.com> <YtWFHfs0mYonWBwH@casper.infradead.org>
In-Reply-To: <YtWFHfs0mYonWBwH@casper.infradead.org>
From:   Barry Song <21cnbao@gmail.com>
Date:   Tue, 19 Jul 2022 08:14:41 +1200
Message-ID: <CAGsJ_4z0z0mUfuEbyfj7HxB4pBNdkv5igi1rfccithnSB7Q5gA@mail.gmail.com>
Subject: Re: [RESEND PATCH v3] arm64: enable THP_SWAP for arm64
To:     Matthew Wilcox <willy@infradead.org>
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
        Ying Huang <ying.huang@intel.com>,
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

On Tue, Jul 19, 2022 at 4:06 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Jul 18, 2022 at 09:00:50PM +1200, Barry Song wrote:
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 1652a9800ebe..e1c540e80eec 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -101,6 +101,7 @@ config ARM64
> >       select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> >       select ARCH_WANT_LD_ORPHAN_WARN
> >       select ARCH_WANTS_NO_INSTR
> > +     select ARCH_WANTS_THP_SWAP if ARM64_4K_PAGES
>
> Can't you avoid all the other changes by simply doing:
>
>         select ARCH_WANTS_THP_SWAP if ARM64_4K_PAGES && !ARM64_MTE
>
> >       select ARCH_HAS_UBSAN_SANITIZE_ALL
> >       select ARM_AMBA
> >       select ARM_ARCH_TIMER

Nope. as we also enable ARM64_MTE on platforms without mte.
ARMv8.5 based processors introduce the Memory Tagging Extension
(MTE) feature but the Kconfig is default Y for platforms before 8.5.

arm64 usually detects the cpufeature rather than depending on
static build configuration.

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
> > --
> > 2.25.1
> >
> >

Thanks
Barry

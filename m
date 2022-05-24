Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467755331A6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 21:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240705AbiEXTOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 15:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240795AbiEXTOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 15:14:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1125F8F1
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:14:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C0B2B81806
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 19:14:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAEC7C34118;
        Tue, 24 May 2022 19:14:08 +0000 (UTC)
Date:   Tue, 24 May 2022 20:14:04 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Barry Song <21cnbao@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        hanchuanhua <hanchuanhua@oppo.com>,
        =?utf-8?B?5byg6K+X5piOKFNpbW9uIFpoYW5nKQ==?= 
        <zhangshiming@oppo.com>, =?utf-8?B?6YOt5YGl?= <guojian@oppo.com>,
        Barry Song <v-songbaohua@oppo.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>, Shaohua Li <shli@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Steven Price <steven.price@arm.com>
Subject: Re: [PATCH] arm64: enable THP_SWAP for arm64
Message-ID: <Yo0ufMHXPL5mJ5t6@arm.com>
References: <20220524071403.128644-1-21cnbao@gmail.com>
 <YoyTWaDmSiBUkaeg@arm.com>
 <CAGsJ_4xPFkc6Kn2G5pPPk8XJ4iZV=atzan=Quq6Ljc_5vr1fnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4xPFkc6Kn2G5pPPk8XJ4iZV=atzan=Quq6Ljc_5vr1fnA@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 10:05:35PM +1200, Barry Song wrote:
> On Tue, May 24, 2022 at 8:12 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Tue, May 24, 2022 at 07:14:03PM +1200, Barry Song wrote:
> > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > index d550f5acfaf3..8e3771c56fbf 100644
> > > --- a/arch/arm64/Kconfig
> > > +++ b/arch/arm64/Kconfig
> > > @@ -98,6 +98,7 @@ config ARM64
> > >       select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
> > >       select ARCH_WANT_LD_ORPHAN_WARN
> > >       select ARCH_WANTS_NO_INSTR
> > > +     select ARCH_WANTS_THP_SWAP if ARM64_4K_PAGES
> >
> > I'm not opposed to this but I think it would break pages mapped with
> > PROT_MTE. We have an assumption in mte_sync_tags() that compound pages
> > are not swapped out (or in). With MTE, we store the tags in a slab
> 
> I assume you mean mte_sync_tags() require that THP is not swapped as a whole,
> as without THP_SWP, THP is still swapping after being splitted. MTE doesn't stop
> THP from swapping through a couple of splitted pages, does it?

That's correct, split THP page are swapped out/in just fine.

> > object (128-bytes per swapped page) and restore them when pages are
> > swapped in. At some point we may teach the core swap code about such
> > metadata but in the meantime that was the easiest way.
> 
> If my previous assumption is true,  the easiest way to enable THP_SWP
> for this moment might be always letting mm fallback to the splitting
> way for MTE hardware. For this moment, I care about THP_SWP more as
> none of my hardware has MTE.
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 45c358538f13..d55a2a3e41a9 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -44,6 +44,8 @@
>         __flush_tlb_range(vma, addr, end, PUD_SIZE, false, 1)
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> 
> +#define arch_thp_swp_supported !system_supports_mte
> +
>  /*
>   * Outside of a few very special situations (e.g. hibernation), we always
>   * use broadcast TLB invalidation instructions, therefore a spurious page
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 2999190adc22..064b6b03df9e 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -447,4 +447,16 @@ static inline int split_folio_to_list(struct folio *folio,
>         return split_huge_page_to_list(&folio->page, list);
>  }
> 
> +/*
> + * archs that select ARCH_WANTS_THP_SWAP but don't support THP_SWP due to
> + * limitations in the implementation like arm64 MTE can override this to
> + * false
> + */
> +#ifndef arch_thp_swp_supported
> +static inline bool arch_thp_swp_supported(void)
> +{
> +       return true;
> +}
> +#endif
> +
>  #endif /* _LINUX_HUGE_MM_H */
> diff --git a/mm/swap_slots.c b/mm/swap_slots.c
> index 2b5531840583..dde685836328 100644
> --- a/mm/swap_slots.c
> +++ b/mm/swap_slots.c
> @@ -309,7 +309,7 @@ swp_entry_t get_swap_page(struct page *page)
>         entry.val = 0;
> 
>         if (PageTransHuge(page)) {
> -               if (IS_ENABLED(CONFIG_THP_SWAP))
> +               if (IS_ENABLED(CONFIG_THP_SWAP) && arch_thp_swp_supported())
>                         get_swap_pages(1, &entry, HPAGE_PMD_NR);
>                 goto out;

I think this should work and with your other proposal it would be
limited to MTE pages:

#define arch_thp_swp_supported(page)	(!test_bit(PG_mte_tagged, &page->flags))

Are THP pages loaded from swap as a whole or are they split? IIRC the
splitting still happens but after the swapping out finishes. Even if
they are loaded as 4K pages, we still have the mte_save_tags() that only
understands small pages currently, so rejecting THP pages is probably
best.

-- 
Catalin

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232B6535261
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 19:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348131AbiEZRDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 13:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239744AbiEZRDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 13:03:12 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED140A30A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 10:03:11 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id f4so1794416pgf.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 10:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gorH7UAKZ9zn96vWk/PpomqGsSwkifsSCcK0i/4c404=;
        b=UKjLbwlwg4bjVZJ5jvA8BNq3KPnpb0DJmOj5CSNuPCbWG5TEVYp1pmATFh8+yjg7Ra
         6o/EuF0Pr41yiPLbZ5LN3UvIhKC4Lv+Tz7iEkchYfnFgC+SEGi0U0aehJvX+PwE+sRPq
         g5AGw0ZtVZjr6qcXhMQkrTrHOjf8qH5oBwsaRzy0ewq2U3vpykVuXEprwofR54mEM/Tt
         YF7fZi+KLX9qe32v2bpv/JmxG65ByTVtOtKzYdCiaaDmWHhItp14slnC8U6cWEfALY6o
         ciQbusHzL2LZ1q4QiR7aHr3RCltiGTo3ZtzvaOknRloG57fPlnn63gTND2sbFVltLDx4
         hrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gorH7UAKZ9zn96vWk/PpomqGsSwkifsSCcK0i/4c404=;
        b=7pgplqG0XKZDGAJHktw1yqbrD7sVdCWbxPMhI09nCFgFgCSrulc7OGVHpphVN6B046
         QVtHslffn6ENT5UYvqsLNFl9dgKoTxaP2Q1Nk/WpeQL6GAhRB891PQJ6DBxLBiaYKk5e
         UYlJqF8AhhzZXsAvC03OPdtjPwpXDe4n+LpiD3qctzxFRptelAJdpxanMGRsgNLrDq5Q
         2g0iwaXR0uXGBr3kPhfe5XKqPmDDsBFucv6X8hwXQwdh3y+CRBuMVGcBsF6CfibCym9F
         oRskxgm7/+NmTkozOCZnAPYPHBqCDL2DFeSbob2cTdS5QNPq9t3upsKpl7QybjO7+qou
         MODA==
X-Gm-Message-State: AOAM530Ig0zuC9QAA2KVClmFP4MD3plVy8xTzTcI12po49AKWelyvqGt
        jIK1sfqkogRlqlolKhnDU2QtBIR7zRtiKgIjciw=
X-Google-Smtp-Source: ABdhPJyF0STQqXJfoZ8cz5Q20uPuFHbMmyDzj/yAAgIMU9BcKtubaOMxPnCwC8zxiWXz5Vb9ELlUPchspfST4pudBYc=
X-Received: by 2002:a62:e518:0:b0:4fa:9333:ddbd with SMTP id
 n24-20020a62e518000000b004fa9333ddbdmr39821245pff.11.1653584591385; Thu, 26
 May 2022 10:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220524071403.128644-1-21cnbao@gmail.com> <YoyTWaDmSiBUkaeg@arm.com>
 <CAGsJ_4xPFkc6Kn2G5pPPk8XJ4iZV=atzan=Quq6Ljc_5vr1fnA@mail.gmail.com>
 <Yo0ufMHXPL5mJ5t6@arm.com> <CAGsJ_4wSmZo9+Anzq_WjF=xACRT7p0EJ86de6C=8xhGpTBOHQg@mail.gmail.com>
 <CAHbLzkr=_kc9SrOhfhKSb2bhYp=-DSnh8jgnQ-FXKMvCK5YmbQ@mail.gmail.com> <CAGsJ_4xeOqOvnf3t7PDM4EJ9YuUUvi7w88rk_KrN6StMkYKUYg@mail.gmail.com>
In-Reply-To: <CAGsJ_4xeOqOvnf3t7PDM4EJ9YuUUvi7w88rk_KrN6StMkYKUYg@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 26 May 2022 10:02:58 -0700
Message-ID: <CAHbLzko=tVVCozxZsny-_kn5GOERWYsUQXFQ18J7h2gcs_LjPg@mail.gmail.com>
Subject: Re: [PATCH] arm64: enable THP_SWAP for arm64
To:     Barry Song <21cnbao@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        hanchuanhua <hanchuanhua@oppo.com>,
        =?UTF-8?B?5byg6K+X5piOKFNpbW9uIFpoYW5nKQ==?= 
        <zhangshiming@oppo.com>, =?UTF-8?B?6YOt5YGl?= <guojian@oppo.com>,
        Barry Song <v-songbaohua@oppo.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Steven Price <steven.price@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 2:19 AM Barry Song <21cnbao@gmail.com> wrote:
>
> On Thu, May 26, 2022 at 5:49 AM Yang Shi <shy828301@gmail.com> wrote:
> >
> > On Wed, May 25, 2022 at 4:10 AM Barry Song <21cnbao@gmail.com> wrote:
> > >
> > > On Wed, May 25, 2022 at 7:14 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > >
> > > > On Tue, May 24, 2022 at 10:05:35PM +1200, Barry Song wrote:
> > > > > On Tue, May 24, 2022 at 8:12 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > > > On Tue, May 24, 2022 at 07:14:03PM +1200, Barry Song wrote:
> > > > > > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > > > > > index d550f5acfaf3..8e3771c56fbf 100644
> > > > > > > --- a/arch/arm64/Kconfig
> > > > > > > +++ b/arch/arm64/Kconfig
> > > > > > > @@ -98,6 +98,7 @@ config ARM64
> > > > > > >       select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
> > > > > > >       select ARCH_WANT_LD_ORPHAN_WARN
> > > > > > >       select ARCH_WANTS_NO_INSTR
> > > > > > > +     select ARCH_WANTS_THP_SWAP if ARM64_4K_PAGES
> > > > > >
> > > > > > I'm not opposed to this but I think it would break pages mapped with
> > > > > > PROT_MTE. We have an assumption in mte_sync_tags() that compound pages
> > > > > > are not swapped out (or in). With MTE, we store the tags in a slab
> > > > >
> > > > > I assume you mean mte_sync_tags() require that THP is not swapped as a whole,
> > > > > as without THP_SWP, THP is still swapping after being splitted. MTE doesn't stop
> > > > > THP from swapping through a couple of splitted pages, does it?
> > > >
> > > > That's correct, split THP page are swapped out/in just fine.
> > > >
> > > > > > object (128-bytes per swapped page) and restore them when pages are
> > > > > > swapped in. At some point we may teach the core swap code about such
> > > > > > metadata but in the meantime that was the easiest way.
> > > > >
> > > > > If my previous assumption is true,  the easiest way to enable THP_SWP
> > > > > for this moment might be always letting mm fallback to the splitting
> > > > > way for MTE hardware. For this moment, I care about THP_SWP more as
> > > > > none of my hardware has MTE.
> > > > >
> > > > > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> > > > > index 45c358538f13..d55a2a3e41a9 100644
> > > > > --- a/arch/arm64/include/asm/pgtable.h
> > > > > +++ b/arch/arm64/include/asm/pgtable.h
> > > > > @@ -44,6 +44,8 @@
> > > > >         __flush_tlb_range(vma, addr, end, PUD_SIZE, false, 1)
> > > > >  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> > > > >
> > > > > +#define arch_thp_swp_supported !system_supports_mte
> > > > > +
> > > > >  /*
> > > > >   * Outside of a few very special situations (e.g. hibernation), we always
> > > > >   * use broadcast TLB invalidation instructions, therefore a spurious page
> > > > > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > > > > index 2999190adc22..064b6b03df9e 100644
> > > > > --- a/include/linux/huge_mm.h
> > > > > +++ b/include/linux/huge_mm.h
> > > > > @@ -447,4 +447,16 @@ static inline int split_folio_to_list(struct folio *folio,
> > > > >         return split_huge_page_to_list(&folio->page, list);
> > > > >  }
> > > > >
> > > > > +/*
> > > > > + * archs that select ARCH_WANTS_THP_SWAP but don't support THP_SWP due to
> > > > > + * limitations in the implementation like arm64 MTE can override this to
> > > > > + * false
> > > > > + */
> > > > > +#ifndef arch_thp_swp_supported
> > > > > +static inline bool arch_thp_swp_supported(void)
> > > > > +{
> > > > > +       return true;
> > > > > +}
> > > > > +#endif
> > > > > +
> > > > >  #endif /* _LINUX_HUGE_MM_H */
> > > > > diff --git a/mm/swap_slots.c b/mm/swap_slots.c
> > > > > index 2b5531840583..dde685836328 100644
> > > > > --- a/mm/swap_slots.c
> > > > > +++ b/mm/swap_slots.c
> > > > > @@ -309,7 +309,7 @@ swp_entry_t get_swap_page(struct page *page)
> > > > >         entry.val = 0;
> > > > >
> > > > >         if (PageTransHuge(page)) {
> > > > > -               if (IS_ENABLED(CONFIG_THP_SWAP))
> > > > > +               if (IS_ENABLED(CONFIG_THP_SWAP) && arch_thp_swp_supported())
> > > > >                         get_swap_pages(1, &entry, HPAGE_PMD_NR);
> > > > >                 goto out;
> > > >
> > > > I think this should work and with your other proposal it would be
> > > > limited to MTE pages:
> > > >
> > > > #define arch_thp_swp_supported(page)    (!test_bit(PG_mte_tagged, &page->flags))
> > > >
> > > > Are THP pages loaded from swap as a whole or are they split? IIRC the
> > >
> > > i can confirm thp is written as a whole through:
> > > [   90.622863]  __swap_writepage+0xe8/0x580
> > > [   90.622881]  swap_writepage+0x44/0xf8
> > > [   90.622891]  pageout+0xe0/0x2a8
> > > [   90.622906]  shrink_page_list+0x9dc/0xde0
> > > [   90.622917]  shrink_inactive_list+0x1ec/0x3c8
> > > [   90.622928]  shrink_lruvec+0x3dc/0x628
> > > [   90.622939]  shrink_node+0x37c/0x6a0
> > > [   90.622950]  balance_pgdat+0x354/0x668
> > > [   90.622961]  kswapd+0x1e0/0x3c0
> > > [   90.622972]  kthread+0x110/0x120
> > >
> > > but i have never got a backtrace in which thp is loaded as a whole though it
> > > seems the code has this path:
> >
> > THP could be swapped out in a whole, but never swapped in as THP. Just
> > the single base page (4K on x86) is swapped in.
>
> yep. it seems swapin_readahead() is never reading a THP or even splitted
> pages for this 2MB THP.
>
> the number of pages to be read-ahead is determined either by
> /proc/sys/vm/page-cluster if /sys/kernel/mm/swap/vma_ra_enabled is fase
> or
> by vma read-ahead algorithm if /sys//kernel/mm/swap/vma_ra_enabled is true
> And the number is usually quite small.
>
> Am I missing any case in which 2MB can be swapped in as whole either by
> splitted pages or a THP?

Even though readahead swaps in 2MB, they are 512 single base pages
rather than THP. They may not be physically continuous at all.

>
> Thanks
> Barry

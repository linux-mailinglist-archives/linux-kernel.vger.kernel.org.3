Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E805328B6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 13:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236517AbiEXLPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 07:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236373AbiEXLPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:15:35 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E926FA0C
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:15:33 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id rq11so12514525ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rm0MWZbX6R/By7K+rxlAjoioJpGDi/eaTT4NYHz6bcU=;
        b=F9WLWYTdXocg+MPoUgp4Bf7Vi2qbilJV7BvoS7du8d97TITGv82B6ypzkLX/NSe8R2
         BxCTLrLu0NQFYr4MRubjlRXjz4i77w1w8XK2Bdak0/r4QFXWBRI49z9Z6puikhaly3PV
         IzNX36O5RCXi30MeO/4+9MRmqhleiWTunupiKaW6aQ4i8tnu7w9sqn36B+OvLQnoKg4E
         3luQfMQ+n5Vfzso85P6EMZStdIWEeoU1QuMVAq/2X6sIQjL9QBFR0aaKazYlul/D9vyb
         XDdW0i9dMpOUDMoRwyzShBzkzsi6g/U4AY04vJOkS03RteG+iE2+tu6c3mVKK1pTE/ma
         5nCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rm0MWZbX6R/By7K+rxlAjoioJpGDi/eaTT4NYHz6bcU=;
        b=Vcr/+Oc7YX8/pJvH/2w6FGBiJR9joFgH5yHwuptNXXWYClVB5SbzpKgjhjAD8OVzQU
         9QX/N2T2RRBkhvX7o6Vb4MQ6IVy00kfa3x9MnMieb8vr5yeCHxbLJF4TvAy5574Rr0GC
         ix87nF40OEjiF8jUROpnkwsFZKh+uj5gGjnw6Wyzd/mHW0+qmV1p8WjtXuQAByct1X48
         tjHPVOLe0Xb5ytxcNN8HnbgxO5jlQBgUJachjtSDKh8h/hjF14H6nntJA/nNVCOXuBsJ
         5e+DKCODISho9dMTpajVoO0ksYUiSCBEpEP8QiMNByH0Nb8wctHlZIsypozeipNDwoZi
         VlkA==
X-Gm-Message-State: AOAM532CbA1j39VseeX8pg8ftNMLbAAKK1b2QbeH5gafO315PxZhD1TP
        CprpxDWwYUNAh/nz2bHeyUydxeRVNPrR9DgLWaw=
X-Google-Smtp-Source: ABdhPJwkvi9Kxb+Y+IHF1mZiooqwN0jXvP5jliln7mmgkqu6mG3+RkPKm7KFoRaNqse5ZAXMqLmrCnd7aDN7ZM/Xmtc=
X-Received: by 2002:a17:906:7309:b0:6f5:ea1:afa with SMTP id
 di9-20020a170906730900b006f50ea10afamr24026992ejc.170.1653390931817; Tue, 24
 May 2022 04:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220524071403.128644-1-21cnbao@gmail.com> <YoyTWaDmSiBUkaeg@arm.com>
 <CAGsJ_4xPFkc6Kn2G5pPPk8XJ4iZV=atzan=Quq6Ljc_5vr1fnA@mail.gmail.com>
In-Reply-To: <CAGsJ_4xPFkc6Kn2G5pPPk8XJ4iZV=atzan=Quq6Ljc_5vr1fnA@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Tue, 24 May 2022 23:15:20 +1200
Message-ID: <CAGsJ_4yae=4CpACJQkqTc-B8if47nbOqT9CBHtT0jsKWis4QRQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: enable THP_SWAP for arm64
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        Hugh Dickins <hughd@google.com>, Shaohua Li <shli@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Steven Price <steven.price@arm.com>
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

On Tue, May 24, 2022 at 10:05 PM Barry Song <21cnbao@gmail.com> wrote:
>
> On Tue, May 24, 2022 at 8:12 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> >
> > On Tue, May 24, 2022 at 07:14:03PM +1200, Barry Song wrote:
> > > From: Barry Song <v-songbaohua@oppo.com>
> > >
> > > THP_SWAP has been proved to improve the swap throughput significantly
> > > on x86_64 according to commit bd4c82c22c367e ("mm, THP, swap: delay
> > > splitting THP after swapped out").
> > > As long as arm64 uses 4K page size, it is quite similar with x86_64
> > > by having 2MB PMD THP. So we are going to get similar improvement.
> > > For other page sizes such as 16KB and 64KB, PMD might be too large.
> > > Negative side effects such as IO latency might be a problem. Thus,
> > > we can only safely enable the counterpart of X86_64.
> > >
> > > Cc: "Huang, Ying" <ying.huang@intel.com>
> > > Cc: Minchan Kim <minchan@kernel.org>
> > > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > > Cc: Hugh Dickins <hughd@google.com>
> > > Cc: Shaohua Li <shli@kernel.org>
> > > Cc: Rik van Riel <riel@redhat.com>
> > > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > > ---
> > >  arch/arm64/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
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
>
> > object (128-bytes per swapped page) and restore them when pages are
> > swapped in. At some point we may teach the core swap code about such
> > metadata but in the meantime that was the easiest way.
> >
>
> If my previous assumption is true,  the easiest way to enable THP_SWP
> for this moment
> might be always letting mm fallback to the splitting way for MTE
> hardware. For this
> moment, I care about THP_SWP more as none of my hardware has MTE.
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
>         }
>

Am I actually able to go further to only split MTE tagged pages?

For mm core:

+/*
+ * archs that select ARCH_WANTS_THP_SWAP but don't support THP_SWP due to
+ * limitations in the implementation like arm64 MTE can override this to
+ * false
+ */
+#ifndef arch_thp_swp_supported
+static inline bool arch_thp_swp_supported(struct page *page)
+{
+       return true;
+}
+#endif
+

For arm64:
+#define arch_thp_swp_supported(page) !test_bit(PG_mte_tagged, &page->flags)

But I don't have MTE hardware to test. So to me, totally disabling THP_SWP
is safer.

thoughts?
> > --
> > Catalin
>
> Thanks
> Barry

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB15535A5F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 09:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346120AbiE0H3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 03:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbiE0H3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 03:29:45 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C12666AE0
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 00:29:44 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ck4so7017187ejb.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 00:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BDUW6rhZr1cLhR+rXpmqy9X9Px+U0K54NN6ME+NGm0w=;
        b=J81AIv0ninxPsK+gQDpUH1BvmDMali0IwW/XEiCZg7Hc9VUFughyGMo065vFuqVfDu
         dE9I/bDKj6dwmLnJ5mGgfgyBkVnq32OKCVvDOv8VhcehHU68q6LXBlygAhBGKDR0nUIg
         aIvo1V2QLfQar9rhQttlSdETFEsk2X2mEF7/3JkJJgnf/9SMO7LKKtIkevV3BLElAsLm
         i/8ISMQ5fMMXRpsSmdKttsolIIm67I1gBi/RyHdpznXOUbbjXzWC3ZuN6fp8i+klIeNd
         4wxhROO6nrWRSIacgqQELpL/G/u7GcfaRhzgHFvKHof8ftWl3KuaPsEfQhcwh8D0rl1c
         vTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BDUW6rhZr1cLhR+rXpmqy9X9Px+U0K54NN6ME+NGm0w=;
        b=Ss2YExe0lFHoZGIEqyqIHByf7fThFARt5OWEqDUzOJSDrayYYSji0gbY4x02npN5W5
         rcBPiYX+YMUu1li5qiyC72782+RmUOMLmMGa5fk5tCn5jING/JYmoauS5bKjO2AfptWi
         28Fbzfi3TQouqolZNU5jlGgw8du5yQh5PlljbJ65eFb0E8y/fFtu83F047FM2wkjOoo0
         GIxTCX6uXTG7R4R+7mnd6e6xQ2K8zx37Es7i4WVE/qX0dM+MFUOfWDecNXV62Q0WgCch
         n2FvmoXTpyzs0MsdL2tTocZbkm+/b7h2GdrLh6oOwWuXjeqtbZGlbAPzYsrrd6YDDRXx
         a8IQ==
X-Gm-Message-State: AOAM532wrZbP1k7Wnfu9nQaemooc7nWsTUkKeOPX/a/E+81fpkoE7dF7
        TWn3szRIuLgh+DZ0FNb0erVBgMVzavm3pytKR/g=
X-Google-Smtp-Source: ABdhPJyHaKMIF9secUpoEPTz2GjzeXQBMLBCB8/ETFYokgbxBRCEwTq6H5+2qeZ5TsLSiuYyTS2ymXgonycrkERveaM=
X-Received: by 2002:a17:907:2d10:b0:6fe:debf:bfc7 with SMTP id
 gs16-20020a1709072d1000b006fedebfbfc7mr22026687ejc.502.1653636582760; Fri, 27
 May 2022 00:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220524071403.128644-1-21cnbao@gmail.com> <YoyTWaDmSiBUkaeg@arm.com>
 <CAGsJ_4xPFkc6Kn2G5pPPk8XJ4iZV=atzan=Quq6Ljc_5vr1fnA@mail.gmail.com>
 <Yo0ufMHXPL5mJ5t6@arm.com> <CAGsJ_4wSmZo9+Anzq_WjF=xACRT7p0EJ86de6C=8xhGpTBOHQg@mail.gmail.com>
 <CAHbLzkr=_kc9SrOhfhKSb2bhYp=-DSnh8jgnQ-FXKMvCK5YmbQ@mail.gmail.com>
 <CAGsJ_4xeOqOvnf3t7PDM4EJ9YuUUvi7w88rk_KrN6StMkYKUYg@mail.gmail.com> <CAHbLzko=tVVCozxZsny-_kn5GOERWYsUQXFQ18J7h2gcs_LjPg@mail.gmail.com>
In-Reply-To: <CAHbLzko=tVVCozxZsny-_kn5GOERWYsUQXFQ18J7h2gcs_LjPg@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Fri, 27 May 2022 19:29:31 +1200
Message-ID: <CAGsJ_4w4J_wBPX0x5vWrO8jeOV5XLzkyUkyYpWUKkB4FHi0rHg@mail.gmail.com>
Subject: Re: [PATCH] arm64: enable THP_SWAP for arm64
To:     Yang Shi <shy828301@gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 5:03 AM Yang Shi <shy828301@gmail.com> wrote:
>
> On Thu, May 26, 2022 at 2:19 AM Barry Song <21cnbao@gmail.com> wrote:
> >
> > On Thu, May 26, 2022 at 5:49 AM Yang Shi <shy828301@gmail.com> wrote:
> > >
> > > On Wed, May 25, 2022 at 4:10 AM Barry Song <21cnbao@gmail.com> wrote:
> > > >
> > > > On Wed, May 25, 2022 at 7:14 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > >
> > > > > On Tue, May 24, 2022 at 10:05:35PM +1200, Barry Song wrote:
> > > > > > On Tue, May 24, 2022 at 8:12 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > > > > On Tue, May 24, 2022 at 07:14:03PM +1200, Barry Song wrote:
> > > > > > > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > > > > > > index d550f5acfaf3..8e3771c56fbf 100644
> > > > > > > > --- a/arch/arm64/Kconfig
> > > > > > > > +++ b/arch/arm64/Kconfig
> > > > > > > > @@ -98,6 +98,7 @@ config ARM64
> > > > > > > >       select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
> > > > > > > >       select ARCH_WANT_LD_ORPHAN_WARN
> > > > > > > >       select ARCH_WANTS_NO_INSTR
> > > > > > > > +     select ARCH_WANTS_THP_SWAP if ARM64_4K_PAGES
> > > > > > >
> > > > > > > I'm not opposed to this but I think it would break pages mapped with
> > > > > > > PROT_MTE. We have an assumption in mte_sync_tags() that compound pages
> > > > > > > are not swapped out (or in). With MTE, we store the tags in a slab
> > > > > >
> > > > > > I assume you mean mte_sync_tags() require that THP is not swapped as a whole,
> > > > > > as without THP_SWP, THP is still swapping after being splitted. MTE doesn't stop
> > > > > > THP from swapping through a couple of splitted pages, does it?
> > > > >
> > > > > That's correct, split THP page are swapped out/in just fine.
> > > > >
> > > > > > > object (128-bytes per swapped page) and restore them when pages are
> > > > > > > swapped in. At some point we may teach the core swap code about such
> > > > > > > metadata but in the meantime that was the easiest way.
> > > > > >
> > > > > > If my previous assumption is true,  the easiest way to enable THP_SWP
> > > > > > for this moment might be always letting mm fallback to the splitting
> > > > > > way for MTE hardware. For this moment, I care about THP_SWP more as
> > > > > > none of my hardware has MTE.
> > > > > >
> > > > > > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> > > > > > index 45c358538f13..d55a2a3e41a9 100644
> > > > > > --- a/arch/arm64/include/asm/pgtable.h
> > > > > > +++ b/arch/arm64/include/asm/pgtable.h
> > > > > > @@ -44,6 +44,8 @@
> > > > > >         __flush_tlb_range(vma, addr, end, PUD_SIZE, false, 1)
> > > > > >  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> > > > > >
> > > > > > +#define arch_thp_swp_supported !system_supports_mte
> > > > > > +
> > > > > >  /*
> > > > > >   * Outside of a few very special situations (e.g. hibernation), we always
> > > > > >   * use broadcast TLB invalidation instructions, therefore a spurious page
> > > > > > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > > > > > index 2999190adc22..064b6b03df9e 100644
> > > > > > --- a/include/linux/huge_mm.h
> > > > > > +++ b/include/linux/huge_mm.h
> > > > > > @@ -447,4 +447,16 @@ static inline int split_folio_to_list(struct folio *folio,
> > > > > >         return split_huge_page_to_list(&folio->page, list);
> > > > > >  }
> > > > > >
> > > > > > +/*
> > > > > > + * archs that select ARCH_WANTS_THP_SWAP but don't support THP_SWP due to
> > > > > > + * limitations in the implementation like arm64 MTE can override this to
> > > > > > + * false
> > > > > > + */
> > > > > > +#ifndef arch_thp_swp_supported
> > > > > > +static inline bool arch_thp_swp_supported(void)
> > > > > > +{
> > > > > > +       return true;
> > > > > > +}
> > > > > > +#endif
> > > > > > +
> > > > > >  #endif /* _LINUX_HUGE_MM_H */
> > > > > > diff --git a/mm/swap_slots.c b/mm/swap_slots.c
> > > > > > index 2b5531840583..dde685836328 100644
> > > > > > --- a/mm/swap_slots.c
> > > > > > +++ b/mm/swap_slots.c
> > > > > > @@ -309,7 +309,7 @@ swp_entry_t get_swap_page(struct page *page)
> > > > > >         entry.val = 0;
> > > > > >
> > > > > >         if (PageTransHuge(page)) {
> > > > > > -               if (IS_ENABLED(CONFIG_THP_SWAP))
> > > > > > +               if (IS_ENABLED(CONFIG_THP_SWAP) && arch_thp_swp_supported())
> > > > > >                         get_swap_pages(1, &entry, HPAGE_PMD_NR);
> > > > > >                 goto out;
> > > > >
> > > > > I think this should work and with your other proposal it would be
> > > > > limited to MTE pages:
> > > > >
> > > > > #define arch_thp_swp_supported(page)    (!test_bit(PG_mte_tagged, &page->flags))
> > > > >
> > > > > Are THP pages loaded from swap as a whole or are they split? IIRC the
> > > >
> > > > i can confirm thp is written as a whole through:
> > > > [   90.622863]  __swap_writepage+0xe8/0x580
> > > > [   90.622881]  swap_writepage+0x44/0xf8
> > > > [   90.622891]  pageout+0xe0/0x2a8
> > > > [   90.622906]  shrink_page_list+0x9dc/0xde0
> > > > [   90.622917]  shrink_inactive_list+0x1ec/0x3c8
> > > > [   90.622928]  shrink_lruvec+0x3dc/0x628
> > > > [   90.622939]  shrink_node+0x37c/0x6a0
> > > > [   90.622950]  balance_pgdat+0x354/0x668
> > > > [   90.622961]  kswapd+0x1e0/0x3c0
> > > > [   90.622972]  kthread+0x110/0x120
> > > >
> > > > but i have never got a backtrace in which thp is loaded as a whole though it
> > > > seems the code has this path:
> > >
> > > THP could be swapped out in a whole, but never swapped in as THP. Just
> > > the single base page (4K on x86) is swapped in.
> >
> > yep. it seems swapin_readahead() is never reading a THP or even splitted
> > pages for this 2MB THP.
> >
> > the number of pages to be read-ahead is determined either by
> > /proc/sys/vm/page-cluster if /sys/kernel/mm/swap/vma_ra_enabled is fase
> > or
> > by vma read-ahead algorithm if /sys//kernel/mm/swap/vma_ra_enabled is true
> > And the number is usually quite small.
> >
> > Am I missing any case in which 2MB can be swapped in as whole either by
> > splitted pages or a THP?
>
> Even though readahead swaps in 2MB, they are 512 single base pages
> rather than THP. They may not be physically continuous at all.

I actually haven't found out that readahead can swap in 2MB through either
THP or 512 single base pages. per my log, swapin_vma_readahead() usually
swaps in 2,3,4 or 8 pages.

but we do have a case in which we can swap in up to 2MB while doing
collapse:
static bool __collapse_huge_page_swapin(struct mm_struct *mm,
                                        struct vm_area_struct *vma,
                                        unsigned long haddr, pmd_t *pmd,
                                        int referenced)
{
        int swapped_in = 0;
        vm_fault_t ret = 0;
        unsigned long address, end = haddr + (HPAGE_PMD_NR * PAGE_SIZE);

        for (address = haddr; address < end; address += PAGE_SIZE) {
                struct vm_fault vmf = {
                        .vma = vma,
                        .address = address,
                        .pgoff = linear_page_index(vma, haddr),
                        .flags = FAULT_FLAG_ALLOW_RETRY,
                        .pmd = pmd,
                };

                vmf.pte = pte_offset_map(pmd, address);
                vmf.orig_pte = *vmf.pte;
                if (!is_swap_pte(vmf.orig_pte)) {
                        pte_unmap(vmf.pte);
                        continue;
                }
                swapped_in++;
                ret = do_swap_page(&vmf);

                ...}
        }

}

It seems Huang Ying once mentioned there was a plan to not split THP
throughout the whole process.

Thanks
Barry

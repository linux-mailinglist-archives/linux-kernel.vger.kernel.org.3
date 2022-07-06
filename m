Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F15567FD0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 09:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbiGFH3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 03:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiGFH3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 03:29:14 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E502252B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 00:29:13 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id l144so13423242ybl.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 00:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EnTYqjrjBR+7+2kKZfXHsxrb/Kk0mP3AD0EQkfCVCJw=;
        b=OZXgpXMIrfSJeVcKc+v378sVaKdo6cBWNkRKzs5WG5mwMa/IKUTJ7HhYu7WsSYp9NW
         mL17ZhRvsUwbQTnvEY1CbMM3Cu7bZdn0Etixxqy7jGNDCwHm3YKyGIhOwSTwkd7YbR5C
         Pd6PcbDmg4WoTh4qJqrl8ic1mplNRWKc9QClS5UGfu1ODSS0WMcBeFREMJ/Gxy4j2rGO
         FikTdxxmYTDIbz3+LaVQM3zVxzHlMuy8tkwmosYumaeYtJcdlDIYCZijhl9Dhs7r4a2r
         kNgilrzI7akS94o+dvs/KKoxej8K1lNQnHn3d4ZqohaRGd3/c+IObX3ar5K3txUX27o1
         0Vvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EnTYqjrjBR+7+2kKZfXHsxrb/Kk0mP3AD0EQkfCVCJw=;
        b=wgAemtEiXONmr7RF6MXOYkkjZwPIhvvgx+4BzdzIZmDpl8o0vkRmmfe4xwPSsW/Ve8
         CSu439RGsHqSyMc00rLsWczbyGIUn2UKRI/kSLyrsZGewGrzD8pKXmbOXExMEPglsZJk
         gSpokilE9WA8ythOHCEV6t/zDgbiejmwjdvq8T8n9FWTHji+aj/mthsnX1CDYA4xbKBq
         RTXZWVfXSPP/cheJMrLxcKdG6O7sxScsxZUTPs5AWuhHfFOaSZp3Ik0k4LBvtq/Gk+ac
         BgDW9ztw2IGj738RN4IBfAUtQ0e2ppVkbGa2Ohz9IUa6YJpq4pALqyNd+h7ZaeCGserU
         A8Tw==
X-Gm-Message-State: AJIora+rqrMkuHsT8g8GmgmW+USDQ+NofD5YuwvuRBldRZXC6OhCC63l
        o+dYj5qADkhph46zpIxblJuteAZenYOrZvEg4PoOng==
X-Google-Smtp-Source: AGRyM1u7ReDfgvySBbkzI7c9Zdpyuc4u+9JbhW9Gjcsd9qOl9Td8Y+UaebC6ukmQwplXBmWYRcEjb+Eoogh2XqDsBPc=
X-Received: by 2002:a25:6913:0:b0:66e:3700:4235 with SMTP id
 e19-20020a256913000000b0066e37004235mr18618348ybc.240.1657092552492; Wed, 06
 Jul 2022 00:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220518081753.29589-1-po-kai.chi@sifive.com> <mhng-296c3110-5e5d-48a4-bd41-1d46bf7987cd@palmer-ri-x1c9>
In-Reply-To: <mhng-296c3110-5e5d-48a4-bd41-1d46bf7987cd@palmer-ri-x1c9>
From:   Po-Kai Chi <po-kai.chi@sifive.com>
Date:   Wed, 6 Jul 2022 15:28:37 +0800
Message-ID: <CABZ18H++ETn08TrDLL5YRsrr2z7rQfdxsjUudVFG=yB_KPg+Dw@mail.gmail.com>
Subject: Re: [PATCH] riscv: Invalid instruction cache after copy the xol area
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Palmer,

Replacing flush_icache_range() with flush_icache_all() looks good to me.
And I think this is the necessary evil because we don't know whether
hardware is performing speculative access to the XOL area or not.


On Fri, Jun 17, 2022 at 6:04 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Wed, 18 May 2022 01:17:53 PDT (-0700), po-kai.chi@sifive.com wrote:
> > We need to invalid the relevant instruction cache after
> > copying the xol area, to ensure the changes takes effect.
> >
> > Signed-off-by: Po-Kai Chi <po-kai.chi@sifive.com>
> > ---
> >  arch/riscv/kernel/probes/uprobes.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probes/uprobes.c
> > index 7a057b5f0adc..9d52beeac73c 100644
> > --- a/arch/riscv/kernel/probes/uprobes.c
> > +++ b/arch/riscv/kernel/probes/uprobes.c
> > @@ -165,6 +165,7 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
> >       /* Initialize the slot */
> >       void *kaddr = kmap_atomic(page);
> >       void *dst = kaddr + (vaddr & ~PAGE_MASK);
> > +     unsigned long addr = (unsigned long)dst;
> >
> >       memcpy(dst, src, len);
> >
> > @@ -177,10 +178,9 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
> >       kunmap_atomic(kaddr);
> >
> >       /*
> > -      * We probably need flush_icache_user_page() but it needs vma.
> > -      * This should work on most of architectures by default. If
> > -      * architecture needs to do something different it can define
> > -      * its own version of the function.
> > +      * Flush both I/D cache to ensure instruction modification
> > +      * takes effect.
> >        */
> >       flush_dcache_page(page);
> > +     flush_icache_range(addr, addr + len);
> >  }
>
> This brings up a handful of issues:
>
> * This always inserts a 32-bit breakpoint, but that's not quite correct.
>   This should really be checking the _next_ instruction as well to
>   insert a 16-bit breakpoint if it's a 16-bit instruction as otherwise
>   userspace might jump into the middle of the breakpoint.
> * These instructions can be concurrently executing, which relies on some
>   instruction fetch ordering that's very lightly specified.  We don't
>   rely on that elsewhere (see stop_machine() in kprobes), but we
>   probably should.  It's probably worth adding something to probe the HW
>   to make sure this is supported.
> * Adding the icache flush defeats a uprobes advantage in that we'll now
>   be triggering remote execution (to do the remote fence.i).  One option
>   could be to defer the fence and wait on it, but not sure if that's
>   sane and it'd likely require a lot of
>
> This also leaves a bit undefined WRT icache aliasing, at least in terms
> of the API used.  IMO it'd be
>
>     diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probes/uprobes.c
>     index 9d52beeac73c..c857346864fc 100644
>     --- a/arch/riscv/kernel/probes/uprobes.c
>     +++ b/arch/riscv/kernel/probes/uprobes.c
>     @@ -165,7 +165,6 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
>         /* Initialize the slot */
>         void *kaddr = kmap_atomic(page);
>         void *dst = kaddr + (vaddr & ~PAGE_MASK);
>     -   unsigned long addr = (unsigned long)dst;
>
>         memcpy(dst, src, len);
>
>     @@ -179,8 +178,10 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
>
>         /*
>          * Flush both I/D cache to ensure instruction modification
>     -    * takes effect.
>     +    * takes effect.  We don't need to flush the whole icache, but that's
>     +    * all RISC-V defines so rather than worry about aliasing this just
>     +    * flushes everything.
>          */
>         flush_dcache_page(page);
>     -   flush_icache_range(addr, addr + len);
>     +   flush_icache_all();
>      }
>
> which will end up doing the same thing but avoids the ambiguity.  I went
> ahead and put this at palmer/riscv-uprobe_fencei with that and some
> other minor things fixed up, LMK if that looks OK and I'll take it on
> fixes.
>
> Thanks!



-- 
BR,
Po-Kai Chi

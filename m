Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2F54B5D63
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 23:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbiBNWEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 17:04:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiBNWEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 17:04:00 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2D2177E50
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 14:03:51 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c192so10368633wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 14:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=38jyLv0u0qIybtfltYvr9HnUqxoAfv/j6qkWJXrbAAo=;
        b=Bbc1wXI0wF4/tZHAV6O92OtxEnnXMyCGRgfqz5u8k0HZT2ULi2fbifTaHrNxSmtJ+D
         /pB4mpDnuSXZnBFMUsmFm4Pvr+kbqQhRpv1knlo6l/11eVtn6Vc/fFlNmmKmA3RbbSTb
         eW1UHQ+bkXRbVHL3pEd1Av2GFhuri7dyi7vq5QH08mWS8pKEgcR9GeKfRlZzDdqsFVvO
         cEJoH+Uw1klNK6ivy+ROT1OedTUHu+cO/vuBJ8Wyvvwuvj6qLPOGuvG18v21Xpxl4yUI
         rAC9VeUwTqi0p/izmYFOFhR7dhFMjP4bf/eIoYUvx1WWN4McP/eIu6q4bT+HZGV5il/U
         bkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=38jyLv0u0qIybtfltYvr9HnUqxoAfv/j6qkWJXrbAAo=;
        b=Jk59ZBouOY+CABOLIP7+i+d+p+4Ae2OQ8iySMPew2QtESNnLW+FmVHWEx0iDCT7oce
         9bBIG3IEg2lnJPgNtoq68K3ZrZCZm0xXWEcWhWV7CJ4OyGmVT+k9KzyC0vBqnXjEKnm0
         DB7C2hdmq9yvUk4l7sIJKtrntMkAJgEhjJTsH2wkJb69aqmxT5Z0IZ2xYcP1/A/ulMtd
         NOXC5NeJ2XakQ0uTtbVBnl/JiJx8fgGEUMIOI+jlqEOScI060L8PtSjpnoVOQvlE7Wwb
         gGBepetB1j8+wOpOaaTpF7JPORCj8tm9xG6q6GbQL0gJ77xZixJnDTwwHGcEEcLSBZdz
         +/Ng==
X-Gm-Message-State: AOAM532yAsvYTRBv3lKzDf9AYzVFA1ASAe6wDOYJp3wvL9KO7jZQoV4H
        QctMpOM/rUzzMBiThkdxNPTzHfSHDR3LOBCKc2mmEg==
X-Google-Smtp-Source: ABdhPJyuOiZOcvtPPW6+z6Ib5nhEDOP4uK+8XwPv1UzoZ8fYA3rhV/irfeMg2SHAqjLLlCju5rICe7VFiX47yacb0YE=
X-Received: by 2002:a05:600c:3b21:: with SMTP id m33mr633946wms.7.1644876230035;
 Mon, 14 Feb 2022 14:03:50 -0800 (PST)
MIME-Version: 1.0
References: <20220210224220.4076151-1-kaleshsingh@google.com>
 <20220210224220.4076151-5-kaleshsingh@google.com> <87leyd4k5q.wl-maz@kernel.org>
In-Reply-To: <87leyd4k5q.wl-maz@kernel.org>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Mon, 14 Feb 2022 14:03:38 -0800
Message-ID: <CAC_TJvep6n74PJARzR9J9_pHZEGUnehb0W50f64m-16UGJE_Cg@mail.gmail.com>
Subject: Re: [PATCH 4/7] KVM: arm64: Allocate guard pages near hyp stacks
To:     Marc Zyngier <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Quentin Perret <qperret@google.com>,
        Fuad Tabba <tabba@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Scull <ascull@google.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, kvmarm@lists.cs.columbia.edu
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

On Mon, Feb 14, 2022 at 6:06 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 10 Feb 2022 22:41:45 +0000,
> Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > From: Quentin Perret <qperret@google.com>
> >
> > Allocate unbacked VA space underneath each stack page to ensure stack
> > overflows get trapped and don't corrupt memory silently.
> >
> > The stack is aligned to twice its size (PAGE_SIZE), meaning that any
> > valid stack address has PAGE_SHIFT bit as 0. This allows us to easily
> > check for overflow in the exception entry without corrupting any GPRs.
> >
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > [ Kalesh - Update commit text and comments,
> >            refactor, add overflow handling ]
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >  arch/arm64/kvm/hyp/nvhe/host.S   | 16 ++++++++++++++++
> >  arch/arm64/kvm/hyp/nvhe/setup.c  | 19 ++++++++++++++++++-
> >  arch/arm64/kvm/hyp/nvhe/switch.c |  5 +++++
> >  3 files changed, 39 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
> > index 3d613e721a75..78e4b612ac06 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/host.S
> > +++ b/arch/arm64/kvm/hyp/nvhe/host.S
> > @@ -153,6 +153,10 @@ SYM_FUNC_END(__host_hvc)
> >
> >  .macro invalid_host_el2_vect
> >       .align 7
> > +
> > +     /* Test stack overflow without corrupting GPRs */
> > +     test_sp_overflow PAGE_SHIFT, .L__hyp_sp_overflow\@
> > +
>
> I am definitely concerned with this in a system not using pKVM (which
> is on average 100% of the upstream users so far! ;-). This is more or
> less guaranteed to do the wrong thing 50% of the times, depending on
> the alignment of the stack.

Thanks for pointing this out Marc. I'll rework this to work for both
protected and non-protected modes.

>
> >       /* If a guest is loaded, panic out of it. */
> >       stp     x0, x1, [sp, #-16]!
> >       get_loaded_vcpu x0, x1
> > @@ -165,6 +169,18 @@ SYM_FUNC_END(__host_hvc)
> >        * been partially clobbered by __host_enter.
> >        */
> >       b       hyp_panic
> > +
> > +.L__hyp_sp_overflow\@:
> > +     /*
> > +      * Reset SP to the top of the stack, to allow handling the hyp_panic.
> > +      * This corrupts the stack but is ok, since we won't be attempting
> > +      * any unwinding here.
> > +      */
> > +     ldr_this_cpu    x0, kvm_init_params + NVHE_INIT_STACK_HYP_VA, x1
> > +     mov     sp, x0
> > +
> > +     bl      hyp_panic_bad_stack
> > +     ASM_BUG()
> >  .endm
> >
> >  .macro invalid_host_el1_vect
> > diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
> > index 99e178cf4249..114053dff228 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/setup.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/setup.c
> > @@ -105,7 +105,24 @@ static int recreate_hyp_mappings(phys_addr_t phys, unsigned long size,
> >               if (ret)
> >                       return ret;
> >
> > -             /* Map stack pages in the 'private' VA range */
> > +             /*
> > +              * Allocate 'private' VA range for stack guard pages.
> > +              *
> > +              * The 'private' VA range grows upward and stacks downwards, so
> > +              * allocate the guard page first. But make sure to align the
> > +              * stack itself with PAGE_SIZE * 2 granularity to ease overflow
> > +              * detection in the entry assembly code.
> > +              */
> > +             do {
> > +                     start = (void *)hyp_alloc_private_va_range(PAGE_SIZE);
> > +                     if (IS_ERR(start))
> > +                             return PTR_ERR(start);
> > +             } while (IS_ALIGNED((u64) start, PAGE_SIZE * 2));
>
> This seems cumbersome. Can't we tweak hyp_alloc_private_va_range() to
> perform the required alignment? It could easily be convinced to return
> an address that is aligned on the size of the region, which would
> avoid this sort of loop.

Ack. I'll update it for v2.

- Kalesh

>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

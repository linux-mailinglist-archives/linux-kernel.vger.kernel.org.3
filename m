Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801A94C02F0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 21:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbiBVUU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 15:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbiBVUU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 15:20:58 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6088012A76C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 12:20:32 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id y6-20020a7bc186000000b0037bdc5a531eso1606882wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 12:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wOey4rPC2TeiOe1tuJcJnl76pBFzOll2hU5Aq8ViVuo=;
        b=Z0MMnMKZ8ChPYc9QvuVfaVyvcvMHdxyCx7Is/qVaUayOmS0S1TjILQ8IvSCnBsBDbx
         Uu7SeMoZNephvMZZVlrLGOE8iXzf3Vs3JQqJexz+9cWxhY7I0l7BrQG6VNnjyy8YKiWI
         sGq2n1zU0bXPpVmAHWQixJ5KWIOO9CsM2UenDDVcRVkkXLqBKeNkUon5zYp2N0B9kMpt
         56uk2w5vx0mMlwrdlMeMmUcXIPz68sBx0I5mPa/5eEw2eHD3c9bse/ULzM0f51yFNly6
         MDe+LiFQFyhnTBXWaXJ+B/XWFwARwHsJyF4r6J+zNz59UQPgHHKonmCN1x5eqfB1Urb/
         RpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wOey4rPC2TeiOe1tuJcJnl76pBFzOll2hU5Aq8ViVuo=;
        b=0PmdpDBYiVp3rEOg6tRDm/iDD/Ao3HkQd981QIzY5cmOKbEYvuTc74vdQq9yb+xusD
         K3VFRBGOEqXqSKRyd2TD53neDZIMEuMoN44x4SsEix1Ps4WH7t6RHLijp/3M00P9tX7n
         4ssjslkFbQITSEUUMCWBGDV3NbJ7CkRpxpJTC4HdYQoZMj0H8aY62AGBKowbBwoAkC9B
         MaTiNYyuUXK0QZ+yjaUO0ryEoQOmT+MhKneAXtTKlqBoHX10a3p8C8Ps5eYWZnlcq1Y+
         cL//Cw13cPf6KpQ2GS3nWpTQcmhDcCac64nyObrebF5XCoMpLA196iVWW4zLjsGdPIoL
         10/w==
X-Gm-Message-State: AOAM533YnDHPyWZoQnxTHUV6VILHoscedZG7lkLJXD2y/PahXDgn7Z3r
        9qOTMRi5ALaRXbaBzOBFQR55BCaJzpTjOJZsSOw++w==
X-Google-Smtp-Source: ABdhPJwB6dHixzfnFB/aFW5sbmzpMc+ZugeT0IDT1VPile7+mVN6XZnPjFDa4fuF2gd1rm7gYsaquR4HrkRhYX6DvtY=
X-Received: by 2002:a05:600c:4fc4:b0:37c:9116:ef3d with SMTP id
 o4-20020a05600c4fc400b0037c9116ef3dmr4551689wmq.167.1645561230799; Tue, 22
 Feb 2022 12:20:30 -0800 (PST)
MIME-Version: 1.0
References: <20220222165212.2005066-1-kaleshsingh@google.com>
 <20220222165212.2005066-6-kaleshsingh@google.com> <YhUsQZUqgb94EjmD@lakrids>
In-Reply-To: <YhUsQZUqgb94EjmD@lakrids>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Tue, 22 Feb 2022 12:20:19 -0800
Message-ID: <CAC_TJvdo2UwrZwKGhZUTnCF--CNsKJFKe+tZOQWgs0=BhpBF0g@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] arm64: asm: Introduce test_sp_overflow macro
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Fuad Tabba <tabba@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Scull <ascull@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
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

On Tue, Feb 22, 2022 at 10:32 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Feb 22, 2022 at 08:51:06AM -0800, Kalesh Singh wrote:
> > From: Quentin Perret <qperret@google.com>
> >
> > The asm entry code in the kernel uses a trick to check if VMAP'd stacks
> > have overflowed by aligning them at THREAD_SHIFT * 2 granularity and
> > checking the SP's THREAD_SHIFT bit.
> >
> > Protected KVM will soon make use of a similar trick to detect stack
> > overflows, so factor out the asm code in a re-usable macro.
> >
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > [Kalesh - Resolve minor conflicts]
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >  arch/arm64/include/asm/assembler.h | 11 +++++++++++
> >  arch/arm64/kernel/entry.S          |  7 +------
> >  2 files changed, 12 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> > index e8bd0af0141c..ad40eb0eee83 100644
> > --- a/arch/arm64/include/asm/assembler.h
> > +++ b/arch/arm64/include/asm/assembler.h
> > @@ -850,4 +850,15 @@ alternative_endif
> >
> >  #endif /* GNU_PROPERTY_AARCH64_FEATURE_1_DEFAULT */
> >
> > +/*
> > + * Test whether the SP has overflowed, without corrupting a GPR.
> > + */
> > +.macro test_sp_overflow shift, label
> > +     add     sp, sp, x0                      // sp' = sp + x0
> > +     sub     x0, sp, x0                      // x0' = sp' - x0 = (sp + x0) - x0 = sp
> > +     tbnz    x0, #\shift, \label
> > +     sub     x0, sp, x0                      // x0'' = sp' - x0' = (sp + x0) - sp = x0
> > +     sub     sp, sp, x0                      // sp'' = sp' - x0 = (sp + x0) - x0 = sp
> > +.endm
>
> I'm a little unhappy about factoring this out, since it's not really
> self-contained and leaves sp and x0 partially-swapped when it branches
> to the label. You can't really make that clear with comments on the
> macro, and you need comments at each use-sire, so I'd ratehr we just
> open-coded a copy of this.
>
> > +
> >  #endif       /* __ASM_ASSEMBLER_H */
> > diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> > index 772ec2ecf488..ce99ee30c77e 100644
> > --- a/arch/arm64/kernel/entry.S
> > +++ b/arch/arm64/kernel/entry.S
> > @@ -53,15 +53,10 @@ alternative_else_nop_endif
> >       sub     sp, sp, #PT_REGS_SIZE
> >  #ifdef CONFIG_VMAP_STACK
> >       /*
> > -      * Test whether the SP has overflowed, without corrupting a GPR.
> >        * Task and IRQ stacks are aligned so that SP & (1 << THREAD_SHIFT)
> >        * should always be zero.
> >        */
> > -     add     sp, sp, x0                      // sp' = sp + x0
> > -     sub     x0, sp, x0                      // x0' = sp' - x0 = (sp + x0) - x0 = sp
> > -     tbnz    x0, #THREAD_SHIFT, 0f
> > -     sub     x0, sp, x0                      // x0'' = sp' - x0' = (sp + x0) - sp = x0
> > -     sub     sp, sp, x0                      // sp'' = sp' - x0 = (sp + x0) - x0 = sp
> > +     test_sp_overflow THREAD_SHIFT, 0f
> >       b       el\el\ht\()_\regsize\()_\label
> >
> >  0:
>
> Further to my comment above, immediately after this we have:
>
>         /* Stash the original SP (minus PT_REGS_SIZE) in tpidr_el0. */
>         msr     tpidr_el0, x0
>
>         /* Recover the original x0 value and stash it in tpidrro_el0 */
>         sub     x0, sp, x0
>         msr     tpidrro_el0, x0
>
> ... which is really surprising with the `test_sp_overflow` macro because
> it's not clear that modifies x0 and sp in this way.

Hi Mark,

I agree the macro hides the fact that sp and x0 are left in an
'corrupt' state if the branch happens. Not a problem in this case but
it could be misleading to new users. I'll remove this per your
suggestion in the next version.

Thanks,
Kalesh
>
> Thanks,
> Mark.
> ...
>
> > --
> > 2.35.1.473.g83b2b277ed-goog
> >

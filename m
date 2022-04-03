Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471DF4F084D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 09:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242597AbiDCHjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 03:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbiDCHjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 03:39:01 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CD23614F
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 00:37:07 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id p15so13967686ejc.7
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 00:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IGvz+saGqGJ7n4uIJ25zKRG9x6+wAmAWhzfjK7OHNP8=;
        b=k30o2vFaWNsgROXTs/2LzyBi7ggbM3drImTq01cuYrYB5rBgld+5LH23t38QhCrc88
         K/3PK3XDaItwLglQNZmGWhysvvhjstzP6Zj5CVN0kTK/jaID7j0KdGwLuOYZ9Ft4g12D
         4T0ZTxi1GuAEt026qDezcadOHAXvjrdBpYNe/e+BZjPQvAGQ786dG2m5ofvUzku2csIp
         xemxZfXkLUAZx6cHjrZ/loERSWbqshsCKJYihnUC88qdk/iUBA6IGLDJoWjPOLBhlFCt
         rqkzVLUHyAZ8syuZd1Cp3apuD3fnIxNBo3PGV3iw4xKGdtog6iveGakNDV0OvHff/yEw
         8gSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IGvz+saGqGJ7n4uIJ25zKRG9x6+wAmAWhzfjK7OHNP8=;
        b=EF/eLuXFzCXCCIGCTnYJmPhZnWpHmzt2cpe8mowK+LZjn8RYfC/vVK+zH7NKjFkjW0
         RVhbNAHxrmsgPlqGcAypSY8QsD2DPHrrOJF+gjGhTD83PxboOmLe+9gIu/dK0GJaHqj3
         h7EFk948mUZw1zQ9B0XhCPQb07ys3/2n6/6Dp6JfOiZeiswUtyPy0ezELeBQsLo03VJE
         3s3WGtlKihnW7Zll30UVfOh/T0J5QsxRVHgmNFpQVcs3DlgVdx6MB8bSzbFyBTb+vJau
         Djtb7j7CYnIV3kPdXGoy4EG2tKoStPNZBJ6aiV1QKukx3IOJGwVPyspGuhvutTTShfS5
         r5zg==
X-Gm-Message-State: AOAM531LzFVSEkuy/pYw9j1bngxBvDPS5VWlPJ5/4xZNjwOh0J/qpr/d
        1TpPSEl2L5MQP3D+WI0s4KXobuM7t3x3jSDF8tU=
X-Google-Smtp-Source: ABdhPJybhkbRVQxK8WVuOfZRCgeD+Vb4Z0HllGMHwZI1hv0bKzlEbnFYsHiCO3xxy/9xs9Yuu4WMyoOkWamj/7QWdeU=
X-Received: by 2002:a17:906:7314:b0:6df:839f:af7 with SMTP id
 di20-20020a170906731400b006df839f0af7mr6271448ejc.65.1648971426309; Sun, 03
 Apr 2022 00:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220401164406.61583-1-jeremy.linton@arm.com> <Ykc0xrLv391/jdJj@FVFF77S0Q05N>
In-Reply-To: <Ykc0xrLv391/jdJj@FVFF77S0Q05N>
From:   Andrew Pinski <pinskia@gmail.com>
Date:   Sun, 3 Apr 2022 00:36:53 -0700
Message-ID: <CA+=Sn1k23tzMKbMWKW7c3EBoXidJCT-k_k_oF_sKTsGLJTKTnw@mail.gmail.com>
Subject: Re: [PATCH] arm64/io: Remind compiler that there is a memory side effect
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        GCC Mailing List <gcc@gcc.gnu.org>, f.fainelli@gmail.com,
        maz@kernel.org, marcan@marcan.st,
        LKML <linux-kernel@vger.kernel.org>, opendmb@gmail.com,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
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

On Fri, Apr 1, 2022 at 10:24 AM Mark Rutland via Gcc <gcc@gcc.gnu.org> wrote:
>
> Hi Jeremy,
>
> Thanks for raising this.
>
> On Fri, Apr 01, 2022 at 11:44:06AM -0500, Jeremy Linton wrote:
> > The relaxed variants of read/write macros are only declared
> > as `asm volatile()` which forces the compiler to generate the
> > instruction in the code path as intended. The only problem
> > is that it doesn't also tell the compiler that there may
> > be memory side effects. Meaning that if a function is comprised
> > entirely of relaxed io operations, the compiler may think that
> > it only has register side effects and doesn't need to be called.
>
> As I mentioned on a private mail, I don't think that reasoning above is
> correct, and I think this is a miscompilation (i.e. a compiler bug).
>
> The important thing is that any `asm volatile` may have a side effects
> generally outside of memory or GPRs, and whether the assembly contains a memory
> load/store is immaterial. We should not need to add a memory clobber in order
> to retain the volatile semantic.
>
> See:
>
>   https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Volatile
>
> ... and consider the x86 example that reads rdtsc, or an arm64 sequence like:
>
> | void do_sysreg_thing(void)
> | {
> |       unsigned long tmp;
> |
> |       tmp = read_sysreg(some_reg);
> |       tmp |= SOME_BIT;
> |       write_sysreg(some_reg);
> | }
>
> ... where there's no memory that we should need to hazard against.
>
> This patch might workaround the issue, but I don't believe it is a correct fix.

It might not be the most restricted fix but it is a fix.
The best fix is to tell that you are writing to that location of memory.
volatile asm does not do what you think it does.
You didn't read further down about memory clobbers:
https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Clobbers-and-Scratch-Registers
Specifically this part:
The "memory" clobber tells the compiler that the assembly code
performs memory reads or writes to items other than those listed in
the input and output operands




>
> > For an example function look at bcmgenet_enable_dma(), before the
> > relaxed variants were removed. When built with gcc12 the code
> > contains the asm blocks as expected, but then the function is
> > never called.
>
> So it sounds like this is a regression in GCC 12, which IIUC isn't released yet
> per:

It is NOT a bug in GCC 12. Just you depended on behavior which
accidently worked in the cases you were looking at. GCC 12 did not
change in this area at all even.

Thanks,
Andrew Pinski

>
>   https://gcc.gnu.org/gcc-12/changes.html
>
> ... which says:
>
> | Note: GCC 12 has not been released yet
>
> Surely we can fix it prior to release?
>
> Thanks,
> Mark.
>
> >
> > Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> > ---
> >  arch/arm64/include/asm/io.h | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
> > index 7fd836bea7eb..3cceda7948a0 100644
> > --- a/arch/arm64/include/asm/io.h
> > +++ b/arch/arm64/include/asm/io.h
> > @@ -24,25 +24,25 @@
> >  #define __raw_writeb __raw_writeb
> >  static inline void __raw_writeb(u8 val, volatile void __iomem *addr)
> >  {
> > -     asm volatile("strb %w0, [%1]" : : "rZ" (val), "r" (addr));
> > +     asm volatile("strb %w0, [%1]" : : "rZ" (val), "r" (addr) : "memory");
> >  }
> >
> >  #define __raw_writew __raw_writew
> >  static inline void __raw_writew(u16 val, volatile void __iomem *addr)
> >  {
> > -     asm volatile("strh %w0, [%1]" : : "rZ" (val), "r" (addr));
> > +     asm volatile("strh %w0, [%1]" : : "rZ" (val), "r" (addr) : "memory");
> >  }
> >
> >  #define __raw_writel __raw_writel
> >  static __always_inline void __raw_writel(u32 val, volatile void __iomem *addr)
> >  {
> > -     asm volatile("str %w0, [%1]" : : "rZ" (val), "r" (addr));
> > +     asm volatile("str %w0, [%1]" : : "rZ" (val), "r" (addr) : "memory");
> >  }
> >
> >  #define __raw_writeq __raw_writeq
> >  static inline void __raw_writeq(u64 val, volatile void __iomem *addr)
> >  {
> > -     asm volatile("str %x0, [%1]" : : "rZ" (val), "r" (addr));
> > +     asm volatile("str %x0, [%1]" : : "rZ" (val), "r" (addr) : "memory");
> >  }
> >
> >  #define __raw_readb __raw_readb
> > --
> > 2.35.1
> >

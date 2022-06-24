Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8A1559442
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 09:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiFXHda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 03:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiFXHd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 03:33:29 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D0F4EF71
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 00:33:27 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id k20so1390943qkj.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 00:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fR6uKfBDYRieZiuAMXFfm7AitfVVlF5V4Jud/klMDd0=;
        b=rBsMrbkOvHn2lXCYMQP3Wze/vl2AJoykTr0v0omTH75CKCTzEQINNWWBGN+2N94qPS
         lboLFvCO1H+csqUpI/DfYbOIdCZvQUM8nC8x7eTXRmW3+3KC9ArjftWj3gY2Ld/RZTVA
         8BKqI8dnZPVNp1VInit08K9O92G56LBkXs3gevqoY2NKwxuf8WbjkGx2xsu0J1gqJa+S
         aybJWcWeYQ4qCjVsldNl2BDAnCq+rnwJmWZP1Wdme5lOG0KHw9H33siUdxHRs+jwk1I7
         pNwBXN5qGg7TBo4g5SXSxJmyLzOKtRfWUslXzvkOIgLfruSt2u1vor59m0ld+bBr9ZaV
         EZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fR6uKfBDYRieZiuAMXFfm7AitfVVlF5V4Jud/klMDd0=;
        b=QDu3tmK1gRBJyN76LTZ1h+eXctayjsPf4WXHgzrOwWEFlSqHVR/YteaFn6kEt6S9rt
         h2NAgaH2QDh1Mg0c/piv7KHm4Xfl+0pZXSib+sy5iuFq7GtB/nDZ8bsbMKneiW+TuIvB
         qE/IfhaL6DLUI0wCN4dnXrwc45ej54XKO6i/j/SA0ViGrnIbeu5wUkC6ipB/Q7uSyOfg
         lU4x1GWMQDoqgpzSGv/9F1VSqRgIo7f3Ti8usYHmhJFE6/N1eyXFI+YuIZby8Iw9EVLJ
         zc8Jy2s9JawCSPOgQsQlrhQH8eQSbBvkC7PG4UKmX1818ly4qAJKm+RweArzrQJ4rEvr
         q2Aw==
X-Gm-Message-State: AJIora967r4cJVB98ty6xIcyCB1Uu5hFY1sue0jEyNRTPbPEnKujsXz7
        ysW8r/jsz1fjyEAnJMLLcNLdeFnZom173bZ9kjQfsA==
X-Google-Smtp-Source: AGRyM1vW1GrBPEbbxDBjM3RFXMgO6JY9qkykLiXUWcYVbtoEe0fi2Nqvgwk1vmP6EaWE+FZAKs3xUig5WBYfQruzVC0=
X-Received: by 2002:a05:620a:4591:b0:6a7:5a82:3d2d with SMTP id
 bp17-20020a05620a459100b006a75a823d2dmr9266728qkb.694.1656056006349; Fri, 24
 Jun 2022 00:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220623152948.1607295-1-christoph.muellner@vrull.eu> <1903087.PYKUYFuaPT@diego>
In-Reply-To: <1903087.PYKUYFuaPT@diego>
From:   =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Date:   Fri, 24 Jun 2022 09:33:15 +0200
Message-ID: <CAEg0e7g2jfT1X0pMo8oNaaeQ5B6d=qJe-YK0r8vrDzbFYE_ARQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] riscv: Add Zawrs support for spinlocks
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Aaron Durbin <adurbin@rivosinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Atish Patra <atishp@atishpatra.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 6:32 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Hi Christoph,
>
> Am Donnerstag, 23. Juni 2022, 17:29:48 CEST schrieb Christoph Muellner:
> > From: Christoph M=C3=BCllner <christoph.muellner@vrull.eu>
> >
> > The current RISC-V code uses the generic ticket lock implementation,
> > that calls the macros smp_cond_load_relaxed() and smp_cond_load_acquire=
().
> > Currently, RISC-V uses the generic implementation of these macros.
> > This patch introduces a RISC-V specific implementation, of these
> > macros, that peels off the first loop iteration and modifies the waitin=
g
> > loop such, that it is possible to use the WRS.STO instruction of the Za=
wrs
> > ISA extension to stall the CPU.
> >
> > The resulting implementation of smp_cond_load_*() will only work for
> > 32-bit or 64-bit types for RV64 and 32-bit types for RV32.
> > This is caused by the restrictions of the LR instruction (RISC-V only
> > has LR.W and LR.D). Compiler assertions guard this new restriction.
> >
> > This patch uses the existing RISC-V ISA extension framework
> > to detect the presents of Zawrs at run-time.
> > If available a NOP instruction will be replaced by WRS.NTO or WRS.STO.
> >
> > The whole mechanism is gated by Kconfig setting, which defaults to Y.
> >
> > The Zawrs specification can be found here:
> > https://github.com/riscv/riscv-zawrs/blob/main/zawrs.adoc
> >
> > Note, that the Zawrs extension is not frozen or ratified yet.
> > Therefore this patch is an RFC and not intended to get merged.
> >
> > Changes since v1:
> > * Adding "depends on !XIP_KERNEL" to RISCV_ISA_ZAWRS
> > * Fixing type checking code in __smp_load_reserved*
> > * Adjustments according to the specification change
> >
> > Signed-off-by: Christoph M=C3=BCllner <christoph.muellner@vrull.eu>
>
> With the matching Qemu-Patch on
> - rv64 + Debian rootfs
> - rv32 + 32bit-Buildroot rootfs
>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
>
> apart from the one nit below
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>
> > ---
> >  arch/riscv/Kconfig                   | 11 ++++
> >  arch/riscv/include/asm/barrier.h     | 92 ++++++++++++++++++++++++++++
> >  arch/riscv/include/asm/errata_list.h | 19 +++++-
> >  arch/riscv/include/asm/hwcap.h       |  3 +-
> >  arch/riscv/kernel/cpu.c              |  1 +
> >  arch/riscv/kernel/cpufeature.c       | 13 ++++
> >  6 files changed, 136 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 32ffef9f6e5b..9d40569237c9 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -358,6 +358,17 @@ config RISCV_ISA_C
> >
> >          If you don't know what to do here, say Y.
> >
> > +config RISCV_ISA_ZAWRS
> > +     bool "Zawrs extension support"
> > +     depends on !XIP_KERNEL
> > +     select RISCV_ALTERNATIVE
> > +     default y
> > +     help
> > +        Adds support to dynamically detect the presence of the Zawrs e=
xtension
> > +        (wait for reservation set) and enable its usage.
> > +
> > +        If you don't know what to do here, say Y.
> > +
> >  config RISCV_ISA_SVPBMT
> >       bool "SVPBMT extension support"
> >       depends on 64BIT && MMU
> > diff --git a/arch/riscv/include/asm/barrier.h b/arch/riscv/include/asm/=
barrier.h
> > index d0e24aaa2aa0..1f9628aaa7cb 100644
> > --- a/arch/riscv/include/asm/barrier.h
> > +++ b/arch/riscv/include/asm/barrier.h
> > @@ -12,6 +12,8 @@
> >
> >  #ifndef __ASSEMBLY__
> >
> > +#include <asm/errata_list.h>
> > +
> >  #define nop()                __asm__ __volatile__ ("nop")
> >
> >  #define RISCV_FENCE(p, s) \
> > @@ -42,6 +44,64 @@ do {                                                =
                       \
> >       ___p1;                                                          \
> >  })
> >
> > +#if __riscv_xlen =3D=3D 64
> > +
>
> nit: I guess we could do without the extra blanks?
> asm.h does so, and also the #else block below also doesn't
> use them ;-) . But I guess that is more a style debate

Ok, will remove the empty lines in a new revision.

Thanks!


>
> > +#define __riscv_lrsc_word(t)                                         \
> > +     (sizeof(t) =3D=3D sizeof(int) ||                                 =
   \
> > +      sizeof(t) =3D=3D sizeof(long))
> > +
> > +#elif __riscv_xlen =3D=3D 32
> > +
> > +#define __riscv_lrsc_word(t)                                         \
> > +     (sizeof(t) =3D=3D sizeof(int))
> > +
> > +#else
> > +#error "Unexpected __riscv_xlen"
> > +#endif /* __riscv_xlen */
>
> [...]
>
> Thanks
> Heiko
>
>

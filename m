Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE25467AC9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 17:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381950AbhLCQK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 11:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244701AbhLCQK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 11:10:57 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D57C061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 08:07:32 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 131so10668434ybc.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 08:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UGM7UBMu9hpWc2CpdHHwIO9PerlU890k24SrZiue448=;
        b=N6sEXlj+o/uYovaKtOnHtS3iWp++ez1sdPFxvq0U0x9CPrKqNF7G4GyZWnRb6RC4LS
         9daz1H/B9g2ugXoyyaijPGsjG90NK7HyHk10gzvQqhr6iv7iNhKOgjsP525OQ8z9DUZG
         WiZ/B+Vx7/U7w41cTwM+S2POYpDeKa7VE1SEWKYiFQe38hFqoNgHlIAT1z2mWjOfmBZa
         vDBnG4UXNGjtmZ2ou4KpRRzEkBUKhskIdVy0XuDvz+fUJbqAN7zexWcKgqLLQ6ru1b/x
         bFf+QMKN2NEN+U/OlR8pThIz6diqVCR5DLt9E5J7nUNrvH1GfPURXqp2uIqEVyuecIRy
         XIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UGM7UBMu9hpWc2CpdHHwIO9PerlU890k24SrZiue448=;
        b=Rj2uF0f4Oy6ybndXwgfaXZuAgQEJK6dlEhyXl90NUXQeBM1YrYFB0AxKTaxBSe5d76
         pL3mR0mecY3W2tLcQO+PyJrCt/WbbSe88pgiocQ2mHn3lHbIptYfZkqLsDyt6hkjk4K1
         GxKDiOdAsKdrrF7Du3ZKxYAhOdOBwRu39yyfsoWAV3AUy/ZBytxguyMx8RftTvgJHLsO
         rZaKpBBtu+po3w1JTL6VsV/GYsBosT3wH7ocO/QdoXQa+KhGycwsg+rx7ivGIHay/qIF
         TRL8lRCI+1SdYayCV+LKnp8V2jptXOdmvn4Hb2zDLNldFqMcTT41PIUdZb+/uMtKsC0a
         g5ig==
X-Gm-Message-State: AOAM532aRNB9dTdJ+2Ahmqu2I7VakF4B8TL8vaTd+37p7CVDffdZ75oB
        LfuyxjKad4bdGc1FKEaTM5m7LHlyGrEu8yNwbo6YUQ==
X-Google-Smtp-Source: ABdhPJz6uNB4YJ0bQ7FWsAHlz+kuVJK0fVf6C9Ze629WR8+BmMgjr0LuKxp936uRsYd0I+7nFLi7jwf2FGYnWLmARdU=
X-Received: by 2002:a25:b204:: with SMTP id i4mr23135408ybj.263.1638547651747;
 Fri, 03 Dec 2021 08:07:31 -0800 (PST)
MIME-Version: 1.0
References: <20211203052908.7467-1-ben.dai@unisoc.com> <Yan7nD6U1I0m5uKY@FVFF77S0Q05N>
In-Reply-To: <Yan7nD6U1I0m5uKY@FVFF77S0Q05N>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 3 Dec 2021 08:07:20 -0800
Message-ID: <CABCJKuf__Lm7eJN8FqRRs1Ax3guX_WpD66Hahs5zzmSo5bbe7Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: fix the address of syscall in arch_syscall_addr if
 CFI is enabled
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Ben Dai <ben.dai9703@gmail.com>, ndesaulniers@google.com,
        rostedt@goodmis.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Ben Dai <ben.dai@unisoc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peter.zijlstra@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 3, 2021 at 3:12 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi Ben,
>
> Please Cc the arm64 maintainers for arm64 patches, you can find the relevant
> folk in the MAINTAINERS file, and you can use the get_maintainer.pl script to
> find them automatically (e.g. with `./scripts/get_maintainer.pl ${PATCH}` or
> `./scripts/get_maintainer.pl -f ${FILE}`).
>
> For arm64 patches, you should also see LAKML
> (linux-arm-kernel@lists.infradead.org).
>
> I've added Will and Catalin now, and Ard and Peter too since they've btoh been
> fighting with things in this area.
>
> On Fri, Dec 03, 2021 at 01:29:08PM +0800, Ben Dai wrote:
> > With CONFIG_CFI_CLANG, the addresses in sys_call_table[] actually point to
> > jump instructions like "b __arm64_sys_*", and if CONFIG_LTO_CLANG_FULL is
> > enabled, the compiler will not generate a symbol for each jump. It causes
> > syscall tracer can't get symbol name in find_syscall_meta() and fail to
> > initialize.
> >
> > To fix this problem, implement an strong definition of arch_syscall_addr()
> > to get the actual addresses of system calls.
> >
> > Signed-off-by: Ben Dai <ben.dai@unisoc.com>

I don't think this is the correct solution. I believe Nick fixed the
issue with missing symbols in https://reviews.llvm.org/D107934, so we
should probably just require a newer compiler version here.

> > ---
> >  arch/arm64/kernel/syscall.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> > index 50a0f1a38e84..2b911603966b 100644
> > --- a/arch/arm64/kernel/syscall.c
> > +++ b/arch/arm64/kernel/syscall.c
> > @@ -12,6 +12,8 @@
> >  #include <asm/debug-monitors.h>
> >  #include <asm/exception.h>
> >  #include <asm/fpsimd.h>
> > +#include <asm/insn.h>
> > +#include <asm/patching.h>
> >  #include <asm/syscall.h>
> >  #include <asm/thread_info.h>
> >  #include <asm/unistd.h>
> > @@ -19,6 +21,25 @@
> >  long compat_arm_syscall(struct pt_regs *regs, int scno);
> >  long sys_ni_syscall(void);
> >
> > +#ifdef CONFIG_CFI_CLANG
> > +unsigned long __init arch_syscall_addr(int nr)
> > +{
> > +     u32 insn;
> > +     unsigned long addr = (unsigned long)sys_call_table[nr];
> > +
> > +     /*
> > +      * Clang's CFI will replace the address of each system call function
> > +      * with the address of a jump table entry. In this case, the jump
> > +      * target address is the actual address of the system call.
> > +      */
> > +     aarch64_insn_read((void *)addr, &insn);
> > +     if (likely(aarch64_insn_is_b(insn)))
> > +             addr += aarch64_get_branch_offset(insn);
>
> The problemn is not your fault, but I absolutely hate this, because we're
> bodging around the compiler having broken stuff for us in the first place.
> We've been encountering more of these cases over time, and had we been aware of
> them to begin with we'd have strongly pushed back on marging the CFI patches
> until the compiler offered a better solution.
>
> My view is that the current clang CFI scheme is broken by design here, and we
> should mark tracing as incompatible with it for now, and work with the compiler
> folk to get a scheme that actually works, rather than trying to bodge around
> it.

We are actively fixing compiler issues when they're discovered. In the
meanwhile, Android uses both CFI and tracing without any major issues,
so I don't see why we should mark the combination broken.

Sami

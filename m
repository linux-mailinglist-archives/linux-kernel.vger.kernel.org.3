Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D7A5B230A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 18:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbiIHQDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 12:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbiIHQDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 12:03:35 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BD9CCE25
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 09:03:29 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-345528ceb87so113285587b3.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 09:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=9jDIgaiDOueBZywEIJYtrnQ4M8lU4j/xUU5lsSusSWQ=;
        b=w7oP9Mam2FF5isqkBFvrRGCu0IZdmwvaAmasErePzQDAKe1DC8g7Ioy3GAmttBr4aZ
         i7mcQz9QfxOPs6O2hMgfUUDEWyAfy5UipJ62kuiIvLHHkl7pFBZFA9uZoIwZdVpoywzt
         kYmAp0ZdbbsjUKK6jg7CB4Ta7vceYccoDG5Qyoml5JQMYc8vfPhpZ1pwP9gWyzbMrGQe
         xHDi8Gd7QQ9OUHBSkfu/7rebK3hSfY0A/hFr1M99lKv6m6DjoMLs6bH+UU2TPZtWwgsd
         L1qXiq25W3uA56FRjl4DSkgISLQust05sQaa/2j6/Ffrg+OkpfW56NgdJ8H6uv65Q8XK
         ii3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9jDIgaiDOueBZywEIJYtrnQ4M8lU4j/xUU5lsSusSWQ=;
        b=3N2xjcg1iwYf51QCzNRVqJ94yO8IiGlk+icJz6wL1O2AFcaWK8GjECl2KYuk2WLnag
         +DKtaDmq8NME4k/Jyzv3eixWD4gYaSBJ8v+IHcITGNm/EhXnQeWIzj8U+2zDFIgC7dSA
         F5yO663mwjfRuvyPkmnTNf2N5gdWcI/33C21TjvD2N17sdzuZCfxgctaGdWFegMp1BT9
         A5trzBSWDbsdiWajjxcDpqYbjb4DG5RlArRQ+UzIhKVA+morwbGAQT7ACVlSxxu87at7
         eR6w6gTv5sqWUhil6A6lkFa/Q+kSOBrxVhmHJBkQuyB207anpxiwCoOd8KxpYhNAEmyJ
         6l/g==
X-Gm-Message-State: ACgBeo0i/wsltvj4KJbxcEVWX/0vt26an+5kBidN5Oyi4X1gCcUtQsiy
        KZWqkXRypjVfvtzg5WDMRALBZ+pgIIGMIy8Njkda5A==
X-Google-Smtp-Source: AA6agR4Jd6UzszZSbhssCptu3gk3s0Y88Z77skDGyRd6UzQCdc27W75KBjszSyjEUahkjPYoooq704swveDF4P6hF/c=
X-Received: by 2002:a81:8006:0:b0:336:e100:8206 with SMTP id
 q6-20020a818006000000b00336e1008206mr8179205ywf.427.1662653008926; Thu, 08
 Sep 2022 09:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220831172500.752195-1-ajones@ventanamicro.com>
 <20220831172500.752195-3-ajones@ventanamicro.com> <3006889.o7ts2hSHzF@diego>
In-Reply-To: <3006889.o7ts2hSHzF@diego>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 8 Sep 2022 21:33:15 +0530
Message-ID: <CAAhSdy0yiYZFhcxvDr22h1+NWgQAc-APhZfErdfgcHD1kMosfg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] riscv: Introduce support for defining instructions
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        mchitale@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 8, 2022 at 9:19 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Mittwoch, 31. August 2022, 19:24:58 CEST schrieb Andrew Jones:
> > When compiling with toolchains that haven't yet been taught about
> > new instructions we need to encode them ourselves. Create a new file
> > where support for instruction definitions will evolve. We initiate
> > the file with a macro called INSN_R(), which implements the R-type
> > instruction encoding. INSN_R() will use the assembler's .insn
> > directive when available, which should give the assembler a chance
> > to do some validation. When .insn is not available we fall back to
> > manual encoding.
> >
> > Not only should using instruction encoding macros improve readability
> > and maintainability of code over the alternative of inserting
> > instructions directly (e.g. '.word 0xc0de'), but we should also gain
> > potential for more optimized code after compilation because the
> > compiler will have control over the input and output registers used.
> >
> > Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> > Reviewed-by: Anup Patel <anup@brainfault.org>
> > ---
> >  arch/riscv/Kconfig                |  3 ++
> >  arch/riscv/include/asm/insn-def.h | 86 +++++++++++++++++++++++++++++++
> >  2 files changed, 89 insertions(+)
> >  create mode 100644 arch/riscv/include/asm/insn-def.h
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index ed66c31e4655..f8f3b316b838 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -227,6 +227,9 @@ config RISCV_DMA_NONCOHERENT
> >       select ARCH_HAS_SETUP_DMA_OPS
> >       select DMA_DIRECT_REMAP
> >
> > +config AS_HAS_INSN
> > +     def_bool $(as-instr,.insn r 51$(comma) 0$(comma) 0$(comma) t0$(co=
mma) t0$(comma) zero)
> > +
> >  source "arch/riscv/Kconfig.socs"
> >  source "arch/riscv/Kconfig.erratas"
> >
> > diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm=
/insn-def.h
> > new file mode 100644
> > index 000000000000..2dcd1d4781bf
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/insn-def.h
> > @@ -0,0 +1,86 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +
> > +#ifndef __ASM_INSN_DEF_H
> > +#define __ASM_INSN_DEF_H
> > +
> > +#include <asm/asm.h>
> > +
> > +#define INSN_R_FUNC7_SHIFT           25
> > +#define INSN_R_RS2_SHIFT             20
> > +#define INSN_R_RS1_SHIFT             15
> > +#define INSN_R_FUNC3_SHIFT           12
> > +#define INSN_R_RD_SHIFT                       7
> > +#define INSN_R_OPCODE_SHIFT           0
> > +
> > +#ifdef __ASSEMBLY__
> > +
> > +#ifdef CONFIG_AS_HAS_INSN
> > +
> > +     .macro insn_r, opcode, func3, func7, rd, rs1, rs2
> > +     .insn   r \opcode, \func3, \func7, \rd, \rs1, \rs2
> > +     .endm
> > +
> > +#else
> > +
> > +#include <asm/gpr-num.h>
> > +
> > +     .macro insn_r, opcode, func3, func7, rd, rs1, rs2
> > +     .4byte  ((\opcode << INSN_R_OPCODE_SHIFT) |             \
> > +              (\func3 << INSN_R_FUNC3_SHIFT) |               \
> > +              (\func7 << INSN_R_FUNC7_SHIFT) |               \
> > +              (.L__gpr_num_\rd << INSN_R_RD_SHIFT) |         \
> > +              (.L__gpr_num_\rs1 << INSN_R_RS1_SHIFT) |       \
> > +              (.L__gpr_num_\rs2 << INSN_R_RS2_SHIFT))
> > +     .endm
> > +
> > +#endif
> > +
> > +#define INSN_R(...)  insn_r __VA_ARGS__
> > +
> > +#else /* ! __ASSEMBLY__ */
> > +
> > +#ifdef CONFIG_AS_HAS_INSN
> > +
> > +#define INSN_R(opcode, func3, func7, rd, rs1, rs2)   \
> > +     ".insn  r " opcode ", " func3 ", " func7 ", " rd ", " rs1 ", " rs=
2 "\n"
> > +
> > +#else
> > +
> > +#include <linux/stringify.h>
> > +#include <asm/gpr-num.h>
> > +
> > +#define DEFINE_INSN_R                                                 =
       \
> > +     __DEFINE_ASM_GPR_NUMS                                           \
> > +"    .macro insn_r, opcode, func3, func7, rd, rs1, rs2\n"            \
> > +"    .4byte  ((\\opcode << " __stringify(INSN_R_OPCODE_SHIFT) ") |"  \
> > +"             (\\func3 << " __stringify(INSN_R_FUNC3_SHIFT) ") |"    \
> > +"             (\\func7 << " __stringify(INSN_R_FUNC7_SHIFT) ") |"    \
> > +"             (.L__gpr_num_\\rd << " __stringify(INSN_R_RD_SHIFT) ") |=
"    \
> > +"             (.L__gpr_num_\\rs1 << " __stringify(INSN_R_RS1_SHIFT) ")=
 |"  \
> > +"             (.L__gpr_num_\\rs2 << " __stringify(INSN_R_RS2_SHIFT) ")=
)\n" \
> > +"    .endm\n"
> > +
> > +#define UNDEFINE_INSN_R                                               =
       \
> > +"    .purgem insn_r\n"
> > +
> > +#define INSN_R(opcode, func3, func7, rd, rs1, rs2)                   \
> > +     DEFINE_INSN_R                                                   \
> > +     "insn_r " opcode ", " func3 ", " func7 ", " rd ", " rs1 ", " rs2 =
"\n" \
> > +     UNDEFINE_INSN_R
> > +
> > +#endif
> > +
> > +#endif /* ! __ASSEMBLY__ */
> > +
> > +#define OPCODE(v)    __ASM_STR(v)
> > +#define FUNC3(v)     __ASM_STR(v)
> > +#define FUNC7(v)     __ASM_STR(v)
> > +#define RD(v)                __ASM_STR(v)
> > +#define RS1(v)               __ASM_STR(v)
> > +#define RS2(v)               __ASM_STR(v)
>
> you might want some sort of prefix here
>         RISCV_RS1(v) ?
>
> While trying to adapt this for the cmo stuff I ran into the issue
> of bpf complaining that "IMM" is already defined there.
>
> And names above are generic enough that these also
> might conflict with other stuff.

I can update the KVM RISC-V queue but I suggest to
use a smaller prefix. Maybe RV_xyz() ?

Regards,
Anup

>
>
>
>
> > +#define __REG(v)     __ASM_STR(x ## v)
> > +#define __RD(v)              __REG(v)
> > +#define __RS1(v)     __REG(v)
> > +#define __RS2(v)     __REG(v)
> > +
> > +#endif /* __ASM_INSN_DEF_H */
> >
>
>
>
>

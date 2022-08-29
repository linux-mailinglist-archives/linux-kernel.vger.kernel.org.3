Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5904E5A4512
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiH2Ib2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiH2IbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:31:24 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAFA44540
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:31:23 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-334dc616f86so177365617b3.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=HhkDsDA80zH9OWHmK2nGu5RFBtVZXnjtoCv9dyej5Ag=;
        b=vTlFk8K6+piI/hraTj4z1RaLXDO11MVfTc34bTdeBTn5goYp3OBp6ubASyg/IWIsSO
         qOgvhHINIv5IhkS2DXq9clfHMQVsppY9NHqRS4qX3cPh3RQFcZzhoCNHnZEfd6RVcvR4
         SJWonWz802UBhbCeZrytqddkf+0Obs+1cShEt+b1wk1KzBiukT+KcfuySTJvSdvhVhyA
         uamZeh060q9HBxj/ek+mIVhLMNG7AIHwecA59dqLvvWDztIor2kBKSF26dvdCAovijSo
         Qifs6y9N7N0MFjYxmtItcDCCBrP6FHKO8ycSDaoCzMZzTYJo2gzfSY4HbN3R0J0bHGqQ
         3Dyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=HhkDsDA80zH9OWHmK2nGu5RFBtVZXnjtoCv9dyej5Ag=;
        b=SKINbc82gPJaoAlgNGBn7Y7xzmhAsL4mwUUmIru+3e6wQWfwelMgfPtlYfjYqMQ5yW
         goRIQfh/85Fr84DH0tOZobso7mYP8Kq6U+HsoVCC7DQIwewFbZJaCs6My4EmLVTjKUKM
         3mARcoYWeFzrTKeP8opk0/Zi7scjW7fVBMVPqY/1O5OXiFAkfeefrrTYInXbZe5wrgyw
         EUjhRBxLCeQZOGCnABAGj874SRwnETsgdIoSj3tunpbi0vzuQbV85pZ+8KoSLLKstxq8
         wIzswgzGY+RHGr5BXw4lyPsODlQ8xuxX0429z/daPLR+0r4cbgbM8w+s4y9+lsU7Rpyt
         /Aww==
X-Gm-Message-State: ACgBeo0/2CB5t3YSs+VMUrc//CvUpB7Kic0ylnTXDICynoY6Wk21qRVW
        pl8g6O/uUQz3vwq12bTupVGagAuMAAWX/7BxTWBVrw==
X-Google-Smtp-Source: AA6agR43z1nY3ei/WrttWc11d05Z1Md+aZfj4UacatrD1NZZTdNID4+e2lva3ipUumyedS+VjNEbH1FhGdD6MwE1xH4=
X-Received: by 2002:a25:234a:0:b0:696:435f:df06 with SMTP id
 j71-20020a25234a000000b00696435fdf06mr7486832ybj.180.1661761882106; Mon, 29
 Aug 2022 01:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220819140250.3892995-1-ajones@ventanamicro.com> <20220819140250.3892995-3-ajones@ventanamicro.com>
In-Reply-To: <20220819140250.3892995-3-ajones@ventanamicro.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 29 Aug 2022 14:01:06 +0530
Message-ID: <CAAhSdy3KcjR-jFTxH-oYEw=mLTSdbMnadoLcygDPQaa0h3JbxQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] riscv: Introduce support for defining instructions
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        mchitale@ventanamicro.com, heiko@sntech.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 7:32 PM Andrew Jones <ajones@ventanamicro.com> wrote:
>
> When compiling with toolchains that haven't yet been taught about
> new instructions we need to encode them ourselves. Create a new file
> where support for instruction definitions will evolve. We initiate
> the file with a macro called INSN_R(), which implements the R-type
> instruction encoding. INSN_R() will use the assembler's .insn
> directive when available, which should give the assembler a chance
> to do some validation. When .insn is not available we fall back to
> manual encoding.
>
> Not only should using instruction encoding macros improve readability
> and maintainability of code over the alternative of inserting
> instructions directly (e.g. '.word 0xc0de'), but we should also gain
> potential for more optimized code after compilation because the
> compiler will have control over the input and output registers used.
>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/Kconfig                |  3 ++
>  arch/riscv/include/asm/insn-def.h | 82 +++++++++++++++++++++++++++++++
>  2 files changed, 85 insertions(+)
>  create mode 100644 arch/riscv/include/asm/insn-def.h
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index ed66c31e4655..f8f3b316b838 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -227,6 +227,9 @@ config RISCV_DMA_NONCOHERENT
>         select ARCH_HAS_SETUP_DMA_OPS
>         select DMA_DIRECT_REMAP
>
> +config AS_HAS_INSN
> +       def_bool $(as-instr,.insn r 51$(comma) 0$(comma) 0$(comma) t0$(comma) t0$(comma) zero)
> +
>  source "arch/riscv/Kconfig.socs"
>  source "arch/riscv/Kconfig.erratas"
>
> diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm/insn-def.h
> new file mode 100644
> index 000000000000..4cd0208068dd
> --- /dev/null
> +++ b/arch/riscv/include/asm/insn-def.h
> @@ -0,0 +1,82 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __ASM_INSN_DEF_H
> +#define __ASM_INSN_DEF_H

Add a new line here.

> +#include <asm/asm.h>
> +
> +#define INSN_R_FUNC7_SHIFT             25
> +#define INSN_R_RS2_SHIFT               20
> +#define INSN_R_RS1_SHIFT               15
> +#define INSN_R_FUNC3_SHIFT             12
> +#define INSN_R_RD_SHIFT                         7
> +#define INSN_R_OPCODE_SHIFT             0
> +
> +#ifdef __ASSEMBLY__
> +
> +#ifdef CONFIG_AS_HAS_INSN
> +
> +       .macro insn_r, opcode, func3, func7, rd, rs1, rs2
> +       .insn   r \opcode, \func3, \func7, \rd, \rs1, \rs2
> +       .endm

Maybe use indentation here ?

.macro <xyz>
     .insn ...
.endm

> +
> +#else
> +
> +#include <asm/gpr-num.h>
> +
> +       .macro insn_r, opcode, func3, func7, rd, rs1, rs2
> +       .4byte  ((\opcode << INSN_R_OPCODE_SHIFT) |             \
> +                (\func3 << INSN_R_FUNC3_SHIFT) |               \
> +                (\func7 << INSN_R_FUNC7_SHIFT) |               \
> +                (.L__gpr_num_\rd << INSN_R_RD_SHIFT) |         \
> +                (.L__gpr_num_\rs1 << INSN_R_RS1_SHIFT) |       \
> +                (.L__gpr_num_\rs2 << INSN_R_RS2_SHIFT))
> +        .endm
> +
> +#endif
> +
> +#define INSN_R(...)    insn_r __VA_ARGS__
> +
> +#else /* ! __ASSEMBLY__ */
> +
> +#ifdef CONFIG_AS_HAS_INSN
> +
> +#define INSN_R(opcode, func3, func7, rd, rs1, rs2)     \
> +       ".insn  r " opcode ", " func3 ", " func7 ", " rd ", " rs1 ", " rs2 "\n"
> +
> +#else
> +
> +#include <linux/stringify.h>
> +#include <asm/gpr-num.h>
> +
> +#define DEFINE_INSN_R                                                  \
> +       __DEFINE_ASM_GPR_NUMS                                           \
> +"      .macro insn_r, opcode, func3, func7, rd, rs1, rs2\n"            \
> +"      .4byte  ((\\opcode << " __stringify(INSN_R_OPCODE_SHIFT) ") |"  \
> +"               (\\func3 << " __stringify(INSN_R_FUNC3_SHIFT) ") |"    \
> +"               (\\func7 << " __stringify(INSN_R_FUNC7_SHIFT) ") |"    \
> +"               (.L__gpr_num_\\rd << " __stringify(INSN_R_RD_SHIFT) ") |"    \
> +"               (.L__gpr_num_\\rs1 << " __stringify(INSN_R_RS1_SHIFT) ") |"  \
> +"               (.L__gpr_num_\\rs2 << " __stringify(INSN_R_RS2_SHIFT) "))\n" \
> +"      .endm\n"
> +
> +#define UNDEFINE_INSN_R                                                        \
> +"      .purgem insn_r\n"
> +
> +#define INSN_R(opcode, func3, func7, rd, rs1, rs2)                     \
> +       DEFINE_INSN_R                                                   \
> +       "insn_r " opcode ", " func3 ", " func7 ", " rd ", " rs1 ", " rs2 "\n" \
> +       UNDEFINE_INSN_R
> +
> +#endif
> +
> +#endif /* ! __ASSEMBLY__ */
> +
> +#define OPCODE(v)      __ASM_STR(v)
> +#define FUNC3(v)       __ASM_STR(v)
> +#define FUNC7(v)       __ASM_STR(v)
> +#define __REG(v)       __ASM_STR(x ## v)
> +#define RD(v)          __REG(v)
> +#define RS1(v)         __REG(v)
> +#define RS2(v)         __REG(v)
> +
> +#endif /* __ASM_INSN_DEF_H */
> --
> 2.37.1
>

Apart from new nit comments above, this looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8696F5AA856
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 08:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbiIBGwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 02:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbiIBGwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 02:52:31 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85B732A8E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 23:52:29 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 193so1854155ybc.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 23:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=jEmD+sonir/wrrBAuM3WRSeJRwInUyaKyDNim+FUfro=;
        b=1UpWumfHYOWbr/JF9ogYs0NCweH8XNqdDUFG7CKvmJGwKc3LG4vllMgVJO45zt/tWy
         sl5jMrXTOqQ5y2OKzBaRT5df1mjFBbRcA44rQwmqDWdR67Yx3sN2XZmGxw7eYGSZ9bNF
         DQmWmBkjNYMa4/yIqwlCmihn6gXNfi5Fcvz2XWCDs5Y1kMowy+SO5VPJY8hC1ul9gIqS
         kiBXybjMmsfrWM+FPQDiRyXFszD0J4mdO1nIjJSPcEyQ7A+KwcXFA+34C9YElCMGBw8K
         S7kLDXV+dNPnS0oMl2vV3vw4/i7V9GOkyE0uG+9sHJCwyw1njOFtzpYfkFpXAaG/THkD
         zRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=jEmD+sonir/wrrBAuM3WRSeJRwInUyaKyDNim+FUfro=;
        b=mj/rfVonEGUlANZEGPBZYJjeswtY93Jg6sUsr+YqiM6Kh9AyH3SuEDfYC9jjcEBwkd
         9dKyDNojDAnh/2WU7ywqZfwELwn977RZAXyZn9ZbfDBQDIdHmL2TlaIcJHihZAHzIR6L
         COs6wbsr2UL3iM5dJuDEblE4sC7dE7k/gHeh4MrD6fWkXrXNDS0kFmzbhf4bAfBP7T5w
         fH9FKRZqakdKsnbjsGf02EGdjkD7atBpwm856nR1HDLhgbs8uwxaAwTu85G5mkB/IGXT
         ozEzZVBR9G6HpE6i23GKeojURXHqFc6rMT/cDMN+snB7oO1gd2u3zOWbnF9+ZcgEoYAW
         oujw==
X-Gm-Message-State: ACgBeo0mqw1DVR9j2/XCMgv71PhWfs1OV54sMxnCsuqPr6srLbElXpMU
        o6lE5xXHKZRRj/tdvfrAMH061iT9szrHIv21/xJ8BB+s9udA3lBB
X-Google-Smtp-Source: AA6agR44g/Ju9nqb+toCfK/zUEecF64y1FoAxAcnWFvNBCqUEEo7XSRHfJBznJrPc7Sa4iE44Migg0Ovl3hCOmU1szI=
X-Received: by 2002:a25:2596:0:b0:696:5c19:6e34 with SMTP id
 l144-20020a252596000000b006965c196e34mr22259794ybl.423.1662101549009; Thu, 01
 Sep 2022 23:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220831172500.752195-1-ajones@ventanamicro.com> <20220831172500.752195-3-ajones@ventanamicro.com>
In-Reply-To: <20220831172500.752195-3-ajones@ventanamicro.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 2 Sep 2022 12:22:16 +0530
Message-ID: <CAAhSdy3OE_+ZafzYN5dtLWvgX7X8-ZN0SVv4ML+pT2sGarmEBQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] riscv: Introduce support for defining instructions
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

On Wed, Aug 31, 2022 at 10:55 PM Andrew Jones <ajones@ventanamicro.com> wrote:
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
> Reviewed-by: Anup Patel <anup@brainfault.org>

I have queued this patch for Linux-6.1

Thanks,
Anup

> ---
>  arch/riscv/Kconfig                |  3 ++
>  arch/riscv/include/asm/insn-def.h | 86 +++++++++++++++++++++++++++++++
>  2 files changed, 89 insertions(+)
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
> index 000000000000..2dcd1d4781bf
> --- /dev/null
> +++ b/arch/riscv/include/asm/insn-def.h
> @@ -0,0 +1,86 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __ASM_INSN_DEF_H
> +#define __ASM_INSN_DEF_H
> +
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
> +       .endm
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
> +#define RD(v)          __ASM_STR(v)
> +#define RS1(v)         __ASM_STR(v)
> +#define RS2(v)         __ASM_STR(v)
> +#define __REG(v)       __ASM_STR(x ## v)
> +#define __RD(v)                __REG(v)
> +#define __RS1(v)       __REG(v)
> +#define __RS2(v)       __REG(v)
> +
> +#endif /* __ASM_INSN_DEF_H */
> --
> 2.37.2
>

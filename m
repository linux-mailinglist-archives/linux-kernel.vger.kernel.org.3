Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D002599D7D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 16:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349612AbiHSO0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 10:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349548AbiHSO0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 10:26:23 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CD8EA33C
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 07:26:11 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r4so5864198edi.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 07:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=fFhF+3XP6naP0ZUj4bms8XHGKJDA61lcJSZD3iKtxUw=;
        b=GzGtS0qGqcbT3ZOUCDh9ZmEwsbXx8fJibrnq0qhJSCm6olm7FJiAhA2ANhWqaFCtfZ
         P/F/JkZVEQ1y9QQNtyV8W7MH0lMgrz5iU3GU0DAn5L+fX5irWCOt557ANXambeB0ixww
         Hu/UK89XLPopqAh4wdHUI7EJvZeLPfxERgYbS2WL5Il79yGntUhiLlihfCSdt7dX4NVB
         /ost9aDlnJOT4rpuKtacFJUEn8Xgs4c21K/Samr94S0vu72uSZ0aE9nE5o8cswszZTML
         fHER1lcOKxDVQcwnf3uDZTH8dmcicTnRIL/1gZ08mKQEAmngswTJhaCom5jG263DpqHF
         BODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=fFhF+3XP6naP0ZUj4bms8XHGKJDA61lcJSZD3iKtxUw=;
        b=Kf0nR9VZ2rPOZFheMOqPs67fAcu2dnaaUY8Rz1MggxV5Na4odlfiFaTNgVoLYmTsA/
         rq4uMUrvFNPTRf/oqo9c/yd3gAe9+i2scOjIFwLkcxpMQuh/bnIAX1dcUu19Pq1/OHGi
         9XeNwORA45hd6QNHa8GkYmSC4DbwmMS4Oojsca3Tsbqux7H3MPCCnEzWTyNBpus2aBkI
         tAKglcbh0mMorxT1XxE+Wuo7MxqipLduEwP8H2lbbX3UvzEXJLRHsqqD4pmfibWpB0qV
         TTgVFHjARVvoWSwrdaBZWufqvOf+xNArg+jV58K5VhPQs9KN5mwRvMRB+Md25arKBvtG
         LBDQ==
X-Gm-Message-State: ACgBeo3cwqZwEM6CeCT0NTvZG7LMHz+X3J/5n8ucU6yKfJDwt9z3rhck
        RFN3sGem8jvSn81rpdpz6SL3Tg==
X-Google-Smtp-Source: AA6agR6T8+Us3I3yAILhsdbXqW3Vr1uQ9Ap68Pb15BPdvtLCGkeCkD8ohZ3rbVdll6nmLOmqYzNa5A==
X-Received: by 2002:a05:6402:d0b:b0:443:df38:9df with SMTP id eb11-20020a0564020d0b00b00443df3809dfmr6361959edb.9.1660919170199;
        Fri, 19 Aug 2022 07:26:10 -0700 (PDT)
Received: from localhost (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id kf14-20020a17090776ce00b0073851453444sm2395288ejc.60.2022.08.19.07.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 07:26:09 -0700 (PDT)
Date:   Fri, 19 Aug 2022 16:26:08 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        mchitale@ventanamicro.com, heiko@sntech.de
Subject: Re: [PATCH 2/4] riscv: Introduce support for defining instructions
Message-ID: <20220819142608.uzqvtd7qfejvhzia@kamzik>
References: <20220819140250.3892995-1-ajones@ventanamicro.com>
 <20220819140250.3892995-3-ajones@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819140250.3892995-3-ajones@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 04:02:48PM +0200, Andrew Jones wrote:
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
>  	select ARCH_HAS_SETUP_DMA_OPS
>  	select DMA_DIRECT_REMAP
>  
> +config AS_HAS_INSN
> +	def_bool $(as-instr,.insn r 51$(comma) 0$(comma) 0$(comma) t0$(comma) t0$(comma) zero)
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
> +#include <asm/asm.h>
> +
> +#define INSN_R_FUNC7_SHIFT		25
> +#define INSN_R_RS2_SHIFT		20
> +#define INSN_R_RS1_SHIFT		15
> +#define INSN_R_FUNC3_SHIFT		12
> +#define INSN_R_RD_SHIFT			 7
> +#define INSN_R_OPCODE_SHIFT		 0
> +
> +#ifdef __ASSEMBLY__
> +
> +#ifdef CONFIG_AS_HAS_INSN
> +
> +	.macro insn_r, opcode, func3, func7, rd, rs1, rs2
> +	.insn	r \opcode, \func3, \func7, \rd, \rs1, \rs2
> +	.endm
> +
> +#else
> +
> +#include <asm/gpr-num.h>
> +
> +	.macro insn_r, opcode, func3, func7, rd, rs1, rs2
> +	.4byte	((\opcode << INSN_R_OPCODE_SHIFT) |		\
> +		 (\func3 << INSN_R_FUNC3_SHIFT) |		\
> +		 (\func7 << INSN_R_FUNC7_SHIFT) |		\
> +		 (.L__gpr_num_\rd << INSN_R_RD_SHIFT) |		\
> +		 (.L__gpr_num_\rs1 << INSN_R_RS1_SHIFT) |	\
> +		 (.L__gpr_num_\rs2 << INSN_R_RS2_SHIFT))
> +        .endm

Doh, checkpatch told me about the spaces vs. tabs before .endm, but I
forgot to refresh before sending. I won't send a v2 until the series
gets more feedback, but I've already got it fixed.

> +
> +#endif
> +
> +#define INSN_R(...)	insn_r __VA_ARGS__
> +
> +#else /* ! __ASSEMBLY__ */
> +
> +#ifdef CONFIG_AS_HAS_INSN
> +
> +#define INSN_R(opcode, func3, func7, rd, rs1, rs2)	\
> +	".insn	r " opcode ", " func3 ", " func7 ", " rd ", " rs1 ", " rs2 "\n"
> +
> +#else
> +
> +#include <linux/stringify.h>
> +#include <asm/gpr-num.h>
> +
> +#define DEFINE_INSN_R							\
> +	__DEFINE_ASM_GPR_NUMS						\
> +"	.macro insn_r, opcode, func3, func7, rd, rs1, rs2\n"		\
> +"	.4byte  ((\\opcode << " __stringify(INSN_R_OPCODE_SHIFT) ") |"	\
              ^
              ^ checkpatch didn't tell me those are spaces instead of a
	      tab, but I found it while fixing the other tab issue.

> +"		 (\\func3 << " __stringify(INSN_R_FUNC3_SHIFT) ") |"	\
> +"		 (\\func7 << " __stringify(INSN_R_FUNC7_SHIFT) ") |"	\
> +"		 (.L__gpr_num_\\rd << " __stringify(INSN_R_RD_SHIFT) ") |"    \
> +"		 (.L__gpr_num_\\rs1 << " __stringify(INSN_R_RS1_SHIFT) ") |"  \
> +"		 (.L__gpr_num_\\rs2 << " __stringify(INSN_R_RS2_SHIFT) "))\n" \
> +"	.endm\n"
> +
> +#define UNDEFINE_INSN_R							\
> +"	.purgem insn_r\n"
> +
> +#define INSN_R(opcode, func3, func7, rd, rs1, rs2)			\
> +	DEFINE_INSN_R							\
> +	"insn_r " opcode ", " func3 ", " func7 ", " rd ", " rs1 ", " rs2 "\n" \
> +	UNDEFINE_INSN_R
> +
> +#endif
> +
> +#endif /* ! __ASSEMBLY__ */
> +
> +#define OPCODE(v)	__ASM_STR(v)
> +#define FUNC3(v)	__ASM_STR(v)
> +#define FUNC7(v)	__ASM_STR(v)
> +#define __REG(v)	__ASM_STR(x ## v)
> +#define RD(v)		__REG(v)
> +#define RS1(v)		__REG(v)
> +#define RS2(v)		__REG(v)
> +
> +#endif /* __ASM_INSN_DEF_H */
> -- 
> 2.37.1
> 

Thanks,
drew

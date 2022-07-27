Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB08582964
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 17:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbiG0PP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 11:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiG0PP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 11:15:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39802316A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 08:15:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E61D61904
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 15:15:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCAD4C433B5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 15:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658934922;
        bh=WSeVoPqh36Q6lc/inqTgm0AY0e9m4yxhb9yfDlnUI/Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R6rWLt+/yZd7RE/c0aFeQ21THpKeprus95goYPPJnCBVuhr+hN0WsSf061vuh5ePl
         B5IOJd3rMGFJXFGy1VNL19pqkwaAnfPrQGaMwm5vXBTGapB/oGqBvVSHMMILLMOzHm
         3Qqd4jAv9inDm3jhedOsn7k45Q+DFFmdVSZAebQzfJTYiBSfucL/kLUQOS0xPnY5XI
         KhE1/JiQKeFKWB/G/79KhsBtE9B5UGn9mGIdQd23eSqByv7+xnByEY1oamdiSHrAir
         OdLdjQDKT4mR/fLqtubm4RePxrp829Xf3QiB1vTKEojdrjrI3zXJPMZZqIobjlMwOI
         CgPlZjUi/q4ug==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-10e615a36b0so1446979fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 08:15:22 -0700 (PDT)
X-Gm-Message-State: AJIora82db/4D+HXXiv9xQLc+ty8dGBKXRs1kH6NiAUHhT63Q1AoYpDG
        ugyzAnHDAmunr+rDZbU5WMGnwEjKgGdcYA5CJHo=
X-Google-Smtp-Source: AGRyM1tjy6IE5hNBYjvy+u/SvmxrUKuq8Ilr3POazgyOQatfbanLbCxW1CfNLqkfknbQGCziV/CvYrGGatIsm+TxNfA=
X-Received: by 2002:a05:6870:5b91:b0:108:374a:96b0 with SMTP id
 em17-20020a0568705b9100b00108374a96b0mr2371877oab.126.1658934921847; Wed, 27
 Jul 2022 08:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220709084830.3124-1-jszhang@kernel.org>
In-Reply-To: <20220709084830.3124-1-jszhang@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 27 Jul 2022 08:15:11 -0700
X-Gmail-Original-Message-ID: <CAMj1kXEy7_zyDqQC_e9Rf1a8HuMBz_HbZOAP-WBzeeDVu8Mwmw@mail.gmail.com>
Message-ID: <CAMj1kXEy7_zyDqQC_e9Rf1a8HuMBz_HbZOAP-WBzeeDVu8Mwmw@mail.gmail.com>
Subject: Re: [PATCH] arm64: save movk instructions in mov_q when the lower
 16|32 bits are all zero
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Jul 2022 at 01:58, Jisheng Zhang <jszhang@kernel.org> wrote:
>
> Currently mov_q is used to move a constant into a 64-bit register,
> when the lower 16 or 32bits of the constant are all zero, the mov_q
> emits one or two useless movk instructions. If the mov_q macro is used
> in hot code path, we want to save the movk instructions as much as
> possible. For example, when CONFIG_ARM64_MTE is 'Y' and
> CONFIG_KASAN_HW_TAGS is 'N', the following code in __cpu_setup()
> routine is the pontential optimization target:
>
>         /* set the TCR_EL1 bits */
>         mov_q   x10, TCR_MTE_FLAGS
>
> Before the patch:
>         mov     x10, #0x10000000000000
>         movk    x10, #0x40, lsl #32
>         movk    x10, #0x0, lsl #16
>         movk    x10, #0x0
>
> After the patch:
>         mov     x10, #0x10000000000000
>         movk    x10, #0x40, lsl #32
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

This is broken for constants that have 0xffff in the top 16 bits, as
in that case, we will emit a MOVN/MOVK/MOVK sequence, and omitting the
MOVKs will set the corresponding field to 0xffff not 0x0.


> ---
>  arch/arm64/include/asm/assembler.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index 8c5a61aeaf8e..09f408424cae 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -568,9 +568,13 @@ alternative_endif
>         movz    \reg, :abs_g3:\val
>         movk    \reg, :abs_g2_nc:\val
>         .endif
> +       .if ((((\val) >> 16) & 0xffff) != 0)
>         movk    \reg, :abs_g1_nc:\val
>         .endif
> +       .endif
> +       .if (((\val) & 0xffff) != 0)
>         movk    \reg, :abs_g0_nc:\val
> +       .endif
>         .endm
>
>  /*
> --
> 2.34.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

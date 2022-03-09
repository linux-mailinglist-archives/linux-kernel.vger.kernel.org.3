Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8702E4D3C6C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 22:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238478AbiCIVzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 16:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbiCIVzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 16:55:04 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBA955237
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 13:54:04 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id g17so6197904lfh.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 13:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CUMQksGgCdQmcHrJcF66PznC3AjKKF/X4cilDJy65/w=;
        b=d+gHv8c+vxZcULWVQVZgmkK5hNAQs6Bxjw7N1RsVhrfDlZF7oSU2rRiN85oK+lQjVq
         fJXUwTPySu5+R6mo42EroOgWo0BOK+OjTerHV+hSZr+8QBPhhaBXZcEbV967exOsMccX
         WIwQIMmhgp/lyWPrq8NFTZFD209Xd+5mvSQlgunNCXwSuXDXYn84YVgNEZRAd4V2svWu
         C7K2YASRRhkc4BMI4nqARSOhGX2SegCS0mu0VPIth78rpspBAqWnw+gVrvd3b9N2U/w9
         TG5HXSdM9WG53grpcyEFaHmeC6aKnwg+sdOmBUOfgFfyH/jysQ7amBkGCxZgbjJalzFu
         rUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CUMQksGgCdQmcHrJcF66PznC3AjKKF/X4cilDJy65/w=;
        b=RJKjTUmRRGQArLRqq65nv4wEkhCaoQS+NCcOmmgSF0M+OgN/vVQ35+UmYeSi5oltVi
         +wdyWYmFt9DyfL1yrR2VkKaRzeBUCxJ5MpZV9KJNBsy49+JwHLFWe3luLscoZvNWP6D2
         oyrGR6bDJ+WYJmnNDO10GJ/q+ZioBQJrxVaFeUudoy7xMgQUoiXXyVZdlI0qREUE3HWz
         LIlz6LtD/kE7GclBQEegckIA9GCaaRczyFIo+1kauC7jd8K1OkTTCoU6jvHUUmHMQYB9
         Q5FVs2Hh9WxZz8QhaZYGYDXM4fcYRL/aSAkLEVt3SkyqkrHtt9MZ3AskO2Lhs63ZDXDe
         lHWA==
X-Gm-Message-State: AOAM5317KkubCgLkMtGMaXIkhoa9hEjQqAp3W5UPK1BHxvL/Zney7mN3
        cFP69VZuXAOxjXONkKQ9V41rWtDgT2bpda0YWiLtJw==
X-Google-Smtp-Source: ABdhPJzCxFT3dV8gojSRQ4YAikZ6dGu6NuaatVUte2DQRtdeETHIEzS6FLUxjVZqUU2RsWwhnDqKYQp3Aem765MNgqc=
X-Received: by 2002:ac2:5feb:0:b0:448:2707:6bfd with SMTP id
 s11-20020ac25feb000000b0044827076bfdmr1082389lfg.380.1646862842545; Wed, 09
 Mar 2022 13:54:02 -0800 (PST)
MIME-Version: 1.0
References: <20220309191633.2307110-1-nathan@kernel.org>
In-Reply-To: <20220309191633.2307110-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 9 Mar 2022 13:53:50 -0800
Message-ID: <CAKwvOdkrgtyE3rU8Xa2B8QQJ1ZErSTB9PDuikPF6=4D4Q80XVQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: Do not include __READ_ONCE() block in assembly files
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, stable@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 9, 2022 at 11:19 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> When building arm64 defconfig + CONFIG_LTO_CLANG_{FULL,THIN}=y after
> commit 558c303c9734 ("arm64: Mitigate spectre style branch history side
> channels"), the following error occurs:
>
>   <instantiation>:4:2: error: invalid fixup for movz/movk instruction
>    mov w0, #ARM_SMCCC_ARCH_WORKAROUND_3
>    ^
>
> Marc figured out that moving "#include <linux/init.h>" in
> include/linux/arm-smccc.h into a !__ASSEMBLY__ block resolves it. The
> full include chain with CONFIG_LTO=y from include/linux/arm-smccc.h:
>
> include/linux/init.h
> include/linux/compiler.h
> arch/arm64/include/asm/rwonce.h
> arch/arm64/include/asm/alternative-macros.h
> arch/arm64/include/asm/assembler.h
>
> The asm/alternative-macros.h include in asm/rwonce.h only happens when
> CONFIG_LTO is set, which ultimately casues asm/assembler.h to be
> included before the definition of ARM_SMCCC_ARCH_WORKAROUND_3. As a
> result, the preprocessor does not expand ARM_SMCCC_ARCH_WORKAROUND_3 in
> __mitigate_spectre_bhb_fw, which results in the error above.
>
> Avoid this problem by just avoiding the CONFIG_LTO=y __READ_ONCE() block
> in asm/rwonce.h with assembly files, as nothing in that block is useful
> to assembly files, which allows ARM_SMCCC_ARCH_WORKAROUND_3 to be
> properly expanded with CONFIG_LTO=y builds.
>
> Cc: stable@vger.kernel.org
> Fixes: e35123d83ee3 ("arm64: lto: Strengthen READ_ONCE() to acquire when CONFIG_LTO=y")
> Link: https://lore.kernel.org/r/20220309155716.3988480-1-maz@kernel.org/
> Reported-by: Marc Zyngier <maz@kernel.org>
> Acked-by: James Morse <james.morse@arm.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks for taking point on all of the BHB fallout.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> This is based on current mainline; if it should be based on a specific
> arm64 branch, please let me know.
>
> As 558c303c9734 is going to stable, I marked this for stable as well to
> avoid breaking Android. I used e35123d83ee3 for the fixes tag to make it
> clear to the stable team this should only go where that commit is
> present. If a different fixes tag should be used, please feel free to
> substitute.
>
>  arch/arm64/include/asm/rwonce.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/include/asm/rwonce.h b/arch/arm64/include/asm/rwonce.h
> index 1bce62fa908a..56f7b1d4d54b 100644
> --- a/arch/arm64/include/asm/rwonce.h
> +++ b/arch/arm64/include/asm/rwonce.h
> @@ -5,7 +5,7 @@
>  #ifndef __ASM_RWONCE_H
>  #define __ASM_RWONCE_H
>
> -#ifdef CONFIG_LTO
> +#if defined(CONFIG_LTO) && !defined(__ASSEMBLY__)
>
>  #include <linux/compiler_types.h>
>  #include <asm/alternative-macros.h>
> @@ -66,7 +66,7 @@
>  })
>
>  #endif /* !BUILD_VDSO */
> -#endif /* CONFIG_LTO */
> +#endif /* CONFIG_LTO && !__ASSEMBLY__ */
>
>  #include <asm-generic/rwonce.h>
>
>
> base-commit: 330f4c53d3c2d8b11d86ec03a964b86dc81452f5
> --
> 2.35.1
>


-- 
Thanks,
~Nick Desaulniers

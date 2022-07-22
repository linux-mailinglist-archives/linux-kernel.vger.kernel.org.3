Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4D657E39E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 17:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235681AbiGVPRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 11:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235585AbiGVPRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 11:17:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9F713E0A;
        Fri, 22 Jul 2022 08:17:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4736E62155;
        Fri, 22 Jul 2022 15:17:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0B4C341C7;
        Fri, 22 Jul 2022 15:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658503052;
        bh=jPlHs36zPeUaSc/musyEd34dfiN7dNUrdFQXuCvn1v0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o7RJwxnIWOilXjEk1yyNHW0M321N+yOFY4bUF08Bme8BE3ALE44JmNqTvgH+0LV2w
         6Qt3UE2Ia6P8Mx0P2kK3p0XNm4AJIH8jb5am8QrrFhVpQO2+X9EpLPeGZ+/FDV006Y
         q2dAR+K0OgVwv+FwebxaRuBPTre2H8A/lDkKNJI4uDEGmgcPlQ8kyHL+ih4YmfVTkJ
         F/d+vGrWwRHwvlLvjD7kymfZAZiSsomZ4LESTwRKTGSrKy0k49wAVrR5TvAjttMoce
         HL5xvG6nEGPlLsew9X4Sy/qwfU2D1H5hpRfsaKbXoJ5OWOKe+7sGWwoWTrRtXVk4xa
         6Dwzo19VzWvpQ==
Received: by mail-ot1-f41.google.com with SMTP id y10-20020a9d634a000000b006167f7ce0c5so3577382otk.0;
        Fri, 22 Jul 2022 08:17:32 -0700 (PDT)
X-Gm-Message-State: AJIora/AiaMqSi5KYYwCG6HaNA8/hwDFe+fq/i3UFRNZ4LbxDovvQmTJ
        CBRJ3BFve5tcFASV3jTqZAoMbxtcjAkp/GWGPpY=
X-Google-Smtp-Source: AGRyM1u8XGs9hxM+0KOLjDxo+lSQSUWBU2NPa1D02NySMDEqf++3khY3s8HzFnPZFuVcpc8yATJM3ZFBHK9Gwwnt/VQ=
X-Received: by 2002:a9d:2f2a:0:b0:61c:cc5a:22b with SMTP id
 h39-20020a9d2f2a000000b0061ccc5a022bmr154201otb.71.1658503051701; Fri, 22 Jul
 2022 08:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220721100433.18286-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20220721100433.18286-1-lukas.bulwahn@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 22 Jul 2022 17:17:20 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEb5sT-KaHMUB1jU8kO69Pf97XG39xW9xDat62yxwZA1Q@mail.gmail.com>
Message-ID: <CAMj1kXEb5sT-KaHMUB1jU8kO69Pf97XG39xW9xDat62yxwZA1Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: adjust KASLR relocation after ARCH_RANDOM removal
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jul 2022 at 12:04, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit aacd149b6238 ("arm64: head: avoid relocating the kernel twice for
> KASLR") adds the new file arch/arm64/kernel/pi/kaslr_early.c with a small
> code part guarded by '#ifdef CONFIG_ARCH_RANDOM'.
>
> Concurrently, commit 9592eef7c16e ("random: remove CONFIG_ARCH_RANDOM")
> removes the config CONFIG_ARCH_RANDOM and turns all '#ifdef
> CONFIG_ARCH_RANDOM' code parts into unconditional code parts, which is
> generally safe to do.
>
> Remove a needless ifdef guard after the ARCH_RANDOM removal.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/arm64/kernel/pi/kaslr_early.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/kernel/pi/kaslr_early.c b/arch/arm64/kernel/pi/kaslr_early.c
> index 6c3855e69395..17bff6e399e4 100644
> --- a/arch/arm64/kernel/pi/kaslr_early.c
> +++ b/arch/arm64/kernel/pi/kaslr_early.c
> @@ -94,11 +94,9 @@ asmlinkage u64 kaslr_early_init(void *fdt)
>
>         seed = get_kaslr_seed(fdt);
>         if (!seed) {
> -#ifdef CONFIG_ARCH_RANDOM
> -                if (!__early_cpu_has_rndr() ||
> -                    !__arm64_rndr((unsigned long *)&seed))
> -#endif
> -               return 0;
> +               if (!__early_cpu_has_rndr() ||
> +                   !__arm64_rndr((unsigned long *)&seed))
> +                       return 0;
>         }
>
>         /*
> --
> 2.17.1
>

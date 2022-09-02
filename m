Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220EB5AA4DC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 03:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbiIBBHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 21:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235136AbiIBBHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 21:07:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F436C12B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 18:07:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A44861AA6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 01:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90354C43470
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 01:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662080867;
        bh=YGW06h42fog0+829pIdqqfbbxG5/bSPM5IarAA8Qg4Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=goPsjt9899ORTuqLLkog1synbcfRjehQYCiugCW4nLaM1EV6HU0+oYY/4uDwnRcl8
         xWTV/9Ta9+eQJ/qmK3SCstibOAnexccPfKfCoiKLu+Nr+1VFvOElFT7q2bkpjDSZDB
         dZxQIEKwUPAZDzdBji2Jh803TKzH9mFcrEQKLHxA3dkCJpTVyWG7HyowSedQ33YJIe
         AGcYUog1piTixJzlR1dtwTdcaAqFE0SunInOP4nHkQc5xU8xXCdBeptCAdgIM3GpQ2
         YjoimfAofZEYlMaqNZr8k94rGHcuqFBAkOm3fTpJJvKfr8HJqp/7n5LgDqLaUbukRC
         wTdUxr4BdV/UQ==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-11eab59db71so1346088fac.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 18:07:47 -0700 (PDT)
X-Gm-Message-State: ACgBeo2oClnjUVc7rFeG6f6lTyftR3WskOdzrwgFaVcfC1QfYV4dyJMl
        ymov1veG/zeTKIJ7hfJ9kuHlNnKPCZ223GWGONs=
X-Google-Smtp-Source: AA6agR4Ocs9kP9xBS2wmYYMgKp46ESJNJgZQyzz/kLfwkEqbvIlyV+tofNOYNy9gfS/+9/H3rD1//vbYWh8e8wc+wg4=
X-Received: by 2002:a05:6870:c596:b0:101:6409:ae62 with SMTP id
 ba22-20020a056870c59600b001016409ae62mr1043596oab.112.1662080866791; Thu, 01
 Sep 2022 18:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220901222744.2210215-1-heiko@sntech.de>
In-Reply-To: <20220901222744.2210215-1-heiko@sntech.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 2 Sep 2022 09:07:34 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRnhN37C3pd6FYKX8KEVUQHm5PzWTf6Urxe4kwVW5hg7Q@mail.gmail.com>
Message-ID: <CAJF2gTRnhN37C3pd6FYKX8KEVUQHm5PzWTf6Urxe4kwVW5hg7Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] riscv: cleanup svpbmt cpufeature probing
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, conor.dooley@microchip.com,
        apatel@ventanamicro.com, atishp@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Fri, Sep 2, 2022 at 6:28 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> This can also do without the ifdef and use IS_ENABLED instead and
> for better readability, getting rid of that switch also seems
> waranted.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/riscv/kernel/cpufeature.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 553d755483ed..764ea220161f 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -253,16 +253,13 @@ void __init riscv_fill_hwcap(void)
>  #ifdef CONFIG_RISCV_ALTERNATIVE
>  static bool __init_or_module cpufeature_probe_svpbmt(unsigned int stage)
>  {
> -#ifdef CONFIG_RISCV_ISA_SVPBMT
> -       switch (stage) {
> -       case RISCV_ALTERNATIVES_EARLY_BOOT:
> +       if (!IS_ENABLED(CONFIG_RISCV_ISA_SVPBMT))
>                 return false;
> -       default:
> -               return riscv_isa_extension_available(NULL, SVPBMT);
> -       }
> -#endif
>
> -       return false;
> +       if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
> +               return false;
> +
> +       return riscv_isa_extension_available(NULL, SVPBMT);
>  }
>
>  static bool __init_or_module cpufeature_probe_zicbom(unsigned int stage)
> --
> 2.35.1
>


-- 
Best Regards
 Guo Ren

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48D75B0964
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 17:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiIGP7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 11:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiIGP7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:59:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C28B9FAC
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 08:59:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC9FF6199A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 15:59:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47518C433C1
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 15:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662566358;
        bh=xfHDa8Z2gPr0dZtyXQaf3jkII3Enpj+hX9D1LXf6pvo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Lfl+LCzMAq2Jj+m6i0q8jvk/Ywum9HztA8ocEjEn2VsP9bDd+I+bkoabRxPivOA8a
         lQnf67c05RMkEO2W5k3O0Hy5/1BkCFF+ipAVcTKIplL/p3rg3eTzL7J4nsKI/eUAOi
         XLg36jk4Lw3S+t9lOndtcpwF9yq7TD72SxyBIRfF02C/DBIsA5YPEWpK+fb3DkwJJN
         v5oPf/DKMbc/Baw2xC57iomXjm67hMenxSR9q7Xi7u7SLFSIKn5nqhmfHke61SsYbe
         SR37iIp/y5Cno5jutfN4mj2kaAJMB91gLyKVk28z66wMuu/EfZkkBs1a0XpwRUcScC
         7LrYJb+fs9I/A==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1278624b7c4so18878061fac.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 08:59:18 -0700 (PDT)
X-Gm-Message-State: ACgBeo3cBeyMf/hgmESmr4cccSrIVEUYaahHFu5KuQpNM/cY+41Zyyhm
        +cztaUjkcm6u2H9QaiTY5aGgv+cpe/6F08FIxHo=
X-Google-Smtp-Source: AA6agR7MvAlCAbk8bogv7PvRt1jry2ZgjDxXdRGIK2wehgNgr1Ni5jtfIXHdb/ktZY+HZtYkqi8h2gLJfSSOEzo+YUc=
X-Received: by 2002:a05:6808:150f:b0:343:3202:91cf with SMTP id
 u15-20020a056808150f00b00343320291cfmr12104572oiw.112.1662566357437; Wed, 07
 Sep 2022 08:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220907154932.2858518-1-heiko@sntech.de>
In-Reply-To: <20220907154932.2858518-1-heiko@sntech.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 7 Sep 2022 23:59:05 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR0p1C=JN1gr_O7ThZririQ9wstMxcixKL4yqRQKdvrCg@mail.gmail.com>
Message-ID: <CAJF2gTR0p1C=JN1gr_O7ThZririQ9wstMxcixKL4yqRQKdvrCg@mail.gmail.com>
Subject: Re: [PATCH] riscv: make t-head erratas depend on MMU
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, samuel@sholland.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
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

On Wed, Sep 7, 2022 at 11:49 PM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Both basic extensions of SVPBMT and ZICBOM depend on CONFIG_MMU.
> Make the T-Head errata implementations of the similar functionality
> also depend on it to prevent build errors.
>
> Fixes: a35707c3d850 ("riscv: add memory-type errata for T-Head")
> Fixes: d20ec7529236 ("riscv: implement cache-management errata for T-Head SoCs")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/riscv/Kconfig.erratas | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/Kconfig.erratas b/arch/riscv/Kconfig.erratas
> index 6850e9389930..f3623df23b5f 100644
> --- a/arch/riscv/Kconfig.erratas
> +++ b/arch/riscv/Kconfig.erratas
> @@ -46,7 +46,7 @@ config ERRATA_THEAD
>
>  config ERRATA_THEAD_PBMT
>         bool "Apply T-Head memory type errata"
> -       depends on ERRATA_THEAD && 64BIT
> +       depends on ERRATA_THEAD && 64BIT && MMU
>         select RISCV_ALTERNATIVE_EARLY
>         default y
>         help
> @@ -57,7 +57,7 @@ config ERRATA_THEAD_PBMT
>
>  config ERRATA_THEAD_CMO
>         bool "Apply T-Head cache management errata"
> -       depends on ERRATA_THEAD
> +       depends on ERRATA_THEAD && MMU
>         select RISCV_DMA_NONCOHERENT
>         default y
>         help
> --
> 2.35.1
>


-- 
Best Regards
 Guo Ren

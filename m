Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AD75357DC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 04:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbiE0Cu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 22:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiE0Cuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 22:50:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BE86A035
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 19:50:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4C64B82219
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817C0C34114
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653619851;
        bh=VW2B/834QEadFvp2MVBpsXYQ9PdcdQlwPrY/Trn8VGw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KB6rmH+NKrsn4vdTB2x+jryBkGyTASZU5IZDBlwgqDmFXSXUHIIxI/4PX/oGDZfK3
         nqHJLFaZj17CA2qgYskE63BasOJOB/KTE6zzMgwzQuT/XP6VFlMEf3NiudKloUjDHd
         MSzfiMZJFv46g5FRmO48rRUz/yaIM+Kb+A+JtkxRigjA3oAB3kEny9cDeHXoreiCPY
         y3kI6uGjmQCka8vUWVKik0RKAdVa4r8xTzfOF8huC+RNRrvuRaIYnBBe7FmGqgJMaf
         Qpj29vLq7Ksp3LFcRKo2bgepjpbJN6hKsYak+CyD7FtJ7f5d5VFrBPdE1MJShjGnty
         UxCF6B8o1b/mw==
Received: by mail-vk1-f173.google.com with SMTP id b81so1515795vkf.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 19:50:51 -0700 (PDT)
X-Gm-Message-State: AOAM532tfgst/kk0QWcQoggbhrkhNm2galWOYlGpn7w64UOSosIQGljB
        qU0+7ZOlA4w+tQR4tr0hGNgCSyxEDb6aTIt7H5U=
X-Google-Smtp-Source: ABdhPJxCY0KFOVgzAOyccpbA9v4KJUZMQ2Q5ufs9Y5IWvX1RYvYBuQyNFpioDHUmGn3USdzdYpYeRRWgZ+D1e655FvU=
X-Received: by 2002:a1f:1c47:0:b0:357:d477:3354 with SMTP id
 c68-20020a1f1c47000000b00357d4773354mr8052414vkc.28.1653619850462; Thu, 26
 May 2022 19:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220526205646.258337-1-heiko@sntech.de> <20220526205646.258337-5-heiko@sntech.de>
In-Reply-To: <20220526205646.258337-5-heiko@sntech.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 27 May 2022 10:50:39 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS0zyM9sM8y6krHoMzhrLRGJPBfuXDvATw0Tm7KyE=NwQ@mail.gmail.com>
Message-ID: <CAJF2gTS0zyM9sM8y6krHoMzhrLRGJPBfuXDvATw0Tm7KyE=NwQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] riscv: fix dependency for t-head errata
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Fu <wefu@redhat.com>, Nick Kossifidis <mick@ics.forth.gr>,
        Samuel Holland <samuel@sholland.org>,
        Christoph Muellner <cmuellner@linux.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Christoph Hellwig <hch@lst.de>,
        kernel test robot <yujie.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em... This is a limitation to our scenario but seems it okay for
current t-thead SoC products.

Reviewed-by: Guo Ren <guoren@kernel.org>

On Fri, May 27, 2022 at 4:57 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> alternatives only work correctly on non-xip-kernels and while the
> selected alternative-symbol has the correct dependency the symbol
> selecting it also needs that dependency.
>
> So add the missing dependency to the T-Head errata Kconfig symbol.
>
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/riscv/Kconfig.erratas | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/Kconfig.erratas b/arch/riscv/Kconfig.erratas
> index ebfcd5cc6eaf..457ac72c9b36 100644
> --- a/arch/riscv/Kconfig.erratas
> +++ b/arch/riscv/Kconfig.erratas
> @@ -35,6 +35,7 @@ config ERRATA_SIFIVE_CIP_1200
>
>  config ERRATA_THEAD
>         bool "T-HEAD errata"
> +       depends on !XIP_KERNEL
>         select RISCV_ALTERNATIVE
>         help
>           All T-HEAD errata Kconfig depend on this Kconfig. Disabling
> --
> 2.35.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

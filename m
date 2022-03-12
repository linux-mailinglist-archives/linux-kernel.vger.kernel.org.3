Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F135B4D6DB7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 10:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbiCLJQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 04:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiCLJQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 04:16:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BF71C7C33
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 01:15:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0146C60A23
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 09:15:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC1FC36AE2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 09:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647076504;
        bh=ndlAtVsMZB6QjhlQTA/+jwZ87IhmzTbmHCx6H4JJ6pA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gdTWYo2fsAGvwYaFT+OlNOWdTazMawskneOM96CHkk+NjXRL6vjM9dPcHykyic/oV
         pVvrxQfLega/A4d7EvLpTqGdS1JT43CvIIr44nav7jjt/12QNXondIm+J5zqpoojyI
         p/nYETs11xcQTBnSoGzueNtsw0oIUTfs6sLKR9rov4LwxLhJrhPAdXo1idMKbXWcKx
         qA01bgilxvEfodYCUI5jZ8X/gH7wog3YqQ75Pvd1rgQBlDhRn6AoLD07eIq/fsc9yG
         0JO43s8uU/y+agFFkLu8TVry9ITWjB90Uc3RnOxOOvTH2RkDCQrLDyA8QSl9aOSw9C
         7SnZaYqC5kDcA==
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2d07ae0b1c0so117608077b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 01:15:04 -0800 (PST)
X-Gm-Message-State: AOAM533idf03IwHgM4pj8m/9FwejISiahWu9mZvmr/AUh4qLldIbafrL
        Mxh8Ybh5c2489Wf5+DZKk8dYuYSmjurF1eArnmA=
X-Google-Smtp-Source: ABdhPJxXVFvCA3xfCEKDQSGwJzxV1O7JYrkhwTAU08jl9Kd850SEd8pe7dJoJppZL7UIOIDCZROgPvCpP0ExJFMip2k=
X-Received: by 2002:a81:c24b:0:b0:2dc:7d67:a57a with SMTP id
 t11-20020a81c24b000000b002dc7d67a57amr12162597ywg.272.1647076503381; Sat, 12
 Mar 2022 01:15:03 -0800 (PST)
MIME-Version: 1.0
References: <20220309144138.360482-1-arnd@kernel.org>
In-Reply-To: <20220309144138.360482-1-arnd@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 12 Mar 2022 10:14:51 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH6naR0FJHnie2NjqixFegX1EJVjB8_X=6_g2nZKFS=AQ@mail.gmail.com>
Message-ID: <CAMj1kXH6naR0FJHnie2NjqixFegX1EJVjB8_X=6_g2nZKFS=AQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: fix building NOMMU ARMv4/v5 kernels
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2022 at 15:41, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The removal of the old-style irq entry broke obscure NOMMU
> configurations on machines that have an MMU:
>
> ld.lld: error: undefined symbol: generic_handle_arch_irq
>  referenced by kernel/entry-armv.o:(__irq_svc) in archive arch/arm/built-in.a
>
> A follow-up patch to convert nvic to the generic_handle_arch_irq()
> could have fixed this by removing the Kconfig conditional, but did
> it differently.
>
> Change the Kconfig logic so ARM machines now unconditionally
> enable the feature.
>
> I have also submitted a patch to remove support for the configurations
> that broke, but fixing the regression first is a trivial and correct
> change.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 54f481a2308e ("ARM: remove old-style irq entry")
> Fixes: 52d240871760 ("irqchip: nvic: Use GENERIC_IRQ_MULTI_HANDLER")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed by: Ard Biesheuvel <ardb@kernel.org>

> ---
> This patch should go into the arm/devel-stable branch that has
> the arm-irq-and-vmap-stacks-for-rmk patches from Ard
> ---
>  arch/arm/Kconfig        | 2 +-
>  drivers/irqchip/Kconfig | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index e9975ddd5034..5f0b40bab4fb 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -60,7 +60,7 @@ config ARM
>         select GENERIC_CPU_AUTOPROBE
>         select GENERIC_EARLY_IOREMAP
>         select GENERIC_IDLE_POLL_SETUP
> -       select GENERIC_IRQ_MULTI_HANDLER if MMU
> +       select GENERIC_IRQ_MULTI_HANDLER
>         select GENERIC_IRQ_PROBE
>         select GENERIC_IRQ_SHOW
>         select GENERIC_IRQ_SHOW_LEVEL
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 488eaa14d3a7..7038957f4a77 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -58,7 +58,6 @@ config ARM_NVIC
>         bool
>         select IRQ_DOMAIN_HIERARCHY
>         select GENERIC_IRQ_CHIP
> -       select GENERIC_IRQ_MULTI_HANDLER
>
>  config ARM_VIC
>         bool
> --
> 2.29.2
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6841A578F8A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 03:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbiGSBGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 21:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiGSBGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 21:06:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEC29D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 18:06:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1FDF616E3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:06:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65FAC341C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658192789;
        bh=kxYeyaK98bc49giE1gnQxza3GWs0xyyloJIWb1p7nFY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uRxBigYkEFpwtakr1ZSZUd0w9dVcfUNG8SRb7hwk7NPKYKfAk1zHOsD60n7sxFxdY
         mEJ7okdsbwrIWt6+duLT6sO7HllK/TyOe2RVJLlGP2CiMvV9DBYh/dELyRmcq+tVhv
         RYydFiKVDmrCnsW4rjYZNEiuSnDah5gKx9hNvQMdVsKW4g83pOX28cOyqyaoXPWYLK
         x4fvi/rbXX+8ZOub7/qC/KfXB/Pvxtz2Xe890/AA+4M/r/HBvRvqlrmbpPjGZFs/Cv
         uGW9zC/cvcnkCSvAscEuIbLXhXBuEo2lD4KzXj6xEWFQe/kmrO1GgKGelAvN/EfLYj
         7LU5C6yX9s15w==
Received: by mail-vs1-f50.google.com with SMTP id q26so12055812vsp.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 18:06:29 -0700 (PDT)
X-Gm-Message-State: AJIora/6R9dDopJZQ9DpsRnl9LgvjAwWeHNJqoE3bwJ5ePObevKKEqbU
        3HkG3cx5HxUBxDgloNJw4uaw36Nb2WPeRq56zcI=
X-Google-Smtp-Source: AGRyM1uXkHqJ1jNNkLUVfs4Y4LMdgPemWq2w9gsknKl2suGR1qyJLOuATeoavOgl15eseE6H341Zr1h3xGAmgqy0Bz4=
X-Received: by 2002:a67:ec05:0:b0:357:7a48:cba8 with SMTP id
 d5-20020a67ec05000000b003577a48cba8mr11370704vso.78.1658192788918; Mon, 18
 Jul 2022 18:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <1658153621-40445-1-git-send-email-lvjianmin@loongson.cn> <1658153621-40445-8-git-send-email-lvjianmin@loongson.cn>
In-Reply-To: <1658153621-40445-8-git-send-email-lvjianmin@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 19 Jul 2022 09:06:16 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7VRwAEELp_OrGsk7Rj73Xbwj-4A0yoyaxpMspPV83W3A@mail.gmail.com>
Message-ID: <CAAhV-H7VRwAEELp_OrGsk7Rj73Xbwj-4A0yoyaxpMspPV83W3A@mail.gmail.com>
Subject: Re: [PATCH V16 07/14] irqchip: remove COMPILE_TEST for pch-pic and pch-msi
To:     Jianmin Lv <lvjianmin@loongson.cn>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, loongarch@lists.linux.dev,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jianmin,

This patch can be squashed into "irqchip/loongson-pch-pic: Add ACPI
init support" and "irqchip/loongson-pch-msi: Add ACPI init support",
thanks.

Huacai

On Mon, Jul 18, 2022 at 10:13 PM Jianmin Lv <lvjianmin@loongson.cn> wrote:
>
> From: Huacai Chen <chenhuacai@loongson.cn>
>
> Loongson's pch-pic and pch-msi will have some arch-specific
> code, so we remove the COMPILE_TEST dependency to avoid build
> warnings.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> ---
>  drivers/irqchip/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index c1d527f..8844e6b 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -574,7 +574,7 @@ config LOONGSON_HTVEC
>
>  config LOONGSON_PCH_PIC
>         bool "Loongson PCH PIC Controller"
> -       depends on MACH_LOONGSON64 || COMPILE_TEST
> +       depends on MACH_LOONGSON64
>         default MACH_LOONGSON64
>         select IRQ_DOMAIN_HIERARCHY
>         select IRQ_FASTEOI_HIERARCHY_HANDLERS
> @@ -583,7 +583,7 @@ config LOONGSON_PCH_PIC
>
>  config LOONGSON_PCH_MSI
>         bool "Loongson PCH MSI Controller"
> -       depends on MACH_LOONGSON64 || COMPILE_TEST
> +       depends on MACH_LOONGSON64
>         depends on PCI
>         default MACH_LOONGSON64
>         select IRQ_DOMAIN_HIERARCHY
> --
> 1.8.3.1
>
>

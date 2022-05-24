Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE08D532130
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbiEXCuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbiEXCuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:50:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F646EB11;
        Mon, 23 May 2022 19:50:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E49FCB81722;
        Tue, 24 May 2022 02:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A559FC36AE3;
        Tue, 24 May 2022 02:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653360608;
        bh=9tJzgDSzNbcE3lkPHHMiOyFzxrJvq0EKSU2oKxbKIoM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b6UAAB3hpv8m6aTOEYYiWrfrlORMkuuyR7su5oPM4rVsyNZXRLPJS+Zlj0DgEAl01
         3UURv9EPt68fdFGsJnkHdcRtYiFCe0kyB2YLi0VztaKlRWVN+KUxedApXPLsIkDCrr
         Zx5xVogUzGv589rAKDM265+dY8lOzIbO4hodtaIbOvYcdGUCZMnGJiTxm5Q2FpmdWe
         Vj4uz8Jeyq01lHjcostR8wh0scGnER8O8EgHahQBPC34bPsB5I4K7dNzKweVdkjVvt
         2wPehCzgm1puDwCV1eQo+SiNOPLQYZtZC6Dc08z8ImIoutVS6XOB2uTnfJjfxVdCx5
         0PC13HyuUHx5Q==
Received: by mail-vs1-f51.google.com with SMTP id 67so1763472vsh.2;
        Mon, 23 May 2022 19:50:08 -0700 (PDT)
X-Gm-Message-State: AOAM533c+XzBWg2euBMYEHAdFf+mS1BUdzfCTm5mY2I4hV2QPYrTzIvN
        AUnVBsgcNma5sjF18uDYYzfqVtrjGeoZwPuO/68=
X-Google-Smtp-Source: ABdhPJzwXGK1MbaJ7TTtBoFyMr/agYiAbxyTf7HvMrhpcP0V0i/PJTWjerMRQpBE9AhGVF8/+Y7Lp3ILB/1fUHaQT3Y=
X-Received: by 2002:a67:e899:0:b0:337:932a:2fc5 with SMTP id
 x25-20020a67e899000000b00337932a2fc5mr6298284vsn.40.1653360607569; Mon, 23
 May 2022 19:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <1c4e81eda5f9651f581f1554629d334f1afda841.1653227039.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <1c4e81eda5f9651f581f1554629d334f1afda841.1653227039.git.christophe.jaillet@wanadoo.fr>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 24 May 2022 10:50:00 +0800
X-Gmail-Original-Message-ID: <CAAhV-H73Gj-KDjLuqCtasX5dtBRTHe_8s51wR1mrd=_rBF_XZA@mail.gmail.com>
Message-ID: <CAAhV-H73Gj-KDjLuqCtasX5dtBRTHe_8s51wR1mrd=_rBF_XZA@mail.gmail.com>
Subject: Re: [PATCH] irqchip/loongson-liointc: Fix an error handling path in liointc_init()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     dan.carpenter@oracle.com, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        "open list:MIPS" <linux-mips@vger.kernel.org>
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

Hi, Christophe,

On Sun, May 22, 2022 at 9:44 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> If a of_property_match_string() call fails, we still need to release some
> resources.
> Add the corresponding goto instead of a direct return.
Your patch is correct, but 807e93d0ecbb hasn't been upstream, I don't
know how to handle it.

Huacai
>
> Fixes: 807e93d0ecbb ("irqchip/loongson-liointc: Add ACPI init support")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/irqchip/irq-loongson-liointc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
> index ff3cb5b05710..2227b702a81d 100644
> --- a/drivers/irqchip/irq-loongson-liointc.c
> +++ b/drivers/irqchip/irq-loongson-liointc.c
> @@ -185,8 +185,10 @@ static int liointc_init(phys_addr_t addr, unsigned long size, int revision,
>                         int index = of_property_match_string(node,
>                                         "reg-names", core_reg_names[i]);
>
> -                       if (index < 0)
> -                               return -EINVAL;
> +                       if (index < 0) {
> +                               err = -EINVAL;
> +                               goto out_iounmap;
> +                       }
>
>                         priv->core_isr[i] = of_iomap(node, index);
>                 }
> --
> 2.34.1
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E01246E11E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 04:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhLIDL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 22:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhLIDLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 22:11:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B76FC061746;
        Wed,  8 Dec 2021 19:08:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A947B8236F;
        Thu,  9 Dec 2021 03:08:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB985C341C7;
        Thu,  9 Dec 2021 03:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639019293;
        bh=OwC5+HVjHuesgoVGYQ3WpeyASnIQ6aFbde6At4MqiYU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H1rVBputbwW8bKidazrvgL1kTOJqHgHjwCvPn1Q7z3qF8xuu1iDO5Pknyavnr6CH0
         mOB5tQMl0V91tJlXEisLIKSpKvWcdD7iMEBGdN16oyKbPQzX9dbRC+A/MBBc87R8YL
         DVBXre0gAd2m9mP6TtxFIvMIR6ftOeuRp04J/n4/vgOIGIQoo7ZiUkPy5iWt8K7Ui/
         J/uIYwH8G2cbz4S8079/+ugjaX5gnlfpy1kReWmJcAS3CapZdwtDmP82DlIiOy2Le3
         D0n6ZWosDaq+7fVUmn5qBia5GPE66bo3X631kFC9tel3kpTTJrBMiVHZd5WRd2MxVb
         llJUSmo8JspRg==
Received: by mail-ed1-f48.google.com with SMTP id w1so14937050edc.6;
        Wed, 08 Dec 2021 19:08:13 -0800 (PST)
X-Gm-Message-State: AOAM532qaSgAUiaC/rE7d2xrpK3TJSy56bVbUJJI5OE5XEHU56giHH+g
        6tj6bt6h36lzXQjR5mZbvgwQux2NXV7mLeW0sg==
X-Google-Smtp-Source: ABdhPJyyND1t4VP0cquujrBH74RIM5qxBBAuG9q2A50vzIHpbIMiHVFHDXaavM0IHgf/bAan7vOUKxqc6AZgDTvQ+Kk=
X-Received: by 2002:a05:6402:4251:: with SMTP id g17mr24808372edb.89.1639019292065;
 Wed, 08 Dec 2021 19:08:12 -0800 (PST)
MIME-Version: 1.0
References: <20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 8 Dec 2021 21:08:00 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJUS0-ZNus__7nJJ-BaJBqQcS0NZ8a4o5QheLt4g8oK+Q@mail.gmail.com>
Message-ID: <CAL_JsqJUS0-ZNus__7nJJ-BaJBqQcS0NZ8a4o5QheLt4g8oK+Q@mail.gmail.com>
Subject: Re: [RFC PATCH] of: platform: Skip mapping of interrupts in of_device_alloc()
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 8, 2021 at 6:11 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> of_device_alloc() in early boot stage creates a interrupt mapping if
> there exists a "interrupts" property in the node.
>
> For hierarchical interrupt domains using "interrupts" property in the node
> bypassed the hierarchical setup and messed up the irq setup.
>
> This patch adds a check in of_device_alloc() to skip interrupt mapping if
> "not-interrupt-producer" property is present in the node. This allows
> nodes to describe the interrupts using "interrupts" property.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Hi All,
>
> Spawning from discussion [1], here is simple patch (not the ideal probably
> welcome for suggestions) from stopping the OF code from creating a map for
> the interrupts when using "interrupts" property.
>
> [1] https://lore.kernel.org/lkml/87pmqrck2m.wl-maz@kernel.org/
>     T/#mbd1e47c1981082aded4b32a52e2c04291e515508
>
> Cheers,
> Prabhakar
> ---
>  drivers/of/platform.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index b3faf89744aa..629776ca1721 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -114,7 +114,7 @@ struct platform_device *of_device_alloc(struct device_node *np,
>                                   struct device *parent)
>  {
>         struct platform_device *dev;
> -       int rc, i, num_reg = 0, num_irq;
> +       int rc, i, num_reg = 0, num_irq = 0;
>         struct resource *res, temp_res;
>
>         dev = platform_device_alloc("", PLATFORM_DEVID_NONE);
> @@ -124,7 +124,14 @@ struct platform_device *of_device_alloc(struct device_node *np,
>         /* count the io and irq resources */
>         while (of_address_to_resource(np, num_reg, &temp_res) == 0)
>                 num_reg++;
> -       num_irq = of_irq_count(np);
> +
> +       /*
> +        * we don't want to map the interrupts of hierarchical interrupt domain
> +        * into the parent domain yet. This will be the job of the hierarchical
> +        * interrupt driver code to map the interrupts as and when needed.
> +        */
> +       if (!of_property_read_bool(np, "not-interrupt-producer"))
> +               num_irq = of_irq_count(np);

The property won't fly for sure. A compatible match table could work
here, but I don't really want another temporary solution.

>         /* Populate the resource table */
>         if (num_irq || num_reg) {
> @@ -140,7 +147,7 @@ struct platform_device *of_device_alloc(struct device_node *np,
>                         rc = of_address_to_resource(np, i, res);
>                         WARN_ON(rc);
>                 }
> -               if (of_irq_to_resource_table(np, res, num_irq) != num_irq)
> +               if (num_irq && of_irq_to_resource_table(np, res, num_irq) != num_irq)

You might want to look at commit 9ec36cafe43b ("of/irq: do irq
resolution in platform_get_irq"). The intent was to remove this code,
but looks like the cleanup has a ways to go 7 years on. Primarily,
it's convert any platform_get_resource(pdev, IORESOURCE_IRQ, n) call
to platform_get_irq(). There's ~169 of those.

There are probably some open coded accesses to pdev->resources too,
but I didn't spot any.

Rob

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A739246E3B7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 09:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbhLIIKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 03:10:48 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37780 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhLIIKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 03:10:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D75FB8232D;
        Thu,  9 Dec 2021 08:07:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDF8C004DD;
        Thu,  9 Dec 2021 08:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639037231;
        bh=+byi4jazPjWiiuMxrmLm/up5m5oJ2mLxYw3tgGfUdjE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=API6olAzn9MjMwTNlc4Wo5snguoGWqdZur3wg3ade3/h256T9N7S+Ez+QGEeJNYYo
         uuva2NN2SfwBnOrqJJx88o+ufKYqXKzCDhGFGLtZEUIR0Nlvx+h8lBOKMQDmBeyrA3
         iHpEy3mk8QHOIhV5ckJhho6NJtEfzl/NtzVliqAyga3q7spUXKWOEo3P00LbA8cStw
         Hfq0o+Pkx3m2kqEy0WqSeVwziZIZXa5TgUa/8qg3+71/jhzqEwEbfp5bAzE1SSrxMs
         dIhwydP58dWXBb+nbClbZaYNJWvbwgQbLX2+e5YPqlbHRPX2fx/2E219AVV7Wnp2lM
         t/B9ZXZ06yrCg==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mvESL-00AxjR-Cd; Thu, 09 Dec 2021 08:07:09 +0000
MIME-Version: 1.0
Date:   Thu, 09 Dec 2021 08:07:09 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [RFC PATCH] of: platform: Skip mapping of interrupts in
 of_device_alloc()
In-Reply-To: <20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <d290850bf95f4bdf0c329f278db458c7@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: prabhakar.mahadev-lad.rj@bp.renesas.com, robh+dt@kernel.org, frowand.list@gmail.com, tglx@linutronix.de, geert+renesas@glider.be, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, prabhakar.csengg@gmail.com, biju.das.jz@bp.renesas.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-09 00:10, Lad Prabhakar wrote:
> of_device_alloc() in early boot stage creates a interrupt mapping if
> there exists a "interrupts" property in the node.
> 
> For hierarchical interrupt domains using "interrupts" property in the 
> node
> bypassed the hierarchical setup and messed up the irq setup.
> 
> This patch adds a check in of_device_alloc() to skip interrupt mapping 
> if
> "not-interrupt-producer" property is present in the node. This allows
> nodes to describe the interrupts using "interrupts" property.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Hi All,
> 
> Spawning from discussion [1], here is simple patch (not the ideal 
> probably
> welcome for suggestions) from stopping the OF code from creating a map 
> for
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
> @@ -114,7 +114,7 @@ struct platform_device *of_device_alloc(struct
> device_node *np,
>  				  struct device *parent)
>  {
>  	struct platform_device *dev;
> -	int rc, i, num_reg = 0, num_irq;
> +	int rc, i, num_reg = 0, num_irq = 0;
>  	struct resource *res, temp_res;
> 
>  	dev = platform_device_alloc("", PLATFORM_DEVID_NONE);
> @@ -124,7 +124,14 @@ struct platform_device *of_device_alloc(struct
> device_node *np,
>  	/* count the io and irq resources */
>  	while (of_address_to_resource(np, num_reg, &temp_res) == 0)
>  		num_reg++;
> -	num_irq = of_irq_count(np);
> +
> +	/*
> +	 * we don't want to map the interrupts of hierarchical interrupt 
> domain
> +	 * into the parent domain yet. This will be the job of the 
> hierarchical
> +	 * interrupt driver code to map the interrupts as and when needed.
> +	 */
> +	if (!of_property_read_bool(np, "not-interrupt-producer"))

I don't think this is right. If anything, the expected behaviour should 
be
indicated by the driver and not the device node.

> +		num_irq = of_irq_count(np);
> 
>  	/* Populate the resource table */
>  	if (num_irq || num_reg) {
> @@ -140,7 +147,7 @@ struct platform_device *of_device_alloc(struct
> device_node *np,
>  			rc = of_address_to_resource(np, i, res);
>  			WARN_ON(rc);
>  		}
> -		if (of_irq_to_resource_table(np, res, num_irq) != num_irq)
> +		if (num_irq && of_irq_to_resource_table(np, res, num_irq) != 
> num_irq)
>  			pr_debug("not all legacy IRQ resources mapped for %pOFn\n",
>  				 np);
>  	}

The root of the issue is that all the resource allocation is done 
upfront,
way before we even have a driver that could potentially deal with this
device. This is a potential waste of resource, and it triggers the
issue you noticed.

If you delay the resource allocation until there is an actual match with 
a
driver, you could have a per-driver flag telling you whether the IRQ
allocation should be performed before the probe() function is called.

         M.
-- 
Jazz is not dead. It just smells funny...

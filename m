Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39AF46D35F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 13:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbhLHMhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 07:37:15 -0500
Received: from mail.thorsis.com ([92.198.35.195]:53952 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229598AbhLHMhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 07:37:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id BDB6410C8;
        Wed,  8 Dec 2021 13:33:41 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.thorsis.com
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TYdj9XuRCxoj; Wed,  8 Dec 2021 13:33:41 +0100 (CET)
Received: by mail.thorsis.com (Postfix, from userid 109)
        id EF044335A; Wed,  8 Dec 2021 13:33:39 +0100 (CET)
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.2
X-Spam-Report: * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: axentia.se]
        * -0.0 NO_RELAYS Informational: message was not relayed via SMTP
        * -0.0 NO_RECEIVED Informational: message has no Received headers
Date:   Wed, 8 Dec 2021 13:33:25 +0100
From:   Alexander Dahl <ada@thorsis.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH] pinctrl: at91: allow use of of gpio-line-names property
Message-ID: <YbCmFac6/nU949/Z@ada-deb-carambola.ifak-system.com>
Mail-Followup-To: Peter Rosin <peda@axentia.se>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
References: <4d17866a-d9a4-a3d7-189a-781d18dbea00@axentia.se>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d17866a-d9a4-a3d7-189a-781d18dbea00@axentia.se>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter,

Am Tue, Dec 07, 2021 at 12:32:03AM +0100 schrieb Peter Rosin:
> If no line name is given (by not having a gpio-line-names property,
> or by having empty "" strings for some lines), fall back to the
> existing pioC12-style line name scheme.
> 
> It is useful to be able to explicitly name lines from the schematics
> or its function, rather than having the MCU names forced upon every
> user.

+1 from me. 

I asked about this some months ago, but I saw no clear
direction in the discussion. So for reference:

https://lore.kernel.org/linux-gpio/946021874.11132.1615900079722@seven.thorsis.com/

HTH & Greets
Alex

> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/pinctrl/pinctrl-at91.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> I don't know if it's sane to fall back to the pioC12-style on empty
> strings, or if someone adding a gpio-line-names property should be
> responsible for filling in those names "by hand". I generally don't
> care what "unused" pins are named, so either is fine by me...
> 
> Cheers,
> Peter
> 
> diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
> index 6022496bb6a9..4f108d07e6ad 100644
> --- a/drivers/pinctrl/pinctrl-at91.c
> +++ b/drivers/pinctrl/pinctrl-at91.c
> @@ -1821,7 +1821,7 @@ static int at91_gpio_probe(struct platform_device *pdev)
>  	int irq, i;
>  	int alias_idx = of_alias_get_id(np, "gpio");
>  	uint32_t ngpio;
> -	char **names;
> +	const char **names;
>  
>  	BUG_ON(alias_idx >= ARRAY_SIZE(gpio_chips));
>  	if (gpio_chips[alias_idx]) {
> @@ -1890,8 +1890,15 @@ static int at91_gpio_probe(struct platform_device *pdev)
>  		goto clk_enable_err;
>  	}
>  
> -	for (i = 0; i < chip->ngpio; i++)
> -		names[i] = kasprintf(GFP_KERNEL, "pio%c%d", alias_idx + 'A', i);
> +	if (of_property_read_string_array(np, "gpio-line-names",
> +					  names, chip->ngpio) != chip->ngpio)
> +		memset(names, 0, chip->ngpio * sizeof(char *));
> +
> +	for (i = 0; i < chip->ngpio; i++) {
> +		if (!names[i] || !names[i][0])
> +			names[i] = kasprintf(GFP_KERNEL,
> +					     "pio%c%d", alias_idx + 'A', i);
> +	}
>  
>  	chip->names = (const char *const *)names;
>  
> -- 
> 2.20.1
> 

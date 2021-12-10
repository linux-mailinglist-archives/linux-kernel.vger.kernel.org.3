Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B137147009E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 13:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240979AbhLJM2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 07:28:46 -0500
Received: from mail.thorsis.com ([92.198.35.195]:47459 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240974AbhLJM2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 07:28:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id CDC8A354A;
        Fri, 10 Dec 2021 13:25:09 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.thorsis.com
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sc9IaSCmdGH8; Fri, 10 Dec 2021 13:25:09 +0100 (CET)
Received: by mail.thorsis.com (Postfix, from userid 109)
        id 9778A1D8A; Fri, 10 Dec 2021 13:25:09 +0100 (CET)
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
        *      [URIs: thorsis.com]
        * -0.0 NO_RELAYS Informational: message was not relayed via SMTP
        * -0.0 NO_RECEIVED Informational: message has no Received headers
Date:   Fri, 10 Dec 2021 13:24:58 +0100
From:   Alexander Dahl <ada@thorsis.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexander Dahl <ada@thorsis.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Roelf-Erik Carsjens <rca@thorsis.com>
Subject: Re: [PATCH] gpiolib: allow line names from device props to override
 driver names
Message-ID: <YbNHGkhHKQAOwxnB@ada.ifak-system.com>
Mail-Followup-To: Peter Rosin <peda@axentia.se>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Roelf-Erik Carsjens <rca@thorsis.com>
References: <70b1de02-b674-ca17-9219-61fa8e1c00db@axentia.se>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70b1de02-b674-ca17-9219-61fa8e1c00db@axentia.se>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter,

Am Thu, Dec 09, 2021 at 12:32:29PM +0100 schrieb Peter Rosin:
> Some gpio providers set names for gpio lines that match the names of
> the pins on the SoC, or variations on that theme. These names are
> generally generic, such as pioC12 in the at91 case. These generic names
> block the possibility to name gpio lines with in device properties
> (i.e. gpio-line-names).
> 
> Allow overriding a generic name given by the gpio driver if there is
> a name given to the gpio line using device properties, but leave the
> generic name alone if no better name is available.

I think this is a good solution. For example on at91 if someone did
not set gpio-line-names yet, and relied on the generic names (PA0,
PA1, etc.), she won't get new names until she sets line names in dts.
This at least allows for transitioning dts / userspace at the same
time, without the kernel getting in the way.

> However, there is a risk. If user space is depending on the above
> mentioned fixed gpio names, AND there are device properties that
> previously did not reach the surface, the name change might cause
> regressions. But hopefully this stays below the radar...
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

I backported the patch to v5.10.65 and tested, this is part of the
result on a custom board, where line names were set for the sd card
interface and an I²C port:

    root@DistroKit:~ gpioinfo | head -n20
    gpiochip0 - 128 lines:
            line   0:  "SDMMC0_CK"       unused   input  active-high 
            line   1: "SDMMC0_CMD"       unused   input  active-high 
            line   2: "SDMMC0_DAT0" unused input active-high 
            line   3: "SDMMC0_DAT1" unused input active-high 
            line   4: "SDMMC0_DAT2" unused input active-high 
            line   5: "SDMMC0_DAT3" unused input active-high 
            line   6:        "TWD"       unused   input  active-high 
            line   7:       "TWCK"       unused   input  active-high 
            line   8:        "PA8"       unused   input  active-high 
            line   9:        "PA9"       unused   input  active-high 
            line  10:       "PA10"       unused   input  active-high 
            line  11:       "PA11"       unused   input  active-high 
            line  12:       "PA12"       unused   input  active-high 
            line  13:  "SDMMC0_CD"       unused   input  active-high 
            line  14:       "PA14"       unused   input  active-high 
            line  15:       "PA15"       unused   input  active-high 
            line  16:       "PA16"       unused   input  active-high 
            line  17:       "PA17"       unused   input  active-high 
            line  18:       "PA18"       unused   input  active-high 

So if you're okay with testing a backport, you may add my

Tested-by: Alexander Dahl <ada@thorsis.com>

Greets
Alex

> ---
>  drivers/gpio/gpiolib.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> Instead of doing this only for pinctrl-at91.c as in my recent patch [1], do
> it for everyone.
> 
> Cheers,
> Peter
> 
> [1] https://lore.kernel.org/lkml/4d17866a-d9a4-a3d7-189a-781d18dbea00@axentia.se/
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index abfbf546d159..00a2a689c202 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -422,8 +422,15 @@ static int devprop_gpiochip_set_names(struct gpio_chip *chip)
>  	if (count > chip->ngpio)
>  		count = chip->ngpio;
>  
> -	for (i = 0; i < count; i++)
> -		gdev->descs[i].name = names[chip->offset + i];
> +	for (i = 0; i < count; i++) {
> +		/*
> +		 * Allow overriding "fixed" names provided by the gpio
> +		 * provider, the "fixed" names are generally generic and less
> +		 * informative than the names given in device properties.
> +		 */
> +		if (names[chip->offset + i] && names[chip->offset + i][0])
> +			gdev->descs[i].name = names[chip->offset + i];
> +	}
>  
>  	kfree(names);
>  
> @@ -708,10 +715,12 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
>  	INIT_LIST_HEAD(&gdev->pin_ranges);
>  #endif
>  
> -	if (gc->names)
> +	if (gc->names) {
>  		ret = gpiochip_set_desc_names(gc);
> -	else
> -		ret = devprop_gpiochip_set_names(gc);
> +		if (ret)
> +			goto err_remove_from_list;
> +	}
> +	ret = devprop_gpiochip_set_names(gc);
>  	if (ret)
>  		goto err_remove_from_list;
>  
> -- 
> 2.20.1
> 

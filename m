Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC38847A8EB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 12:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhLTLpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 06:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbhLTLpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 06:45:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09258C061574;
        Mon, 20 Dec 2021 03:45:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9ECB560F47;
        Mon, 20 Dec 2021 11:45:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75FEAC36AE7;
        Mon, 20 Dec 2021 11:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640000734;
        bh=3C01IwQMe5zGfxAc75SMbbI2IYtkbpFIeHZRk8OhIbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dfOJbjRkgIxRcoCF+Yv5tW2XP7/jxJB54k4QjSA+quTqe092x0kt4nXAmDA2kGBae
         N3PjAesutQ7BL9ACUkFWgqiewcQbpt53mEsy/K0bhbOGg5iQIkfV8d6rPjLqZj8iAh
         3oWvpXOFs61RuVwzuHBYNdpDrNAOIjMDlBX/newY=
Date:   Mon, 20 Dec 2021 12:45:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Radim Pavlik <radim.pavlik@tbs-biometrics.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sc16is7xx: Prevent dereferencing invalid data when
 gpio_hog used
Message-ID: <YcBs2ySfTdApxM1m@kroah.com>
References: <CAHp75VeaWJBstu2j1-wkBkPfgc0dXvjWZR01d8-q0P8t_3gvNA@mail.gmail.com>
 <20211220113603.1311-1-radim.pavlik@tbs-biometrics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220113603.1311-1-radim.pavlik@tbs-biometrics.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 12:36:03PM +0100, Radim Pavlik wrote:
> gpio_hog is trying to use gpio functions during probe call.
> At that time we dont have initialized port data which are dereferenced
> via assigned gpio.direction_input/output functions.
> This results in unable to handle kernel NULL pointer dereference
> followed by Kernel panic.
> This patch prevents that.
> 
> Due to changed order of initialization 'port' before 'gpio controller'
> was also changed error path which resulted in removed label.
> 
> No fixes tag because patch spans across multiple patches.
> 
> Signed-off-by: Radim Pavlik <radim.pavlik@tbs-biometrics.com>
> ---
>  drivers/tty/serial/sc16is7xx.c | 49 +++++++++++++++++-----------------
>  1 file changed, 24 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 64e7e6c8145f..416fa71dcde1 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -1242,25 +1242,6 @@ static int sc16is7xx_probe(struct device *dev,
>  	}
>  	sched_set_fifo(s->kworker_task);
> 
> -#ifdef CONFIG_GPIOLIB
> -	if (devtype->nr_gpio) {
> -		/* Setup GPIO cotroller */
> -		s->gpio.owner		 = THIS_MODULE;
> -		s->gpio.parent		 = dev;
> -		s->gpio.label		 = dev_name(dev);
> -		s->gpio.direction_input	 = sc16is7xx_gpio_direction_input;
> -		s->gpio.get		 = sc16is7xx_gpio_get;
> -		s->gpio.direction_output = sc16is7xx_gpio_direction_output;
> -		s->gpio.set		 = sc16is7xx_gpio_set;
> -		s->gpio.base		 = -1;
> -		s->gpio.ngpio		 = devtype->nr_gpio;
> -		s->gpio.can_sleep	 = 1;
> -		ret = gpiochip_add_data(&s->gpio, s);
> -		if (ret)
> -			goto out_thread;
> -	}
> -#endif
> -
>  	/* reset device, purging any pending irq / data */
>  	regmap_write(s->regmap, SC16IS7XX_IOCONTROL_REG << SC16IS7XX_REG_SHIFT,
>  			SC16IS7XX_IOCONTROL_SRESET_BIT);
> @@ -1315,6 +1296,25 @@ static int sc16is7xx_probe(struct device *dev,
>  		sc16is7xx_power(&s->p[i].port, 0);
>  	}
> 
> +#ifdef CONFIG_GPIOLIB
> +	if (devtype->nr_gpio) {
> +		/* Setup GPIO cotroller */
> +		s->gpio.owner		 = THIS_MODULE;
> +		s->gpio.parent		 = dev;
> +		s->gpio.label		 = dev_name(dev);
> +		s->gpio.direction_input	 = sc16is7xx_gpio_direction_input;
> +		s->gpio.get		 = sc16is7xx_gpio_get;
> +		s->gpio.direction_output = sc16is7xx_gpio_direction_output;
> +		s->gpio.set		 = sc16is7xx_gpio_set;
> +		s->gpio.base		 = -1;
> +		s->gpio.ngpio		 = devtype->nr_gpio;
> +		s->gpio.can_sleep	 = 1;
> +		ret = gpiochip_add_data(&s->gpio, s);
> +		if (ret)
> +			goto out_ports;
> +	}
> +#endif
> +
>  	if (dev->of_node) {
>  		struct property *prop;
>  		const __be32 *p;
> @@ -1345,18 +1345,17 @@ static int sc16is7xx_probe(struct device *dev,
>  	if (!ret)
>  		return 0;
> 
> +#ifdef CONFIG_GPIOLIB
> +	if (devtype->nr_gpio)
> +		gpiochip_remove(&s->gpio);
> +#endif
> +
>  out_ports:
>  	for (i--; i >= 0; i--) {
>  		uart_remove_one_port(&sc16is7xx_uart, &s->p[i].port);
>  		clear_bit(s->p[i].port.line, &sc16is7xx_lines);
>  	}
> 
> -#ifdef CONFIG_GPIOLIB
> -	if (devtype->nr_gpio)
> -		gpiochip_remove(&s->gpio);
> -
> -out_thread:
> -#endif
>  	kthread_stop(s->kworker_task);
> 
>  out_clk:
> --
> 2.32.0
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot


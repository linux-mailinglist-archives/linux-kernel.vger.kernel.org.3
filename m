Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA37463140
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 11:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbhK3KoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 05:44:11 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:36120 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbhK3KoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 05:44:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8555BCE1753;
        Tue, 30 Nov 2021 10:40:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B184FC53FC7;
        Tue, 30 Nov 2021 10:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638268847;
        bh=18ZTr0X2PdlfkzsEGpm3sExOfpPIH1Cb57fTif+SfOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VClwLslT6Wf78OwabLpCpOEtmZpKOTBg448g2UYLMnX55q1Q9nhRslgWFnpqUwUQg
         yQxyr4udMMi03wnCJa+7BA19yfIElI6Efn4VuzExOUkKKH0XUa9GURH/u5dwY7/ywo
         C0TSt0KteiCVOtQC8sG/m8IsLv8N4SI9IMdUHgYdWFk2IfS7xiQf3Ve0wtyj24Sk75
         qroYoRX/jKqjXESPUhWWIYeaLpfe2inkT39X9V+Od7WEHtTMhcYczZU6TIqJTbr/kq
         8ijJ4U3lmRIxmhVXJ1wRLeHmMFLrdcizSlsljto0/Qrkp34U0XkFLM0AVwuJWqIiBW
         U3kpypkO6Byzw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ms0Yj-0006cF-6d; Tue, 30 Nov 2021 11:40:25 +0100
Date:   Tue, 30 Nov 2021 11:40:25 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 5/7] serial: 8250_omap: Require a valid wakeirq for
 deeper idle states
Message-ID: <YaX/mWdylxahR2Fi@hovoldconsulting.com>
References: <20211115084203.56478-1-tony@atomide.com>
 <20211115084203.56478-6-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115084203.56478-6-tony@atomide.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 10:42:01AM +0200, Tony Lindgren wrote:
> For deeper idle states the 8250 device gets powered off. The wakeup is
> handled with a separate wakeirq controller monitoring the RX pin.
> 
> Let's check for a valid wakeirq before enabling deeper idle states.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/tty/serial/8250/8250_omap.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -133,6 +133,7 @@ struct omap8250_priv {
>  	spinlock_t rx_dma_lock;
>  	bool rx_dma_broken;
>  	bool throttled;
> +	unsigned int allow_rpm:1;
>  };
>  
>  struct omap8250_dma_params {
> @@ -676,6 +677,7 @@ static int omap_8250_startup(struct uart_port *port)
>  		ret = dev_pm_set_dedicated_wake_irq(port->dev, priv->wakeirq);
>  		if (ret)
>  			return ret;
> +		priv->allow_rpm = 1;
>  	}
>  
>  	pm_runtime_get_sync(port->dev);

Note that you still have synchronous resumes here despite this function
being called in atomic context. It didn't look like these were removed
by the next patch that drops irq_safe.

> @@ -722,6 +724,10 @@ static int omap_8250_startup(struct uart_port *port)
>  	if (up->dma && !(priv->habit & UART_HAS_EFR2))
>  		up->dma->rx_dma(up);
>  
> +	/* Block runtime PM if no wakeirq, paired with shutdown */
> +	if (!priv->allow_rpm)
> +		pm_runtime_get_noresume(port->dev);
> +
>  	pm_runtime_mark_last_busy(port->dev);
>  	pm_runtime_put_autosuspend(port->dev);
>  	return 0;
> @@ -760,6 +766,10 @@ static void omap_8250_shutdown(struct uart_port *port)
>  		serial_out(up, UART_LCR, up->lcr & ~UART_LCR_SBC);
>  	serial_out(up, UART_FCR, UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
>  
> +	/* Clear possible PM runtime block to pair with startup */
> +	if (!priv->allow_rpm)
> +		pm_runtime_put_noidle(port->dev);
> +
>  	pm_runtime_mark_last_busy(port->dev);
>  	pm_runtime_put_autosuspend(port->dev);
>  	free_irq(port->irq, port);

Johan

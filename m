Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F21247BB2A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 08:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbhLUHeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 02:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbhLUHet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 02:34:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F9FC061574;
        Mon, 20 Dec 2021 23:34:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD799B80F79;
        Tue, 21 Dec 2021 07:34:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83D8C36AE2;
        Tue, 21 Dec 2021 07:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640072086;
        bh=dsSQbAT1V4+2QpbUbARv7dXxnQ6C8Kb0uF8C7BfJ+08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d5cxkQ3tSPDMhdbJUR0SRb5m++JZlNF3uNA9QpyyfhrG35K37kwIlktQe5cMCCK5w
         HIalXPRJyNXojT6zjtJulQ8Zae9F6UKVIkNV5cAOHSUTgsSOH/0E+PyIncU2VrVLGh
         YpZ6UPlkvIIBW4EztidU15mOLNksZ5QmrvVcm42I=
Date:   Tue, 21 Dec 2021 08:34:43 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yu Tu <yu.tu@amlogic.com>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 3/3] tty: serial: meson: add UART driver compatible with
 S4 SoC on-chip
Message-ID: <YcGDk3eC3sIstYjs@kroah.com>
References: <20211221071634.25980-1-yu.tu@amlogic.com>
 <20211221071634.25980-4-yu.tu@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221071634.25980-4-yu.tu@amlogic.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 03:16:34PM +0800, Yu Tu wrote:
> The S4 SoC on-chip UART uses a 12M clock as the clock source for
> calculating the baud rate of the UART. But previously, chips used 24M or
> other clock sources. So add this change. The specific clock source is
> determined by chip design.
> 
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---
>  drivers/tty/serial/meson_uart.c | 62 +++++++++++++++++++++++++++++----
>  1 file changed, 55 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 69450a461c48..557c24d954a2 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -19,6 +19,7 @@
>  #include <linux/serial_core.h>
>  #include <linux/tty.h>
>  #include <linux/tty_flip.h>
> +#include <linux/of_device.h>
>  
>  /* Register offsets */
>  #define AML_UART_WFIFO			0x00
> @@ -68,6 +69,8 @@
>  #define AML_UART_BAUD_MASK		0x7fffff
>  #define AML_UART_BAUD_USE		BIT(23)
>  #define AML_UART_BAUD_XTAL		BIT(24)
> +#define AML_UART_BAUD_XTAL_TICK		BIT(26)
> +#define AML_UART_BAUD_XTAL_DIV2		BIT(27)
>  
>  #define AML_UART_PORT_NUM		12
>  #define AML_UART_PORT_OFFSET		6
> @@ -80,6 +83,11 @@ static struct uart_driver meson_uart_driver;
>  
>  static struct uart_port *meson_ports[AML_UART_PORT_NUM];
>  
> +struct meson_uart_data {
> +	/*A clock source that calculates baud rates*/

Please use spaces in your comments.

> +	unsigned int xtal_tick_en;

What is "_en" for?

"enabled"?

Spell it out please.

And why an unsigned int for a boolean flag?

> +};
> +
>  static void meson_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
>  {
>  }
> @@ -294,16 +302,29 @@ static int meson_uart_startup(struct uart_port *port)
>  
>  static void meson_uart_change_speed(struct uart_port *port, unsigned long baud)
>  {
> +	struct meson_uart_data *uart_data = port->private_data;
>  	u32 val;
>  
>  	while (!meson_uart_tx_empty(port))
>  		cpu_relax();
>  
> +	val = readl_relaxed(port->membase + AML_UART_REG5);
> +	val &= ~AML_UART_BAUD_MASK;
> +
>  	if (port->uartclk == 24000000) {
> -		val = ((port->uartclk / 3) / baud) - 1;
> -		val |= AML_UART_BAUD_XTAL;
> +		if (uart_data->xtal_tick_en) {
> +			val = (port->uartclk / 2 + baud / 2) / baud  - 1;
> +			val |= (AML_UART_BAUD_XTAL | AML_UART_BAUD_XTAL_DIV2);
> +		} else {
> +			val = ((port->uartclk / 3) + baud / 2) / baud  - 1;
> +			val &= (~(AML_UART_BAUD_XTAL_TICK |
> +				AML_UART_BAUD_XTAL_DIV2));
> +			val |= AML_UART_BAUD_XTAL;
> +		}
>  	} else {
>  		val = ((port->uartclk * 10 / (baud * 4) + 5) / 10) - 1;
> +		val &= (~(AML_UART_BAUD_XTAL | AML_UART_BAUD_XTAL_TICK |
> +			AML_UART_BAUD_XTAL_DIV2));
>  	}
>  	val |= AML_UART_BAUD_USE;
>  	writel(val, port->membase + AML_UART_REG5);
> @@ -714,6 +735,7 @@ static int meson_uart_probe(struct platform_device *pdev)
>  {
>  	struct resource *res_mem, *res_irq;
>  	struct uart_port *port;
> +	struct meson_uart_data *uart_data;
>  	int ret = 0;
>  	int id = -1;
>  
> @@ -729,6 +751,10 @@ static int meson_uart_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	uart_data = of_device_get_match_data(&pdev->dev);
> +	if (!uart_data)
> +		return  -EINVAL;

Wrong spacing.

Always use checkpatch.pl on your patches before sending them out.

And did you just break existing systems?  Do you know if all older ones
will still work with that call?

> +
>  	if (pdev->id < 0 || pdev->id >= AML_UART_PORT_NUM)
>  		return -EINVAL;
>  
> @@ -770,6 +796,7 @@ static int meson_uart_probe(struct platform_device *pdev)
>  	port->x_char = 0;
>  	port->ops = &meson_uart_ops;
>  	port->fifosize = 64;
> +	port->private_data = uart_data;
>  
>  	meson_ports[pdev->id] = port;
>  	platform_set_drvdata(pdev, port);
> @@ -798,14 +825,35 @@ static int meson_uart_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct meson_uart_data meson_uart_data = {
> +	.xtal_tick_en = 0,
> +};
> +
> +static const struct meson_uart_data s4_meson_uart_data = {
> +	.xtal_tick_en = 1,
> +};

As your whole structure just has one bit, why not just use that as the
data value, instead of a structure?  No need to be complex here at all.

thanks,

greg k-h

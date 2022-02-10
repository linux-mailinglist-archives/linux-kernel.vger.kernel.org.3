Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AFA4B075E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 08:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbiBJHkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 02:40:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbiBJHko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 02:40:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A60C5A;
        Wed,  9 Feb 2022 23:40:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CBE961BAC;
        Thu, 10 Feb 2022 07:40:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138DCC004E1;
        Thu, 10 Feb 2022 07:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644478844;
        bh=N8/bXTmvWY7W+wVw+ygNVKaot4xb1H7ai8HRw78A9YQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wr9iaSYKDze12KSvH+58tFW6xNQOBvBlJaBUaBfC1TGzuJiKEY2exs+gXUlxUM/MY
         FrrSAXChq1k1wFXB2Jip2PXCmlfCjRKrSHT9LlJNvOQ8RhGMv+oVuB41k+Uir/l+T/
         1TXK2CHKx5mLeoALUH8qRvKL0c7qBpRJRs4FhthM=
Date:   Thu, 10 Feb 2022 08:40:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Konstantin Aladyshev <aladyshev22@gmail.com>,
        Oskar Senft <osk@google.com>, openbmc@lists.ozlabs.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_aspeed_vuart: add PORT_ASPEED_VUART port
 type
Message-ID: <YgTBennInxX3fE3X@kroah.com>
References: <20220209203414.23491-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209203414.23491-1-zev@bewilderbeest.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 12:34:14PM -0800, Zev Weiss wrote:
> Commit 54da3e381c2b ("serial: 8250_aspeed_vuart: use UPF_IOREMAP to
> set up register mapping") fixed a bug that had, as a side-effect,
> prevented the 8250_aspeed_vuart driver from enabling the VUART's
> FIFOs.  However, fixing that (and hence enabling the FIFOs) has in
> turn revealed what appears to be a hardware bug in the ASPEED VUART in
> which the host-side THRE bit doesn't get if the BMC-side receive FIFO
> trigger level is set to anything but one byte.  This causes problems
> for polled-mode writes from the host -- for example, Linux kernel
> console writes proceed at a glacial pace (less than 100 bytes per
> second) because the write path waits for a 10ms timeout to expire
> after every character instead of being able to continue on to the next
> character upon seeing THRE asserted.  (GRUB behaves similarly.)
> 
> As a workaround, introduce a new port type for the ASPEED VUART that's
> identical to PORT_16550A as it had previously been using, but with
> UART_FCR_R_TRIG_00 instead to set the receive FIFO trigger level to
> one byte, which (experimentally) seems to avoid the problematic THRE
> behavior.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> Tested-by: Konstantin Aladyshev <aladyshev22@gmail.com>

Do we need a "Fixes:" tag here as well?

> ---
>  drivers/tty/serial/8250/8250_aspeed_vuart.c | 2 +-
>  drivers/tty/serial/8250/8250_port.c         | 8 ++++++++
>  include/uapi/linux/serial_core.h            | 3 +++
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> index 2350fb3bb5e4..c2cecc6f47db 100644
> --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
> +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> @@ -487,7 +487,7 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
>  	port.port.irq = irq_of_parse_and_map(np, 0);
>  	port.port.handle_irq = aspeed_vuart_handle_irq;
>  	port.port.iotype = UPIO_MEM;
> -	port.port.type = PORT_16550A;
> +	port.port.type = PORT_ASPEED_VUART;
>  	port.port.uartclk = clk;
>  	port.port.flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP
>  		| UPF_FIXED_PORT | UPF_FIXED_TYPE | UPF_NO_THRE_TEST;
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 3b12bfc1ed67..973870ebff69 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -307,6 +307,14 @@ static const struct serial8250_config uart_config[] = {
>  		.rxtrig_bytes	= {1, 32, 64, 112},
>  		.flags		= UART_CAP_FIFO | UART_CAP_SLEEP,
>  	},
> +	[PORT_ASPEED_VUART] = {
> +		.name		= "ASPEED VUART",
> +		.fifo_size	= 16,
> +		.tx_loadsz	= 16,
> +		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_00,
> +		.rxtrig_bytes	= {1, 4, 8, 14},
> +		.flags		= UART_CAP_FIFO,
> +	},
>  };
>  
>  /* Uart divisor latch read */
> diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
> index c4042dcfdc0c..cd11748833e6 100644
> --- a/include/uapi/linux/serial_core.h
> +++ b/include/uapi/linux/serial_core.h
> @@ -274,4 +274,7 @@
>  /* Freescale LINFlexD UART */
>  #define PORT_LINFLEXUART	122
>  
> +/* ASPEED AST2x00 virtual UART */
> +#define PORT_ASPEED_VUART	123

Why does this value have to be in a uapi header file?  What userspace
tool is going to need this?

thanks,

greg k-h

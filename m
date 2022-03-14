Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21764D7FBE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 11:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238495AbiCNKZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 06:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238450AbiCNKZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 06:25:16 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C973ED32;
        Mon, 14 Mar 2022 03:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647253447; x=1678789447;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+1uZ+2Uca9d4Bi+1Q6hEFqLMXDAGlGvlP/r2E4UXo/E=;
  b=MlVc2U7dctugiRGyE7bDRtCfZoYCSJsVZI3l4ggYgyXT0YlbT+nKWyMe
   1ofhI9zbU9ueIh6gXKnoVpy+HE8Pg8MkFunbzRzIQ6CzPnV9Mt+e0i9/L
   gpMajUF7gDyLLKLmrn5h3Tz1H8NJE3Pkiz3bsoxhROV8Xd2z8VY2OxyJ6
   M+3WioaKn9t/J5sEPXbuTdu7wmC90BhC3WQQeNzFZaGXnt8IcyZ1Iq7Na
   3VtaI8bjfM01cVYcDiLice0IdxGr2Uz5cvFEoZsXi9PaieUR6E+k/oExU
   VyGP6VpM3IK/3/u2+ZVKIZi0j/A5M03mi3izRKdDoyrD9WxKi7RFxUEP0
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="342414047"
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; 
   d="scan'208";a="342414047"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 03:24:06 -0700
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; 
   d="scan'208";a="497554982"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 03:24:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nThrH-00H9Xc-2X;
        Mon, 14 Mar 2022 12:23:23 +0200
Date:   Mon, 14 Mar 2022 12:23:22 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lukas Wunner <lukas@wunner.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Gilles Buloz <gilles.buloz@kontron.com>
Subject: Re: [PATCH 1/1] serial: 8250: fix XOFF/XON sending when DMA is used
Message-ID: <Yi8XmuHoxSQKQ92u@smile.fi.intel.com>
References: <20220314091432.4288-1-ilpo.jarvinen@linux.intel.com>
 <20220314091432.4288-2-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220314091432.4288-2-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 11:14:32AM +0200, Ilpo Järvinen wrote:
> When 8250 UART is using DMA, x_char (XON/XOFF) is never sent
> to the wire. After this change, x_char is injected correctly.
> 
> Create uart_xchar_out() helper for sending the x_char out and
> accounting related to it. It seems that almost every driver
> does these same steps with x_char. Except for 8250, however,
> almost all currently lack .serial_out so they cannot immediately
> take advantage of this new helper.
> 
> The downside of this patch is that it might reintroduce
> the problems some devices faced with mixed DMA/non-DMA transfer
> which caused revert f967fc8f165f (Revert "serial: 8250_dma:
> don't bother DMA with small transfers"). However, the impact
> should be limited to cases with XON/XOFF (that didn't work
> with DMA capable devices to begin with so this problem is not
> very likely to cause a major issue, if any at all).

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
One nit=pick below.

> Reported-by: Gilles Buloz <gilles.buloz@kontron.com>
> Tested-by: Gilles Buloz <gilles.buloz@kontron.com>
> Fixes: 9ee4b83e51f74 ("serial: 8250: Add support for dmaengine")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_dma.c  | 11 ++++++++++-
>  drivers/tty/serial/8250/8250_port.c |  4 +---
>  drivers/tty/serial/serial_core.c    | 14 ++++++++++++++
>  include/linux/serial_core.h         |  2 ++
>  4 files changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
> index 890fa7ddaa7f..b3c3f7e5851a 100644
> --- a/drivers/tty/serial/8250/8250_dma.c
> +++ b/drivers/tty/serial/8250/8250_dma.c
> @@ -64,10 +64,19 @@ int serial8250_tx_dma(struct uart_8250_port *p)
>  	struct uart_8250_dma		*dma = p->dma;
>  	struct circ_buf			*xmit = &p->port.state->xmit;
>  	struct dma_async_tx_descriptor	*desc;
> +	struct uart_port		*up = &p->port;
>  	int ret;
>  
> -	if (dma->tx_running)
> +	if (dma->tx_running) {
> +		if (up->x_char) {
> +			dmaengine_pause(dma->txchan);
> +			uart_xchar_out(up, UART_TX);
> +			dmaengine_resume(dma->txchan);
> +		}
>  		return 0;
> +	} else if (up->x_char) {
> +		uart_xchar_out(up, UART_TX);
> +	}

This can be written as

	if (dma->tx_running) {
		...
		return 0;
	}

	if (up->x_char)
		uart_xchar_out(up, UART_TX);

But I'm fine with the original code (it might make sense to have redundant
'else' just to keep xON/xOFF handling grouped).

>  	if (uart_tx_stopped(&p->port) || uart_circ_empty(xmit)) {
>  		/* We have been called from __dma_tx_complete() */
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 3b12bfc1ed67..63e9bc6fce06 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1799,9 +1799,7 @@ void serial8250_tx_chars(struct uart_8250_port *up)
>  	int count;
>  
>  	if (port->x_char) {
> -		serial_out(up, UART_TX, port->x_char);
> -		port->icount.tx++;
> -		port->x_char = 0;
> +		uart_xchar_out(port, UART_TX);
>  		return;
>  	}
>  	if (uart_tx_stopped(port)) {
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 0db90be4c3bc..f67540ae2a88 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -644,6 +644,20 @@ static void uart_flush_buffer(struct tty_struct *tty)
>  	tty_port_tty_wakeup(&state->port);
>  }
>  
> +/*
> + * This function performs low-level write of high-priority XON/XOFF
> + * character and accounting for it.
> + *
> + * Requires uart_port to implement .serial_out().
> + */
> +void uart_xchar_out(struct uart_port *uport, int offset)
> +{
> +	serial_port_out(uport, offset, uport->x_char);
> +	uport->icount.tx++;
> +	uport->x_char = 0;
> +}
> +EXPORT_SYMBOL_GPL(uart_xchar_out);
> +
>  /*
>   * This function is used to send a high-priority XON/XOFF character to
>   * the device
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index c58cc142d23f..8c32935e1059 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -458,6 +458,8 @@ extern void uart_handle_cts_change(struct uart_port *uport,
>  extern void uart_insert_char(struct uart_port *port, unsigned int status,
>  		 unsigned int overrun, unsigned int ch, unsigned int flag);
>  
> +void uart_xchar_out(struct uart_port *uport, int offset);
> +
>  #ifdef CONFIG_MAGIC_SYSRQ_SERIAL
>  #define SYSRQ_TIMEOUT	(HZ * 5)
>  
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko



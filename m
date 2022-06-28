Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD7755C86F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243816AbiF1KXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 06:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239377AbiF1KXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:23:40 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3112FFC4;
        Tue, 28 Jun 2022 03:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656411819; x=1687947819;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wRjPbVKWB0JV41bfLywdOItEg7b3njNAAl1ELy2fXAI=;
  b=Gf7tnnPZc8e2pQpRQezdDGgNWN2joVeTpG9jCltYG7hOdcEso13SjfbJ
   rkMLJ0UOeU2OJakVLtcD8WGdx/UuHh3JeRDvxlv5R2PnO3Al2mbPI7YKI
   q/0VnEBM5Ad1ilbOcjd75iaRIsJA/n37MbzlEUHRZkqgToFTSmPIZ8RTt
   2xixhTsuHeJ0cP9kgIOV7cESRD+cWNZPrwsDcfgklY3WX5hmGbLpfiHM5
   c1Ye+E5wAh8oHdbFJofgnary0Yy50m5o5cGIcmmJiFoBXz4KVP4Y+siMN
   nu4Cl1hsF7JMRB/hp5CJbXcxNVd9G1XUfloNAXRuKfBxC3UEgOI+joNRR
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="280462650"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="280462650"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 03:23:39 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="646855987"
Received: from iannetti-mobl.ger.corp.intel.com ([10.251.216.215])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 03:23:37 -0700
Date:   Tue, 28 Jun 2022 13:23:34 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali@kernel.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Allen Yan <yanwei@marvell.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: mvebu-uart: correctly report configured baudrate
 value
In-Reply-To: <20220628100922.10717-1-pali@kernel.org>
Message-ID: <ac5fe14-2cee-ec1a-eb9a-5a38e273737d@linux.intel.com>
References: <20220628100922.10717-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-888930425-1656411819=:1603"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-888930425-1656411819=:1603
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 28 Jun 2022, Pali Rohár wrote:

> Functions tty_termios_encode_baud_rate() and uart_update_timeout() should
> be called with the baudrate value which was set to hardware. Linux then
> report exact values via ioctl(TCGETS2) to userspace.
> 
> Change mvebu_uart_baud_rate_set() function to return baudrate value which
> was set to hardware and propagate this value to above mentioned functions.
> 
> With this change userspace would see precise value in termios c_ospeed
> field.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Fixes: 68a0db1d7da2 ("serial: mvebu-uart: add function to change baudrate")

Look better than my patch covering cases I didn't even realize
existed. Thanks.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.


> ---
>  drivers/tty/serial/mvebu-uart.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
> index 0429c2a54290..93489fe334d0 100644
> --- a/drivers/tty/serial/mvebu-uart.c
> +++ b/drivers/tty/serial/mvebu-uart.c
> @@ -470,14 +470,14 @@ static void mvebu_uart_shutdown(struct uart_port *port)
>  	}
>  }
>  
> -static int mvebu_uart_baud_rate_set(struct uart_port *port, unsigned int baud)
> +static unsigned int mvebu_uart_baud_rate_set(struct uart_port *port, unsigned int baud)
>  {
>  	unsigned int d_divisor, m_divisor;
>  	unsigned long flags;
>  	u32 brdv, osamp;
>  
>  	if (!port->uartclk)
> -		return -EOPNOTSUPP;
> +		return 0;
>  
>  	/*
>  	 * The baudrate is derived from the UART clock thanks to divisors:
> @@ -548,7 +548,7 @@ static int mvebu_uart_baud_rate_set(struct uart_port *port, unsigned int baud)
>  			(m_divisor << 16) | (m_divisor << 24);
>  	writel(osamp, port->membase + UART_OSAMP);
>  
> -	return 0;
> +	return DIV_ROUND_CLOSEST(port->uartclk, d_divisor * m_divisor);
>  }
>  
>  static void mvebu_uart_set_termios(struct uart_port *port,
> @@ -587,15 +587,11 @@ static void mvebu_uart_set_termios(struct uart_port *port,
>  	max_baud = port->uartclk / 80;
>  
>  	baud = uart_get_baud_rate(port, termios, old, min_baud, max_baud);
> -	if (mvebu_uart_baud_rate_set(port, baud)) {
> -		/* No clock available, baudrate cannot be changed */
> -		if (old)
> -			baud = uart_get_baud_rate(port, old, NULL,
> -						  min_baud, max_baud);
> -	} else {
> -		tty_termios_encode_baud_rate(termios, baud, baud);
> -		uart_update_timeout(port, termios->c_cflag, baud);
> -	}
> +	baud = mvebu_uart_baud_rate_set(port, baud);
> +
> +	/* In case baudrate cannot be changed, report previous old value */
> +	if (baud == 0 && old)
> +		baud = tty_termios_baud_rate(old);
>  
>  	/* Only the following flag changes are supported */
>  	if (old) {
> @@ -606,6 +602,11 @@ static void mvebu_uart_set_termios(struct uart_port *port,
>  		termios->c_cflag |= CS8;
>  	}
>  
> +	if (baud != 0) {
> +		tty_termios_encode_baud_rate(termios, baud, baud);
> +		uart_update_timeout(port, termios->c_cflag, baud);
> +	}
> +
>  	spin_unlock_irqrestore(&port->lock, flags);
>  }
>  
> 

--8323329-888930425-1656411819=:1603--

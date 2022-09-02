Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FA35AB481
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbiIBO51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236615AbiIBO4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:56:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645E5C04E0;
        Fri,  2 Sep 2022 07:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662128480; x=1693664480;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6f+huALnahss6lYz0y0UEQS8/UevmtS+kT7aaSrmY2Q=;
  b=hE/J+V0ofI5Raoy4pZTztHoHVFL9zpd/GF0mQDGgYlyEndnOoFGON1KG
   EpF91m1YRMowzsyQO8O+PO4qBQKvbAbk88xTIzRC5S+hhTeemUvgB4a5r
   Q6LI8TGaXR8Vkd0AlHKB9D9RfFVMD4NjowbLAo6nzLDW8ZvGDoxaZHOgP
   QeKj0A9ElK4bq/sXxdM7+kiMqKrK8DLscLtkMUprsdtfewCAiLzV95Rdb
   ub4lZHllbs951O+rITT6DBasK1UObq9fsqGGqUr3goS11vITRCbzaqwl+
   AVA4WHlPLcx+ugtTxjMTjrKTSH6pZ0MHMhayHaXP34tY5vrFObNmomwIL
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="276391223"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="276391223"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 07:21:20 -0700
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="674369533"
Received: from vbykovni-mobl.ger.corp.intel.com ([10.252.53.17])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 07:21:15 -0700
Date:   Fri, 2 Sep 2022 17:21:14 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tobias Klauser <tklauser@distanz.ch>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?ISO-8859-15?Q?Andreas_F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v2 2/3] tty: serial: use DEFINE_UART_PORT_TX_HELPER()
In-Reply-To: <20220901110657.3305-3-jslaby@suse.cz>
Message-ID: <89b44cd-6550-32b2-9bd-ae8dde6b48cd@linux.intel.com>
References: <20220901110657.3305-1-jslaby@suse.cz> <20220901110657.3305-3-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1885109871-1662128480=:1647"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

--8323329-1885109871-1662128480=:1647
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 1 Sep 2022, Jiri Slaby wrote:

> DEFINE_UART_PORT_TX_HELPER() is a new helper to send characters to the
> device. Use it in these drivers.
> 
> Cc: Tobias Klauser <tklauser@distanz.ch>
> Cc: Richard Genoud <richard.genoud@gmail.com>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
> Cc: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: "Andreas Färber" <afaerber@suse.de>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---

> diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
> index 3f1986c89694..944686a0d00d 100644
> --- a/drivers/tty/serial/mpc52xx_uart.c
> +++ b/drivers/tty/serial/mpc52xx_uart.c
> @@ -1338,7 +1338,6 @@ mpc52xx_uart_verify_port(struct uart_port *port, struct serial_struct *ser)
>  	return 0;
>  }
>  
> -
>  static const struct uart_ops mpc52xx_uart_ops = {
>  	.tx_empty	= mpc52xx_uart_tx_empty,
>  	.set_mctrl	= mpc52xx_uart_set_mctrl,

Stray change.

> diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
> index e64e42a19d1a..738f4b20cb8e 100644
> --- a/drivers/tty/serial/sa1100.c
> +++ b/drivers/tty/serial/sa1100.c
> @@ -226,45 +226,34 @@ sa1100_rx_chars(struct sa1100_port *sport)
>  	tty_flip_buffer_push(&sport->port.state->port);
>  }
>  
> -static void sa1100_tx_chars(struct sa1100_port *sport)
> +static bool sa1100_tx_ready(struct uart_port *port)
>  {
> -	struct circ_buf *xmit = &sport->port.state->xmit;
> +	struct sa1100_port *sport =
> +		container_of(port, struct sa1100_port, port);
>  
> -	if (sport->port.x_char) {
> -		UART_PUT_CHAR(sport, sport->port.x_char);
> -		sport->port.icount.tx++;
> -		sport->port.x_char = 0;
> -		return;
> -	}
> +	return UART_GET_UTSR1(sport) & UTSR1_TNF;
> +}
> +
> +static void sa1100_put_char(struct uart_port *port, unsigned char ch)
> +{
> +	struct sa1100_port *sport =
> +		container_of(port, struct sa1100_port, port);
> +
> +	UART_PUT_CHAR(sport, ch);
> +}

Perhaps not to add into this change itself, but I just point out these 
would be useful in addition to what is changed:
	- Get rid of UART_PUT_CHAR()
	- sa1100_console_putchar() could use sa1100_tx_ready()

> diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
> index 6f08136ce78a..ff430a1cc3a2 100644
> --- a/drivers/tty/serial/vt8500_serial.c
> +++ b/drivers/tty/serial/vt8500_serial.c
> @@ -187,37 +187,17 @@ static void handle_rx(struct uart_port *port)
>  	tty_flip_buffer_push(tport);
>  }
>  
> -static void handle_tx(struct uart_port *port)
> +static unsigned int vt8500_tx_empty(struct uart_port *port)
>  {
> -	struct circ_buf *xmit = &port->state->xmit;
> -
> -	if (port->x_char) {
> -		writeb(port->x_char, port->membase + VT8500_TXFIFO);
> -		port->icount.tx++;
> -		port->x_char = 0;
> -	}
> -	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
> -		vt8500_stop_tx(port);
> -		return;
> -	}
> +	unsigned int idx = vt8500_read(port, VT8500_URFIDX) & 0x1f;
>  
> -	while ((vt8500_read(port, VT8500_URFIDX) & 0x1f) < 16) {
> -		if (uart_circ_empty(xmit))
> -			break;
> -
> -		writeb(xmit->buf[xmit->tail], port->membase + VT8500_TXFIFO);
> -
> -		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> -		port->icount.tx++;
> -	}
> -
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> -		uart_write_wakeup(port);
> -
> -	if (uart_circ_empty(xmit))
> -		vt8500_stop_tx(port);
> +	return idx < 16 ? TIOCSER_TEMT : 0;
>  }

So there's just plain move and re-layouting of existing vt8500_tx_empty() 
embedded here. Why not do it in a separate change beforehand?

I discovered this the hard way, that is, I started to look why tx on 
earth "FIFO index" < 16 should be called "tx empty", if it would be a 
separate change it would have been immediately obvious that it was a 
pre-existing thing.

> +static DEFINE_UART_PORT_TX_HELPER(handle_tx, port, ch,
> +		vt8500_tx_empty(port),
> +		writeb(ch, port->membase + VT8500_TXFIFO));
> +
>  static void vt8500_start_tx(struct uart_port *port)
>  {
>  	struct vt8500_port *vt8500_port = container_of(port,
> @@ -260,12 +240,6 @@ static irqreturn_t vt8500_irq(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> -static unsigned int vt8500_tx_empty(struct uart_port *port)
> -{
> -	return (vt8500_read(port, VT8500_URFIDX) & 0x1f) < 16 ?
> -						TIOCSER_TEMT : 0;
> -}
> -
>  static unsigned int vt8500_get_mctrl(struct uart_port *port)
>  {
>  	unsigned int usr;
> 

-- 
 i.

--8323329-1885109871-1662128480=:1647--

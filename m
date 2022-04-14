Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4C2501951
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbiDNRAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344369AbiDNQ6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 12:58:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313DC9F6C0;
        Thu, 14 Apr 2022 09:32:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA54E61FEC;
        Thu, 14 Apr 2022 16:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D21C385A5;
        Thu, 14 Apr 2022 16:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649953930;
        bh=hdd96lwHARk1y0gyMqVXzjjCx4Up+g8Yw/n6h7HFY3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IG4XPTR2iiuTGA251zdre+MOrTvjCrVug0OvyEp6FVKof3sR3O3ByMLfvjQQdhjWq
         bfdrSGZCs2KpTH6uBNSZ/qRYjudyTgtpwUIjrLptb8vsx+3TJ+5ADIZMKq3rFDwNUa
         yZWfDalboZu1KwfcOMfqbB490COqxZXT5vrJ//n4=
Date:   Thu, 14 Apr 2022 18:32:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] tty: serial: introduce uart_port_tx{,_limit}()
 helpers
Message-ID: <YlhMhy9FhK0j3MId@kroah.com>
References: <20220411105405.9519-1-jslaby@suse.cz>
 <20220411105405.9519-2-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411105405.9519-2-jslaby@suse.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 12:54:03PM +0200, Jiri Slaby wrote:
> Many serial drivers do the same thing:
> * send x_char if set
> * keep sending from the xmit circular buffer until either
>   - the loop reaches the end of the xmit buffer
>   - TX is stopped
>   - HW fifo is full
> * check for pending characters and:
>   - wake up tty writers to fill for more data into xmit buffer
>   - stop TX if there is nothing in the xmit buffer
> 
> The only differences are:
> * how to write the character to the HW fifo
> * the check of the end condition:
>   - is the HW fifo full?
>   - is limit of the written characters reached?
> 
> So unify the above into two helpers:
> * uart_port_tx_limit() -- the generic one, it performs the above taking
>   into account the written characters limit
> * uart_port_tx() -- calls the above with ~0 as the limit. So it only
>   checks the HW fullness.
> 
> We need three more hooks in struct uart_ops for all this to work:
> * tx_ready() -- returns true if HW can accept more data.
> * put_char() -- write a character to the device.
> * tx_done() -- when the write loop is done, perform arbitrary action
>   before potential invocation of ops->stop_tx() happens.
> 
> NOTE1: Maybe the three hooks in uart_ops above are overkill. We can
> instead pass pointers to the three functions directly to the new helpers
> as they are not used elsewhere. Similar to uart_console_write() and its
> putchar().
> 
> NOTE2: These two new helper functions call the hooks per every character
> processed. I was unable to measure any difference, provided most time is
> spent by readb (or alike) in the hooks themselves.  First, LTO might
> help to eliminate these explicit calls (we might need NOTE1 to be
> implemented for this to be true). Second, if this turns out to be a
> problem, we can introduce a macro to build the helper in the driver's
> code instead of serial_core. That is, similar to wait_event().
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
>  Documentation/driver-api/serial/driver.rst | 28 ++++++++++++
>  drivers/tty/serial/serial_core.c           | 53 ++++++++++++++++++++++
>  include/linux/serial_core.h                |  9 ++++
>  3 files changed, 90 insertions(+)
> 
> diff --git a/Documentation/driver-api/serial/driver.rst b/Documentation/driver-api/serial/driver.rst
> index 06ec04ba086f..7dc3791addeb 100644
> --- a/Documentation/driver-api/serial/driver.rst
> +++ b/Documentation/driver-api/serial/driver.rst
> @@ -80,6 +80,34 @@ hardware.
>  
>  	This call must not sleep
>  
> +  tx_ready(port)
> +	The driver returns true if the HW can accept more data to be sent.
> +
> +	Locking: port->lock taken.
> +
> +	Interrupts: locally disabled.
> +
> +	This call must not sleep.
> +
> +  put_char(port, ch)
> +	The driver is asked to write ch to the device.
> +
> +	Locking: port->lock taken.
> +
> +	Interrupts: locally disabled.
> +
> +	This call must not sleep.
> +
> +  tx_done(port)
> +	When the write loop is done, the driver can perform arbitrary action
> +	here before potential invocation of ops->stop_tx() happens.
> +
> +	Locking: port->lock taken.
> +
> +	Interrupts: locally disabled.
> +
> +	This call must not sleep.
> +
>    set_mctrl(port, mctrl)
>  	This function sets the modem control lines for port described
>  	by 'port' to the state described by mctrl.  The relevant bits
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 6a8963caf954..1be14e90066c 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -107,6 +107,59 @@ void uart_write_wakeup(struct uart_port *port)
>  }
>  EXPORT_SYMBOL(uart_write_wakeup);
>  
> +static bool uart_port_tx_always_ready(struct uart_port *port)
> +{
> +	return true;
> +}
> +
> +/**
> + * uart_port_tx_limit -- transmit helper for uart_port
> + * @port: from which port to transmit
> + * @count: limit count
> + *
> + * uart_port_tx_limit() transmits characters from the xmit buffer to the
> + * hardware using @uart_port::ops::put_char(). It does so until @count
> + * characters are sent and while @uart_port::ops::tx_ready() still returns
> + * non-zero (if non-NULL).
> + *
> + * Return: number of characters in the xmit buffer when done.
> + */
> +unsigned int uart_port_tx_limit(struct uart_port *port, unsigned int count)
> +{
> +	struct circ_buf *xmit = &port->state->xmit;
> +	bool (*tx_ready)(struct uart_port *) = port->ops->tx_ready ? :
> +		uart_port_tx_always_ready;
> +	unsigned int pending;
> +
> +	for (; count && tx_ready(port); count--, port->icount.tx++) {
> +		if (port->x_char) {
> +			port->ops->put_char(port, port->x_char);
> +			port->x_char = 0;
> +			continue;
> +		}
> +
> +		if (uart_circ_empty(xmit) || uart_tx_stopped(port))
> +			break;
> +
> +		port->ops->put_char(port, xmit->buf[xmit->tail]);

That's a lot of redirection and function pointer mess per each character
sent now.  With the spectre overhead here (and only getting worse), this
feels like a step backwards.

I doubt throughput matters here given cpu speeds now, _but_ the cpu load
should go up.

Although on smaller cpus with slower Mhz and faster line rates, this
feels like a lot of extra work happening for no real good reason.

Any benchmarks?

thanks,

greg k-h

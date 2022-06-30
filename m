Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32C156152E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbiF3Ifs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbiF3Ifp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:35:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0922252D;
        Thu, 30 Jun 2022 01:35:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61B6961F56;
        Thu, 30 Jun 2022 08:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619C5C34115;
        Thu, 30 Jun 2022 08:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656578143;
        bh=3F1iN2nIgI+xSO5HnpbJNEPxV7Bm8MUyryS/idZ1CIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fZKC6hAtSlEiL04R8OiibU+qu37mRcW/rthlpWCchSIZFuhtAjS24aYt4qOvBUTK5
         1qPInlDjyv23SROnIfW0sbHcsPkD4hiMnpKwg83LLgfz6WN63dwP+DVYKEBZvSPHzg
         8oblykiMqBfZW0u+VeMjqMLES0BAt4dDxyged/c85YcEZf9DSJFlLLgw11ox0GG/VN
         oQmGX/rkxCGwEGBPs/L5RIWxIjIoU0tY/Fg+eWb9NJORodp7q7MlkZ0u0WiACT0sy+
         KIZcZimiPTRszOknA9ffVpNaNvhB879wAIhSANF4KsJfxsfsGjNPzRo/fElRMcyOzG
         YissxZM8zgvEA==
Received: by pali.im (Postfix)
        id 8698D96E; Thu, 30 Jun 2022 10:35:40 +0200 (CEST)
Date:   Thu, 30 Jun 2022 10:35:40 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Allen Yan <yanwei@marvell.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: mvebu-uart: correctly report configured baudrate
 value
Message-ID: <20220630083540.azojxio2naixxkk3@pali>
References: <20220628100922.10717-1-pali@kernel.org>
 <ac5fe14-2cee-ec1a-eb9a-5a38e273737d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac5fe14-2cee-ec1a-eb9a-5a38e273737d@linux.intel.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 June 2022 13:23:34 Ilpo Järvinen wrote:
> On Tue, 28 Jun 2022, Pali Rohár wrote:
> 
> > Functions tty_termios_encode_baud_rate() and uart_update_timeout() should
> > be called with the baudrate value which was set to hardware. Linux then
> > report exact values via ioctl(TCGETS2) to userspace.
> > 
> > Change mvebu_uart_baud_rate_set() function to return baudrate value which
> > was set to hardware and propagate this value to above mentioned functions.
> > 
> > With this change userspace would see precise value in termios c_ospeed
> > field.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > Fixes: 68a0db1d7da2 ("serial: mvebu-uart: add function to change baudrate")
> 
> Look better than my patch covering cases I didn't even realize
> existed. Thanks.
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Thanks for review!

Now I now why I have not sent this patch earlier. This patch hit bug
described and fixed by commit "serial: core: Fix initializing and
restoring termios speed":
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=027b57170bf8bb6999a28e4a5f3d78bf1db0f90c

Above commit is already in master since v5.16 and IIRC it was also
backported to stable trees.

So applying and testing this patch should be fine also in old trees now.

> -- 
>  i.
> 
> 
> > ---
> >  drivers/tty/serial/mvebu-uart.c | 25 +++++++++++++------------
> >  1 file changed, 13 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
> > index 0429c2a54290..93489fe334d0 100644
> > --- a/drivers/tty/serial/mvebu-uart.c
> > +++ b/drivers/tty/serial/mvebu-uart.c
> > @@ -470,14 +470,14 @@ static void mvebu_uart_shutdown(struct uart_port *port)
> >  	}
> >  }
> >  
> > -static int mvebu_uart_baud_rate_set(struct uart_port *port, unsigned int baud)
> > +static unsigned int mvebu_uart_baud_rate_set(struct uart_port *port, unsigned int baud)
> >  {
> >  	unsigned int d_divisor, m_divisor;
> >  	unsigned long flags;
> >  	u32 brdv, osamp;
> >  
> >  	if (!port->uartclk)
> > -		return -EOPNOTSUPP;
> > +		return 0;
> >  
> >  	/*
> >  	 * The baudrate is derived from the UART clock thanks to divisors:
> > @@ -548,7 +548,7 @@ static int mvebu_uart_baud_rate_set(struct uart_port *port, unsigned int baud)
> >  			(m_divisor << 16) | (m_divisor << 24);
> >  	writel(osamp, port->membase + UART_OSAMP);
> >  
> > -	return 0;
> > +	return DIV_ROUND_CLOSEST(port->uartclk, d_divisor * m_divisor);
> >  }
> >  
> >  static void mvebu_uart_set_termios(struct uart_port *port,
> > @@ -587,15 +587,11 @@ static void mvebu_uart_set_termios(struct uart_port *port,
> >  	max_baud = port->uartclk / 80;
> >  
> >  	baud = uart_get_baud_rate(port, termios, old, min_baud, max_baud);
> > -	if (mvebu_uart_baud_rate_set(port, baud)) {
> > -		/* No clock available, baudrate cannot be changed */
> > -		if (old)
> > -			baud = uart_get_baud_rate(port, old, NULL,
> > -						  min_baud, max_baud);
> > -	} else {
> > -		tty_termios_encode_baud_rate(termios, baud, baud);
> > -		uart_update_timeout(port, termios->c_cflag, baud);
> > -	}
> > +	baud = mvebu_uart_baud_rate_set(port, baud);
> > +
> > +	/* In case baudrate cannot be changed, report previous old value */
> > +	if (baud == 0 && old)
> > +		baud = tty_termios_baud_rate(old);
> >  
> >  	/* Only the following flag changes are supported */
> >  	if (old) {
> > @@ -606,6 +602,11 @@ static void mvebu_uart_set_termios(struct uart_port *port,
> >  		termios->c_cflag |= CS8;
> >  	}
> >  
> > +	if (baud != 0) {
> > +		tty_termios_encode_baud_rate(termios, baud, baud);
> > +		uart_update_timeout(port, termios->c_cflag, baud);
> > +	}
> > +
> >  	spin_unlock_irqrestore(&port->lock, flags);
> >  }
> >  
> > 


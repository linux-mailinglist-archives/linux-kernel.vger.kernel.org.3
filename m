Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7614B0B41
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240062AbiBJKqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:46:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbiBJKqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:46:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63EEFF1;
        Thu, 10 Feb 2022 02:46:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93EF3B824B3;
        Thu, 10 Feb 2022 10:46:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAAC8C004E1;
        Thu, 10 Feb 2022 10:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644489972;
        bh=qhgOSNqzVwAgQEC+/Ughopou3AgvMKYhrHTrwnUjWFo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W4iUUfliBgRfgMb3+LAgt77ybKOcO8zcmnMp7YXwwzY8e2ldIwu+gZuQj4SyOCk0m
         +u+WSqYFt+URKQQUJQ1v2flcaSrGHdy0TGgBwv5T6kfaMXo8mWFH2lGxzVf+JtE+xc
         hLd/K/qM8dR02Z4k3bRl+LKOlbGx1P/hhKDs/bGg=
Date:   Thu, 10 Feb 2022 11:46:09 +0100
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
Message-ID: <YgTs8XNR6h34s0jc@kroah.com>
References: <20220209203414.23491-1-zev@bewilderbeest.net>
 <YgTBennInxX3fE3X@kroah.com>
 <YgTDm5qKUJyzciR2@hatter.bewilderbeest.net>
 <YgTKvIqTIOomFSsF@kroah.com>
 <YgTZQQuTkLjnkeyB@hatter.bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgTZQQuTkLjnkeyB@hatter.bewilderbeest.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 01:22:09AM -0800, Zev Weiss wrote:
> On Thu, Feb 10, 2022 at 12:20:12AM PST, Greg Kroah-Hartman wrote:
> > On Wed, Feb 09, 2022 at 11:49:47PM -0800, Zev Weiss wrote:
> > > On Wed, Feb 09, 2022 at 11:40:42PM PST, Greg Kroah-Hartman wrote:
> > > > On Wed, Feb 09, 2022 at 12:34:14PM -0800, Zev Weiss wrote:
> > > > > Commit 54da3e381c2b ("serial: 8250_aspeed_vuart: use UPF_IOREMAP to
> > > > > set up register mapping") fixed a bug that had, as a side-effect,
> > > > > prevented the 8250_aspeed_vuart driver from enabling the VUART's
> > > > > FIFOs.  However, fixing that (and hence enabling the FIFOs) has in
> > > > > turn revealed what appears to be a hardware bug in the ASPEED VUART in
> > > > > which the host-side THRE bit doesn't get if the BMC-side receive FIFO
> > > > > trigger level is set to anything but one byte.  This causes problems
> > > > > for polled-mode writes from the host -- for example, Linux kernel
> > > > > console writes proceed at a glacial pace (less than 100 bytes per
> > > > > second) because the write path waits for a 10ms timeout to expire
> > > > > after every character instead of being able to continue on to the next
> > > > > character upon seeing THRE asserted.  (GRUB behaves similarly.)
> > > > >
> > > > > As a workaround, introduce a new port type for the ASPEED VUART that's
> > > > > identical to PORT_16550A as it had previously been using, but with
> > > > > UART_FCR_R_TRIG_00 instead to set the receive FIFO trigger level to
> > > > > one byte, which (experimentally) seems to avoid the problematic THRE
> > > > > behavior.
> > > > >
> > > > > Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> > > > > Tested-by: Konstantin Aladyshev <aladyshev22@gmail.com>
> > > >
> > > > Do we need a "Fixes:" tag here as well?
> > > 
> > > I was wondering the same -- I left it out because it didn't seem like it was
> > > strictly a bug in the earlier commit that's really being fixed per se, but
> > > perhaps that's an overly pedantic distinction.  I can certainly add it if
> > > you'd prefer.
> > 
> > This obviously fixes an issue, if you don't have a specific commit that
> > caused it, a cc: stable@vger.kernel.org should be added so we know to
> > backport this to all stable kernels.
> > 
> 
> Okay -- well, I suppose it's a fix in the sense that if you have the earlier
> commit, you'll also want this one, so I'll add the tag.

Please do.

> > > > > ---
> > > > >  drivers/tty/serial/8250/8250_aspeed_vuart.c | 2 +-
> > > > >  drivers/tty/serial/8250/8250_port.c         | 8 ++++++++
> > > > >  include/uapi/linux/serial_core.h            | 3 +++
> > > > >  3 files changed, 12 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> > > > > index 2350fb3bb5e4..c2cecc6f47db 100644
> > > > > --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
> > > > > +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> > > > > @@ -487,7 +487,7 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
> > > > >  	port.port.irq = irq_of_parse_and_map(np, 0);
> > > > >  	port.port.handle_irq = aspeed_vuart_handle_irq;
> > > > >  	port.port.iotype = UPIO_MEM;
> > > > > -	port.port.type = PORT_16550A;
> > > > > +	port.port.type = PORT_ASPEED_VUART;
> > > > >  	port.port.uartclk = clk;
> > > > >  	port.port.flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP
> > > > >  		| UPF_FIXED_PORT | UPF_FIXED_TYPE | UPF_NO_THRE_TEST;
> > > > > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> > > > > index 3b12bfc1ed67..973870ebff69 100644
> > > > > --- a/drivers/tty/serial/8250/8250_port.c
> > > > > +++ b/drivers/tty/serial/8250/8250_port.c
> > > > > @@ -307,6 +307,14 @@ static const struct serial8250_config uart_config[] = {
> > > > >  		.rxtrig_bytes	= {1, 32, 64, 112},
> > > > >  		.flags		= UART_CAP_FIFO | UART_CAP_SLEEP,
> > > > >  	},
> > > > > +	[PORT_ASPEED_VUART] = {
> > > > > +		.name		= "ASPEED VUART",
> > > > > +		.fifo_size	= 16,
> > > > > +		.tx_loadsz	= 16,
> > > > > +		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_00,
> > > > > +		.rxtrig_bytes	= {1, 4, 8, 14},
> > > > > +		.flags		= UART_CAP_FIFO,
> > > > > +	},
> > > > >  };
> > > > >
> > > > >  /* Uart divisor latch read */
> > > > > diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
> > > > > index c4042dcfdc0c..cd11748833e6 100644
> > > > > --- a/include/uapi/linux/serial_core.h
> > > > > +++ b/include/uapi/linux/serial_core.h
> > > > > @@ -274,4 +274,7 @@
> > > > >  /* Freescale LINFlexD UART */
> > > > >  #define PORT_LINFLEXUART	122
> > > > >
> > > > > +/* ASPEED AST2x00 virtual UART */
> > > > > +#define PORT_ASPEED_VUART	123
> > > >
> > > > Why does this value have to be in a uapi header file?  What userspace
> > > > tool is going to need this?
> > > >
> > > 
> > > I only put it there because that was where all the other port type constants
> > > were defined, and wondered the same thing about the lot of them.  Is there a
> > > userspace tool that makes use of any of these?
> > 
> > Not really, please don't add it if you do not require it.
> > 
> 
> It seems like an odd inconsistency to put this one particular definition
> somewhere else when the other 100+ of its siblings are in the uapi header;
> would you want a preceding patch to move them all somewhere under
> include/linux?  (Which in turn doesn't really seem like a change for -stable
> I'd think.)
> 
> Though actually, on further investigation I see those constants are in fact
> exposed to userspace in struct serial_struct->type (via
> TIOCGSERIAL/TIOCSSERIAL), and via the 'type' sysfs attribute, so I'd think
> we'd probably want to keep them as they are?

One of these days I'll unwind this mess.  There should not be any need
to export this to userspace as userspace doesn't really care about it.

but for now, sure, keep it :(

thanks,

greg k-h

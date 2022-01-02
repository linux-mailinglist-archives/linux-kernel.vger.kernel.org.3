Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A84482C8C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 19:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiABS2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 13:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiABS2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 13:28:03 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A6CC061761;
        Sun,  2 Jan 2022 10:28:03 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 8BFDB100DECB3;
        Sun,  2 Jan 2022 19:28:01 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 697BF16E2A; Sun,  2 Jan 2022 19:28:01 +0100 (CET)
Date:   Sun, 2 Jan 2022 19:28:01 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     jmades <jochen@mades.net>, gregkh@linuxfoundation.org,
        Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philipp Rosenberger <p.rosenberger@kunbus.com>
Subject: Re: [PATCH] Bugfix RTS line config in RS485 mode is overwritten in
 pl011_set_mctrl() function.
Message-ID: <20220102182801.GA22268@wunner.de>
References: <20211231171516.18407-1-jochen@mades.net>
 <20220102100710.GA29858@wunner.de>
 <0e0e91b8-72f8-aa31-50e2-80090dd5613a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e0e91b8-72f8-aa31-50e2-80090dd5613a@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2022 at 04:06:53PM +0100, Lino Sanfilippo wrote:
> On 02.01.22 at 11:07, Lukas Wunner wrote:
> > On Fri, Dec 31, 2021 at 05:15:14PM +0000, jmades wrote:
> > > --- a/drivers/tty/serial/amba-pl011.c
> > > +++ b/drivers/tty/serial/amba-pl011.c
> > > @@ -1646,8 +1646,12 @@ static void pl011_set_mctrl(struct uart_port *port, unsigned int mctrl)
> > >  	    container_of(port, struct uart_amba_port, port);
> > >  	unsigned int cr;
> > >
> > > -	if (port->rs485.flags & SER_RS485_ENABLED)
> > > -		mctrl &= ~TIOCM_RTS;
> > > +	if (port->rs485.flags & SER_RS485_ENABLED) {
> > > +		if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
> > > +			mctrl &= ~TIOCM_RTS;
> > > +		else
> > > +			mctrl |= TIOCM_RTS;
> > > +	}
> > >
> > >  	cr = pl011_read(uap, REG_CR);
> 
> Does this logic really have to be implemented in the driver?

No, it doesn't have to be and indeed I'm working towards consolidating
it in the serial core with this collection of patches:

https://git.kernel.org/gregkh/tty/c/d3b3404df318
https://lore.kernel.org/all/f49f945375f5ccb979893c49f1129f51651ac738.1641129062.git.lukas@wunner.de
https://lore.kernel.org/all/e22089ab49e6e78822c50c8c4db46bf3ee885623.1641129328.git.lukas@wunner.de
https://lore.kernel.org/all/bceeaba030b028ed810272d55d5fc6f3656ddddb.1641129752.git.lukas@wunner.de
https://github.com/l1k/linux/commit/532ef2ad757f

The last of these removes the rs485 logic from pl011_set_mctrl().
I'll post it once the others (and Jochen Mades' patch) have landed.

Even though the logic is eventually removed from pl011_set_mctrl(),
Jochen's patch makes sense as a backportable fix for v5.15.


> It looks as if the serial core already takes RS485 into account before
> calling set_mctrls(). At least I get the impression when looking
> at uart_tiocmset() and uart_port_dtr_rts(). Also other drivers like imx
> simply seem to ignore RTS in case of RS485.

The logic in uart_port_dtr_rts() is broken.  That's fixed by d3b3404df318,
which is queued up in tty-next for v5.17.

The pl011 driver papered over it with its own rs485-specific logic in
pl011_set_mctrl().  But as Jochen Mades correctly pointed out, that
only worked correctly if RTS is driven high on idle.


The logic in uart_tiocmset() is correct, but not sufficient because
uart_throttle(), uart_unthrottle and uart_set_termios() need to become
rs485-aware as well.  That's also addressed by the above-linked
GitHub commit.

Thanks,

Lukas

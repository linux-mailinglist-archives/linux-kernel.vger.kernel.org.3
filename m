Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE3748AAFA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 11:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348380AbiAKKAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 05:00:36 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:39033 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237046AbiAKKAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 05:00:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1641895232;
    s=strato-dkim-0002; d=mades.net;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=lyofxhP/zBVTJReIn3f+VXHtqr4OgCKN/QQINp+/bx8=;
    b=X0MWPLscqqIMrs6tbPtT+Q9/3/smLjTN3FhqdEz2gOZN5toka1NCE+dOAHxILF0xdP
    txzRT9FHLQv8gnrNvHUORP8Go9P+F05ncz5sPFJPIMuozLFSBK2GfhQ4YPKVPB4e5ZId
    iw7Z+t/MPDN0skdcnSOQ7cfmZ789s6YrKANg+FN8nSprzlSYAoPdRV2xtA0HzyA18gwG
    mvBYeoTzm1aotPa9l2C/A2eI4iPGDPBq5mOiQmOzhTGBfXBjkSp5OGQWvVX2UQo9tVFf
    diunEotDevN/QSF2OAVSbv6EiZNzj/VDsSD7J7KjyXKFYH2H7YEEishsaC7BpP+1v1n7
    WLCg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JmMHfUWmW/JCZ5q3rSbjoqaGiJoG2nOuw/BEppjnAC9QlFFS7UbO3fgyY5MDJqZr"
X-RZG-CLASS-ID: mo00
Received: from oxapp05-01.back.ox.d0m.de
    by smtp.strato.de (RZmta 47.37.6 AUTH)
    with ESMTPSA id Y49088y0BA0WEd2
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Tue, 11 Jan 2022 11:00:32 +0100 (CET)
Date:   Tue, 11 Jan 2022 11:00:32 +0100 (CET)
From:   Jochen Mades <jochen@mades.net>
To:     Lukas Wunner <lukas@wunner.de>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     gregkh@linuxfoundation.org, Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philipp Rosenberger <p.rosenberger@kunbus.com>
Message-ID: <27017560.2684465.1641895232612@webmail.strato.com>
In-Reply-To: <20220102182801.GA22268@wunner.de>
References: <20211231171516.18407-1-jochen@mades.net>
 <20220102100710.GA29858@wunner.de>
 <0e0e91b8-72f8-aa31-50e2-80090dd5613a@gmx.de>
 <20220102182801.GA22268@wunner.de>
Subject: Re: [PATCH] Bugfix RTS line config in RS485 mode is overwritten in
 pl011_set_mctrl() function.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.5-Rev33
X-Originating-Client: open-xchange-appsuite
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas, Lino,

please let me know when I could test again with an "official" linux kernel, instead of using my local patch.

Bests
Jochen

> On 02/01/2022 19:28 Lukas Wunner <lukas@wunner.de> wrote:
> 
>  
> On Sun, Jan 02, 2022 at 04:06:53PM +0100, Lino Sanfilippo wrote:
> > On 02.01.22 at 11:07, Lukas Wunner wrote:
> > > On Fri, Dec 31, 2021 at 05:15:14PM +0000, jmades wrote:
> > > > --- a/drivers/tty/serial/amba-pl011.c
> > > > +++ b/drivers/tty/serial/amba-pl011.c
> > > > @@ -1646,8 +1646,12 @@ static void pl011_set_mctrl(struct uart_port *port, unsigned int mctrl)
> > > >  	    container_of(port, struct uart_amba_port, port);
> > > >  	unsigned int cr;
> > > >
> > > > -	if (port->rs485.flags & SER_RS485_ENABLED)
> > > > -		mctrl &= ~TIOCM_RTS;
> > > > +	if (port->rs485.flags & SER_RS485_ENABLED) {
> > > > +		if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
> > > > +			mctrl &= ~TIOCM_RTS;
> > > > +		else
> > > > +			mctrl |= TIOCM_RTS;
> > > > +	}
> > > >
> > > >  	cr = pl011_read(uap, REG_CR);
> > 
> > Does this logic really have to be implemented in the driver?
> 
> No, it doesn't have to be and indeed I'm working towards consolidating
> it in the serial core with this collection of patches:
> 
> https://git.kernel.org/gregkh/tty/c/d3b3404df318
> https://lore.kernel.org/all/f49f945375f5ccb979893c49f1129f51651ac738.1641129062.git.lukas@wunner.de
> https://lore.kernel.org/all/e22089ab49e6e78822c50c8c4db46bf3ee885623.1641129328.git.lukas@wunner.de
> https://lore.kernel.org/all/bceeaba030b028ed810272d55d5fc6f3656ddddb.1641129752.git.lukas@wunner.de
> https://github.com/l1k/linux/commit/532ef2ad757f
> 
> The last of these removes the rs485 logic from pl011_set_mctrl().
> I'll post it once the others (and Jochen Mades' patch) have landed.
> 
> Even though the logic is eventually removed from pl011_set_mctrl(),
> Jochen's patch makes sense as a backportable fix for v5.15.
> 
> 
> > It looks as if the serial core already takes RS485 into account before
> > calling set_mctrls(). At least I get the impression when looking
> > at uart_tiocmset() and uart_port_dtr_rts(). Also other drivers like imx
> > simply seem to ignore RTS in case of RS485.
> 
> The logic in uart_port_dtr_rts() is broken.  That's fixed by d3b3404df318,
> which is queued up in tty-next for v5.17.
> 
> The pl011 driver papered over it with its own rs485-specific logic in
> pl011_set_mctrl().  But as Jochen Mades correctly pointed out, that
> only worked correctly if RTS is driven high on idle.
> 
> 
> The logic in uart_tiocmset() is correct, but not sufficient because
> uart_throttle(), uart_unthrottle and uart_set_termios() need to become
> rs485-aware as well.  That's also addressed by the above-linked
> GitHub commit.
> 
> Thanks,
> 
> Lukas

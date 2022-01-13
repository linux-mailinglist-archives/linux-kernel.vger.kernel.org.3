Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7669648D5A1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbiAMKUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:20:46 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41004 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiAMKUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:20:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 544A261BE6;
        Thu, 13 Jan 2022 10:20:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1456CC36AE9;
        Thu, 13 Jan 2022 10:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642069244;
        bh=9l4YiTzis5EX2SbFlAJNIL7bN9QTMaOyqHcEuSDbCVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FA+eauo75VUVRV4J+OZEz7sUf05vB0tLcQ+0A+VoOy/43Peu41YMAKQMWmByj514c
         /QpQviQ+Ofgv4AymrOGZaYbwpXu272z0//Gt0UWyKmxAPUGAyYachjIsBKW/DSZnQk
         tM+up+YtDH6DL82B2c58A1CntyKeQmFsMWdmp8Kw=
Date:   Thu, 13 Jan 2022 11:20:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jochen Mades <jochen@mades.net>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Philipp Rosenberger <p.rosenberger@kunbus.com>
Subject: Re: [PATCH] Bugfix RTS line config in RS485 mode is overwritten in
 pl011_set_mctrl() function.
Message-ID: <Yd/8+YR549pvmOHS@kroah.com>
References: <20211231171516.18407-1-jochen@mades.net>
 <20220102100710.GA29858@wunner.de>
 <1489312180.3256431.1642068732902@webmail.strato.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1489312180.3256431.1642068732902@webmail.strato.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 11:12:12AM +0100, Jochen Mades wrote:
> Hi Lukas,
> 
> > Patch is correct, but commit message could be improved:
> > 
> > * Subject should be in imperative mood (by convention), it should be
> >   prepended by "serial: pl011: " (in line with previous commits touching
> >   this driver, use "git log --oneline amba-pl011.c") and the trailing dot
> >   is unnecessary, e.g.:
> > 
> >   "serial: pl011: Fix incorrect rs485 RTS polarity on set_mctrl"
> > 
> > * Commit message should be wrapped at 72 characters (so that it appears
> >   centered when displayed with "git log" on an 80 chars terminal).
> >   The reference to "0001-serial-amba-pl011-add-RS485-support.patch"
> >   should be replaced with a reference to the offending commit, e.g.:
> >
> >   "Commit 8d479237727c ("serial: amba-pl011: add RS485 support") sought
> >   to keep RTS deasserted on set_mctrl if rs485 is enabled.  However it
> >   did so only if deasserted RTS polarity is high.  Fix it in case it's
> >   low."
> >
> >   Feel free to copy this to a v2 of your patch and amend as you see fit.
> > 
> 
> Find attached the patch with the new subject and corretced commit message.
> 
> > * Add tags for the offending commit:
> > 
> >   Fixes: 8d479237727c ("serial: amba-pl011: add RS485 support")
> >   Cc: stable@vger.kernel.org # v5.15+
> > 
> > * Be sure to cc the author of the offending commit.
> 
> Sorry I don't know how to do that correctly. Can you please give support/hints?
> 
>  
> > Thanks,
> > 
> > Lukas
> > 
> > > ---
> > >  drivers/tty/serial/amba-pl011.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> > > index 537f37ac4..1749c1498 100644
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


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch was attached, please place it inline so that it can be
  applied directly from the email message itself.

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file, Documentation/SubmittingPatches
  for how to do this correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

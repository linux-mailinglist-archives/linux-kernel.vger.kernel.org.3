Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7503C4AD662
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357106AbiBHLYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244906AbiBHKEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 05:04:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3497FC03FEC0;
        Tue,  8 Feb 2022 02:04:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C82C5B819AA;
        Tue,  8 Feb 2022 10:04:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D1CC340ED;
        Tue,  8 Feb 2022 10:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644314639;
        bh=9XRxX5n5xmPLXTFls/kdqprhfHPlsurq93wudUcHvmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ydMfYgvttYlxl9uRj9Idy5Mfb8u3n3OXW3As+08WOsMeVgyEFsIELiokvKXAza88c
         q+ArZi2JeMzdkwiYIC0h7rfZzDkecdHEsCX5Opcb2I4tCAzLDMedbto4z8meqsvHsG
         itZ329OsvY3CyLkSCy7t5yq0VrQU3vmhnOF9VhfA=
Date:   Tue, 8 Feb 2022 11:03:56 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Harald Seiler <hws@denx.de>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-serial@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] tty: serial: imx: Add fast path when rs485 delays are 0
Message-ID: <YgJADKxWfOZroS35@kroah.com>
References: <20220119145204.238767-1-hws@denx.de>
 <20220119151145.zft47rzebnabiej2@pengutronix.de>
 <0df5d9ea2081f5d798f80297efb973f542dae183.camel@denx.de>
 <20220119162122.jmnz2hxid76p4hli@pengutronix.de>
 <5cab27cab5a39ef5e19992bc54e57c3f6106dafe.camel@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5cab27cab5a39ef5e19992bc54e57c3f6106dafe.camel@denx.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 05:59:46PM +0100, Harald Seiler wrote:
> Hi,
> 
> On Wed, 2022-01-19 at 17:21 +0100, Uwe Kleine-König wrote:
> > On Wed, Jan 19, 2022 at 04:20:12PM +0100, Harald Seiler wrote:
> > > Hi,
> > > 
> > > On Wed, 2022-01-19 at 16:11 +0100, Uwe Kleine-König wrote:
> > > > On Wed, Jan 19, 2022 at 03:52:03PM +0100, Harald Seiler wrote:
> > > > > Right now, even when `delay_rts_before_send` and `delay_rts_after_send`
> > > > > are 0, the hrtimer is triggered (with timeout 0) which can introduce a
> > > > > few 100us of additional overhead on slower i.MX platforms.
> > > > > 
> > > > > Implement a fast path when the delays are 0, where the RTS signal is
> > > > > toggled immediately instead of going through an hrtimer.  This fast path
> > > > > behaves identical to the code before delay support was implemented.
> > > > > 
> > > > > Signed-off-by: Harald Seiler <hws@denx.de>
> > > > > ---
> > > > >  drivers/tty/serial/imx.c | 18 ++++++++++++++----
> > > > >  1 file changed, 14 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > > > > index df8a0c8b8b29..67bbbb69229d 100644
> > > > > --- a/drivers/tty/serial/imx.c
> > > > > +++ b/drivers/tty/serial/imx.c
> > > > > @@ -455,9 +455,14 @@ static void imx_uart_stop_tx(struct uart_port *port)
> > > > >  	if (port->rs485.flags & SER_RS485_ENABLED) {
> > > > >  		if (sport->tx_state == SEND) {
> > > > >  			sport->tx_state = WAIT_AFTER_SEND;
> > > > > -			start_hrtimer_ms(&sport->trigger_stop_tx,
> > > > > +
> > > > > +			if (port->rs485.delay_rts_after_send > 0) {
> > > > > +				start_hrtimer_ms(&sport->trigger_stop_tx,
> > > > >  					 port->rs485.delay_rts_after_send);
> > > > > -			return;
> > > > > +				return;
> > > > > +			}
> > > > > +
> > > > > +			/* continue without any delay */
> > > > 
> > > > Is it right to keep the assignment sport->tx_state = WAIT_AFTER_SEND ?
> > > 
> > > I am keeping the assignment intentionally, to fall into the
> > > if(state == WAIT_AFTER_RTS) below (which then sets the state to OFF).
> > > I originally had the code structured like this:
> > > 
> > > 	if (port->rs485.delay_rts_after_send > 0) {
> > > 		sport->tx_state = WAIT_AFTER_SEND;
> > > 		start_hrtimer_ms(&sport->trigger_stop_tx,
> > > 			 port->rs485.delay_rts_after_send);
> > > 		return;
> > > 	} else {
> > > 		/* continue without any delay */
> > > 		sport->tx_state = WAIT_AFTER_SEND;
> > > 	}
> > > 
> > > This is functionally identical, but maybe a bit more explicit.
> > > 
> > > Not sure what is more clear to read?
> > 
> > I didn't oppose to the readability thing. With your patch you skip
> > starting the stop_tx timer and that would usually care for calling
> > imx_uart_stop_tx and setting sport->tx_state = OFF. This doesn't happen
> > with your patch any more.
> 
> Not starting the timer is the entire point of the patch - instead, the
> code which would run inside the timer callback now runs immediately. To
> do this, I set the tx_state to WAIT_AFTER_SEND and _don't_ do the early
> return which leads into the if(tx_state == WAIT_AFTER_SEND) below.  This
> is the code-path which normally runs later in the hrtimer callback.
> 
> I suppose it would have been good to provide more context lines in the
> patch... Here is the relevant bit (in the changed version now):
> 
> 	if (sport->tx_state == SEND) {
> 		sport->tx_state = WAIT_AFTER_SEND;
> 
> 		if (port->rs485.delay_rts_after_send > 0) {
> 			start_hrtimer_ms(&sport->trigger_stop_tx,
> 				 port->rs485.delay_rts_after_send);
> 			return;
> 		}
> 
> 		/* continue without any delay */
> 	}
> 
> 	if (sport->tx_state == WAIT_AFTER_RTS ||
> 	    sport->tx_state == WAIT_AFTER_SEND) {
> 		/* ... actual rts toggling ... */
> 
> 		sport->tx_state = OFF;
> 	}
> 

Uwe, any thoughts about if this patch should be taken or not?

thanks,

greg k-h

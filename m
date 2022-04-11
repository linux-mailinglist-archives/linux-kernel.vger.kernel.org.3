Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAC04FB921
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345153AbiDKKO0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Apr 2022 06:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239505AbiDKKOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:14:23 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C87841F89;
        Mon, 11 Apr 2022 03:12:10 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D0EAE809F;
        Mon, 11 Apr 2022 10:09:38 +0000 (UTC)
Date:   Mon, 11 Apr 2022 13:12:08 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: Re: [PATCH 2/2] serial: 8250: Fix runtime PM for start_tx() for
 empty buffer
Message-ID: <YlP++Eygz2aFKd1u@atomide.com>
References: <20220411094805.45696-1-tony@atomide.com>
 <20220411094805.45696-2-tony@atomide.com>
 <20220411100202.5mzcogksfzk4hlk6@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20220411100202.5mzcogksfzk4hlk6@pengutronix.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Uwe Kleine-König <u.kleine-koenig@pengutronix.de> [220411 09:59]:
> On Mon, Apr 11, 2022 at 12:48:05PM +0300, Tony Lindgren wrote:
> > Commit 932d596378b0 ("serial: 8250: Return early in .start_tx() if there
> > are no chars to send") caused a regression where the drivers implementing
> > runtime PM stopped idling.
> > 
> > We need to call serial8250_rpm_put_tx() on early exit, it normally gets
> > called later on at __stop_tx().
> > 
> > Fixes: 932d596378b0 ("serial: 8250: Return early in .start_tx() if there are no chars to send")
> > Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  drivers/tty/serial/8250/8250_port.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -1677,8 +1677,10 @@ static void serial8250_start_tx(struct uart_port *port)
> >  
> >  	serial8250_rpm_get_tx(up);
> >  
> > -	if (!port->x_char && uart_circ_empty(&port->state->xmit))
> > +	if (!port->x_char && uart_circ_empty(&port->state->xmit)) {
> > +		serial8250_rpm_put_tx(up);
> >  		return;
> > +	}
> 
> Assuming you don't need serial8250_rpm_get_tx() to check the condition,
> it would be easier to move the early return before the call to
> serial8250_rpm_get_tx().

Yeah good suggestion, that should work.

Regards,

Tony


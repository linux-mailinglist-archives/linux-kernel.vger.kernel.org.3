Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16104FB91C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345135AbiDKKNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345215AbiDKKMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:12:49 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57A493A711;
        Mon, 11 Apr 2022 03:10:36 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id EF152809F;
        Mon, 11 Apr 2022 10:08:04 +0000 (UTC)
Date:   Mon, 11 Apr 2022 13:10:34 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Matwey V . Kornilov" <matwey@sai.msu.ru>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/2] serial: 8250: Fix runtime PM for start_tx() for RS485
Message-ID: <YlP+muZF1nDIU0t4@atomide.com>
References: <20220411094805.45696-1-tony@atomide.com>
 <YlP7eArvvNWnbMF2@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlP7eArvvNWnbMF2@hovoldconsulting.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Johan Hovold <johan@kernel.org> [220411 09:54]:
> On Mon, Apr 11, 2022 at 12:48:04PM +0300, Tony Lindgren wrote:
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -1681,8 +1681,10 @@ static void serial8250_start_tx(struct uart_port *port)
> >  		return;
> >  
> >  	if (em485 &&
> > -	    em485->active_timer == &em485->start_tx_timer)
> > +	    em485->active_timer == &em485->start_tx_timer) {
> > +		serial8250_rpm_put_tx(up);
> >  		return;
> > +	}
> 
> I was just taking a quick look at your report about this and also
> noticed this return statement.
> 
> The runtime PM implementation is a bit of mess as we've discussed
> elsewhere, but the change you propose here doesn't look right.

Frankly "a bit of mess" applies "a bit more" than just the serial runtime
PM :)

> start_tx() can be deferred in the rs485 case, but that doesn't mean you
> should suspend the device here. In fact, that look like it would just
> break runtime PM (the parts that may work to some extent).

AFAIK there's currently nothing paired with the serial8250_rpm_get_tx(up)
call at the beginning of serial8250_start_tx() for the early exit cases
if start_tx_rs485() or __start_tx() won't get called.

Care to clarify a bit more what you have in mind?

Regards,

Tony

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84DD4FBB88
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345754AbiDKMDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345661AbiDKMDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:03:45 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EDDF369FB;
        Mon, 11 Apr 2022 05:01:31 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E6373809F;
        Mon, 11 Apr 2022 11:58:59 +0000 (UTC)
Date:   Mon, 11 Apr 2022 15:01:29 +0300
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
Message-ID: <YlQYmTIFCbk/hEZY@atomide.com>
References: <20220411094805.45696-1-tony@atomide.com>
 <YlP7eArvvNWnbMF2@hovoldconsulting.com>
 <YlP+muZF1nDIU0t4@atomide.com>
 <YlQCJE4yQRsO8JPn@hovoldconsulting.com>
 <YlQD2mZdorEAKfZ7@atomide.com>
 <YlQXUpNGo8JSppF+@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlQXUpNGo8JSppF+@hovoldconsulting.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Johan Hovold <johan@kernel.org> [220411 11:53]:
> On Mon, Apr 11, 2022 at 01:32:58PM +0300, Tony Lindgren wrote:
> > * Johan Hovold <johan@kernel.org> [220411 10:23]:
> > > On Mon, Apr 11, 2022 at 01:10:34PM +0300, Tony Lindgren wrote:
> > > > * Johan Hovold <johan@kernel.org> [220411 09:54]:
> > > > > On Mon, Apr 11, 2022 at 12:48:04PM +0300, Tony Lindgren wrote:
> > > > > > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> > > > > > --- a/drivers/tty/serial/8250/8250_port.c
> > > > > > +++ b/drivers/tty/serial/8250/8250_port.c
> > > > > > @@ -1681,8 +1681,10 @@ static void serial8250_start_tx(struct uart_port *port)
> > > > > >  		return;
> > > > > >  
> > > > > >  	if (em485 &&
> > > > > > -	    em485->active_timer == &em485->start_tx_timer)
> > > > > > +	    em485->active_timer == &em485->start_tx_timer) {
> > > > > > +		serial8250_rpm_put_tx(up);
> > > > > >  		return;
> > > > > > +	}
> 
> > > The problem is that that serial8250_rpm_put_tx() you're adding may
> > > suspend the device unconditionally (i.e. regardless of any previous
> > > calls to serial8250_rpm_get_tx()).
> > > 
> > > If rs485 tx is just being deferred you mustn't suspend the device before
> > > it has had a chance to start transmitting.
> > 
> > Hmm I'm pretty sure rs485 has the runtime PM usage count is currently
> > unbalanced. To me it seems em485->start_tx_timer calls start_tx()
> > again from serial8250_em485_handle_start_tx().
> 
> It appears to call __start_tx(), but note that the only call to
> serial8250_rpm_get_tx() is in serial8250_start_tx() which this patch
> would have cancelled out.

OK

> Also note that the serial8250_rpm_get/set_tx() calls aren't supposed to
> be balanced. get() can be called multiple times and will only increment
> the PM usage counter once, while put() will decrement the counter
> whenever get() has been called once (and hence potentially suspend the
> device immediately).
> 
> Messy indeed.

Yeah that is not nice.

I'll send a patch to prepare things for runtime PM that will hopefully
make things a bit easier as discussed earlier.

Regards,

Tony

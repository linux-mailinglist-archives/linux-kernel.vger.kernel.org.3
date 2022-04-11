Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241E04FBB6C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245753AbiDKL60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244053AbiDKL6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:58:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529FA43AD4;
        Mon, 11 Apr 2022 04:56:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C61EE615FC;
        Mon, 11 Apr 2022 11:56:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D87C385A3;
        Mon, 11 Apr 2022 11:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649678169;
        bh=APN4Xr9wiOB2KYM+IUY6sAcDxDKATbLaOo6eZnz1pqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=asgAmVjK9bGh53HKIMDmNRb13i7Q7Z+qDa/K0SMhLbWsNPYWlbehYxET8woZGikMW
         ksgXQP2LY7A54MrlMAMlrd1IJfmnHyXC0Tk4QKABkeRNVtlto5NQSlud7cvlkd2c6Y
         pjjgpT490IfsydpjgNxFSwSRHN8KNCDBL89HWcSzJsd7XmrgZU60cymOon1FnNHwNj
         7Pa6dFxkOk2jz86RK1bSSwBNENC4W0Wt9QIpfohw7W6H8GAgwKZf+0a/7sD/F4tBUT
         NXx1tRZT/LewQD2Ljfyp/ZccavryK6AHDcKZi6t5qhCZHOqgthBllluKsO/ZFzl3Vu
         yKc9c/RSrLcwg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ndseI-0004eS-JW; Mon, 11 Apr 2022 13:56:02 +0200
Date:   Mon, 11 Apr 2022 13:56:02 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
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
Message-ID: <YlQXUpNGo8JSppF+@hovoldconsulting.com>
References: <20220411094805.45696-1-tony@atomide.com>
 <YlP7eArvvNWnbMF2@hovoldconsulting.com>
 <YlP+muZF1nDIU0t4@atomide.com>
 <YlQCJE4yQRsO8JPn@hovoldconsulting.com>
 <YlQD2mZdorEAKfZ7@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlQD2mZdorEAKfZ7@atomide.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 01:32:58PM +0300, Tony Lindgren wrote:
> * Johan Hovold <johan@kernel.org> [220411 10:23]:
> > On Mon, Apr 11, 2022 at 01:10:34PM +0300, Tony Lindgren wrote:
> > > * Johan Hovold <johan@kernel.org> [220411 09:54]:
> > > > On Mon, Apr 11, 2022 at 12:48:04PM +0300, Tony Lindgren wrote:
> > > > > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> > > > > --- a/drivers/tty/serial/8250/8250_port.c
> > > > > +++ b/drivers/tty/serial/8250/8250_port.c
> > > > > @@ -1681,8 +1681,10 @@ static void serial8250_start_tx(struct uart_port *port)
> > > > >  		return;
> > > > >  
> > > > >  	if (em485 &&
> > > > > -	    em485->active_timer == &em485->start_tx_timer)
> > > > > +	    em485->active_timer == &em485->start_tx_timer) {
> > > > > +		serial8250_rpm_put_tx(up);
> > > > >  		return;
> > > > > +	}

> > The problem is that that serial8250_rpm_put_tx() you're adding may
> > suspend the device unconditionally (i.e. regardless of any previous
> > calls to serial8250_rpm_get_tx()).
> > 
> > If rs485 tx is just being deferred you mustn't suspend the device before
> > it has had a chance to start transmitting.
> 
> Hmm I'm pretty sure rs485 has the runtime PM usage count is currently
> unbalanced. To me it seems em485->start_tx_timer calls start_tx()
> again from serial8250_em485_handle_start_tx().

It appears to call __start_tx(), but note that the only call to
serial8250_rpm_get_tx() is in serial8250_start_tx() which this patch
would have cancelled out.
 
Also note that the serial8250_rpm_get/set_tx() calls aren't supposed to
be balanced. get() can be called multiple times and will only increment
the PM usage counter once, while put() will decrement the counter
whenever get() has been called once (and hence potentially suspend the
device immediately).

Messy indeed.

Johan

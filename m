Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13654FB985
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345406AbiDKK2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345834AbiDKK2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:28:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BD02253D;
        Mon, 11 Apr 2022 03:25:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81B5961494;
        Mon, 11 Apr 2022 10:25:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43D2C385A5;
        Mon, 11 Apr 2022 10:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649672746;
        bh=ToeC9tEdnIhlAOR1pPNmn1re702gqOBJ1GoLQPVv7K0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SrhLIUOEc1lbZh4BFijvTmYSn+pFIKhlkruchPzE/FS52FFP880HJHvxTZE0an0+2
         9fiGIoeBCdM6izDDe1VOtswW5OnW8QQLFNLlFdQH1XJ3o4I55FNV9Ag1755pLSEHjc
         g1e7JN/LnHyAERGrPlC74jn88/tFhhyK0IGcjCB2hWAVdhZq33ASMucq4q3SC8y5aE
         y5/7GHpoTJdGnlS679MWQYbwQchrJXutdAEGwqq1JZ52AHLGrEa4d8+YayNSTWEK/Y
         IMwCSoIXYHrYLX+F66ElFEgwN6RZpsGI9Sa1Vu2SFWp00uySGSmkfIAvvPVUf+39BH
         y3Dz6az2EPoZA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ndrEq-0003zS-9G; Mon, 11 Apr 2022 12:25:40 +0200
Date:   Mon, 11 Apr 2022 12:25:40 +0200
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
Message-ID: <YlQCJE4yQRsO8JPn@hovoldconsulting.com>
References: <20220411094805.45696-1-tony@atomide.com>
 <YlP7eArvvNWnbMF2@hovoldconsulting.com>
 <YlP+muZF1nDIU0t4@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlP+muZF1nDIU0t4@atomide.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 01:10:34PM +0300, Tony Lindgren wrote:
> * Johan Hovold <johan@kernel.org> [220411 09:54]:
> > On Mon, Apr 11, 2022 at 12:48:04PM +0300, Tony Lindgren wrote:
> > > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> > > --- a/drivers/tty/serial/8250/8250_port.c
> > > +++ b/drivers/tty/serial/8250/8250_port.c
> > > @@ -1681,8 +1681,10 @@ static void serial8250_start_tx(struct uart_port *port)
> > >  		return;
> > >  
> > >  	if (em485 &&
> > > -	    em485->active_timer == &em485->start_tx_timer)
> > > +	    em485->active_timer == &em485->start_tx_timer) {
> > > +		serial8250_rpm_put_tx(up);
> > >  		return;
> > > +	}
> > 
> > I was just taking a quick look at your report about this and also
> > noticed this return statement.
> > 
> > The runtime PM implementation is a bit of mess as we've discussed
> > elsewhere, but the change you propose here doesn't look right.
> 
> Frankly "a bit of mess" applies "a bit more" than just the serial runtime
> PM :)

Heh. I'm afraid that's all too true. :)

> > start_tx() can be deferred in the rs485 case, but that doesn't mean you
> > should suspend the device here. In fact, that look like it would just
> > break runtime PM (the parts that may work to some extent).
> 
> AFAIK there's currently nothing paired with the serial8250_rpm_get_tx(up)
> call at the beginning of serial8250_start_tx() for the early exit cases
> if start_tx_rs485() or __start_tx() won't get called.
> 
> Care to clarify a bit more what you have in mind?

The problem is that that serial8250_rpm_put_tx() you're adding may
suspend the device unconditionally (i.e. regardless of any previous
calls to serial8250_rpm_get_tx()).

If rs485 tx is just being deferred you mustn't suspend the device before
it has had a chance to start transmitting.

Johan

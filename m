Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F237B54DCC7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359620AbiFPIXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359738AbiFPIXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:23:35 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15CB224598;
        Thu, 16 Jun 2022 01:23:34 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 5E738812F;
        Thu, 16 Jun 2022 08:18:46 +0000 (UTC)
Date:   Thu, 16 Jun 2022 11:23:32 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <YqrohD8FZJS5aBo+@atomide.com>
References: <20220615062455.15490-1-tony@atomide.com>
 <YqmjnaawQ2gye/pe@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqmjnaawQ2gye/pe@smile.fi.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Shevchenko <andriy.shevchenko@linux.intel.com> [220615 09:12]:
> On Wed, Jun 15, 2022 at 09:24:55AM +0300, Tony Lindgren wrote:
> > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -30,6 +32,25 @@
> >  #include <linux/irq.h>
> >  #include <linux/uaccess.h>
> >  
> > +/*
> > + * Serial port device specific data for serial core.
> > + *
> > + * Each port device can have multiple ports with struct uart_state allocated
> > + * for each port. The array of ports is kept in struct uart_driver.
> > + */
> > +struct serial_controller {
> > +	struct device *dev;			/* Serial port device */
> 
> Serial port device is a bit unclear for non-prepared reader. Perhaps add
> the word "physical" or another to specify the nature of the device (because
> to me "serial port device" sounds like a duplication of something in struct
> uart_port, but I have doubts).

Hmm so we could add a list of all the registered struct uart_port or
uart_state to struct serial_controller. Then looking up struct device would
be just looking at the first list entry. We need to take port_mutex, but
that should be mostly when the device does runtime PM. We'll be needing that
list anyways later on to flush pending TX on runtime PM resume for each
port associated with the device.

> > diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> > --- a/include/linux/serial_core.h
> > +++ b/include/linux/serial_core.h
> > @@ -250,6 +250,7 @@ struct uart_port {
> >  	unsigned char		hub6;			/* this should be in the 8250 driver */
> >  	unsigned char		suspended;
> >  	unsigned char		console_reinit;
> > +	unsigned char		supports_autosuspend;
> >  	const char		*name;			/* port name */
> >  	struct attribute_group	*attr_group;		/* port specific attributes */
> >  	const struct attribute_group **tty_groups;	/* all attributes (serial core use only) */
> > @@ -285,6 +286,8 @@ enum uart_pm_state {
> >   * This is the state information which is persistent across opens.
> >   */
> >  struct uart_state {
> > +	struct serial_controller *controller;
> 
> While good looking here, I believe resource wise is better to leave @port to be
> the first member. The rationale is to get rid of pointer arithmetics at compile
> time (and I believe the port is used much more and in more critical places).
> However, I dunno if it will get a lot of benefit, would be nice to see
> bloat-o-meter output for your variant and my proposal.

OK makes sense. And thanks for reviewing again :)

Regards,

Tony

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DE155FC56
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbiF2JlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiF2JlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:41:20 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0C6039825;
        Wed, 29 Jun 2022 02:41:19 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9BC6380CD;
        Wed, 29 Jun 2022 09:36:04 +0000 (UTC)
Date:   Wed, 29 Jun 2022 12:41:17 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250: Fix PM usage_count for console handover
Message-ID: <YrwePdVzSYDygdVA@atomide.com>
References: <20220628165834.63044-1-ilpo.jarvinen@linux.intel.com>
 <YrtvOSrrSLGX/coS@smile.fi.intel.com>
 <YrwZkTcU9IyY2DhN@atomide.com>
 <5548afe5-20aa-9066-37e7-a3b2b26872e1@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5548afe5-20aa-9066-37e7-a3b2b26872e1@linux.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> [220629 09:26]:
> On Wed, 29 Jun 2022, Tony Lindgren wrote:
> 
> > * Andy Shevchenko <andriy.shevchenko@linux.intel.com> [220628 21:09]:
> > > On Tue, Jun 28, 2022 at 07:58:34PM +0300, Ilpo Järvinen wrote:
> > > > When console is enabled, univ8250_console_setup() calls
> > > > serial8250_console_setup() before .dev is set to uart_port. Therefore,
> > > > it will not call pm_runtime_get_sync(). Later, when the actual driver
> > > > is going to take over univ8250_console_exit() is called. As .dev is
> > > > already set, serial8250_console_exit() makes pm_runtime_put_sync() call
> > > > with usage count being zero triggering PM usage count warning
> > > > (extra debug for univ8250_console_setup(), univ8250_console_exit(), and
> > > > serial8250_register_ports()):
> > 
> > Hmm so serial8250_console_setup() calls pm_runtime_get_sync() if dev
> > exists..
> > 
> > > > diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> > > > index 57e86133af4f..2e83e7367441 100644
> > > > --- a/drivers/tty/serial/8250/8250_core.c
> > > > +++ b/drivers/tty/serial/8250/8250_core.c
> > > > @@ -23,6 +23,7 @@
> > > >  #include <linux/sysrq.h>
> > > >  #include <linux/delay.h>
> > > >  #include <linux/platform_device.h>
> > > > +#include <linux/pm_runtime.h>
> > > >  #include <linux/tty.h>
> > > >  #include <linux/ratelimit.h>
> > > >  #include <linux/tty_flip.h>
> > > > @@ -558,6 +559,9 @@ serial8250_register_ports(struct uart_driver *drv, struct device *dev)
> > > >  
> > > >  		up->port.dev = dev;
> > > >  
> > > > +		if (uart_console_enabled(&up->port))
> > > > +			pm_runtime_get_sync(up->port.dev);
> > > > +
> > > >  		serial8250_apply_quirks(up);
> > > >  		uart_add_one_port(drv, &up->port);
> > > >  	}
> > 
> > ..and now we also call it here. Are there now cases where pm_runtime_get_sync()
> > gets called twice potentially or does uart_console_enabled() ensure that is
> > not the case already?
> 
> The code in serial8250_register_ports() right before that context block is 
> this:
> 
> 		if (up->port.dev)
> 			continue;
> 
> If serial8250_console_setup() already saw .dev != NULL, we take that 
> continue and pm_runtime_get_sync() will not get called again here.

OK thanks. Looks good to me:

Reviewed-by: Tony Lindgren <tony@atomide.com>
Tested-by: Tony Lindgren <tony@atomide.com>

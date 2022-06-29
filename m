Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8451155FC0C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbiF2Jbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbiF2Jba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:31:30 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674823A19F;
        Wed, 29 Jun 2022 02:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656495089; x=1688031089;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6XgOU8eRPAfaRBGVd2axJoVIivSpVH9so8YeDqxKLnU=;
  b=mxn0bvKFVN+dp4UHWKausY+tUgEffng06T6tYSAboWOx1KcSMNzZGzYr
   /TnqFoXjfH+LrsCOeKEdltsZpx03Pmtk3S/1lI4pT8T/R7pMJU/pxStL+
   vOJULRYb5fvkzycCJDiE3eKfMnrLFG/xOZKGfkZ15fSBxXWzq8L61lGk/
   jZ6AVjhR23bTHhZJALwT5nout0xmznm87U2VXArsUniRGqcufKjiFXVH9
   OnUTUp5w86PHdSkdJKugCIgA7DcPyCCObR+SJvFGzpaOh6fzkX9iNxBwj
   TruOupmHeMBgXrASDva/VXBAOlJwCqSTEZBVXMktO23oupESwR5t5P6Sv
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="282019383"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="282019383"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 02:31:28 -0700
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="733117286"
Received: from dsummer-mobl.ger.corp.intel.com ([10.252.38.121])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 02:31:27 -0700
Date:   Wed, 29 Jun 2022 12:31:25 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Tony Lindgren <tony@atomide.com>
cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250: Fix PM usage_count for console handover
In-Reply-To: <YrwZkTcU9IyY2DhN@atomide.com>
Message-ID: <5548afe5-20aa-9066-37e7-a3b2b26872e1@linux.intel.com>
References: <20220628165834.63044-1-ilpo.jarvinen@linux.intel.com> <YrtvOSrrSLGX/coS@smile.fi.intel.com> <YrwZkTcU9IyY2DhN@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2038978736-1656495088=:1529"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2038978736-1656495088=:1529
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 29 Jun 2022, Tony Lindgren wrote:

> * Andy Shevchenko <andriy.shevchenko@linux.intel.com> [220628 21:09]:
> > On Tue, Jun 28, 2022 at 07:58:34PM +0300, Ilpo Järvinen wrote:
> > > When console is enabled, univ8250_console_setup() calls
> > > serial8250_console_setup() before .dev is set to uart_port. Therefore,
> > > it will not call pm_runtime_get_sync(). Later, when the actual driver
> > > is going to take over univ8250_console_exit() is called. As .dev is
> > > already set, serial8250_console_exit() makes pm_runtime_put_sync() call
> > > with usage count being zero triggering PM usage count warning
> > > (extra debug for univ8250_console_setup(), univ8250_console_exit(), and
> > > serial8250_register_ports()):
> 
> Hmm so serial8250_console_setup() calls pm_runtime_get_sync() if dev
> exists..
> 
> > > diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> > > index 57e86133af4f..2e83e7367441 100644
> > > --- a/drivers/tty/serial/8250/8250_core.c
> > > +++ b/drivers/tty/serial/8250/8250_core.c
> > > @@ -23,6 +23,7 @@
> > >  #include <linux/sysrq.h>
> > >  #include <linux/delay.h>
> > >  #include <linux/platform_device.h>
> > > +#include <linux/pm_runtime.h>
> > >  #include <linux/tty.h>
> > >  #include <linux/ratelimit.h>
> > >  #include <linux/tty_flip.h>
> > > @@ -558,6 +559,9 @@ serial8250_register_ports(struct uart_driver *drv, struct device *dev)
> > >  
> > >  		up->port.dev = dev;
> > >  
> > > +		if (uart_console_enabled(&up->port))
> > > +			pm_runtime_get_sync(up->port.dev);
> > > +
> > >  		serial8250_apply_quirks(up);
> > >  		uart_add_one_port(drv, &up->port);
> > >  	}
> 
> ..and now we also call it here. Are there now cases where pm_runtime_get_sync()
> gets called twice potentially or does uart_console_enabled() ensure that is
> not the case already?

The code in serial8250_register_ports() right before that context block is 
this:

		if (up->port.dev)
			continue;

If serial8250_console_setup() already saw .dev != NULL, we take that 
continue and pm_runtime_get_sync() will not get called again here.


-- 
 i.

--8323329-2038978736-1656495088=:1529--

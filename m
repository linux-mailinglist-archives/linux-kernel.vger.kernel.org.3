Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09714C5530
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 11:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbiBZKdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 05:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiBZKdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 05:33:09 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C37B344E0;
        Sat, 26 Feb 2022 02:32:34 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 7CF2292009D; Sat, 26 Feb 2022 11:32:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 77FE792009C;
        Sat, 26 Feb 2022 10:32:31 +0000 (GMT)
Date:   Sat, 26 Feb 2022 10:32:31 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] serial: 8250: Report which option to enable for
 blacklisted PCI devices
In-Reply-To: <Yhiixm/iRlnF18B7@kroah.com>
Message-ID: <alpine.DEB.2.21.2202251753530.25061@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2202121646020.34636@angie.orcam.me.uk> <alpine.DEB.2.21.2202121706060.34636@angie.orcam.me.uk> <Yhiixm/iRlnF18B7@kroah.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Feb 2022, Greg Kroah-Hartman wrote:

> On Sat, Feb 12, 2022 at 05:30:59PM +0000, Maciej W. Rozycki wrote:
> > Provide information in the kernel log as to what configuration option to 
> > enable for PCI UART devices that have been blacklisted in the generic 
> > PCI 8250 UART driver and which have a dedicated driver available to 
> > handle that has been disabled.  The rationale is there is no easy way 
> > for the user to map a specific PCI vendor:device pair to an individual 
> > dedicated driver while the generic driver has this information readily 
> > available and it will likely be confusing that the generic driver does 
> > not register such a port.
> > 
> > A message is then printed like:
> > 
> > serial 0000:04:00.3: ignoring port, enable SERIAL_8250_PERICOM to handle
> > 
> > when an affected device is encountered and the generic driver rejects it.
> > 
> > Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> 
> I've applied patch 1 of this series, but this is really an odd one.

 Thank you.

> We don't do this for any other driver subsystem, so why is it really
> needed?  What is so special about this driver that distros can't
> just enable all of the drivers and all is good?  What is keeping those
> drivers fromb eing enabled?

 My justification is we have a supposedly generic PCI 8250 UART driver, 
except it explicitly and silently refuses to handle a handful of devices 
chosen by their PCI IDs based on that they may have extra features, even 
though they are otherwise fully compatible with a generic 8250.

 For distributions it probably does not matter as long as the packager 
does not forget to enable an option, which itself might be a problem (I've 
seen distributions missing drivers randomly).  A user who configures their 
kernel on their own may simply not be aware that for one card enabling 
SERIAL_8250_PCI will do while for another almost identical card they need 
to use SERIAL_8250_foo instead even though it's just another PCI 8250 
UART.

 Consequently someone may well waste a day trying to figure out why their 
card does not work (is it faulty perhaps, is there a configuration error 
with the hardware?).  Even if they actually realise it's a kernel config 
issue, they may still have to go through a trial-and-error experience 
trying to figure out which driver to enable.  While the generic driver 
knows perfectly well.  Then why not make people's life easier and let them 
know as well what is going on?

 I don't think we have another case like this, do we?  Hence my proposal.

 Have I made myself clear now?  What are your actual arguments against my 
reasoning?

  Maciej

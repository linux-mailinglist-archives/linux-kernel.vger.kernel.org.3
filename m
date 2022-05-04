Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F7C51A26C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 16:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351430AbiEDOoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 10:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344317AbiEDOoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 10:44:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777616147;
        Wed,  4 May 2022 07:40:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C0CF61A9C;
        Wed,  4 May 2022 14:40:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47618C385A4;
        Wed,  4 May 2022 14:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651675232;
        bh=pXEMqJc4FMTugFCsqdvFsuG1NQYrw+IcXscCZBtoAmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=poZyFfi/B3gq6L6NFEBuYPHvtwbfB7IYSgRGeftkd/+88cA4KuFAt/JFIRgp/qC29
         3ZqgPAzgHH9W/VdxK0kiocFMLzhpRohjJ7dLs90/Pr5d85rdkZy0Qi+n1kgZaF0FWX
         Y0a5/2cnRJ8cOdM/Yarnsw50+1OFUhgJU6CtAoj0=
Date:   Wed, 4 May 2022 16:40:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Felipe Balbi <balbi@kernel.org>,
        USB mailing list <linux-usb@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH 4/4] USB: gadget: Add a new bus for gadgets
Message-ID: <YnKQXwGbe4k+cGkF@kroah.com>
References: <YjeEbHL8ITkW692W@rowland.harvard.edu>
 <YmKt3kH+85kjzdbL@kroah.com>
 <YmSc29YZvxgT5fEJ@rowland.harvard.edu>
 <YmSo6fU1FlNq8cOZ@rowland.harvard.edu>
 <YmSpKpnWR8WWEk/p@rowland.harvard.edu>
 <YmSpdxaDNeC2BBOf@rowland.harvard.edu>
 <alpine.DEB.2.22.394.2205031209030.681336@ramsan.of.borg>
 <YnFCEn45XwDWM/9Y@rowland.harvard.edu>
 <CAMuHMdVDK0W0T3=+2c1E6wtwy5JTUemTGYyj3PFuVUhK++AzrA@mail.gmail.com>
 <YnFO0Qr8RY7peFCg@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnFO0Qr8RY7peFCg@rowland.harvard.edu>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 11:48:33AM -0400, Alan Stern wrote:
> On Tue, May 03, 2022 at 05:27:08PM +0200, Geert Uytterhoeven wrote:
> > Hi Alan,
> > 
> > On Tue, May 3, 2022 at 5:14 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > On Tue, May 03, 2022 at 12:14:30PM +0200, Geert Uytterhoeven wrote:
> > > > On Sat, 23 Apr 2022, Alan Stern wrote:
> > > > > This patch adds a "gadget" bus and uses it for registering gadgets and
> > > > > their drivers.  From now on, bindings will be managed by the driver
> > > > > core rather than through ad-hoc manipulations in the UDC core.
> > > > >
> > > > > As part of this change, the driver_pending_list is removed.  The UDC
> > > > > core won't need to keep track of unbound drivers for later binding,
> > > > > because the driver core handles all of that for us.
> > > > >
> > > > > However, we do need one new feature: a way to prevent gadget drivers
> > > > > from being bound to more than one gadget at a time.  The existing code
> > > > > does this automatically, but the driver core doesn't -- it's perfectly
> > > > > happy to bind a single driver to all the matching devices on the bus.
> > > > > The patch adds a new bitflag to the usb_gadget_driver structure for
> > > > > this purpose.
> > > > >
> > > > > A nice side effect of this change is a reduction in the total lines of
> > > > > code, since now the driver core will do part of the work that the UDC
> > > > > used to do.
> > > > >
> > > > > A possible future patch could add udc devices to the gadget bus, say
> > > > > as a separate device type.
> > > > >
> > > > > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > > >
> > > > Thanks for your patch, which is now commit fc274c1e997314bf ("USB:
> > > > gadget: Add a new bus for gadgets") in usb-next.
> > > >
> > > > This patch cause a regression on the Renesas Salvator-XS development
> > > > board, as R-Car H3 has multiple USB gadget devices:
> > >
> > > Then these gadgets ought to have distinct names in order to avoid the
> > > conflict below:
> > >
> > > >     sysfs: cannot create duplicate filename '/bus/gadget/devices/gadget'
> > > >     CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.18.0-rc1-arm64-renesas-00074-gfc274c1e9973 #1587
> > > >     Hardware name: Renesas Salvator-X 2nd version board based on r8a77951 (DT)
> > > >     Call trace:
> > > >      dump_backtrace+0xcc/0xd8
> > > >      show_stack+0x14/0x30
> > > >      dump_stack_lvl+0x88/0xb0
> > > >      dump_stack+0x14/0x2c
> > > >      sysfs_warn_dup+0x60/0x78
> > > >      sysfs_do_create_link_sd.isra.0+0xe4/0xf0
> > > >      sysfs_create_link+0x20/0x40
> > > >      bus_add_device+0x64/0x110
> > > >      device_add+0x31c/0x850
> > > >      usb_add_gadget+0x124/0x1a0
> > > >      usb_add_gadget_udc_release+0x1c/0x50
> > > >      usb_add_gadget_udc+0x10/0x18
> > > >      renesas_usb3_probe+0x450/0x728
> > > ...
> > >
> > > Having three gadget devices, all named "gadget", doesn't seem like a
> > > good idea.
> > 
> > I'm not so sure where these names are coming from.
> > `git grep '"gadget"'` points to the following likely targets:
> > 
> > drivers/usb/gadget/udc/core.c:  dev_set_name(&gadget->dev, "gadget");
> > drivers/usb/renesas_usbhs/mod_gadget.c: gpriv->mod.name         = "gadget";
> > 
> > Changing both names reveals the problem is actually caused by
> > the former ;-)
> 
> Ah, good.
> 
> One way to attack this would be to keep a static counter and dynamically 
> set the name to "gadget.%d" using the counter's value.  Or keep a bitmap 
> of allocated gadget numbers and use the first available number.
> 
> Felipe, Greg, any opinions?

Just use an idr structure for the number, that's the simplest way to
track that.

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9286A4CB172
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 22:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245411AbiCBVhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 16:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240058AbiCBVhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:37:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7A7C7E5D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 13:36:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B727B8223F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 21:36:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFB9C004E1;
        Wed,  2 Mar 2022 21:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646257006;
        bh=wGOLoq8fO/bwBfklot0y6ii49GS28hhpXga2ycZLJdU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lboPQ20XON/WND9HxR5Dwmk0jul4RMqBddy5YACBLugkN1tKUS1+GvTUWoUbP5kaj
         HaRRrCgYeaTKkMVtT9/SqDfkrY2WsahR1FnB7Jkf0EOGLU/ZcplDIQhJVryPb3Xhzy
         wg3aT1kFTlk57cOOoyX0nEFLuBTK7lApVphEmiNA=
Date:   Wed, 2 Mar 2022 22:36:43 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        Tejun Heo <tj@kernel.org>,
        syzbot <syzbot+348b571beb5eeb70a582@syzkaller.appspotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "balbi@kernel.org" <balbi@kernel.org>
Subject: Re: [syzbot] KASAN: use-after-free Read in dev_uevent
Message-ID: <Yh/ja0K9E7ahJf5Q@kroah.com>
References: <YhZiMHHjrBw8am5g@rowland.harvard.edu>
 <PH0PR11MB5880D7544442B4D60810F0D2DA3D9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB588091026B817203C772B264DA3D9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <Yhf3ThBfjWVcYszC@rowland.harvard.edu>
 <YhgIs6FmBJYXiQVw@kroah.com>
 <Yhg5lWdEy2G4SsFr@rowland.harvard.edu>
 <YhiZDy+y1/YmlWL2@kroah.com>
 <Yhj7FO3hisW9yJRN@rowland.harvard.edu>
 <Yhnttj7dA0ZecNj0@kroah.com>
 <Yh/BF2bx1TT3DMPG@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh/BF2bx1TT3DMPG@rowland.harvard.edu>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 02:10:15PM -0500, stern@rowland.harvard.edu wrote:
> On Sat, Feb 26, 2022 at 10:07:02AM +0100, gregkh@linuxfoundation.org wrote:
> > On Fri, Feb 25, 2022 at 10:51:48AM -0500, stern@rowland.harvard.edu wrote:
> > > On Fri, Feb 25, 2022 at 09:53:35AM +0100, gregkh@linuxfoundation.org wrote:
> > > > The aux bus might make this easier:
> > > > 	Documentation/driver-api/auxiliary_bus.rst
> > > 
> > > Won't this end up changing the user-visible filenames and directories in 
> > > sysfs for gadgets and gadget drivers?
> > > 
> > > For instance, currently gadgets get registered under their UDC driver 
> > > name, like "net2280" or "at91".  If we put them on the aux bus then they 
> > > will have to get registered under a name looking something like 
> > > "udc.gadget.0", i.e., module name, generic device name, and ID number.
> > 
> > Ah, yeah, that isn't good.
> > 
> > > We will be forced to use a generic device name because the aux bus does 
> > > matching based on it, and we want every gadget driver to be able to 
> > > match every UDC.  We don't want some gadget drivers restricted to 
> > > net2280 gadgets, others restricted to fotg210 gadgets, and so on.
> > 
> > So yes, I guess it does need to be a "real" bus, sorry.
> 
> It turns out not to be so bad.  In fact there are only five
> gadget drivers (that is, instances of struct usb_gadget_driver) in the 
> kernel:
> 
> 	composite_driver_template	(gadget/composite.c)
> 	configfs_driver_template	(gadget/configfs.c)
> 	gadgetfs_driver			(gadget/legacy/inode.c)
> 	driver				(gadget/legacy/raw_gadget.c)
> 	dbgp_driver			(gadget/legacy/dbgp.c)

I would really love to drop the gadget/legacy/ stuff if at all possible
entirely.  I wonder if that's possible.  I know that Android has moved
off of this, and that used to be the largest user (in the billions), so
we might be ok to possibly just delete these entirely.

> Everything else is implemented as a "function" driver.  So the gadget 
> driver's name doesn't mean very much to the user anyway.

That's good to know.

> The interaction between the gadget subsystem and the device core is 
> rather peculiar.  Each UDC controller is represented by a pair of device 
> structures: the .dev fields in struct usb_udc and struct usb_gadget.  
> These two are siblings -- they always have the same parent (see 
> usb_add_gadget() in gadget/udc/core.c).  Furthermore, they have the same 
> driver; that is, udc->dev.driver is always the same as 
> gadget->dev.driver (see udc_bind_to_driver()).  Which is doubly odd, 
> because gadget drivers manage only gadget devices, not udc devices.  The 
> major difference between them is that the usb_udc is a class device 
> whereas the usb_gadget is a "real" device.
> 
> Currently neither the udc device nor the gadget device is registered on 
> any bus.  IMO it would make sense to leave udc->dev.driver always set to 
> NULL, keep the udc devices bus-less, and put the gadget devices on the 
> aux bus.
> 
> Does that sound reasonable?  I'll work on a patch to do it.

That's odd, but it might work, so sure, let's see how it turns out.

thanks,

greg k-h

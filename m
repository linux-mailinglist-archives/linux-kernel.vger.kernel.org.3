Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C2F4CAE50
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244928AbiCBTLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 14:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244926AbiCBTLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:11:00 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 6520BCA707
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:10:16 -0800 (PST)
Received: (qmail 1244449 invoked by uid 1000); 2 Mar 2022 14:10:15 -0500
Date:   Wed, 2 Mar 2022 14:10:15 -0500
From:   "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        Tejun Heo <tj@kernel.org>,
        syzbot <syzbot+348b571beb5eeb70a582@syzkaller.appspotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "balbi@kernel.org" <balbi@kernel.org>
Subject: Re: [syzbot] KASAN: use-after-free Read in dev_uevent
Message-ID: <Yh/BF2bx1TT3DMPG@rowland.harvard.edu>
References: <YhZaDGeIIvpILdCk@kroah.com>
 <YhZiMHHjrBw8am5g@rowland.harvard.edu>
 <PH0PR11MB5880D7544442B4D60810F0D2DA3D9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB588091026B817203C772B264DA3D9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <Yhf3ThBfjWVcYszC@rowland.harvard.edu>
 <YhgIs6FmBJYXiQVw@kroah.com>
 <Yhg5lWdEy2G4SsFr@rowland.harvard.edu>
 <YhiZDy+y1/YmlWL2@kroah.com>
 <Yhj7FO3hisW9yJRN@rowland.harvard.edu>
 <Yhnttj7dA0ZecNj0@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yhnttj7dA0ZecNj0@kroah.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2022 at 10:07:02AM +0100, gregkh@linuxfoundation.org wrote:
> On Fri, Feb 25, 2022 at 10:51:48AM -0500, stern@rowland.harvard.edu wrote:
> > On Fri, Feb 25, 2022 at 09:53:35AM +0100, gregkh@linuxfoundation.org wrote:
> > > The aux bus might make this easier:
> > > 	Documentation/driver-api/auxiliary_bus.rst
> > 
> > Won't this end up changing the user-visible filenames and directories in 
> > sysfs for gadgets and gadget drivers?
> > 
> > For instance, currently gadgets get registered under their UDC driver 
> > name, like "net2280" or "at91".  If we put them on the aux bus then they 
> > will have to get registered under a name looking something like 
> > "udc.gadget.0", i.e., module name, generic device name, and ID number.
> 
> Ah, yeah, that isn't good.
> 
> > We will be forced to use a generic device name because the aux bus does 
> > matching based on it, and we want every gadget driver to be able to 
> > match every UDC.  We don't want some gadget drivers restricted to 
> > net2280 gadgets, others restricted to fotg210 gadgets, and so on.
> 
> So yes, I guess it does need to be a "real" bus, sorry.

It turns out not to be so bad.  In fact there are only five
gadget drivers (that is, instances of struct usb_gadget_driver) in the 
kernel:

	composite_driver_template	(gadget/composite.c)
	configfs_driver_template	(gadget/configfs.c)
	gadgetfs_driver			(gadget/legacy/inode.c)
	driver				(gadget/legacy/raw_gadget.c)
	dbgp_driver			(gadget/legacy/dbgp.c)

Everything else is implemented as a "function" driver.  So the gadget 
driver's name doesn't mean very much to the user anyway.

The interaction between the gadget subsystem and the device core is 
rather peculiar.  Each UDC controller is represented by a pair of device 
structures: the .dev fields in struct usb_udc and struct usb_gadget.  
These two are siblings -- they always have the same parent (see 
usb_add_gadget() in gadget/udc/core.c).  Furthermore, they have the same 
driver; that is, udc->dev.driver is always the same as 
gadget->dev.driver (see udc_bind_to_driver()).  Which is doubly odd, 
because gadget drivers manage only gadget devices, not udc devices.  The 
major difference between them is that the usb_udc is a class device 
whereas the usb_gadget is a "real" device.

Currently neither the udc device nor the gadget device is registered on 
any bus.  IMO it would make sense to leave udc->dev.driver always set to 
NULL, keep the udc devices bus-less, and put the gadget devices on the 
aux bus.

Does that sound reasonable?  I'll work on a patch to do it.

Alan Stern

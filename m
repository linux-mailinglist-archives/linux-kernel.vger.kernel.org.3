Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB264C38D5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbiBXWiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiBXWiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:38:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09DF18C783
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 14:37:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 584D661B1F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 22:37:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1FCC340E9;
        Thu, 24 Feb 2022 22:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645742262;
        bh=wtcBzWooL32dNZOr+Z536waTgYAuQ0OCmkwF/qD5HLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xw962sorCN8Y5u6rerZAVg2CHHt/+Upk7sbdDEYKQgC83AUyiotOJvnbqwLt0NwZm
         w0ZKsvCmOKezjbRo8IjM5m6HFNVhfWfTko/Dt/s4CCP8klf5prGDcnGbSA6SUleDH8
         OHyrB86MP1sGunh7hJ0myk6tJgzONdpcV9rDEqBc=
Date:   Thu, 24 Feb 2022 23:37:39 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        Tejun Heo <tj@kernel.org>,
        syzbot <syzbot+348b571beb5eeb70a582@syzkaller.appspotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "balbi@kernel.org" <balbi@kernel.org>
Subject: Re: [syzbot] KASAN: use-after-free Read in dev_uevent
Message-ID: <YhgIs6FmBJYXiQVw@kroah.com>
References: <0000000000005a991a05a86970bb@google.com>
 <00000000000033314805d8765175@google.com>
 <PH0PR11MB58805E3C4CF7D4C41D49BFCFDA3C9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <YhYafwiwUV2Sbn5t@kroah.com>
 <YhZG3GJb8G7oL7l7@rowland.harvard.edu>
 <YhZaDGeIIvpILdCk@kroah.com>
 <YhZiMHHjrBw8am5g@rowland.harvard.edu>
 <PH0PR11MB5880D7544442B4D60810F0D2DA3D9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB588091026B817203C772B264DA3D9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <Yhf3ThBfjWVcYszC@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yhf3ThBfjWVcYszC@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 04:23:26PM -0500, stern@rowland.harvard.edu wrote:
> On Thu, Feb 24, 2022 at 03:14:54AM +0000, Zhang, Qiang1 wrote:
> > 
> > On Wed, Feb 23, 2022 at 05:00:12PM +0100, gregkh@linuxfoundation.org wrote:
> > > On Wed, Feb 23, 2022 at 09:38:20AM -0500, stern@rowland.harvard.edu wrote:
> > > > Which bus locks are you referring to?  I'm not aware of any locks 
> > > > that synchronize dev_uevent() with anything (in particular, with 
> > > > driver unbinding).
> > > 
> > > The locks in the driver core that handle the binding and unbinding of 
> > > drivers to devices.
> > > 
> > > > And as far as I know, usb_gadget_remove_driver() doesn't play any 
> > > > odd tricks with pointers.
> > > 
> > > Ah, I never noticed that this is doing a "fake" bus and does the 
> > > bind/unbind itself outside of the driver core.  It should just be a 
> > > normal bus type and have the core do the work for it, but oh well.
> > > 
> > > And there is a lock that should serialize all of this already, so it's 
> > > odd that this is able to be triggered at all.
> > 
> > >>I guess at a minimum the UDC core should hold the device lock when it registers, unregisters, binds, or unbinds UDC and gadget devices.  
> > >>Would that be enough to fix the problem?  I really don't understand how sysfs file access gets synchronized with device removal.
> > 
> > >>>
> > >>>Agree with you, in usb_gadget_remove_driver() function, the udc->dev.driver and udc->gadget->dev.driver be set to null without any protection, so when the udevd accessed the dev->driver, this address may be invalid at this time.
> > >>>maybe the operation of dev->driver can be protected by device_lock(). 
> > >>>
> > 
> > Is it enough that we just need to protect "dev.driver" ?
> 
> I don't know, although I doubt it.  The right way to fix it is to make 
> sure that the existing protections, which apply to drivers that are 
> registered in the driver core, can also work properly with gadgets.  But 
> I don't know what those protections are or how they work.
> 
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 3d6430eb0c6a..9bd2624973d7 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -2316,8 +2316,10 @@ static int dev_uevent(struct kobject *kobj, struct kobj_uevent_env *env)
> >         if (dev->type && dev->type->name)
> >                 add_uevent_var(env, "DEVTYPE=%s", dev->type->name);
> > 
> > +       device_lock(dev);
> >         if (dev->driver)
> >                 add_uevent_var(env, "DRIVER=%s", dev->driver->name);
> > +       device_unlock(dev);
> 
> You probably should not do this.  Unless there's a serious bug, the 
> driver core already takes all the locks it needs.  Doing this might 
> cause a deadlock (because the caller may already hold the device lock).
> 
> > 
> >         /* Add common DT information about the device */
> >         of_device_uevent(dev, env);
> > diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> > index 568534a0d17c..7877142397d3 100644
> > --- a/drivers/usb/gadget/udc/core.c
> > +++ b/drivers/usb/gadget/udc/core.c
> > @@ -1436,8 +1436,14 @@ static void usb_gadget_remove_driver(struct usb_udc *udc)
> >         usb_gadget_udc_stop(udc);
> > 
> >         udc->driver = NULL;
> > +
> > +       device_lock(&udc->dev);
> >         udc->dev.driver = NULL;
> > +       device_unlock(&udc->dev);
> > +
> > +       device_lock(&udc->gadget->dev);
> >         udc->gadget->dev.driver = NULL;
> > +       device_unlock(&udc->gadget->dev);
> >  }
> 
> These are reasonable things to do, but I don't know if they will fix the 
> problem.
> 
> We really should ask advice from somebody who understands how this stuff 
> is supposed to work.  I'm not sure who to ask, though.  Tejun Heo, 
> perhaps (CC'ed).
> 
> Tejun: The USB Gadget core binds and unbinds drivers without using the 
> normal driver core facilities (see the code in 
> usb_gadget_remove_driver() above).  As a result, unbinding races with 
> uevent generation, which can lead to a NULL pointer dereference as found 
> by syzbot testing.  In particular, dev->driver can become NULL between 
> the times when dev_uevent() tests it and uses it (see above).
> 
> Can you tell us how this should be fixed?

It should be fixed by properly using the driver core to bind/unbind the
driver to devices like I mentioned previously :)

That will be more work, but it's the correct fix here.  Otherwise it
needs to take the same bus locks that the device lives on to keep things
in sync, like the driver core would do if it were managing these things.
That could be the "short term" fix if no one wants to do the real work
needed here.  Nothing should be needed to change in the driver core
itself, it is rightfully thinking it owns the device and can free it
when needed.

thanks,

greg k-h

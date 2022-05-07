Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B17E51E804
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 17:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385632AbiEGPKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 11:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238606AbiEGPKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 11:10:44 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id DB7F2237E4
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 08:06:56 -0700 (PDT)
Received: (qmail 74041 invoked by uid 1000); 7 May 2022 11:06:55 -0400
Date:   Sat, 7 May 2022 11:06:55 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Schspa Shi <schspa@gmail.com>, andreyknvl@gmail.com,
        balbi@kernel.org, jj251510319013@gmail.com, jannh@google.com,
        Julia.Lawall@inria.fr, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+dc7c3ca638e773db07f6@syzkaller.appspotmail.com
Subject: Re: [PATCH] usb: gadget: fix race when gadget driver register via
 ioctl
Message-ID: <YnaLDxcaCGMmETuP@rowland.harvard.edu>
References: <20220507120851.29948-1-schspa@gmail.com>
 <YnaBwkhIxZ1wtIQX@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnaBwkhIxZ1wtIQX@kroah.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2022 at 04:27:14PM +0200, Greg KH wrote:
> On Sat, May 07, 2022 at 08:08:51PM +0800, Schspa Shi wrote:
> > The usb_gadget_register_driver doesn't have inside locks to protect the
> > driver, and If there is two threads are registered at the same time via
> > the ioctl syscall, the system will crash as syzbot reported.
> > 
> > Call trace as:
> >   driver_register+0x220/0x3a0 drivers/base/driver.c:171
> >   usb_gadget_register_driver_owner+0xfb/0x1e0
> >     drivers/usb/gadget/udc/core.c:1546
> >   raw_ioctl_run drivers/usb/gadget/legacy/raw_gadget.c:513 [inline]
> >   raw_ioctl+0x1883/0x2730 drivers/usb/gadget/legacy/raw_gadget.c:1220
> > 
> > This routine allows two processes to register the same driver instance
> > via ioctl syscall. which lead to a race condition.
> > 
> > We can fix it by adding a driver_lock to avoid double register.
> > 
> > Reported-by: syzbot+dc7c3ca638e773db07f6@syzkaller.appspotmail.com
> > Link: https://lore.kernel.org/all/000000000000e66c2805de55b15a@google.com/
> > 
> > Signed-off-by: Schspa Shi <schspa@gmail.com>
> > ---
> >  drivers/usb/gadget/legacy/raw_gadget.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
> > index b3be8db1ff63..d7ff9c2b5397 100644
> > --- a/drivers/usb/gadget/legacy/raw_gadget.c
> > +++ b/drivers/usb/gadget/legacy/raw_gadget.c
> > @@ -155,7 +155,9 @@ struct raw_dev {
> >  	spinlock_t			lock;
> >  
> >  	const char			*udc_name;
> > +	/* Protected by driver_lock for reentrant registration */
> >  	struct usb_gadget_driver	driver;
> > +	struct mutex			driver_lock;
> 
> Why are you adding another lock here?  What's wrong with the existing
> lock in this structure that requires an additional one?
> 
> >  
> >  	/* Reference to misc device: */
> >  	struct device			*dev;
> > @@ -188,6 +190,8 @@ static struct raw_dev *dev_new(void)
> >  	spin_lock_init(&dev->lock);
> >  	init_completion(&dev->ep0_done);
> >  	raw_event_queue_init(&dev->queue);
> > +	mutex_init(&dev->driver_lock);
> > +
> >  	return dev;
> >  }
> >  
> > @@ -398,7 +402,9 @@ static int raw_release(struct inode *inode, struct file *fd)
> >  	spin_unlock_irqrestore(&dev->lock, flags);
> >  
> >  	if (unregister) {
> > +		mutex_lock(&dev->driver_lock);
> >  		ret = usb_gadget_unregister_driver(&dev->driver);
> > +		mutex_unlock(&dev->driver_lock);
> >  		if (ret != 0)
> >  			dev_err(dev->dev,
> >  				"usb_gadget_unregister_driver() failed with %d\n",
> > @@ -510,7 +516,9 @@ static int raw_ioctl_run(struct raw_dev *dev, unsigned long value)
> >  	}
> >  	spin_unlock_irqrestore(&dev->lock, flags);
> >  
> > +	mutex_lock(&dev->driver_lock);
> >  	ret = usb_gadget_register_driver(&dev->driver);
> > +	mutex_unlock(&dev->driver_lock);
> 
> How can unregister race with register?
> 
> What ioctl is causing this race?  What userspace program is doing this?
> Only one userspace program should be accessing this at once, right?

These questions are on the right track.

The problem here is not insufficient locking.  The problem is that 
dev->state does not have a special state to indicate that the driver is 
being registered.

Before calling usb_gadget_register_driver(), while still holding 
dev->lock, the code should change dev->state to STATE_DEV_REGISTERING.  
Then no race can occur, because the second thread to acquire the 
spinlock will see that dev->state is not equal to STATE_DEV_INITIALIZED.

Alan Stern

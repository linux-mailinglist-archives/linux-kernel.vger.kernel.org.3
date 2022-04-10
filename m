Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6344FAE72
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 17:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243429AbiDJPXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 11:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiDJPX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 11:23:28 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0F79111162
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 08:21:16 -0700 (PDT)
Received: (qmail 314411 invoked by uid 1000); 10 Apr 2022 11:21:15 -0400
Date:   Sun, 10 Apr 2022 11:21:15 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Maxim Devaev <mdevaev@gmail.com>
Cc:     linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cai Huoqing <caihuoqing@baidu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_mass_storage: break IO operations via
 configfs
Message-ID: <YlL164UHvCV0ti4U@rowland.harvard.edu>
References: <Yk8L6b9wEWTjWOg4@rowland.harvard.edu>
 <20220407204553.35cead72@reki>
 <YlBN4Zcn9NYw0PLA@rowland.harvard.edu>
 <20220409115756.4f9b015d@reki>
 <YlGOOJ9SwkD7WVmX@rowland.harvard.edu>
 <20220409170837.02f0853f@reki>
 <YlHrBdYkBSR0L6FL@rowland.harvard.edu>
 <20220410014228.117d9f66@reki>
 <YlI5b1SNdsVnuo/v@rowland.harvard.edu>
 <20220410051804.315fb0d9@reki>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220410051804.315fb0d9@reki>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2022 at 05:18:04AM +0300, Maxim Devaev wrote:
> В Sat, 9 Apr 2022 21:57:03 -0400
> Alan Stern <stern@rowland.harvard.edu> пишет:
> 
> > On Sun, Apr 10, 2022 at 01:42:28AM +0300, Maxim Devaev wrote:
> > > В Sat, 9 Apr 2022 16:22:29 -0400
> > > Alan Stern <stern@rowland.harvard.edu> wrote:  
> > > > > I'm using Raspberry Pi with DWC2. So:
> > > > > - Connect RPi-based gadget to the Linux host.
> > > > > - Set image in the "file" attribute.    
> > > > 
> > > > Exactly what is the full pathname you're using for the "file" attribute?  
> > > 
> > > /sys/kernel/config/usb_gadget/kvmd/functions/mass_storage.usb0/lun.0/file  
> > 
> > Yeah, that doesn't seem right at all.
> > 
> > You're doing this under KVM, right?  Is the gadget driver running in the 
> > host OS or the guest OS?  And the sysfs file accesses -- are they in the 
> > host's filesystem or in the guest's?
> > 
> > What happens if you don't use KVM and just load the gadget driver on the 
> > physical machine?
> 
> We really have a miscommunication :) Speaking of KVM, I mean KVM-over-IP,
> a physical device that emulates Keyboard-Video-Mouse. It is made on the
> Raspberry Pi and is physically connected via USB to another host machine
> to emulate mass storage, among other things. So, we have two physical devices:
> with USB host and USB gadget.

Okay, I see where I misunderstood.  Oops.  :-)

> > > > I also tried sending a USR1 signal to the driver's kernel thread while 
> > > > an image was mounted and being accessed.  It did clear the prevent_allow 
> > > > flag, so I could eject the image.  But it also caused a 30-second delay 
> > > > on the host, as predicted.  Now, maybe you don't care about such delays 
> > > > when you're going to eject the media anyway, but it still seems like a 
> > > > bad thing to do.  
> > > 
> > > It looks like the prevent_medium_removal flag switching really works better in this case.  
> > 
> > I don't understand that comment.  In what case?  Works better than what?
> 
> Sorry, better than SIGUSR1. The patch that only sets the prevent_medium_removal=0
> and makes the "file" empty.

Ah, yes, I agree.

> > > > > > > I have reflected on the rest of your arguments and changed my mind.
> > > > > > > I think that "forced_eject" for a specific lun without interrupting operations would
> > > > > > > really be the best solution. I wrote a simple patch and tested it, everything seems
> > > > > > > to work. What do you think about something like this?
> > > > > > > 
> > > > > > > 
> > > > > > > static ssize_t fsg_lun_opts_forced_eject_store(struct config_item *item,
> > > > > > >                                                const char *page, size_t len)
> > > > > > > {
> > > > > > >         struct fsg_lun_opts *opts = to_fsg_lun_opts(item);
> > > > > > >         struct fsg_opts *fsg_opts = to_fsg_opts(opts->group.cg_item.ci_parent);
> > > > > > >         int ret;
> > > > > > > 
> > > > > > >         opts->lun->prevent_medium_removal = 0;
> > > > > > >         ret = fsg_store_file(opts->lun, &fsg_opts->common->filesem, "", 0);
> > > > > > >         return ret < 0 ? ret : len;
> > > > > > > }
> > > > > > > 
> > > > > > > CONFIGFS_ATTR_WO(fsg_lun_opts_, forced_eject);      
> > > > > > 
> > > > > > The basic idea is right.  But this should not be a CONFIGFS option; it 
> > > > > > should be an ordinary LUN attribute.  For an example, see the definition of 
> > > > > > file_store() in f_mass_storage.c; your routine should look very similar.    
> > > > > 
> > > > > Okay, but where this attribute is located in sysfs? How can I use it?    
> > > > 
> > > > Well, it's going to be in different places depending on what UDC driver 
> > > > your gadget uses.  On my system I'm using the dummy_udc driver, so the 
> > > > sysfs "file" attribute is located at:
> > > > 
> > > > 	/sys/devices/platform/dummy_ucd.0/gadget/lun0/file
> > > > 
> > > > If instead you're looking at
> > > > 
> > > > 	/sys/module/g_mass_storage/parameters/file
> > > > 
> > > > or in some configfs directory, that's the wrong place.  You can eject 
> > > > the media simply by doing (as root):
> > > > 
> > > > 	echo >/sys/devices/.../gadget/lun0/file
> > > > 
> > > > (fill in the "..." appropriately for your system).
> > > >   
> > > > > Sorry for the stupid question.    
> > > > 
> > > > Not at all.  
> > > 
> > > Thanks! Unfortunately I'm using dwc2 driver and it doesn't have any gadget parameters
> > > outside of the configfs:
> > > 
> > > [root@pikvm ~]# find /sys -iname lun0
> > > [root@pikvm ~]# find /sys -iname lun.0
> > > /sys/kernel/config/usb_gadget/kvmd/functions/mass_storage.usb0/lun.0
> > > [root@pikvm ~]#
> > > 
> > > So in my local case configfs is only way to place forced_eject :(  
> > 
> > That can't possibly be right.  Again, we may be miscommunicating because 
> > of the way you're using KVM.
> > 
> > What happens if you set up the gadget using g-mass-storage instead of 
> > configfs?  For example:
> > 
> > 	modprobe g-mass-storage cdrom=y removable=y ro=y file=...
> >
> > > Could we add both device attrs and configfs file?  
> > 
> > No.  Configfs files are for setting up the gadget in the first place, or 
> > changing its configuration while it isn't attached to a host.  Device 
> > attribute files are for modifying the gadget while it is running.
> > 
> I've tried and got this:
> 
> [root@pikvm ~]# modprobe g-mass-storage cdrom=y removable=y ro=y file=/var/lib/kvmd/msd/images/dsl-4.11.rc1.iso
> [root@pikvm ~]# find /sys -iname lun.0
> [root@pikvm ~]# find /sys -iname lun0
> /sys/devices/platform/soc/fe980000.usb/gadget/lun0
> [root@pikvm ~]# ls /sys/devices/platform/soc/fe980000.usb/gadget/lun0
> power  file  nofua  ro  uevent
> 
> But with libcomposite and configfs I don't have "/sys/devices/platform/soc/fe980000.usb/gadget/lun0" at all:
> 
> [root@pikvm ~]# ls /sys/devices/platform/soc/fe980000.usb/gadget/
> power  suspended  uevent
> 
> So all this timed I used configfs to change parameters.
> I thought this was the way it was intended because the code for changing configfs
> and device attributes is almost identical and everything worked.
> If I don't have device attributes when using libcomposite, then how am I supposed
> to change its settings in runtime, if not through configfs?

All right.  I've never used configfs before, so my understanding of it 
was out of date.  After reading through the documentation and the code, 
it's clear now that you're right and there should be both a device 
attribute and a configfs file.

Unlike the fsg_lun_opts_forced_eject_store() example you wrote above, 
but like the existing fsg_lun_opts_file_store() and file_store() 
routines, both of your new routines should call a single 
fsg_store_forced_eject() function in storage_common.c to do the real 
work.  Namely, something like:

	lun->prevent_medium_removal = 0;
	return fsg_store_file(lun, filesem, "", 0);

That should accomplish what you're looking for, in all possible 
configurations.

Alan Stern

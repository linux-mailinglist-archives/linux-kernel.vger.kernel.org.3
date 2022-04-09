Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9624FAAB4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 22:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbiDIUYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 16:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbiDIUYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 16:24:40 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 6D24B2BCE
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 13:22:30 -0700 (PDT)
Received: (qmail 293258 invoked by uid 1000); 9 Apr 2022 16:22:29 -0400
Date:   Sat, 9 Apr 2022 16:22:29 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Maxim Devaev <mdevaev@gmail.com>
Cc:     linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cai Huoqing <caihuoqing@baidu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_mass_storage: break IO operations via
 configfs
Message-ID: <YlHrBdYkBSR0L6FL@rowland.harvard.edu>
References: <Yk2wvhSTMKTLFK6c@rowland.harvard.edu>
 <20220406195234.4f63cb4a@reki>
 <Yk3TLPKyaQDsnuD4@rowland.harvard.edu>
 <20220406213634.104cae45@reki>
 <Yk8L6b9wEWTjWOg4@rowland.harvard.edu>
 <20220407204553.35cead72@reki>
 <YlBN4Zcn9NYw0PLA@rowland.harvard.edu>
 <20220409115756.4f9b015d@reki>
 <YlGOOJ9SwkD7WVmX@rowland.harvard.edu>
 <20220409170837.02f0853f@reki>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220409170837.02f0853f@reki>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2022 at 05:08:37PM +0300, Maxim Devaev wrote:
> В Sat, 9 Apr 2022 09:46:32 -0400
> Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > On Sat, Apr 09, 2022 at 11:57:56AM +0300, Maxim Devaev wrote:
> > > В Fri, 8 Apr 2022 10:59:45 -0400
> > > Alan Stern <stern@rowland.harvard.edu> wrote:  
> > > > > At least there is one situation where the behavior of f_mass_storage differs
> > > > > from the behavior of a real drive. What happens when you click on the physical
> > > > > "eject" button?    
> > > > 
> > > > If the host has prevented ejection, nothing happens.  Otherwise the disc 
> > > > gets ejected.
> > > >   
> > > > > Yes, the OS can block this, but the problem is that we don't have
> > > > > an "eject" here.    
> > > > 
> > > > What do you mean?  Writing an empty string to the sysfs "file" attribute 
> > > > is the virtual analog of pressing the eject button.  
> > > 
> > > But I can't eject the disc event it's not mounted on Linux host. It seems to me
> > > it differs from the real drive behavior.  
> > 
> > It sounds like either there's a bug or else you're not doing the right 
> > thing.  Tell me exactly what you do when this fails.
> 
> I'm using Raspberry Pi with DWC2. So:
> - Connect RPi-based gadget to the Linux host.
> - Set image in the "file" attribute.

Exactly what is the full pathname you're using for the "file" attribute?

> - Mount gadget's drive on the Linux host.
> - Umount it.
> - Try to eject using emptying the "file" attribute.
> - Get EBUSY error.

This must mean that some program on the host is keeping the device file 
open, even though it isn't mounted.  (I tried running a similar test on 
my system and it worked perfectly, with no other programs accessing the 
device).  You might be able to identify which program is accessing the 
device by running lsof on the host and searching the output for the 
device name.

I also tried sending a USR1 signal to the driver's kernel thread while 
an image was mounted and being accessed.  It did clear the prevent_allow 
flag, so I could eject the image.  But it also caused a 30-second delay 
on the host, as predicted.  Now, maybe you don't care about such delays 
when you're going to eject the media anyway, but it still seems like a 
bad thing to do.

> > > I have reflected on the rest of your arguments and changed my mind.
> > > I think that "forced_eject" for a specific lun without interrupting operations would
> > > really be the best solution. I wrote a simple patch and tested it, everything seems
> > > to work. What do you think about something like this?
> > > 
> > > 
> > > static ssize_t fsg_lun_opts_forced_eject_store(struct config_item *item,
> > >                                                const char *page, size_t len)
> > > {
> > >         struct fsg_lun_opts *opts = to_fsg_lun_opts(item);
> > >         struct fsg_opts *fsg_opts = to_fsg_opts(opts->group.cg_item.ci_parent);
> > >         int ret;
> > > 
> > >         opts->lun->prevent_medium_removal = 0;
> > >         ret = fsg_store_file(opts->lun, &fsg_opts->common->filesem, "", 0);
> > >         return ret < 0 ? ret : len;
> > > }
> > > 
> > > CONFIGFS_ATTR_WO(fsg_lun_opts_, forced_eject);  
> > 
> > The basic idea is right.  But this should not be a CONFIGFS option; it 
> > should be an ordinary LUN attribute.  For an example, see the definition of 
> > file_store() in f_mass_storage.c; your routine should look very similar.
> 
> Okay, but where this attribute is located in sysfs? How can I use it?

Well, it's going to be in different places depending on what UDC driver 
your gadget uses.  On my system I'm using the dummy_udc driver, so the 
sysfs "file" attribute is located at:

	/sys/devices/platform/dummy_ucd.0/gadget/lun0/file

If instead you're looking at

	/sys/module/g_mass_storage/parameters/file

or in some configfs directory, that's the wrong place.  You can eject 
the media simply by doing (as root):

	echo >/sys/devices/.../gadget/lun0/file

(fill in the "..." appropriately for your system).

> Sorry for the stupid question.

Not at all.

Alan Stern

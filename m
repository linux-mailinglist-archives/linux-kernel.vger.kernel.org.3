Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEC853CCE8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 18:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343613AbiFCQDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 12:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343612AbiFCQDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 12:03:35 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id ACBE237BCC
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 09:03:33 -0700 (PDT)
Received: (qmail 305407 invoked by uid 1000); 3 Jun 2022 12:03:32 -0400
Date:   Fri, 3 Jun 2022 12:03:32 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        syzbot <syzbot+dd3c97de244683533381@syzkaller.appspotmail.com>,
        hdanton@sina.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        rafael@kernel.org, rjw@rjwysocki.net,
        syzkaller-bugs@googlegroups.com, linux-usb@vger.kernel.org
Subject: Re: [syzbot] general protection fault in __device_attach
Message-ID: <Ypow1LRZ3Hau36ci@rowland.harvard.edu>
References: <000000000000bb7f1c05da29b601@google.com>
 <00000000000010b7d305e08837c8@google.com>
 <YpnqpMYcokTwCB6u@smile.fi.intel.com>
 <Ypor265BTdnmgwpM@rowland.harvard.edu>
 <YpouRmanvCQeKA3S@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpouRmanvCQeKA3S@kroah.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 05:52:38PM +0200, Greg KH wrote:
> On Fri, Jun 03, 2022 at 11:42:19AM -0400, Alan Stern wrote:
> > On Fri, Jun 03, 2022 at 02:04:04PM +0300, Andy Shevchenko wrote:
> > > On Fri, Jun 03, 2022 at 03:02:07AM -0700, syzbot wrote:
> > > > syzbot has bisected this issue to:
> > > > 
> > > > commit a9c4cf299f5f79d5016c8a9646fa1fc49381a8c1
> > > > Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > Date:   Fri Jun 18 13:41:27 2021 +0000
> > > > 
> > > >     ACPI: sysfs: Use __ATTR_RO() and __ATTR_RW() macros
> > > 
> > > Hmm... It's not obvious at all how this change can alter the behaviour so
> > > drastically. device_add() is called from USB core with intf->dev.name == NULL
> > > by some reason. A-ha, seems like fault injector, which looks like
> > > 
> > > 	dev_set_name(&intf->dev, "%d-%s:%d.%d", dev->bus->busnum,
> > > 		     dev->devpath, configuration, ifnum);
> > > 
> > > missed the return code check.
> > > 
> > > But I'm not familiar with that code at all, adding Linux USB ML and Alan.
> > 
> > I can't see any connection between this bug and acpi/sysfs.c.  Is it a 
> > bad bisection?
> > 
> > It looks like you're right about dev_set_name() failing.  In fact, the 
> > kernel appears to be littered with calls to that routine which do not 
> > check the return code (the entire subtree below drivers/usb/ contains 
> > only _one_ call that does check the return code!).  The function doesn't 
> > have any __must_check annotation, and its kerneldoc doesn't mention the 
> > return code or the possibility of a failure.
> > 
> > Apparently the assumption is that if dev_set_name() fails then 
> > device_add() later on will also fail, and the problem will be detected 
> > then.
> > 
> > So now what should happen when device_add() for an interface fails in 
> > usb_set_configuration()?
> 
> But how can that really fail on a real system?
> 
> Is this just due to error-injection stuff?  If so, I'm really loath to
> rework the world for something that can never happen in real life.
> 
> Or is this a real syzbot-found-with-reproducer issue?

Aren't there quite a few reasons why device_add() might fail?  (Although 
most of them probably are memory allocation errors...)

Basically, you have to make up your mind.  If a function can fail, you 
should be prepared to handle the failure.  If it can't fail, there's no 
point in even checking the return code.

Alan Stern

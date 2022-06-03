Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5868053CC7A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245626AbiFCPm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245625AbiFCPmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:42:23 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 779769FD9
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 08:42:19 -0700 (PDT)
Received: (qmail 304861 invoked by uid 1000); 3 Jun 2022 11:42:19 -0400
Date:   Fri, 3 Jun 2022 11:42:19 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     syzbot <syzbot+dd3c97de244683533381@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, hdanton@sina.com, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael.j.wysocki@intel.com, rafael@kernel.org, rjw@rjwysocki.net,
        syzkaller-bugs@googlegroups.com, linux-usb@vger.kernel.org
Subject: Re: [syzbot] general protection fault in __device_attach
Message-ID: <Ypor265BTdnmgwpM@rowland.harvard.edu>
References: <000000000000bb7f1c05da29b601@google.com>
 <00000000000010b7d305e08837c8@google.com>
 <YpnqpMYcokTwCB6u@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpnqpMYcokTwCB6u@smile.fi.intel.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 02:04:04PM +0300, Andy Shevchenko wrote:
> On Fri, Jun 03, 2022 at 03:02:07AM -0700, syzbot wrote:
> > syzbot has bisected this issue to:
> > 
> > commit a9c4cf299f5f79d5016c8a9646fa1fc49381a8c1
> > Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Date:   Fri Jun 18 13:41:27 2021 +0000
> > 
> >     ACPI: sysfs: Use __ATTR_RO() and __ATTR_RW() macros
> 
> Hmm... It's not obvious at all how this change can alter the behaviour so
> drastically. device_add() is called from USB core with intf->dev.name == NULL
> by some reason. A-ha, seems like fault injector, which looks like
> 
> 	dev_set_name(&intf->dev, "%d-%s:%d.%d", dev->bus->busnum,
> 		     dev->devpath, configuration, ifnum);
> 
> missed the return code check.
> 
> But I'm not familiar with that code at all, adding Linux USB ML and Alan.

I can't see any connection between this bug and acpi/sysfs.c.  Is it a 
bad bisection?

It looks like you're right about dev_set_name() failing.  In fact, the 
kernel appears to be littered with calls to that routine which do not 
check the return code (the entire subtree below drivers/usb/ contains 
only _one_ call that does check the return code!).  The function doesn't 
have any __must_check annotation, and its kerneldoc doesn't mention the 
return code or the possibility of a failure.

Apparently the assumption is that if dev_set_name() fails then 
device_add() later on will also fail, and the problem will be detected 
then.

So now what should happen when device_add() for an interface fails in 
usb_set_configuration()?  I guess the interface should be deleted; 
otherwise we have the possibility that people might still try to access 
it via usbfs, as in the syzbot test run.  Same goes for the 
of_device_is_available() check.

Fixing that will be a little painful.  Right now there are plenty of 
places in the USB core that aren't prepared to cope with a non-existent 
interface.

Alan Stern

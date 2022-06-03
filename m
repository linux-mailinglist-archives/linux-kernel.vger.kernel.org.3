Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D215D53CCAD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343489AbiFCPxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245746AbiFCPxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:53:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C03BE04;
        Fri,  3 Jun 2022 08:53:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3322618EA;
        Fri,  3 Jun 2022 15:53:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A52AC385A9;
        Fri,  3 Jun 2022 15:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654271600;
        bh=BSsxCUjvHnMHsWdDP5bKcDrYnrEorYKAbCgrI7QnQlI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N1xbAa9Qa7xu/WGbuV8KBNO/vbVHdNpsVDcbRLTkU6gKPqljWMncNQZnDHFZrf3TK
         hE61syou/ot0f8G+XQiP7D6MP1bNyKXVVF25z8PgZoFbjCyd/lnMNeIKLPL+3Hh8oU
         4jgQw74y1MuxReWAIfnfXfsm4q9SRXeISlvEjjkE=
Date:   Fri, 3 Jun 2022 17:52:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        syzbot <syzbot+dd3c97de244683533381@syzkaller.appspotmail.com>,
        hdanton@sina.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        rafael@kernel.org, rjw@rjwysocki.net,
        syzkaller-bugs@googlegroups.com, linux-usb@vger.kernel.org
Subject: Re: [syzbot] general protection fault in __device_attach
Message-ID: <YpouRmanvCQeKA3S@kroah.com>
References: <000000000000bb7f1c05da29b601@google.com>
 <00000000000010b7d305e08837c8@google.com>
 <YpnqpMYcokTwCB6u@smile.fi.intel.com>
 <Ypor265BTdnmgwpM@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ypor265BTdnmgwpM@rowland.harvard.edu>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 11:42:19AM -0400, Alan Stern wrote:
> On Fri, Jun 03, 2022 at 02:04:04PM +0300, Andy Shevchenko wrote:
> > On Fri, Jun 03, 2022 at 03:02:07AM -0700, syzbot wrote:
> > > syzbot has bisected this issue to:
> > > 
> > > commit a9c4cf299f5f79d5016c8a9646fa1fc49381a8c1
> > > Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Date:   Fri Jun 18 13:41:27 2021 +0000
> > > 
> > >     ACPI: sysfs: Use __ATTR_RO() and __ATTR_RW() macros
> > 
> > Hmm... It's not obvious at all how this change can alter the behaviour so
> > drastically. device_add() is called from USB core with intf->dev.name == NULL
> > by some reason. A-ha, seems like fault injector, which looks like
> > 
> > 	dev_set_name(&intf->dev, "%d-%s:%d.%d", dev->bus->busnum,
> > 		     dev->devpath, configuration, ifnum);
> > 
> > missed the return code check.
> > 
> > But I'm not familiar with that code at all, adding Linux USB ML and Alan.
> 
> I can't see any connection between this bug and acpi/sysfs.c.  Is it a 
> bad bisection?
> 
> It looks like you're right about dev_set_name() failing.  In fact, the 
> kernel appears to be littered with calls to that routine which do not 
> check the return code (the entire subtree below drivers/usb/ contains 
> only _one_ call that does check the return code!).  The function doesn't 
> have any __must_check annotation, and its kerneldoc doesn't mention the 
> return code or the possibility of a failure.
> 
> Apparently the assumption is that if dev_set_name() fails then 
> device_add() later on will also fail, and the problem will be detected 
> then.
> 
> So now what should happen when device_add() for an interface fails in 
> usb_set_configuration()?

But how can that really fail on a real system?

Is this just due to error-injection stuff?  If so, I'm really loath to
rework the world for something that can never happen in real life.

Or is this a real syzbot-found-with-reproducer issue?

thanks,

greg k-h

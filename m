Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6AD553CD32
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 18:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343905AbiFCQ12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 12:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238628AbiFCQ10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 12:27:26 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id BBF2C1836F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 09:27:25 -0700 (PDT)
Received: (qmail 306240 invoked by uid 1000); 3 Jun 2022 12:27:25 -0400
Date:   Fri, 3 Jun 2022 12:27:25 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        syzbot <syzbot+dd3c97de244683533381@syzkaller.appspotmail.com>,
        hdanton@sina.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        rafael@kernel.org, rjw@rjwysocki.net,
        syzkaller-bugs@googlegroups.com, linux-usb@vger.kernel.org
Subject: Re: [syzbot] general protection fault in __device_attach
Message-ID: <Ypo2bbTfzdH3jH42@rowland.harvard.edu>
References: <000000000000bb7f1c05da29b601@google.com>
 <00000000000010b7d305e08837c8@google.com>
 <YpnqpMYcokTwCB6u@smile.fi.intel.com>
 <Ypor265BTdnmgwpM@rowland.harvard.edu>
 <YpouRmanvCQeKA3S@kroah.com>
 <Ypow1LRZ3Hau36ci@rowland.harvard.edu>
 <Ypoyy/stICFdHauR@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ypoyy/stICFdHauR@kroah.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 06:11:55PM +0200, Greg KH wrote:
> On Fri, Jun 03, 2022 at 12:03:32PM -0400, Alan Stern wrote:
> > On Fri, Jun 03, 2022 at 05:52:38PM +0200, Greg KH wrote:
> > > On Fri, Jun 03, 2022 at 11:42:19AM -0400, Alan Stern wrote:
> > > > So now what should happen when device_add() for an interface fails in 
> > > > usb_set_configuration()?
> > > 
> > > But how can that really fail on a real system?
> > > 
> > > Is this just due to error-injection stuff?  If so, I'm really loath to
> > > rework the world for something that can never happen in real life.
> > > 
> > > Or is this a real syzbot-found-with-reproducer issue?
> > 
> > Aren't there quite a few reasons why device_add() might fail?  (Although 
> > most of them probably are memory allocation errors...)
> 
> I was thinking of the dev_set_name() issue further back in the call
> chain.

As far as I know, the only reason for dev_set_name() to fail is -ENOMEM.  
That's not something the user can control directly.

> > Basically, you have to make up your mind.  If a function can fail, you 
> > should be prepared to handle the failure.  If it can't fail, there's no 
> > point in even checking the return code.
> 
> True, ok, we should unwind the mess.  I'll try to look at it after the
> merge window...
> 
> But again, is this a "real and able to be triggered from userspace"
> problem, or just fault-injection-induced?

I don't think any of the failure paths here are controlled by the user.  
They all seem to involve something going wrong internally in the kernel 
(i.e., corruption or memory allocation failure for a small buffer).  
Once that happens, the game is pretty much over anyway.

Is it worth handling this sort of thing, or should we ignore the 
possibility and allow it to escalate to the point where the user can 
potentially trigger a kernel panic?  Another way of putting it is: How 
gracefully do you want the kernel to collapse when this sort of 
corruption happens?

Alan Stern

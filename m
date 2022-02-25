Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28AA4C499A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 16:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242366AbiBYPw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 10:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbiBYPwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 10:52:22 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 718371CF084
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 07:51:49 -0800 (PST)
Received: (qmail 1082425 invoked by uid 1000); 25 Feb 2022 10:51:48 -0500
Date:   Fri, 25 Feb 2022 10:51:48 -0500
From:   "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        Tejun Heo <tj@kernel.org>,
        syzbot <syzbot+348b571beb5eeb70a582@syzkaller.appspotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "balbi@kernel.org" <balbi@kernel.org>
Subject: Re: [syzbot] KASAN: use-after-free Read in dev_uevent
Message-ID: <Yhj7FO3hisW9yJRN@rowland.harvard.edu>
References: <YhYafwiwUV2Sbn5t@kroah.com>
 <YhZG3GJb8G7oL7l7@rowland.harvard.edu>
 <YhZaDGeIIvpILdCk@kroah.com>
 <YhZiMHHjrBw8am5g@rowland.harvard.edu>
 <PH0PR11MB5880D7544442B4D60810F0D2DA3D9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB588091026B817203C772B264DA3D9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <Yhf3ThBfjWVcYszC@rowland.harvard.edu>
 <YhgIs6FmBJYXiQVw@kroah.com>
 <Yhg5lWdEy2G4SsFr@rowland.harvard.edu>
 <YhiZDy+y1/YmlWL2@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhiZDy+y1/YmlWL2@kroah.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 09:53:35AM +0100, gregkh@linuxfoundation.org wrote:
> On Thu, Feb 24, 2022 at 09:06:13PM -0500, stern@rowland.harvard.edu wrote:
> > On Thu, Feb 24, 2022 at 11:37:39PM +0100, gregkh@linuxfoundation.org wrote:
> > > On Thu, Feb 24, 2022 at 04:23:26PM -0500, stern@rowland.harvard.edu wrote:
> > > > Can you tell us how this should be fixed?
> > > 
> > > It should be fixed by properly using the driver core to bind/unbind the
> > > driver to devices like I mentioned previously :)
> > 
> > This would involve creating a "gadget" bus_type (or should it be a 
> > device_type under the platform bus?) and registering the gadgets 
> > on it, right?.
> 
> Yes.  Or you can use the aux bus for this, which might be easier.
> 
> > Similarly, the gadget drivers would be registered on 
> > this bus.  I suppose we can control which drivers get bound to which 
> > gadgets with careful matching code.
> 
> The aux bus might make this easier:
> 	Documentation/driver-api/auxiliary_bus.rst

Won't this end up changing the user-visible filenames and directories in 
sysfs for gadgets and gadget drivers?

For instance, currently gadgets get registered under their UDC driver 
name, like "net2280" or "at91".  If we put them on the aux bus then they 
will have to get registered under a name looking something like 
"udc.gadget.0", i.e., module name, generic device name, and ID number.

We will be forced to use a generic device name because the aux bus does 
matching based on it, and we want every gadget driver to be able to 
match every UDC.  We don't want some gadget drivers restricted to 
net2280 gadgets, others restricted to fotg210 gadgets, and so on.

Alan Stern

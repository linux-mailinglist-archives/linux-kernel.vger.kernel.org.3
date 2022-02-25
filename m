Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920D14C3B6A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 03:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236595AbiBYCGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 21:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbiBYCGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 21:06:45 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 4CFAC1D6F59
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 18:06:14 -0800 (PST)
Received: (qmail 1066190 invoked by uid 1000); 24 Feb 2022 21:06:13 -0500
Date:   Thu, 24 Feb 2022 21:06:13 -0500
From:   "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        Tejun Heo <tj@kernel.org>,
        syzbot <syzbot+348b571beb5eeb70a582@syzkaller.appspotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "balbi@kernel.org" <balbi@kernel.org>
Subject: Re: [syzbot] KASAN: use-after-free Read in dev_uevent
Message-ID: <Yhg5lWdEy2G4SsFr@rowland.harvard.edu>
References: <00000000000033314805d8765175@google.com>
 <PH0PR11MB58805E3C4CF7D4C41D49BFCFDA3C9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <YhYafwiwUV2Sbn5t@kroah.com>
 <YhZG3GJb8G7oL7l7@rowland.harvard.edu>
 <YhZaDGeIIvpILdCk@kroah.com>
 <YhZiMHHjrBw8am5g@rowland.harvard.edu>
 <PH0PR11MB5880D7544442B4D60810F0D2DA3D9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB588091026B817203C772B264DA3D9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <Yhf3ThBfjWVcYszC@rowland.harvard.edu>
 <YhgIs6FmBJYXiQVw@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhgIs6FmBJYXiQVw@kroah.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 11:37:39PM +0100, gregkh@linuxfoundation.org wrote:
> On Thu, Feb 24, 2022 at 04:23:26PM -0500, stern@rowland.harvard.edu wrote:
> > Can you tell us how this should be fixed?
> 
> It should be fixed by properly using the driver core to bind/unbind the
> driver to devices like I mentioned previously :)

This would involve creating a "gadget" bus_type (or should it be a 
device_type under the platform bus?) and registering the gadgets 
on it, right?.  Similarly, the gadget drivers would be registered on 
this bus.  I suppose we can control which drivers get bound to which 
gadgets with careful matching code.

> That will be more work, but it's the correct fix here.  Otherwise it
> needs to take the same bus locks that the device lives on to keep things
> in sync, like the driver core would do if it were managing these things.
> That could be the "short term" fix if no one wants to do the real work
> needed here.  Nothing should be needed to change in the driver core
> itself, it is rightfully thinking it owns the device and can free it
> when needed.

All right, thanks.  I'll think about implementing it.

Alan Stern

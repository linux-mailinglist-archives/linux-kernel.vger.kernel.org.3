Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A194C40B3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 09:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238781AbiBYIya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 03:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238796AbiBYIyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:54:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009F521EBBF
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 00:53:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67C1EB82BB2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 08:53:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCB7C340E7;
        Fri, 25 Feb 2022 08:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645779223;
        bh=zp/rjGYXjrTHoijVI6/l52iUfL6F+4cA5KamDh0Be6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qs3Z/5fJBAcVEyyCkgkLEgFATkWJ+8/8U1lVLqC1hmBhlflgFyC6e8Y4NkAHJdmu4
         ZUnAPDvWhsIHwF9k3uJ6mv4zh22p5S5UAjRRY7Qwdm0hgs7PjtsjUM812prwb0sbNC
         SNVr6IzBeF1y0la8FpnQxXwe42buhuIroMqbQvRY=
Date:   Fri, 25 Feb 2022 09:53:35 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        Tejun Heo <tj@kernel.org>,
        syzbot <syzbot+348b571beb5eeb70a582@syzkaller.appspotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "balbi@kernel.org" <balbi@kernel.org>
Subject: Re: [syzbot] KASAN: use-after-free Read in dev_uevent
Message-ID: <YhiZDy+y1/YmlWL2@kroah.com>
References: <PH0PR11MB58805E3C4CF7D4C41D49BFCFDA3C9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <YhYafwiwUV2Sbn5t@kroah.com>
 <YhZG3GJb8G7oL7l7@rowland.harvard.edu>
 <YhZaDGeIIvpILdCk@kroah.com>
 <YhZiMHHjrBw8am5g@rowland.harvard.edu>
 <PH0PR11MB5880D7544442B4D60810F0D2DA3D9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB588091026B817203C772B264DA3D9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <Yhf3ThBfjWVcYszC@rowland.harvard.edu>
 <YhgIs6FmBJYXiQVw@kroah.com>
 <Yhg5lWdEy2G4SsFr@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yhg5lWdEy2G4SsFr@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 09:06:13PM -0500, stern@rowland.harvard.edu wrote:
> On Thu, Feb 24, 2022 at 11:37:39PM +0100, gregkh@linuxfoundation.org wrote:
> > On Thu, Feb 24, 2022 at 04:23:26PM -0500, stern@rowland.harvard.edu wrote:
> > > Can you tell us how this should be fixed?
> > 
> > It should be fixed by properly using the driver core to bind/unbind the
> > driver to devices like I mentioned previously :)
> 
> This would involve creating a "gadget" bus_type (or should it be a 
> device_type under the platform bus?) and registering the gadgets 
> on it, right?.

Yes.  Or you can use the aux bus for this, which might be easier.

> Similarly, the gadget drivers would be registered on 
> this bus.  I suppose we can control which drivers get bound to which 
> gadgets with careful matching code.

The aux bus might make this easier:
	Documentation/driver-api/auxiliary_bus.rst

thanks,

greg k-h

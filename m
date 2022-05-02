Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597E2516F0E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 13:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384796AbiEBLuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 07:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241744AbiEBLuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 07:50:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE87C165BF;
        Mon,  2 May 2022 04:46:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A5CF61216;
        Mon,  2 May 2022 11:46:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0CBC385AC;
        Mon,  2 May 2022 11:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651492000;
        bh=MUFykdNVid0aaejhToLZfeDf3CUxpzSoP2z1PtGS1uo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=enpPRHfBVOI08gdtMVVVQ6aNPivGjpflVMCIBXbkX9T7XVKCDIAIMRrKHFeoEZtnn
         hULZLu0WMW6MCCU0JzE4RkGfY0Yd8R4l53LV9e0KqVkAvqhKn0RN/uSa5cWJXIXjk9
         RlZ0W6beSn+rqDfcVBoLLYu10B4mmZc2JSQsC3dM=
Date:   Mon, 2 May 2022 13:46:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Vacura <w36195@motorola.com>
Cc:     linux-usb@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: uvc: allow for application to cleanly
 shutdown
Message-ID: <Ym/En8EjfkpIVm+a@kroah.com>
References: <20220429192001.385636-1-w36195@motorola.com>
 <YmzrwgiEO2hoKM4U@kroah.com>
 <Ym9Z+BfHcwDKlwjy@p1g3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ym9Z+BfHcwDKlwjy@p1g3>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2022 at 11:11:36PM -0500, Dan Vacura wrote:
> On Sat, Apr 30, 2022 at 09:56:50AM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Apr 29, 2022 at 02:20:01PM -0500, Dan Vacura wrote:
> > > Several types of kernel panics can occur due to timing during the uvc
> > > gadget removal. This appears to be a problem with gadget resources being
> > > managed by both the client application's v4l2 open/close and the UDC
> > > gadget bind/unbind. Since the concept of USB_GADGET_DELAYED_STATUS
> > > doesn't exist for unbind, add a wait to allow for the application to
> > > close out.
> > > 
> > > Some examples of the panics that can occur are:
> > > 
> > > <1>[ 1147.652313] Unable to handle kernel NULL pointer dereference at
> > > virtual address 0000000000000028
> > > <4>[ 1147.652510] Call trace:
> > > <4>[ 1147.652514]  usb_gadget_disconnect+0x74/0x1f0
> > > <4>[ 1147.652516]  usb_gadget_deactivate+0x38/0x168
> > > <4>[ 1147.652520]  usb_function_deactivate+0x54/0x90
> > > <4>[ 1147.652524]  uvc_function_disconnect+0x14/0x38
> > > <4>[ 1147.652527]  uvc_v4l2_release+0x34/0xa0
> > > <4>[ 1147.652537]  __fput+0xdc/0x2c0
> > > <4>[ 1147.652540]  ____fput+0x10/0x1c
> > > <4>[ 1147.652545]  task_work_run+0xe4/0x12c
> > > <4>[ 1147.652549]  do_notify_resume+0x108/0x168
> > > 
> > > <1>[  282.950561][ T1472] Unable to handle kernel NULL pointer
> > > dereference at virtual address 00000000000005b8
> > > <6>[  282.953111][ T1472] Call trace:
> > > <6>[  282.953121][ T1472]  usb_function_deactivate+0x54/0xd4
> > > <6>[  282.953134][ T1472]  uvc_v4l2_release+0xac/0x1e4
> > > <6>[  282.953145][ T1472]  v4l2_release+0x134/0x1f0
> > > <6>[  282.953167][ T1472]  __fput+0xf4/0x428
> > > <6>[  282.953178][ T1472]  ____fput+0x14/0x24
> > > <6>[  282.953193][ T1472]  task_work_run+0xac/0x130
> > > 
> > > <3>[  213.410077][   T29] configfs-gadget gadget: uvc: Failed to queue
> > > request (-108).
> > > <1>[  213.410116][   T29] Unable to handle kernel NULL pointer
> > > dereference at virtual address 0000000000000003
> > > <6>[  213.413460][   T29] Call trace:
> > > <6>[  213.413474][   T29]  uvcg_video_pump+0x1f0/0x384
> > > <6>[  213.413489][   T29]  process_one_work+0x2a4/0x544
> > > <6>[  213.413502][   T29]  worker_thread+0x350/0x784
> > > <6>[  213.413515][   T29]  kthread+0x2ac/0x320
> > > <6>[  213.413528][   T29]  ret_from_fork+0x10/0x30
> > > 
> > > Signed-off-by: Dan Vacura <w36195@motorola.com>
> > > ---
> > >  drivers/usb/gadget/function/f_uvc.c    | 24 ++++++++++++++++++++++++
> > >  drivers/usb/gadget/function/uvc.h      |  2 ++
> > >  drivers/usb/gadget/function/uvc_v4l2.c |  3 ++-
> > >  3 files changed, 28 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
> > > index 50e6e7a58b41..3cc8cf24a7c7 100644
> > > --- a/drivers/usb/gadget/function/f_uvc.c
> > > +++ b/drivers/usb/gadget/function/f_uvc.c
> > > @@ -892,13 +892,36 @@ static void uvc_function_unbind(struct usb_configuration *c,
> > >  {
> > >  	struct usb_composite_dev *cdev = c->cdev;
> > >  	struct uvc_device *uvc = to_uvc(f);
> > > +	int wait_ret = 1;
> > >  
> > >  	uvcg_info(f, "%s()\n", __func__);
> > 
> > Ick, wait, is that in the kernel?  That needs to be removed, ftrace can
> > do that for you.
> 
> Yes, part of the kernel, and tbh, I find it to be quite helpful in
> debugging field issues from customers, where enabling ftrace isn't
> practical.

Why isn't ftrace ok to enable in a running kernel?

Worst case, this should be dev_dbg(), right?

> If you still want to remove, there are other locations in
> this gadget driver that log function entry. Perhaps it'd be better to
> do a separate change that cleans up logging a bit or do you prefer to
> just refactor this one now?

This commit is fine, it's a separate issue, I just noticed it as it was
in the context of this change.

> > > +	/* If we know we're connected via v4l2, then there should be a cleanup
> > > +	 * of the device from userspace either via UVC_EVENT_DISCONNECT or
> > > +	 * though the video device removal uevent. Allow some time for the
> > > +	 * application to close out before things get deleted.
> > > +	 */
> > > +	if (uvc->func_connected) {
> > > +		uvcg_info(f, "%s waiting for clean disconnect\n", __func__);
> > > +		wait_ret = wait_event_interruptible_timeout(uvc->func_connected_queue,
> > > +				uvc->func_connected == false, msecs_to_jiffies(500));
> > > +		uvcg_info(f, "%s done waiting with ret: %u\n", __func__, wait_ret);
> > 
> > Please remove debugging code before submitting patches.
> 
> Will do.

But this should be removed :)

Feel free to change it to dev_dbg(), which gives you the __func__
automatically without anything extra needed.

thanks,

greg k-h

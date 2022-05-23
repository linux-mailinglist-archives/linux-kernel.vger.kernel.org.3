Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415EC53147C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238532AbiEWQHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238387AbiEWQHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:07:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBBE22BF3
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:06:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8EA35B81192
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 16:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A1EC385AA;
        Mon, 23 May 2022 16:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1653322016;
        bh=qyIyPX6ADZ1zEeCUptE8kITzDG/Coxms3dWlBd9Ao8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r/Cq1M528dfKuwMUBnpcrF0W2aVzTWOBDppAGmjEzZvjT34Jpaqi5FCb5rOIJmVrO
         ZOdDM9d5bDLbI1U/KwtuTJiX8SVfbkp62JwkuGfWg05kyUo0yeIEr2wQuZojxwSGPh
         qvZHKG0HwTGIlQ9FWTlOekAxZWbYlEhRZRaaA91s=
Date:   Mon, 23 May 2022 18:06:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     eli.billauer@gmail.com, arnd@arndb.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] char: xillybus: Check endpoint type before allocing
Message-ID: <YouxHY48daZt7J/O@kroah.com>
References: <Yn9XwHxWsLIJXlHu@kroah.com>
 <20220514114819.2773691-1-zheyuma97@gmail.com>
 <Yn+va5fTsuaFTxVR@kroah.com>
 <CAMhUBj=RMJwn2K+rQC9rQ=QEe5QkiJ29rMd8KzEC8B7vtXo+ug@mail.gmail.com>
 <Yocp+WZ0On9/wObu@kroah.com>
 <CAMhUBj=J5-V_D_kucpiWz6ZdOSSR1N9nRXQxOKgmwRA+LxW17Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMhUBj=J5-V_D_kucpiWz6ZdOSSR1N9nRXQxOKgmwRA+LxW17Q@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2022 at 01:06:59PM +0800, Zheyu Ma wrote:
> On Fri, May 20, 2022 at 1:41 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, May 20, 2022 at 11:32:51AM +0800, Zheyu Ma wrote:
> > > On Sat, May 14, 2022 at 9:32 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Sat, May 14, 2022 at 07:48:19PM +0800, Zheyu Ma wrote:
> > > > > The driver submits bulk urb without checking the endpoint type is
> > > > > actually bulk.
> > > > >
> > > > > [    3.108690] usb 1-1: BOGUS urb xfer, pipe 3 != type 1
> > > > > [    3.108983] WARNING: CPU: 0 PID: 211 at drivers/usb/core/urb.c:503 usb_submit_urb+0xcd9/0x18b0
> > > > > [    3.110976] RIP: 0010:usb_submit_urb+0xcd9/0x18b0
> > > > > [    3.115318] Call Trace:
> > > > > [    3.115452]  <TASK>
> > > > > [    3.115570]  try_queue_bulk_in+0x43c/0x6e0 [xillyusb]
> > > > > [    3.115838]  xillyusb_probe+0x488/0x1230 [xillyusb]
> > > > >
> > > > > Add a check in endpoint_alloc() to fix the bug.
> > > > >
> > > > > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> > > > > ---
> > > > > Changes in v2:
> > > > >     - Check the endpoint type at probe time
> > > > > ---
> > > > >  drivers/char/xillybus/xillyusb.c | 27 ++++++++++++++++++++++++++-
> > > > >  1 file changed, 26 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/char/xillybus/xillyusb.c b/drivers/char/xillybus/xillyusb.c
> > > > > index dc3551796e5e..4467f13993ef 100644
> > > > > --- a/drivers/char/xillybus/xillyusb.c
> > > > > +++ b/drivers/char/xillybus/xillyusb.c
> > > > > @@ -167,6 +167,7 @@ struct xillyusb_dev {
> > > > >       struct device           *dev; /* For dev_err() and such */
> > > > >       struct kref             kref;
> > > > >       struct workqueue_struct *workq;
> > > > > +     struct usb_interface *intf;
> > > > >
> > > > >       int error;
> > > > >       spinlock_t error_lock; /* protect @error */
> > > > > @@ -475,6 +476,25 @@ static void endpoint_dealloc(struct xillyusb_endpoint *ep)
> > > > >       kfree(ep);
> > > > >  }
> > > > >
> > > > > +static int xillyusb_check_endpoint(struct xillyusb_dev *xdev, u8 ep_num)
> > > > > +{
> > > > > +     struct usb_host_interface *if_desc = xdev->intf->altsetting;
> > > > > +     int i;
> > > > > +
> > > > > +     for (i = 0; i < if_desc->desc.bNumEndpoints; i++) {
> > > > > +             struct usb_endpoint_descriptor *ep = &if_desc->endpoint[i].desc;
> > > > > +
> > > > > +             if (ep->bEndpointAddress != ep_num)
> > > > > +                     continue;
> > > > > +
> > > > > +             if ((usb_pipein(ep_num) && usb_endpoint_is_bulk_in(ep)) ||
> > > > > +                     (usb_pipeout(ep_num) && usb_endpoint_is_bulk_out(ep)))
> > > > > +                     return 0;
> > > > > +     }
> > > >
> > > > Why not use the built-in usb core functions that do this for you instead
> > > > of hand-parsing this?  Look at usb_find_common_endpoints() and related
> > > > functions, that should make this much easier.
> > >
> > > Thanks for your reminder. But in this driver, we have to check not
> > > only the type and direction of the endpoint, but also the address of
> > > it. And the endpoint's address is sometimes dynamic. For example,  in
> > > the function xillyusb_open():
> > >
> > > out_ep = endpoint_alloc(xdev, (chan->chan_idx + 2) | USB_DIR_OUT,
> > > bulk_out_work, BUF_SIZE_ORDER, BUFNUM);
> > >
> > > However, usb_find_common_endpoints() can only find the first endpoint
> > > that satisfies the condition, not on a specific address. I cannot find
> > > a more suitable built-in core function, please correct me if I'm
> > > wrong.
> >
> > I do not understand the problem here, it looks like your code above that
> > I responded to doesn't care about specific addresses at all.  It is just
> > walking all of them and making sure that it is a bulk in/out endpoint.
> 
> Please correct me if I'm wrong. I think the driver needs to check if
> the urb has the correct type before submitting the urb, and this check
> should be done early.

Yes, very very early, like probe() callback time early.

Not way down here in "do we want to allow open() to work or not" like
you are currently doing.

If the device does not have the EXACT USB endpoints that you are
expecting (size, address, direction, type, etc.) at probe time reject
the device.

That is what the helper functions I pointed you at are for.

This driver is trying to detect this type of problem _way_ too late.

thanks,

greg k-h

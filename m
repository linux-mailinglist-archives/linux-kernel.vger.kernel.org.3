Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0143A4D9D9E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 15:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244801AbiCOOdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 10:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236895AbiCOOdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:33:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B0155217;
        Tue, 15 Mar 2022 07:32:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14E4660DBB;
        Tue, 15 Mar 2022 14:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C26C340E8;
        Tue, 15 Mar 2022 14:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647354739;
        bh=tkMjL/wZdYB0I49Qx/18oHUvgPG/8y/8tmdU+zCoigg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hx6eKOuA9YxuYo7BT1lUIIvVrCV4wNNIynQ89obART+lGnFAIuYv7CfLaRSmalJiq
         3Xf2HAt2brKseIEQcVnk8zF1f3sPaGAMy5aCUlEEtKqGO+bhwbgFUvmZspjV2sRRWR
         kf7A9DmqBPArTFkR1yeXJit2wX4BaRpidllkVW4g=
Date:   Tue, 15 Mar 2022 15:32:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Wei Ming Chen <jj251510319013@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v2] usb: raw-gadget: return -EINVAL if no proper ep
 address available
Message-ID: <YjCjYeIdrWvyINpX@kroah.com>
References: <CA+fCnZd2GoU6LVvT4eBT3w7TigRrp_9XcAGyL55K5nbi3yt4sA@mail.gmail.com>
 <20220311082944.4881-1-jj251510319013@gmail.com>
 <CA+fCnZeXMKXBzJm=akMNm4OVN53T_1aQw4n+yYZ6Vkqmj8+KAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+fCnZeXMKXBzJm=akMNm4OVN53T_1aQw4n+yYZ6Vkqmj8+KAQ@mail.gmail.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 13, 2022 at 03:52:35PM +0100, Andrey Konovalov wrote:
> On Fri, Mar 11, 2022 at 9:30 AM Wei Ming Chen <jj251510319013@gmail.com> wrote:
> >
> > If we try to use raw_ioctl_ep_enable() for ep5in on a hardware that
> > only support from ep1-ep4 for both in and out direction, it will return
> > -EBUSY originally.
> >
> > I think it will be more intuitive if we return -EINVAL, because -EBUSY
> > sounds like ep5in is not available now, but might be available in the
> > future.
> >
> > Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
> > ---
> >
> > Changes in v2:
> > - Rename variable from ep_num_matched to ep_props_matched
> > - Incorporate the patch from Andrey Konovalov that cover
> >   the foloowing cases:
> >     1. If there are no endpoints that match the provided descriptor, return
> >        EINVAL.
> >     2. If there are matching endpoints, but they are all already enabled,
> >        return EBUSY.
> >
> >  drivers/usb/gadget/legacy/raw_gadget.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
> > index d86c3a36441e..e5707626c4d4 100644
> > --- a/drivers/usb/gadget/legacy/raw_gadget.c
> > +++ b/drivers/usb/gadget/legacy/raw_gadget.c
> > @@ -758,6 +758,7 @@ static int raw_ioctl_ep_enable(struct raw_dev *dev, unsigned long value)
> >         unsigned long flags;
> >         struct usb_endpoint_descriptor *desc;
> >         struct raw_ep *ep;
> > +       bool ep_props_matched = false;
> >
> >         desc = memdup_user((void __user *)value, sizeof(*desc));
> >         if (IS_ERR(desc))
> > @@ -787,13 +788,14 @@ static int raw_ioctl_ep_enable(struct raw_dev *dev, unsigned long value)
> >
> >         for (i = 0; i < dev->eps_num; i++) {
> >                 ep = &dev->eps[i];
> > -               if (ep->state != STATE_EP_DISABLED)
> > -                       continue;
> >                 if (ep->addr != usb_endpoint_num(desc) &&
> >                                 ep->addr != USB_RAW_EP_ADDR_ANY)
> >                         continue;
> >                 if (!usb_gadget_ep_match_desc(dev->gadget, ep->ep, desc, NULL))
> >                         continue;
> > +               ep_props_matched = true;
> > +               if (ep->state != STATE_EP_DISABLED)
> > +                       continue;
> >                 ep->ep->desc = desc;
> >                 ret = usb_ep_enable(ep->ep);
> >                 if (ret < 0) {
> > @@ -815,8 +817,13 @@ static int raw_ioctl_ep_enable(struct raw_dev *dev, unsigned long value)
> >                 goto out_unlock;
> >         }
> >
> > -       dev_dbg(&dev->gadget->dev, "fail, no gadget endpoints available\n");
> > -       ret = -EBUSY;
> > +       if (!ep_props_matched) {
> > +               dev_dbg(&dev->gadget->dev, "fail, bad endpoint descriptor\n");
> > +               ret = -EINVAL;
> > +       } else {
> > +               dev_dbg(&dev->gadget->dev, "fail, no endpoints available\n");
> > +               ret = -EBUSY;
> > +       }
> >
> >  out_free:
> >         kfree(desc);
> > --
> > 2.25.1
> >
> 
> Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
> 
> Greg, could you consider picking this up?

Now picked up, thanks.

greg k-h

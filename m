Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094C4530100
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 07:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236117AbiEVFHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 01:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiEVFHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 01:07:12 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD783669D
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 22:07:11 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id b5so3413962plx.10
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 22:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/zVdOgntLPr65qEklFl4nAPYvyRm9z2iaUah6eFKKVI=;
        b=LEDxfmuaQi4BsWb0dD8OMVEJL0VqYqptPmyWiVlyr1UfGIbklnwhjDrJoZjsK+v0fN
         xZgHC1rbHfNGUbGIjML5QYuX7VoU46LeBxtoGxmwYkV5QBIS4Y4a4xcXkSEabsepmMTU
         FmSXwkRwV4E49YGiunirk4XzJpuDptlddnT/QdT3TILzxh3z1yqUwdW5Lv2Y3BVlHGZb
         vcvZtGQFPoKrQASld/vwuPfXYu2UWPpSndzFRRp9Fn++IlzFJOgac2IkDrMWo80tZGdW
         eUu9EI4klpqBtONc4zSP0YacweFF4oj8g0nrkUqurtrpLF9PhVlW1PB3JGQNTU7nHiqq
         VcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/zVdOgntLPr65qEklFl4nAPYvyRm9z2iaUah6eFKKVI=;
        b=4j5XXuSTUk1aoDsVvxMgw1LKWOEAorrjjrjWXhNf8ve+IxjdDEGRGBMOyT0vJM46/i
         2wj6wXK4S1K03sNcgLg1iJqGV4s713IwaA3PHfQ2rh34JaIy4JdWJJzbnvJEZRGiLRGs
         4W5H3XWeiLDpn2gI/0yE4StB0GUr6ed+DXLEFT7tIUDW2XwV+O3mzut2azQapPTgRuGG
         yDFjqfFZOV1YaYikqe9lOZ1km0QCKtrnbqE2mZCJ8mkIOs6ISZ9dXbJdhNZO1/GVuIMq
         pxryvj6QkhNQ9J2nyry9ztz0CWM4eNNwOo7NHsCA6BB0yLyzdUNfWTeQ9F0Hhu2/AY3Y
         sBhA==
X-Gm-Message-State: AOAM533IyIo/zjzZ2JhGB7GhWszhJQtPKeew6Jbi7crEu2JWEDHT+2FB
        JjMxiSw1SxNqqlrjk8/XjnKcnKFyW6igILxdno82PYTQfaI2t1LcMA==
X-Google-Smtp-Source: ABdhPJzMw4wR7ICo7g7/CU+NSffUREE2U8zYqhKmtleP97GJDDM18JtsTySQaYvuLz6C9H815du6UFsezjXQcU1X8kg=
X-Received: by 2002:a17:903:240b:b0:14b:1100:aebc with SMTP id
 e11-20020a170903240b00b0014b1100aebcmr17447032plo.133.1653196030813; Sat, 21
 May 2022 22:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <Yn9XwHxWsLIJXlHu@kroah.com> <20220514114819.2773691-1-zheyuma97@gmail.com>
 <Yn+va5fTsuaFTxVR@kroah.com> <CAMhUBj=RMJwn2K+rQC9rQ=QEe5QkiJ29rMd8KzEC8B7vtXo+ug@mail.gmail.com>
 <Yocp+WZ0On9/wObu@kroah.com>
In-Reply-To: <Yocp+WZ0On9/wObu@kroah.com>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Sun, 22 May 2022 13:06:59 +0800
Message-ID: <CAMhUBj=J5-V_D_kucpiWz6ZdOSSR1N9nRXQxOKgmwRA+LxW17Q@mail.gmail.com>
Subject: Re: [PATCH v2] char: xillybus: Check endpoint type before allocing
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     eli.billauer@gmail.com, arnd@arndb.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 1:41 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, May 20, 2022 at 11:32:51AM +0800, Zheyu Ma wrote:
> > On Sat, May 14, 2022 at 9:32 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Sat, May 14, 2022 at 07:48:19PM +0800, Zheyu Ma wrote:
> > > > The driver submits bulk urb without checking the endpoint type is
> > > > actually bulk.
> > > >
> > > > [    3.108690] usb 1-1: BOGUS urb xfer, pipe 3 != type 1
> > > > [    3.108983] WARNING: CPU: 0 PID: 211 at drivers/usb/core/urb.c:503 usb_submit_urb+0xcd9/0x18b0
> > > > [    3.110976] RIP: 0010:usb_submit_urb+0xcd9/0x18b0
> > > > [    3.115318] Call Trace:
> > > > [    3.115452]  <TASK>
> > > > [    3.115570]  try_queue_bulk_in+0x43c/0x6e0 [xillyusb]
> > > > [    3.115838]  xillyusb_probe+0x488/0x1230 [xillyusb]
> > > >
> > > > Add a check in endpoint_alloc() to fix the bug.
> > > >
> > > > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> > > > ---
> > > > Changes in v2:
> > > >     - Check the endpoint type at probe time
> > > > ---
> > > >  drivers/char/xillybus/xillyusb.c | 27 ++++++++++++++++++++++++++-
> > > >  1 file changed, 26 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/char/xillybus/xillyusb.c b/drivers/char/xillybus/xillyusb.c
> > > > index dc3551796e5e..4467f13993ef 100644
> > > > --- a/drivers/char/xillybus/xillyusb.c
> > > > +++ b/drivers/char/xillybus/xillyusb.c
> > > > @@ -167,6 +167,7 @@ struct xillyusb_dev {
> > > >       struct device           *dev; /* For dev_err() and such */
> > > >       struct kref             kref;
> > > >       struct workqueue_struct *workq;
> > > > +     struct usb_interface *intf;
> > > >
> > > >       int error;
> > > >       spinlock_t error_lock; /* protect @error */
> > > > @@ -475,6 +476,25 @@ static void endpoint_dealloc(struct xillyusb_endpoint *ep)
> > > >       kfree(ep);
> > > >  }
> > > >
> > > > +static int xillyusb_check_endpoint(struct xillyusb_dev *xdev, u8 ep_num)
> > > > +{
> > > > +     struct usb_host_interface *if_desc = xdev->intf->altsetting;
> > > > +     int i;
> > > > +
> > > > +     for (i = 0; i < if_desc->desc.bNumEndpoints; i++) {
> > > > +             struct usb_endpoint_descriptor *ep = &if_desc->endpoint[i].desc;
> > > > +
> > > > +             if (ep->bEndpointAddress != ep_num)
> > > > +                     continue;
> > > > +
> > > > +             if ((usb_pipein(ep_num) && usb_endpoint_is_bulk_in(ep)) ||
> > > > +                     (usb_pipeout(ep_num) && usb_endpoint_is_bulk_out(ep)))
> > > > +                     return 0;
> > > > +     }
> > >
> > > Why not use the built-in usb core functions that do this for you instead
> > > of hand-parsing this?  Look at usb_find_common_endpoints() and related
> > > functions, that should make this much easier.
> >
> > Thanks for your reminder. But in this driver, we have to check not
> > only the type and direction of the endpoint, but also the address of
> > it. And the endpoint's address is sometimes dynamic. For example,  in
> > the function xillyusb_open():
> >
> > out_ep = endpoint_alloc(xdev, (chan->chan_idx + 2) | USB_DIR_OUT,
> > bulk_out_work, BUF_SIZE_ORDER, BUFNUM);
> >
> > However, usb_find_common_endpoints() can only find the first endpoint
> > that satisfies the condition, not on a specific address. I cannot find
> > a more suitable built-in core function, please correct me if I'm
> > wrong.
>
> I do not understand the problem here, it looks like your code above that
> I responded to doesn't care about specific addresses at all.  It is just
> walking all of them and making sure that it is a bulk in/out endpoint.

Please correct me if I'm wrong. I think the driver needs to check if
the urb has the correct type before submitting the urb, and this check
should be done early.
This driver uses endpoint_alloc() to allocate an endpoint and then
uses this endpoint for transfers. And one of the arguments of
endpoint_alloc() is 'ep_num'. So I want to iterate over the endpoints
and exclude the unwanted address as follows:

 if (ep->bEndpointAddress != ep_num)
    continue;

> And why do you care about the address of the endpoint?  If you know
> that, then there's no need to walk them all and you can check that even
> easier.

I care about the address of the endpoint because it is an argument of
endpoint_alloc(). I don't know a better solution to check the endpoint
even if I know the address.

Thanks,
Zheyu Ma

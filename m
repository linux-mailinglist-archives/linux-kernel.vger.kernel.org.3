Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF8D52E327
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 05:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345166AbiETDdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 23:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344034AbiETDdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 23:33:04 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A123131284
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 20:33:03 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id w17-20020a17090a529100b001db302efed6so6833292pjh.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 20:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FlZBjKSvnl7AO5/tg338EStcNW8RzWBsvwWR1QqvSkw=;
        b=Wu12qjr1piexo1XuIyCC04c3/a9M0o+idnc7V3Lv6m1PZry+qW7XyarnNcLTduTpp8
         mEGxyuUfZQuHOi+g41mZ2naQreRGxMMF1kZsL6UW8cMbneqMS2nqbZOtvKmcdiQ9ht4s
         08RZ/MzeMzsnYcLWDObmbgxhTPv1GSE8OfJ3UstZQTATXs2SzlKTnB4R1czR77VU3sKa
         KF139nLQmZTN91r2S6U8neEr1Szx9oF1u8VW9wf3wIUCgTM2JW8FXSAqBys1L1yj949n
         esJunbZu1fF7Uc7uRVZzPj6YeyZA96rDCyNHgxl9MGsKxBvW6vtIGWNuxtHp3H5ybIQ1
         RL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FlZBjKSvnl7AO5/tg338EStcNW8RzWBsvwWR1QqvSkw=;
        b=ytP4J4/dGg0kiEWzeCfvoHjTu1xTxkNcjLSL9WvQU2cLu7T1ENJDihaqKeJ0C7MdZn
         VeVqkdoUeiFcidet2Gfdzsc5SjlZZvAna/m4evXONtiDRkAVP+XaXm6JvbOVdw29YXH8
         KpNjEJyE7oS1cVVhypWXfmhhcSRvAE9ijt0TSGQgNZAihjdXaDVhib7wuXngg/g5kSar
         u9hl9sGJZK2//TzriWSlSRdXUDKHEoFX2QuT15rEPl0naeE0A4/UUeFMcfgXojcmjFT/
         N+tP9XriRdqiTLSBs/UTTvBpIOnVENED2kd2oqccueOUWdZ1Nk2wRhke/EbNFJ6yEN9i
         6qWQ==
X-Gm-Message-State: AOAM532ruoSQIZeVx8F7/UgClo/+7kkYJ0LNopnb0x7rPa2QoPC6ZbH6
        iORH2uqQwVK5FKWvdYq7bu7cCXU1j3NiIl2FQg==
X-Google-Smtp-Source: ABdhPJyOisf6TLQxHiKf3AMcHZItMxH4DFkE/uGDL1fRktUs2HOCacp+Q7OauVh+TEGH18UMA4ZTXP9GMjPzEjzqWP4=
X-Received: by 2002:a17:903:22c1:b0:161:d274:fb41 with SMTP id
 y1-20020a17090322c100b00161d274fb41mr7671742plg.31.1653017582589; Thu, 19 May
 2022 20:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <Yn9XwHxWsLIJXlHu@kroah.com> <20220514114819.2773691-1-zheyuma97@gmail.com>
 <Yn+va5fTsuaFTxVR@kroah.com>
In-Reply-To: <Yn+va5fTsuaFTxVR@kroah.com>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Fri, 20 May 2022 11:32:51 +0800
Message-ID: <CAMhUBj=RMJwn2K+rQC9rQ=QEe5QkiJ29rMd8KzEC8B7vtXo+ug@mail.gmail.com>
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

On Sat, May 14, 2022 at 9:32 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, May 14, 2022 at 07:48:19PM +0800, Zheyu Ma wrote:
> > The driver submits bulk urb without checking the endpoint type is
> > actually bulk.
> >
> > [    3.108690] usb 1-1: BOGUS urb xfer, pipe 3 != type 1
> > [    3.108983] WARNING: CPU: 0 PID: 211 at drivers/usb/core/urb.c:503 usb_submit_urb+0xcd9/0x18b0
> > [    3.110976] RIP: 0010:usb_submit_urb+0xcd9/0x18b0
> > [    3.115318] Call Trace:
> > [    3.115452]  <TASK>
> > [    3.115570]  try_queue_bulk_in+0x43c/0x6e0 [xillyusb]
> > [    3.115838]  xillyusb_probe+0x488/0x1230 [xillyusb]
> >
> > Add a check in endpoint_alloc() to fix the bug.
> >
> > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> > ---
> > Changes in v2:
> >     - Check the endpoint type at probe time
> > ---
> >  drivers/char/xillybus/xillyusb.c | 27 ++++++++++++++++++++++++++-
> >  1 file changed, 26 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/char/xillybus/xillyusb.c b/drivers/char/xillybus/xillyusb.c
> > index dc3551796e5e..4467f13993ef 100644
> > --- a/drivers/char/xillybus/xillyusb.c
> > +++ b/drivers/char/xillybus/xillyusb.c
> > @@ -167,6 +167,7 @@ struct xillyusb_dev {
> >       struct device           *dev; /* For dev_err() and such */
> >       struct kref             kref;
> >       struct workqueue_struct *workq;
> > +     struct usb_interface *intf;
> >
> >       int error;
> >       spinlock_t error_lock; /* protect @error */
> > @@ -475,6 +476,25 @@ static void endpoint_dealloc(struct xillyusb_endpoint *ep)
> >       kfree(ep);
> >  }
> >
> > +static int xillyusb_check_endpoint(struct xillyusb_dev *xdev, u8 ep_num)
> > +{
> > +     struct usb_host_interface *if_desc = xdev->intf->altsetting;
> > +     int i;
> > +
> > +     for (i = 0; i < if_desc->desc.bNumEndpoints; i++) {
> > +             struct usb_endpoint_descriptor *ep = &if_desc->endpoint[i].desc;
> > +
> > +             if (ep->bEndpointAddress != ep_num)
> > +                     continue;
> > +
> > +             if ((usb_pipein(ep_num) && usb_endpoint_is_bulk_in(ep)) ||
> > +                     (usb_pipeout(ep_num) && usb_endpoint_is_bulk_out(ep)))
> > +                     return 0;
> > +     }
>
> Why not use the built-in usb core functions that do this for you instead
> of hand-parsing this?  Look at usb_find_common_endpoints() and related
> functions, that should make this much easier.

Thanks for your reminder. But in this driver, we have to check not
only the type and direction of the endpoint, but also the address of
it. And the endpoint's address is sometimes dynamic. For example,  in
the function xillyusb_open():

out_ep = endpoint_alloc(xdev, (chan->chan_idx + 2) | USB_DIR_OUT,
bulk_out_work, BUF_SIZE_ORDER, BUFNUM);

However, usb_find_common_endpoints() can only find the first endpoint
that satisfies the condition, not on a specific address. I cannot find
a more suitable built-in core function, please correct me if I'm
wrong.

Thanks,
Zheyu Ma

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E504A93CA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 06:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244568AbiBDF7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 00:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbiBDF7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 00:59:31 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E540C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 21:59:31 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id k9so4557091qvv.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 21:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FhZFsKyaaJOtTsKL6vGNTA/6IREkOSV0yWyR3eyZXuQ=;
        b=X+RNP3W+BuS/HW4UIS+ZtcvWEGnvtGzzhZjoTJEB6nvhA5+Zalv7enVNJ9jhE9LtyP
         +qj3R73iue5rYG97CgSV9LDSVkT4fOfz1Hb9zJvnW8ed76egAELCwmD2sLsljlhg0JK6
         6KX9T5adtJpEGuroU6Ec55ehzYXQz5GZaL31Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FhZFsKyaaJOtTsKL6vGNTA/6IREkOSV0yWyR3eyZXuQ=;
        b=TNc7LBWL5UGIBajbXgH3muY2G08r5xXmUocw+cOtBfPC+S1bPN6DCXcLHcdljvRGe8
         zZ2AqckE+cSn7LnmPB6sHUVPBhKSljZAfVxkaEm79+xxTgq2ex2BiauDbi75H2icsOaV
         UKAp2QWAX5Pi2eL9NezItgofKgjh0j/LM5nZNqsH/pNaJV21Eb8Er20AUfsDuNTFNDkq
         zjhia4UKtIUHSfR+PawfOxGQzyZfzLcWRfFaCpjRMob0JnG4wLhZgPElmFtzTtEA4jPX
         482qLMz/T2A8qIi50UXXSthf8o7uUgIWM7XgX2yKNIle7jR4iZNoY99LUODl45d5zf8d
         I1MQ==
X-Gm-Message-State: AOAM533JG4zKOf1JQOhGxOdq56mdZICTURAzK99PUCL7Rz2MaN6ojU9L
        rlNCzDCnZAMa84aIxd2vfuoNRtn2XOyi4Q==
X-Google-Smtp-Source: ABdhPJwAIJevnHSlOD1ZySj5Cg1QxfTDihKDd0FAQ5KIqpC04UdbRuCTuhVASYje+zYkmsBLBZ2RSg==
X-Received: by 2002:a05:6214:4011:: with SMTP id kd17mr882621qvb.45.1643954370397;
        Thu, 03 Feb 2022 21:59:30 -0800 (PST)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id g11sm647117qtg.49.2022.02.03.21.59.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 21:59:28 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id y6so1036377ybc.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 21:59:28 -0800 (PST)
X-Received: by 2002:a81:dc04:: with SMTP id h4mr1455448ywj.4.1643954368322;
 Thu, 03 Feb 2022 21:59:28 -0800 (PST)
MIME-Version: 1.0
References: <20201221164819.792019-1-ribalda@chromium.org> <20201221164819.792019-10-ribalda@chromium.org>
 <X+HKpxzbVC29lNlk@pendragon.ideasonboard.com> <CANiDSCv_+Usx4QkG4ypGWbCKvusiugYGgeNRYP8GZJ_pvuhjEQ@mail.gmail.com>
 <X+L6KSlpKERPAxsm@pendragon.ideasonboard.com> <CANiDSCsvOdB7oAGBwupb_UrV=SND96Pc2AuWu=dPAbTA-boXhQ@mail.gmail.com>
 <CANiDSCvMWtWUJT76T_4ksoc9bA0ev14kGs1S8Ashw+06iPw6tA@mail.gmail.com> <CAAFQd5By3GVrzww4AvnhCOdBxdC6udu5=kBCVk_yr6aZ7M1wQg@mail.gmail.com>
In-Reply-To: <CAAFQd5By3GVrzww4AvnhCOdBxdC6udu5=kBCVk_yr6aZ7M1wQg@mail.gmail.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 4 Feb 2022 14:59:16 +0900
X-Gmail-Original-Message-ID: <CAAFQd5B=BWuf0W5Q1R2BPas_0ACZR-s9nR76awtrb5LDhUQnYw@mail.gmail.com>
Message-ID: <CAAFQd5B=BWuf0W5Q1R2BPas_0ACZR-s9nR76awtrb5LDhUQnYw@mail.gmail.com>
Subject: Re: [PATCH v5 09/12] media: uvcvideo: Implement UVC_QUIRK_PRIVACY_DURING_STREAM
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ricardo Ribalda <ribalda@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 1:54 PM Tomasz Figa <tfiga@chromium.org> wrote:
>
> On Wed, Dec 23, 2020 at 9:56 PM Ricardo Ribalda <ribalda@chromium.org> wrote:
> >
> > Hi again
> >
> > On Wed, Dec 23, 2020 at 9:31 AM Ricardo Ribalda <ribalda@chromium.org> wrote:
> > >
> > > Hi Laurent
> > >
> > > On Wed, Dec 23, 2020 at 9:05 AM Laurent Pinchart
> > > <laurent.pinchart@ideasonboard.com> wrote:
> > > >
> > > > Hi Ricardo,
> > > >
> > > > On Tue, Dec 22, 2020 at 09:04:19PM +0100, Ricardo Ribalda wrote:
> > > > > On Tue, Dec 22, 2020 at 11:30 AM Laurent Pinchart wrote:
> > > > > > On Mon, Dec 21, 2020 at 05:48:16PM +0100, Ricardo Ribalda wrote:
> > > > > > > Some devices, can only read the privacy_pin if the device is
> > > > > >
> > > > > > s/devices,/devices/
> > > > > >
> > > > > > > streaming.
> > > > > > >
> > > > > > > This patch implement a quirk for such devices, in order to avoid invalid
> > > > > > > reads and/or spurious events.
> > > > > > >
> > > > > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > > > > ---
> > > > > > >  drivers/media/usb/uvc/uvc_driver.c | 57 ++++++++++++++++++++++++++++--
> > > > > > >  drivers/media/usb/uvc/uvc_queue.c  |  3 ++
> > > > > > >  drivers/media/usb/uvc/uvcvideo.h   |  4 +++
> > > > > > >  3 files changed, 61 insertions(+), 3 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > > > > > > index 72516101fdd0..7af37d4bd60a 100644
> > > > > > > --- a/drivers/media/usb/uvc/uvc_driver.c
> > > > > > > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > > > > > > @@ -7,6 +7,7 @@
> > > > > > >   */
> > > > > > >
> > > > > > >  #include <linux/atomic.h>
> > > > > > > +#include <linux/dmi.h>
> > > > > > >  #include <linux/gpio/consumer.h>
> > > > > > >  #include <linux/kernel.h>
> > > > > > >  #include <linux/list.h>
> > > > > > > @@ -1472,6 +1473,17 @@ static int uvc_parse_control(struct uvc_device *dev)
> > > > > > >  /* -----------------------------------------------------------------------------
> > > > > > >   * Privacy GPIO
> > > > > > >   */
> > > > > >
> > > > > > There should be a blank line here.
> > > > > >
> > > > > > > +static bool uvc_gpio_is_streaming(struct uvc_device *dev)
> > > > > > > +{
> > > > > > > +     struct uvc_streaming *streaming;
> > > > > > > +
> > > > > > > +     list_for_each_entry(streaming, &dev->streams, list) {
> > > > > > > +             if (uvc_queue_streaming(&streaming->queue))
> > > > > > > +                     return true;
> > > > > > > +     }
> > > > > > > +
> > > > > > > +     return false;
> > > > > > > +}
> > > > > > >
> > > > > > >
> > > > > >
> > > > > > But not too blank lines here.
> > > > > >
> > > > > > >  static u8 uvc_gpio_update_value(struct uvc_device *dev,
> > > > > > > @@ -1499,7 +1511,12 @@ static int uvc_gpio_get_cur(struct uvc_device *dev, struct uvc_entity *entity,
> > > > > > >       if (cs != UVC_CT_PRIVACY_CONTROL || size < 1)
> > > > > > >               return -EINVAL;
> > > > > > >
> > > > > > > +     if ((dev->quirks & UVC_QUIRK_PRIVACY_DURING_STREAM) &&
> > > > > > > +         !uvc_gpio_is_streaming(dev))
> > > > > > > +             return -EBUSY;
> > > > > > > +
> > > > > > >       *(uint8_t *)data = uvc_gpio_update_value(dev, entity);
> > > > > > > +
> > > > > > >       return 0;
> > > > > > >  }
> > > > > > >
> > > > > > > @@ -1528,19 +1545,50 @@ static struct uvc_entity *uvc_gpio_find_entity(struct uvc_device *dev)
> > > > > > >       return NULL;
> > > > > > >  }
> > > > > > >
> > > > > > > -static irqreturn_t uvc_gpio_irq(int irq, void *data)
> > > > > > > +void uvc_privacy_gpio_event(struct uvc_device *dev)
> > > > > > >  {
> > > > > > > -     struct uvc_device *dev = data;
> > > > > > >       struct uvc_entity *unit;
> > > > > > >
> > > > > > > +
> > > > > > >       unit = uvc_gpio_find_entity(dev);
> > > > > > >       if (!unit)
> > > > > > > -             return IRQ_HANDLED;
> > > > > > > +             return;
> > > > > > >
> > > > > > >       uvc_gpio_update_value(dev, unit);
> > > > > > > +}
> > > > > > > +
> > > > > > > +static irqreturn_t uvc_gpio_irq(int irq, void *data)
> > > > > > > +{
> > > > > > > +     struct uvc_device *dev = data;
> > > > > > > +
> > > > > > > +     /* Ignore privacy events during streamoff */
> > > > > > > +     if (dev->quirks & UVC_QUIRK_PRIVACY_DURING_STREAM)
> > > > > > > +             if (!uvc_gpio_is_streaming(dev))
> > > > > > > +                     return IRQ_HANDLED;
> > > > > >
> > > > > > I'm still a bit concerned of race conditions. When stopping the stream,
> > > > > > vb2_queue.streaming is set to 0 after calling the driver's .stop_stream()
> > > > > > handler. This means that the device will cut power before
> > > > > > uvc_gpio_is_streaming() can detect that streaming has stopped, and the
> > > > > > GPIO could thus trigger an IRQ.
> > > > >
> > > > > On the affected devices I have not seen this. I guess it takes some
> > > > > time to discharge. Anyway I am implementing a workaround. Tell me if
> > > > > it is too ugly.
> > > > >
> > > > > > You mentioned that devices have a pull-up or pull-down on the GPIO line.
> > > > > > As there are only two devices affected, do you know if it's a pull-up or
> > > > > > pull-down ? Would it be worse to expose that state to userspace than to
> > > > > > return -EBUSY when reading the control ?
> > > > >
> > > > > The module has a 100K pull up. This is, it will return "Privacy = 0".
> > > > >
> > > > > We cannot return the default value, as it would make the user believe
> > > > > that the privacy is in a different state that currently is.
> > > > > In other words, userspace needs to know at all times if the privacy is
> > > > > in : unknow_state, on, off.
> > > >
> > > > This seems to be the core of the issue: we're trying to shove 3 states
> > > > into a boolean. Would this call for turning the V4L2_CID_PRIVACY control
> > > > into a menu ? Or maybe setting V4L2_CTRL_FLAG_INACTIVE ? Returning
> > > > -EBUSY when the control is read while not streaming, and not generating
> > > > an event that tells the control value becomes unknown, seems like a hack
> > > > designed to work with a single userspace implementation.
> > > >
> > >
> > > I think that the V4L2_CTRL_FLAG_INACTIVE seems more correct. I will
> > > see how can I wire that up.
> >
> > Let me correct myself here. FLAG_INACTIVE is also not a good idea.
> >
> > you need two ioctls to read the value:
> > -queryctrl()
> > -g_ctrl()
> > and you cannot send both at the same time.
> >
> > I guess we need to keep the -EBUSY or move to a menu. Since we will
> > probably delay this patch for  a while. I will resend based on -EBUSY
> > at the end of my patchset, so it can be easily ignored if we find a
> > better solution.
>
> Hi Laurent, Kieran,
>
> Would it be okay to keep the behavior as suggested by Ricardo?

Gentle ping.

>
> Best regards,
> Tomasz
>
> >
> > Thanks!
> >
> > >
> > >
> > > > As the rest of the series is getting ready, I'd propose merging it
> > > > without this patch until we figure out what should be done to support
> > > > these lovely devices. Would that work for you ?
> > >
> > > Yes that sounds good to me. Thanks!
> > >
> > >
> > > >
> > > > > > > +
> > > > > > > +     uvc_privacy_gpio_event(dev);
> > > > > > > +
> > > > > > >       return IRQ_HANDLED;
> > > > > > >  }
> > > > > > >
> > > > > > > +static const struct dmi_system_id privacy_valid_during_streamon[] = {
> > > > > > > +     {
> > > > > > > +             .ident = "HP Elite c1030 Chromebook",
> > > > > > > +             .matches = {
> > > > > > > +                     DMI_MATCH(DMI_SYS_VENDOR, "HP"),
> > > > > > > +                     DMI_MATCH(DMI_PRODUCT_NAME, "Jinlon"),
> > > > > > > +             },
> > > > > > > +     },
> > > > > > > +     {
> > > > > > > +             .ident = "HP Pro c640 Chromebook",
> > > > > > > +             .matches = {
> > > > > > > +                     DMI_MATCH(DMI_SYS_VENDOR, "HP"),
> > > > > > > +                     DMI_MATCH(DMI_PRODUCT_NAME, "Dratini"),
> > > > > > > +             },
> > > > > > > +     },
> > > > > > > +     { } /* terminate list */
> > > > > > > +};
> > > > > > > +
> > > > > > >  static int uvc_gpio_parse(struct uvc_device *dev)
> > > > > > >  {
> > > > > > >       struct uvc_entity *unit;
> > > > > > > @@ -1577,6 +1625,9 @@ static int uvc_gpio_parse(struct uvc_device *dev)
> > > > > > >
> > > > > > >       list_add_tail(&unit->list, &dev->entities);
> > > > > > >
> > > > > > > +     if (dmi_check_system(privacy_valid_during_streamon))
> > > > > > > +             dev->quirks |= UVC_QUIRK_PRIVACY_DURING_STREAM;
> > > > > >
> > > > > > This will also match any external UVC camera plugged to one of the
> > > > > > affected systems, right ? It shouldn't matter in practice as those
> > > > > > devices won't have a GPIO entity.
> > > > >
> > > > > I did think about that but did not make it explicit in the code.
> > > > > Adding a comment.
> > > > >
> > > > > > I suppose we can't match on VID:PID instead because the same VID:PID is
> > > > > > used in both devices affected by this issue, and devices immune to it ?
> > > > >
> > > > > The problem with VID:PID, is that the manufacturer can decide to
> > > > > change the camera module and then the quirk will not work.
> > > > >
> > > > > We cannot rely ONLY in VID:PID as these modules are also used in other
> > > > > models not affected by the quirk.
> > > > >
> > > > > I believe that it is also correct to rely on the dmi, as the quirk is
> > > > > caused for the way the camera module is wired, which is on the
> > > > > motherboard.
> > > >
> > > > I can't comment on the hardware side as I lack details. Using the
> > > > VID:PID only seems a problem indeed. We could combine DMI and VID:PID,
> > > > but that wouldn't make a difference in practice, so I suppose this is
> > > > good enough.
> > > >
> > > > > > > +
> > > > > > >       return 0;
> > > > > > >  }
> > > > > > >
> > > > > > > diff --git a/drivers/media/usb/uvc/uvc_queue.c b/drivers/media/usb/uvc/uvc_queue.c
> > > > > > > index cd60c6c1749e..e800d491303f 100644
> > > > > > > --- a/drivers/media/usb/uvc/uvc_queue.c
> > > > > > > +++ b/drivers/media/usb/uvc/uvc_queue.c
> > > > > > > @@ -337,9 +337,12 @@ int uvc_dequeue_buffer(struct uvc_video_queue *queue, struct v4l2_buffer *buf,
> > > > > > >  int uvc_queue_streamon(struct uvc_video_queue *queue, enum v4l2_buf_type type)
> > > > > > >  {
> > > > > > >       int ret;
> > > > > > > +     struct uvc_streaming *stream = uvc_queue_to_stream(queue);
> > > > > >
> > > > > > Please swap the two lines.
> > > > > >
> > > > > > >
> > > > > > >       mutex_lock(&queue->mutex);
> > > > > > >       ret = vb2_streamon(&queue->queue, type);
> > > > > > > +     if (stream->dev->quirks & UVC_QUIRK_PRIVACY_DURING_STREAM)
> > > > > > > +             uvc_privacy_gpio_event(stream->dev);
> > > > > >
> > > > > > Even when vb2_streamon() failed ?
> > > > > >
> > > > > > >       mutex_unlock(&queue->mutex);
> > > > > > >
> > > > > > >       return ret;
> > > > > > > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > > > > > > index 079a407ebba5..32c1ba246d97 100644
> > > > > > > --- a/drivers/media/usb/uvc/uvcvideo.h
> > > > > > > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > > > > > > @@ -209,6 +209,7 @@
> > > > > > >  #define UVC_QUIRK_RESTORE_CTRLS_ON_INIT      0x00000400
> > > > > > >  #define UVC_QUIRK_FORCE_Y8           0x00000800
> > > > > > >  #define UVC_QUIRK_FORCE_BPP          0x00001000
> > > > > > > +#define UVC_QUIRK_PRIVACY_DURING_STREAM      0x00002000
> > > > > > >
> > > > > > >  /* Format flags */
> > > > > > >  #define UVC_FMT_FLAG_COMPRESSED              0x00000001
> > > > > > > @@ -826,6 +827,9 @@ extern const struct v4l2_file_operations uvc_fops;
> > > > > > >  int uvc_mc_register_entities(struct uvc_video_chain *chain);
> > > > > > >  void uvc_mc_cleanup_entity(struct uvc_entity *entity);
> > > > > > >
> > > > > > > +/* Privacy gpio */
> > > > > > > +void uvc_privacy_gpio_event(struct uvc_device *dev);
> > > > > > > +
> > > > > > >  /* Video */
> > > > > > >  int uvc_video_init(struct uvc_streaming *stream);
> > > > > > >  int uvc_video_suspend(struct uvc_streaming *stream);
> > > >
> > > > --
> > > > Regards,
> > > >
> > > > Laurent Pinchart
> > >
> > >
> > >
> > > --
> > > Ricardo Ribalda
> >
> >
> >
> > --
> > Ricardo Ribalda

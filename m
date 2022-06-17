Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B42B54F908
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 16:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381709AbiFQOTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 10:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbiFQOTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:19:11 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A959FD99
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:19:10 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id e67-20020a9d01c9000000b0060c221b1420so3232207ote.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tePk6gE5EYzJMX/tVHM22VabenFCCZzFf7vAI0EWFyQ=;
        b=f5hyNmqWNRMe3j9n+pN11Udlu0j4Pxrkm9doO4qpEDrgCp2LMEJpeKjJnhvEMoBykv
         mrnDW+Y6LSOAorzIJ36ZX23qdkkPfIbn6PzUk3rIp2X5xCB7qZ69RdjcREwn259JqVxK
         i3xNSP/PMZ68LxuVUefX8PIhY+mfDQQS17OMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tePk6gE5EYzJMX/tVHM22VabenFCCZzFf7vAI0EWFyQ=;
        b=jQtlSr77nnRIh4XIr45kOMqUQPp+CWGJoutpbROYDwRx+KB/TBjBMgbENlSwUxgWvv
         9JCZXB+ljH5V6bv3XhjhGvCPdyVAN1nVLYixT74Balz9QtkNxawetjfv5eq6putp5haw
         a2iUWX3eLR8xtl99GJ0jFtJWVo2VJhe2wn9Nd5Cjk7pLX+/hYjQXy3dDmNG6DcuQuBHP
         xw849ttGJxmSEf2+zF36uGSoENOktNpZg6hsk/Zpc/7IwGVefc347jsqKVvoE6ANYG/t
         S9tvl04N3RoTyld/nvYe3/qK1nMPEgyLqm+qqpJpib4789xNnvC8dPbhZaC4Zb3sR+nb
         1LpQ==
X-Gm-Message-State: AJIora8EvWz6Y0Fd+hdnxCex+sfk0RPgq+TzAz8tLEwvMy73JC6euPam
        CIJYUdGwuG6L5qcd3ojZBOWn8EYqKPwUxpkP
X-Google-Smtp-Source: AGRyM1sxzt9HGcTfNefPaJurqaFQpWgLVwYWidCxc5TRZb9BryoFAuRJKFPtX7pK2j3A+2eFylp2Eg==
X-Received: by 2002:a9d:d87:0:b0:60b:f52b:f762 with SMTP id 7-20020a9d0d87000000b0060bf52bf762mr4055479ots.127.1655475549771;
        Fri, 17 Jun 2022 07:19:09 -0700 (PDT)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com. [209.85.167.177])
        by smtp.gmail.com with ESMTPSA id c83-20020aca3556000000b0032b99637366sm2508348oia.25.2022.06.17.07.19.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 07:19:09 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id i25so5559730oii.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:19:08 -0700 (PDT)
X-Received: by 2002:aca:38c6:0:b0:32f:2477:2ec6 with SMTP id
 f189-20020aca38c6000000b0032f24772ec6mr10407782oia.66.1655475548200; Fri, 17
 Jun 2022 07:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220617103645.71560-1-ribalda@chromium.org> <20220617103645.71560-5-ribalda@chromium.org>
 <YqyJUikNtzvgujob@pendragon.ideasonboard.com>
In-Reply-To: <YqyJUikNtzvgujob@pendragon.ideasonboard.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 17 Jun 2022 16:18:57 +0200
X-Gmail-Original-Message-ID: <CANiDSCt4mHio7yzgo8afYipB82=DV9FG-rmJ_OnV1jk9QwQB7Q@mail.gmail.com>
Message-ID: <CANiDSCt4mHio7yzgo8afYipB82=DV9FG-rmJ_OnV1jk9QwQB7Q@mail.gmail.com>
Subject: Re: [PATCH v7 4/8] media: uvcvideo: Limit power line control for
 Quanta UVC Webcam
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org, senozhatsky@chromium.org, yunkec@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent

On Fri, 17 Jun 2022 at 16:02, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.

Thank you :)

>
> On Fri, Jun 17, 2022 at 12:36:41PM +0200, Ricardo Ribalda wrote:
> > The device does not implement the power line control correctly. Add a
> > corresponding control mapping override.
> >
> > Bus 001 Device 003: ID 0408:3090 Quanta Computer, Inc. USB2.0 HD UVC WebCam
> > Device Descriptor:
> >   bLength                18
> >   bDescriptorType         1
> >   bcdUSB               2.00
> >   bDeviceClass          239 Miscellaneous Device
> >   bDeviceSubClass         2
> >   bDeviceProtocol         1 Interface Association
> >   bMaxPacketSize0        64
> >   idVendor           0x0408 Quanta Computer, Inc.
> >   idProduct          0x3090
> >   bcdDevice            0.04
> >   iManufacturer           3 Quanta
> >   iProduct                1 USB2.0 HD UVC WebCam
> >   iSerial                 2 0x0001
> >   bNumConfigurations      1
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> >  drivers/media/usb/uvc/uvc_driver.c | 35 ++++++++++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > index 6c86faecbea2..4fb07084f1c0 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -2643,6 +2643,32 @@ MODULE_PARM_DESC(timeout, "Streaming control requests timeout");
> >   * Driver initialization and cleanup
> >   */
> >
> > +static const struct uvc_menu_info power_line_frequency_controls_limited[] = {
> > +     { 0, "Invalid" },
> > +     { 1, "50 Hz" },
> > +     { 2, "60 Hz" },
> > +};
>
> It's not nice to have to include the first item in the array, but we
> can't fix that without modifying uvc_menu_info, which we can't do as
> it's part of the UAPI. Let's keep it as-is, but I would then expose the
> uvc_menu_info array from uvc_ctrl.c instead of duplicating it here.

Instead of that, what about using the values from v4l2_ctrl_get_menu() ?

We will still provide a fallback in case the control is not standard.

Let me implement that in the next version and see what you think about it.

Regards!

>
> > +
> > +static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
> > +     .id             = V4L2_CID_POWER_LINE_FREQUENCY,
> > +     .entity         = UVC_GUID_UVC_PROCESSING,
> > +     .selector       = UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
> > +     .size           = 2,
> > +     .offset         = 0,
> > +     .v4l2_type      = V4L2_CTRL_TYPE_MENU,
> > +     .data_type      = UVC_CTRL_DATA_TYPE_ENUM,
> > +     .menu_info      = power_line_frequency_controls_limited,
> > +     .menu_min       = 1,
> > +     .menu_count     = ARRAY_SIZE(power_line_frequency_controls_limited),
> > +};
> > +
> > +static const struct uvc_device_info uvc_ctrl_power_line_limited = {
> > +     .mappings = (const struct uvc_control_mapping *[]) {
> > +             &uvc_ctrl_power_line_mapping_limited,
> > +             NULL, /* Sentinel */
> > +     },
> > +};
> > +
> >  static const struct uvc_device_info uvc_quirk_probe_minmax = {
> >       .quirks = UVC_QUIRK_PROBE_MINMAX,
> >  };
> > @@ -2673,6 +2699,15 @@ static const struct uvc_device_info uvc_quirk_force_y8 = {
> >   * though they are compliant.
> >   */
> >  static const struct usb_device_id uvc_ids[] = {
> > +     /* Quanta USB2.0 HD UVC Webcam */
> > +     { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> > +                             | USB_DEVICE_ID_MATCH_INT_INFO,
> > +       .idVendor             = 0x0408,
> > +       .idProduct            = 0x3090,
> > +       .bInterfaceClass      = USB_CLASS_VIDEO,
> > +       .bInterfaceSubClass   = 1,
> > +       .bInterfaceProtocol   = 0,
> > +       .driver_info          = (kernel_ulong_t)&uvc_ctrl_power_line_limited },
> >       /* LogiLink Wireless Webcam */
> >       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> >                               | USB_DEVICE_ID_MATCH_INT_INFO,
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D042159EAF0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbiHWS0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiHWSZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:25:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A105C108D
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 09:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661273042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mppPawPOkC8dhN6QvQLe5lTi5TBeQJ4AVVFwr4C9YA4=;
        b=IDsnE8i+UUhvBIxcd1TmwEl5nPlDPnwZI/Q6tuWcfkjmEntGmTS3i1HIyB5uwR7xMra9lh
        CXKwOpmzoKJ6ZmyMMImRPihO5OWB9LXgigDVWKhNEJRBFUcbBE4095pphwZ1q/tav+H+Xf
        C2KgsmV9ADhafOh4/qnII47pqeV9GPs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-582-MN4IUq5dOr6i1lgTJZBOHg-1; Tue, 23 Aug 2022 12:44:01 -0400
X-MC-Unique: MN4IUq5dOr6i1lgTJZBOHg-1
Received: by mail-pj1-f72.google.com with SMTP id j11-20020a17090a738b00b001faeb619f6eso4620109pjg.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 09:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=mppPawPOkC8dhN6QvQLe5lTi5TBeQJ4AVVFwr4C9YA4=;
        b=ncVqoIJaOZyPWdO3zIFG2fEQESkkXltW1hewlnTwt+vtmF+3fIYxVbEaJr+4DnPIDd
         DOPU8TrlUImboQhI6OCuuAn2x5lDE7UcB2JUPGpj6fsXowsJuYhcQqsU4tkcGsNctrZ+
         q16BMUnk2TWee+EwUEwS569uXSNKZyBWEq6HMKKUekcsgePG2EvhuWQoGn1TjNVsjolm
         Q0OHqv0PwPYzP0/p5/m31y6qtSguWnQoknRbogrmgE63OKb79u0CZDUVcG3vCnDWyIoc
         q7HD8n2HiqdFwD1sbAZdkX9husz9mjySPsNhgANg0djDb4eiyRZb57WWGId6n6Cqray9
         o1Nw==
X-Gm-Message-State: ACgBeo2tzLnVRpjNJfmH1TibOY0aoRzY1WEJYlDD/Bu5IH9KRHt2t2eE
        4tezrviTSsVKkxaB+J6N3ZH+J07PN6rAzCkYK/TVWLE+2tTjMATmpIJ4Sl63budu6AHnQ2XkNAW
        yMB9GOrrLGpzgwTfJdrccwNnzOSx1wqEAb0l9Tz1k
X-Received: by 2002:a17:903:110e:b0:171:5a95:a91d with SMTP id n14-20020a170903110e00b001715a95a91dmr25036980plh.3.1661273039923;
        Tue, 23 Aug 2022 09:43:59 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5qBI3+tYvBmWZQOgbSJhX4pIQOrpXwszXhqdRdigvO6iwIMXTZy2NXiDjh1ZL8rXHiERsStbm8qVQORNszaRA=
X-Received: by 2002:a17:903:110e:b0:171:5a95:a91d with SMTP id
 n14-20020a170903110e00b001715a95a91dmr25036961plh.3.1661273039448; Tue, 23
 Aug 2022 09:43:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220822060936.769855-1-marcus.folkesson@gmail.com>
 <CAO-hwJ+3Yrr--cr=r5+jvs4A=A-cmDtrKQETo=YOYDC3nXTMBg@mail.gmail.com> <YwTvrNuulKx0SB6H@gmail.com>
In-Reply-To: <YwTvrNuulKx0SB6H@gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 23 Aug 2022 18:43:47 +0200
Message-ID: <CAO-hwJKiq50fWwXNUGcXeWtWcUXb65ZmJMsADfrsUTac_Xj2dw@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/2] HID: Add driver for RC Simulator Controllers
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Jiri Kosina <jikos@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 5:13 PM Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
>
> Thank you  Benjamin,
>
> On Tue, Aug 23, 2022 at 11:49:59AM +0200, Benjamin Tissoires wrote:
> > Hi Marcus,
> >
> > [and sorry for the delay in the review of your patches]
> >
> > On Mon, Aug 22, 2022 at 8:04 AM Marcus Folkesson
> > <marcus.folkesson@gmail.com> wrote:
> > >
> > > Several RC Simulator Controllers are HID compliant with similar
> > > interface.
> > >
> > > Add support for these controllers:
> > >  - Phoenix RC (HID variant)
> > >  - Car VRC2.0
> > >  - Real Flight G5/G6/G7
> > >  - Aero Fly, FMS
> > >  - OrangeRX FrSky
> > >
> > > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > > ---
> > >  Documentation/hid/index.rst |   1 +
> > >  Documentation/hid/rcsim.rst | 142 ++++++++++++++++
> > >  drivers/hid/Kconfig         |  11 ++
> > >  drivers/hid/Makefile        |   1 +
> > >  drivers/hid/hid-ids.h       |   5 +
> > >  drivers/hid/hid-rcsim.c     | 315 ++++++++++++++++++++++++++++++++++++
> > >  6 files changed, 475 insertions(+)
> > >  create mode 100644 Documentation/hid/rcsim.rst
> > >  create mode 100644 drivers/hid/hid-rcsim.c
> > >
> > > diff --git a/Documentation/hid/index.rst b/Documentation/hid/index.rst
> > > index e50f513c579c..e5813d264f37 100644
> > > --- a/Documentation/hid/index.rst
> > > +++ b/Documentation/hid/index.rst
> > > @@ -17,3 +17,4 @@ Human Interface Devices (HID)
> > >     hid-alps
> > >     intel-ish-hid
> > >     amd-sfh-hid
> > > +   rcsim
> > > diff --git a/Documentation/hid/rcsim.rst b/Documentation/hid/rcsim.rst
> > > new file mode 100644
> > > index 000000000000..1a031f7189cb
> > > --- /dev/null
> > > +++ b/Documentation/hid/rcsim.rst
> > > @@ -0,0 +1,142 @@
> > > +.. SPDX-License-Identifier: GPL-2.0
> > > +
> > > +=================================
> > > +rcsim - RC Simulator Controllers
> > > +=================================
> > > +
> > > +:Author: Marcus Folkesson <marcus.folkesson@gmail.com>
> > > +
> > > +This driver let you use your own RC controller plugged
> > > +into your computer using an HID compatible USB dongle.
> > > +
> > > +There are several HID compatible USB dongles from different
> > > +vendors. The driver currently supports:
> > > +
> > > +- Phoenix RC (HID variant) (8ch)
> > > +- Car VRC2.0 (2ch)
> > > +- Real Flight G5/G6/G7 (6ch)
> > > +- Aero Fly, FMS (8ch)
> > > +- OrangeRX FrSky (6ch)
> > > +
> > > +Many RC controllers is able to configure which stick goes to which channel.
> > > +This is also configurable in most simulators, so a matching is not necessary.
> > > +
> > > +Supported dongles
> > > +==================
> > > +
> > > +PhoenixRC
> > > +----------
> > > +
> > > +The PhoenixRC has one HID compatible variant which is supported by this driver.
> > > +The controller has support for 8 analog channels.
> > > +
> > > +The driver is generating the following input event for on channels:
> > > +
> > > ++---------+----------------+
> > > +| Channel |      Event     |
> > > ++=========+================+
> > > +|     1   |  ABS_Y         |
> > > ++---------+----------------+
> > > +|     2   |  ABS_X         |
> > > ++---------+----------------+
> > > +|     3   |  ABS_RY        |
> > > ++---------+----------------+
> > > +|     4   |  ABS_RX        |
> > > ++---------+----------------+
> > > +|     5   |  ABS_RUDDER    |
> > > ++---------+----------------+
> > > +|     6   |  ABS_THROTTLE  |
> > > ++---------+----------------+
> > > +|     7   |  ABS_Z         |
> > > ++---------+----------------+
> > > +|     8   |  ABS_RZ        |
> > > ++---------+----------------+
> > > +
> > > +VRC2.0
> > > +----------
> > > +VRC2.0 is a controller for RC Cars.
> > > +The controller has support for 2 analog channels.
> > > +
> > > +The driver is generating the following input event for on channels:
> > > +
> > > ++---------+----------------+
> > > +| Channel |      Event     |
> > > ++=========+================+
> > > +|     1   |  ABS_GAS       |
> > > ++---------+----------------+
> > > +|     2   |  ABS_WHEEL     |
> > > ++---------+----------------+
> > > +
> > > +RealFlight
> > > +----------
> > > +
> > > +This driver supports Realflight G4-G7 and above
> > > +The controller has support for 4 analog channels and two buttons.
> > > +
> > > +The driver is generating the following input event for on channels:
> > > +
> > > ++---------+----------------+
> > > +| Channel |      Event     |
> > > ++=========+================+
> > > +|     1   |  ABS_Y         |
> > > ++---------+----------------+
> > > +|     2   |  ABS_X         |
> > > ++---------+----------------+
> > > +|     3   |  ABS_RY        |
> > > ++---------+----------------+
> > > +|     4   |  ABS_RX        |
> > > ++---------+----------------+
> > > +|     5   |  BTN_A         |
> > > ++---------+----------------+
> > > +|     6   |  BTN_B         |
> > > ++---------+----------------+
> > > +
> > > +XTR+G2+FMS Controllers
> > > +--------------------------------
> > > +
> > > +The controllers has support for 8 analog channels.
> > > +
> > > +The driver is generating the following input event for on channels:
> > > +
> > > ++---------+----------------+
> > > +| Channel |      Event     |
> > > ++=========+================+
> > > +|     1   |  ABS_Y         |
> > > ++---------+----------------+
> > > +|     2   |  ABS_X         |
> > > ++---------+----------------+
> > > +|     3   |  ABS_RY        |
> > > ++---------+----------------+
> > > +|     4   |  ABS_RX        |
> > > ++---------+----------------+
> > > +|     5   |  ABS_RUDDER    |
> > > ++---------+----------------+
> > > +|     6   |  ABS_THROTTLE  |
> > > ++---------+----------------+
> > > +|     7   |  ABS_Z         |
> > > ++---------+----------------+
> > > +|     8   |  ABS_RZ        |
> > > ++---------+----------------+
> > > +
> > > +OrangeRX
> > > +----------
> > > +
> > > +The controllers has support for 6 analog channels.
> > > +
> > > +The driver is generating the following input event for on channels:
> > > +
> > > ++---------+----------------+
> > > +| Channel |      Event     |
> > > ++=========+================+
> > > +|     1   |  ABS_Y         |
> > > ++---------+----------------+
> > > +|     2   |  ABS_X         |
> > > ++---------+----------------+
> > > +|     3   |  ABS_RY        |
> > > ++---------+----------------+
> > > +|     4   |  ABS_RX        |
> > > ++---------+----------------+
> > > +|     5   |  ABS_RUDDER    |
> > > ++---------+----------------+
> > > +|     6   |  ABS_THROTTLE  |
> > > ++---------+----------------+
> > > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> > > index 70da5931082f..d8313d36086c 100644
> > > --- a/drivers/hid/Kconfig
> > > +++ b/drivers/hid/Kconfig
> > > @@ -957,6 +957,17 @@ config HID_RAZER
> > >         Support for Razer devices that are not fully compliant with the
> > >         HID standard.
> > >
> > > +config HID_RCSIM
> > > +       tristate "RC Simulator Controllers"
> > > +       depends on HID
> > > +       help
> > > +       Support for several HID compatible RC Simulator Controllers including
> > > +         - Phoenix RC
> > > +         - Car VRC2.0
> > > +         - Real Flight
> > > +         - Aero Fly, FMS
> > > +         - OrangeRX FrSky
> > > +
> > >  config HID_PRIMAX
> > >         tristate "Primax non-fully HID-compliant devices"
> > >         depends on HID
> > > diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> > > index cac2cbe26d11..85d50ab352ee 100644
> > > --- a/drivers/hid/Makefile
> > > +++ b/drivers/hid/Makefile
> > > @@ -102,6 +102,7 @@ obj-$(CONFIG_HID_PLANTRONICS)       += hid-plantronics.o
> > >  obj-$(CONFIG_HID_PLAYSTATION)  += hid-playstation.o
> > >  obj-$(CONFIG_HID_PRIMAX)       += hid-primax.o
> > >  obj-$(CONFIG_HID_RAZER)        += hid-razer.o
> > > +obj-$(CONFIG_HID_RCSIM)        += hid-rcsim.o
> >
> > General rule of thumbs, we try to name the drivers after their
> > vendors, unless we know we have a generic driver.
> >
> > Here, this driver seems to be really tied to a small set of devices,
> > and thus I don't think we can call it "generic".
>
> Got it.
>
> >
> > >  obj-$(CONFIG_HID_REDRAGON)     += hid-redragon.o
> > >  obj-$(CONFIG_HID_RETRODE)      += hid-retrode.o
> > >  obj-$(CONFIG_HID_ROCCAT)       += hid-roccat.o hid-roccat-common.o \
> > > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > > index d9eb676abe96..baf5f74d5bed 100644
> > > --- a/drivers/hid/hid-ids.h
> > > +++ b/drivers/hid/hid-ids.h
> > > @@ -1381,6 +1381,11 @@
> > >
> > >  #define USB_VENDOR_ID_MULTIPLE_1781    0x1781
> > >  #define USB_DEVICE_ID_RAPHNET_4NES4SNES_OLD    0x0a9d
> > > +#define USB_DEVICE_ID_PHOENIXRC        0x0898
> > > +#define USB_DEVICE_ID_REALFLIGHT       0x0e56
> > > +
> > > +#define USB_VENDOR_ID_DIPLING  0x0B9B
> > > +#define USB_DEVICE_ID_DIPLING_RCCONTROLLER     0x4012
> > >
> > >  #define USB_VENDOR_ID_DRACAL_RAPHNET   0x289b
> > >  #define USB_DEVICE_ID_RAPHNET_2NES2SNES        0x0002
> > > diff --git a/drivers/hid/hid-rcsim.c b/drivers/hid/hid-rcsim.c
> > > new file mode 100644
> > > index 000000000000..0f214cb5816a
> > > --- /dev/null
> > > +++ b/drivers/hid/hid-rcsim.c
> > > @@ -0,0 +1,315 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Driver for several HID compatible RC Simulator Controllers.
> > > + * Currently supported controllers are:
> > > + *
> > > + * - Phoenix RC (HID variant) (8ch)
> > > + * - Car VRC2.0 (2ch)
> > > + * - Real Flight G5/G6/G7 (6ch)
> > > + * - Aero Fly, FMS (8ch)
> > > + * - OrangeRX FrSky (6ch)
> > > + *
> > > + * Copyright (C) 2022 Marcus Folkesson <marcus.folkesson@gmail.com>
> > > + */
> > > +
> > > +#include <linux/bitfield.h>
> > > +#include <linux/device.h>
> > > +#include <linux/input.h>
> > > +#include <linux/hid.h>
> > > +#include <linux/module.h>
> > > +#include <linux/usb.h>
> > > +
> > > +#include "hid-ids.h"
> > > +
> > > +/*
> > > + * Some of these VID/PID are probably "borrowed", so keep them locally and
> > > + * do not populate hid-ids.h with those.
> > > + */
> > > +
> > > +/* PHOENIXRC Controlloer (HID variant) */
> > > +#define PHOENIXRC_VID  (USB_VENDOR_ID_MULTIPLE_1781)
> > > +#define PHOENIXRC_PID  (USB_DEVICE_ID_PHOENIXRC)
> > > +#define PHOENIXRC_DSIZE        (8)
> > > +
> > > +/* VRC2 Controlloer */
> > > +#define VRC2_VID       (0x07c0)
> > > +#define VRC2_PID       (0x1125)
> > > +#define VRC2_DSIZE     (7)
> > > +
> > > +/* Realflight G4-&7 and Above Controller */
> > > +#define REALFLIGHT_VID (USB_VENDOR_ID_MULTIPLE_1781)
> > > +#define REALFLIGHT_PID (USB_DEVICE_ID_REALFLIGHT)
> > > +#define REALFLIGHT_DSIZE       (8)
> > > +
> > > +#define REALFLIGHT_BTN_A       BIT(0)
> > > +#define REALFLIGHT_BTN_B       BIT(1)
> > > +
> > > +/* XTR+G2+FMS Controller */
> > > +#define XTRG2FMS_VID   (USB_VENDOR_ID_DIPLING)
> > > +#define XTRG2FMS_PID   (USB_DEVICE_ID_DIPLING_RCCONTROLLER)
> > > +#define XTRG2FMS_DSIZE (8)
> > > +
> > > +#define XTRG2FMS_X_HI  GENMASK(3, 2)
> > > +#define XTRG2FMS_Y_HI  GENMASK(1, 0)
> > > +#define XTRG2FMS_RX_HI GENMASK(7, 6)
> > > +#define XTRG2FMS_RY_HI GENMASK(5, 4)
> > > +#define XTRG2FMS_ALT1_HI       GENMASK(3, 2)
> > > +#define XTRG2FMS_ALT2_HI       GENMASK(1, 0)
> > > +
> > > +/* OrangeRX FrSky */
> > > +#define ORANGERX_VID   (0x0451)
> > > +#define ORANGERX_PID   (0x16a5)
> > > +#define ORANGERX_DSIZE (8)
> > > +
> > > +enum rcsim_controller {
> > > +       PHOENIXRC,
> > > +       VRC2,
> > > +       REALFLIGHT,
> > > +       XTRG2FMS,
> > > +       ORANGERX
> > > +};
> > > +
> > > +struct rcsim_priv {
> > > +       struct hid_device *hdev;
> > > +       struct input_dev *input;
> > > +       enum rcsim_controller controller;
> > > +       u8 alt;
> > > +};
> > > +
> > > +static int rcsim_open(struct input_dev *dev)
> > > +{
> > > +       struct rcsim_priv *priv = input_get_drvdata(dev);
> > > +
> > > +       return hid_hw_open(priv->hdev);
> > > +}
> > > +
> > > +static void rcsim_close(struct input_dev *dev)
> > > +{
> > > +       struct rcsim_priv *priv = input_get_drvdata(dev);
> > > +
> > > +       hid_hw_close(priv->hdev);
> > > +}
> > > +
> > > +static int rcsim_setup_input(struct rcsim_priv *priv)
> > > +{
> > > +       struct input_dev *input;
> > > +
> > > +       input = devm_input_allocate_device(&priv->hdev->dev);
> > > +       if (!input)
> > > +               return -ENOMEM;
> > > +
> > > +       input->id.bustype = priv->hdev->bus;
> > > +       input->id.vendor  = priv->hdev->vendor;
> > > +       input->id.product = priv->hdev->product;
> > > +       input->id.version = priv->hdev->bus;
> > > +       input->phys = priv->hdev->phys;
> > > +       input->uniq = priv->hdev->uniq;
> > > +       input->open = rcsim_open;
> > > +       input->close = rcsim_close;
> > > +
> > > +       input_set_drvdata(input, priv);
> > > +
> > > +       switch (priv->controller) {
> > > +       case PHOENIXRC:
> > > +               input_set_abs_params(input, ABS_X, 0, 255, 0, 0);
> > > +               input_set_abs_params(input, ABS_Y, 0, 255, 0, 0);
> > > +               input_set_abs_params(input, ABS_RX, 0, 255, 0, 0);
> > > +               input_set_abs_params(input, ABS_RY, 0, 255, 0, 0);
> > > +               input_set_abs_params(input, ABS_Z, 0, 255, 0, 0);
> > > +               input_set_abs_params(input, ABS_RZ, 0, 255, 0, 0);
> > > +               input_set_abs_params(input, ABS_RUDDER, 0, 255, 0, 0);
> > > +               input_set_abs_params(input, ABS_THROTTLE, 0, 255, 0, 0);
> > > +               input->name = "RC Simuator Controller PhoenixRC";
> > > +               break;
> > > +       case VRC2:
> > > +               input_set_abs_params(input, ABS_GAS, 0, 2048, 0, 0);
> > > +               input_set_abs_params(input, ABS_WHEEL, 0, 2048, 0, 0);
> > > +               input->name = "RC Simuator Controller VRC2.0";
> > > +               break;
> > > +       case REALFLIGHT:
> > > +               input_set_abs_params(input, ABS_X, 0, 1024, 0, 0);
> > > +               input_set_abs_params(input, ABS_Y, 0, 1024, 0, 0);
> > > +               input_set_abs_params(input, ABS_RX, 0, 1024, 0, 0);
> > > +               input_set_abs_params(input, ABS_RY, 0, 1024, 0, 0);
> > > +               input_set_capability(input, EV_KEY, BTN_A);
> > > +               input_set_capability(input, EV_KEY, BTN_B);
> > > +               input->name = "RC Simuator Controller Realflight";
> > > +               break;
> > > +       case XTRG2FMS:
> > > +               input_set_abs_params(input, ABS_X, 0, 1024, 0, 0);
> > > +               input_set_abs_params(input, ABS_Y, 0, 1024, 0, 0);
> > > +               input_set_abs_params(input, ABS_RX, 0, 1024, 0, 0);
> > > +               input_set_abs_params(input, ABS_RY, 0, 1024, 0, 0);
> > > +               input_set_abs_params(input, ABS_Z, 0, 1024, 0, 0);
> > > +               input_set_abs_params(input, ABS_RZ, 0, 1024, 0, 0);
> > > +               input_set_abs_params(input, ABS_RUDDER, 0, 1024, 0, 0);
> > > +               input_set_abs_params(input, ABS_THROTTLE, 0, 1024, 0, 0);
> > > +               input->name = "RC Simuator Controller AeroFly, FMS";
> > > +               priv->alt = 0;
> > > +               break;
> > > +       case ORANGERX:
> > > +               input_set_abs_params(input, ABS_X, 0, 255, 0, 0);
> > > +               input_set_abs_params(input, ABS_Y, 0, 255, 0, 0);
> > > +               input_set_abs_params(input, ABS_RX, 0, 255, 0, 0);
> > > +               input_set_abs_params(input, ABS_RY, 0, 255, 0, 0);
> > > +               input_set_abs_params(input, ABS_RUDDER, 0, 255, 0, 0);
> > > +               input_set_abs_params(input, ABS_THROTTLE, 0, 255, 0, 0);
> > > +               input->name = "RC Simuator Controller OrangeRX FrSky";
> > > +               break;
> > > +       };
> > > +
> > > +       priv->input = input;
> > > +       return input_register_device(priv->input);
> > > +}
> >
> > You are basically rewriting hid-input.c, which is suboptimal.
>
> Ouch. I will have a look at hid-input, thanks.
>
> >
> > I guess the report descriptor provided by these devices are basically
> > useless, and so you have to parse the reports yourself in the
> > raw_event callback.
>
> Yep.
>
> >
> > But instead of manually doing that, why not overwrite the report
> > descriptor (with .rdesc_fixup) and declare here all of the data that
>  Do you mean .report_fixup?

yes, sorry :/

>
> > needs to be exported. You could remove basically everything in this
> > driver by just providing a fixed report descriptor.
>
> What you are aiming for is to fixup the report descriptor and let the
> generic hid-raw driver handle the rest, or do I get you wrong?

yep, exactly

>
> How is the report mapped to certain events then?

Have a look at hid_configure_usage in hid-input.c [3]. Most of HID
events are mapped to input events with a one to one mapping.

>
> I do read at [1] but it is not obvious how to put it together.
> Most drivers I've looked at that is using .report_fixup just fix broken
> reports. I guess these reports are not "broken", just.. odd?

Have a look at [2], lots of full report descriptors :)

And in your case, the reports are incomplete, not odd.

>
>
> >
> > > +
> > > +static int rcsim_raw_event(struct hid_device *hdev,
> > > +                              struct hid_report *report,
> > > +                              u8 *raw_data, int size)
> > > +{
> > > +       struct rcsim_priv *priv = hid_get_drvdata(hdev);
> > > +       u16 value;
> > > +
> > > +       switch (priv->controller) {
> > > +       case PHOENIXRC:
> > > +               if (size != PHOENIXRC_DSIZE)
> > > +                       break;
> > > +
> > > +               /* X, RX, Y and RY, RUDDER and THROTTLE are sent every time */
> > > +               input_report_abs(priv->input, ABS_X, raw_data[2]);
> > > +               input_report_abs(priv->input, ABS_Y, raw_data[0]);
> > > +               input_report_abs(priv->input, ABS_RX, raw_data[4]);
> > > +               input_report_abs(priv->input, ABS_RY, raw_data[3]);
> > > +               input_report_abs(priv->input, ABS_RUDDER, raw_data[5]);
> > > +               input_report_abs(priv->input, ABS_THROTTLE, raw_data[6]);
> > > +
> > > +               /* Z and RZ are sent every other time */
> > > +               if (priv->alt)
> > > +                       input_report_abs(priv->input, ABS_Z, raw_data[7]);
> > > +               else
> > > +                       input_report_abs(priv->input, ABS_RZ, raw_data[7]);
> > > +
> > > +               priv->alt ^= 1;
> > > +               break;
> > > +       case VRC2:
> > > +               if (size != VRC2_DSIZE)
> > > +                       break;
> > > +               value = (raw_data[1] << 8 | raw_data[0]) & GENMASK(10, 0);
> > > +               input_report_abs(priv->input, ABS_GAS, value);
> > > +               value = (raw_data[3] << 8 | raw_data[2]) & GENMASK(10, 0);
> > > +               input_report_abs(priv->input, ABS_WHEEL, value);
> > > +               break;
> > > +       case REALFLIGHT:
> > > +               if (size != REALFLIGHT_DSIZE)
> > > +                       break;
> > > +               input_report_abs(priv->input, ABS_X, raw_data[2]);
> > > +               input_report_abs(priv->input, ABS_Y, raw_data[1]);
> > > +               input_report_abs(priv->input, ABS_RX, raw_data[5]);
> > > +               input_report_abs(priv->input, ABS_RY, raw_data[3]);
> > > +               input_report_abs(priv->input, ABS_MISC, raw_data[4]);
> > > +               input_report_key(priv->input, BTN_A,
> > > +                               raw_data[7] & REALFLIGHT_BTN_A);
> > > +               input_report_key(priv->input, BTN_B,
> > > +                               raw_data[7] & REALFLIGHT_BTN_B);
> > > +               break;
> > > +       case XTRG2FMS:
> > > +               if (size != XTRG2FMS_DSIZE)
> > > +                       break;
> > > +
> > > +               /* X, RX, Y and RY are sent every time */
> > > +               value = FIELD_GET(XTRG2FMS_X_HI, raw_data[3]);
> > > +               value = (value << 8) | raw_data[1];
> > > +               input_report_abs(priv->input, ABS_X, value);
> > > +
> > > +               value = FIELD_GET(XTRG2FMS_Y_HI, raw_data[3]);
> > > +               value = (value << 8) | raw_data[2];
> > > +               input_report_abs(priv->input, ABS_Y, value);
> > > +
> > > +               value = FIELD_GET(XTRG2FMS_RX_HI, raw_data[3]);
> > > +               value = (value << 8) | raw_data[0];
> > > +               input_report_abs(priv->input, ABS_RX, value);
> > > +
> > > +               value = FIELD_GET(XTRG2FMS_RY_HI, raw_data[3]);
> > > +               value = (value << 8) | raw_data[4];
> > > +               input_report_abs(priv->input, ABS_RY, value);
> > > +
> > > +               /* Z, RZ, RUDDER and THROTTLE are sent every other time */
> > > +               value = FIELD_GET(XTRG2FMS_ALT1_HI, raw_data[7]);
> > > +               value = (value << 8) | raw_data[6];
> > > +               if (priv->alt)
> > > +                       input_report_abs(priv->input, ABS_Z, value);
> > > +               else
> > > +                       input_report_abs(priv->input, ABS_RUDDER, value);
> > > +
> > > +               value = FIELD_GET(XTRG2FMS_ALT2_HI, raw_data[7]);
> > > +               value = (value << 8) | raw_data[5];
> > > +               if (priv->alt)
> > > +                       input_report_abs(priv->input, ABS_RZ, value);
> > > +               else
> > > +                       input_report_abs(priv->input, ABS_THROTTLE, value);
> > > +
> > > +               priv->alt ^= 1;
> > > +               break;
> > > +       case ORANGERX:
> > > +               if (size != ORANGERX_DSIZE)
> > > +                       break;
> > > +               input_report_abs(priv->input, ABS_X, raw_data[0]);
> > > +               input_report_abs(priv->input, ABS_Y, raw_data[2]);
> > > +               input_report_abs(priv->input, ABS_RX, raw_data[3]);
> > > +               input_report_abs(priv->input, ABS_RY, raw_data[1]);
> > > +               input_report_abs(priv->input, ABS_RUDDER, raw_data[5]);
> > > +               input_report_abs(priv->input, ABS_THROTTLE, raw_data[6]);
> > > +               break;
> > > +       };
> > > +
> > > +       input_sync(priv->input);
> > > +       return 0;
> > > +}
> > > +
> > > +static int rcsim_probe(struct hid_device *hdev, const struct hid_device_id *id)
> > > +{
> > > +       struct device *dev = &hdev->dev;
> > > +       struct rcsim_priv *priv;
> > > +       int ret;
> > > +
> > > +       if (!hid_is_using_ll_driver(hdev, &usb_hid_driver))
> > > +               return -ENODEV;
> >
> > You are not accessing anything in the USB stack, so there is no need
> > to prevent regression tests that could inject uhid devices to your
> > drivers.
>
> Ok, thanks.
>
> >
> > Cheers,
> > Benjamin
> >
>
> Best regards,
> Marcus Folkesson
>
> [1] https://www.usb.org/hid
>

If you need help in writing report descriptors, I can give you some,
but the easiest might be for you to start from the report descriptor
in hid-sony.c. I used to have a tool to dynamically write a report
descriptor, but I'm not sure it still works...

FYI, I just re-read rcsim_raw_event() and there is stuff that would
require more than just a report descriptor fixup (the fact that some
data is sent every other report is not good and will need some manual
handling though).

Cheers,
Benjamin

[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/hid/hid-uclogic-rdesc.c
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/hid/hid-input.c#n817


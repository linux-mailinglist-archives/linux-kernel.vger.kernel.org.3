Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF015A6376
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiH3MgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiH3MgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:36:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33DAA61DF
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 05:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661862970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5oiYjf0mGVRXobzkKbV/sPZDxZVW6AII2pTU2TKyMq8=;
        b=Mu1NQsBK2QR6BgkyF4wRxZ+SsM8cRg2Fe8ufMuuf28TVUbXkypJGC/8dV5RBxTFQiMaz+e
        aRS+ZIijZ615tKwe4u+Ah+EoqZqXuahj19Q6P2k5NP2jv0ZCkctEyl2O7K0ockTq6/9rYR
        dTsGuR2lKyPFztyTtJIfEUJuJmVj890=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-389-pur2U4iwMPaHtBmaryHuRA-1; Tue, 30 Aug 2022 08:36:08 -0400
X-MC-Unique: pur2U4iwMPaHtBmaryHuRA-1
Received: by mail-pl1-f199.google.com with SMTP id m15-20020a170902db0f00b001753b1c5adeso11722plx.18
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 05:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5oiYjf0mGVRXobzkKbV/sPZDxZVW6AII2pTU2TKyMq8=;
        b=lKrMVxuHXhQE6cgYSIO1JrWh2MlS/EBjfiZcmYNu+YjXJoOWIsMobSBR7l8i57THI6
         8vg0hQLQmUwfGdU0DIDw+K0WHi45o1mpwE0Pu3OVVNPFANQZOBlGE0UUvYs6Ay8H01nW
         XtEOdZOfgCyAeS5OKEd442DqhtD9zP+Z0WOl0iP7oN8p6dYGho2i0/ZjaKgHliIhc7mp
         be/chDJ3GUU3k/DQ64RanDuIJecdd8Mmq4JAGSEWbg5M2z1xGeRJxK94J0b2zV0HtXpy
         ZNhD/CZyotaD/FJl0lTv7ZXR85i0cjK0JNfXSFZ3CQmmR/CbBOolsKfpTuf3uW7SLflQ
         Vh1w==
X-Gm-Message-State: ACgBeo3boixHFxA3nI5QBavvvMV0+BhPhtXm7cHBQXWIkaXk3iKRr/4V
        G/BzHIm26z6W3pZHXMZJ3YKG+zKlUI9CnzXT8PgDd+N1oHvNAquRRxQCVLGdxZqmopjOe1GW0E1
        1w0Te9BQyAGAyh9XgoYIEnyQxiIqTObUoD+0AQSQp
X-Received: by 2002:a17:902:b58a:b0:16e:f91a:486b with SMTP id a10-20020a170902b58a00b0016ef91a486bmr21598101pls.119.1661862966360;
        Tue, 30 Aug 2022 05:36:06 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6RGHLOYWvG1/wLvEI4d119yJ1JbZ2ET1bLsBpoVe0M65yG5yg76TP8DqXe8znDOmzi5ZjlqPW52EhueTuHiTE=
X-Received: by 2002:a17:902:b58a:b0:16e:f91a:486b with SMTP id
 a10-20020a170902b58a00b0016ef91a486bmr21598056pls.119.1661862965842; Tue, 30
 Aug 2022 05:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220822060936.769855-1-marcus.folkesson@gmail.com>
 <CAO-hwJ+3Yrr--cr=r5+jvs4A=A-cmDtrKQETo=YOYDC3nXTMBg@mail.gmail.com>
 <YwTvrNuulKx0SB6H@gmail.com> <CAO-hwJKiq50fWwXNUGcXeWtWcUXb65ZmJMsADfrsUTac_Xj2dw@mail.gmail.com>
 <Ywt5Oo+kTDoZFbqH@gmail.com>
In-Reply-To: <Ywt5Oo+kTDoZFbqH@gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 30 Aug 2022 14:35:54 +0200
Message-ID: <CAO-hwJ+YD8KuaO86Ws0T0y1VBzttpVSEKW=ut0JuT4TxGdDowQ@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/2] HID: Add driver for RC Simulator Controllers
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Jiri Kosina <jikos@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcus,

On Sun, Aug 28, 2022 at 4:13 PM Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
>
> Hi,
>
> On Tue, Aug 23, 2022 at 06:43:47PM +0200, Benjamin Tissoires wrote:
> > On Tue, Aug 23, 2022 at 5:13 PM Marcus Folkesson
> > <marcus.folkesson@gmail.com> wrote:
>
> > >
> > > Thank you  Benjamin,
> > >
> > > On Tue, Aug 23, 2022 at 11:49:59AM +0200, Benjamin Tissoires wrote:
> > > > Hi Marcus,
> > > >
> > > > [and sorry for the delay in the review of your patches]
> > > >
> > > > On Mon, Aug 22, 2022 at 8:04 AM Marcus Folkesson
> > > > <marcus.folkesson@gmail.com> wrote:
> > > > >
> > > > > Several RC Simulator Controllers are HID compliant with similar
> > > > > interface.
> > > > >
> > > > > Add support for these controllers:
> > > > >  - Phoenix RC (HID variant)
> > > > >  - Car VRC2.0
> > > > >  - Real Flight G5/G6/G7
> > > > >  - Aero Fly, FMS
> > > > >  - OrangeRX FrSky
> > > > >
> > > > > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > > > > ---
> > > > >  Documentation/hid/index.rst |   1 +
> > > > >  Documentation/hid/rcsim.rst | 142 ++++++++++++++++
> > > > >  drivers/hid/Kconfig         |  11 ++
> > > > >  drivers/hid/Makefile        |   1 +
> > > > >  drivers/hid/hid-ids.h       |   5 +
> > > > >  drivers/hid/hid-rcsim.c     | 315 ++++++++++++++++++++++++++++++++++++
> > > > >  6 files changed, 475 insertions(+)
> > > > >  create mode 100644 Documentation/hid/rcsim.rst
> > > > >  create mode 100644 drivers/hid/hid-rcsim.c
> > > > >
> > > > > diff --git a/Documentation/hid/index.rst b/Documentation/hid/index.rst
> > > > > index e50f513c579c..e5813d264f37 100644
> > > > > --- a/Documentation/hid/index.rst
> > > > > +++ b/Documentation/hid/index.rst
> > > > > @@ -17,3 +17,4 @@ Human Interface Devices (HID)
> > > > >     hid-alps
> > > > >     intel-ish-hid
> > > > >     amd-sfh-hid
> > > > > +   rcsim
> > > > > diff --git a/Documentation/hid/rcsim.rst b/Documentation/hid/rcsim.rst
> > > > > new file mode 100644
> > > > > index 000000000000..1a031f7189cb
> > > > > --- /dev/null
> > > > > +++ b/Documentation/hid/rcsim.rst
> > > > > @@ -0,0 +1,142 @@
> > > > > +.. SPDX-License-Identifier: GPL-2.0
> > > > > +
> > > > > +=================================
> > > > > +rcsim - RC Simulator Controllers
> > > > > +=================================
> > > > > +
> > > > > +:Author: Marcus Folkesson <marcus.folkesson@gmail.com>
> > > > > +
> > > > > +This driver let you use your own RC controller plugged
> > > > > +into your computer using an HID compatible USB dongle.
> > > > > +
> > > > > +There are several HID compatible USB dongles from different
> > > > > +vendors. The driver currently supports:
> > > > > +
> > > > > +- Phoenix RC (HID variant) (8ch)
> > > > > +- Car VRC2.0 (2ch)
> > > > > +- Real Flight G5/G6/G7 (6ch)
> > > > > +- Aero Fly, FMS (8ch)
> > > > > +- OrangeRX FrSky (6ch)
> > > > > +
> > > > > +Many RC controllers is able to configure which stick goes to which channel.
> > > > > +This is also configurable in most simulators, so a matching is not necessary.
> > > > > +
> > > > > +Supported dongles
> > > > > +==================
> > > > > +
> > > > > +PhoenixRC
> > > > > +----------
> > > > > +
> > > > > +The PhoenixRC has one HID compatible variant which is supported by this driver.
> > > > > +The controller has support for 8 analog channels.
> > > > > +
> > > > > +The driver is generating the following input event for on channels:
> > > > > +
> > > > > ++---------+----------------+
> > > > > +| Channel |      Event     |
> > > > > ++=========+================+
> > > > > +|     1   |  ABS_Y         |
> > > > > ++---------+----------------+
> > > > > +|     2   |  ABS_X         |
> > > > > ++---------+----------------+
> > > > > +|     3   |  ABS_RY        |
> > > > > ++---------+----------------+
> > > > > +|     4   |  ABS_RX        |
> > > > > ++---------+----------------+
> > > > > +|     5   |  ABS_RUDDER    |
> > > > > ++---------+----------------+
> > > > > +|     6   |  ABS_THROTTLE  |
> > > > > ++---------+----------------+
> > > > > +|     7   |  ABS_Z         |
> > > > > ++---------+----------------+
> > > > > +|     8   |  ABS_RZ        |
> > > > > ++---------+----------------+
> > > > > +
> > > > > +VRC2.0
> > > > > +----------
> > > > > +VRC2.0 is a controller for RC Cars.
> > > > > +The controller has support for 2 analog channels.
> > > > > +
> > > > > +The driver is generating the following input event for on channels:
> > > > > +
> > > > > ++---------+----------------+
> > > > > +| Channel |      Event     |
> > > > > ++=========+================+
> > > > > +|     1   |  ABS_GAS       |
> > > > > ++---------+----------------+
> > > > > +|     2   |  ABS_WHEEL     |
> > > > > ++---------+----------------+
> > > > > +
> > > > > +RealFlight
> > > > > +----------
> > > > > +
> > > > > +This driver supports Realflight G4-G7 and above
> > > > > +The controller has support for 4 analog channels and two buttons.
> > > > > +
> > > > > +The driver is generating the following input event for on channels:
> > > > > +
> > > > > ++---------+----------------+
> > > > > +| Channel |      Event     |
> > > > > ++=========+================+
> > > > > +|     1   |  ABS_Y         |
> > > > > ++---------+----------------+
> > > > > +|     2   |  ABS_X         |
> > > > > ++---------+----------------+
> > > > > +|     3   |  ABS_RY        |
> > > > > ++---------+----------------+
> > > > > +|     4   |  ABS_RX        |
> > > > > ++---------+----------------+
> > > > > +|     5   |  BTN_A         |
> > > > > ++---------+----------------+
> > > > > +|     6   |  BTN_B         |
> > > > > ++---------+----------------+
> > > > > +
> > > > > +XTR+G2+FMS Controllers
> > > > > +--------------------------------
> > > > > +
> > > > > +The controllers has support for 8 analog channels.
> > > > > +
> > > > > +The driver is generating the following input event for on channels:
> > > > > +
> > > > > ++---------+----------------+
> > > > > +| Channel |      Event     |
> > > > > ++=========+================+
> > > > > +|     1   |  ABS_Y         |
> > > > > ++---------+----------------+
> > > > > +|     2   |  ABS_X         |
> > > > > ++---------+----------------+
> > > > > +|     3   |  ABS_RY        |
> > > > > ++---------+----------------+
> > > > > +|     4   |  ABS_RX        |
> > > > > ++---------+----------------+
> > > > > +|     5   |  ABS_RUDDER    |
> > > > > ++---------+----------------+
> > > > > +|     6   |  ABS_THROTTLE  |
> > > > > ++---------+----------------+
> > > > > +|     7   |  ABS_Z         |
> > > > > ++---------+----------------+
> > > > > +|     8   |  ABS_RZ        |
> > > > > ++---------+----------------+
> > > > > +
> > > > > +OrangeRX
> > > > > +----------
> > > > > +
> > > > > +The controllers has support for 6 analog channels.
> > > > > +
> > > > > +The driver is generating the following input event for on channels:
> > > > > +
> > > > > ++---------+----------------+
> > > > > +| Channel |      Event     |
> > > > > ++=========+================+
> > > > > +|     1   |  ABS_Y         |
> > > > > ++---------+----------------+
> > > > > +|     2   |  ABS_X         |
> > > > > ++---------+----------------+
> > > > > +|     3   |  ABS_RY        |
> > > > > ++---------+----------------+
> > > > > +|     4   |  ABS_RX        |
> > > > > ++---------+----------------+
> > > > > +|     5   |  ABS_RUDDER    |
> > > > > ++---------+----------------+
> > > > > +|     6   |  ABS_THROTTLE  |
> > > > > ++---------+----------------+
> > > > > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> > > > > index 70da5931082f..d8313d36086c 100644
> > > > > --- a/drivers/hid/Kconfig
> > > > > +++ b/drivers/hid/Kconfig
> > > > > @@ -957,6 +957,17 @@ config HID_RAZER
> > > > >         Support for Razer devices that are not fully compliant with the
> > > > >         HID standard.
> > > > >
> > > > > +config HID_RCSIM
> > > > > +       tristate "RC Simulator Controllers"
> > > > > +       depends on HID
> > > > > +       help
> > > > > +       Support for several HID compatible RC Simulator Controllers including
> > > > > +         - Phoenix RC
> > > > > +         - Car VRC2.0
> > > > > +         - Real Flight
> > > > > +         - Aero Fly, FMS
> > > > > +         - OrangeRX FrSky
> > > > > +
> > > > >  config HID_PRIMAX
> > > > >         tristate "Primax non-fully HID-compliant devices"
> > > > >         depends on HID
> > > > > diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> > > > > index cac2cbe26d11..85d50ab352ee 100644
> > > > > --- a/drivers/hid/Makefile
> > > > > +++ b/drivers/hid/Makefile
> > > > > @@ -102,6 +102,7 @@ obj-$(CONFIG_HID_PLANTRONICS)       += hid-plantronics.o
> > > > >  obj-$(CONFIG_HID_PLAYSTATION)  += hid-playstation.o
> > > > >  obj-$(CONFIG_HID_PRIMAX)       += hid-primax.o
> > > > >  obj-$(CONFIG_HID_RAZER)        += hid-razer.o
> > > > > +obj-$(CONFIG_HID_RCSIM)        += hid-rcsim.o
> > > >
> > > > General rule of thumbs, we try to name the drivers after their
> > > > vendors, unless we know we have a generic driver.
> > > >
> > > > Here, this driver seems to be really tied to a small set of devices,
> > > > and thus I don't think we can call it "generic".
> > >
> > > Got it.
> > >
> > > >
> > > > >  obj-$(CONFIG_HID_REDRAGON)     += hid-redragon.o
> > > > >  obj-$(CONFIG_HID_RETRODE)      += hid-retrode.o
> > > > >  obj-$(CONFIG_HID_ROCCAT)       += hid-roccat.o hid-roccat-common.o \
> > > > > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > > > > index d9eb676abe96..baf5f74d5bed 100644
> > > > > --- a/drivers/hid/hid-ids.h
> > > > > +++ b/drivers/hid/hid-ids.h
> > > > > @@ -1381,6 +1381,11 @@
> > > > >
> > > > >  #define USB_VENDOR_ID_MULTIPLE_1781    0x1781
> > > > >  #define USB_DEVICE_ID_RAPHNET_4NES4SNES_OLD    0x0a9d
> > > > > +#define USB_DEVICE_ID_PHOENIXRC        0x0898
> > > > > +#define USB_DEVICE_ID_REALFLIGHT       0x0e56
> > > > > +
> > > > > +#define USB_VENDOR_ID_DIPLING  0x0B9B
> > > > > +#define USB_DEVICE_ID_DIPLING_RCCONTROLLER     0x4012
> > > > >
> > > > >  #define USB_VENDOR_ID_DRACAL_RAPHNET   0x289b
> > > > >  #define USB_DEVICE_ID_RAPHNET_2NES2SNES        0x0002
> > > > > diff --git a/drivers/hid/hid-rcsim.c b/drivers/hid/hid-rcsim.c
> > > > > new file mode 100644
> > > > > index 000000000000..0f214cb5816a
> > > > > --- /dev/null
> > > > > +++ b/drivers/hid/hid-rcsim.c
> > > > > @@ -0,0 +1,315 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > +/*
> > > > > + * Driver for several HID compatible RC Simulator Controllers.
> > > > > + * Currently supported controllers are:
> > > > > + *
> > > > > + * - Phoenix RC (HID variant) (8ch)
> > > > > + * - Car VRC2.0 (2ch)
> > > > > + * - Real Flight G5/G6/G7 (6ch)
> > > > > + * - Aero Fly, FMS (8ch)
> > > > > + * - OrangeRX FrSky (6ch)
> > > > > + *
> > > > > + * Copyright (C) 2022 Marcus Folkesson <marcus.folkesson@gmail.com>
> > > > > + */
> > > > > +
> > > > > +#include <linux/bitfield.h>
> > > > > +#include <linux/device.h>
> > > > > +#include <linux/input.h>
> > > > > +#include <linux/hid.h>
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/usb.h>
> > > > > +
> > > > > +#include "hid-ids.h"
> > > > > +
> > > > > +/*
> > > > > + * Some of these VID/PID are probably "borrowed", so keep them locally and
> > > > > + * do not populate hid-ids.h with those.
> > > > > + */
> > > > > +
> > > > > +/* PHOENIXRC Controlloer (HID variant) */
> > > > > +#define PHOENIXRC_VID  (USB_VENDOR_ID_MULTIPLE_1781)
> > > > > +#define PHOENIXRC_PID  (USB_DEVICE_ID_PHOENIXRC)
> > > > > +#define PHOENIXRC_DSIZE        (8)
> > > > > +
> > > > > +/* VRC2 Controlloer */
> > > > > +#define VRC2_VID       (0x07c0)
> > > > > +#define VRC2_PID       (0x1125)
> > > > > +#define VRC2_DSIZE     (7)
> > > > > +
> > > > > +/* Realflight G4-&7 and Above Controller */
> > > > > +#define REALFLIGHT_VID (USB_VENDOR_ID_MULTIPLE_1781)
> > > > > +#define REALFLIGHT_PID (USB_DEVICE_ID_REALFLIGHT)
> > > > > +#define REALFLIGHT_DSIZE       (8)
> > > > > +
> > > > > +#define REALFLIGHT_BTN_A       BIT(0)
> > > > > +#define REALFLIGHT_BTN_B       BIT(1)
> > > > > +
> > > > > +/* XTR+G2+FMS Controller */
> > > > > +#define XTRG2FMS_VID   (USB_VENDOR_ID_DIPLING)
> > > > > +#define XTRG2FMS_PID   (USB_DEVICE_ID_DIPLING_RCCONTROLLER)
> > > > > +#define XTRG2FMS_DSIZE (8)
> > > > > +
> > > > > +#define XTRG2FMS_X_HI  GENMASK(3, 2)
> > > > > +#define XTRG2FMS_Y_HI  GENMASK(1, 0)
> > > > > +#define XTRG2FMS_RX_HI GENMASK(7, 6)
> > > > > +#define XTRG2FMS_RY_HI GENMASK(5, 4)
> > > > > +#define XTRG2FMS_ALT1_HI       GENMASK(3, 2)
> > > > > +#define XTRG2FMS_ALT2_HI       GENMASK(1, 0)
> > > > > +
> > > > > +/* OrangeRX FrSky */
> > > > > +#define ORANGERX_VID   (0x0451)
> > > > > +#define ORANGERX_PID   (0x16a5)
> > > > > +#define ORANGERX_DSIZE (8)
> > > > > +
> > > > > +enum rcsim_controller {
> > > > > +       PHOENIXRC,
> > > > > +       VRC2,
> > > > > +       REALFLIGHT,
> > > > > +       XTRG2FMS,
> > > > > +       ORANGERX
> > > > > +};
> > > > > +
> > > > > +struct rcsim_priv {
> > > > > +       struct hid_device *hdev;
> > > > > +       struct input_dev *input;
> > > > > +       enum rcsim_controller controller;
> > > > > +       u8 alt;
> > > > > +};
> > > > > +
> > > > > +static int rcsim_open(struct input_dev *dev)
> > > > > +{
> > > > > +       struct rcsim_priv *priv = input_get_drvdata(dev);
> > > > > +
> > > > > +       return hid_hw_open(priv->hdev);
> > > > > +}
> > > > > +
> > > > > +static void rcsim_close(struct input_dev *dev)
> > > > > +{
> > > > > +       struct rcsim_priv *priv = input_get_drvdata(dev);
> > > > > +
> > > > > +       hid_hw_close(priv->hdev);
> > > > > +}
> > > > > +
> > > > > +static int rcsim_setup_input(struct rcsim_priv *priv)
> > > > > +{
> > > > > +       struct input_dev *input;
> > > > > +
> > > > > +       input = devm_input_allocate_device(&priv->hdev->dev);
> > > > > +       if (!input)
> > > > > +               return -ENOMEM;
> > > > > +
> > > > > +       input->id.bustype = priv->hdev->bus;
> > > > > +       input->id.vendor  = priv->hdev->vendor;
> > > > > +       input->id.product = priv->hdev->product;
> > > > > +       input->id.version = priv->hdev->bus;
> > > > > +       input->phys = priv->hdev->phys;
> > > > > +       input->uniq = priv->hdev->uniq;
> > > > > +       input->open = rcsim_open;
> > > > > +       input->close = rcsim_close;
> > > > > +
> > > > > +       input_set_drvdata(input, priv);
> > > > > +
> > > > > +       switch (priv->controller) {
> > > > > +       case PHOENIXRC:
> > > > > +               input_set_abs_params(input, ABS_X, 0, 255, 0, 0);
> > > > > +               input_set_abs_params(input, ABS_Y, 0, 255, 0, 0);
> > > > > +               input_set_abs_params(input, ABS_RX, 0, 255, 0, 0);
> > > > > +               input_set_abs_params(input, ABS_RY, 0, 255, 0, 0);
> > > > > +               input_set_abs_params(input, ABS_Z, 0, 255, 0, 0);
> > > > > +               input_set_abs_params(input, ABS_RZ, 0, 255, 0, 0);
> > > > > +               input_set_abs_params(input, ABS_RUDDER, 0, 255, 0, 0);
> > > > > +               input_set_abs_params(input, ABS_THROTTLE, 0, 255, 0, 0);
> > > > > +               input->name = "RC Simuator Controller PhoenixRC";
> > > > > +               break;
> > > > > +       case VRC2:
> > > > > +               input_set_abs_params(input, ABS_GAS, 0, 2048, 0, 0);
> > > > > +               input_set_abs_params(input, ABS_WHEEL, 0, 2048, 0, 0);
> > > > > +               input->name = "RC Simuator Controller VRC2.0";
> > > > > +               break;
> > > > > +       case REALFLIGHT:
> > > > > +               input_set_abs_params(input, ABS_X, 0, 1024, 0, 0);
> > > > > +               input_set_abs_params(input, ABS_Y, 0, 1024, 0, 0);
> > > > > +               input_set_abs_params(input, ABS_RX, 0, 1024, 0, 0);
> > > > > +               input_set_abs_params(input, ABS_RY, 0, 1024, 0, 0);
> > > > > +               input_set_capability(input, EV_KEY, BTN_A);
> > > > > +               input_set_capability(input, EV_KEY, BTN_B);
> > > > > +               input->name = "RC Simuator Controller Realflight";
> > > > > +               break;
> > > > > +       case XTRG2FMS:
> > > > > +               input_set_abs_params(input, ABS_X, 0, 1024, 0, 0);
> > > > > +               input_set_abs_params(input, ABS_Y, 0, 1024, 0, 0);
> > > > > +               input_set_abs_params(input, ABS_RX, 0, 1024, 0, 0);
> > > > > +               input_set_abs_params(input, ABS_RY, 0, 1024, 0, 0);
> > > > > +               input_set_abs_params(input, ABS_Z, 0, 1024, 0, 0);
> > > > > +               input_set_abs_params(input, ABS_RZ, 0, 1024, 0, 0);
> > > > > +               input_set_abs_params(input, ABS_RUDDER, 0, 1024, 0, 0);
> > > > > +               input_set_abs_params(input, ABS_THROTTLE, 0, 1024, 0, 0);
> > > > > +               input->name = "RC Simuator Controller AeroFly, FMS";
> > > > > +               priv->alt = 0;
> > > > > +               break;
> > > > > +       case ORANGERX:
> > > > > +               input_set_abs_params(input, ABS_X, 0, 255, 0, 0);
> > > > > +               input_set_abs_params(input, ABS_Y, 0, 255, 0, 0);
> > > > > +               input_set_abs_params(input, ABS_RX, 0, 255, 0, 0);
> > > > > +               input_set_abs_params(input, ABS_RY, 0, 255, 0, 0);
> > > > > +               input_set_abs_params(input, ABS_RUDDER, 0, 255, 0, 0);
> > > > > +               input_set_abs_params(input, ABS_THROTTLE, 0, 255, 0, 0);
> > > > > +               input->name = "RC Simuator Controller OrangeRX FrSky";
> > > > > +               break;
> > > > > +       };
> > > > > +
> > > > > +       priv->input = input;
> > > > > +       return input_register_device(priv->input);
> > > > > +}
> > > >
> > > > You are basically rewriting hid-input.c, which is suboptimal.
> > >
> > > Ouch. I will have a look at hid-input, thanks.
> > >
> > > >
> > > > I guess the report descriptor provided by these devices are basically
> > > > useless, and so you have to parse the reports yourself in the
> > > > raw_event callback.
> > >
> > > Yep.
> > >
> > > >
> > > > But instead of manually doing that, why not overwrite the report
> > > > descriptor (with .rdesc_fixup) and declare here all of the data that
> > >  Do you mean .report_fixup?
> >
> > yes, sorry :/
> >
> > >
> > > > needs to be exported. You could remove basically everything in this
> > > > driver by just providing a fixed report descriptor.
> > >
> > > What you are aiming for is to fixup the report descriptor and let the
> > > generic hid-raw driver handle the rest, or do I get you wrong?
> >
> > yep, exactly
> >
> > >
> > > How is the report mapped to certain events then?
> >
> > Have a look at hid_configure_usage in hid-input.c [3]. Most of HID
> > events are mapped to input events with a one to one mapping.
> >
> > >
> > > I do read at [1] but it is not obvious how to put it together.
> > > Most drivers I've looked at that is using .report_fixup just fix broken
> > > reports. I guess these reports are not "broken", just.. odd?
> >
> > Have a look at [2], lots of full report descriptors :)
> >
> > And in your case, the reports are incomplete, not odd.
> >
> > >
> > >
> > > >
> > > > > +
> > > > > +static int rcsim_raw_event(struct hid_device *hdev,
> > > > > +                              struct hid_report *report,
> > > > > +                              u8 *raw_data, int size)
> > > > > +{
> > > > > +       struct rcsim_priv *priv = hid_get_drvdata(hdev);
> > > > > +       u16 value;
> > > > > +
> > > > > +       switch (priv->controller) {
> > > > > +       case PHOENIXRC:
> > > > > +               if (size != PHOENIXRC_DSIZE)
> > > > > +                       break;
> > > > > +
> > > > > +               /* X, RX, Y and RY, RUDDER and THROTTLE are sent every time */
> > > > > +               input_report_abs(priv->input, ABS_X, raw_data[2]);
> > > > > +               input_report_abs(priv->input, ABS_Y, raw_data[0]);
> > > > > +               input_report_abs(priv->input, ABS_RX, raw_data[4]);
> > > > > +               input_report_abs(priv->input, ABS_RY, raw_data[3]);
> > > > > +               input_report_abs(priv->input, ABS_RUDDER, raw_data[5]);
> > > > > +               input_report_abs(priv->input, ABS_THROTTLE, raw_data[6]);
> > > > > +
> > > > > +               /* Z and RZ are sent every other time */
> > > > > +               if (priv->alt)
> > > > > +                       input_report_abs(priv->input, ABS_Z, raw_data[7]);
> > > > > +               else
> > > > > +                       input_report_abs(priv->input, ABS_RZ, raw_data[7]);
> > > > > +
> > > > > +               priv->alt ^= 1;
> > > > > +               break;
> > > > > +       case VRC2:
> > > > > +               if (size != VRC2_DSIZE)
> > > > > +                       break;
> > > > > +               value = (raw_data[1] << 8 | raw_data[0]) & GENMASK(10, 0);
> > > > > +               input_report_abs(priv->input, ABS_GAS, value);
> > > > > +               value = (raw_data[3] << 8 | raw_data[2]) & GENMASK(10, 0);
> > > > > +               input_report_abs(priv->input, ABS_WHEEL, value);
> > > > > +               break;
> > > > > +       case REALFLIGHT:
> > > > > +               if (size != REALFLIGHT_DSIZE)
> > > > > +                       break;
> > > > > +               input_report_abs(priv->input, ABS_X, raw_data[2]);
> > > > > +               input_report_abs(priv->input, ABS_Y, raw_data[1]);
> > > > > +               input_report_abs(priv->input, ABS_RX, raw_data[5]);
> > > > > +               input_report_abs(priv->input, ABS_RY, raw_data[3]);
> > > > > +               input_report_abs(priv->input, ABS_MISC, raw_data[4]);
> > > > > +               input_report_key(priv->input, BTN_A,
> > > > > +                               raw_data[7] & REALFLIGHT_BTN_A);
> > > > > +               input_report_key(priv->input, BTN_B,
> > > > > +                               raw_data[7] & REALFLIGHT_BTN_B);
> > > > > +               break;
> > > > > +       case XTRG2FMS:
> > > > > +               if (size != XTRG2FMS_DSIZE)
> > > > > +                       break;
> > > > > +
> > > > > +               /* X, RX, Y and RY are sent every time */
> > > > > +               value = FIELD_GET(XTRG2FMS_X_HI, raw_data[3]);
> > > > > +               value = (value << 8) | raw_data[1];
> > > > > +               input_report_abs(priv->input, ABS_X, value);
> > > > > +
> > > > > +               value = FIELD_GET(XTRG2FMS_Y_HI, raw_data[3]);
> > > > > +               value = (value << 8) | raw_data[2];
> > > > > +               input_report_abs(priv->input, ABS_Y, value);
> > > > > +
> > > > > +               value = FIELD_GET(XTRG2FMS_RX_HI, raw_data[3]);
> > > > > +               value = (value << 8) | raw_data[0];
> > > > > +               input_report_abs(priv->input, ABS_RX, value);
> > > > > +
> > > > > +               value = FIELD_GET(XTRG2FMS_RY_HI, raw_data[3]);
> > > > > +               value = (value << 8) | raw_data[4];
> > > > > +               input_report_abs(priv->input, ABS_RY, value);
> > > > > +
> > > > > +               /* Z, RZ, RUDDER and THROTTLE are sent every other time */
> > > > > +               value = FIELD_GET(XTRG2FMS_ALT1_HI, raw_data[7]);
> > > > > +               value = (value << 8) | raw_data[6];
> > > > > +               if (priv->alt)
> > > > > +                       input_report_abs(priv->input, ABS_Z, value);
> > > > > +               else
> > > > > +                       input_report_abs(priv->input, ABS_RUDDER, value);
> > > > > +
> > > > > +               value = FIELD_GET(XTRG2FMS_ALT2_HI, raw_data[7]);
> > > > > +               value = (value << 8) | raw_data[5];
> > > > > +               if (priv->alt)
> > > > > +                       input_report_abs(priv->input, ABS_RZ, value);
> > > > > +               else
> > > > > +                       input_report_abs(priv->input, ABS_THROTTLE, value);
> > > > > +
> > > > > +               priv->alt ^= 1;
> > > > > +               break;
> > > > > +       case ORANGERX:
> > > > > +               if (size != ORANGERX_DSIZE)
> > > > > +                       break;
> > > > > +               input_report_abs(priv->input, ABS_X, raw_data[0]);
> > > > > +               input_report_abs(priv->input, ABS_Y, raw_data[2]);
> > > > > +               input_report_abs(priv->input, ABS_RX, raw_data[3]);
> > > > > +               input_report_abs(priv->input, ABS_RY, raw_data[1]);
> > > > > +               input_report_abs(priv->input, ABS_RUDDER, raw_data[5]);
> > > > > +               input_report_abs(priv->input, ABS_THROTTLE, raw_data[6]);
> > > > > +               break;
> > > > > +       };
> > > > > +
> > > > > +       input_sync(priv->input);
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +static int rcsim_probe(struct hid_device *hdev, const struct hid_device_id *id)
> > > > > +{
> > > > > +       struct device *dev = &hdev->dev;
> > > > > +       struct rcsim_priv *priv;
> > > > > +       int ret;
> > > > > +
> > > > > +       if (!hid_is_using_ll_driver(hdev, &usb_hid_driver))
> > > > > +               return -ENODEV;
> > > >
> > > > You are not accessing anything in the USB stack, so there is no need
> > > > to prevent regression tests that could inject uhid devices to your
> > > > drivers.
> > >
> > > Ok, thanks.
> > >
> > > >
> > > > Cheers,
> > > > Benjamin
> > > >
> > >
> > > Best regards,
> > > Marcus Folkesson
> > >
> > > [1] https://www.usb.org/hid
> > >
> >
> > If you need help in writing report descriptors, I can give you some,
> > but the easiest might be for you to start from the report descriptor
> > in hid-sony.c. I used to have a tool to dynamically write a report
> > descriptor, but I'm not sure it still works...
>
> I've worked with the report descriptor for VRC2, and have come up with
> something that works.

Great that you managed to fill in most of the gaps :)

>
>
> static __u8 vrc2_rdesc_fixed[] = {
>         0x05, 0x01,        // Usage Page (Generic Desktop Ctrls)
>         0x09, 0x04,        // Usage (Joystick)
>         0xA1, 0x01,        // Collection (Application)
>         0x09, 0x01,        //   Usage (Pointer)
>         0xA1, 0x00,        //   Collection (Physical)
>         0x09, 0x30,        //     Usage (X)
>         0x09, 0x31,        //     Usage (Y)
>         0x15, 0x00,        //     Logical Minimum (0)
>         0x26, 0xFF, 0x07,  //     Logical Maximum (2047)
>         0x35, 0x00,        //     Physical Minimum (0)
>         0x46, 0xFF, 0x00,  //     Physical Maximum (255)
>         0x75, 0x10,        //     Report Size (16)
>         0x95, 0x02,        //     Report Count (2)
>         0x81, 0x02,        //     Input (Data,Var,Abs,No Wrap,Linear,Preferred State,No Null Position)
>         0xC0,              //   End Collection
>         0x95, 0x01,        //   Report Count (1)
>         0x75, 0x18,        //   Report Size (24)
>         0x81, 0x01,        //   Input (Const,Array,Abs,No Wrap,Linear,Preferred State,No Null Position)
>         0x09, 0x00,        //   Usage (Undefined)
>         0x15, 0x00,        //   Logical Minimum (0)
>         0x26, 0xFF, 0x00,  //   Logical Maximum (255)
>         0x75, 0x08,        //   Report Size (8)
>         0x95, 0x08,        //   Report Count (8)
>         0xB1, 0x02,        //   Feature (Data,Var,Abs,No Wrap,Linear,Preferred State,No Null Position,Non-volatile)
>         0xC0,              // End Collection
> };
>
>
> It is a result of reading specifications and looking at various
> examples.
>
> These lines are taken from an example, and I do not know why I need
> those. I think the constant report size is wrong (should be 32 to

Do you have an example of the actual data sent on the wire? hexdump or
hid-recorder should be enough for me to get what is missing.

As I read the report descriptors, we had:
* old one:
  - opening of application collection of usage undefined
    - 64 buttons (logical max of 1), usage being being 0x01 and 0x3F
(63) -> so the last bit is ignored

Which would translate to a report of the following (each 0 being a
separate button, | is marking bytes):

0, 0, 0, 0, 0, 0, 0, 0 | 0, 0, 0, 0, 0, 0, 0, 0 | 0, 0, 0, 0, 0, 0, 0,
0 | 0, 0, 0, 0, 0, 0, 0, 0 | 0, 0, 0, 0, 0, 0, 0, 0 | 0, 0, 0, 0, 0,
0, 0, 0 | 0, 0, 0, 0, 0, 0, 0, 0 | 0, 0, 0, 0, 0, 0, 0, X

-> 64 * 1 = 64 bits

()last bit being ignored because of its duplicated usage with the previous one)

* new one:
  - opening of an application collection of usage Joystick
    - opening of a physical collection of type Pointer
      - 16 bits for X, with logical max of 2047 and physical max of 255
      - 16 bits for Y, with logical max of 2047 and physical max of 255
    - 1 const element of size 24 that has to be ignored
    - one feature that should not be there :)

So it would translate into the following (c being constant bit):
X (2 bytes) | Y (2 bytes) | c, c, c, c, c, c, c, c | c, c, c, c, c, c,
c, c | c, c, c, c, c, c, c, c

-> 24 + 2*8 + 2*8 = 56 bits

So I agree with you, you are missing 16 bits

> fill up) and I do not know what the Feature is used for.

You should not have to declare a feature. A feature is a special HID
endpoint that you can use to talk to the HID device. By emitting
special HID commands, (HID_REPORT_GET/HID_REPORT_SET) you can control
how the device works. But if your current report descriptor doesn't
have a feature declared, you should not declare it.

>
>         0x95, 0x01,        //   Report Count (1)
>         0x75, 0x18,        //   Report Size (24)
>         0x81, 0x01,        //   Input (Const,Array,Abs,No Wrap,Linear,Preferred State,No Null Position)
>         0x09, 0x00,        //   Usage (Undefined)
>         0x15, 0x00,        //   Logical Minimum (0)
>         0x26, 0xFF, 0x00,  //   Logical Maximum (255)
>         0x75, 0x08,        //   Report Size (8)
>         0x95, 0x08,        //   Report Count (8)
>         0xB1, 0x02,        //   Feature (Data,Var,Abs,No Wrap,Linear,Preferred State,No Null Position,Non-volatile)
>
> If I omit any of these lines then I only get tons of
>
> kernel: usb 3-12.3.1.3.3: input irq status -75 received

I assume the feature in this particular case helps the driver to
understand that you need to allocate a 64 bits chunk of memory to
communicate with the device.

I would advise to use the following report instead:

----
static __u8 vrc2_rdesc_fixed[] = {
        0x05, 0x01,        // Usage Page (Generic Desktop Ctrls)
        0x09, 0x04,        // Usage (Joystick)
        0xA1, 0x01,        // Collection (Application)
        0x09, 0x01,        //   Usage (Pointer)
        0xA1, 0x00,        //   Collection (Physical)
        0x09, 0x30,        //     Usage (X)
        0x09, 0x31,        //     Usage (Y)
        0x15, 0x00,        //     Logical Minimum (0)
        0x26, 0xFF, 0x07,  //     Logical Maximum (2047)
        0x35, 0x00,        //     Physical Minimum (0)
        0x46, 0xFF, 0x00,  //     Physical Maximum (255)
        0x75, 0x10,        //     Report Size (16)
        0x95, 0x02,        //     Report Count (2)
        0x81, 0x02,        //     Input (Data,Var,Abs,No
Wrap,Linear,Preferred State,No Null Position)
        0xC0,              //   End Collection
        0x75, 0x08,        //   Report Size (8)
       0x95, 0x04,        //   Report Count (4)
        0x81, 0x03,        //   Input (Cnst,Var,Abs)
        0xC0,              // End Collection
};
---

Few changes:
- use of 4 bytes of padding, instead of 1 24bits slot of padding
- changed the padding from 0x01 to 0x03 to remove the "array" const
definition which is tricky to handle
- removed the feature report.

Cheers,
Benjamin

>
> In the kernel log.
>
>
> >
> > FYI, I just re-read rcsim_raw_event() and there is stuff that would
> > require more than just a report descriptor fixup (the fact that some
> > data is sent every other report is not good and will need some manual
> > handling though).
> >
> > Cheers,
> > Benjamin
> >
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/hid/hid-uclogic-rdesc.c
> > [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/hid/hid-input.c#n817
> >
>
>
> Best regards
> Marcus Folkesson


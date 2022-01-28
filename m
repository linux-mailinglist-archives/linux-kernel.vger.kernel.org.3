Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E16449F48B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242764AbiA1Hli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiA1Hli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:41:38 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B19C06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 23:41:37 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id x13so1982914vsl.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 23:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tjuChuAHIbTONdAQAHBnCnWD6+3PJQKXKvwxTCI2J/E=;
        b=OHDZJVNKNvd51WXna1TJHIyvBpowWCZYV0yhQO/nF8L7S9dzh/tjGv8sCtF0z17ia5
         rGHcBvtEYiFMQq0Wr8a3ub30vbx5ea2nHZUvWJhmAvI3d+Ce47oxDnr3XclVRQ20b4Vl
         2BHxfu+FppFyvUlYx2lBr8jAxhv/OtNiMt5BY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tjuChuAHIbTONdAQAHBnCnWD6+3PJQKXKvwxTCI2J/E=;
        b=MnnQtbNtvOZyEXwwT3dRjCriBx8suRWq6A78lUb2AMrqChi3u3MMfajb4GRHP+XqWg
         9RNGgN0L/qXPjQj+5jxWD4hMT7oBVx1GwmKxAaCqzo8H7QU9fi2hDcWg6vCDge8u+Kej
         ps+RlMTFKXr9A+MaBwA3oiwsVMTzdXUJJZuWJFjOIbWNEt//FS3P5ZZFN3L1Iw6NNywg
         YOV/Nsc7jhzgwwqe56a3P9Z1ceYQvknIHanzFGxPiiosGZWBNhESTd1DWXIzPQTTF1qX
         FE2fRd5OrQ1g/Y4hBm66M44z3onXaVmXpaKIBSXJvGU9fWgVEYTB8JJ2j1hPfyDd5W7N
         duhA==
X-Gm-Message-State: AOAM531oqUdjQFhvV3BntPLpWkIfpf1O50zoOUSuDiRb6//Kbtyyj9jF
        EYsXR8UhGOWVw0DsU2H4L4csMm+koSScgx4JGS50wQ==
X-Google-Smtp-Source: ABdhPJx78U5dqaYdGDDjyP4sYKpRRIlBGG2rs/pGeuMOgJ3BVhghYYIztse0PMYH5rLWFPBO/z9XrdjaeP3NnPFwHm4=
X-Received: by 2002:a67:f492:: with SMTP id o18mr3401067vsn.55.1643355696611;
 Thu, 27 Jan 2022 23:41:36 -0800 (PST)
MIME-Version: 1.0
References: <20220127083545.1020423-1-skyostil@chromium.org>
 <20220127083545.1020423-2-skyostil@chromium.org> <YfJogh+yk1FHWSMC@kroah.com>
In-Reply-To: <YfJogh+yk1FHWSMC@kroah.com>
From:   Sami Kyostila <skyostil@chromium.org>
Date:   Fri, 28 Jan 2022 18:41:25 +1100
Message-ID: <CAPuLczsKqFOsqf-d39HOMHZaFQb2vmv054HUOj2+amQGE=oPkw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drivers/misc: add a driver for HPS
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, dtor@chromium.org,
        evanbenn@chromium.org, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

to 27. tammik. 2022 klo 20.40 Greg KH (gregkh@linuxfoundation.org) kirjoitt=
i:
>
> On Thu, Jan 27, 2022 at 07:35:44PM +1100, Sami Ky=C3=B6stil=C3=A4 wrote:
> > This patch introduces a driver for the ChromeOS snooping protection
> > sensor (aka. HPS). The driver supports a sensor connected to the I2C bu=
s
> > and identified as "GOOG0020" in the ACPI tables.
> >
> > When loaded, the driver exports the sensor to userspace through a
> > character device. This initial version of the device only supports powe=
r
> > management, i.e., communicating with the sensor must be done through I2=
C
> > from userspace.
> >
> > Power management is implemented by enabling the respective power GPIO
> > while at least one userspace process holds an open fd on the character
> > device. By default, the device is powered down if there are no active
> > clients.
> >
> > Note that the driver makes no effort to preserve the state of the senso=
r
> > between power down and power up events. Userspace is responsible for
> > reinitializing any needed state once power has been restored.
> >
> > The device firmware, I2C protocol and other documentation is available
> > at https://chromium.googlesource.com/chromiumos/platform/hps-firmware.
>
> How about a userspace tool that interacts with this new ioctl interface
> as well so that we can understand how the driver is supposed to work?

Sure, here's a small example that shows how to read a magic register
value from the device:
https://gist.github.com/skyostil/13d60a288919d18d00b20e81dfe018cd

(Let me know if you'd prefer this to be checked into the tree somewhere.)

Here's also a patch that makes the production daemon use this
interface: https://chromium-review.googlesource.com/c/chromiumos/platform2/=
+/3353640

> >
> > Signed-off-by: Sami Ky=C3=B6stil=C3=A4 <skyostil@chromium.org>
> > ---
> >
> >  MAINTAINERS            |   6 ++
> >  drivers/misc/Kconfig   |  10 ++
> >  drivers/misc/Makefile  |   1 +
> >  drivers/misc/hps-i2c.c | 223 +++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 240 insertions(+)
> >  create mode 100644 drivers/misc/hps-i2c.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index ea3e6c914384..9dea4b8c2ab5 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8798,6 +8798,12 @@ S:     Maintained
> >  W:   http://artax.karlin.mff.cuni.cz/~mikulas/vyplody/hpfs/index-e.cgi
> >  F:   fs/hpfs/
> >
> > +HPS (ChromeOS snooping protection sensor) DRIVER
> > +M:   Sami Ky=C3=B6stil=C3=A4 <skyostil@chromium.org>
> > +R:   Evan Benn <evanbenn@chromium.org>
> > +S:   Maintained
> > +F:   drivers/misc/hps-i2c.c
> > +
> >  HSI SUBSYSTEM
> >  M:   Sebastian Reichel <sre@kernel.org>
> >  S:   Maintained
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > index 0f5a49fc7c9e..b48b7803f537 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -244,6 +244,16 @@ config HP_ILO
> >         To compile this driver as a module, choose M here: the
> >         module will be called hpilo.
> >
> > +config HPS_I2C
> > +     tristate "ChromeOS HPS device support"
> > +     depends on HID && I2C && PM
> > +     help
> > +       Say Y here if you want to enable support for the ChromeOS
> > +       anti-snooping sensor (HPS), attached via I2C. The driver suppor=
ts a
> > +       sensor connected to the I2C bus and exposes it as a character d=
evice.
> > +       To save power, the sensor is automatically powered down when no
> > +       clients are accessing it.
> > +
> >  config QCOM_COINCELL
> >       tristate "Qualcomm coincell charger support"
> >       depends on MFD_SPMI_PMIC || COMPILE_TEST
> > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> > index a086197af544..162a7d530dab 100644
> > --- a/drivers/misc/Makefile
> > +++ b/drivers/misc/Makefile
> > @@ -26,6 +26,7 @@ obj-$(CONFIG_SGI_GRU)               +=3D sgi-gru/
> >  obj-$(CONFIG_CS5535_MFGPT)   +=3D cs5535-mfgpt.o
> >  obj-$(CONFIG_GEHC_ACHC)              +=3D gehc-achc.o
> >  obj-$(CONFIG_HP_ILO)         +=3D hpilo.o
> > +obj-$(CONFIG_HPS_I2C)                +=3D hps-i2c.o
> >  obj-$(CONFIG_APDS9802ALS)    +=3D apds9802als.o
> >  obj-$(CONFIG_ISL29003)               +=3D isl29003.o
> >  obj-$(CONFIG_ISL29020)               +=3D isl29020.o
> > diff --git a/drivers/misc/hps-i2c.c b/drivers/misc/hps-i2c.c
> > new file mode 100644
> > index 000000000000..fe9f073b0352
> > --- /dev/null
> > +++ b/drivers/misc/hps-i2c.c
> > @@ -0,0 +1,223 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Driver for the ChromeOS anti-snooping sensor (HPS), attached via I2=
C.
> > + *
> > + * The driver exposes HPS as a character device, although currently no=
 read or
> > + * write operations are supported. Instead, the driver only controls t=
he power
> > + * state of the sensor, keeping it on only while userspace holds an op=
en file
> > + * descriptor to the HPS device.
> > + *
> > + * Copyright 2022 Google LLC.
> > + */
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/cdev.h>
> > +#include <linux/fs.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/i2c.h>
> > +#include <linux/module.h>
> > +#include <linux/pm_runtime.h>
> > +
> > +#define HPS_ACPI_ID          "GOOG0020"
> > +#define HPS_MAX_DEVICES              1
> > +
> > +struct hps_drvdata {
> > +     struct i2c_client *client;
> > +
> > +     struct cdev cdev;
> > +     struct class *cdev_class;
>
> As you only have 1 device, please just use the miscdev interface, not
> the chardev interface.  Makes your code much smaller and easier to
> review and maintain over time and does not "burn" a whole major number
> for this tiny driver.

Will do, thanks for the tip!

>
> thanks,
>
> greg k-h



- Sami

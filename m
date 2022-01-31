Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682E24A3E91
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 09:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245579AbiAaIXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 03:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiAaIXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 03:23:46 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE36C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 00:23:37 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id t20so10819565vsq.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 00:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QOgMVge0doRwCo4zUFKXcrmrN7hn9U3fz3Lr7n2UGBg=;
        b=CKNyA/TvTMcTzz21V1RspQEYYHHg7u/J3b8ctgMyazAn23SvRhlVaULTx1KQn7CaKQ
         /ee00LA7lYxUfDAMKxBcJ/gx1bRUDRIiDRTYzK43VC9Xqeg3vSjMQiF57RxTtOURudlP
         w37CdNKYoOtp+c+oIBxcq2NqVfprvraJQKYew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QOgMVge0doRwCo4zUFKXcrmrN7hn9U3fz3Lr7n2UGBg=;
        b=RPlK4XbXzwBGM/9y2xxHFjmi1I0oCHyyiECTLS7EH13NGgCGBkc8N239bLS9SnZuiT
         Hule+ZP/UZHE1eUlNChgvcdVOIC6lkTAyhKTaDdh/9sFaU8BQomWgGKxEFI2HkxHfFts
         BC4p2R06gpMCIHq9CHtE4Gc+qnuwSx7T93oV8gDiRFPA+5zJ7+gKOL2RBfXrfm6UIjsr
         6RC4GYTF0u0yITKG6iKJ5xcLHhq8wummbHrrImlEa/ZfhtQc3FhjknEgKoxTZZtzEf6A
         Z7UHBcH6btPYS3O8RfkY+suY72+nC+Z0kdAhgyZr36/Z7toBPQiHLhIWuA6mS7z5wpci
         umPg==
X-Gm-Message-State: AOAM531f8hbuKoW7oHtIRWa95wiCssewiZls8sSRhQRBixb/dfhyBkHo
        tJbMEDO2PkM4esyYgupqKKv7AvKRQxgZKtoyISgjnGMPFDt5eozf
X-Google-Smtp-Source: ABdhPJxDZ6j5RIG/lj471GNbC2EuT3KMJ2HFwYMsbpbHKpWfJQfkhgyxZ3RNGDVgJet79mqvqHWhePtSK40ystwhRjI=
X-Received: by 2002:a67:ce0b:: with SMTP id s11mr7122942vsl.50.1643617416213;
 Mon, 31 Jan 2022 00:23:36 -0800 (PST)
MIME-Version: 1.0
References: <20220127083545.1020423-1-skyostil@chromium.org>
 <20220127083545.1020423-3-skyostil@chromium.org> <YfJovN7clqBZ8NDr@kroah.com>
 <CAPuLczsLSnojXG8zyWBq6P50S8dVN3LcTi+2L0j-zLbwC_cJ0g@mail.gmail.com> <YfO5ASQ31vJpnGTC@kroah.com>
In-Reply-To: <YfO5ASQ31vJpnGTC@kroah.com>
From:   Sami Kyostila <skyostil@chromium.org>
Date:   Mon, 31 Jan 2022 19:23:24 +1100
Message-ID: <CAPuLczsP=VFVYzFjGDj3ysb6C=p4FHMVO3T69P6oN+p0WFQqRw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers/misc: add transfer ioctl for HPS
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, dtor@chromium.org,
        evanbenn@chromium.org, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pe 28. tammik. 2022 klo 20.36 Greg KH (gregkh@linuxfoundation.org) kirjoitt=
i:
>
> On Fri, Jan 28, 2022 at 06:42:08PM +1100, Sami Kyostila wrote:
> > to 27. tammik. 2022 klo 20.41 Greg KH (gregkh@linuxfoundation.org) kirj=
oitti:
> > >
> > > On Thu, Jan 27, 2022 at 07:35:45PM +1100, Sami Ky=C3=B6stil=C3=A4 wro=
te:
> > > > This patch adds an ioctl operation for sending and receiving data f=
rom
> > > > the ChromeOS snooping protection sensor (a.k.a., HPS). This allows
> > > > userspace programs to perform a combined read/write I2C transaction
> > > > through a single syscall.
> > > >
> > > > The I2C wire protocol for the device is documented at:
> > > >
> > > > https://chromium.googlesource.com/chromiumos/platform/hps-firmware/=
+/
> > > > refs/heads/main/docs/host_device_i2c_protocol.md
> > > >
> > > > Signed-off-by: Sami Ky=C3=B6stil=C3=A4 <skyostil@chromium.org>
> > > > ---
> > > >
> > > >  MAINTAINERS              |  1 +
> > > >  drivers/misc/hps-i2c.c   | 81 ++++++++++++++++++++++++++++++++++++=
++++
> > > >  include/uapi/linux/hps.h | 20 ++++++++++
> > > >  3 files changed, 102 insertions(+)
> > > >  create mode 100644 include/uapi/linux/hps.h
> > > >
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index 9dea4b8c2ab5..d5fc066fdbc2 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -8803,6 +8803,7 @@ M:      Sami Ky=C3=B6stil=C3=A4 <skyostil@chr=
omium.org>
> > > >  R:   Evan Benn <evanbenn@chromium.org>
> > > >  S:   Maintained
> > > >  F:   drivers/misc/hps-i2c.c
> > > > +F:   include/uapi/linux/hps.h
> > > >
> > > >  HSI SUBSYSTEM
> > > >  M:   Sebastian Reichel <sre@kernel.org>
> > > > diff --git a/drivers/misc/hps-i2c.c b/drivers/misc/hps-i2c.c
> > > > index fe9f073b0352..748ead49d678 100644
> > > > --- a/drivers/misc/hps-i2c.c
> > > > +++ b/drivers/misc/hps-i2c.c
> > > > @@ -17,9 +17,11 @@
> > > >  #include <linux/i2c.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/pm_runtime.h>
> > > > +#include <uapi/linux/hps.h>
> > > >
> > > >  #define HPS_ACPI_ID          "GOOG0020"
> > > >  #define HPS_MAX_DEVICES              1
> > > > +#define HPS_MAX_MSG_SIZE     8192
> > > >
> > > >  struct hps_drvdata {
> > > >       struct i2c_client *client;
> > > > @@ -60,6 +62,8 @@ static int hps_open(struct inode *inode, struct f=
ile *file)
> > > >       ret =3D pm_runtime_get_sync(dev);
> > > >       if (ret < 0)
> > > >               goto pm_get_fail;
> > > > +
> > > > +     file->private_data =3D hps->client;
> > > >       return 0;
> > > >
> > > >  pm_get_fail:
> > > > @@ -84,10 +88,87 @@ static int hps_release(struct inode *inode, str=
uct file *file)
> > > >       return ret;
> > > >  }
> > > >
> > > > +static int hps_do_ioctl_transfer(struct i2c_client *client,
> > > > +                              struct hps_transfer_ioctl_data *args=
)
> > > > +{
> > > > +     int ret;
> > > > +     int nmsg =3D 0;
> > > > +     struct i2c_msg msgs[2] =3D {
> > > > +             {
> > > > +                     .addr =3D client->addr,
> > > > +                     .flags =3D client->flags,
> > > > +             },
> > > > +             {
> > > > +                     .addr =3D client->addr,
> > > > +                     .flags =3D client->flags,
> > > > +             },
> > > > +     };
> > > > +
> > > > +     if (args->isize) {
> > > > +             msgs[nmsg].len =3D args->isize;
> > > > +             msgs[nmsg].buf =3D memdup_user(args->ibuf, args->isiz=
e);
> > > > +             if (IS_ERR(msgs[nmsg].buf)) {
> > > > +                     ret =3D PTR_ERR(msgs[nmsg].buf);
> > > > +                     goto memdup_fail;
> > > > +             }
> > > > +             nmsg++;
> > > > +     }
> > > > +
> > > > +     if (args->osize) {
> > > > +             msgs[nmsg].len =3D args->osize;
> > > > +             msgs[nmsg].buf =3D memdup_user(args->obuf, args->osiz=
e);
> > > > +             msgs[nmsg].flags |=3D I2C_M_RD;
> > > > +             if (IS_ERR(msgs[nmsg].buf)) {
> > > > +                     ret =3D PTR_ERR(msgs[nmsg].buf);
> > > > +                     goto memdup_fail;
> > > > +             }
> > > > +             nmsg++;
> > > > +     }
> > > > +
> > > > +     ret =3D i2c_transfer(client->adapter, &msgs[0], nmsg);
> > > > +     if (ret > 0 && args->osize) {
> > > > +             if (copy_to_user(args->obuf, msgs[nmsg - 1].buf, ret)=
)
> > > > +                     ret =3D -EFAULT;
> > > > +     }
> > >
> > > Why can't you just do normal i2c transfers to/from userspace instead =
of
> > > requring a custom ioctl?
> >
> > The main reason is security: without this driver, in order to talk to
> > HPS the userspace daemon needs read/write access to the entire I2C
> > controller (e.g., /dev/i2c-0). This means the daemon can also control
> > any other I2C device which happens to be on the same bus. With a
> > separate ioctl we can limit access to just HP
> Then use seccomp for this?

As far as I can tell, seccomp can't do this because it can't read the
device address field[1] which is behind two userspace pointer hops in
the I2C_RDWR ioctl[2].

[1] https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/i2c.h=
#L74
[2] https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/i2c-d=
ev.h#L51

>
> > As far as I can tell, there's no way to restrict access on a
> > per-device level with normal i2c, but I'd be happy to be proven wrong
> > :)
>
> Selinux rules?

I guess we could add an LSM hook for I2C transfers, but that would
require baking device addresses into the SELinux policy which seems a
little unfortunate.

I think that leaves the options suggested by Arnd (thanks!):

a) Add a generic way to expose device nodes for individual I2C devices
(something like /dev/i2c/by-id/NN?).

b) Make the ioctl interface more fully featured instead of just exposing I2=
C.

I think I'm leaning toward (a) since it's not yet totally clear what
the right high level abstraction for this type of device is (e.g.,
should it be HID, in which case the protocol should probably become
HID-I2C).

If this sounds okay, then I suggest we merge just the power control
patch from this series (with comments addressed) and I'll follow-up
with splitting out the i2c devices.

> What else is on this bus for the device that you care about?

That's really up to the device manufacturer; it could be anything from
touchpads to cameras or fingerprint scanners.

> thanks,
>
> greg k-h

- Sami

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAF449F48D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242964AbiA1HmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiA1HmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:42:20 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F70C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 23:42:20 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id az20so1986869vsb.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 23:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TUJN3E8HLIWQMC+JkuH+pNtqlz3LDjBnQRMbHqWeDZY=;
        b=oRHvg9qCnFAFOGAFsSCyPwMEb+x54NrSRrWvx8JpZ4RAupPNRrpxkX5L17ovRg3Vt/
         i63c8Q0ozaECZH1te1QVjS8HIc9xYz6PPHJH1IZHL/28t+J1j6Epq0mmZEpM6wCP9nJz
         tUJibp4obJh5MErW44MuQYjDOEGYphSeLQKVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TUJN3E8HLIWQMC+JkuH+pNtqlz3LDjBnQRMbHqWeDZY=;
        b=yCTqFSURUAW0IRLqR30w8NpgYynXi5/MrnGDbgZUEhDhAH5Bf3bYrTaFJreDPO1tnA
         EbqgneYXNBVBxgrIL9iKtNYDqv85RPkFw/h0+J9SvMjCwfMR92j3lvHHMjXPdUU/4m53
         OkLyHgSikTLEUrhwqaSO4/Ut4KWbndHb6BuVWSij8Q3tTeIDUQJqCOO4EdMyWH5t62HL
         9SxdosstvM8YwtXKDRNUbzAM6IBNPtRqtK7gEbt9czZCMkbtzE4CBl1lNu6gB0j4YwiF
         9F2miqe+I2ghJajRJi5jf528ekjL/ySU1oLKIWF2BtJmEhp/1YgsCc3J2ZZK/t3bAfbi
         dJFg==
X-Gm-Message-State: AOAM530WLC1gxae398KcmJms6vQeYEkyxCLZbiV4TBM/oHS1mbJ06lL8
        d3VGDgUzNM4tmaRrlC/wLsRakxTXgHv9teAzeiVZCQ==
X-Google-Smtp-Source: ABdhPJxKJjUVYuCr4CRypjs5KIau2+had06NuPAfIaws1OGW/6KUgGXj26162C85z7lT51v4dBsG/X9IxRzH5AVK3Tc=
X-Received: by 2002:a05:6102:18d:: with SMTP id r13mr3631364vsq.67.1643355739440;
 Thu, 27 Jan 2022 23:42:19 -0800 (PST)
MIME-Version: 1.0
References: <20220127083545.1020423-1-skyostil@chromium.org>
 <20220127083545.1020423-3-skyostil@chromium.org> <YfJovN7clqBZ8NDr@kroah.com>
In-Reply-To: <YfJovN7clqBZ8NDr@kroah.com>
From:   Sami Kyostila <skyostil@chromium.org>
Date:   Fri, 28 Jan 2022 18:42:08 +1100
Message-ID: <CAPuLczsLSnojXG8zyWBq6P50S8dVN3LcTi+2L0j-zLbwC_cJ0g@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers/misc: add transfer ioctl for HPS
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, dtor@chromium.org,
        evanbenn@chromium.org, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

to 27. tammik. 2022 klo 20.41 Greg KH (gregkh@linuxfoundation.org) kirjoitt=
i:
>
> On Thu, Jan 27, 2022 at 07:35:45PM +1100, Sami Ky=C3=B6stil=C3=A4 wrote:
> > This patch adds an ioctl operation for sending and receiving data from
> > the ChromeOS snooping protection sensor (a.k.a., HPS). This allows
> > userspace programs to perform a combined read/write I2C transaction
> > through a single syscall.
> >
> > The I2C wire protocol for the device is documented at:
> >
> > https://chromium.googlesource.com/chromiumos/platform/hps-firmware/+/
> > refs/heads/main/docs/host_device_i2c_protocol.md
> >
> > Signed-off-by: Sami Ky=C3=B6stil=C3=A4 <skyostil@chromium.org>
> > ---
> >
> >  MAINTAINERS              |  1 +
> >  drivers/misc/hps-i2c.c   | 81 ++++++++++++++++++++++++++++++++++++++++
> >  include/uapi/linux/hps.h | 20 ++++++++++
> >  3 files changed, 102 insertions(+)
> >  create mode 100644 include/uapi/linux/hps.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 9dea4b8c2ab5..d5fc066fdbc2 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8803,6 +8803,7 @@ M:      Sami Ky=C3=B6stil=C3=A4 <skyostil@chromiu=
m.org>
> >  R:   Evan Benn <evanbenn@chromium.org>
> >  S:   Maintained
> >  F:   drivers/misc/hps-i2c.c
> > +F:   include/uapi/linux/hps.h
> >
> >  HSI SUBSYSTEM
> >  M:   Sebastian Reichel <sre@kernel.org>
> > diff --git a/drivers/misc/hps-i2c.c b/drivers/misc/hps-i2c.c
> > index fe9f073b0352..748ead49d678 100644
> > --- a/drivers/misc/hps-i2c.c
> > +++ b/drivers/misc/hps-i2c.c
> > @@ -17,9 +17,11 @@
> >  #include <linux/i2c.h>
> >  #include <linux/module.h>
> >  #include <linux/pm_runtime.h>
> > +#include <uapi/linux/hps.h>
> >
> >  #define HPS_ACPI_ID          "GOOG0020"
> >  #define HPS_MAX_DEVICES              1
> > +#define HPS_MAX_MSG_SIZE     8192
> >
> >  struct hps_drvdata {
> >       struct i2c_client *client;
> > @@ -60,6 +62,8 @@ static int hps_open(struct inode *inode, struct file =
*file)
> >       ret =3D pm_runtime_get_sync(dev);
> >       if (ret < 0)
> >               goto pm_get_fail;
> > +
> > +     file->private_data =3D hps->client;
> >       return 0;
> >
> >  pm_get_fail:
> > @@ -84,10 +88,87 @@ static int hps_release(struct inode *inode, struct =
file *file)
> >       return ret;
> >  }
> >
> > +static int hps_do_ioctl_transfer(struct i2c_client *client,
> > +                              struct hps_transfer_ioctl_data *args)
> > +{
> > +     int ret;
> > +     int nmsg =3D 0;
> > +     struct i2c_msg msgs[2] =3D {
> > +             {
> > +                     .addr =3D client->addr,
> > +                     .flags =3D client->flags,
> > +             },
> > +             {
> > +                     .addr =3D client->addr,
> > +                     .flags =3D client->flags,
> > +             },
> > +     };
> > +
> > +     if (args->isize) {
> > +             msgs[nmsg].len =3D args->isize;
> > +             msgs[nmsg].buf =3D memdup_user(args->ibuf, args->isize);
> > +             if (IS_ERR(msgs[nmsg].buf)) {
> > +                     ret =3D PTR_ERR(msgs[nmsg].buf);
> > +                     goto memdup_fail;
> > +             }
> > +             nmsg++;
> > +     }
> > +
> > +     if (args->osize) {
> > +             msgs[nmsg].len =3D args->osize;
> > +             msgs[nmsg].buf =3D memdup_user(args->obuf, args->osize);
> > +             msgs[nmsg].flags |=3D I2C_M_RD;
> > +             if (IS_ERR(msgs[nmsg].buf)) {
> > +                     ret =3D PTR_ERR(msgs[nmsg].buf);
> > +                     goto memdup_fail;
> > +             }
> > +             nmsg++;
> > +     }
> > +
> > +     ret =3D i2c_transfer(client->adapter, &msgs[0], nmsg);
> > +     if (ret > 0 && args->osize) {
> > +             if (copy_to_user(args->obuf, msgs[nmsg - 1].buf, ret))
> > +                     ret =3D -EFAULT;
> > +     }
>
> Why can't you just do normal i2c transfers to/from userspace instead of
> requring a custom ioctl?

The main reason is security: without this driver, in order to talk to
HPS the userspace daemon needs read/write access to the entire I2C
controller (e.g., /dev/i2c-0). This means the daemon can also control
any other I2C device which happens to be on the same bus. With a
separate ioctl we can limit access to just HPS.

As far as I can tell, there's no way to restrict access on a
per-device level with normal i2c, but I'd be happy to be proven wrong
:)

>
> thanks,
>
> greg k-h


- Sami

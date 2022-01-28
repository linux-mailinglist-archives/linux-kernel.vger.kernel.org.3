Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0648B49F677
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 10:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243590AbiA1JgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 04:36:08 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52044 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238119AbiA1JgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:36:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D69E4B818E0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 09:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B31EC340E0;
        Fri, 28 Jan 2022 09:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643362564;
        bh=RNYx0y7rlPXfR94RfuO4OdTpV0HZfT1xQgB4lqpedt8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uxuN3efWq5y8qyUWiS+rk/tbXIS+awH4jtFT0DGXBhj3ymKei0v7fcIwhG34XlBbH
         lWp0+9LZY2GBao+Sq+vSU7Ohq18OsAgwxm4AptD5ip+tmMpGo8ESdbE3qsLsQFc82d
         vKvkPgejcXCdAUJ7k1RNE0vzX1h90YfxSY2LmtEM=
Date:   Fri, 28 Jan 2022 10:36:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sami Kyostila <skyostil@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, dtor@chromium.org,
        evanbenn@chromium.org, arnd@arndb.de
Subject: Re: [PATCH 2/2] drivers/misc: add transfer ioctl for HPS
Message-ID: <YfO5ASQ31vJpnGTC@kroah.com>
References: <20220127083545.1020423-1-skyostil@chromium.org>
 <20220127083545.1020423-3-skyostil@chromium.org>
 <YfJovN7clqBZ8NDr@kroah.com>
 <CAPuLczsLSnojXG8zyWBq6P50S8dVN3LcTi+2L0j-zLbwC_cJ0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPuLczsLSnojXG8zyWBq6P50S8dVN3LcTi+2L0j-zLbwC_cJ0g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 06:42:08PM +1100, Sami Kyostila wrote:
> to 27. tammik. 2022 klo 20.41 Greg KH (gregkh@linuxfoundation.org) kirjoitti:
> >
> > On Thu, Jan 27, 2022 at 07:35:45PM +1100, Sami Kyöstilä wrote:
> > > This patch adds an ioctl operation for sending and receiving data from
> > > the ChromeOS snooping protection sensor (a.k.a., HPS). This allows
> > > userspace programs to perform a combined read/write I2C transaction
> > > through a single syscall.
> > >
> > > The I2C wire protocol for the device is documented at:
> > >
> > > https://chromium.googlesource.com/chromiumos/platform/hps-firmware/+/
> > > refs/heads/main/docs/host_device_i2c_protocol.md
> > >
> > > Signed-off-by: Sami Kyöstilä <skyostil@chromium.org>
> > > ---
> > >
> > >  MAINTAINERS              |  1 +
> > >  drivers/misc/hps-i2c.c   | 81 ++++++++++++++++++++++++++++++++++++++++
> > >  include/uapi/linux/hps.h | 20 ++++++++++
> > >  3 files changed, 102 insertions(+)
> > >  create mode 100644 include/uapi/linux/hps.h
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 9dea4b8c2ab5..d5fc066fdbc2 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -8803,6 +8803,7 @@ M:      Sami Kyöstilä <skyostil@chromium.org>
> > >  R:   Evan Benn <evanbenn@chromium.org>
> > >  S:   Maintained
> > >  F:   drivers/misc/hps-i2c.c
> > > +F:   include/uapi/linux/hps.h
> > >
> > >  HSI SUBSYSTEM
> > >  M:   Sebastian Reichel <sre@kernel.org>
> > > diff --git a/drivers/misc/hps-i2c.c b/drivers/misc/hps-i2c.c
> > > index fe9f073b0352..748ead49d678 100644
> > > --- a/drivers/misc/hps-i2c.c
> > > +++ b/drivers/misc/hps-i2c.c
> > > @@ -17,9 +17,11 @@
> > >  #include <linux/i2c.h>
> > >  #include <linux/module.h>
> > >  #include <linux/pm_runtime.h>
> > > +#include <uapi/linux/hps.h>
> > >
> > >  #define HPS_ACPI_ID          "GOOG0020"
> > >  #define HPS_MAX_DEVICES              1
> > > +#define HPS_MAX_MSG_SIZE     8192
> > >
> > >  struct hps_drvdata {
> > >       struct i2c_client *client;
> > > @@ -60,6 +62,8 @@ static int hps_open(struct inode *inode, struct file *file)
> > >       ret = pm_runtime_get_sync(dev);
> > >       if (ret < 0)
> > >               goto pm_get_fail;
> > > +
> > > +     file->private_data = hps->client;
> > >       return 0;
> > >
> > >  pm_get_fail:
> > > @@ -84,10 +88,87 @@ static int hps_release(struct inode *inode, struct file *file)
> > >       return ret;
> > >  }
> > >
> > > +static int hps_do_ioctl_transfer(struct i2c_client *client,
> > > +                              struct hps_transfer_ioctl_data *args)
> > > +{
> > > +     int ret;
> > > +     int nmsg = 0;
> > > +     struct i2c_msg msgs[2] = {
> > > +             {
> > > +                     .addr = client->addr,
> > > +                     .flags = client->flags,
> > > +             },
> > > +             {
> > > +                     .addr = client->addr,
> > > +                     .flags = client->flags,
> > > +             },
> > > +     };
> > > +
> > > +     if (args->isize) {
> > > +             msgs[nmsg].len = args->isize;
> > > +             msgs[nmsg].buf = memdup_user(args->ibuf, args->isize);
> > > +             if (IS_ERR(msgs[nmsg].buf)) {
> > > +                     ret = PTR_ERR(msgs[nmsg].buf);
> > > +                     goto memdup_fail;
> > > +             }
> > > +             nmsg++;
> > > +     }
> > > +
> > > +     if (args->osize) {
> > > +             msgs[nmsg].len = args->osize;
> > > +             msgs[nmsg].buf = memdup_user(args->obuf, args->osize);
> > > +             msgs[nmsg].flags |= I2C_M_RD;
> > > +             if (IS_ERR(msgs[nmsg].buf)) {
> > > +                     ret = PTR_ERR(msgs[nmsg].buf);
> > > +                     goto memdup_fail;
> > > +             }
> > > +             nmsg++;
> > > +     }
> > > +
> > > +     ret = i2c_transfer(client->adapter, &msgs[0], nmsg);
> > > +     if (ret > 0 && args->osize) {
> > > +             if (copy_to_user(args->obuf, msgs[nmsg - 1].buf, ret))
> > > +                     ret = -EFAULT;
> > > +     }
> >
> > Why can't you just do normal i2c transfers to/from userspace instead of
> > requring a custom ioctl?
> 
> The main reason is security: without this driver, in order to talk to
> HPS the userspace daemon needs read/write access to the entire I2C
> controller (e.g., /dev/i2c-0). This means the daemon can also control
> any other I2C device which happens to be on the same bus. With a
> separate ioctl we can limit access to just HPS.

Then use seccomp for this?

> As far as I can tell, there's no way to restrict access on a
> per-device level with normal i2c, but I'd be happy to be proven wrong
> :)

Selinux rules?

What else is on this bus for the device that you care about?

thanks,

greg k-h

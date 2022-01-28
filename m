Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E6F49F48E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242967AbiA1Hmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346929AbiA1Hmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:42:43 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FB2C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 23:42:43 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id x13so1985534vsl.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 23:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iD4Xdgw71HLMmvdMsMDTR6FQ/xXimMvzqBGCzvKFjLs=;
        b=FPylrTDsY2K3hOmGAMpHUjSNwkuz2BNcgOEy0c4YFgGFKJjehO5eFocGoa8naf4pZ0
         /Iik/0Tz2OPw/DoPELjijxVpB634XjEjP26u0MDIhXLJOaVea2kvoWBlilSFtkF5Cybh
         1Zuk+uviUZoYx7NFWKSnJzDc55St+iMAAV1tE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iD4Xdgw71HLMmvdMsMDTR6FQ/xXimMvzqBGCzvKFjLs=;
        b=ujwx7pb6pC1BloxaVLD0Xb9PHbLx0Svm2HvJ9P/qaLz6HKljU1SzLJ7NI+N+X6N9aG
         odJuky3eztLVSSikx5Eg8j2FeGEEeShCYsPqyvb20e9KgJfv95B9Y0j9K6KKMlTymEw8
         +fMgSMs5uQgOuoQVyNgsf3NhylebyeTfYJnl6Xtr4aIi0HZqjzVY/jIhJ1aGK3jKs1jQ
         YWG3Rat6Ruy9q4TmSkXKpiUD4omRwSElLeyyQI2eCvro+ED0vGu6F4lPMwmBjVyE/2jA
         YhneSwabzx+6GA5Hh8RXPQeUTm07QZlOgp4wyfRv/HS2Epp33tMceZltCZIISQxM/tqo
         1gFw==
X-Gm-Message-State: AOAM533PT7QjagqqDUeWFo+UsFrSUOhO8xrRqD2SQ1xImVfpZ7Wm+51r
        8PqH5pmnmh61iEFpwdTqxrkwaDislR0Dfe2Uy/hg+w==
X-Google-Smtp-Source: ABdhPJwLOnCBACCySx4/OYaV1zo4qkIeMMNqn0ClSqJF47Z43DGdF+xEOTesc/OQAnn2Tm5kU36DAh6VVK8AYoRHGos=
X-Received: by 2002:a67:d98e:: with SMTP id u14mr3730406vsj.2.1643355762269;
 Thu, 27 Jan 2022 23:42:42 -0800 (PST)
MIME-Version: 1.0
References: <20220127083545.1020423-1-skyostil@chromium.org>
 <20220127083545.1020423-3-skyostil@chromium.org> <aa0b1b37-de0b-c859-5d9b-9de406c770b9@infradead.org>
In-Reply-To: <aa0b1b37-de0b-c859-5d9b-9de406c770b9@infradead.org>
From:   Sami Kyostila <skyostil@chromium.org>
Date:   Fri, 28 Jan 2022 18:42:31 +1100
Message-ID: <CAPuLczt0Oo-tWZQDLe_g6JNvR9Dqa3wpKUjzMAv+goOV64DNyA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers/misc: add transfer ioctl for HPS
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, dtor@chromium.org,
        evanbenn@chromium.org, arnd@arndb.de, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pe 28. tammik. 2022 klo 9.39 Randy Dunlap (rdunlap@infradead.org) kirjoitti=
:
>
>
>
> On 1/27/22 00:35, Sami Ky=C3=B6stil=C3=A4 wrote:
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
>
> Hi--
>
> If your next patch version continues to use an ioctl, its magic "number"
> ('h') should be documented in Documentation/userspace-api/ioctl/ioctl-num=
ber.rst.

Ah, thanks for the pointer. Will do.


- Sami

>
> thanks.
>
> > diff --git a/include/uapi/linux/hps.h b/include/uapi/linux/hps.h
> > new file mode 100644
> > index 000000000000..2c1bd174cd02
> > --- /dev/null
> > +++ b/include/uapi/linux/hps.h
> > @@ -0,0 +1,20 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> > +/*
> > + *  Copyright 2022 Google LLC.
> > + */
> > +
> > +#ifndef _UAPI_HPS_H
> > +#define _UAPI_HPS_H
> > +
> > +#include <linux/types.h>
> > +
> > +#define HPS_IOC_TRANSFER     _IOWR('h', 0x01, struct hps_transfer_ioct=
l_data)
> > +
> > +struct hps_transfer_ioctl_data {
> > +     __u32 isize;                    /* Number of bytes to send */
> > +     unsigned char __user *ibuf;     /* Input buffer */
> > +     __u32 osize;                    /* Number of bytes to receive */
> > +     unsigned char __user *obuf;     /* Output buffer */
> > +};
> > +
> > +#endif /* _UAPI_HPS_H */
>
> --
> ~Randy

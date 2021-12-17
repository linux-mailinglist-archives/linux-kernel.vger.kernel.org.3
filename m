Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816714793AC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 19:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240144AbhLQSQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 13:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240134AbhLQSQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 13:16:18 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C032C06173E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 10:16:18 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id g17so8697114ybe.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 10:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=INj4rN0A/6Jb71uPWpLzYSllBxhC8CfxjBxGNm12ZbM=;
        b=Hb/CFhAlMCEKOAb4Nc9zHkTNxIpikKk8A9CMgE5WFTQtVwYA5C57sBDSWVMzZtVgxd
         Zf5b9VTFBjlxvPWSj+wfs1lVkzxlQdc7Kbmg2lJuGFuPW/WWL+PkDyV3qDXZhdRp1GdH
         12/aeL5zp25qWdOvvvTNS7WOhCrdtHkDfwD2PZj0kX4u1qMEpgdwgofCLXVdZMBDy+MI
         uAsid/M+AIWEkyJknkOSA4vWb4hQUFXfzBtQ9ur1eQG0Q5wGS4UpOp42aIZepm7RiKTI
         0hL+QCNiAU0mMCOvztFKwhMHAWT3+vngmeXEq9A216qdeFzOXJ1chY3bWr6VMjg0BwRD
         5T7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=INj4rN0A/6Jb71uPWpLzYSllBxhC8CfxjBxGNm12ZbM=;
        b=0Yo4X/lsMT4CW2JHj8HNICa8Y4XE+CMc9WhWaRZ6lFmFeVmo8YVyMQ0FbO9QRQq59L
         PHZBQ8lbGGpNahSnfLJyZqig/xEJzx/0TaF6cHeCdg2RQEJ9t723pmWY9kIflAP5H0RV
         R2ThOt+/urgeWffaqF03GfjdeYEghpBFqiM/KBYccL9dZU1223vH7kAexrvtVS1yaaza
         5Lh0TkrHAqKaF9Vnc2w+kEG7uHB8e2cmd0nm7H8O8fewI2gvDuParYWcOlIt7leocskz
         Nntl8o+tdfQ4dKhDJXlVp8c5MtXadz+VwN/35yu+onePEVOJCAuIPwyZPCA0djo7J344
         F9Yw==
X-Gm-Message-State: AOAM533wuZtwWDuNKMXn51qFs1BRq70YKFuazBD0JMRm9qJurN7Jbe91
        PpHuidMdLTX6gNotUhGv5EKhue56lWRvYaeQaJk=
X-Google-Smtp-Source: ABdhPJx5rXitpkARcCH4JuL/HI9P91U6jCSOUNxq95ERJAU77IJ3uXXkNvtL5cZkD6Yx0lCkzlJeAY40UNMh5CYA/Lc=
X-Received: by 2002:a25:4156:: with SMTP id o83mr5615173yba.216.1639764977118;
 Fri, 17 Dec 2021 10:16:17 -0800 (PST)
MIME-Version: 1.0
References: <20211217145544.341617-1-pgwipeout@gmail.com> <2bebe0ae-27df-f75d-97d6-2e4d2dd032b0@gmail.com>
In-Reply-To: <2bebe0ae-27df-f75d-97d6-2e4d2dd032b0@gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Fri, 17 Dec 2021 13:16:05 -0500
Message-ID: <CAMdYzYq=2G1bvu9M_DR0vdQDtcvVBhQFRPTNKo1ySFrMZOk=jg@mail.gmail.com>
Subject: Re: [PATCH v2] mfd: rk808: add reboot support to rk808.c
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 10:29 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 17.12.2021 17:55, Peter Geis =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > This adds reboot support to the rk808o pmic driver and enables it for
> > the rk809 and rk817 devices.
> > This only enables if the rockchip,system-power-controller flag is set.
> >
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > ---
> > This patch was created to address issues with psci-reset on rk356x
> > chips. Until the rk356x series ATF open source code is released so we
> > can fix the issue at the source, this is the only way to ensure reliabl=
e
> > resetting on devices using these chips.
> >
> > After testing the rk808 (thanks Robin!), it was found DEV_OFF_RST does
> > not reset the PMIC to a power on state. Since the rk805 and rk818 match
> > this register layout, I'm removing support for all three in the v2.
> > It may be possible to add support to them using an RTC wakeup, but that
> > has not been explored and is outside the scope of this patch.
> >
> > Changelog:
> > V2:
> > - Squash the patch from Frank Wunderlich for rk809 support.
> > - Remove support for the rk805, rk808, and rk818 devices.
> > - Only register the reset handler for supported devices.
> > - Remove unnecessary dev_err and dev_warn statements.
> > - Register the reset handler directly
> >
> >  drivers/mfd/rk808.c       | 43 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/mfd/rk808.h |  1 +
> >  2 files changed, 44 insertions(+)
> ...
> > +static struct notifier_block rk808_restart_handler =3D {
> > +     .notifier_call =3D rk808_restart_notify,
> > +     .priority =3D 255,
> > +};
>
> Hello!
>
> Please use the default 128 priority if there are no other conflicting
> handlers on this RK.

Unfortunately the psci-reboot handler is set to 129, I'll adjust this
to 192 which is in line with other PMIC reboot drivers.

>
> >  static void rk8xx_shutdown(struct i2c_client *client)
> >  {
> >       struct rk808 *rk808 =3D i2c_get_clientdata(client);
> > @@ -727,6 +757,19 @@ static int rk808_probe(struct i2c_client *client,
> >       if (of_property_read_bool(np, "rockchip,system-power-controller")=
) {
> >               rk808_i2c_client =3D client;
> >               pm_power_off =3D rk808_pm_power_off;
> > +
> > +             switch (rk808->variant) {
> > +             case RK809_ID:
> > +             case RK817_ID:
> > +                     ret =3D register_restart_handler(&rk808_restart_h=
andler);
>
> There is no corresponding unregister_restart_handler(), which you should
> add to rk808_remove(). Otherwise kernel will crash on reboot if you'll
> unload this driver module.

Thanks, added!

>
> > +                     break;
> > +             default:
> > +                     dev_info(&client->dev, "pmic controlled board res=
et not supported\n");
>
> I'd set ret=3D0 explicitly here. Later on somebody may change the code an=
d
> ret won't be zero anymore, this is not an uncommon trouble in kernel.

It took me a moment to see the logic here, but I understand it now.

>
> > +                     break;
> > +             }
> > +
> > +             if (ret)
> > +                     dev_err(&client->dev, "failed to register restart=
 handler, %d\n", ret);
>
>
>

Thank you for the review.

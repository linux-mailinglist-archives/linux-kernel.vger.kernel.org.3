Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76495478317
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 03:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbhLQCVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 21:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbhLQCVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 21:21:33 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F40C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 18:21:32 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id f9so2159714ybq.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 18:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QqHu8r0uxWjJt+jjHoWIp0FC3lozeKPEo/3clh2f5xY=;
        b=YCMEJ0k4au+E9qUJKMuWxEktkoURDElKIbyUWF/o8FB9jU6CrLxIwnaF5RjXOctBM/
         QBteLQkx0klDLtTm6toQTRawUn8PWj3LTYynJdLpN5sDZFXncwyUMRP0T0J1oaZRVqv7
         L8lG3scMLaPFgpBG6hNfR4aGM8IV1lUzlt3lbqpTLvvZItGJLSEpRzDKkYUMq1pFXRf+
         6UIaD5lhg+MnwdOymlm5qbzw0p1K2NlpUAaZg+DUwjgbes8Wnkw4aNEqZ+du3MC7BcsU
         lmwWzNmyC4ClP2Ap2EW0ytLWToWcaNbY6ECt7Z5vjWwq58J/fR6hDnNicjsrB5k9OdwW
         MVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QqHu8r0uxWjJt+jjHoWIp0FC3lozeKPEo/3clh2f5xY=;
        b=h5yUwOkJXxoGRBdsgMNxNmUWfP/6YvdqF1dRhxxhFG1khVuiM+yrDCAWBsIlrzuk5B
         xxShBDD9fY6k+zAWQZgdTnI45B1HHN5fW24UU6GqsvAo+0w0TxR2SOD0ewYeoAdcrL91
         Yjs8btoRkeDF70qxSUllLLkwtLXl39nUlUkjMJ3oHs9jSFEHhTL9sug1KAmjfKYFFnQf
         1mBcxFfVmQJntpkJrstIuA3fV7mJvKf6rtjGuXt50E4PYAkWO1YHnkSwyF3qod16TGCs
         KIvQVsbh8NpNipXegm1NjmnDj/88cgU1o5nobwH1MNpJcgLN9LkMqO6HpSkXpkpTJqLd
         ddrw==
X-Gm-Message-State: AOAM5337woKMfwJ5BMcZJdWTTsG8htBUBKLYyJxMFkjpiSaVd5XPaZD2
        poRSFGI+otDXBZCYd1rq7m3jO1LwxePP+lQjo7E=
X-Google-Smtp-Source: ABdhPJwv/4RRFLrJSgX63bWLN8qW78qqYUNovM/1lgUWBiv8YDjl4Dd7tk3dh2BekJRMOB5Pwvny5j2NJ4XhJdctyUY=
X-Received: by 2002:a25:6984:: with SMTP id e126mr1535603ybc.680.1639707691969;
 Thu, 16 Dec 2021 18:21:31 -0800 (PST)
MIME-Version: 1.0
References: <20211215213300.4778-1-linux@fw-web.de> <20211215213300.4778-2-linux@fw-web.de>
 <fe895d71-5f1f-daf0-bde8-c8ab5f4c0128@arm.com> <trinity-18dddf5d-bc73-453d-a9eb-954de1ab7cc7-1639672581601@3c-app-gmx-bap16>
In-Reply-To: <trinity-18dddf5d-bc73-453d-a9eb-954de1ab7cc7-1639672581601@3c-app-gmx-bap16>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Thu, 16 Dec 2021 21:21:20 -0500
Message-ID: <CAMdYzYpqtJ9E+NJ7Ra9rdMPj5idjrRvQ3=+N+ye7MTLuQtzJSw@mail.gmail.com>
Subject: Re: Re: [PATCH 1/2] mfd: rk808: add reboot support to rk808 pmic
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Frank Wunderlich <linux@fw-web.de>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 11:36 AM Frank Wunderlich
<frank-w@public-files.de> wrote:
>
> Hi Robin
>
> thanks for your review

Good Evening,

>
> > Gesendet: Donnerstag, 16. Dezember 2021 um 14:17 Uhr
> > Von: "Robin Murphy" <robin.murphy@arm.com>
>
> > > +   dev_err(&rk808_i2c_client->dev, "poweroff device!\n");
> >
> > This is not an error.
>
> ack, we can change to dev_dbg/dev_info or drop completely

Yes, this was set to isolate down when individuals were having issues
on a specific distro that unfortunately defaults to a silent boot.
It can be dropped at this point.

>
> > > @@ -552,6 +554,7 @@ static void rk808_pm_power_off(void)
> > >             bit = DEV_OFF;
> > >             break;
> > >     default:
> > > +           dev_err(&rk808_i2c_client->dev, "poweroff device not supported!\n");
> >
> > If we really don't support power off for the present PMIC then we should
> > avoid registering the power off handler in the first place. These
> > default cases should mostly just serve to keep static checkers happy.
>
> currently we had added all device-ids supported by probe. Before my Patch (Part2) rk809 was missing.
> It is not registered for (currently) unsupported IDs as probe exits with -EINVAL for unsupported IDs before.
>
> If anyone adds init-code in future but not poweroff/restart part we ran into this. So i would leave this message.
>
> registering handler depending on supported devices (for poweroff/restart function) imho makes code less readable.

I added that just in case someone put in support for a new device
without checking everything.
I don't have any particular attachment to it however.

>
> > > @@ -559,6 +562,44 @@ static void rk808_pm_power_off(void)
> > >             dev_err(&rk808_i2c_client->dev, "Failed to shutdown device!\n");
> > >   }
> > >
> > > +static int rk808_restart_notify(struct notifier_block *this, unsigned long mode, void *cmd)
> > > +{
> > > +   int ret;
> > > +   unsigned int reg, bit;
> > > +   struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
> > > +
> > > +   switch (rk808->variant) {
> > > +   case RK805_ID:
> > > +           reg = RK805_DEV_CTRL_REG;
> > > +           bit = DEV_OFF_RST;
> > > +           break;
> > > +   case RK808_ID:
> > > +           reg = RK808_DEVCTRL_REG,
> > > +           bit = DEV_OFF;
> >
> > Is that right? The RK808 datasheet does say that this bit resets itself
> > once the OFF state is reached, but there doesn't seem to be any obvious
> > guarantee of a power-on condition being present to automatically
> > transition back to ACTIVE.
>
> i think you're right...imho it should be DEV_OFF_RST in restart_notify and DEV_OFF in poweroff

I've tested this on the rockpro64, DEV_OFF_RST and DEV_OFF both power
down the rk808.
The difference is the DEV_OFF_RST "activate reset of the digital core".
This is similar to the description of pressing the RESET key, with the
exception of not powering up the PMIC.
It seems the rk808 doesn't support software resetting at all per the trm.
We should drop reset support for the rk808.
The only way I can see triggering a reset in the rk808 being possible
is by setting the RTC alarm to wake the device shortly after powering
down.

>
> > > @@ -727,6 +768,13 @@ static int rk808_probe(struct i2c_client *client,
> > >     if (of_property_read_bool(np, "rockchip,system-power-controller")) {
> > >             rk808_i2c_client = client;
> > >             pm_power_off = rk808_pm_power_off;
> > > +           rk808->nb = &rk808_restart_handler;
> >
> > The handler just relies on the global rk808_i2c_client anyway, so does
> > this serve any purpose?
>
> i guess
>
> ret = register_restart_handler(&rk808_restart_handler);
>
> is better here too.
>
> i cannot figure out why storing the function-pointer in rk808->nb too as this seems not to be used anywhere else

I can't remember why I set this up like this, probably "borrowed" from
another driver somewhere.
Go ahead and change it.

>
> > > +
> > > +           dev_warn(&client->dev, "register restart handler\n");
> >
> > Don't scream a warning about normal and expected operation.
>
> ack

This was to check that it was in fact registering, drop it.

>
> > Thanks,
> > Robin.
>
> @Peter, what do you think?
>
> regards Frank

Thank you for the review Robin and the submission Frank.

Always,
Peter

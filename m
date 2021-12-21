Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB8A47C9E2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 00:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238197AbhLUXvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 18:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238180AbhLUXvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 18:51:49 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682E9C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 15:51:49 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id v11so697101pfu.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 15:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tp2DnvKyLJtpECaFqmhOaYcsLjvUwB2kkdoaGVrA2uQ=;
        b=mp9H7Kq+YBT0OApPNaEJLvNvx7UhJ3CFub2MkIi6tBcZCiAT99JKijqIQFsVg3rWKa
         hsmHUYp/ylvTbWTwRXP9PUkNRqnMOQU6B7BQjTFyudkxagezOPkf9t/vkMvMxVuX9v0D
         lLRUJQ7O/QRwM7bNUzWfr+qYq9FNp+Ayic880=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tp2DnvKyLJtpECaFqmhOaYcsLjvUwB2kkdoaGVrA2uQ=;
        b=spPhUXsvhllOPUEdc4sKuBPCy7DVwgm7lE+jy5ntQA4k/VPfoy+HPE+fTR6mYbKZpB
         A5MIYrI2HDo16SaTNcrKlD8eq4ireiwb/cYefFHOs5IaJOE0R5yNNdFUH64Da8NBUjGd
         QQ7ypx/io0dwaYvGtn8Y6z3MInqlUFHdNaqjbtt2sXbf5MQNl0KTI9dPkZKirBDodcMY
         fZhWny72nspqdfxZMaWdcSDov0fJNgXyLpop1RuKBxVyMXt3QkxUiXqtZBy198X2va2Z
         YIAi+e77F+So0f2y6FqXL+uw9naf4iBWCC/H7BbxFoanU4oo7/rPgYpcZL9bQMHzDtbf
         1Krg==
X-Gm-Message-State: AOAM532+amLzaWCOrl/0ZsptxNQljud3EjvV/MLUvrFv6yvo0jRy1D2c
        +wgrjsZmTvlAA1Z7pUeYt3G2urLSDEvHXw==
X-Google-Smtp-Source: ABdhPJwdHHBGjAvNx7H9m1SsDeTQENd7Dwe797qzhkHjd5vdPs4MwaERHzWMEMkBGG2i4/dTZLPWhA==
X-Received: by 2002:a62:6184:0:b0:4a2:a063:fe8e with SMTP id v126-20020a626184000000b004a2a063fe8emr379731pfb.69.1640130708628;
        Tue, 21 Dec 2021 15:51:48 -0800 (PST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com. [209.85.216.41])
        by smtp.gmail.com with ESMTPSA id q190sm175233pgq.38.2021.12.21.15.51.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 15:51:48 -0800 (PST)
Received: by mail-pj1-f41.google.com with SMTP id z9-20020a17090a7b8900b001b13558eadaso4021817pjc.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 15:51:48 -0800 (PST)
X-Received: by 2002:a17:90a:b303:: with SMTP id d3mr842480pjr.115.1640130707643;
 Tue, 21 Dec 2021 15:51:47 -0800 (PST)
MIME-Version: 1.0
References: <20211220234346.2798027-1-rrangel@chromium.org>
 <20211220163823.1.Ie20ca47a26d3ea68124d8197b67bb1344c67f650@changeid> <7d4f20da-f18b-eccf-19c4-ea7c15492634@redhat.com>
In-Reply-To: <7d4f20da-f18b-eccf-19c4-ea7c15492634@redhat.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Tue, 21 Dec 2021 16:51:36 -0700
X-Gmail-Original-Message-ID: <CAHQZ30Czx_ZOPHBBc0yRqdcyVqrT9nxqKTpe8QZU2-fJGVs9_A@mail.gmail.com>
Message-ID: <CAHQZ30Czx_ZOPHBBc0yRqdcyVqrT9nxqKTpe8QZU2-fJGVs9_A@mail.gmail.com>
Subject: Re: [PATCH 1/3] HID: i2c-hid-acpi: Remove explicit device_set_wakeup_capable
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        mario.limonciello@amd.com, linux-input@vger.kernel.org,
        dianders@chromium.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 11:49 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 12/21/21 00:43, Raul E Rangel wrote:
> > The ACPI subsystem is responsible for managing the power and wake
> > sources for an ACPI device. By explicitly calling
> > device_set_wakeup_capable, we are circumvent the ACPI subsystem and
> > setting wake capabilities on the device when it doesn't support it.
> >
> > Take the following example:
> > * We have an ACPI HID device that has `_PR0` and `_PR3`. It doesn't have
> > `_PRW` so that means the device can't wake the system.
> > * The IRQ line is active level low for this device and is pulled up by the
> > power resource defined in `_PR0`/`_PR3`.
> >
> > Since the i2c-hid driver has set the device as wake capable, the wake
> > pin gets enabled on suspend.
>
> The IRQ pin should only have a enable_irq_wake() called on it if
> something has actually requested the i2c-HID device to be a wakeup source,
> the removed code claims the device is wakeup *capable*, but is also
> explicitly calls device_set_wakeup_enable(dev, false), disabling wakeup.
>

I thought of something else:

> And i2c-hid suspend does:
>
>         if (device_may_wakeup(&client->dev)) {
>                 wake_status = enable_irq_wake(client->irq);
>

I think we also need to guard the enable_irq_wake call with
`!ACPI_COMPANION(dev)`.
ACPI will handle enabling the correct GPIO or GPE defined in `_PRW`.

We might also be able to remove manually calling {enable,disable}_irq_wake by
switching over to `dev_pm_set_wake_irq`. I did this for the elan_i2c
driver in the 2nd patch:
https://patchwork.kernel.org/project/linux-input/patch/20211220163823.2.Id022caf53d01112188308520915798f08a33cd3e@changeid/

> And device_may_wakeup() checks the wakeup *enabled* setting AFAIK.
>
> I've added Rafael to the Cc since he knows all this a lot better then me.
>
> I have the feeling that your userspace is perhaps poking the
> wakeup settings in sysfs, triggering this issue.
>
> > As part of suspend, ACPI will power down
> > the device since it's not a wake source. When the device is powered
> > down, the IRQ line will drop, and it will trigger a wake event.
>
> To me that sounds like the device is not wakeup *capable* at all, so
> its ACPI node should not set the ACPI_FADT_LOW_POWER_S0 flag at all.
>
> Note I'm not certain about this at all, but at a first look this feels
> like it is not the right fix for your problem.
>
> Regards,
>
> Hans
>
>
> >
> > See the following debug log:
> > [   42.335804] PM: Suspending system (s2idle)
> > [   42.340186] amd_gpio AMD0030:00: RX: Setting wake for pin 89 to enable
> > [   42.467736]     power-0416 __acpi_power_off      : Power resource [PR00] turned off
> > [   42.467739] device_pm-0280 device_set_power      : Device [H05D] transitioned to D3cold
> > [   42.475210] PM: pm_system_irq_wakeup: 11 triggered pinctrl_amd
> > [   42.535293] PM: Wakeup unrelated to ACPI SCI
> > [   42.535294] PM: resume from suspend-to-idle
> >
> > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> > ---
> >
> >  drivers/hid/i2c-hid/i2c-hid-acpi.c | 5 -----
> >  1 file changed, 5 deletions(-)
> >
> > diff --git a/drivers/hid/i2c-hid/i2c-hid-acpi.c b/drivers/hid/i2c-hid/i2c-hid-acpi.c
> > index a6f0257a26de..fc311a19a19d 100644
> > --- a/drivers/hid/i2c-hid/i2c-hid-acpi.c
> > +++ b/drivers/hid/i2c-hid/i2c-hid-acpi.c
> > @@ -105,11 +105,6 @@ static int i2c_hid_acpi_probe(struct i2c_client *client)
> >
> >       acpi_device_fix_up_power(adev);
> >
> > -     if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
> > -             device_set_wakeup_capable(dev, true);
> > -             device_set_wakeup_enable(dev, false);
> > -     }
> > -
> >       return i2c_hid_core_probe(client, &ihid_acpi->ops,
> >                                 hid_descriptor_address);
> >  }
> >
>

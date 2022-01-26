Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1A249CEFB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 16:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbiAZPy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 10:54:57 -0500
Received: from mail-yb1-f169.google.com ([209.85.219.169]:43952 "EHLO
        mail-yb1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiAZPyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 10:54:54 -0500
Received: by mail-yb1-f169.google.com with SMTP id i10so53712ybt.10;
        Wed, 26 Jan 2022 07:54:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ucO1sywroR8yC1kKoTBiQwAGK1EFu2UMuTi0r7LNQIo=;
        b=fziYqRGxe2mG1ZQBaIrI4dqvqu2xaZcqoozdXk1EuSKGzLj/qG5NWyhXrKd4HE4TWP
         MdlwYrTVlp4ARgLbEkXef5Nr2VClr9jKCc5rq4docxUjFXlD3Fdnny6Z38bewzCeihyP
         njM6lo7JZpKKEKC7DKL5uy09xBLTY+7aqpFLpB3YhswjOjSV8Enzw2e0EWHtLLeqaMeQ
         zcRD4eAjHuP0his1DiotkNnZkgk9qjmQy9RMrvVJTYyUpqVjylOC29/s4DwCTLXcGeN6
         gjZMy9Sq+dOGYbf+jrXfqqMc+sAQeJTCWOiYxq0fKshTlPKK+z1kLb1Dvt5VP1IoCdaL
         SJKA==
X-Gm-Message-State: AOAM530rASM3sd1KM/4adU6LpLBYFManprB7QJUICNWEL1kmyR6yTbJq
        3dhHyWSqaMRtrI2Q+6WfVqsMyfjL6Ut3iUsvtD0=
X-Google-Smtp-Source: ABdhPJymVLAX8wg62RwdJAXxUEjDxYZbfFYeCSGaFYiOUyaot4fh9pGEqFr1JLabhRbIJtmemdXujcnWT0rb+wSx+UM=
X-Received: by 2002:a25:3793:: with SMTP id e141mr36739114yba.624.1643212494095;
 Wed, 26 Jan 2022 07:54:54 -0800 (PST)
MIME-Version: 1.0
References: <20220123091004.763775-1-ztong0001@gmail.com> <6a0233cd-d931-8a36-3b9e-08b774cec7b0@redhat.com>
In-Reply-To: <6a0233cd-d931-8a36-3b9e-08b774cec7b0@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Jan 2022 16:54:43 +0100
Message-ID: <CAJZ5v0h51v9fFrJRuaFpSn7J2UEHndEj0f3zpmw=RvgsvAhtvw@mail.gmail.com>
Subject: Re: acpi_get_devices() crash when acpi_disabled==true (was [PATCH v2]
 drm/privacy-screen: honor acpi=off in detect_thinkpad_privacy_screen)
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Tong Zhang <ztong0001@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 2:47 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi All,
>
> On 1/23/22 10:10, Tong Zhang wrote:
> > when acpi=off is provided in bootarg, kernel crash with
> >
> > [    1.252739] BUG: kernel NULL pointer dereference, address: 0000000000000018
> > [    1.258308] Call Trace:
> > [    1.258490]  ? acpi_walk_namespace+0x147/0x147
> > [    1.258770]  acpi_get_devices+0xe4/0x137
> > [    1.258921]  ? drm_core_init+0xc0/0xc0 [drm]
> > [    1.259108]  detect_thinkpad_privacy_screen+0x5e/0xa8 [drm]
> > [    1.259337]  drm_privacy_screen_lookup_init+0xe/0xe85 [drm]
> >
> > The reason is that acpi_walk_namespace expects acpi related stuff
> > initialized but in fact it wouldn't when acpi is set to off. In this case
> > we should honor acpi=off in detect_thinkpad_privacy_screen().
> >
> > Signed-off-by: Tong Zhang <ztong0001@gmail.com>
>
> Thank you for catching this and thank you for your patch. I was about to merge
> this, but then I realized that this might not be the best way to fix this.
>
> A quick grep shows 10 acpi_get_devices() calls outside of drivers/acpi,
> and at a first glance about half of those are missing an acpi_disabled
> check. IMHO it would be better to simply add an acpi_disabled check to
> acpi_get_devices() itself.
>
> Rafael, do you agree ?

Yes, I do.

> Note the just added chrome privacy-screen check uses
> acpi_dev_present(), this is also used in about 10 places outside
> of drivers/acpi and AFAIK none of those do an acpi_disabled check.
>
> acpi_dev_present() uses bus_find_device(&acpi_bus_type, ...)
> but the acpi_bus_type does not get registered when acpi_disabled
> is set. In the end this is fine though since bus_find_device
> checks for the bus not being registered and then just returns
> NULL.

Right.

> > ---
> > v2: fix typo in previous commit -- my keyboard is eating letters
> >
> >  drivers/gpu/drm/drm_privacy_screen_x86.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_privacy_screen_x86.c b/drivers/gpu/drm/drm_privacy_screen_x86.c
> > index a2cafb294ca6..e7aa74ad0b24 100644
> > --- a/drivers/gpu/drm/drm_privacy_screen_x86.c
> > +++ b/drivers/gpu/drm/drm_privacy_screen_x86.c
> > @@ -33,6 +33,9 @@ static bool __init detect_thinkpad_privacy_screen(void)
> >       unsigned long long output;
> >       acpi_status status;
> >
> > +     if (acpi_disabled)
> > +             return false;
> > +
> >       /* Get embedded-controller handle */
> >       status = acpi_get_devices("PNP0C09", acpi_set_handle, NULL, &ec_handle);
> >       if (ACPI_FAILURE(status) || !ec_handle)
>

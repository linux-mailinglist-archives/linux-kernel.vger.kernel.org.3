Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFED4A61E9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241438AbiBARGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241434AbiBARGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:06:46 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC2EC061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 09:06:45 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id m9so34493567oia.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 09:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RdQTcqQ9Qr4h0L2NlLlM99qGIKmmmXyVpgAfVQlyXvw=;
        b=aBXJGsBy39GcwPGw1gQwRkkKV6thDHpcyarDrmkoubQM6M8m7KheFYLmVcR/iba2MT
         ++t5VYXBHifuxfZgt0rPdm2eEQIi4to/6t4QII6YDcjxIphQkcY9ydqlzF1HGNKaSs9V
         IvfM1MNQmBgOqUNJRefzdJIahGbbWzxTo2tEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RdQTcqQ9Qr4h0L2NlLlM99qGIKmmmXyVpgAfVQlyXvw=;
        b=u2CbEYxl9ZpNbGvYMaDDR20aicM8TQ2kGNAemwuNcdNLs+UyVgvrKYilmyogogRdP7
         xQ9xhLNmYzZCV9OgDKkTQZm3ieS41ZkLvuRZcwjYNIB8V4XwVVRjdM+vvFmP4OmOiJMa
         XQ39oP5kxf5Eu5xb1XLpVnsnHMAozAbiVwIzFyFTFZfS0M4KMJ+pRFPevgjQ8re8N1jH
         yuARQlLsLnsvwTQi5E1Aj2Bab8FLd2DT/DiTRoq1Vupkv+4Vbi4Sw/uBqhoCGqca7umm
         bFRpyF//fvP4TbTdmy+e5CWN2ugFxu7GACTJDptgI4A+qzNuN36VJKv6HiqEgBWiinfr
         8KYw==
X-Gm-Message-State: AOAM531SIcKmeeKZk6S3AA/T6oJV7ZqT6fmdCozwYmsX8DXJMen1w9cS
        qYIh9xLXq6E14c7EeU/qN2Xe+ZFqPlnnpyyhH0k5pQ==
X-Google-Smtp-Source: ABdhPJxmJTT10BhmESxaD9wSsaXi2TyqjKpx8TF/TQp9so++NA/uk65aK3wvzaI2XbQCX3/1SL7QYNE/AkpMguwVMkA=
X-Received: by 2002:a05:6808:1641:: with SMTP id az1mr1928959oib.278.1643735204982;
 Tue, 01 Feb 2022 09:06:44 -0800 (PST)
MIME-Version: 1.0
References: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
 <20220125202118.63362-2-andriy.shevchenko@linux.intel.com>
 <YfEG2qVO9K9G+g1d@kroah.com> <CAKMK7uGoRC9a4cMCADTipV67oivfWvTw=6RYm2kOthB_bhWnXQ@mail.gmail.com>
 <f671a112-880d-1526-a395-360947b40c5a@gmx.de> <YfEv7OQs98O9wJdJ@kroah.com>
 <YfFIpBb7lL4ukWjm@smile.fi.intel.com> <b8eb7111-43aa-cc8a-a1bc-f08e0f2987ed@redhat.com>
 <YfFV4EJosayH+e6C@smile.fi.intel.com> <YfFWPmG2D093gz4N@smile.fi.intel.com>
 <6e74d4cc-655a-e38e-0856-a59e4e6deb36@redhat.com> <c423a2f0-e7be-3884-3568-7629c7e9104e@redhat.com>
 <ddb0f354-be19-92fe-20b3-56b00c9304ab@suse.de> <840ec74d-60c6-9480-709c-8cd597c6f5b0@redhat.com>
 <e7fbef3c-2f87-15f9-b24d-34ffaa5a2853@suse.de> <CAMuHMdXnn+JcyMAV_Vbb4Yj8hJmae=Snc2R2fLviq67UYXg7Ew@mail.gmail.com>
In-Reply-To: <CAMuHMdXnn+JcyMAV_Vbb4Yj8hJmae=Snc2R2fLviq67UYXg7Ew@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 1 Feb 2022 18:06:33 +0100
Message-ID: <CAKMK7uEPuw1+-=h7gvSyCxW4zNuTK3UNZP6yjpP6MPV17sAasQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] fbtft: Unorphan the driver
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andy@kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>, linux-staging@lists.linux.dev,
        Javier Martinez Canillas <javierm@redhat.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Carlis <zhangxuezhi1@yulong.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 6:01 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Thomas,
>
> On Tue, Feb 1, 2022 at 5:16 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> > Am 31.01.22 um 11:18 schrieb Javier Martinez Canillas:
> > > Another thing that's missing is a DRM_MODE_CONNECTOR_I2C, because I used for
> > > now a DRM_MODE_CONNECTOR_Unknown.
> >
> > That might have implications on userspace. Maybe ask around. (Not that
> > we actually run userspace on the device).
>
> Looking at the list of connector types (and wondering if we're gonna
> need more when converting existing fbdev drivers to drm drivers),
> there seem to be two different families of connector types, for
>   1. transports between CRTC and display (e.g. VGA, DVID, HDMI),
>   2. transports between CPU and CRTC (e.g. SPI, possibly USB, and
>      the proposed I2C)?

I was trying to argue for a panel connector type and stop doing all
these internal things because like you point out, it kinda doesn't,
only the external connectors are relevant to users. But it didn't
stick anywhere yet, we keep adding more connector types and then
having to update userspace, which should map these all to "it's the
panel" or something like that. But also since various technicolor
abbreviations are about as useful to end-users as "unknown" it really
doesn't matter, so I'm happy to let this bikeshed get a tad fancier
every year :-)
-Daniel

> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

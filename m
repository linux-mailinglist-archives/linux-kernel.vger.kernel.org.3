Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9AC4AF406
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 15:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbiBIO1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 09:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbiBIO1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:27:32 -0500
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82868C06157B;
        Wed,  9 Feb 2022 06:27:35 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id t184so2711168vst.13;
        Wed, 09 Feb 2022 06:27:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gJXDOrB/jL/yycfpf2+OsoUzWbEp18SJyGOgWCPyYcE=;
        b=MOq/Qqoi8DES3gvorx1q+TNrBEA4wtTG5efPVyO4kwlfjmaXV6j0JN9Br6EeF1JlFI
         e2fQ4KRDs1VXcxhG4+saKqt+ER9ADp9wydoOnGOxbg/3+5cxKh/TpqT/0LCYFGdUbfua
         B+2uPMGBKfWlpSLxFd0qsoPj8g6tzj5jtYGHRu17HQDuKkX9LAmdHHd7JWHqFt/2/QEb
         hpDojb5uz8c3hE257wXssDNxXgA0IvRxhMVKTIjbWxmIcho439HYd2jQqskuhUXuDjOv
         VngKZ4+HHuqDiWrneIEwGWmx1/tMkbcqxSJp0ens6zWv5DE/GkWwaCu/OE2UHlgD4Mtv
         9v0Q==
X-Gm-Message-State: AOAM530VmaonHtZHB6yKSnLabhHZwe0NqOUci+q/hQK0b3KNYUULkLB2
        d96sGtS/MsDTnW9OOZ9dv/AOPP0HjDn0Dw==
X-Google-Smtp-Source: ABdhPJxIvUPGH7t7A+4WN58FkKE3HSz16bb+/N3+1ptTMbGaZUJ9XB4fIVz8/sRW/aR5stwXnkwr2w==
X-Received: by 2002:a05:6102:a4f:: with SMTP id i15mr771596vss.17.1644416854412;
        Wed, 09 Feb 2022 06:27:34 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id g20sm1969052vkq.46.2022.02.09.06.27.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 06:27:33 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id v5so1388142uam.3;
        Wed, 09 Feb 2022 06:27:33 -0800 (PST)
X-Received: by 2002:ab0:384c:: with SMTP id h12mr813487uaw.122.1644416853482;
 Wed, 09 Feb 2022 06:27:33 -0800 (PST)
MIME-Version: 1.0
References: <20220204134347.1187749-1-javierm@redhat.com> <CAMuHMdVTVX7LFay-rfv=oW96dMA24duMUVGRE62jQSNkrKtyMg@mail.gmail.com>
 <f178de92-7cb1-dcc5-1f60-9ccfc56bc0a4@redhat.com> <YgPF1cBMsd9973Dx@smile.fi.intel.com>
In-Reply-To: <YgPF1cBMsd9973Dx@smile.fi.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Feb 2022 15:27:22 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXQdL_Do8Hjay1egfmd9H05R7BjNeKfLGq67mU4bQNVZA@mail.gmail.com>
Message-ID: <CAMuHMdXQdL_Do8Hjay1egfmd9H05R7BjNeKfLGq67mU4bQNVZA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED displays
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Wed, Feb 9, 2022 at 2:48 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Tue, Feb 08, 2022 at 04:10:49PM +0100, Javier Martinez Canillas wrote:
> > On 2/8/22 15:19, Geert Uytterhoeven wrote:
> > > On Fri, Feb 4, 2022 at 2:43 PM Javier Martinez Canillas
> > > <javierm@redhat.com> wrote:
> > >   - Kernel size increased by 349 KiB,
> > >   - The "Memory:" line reports 412 KiB less memory,
> > >   - On top of that, "free" shows ca. 92 KiB more memory in use after
> > >     bootup.
>
> The memory consumption should really be taken seriously, because these kind of
> displays are for embedded platforms with limited amount of resources.

Thanks for your concern!

Looking at the options that are auto-enabled, a few stand out that
look like they're not needed on systems witch such small displays,
or on legacy systems predating DDC:

    menuconfig DRM
            tristate "Direct Rendering Manager (XFree86 4.1.0 and
higher DRI support)"
            depends on (AGP || AGP=n) && !EMULATED_CMPXCHG && HAS_DMA
            select DRM_NOMODESET
            select DRM_PANEL_ORIENTATION_QUIRKS
            select HDMI

Not everyone pays HDMI royalties ;-)

            select FB_CMDLINE
            select I2C
            select I2C_ALGOBIT

I do need I2C, as it's the transport for my SSD1306 display, but not
everyone needs it.

            select DMA_SHARED_BUFFER
            select SYNC_FILE
    # gallium uses SYS_kcmp for os_same_file_description() to de-duplicate
    # device and dmabuf fd. Let's make sure that is available for our userspace.
            select KCMP

And:

    config DRM_BRIDGE
            def_bool y
            depends on DRM
            help
              Bridge registration and lookup framework.

    config DRM_PANEL_BRIDGE
            def_bool y


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

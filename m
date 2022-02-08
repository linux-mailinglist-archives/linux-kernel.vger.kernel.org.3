Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25134ADC7E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380042AbiBHPXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351682AbiBHPXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:23:43 -0500
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6469C061576;
        Tue,  8 Feb 2022 07:23:42 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id d22so6932947uaw.2;
        Tue, 08 Feb 2022 07:23:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LZ7CP5kqwUe/zKlKUAI4I0ax7qbE+g2pzH6adwlgoSo=;
        b=1zESSamYy0VUnQrYoCCM1iwZHdpnERjYq2AjbYcTrWzgiPcyO03lA4buDiIEagmpKo
         Ipp7dWimZdScsyt+N/0pQ8ejX/K/CCuimVYUIKSmXK2J3v/6mtjJ8ZcQ+Qv7zNcHUHGV
         N1wzr0smHb8v260QUASqVWEuxI70hgBrqNaR3M+/G4qe/yWqGxj26NBbNF1pD1ivSWuI
         xMhYo+zSBsxighLLEMGwexo49v/RlHe2hNMhL6mCGyd+EF5re3m/njmtqt2IJ2s62C58
         YEC/sYKDXWkchagcJAoW0/uqVeuTeH0Jf12KC2RrGOOJGCF7G3wpqXeaAZ85tve8Zl2x
         FkYA==
X-Gm-Message-State: AOAM531tBlOmLwG3yi0BgqJWkliraWvYvImhHZIEdodc8hy/VbLMvoYr
        2xxFi47B0Ez5PNofWHrF4n1dD6AjQPO03g==
X-Google-Smtp-Source: ABdhPJyzfZmyaqtO/I3rmFIPPUzNcb1vWNVlL0NEKCwiPeB9S96CWQC8OAqvt18JN2w0nnhxUaZrEA==
X-Received: by 2002:ab0:36b3:: with SMTP id v19mr1666390uat.101.1644333821629;
        Tue, 08 Feb 2022 07:23:41 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id h22sm2970642vsj.0.2022.02.08.07.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 07:23:41 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id m24so3755191vsp.7;
        Tue, 08 Feb 2022 07:23:41 -0800 (PST)
X-Received: by 2002:a05:6102:34d9:: with SMTP id a25mr334951vst.68.1644333820869;
 Tue, 08 Feb 2022 07:23:40 -0800 (PST)
MIME-Version: 1.0
References: <20220204134347.1187749-1-javierm@redhat.com> <CAMuHMdVTVX7LFay-rfv=oW96dMA24duMUVGRE62jQSNkrKtyMg@mail.gmail.com>
 <f178de92-7cb1-dcc5-1f60-9ccfc56bc0a4@redhat.com>
In-Reply-To: <f178de92-7cb1-dcc5-1f60-9ccfc56bc0a4@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Feb 2022 16:23:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWvrJip+W6ZZoO2ZURLc5CYmFno3=Sa2mL4xJE8gMzFqg@mail.gmail.com>
Message-ID: <CAMuHMdWvrJip+W6ZZoO2ZURLc5CYmFno3=Sa2mL4xJE8gMzFqg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED displays
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
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
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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

Hi Javier,

On Tue, Feb 8, 2022 at 4:10 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> On 2/8/22 15:19, Geert Uytterhoeven wrote:
> > On Fri, Feb 4, 2022 at 2:43 PM Javier Martinez Canillas
> > <javierm@redhat.com> wrote:
> >> This patch series adds a DRM driver for the Solomon OLED SSD1305, SSD1306,
> >> SSD1307 and SSD1309 displays. It is a port of the ssd1307fb fbdev driver.
> >
> > I gave it a try on an Adafruit FeatherWing 128x32 OLED, connected to an
> > OrangeCrab ECP5 FPGA board running a 64 MHz VexRiscv RISC-V softcore.
> >
> > Findings:
> >   - Kernel size increased by 349 KiB,
> >   - The "Memory:" line reports 412 KiB less memory,
> >   - On top of that, "free" shows ca. 92 KiB more memory in use after
> >     bootup.
> >   - The logo (I have a custom monochrome logo enabled) is no longer shown.
>
> I was able to display your tux monochrome with ./fbtest -f /dev/fb1 test004

I meant the kernel's logo (FB_LOGO_*),. Obviously you need to enable
a smaller one, as the default 80x80 logo is too large, and thus can't
be drawn on your 128x64 or my 128x32 display.

> >   - The screen is empty, with a (very very slow) flashing cursor in the
> >     middle of the screen, with a bogus long line next to it, which I can
> >     see being redrawn.
> >   - Writing text (e.g. hello) to /dev/tty0, I first see the text,
> >     followed by an enlargement of some of the characters.
>
> So far I was mostly testing using your fbtest repo tests and all of them
> (modulo test009 that says "Screen size too small for this test").
>
> But I've tried now using as a VT and I see the same visual artifacts. I
> wonder what's the difference between fbcon and the way your tests use
> the fbdev API.

Fbcon does small writes to the shadow frame buffer, while fbtest
writes to the mmap()ed /dev/fbX, causing a full page to be updated.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

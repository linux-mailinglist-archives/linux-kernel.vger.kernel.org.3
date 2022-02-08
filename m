Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D294ADB0C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 15:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378024AbiBHOUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 09:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351022AbiBHOUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 09:20:12 -0500
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA71CC03FECE;
        Tue,  8 Feb 2022 06:20:11 -0800 (PST)
Received: by mail-vk1-f177.google.com with SMTP id v192so9856109vkv.4;
        Tue, 08 Feb 2022 06:20:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tWsUC/Af6ywp4UcAlxa6QvBdBkZWz95sQEwSbu3EUOM=;
        b=qviQxYjbeOWp0843ZcdnIo+y4ui8xr8+d5RFlZ4vO9LqvLY7aNgrAEuF0Pu9k2+LkX
         aVMNog5c/XBMA2IEu32h8mknAoBQucFoDgXUg5eVqbp7hCbR5bgt66RiwwiHwQFs6xkn
         ESSp/noBgZdE0QMgCCxyo4SS5JlmEoK3Fikbqji4pwLqS+Ddlwy1EnweXmJFMOp2jJK3
         s9/AvTEv0mlxt+42A2Juqg6N1el6fQ89rDnsXIk5gu1ri04Jg2UaDmJhUQntEa0tIzsu
         cBq+y2sSVZtwEL1S9LuhFmFO2rMBvbkLOHbINI7oK3MtUyf6MRY1xYTfT8C6i/k1LttM
         fQhw==
X-Gm-Message-State: AOAM532ARZjYISPgZ5mHK75hvuuNW2UBWe3ooav1uLWrcI7nL3HwwFEf
        XkdYHv7OAYnh3VMzNPWvq5m/QGItcX04uw==
X-Google-Smtp-Source: ABdhPJwNVJpS74KdYjuNT/DdBWlEgfiEbsLZQCTpCOvWFLt0cuyphOK9myV6EqAiLwQhdzAsX2qn7g==
X-Received: by 2002:a05:6122:17a5:: with SMTP id o37mr1656708vkf.25.1644330010672;
        Tue, 08 Feb 2022 06:20:10 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id g22sm2823278vsk.26.2022.02.08.06.20.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 06:20:09 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id a19so3513768vsi.2;
        Tue, 08 Feb 2022 06:20:09 -0800 (PST)
X-Received: by 2002:a05:6102:34d9:: with SMTP id a25mr223540vst.68.1644330009205;
 Tue, 08 Feb 2022 06:20:09 -0800 (PST)
MIME-Version: 1.0
References: <20220204134347.1187749-1-javierm@redhat.com>
In-Reply-To: <20220204134347.1187749-1-javierm@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Feb 2022 15:19:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVTVX7LFay-rfv=oW96dMA24duMUVGRE62jQSNkrKtyMg@mail.gmail.com>
Message-ID: <CAMuHMdVTVX7LFay-rfv=oW96dMA24duMUVGRE62jQSNkrKtyMg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED displays
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>
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

On Fri, Feb 4, 2022 at 2:43 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> This patch series adds a DRM driver for the Solomon OLED SSD1305, SSD1306,
> SSD1307 and SSD1309 displays. It is a port of the ssd1307fb fbdev driver.

I gave it a try on an Adafruit FeatherWing 128x32 OLED, connected to an
OrangeCrab ECP5 FPGA board running a 64 MHz VexRiscv RISC-V softcore.

Findings:
  - Kernel size increased by 349 KiB,
  - The "Memory:" line reports 412 KiB less memory,
  - On top of that, "free" shows ca. 92 KiB more memory in use after
    bootup.
  - The logo (I have a custom monochrome logo enabled) is no longer shown.
  - The screen is empty, with a (very very slow) flashing cursor in the
    middle of the screen, with a bogus long line next to it, which I can
    see being redrawn.
  - Writing text (e.g. hello) to /dev/tty0, I first see the text,
    followed by an enlargement of some of the characters.
  - "time ls" on the serial console (no files in the current directory,
    so nothing to print) increases from 0.86s to 1.92s, so the system is
    more loaded.  As ssd1307fb relied on deferred I/O too, the slowdown
    might be (partly) due to redrawing of the visual artefacts
    mentioned above.

So while the displays seems to be initialized correctly, it looks like
there are some serious bugs in the conversion from xrgb8888 to
monochrome.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

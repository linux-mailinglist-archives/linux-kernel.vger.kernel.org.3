Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F5C4A58BA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 09:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbiBAIoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 03:44:20 -0500
Received: from mail-vs1-f49.google.com ([209.85.217.49]:40806 "EHLO
        mail-vs1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235792AbiBAIoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 03:44:04 -0500
Received: by mail-vs1-f49.google.com with SMTP id g23so15132528vsf.7;
        Tue, 01 Feb 2022 00:44:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=raT8Y/Y+3uKWPsdtZjNjvpSo+gn1Wm+Os229uVdckR0=;
        b=7qkMOrBhM3geLvg4FRhArosAP6YdRd1YeKT3qFFsYC1kjlsLa6rFgUUt+Vqwou7YQb
         CzwdMbhEcRMv9XVM+DC6O2tTuW970AU0HYb0yyOhkAaRglWJTWFxxeyr2waPLDg4knh7
         9yQh2oU0MNIcYtAz5F2mksY2/91OHEAUaOMYVVk4/VcOc/i0gPPoTwXMvtAULU48UcFs
         zH0PukTwE859SZSSEqBxVfEinNeh2c8opqyErVLMlVb0W9AoJjyS5iCxgC7enwIkx2vE
         4vb2yYGQfgZ1vDLi7x93PIFKoHazk8P+AgpPZK0aO/bM1gyWH91kXmLkHCjwH5yzYspr
         zo6Q==
X-Gm-Message-State: AOAM530xUnZ4/RuJu3Il0qIPdVim8D5AKSL6eIXhKP/o/pqlHFwJvrhP
        o7ZCD69ARq3qubyPjBAZStvjmSi9hocfSw==
X-Google-Smtp-Source: ABdhPJxNV8EM4hWf7/DxTFP/+xk0PZwkvwJMEZlme2nAg38dwxCggIhiaok8d2c0oL0XWBNQokmtgw==
X-Received: by 2002:a67:ec4c:: with SMTP id z12mr9987220vso.41.1643705043184;
        Tue, 01 Feb 2022 00:44:03 -0800 (PST)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id q69sm4570447vka.21.2022.02.01.00.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 00:44:02 -0800 (PST)
Received: by mail-vk1-f173.google.com with SMTP id v192so9960248vkv.4;
        Tue, 01 Feb 2022 00:44:01 -0800 (PST)
X-Received: by 2002:a1f:5d84:: with SMTP id r126mr9423475vkb.33.1643705041310;
 Tue, 01 Feb 2022 00:44:01 -0800 (PST)
MIME-Version: 1.0
References: <20220131201225.2324984-1-javierm@redhat.com>
In-Reply-To: <20220131201225.2324984-1-javierm@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Feb 2022 09:43:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXMayLLRavAJJujmPqT+Vd11dPfycqXie3w_pOkS8i9eA@mail.gmail.com>
Message-ID: <CAMuHMdXMayLLRavAJJujmPqT+Vd11dPfycqXie3w_pOkS8i9eA@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED displays
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux PWM List <linux-pwm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Mon, Jan 31, 2022 at 9:12 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> This patch series adds a DRM driver for the Solomon OLED SSD1305, SSD1306,
> SSD1307 and SSD1309 displays. It is a port of the ssd1307fb fbdev driver.

Thanks for your series!

I'll give it a try on an Adafruit FeatherWing 128x32 OLED, connected
to an OrangeCrab ECP5 FPGA board running a 64 MHz VexRiscv RISC-V
softcore.

> Using the DRM fb emulation, all the tests from Geert Uytterhoeven's fbtest
> (https://git.kernel.org/pub/scm/linux/kernel/git/geert/fbtest.git) passes:
>
>      ./fbtest -f /dev/fb1
>     Using drawops cfb32 (32 bpp packed pixels)
>     Available visuals:
>       Monochrome
>       Grayscale 256
>       Truecolor 8:8:8:0

Oh, fake 32-bpp truecolor ;-)

Does it run modetest, too?

I'm trying to get modetest working on my atari DRM driver.
Comparing to the cirrus driver doesn't help much, as modetest doesn't
seem to work with the cirrus driver (modified to not do hardware
access, as I don't have cirrus hardware):

    # modetest -M cirrus -s 31:1024x768-60Hz
    setting mode 1024x768-60.00Hz on connectors 31, crtc 34
    failed to set gamma: Function not implemented

Does there exist another simple test program for showing something
using the DRM API?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

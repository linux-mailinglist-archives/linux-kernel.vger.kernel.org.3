Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B394A9B06
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 15:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359331AbiBDObu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 09:31:50 -0500
Received: from mail-ua1-f41.google.com ([209.85.222.41]:37758 "EHLO
        mail-ua1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343911AbiBDObs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 09:31:48 -0500
Received: by mail-ua1-f41.google.com with SMTP id b16so11144137uaq.4;
        Fri, 04 Feb 2022 06:31:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aVjVsdLr/YeumyNFWKCtu2VuB2Qk2ba3Q9UmWUGtgwc=;
        b=a8qv1Ms1wO89gt9oAk61jaLCI1Xm9FwQYG0j3cRMIXTDskuviw2xYc+Z7y4GkWe1g4
         mH9jEH5h9KxA0xq6Jxz9UXa370MCwOCyCW7ojycut5bgrXMolT/p1LB698pWNg/osg/f
         pM7Nw4aynOOylwcJg/FCuLsMEVLcxjjHz48CbFyOcw3XEg2JikfBh2l3ufho9+y7F/fB
         9sjyXbYbKL9DTpq1W07ppybKCuA9eUc39sQAve4uoZHDd4A3/Xrx5mMUvwXMIuBXQ88N
         J7nSLpm7Z6rqSRGHGiKK5kz2FcM8c/kh5nBoQAztfmLfIhrI12xXgbgNFkhX8YXUZw7x
         bTjA==
X-Gm-Message-State: AOAM531LBGN3GShbH8Ub0hu/cUYBgjjQ9LrMCy9knI2j65bs1ZvxkHvb
        Mlfu/rUkdrf3FpUIRnwkd2eTe6jc9/Q5/g==
X-Google-Smtp-Source: ABdhPJxwLos4c8K6jyKkNtYiUrr0ity7E6S0V3cAArRKHASIGJJr1Vm319LfD2BfGG2H9VCkSd+32w==
X-Received: by 2002:ab0:2786:: with SMTP id t6mr985319uap.75.1643985107824;
        Fri, 04 Feb 2022 06:31:47 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id y18sm570947ual.15.2022.02.04.06.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 06:31:46 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id b16so11144008uaq.4;
        Fri, 04 Feb 2022 06:31:46 -0800 (PST)
X-Received: by 2002:a67:c198:: with SMTP id h24mr922470vsj.5.1643985106337;
 Fri, 04 Feb 2022 06:31:46 -0800 (PST)
MIME-Version: 1.0
References: <20220204134347.1187749-1-javierm@redhat.com>
In-Reply-To: <20220204134347.1187749-1-javierm@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 4 Feb 2022 15:31:35 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWoBc8amsg009oQGqUST8bN=8WqPM96SkUzcv=P1uRbfA@mail.gmail.com>
Message-ID: <CAMuHMdWoBc8amsg009oQGqUST8bN=8WqPM96SkUzcv=P1uRbfA@mail.gmail.com>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Fri, Feb 4, 2022 at 2:43 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> This patch series adds a DRM driver for the Solomon OLED SSD1305, SSD1306,
> SSD1307 and SSD1309 displays. It is a port of the ssd1307fb fbdev driver.

[...]

> This is a v2 that addresses all the issues pointed in v1, thanks a lot
> to everyone that gave me feedback and reviews. I tried to not miss any
> comment, but there were a lot so forgive me if something is not there.

Thanks for the update!

> Changes in v2:

[...]

Note that the individual patches say "(no changes since v1)"?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

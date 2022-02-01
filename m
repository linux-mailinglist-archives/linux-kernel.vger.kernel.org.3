Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA36B4A5B67
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 12:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237400AbiBALqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 06:46:44 -0500
Received: from mail-qv1-f47.google.com ([209.85.219.47]:43892 "EHLO
        mail-qv1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237374AbiBALqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 06:46:43 -0500
Received: by mail-qv1-f47.google.com with SMTP id h16so15659345qvk.10;
        Tue, 01 Feb 2022 03:46:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mA8XYa2O0+UEsBGkXuHhOFnWvI6ZRmcsG3sID3xO/+M=;
        b=oKY1u04v+4KghX/nT+POHwIpi+2m062T38+Aak9lAkN5DGqRxxKp+NVWowboBqEZjm
         G6yNTY1jxrz0cv4X8tgsAqhqd3kcaY5PahohNlkrRN/+BHAyKxO8GgQqGKBIT1K8LFP1
         W0DrAae8p0OnInQF+exgms4EK1mwxeO31+iQDSU0JE1cLK3KBsS8TZyxwLHKFh8LNu81
         Jbes/RTURmB77N13zaO12mMEvtuqbrsMJfRJL0q/v4Fqrnu4eZiDW1VAJIKQSy1olpBd
         DxruF2ZQMfAXPg5aIL0LfTtPmjumhKmjL2TbwDKjMOdcYYzJ13w5rQwxXW0gwSnAfV/H
         nEvw==
X-Gm-Message-State: AOAM533rD8NtkZ0RDt9DYxGRmSvp7G92ao9GfxcC9nD7XRnGzEdkJTjV
        2u/XqZMG6FHW8mQhvFvi0jU/+ptlkITo5m78
X-Google-Smtp-Source: ABdhPJyOoV7t/GPm1BjaYai6hQpagzBmaMcAG+xanK6dcOfDlvuN1bsEZBMdVPdamIWr96jZDg2YIg==
X-Received: by 2002:a05:6214:240c:: with SMTP id fv12mr15457823qvb.40.1643716002181;
        Tue, 01 Feb 2022 03:46:42 -0800 (PST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com. [209.85.219.54])
        by smtp.gmail.com with ESMTPSA id n19sm2314364qkp.52.2022.02.01.03.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 03:46:42 -0800 (PST)
Received: by mail-qv1-f54.google.com with SMTP id i19so15673402qvx.12;
        Tue, 01 Feb 2022 03:46:42 -0800 (PST)
X-Received: by 2002:a1f:b287:: with SMTP id b129mr10219823vkf.20.1643715544741;
 Tue, 01 Feb 2022 03:39:04 -0800 (PST)
MIME-Version: 1.0
References: <20220131201225.2324984-1-javierm@redhat.com> <YfhM97cVH3+lJKg0@ravnborg.org>
 <Yfj/XGRRDNABsLPm@smile.fi.intel.com> <f8d71acb-5c8b-ac4e-0c32-38eb66af04c3@redhat.com>
In-Reply-To: <f8d71acb-5c8b-ac4e-0c32-38eb66af04c3@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Feb 2022 12:38:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVP6ER119r2KAegjZes1a=KWZ47z6j=kgQ0oNx1oeUJ+w@mail.gmail.com>
Message-ID: <CAMuHMdVP6ER119r2KAegjZes1a=KWZ47z6j=kgQ0oNx1oeUJ+w@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED displays
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Mark Brown <broonie@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Tue, Feb 1, 2022 at 12:31 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> On 2/1/22 10:37, Andy Shevchenko wrote:
> > On Mon, Jan 31, 2022 at 09:56:23PM +0100, Sam Ravnborg wrote:
> >> On Mon, Jan 31, 2022 at 09:12:20PM +0100, Javier Martinez Canillas wrote:
> >
> > ...
> >
> >>> Patch #3 adds the driver. The name ssd1307 was used instead of ssd130x
> >>> (which would be more accurate) to avoid confusion for users who want to
> >>> migrate from the existing ssd1307fb fbdev driver.
> >> Looking forward the name ssd130x would make more sense. There is only so
> >> many existing users and a potential of much more new users.
> >> So in my color of the world the naming that benefits the most users
> >> wins.
> >
> > It depends if the binding is going to be preserved. Also this series doesn't
> > answer to the question what to do with the old driver.
> >
>
> I don't plan to remove the old driver (yet). My goal here is to have an answer
> for Fedora users that might complain that we disabled all the fbdev drivers.
>
> So I wanted to understand the effort involved in porting a fbdev driver to DRM.
>
> > If you leave it, I would expect the backward compatibility, otherwise the
> > series misses removal of the old driver.
> >
>
> I don't see how those two are correlated. You just need different compatible
> strings to match the new and old drivers. That what was usually done for DRM
> drivers that were ported. To give an example, the "omapfb" vs "omapdrm".
>
> Since the current binding has a compatible "ssd1305fb-i2c", we could make the
> new one "ssd1305drm-i2c" or better, just "ssd1305-i2c".

DT describes hardware, not software policy.
If the hardware is the same, the DT bindings should stay the same.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

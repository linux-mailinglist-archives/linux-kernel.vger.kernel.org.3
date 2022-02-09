Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461054AF67E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbiBIQZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236774AbiBIQZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:25:12 -0500
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E9DC05CB82;
        Wed,  9 Feb 2022 08:25:15 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id g15so1558701uap.11;
        Wed, 09 Feb 2022 08:25:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4GuniAOq5DbLNh++mRg7r5HcnQnN5dB0Mrzttjolx/0=;
        b=DLUVVYw9rAa7M/y8Zeadbrju1H/My6Sp1nZnNoTZTw3/GkreBT5pT7vuge0xZuMCwv
         uRBkXyNtXrQtr76qDkiSyzXNUvTLpwW+ROmdixHhJpa0VArUWgNI+lm+2thnhAZ050Wa
         HUCnjHdCr8BhB2UzDwk4EcuZUtu/QXOf2IGTPomMsdFMsQBIl7X72sk6L8GCrO/Oo5Za
         bYT+/drGBRCu7EA38zmI58SyL+u/h2QGMmA4ZpcMIZvPEGb4GrtlPqmxQ5S/zlNVa3TN
         s6efhkzcPe7ypJYfqwPt8jXNKzktGkuh5ZgKOGSvzHR55/dXc0F9CP1/TDCdR4RJHiTp
         jEGQ==
X-Gm-Message-State: AOAM530wTgkqS32B2D1ou82x1QE6sFFS6+HqoHpdqTr4m1FUWQjvXq9s
        lCREI8F2cBmHXDYo0RgGweILu95kF9X1oQ==
X-Google-Smtp-Source: ABdhPJyPtktnKBBHEaxKmYoTEwof2ceVdOC/QpUDrPDGB5n3cWmO7NVqj4aD1qZYT+EaaHjzhr2tXg==
X-Received: by 2002:a9f:2067:: with SMTP id 94mr997452uam.26.1644423914577;
        Wed, 09 Feb 2022 08:25:14 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id x18sm3394315vsj.20.2022.02.09.08.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 08:25:14 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id u17so3191898vsg.8;
        Wed, 09 Feb 2022 08:25:14 -0800 (PST)
X-Received: by 2002:a67:a401:: with SMTP id n1mr920976vse.38.1644423914101;
 Wed, 09 Feb 2022 08:25:14 -0800 (PST)
MIME-Version: 1.0
References: <20220209090314.2511959-1-javierm@redhat.com> <20220209091204.2513437-1-javierm@redhat.com>
 <CAMuHMdWSDBjpYJv6JtgvyaKiFKh_eqbvH78TR6VBtpDeFJvqFQ@mail.gmail.com>
 <YgPbAL0I8Wn7nnNb@smile.fi.intel.com> <d32c731b-c06f-2dcb-5a6d-1a84351719b2@redhat.com>
In-Reply-To: <d32c731b-c06f-2dcb-5a6d-1a84351719b2@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Feb 2022 17:25:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXsAyp18ivtSe-ZVmu6xbBBnvjMuZ=H1w9Gk=Ys4rkCeg@mail.gmail.com>
Message-ID: <CAMuHMdXsAyp18ivtSe-ZVmu6xbBBnvjMuZ=H1w9Gk=Ys4rkCeg@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] (WIP) drm/solomon: Add SSD130X OLED displays SPI support
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
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

On Wed, Feb 9, 2022 at 5:07 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> On 2/9/22 16:17, Andy Shevchenko wrote:
> > On Wed, Feb 09, 2022 at 01:25:46PM +0100, Geert Uytterhoeven wrote:
> >> On Wed, Feb 9, 2022 at 10:12 AM Javier Martinez Canillas
> >> <javierm@redhat.com> wrote:
> >
> > ...
> >
> >>> +               .compatible = "solomon,ssd1305fb-spi",
> >>
> >> This needs an update to the DT bindings.
> >> Hence this may be a good time to deprecate the existing
> >> "solomon,ssd130*fb-i2c" compatible values, and switch to
> >> "solomon,ssd130*fb" instead, for both I2C and SPI.
> >
> > Agree!
> >
>
> Did you see my comment about automatic module loading ? I think
> that would be an issue if we use the same compatible for both
> I2C and SPI drivers.

We have several drivers that have a core and separate i2c and spi
wrappers, see e.g.

$ git grep -w ltc2947_of_match
drivers/hwmon/ltc2947-core.c:const struct of_device_id ltc2947_of_match[] = {
drivers/hwmon/ltc2947-core.c:EXPORT_SYMBOL_GPL(ltc2947_of_match);
drivers/hwmon/ltc2947-core.c:MODULE_DEVICE_TABLE(of, ltc2947_of_match);
drivers/hwmon/ltc2947-i2c.c:            .of_match_table = ltc2947_of_match,
drivers/hwmon/ltc2947-spi.c:            .of_match_table = ltc2947_of_match,
drivers/hwmon/ltc2947.h:extern const struct of_device_id ltc2947_of_match[];

Are they all broken?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

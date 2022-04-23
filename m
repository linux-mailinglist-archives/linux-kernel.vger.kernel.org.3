Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F311450CD50
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 21:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236978AbiDWT6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 15:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236914AbiDWT60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 15:58:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2115F183FBD;
        Sat, 23 Apr 2022 12:55:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5E94B80D1C;
        Sat, 23 Apr 2022 19:55:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA3CC385B5;
        Sat, 23 Apr 2022 19:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650743721;
        bh=f+gN5VFSk9TvNUY6oLSGkqRdwS9xhEyKvVqBzBXLs0k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PzAHzR20lzvPfCTqt/UUzx12IPhOfz+TRjqNJ8NxEoRI/bWqgErqlZjk7cfTM259a
         ES9ZLzK7AQ5x5SMPoX4fGuEBvk10IF/bYoYOZNrIybBirPtSW18FdAPqWZza8MudXV
         vG23F9GYtnFHpHrf84m9ZBvRrLCT6HR3YBoZ5rIdgNbcdWJ4WulW+Ag5txr/fArK/K
         8hzENh6M4DW/B6aRii4K02sQiyHAgWdV6wTeninHDFb9FTGsk1kC60BC8Ty7Z9oRiu
         uezNy/Q8OZSv9U2rlimKsK6lo1l+EW6dZRWZhxxZjuCiGNgZmaJtyoN+hSdEOEgF8G
         ZbIfS2Abjyb2Q==
Received: by mail-wm1-f48.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso10070118wme.5;
        Sat, 23 Apr 2022 12:55:21 -0700 (PDT)
X-Gm-Message-State: AOAM533lGh9EPqhUPg/nNViJ/yIL6iwq+/2Z9XUGtlSB1o1YIthHmVZa
        ZwNhKnBa6uPnYoSswxFiRZFxxDjgek5kduGVgxM=
X-Google-Smtp-Source: ABdhPJwI9oPHj0hjS6Y5T/XpNunPLjXzfhDb/y4TSIxWhFvis5ICGMzIa2Kp6ZajGKm/dLFayXeKiCmoNnJ4Fu7pVP8=
X-Received: by 2002:a1c:f219:0:b0:38c:782c:3bb with SMTP id
 s25-20020a1cf219000000b0038c782c03bbmr18417513wmc.94.1650743719480; Sat, 23
 Apr 2022 12:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220419163810.2118169-1-arnd@kernel.org> <20220422170530.GA2338209@roeck-us.net>
 <CAK8P3a3V=qxUqYT3Yt=dpXVv58-Y+HVi952wO6D4LPN5NNphGA@mail.gmail.com>
 <8b36d3a4-ec85-2f9f-e4b7-734d8ddd3d8f@roeck-us.net> <CAK8P3a0R9cpEb1d2=e9KnGSbi_uRv48RWfCu_J4DDak_cGZSuw@mail.gmail.com>
 <20220422234150.GA3442771@roeck-us.net>
In-Reply-To: <20220422234150.GA3442771@roeck-us.net>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sat, 23 Apr 2022 21:55:03 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3qZdEqnJ2nTOKwDMossngOgCpEvZq4cQMPQjSsUoU=6g@mail.gmail.com>
Message-ID: <CAK8P3a3qZdEqnJ2nTOKwDMossngOgCpEvZq4cQMPQjSsUoU=6g@mail.gmail.com>
Subject: Re: [PATCH v2 00/48] ARM: PXA multiplatform support
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Paul Parsons <lost.distance@yahoo.com>,
        Tomas Cech <sleep_walker@suse.com>,
        Sergey Lapin <slapin@ossfans.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Helge Deller <deller@gmx.de>, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        IDE-ML <linux-ide@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        patches@opensource.cirrus.com, linux-leds@vger.kernel.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-rtc@vger.kernel.org, USB list <linux-usb@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 1:41 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Sat, Apr 23, 2022 at 12:04:31AM +0200, Arnd Bergmann wrote:
> > On Fri, Apr 22, 2022 at 10:55 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > On 4/22/22 12:16, Arnd Bergmann wrote:
> > > > On Fri, Apr 22, 2022 at 7:05 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > >
> > > > Which machine did you hit this on? Is this on hardware or in qemu?
> > > >
> > > qemu, as always. borzoi, spitz, terrier, tosa, z2, and sx1 fail.
> > > Also, I just noticed that the failure is not always the same.
> > > z2 fails to boot from initrd, and sx1 fails to boot completely.
> >
> > That's a lot of machines failing, I hope at least we got the same bugs more
> > than once here.
> >
> > For the I/O space, I found now that PXA was not using the standard
> > virtual I/O address yet, but instead used a NULL-based offset.
> >
> > I'm not entirely happy with this patch, but this is an outline of what
> > I think we need to fix that: https://pastebin.com/3nVgQsEw
> > This one is probably incomplete, at least it breaks sa1100 for now,
> > and it adds a bogus CONFIG_PCI dependency. I'm also not sure
> > in what way the last patch in the series triggers it, rather than the
> > one that removed mach/io.h.
> >
> > I had sx1 booting in qemu at least, with the omap1 multiplatform series only.
> > If you have a custom config for this one, make sure you get the right
> > DEBUG_LL address.
> >
> > > I'll do another round of bisects.
> >
>
> Here is the bisect for the sx1 boot failure.

Odd, I can't reproduce this at all. Do you get any console output at
all for this?

Is this the plain omap1_defconfig, or something else?

One thing I keep having to apply myself is this snippet:

diff --git a/arch/arm/mm/proc-arm925.S b/arch/arm/mm/proc-arm925.S
index 0bfad62ea858..87c695703580 100644
--- a/arch/arm/mm/proc-arm925.S
+++ b/arch/arm/mm/proc-arm925.S
@@ -441,7 +441,6 @@ __arm925_setup:

 #ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
        mov     r0, #4                          @ disable write-back
on caches explicitly
-       mcr     p15, 7, r0, c15, c0, 0
 #endif

        adr     r5, arm925_crval

I don't remember what the story is behind this, but I can't actually manage
to boot omap1_defconfig on qemu with the instruction intact.

       Arnd

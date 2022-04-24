Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4DF50D449
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 20:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237194AbiDXSwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 14:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiDXSwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 14:52:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848D813F51;
        Sun, 24 Apr 2022 11:48:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B01276124F;
        Sun, 24 Apr 2022 18:48:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B0CC385B1;
        Sun, 24 Apr 2022 18:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650826137;
        bh=ipl3oSa3DODJXFqNROBx1CoqGwslciyjMuC+i+Saf6s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BOkM82fII90m6hiFZrsM+S6NoOx/9JSXO645uDox3wouyvV5cDVRWJxz7xq/cB9au
         LYrBwqxSBkhIKBzBNs0hwtCBHRO1gixAqGnRtxVTd+01UzyFfxHSDne9WN6ttlm+rb
         jcQBniXrkaKqn2jBmZOb15DeGZFcd9PAC8aU0sErmt9X3VJ12+DgM2/0JBOHnN/nNw
         G4IIFddQ3lsrPoLfBPfhYi7wy7+MEYhHtnQkavlIidm5fb5N3XrXiQ6swPnyQws0/W
         CtU43okgiFy2OpjRFiWX3gSYz6BOM2afEEdzeBOnonvAaXEfnmyinRGY3cRVziG/FD
         TihvS5WssHAGA==
Received: by mail-wm1-f49.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so8339736wmn.1;
        Sun, 24 Apr 2022 11:48:56 -0700 (PDT)
X-Gm-Message-State: AOAM532dCbbuPtNLiFWY0oLFZs8XVfrMBbWkSdIYLtsNfBb72iV3o7bU
        it6YCv5pHi/kxy42HhEx37g9WQ8uhZLw+EPMKaw=
X-Google-Smtp-Source: ABdhPJy0bXzhrJhOMZ1X8kbnkslFxEyAGa0Ih/9fgvnO3mTuzgN7/0kU+dSPN2u/9dZRAXnrV+Nc5ftINsUw3V0d/rc=
X-Received: by 2002:a05:600c:4e4a:b0:392:88e1:74a7 with SMTP id
 e10-20020a05600c4e4a00b0039288e174a7mr22771106wmq.174.1650826135238; Sun, 24
 Apr 2022 11:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220419163810.2118169-1-arnd@kernel.org> <20220422170530.GA2338209@roeck-us.net>
 <CAK8P3a3V=qxUqYT3Yt=dpXVv58-Y+HVi952wO6D4LPN5NNphGA@mail.gmail.com>
 <8b36d3a4-ec85-2f9f-e4b7-734d8ddd3d8f@roeck-us.net> <CAK8P3a0R9cpEb1d2=e9KnGSbi_uRv48RWfCu_J4DDak_cGZSuw@mail.gmail.com>
 <20220422234150.GA3442771@roeck-us.net> <CAK8P3a3qZdEqnJ2nTOKwDMossngOgCpEvZq4cQMPQjSsUoU=6g@mail.gmail.com>
 <3b4046ed-fd75-13ea-fac3-06469172806c@roeck-us.net> <CAK8P3a1LzEG1vo+5nMrnL3TOMcbSKJ3u=StcfY8dajV2raUBjA@mail.gmail.com>
 <3df135a2-17f5-d6c6-b4a8-e1a60e254297@roeck-us.net>
In-Reply-To: <3df135a2-17f5-d6c6-b4a8-e1a60e254297@roeck-us.net>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sun, 24 Apr 2022 20:48:39 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2EHMQPN4ny9sXXuReFG0jN0hyRV7h9v_AR_0pqpOU41w@mail.gmail.com>
Message-ID: <CAK8P3a2EHMQPN4ny9sXXuReFG0jN0hyRV7h9v_AR_0pqpOU41w@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 5:28 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On 4/24/22 01:52, Arnd Bergmann wrote:
> > On Sun, Apr 24, 2022 at 4:09 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > into the defconfig file, otherwise the multiplatform target defaults to
> > an ARMv7 instead of ARMv5 build. For an OMAP15xx as in the SX1,
> > you also need to enable CONFIG_ARCH_MULTI_V4T.
> >
> > This is slightly unfortunate, but I don't see any way to avoid it, and the
> > modified defconfig will still work fine with older kernel trees.
> >
>
> Yes, that works. I changed it in my configuration.

Ok, great!. I managed to boot the z2 machine with PCMCIA support
and it gets around the issue with my patch, correctly detecting the
CF card.

> >>> One thing I keep having to apply myself is this snippet:
> >>>
> >>> diff --git a/arch/arm/mm/proc-arm925.S b/arch/arm/mm/proc-arm925.S
> >>> index 0bfad62ea858..87c695703580 100644
> >>> --- a/arch/arm/mm/proc-arm925.S
> >>> +++ b/arch/arm/mm/proc-arm925.S
> >>> @@ -441,7 +441,6 @@ __arm925_setup:
> >>>
> >>>    #ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
> >>>           mov     r0, #4                          @ disable write-back
> >>> on caches explicitly
> >>> -       mcr     p15, 7, r0, c15, c0, 0
> >>>    #endif
> >>
> >> it does not have CONFIG_CPU_DCACHE_WRITETHROUGH enabled.
> >
> > Maybe it was disabled explicitly for the sx1_defconfig because of this
> > bug. I would think that this is required for actual sx1 hardware because the
> > option is default-enabled for ARM925T, and that CPU core is exclusively
> > used in OMAP15xx.
> >
>
> That looks like a bug in qemu. ARM925T instruction support is limited to V4T
> instructions. qemu doesn't have explicit 5T support. It is either V4T
> or V5.

I'm not entirely sure what instructions the CPU supports, but Linux
treats it as ARMv4T as well, and qemu supports some of the 925t
specific instructions as "ti925t" in target/arm/cpu_tcg.c, it just seems
it's missing some others.

      Arnd

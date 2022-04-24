Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFBF50D0AA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 10:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbiDXI4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 04:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbiDXIz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 04:55:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A587095A38;
        Sun, 24 Apr 2022 01:52:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1003B80DDE;
        Sun, 24 Apr 2022 08:52:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F33DC385B6;
        Sun, 24 Apr 2022 08:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650790374;
        bh=VAIS5RCD9giYhrbO5Hac6FpKh7We3My7pPHwyo54GI8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IlEUmxA7Upi/jZvwszo5tWXIcRM0EAFPHSwLNctN9Y58IvDFrOEsiQajUPCMH7Jvj
         ffMGYU3Am1eiuRxan/QEzVGZIU4/nZDiD4I9qyEihHwFs57oDBFuZkioK/aaH82E/D
         cafv1RJevyhRqAmfrOprDhzFhC5PdErVyqMypulLdZQgaDPE2OydWwwQC4+yvZmqbe
         cKfnbHuByU+9iCxgB+9sW82eJWEWf6s1YXcaaJOKEOR6FMrQj52g4nRCkxQaL9o5DE
         hRPjDgGmvEn6UrlX0oEzCHgEu1vF7VzmeRUbf/lMOXmL9MVlUAWdZQ45wrK1ipQsiq
         1YeW3uUpHXgig==
Received: by mail-wm1-f46.google.com with SMTP id n32-20020a05600c3ba000b00393ea7192faso338998wms.2;
        Sun, 24 Apr 2022 01:52:54 -0700 (PDT)
X-Gm-Message-State: AOAM530pm5LKoJ9S9zURth3ykurMGPhtGlFWlgWWk21lbp77o9sfaDGO
        08lMtfVWNAsO9QdzyqUCGCnBOiJi5UCARkJqihE=
X-Google-Smtp-Source: ABdhPJwWxQyFReh1xxhP87snsCB/AySgR1dxVTGy6Gpi4+Uz2ZZzeirzOgx8S2o3MdbrdLkLr/78d+DVsl9RCKwJ5Q8=
X-Received: by 2002:a1c:f219:0:b0:38c:782c:3bb with SMTP id
 s25-20020a1cf219000000b0038c782c03bbmr20347843wmc.94.1650790372472; Sun, 24
 Apr 2022 01:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220419163810.2118169-1-arnd@kernel.org> <20220422170530.GA2338209@roeck-us.net>
 <CAK8P3a3V=qxUqYT3Yt=dpXVv58-Y+HVi952wO6D4LPN5NNphGA@mail.gmail.com>
 <8b36d3a4-ec85-2f9f-e4b7-734d8ddd3d8f@roeck-us.net> <CAK8P3a0R9cpEb1d2=e9KnGSbi_uRv48RWfCu_J4DDak_cGZSuw@mail.gmail.com>
 <20220422234150.GA3442771@roeck-us.net> <CAK8P3a3qZdEqnJ2nTOKwDMossngOgCpEvZq4cQMPQjSsUoU=6g@mail.gmail.com>
 <3b4046ed-fd75-13ea-fac3-06469172806c@roeck-us.net>
In-Reply-To: <3b4046ed-fd75-13ea-fac3-06469172806c@roeck-us.net>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sun, 24 Apr 2022 10:52:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1LzEG1vo+5nMrnL3TOMcbSKJ3u=StcfY8dajV2raUBjA@mail.gmail.com>
Message-ID: <CAK8P3a1LzEG1vo+5nMrnL3TOMcbSKJ3u=StcfY8dajV2raUBjA@mail.gmail.com>
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

On Sun, Apr 24, 2022 at 4:09 AM Guenter Roeck <linux@roeck-us.net> wrote:
> On 4/23/22 12:55, Arnd Bergmann wrote:
> > On Sat, Apr 23, 2022 at 1:41 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >> On Sat, Apr 23, 2022 at 12:04:31AM +0200, Arnd Bergmann wrote:
> >
> > Odd, I can't reproduce this at all. Do you get any console output at
> > all for this?
> >
> > Is this the plain omap1_defconfig, or something else?
> >
>
> No, it is my own sx1 specific configuration.
>
> https://github.com/groeck/linux-build-test/blob/master/rootfs/arm/qemu_sx1_defconfig
>
> I don't recall where I got it from but ...

Ok, that explains it, thanks!

I fixed all the defconfig files that come with the kernel, but for your own
ones you have to add

# CONFIG_ARCH_MULTI_V7 is not set

into the defconfig file, otherwise the multiplatform target defaults to
an ARMv7 instead of ARMv5 build. For an OMAP15xx as in the SX1,
you also need to enable CONFIG_ARCH_MULTI_V4T.

This is slightly unfortunate, but I don't see any way to avoid it, and the
modified defconfig will still work fine with older kernel trees.

> > One thing I keep having to apply myself is this snippet:
> >
> > diff --git a/arch/arm/mm/proc-arm925.S b/arch/arm/mm/proc-arm925.S
> > index 0bfad62ea858..87c695703580 100644
> > --- a/arch/arm/mm/proc-arm925.S
> > +++ b/arch/arm/mm/proc-arm925.S
> > @@ -441,7 +441,6 @@ __arm925_setup:
> >
> >   #ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
> >          mov     r0, #4                          @ disable write-back
> > on caches explicitly
> > -       mcr     p15, 7, r0, c15, c0, 0
> >   #endif
>
> it does not have CONFIG_CPU_DCACHE_WRITETHROUGH enabled.

Maybe it was disabled explicitly for the sx1_defconfig because of this
bug. I would think that this is required for actual sx1 hardware because the
option is default-enabled for ARM925T, and that CPU core is exclusively
used in OMAP15xx.

        Arnd

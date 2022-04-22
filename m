Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5A250C3A8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbiDVWUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbiDVWSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:18:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A044705E;
        Fri, 22 Apr 2022 15:04:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9EC42B83272;
        Fri, 22 Apr 2022 22:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502FFC385AB;
        Fri, 22 Apr 2022 22:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650665089;
        bh=zuNw6j1TShfoNbLYYIZxrZxreBGq9IdbmgqrCDzwCoE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GJHnYGm7kS7OYKfkAu61QcQIzQsPpKgiX8ZwFOEZB2cc8bdXfKuICeePb/LdLDWns
         VNg0u6qUYqau/LeOFrayBulaQJxkihHPe/A2FqLymKPNdePaoUDSIGdGevpo7L/zJM
         aFPhStRd09KzzfNR1joe6PwVDpjMzpbeziX7fgPmvokEvCi/0oFrjnwBTaaGfP/BOU
         IUNNTQDtVNPw7mpJSpA99kiRdBDjanYdKye5l82yB0eqq3zLotqrujW7fvCIf2Ejkd
         dAqJEF/tV2gwSfcpwtPVTrB+Lh9rnVah9UvWO9BhrH9MflpU1vh20qiOa/U8KRRaYH
         giaZNTf1zCHIw==
Received: by mail-wm1-f47.google.com with SMTP id q20so5841606wmq.1;
        Fri, 22 Apr 2022 15:04:49 -0700 (PDT)
X-Gm-Message-State: AOAM5316G1Qpk56Wu+UcOt6hj2nx1VfttOXlwvZpmLGd7jHRHONmsW3f
        STOnEHKSTHIV4MExAz+NGq4VoEiQvcmEOpiQ/uQ=
X-Google-Smtp-Source: ABdhPJxxyzPCyBaxXq4e/OKv6ds/3UgnpcR0jFo6uX7QoEAMCxGf0GP6zkRcnylbgWRsSBmj2Bdv9puvN/pDeVMDIcQ=
X-Received: by 2002:a05:600c:4ed4:b0:392:90a5:b7e6 with SMTP id
 g20-20020a05600c4ed400b0039290a5b7e6mr15508304wmq.33.1650665087477; Fri, 22
 Apr 2022 15:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220419163810.2118169-1-arnd@kernel.org> <20220422170530.GA2338209@roeck-us.net>
 <CAK8P3a3V=qxUqYT3Yt=dpXVv58-Y+HVi952wO6D4LPN5NNphGA@mail.gmail.com> <8b36d3a4-ec85-2f9f-e4b7-734d8ddd3d8f@roeck-us.net>
In-Reply-To: <8b36d3a4-ec85-2f9f-e4b7-734d8ddd3d8f@roeck-us.net>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sat, 23 Apr 2022 00:04:31 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0R9cpEb1d2=e9KnGSbi_uRv48RWfCu_J4DDak_cGZSuw@mail.gmail.com>
Message-ID: <CAK8P3a0R9cpEb1d2=e9KnGSbi_uRv48RWfCu_J4DDak_cGZSuw@mail.gmail.com>
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

On Fri, Apr 22, 2022 at 10:55 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On 4/22/22 12:16, Arnd Bergmann wrote:
> > On Fri, Apr 22, 2022 at 7:05 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Which machine did you hit this on? Is this on hardware or in qemu?
> >
> qemu, as always. borzoi, spitz, terrier, tosa, z2, and sx1 fail.
> Also, I just noticed that the failure is not always the same.
> z2 fails to boot from initrd, and sx1 fails to boot completely.

That's a lot of machines failing, I hope at least we got the same bugs more
than once here.

For the I/O space, I found now that PXA was not using the standard
virtual I/O address yet, but instead used a NULL-based offset.

I'm not entirely happy with this patch, but this is an outline of what
I think we need to fix that: https://pastebin.com/3nVgQsEw
This one is probably incomplete, at least it breaks sa1100 for now,
and it adds a bogus CONFIG_PCI dependency. I'm also not sure
in what way the last patch in the series triggers it, rather than the
one that removed mach/io.h.

I had sx1 booting in qemu at least, with the omap1 multiplatform series only.
If you have a custom config for this one, make sure you get the right
DEBUG_LL address.

> I'll do another round of bisects.

Thanks!

       Arnd

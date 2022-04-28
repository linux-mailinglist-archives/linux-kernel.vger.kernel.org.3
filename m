Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82808513589
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347621AbiD1Ns0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347594AbiD1NsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:48:23 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613661009;
        Thu, 28 Apr 2022 06:45:07 -0700 (PDT)
Received: from mail-yw1-f172.google.com ([209.85.128.172]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mbj7g-1oHTX51Pwc-00dBzt; Thu, 28 Apr 2022 15:45:05 +0200
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-2f16645872fso53520157b3.4;
        Thu, 28 Apr 2022 06:45:04 -0700 (PDT)
X-Gm-Message-State: AOAM531rqS3TMANA9dj5PbXHgYaYSabwGuCiqYz/vsc+5F15FvO6r45T
        WzYb45HYkZmr2LEKIEQie8lnR4wtPfawCBHHv8E=
X-Google-Smtp-Source: ABdhPJzhKdbLezBOw+onlWys2HjSNrb5hSb6f6j0ogYNPd9ax1npbHyo1Y6CrpuYIOWED3Pgr1SGQ4YvAKDaJmP/tmM=
X-Received: by 2002:a0d:fc83:0:b0:2e5:b0f4:c125 with SMTP id
 m125-20020a0dfc83000000b002e5b0f4c125mr33063062ywf.347.1651153503029; Thu, 28
 Apr 2022 06:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220419163810.2118169-1-arnd@kernel.org> <20220422170530.GA2338209@roeck-us.net>
 <CAK8P3a3V=qxUqYT3Yt=dpXVv58-Y+HVi952wO6D4LPN5NNphGA@mail.gmail.com>
 <8b36d3a4-ec85-2f9f-e4b7-734d8ddd3d8f@roeck-us.net> <CAK8P3a0R9cpEb1d2=e9KnGSbi_uRv48RWfCu_J4DDak_cGZSuw@mail.gmail.com>
 <20220422234150.GA3442771@roeck-us.net> <CAK8P3a3qZdEqnJ2nTOKwDMossngOgCpEvZq4cQMPQjSsUoU=6g@mail.gmail.com>
 <3b4046ed-fd75-13ea-fac3-06469172806c@roeck-us.net> <CAK8P3a1LzEG1vo+5nMrnL3TOMcbSKJ3u=StcfY8dajV2raUBjA@mail.gmail.com>
 <3df135a2-17f5-d6c6-b4a8-e1a60e254297@roeck-us.net> <CAK8P3a2EHMQPN4ny9sXXuReFG0jN0hyRV7h9v_AR_0pqpOU41w@mail.gmail.com>
In-Reply-To: <CAK8P3a2EHMQPN4ny9sXXuReFG0jN0hyRV7h9v_AR_0pqpOU41w@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 28 Apr 2022 15:44:47 +0200
X-Gmail-Original-Message-ID: <CAK8P3a09+nFS3g1rgvTW9da3tMiAhHjkjZVs1QOJOj8TJ-9MDg@mail.gmail.com>
Message-ID: <CAK8P3a09+nFS3g1rgvTW9da3tMiAhHjkjZVs1QOJOj8TJ-9MDg@mail.gmail.com>
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
X-Provags-ID: V03:K1:FlIDVPKXj9nzRwbk/wtccBdWDayg3PeTGiQuZ0/K42Bc7lGmPdy
 zssQcyDZ/DvWHSLnMLZ2c9c0/R8//Ct6Le7VOKueD5Qrh1XSkN/immCrCQM54OpPKR7UGyt
 rQR8FQFtM5HLTQupvDTlwrysBtqfjlwTZD25pEF/Z42s6fyHy6hxD7eWpHSPUujdYwhn8pQ
 hp2z24g1g13nAlk8lrHHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bRWqGE+N+ZY=:1iRjrIl6V157UK5O78TAoc
 5W5zmo/RxHt6piZZQJR7bHPk8veJW7G/eD5jO6ABZaX8NSxlHXJ4TP5x5uFoaOWveTMuY2YNB
 E/S7IJzqQcjMpAVq0rBO649N779tX8wy6iezjQHdAX7O/6l7dHbxrLeGuJGtVvy5SPmFPsnuF
 7hnbUhs94zbUsLMYQRcLlnGNptZ7bFxfi+PlNYB3jQQh0+wXdJS+P/EHPJK8UZHs5BjQBv+Qa
 EX048TdTH+63xTL5zzrwgKZLFucF2PiHs68Y/WDhFOvULFD5XwxnpC8QYME42zx9V0NjnR5nN
 Zars/a9a2hpnBBVlPLxle2k0Ttww//0frPo+wnR8G+aU3Z16D9IvAlHwSrOB4KMSHfQcLKCXw
 tPZA1Y7PpVtBkQv7lmHrlSCe1xcRYAXOza/mWm2Xjc8xgk76wXvHvzBr1oDGBEonkVw+bOSVk
 vREnB57Ovs/1UlfpUFpyy1eB8Q7JaktAGlKXASPtn19bnV5rt2G4I4ntfhaJQgAmDnlzlZpC5
 Evd5+7v4S1X/iOOX+m+Ahkho8f4fM1ugsUVvQaHKOghqQBb6nN0eAvrdXIURg56QmTfn7UwPn
 N0bxJ5G7FH8Br9CiO+tOZBKs/TdaV+aEaEj9KMO4yP5VYEF6IpBEitkf9ifUTwFwihqSEjEM8
 bFcGWSSCC9/0KLlTg8Gh5+db6LA5cg7itMKXDE5C7XsBAI9Hm3mx1p5yWo7HLHsbXHmzeASA2
 rpwe5iV2gi/30EyX8gsnnoe4xEtOTZhUuWGdwxWCA0Vb4Q0oLDG+gyWlREBg6vyV7SR9Ag7iE
 yckvS97oNG9rtf98GBy9xysVb2+4/y8JObMv6+5+lQPd284ay4=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 8:48 PM Arnd Bergmann <arnd@kernel.org> wrote:
> On Sun, Apr 24, 2022 at 5:28 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > On 4/24/22 01:52, Arnd Bergmann wrote:
> > > On Sun, Apr 24, 2022 at 4:09 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > > into the defconfig file, otherwise the multiplatform target defaults to
> > > an ARMv7 instead of ARMv5 build. For an OMAP15xx as in the SX1,
> > > you also need to enable CONFIG_ARCH_MULTI_V4T.
> > >
> > > This is slightly unfortunate, but I don't see any way to avoid it, and the
> > > modified defconfig will still work fine with older kernel trees.
> > >
> >
> > Yes, that works. I changed it in my configuration.
>
> Ok, great!. I managed to boot the z2 machine with PCMCIA support
> and it gets around the issue with my patch, correctly detecting the
> CF card.

Hi Guenter,

I have now sent out a fix that I'm happy with, and applied it to the
pxa-multiplatform-5.18 branch of the soc tree as well as the
combined arm/multiplatform tree.

I have not merged this new version into the for-next branch
since I would like to see if there are any other regressions first.

Can you run your boot tests on the arm/multiplatform branch
and let me know if that fixes everything you found? If that
takes a lot of manual steps on your side, I'd just wait for the
build bots and merge it after all there are no new compile-time
issues.

       Arnd

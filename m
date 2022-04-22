Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D04950C4F9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiDVXfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 19:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiDVXf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 19:35:26 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB6E1D83BA;
        Fri, 22 Apr 2022 16:18:40 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id i3-20020a056830010300b00605468119c3so6494407otp.11;
        Fri, 22 Apr 2022 16:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KoWXKICOXrLwboX1KRSR8wabyc5tj+p6lrbCOGJNsB0=;
        b=WfyERyMX7R5AXo/rMMIl6y8nSXixykdVRLEdinY/MomqcCB5r5ZQbLs3BCON1JbJid
         SYBch1vH11Gbyyr7uHnb4uKt0rpEYLwWG6jPVzGB/6YTjnfP6B6nc9E72CRX17Qo8Nv0
         hqL9sBFF2f0anLzd4y4fWfHceVS7UFZj4OgGcGq3zFsQ1W26Ro4FtkgUsgVmFt6FTodv
         WJhhQLAQTlQE5ybgDgtXzSu4H0hkfGnY/mdPQk846Y0PZFkSuevMtu2SOCSNLfL6QGeG
         2/n/ZJOa7dCF4cmxGePvIEuDB/dkYth22mYrBof0ZAwoE1ogpw42s8W4hmZGYwun6WYu
         NaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=KoWXKICOXrLwboX1KRSR8wabyc5tj+p6lrbCOGJNsB0=;
        b=0udM59OXTkX0qBnWg3+GL73fGaVxcVrRra3MiwovoCuQzxxCnuxt4rnE5fI87cJDSJ
         5hJ2UtZRWZ9W0jRioEmY5Ehh4Gf3AZBrpWIuFjHTuTFEc2xY0CX13Mf95XBRpjYlbnST
         GkOFlxxsWcRCHAwWo6NyNK5h4jIiUqU2CR9ac3QPbe8dvA3RAEucqq/PkaiInJx4nD3I
         ad9eXdjUG6GoAVuUbilyT2ogorPZnCF8S5+wDMt9nB6wZyAULb5gUbsJuhxq6NN5OMjK
         ZzZq9gBkRqsf1v1hHQwuEVbNrB7VXAl3fIzvpEalEqAbVUoilveIzYT5QHw5TBPKhng0
         w2Ew==
X-Gm-Message-State: AOAM5339xlY6pD+0oHKGHNb0Dm+jKfiKy3vE2bynMOUsa/eiVWOva+Il
        rRsE3wldGCT8V/5DLez8bjg=
X-Google-Smtp-Source: ABdhPJwKkrwKpAYwt9fhjngX1DM/06254YDKfs9CDiPU2Hx7eNlH3p/K4fmqYt8gQFcOM67kG0jDEA==
X-Received: by 2002:a05:6830:14cd:b0:605:4e77:6472 with SMTP id t13-20020a05683014cd00b006054e776472mr2672213otq.94.1650669519778;
        Fri, 22 Apr 2022 16:18:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f15-20020a9d5f0f000000b005e6b67945a3sm1256410oti.15.2022.04.22.16.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 16:18:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 22 Apr 2022 16:18:36 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Arnd Bergmann <arnd@kernel.org>
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
Subject: Re: [PATCH v2 00/48] ARM: PXA multiplatform support
Message-ID: <20220422231836.GA3202260@roeck-us.net>
References: <20220419163810.2118169-1-arnd@kernel.org>
 <20220422170530.GA2338209@roeck-us.net>
 <CAK8P3a3V=qxUqYT3Yt=dpXVv58-Y+HVi952wO6D4LPN5NNphGA@mail.gmail.com>
 <8b36d3a4-ec85-2f9f-e4b7-734d8ddd3d8f@roeck-us.net>
 <CAK8P3a0R9cpEb1d2=e9KnGSbi_uRv48RWfCu_J4DDak_cGZSuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0R9cpEb1d2=e9KnGSbi_uRv48RWfCu_J4DDak_cGZSuw@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 12:04:31AM +0200, Arnd Bergmann wrote:
> On Fri, Apr 22, 2022 at 10:55 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > On 4/22/22 12:16, Arnd Bergmann wrote:
> > > On Fri, Apr 22, 2022 at 7:05 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > Which machine did you hit this on? Is this on hardware or in qemu?
> > >
> > qemu, as always. borzoi, spitz, terrier, tosa, z2, and sx1 fail.
> > Also, I just noticed that the failure is not always the same.
> > z2 fails to boot from initrd, and sx1 fails to boot completely.
> 
> That's a lot of machines failing, I hope at least we got the same bugs more
> than once here.
> 
> For the I/O space, I found now that PXA was not using the standard
> virtual I/O address yet, but instead used a NULL-based offset.
> 
> I'm not entirely happy with this patch, but this is an outline of what
> I think we need to fix that: https://pastebin.com/3nVgQsEw
> This one is probably incomplete, at least it breaks sa1100 for now,
> and it adds a bogus CONFIG_PCI dependency. I'm also not sure
> in what way the last patch in the series triggers it, rather than the
> one that removed mach/io.h.
> 
> I had sx1 booting in qemu at least, with the omap1 multiplatform series only.
> If you have a custom config for this one, make sure you get the right
> DEBUG_LL address.
> 
> > I'll do another round of bisects.
> 

So ... z2 bisect points to the same patch, but the error is different.
As mentioned, it does not recognize the initrd. Oddly enough, booting
from initrd works for the other platforms.

The sx1 boot failure seems to be unrelated to your patch series. It boots
fine if built from the tip of your branch, but fails to boot in -next.
That will require a bisect from -next.

Guenter

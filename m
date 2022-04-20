Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400965089C6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379196AbiDTNv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234412AbiDTNv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:51:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A58543493;
        Wed, 20 Apr 2022 06:48:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03ECBB81F18;
        Wed, 20 Apr 2022 13:48:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3157C385B0;
        Wed, 20 Apr 2022 13:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650462517;
        bh=r5gIACVwFwXfu+L0SjHY63rmQTmlBYIcuCScaOsuAjk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E8Em2MQWztm+C2EmlV1FQe3I0FTSV2DiJcyK2iihaFQo51NM0DFE/rYOIE+wyx1wp
         /VWN0/71ZwssYkNVh129T8UpZm6AUkLIGuMiY6fzJStQ7ZZZzsLu+YfHMjswZ9W7YM
         mjdK3DJxHlIkGZPSUsh/8dFkbBcT5Jm8E77pDoGNiEZG4/4EPstw+51gVak16za2ga
         dhu7kZkcOynk9SMtnhYtXUgL6zQdymwzczZfSDpnrDpvJEhYxBXYfvKUUxyNISj4vp
         /lSN3yrqnyEcDKHRIhkxeNkjouxpUUs1/5w5lM+l5Iw8Csip1eFb3F0IQ3ctyogPeM
         5m+eazxPFDoqg==
Received: by mail-wr1-f44.google.com with SMTP id p18so2362232wru.5;
        Wed, 20 Apr 2022 06:48:37 -0700 (PDT)
X-Gm-Message-State: AOAM5314VcoKSUO2df9/UV2WWtZ74zAVJ6/84WF1Vw3vWjbKXqaEVb8b
        SEDqrsFliZOFpFCpdAgMviERW/E84s9t8n1stW8=
X-Google-Smtp-Source: ABdhPJwSpIclw+ZwqVR57edT/aQRpFn5BaY64Phs17aAgIE6n54XF3PED3yv14Fv9AL2uDPz7qCh2GbTzsHglUZV1DA=
X-Received: by 2002:a5d:6389:0:b0:207:a7d8:2b64 with SMTP id
 p9-20020a5d6389000000b00207a7d82b64mr15595597wru.12.1650462515957; Wed, 20
 Apr 2022 06:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220419163810.2118169-1-arnd@kernel.org> <20220419163810.2118169-41-arnd@kernel.org>
 <20220420134305.fq7pc3fsz5fxkryj@mercury.elektranox.org>
In-Reply-To: <20220420134305.fq7pc3fsz5fxkryj@mercury.elektranox.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 20 Apr 2022 15:48:19 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2Mv-gUoc3hpqvCa1tzvEEwHN6wXDxmy8K5rN8sULQnMw@mail.gmail.com>
Message-ID: <CAK8P3a2Mv-gUoc3hpqvCa1tzvEEwHN6wXDxmy8K5rN8sULQnMw@mail.gmail.com>
Subject: Re: [PATCH 40/48] ARM: pxa: tosa: use gpio lookup for battery
To:     Sebastian Reichel <sre@kernel.org>
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

On Wed, Apr 20, 2022 at 3:43 PM Sebastian Reichel <sre@kernel.org> wrote:
> > @@ -15,11 +15,16 @@
> >  #include <linux/gpio.h>
>
> This should be <linux/gpio/consumer.h> now.
>
Fixed now, thanks!

     Arnd

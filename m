Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D04851F88E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbiEIJy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238352AbiEIJpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:45:44 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0442300CE;
        Mon,  9 May 2022 02:41:41 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id bm18-20020a056820189200b0035f7e56a3dfso423215oob.8;
        Mon, 09 May 2022 02:41:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/2S52I/7rnpAZPZBnPAQrsYd+UWQvbEGjZCjMYNcziY=;
        b=SaJcfRTmzrIU3dMkD+We4rkg1XIReS5NS79HAoK0MegmHM847XqmBul86CxGWtKcw/
         3dQjG6Kp2K+wRg/d0soSR9LRkUU92Nk2go4EzSzDXyNlzmh93N9VEshjUhV0cSYCx3o3
         +R2UXL7llLjz9s7jIpA+70uqNh4Z3WiLeMP9KBE06UHAbtRfv82efm7FkuEvZlt59aYn
         1JVZYAdVYcnj/2gs7zjOMpUEyPQ/gttVpQ7wFVUCbPqz8/0B6Vz5trpnQCDbuNBX/kdF
         /Jz1JnltJNTY5Dvr9u1Oj35tbZEJdiAQm8JEeGFiXbdcqKxrAXZG9R8lqbr7QGCCH3yR
         WtkQ==
X-Gm-Message-State: AOAM5313TKZow2GK4gpyqo2YszOhPSVhbKtlzdSwPZ2esBbYjqs1GVKY
        uLZz/mb+vuG3HThcamHQ9bGwsleKIaja3Q==
X-Google-Smtp-Source: ABdhPJxLFleYDC+MrO2l8La8D4Yi8Vw0mJAWR1LKq8xR8Eajy8FC/ZdWGe+byu4mPvRWtslo/pg5dw==
X-Received: by 2002:a05:6820:1007:b0:35e:a77a:e712 with SMTP id v7-20020a056820100700b0035ea77ae712mr5488413oor.64.1652088906127;
        Mon, 09 May 2022 02:35:06 -0700 (PDT)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com. [209.85.210.54])
        by smtp.gmail.com with ESMTPSA id 26-20020aca0d1a000000b00325d7b6cab8sm4158479oin.16.2022.05.09.02.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 02:35:06 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id z5-20020a9d62c5000000b00606041d11f1so9708000otk.2;
        Mon, 09 May 2022 02:35:05 -0700 (PDT)
X-Received: by 2002:a25:448:0:b0:64a:94d6:e420 with SMTP id
 69-20020a250448000000b0064a94d6e420mr8778268ybe.89.1652088533360; Mon, 09 May
 2022 02:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220507125443.2766939-1-daniel.lezcano@linexp.org> <20220507125443.2766939-3-daniel.lezcano@linexp.org>
In-Reply-To: <20220507125443.2766939-3-daniel.lezcano@linexp.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 May 2022 11:28:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW9A5NC64yzErhUZd5y88cHN0xgzOAiwzVcdYse9sdUsQ@mail.gmail.com>
Message-ID: <CAMuHMdW9A5NC64yzErhUZd5y88cHN0xgzOAiwzVcdYse9sdUsQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] thermal/core: Add a thermal sensor structure in
 the thermal zone
To:     daniel.lezcano@linexp.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:RENESAS R-CAR THERMAL DRIVERS" 
        <linux-renesas-soc@vger.kernel.org>,
        "open list:SAMSUNG THERMAL DRIVER" 
        <linux-samsung-soc@vger.kernel.org>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Sat, May 7, 2022 at 3:02 PM Daniel Lezcano <daniel.lezcano@linexp.org> wrote:
> The thermal sensor ops is directly defined in the thermal zone but
> still its data structuration makes the sensor ops and the thermal zone
> too much interconnected for multiple sensors per thermal zone.
>
> Create a dedicated structure for the thermal sensor to be included in
> the thermal zone structure so these components are clearly separated.
>
> Cc: Alexandre Bailon <abailon@baylibre.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc; Eduardo Valentin <eduval@amazon.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>

Thanks for your patch!

>  drivers/thermal/rcar_gen3_thermal.c        |  6 +--

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -80,6 +80,11 @@ struct thermal_sensor_ops {
>         void (*critical)(struct thermal_zone_device *);
>  };
>
> +struct thermal_sensor {
> +       struct thermal_sensor_ops *ops;
> +       struct device *dev;

Unless I missed something, the "dev" field is unused in this series?

> +};
> +
>  struct thermal_cooling_device_ops {
>         int (*get_max_state) (struct thermal_cooling_device *, unsigned long *);
>         int (*get_cur_state) (struct thermal_cooling_device *, unsigned long *);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

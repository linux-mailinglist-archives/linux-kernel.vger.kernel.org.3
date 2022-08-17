Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458EE596F19
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239442AbiHQNB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236393AbiHQNBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:01:51 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392E94DB6C;
        Wed, 17 Aug 2022 06:01:50 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id a15so9833791qko.4;
        Wed, 17 Aug 2022 06:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=cH35DFRkJqtmVqNgkmmMsr/quu6SGsADZJqIlU2X9QA=;
        b=RPZAEM0IgVPlanZSqYEaVnkRdO+cMBBYRmsCPW0u73UIywQRpu1zBFGVVKhHwxJJfE
         3XTkHXN++hswmnvAgvtLxC62v6xNGrpmpyFkvdXUxnQ2LJ56Cqk8rDirjb4I+UBAoTgN
         4yKZ7vIExuebAWWXZLLMC2Q6nvo3LvOm0+E1ctRQBhDaqOKjRNBRcD5lX90/pAQlzE4P
         QGBF5wLLBi+MeLvpYGtnFNP2m3myW7Mp/QMg3gER7jT5lQpogoCoqcrWZBsHrjM7+Bug
         u45muz8K9GObovMp5pw+eHcXm3ZGVJpaGNGNWUr6fFm+CvC08xzo6tAX2bZ95sGfroV+
         Iitw==
X-Gm-Message-State: ACgBeo3i0vOUCTPeMm5eLVGn9VHoZG+gDlcLz5rH8oXRPJ3+eSuvr5dc
        oSFI6dlBc1wj6dYkI6JeRq/0MeRjiAPxjQ==
X-Google-Smtp-Source: AA6agR4LAW7UhElE5/82gss2h5khbilqn+4NRSCW1xS5wiYXD4j9iSvrLUg2u7mkiKr+8sI2BNhn/w==
X-Received: by 2002:a05:620a:705:b0:6bb:880a:9c85 with SMTP id 5-20020a05620a070500b006bb880a9c85mr2585035qkc.493.1660741308945;
        Wed, 17 Aug 2022 06:01:48 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id k20-20020ac84754000000b003435f947d9fsm12518097qtp.74.2022.08.17.06.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 06:01:48 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-3246910dac3so228542667b3.12;
        Wed, 17 Aug 2022 06:01:47 -0700 (PDT)
X-Received: by 2002:a25:6890:0:b0:684:2c5c:1bd8 with SMTP id
 d138-20020a256890000000b006842c5c1bd8mr15530630ybc.604.1660741307273; Wed, 17
 Aug 2022 06:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220810060040.321697-1-saravanak@google.com>
In-Reply-To: <20220810060040.321697-1-saravanak@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 17 Aug 2022 15:01:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUHg+HokA63Y74EJ8OUkb6Lbvf7Fa2MX5Vdtoz6ri-otg@mail.gmail.com>
Message-ID: <CAMuHMdUHg+HokA63Y74EJ8OUkb6Lbvf7Fa2MX5Vdtoz6ri-otg@mail.gmail.com>
Subject: Re: [PATCH v1 0/9] fw_devlink improvements
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Tony Lindgren <tony@atomide.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
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

Hi Saravana,

On Wed, Aug 10, 2022 at 8:00 AM Saravana Kannan <saravanak@google.com> wrote:
> This patch series improves fw_devlink in the following ways:
>
> 1. It no longer cares about a fwnode having a "compatible" property. It
>    figures this our more dynamically. The only expectation is that
>    fwnode that are converted to devices actually get probed by a driver
>    for the dependencies to be enforced correctly.
>
> 2. Finer grained dependency tracking. fw_devlink will now create device
>    links from the consumer to the actual resource's device (if it has one,
>    Eg: gpio_device) instead of the parent supplier device. This improves
>    things like async suspend/resume ordering, potentially remove the need
>    for frameworks to create device links, more parallelized async probing,
>    and better sync_state() tracking.
>
> 3. Handle hardware/software quirks where a child firmware node gets
>    populated as a device before its parent firmware node AND actually
>    supplies a non-optional resource to the parent firmware node's
>    device.
>
> 4. Way more robust at cycle handling (see patch for the insane cases).
>
> 5. Stops depending on OF_POPULATED to figure out some corner cases.
>
> 6. Simplifies the work that needs to be done by the firmware specific
>    code.
>
> This took way too long to get done due to typo bugs I had in my rewrite or
> corner cases I had to find and handle. But it's fairly well tested at this
> point and I expect this to work properly.
>
> Abel & Doug,
>
> This should fix your cyclic dependency issues with your display. Can you
> give it a shot please?

Thanks for to your series!

> Geert,
>
> Can you test the renesas stuff I changed please? They should continue
> working like before. Any other sanity test on other hardware would be
> great too.

At first, this series looked like a total disaster, introducing
several regressions[1].

However, after applying the additional fix from
https://lore.kernel.org/lkml/CAGETcx-JUV1nj8wBJrTPfyvM7=Mre5j_vkVmZojeiumUGG6QZQ@mail.gmail.com
all regressions[1] went away, and /sys/kernel/debug/devices_deferred
is empty again.

Note that the Ethernet PHY interrupt on Koelsch is not fixed, so the issue from
https://lore.kernel.org/all/CAMuHMdWo_wRwV-i_iyTxVnEsf3Th9GBAG+wxUQMQGnw1t2ijTg@mail.gmail.com/
is still present.

Summary: while this series (+ the additional fix) doesn't seem to
introduce any regressions on Renesas ARM platforms, it doesn't seem
to fix anything for me neither.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

[1]

R-Mobile APE6 (ape6evm):
    No "deferred probe pending" messages?

    # cat /sys/kernel/debug/devices_deferred
    ee120000.mmc platform: wait for supplier sd1
    ee100000.mmc platform: wait for supplier sd0
    ee200000.mmc platform: wait for supplier mmc0
    keyboard platform: wait for supplier keyboard

R-Mobile A1 (armadillo-800-eva):
    No soundcards found.
    platform backlight: deferred probe pending
    i2c 0-0030: deferred probe pending (RTC)
    platform sound: deferred probe pending
    platform fe1f0000.sound: deferred probe pending
    platform keyboard: deferred probe pending (gpio-keys)
    platform e6850000.mmc: deferred probe pending (SDHI)
    platform e6bd0000.mmc: deferred probe pending (SDHI)

    # cat /sys/kernel/debug/devices_deferred
    backlight platform: wait for supplier backlight
    0-0030 i2c: wait for supplier rtc
    sound asoc-simple-card: parse error
    fe1f0000.sound platform: wait for supplier sounda
    keyboard platform: wait for supplier keyboard
    e6850000.mmc platform: wait for supplier sd0
    e6bd0000.mmc platform: wait for supplier mmc0

SH-Mobile AG5 (kzm9g):
    No soundcards found.
    platform sound: deferred probe pending
    platform ec230000.sound: deferred probe pending

    # cat /sys/kernel/debug/devices_deferred
    sound asoc-simple-card: parse error
    ec230000.sound platform: wait for supplier sounda

    Note: This is the only board where gpio-keys still works!

R-Car M2-W (koelsch):

    i2c-demux-pinctrl i2c-12: failed to setup demux-adapter 0 (-19)
    i2c-demux-pinctrl i2c-13: failed to setup demux-adapter 0 (-19)
    i2c-demux-pinctrl i2c-14: failed to setup demux-adapter 0 (-19)

    i2c-demux-pinctrl i2c-13: Failed to create device link with hdmi-in
    i2c-demux-pinctrl i2c-13: Failed to create device link with hdmi-out

    No soundcards found.

    Some I2C-busses are missing, but not listed in
/sys/kernel/debug/devices_deferred?
    /devices/platform/soc/e6518000.i2c
    /devices/platform/soc/e6530000.i2c
    /devices/platform/soc/e6520000.i2c

    platform keyboard: deferred probe pending
    platform sound: deferred probe pending
    platform feb00000.display: deferred probe pending

    # cat /sys/kernel/debug/devices_deferred
    keyboard platform: wait for supplier keyboard
    sound asoc-simple-card: parse error
    feb00000.display rcar-du: failed to initialize DRM/KMS

R-Car Gen3 (Salvator-X(S), Ebisu)
    platform keys: deferred probe pending (gpio-keys)

    # cat /sys/kernel/debug/devices_deferred
    keys platform: wait for supplier keys

RZ/A (rskrza1, rza2mevb)
    No "deferred probe pending" messages?
    # cat /sys/kernel/debug/devices_deferred
    keyboard platform: wait for supplier keyboard

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

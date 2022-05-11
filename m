Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27876523BF8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345869AbiEKRx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345868AbiEKRxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:53:54 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F98621A952;
        Wed, 11 May 2022 10:53:53 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id m20so5542596ejj.10;
        Wed, 11 May 2022 10:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=20318/xvPXu2lxX8X9tVBy9ShWnG5kb0p7KIWm6bilY=;
        b=JhwCo1D5QmYppFs7JgZN+Z1pfDhfm374tctxpKM/EvNUTf8teix+UoxWxHTlqIgQU6
         p1t5nB782rusQ3nkFO8wA3iFptOukcRDowcFR96BfOF5UDs1dJwN2tBXPsMDiOeofRp3
         Xb8m22WFI6FbzSbfk7mvNd6koLTB4U0CZITZTpzr7lsDXmKMBr13C4TfUmHULvxXiZT+
         zMzyOhR6DRohpqj2EbducUCZV2c9nieHO73muzMM3HUp4G5P0mzmgP+EduQsZVrnLkv6
         XDXPilhxlLJ/MApYsWpaNvCcvPc1g/unY/sjRejpX83J88JbZ5z2nyq7SW///qK4oMEI
         +uLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=20318/xvPXu2lxX8X9tVBy9ShWnG5kb0p7KIWm6bilY=;
        b=d3YNWI7aV7+39si42NZxJdm08zsUWIDG4LL2ImYXWLLCxYYVdhEf230Yo/cgQnvCow
         RJ/Cp9KjCGJ7/dhUyEOarzc0kWV+n2txoB/QdGEOmdmAEY0q/LPjmAx8aT04tVvf9suw
         kj9VRoSup5EADHmWZgeV5pMJosuDwxX4H3/VcRk/93UGjZeC0Crl+oJS746zNsfc2pjf
         51C3/Yy9vddJx1S7IJZitpCN9qYikMmvIdSf1+jiGeFGKlFXAQb5FpQiueEAt6DHoFuL
         MIY537emUW9nOvXw1D/58q2WR49Mi9y6Y6IxNF61p5opgIagt34/ucjfCohkIkp8sdBB
         uzMw==
X-Gm-Message-State: AOAM533rnvHaBIQhxIDmfQ7U5GPlUHt2UUOSdQq/5XKmR7bOpllM2DKg
        4AyDEPGf2FpemFyh+rsGty5am9WsCWqNPELMYEg=
X-Google-Smtp-Source: ABdhPJxLMXfl6V1uz22UIQH2xA7vQHrxBxFcksWT+mePA5R6lPB9wyRPj6nwxmx2HuPq5Ms9yAFMlx+fSjhE4qq5i34=
X-Received: by 2002:a17:906:3ce9:b0:6ef:a8aa:ab46 with SMTP id
 d9-20020a1709063ce900b006efa8aaab46mr25724454ejh.579.1652291631524; Wed, 11
 May 2022 10:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220511153905.13980-1-henning.schild@siemens.com> <20220511153905.13980-5-henning.schild@siemens.com>
In-Reply-To: <20220511153905.13980-5-henning.schild@siemens.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 11 May 2022 19:53:15 +0200
Message-ID: <CAHp75VdSYgAj-8scpZK1EmiNywuji6cpsCWnCo+6vqqdEvg+5w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] leds: simatic-ipc-leds-gpio: add GPIO version of
 Siemens driver
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-watchdog@vger.kernel.org, Enrico Weigelt <lkml@metux.net>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 6:40 PM Henning Schild
<henning.schild@siemens.com> wrote:
>
> On Apollo Lake the pinctrl drivers will now come up without ACPI. Use
> that instead of open coding it.
> Create a new driver for that which can later be filled with more GPIO
> based models, and which has different dependencies.

...

> +static struct gpiod_lookup_table simatic_ipc_led_gpio_table = {
> +       .dev_id = "leds-gpio",
> +       .table = {
> +               GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 51, NULL, 0, GPIO_ACTIVE_LOW),
> +               GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 52, NULL, 1, GPIO_ACTIVE_LOW),
> +               GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 53, NULL, 2, GPIO_ACTIVE_LOW),
> +               GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 57, NULL, 3, GPIO_ACTIVE_LOW),
> +               GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 58, NULL, 4, GPIO_ACTIVE_LOW),
> +               GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 60, NULL, 5, GPIO_ACTIVE_LOW),
> +               GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 56, NULL, 6, GPIO_ACTIVE_LOW),
> +               GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 59, NULL, 7, GPIO_ACTIVE_HIGH),

> +       }

Keeping a comma is good here.

> +};

...

> +       /* PM_BIOS_BOOT_N */
> +       gpiod = gpiod_get_index(&simatic_leds_pdev->dev, NULL, 6, 0);

This is basically GPIOD_ASIS...

> +       if (IS_ERR(gpiod)) {
> +               err = PTR_ERR(gpiod);
> +               goto out;
> +       }

> +       gpiod_set_value(gpiod, 0);

...but you may apply GPIOD_OUTPUT_LOW there and drop this call.

> +       gpiod_put(gpiod);

Ditto for the rest GPIO requests.

...

> +static struct platform_driver simatic_ipc_led_gpio_driver = {
> +       .probe = simatic_ipc_leds_gpio_probe,
> +       .remove = simatic_ipc_leds_gpio_remove,
> +       .driver = {
> +               .name = KBUILD_MODNAME,
> +       }
> +};

> +

No need to have this blank line.

> +module_platform_driver(simatic_ipc_led_gpio_driver);

-- 
With Best Regards,
Andy Shevchenko

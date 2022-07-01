Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D235631D1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237104AbiGAKqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237096AbiGAKqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:46:42 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023787E01C;
        Fri,  1 Jul 2022 03:46:36 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id r3so3342538ybr.6;
        Fri, 01 Jul 2022 03:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RWCMizkXva41Nm1wqlGXLvbQDsWrO1ICOtX0qSZGbJo=;
        b=XYyB8IdTaXHGEitNXV+dgDP8Tx5lfY9J/39gAzlPnOPe57t3dV44GcU5DqByaWhnBt
         c3cXvHd6Yu1OaeIiB80MwSS98vYnk9JPM/UNneYKTFc6UuPycV8UhPy00m2+b7duuEIW
         VOvJ0PqiVKsORGTH6H01GBaQTizG23QTIpoT4Z/iCxcZDW5ef6pKhaCCbHar8PmmYVb0
         gUBdl83IL39y5E1xSTBLW/CTA00cm60OOFTxaUkmj5003Jk1U4ZRASxC+22hIHG8AWia
         FzjlBhOOwmEaMoCcCGzZYO56zahDUKoqMdUL06TmeITaRNV2u775WDUhbJBO5nYN0I0b
         SOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RWCMizkXva41Nm1wqlGXLvbQDsWrO1ICOtX0qSZGbJo=;
        b=vYWE2KXwLPC4JtbxA/Jme5s4QqO1Os+3gUYNqHZrxnnPxPf/8ZrXh/lqLyqN9pp1RV
         PZ+wvpdaim3xYagTYmZ+aGta3S+vxr36DyZA/TMAeKUI9luuUAIyjircWHno6/pZpeZ3
         MYQpavQbmwPbovUrUrm6nLyTVM2DqkGw8DLRk7npudBYiOlnocsCsU8utEW+oTw5Gg5f
         nqa7EbuTEg7BZIafhIH2CyMXhh9hSKCuShsvk8jlz04+5XdbL2AlHKy0lGI7Hd/AFU74
         HOWeglqBffsYK3IiwRWBRmi627RJoDS08NXbNHdPTepcZrvFuglBhGKXUrb9xLKm6eoL
         tARg==
X-Gm-Message-State: AJIora/Yw4LQ1AntjU/EnvBEO3VCKI/8lGPR/W/n73qZ0/CWrIlYn9JA
        Z+rTR9UQ/8Rq9Ezug6RmfNoZ4QglhjRKn8d2ESZlOMuhWmDibYBPDBs=
X-Google-Smtp-Source: AGRyM1t8n7hxMdE5FzKlZGrnuS1T6c61dW+z5ixhFpQmMQxwN2OkLejdcuV+aH191xXe8O6/lwJovM0emTmsE+xWVJA=
X-Received: by 2002:a25:dd83:0:b0:66c:8d8d:4f5f with SMTP id
 u125-20020a25dd83000000b0066c8d8d4f5fmr14396420ybg.79.1656672395126; Fri, 01
 Jul 2022 03:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220701091412.20718-1-henning.schild@siemens.com> <20220701091412.20718-2-henning.schild@siemens.com>
In-Reply-To: <20220701091412.20718-2-henning.schild@siemens.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 1 Jul 2022 12:45:58 +0200
Message-ID: <CAHp75VcoN6eekZXPK8Kpw4aaJN7jfirnUH+1Q0JTEyLSKwrB0w@mail.gmail.com>
Subject: Re: [PATCH 1/1] gpio: nct6116d: add new driver for several Nuvoton
 super io chips
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Kuan-Wei Ho <cwho@nuvoton.com>
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

On Fri, Jul 1, 2022 at 11:15 AM Henning Schild
<henning.schild@siemens.com> wrote:
>
> This patch adds gpio support for several Nuvoton NCTXXX chips. These super
> io chips offer multiple functions of which several already have drivers in

Super-I/O (to be consistent with the help in Kconfig, etc).


> the kernel, i.e. hwmon and wdt.

watchdog

...

Since you are talking about authorship in the cover letter, is it
possible to get the original authorship to be preserved in the commit
and authors / co-developers giving their SoB tags?

...

> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/gpio/driver.h>

Keep it sorted?

...

> +#define SIO_ID_MASK            0xFFF0

GENMASK() ?

...

> +enum chips {
> +       nct5104d,
> +       nct6106d,
> +       nct6116d,
> +       nct6122d,
> +};
> +
> +static const char * const nct6116d_names[] = {
> +       "nct5104d",
> +       "nct6106d",
> +       "nct6116d",
> +       "nct6122d",

It would be slightly more flexible to use enum values as indices here:

[nct5104d] = "nct5104d",

> +};

...

> +               pr_err(DRVNAME "I/O address 0x%04x already in use\n", base);

Why not use pr_fmt() properly and drop DRVNAME here and in other pr_*(), if any?

...

> +static int nct6116d_gpio_direction_in(struct gpio_chip *chip, unsigned int offset);
> +static int nct6116d_gpio_get(struct gpio_chip *chip, unsigned int offset);
> +static int nct6116d_gpio_direction_out(struct gpio_chip *chip,
> +                                    unsigned int offset, int value);
> +static void nct6116d_gpio_set(struct gpio_chip *chip, unsigned int offset, int value);

Is it possible to avoid forward declarations?

...

> +#define NCT6116D_GPIO_BANK(_base, _ngpio, _regbase, _label)                    \
> +       {                                                               \
> +               .chip = {                                               \
> +                       .label            = _label,                     \
> +                       .owner            = THIS_MODULE,                \
> +                       .direction_input  = nct6116d_gpio_direction_in, \
> +                       .get              = nct6116d_gpio_get,          \
> +                       .direction_output = nct6116d_gpio_direction_out,        \
> +                       .set              = nct6116d_gpio_set,          \

.get_direction ?

> +                       .base             = _base,                      \
> +                       .ngpio            = _ngpio,                     \
> +                       .can_sleep        = false,                      \
> +               },                                                      \
> +               .regbase = _regbase,                                    \
> +       }

...

> +       int err;
> +       struct nct6116d_gpio_bank *bank =
> +               container_of(chip, struct nct6116d_gpio_bank, chip);

Can it be transformed to macro or inliner and then

       struct nct6116d_gpio_bank *bank = to_nct6116d_gpio_bank(chip);

> +       struct nct6116d_sio *sio = bank->data->sio;
> +       u8 dir;

Here and everywhere else, perhaps keep the reversed xmas tree order?

...

> +               err = devm_gpiochip_add_data(&pdev->dev, &bank->chip, bank);
> +               if (err) {
> +                       dev_err(&pdev->dev,
> +                               "Failed to register gpiochip %d: %d\n",
> +                               i, err);
> +                       return err;

return dev_err_probe(...);

...

> +       pr_info(DRVNAME ": Found %s at %#x chip id 0x%04x\n",
> +                       nct6116d_names[sio->type],
> +                       (unsigned int)addr,

Casting in printf() very often means a wrong specifier in use.

> +                       devid);

...

> +       nct6116d_gpio_pdev = platform_device_alloc(DRVNAME, -1);
> +       if (!nct6116d_gpio_pdev)
> +               return -ENOMEM;
> +
> +       err = platform_device_add_data(nct6116d_gpio_pdev, sio, sizeof(*sio));
> +       if (err) {
> +               pr_err(DRVNAME "Platform data allocation failed\n");
> +               goto err;
> +       }
> +
> +       err = platform_device_add(nct6116d_gpio_pdev);
> +       if (err) {
> +               pr_err(DRVNAME "Device addition failed\n");
> +               goto err;
> +       }

Wonder, don't we have some shortcuts for these? Perhaps
platform_device_register_full()?

-- 
With Best Regards,
Andy Shevchenko

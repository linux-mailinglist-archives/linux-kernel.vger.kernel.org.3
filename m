Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A8A565D27
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 19:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbiGDRjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 13:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiGDRjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 13:39:08 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B93D64D7;
        Mon,  4 Jul 2022 10:39:04 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id e69so11382067ybh.2;
        Mon, 04 Jul 2022 10:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gOTZyHFdUTa8U4zXWLRYwsWp0kE0o23lf+AazO1yZjk=;
        b=BIFnXFzZIG3+UMVOXUZw3SG3zvSK6CeFeNGZ+Jaghh4e8Qll6q5eKy6e2NxPrIplBU
         bsej8y6T9pjS/3RjC5E/ZMVZygaPw/1klpdORSnUXueRS5y3N7k0AFM+wtFe9bzW3+IS
         J88UkUl0ToTgMVR2t2wPdx9KvIpGU86OCkvNOrtErhXkGXWG0DnqrSpE89wLJCIJOQl2
         ltVz+cY/Oc6gjz7yqENP8Aln3ELbrwylSq5RhsTHSfAV72xSiXG5YK7Z2XTgF6By1EXY
         6u3+BD8c0dpIznaRpfi/MAU599qdJ5yK4xMkE+OslCC6Htot8GZ7IrF9cWXABj2EuMWX
         C0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gOTZyHFdUTa8U4zXWLRYwsWp0kE0o23lf+AazO1yZjk=;
        b=nc+JM7wi7z4KSZNpifFC0seYWqTh1VVLAggAYT/yNkjzTWE/AEPlPleKtMzxSpjXzA
         I9EU4RiA9CabSVheKUF9jU6oZILDXL2IVP7jeyqyI77xHowJbHYBS1kOhZTFwBhD/Vmh
         HSbG9vJwl5K+RfW2RMDg+4noysOVkKY3ncfqmYZJ9cfepnec0P+BExkHPZE+2VMPdP2w
         bonSqm0qa4RokPhU31Bm/DTNh7xy7Vqc9qXLkSU9S/IWRelYa8sKtesAq8IBUWL4mB/m
         8K6E3+r2J1v6mkmhPca0cVv03ApbOcVI0hZXB0xDoFzGh8L+ZQC7DAPE6tJvbWswwB2W
         4nQw==
X-Gm-Message-State: AJIora+EPvxHIbJrt5lqCwAS8mDNTjT3KXMSvT0G3rV5rOJ6gI98fnBq
        /349IGC8w1hDDZHPJR9uFO2nsUJr4tmDUDCzTqs=
X-Google-Smtp-Source: AGRyM1uQptl1N56k+FKu7zMx7GHM8ktGGH6d0GDzIzKLXwK5/2m7diRK3L8g0QPYOsKefRk4TlJSW16n3H+LnYe59gU=
X-Received: by 2002:a5b:68a:0:b0:66e:472a:83f4 with SMTP id
 j10-20020a5b068a000000b0066e472a83f4mr7754072ybq.570.1656956343261; Mon, 04
 Jul 2022 10:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220704130602.12307-1-henning.schild@siemens.com> <20220704130602.12307-2-henning.schild@siemens.com>
In-Reply-To: <20220704130602.12307-2-henning.schild@siemens.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Jul 2022 19:38:26 +0200
Message-ID: <CAHp75VdTJZ+4wF-AXbj2ERQ6zW-a+JpnO8gfO6T+LhFJyzBhJg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] gpio: nct6116d: add new driver for several Nuvoton
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

On Mon, Jul 4, 2022 at 3:06 PM Henning Schild
<henning.schild@siemens.com> wrote:
>
> This patch adds gpio support for several Nuvoton NCTXXX chips. These

GPIO

s/This patch adds/Add/

> Super-I/O chips offer multiple functions of which several already have
> drivers in the kernel, i.e. hwmon and watchdog.

Seems better, my comments below.

...

> +#include <linux/gpio/driver.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>

At least types.h and bits.h are missed here.

...

> +#define gpio_dir(base) ((base) + 0)
> +#define gpio_data(base) ((base) + 1)

Can you prefix them? gpio_ namespace is not owned by this driver and
may collide with something in the future.

...

> +       if (dir & 1 << offset)

Missed BIT(offset) ?

> +               return GPIO_LINE_DIRECTION_OUT;

...

> +static int __init
> +nct6116d_gpio_device_add(const struct nct6116d_sio *sio)
> +{
> +       int err;
> +
> +       nct6116d_gpio_pdev = platform_device_alloc(KBUILD_MODNAME, -1);
> +       if (!nct6116d_gpio_pdev)
> +               return -ENOMEM;
> +
> +       err = platform_device_add_data(nct6116d_gpio_pdev, sio, sizeof(*sio));
> +       if (err) {
> +               pr_err("Platform data allocation failed\n");
> +               goto err;
> +       }
> +
> +       err = platform_device_add(nct6116d_gpio_pdev);
> +       if (err) {
> +               pr_err("Device addition failed\n");
> +               goto err;
> +       }
> +
> +       return 0;

platform_device_register_full() ?

Yeah, just read your other message. Can you drop an excerpt here to
see how it looks?

> +err:
> +       platform_device_put(nct6116d_gpio_pdev);
> +
> +       return err;
> +}

...

> +static int __init nct6116d_gpio_init(void)
> +{
> +       struct nct6116d_sio sio;
> +       int err;
> +
> +       if (nct6116d_find(0x2e, &sio) &&
> +           nct6116d_find(0x4e, &sio))
> +               return -ENODEV;
> +
> +       err = platform_driver_register(&nct6116d_gpio_driver);
> +       if (!err) {

if (err)
  return err;


> +               err = nct6116d_gpio_device_add(&sio);
> +               if (err)
> +                       platform_driver_unregister(&nct6116d_gpio_driver);
> +       }
> +
> +       return err;
> +}

--
With Best Regards,
Andy Shevchenko

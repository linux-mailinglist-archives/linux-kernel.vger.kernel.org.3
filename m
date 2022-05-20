Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB4752ED7C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 15:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349962AbiETNti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 09:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236525AbiETNtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 09:49:31 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8346216D4A5;
        Fri, 20 May 2022 06:49:30 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id rs12so4009563ejb.13;
        Fri, 20 May 2022 06:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vLu6prHE7CXUmpUtYCqU/VlBGj2MznfppHbEU5NVX48=;
        b=N9cHE+cMf4gYMXLgkqEgNtyHL9BZ9o5tzR31xFjwHF0V8HddVlxGGzjTqvFC6mF6tS
         Bqdoxw0pmdtsvorcrIoS8vrO1IdnqYUmHBxeP0R9hLjgYsIg25edbuUm3vttaywz88AR
         uMN+14dZXH/xTZ2zNclfm5auurIPGsRZy15KKUZnK/KfxqeCM0F+Tg+ViPTzL2YIVnk3
         hIr1ln2/8tukjEe63snmQBwFoeXSbLdcTtyEsBuH12cHfHT5ovkbworONslL5dtliDjH
         NOCTyevP45qqR9tOuKlVXlF2zmgfpldPJNG2m37oFBsyOodHB0LWBflLGCs4BerxwJO0
         JexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vLu6prHE7CXUmpUtYCqU/VlBGj2MznfppHbEU5NVX48=;
        b=eVcKz770JTSwlPz0eIn5TLpPw2J2F6YMgedo7wd7E/1rnKnNW1bO9raUwehj4XzqYx
         W3mmyocLByJzRr6oHB1NeDy/bH4ZhGrY9Z1sUe1Ina2jnY8i/KqCwtRjKyaZAAVv5ECX
         ftZb55U6/NQMMkqmbsxck4vmJOtgAWMM4AcztjAhXrL0vHlBP4FcMGcFNc4iGElyHC9c
         A37jhGqmAwZ/Sl8hbXgWdwkuCPYz8z0zIeMR3MiXPGMPbTbMFhl5mRpQ5GD1Lc234uIi
         ViE5rEVZZW9bOOSnRpP98XxiYrqvY99SAbaFDCywFdhsDl9R8uDfd+oLjXAegZfLLynV
         eVsg==
X-Gm-Message-State: AOAM530tfuBFzECCf47jUmxfCzVqHOhsOjF8jinJ7H23uy/nWzytDUg4
        JSzL80TEF6wxk/bs/QONWQ0A/H0W+v76A5fmypc=
X-Google-Smtp-Source: ABdhPJyufemWfCAAyN03k8cJt2zC0fl4W3n9O0xqGHX18dypGPM+f/0G/4mda4EIBQy9huNnu8/fb9Maq9joHhxdHUU=
X-Received: by 2002:a17:907:a088:b0:6f4:f661:f77a with SMTP id
 hu8-20020a170907a08800b006f4f661f77amr8866778ejc.77.1653054569000; Fri, 20
 May 2022 06:49:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220520025624.3803776-1-zheyuma97@gmail.com>
In-Reply-To: <20220520025624.3803776-1-zheyuma97@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 20 May 2022 15:48:52 +0200
Message-ID: <CAHp75Vc5MERshhsqfiG5XXREJYkWO03V0a=6v4TUKG-fPdy+sw@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: ml-ioh: Convert to use managed functions pcim*
 and devm_*
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, May 20, 2022 at 4:56 AM Zheyu Ma <zheyuma97@gmail.com> wrote:
>
>  When removing the module, we will get the following flaw:
>
> [   14.204955] remove_proc_entry: removing non-empty directory 'irq/21', leaking at least 'gpio_ml_ioh'
> [   14.205827] WARNING: CPU: 0 PID: 305 at fs/proc/generic.c:717 remove_proc_entry+0x389/0x3f0
> ...
> [   14.220613]  ioh_gpio_remove+0xc5/0xe0 [gpio_ml_ioh]
> [   14.221075]  pci_device_remove+0x92/0x240
>
> Fix this by using managed functions, this makes the error handling more
> simpler.

Thanks!

I have a few comments, but they are not critical, so either a followup
or new version depends on Bart's preferences.

...

> -       ret = pci_enable_device(pdev);
> +       ret = pcim_enable_device(pdev);
>         if (ret) {
> -               dev_err(dev, "%s : pci_enable_device failed", __func__);
> -               goto err_pci_enable;
> +               dev_err(dev, "%s : pcim_enable_device failed", __func__);
> +               return ret;

Since you touch them both, we may convert to `return
dev_err_probe(...);` pattern here and elsewhere. But it might be
better to have in the followup as logically different change.

>         }

...

> -       base = pci_iomap(pdev, 1, 0);
> +       base = pcim_iomap_table(pdev)[1];

>         if (!base) {
> -               dev_err(dev, "%s : pci_iomap failed", __func__);
> -               ret = -ENOMEM;
> -               goto err_iomap;
> +               dev_err(dev, "%s : pcim_iomap_table failed", __func__);
> +               return -ENOMEM;
>         }

These lines are dead code since you already checked
pcim_ioremap_regions(). If it doesn't fail, this one never fails.

...

> -       chip_save = kcalloc(8, sizeof(*chip), GFP_KERNEL);
> +       chip_save = devm_kcalloc(dev, 8, sizeof(*chip), GFP_KERNEL);

>         if (chip_save == NULL) {
> -               ret = -ENOMEM;
> -               goto err_kzalloc;
> +               return -ENOMEM;
>         }

The {} are redundant now and the ' == NULL' part can be replaced by '!'.

...

>                 if (irq_base < 0) {

>                         dev_warn(dev,
>                                 "ml_ioh_gpio: Failed to get IRQ base num\n");

This should be dev_err(), but you may convert it altogether to `return
dev_err_probe(...);` in the respective patch.

> -                       ret = irq_base;
> -                       goto err_gpiochip_add;
> +                       return irq_base;
>                 }
>                 chip->irq_base = irq_base;
>
>                 ret = ioh_gpio_alloc_generic_chip(chip,
>                                                   irq_base, num_ports[j]);
>                 if (ret)
> -                       goto err_gpiochip_add;
> +                       return ret;
>         }

...

>         if (ret != 0) {

Also in a separate patch you may replace all this kind of lines;

if (chip == NULL) ==> if (!chip)
if (ret != 0) ==> if (ret)

>                 dev_err(dev, "%s request_irq failed\n", __func__);
> -               goto err_gpiochip_add;
> +               return ret;

return dev_err_probe(...);
But here it's definitely in a separate patch.

>         }

-- 
With Best Regards,
Andy Shevchenko

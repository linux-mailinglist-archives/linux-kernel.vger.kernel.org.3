Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9276E4E2B41
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 15:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349655AbiCUOwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 10:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241954AbiCUOwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:52:36 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCFC13CE1;
        Mon, 21 Mar 2022 07:51:09 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id qa43so30254756ejc.12;
        Mon, 21 Mar 2022 07:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jqRjch6tyjBRaSVUUFlp08VNF6RPYjibRnCDu58F8vA=;
        b=di3CoWBOCbwf869QXrOfgLORMD8gxsbotvsj4hTYNWGdvQmAtbk65lFUkZgykBkeLl
         99ivTEOuTH07ip0ylXumguCG1bT4NRrduINA2LBku3wfEb9qUcpmeAhh5nbWQbmL0O4N
         L0zSMPFI8/Nxx+SugpxFRqPQw3Xx3jqU7QcwVKjof2/qRnLGWpdGnrtVIGqYj1HWxaBK
         uhTOMZ4AUIaVaOtiMvUsX/ZgEVkodJhR2RZROujoIATqiaE9jhJVofphJgDJ64uAjQbL
         x/4WuI6bMWfVQ2gwBYurEQO9/DVfCvr5+Sz/DSI6nAh26AEOklXphjeAOksh5Rrl9hRL
         UqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jqRjch6tyjBRaSVUUFlp08VNF6RPYjibRnCDu58F8vA=;
        b=4Yl3LhPQ++6fvIWvUffES5diqM/3BnxO2/CHLFY8YgmjGCOpwddKA4M3ZT7bnliC+J
         SsIidE3lY8Fdfc+COiKpwT6KEucl5sFD6FRKUlKtubv7WGrGpkkOc4gD0XdIOB+92BQQ
         k9munxKHaK0JamOcTF3m8IXGHAMeuugD/RmjynDXILePPBNEj6NlEt7FpzZfPcCNwvcb
         LxvReKKYmcYli/+soV166zfui5E3tMj3DtuQ+eD3dN8GrF/3Jo4LImZuK/+lxb6+GKVF
         ArlXt7oiiKM0yrRPLZvzjYd2pfdxID772I7RCnSWs3XeAjTd8B2SsMnCtZbTznIEnqfd
         MkbA==
X-Gm-Message-State: AOAM530BanlXrgmqyzDvYEa0hA5uKLnIMYHfQRg0mVsoipBPmwvuP9EL
        ciwQ6bIdKzQVBOixmY2gUGYFT+HHMUrnKUeVqOoh7PPATxk=
X-Google-Smtp-Source: ABdhPJxiV2O0fqsz7GdPU3QAtvtcGIAvFWYk4TrrlrPLsVCxvY2GJb40FjXssPrwPxryJsTV3VfwAaLxzxH7K9Dd/cI=
X-Received: by 2002:a17:907:968e:b0:6db:aed5:43c8 with SMTP id
 hd14-20020a170907968e00b006dbaed543c8mr20870537ejc.636.1647874267193; Mon, 21
 Mar 2022 07:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220321133241.121367-1-shreeya.patel@collabora.com>
In-Reply-To: <20220321133241.121367-1-shreeya.patel@collabora.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 21 Mar 2022 16:49:56 +0200
Message-ID: <CAHp75VeoOakph=cz8Ly-mf-j4qLoeNXjr-64BeDjoKbgwiuJyg@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: Restrict usage of GPIO chip irq members before initialization
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, krisman@collabora.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        alvaro.soliverez@collabora.com
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

On Mon, Mar 21, 2022 at 3:33 PM Shreeya Patel
<shreeya.patel@collabora.com> wrote:
>
> GPIO chip irq members are exposed before they could be completely
> initialized and this leads to race conditions.
>
> One such issue was observed for the gc->irq.domain variable which
> was accessed through the I2C interface in gpiochip_to_irq() before
> it could be initialized by gpiochip_add_irqchip(). This resulted in
> Kernel NULL pointer dereference.
>
> Following are the logs for reference :-
>
> kernel: Call Trace:
> kernel:  gpiod_to_irq+0x53/0x70
> kernel:  acpi_dev_gpio_irq_get_by+0x113/0x1f0
> kernel:  i2c_acpi_get_irq+0xc0/0xd0
> kernel:  i2c_device_probe+0x28a/0x2a0
> kernel:  really_probe+0xf2/0x460
> kernel: RIP: 0010:gpiochip_to_irq+0x47/0xc0
>
> To avoid such scenarios, restrict usage of GPIO chip irq members before
> they are completely initialized.


LGTM, thanks.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> ---
>
> Changes in v3
>   - Move the gc->irq.initialized check inside gpiochip_to_irq().
>   - Rename gc to GPIO chip.
>   - Add barrier() to avoid compiler reordering.
>
> Changes in v2
>   - Make gc_irq_initialized flag a member of gpio_irq_chip structure.
>   - Make use of barrier() to avoid reordering of flag initialization
> before other gc irq members are initialized.
>
>
>  drivers/gpio/gpiolib.c      | 19 +++++++++++++++++++
>  include/linux/gpio/driver.h |  9 +++++++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index defb7c464b87..4ff68f48b87f 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1404,6 +1404,16 @@ static int gpiochip_to_irq(struct gpio_chip *gc, unsigned int offset)
>  {
>         struct irq_domain *domain = gc->irq.domain;
>
> +#ifdef CONFIG_GPIOLIB_IRQCHIP
> +       /*
> +        * Avoid race condition with other code, which tries to lookup
> +        * an IRQ before the irqchip has been properly registered,
> +        * i.e. while gpiochip is still being brought up.
> +        */
> +       if (!gc->irq.initialized)
> +               return -EPROBE_DEFER;
> +#endif
> +
>         if (!gpiochip_irqchip_irq_valid(gc, offset))
>                 return -ENXIO;
>
> @@ -1593,6 +1603,15 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
>
>         acpi_gpiochip_request_interrupts(gc);
>
> +       /*
> +        * Using barrier() here to prevent compiler from reordering
> +        * gc->irq.initialized before initialization of above
> +        * GPIO chip irq members.
> +        */
> +       barrier();
> +
> +       gc->irq.initialized = true;
> +
>         return 0;
>  }
>
> diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
> index b0728c8ad90c..f8996b46f430 100644
> --- a/include/linux/gpio/driver.h
> +++ b/include/linux/gpio/driver.h
> @@ -218,6 +218,15 @@ struct gpio_irq_chip {
>          */
>         bool per_parent_data;
>
> +       /**
> +        * @initialized:
> +        *
> +        * Flag to track GPIO chip irq member's initialization.
> +        * This flag will make sure GPIO chip irq members are not used
> +        * before they are initialized.
> +        */
> +       bool initialized;
> +
>         /**
>          * @init_hw: optional routine to initialize hardware before
>          * an IRQ chip will be added. This is quite useful when
> --
> 2.30.2
>


-- 
With Best Regards,
Andy Shevchenko

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4E74F150E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 14:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347432AbiDDMo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 08:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344509AbiDDMoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 08:44:25 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0512F3A5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 05:42:29 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id f18so5842484edc.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 05:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nl6r7LGHaO+uoAYd02qNw0V8XDaaumC9JI4DzOpeCmw=;
        b=y6nuVDeQJW9M+TB8Dpy1aNI3rKg2P8ub6PasWlkwMajLqQMJowEg7E4KuCfjCKjrsu
         AFi/KDn2Pl2Buq1VfppSz4Ic2fdzB4VDinzNScOuIHoQusTxZb/3Hu3YmgkVUreMOrQb
         xWphGbbApJZuDyyft7u25jRUxr3QkG3/9vGrwpt3o+tQDreN9y22gbf2EjBn49xPVYdy
         BWBhmY6sNg72VloW5boU0YhB/NWndiTg2THaFDKDAB4HPdl45wJfjxD85cP1AIfNUUkT
         RFVrychZVk1o9goTxqB8AHSxGd5wlgZQRm9G5p8ZjlI0HhNrEgvTCLHXvPtDUPL5gF3W
         2TgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nl6r7LGHaO+uoAYd02qNw0V8XDaaumC9JI4DzOpeCmw=;
        b=OH5uyQ8wvhZgnQYEle8+hpgxWz3RH27aDL+Kix0SXVNeNAflYmHlurNfxjr4pksLAc
         siwJUOxNze9ER+XP67Kpq5UjD6jcXmnBrwb66kC8KJ+TpJ8luk7aAYIeesLvR/DDYEIz
         omxPnn4CgxZkPEqHWkUSsbLDECdPBuvQCAHyZV/IG6aagCH9vYPpTYq7fNlfAxDzxfRi
         kcf3m3LpJ9AtWLr5jidBcbqHm5bWPvjOSTPc3en9Pqp8LI8x8f0SsRBeBq/05OoNHqx3
         Ua3MrBW8GrG2vZCz1TZ8HK23GZ2jKC4Mqn7OMb2AeKQNWG4MccoYCduErrsc7Frt/sEp
         8ZDg==
X-Gm-Message-State: AOAM5332ufNYOD8PFZED7WIFy435vx1C4kDWRIEcRIrhl+8lb0spxsQf
        8pop/gn0+utvmheCTwSKFBO0BaxdZpZW7MoWaDjz7g==
X-Google-Smtp-Source: ABdhPJx4ZhPNkg5OWfoTVWIYEuzQyZdcH7mO3QNwP4gZmzoLaFDDMbwIIOOMxo2lPoga59FIHWana+chk7U+MPLE8TA=
X-Received: by 2002:a05:6402:d4c:b0:410:a415:fd95 with SMTP id
 ec12-20020a0564020d4c00b00410a415fd95mr32484194edb.288.1649076147978; Mon, 04
 Apr 2022 05:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220321133241.121367-1-shreeya.patel@collabora.com>
In-Reply-To: <20220321133241.121367-1-shreeya.patel@collabora.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 4 Apr 2022 14:42:17 +0200
Message-ID: <CAMRc=MeZOBjZHnp7UosGuZVQfO0dBL_=cxT400suGfG-rH=_Aw@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: Restrict usage of GPIO chip irq members before initialization
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel@collabora.com, alvaro.soliverez@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 2:33 PM Shreeya Patel
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
>
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

I queued it for fixes, let's backport it to stable.

Bart

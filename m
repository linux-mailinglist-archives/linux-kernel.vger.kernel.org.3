Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0228653AA63
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 17:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349997AbiFAPq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 11:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245480AbiFAPq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:46:56 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25521209A;
        Wed,  1 Jun 2022 08:46:53 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z7so2733740edm.13;
        Wed, 01 Jun 2022 08:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UDnvyXtU+vlqVkO5xLxlQp4Wnlv5+IxV1kh3isorJ6U=;
        b=pql4MkVMXLFolDOEg8AJeelqu7u9rm+GzpS4THyJuZ72m9+hSbnUjV09tdvu60hBxF
         E8e+ntTCRRvzW2mKTaERGEqnN1rWPFT53UXzqUU5SZYPjahzs3JcrX+kNa3Gb+XjjLQe
         LPkhXcZPdn+BH4ulkKfZRm3INiJljMh+WNNztSpSV9YX0r7lHoQ8kcTiBrpyef7aqZ+Z
         UTgtT6q33mMvgeE4J/mPbuR32wdEowrcMVRn0Sw9BF66gPBjVTuQ9gSkQldbasSRew0L
         x7XYPZ1qn9to3uB+HFsX1o8YAVN234iT0FZIMdQOxJMjQaWqNS2rGjdUEJZA/sO48ENy
         9SeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UDnvyXtU+vlqVkO5xLxlQp4Wnlv5+IxV1kh3isorJ6U=;
        b=STk/LlECto5giGcFkx/QLJCIDS9s/3psJgGbGzAFssRYEe7X5fJLPzhTWjmARsr0FX
         eQp+Mkm8z7jYWuW8hHJEW3bjWthOdLQI3LFGyFctSPrUBhhyTZNnCboq/UMSklgC/9Sg
         7XH/R6wkH08g+BJC3zUq8lt+jM6nNQfr3vbllHEwXc3qnRAKtuLk3WD1EN5EEkw73BhB
         4E0e0A3SskUucYCuw60sy7bluRK+Il6DEoHWXp7KiErX6NbihupERzWOOL7OReL9Zqwi
         MKcGMlvtkdKzn+tesuwPlBDd10XxBHTditHLp66a291MdGktKon0pkzDqLIpYMucQ2T4
         dpRg==
X-Gm-Message-State: AOAM533Hx6BUXvUoAhasTcWmXXoT0fAmxwxlkmHGRkUuy/g4dIEuvO2G
        ZJoRBU3dLABEzlYuxTSNWd20yV6S934wXlSwhAg=
X-Google-Smtp-Source: ABdhPJxXujbBgy6BdqTf7MOie6rKo2p59zQBNfTU/g1xMB5WBF1EcW6Dy76NUS9tJkvxBRwsXhp88ulv67VUjQmzJJg=
X-Received: by 2002:a05:6402:11d2:b0:42d:e68a:eae0 with SMTP id
 j18-20020a05640211d200b0042de68aeae0mr340862edw.111.1654098412579; Wed, 01
 Jun 2022 08:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220601150446.25866-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220601150446.25866-1-andriy.shevchenko@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 1 Jun 2022 17:46:16 +0200
Message-ID: <CAHp75Ve3Y054nH9A-7W4iTz8DUc7-MCRQyhtXTXoOyJ3hfV43w@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] gpio: crystalcove: make irq_chip immutable
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
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

On Wed, Jun 1, 2022 at 5:04 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Since recently, the kernel is nagging about mutable irq_chips:
>
>    "not an immutable chip, please consider fixing it!"
>
> Drop the unneeded copy, flag it as IRQCHIP_IMMUTABLE, add the new
> helper functions and call the appropriate gpiolib functions.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpio-crystalcove.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpio/gpio-crystalcove.c b/drivers/gpio/gpio-crystalcove.c
> index b55c74a5e064..f40d3b133527 100644
> --- a/drivers/gpio/gpio-crystalcove.c
> +++ b/drivers/gpio/gpio-crystalcove.c
> @@ -15,6 +15,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/seq_file.h>
> +#include <linux/types.h>
>
>  #define CRYSTALCOVE_GPIO_NUM   16
>  #define CRYSTALCOVE_VGPIO_NUM  95
> @@ -238,10 +239,13 @@ static void crystalcove_bus_sync_unlock(struct irq_data *data)
>
>  static void crystalcove_irq_unmask(struct irq_data *data)
>  {
> -       struct crystalcove_gpio *cg =
> -               gpiochip_get_data(irq_data_get_irq_chip_data(data));
> +       struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
> +       struct crystalcove_gpio *cg = gpiochip_get_data(gc);
> +       irq_hw_number_t hwirq = irqd_to_hwirq(data);
> +
> +       gpiochip_enable_irq(gc, hwirq);
>
> -       if (data->hwirq < CRYSTALCOVE_GPIO_NUM) {
> +       if (hwirq < CRYSTALCOVE_GPIO_NUM) {
>                 cg->set_irq_mask = false;
>                 cg->update |= UPDATE_IRQ_MASK;
>         }
> @@ -249,23 +253,27 @@ static void crystalcove_irq_unmask(struct irq_data *data)
>
>  static void crystalcove_irq_mask(struct irq_data *data)
>  {
> -       struct crystalcove_gpio *cg =
> -               gpiochip_get_data(irq_data_get_irq_chip_data(data));
> +       struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
> +       struct crystalcove_gpio *cg = gpiochip_get_data(gc);
> +       irq_hw_number_t hwirq = irqd_to_hwirq(data);
>
> -       if (data->hwirq < CRYSTALCOVE_GPIO_NUM) {
> +       if (hwirq < CRYSTALCOVE_GPIO_NUM) {
>                 cg->set_irq_mask = true;
>                 cg->update |= UPDATE_IRQ_MASK;
>         }
> +
> +       gpiochip_disable_irq(gc, hwirq);
>  }
>
> -static struct irq_chip crystalcove_irqchip = {
> +static const struct irq_chip crystalcove_irqchip = {
>         .name                   = "Crystal Cove",
>         .irq_mask               = crystalcove_irq_mask,
>         .irq_unmask             = crystalcove_irq_unmask,
>         .irq_set_type           = crystalcove_irq_type,
>         .irq_bus_lock           = crystalcove_bus_lock,
>         .irq_bus_sync_unlock    = crystalcove_bus_sync_unlock,
> -       .flags                  = IRQCHIP_SKIP_SET_WAKE,
> +       .flags                  = IRQCHIP_SKIP_SET_WAKE | IRQCHIP_IMMUTABLE,
> +       GPIOCHIP_IRQ_RESOURCE_HELPERS,
>  };
>
>  static irqreturn_t crystalcove_gpio_irq_handler(int irq, void *data)
> @@ -353,7 +361,7 @@ static int crystalcove_gpio_probe(struct platform_device *pdev)
>         cg->regmap = pmic->regmap;
>
>         girq = &cg->chip.irq;
> -       girq->chip = &crystalcove_irqchip;
> +       gpio_irq_chip_set_chip(girq, &crystalcove_irqchip);
>         /* This will let us handle the parent IRQ in the driver */
>         girq->parent_handler = NULL;
>         girq->num_parents = 0;
> --
> 2.35.1
>


-- 
With Best Regards,
Andy Shevchenko

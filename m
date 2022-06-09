Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D90D544F7C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbiFIOgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245340AbiFIOf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:35:28 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706BA3223B5
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 07:35:26 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 25so31200774edw.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 07:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XP67le0HD8P/bxG7RrUurcaPiTA4btoBvQ2u/IlhO2I=;
        b=NDLvw77dyA9fYTorRsnUaIl50QcwPD/Xom/X1eAfvpjhIwjn7dmk/m7PJD591MxKJC
         IZZF03sZxrRoU7BkvWBwkeBzTXps0LC4ZQmej1Han8neCLZFl7X2qh7TC4emfjmCQno4
         U634GqOuTZNPVPsZ7EkGJVbkJ+mns2Vm+aU4dTXN82TjJYxap7AAnktlzwh9TZkDQWlY
         5PJNWXvwt8X14Sp+B+kwDrddulJv9WSzeOof2jWWG4/5wGzHmGye08KMyP5WchW7cBAy
         kjJvtzrGRxEF+DFyes+lqAn/y+fH7zkXQLQqt5GHUvbBYk7Ac9Nc0yv5jPHcRo6XD2j5
         yv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XP67le0HD8P/bxG7RrUurcaPiTA4btoBvQ2u/IlhO2I=;
        b=gqRDHF/esCOVQp+ueSUbHIKSdQxBYvVC2z5jcVdML/UByn3++p61HZnhwLI3KGKOx8
         3F2mDeQqqBCOFkE/QltlUKlsKleceTLFN3AiXusOHVOYLIEWp1/dUiolPQlidPeGNNb0
         6vDtiCN+eZKCHfRBA50gFncVXRCLlmTPEfbXgHqKppVIN26tcflf6ep514AXRu24HfbQ
         TOLUiT8QkyBK5sNTRHluvHXUETu7KqLXEmTK5b89hmCALfy7iNw3kVka5QgWByqqXNJX
         jS2jugytdQiKSCKbB8k9f4XMpGC76y/Q86kfrffV6I7snYvxaDu9y5KP0FYIduekGQfH
         V25g==
X-Gm-Message-State: AOAM530DZA8dLKlEoSPQLtS+LIMcP9dVU8kW5s4DL/dC1wdVvyFGQMz5
        onowilFAI1FSYP0+ZQoZQFNSOk9t5EbvhqEXP0JGOA==
X-Google-Smtp-Source: ABdhPJxbcdomQ5yEZnb6XwJ7kNy5LX2O/blxVp7XClC3O/qXsyvsjLPb5gDx9WmD6FJLcg26ONvgQSGf3PxkWVKamjk=
X-Received: by 2002:a05:6402:e0c:b0:42d:7f16:ac2c with SMTP id
 h12-20020a0564020e0c00b0042d7f16ac2cmr45213143edh.328.1654785325012; Thu, 09
 Jun 2022 07:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220607060851.10838-1-a-govindraju@ti.com>
In-Reply-To: <20220607060851.10838-1-a-govindraju@ti.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 9 Jun 2022 16:35:14 +0200
Message-ID: <CAMRc=Mdcqu5__eZPQSP3egEpw=axeeAFgGjgKdChj6tN5v1Asg@mail.gmail.com>
Subject: Re: [PATCH] gpio: davinci: Add support for system suspend/resume PM
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Devarsh Thakkar <devarsht@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 7, 2022 at 8:08 AM Aswath Govindraju <a-govindraju@ti.com> wrote:
>
> From: Devarsh Thakkar <devarsht@ti.com>
>
> Add support for system suspend/resume PM hooks, save the
> register context of all the required gpio registers on suspend
> and restore the context on resume.
>
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  drivers/gpio/gpio-davinci.c | 84 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>
> diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
> index f960587f86a3..aca352337c46 100644
> --- a/drivers/gpio/gpio-davinci.c
> +++ b/drivers/gpio/gpio-davinci.c
> @@ -23,6 +23,7 @@
>  #include <linux/irqchip/chained_irq.h>
>  #include <linux/spinlock.h>
>
> +#include <linux/pm_runtime.h>

The below can stay here but please move the pm_runtime include
together with the other linux includes.

>  #include <asm-generic/gpio.h>
>
>  #define MAX_REGS_BANKS 5
> @@ -62,6 +63,8 @@ struct davinci_gpio_controller {
>         void __iomem            *regs[MAX_REGS_BANKS];
>         int                     gpio_unbanked;
>         int                     irqs[MAX_INT_PER_BANK];
> +       struct davinci_gpio_regs context[MAX_REGS_BANKS];
> +       u32                     binten_context;
>  };
>
>  static inline u32 __gpio_mask(unsigned gpio)
> @@ -622,6 +625,86 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev)
>         return 0;
>  }
>
> +static void davinci_gpio_save_context(struct davinci_gpio_controller *chips,
> +                                     u32 nbank)
> +{
> +       struct davinci_gpio_regs __iomem *g = NULL;
> +       struct davinci_gpio_regs *context = NULL;
> +       u32 bank = 0;
> +       void __iomem *base = NULL;

Only initialize variables that need it, please.

> +
> +       base = chips->regs[0] - offset_array[0];
> +       chips->binten_context = readl_relaxed(base + BINTEN);
> +
> +       for (bank = 0; bank < nbank; bank++) {
> +               g = chips->regs[bank];
> +               context = &chips->context[bank];
> +               context->dir = readl_relaxed(&g->dir);
> +               context->set_data = readl_relaxed(&g->set_data);
> +               context->set_rising = readl_relaxed(&g->set_rising);
> +               context->set_falling = readl_relaxed(&g->set_falling);
> +       }
> +
> +       /* Clear Bank interrupt enable bit */
> +       writel_relaxed(0, base + BINTEN);
> +
> +       /* Clear all interrupt status registers */
> +       writel_relaxed(0xFFFFFFFF, &g->intstat);
> +}
> +
> +static void davinci_gpio_restore_context(struct davinci_gpio_controller *chips,
> +                                        u32 nbank)
> +{
> +       struct davinci_gpio_regs __iomem *g = NULL;
> +       struct davinci_gpio_regs *context = NULL;
> +       u32 bank = 0;
> +       void __iomem *base = NULL;
> +
> +       base = chips->regs[0] - offset_array[0];
> +
> +       if (readl_relaxed(base + BINTEN) != chips->binten_context)
> +               writel_relaxed(chips->binten_context, base + BINTEN);
> +
> +       for (bank = 0; bank < nbank; bank++) {
> +               g = chips->regs[bank];
> +               context = &chips->context[bank];
> +               if (readl_relaxed(&g->dir) != context->dir)
> +                       writel_relaxed(context->dir, &g->dir);
> +               if (readl_relaxed(&g->set_data) != context->set_data)
> +                       writel_relaxed(context->set_data, &g->set_data);
> +               if (readl_relaxed(&g->set_rising) != context->set_rising)
> +                       writel_relaxed(context->set_rising, &g->set_rising);
> +               if (readl_relaxed(&g->set_falling) != context->set_falling)
> +                       writel_relaxed(context->set_falling, &g->set_falling);
> +       }
> +}
> +
> +static int __maybe_unused davinci_gpio_suspend(struct device *dev)
> +{
> +       struct davinci_gpio_controller *chips = dev_get_drvdata(dev);
> +       struct davinci_gpio_platform_data *pdata = dev_get_platdata(dev);
> +       u32 nbank = DIV_ROUND_UP(pdata->ngpio, 32);
> +
> +       davinci_gpio_save_context(chips, nbank);
> +
> +       return 0;
> +}
> +
> +static int __maybe_unused davinci_gpio_resume(struct device *dev)
> +{
> +       struct davinci_gpio_controller *chips = dev_get_drvdata(dev);
> +       struct davinci_gpio_platform_data *pdata = dev_get_platdata(dev);
> +       u32 nbank = DIV_ROUND_UP(pdata->ngpio, 32);
> +
> +       davinci_gpio_restore_context(chips, nbank);
> +
> +       return 0;
> +}
> +
> +static const struct dev_pm_ops davinci_gpio_dev_pm_ops = {
> +       SET_SYSTEM_SLEEP_PM_OPS(davinci_gpio_suspend, davinci_gpio_resume)
> +};
> +
>  static const struct of_device_id davinci_gpio_ids[] = {
>         { .compatible = "ti,keystone-gpio", keystone_gpio_get_irq_chip},
>         { .compatible = "ti,am654-gpio", keystone_gpio_get_irq_chip},
> @@ -634,6 +717,7 @@ static struct platform_driver davinci_gpio_driver = {
>         .probe          = davinci_gpio_probe,
>         .driver         = {
>                 .name           = "davinci_gpio",
> +               .pm = &davinci_gpio_dev_pm_ops,
>                 .of_match_table = of_match_ptr(davinci_gpio_ids),
>         },
>  };
> --
> 2.17.1
>

Bart

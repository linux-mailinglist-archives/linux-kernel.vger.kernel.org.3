Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C768651BF9F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 14:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377514AbiEEMnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 08:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377465AbiEEMn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 08:43:28 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C63562C6
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 05:39:49 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ks9so2055190ejb.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 05:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Qy0A2dD0pG2b3g7kJt9R3XBemYnWmUi1/lei/Mn3Kg=;
        b=apV+M2lCzmxrkXkl/YOZ2ZchS7VFuh+64GUdQbxrZP73O2Y2WyK8BzlBD5e63KnJ5r
         QcS33LlKGXmmYxXADaN60mwwM8sthQ6o8m8Bf+ejN0zL+T7ux2MKNpH6kZAUsc5OYrFU
         qFI+3m1/ZZaLULHXb5cC+xZMIeFLGDxZaCx0rmWkQRq9lMta1pp2kLMHGe3oofQ9OmkK
         YOiO8/x1dkVFJIxnP3Zjy7FLSKJYnQgSl9RuAm2HCfPF5qLhVacv2JTn33SSON5p9f08
         dSapFGUIGAVO5ZEXgHc10PvxkCdEShTHoOEqxWeJSZDJi6vrVSh4Txm2+T7WHn1mw5or
         Ru8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Qy0A2dD0pG2b3g7kJt9R3XBemYnWmUi1/lei/Mn3Kg=;
        b=sYdwJCxymxzRmW4nTpOSO8mv8BUwO9gSHYFJq8v2VjlgFfPqm1wFgD6PNKhDl7psfP
         xNqlTukDi92BfHG2lZ68tioiqKsKmWiwD2L/kQjDijsDvuvcimHpS6F61mBTGGhhARhM
         iAl0rdIye867ljIEBUiUoar6xsXu3G6KkJpUQa+Oelt465cg+8xh/UshJ7xHRHTxd5eU
         YS+4+mMvf3Vgk+zqX1Alesmi0vmyE5Fpg9CFQM2+7bjbaTT5h5IhJEJLBJEWjjSojR63
         Jd2UhknU3AH2GCsHdA2GQIB3kHYcKcKo+rwA4+mymhDUKZtH7oQJLTUCXUfAMAnX3ar3
         9emQ==
X-Gm-Message-State: AOAM532XJFNeMgFrynSV5AzclBFoUtIB+MI0SD+b4QMyt4ZS/eV+it8f
        4G2s37Zg9KEUEQOV0k34hSMUUAnmfMXNvHrodXNCLA==
X-Google-Smtp-Source: ABdhPJwHL+dhjrBiYFtuN1w9kygL7hnns5su7zZoA5+fLD0Z8x9CsUv9BkSkolH441plWrj4N1/QpXmRAuyVO9r7gwA=
X-Received: by 2002:a17:907:c2a:b0:6f4:4b49:9cfb with SMTP id
 ga42-20020a1709070c2a00b006f44b499cfbmr18829308ejc.697.1651754387944; Thu, 05
 May 2022 05:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220421094228.2141569-1-nobuhiro1.iwamatsu@toshiba.co.jp>
In-Reply-To: <20220421094228.2141569-1-nobuhiro1.iwamatsu@toshiba.co.jp>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 5 May 2022 14:39:37 +0200
Message-ID: <CAMRc=Mf+Oz0W458GkWXTj060=QVmL78=cyDDebKWP+9NmjfdsQ@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: visconti: Fix fwnode of GPIO IRQ
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,SUSPICIOUS_RECIPS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 11:42 AM Nobuhiro Iwamatsu
<nobuhiro1.iwamatsu@toshiba.co.jp> wrote:
>
> The fwnode of GPIO IRQ must be set to its own fwnode, not the fwnode of the
> parent IRQ. Therefore, this sets own fwnode instead of the parent IRQ fwnode to
> GPIO IRQ's.
>
> Fixes: 2ad74f40dacc ("gpio: visconti: Add Toshiba Visconti GPIO support")
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>
>  v2: Add Fixes tag.
>
>  drivers/gpio/gpio-visconti.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpio/gpio-visconti.c b/drivers/gpio/gpio-visconti.c
> index 47455810bdb9..e6534ea1eaa7 100644
> --- a/drivers/gpio/gpio-visconti.c
> +++ b/drivers/gpio/gpio-visconti.c
> @@ -130,7 +130,6 @@ static int visconti_gpio_probe(struct platform_device *pdev)
>         struct gpio_irq_chip *girq;
>         struct irq_domain *parent;
>         struct device_node *irq_parent;
> -       struct fwnode_handle *fwnode;
>         int ret;
>
>         priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> @@ -150,14 +149,12 @@ static int visconti_gpio_probe(struct platform_device *pdev)
>         }
>
>         parent = irq_find_host(irq_parent);
> +       of_node_put(irq_parent);
>         if (!parent) {
>                 dev_err(dev, "No IRQ parent domain\n");
>                 return -ENODEV;
>         }
>
> -       fwnode = of_node_to_fwnode(irq_parent);
> -       of_node_put(irq_parent);
> -
>         ret = bgpio_init(&priv->gpio_chip, dev, 4,
>                          priv->base + GPIO_IDATA,
>                          priv->base + GPIO_OSET,
> @@ -180,7 +177,7 @@ static int visconti_gpio_probe(struct platform_device *pdev)
>
>         girq = &priv->gpio_chip.irq;
>         girq->chip = irq_chip;
> -       girq->fwnode = fwnode;
> +       girq->fwnode = of_node_to_fwnode(dev->of_node);
>         girq->parent_domain = parent;
>         girq->child_to_parent_hwirq = visconti_gpio_child_to_parent_hwirq;
>         girq->populate_parent_alloc_arg = visconti_gpio_populate_parent_fwspec;
> --
> 2.34.1
>
>

Queued for fixes, thanks!

Bart

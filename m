Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664E247E63C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 17:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349132AbhLWQPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 11:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349125AbhLWQPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 11:15:03 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24ADFC061757
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 08:15:03 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id x15so23418098edv.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 08:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7vIhnilgSh+Fia1MLez8IlVcdelDNWzlS9+D9/jDYmE=;
        b=mpNud0kKzvR+WQ0gBFa5kVXhk7gulH24cYrsgD/5AhkGKPs+M/vEErjulnFUs6N4A5
         DQTSYiAAmncV8N9/HfeCWWV3wOT1zoTg4cyzCO/rBm+cIDzBHBNbT01fq30TcKvvsPSo
         pcyttAnrEF7653+uOBIeS6nMlCV789/lEIFT93UcWbkO2CFh5ZoaBsjOAdw3sMjYpLgY
         crFKrA5pVvE13NVOwdtz3aDkR0WZawwXvAbeRgHqCpakYKM5NxmfBsXe1Stas5jh5vSV
         WVjzwHZn/tKw7Jat9UXoeHkQ+FB8FforGzGTDIZ+qjltxs1EuNTfdzRsIQOcSDux+9hd
         GyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7vIhnilgSh+Fia1MLez8IlVcdelDNWzlS9+D9/jDYmE=;
        b=Uy32dQF8cZjgXYK91jpGvYF3zHrhvVwZVA70kLTbDDQvNFrzX0MYWotjLeELVmRHp7
         bBpGz67GswpvcpjbxC8NiVmHbiN+kqovlp/TI1jdg0VdKVuMgOsDK8E7oo3yrxqkeUes
         l3PiaYq2jA3+4l2Ix0FoiozxFWvMY63S6/atNpGneXm7hRCP1dXy2Qdt9DCVBOoAIij7
         hI/tlh4g43BkLNUrYyI5+NHqno9oHKnUZgqI7c+okcgvhRUrL6ovMkuOIYQws3QwCQyr
         0hyakaDx0uRAGkSQA6wc6Xp1d/GSpqR4XV5DSgAj1m6JU73uzGU6zbIeSEh2Ne9dmgts
         yYhQ==
X-Gm-Message-State: AOAM530Sp7eaaaxhlTAJTJ9NlDO2fvusi9t81RS4F1U2/JJDdtQLptlb
        017Fje1hKpmTRzC/yfYhD5t6U1zWRJqILSG9pja2+YDOxDk=
X-Google-Smtp-Source: ABdhPJwYwGpkU4nU8vEiR/jvrZqHtdO6zYZ1DfYr7cVN1PStGTew60erncoMWe1J2wBUAQPAqvqaqzt66PNibkI8TtU=
X-Received: by 2002:aa7:dd59:: with SMTP id o25mr2597851edw.288.1640276101735;
 Thu, 23 Dec 2021 08:15:01 -0800 (PST)
MIME-Version: 1.0
References: <20211223121606.67055-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211223121606.67055-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 23 Dec 2021 17:14:50 +0100
Message-ID: <CAMRc=McyA5n2vYLP1pSJYuy35AjGfugaM91JYxxmrmm0Lz_Q6A@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: regmap: Switch to use fwnode instead of of_node
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Michael Walle <michael@walle.cc>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 1:16 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> GPIO library now accepts fwnode as a firmware node, so
> switch the driver to use it.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpio-regmap.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
> index 69c219742083..6383136cbe59 100644
> --- a/drivers/gpio/gpio-regmap.c
> +++ b/drivers/gpio/gpio-regmap.c
> @@ -244,16 +244,12 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
>
>         chip = &gpio->gpio_chip;
>         chip->parent = config->parent;
> +       chip->fwnode = config->fwnode;
>         chip->base = -1;
>         chip->ngpio = config->ngpio;
>         chip->names = config->names;
>         chip->label = config->label ?: dev_name(config->parent);
>
> -#if defined(CONFIG_OF_GPIO)
> -       /* gpiolib will use of_node of the parent if chip->of_node is NULL */
> -       chip->of_node = to_of_node(config->fwnode);
> -#endif /* CONFIG_OF_GPIO */
> -
>         /*
>          * If our regmap is fast_io we should probably set can_sleep to false.
>          * Right now, the regmap doesn't save this property, nor is there any
> --
> 2.34.1
>

Applied, thanks!

Bart

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A5A5A87BC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 22:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiHaUva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 16:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiHaUv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 16:51:27 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04182F14F0;
        Wed, 31 Aug 2022 13:51:24 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id q8so12014044qvr.9;
        Wed, 31 Aug 2022 13:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=F77ZSMjukIX1htEAuPVZavphrGy3kQNsKQQbF8+npDM=;
        b=NXj8J5KNtB1xYx+f13xUMw7aGumHqDF3nK9EZZnacnmQhiz6vPl5kHqVXZbOydNbYJ
         XMAQDyHyt6vKaRQeH+yV6z+K+eIC7id6NAB/7COEIkM1BTDOC9EjwwaNiuvW+wdAjY0l
         dKpV1Tl5ChwADCOAyYBF9fvDKZQF0KTSWr91lW0h+BojNDMFuXYRFVTeBdL9UGbewrXn
         hRxxKPBljR5zzZWuuGawiJRUH1S2we8mSEOHwmYMgPDM/v/+fm2mmMLGs6zOqwVgQ/qv
         xktlK9j0x2zTy1I4ImVbXZU4U04FZovhERko4AFaBRjHK1rtDEyDSRbIJYBx/G3PIaGg
         ut/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=F77ZSMjukIX1htEAuPVZavphrGy3kQNsKQQbF8+npDM=;
        b=dIsZfId2qhHTBcQMxOr6qyVweYqS/fAAzvCyJTvfUQX2yXwLZUVVd0pBMN0i/nytJv
         MNdlsyUe+k3XmEhL3j/cTMvk+P+GTIdHHtLC1CZgCMQf19uC0YV4yWIzf+r90LHx9RlG
         3BlZ2L9cRdd2E9KrjclzHkg37Q22DwHRU+lKeS6n8ugGnTv1ao+9+SXjp/mm9YuSgJtJ
         1ql4V7l/YQxl4EDVYMZjK11/b9YfGg9uWCpTalyt55k+XspHJJ3xWaeKPEYQqB8x6vha
         Iz5YBHtJn3Hxe3o9nmuZaI/daDAR5czLgv92CnhhI+R6VJkggttJILiAmlZdBGa+DiYK
         7gdQ==
X-Gm-Message-State: ACgBeo1YZ0e9ASEh3DYafztgJiznc5WLaZEKOz3dJ7tcHRybKYji48fW
        8NvwDNf+l/NqtrjqZDpEpbCGsxooIfZhD2eSWno=
X-Google-Smtp-Source: AA6agR7jKZCSkySuQI5yd5EAlqxDIg6pm0Hq2U8udUCfBuUjwlEC5WO9UaPKj+mZJQ9RqKYBx79+LVIbtlBvEH9I9I4=
X-Received: by 2002:a05:6214:27ca:b0:499:95f:6379 with SMTP id
 ge10-20020a05621427ca00b00499095f6379mr12248607qvb.82.1661979083135; Wed, 31
 Aug 2022 13:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220831055811.1936613-1-s.hauer@pengutronix.de> <20220831055811.1936613-2-s.hauer@pengutronix.de>
In-Reply-To: <20220831055811.1936613-2-s.hauer@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 31 Aug 2022 23:50:47 +0300
Message-ID: <CAHp75Vd6LCv1wcxV58Q3Pa=eBRdEK6XusbfeDQtm8+R0hAAyWg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpio: Add gpio latch driver
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Sascha Hauer <kernel@pengutronix.de>
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

On Wed, Aug 31, 2022 at 9:02 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
> This driver implements a GPIO multiplexer based on latches connected to
> other GPIOs. A set of data GPIOs is connected to the data input of
> multiple latches. The clock input of each latch is driven by another
> set of GPIOs. With two 8-bit latches 10 GPIOs can be multiplexed into
> 16 GPIOs. GPOs might be a better term as in fact the multiplexed pins
> are output only.

I'm still unsure it shouldn't be a part of the (not yet in upstream)
driver that I have mentioned before. But let's leave this apart right
now.

...

> +#include <linux/err.h>
> +#include <linux/module.h>

> +#include <linux/of_device.h>

Why?
It seems you misplaced it instead of mod_devicetable.h.

> +#include <linux/gpio/driver.h>
> +#include <linux/platform_device.h>
> +#include <linux/gpio/consumer.h>

Keep above sorted?

...

> +       struct mutex mutex;
> +       spinlock_t spinlock;

Checkpatch usually complains if locks are not commented. Looking at
the below code, why it's not an (anonymous) union?

...

> +       if (val)
> +               priv->shadow[latch] |= BIT(offset % priv->n_pins);
> +       else
> +               priv->shadow[latch] &= ~BIT(offset % priv->n_pins);

I believe shadow should be defined as unsigned long * and hence normal
bit operations can be applied. For example here is assign_bit().

...

> +       priv->shadow = devm_kcalloc(&pdev->dev, priv->n_ports, sizeof(*priv->shadow),
> +                                   GFP_KERNEL);

bitmap_zalloc()

> +       if (!priv->shadow)
> +               return -ENOMEM;

...

> +       priv->gc.parent = &pdev->dev;

> +       priv->gc.of_node = pdev->dev.of_node;

Redundant as repeating parent above.

...

> +static const struct of_device_id gpio_latch_ids[] = {
> +       {
> +               .compatible     = "gpio-latch",
> +       }, {
> +               /* sentinel */
> +       }

You may compress this to the 2 LoCs.

> +};

-- 
With Best Regards,
Andy Shevchenko

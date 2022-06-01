Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A649453AA73
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 17:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354695AbiFAPsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 11:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355840AbiFAPss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:48:48 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112EC38DB8;
        Wed,  1 Jun 2022 08:48:47 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id fu3so3151967ejc.7;
        Wed, 01 Jun 2022 08:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qIxjOQ/BiBvG7ilAoxDwbyOmhB12l869cvxwINlHsmg=;
        b=myWKseZ3bCT/Zo6L4YCDOR0GLBuS6R7FoxRn50NIUFmA11sj/5pvlrHwwwClvb4+fM
         hdp/bRAgfQ8an1AvgMaw4QNsh0iNUgvvS2YoZ4gzfvUl9Yx96O3PIZKgnmZOzBZdSg5E
         E6PTK3jQNJdOMyrJGpwtn0kHQMN+p+RyNHLuA77PiqIqQQLETSTQFn12yE06Xoc8LOS3
         OPPDVQfOHv08su2U5DWXk04u4FnI3Q3LIACAWD/86XAqTC099o//UMYSbk9q6HVjtQ9D
         cIiMNSUtRHuGARWNY1NiTPNuPoNIJmVE69EW6HC/hNOg3PRM3rnbP2ip30MgubQAnlCy
         9fgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qIxjOQ/BiBvG7ilAoxDwbyOmhB12l869cvxwINlHsmg=;
        b=1fHLsaCeIbJuCQgT3FINalAcDMd5qrXKEFHR+XpdYTgIWrCc/KJpw8ONHpUHe68RBy
         1y1uwMmZJoQb3j7TiCkl7N/4jJDSNWcKeTZZ+EDDL8Rq35JLIVErlgRl116NGLXPyAgW
         3Oon+7XmJI2QzHd3Um0vOaMvU3Pvdt4o2qESJlkGRt1BDwIM5EaXA5C5s7Y0OrdGRSOt
         NTHHZADxSIzUvxkQHe7Yh/htS/O5lLKpgL1IbmhNX8kIayOCwhV1Zl4Z9xTPBhUrLEET
         GwAilWXE0M9rs1z8TnwkeJI2COJwdcqxlCUvG3XEHlYnfRpspOV3Nb9IKH/KX39IDf1t
         E+Ww==
X-Gm-Message-State: AOAM532m8F5dg/XBSZiDLBxuZa834vkwCJlEJy6ZzgLJdeburf5aJUGB
        G5AjDAKnBLhjmT3M4qz+dGFqknHIALWtQJUyuv4=
X-Google-Smtp-Source: ABdhPJyxXh9AA4ItjPVQT20iRsQvdAT0pJHmPQafvOpj6f9UF19skFjG5UQ4hC8SflSUtFx40H67qgT5QdoG+3WJHJg=
X-Received: by 2002:a17:907:8a27:b0:707:cc50:e790 with SMTP id
 sc39-20020a1709078a2700b00707cc50e790mr132621ejc.77.1654098525425; Wed, 01
 Jun 2022 08:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220601150446.25866-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220601150446.25866-1-andriy.shevchenko@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 1 Jun 2022 17:48:08 +0200
Message-ID: <CAHp75VdezsaTyhJxhun+HG8M=q9cOQJKvNSOdcv90fXcn2mu-Q@mail.gmail.com>
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

...

> +       gpiochip_enable_irq(gc, hwirq);

I think we do not need to do this for pins that we do not touch as
IRQs (they are vGPIOs with GPE capabilities, AFAIR).

> -       if (data->hwirq < CRYSTALCOVE_GPIO_NUM) {
> +       if (hwirq < CRYSTALCOVE_GPIO_NUM) {
>                 cg->set_irq_mask = false;
>                 cg->update |= UPDATE_IRQ_MASK;
>         }

...

> -       if (data->hwirq < CRYSTALCOVE_GPIO_NUM) {
> +       if (hwirq < CRYSTALCOVE_GPIO_NUM) {
>                 cg->set_irq_mask = true;
>                 cg->update |= UPDATE_IRQ_MASK;
>         }
> +
> +       gpiochip_disable_irq(gc, hwirq);

Ditto.

-- 
With Best Regards,
Andy Shevchenko

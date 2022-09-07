Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E745AFF48
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiIGIiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiIGIiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:38:10 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD63AE87D;
        Wed,  7 Sep 2022 01:37:35 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id l5so9870860qtv.4;
        Wed, 07 Sep 2022 01:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=NEWIwwUk2NSaBA+z9rQHvgwX/oZVvP/K2rLEZAPGJC4=;
        b=kHSqQQifER8vqeU6eF7kWC4cLxZ9oF8kZrtRAZvp/7pQ5JiGlUBMgTtV9LykTLyR4W
         eCGZbRJzHpRkdABCMrtP9IhcD/cK8jMg2SFD3Wwo7FJiFQ+WKkmTEux7T2Qu2B5x88Kd
         x+baYiiN3gEHqt62NJlxYlTLsqAhDKTKSJIhUPhPkJnkjcxUAfdakxJFc6JbS/DbVst4
         J+04MKU9W3XuUtCa3tWoxHnlOLTArqs9Avjw4bhY9mOkHxQXPYnC5RZPbIN29uRIYvFh
         VhJJ8yYLyt4jDESNwgzxrHiJuluILwjeuKAw9QFvehieqVVakqszRpkbBzYRQku5ZFoL
         1Jvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=NEWIwwUk2NSaBA+z9rQHvgwX/oZVvP/K2rLEZAPGJC4=;
        b=kkC7XncocM1gKtQ4B/n/lz010JNe1NRvdxtPwGNEjqctEHK8QanXVF+Oofx7Y/xWkM
         Jqh0PxDXZHNfTur/UUEVCaGl5EP9CLhpzqYSGeeOMDL0GIubH3/vEuBQqYezHqJDtxYw
         YVkye6CE4XzKhrJRtkrroIFjD07GKByfwSNwKeFYOcJRqpGTCFQYkp6XVwZQbffpKUOI
         383sYftBz49QIY65Owxd0mZ0CcE1feYoV562Qe2FWTrbSgV3EXglETsBRv/NToYL8ViN
         WccS4woJANW2Eg0nSitCzJi5sY3uaZ4IswrqO6NrY87nFTnK6IG2OPH+/qq6rfdgJEFN
         9p9Q==
X-Gm-Message-State: ACgBeo0DiwC+XnfDs/WicqlYVBGJbVTXyOOgcZPG7ZD6YpjwCy4whpaQ
        LdLO5E5ItUKj0ygR7R3/wi1Qi8lbDx2ZDSGV7pcLFfUOD4Q=
X-Google-Smtp-Source: AA6agR585tXK8+3jXAmBRSk4xQZYDawOEG6+L58wghQEu/0tUKAUwfc8KWo+1jRzcbarw+DKD5t8iusPb+pgFMh02C8=
X-Received: by 2002:ac8:5786:0:b0:343:3051:170d with SMTP id
 v6-20020ac85786000000b003433051170dmr2193079qta.429.1662539853505; Wed, 07
 Sep 2022 01:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220907080251.3391659-1-horatiu.vultur@microchip.com>
In-Reply-To: <20220907080251.3391659-1-horatiu.vultur@microchip.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 7 Sep 2022 11:36:57 +0300
Message-ID: <CAHp75VecfNvj3Ji1ivZk3cpwbpr8F4FX0xR5H+=CjAO_o-uuxw@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: ocelot: Fix interrupt controller
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
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

On Wed, Sep 7, 2022 at 10:59 AM Horatiu Vultur
<horatiu.vultur@microchip.com> wrote:
>
> When an external device generated a level based interrupt then the
> interrupt controller could miss the interrupt. The reason is that the
> interrupt controller can detect only link changes.
>
> In the following example, if there is a PHY that generates an interrupt
> then the following would happen. The GPIO detected that the interrupt
> line changed, and then the 'ocelot_irq_handler' will be called. Here it

was called

> detects which GPIO line seen the change and for that will call the

saw

> following:
> 1. irq_mask
> 2. phy interrupt routine
> 3. irq_eoi
> 4. irq_unmask
>
> And this works fine for simple cases, but if the PHY generates many
> interrupts, for example when doing PTP timestamping, then the following
> could happen. Again the function 'ocelot_irq_handler' will be called
> and then from here the following could happen:
> 1. irq_mask
> 2. phy interrupt routine
> 3. irq_eoi
> 4. irq_unmask
>
> Right before step 3(irq_eoi), the PHY will generate another interrupt.
> Now the interrupt controller will acknowledge the change in the
> interrupt line. So we miss the interrupt.
>
> A solution will be to use 'handle_level_irq' instead of
> 'handle_fasteoi_irq', because for this will change routine order of
> handling the interrupt.
> 1. irq_mask
> 2. irq_ack
> 3. phy interrupt routine
> 4. irq_unmask
>
> And now if the PHY will generate a new interrupt before irq_unmask, the
> interrupt controller will detect this because it already acknowledge the
> change in interrupt line at step 2(irq_ack).
>
> But this is not the full solution because there is another issue. In
> case there are 2 PHYs that share the interrupt line. For example phy1
> generates an interrupt, then the following can happen:
> 1.irq_mask
> 2.irq_ack
> 3.phy0 interrupt routine
> 4.phy1 interrupt routine
> 5.irq_unmask
>
> In case phy0 will generate an interrupt while clearing the interrupt
> source in phy1, then the interrupt line will be kept down by phy0. So
> the interrupt controller will not see any changes in the interrupt line.
> The solution here is to update 'irq_unmask' such that it can detect if
> the interrupt line is still active or not. And if it is active then call
> again the procedure to clear the interrupts. But we don't want to do it
> every time, only if we know that the interrupt controller have not seen

has not seen

> already that the interrupt line has changed.
>
> While at this, add support also for IRQ_TYPE_LEVEL_LOW.

...

> +       regmap_read(info->map, REG(OCELOT_GPIO_IN, info, gpio), &val);
> +       if ((!(val & BIT(gpio % 32)) && trigger_level == IRQ_TYPE_LEVEL_LOW) ||
> +             (val & BIT(gpio % 32) && trigger_level == IRQ_TYPE_LEVEL_HIGH))
> +               active = true;

You can use temporary variable for the bit, like

  unsigned int bit = BIT(gpio % 32);

...

> +       /*
> +        * In case the interrupt line is still active and the interrupt
> +        * controller has not seen any changes in the interrupt line, then it
> +        * means that there happen another interrupt while the line was active.
> +        * So we missed that one, so we need to kick again the interrupt

the interrupt again

> +        * handler.
> +        */
> +       if (active && !ack) {
> +               struct ocelot_irq_work *work;
> +
> +               work = kmalloc(sizeof(*work), GFP_ATOMIC);
> +               if (!work)
> +                       return;
> +
> +               work->irq_desc = desc;
> +               INIT_WORK(&work->irq_work, ocelot_irq_work);
> +               queue_work(system_wq, &work->irq_work);
> +       }

Here I see potential issues with the object lifetime. 1) The memory is
allocated here and what does guarantee its freeing? 2) What does
guarantee that work will be not scheduled if the driver or its parts
are gone?

-- 
With Best Regards,
Andy Shevchenko

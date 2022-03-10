Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F126A4D4C74
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 16:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238705AbiCJO40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 09:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347324AbiCJOuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:50:44 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EBF190B41;
        Thu, 10 Mar 2022 06:46:11 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id t1so7070879edc.3;
        Thu, 10 Mar 2022 06:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i/OcMJYeAJz76fpGpL1BhdswPSzuq4p72rQrJmplRqo=;
        b=I/pSVESgWvRlX/daCIkweMDKc+r9MeMeWRXT8XKR8W1KKF5BxwAY/50ma1E+b7oLpv
         Etf2mEUpXqHBZsaOEW6nJLugtcshs1jujWbmWWehWPJNCvh+qqIKen75iGiashWEWO5L
         pEzOLnptXb3tCtrZpwEouBZeX9Plnvyu+MkjtVRPX0mDm0agtRhGbq+HMHfHyC4N2ofp
         X/EfZDUjO2Xrvih0ns5ZHt+83blptPStWrFnzC5Z0kUhXkWHSHlM0HEbH/rbgwMikzIb
         6hmoIjOCxG/HL0sOal4UeASD7HI2jLia0thANuhiG+rkn+0f3TE9LccFy5BbDNTJwrwC
         spMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i/OcMJYeAJz76fpGpL1BhdswPSzuq4p72rQrJmplRqo=;
        b=H+/EwCTqBunFMEm0ybwwNcQM2jgJXoJvX1U8uIq8KRbqq1yQ/zwYaI1WkNIpG1DsZK
         iIF2vVI5NSU2jLM+BnIlalQ0zEJiYusVk/tf0ZCKjItXEs7V+XgNNCCIU201BQvHF/CE
         6O4877hrqxB4/WFUnwwx9ZsIJPAVQX+pBaZTWOtpbkyrVjtqhsLA9eaU+zWKFOCOABax
         k2c1LufNRSuzPm3lgqK/9yRVfJu49w0z0Z1U17xUwwKdqtiXbTs663nRcx1+4zI0KGVg
         6kLDPR9yyMq2jlMhvWBhepWZLc8jv4w2HyXQhJRgBxUxCDBtf2zu3X/rbbVxz3SFVjh3
         hHPQ==
X-Gm-Message-State: AOAM530lgKCFlD/LFrNvsGV8dkwO3vPUv0CUjfRwkUEutD5MtMh8Y5QE
        +AzMEjk1zj4n4nm07n+gFCrQog6A+2VZ7WMIJ7g=
X-Google-Smtp-Source: ABdhPJxi7WPo/ObF4ZQ39dkIM68JLY3zRmGdYSzrVMJ71w2IE9gIQuraxffPU92TGUtlaspbTcOVuF3difPVKovHVqI=
X-Received: by 2002:a05:6402:d7:b0:413:673:ba2f with SMTP id
 i23-20020a05640200d700b004130673ba2fmr4621843edu.29.1646923570051; Thu, 10
 Mar 2022 06:46:10 -0800 (PST)
MIME-Version: 1.0
References: <20220310132108.225387-1-shreeya.patel@collabora.com>
In-Reply-To: <20220310132108.225387-1-shreeya.patel@collabora.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Mar 2022 16:44:53 +0200
Message-ID: <CAHp75VdGWxnxRzEhSknXHRZf1SX0x=pvca_CL0VinWNFcqCQwg@mail.gmail.com>
Subject: Re: [PATCH] gpio: Restrict usage of gc irq members before initialization
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, krisman@collabora.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>
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

On Thu, Mar 10, 2022 at 3:22 PM Shreeya Patel
<shreeya.patel@collabora.com> wrote:
>
> gc irq members are exposed before they could be completely
> initialized and this leads to race conditions.
>
> One such issue was observed for the gc->irq.domain variable which
> was accessed through the I2C interface in gpiochip_to_irq() before
> it could be initialized by gpiochip_add_irqchip(). This resulted in
> Kernel NULL pointer dereference.
>
> To avoid such scenarios, restrict usage of gc irq members before
> they are completely initialized.

Fixes tag?

...

> +bool gc_irq_initialized;

Non-static?

Why is it global?

...

> @@ -1593,6 +1594,8 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
>
>         acpi_gpiochip_request_interrupts(gc);
>
> +       gc_irq_initialized = true;

This is wrong. Imagine a system where you have more than one GPIO chip.

...

> -       if (gc->to_irq) {
> +       if (gc->to_irq && gc_irq_initialized) {
>                 int retirq = gc->to_irq(gc, offset);

Shouldn't it rather be something like

  if (gc->to_irq) {
    if (! ..._initialized)
      return -EPROBE_DEFER;
    ...
  }

?

--
With Best Regards,
Andy Shevchenko

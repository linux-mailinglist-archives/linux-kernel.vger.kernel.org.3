Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E106452C573
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 23:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243065AbiERVJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 17:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243004AbiERVIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 17:08:54 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1961A1B437C;
        Wed, 18 May 2022 14:08:53 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id n13so4283756ejv.1;
        Wed, 18 May 2022 14:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=poAMdlgLXQTMkIS8fgKzLL8994lxq2o1RAN5DIIIqcM=;
        b=hUgrXKGHUGIZBbl8I9XYfH9uW4wflRL6A40xhqtOHNyn2s/ScMigiOPqQdAZBL+cTH
         0IraWlSLjdwK2YmGmnAzHMnBljbl9SrVbtQRz4YTlJBmBUoCoNjrgYtrQfBoMKBZ0HrR
         PnEvF4FL+Sa/mncStYhShm27o1tZ/8Zca2ZotDzV8BTgQ1DW8XjSuTZdKkRtrkpdFjEH
         ljDnuncmS521mSvO6C+lahR5q7wZRcw22SaIHvJTcG71S0LcgtEjNVER2BYfukx8I5dt
         yC6UIJ6kArq8rGydSn1pkfYC1LJCQlqgbHatZQ+FfVLh+X1abarikla8wxrTR8aG3X9Y
         4XLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=poAMdlgLXQTMkIS8fgKzLL8994lxq2o1RAN5DIIIqcM=;
        b=Deml7xoBniVn7L9/s2jpQGrmcXPi7F13RPkE9yCQLkdCFeNuX2AERZVHU8X38Ixv/G
         Z7MGEJ7VkAyY1liatNG0UKrOu7EVDkac3VNUEOoaHojUjV5YCE/QN40+1GRXYTsVm9v8
         IHuYh3426sfzIJ0reYXpM4qGR8BKgrB7TQxOUpU6KrEbNaWH5PM9a2a2VXa/5zScxiT1
         Lvn4fJ9RiLx/U1tZk4/0jT8ihWZAqKRGNVCFPDwwCgSm1CId3SCA1oFXoXSbumZ1WGFy
         Sy1pQ/JkjZoorHqQQYlkIB3u401/uTZA6UYujM0TW27bCBl2RnfYGpbzSzJ9hXpz3gdX
         BSFw==
X-Gm-Message-State: AOAM5308vBx6mC0Yx3vMTbBL1n8+OtosnaMsoFJtGApev+GrJA/DocUs
        8lcZFlm5BjjwK/jglZhEaWxbs3GLTsdppG8+ueE=
X-Google-Smtp-Source: ABdhPJwFvYLZ+xzM7U+/4ei85VsSOTnLxcc8+TJ3t1hLtKLIWqJXDfgtbnn+8qMuueo8Iqc0vnAmUg/SsetyFMAie7o=
X-Received: by 2002:a17:907:868e:b0:6fa:2fe2:92d6 with SMTP id
 qa14-20020a170907868e00b006fa2fe292d6mr1296593ejc.639.1652908131493; Wed, 18
 May 2022 14:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220518192924.20948-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220518192924.20948-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220518192924.20948-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 18 May 2022 23:08:15 +0200
Message-ID: <CAHp75VfbcYCH5XgnP9VB0hX0W3_jdvSBmXSB1ANMiT66yLQvOA@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] gpio: gpiolib: Add a check to validate GPIO hwirq
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
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

On Wed, May 18, 2022 at 9:30 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> Add a check to validate GPIO hwirq is always within the range of hwirq_max
> set in the GPIO irq domain.

...

> +                       if (WARN(hwirq >= domain->hwirq_max,
> +                                "error: hwirq 0x%x is too large for %s\n",
> +                                (int)hwirq, domain->name))

Using castings in the printf() often points to possible mistakes or
missed custom specifiers.

...

> +               if (WARN(hwirq >= domain->hwirq_max,
> +                        "error: hwirq 0x%x is too large for %s\n", (int)hwirq, domain->name))

Ditto.

-- 
With Best Regards,
Andy Shevchenko

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A48456873A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 13:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbiGFLtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 07:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiGFLtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 07:49:03 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55705275E9;
        Wed,  6 Jul 2022 04:49:03 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id e69so20293009ybh.2;
        Wed, 06 Jul 2022 04:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lcQ5M5Km2OfgeROxMy5ZnJEqoGOIn28HhlbwZQ5PQj0=;
        b=p5GrKPrZDN1nvjy8BBxMksQAfYYyMnagD1K966fE07GLbwDbSf9yx3eE7NejrHgbDX
         feTiDyDd83lvsS1HAokmoZ/4I1PP0KBSwQZnT/ppaBfYhvpA6nYNy7+48INz9Pjw1SB9
         nFufm56r1gM9LTt799PE02xNyclTnFtBLbT/6yTUbxwpMYMbAOLtP2rA//dsO4cavbfx
         5r5LQZeePiKpZ6CUQy43o/NEjETZCsleyX4YwLCgcK+5setVbs80NntF/6l+ZKG/4tNI
         DhILF82XxaEYWlydXJcBpMHxkEX1dVvkIzQLDybgPS0hdsWuUFzclI+7N8rHeRYNueJe
         i/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lcQ5M5Km2OfgeROxMy5ZnJEqoGOIn28HhlbwZQ5PQj0=;
        b=W+qPrrfaGxP9/UpM21jyiJIJ7PYlNnafC81MQhc3aoEG1bKsPK/J6iSfdUWSdxWWVN
         5Dx2yYLuoRbs5qI3/aUhLm935ywkSpkMyr1K25ltFeLdpDxHIVsatg/O7NDt5Mpf9Vro
         Z+Js/HLFaplRXzrM/315ygfKStQXyKA+WKXylqvCNqqjKewTjWamsI97PWmMrHRSR7ru
         IKdnotaN/jWjrxzP8APT57SzCe7bsPtNgxKX6R3uj1NWhA0QB7up/s8HEdFIBbxRTI0I
         WaNcJfIA/sC+xoZIYnW+8HeDzyJCryehzz1qzIgc1CZfB8TXS0YXZwwESoykIrXzAqPX
         PcPA==
X-Gm-Message-State: AJIora93/O2kcJ8zk56SIjE5YONh8lPR/2+NQy1fLsjru+I6VbswcUCC
        4reyn4O3LtW0rmYpheRI1jDPmxzMuTueIqKKsDsqqOCAiRg=
X-Google-Smtp-Source: AGRyM1ukx8KknAVZRX14jVT+IZa43KEUinbk+y1Re0E9uKoJxbT1eJ8Bdhqpa1T+0UsKsYBXrQ0Rb88X6QVKfjTL19o=
X-Received: by 2002:a25:dd83:0:b0:66c:8d8d:4f5f with SMTP id
 u125-20020a25dd83000000b0066c8d8d4f5fmr42580242ybg.79.1657108142530; Wed, 06
 Jul 2022 04:49:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220705171835.4923-1-brgl@bgdev.pl>
In-Reply-To: <20220705171835.4923-1-brgl@bgdev.pl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 6 Jul 2022 13:48:26 +0200
Message-ID: <CAHp75Ve3sPhFOZhL=_2p+1avuo96CP995KD+bi+Pn3gyj1F9TA@mail.gmail.com>
Subject: Re: [PATCH] gpio: pxa: schedule a devm action for the clock struct
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>,
        "Signed-off-by : Yuan Can" <yuancan@huawei.com>
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

On Tue, Jul 5, 2022 at 7:29 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> The clock is never released after probe(). Schedule devm actions for
> putting and disabling the clock.

...

> Reported-by: Signed-off-by: Yuan Can <yuancan@huawei.com>

Me puzzled.


...

> +       ret = devm_add_action_or_reset(&pdev->dev, pxa_gpio_clk_put, clk);
> +       if (ret)
> +               return ret;
> +
>         ret = clk_prepare_enable(clk);
> +       if (ret)
> +               return ret;
> +
> +       ret = devm_add_action_or_reset(&pdev->dev,
> +                                      pxa_gpio_clk_disable_unprepare, clk);
> +       if (ret)
>                 return ret;

Can we use recently introduced clk APIs for that? Maybe Stephen has an
immutable branch you may reuse?

-- 
With Best Regards,
Andy Shevchenko

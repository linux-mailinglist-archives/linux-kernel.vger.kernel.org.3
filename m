Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96C9570AF5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 21:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiGKTwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 15:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGKTv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 15:51:59 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AC63F32B;
        Mon, 11 Jul 2022 12:51:58 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-31c9b70c382so60250907b3.6;
        Mon, 11 Jul 2022 12:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0bcHAJ8pPu9Z1dzwWU277Taf7IekpIK9rBLhRh5jWmg=;
        b=DvGAa0zK7HF46aB4MyzxMuUILtwCScFPzDzgP0it6UdyIbOGLVY1S2FdA0PbJoxiSh
         ze6DBRZBRKGCq2YdUjM3FasdOPTNoVygliP/fQlVRM+HUZWWAcXF9whSngETrgb+JsZX
         smYRS+jbDrcjrtcY2KenTHhKqZ/l4hWD1SCpANjcyh/jxQRXcxFeFKqPegE/lowVciTW
         atcfvW5Z7NyTJZIMNue0bOYSJxQV0xSzJ1SdgIgy8qD1qwHuTJGLbiJs/H7dj44+KQXc
         abg0OjJ/DfKuArHGSQ6KotSx3y6b6RQ4b5LpczBpdy0igiE+bEAfai2vdd4Z5hKJrMSr
         vy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0bcHAJ8pPu9Z1dzwWU277Taf7IekpIK9rBLhRh5jWmg=;
        b=xmDQBB/w7hzr8lOLC8uG4zKg40MomKkr60nDiS9Ni+Lb76O92D5yJ+WJ6qgudbYnka
         pft0l1nU9FsWntVIjfCL9HFJHxsJy6kbm93YT7JO2UOuWdRbAEg0+7DpeVDyQSvdLY3m
         QaftgkIGoR/2eSoOgCFI43+ghxlF4TuV4ajQh2agSlqdiiQ4M4vnBB6MNOW6Og7dlPQX
         lZpOtXZbh3zWPclVu8daRJYBPdAaoMhnjwsbDoBWZBpsyXd7TPgA4satxNCskCIC1CHi
         S7XiXoBjWa7pQtIh9eS+TmrZ7J9XodenVnh4eMryUTM1qZQ7OfKyx1kZo8PRpsbVRccE
         vZQw==
X-Gm-Message-State: AJIora+NIbyyP3AKCPT1h+SKLYefScclGyZpdQsgv+QVg6hEVENL55BZ
        HZfvTpfzG9ighKCTTv9cQoj/Voh/pKJu6zjiCMs=
X-Google-Smtp-Source: AGRyM1s0GzjIdZ6IxH9DtjsXq8yr4icmAJGSU8Bb25HOYqSIg36WSyORcHFgw/kXzLiERs5OY7g032OZCQBohYrVvnM=
X-Received: by 2002:a81:8397:0:b0:31c:8a02:3f6d with SMTP id
 t145-20020a818397000000b0031c8a023f6dmr21537093ywf.486.1657569117610; Mon, 11
 Jul 2022 12:51:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220711192113.3522664-1-horatiu.vultur@microchip.com> <20220711192113.3522664-3-horatiu.vultur@microchip.com>
In-Reply-To: <20220711192113.3522664-3-horatiu.vultur@microchip.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 Jul 2022 21:51:20 +0200
Message-ID: <CAHp75VdeZSP62qoOdQf=g4b7AheFd4=jNxfjMh-_T7Q1Zi=LbA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] pinctrl: ocelot: Fix pincfg
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        kavyasree.kotagiri@microchip.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Michael Walle <michael@walle.cc>
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

On Mon, Jul 11, 2022 at 9:17 PM Horatiu Vultur
<horatiu.vultur@microchip.com> wrote:
>
> The blamed commit changed to use regmaps instead of __iomem. But it
> didn't update the register offsets to be at word offset, so it uses byte
> offset.
> Another issue with the same commit is that it has a limit of 32 registers
> which is incorrect. The sparx5 has 64 while lan966x has 77.

...

> -static struct regmap *ocelot_pinctrl_create_pincfg(struct platform_device *pdev)
> +static struct regmap *ocelot_pinctrl_create_pincfg(struct ocelot_pinctrl *info,
> +                                                  struct platform_device *pdev)

const?

And I would leave pdev to be the first parameter, if there are no
other functions that have them like this.

-- 
With Best Regards,
Andy Shevchenko

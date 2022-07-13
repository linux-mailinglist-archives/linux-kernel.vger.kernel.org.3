Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABF75733B4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 12:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbiGMKDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 06:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234441AbiGMKDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 06:03:46 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C66DF35;
        Wed, 13 Jul 2022 03:03:45 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-31cac89d8d6so107319517b3.2;
        Wed, 13 Jul 2022 03:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gYjk25BuMhDSQ35zmvHQJKfbRO8JKe4egdencUOB3Ng=;
        b=K6551hRA1arH81z4Mjzun6igd2wv8HT1VBg/AzFdZF6dU+7eqyZfc37PVyV6TUOdJs
         bW0VXOsA8whh1SYYSbZYKmN9Ft2rCLPjLHYgS2lq9/bhxNkXebtCZJDEoUs0RpHWKSbU
         4zh1agO7a+1CR3XXpnPbUGoABxxypgKbWf6WCtKWvJTzn1JGUPZq5QvYqsSecwG0ver5
         ZSXN/8N+B1C1wE00/gAEI/WBR8XI/kQUTfGzArkGQr7KoBQfYOwmxOR4po9ZkOvjEg8z
         rgoa2Q3eMo2VVe0dfdRAVWLY+z490J3vNKnHxgYQfgc3mayHldiaDWjGZy7YICJRX1RT
         AHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gYjk25BuMhDSQ35zmvHQJKfbRO8JKe4egdencUOB3Ng=;
        b=Qk1LyoulTkS+ulBiOjZsl4AKnm4IjfnESM4Q5MmXmCQWlRqcLhRjqyOBF4hrOCpzrE
         mY6/ZXi/rvYu0KBwVu1TTlItXnrZk6NxZoO0x9HrrbwSXp4pQ4QXvhA2pSemfA1sq/nB
         ElAx45/ru8ZCjLtUq4Ure/NoILLOMJXlSYKrKmBBsXW78TBEYEhCMTKjmDj0/PNgoj5v
         ADZtdFJkL5HrvNxhioLL94VvbmO4meCkN6VvKXSTJi41lWU91L0LpcUOtgUl1Ctl9BgL
         b83yzAMHqJbSVVPwFRs9go5XbuONfPJVrDUI96T+vjyb0QCYWHOpZH3qe0xFpXNjKRmZ
         kArA==
X-Gm-Message-State: AJIora8hoafJre6MupRq8nO1GUADEciEtUayZNzn9fFOLD0YLE/QWOOu
        AJ3LjJqoLk6JTyXM6AZXzdEoSIYOzKSDmeTDaC0=
X-Google-Smtp-Source: AGRyM1uvusCX++8mkox1YoQ1Be026yN/Kojzv9GRLfYzL+xX1/J/63uUNvmNo4TO5+YJHAUfIYc1qIPYtGmzmlgqpX8=
X-Received: by 2002:a81:3984:0:b0:31c:b59e:a899 with SMTP id
 g126-20020a813984000000b0031cb59ea899mr3215851ywa.195.1657706624450; Wed, 13
 Jul 2022 03:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220713013721.68879-1-warthog618@gmail.com> <20220713013721.68879-7-warthog618@gmail.com>
In-Reply-To: <20220713013721.68879-7-warthog618@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Jul 2022 12:03:07 +0200
Message-ID: <CAHp75Vd7je7U7qsoFDz+2jcNkwCzJHJOadsaSNwk6xD2_vgdpA@mail.gmail.com>
Subject: Re: [PATCH 6/6] gpiolib: cdev: compile out HTE unless CONFIG_HTE selected
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dipen Patel <dipenp@nvidia.com>
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

On Wed, Jul 13, 2022 at 3:39 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> The majority of builds do not include HTE, so compile out hte
> functionality unless CONFIG_HTE is selected.

...

> +#ifdef CONFIG_HTE
>         /*
>          * -- hte specific fields --
>          */

Now this comment seems useless to me and it takes 3 LoCs.

...

> +       else if (IS_ENABLED(CONFIG_HTE) &&
> +                (test_bit(FLAG_EVENT_CLOCK_HTE, &line->desc->flags)))

Too many parentheses.

...

> +               if (!IS_ENABLED(CONFIG_HTE) ||
> +                   !test_bit(FLAG_EVENT_CLOCK_HTE, &line->desc->flags)) {

if (!(x && y)) ?

...

> +       if (!IS_ENABLED(CONFIG_HTE) &&
> +           (flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE))
> +               return -EOPNOTSUPP;

Ditto for consistency?

-- 
With Best Regards,
Andy Shevchenko

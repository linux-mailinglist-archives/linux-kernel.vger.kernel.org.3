Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C814D99DB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 12:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347774AbiCOLDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 07:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347771AbiCOLDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 07:03:23 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B35443F1;
        Tue, 15 Mar 2022 04:02:11 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g3so23706838edu.1;
        Tue, 15 Mar 2022 04:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NGCtJBHvVo4Lj2+TmPpGUxDP/Ezlvzgj1VYvHRGJukQ=;
        b=ow5oELPLIpGkU6tFjlv2iT5Yc4QfOrkwMYd9RcisDQuFTpGg6b/cupZgY9V/Keygmu
         3LZB5YnSLV0uqv0hIUjKrLCQhrz0jvk8jcX3t6PDHby1zP+YTP1bOrnM6n30eKMUZRI0
         PzgD37NiwSFL65DCr0X9d3vn+EC4BvFQNFzK0H4x7DEDBIFl83Y6IY6wY5OZfHnj3pkN
         oaRqEWmkalAENwOK209UtyTJd37u7b3ZJflUACH9o6LLC06TnbdKi0TGExRf4sig6Leu
         7WICaOYxjQqb19k2ViQovuOaUY4QcsZjGgIWAEzLhcWmK9YX7HZO/LMBDoyEvXDzKr4M
         hehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NGCtJBHvVo4Lj2+TmPpGUxDP/Ezlvzgj1VYvHRGJukQ=;
        b=EVCaMoewyYNHpcyoUFDN6fIhgVX6B6T9C4jNA8/pXuqvNH/zjbBV6l49bN1zqUWXv1
         Y/QA+tei0GJqHYO20SzbJHVP+ZS1csRS39aS+TSJ+FJdqqjggoDBtrQFyypi0W5hhn7K
         LPfCTTsc9GoMfWuatztnuQlUOCEbwrqPC2zJqPoYMJgQukzL97GGAXSdoiruEqCJ0uQY
         4l3cr5phUVODcEGWBi+YoLZ6h0NwI2C3QvnM/RA6sXAaYddrSVu7F4GmE417ZG6GtMGd
         gmPn9wOAFgtmeP7tgWid49JISojQTw7+0iiH+mNe0shQ6bmbh+mVWmWyn/SmtfRitLyy
         ooFw==
X-Gm-Message-State: AOAM530PEVoIssAuKYS7cSQKriueD68JR0w/hOG5kD2Gsfpc7Da4cw49
        wf/YEkZKLcNPYxdBv3z8MiejOnmUrpX4i1pX46ObImHg1c2i/A==
X-Google-Smtp-Source: ABdhPJz1skzldLmjIw0o9QXGRq15EaszDnx56RVhuy4c296ngzWUWyUbQJaX7jm5s2FiobffFqlYOtlZ4u0kPnGe6is=
X-Received: by 2002:a05:6402:b78:b0:416:171e:835d with SMTP id
 cb24-20020a0564020b7800b00416171e835dmr24302911edb.270.1647342130370; Tue, 15
 Mar 2022 04:02:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220315103813.84407-1-shreeya.patel@collabora.com>
In-Reply-To: <20220315103813.84407-1-shreeya.patel@collabora.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 15 Mar 2022 13:00:56 +0200
Message-ID: <CAHp75VdoN+iSu1GLnxWW9BtL-p9uF1sfAw3ZxkFWNpoo44+bZg@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: Restrict usage of gc irq members before initialization
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

On Tue, Mar 15, 2022 at 12:38 PM Shreeya Patel
<shreeya.patel@collabora.com> wrote:

Thanks for the update, my comments below.

> gc irq members are exposed before they could be completely

gc --> GPIO chip


> initialized and this leads to race conditions.

Any example here. like ~3-4 lines of the Oops in question?

> One such issue was observed for the gc->irq.domain variable which
> was accessed through the I2C interface in gpiochip_to_irq() before
> it could be initialized by gpiochip_add_irqchip(). This resulted in
> Kernel NULL pointer dereference.
>
> To avoid such scenarios, restrict usage of gc irq members before

gc --> GPIO chip

> they are completely initialized.

...

> +       /*
> +        * Using barrier() here to prevent compiler from reordering
> +        * gc->irq.gc_irq_initialized before initialization of above
> +        * gc irq members.
> +        */
> +       barrier();
> +
> +       gc->irq.gc_irq_initialized = true;

There are too many duplications. Why not simply call it 'initialized'?

> -       if (gc->to_irq) {
> +       if (gc->to_irq && gc->irq.gc_irq_initialized) {

Why can't this check be added into gpiochip_to_irq() ?

    if (!gc->irq.initialized)
        return -ENXIO;

...

> +       bool gc_irq_initialized;

Can you move it closer to .init_hw so it will be weakly grouped by
logic similarities?
Also see above.

-- 
With Best Regards,
Andy Shevchenko

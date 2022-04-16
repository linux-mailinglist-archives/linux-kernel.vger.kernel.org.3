Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0449D503534
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 10:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiDPIda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 04:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiDPId1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 04:33:27 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A29205F0;
        Sat, 16 Apr 2022 01:30:56 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bg10so18905296ejb.4;
        Sat, 16 Apr 2022 01:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uyzS6PDK1A1DTcnmpNFDcTGg7251/egHXs4G78IysFI=;
        b=DuYu5wgWxXanf8IMOINzvcdmqoSIsbaeg5/ekDFEKTVlK0GaFd587qGEp65QjXxkBH
         CDBZkLJaf2U//onB9px3Z+5qLoZGBQOB1bkzWymsrwuoGcbM2C3ffEhlQrTIeUa87hAH
         rOZm0UNEJsTt68sFKkq8QZv7ms78Hy/55vyiWTCAhbbtrHpnQRkT5jrA+E7rWtBH1pOV
         TnPXF4WWCAvXywjHVanYLoUBQpQ/1XiJMulPCdA7+8mOHKTNY4NBIB1tzLrXqnbiI8ds
         OGuY/EoOvM4RQCpzNKEJ/RrWtwNGkACWpE6VliogRFZFYmOPXuhuGEGsjFHZMXXPCekB
         0eVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uyzS6PDK1A1DTcnmpNFDcTGg7251/egHXs4G78IysFI=;
        b=0vFiYcnDjORjmYUsIzcEdyDhZoC81T0Ca6zjBZPWImfbRzAxhiThA5PqeztWu0f0R+
         iuSXT/nZp6l3sNlGSjrexAJnflvIGjnZz4fzxrar4jBgX7GXNZr3MRVDw7zXnkdvBlzk
         PCd0COcaq1quyXBxxbpGhg6FMOJ0T9SUTvend+SuO2f3MrwJugvsVKJr8w2qy0CA/O60
         4kgljVnWO9W+f4SpL0DQxMWtvwG+jCouo/SHrP9uzCus1sdexXEwS6hpSdAuPBhu7gn8
         D1uqrFlRhd3YH3q9dW35Cj6kPafv1hYzwVGAx4pT9kpby/UxzlRho0SIIug0aXLS1/6Q
         YgyA==
X-Gm-Message-State: AOAM533Xz+fCZzapnu2n3osLQMtpWsDDvDYBUbNX5x+b3dke1tvG+T9x
        ByyIMfjEtKUUnk+rCgUmYP4TDk5+8blumd5zzuk=
X-Google-Smtp-Source: ABdhPJyn6ybNvImMPMiNVg6dFnvufBr6BxmVI/fk3DEgG6P8XrdURkDphPh+4ghQdJxzOzvOVSNHko/c/NRYVYbrJrI=
X-Received: by 2002:a17:907:628e:b0:6d9:c6fa:6168 with SMTP id
 nd14-20020a170907628e00b006d9c6fa6168mr2036501ejc.132.1650097855153; Sat, 16
 Apr 2022 01:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220415165505.30383-1-schspa@gmail.com>
In-Reply-To: <20220415165505.30383-1-schspa@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 16 Apr 2022 11:30:19 +0300
Message-ID: <CAHp75Veo30c0BWb4Fykgvd-czSnEXsyA8wyMTeKQdS49=e5-nw@mail.gmail.com>
Subject: Re: [PATCH] gpio: use raw spinlock for gpio chip shadowed data
To:     Schspa Shi <schspa@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, opendmb@gmail.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
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

On Sat, Apr 16, 2022 at 3:45 AM Schspa Shi <schspa@gmail.com> wrote:
>
> In case of PREEMPT_RT, there is a raw_spinlock -> spinlock dependency
> as the lockdep report shows.
>
> __irq_set_handler
>   irq_get_desc_buslock
>     __irq_get_desc_lock
>       raw_spin_lock_irqsave(&desc->lock, *flags);  // raw spinlock get here
>   __irq_do_set_handler
>     mask_ack_irq
>       dwapb_irq_ack
>         spin_lock_irqsave(&gc->bgpio_lock, flags); // sleep able spinlock
>   irq_put_desc_busunlock
>
> Replace with a raw lock to avoid BUGs. This lock is only used to access
> registers, and It's safe to replace with the raw lock without bad
> influence.

> [   15.090359][    T1] =============================
> [   15.090365][    T1] [ BUG: Invalid wait context ]
> [   15.090373][    T1] 5.10.59-rt52-00983-g186a6841c682-dirty #3 Not tainted
> [   15.090386][    T1] -----------------------------

Please, reduce this very noise traceback to the point, usually it
takes ~3-5 lines only.

...

>  drivers/gpio/gpio-amdpt.c                 | 10 +++----
>  drivers/gpio/gpio-brcmstb.c               | 12 ++++----
>  drivers/gpio/gpio-cadence.c               | 12 ++++----
>  drivers/gpio/gpio-dwapb.c                 | 36 +++++++++++------------
>  drivers/gpio/gpio-grgpio.c                | 30 +++++++++----------
>  drivers/gpio/gpio-hlwd.c                  | 18 ++++++------
>  drivers/gpio/gpio-idt3243x.c              | 12 ++++----
>  drivers/gpio/gpio-ixp4xx.c                |  4 +--
>  drivers/gpio/gpio-loongson1.c             |  8 ++---
>  drivers/gpio/gpio-menz127.c               |  8 ++---
>  drivers/gpio/gpio-mlxbf2.c                | 18 ++++++------
>  drivers/gpio/gpio-mmio.c                  | 22 +++++++-------
>  drivers/gpio/gpio-sifive.c                | 12 ++++----
>  drivers/gpio/gpio-tb10x.c                 |  4 +--
>  drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c |  8 ++---
>  include/linux/gpio/driver.h               |  2 +-

Looking into the code I think we can't easily (without too much
additional churn) to split this to the series of patches. But I leave
this up to the maintainers to decide.

-- 
With Best Regards,
Andy Shevchenko

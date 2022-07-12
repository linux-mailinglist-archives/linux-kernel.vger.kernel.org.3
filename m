Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3342571D44
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbiGLOty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiGLOtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:49:51 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3237B326D7;
        Tue, 12 Jul 2022 07:49:51 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 136so14322338ybl.5;
        Tue, 12 Jul 2022 07:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7iVcCSNEDPVXZO7KkmaQ6UWTAKgIuOoWOIi+ZoUvMiI=;
        b=kB6ipQhwRymVgL6MecvMix0v5bVQaqPiDDELB6uuhqJCgucni9ofmwnblXQsmy4Dwp
         YXT3QO3CX1F8odY9GwupzSdxv5lK8H8UceT/jiFlEyBKGMJgMLh1fIyDjp9Y9XV04xZm
         K0LZB3pZFNu9hBabtegxj9/z6ijGHSq0EarHW5ckbO65k2vp1ixBaIduwMSGx0NnuGEW
         m6K2YeamWHz+dlBWaOfTXUH5xG4qe/LemopGUnmCsaCZ4z5wjj74NOuniXI0tPkc06wX
         Xje/3nicZylu9l/L9bA2b6YRKBncHict54Or5qKgVT1KEsvFEAF4BqAGcdHaQBtk05gA
         w+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7iVcCSNEDPVXZO7KkmaQ6UWTAKgIuOoWOIi+ZoUvMiI=;
        b=T7vT0xC5gYJc68YSTmnCefSk+7SZMCUeO5Tl6lQ1s1alG2sLQp9HMQJEf33Rth23ek
         33yOkX1D8dPemuDkw0dGSn8kVxa3u2FdBbsMO6BPNRcEanajba4HX1svZJ/Rsu8LT108
         AdUF9O1oE2lwv5zu+56RtEWL9whjc2/A118LQ44imyhjLAgtCQ9z8p7PTOTwyAUPUvue
         tU6cDp2JurKNBIKQueUtg4sr1M+j/WoT1Y3iC6Ks5qg1jJsRgoVigP5ij373oLq5270g
         djh0p9lkTmJpIOdD6Qi7xaT2IxRiXphn2jWLF48BjQziV/6Iowj1nNnckKAZit5YbHDN
         w3GQ==
X-Gm-Message-State: AJIora/aAAOnSbV/s4QLyRafb4JWl7VFJsFO9pFakBLQuIqJ5bxuIAdN
        zOwiyY5Oz29nMNMwC/vxScm98fC26Y6HYGn0OyY=
X-Google-Smtp-Source: AGRyM1u8xxquE10f6yTO7C4T8Li18XfMHlXCfwSUMfAeX5wy3klYVBZK3dXatnRZC6nKrV1LWitwOC3d3GqqLff+8ck=
X-Received: by 2002:a05:6902:10c9:b0:668:e27c:8f7 with SMTP id
 w9-20020a05690210c900b00668e27c08f7mr22824445ybu.128.1657637390435; Tue, 12
 Jul 2022 07:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220712143237.13992-1-henning.schild@siemens.com> <20220712143237.13992-2-henning.schild@siemens.com>
In-Reply-To: <20220712143237.13992-2-henning.schild@siemens.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Jul 2022 16:49:13 +0200
Message-ID: <CAHp75VfCDRRS+WdyN-s5h+C7wnpFOpxOp7DU9_X5rpkL32M45g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] gpio: nct6116d: add new driver for several Nuvoton
 super io chips
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Kuan-Wei Ho <cwho@nuvoton.com>
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

On Tue, Jul 12, 2022 at 4:32 PM Henning Schild
<henning.schild@siemens.com> wrote:
>
> This patch adds gpio support for several Nuvoton NCTXXX chips. These
> Super-I/O chips offer multiple functions of which several already have
> drivers in the kernel, i.e. hwmon and watchdog.

...

> +#include <linux/gpio/driver.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>

+ bits.h
+ types.h.

...

> +static inline int superio_enter(int base)
> +{
> +       /* Don't step on other drivers' I/O space by accident. */
> +       if (!request_muxed_region(base, 2, KBUILD_MODNAME)) {
> +               pr_err("I/O address 0x%04x already in use\n", base);
> +               return -EBUSY;
> +       }
> +
> +       /* According to the datasheet the key must be send twice. */

sent

> +       outb(SIO_UNLOCK_KEY, base);
> +       outb(SIO_UNLOCK_KEY, base);
> +
> +       return 0;
> +}

...

> +#define gpio_dir(base) ((base) + 0)
> +#define gpio_data(base) ((base) + 1)

Dunno, why haven't you changed this? It might be a hidden mine for the
future GPIO library development. I recommend using namespace whenever
it feels right, and here it's exactly the case.

> +       if (dir & 1 << offset)

Another ignored comment... BIT(offset)

I'm stopping here to let you double check what version you have sent.

-- 
With Best Regards,
Andy Shevchenko

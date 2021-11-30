Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E7A46312F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 11:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbhK3Kl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 05:41:29 -0500
Received: from mail-vk1-f169.google.com ([209.85.221.169]:37423 "EHLO
        mail-vk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbhK3Kl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 05:41:28 -0500
Received: by mail-vk1-f169.google.com with SMTP id e27so13261179vkd.4;
        Tue, 30 Nov 2021 02:38:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zEj8NBQjLbsOVUD9Cul394pEoRRBEePEWmIxln6/XGY=;
        b=B+gD2l7ink7J/PaqALdt2vld/Ffm29QAECdiWIY15XXuaOGIrAp4qdiW9b73Twt5aG
         bp7ZzCkthnn8oJBCQ+s7PdZLzvJBW8Mh3YOZRSh8GQ/NOpbFhaqdPy9vrHzHVmGJa907
         vg7BUTwYUTgoDkdOjmoolKw/CEjPk94f0NWCxlWzOs7D8P6VsyBtPfxxlDkq4ifvfQy3
         zxjygKqV9OUQkxBuPVSPsj4oy5LUA8DowzRGKdz0Sn18IeI8XE8mDSgKyHpiXRaPomDS
         0MBodToTAOhiyHiGZeU0DOX40zz9llU0RYeJRvb0+Lnkj8IuI+XS4jZW96ViYmdAsKQw
         wYbQ==
X-Gm-Message-State: AOAM531/uFVC06gsLzWnUL0v7pNA70QdBlbZTxTHDeY6EqIaLWhcXvFI
        67I2t/qhhzy0jghLPkF2DC+l6S/fqhN2hQ==
X-Google-Smtp-Source: ABdhPJwaV0O0fJIbUxYc8ii1M/kw4LHfmXHKS+5l4j7PWt7Bgz0TPQKHvP+B1QzB/VBVBe8QBvUYNg==
X-Received: by 2002:a05:6122:1313:: with SMTP id e19mr43938780vkp.4.1638268688696;
        Tue, 30 Nov 2021 02:38:08 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id t132sm9462699vkb.19.2021.11.30.02.38.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 02:38:08 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id n6so40424704uak.1;
        Tue, 30 Nov 2021 02:38:07 -0800 (PST)
X-Received: by 2002:a67:c106:: with SMTP id d6mr39218065vsj.77.1638268687771;
 Tue, 30 Nov 2021 02:38:07 -0800 (PST)
MIME-Version: 1.0
References: <20211123164902.35370-1-wsa+renesas@sang-engineering.com> <20211123164902.35370-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20211123164902.35370-2-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 30 Nov 2021 11:37:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUGOEmB8QeHufXVHifYpvZxNpu_kku05eGKk=+YRf+PsQ@mail.gmail.com>
Message-ID: <CAMuHMdUGOEmB8QeHufXVHifYpvZxNpu_kku05eGKk=+YRf+PsQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] gpio: add sloppy logic analyzer using polling
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Tue, Nov 23, 2021 at 5:49 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> This is a sloppy logic analyzer using GPIOs. It comes with a script to
> isolate a CPU for polling. While this is definitely not a production
> level analyzer, it can be a helpful first view when remote debugging.
> Read the documentation for details.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -74,6 +74,7 @@ obj-$(CONFIG_GPIO_IT87)                       += gpio-it87.o
>  obj-$(CONFIG_GPIO_IXP4XX)              += gpio-ixp4xx.o
>  obj-$(CONFIG_GPIO_JANZ_TTL)            += gpio-janz-ttl.o
>  obj-$(CONFIG_GPIO_KEMPLD)              += gpio-kempld.o
> +obj-$(CONFIG_GPIO_SLOPPY_LOGIC_ANALYZER) += gpio-sloppy-logic-analyzer.o
>  obj-$(CONFIG_GPIO_LOGICVC)             += gpio-logicvc.o
>  obj-$(CONFIG_GPIO_LOONGSON1)           += gpio-loongson1.o
>  obj-$(CONFIG_GPIO_LOONGSON)            += gpio-loongson.o

(noticed while resolving a merge conflict with the out-of-tree
 gpio-litex)

Please preserve sort order, cfr. the (hilarious?) comment at the top
of the list:

    # Device drivers. Generally keep list sorted alphabetically
    obj-$(CONFIG_GPIO_REGMAP)       += gpio-regmap.o
    obj-$(CONFIG_GPIO_GENERIC)      += gpio-generic.o

    # directly supported by gpio-generic

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

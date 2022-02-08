Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90D84AD771
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355784AbiBHLfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356935AbiBHLNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:13:32 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426C3C03FEC7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 03:13:31 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id u18so36356773edt.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 03:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3G2225l3e7AAW7cvW9DSbSKu70gKYyiFP+/P2AbU0GE=;
        b=Xyf7gEeeFQZpkKXO8gzF2AgluqdrifnT/FgKVNNk/lOKTNzDZiaZpxWZkJBQ3wk8ue
         hYn6eA9FXNG9IBGN9B+GjYUHQ8714SRdBNzbQJ82JTECIlg3js0Ids8PtzlFJlwQ8/No
         KjSJpWys4J2GcMk8T8YisSEgyfTJXbUXne3m/y0TCeoQoimlXHHwP1M4P31cZ7kOgtbc
         +zWBrbmshVSmfUyRDLeErcgLx7SVrFU5Zk0tjgRWRfH+3NXn/PL8N0Wfp1ujODljr+4m
         cAdFJR6/y3QWMGHdJ/QVE6BBFoYdz9z3MzSn6nX0V+TefwaKjnvOZqYCVvi9JflBbb1S
         qJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3G2225l3e7AAW7cvW9DSbSKu70gKYyiFP+/P2AbU0GE=;
        b=3davzk8ulLQJDrzVnmXp+IzQhZ72cS6D3p8dFfnQnNiba7+kG/1XKo1DL/UrMFKI6t
         B/oCQRkbUQgeqqI8x6DnOxfQ/emW4tgVJ3SvmoZ/6G7xsFtDZuyJfLRjNHzqqndYxyrV
         yvMz2sXykis/S4JiGXcOfzrVguhW+MUAdYl0PrIhPG+Ct5qlCGokdsJEniOl0jmutz/n
         SpsAQQMiCy/s4rInu/98xggnMqzvXunkZS85exrs2FciBsIkTEDHkdqrfQCKuxpNghm3
         xO+VS9Z8kAxSlVAjQgAQdqd1PoTTiBDxemS0YWv8qxPEo/wK1AkLIoP9K/jDpnxhLl7t
         6erg==
X-Gm-Message-State: AOAM532ysx2/CYPhRLVPjIuS/LuV0p/iCInEM2x0gSMat2XTdEWdBBXY
        nRn3b46AkTOhYGnWTd0y5zcPb5UNW1J50Kr5UdegxA==
X-Google-Smtp-Source: ABdhPJywJZL0jTPvvCbkGnYtFW82KoshEzkqB1HixUSDNK3JM1+qqwgc2BPOGxgMTLyu8AS04o5CLxS9fyGFvEJzrWk=
X-Received: by 2002:aa7:db49:: with SMTP id n9mr3902542edt.100.1644318809786;
 Tue, 08 Feb 2022 03:13:29 -0800 (PST)
MIME-Version: 1.0
References: <20220201120310.878267-1-maz@kernel.org>
In-Reply-To: <20220201120310.878267-1-maz@kernel.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 8 Feb 2022 12:13:19 +0100
Message-ID: <CAMRc=Me=VTqTfa4=p3HOa4_NmE3W6h+YyPLZGKXZo6dqUoxWmg@mail.gmail.com>
Subject: Re: [PATCH 00/12] genirq: Move irqchip runtime PM over to irq domain
To:     Marc Zyngier <maz@kernel.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 1:03 PM Marc Zyngier <maz@kernel.org> wrote:
>
> Our irq_chip data structure currently suffers from two problems:
>
> (1) the 'name' field is often dynamically populated with a reference
>     to the underlying HW (DT node dame, for example)
>
> (2) the 'parent_device' which is used to implement runtime PM is also
>     dynamically populated
>
> (3) there is at least one instance of a subsystem messing with the
>     internals of irq_chip structures (gpiochip_set_irq_hooks is
>     what I know about)
>
> These things mean that although the primary use of irq_chip is to only
> contain function pointers and other *static* information, the above
> two fields result in these structures being copied in a number of
> drivers. Eventually, it would be much better if the various drivers
> would use irq_chip as an 'ops' data structure (potentially made
> read-only), and keep the dynamic information somewhere more suitable.
>
> For (2) we already have the irqdomain structure that is designed to
> deal with the context in which interrupts are used, and it makes sense
> to move the 'parent_device' field over to this structure. This is what
> this small series is doing, with some minor cleanup on the way.
>
> (1) and (3) will be dealt in separate series (and I don't have a good
> solution for (3) yet).
>
> Thanks,
>
>         M.
>
> Marc Zyngier (12):
>   genirq: Allow the PM device to originate from irq domain
>   irqchip/gic: Move PM device over to irq domain
>   irqchip/renesas-intc-gpio: Move PM device over to irq domain
>   irqchip/renesas-irqc: Move PM device over to irq domain
>   irqchip/imx-intmux: Move PM device over to irq domain
>   gpio: mt7621: Kill parent_device usage
>   gpio: omap: Move PM device over to irq domain
>   gpio: rcar: Move PM device over to irq domain
>   gpio: tpmx86: Move PM device over to irq domain
>   pinctrl: npcm: Fix broken references to chip->parent_device
>   pinctrl: starfive: Move PM device over to irq domain
>   genirq: Kill irq_chip::parent_device
>
>  drivers/gpio/gpio-mt7621.c                |  1 -
>  drivers/gpio/gpio-omap.c                  |  7 ++++---
>  drivers/gpio/gpio-rcar.c                  |  2 +-
>  drivers/gpio/gpio-tqmx86.c                |  3 ++-
>  drivers/irqchip/irq-gic.c                 | 12 +++++------
>  drivers/irqchip/irq-imx-intmux.c          |  8 +++-----
>  drivers/irqchip/irq-renesas-intc-irqpin.c |  3 ++-
>  drivers/irqchip/irq-renesas-irqc.c        |  3 ++-
>  drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c | 25 +++++++++++------------
>  drivers/pinctrl/pinctrl-starfive.c        |  3 ++-
>  include/linux/irq.h                       |  2 --
>  include/linux/irqdomain.h                 | 10 +++++++++
>  kernel/irq/chip.c                         | 20 +++++++++++++-----
>  13 files changed, 59 insertions(+), 40 deletions(-)
>
> --
> 2.30.2
>

The changes for GPIO are small so:

Acked-by: Bartosz Golaszewski <brgl@bgdev.pl>

You can take it through your tree and if there are any conflicts, I'll
just ask for an immutable branch.

Bart

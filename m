Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B46B47F3A8
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 16:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbhLYPhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 10:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbhLYPhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 10:37:02 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C3EC061401;
        Sat, 25 Dec 2021 07:37:01 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id m21so45180148edc.0;
        Sat, 25 Dec 2021 07:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NAXB74HtZUnY5cdy1xAYOyfilFfhS2klWgSDR15UTmA=;
        b=DsfRr4NTaqBSW5zWy4oahlH5JRTyUiZ4a8ZoRFjjdaIjbvbMXoMkvK9InRYNy/bao3
         cfWA/R1oOB/ClVnN3rA0PhCVibG/OLtRmU3LB23vJ43D12vi6x7WueaCmDgl8JMd1bSE
         HrKkOY9jWo0FgikL0gFyThubS2ZDSFQuqJyX9bmf1dztaI1EiwFyVHGx67XxO9N0ouln
         i9bvWmBPc5VE4c1bdgKBcx5u+dyTfXpkmlDtlnT2HZdyhwUgblPmpjWj02zCiZ4i5P6n
         dvrptZ17w2HiqGdHnLWXsTLamPUVjG6gZuCISgm5Ng/1YMD0743zr2YSAEwJ6zYSVxXx
         aeIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NAXB74HtZUnY5cdy1xAYOyfilFfhS2klWgSDR15UTmA=;
        b=fDgb0Z+ndoeKqeB5mriFtl16Iug76KvGpPdKV9sSW2EKsVHzBhORRKl45rTE5hUHxt
         PNgCMbz0I+FzEJQWbbDi39di3oQFNzibO61jhpMUJuserBvAm1LvSGj21dSpzpSmhPOZ
         67t2QlagMTY+GzF2Is4pUcBMyRMn8U+tfyIo/x9xAQyd56PEoqjCDYjNQQAHv9CEQwIQ
         yYzlr6m4U4qAMKsDdDUjKE3fNLGqMb7Q1GD3TjlaOrzBvXjtuHjkVltGVBZ6TO47t7Fd
         GgxlrxozhLA6u7W6IOlhOMewt5UXkIf1pJk8dLvPwylQQi2nlYoscbzib1AzqjlWrIUZ
         VqXA==
X-Gm-Message-State: AOAM5317smamTNo6IvXGxQPMKZohivaSsPr+HkNYeA8QXYc2akEryuhH
        LnTambBs5hj/loftlTUsrDt+l5z/Xd+XwOpxWvM=
X-Google-Smtp-Source: ABdhPJw+9aLmZ5FSvg94YO3m9Uhx31b6XHhD9/2hc0AKZHA7pZBuICfdwOf8kTnimk9PYJjkBPxSCf8McQYU0CHxDk0=
X-Received: by 2002:a17:907:97cd:: with SMTP id js13mr8486074ejc.497.1640446620440;
 Sat, 25 Dec 2021 07:37:00 -0800 (PST)
MIME-Version: 1.0
References: <20211224145748.18754-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20211224145748.18754-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20211224145748.18754-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 25 Dec 2021 17:36:24 +0200
Message-ID: <CAHp75VdTOHK4NaYWLmtotzBrGZBkokpC9iK9ggfhiTzyz-QNQg@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: at91-pio4: Use platform_get_irq_optional()
 to get the interrupt
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2021 at 3:59 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
>
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq_optional().


> +               ret = platform_get_irq_optional(pdev, i);
> +               if (ret < 0) {
>                         dev_err(dev, "missing irq resource for group %c\n",
>                                 'A' + i);
> -                       return -EINVAL;
> +                       return ret;
>                 }

This is an incorrect use of platform_get_irq_optional() (It's not
related to what Alexandre said, it's an additional comment).
NAK.

-- 
With Best Regards,
Andy Shevchenko

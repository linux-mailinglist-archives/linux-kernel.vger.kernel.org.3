Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2BC476C23
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 09:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbhLPIpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 03:45:42 -0500
Received: from mail-ua1-f54.google.com ([209.85.222.54]:40861 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhLPIpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 03:45:41 -0500
Received: by mail-ua1-f54.google.com with SMTP id y23so4152147uay.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 00:45:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vvX8zOJFhSHgycXCNJOQXo5Sjpuk0Z4idjO5IRsN1iM=;
        b=ANi8IEw/hPD+a/VZi2sW37vf3j/x74+8plf4g03WURtSRI7U8Luxb5W/3hKbOahd3v
         RQD4/hwP3db+II5w5qQOQtdDfRf8xesYSrgKXThMqAEdbBJTZXFl4thyXseeSvDmL+lf
         //Ri9QTPHj8Zu/JRU9KO1ws7BNg5GWL1GsZ739a6ltQgtBYFR5lxmGaF37jZ8XHYgHU5
         1wyV1ZCsh43msHFFmZKK7f+0NgXcgcXg+86/jLUbYyNYgDgzxWxwNNXrLGYd6U2q1wsU
         N0SVfbZbhF+lnyl5S2kWYzR6Avo1p1cG4QIBZspSTsAlSetv+ZGFc8RCr/drrvPJ1HMt
         fGiQ==
X-Gm-Message-State: AOAM533VKN1UYDDkk3gzXNqVayQLMqvsYkoQDjksiFxy50o2W8uxnPF8
        U4BBIoWl37ngYni4jVY3lrif4Fkf4+ccRA==
X-Google-Smtp-Source: ABdhPJyiPf/B+4u/K5ohyWdsxfJy30QHOxFyLgLutR/+O+mNT1x9nJohDcD2Vbo2hP4dcYhj7BEQCw==
X-Received: by 2002:a67:c809:: with SMTP id u9mr5048521vsk.84.1639644340930;
        Thu, 16 Dec 2021 00:45:40 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id c14sm960018vkm.10.2021.12.16.00.45.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 00:45:40 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id y23so4152071uay.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 00:45:40 -0800 (PST)
X-Received: by 2002:a05:6102:c89:: with SMTP id f9mr5174273vst.68.1639644340147;
 Thu, 16 Dec 2021 00:45:40 -0800 (PST)
MIME-Version: 1.0
References: <20211215234448.5631-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20211215234448.5631-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 16 Dec 2021 09:45:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXObL9brpFQL87qe79HcxXjjMqQ_oKdEwcRyH0CW1mJeg@mail.gmail.com>
Message-ID: <CAMuHMdXObL9brpFQL87qe79HcxXjjMqQ_oKdEwcRyH0CW1mJeg@mail.gmail.com>
Subject: Re: [PATCH] irqchip/renesas-intc-irqpin: Use platform_get_irq_optional()
 to get the interrupt
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Thu, Dec 16, 2021 at 12:45 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypassed the hierarchical setup and messed up the
> irq chaining.
>
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq_optional().
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

> --- a/drivers/irqchip/irq-renesas-intc-irqpin.c
> +++ b/drivers/irqchip/irq-renesas-intc-irqpin.c

> @@ -418,12 +417,14 @@ static int intc_irqpin_probe(struct platform_device *pdev)
>
>         /* allow any number of IRQs between 1 and INTC_IRQPIN_MAX */
>         for (k = 0; k < INTC_IRQPIN_MAX; k++) {
> -               irq = platform_get_resource(pdev, IORESOURCE_IRQ, k);
> -               if (!irq)
> +               ret = platform_get_irq_optional(pdev, k);
> +               if (ret == -EPROBE_DEFER)
> +                       goto err0;
> +               if (ret < 0)
>                         break;

Shouldn't all errors be considered fatal, except for -ENXIO (no
interrupt)?

>
>                 p->irq[k].p = p;
> -               p->irq[k].requested_irq = irq->start;
> +               p->irq[k].requested_irq = ret;
>         }
>
>         nirqs = k;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

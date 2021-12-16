Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1716B476C2E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 09:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbhLPIrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 03:47:55 -0500
Received: from mail-vk1-f174.google.com ([209.85.221.174]:46772 "EHLO
        mail-vk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbhLPIrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 03:47:53 -0500
Received: by mail-vk1-f174.google.com with SMTP id u198so369644vkb.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 00:47:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mTDl2tDe1MCuLOu0VUv1k0aEawBwMuuqAro2EoOFX3g=;
        b=xwJwQGVcPePToIzsuXWo3N2gj6Lfj4BpErrhBb0WKlE/PCixQlpwBVadv/ibbqsXpo
         LAmx5tKAUa+LOSMSs8NX/LoUPYcyeTAbs14FddsqPEtbji1G3ZUe3jF1USqptZPqVeOp
         kJYJkhBVDIrJR1tcofmvKLBnAQTtBUrDO61EtWdyuj8VJbVdZgXQQ0tJeriPFjIiOl+s
         rvO9ltPFkAAnFQno9X5n4QaxqxGC8FAu/LkkgEH41r2dsmgZ6S2iwuLWvvcSpnwmzRDE
         f8fb4pDWGwVL51EAl8PMkVSk30zbE9SHijlzJRvVaS76w0uDaYgl5JCJYbNJANtVF5uZ
         g92w==
X-Gm-Message-State: AOAM5331Vd18zLeqAj96N5LDNl84iv8Jr8UC9IBOvQ9JafODM/pbaTPh
        pdZl5+Knj+2yf6jguosbK6NurUupCiPrtw==
X-Google-Smtp-Source: ABdhPJwe/wj6jrgQSX5JE1L1EVdhbXAgFwNPEVeM1DskXMrqG0T81p6TkobNhvjS6awWcUE4U68eCA==
X-Received: by 2002:a1f:cd83:: with SMTP id d125mr5902968vkg.17.1639644472881;
        Thu, 16 Dec 2021 00:47:52 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id b13sm976551vkn.38.2021.12.16.00.47.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 00:47:52 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id 30so45870627uag.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 00:47:52 -0800 (PST)
X-Received: by 2002:a05:6102:21dc:: with SMTP id r28mr5084450vsg.57.1639644472105;
 Thu, 16 Dec 2021 00:47:52 -0800 (PST)
MIME-Version: 1.0
References: <20211215234946.6494-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20211215234946.6494-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 16 Dec 2021 09:47:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW9A0ieNunJ0VLw8qJ8rmWepViwHkAiB=Z=ub72wQhZfQ@mail.gmail.com>
Message-ID: <CAMuHMdW9A0ieNunJ0VLw8qJ8rmWepViwHkAiB=Z=ub72wQhZfQ@mail.gmail.com>
Subject: Re: [PATCH] irqchip/renesas-irqc: Use platform_get_irq_optional() to
 get the interrupt
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Thu, Dec 16, 2021 at 12:50 AM Lad Prabhakar
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

Thanks for your patch!

> --- a/drivers/irqchip/irq-renesas-irqc.c
> +++ b/drivers/irqchip/irq-renesas-irqc.c

> @@ -142,13 +141,15 @@ static int irqc_probe(struct platform_device *pdev)
>
>         /* allow any number of IRQs between 1 and IRQC_IRQ_MAX */
>         for (k = 0; k < IRQC_IRQ_MAX; k++) {
> -               irq = platform_get_resource(pdev, IORESOURCE_IRQ, k);
> -               if (!irq)
> +               ret = platform_get_irq_optional(pdev, k);
> +               if (ret == -EPROBE_DEFER)
> +                       goto err_runtime_pm_disable;
> +               if (ret < 0)
>                         break;

Same comment as for the other patch: shouldn't all errors be
considered fatal, except for -ENXIO (no interrupt)?
>
>                 p->irq[k].p = p;
>                 p->irq[k].hw_irq = k;
> -               p->irq[k].requested_irq = irq->start;
> +               p->irq[k].requested_irq = ret;
>         }
>
>         p->number_of_irqs = k;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

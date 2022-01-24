Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455EB497C85
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 10:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236893AbiAXJ6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 04:58:25 -0500
Received: from mail-vk1-f172.google.com ([209.85.221.172]:38482 "EHLO
        mail-vk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbiAXJ6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:58:20 -0500
Received: by mail-vk1-f172.google.com with SMTP id l196so6890884vki.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 01:58:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0qAilIt3zBRIhtEfQ4Mef/PuAGXLqiFVxp/VPi3j/sQ=;
        b=f3cFJ7ryDdgu2FwRVJySqec+waY7XKb92GIATZvjYtSVYw9kHoGS66n5c3k7doOQpv
         GWs2cMOFcFJmny/6BmZ1nqp0lopQXrzso20oD+lU2q/n/xHXr+XPULlgpEqKB+1a+agD
         59IBLq0qK7//yg1Gy8gKQv2uu9CV1EluQb5zRzvADXKkUx+GcPpSEiFcibC3SI/v6uwH
         z46FeWY+5eqUfJUryS1OU+oidvJ5w+fKXfL9HtHKiUOe9DtoTyJ2ijfAB9NuvAGzXJbd
         eugZ3KuqzdOf8EZO+DVbMQWnn3so+HTGsE7e31QGhaLuwcG0roFsQQbNRu2r4E1X3IVs
         ZmtQ==
X-Gm-Message-State: AOAM5324VUk5nXvnPDybkF0HARYuOhOXMMzFi7oVUi3MtoiVdtfv6QsI
        iMk1CELAGCOBP0s9qS6GHRdTZnhjHigXtg==
X-Google-Smtp-Source: ABdhPJylCI8RL57z5NEUIYQ6m235IpkTQeVK3Bd4j7DRYnIA61Gn2Q77LBCZqWQuRDt/3oIaiAW9GA==
X-Received: by 2002:a1f:a6d7:: with SMTP id p206mr5631365vke.31.1643018299613;
        Mon, 24 Jan 2022 01:58:19 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id 10sm2403564uaq.9.2022.01.24.01.58.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 01:58:19 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id b37so12143564uad.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 01:58:19 -0800 (PST)
X-Received: by 2002:a67:c18e:: with SMTP id h14mr1390246vsj.5.1643018298119;
 Mon, 24 Jan 2022 01:58:18 -0800 (PST)
MIME-Version: 1.0
References: <20220119201741.717770-1-nikita.yoush@cogentembedded.com>
In-Reply-To: <20220119201741.717770-1-nikita.yoush@cogentembedded.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Jan 2022 10:57:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXqG_qp0XL7OLLdHKpYJ=xAG+hTMxPctAbeBfUV9EpodQ@mail.gmail.com>
Message-ID: <CAMuHMdXqG_qp0XL7OLLdHKpYJ=xAG+hTMxPctAbeBfUV9EpodQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: irqchip: add irq-type-changer
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

On Wed, Jan 19, 2022 at 9:17 PM Nikita Yushchenko
<nikita.yoush@cogentembedded.com> wrote:
> Irq type changer is a virtual irqchip useful to support boards that
> change (e.g. invert) interrupt signal between producer and consumer.
>
> Usage example, for Kingfisher extension board for Renesas Gen-3 Soc,
> that has WiFi interrupt delivered over inverting level-shifter:
>
> / {
>         gpio1_25_inverted: inverter {
>                 compatible = "linux,irq-type-changer";
>                 interrupt-controller;
>                 #interrupt-cells = <2>;
>                 interrupt-parent = <&gpio1>;
>                 interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
>         };
> };
>
> &wlcore {
>         interrupt-parent = <&gpio1_25_inverted>;
>         interrupts = <0 IRQ_TYPE_EDGE_RISING>;
> };
>
> Then, wlcore driver observes IRQ_TYPE_EDGE_RISING trigger type and
> configures interrupt output as such. At the same time, gpio-rcar driver
> gets interrupt configured for IRQ_TYPE_EDGE_FALLING.
>
> This version uses hierarchical irq_domain API, and works only with
> parent interrupt domains compatible with that API.
>
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/irqchip/irq-type-changer.c
> @@ -0,0 +1,162 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/irqchip.h>
> +#include <linux/irqdomain.h>
> +#include <linux/of_irq.h>
> +
> +struct changer {
> +       unsigned long count;
> +       struct {
> +               struct irq_fwspec fwspec;
> +               unsigned int type;
> +       } out[0];

Please use [] instead of [0] for flexible arrays, else the compiler
doesn't realize it is a flexible array, and won't complain if you add
more members below.

> +};

> +static int __init changer_of_init(struct device_node *node,
> +                                 struct device_node *parent)
> +{
> +       struct irq_domain *domain, *parent_domain;
> +       int count, i, ret;
> +       struct changer *ch;
> +       struct of_phandle_args pargs;
> +       irq_hw_number_t unused;
> +
> +       if (!parent) {
> +               pr_err("%pOF: no parent node\n", node);
> +               return -EINVAL;
> +       }
> +
> +       parent_domain = irq_find_host(parent);
> +       if (!parent_domain) {
> +               pr_err("%pOF: no parent domain\n", node);
> +               return -EINVAL;
> +       }
> +
> +       if (WARN_ON(!parent_domain->ops->translate))
> +               return -EINVAL;
> +
> +       count = of_irq_count(node);
> +       if (count < 1) {
> +               pr_err("%pOF: no interrupts defined\n", node);
> +               return -EINVAL;
> +       }
> +
> +       ch = kzalloc(GFP_KERNEL, sizeof(*ch) + count * sizeof(ch->out[0]));

Oops, wrong parameter order, as detected by the  kernel test robot.
Please use struct_size() to simplify and harden the size calculation.


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

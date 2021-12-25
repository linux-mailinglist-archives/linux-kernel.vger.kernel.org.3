Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E2F47F3F4
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 18:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbhLYRCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 12:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhLYRCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 12:02:03 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F55C061401;
        Sat, 25 Dec 2021 09:02:02 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id x15so44635943edv.1;
        Sat, 25 Dec 2021 09:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=allLbQ90rxouBvcpZIIL+jJIydJg34w7sYljavKuAz0=;
        b=DFfBC5s44n3NXp3E91x7/nUEN6IDHJU/8wHBeCR0dDrqbCS1HK5/7GXaWohCMMzA4J
         1cYTFNav5i0mcOri6+8LP3u+qK3tWetD15HVUo0jr4sgHbkPsfzDMHl1aXLdSyx8QIQk
         IrQbh4afBETKgEqGpb02LKWNUZQFk2OxL1Wep4fjXcHXpNvAFWeAXHtfCBRN9ZFa4Ntg
         Osn/WH54KmgAmi9yuVr/0iKH1Zu2pHeCHgbQXZun0puPeWV9RnCdhXfyL8xWKDznBAW4
         pep1f1H6P2qB/YG9kdyIRa4vRcp1NWgg892+E9gvm6glM8wQkWwhRfr88Vd+haDG+kcb
         NwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=allLbQ90rxouBvcpZIIL+jJIydJg34w7sYljavKuAz0=;
        b=56YlkqmNxwaZB96BMo0rIVe1RpwGe4nKcDLa21LPGFwDp/GjCWcGS2zbkE1CnW1/tI
         Ih6pW/rWIk7QJHi+s1hmPZpLdy/a0h7DmQKAnoQBJG3qm7FiGwAfUZWkxqG1Sb2LuDzL
         PGuAiVSXPyK3n4szwogL2pWl0874cpRQOYnYl2b0MY+v1op1Inhe6rwABv6iSLro4Yld
         a+jlFu22NeD3gaIg7XWSFERljLFJKtfVeTNplTVoQpcXcxEFhXTfxeb2s8eTR9ybVadR
         jm5Yk+1ycVS40CyNm+jt1ORsnZWM3UTKNUhns/jsOZjLTpW49ziJtjo7a+OZND6kGr4x
         e8/w==
X-Gm-Message-State: AOAM531XRNegP0GhFc8SagjgvAxD3d+UyLBN6TOH+mF1Y6P18LGiEawM
        /XG9ZA8AvZmcTOxZ3CD/oS+uhP/vkkxb9nD4804=
X-Google-Smtp-Source: ABdhPJxJ0LYaPiXmh+h6TqfA7IxbUrr8s+xOP/Agw9UN1zl2MdDESBev9O+182+1jNw2MqsNeOAIL+Faib8p6P/ofK0=
X-Received: by 2002:a05:6402:4301:: with SMTP id m1mr9159028edc.125.1640451721302;
 Sat, 25 Dec 2021 09:02:01 -0800 (PST)
MIME-Version: 1.0
References: <20211224131300.18198-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20211224131300.18198-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20211224131300.18198-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 25 Dec 2021 19:01:24 +0200
Message-ID: <CAHp75VdLOuzpjzrwQw71KWNM82-_TwPtYrE7ukrmZoDN3x0gQA@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] ata: pata_of_platform: Use platform_get_irq_optional()
 to get the interrupt
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2021 at 3:55 AM Lad Prabhakar
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

...

> +       irq = platform_get_irq_optional(ofdev, 0);
> +       if (irq < 0 && irq != -ENXIO)
> +               return irq;
> +
> +       if (irq > 0) {

> +               memset(&irq_res, 0x0, sizeof(struct resource));

Why do you need that variable at all?

0x0 -> 0
sizeof(irq_res)

> +               irq_res.start = irq;
> +       }

-- 
With Best Regards,
Andy Shevchenko

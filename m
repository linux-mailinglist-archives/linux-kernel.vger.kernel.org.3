Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E28348C33A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 12:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352883AbiALLe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 06:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240155AbiALLe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 06:34:26 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79933C06173F;
        Wed, 12 Jan 2022 03:34:25 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 30so8767561edv.3;
        Wed, 12 Jan 2022 03:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tGJ0ER/hWalpuO1RB5LPpHjUQJ/Sj/+tHVIicyDHTvg=;
        b=EbPV5yzYcN2EET3MshMIxIVliAPwygxATaEJVHQwVRI+jzl0gBc6rcftHUDIOkAQEm
         efS2/v1R79nkxdWpLbxg1zgGKAsjXXPuAbFO9IbSNEl57kaj5JWyAYxEpgr8PTHUESMJ
         Tf7m636cXpsL5gW5QIMe90WsHXpMXCobp+DinLA32XcWSNZ0hnqe1oA+/tno7LkBVBQP
         qmnPux+A8jnefr6Ac2QfrUDwNvcGLCilwFMWHFjYwd6wtnAWMKiiCdUPEg+BjV8TOD+g
         0TtXz5tV+VvJlRGtTarUYcA1E5XD2MwDFPoWTFLdQfg5wpShDVqnnZg8P47f002YRjix
         utPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tGJ0ER/hWalpuO1RB5LPpHjUQJ/Sj/+tHVIicyDHTvg=;
        b=O7E2feioy3rpT3WWlKZk4ptWndCcMqbyYwCgteeRyWW9l/ZACL/L3Kr+nY/tcDr99w
         wNKegS2ftK18SxZU4cwCDEc8BjKQzUPGvlqCHMJqoZpvi0M19bQLiLSsP6nImrD1iIMo
         qeUYU6UB0cqbnNqynLWOypOiIhPfBnQlPnKo90Yooiwh/+/lG4SZY2jB9n3gWCZjrmG/
         Egl428+0DoHcJnPYmol2YVEtqL6gk04+4JLNWvhxawUfND639z5qIOkzBooTFz5cbIIk
         6P6l37cZOytGo2cvwhBiqki6DHxFXnsb5tZXN+dN77IEfkoZMs7Mo5P1oVdEqtUaxxp1
         YBkg==
X-Gm-Message-State: AOAM530G0smWggekirmwxgo9l6x8fttOIgbq1Qz2YX6/L9s9bPaMV9s9
        3+72CzFGV8+ThshefVIN5iY2+x5dIscfEMyeZzMZnFy9Aes=
X-Google-Smtp-Source: ABdhPJyzEzUNR58VtS1x2+uXaIGf8JNmjGqtdD/tlbP80SJhfLpiJ0YwmU2+FGg+Kl6O0S7+x+or+OSMmXVf3Aq4VNA=
X-Received: by 2002:a17:906:b24d:: with SMTP id ce13mr2287183ejb.44.1641987263958;
 Wed, 12 Jan 2022 03:34:23 -0800 (PST)
MIME-Version: 1.0
References: <20220111194014.5908-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220111194014.5908-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 12 Jan 2022 13:32:37 +0200
Message-ID: <CAHp75VdL_v3vZwQfCqNUwg3oQbvWpq4HCL2KGbaob88-4w9RNw@mail.gmail.com>
Subject: Re: [PATCH v3] media: davinci: vpif: Use platform_get_irq_optional()
 to get the interrupt
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 9:40 PM Lad Prabhakar
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
>
> While at it, propagate error code in case devm_request_irq() fails
> instead of returning -EINVAL.

...

> +       while (1) {

The infinite loop use is discouraged.

> +               int irq;
> +
> +               err = platform_get_irq_optional(pdev, res_idx);
> +               if (err < 0 && err != -ENXIO)
> +                       goto vpif_unregister;
> +               if (err > 0)
> +                       irq = err;
> +               else
> +                       break;
> +
> +               err = devm_request_irq(&pdev->dev, irq, vpif_channel_isr,
> +                                      IRQF_SHARED, VPIF_DRIVER_NAME,
> +                                      (void *)(&vpif_obj.dev[res_idx]->channel_id));
> +               if (err)
>                         goto vpif_unregister;
> -               }
>                 res_idx++;
>         }

Slightly better

  do {
  ...
  } while (++res_idx);

...

> +       while (1) {

Ditto.

-- 
With Best Regards,
Andy Shevchenko

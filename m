Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1564B47F417
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 18:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbhLYRc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 12:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhLYRcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 12:32:54 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6678FC061401;
        Sat, 25 Dec 2021 09:32:54 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id x15so44830624edv.1;
        Sat, 25 Dec 2021 09:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7hA3vEaUDHtlb/RnlEjxAhRWJLgHlZ5Yq9n1C69h8n8=;
        b=WlISJVC80nmEzfyrb0cNoo5UNH86bU7vaS7ppzOX3dYAzEEv98k+Q1R3qK0IkdlI8+
         FXJBWS7j7iICn2GJIjD/g2wRRvujzmUxYYUzaDoxI7O3qxhsfVkFyxfnU36OxTFj1JzL
         O++gPG8eI0qOCddWpK3cU+hMMzlLl19jfBH5meXCvQ5r7ddC36ZdsM0d6FZpX2nSd+ec
         UISEBT/CZUSjK4/WlGbmN/KTSsdZhPzVExw60cVMrTEt4wme4GkjDZn9FLv9VmnDCOcA
         2j+gX+MJAbKDiakC7uNnwbdFkK97QVrHfoTm+UdnMj5O7MXEVR5SXoMu1zbBeJ5KUCYV
         D6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7hA3vEaUDHtlb/RnlEjxAhRWJLgHlZ5Yq9n1C69h8n8=;
        b=oFsZgd0L0Oh3cVkn/DgWCNJUj81U6DDmQ5srEPCOjVTzebllLudM1TiMKQPC/cCNGb
         tvnQV6wweEx/HVxBeIf3typvId72sre80qY1D/ldUIn/wOatdMdFa9WutYOwBzKKNYJO
         cKx5fxBbEcm94FabIVFGhzSozzszi5t/Fxi6a0sleChR6VItmH4mP09iJLK6fYg98V1z
         c99XHCBGNzmSLoF3c26mXH6yWbmTcsPZ3MAmsZzAR5NFqZhX1cMdbr7JtxSWnGJMaumD
         3oum1fi1arS+54J53SA1djH6blTrn/yhgapEDCDe7+TALGJVKWAcRuc+4sGPwuosH66a
         P9XA==
X-Gm-Message-State: AOAM5310BXBdpJAvwpRUGMVZugkHQUe6HScZLxXNLcMPyc4G+UpAY2KY
        cRFGKWY4i5+eXizpAsUvm3akRlKZcP7B+x2HRGc=
X-Google-Smtp-Source: ABdhPJxCn9ixI/IpsGfA5APrN63l1h69JQwI08xALHCyy0+eotTLl5H85EUZyjZqIut7zSx3mKcQ8iknsdMvFmcM/3Y=
X-Received: by 2002:a17:906:a3c6:: with SMTP id ca6mr8546557ejb.639.1640453572898;
 Sat, 25 Dec 2021 09:32:52 -0800 (PST)
MIME-Version: 1.0
References: <20211223173015.22251-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20211223173015.22251-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20211223173015.22251-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 25 Dec 2021 19:32:16 +0200
Message-ID: <CAHp75VeCwR-eP930s3miv-ux8=_P+vmdkhN+K=weTL1nwNA1ig@mail.gmail.com>
Subject: Re: [PATCH 06/13] media: davinci: vpif: Use platform_get_irq_optional()
 to get the interrupt
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2021 at 3:04 AM Lad Prabhakar
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
> Also this patch propagates error code in case devm_request_irq()
> fails instead of returing -EINVAL.

returning

...

> +       res_irq->flags = IORESOURCE_IRQ | irq_get_trigger_type(irq);
> +       res_irq->start = irq;
> +       res_irq->end = irq;
> +       res_irq->name = dev_of_node(&pdev->dev) ? of_node_full_name(pdev->dev.of_node) : NULL;

If you convert DEFINE_RES_NAMED() to return a compound literal, then
you may use it here like

res_irq = DEFINE_RES_NAMED(...);

or even do like this

if (dev_of_node(...))
  res_irq = DEFINE_RES_IRQ_NAMED(...)
else
  res_irq = DEFINE_RES_IRQ(...);
res_irq->flags |= irq_get_trigger_type(irq);

I'm not sure why you can't simply use the NAMED variant in both cases
(yes, I see that of_node_full_name() will return something, not NULL).

...

> +       while ((err = platform_get_irq_optional(pdev, res_idx)) != -ENXIO) {
> +               if (err < 0)
> +                       goto vpif_unregister;

Needs a better error checking, i.e. consider 0 as no-IRQ (equivalent
to -ENXIO (note, OF code never returns 0 as valid vIRQ).

>                 res_idx++;
>         }

...

> +       while ((err = platform_get_irq_optional(pdev, res_idx)) != -ENXIO) {
> +               if (err < 0)
> +                       goto vpif_unregister;

Ditto.

-- 
With Best Regards,
Andy Shevchenko

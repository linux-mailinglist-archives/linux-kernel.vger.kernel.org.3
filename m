Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F624865F8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 15:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240039AbiAFOYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 09:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239963AbiAFOYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 09:24:06 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08DDC061245;
        Thu,  6 Jan 2022 06:24:05 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id q25so1419846edb.2;
        Thu, 06 Jan 2022 06:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C381CTVUrIBn6eKVpFPnYtUJbbuElG3Z87hB9XBi33s=;
        b=m3qZySBpS6G8fqvtcjkYRmVs19x2NQ5Gm/MXTrjiHYbceQcJa4U1LCVzLM/wK9oOm+
         kwmeqyN/XS1enrZ1aG1nfVF834xNHZzcxYOw5ceginQEwA3JdWYdK+O3HwBiklRevrbF
         s8lWL6u0Hy9iof3P1Liqm8fJGmPtDo7dBefa5HnCDoKx6Ot3FPoG02XQHGSEwslgDnzN
         VdbBUSqd5eEaGvEaMZE2h+GElv+mj02Kmpvd+0s55NzMEEsePGTUBKYYPLJsnJs8xe/+
         IkGod4VVInKuztm7Fx4+mGHGLq8WBSmRBcpmkh3yYaTODrC+tsTXt+yVOxeJoiqqdBwv
         KYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C381CTVUrIBn6eKVpFPnYtUJbbuElG3Z87hB9XBi33s=;
        b=idJ7NxuCwmrSVi4OEHnAl/pCnN5oezTnpIC64qZtmuzDmUteT8Ex1Y+26/dMUHSuvd
         XUbtjCS/b3MvillKIWM/AX00hmTuEX573kijUe7kmgyicARfW3Oxi1TEZ+6QpE74N2Qr
         wrC4CQnf1QmPnRSF0GstaicxG/wIxoOzDCEdP3mZvaLCUuUFHbw3EWbeA1QBWzHZXvKX
         RJV3JVCR8SgmLZDegvrhaKaAPKLcRUq5VMiKFUJRoKij/n8ELkfzVYD76Twkr/rFH5iC
         FarKO/wgvl38d3IP8YRyVEd58KNQGOBGo+SSPtU+Fv6y4yAiXGgXuc4TsSt7zI+tJnMY
         UmXg==
X-Gm-Message-State: AOAM530G2NChiaa5dN8to5WtfjyitnyURr6pH7MCqVO6o5gdkgCkx9wn
        TQBiRcJSHPqHmFhRfr5D7phyOiCLCtK0mjQemQ8=
X-Google-Smtp-Source: ABdhPJylJkORgN1maX1Z2ma1nd8fBcNwO0p+Z5QFsoi1hZCxL3HBUC7lmB6/fY9DmES2j9EzhxwfiboqVSiwR7vIqqE=
X-Received: by 2002:a05:6402:2693:: with SMTP id w19mr56376736edd.158.1641479044167;
 Thu, 06 Jan 2022 06:24:04 -0800 (PST)
MIME-Version: 1.0
References: <20220105180323.8563-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220105180323.8563-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 6 Jan 2022 16:23:28 +0200
Message-ID: <CAHp75Veud0JbA0Gury3pK942xnyRzwums3_Kt=0ENbrDw3yrUQ@mail.gmail.com>
Subject: Re: [PATCH v6] soc: ti: smartreflex: Use platform_get_irq_optional()
 to get the interrupt
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 5, 2022 at 8:03 PM Lad Prabhakar
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
> While at it return 0 instead of returning ret in the probe success path.

LGTM, thanks, FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v5->v6:
> * Dropped printing function name in error message.
>
> v4->v5:
> * Fixed missing return while using dev_err_probe().
>
> v3->v4:
> * Used dev_err_probe() to print error message
> * Returning 0 in probe success path.
>
> v2->v3
> * Switch back to platform_get_irq_optional()
> * Only print error in case of error, and not when interrupt is missing.
>
> v1->v2
> * Updated commit message
> * Drop check for IRQ0
> * Switched to using platform_get_irq() so that the probe won't
>   fail silently as requested by Nishanth.
>
> v1:
> * https://www.spinics.net/lists/arm-kernel/msg942549.html
> ---
>  drivers/soc/ti/smartreflex.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/soc/ti/smartreflex.c b/drivers/soc/ti/smartreflex.c
> index b5b2fa538d5c..ad2bb72e640c 100644
> --- a/drivers/soc/ti/smartreflex.c
> +++ b/drivers/soc/ti/smartreflex.c
> @@ -819,7 +819,7 @@ static int omap_sr_probe(struct platform_device *pdev)
>  {
>         struct omap_sr *sr_info;
>         struct omap_sr_data *pdata = pdev->dev.platform_data;
> -       struct resource *mem, *irq;
> +       struct resource *mem;
>         struct dentry *nvalue_dir;
>         int i, ret = 0;
>
> @@ -844,7 +844,11 @@ static int omap_sr_probe(struct platform_device *pdev)
>         if (IS_ERR(sr_info->base))
>                 return PTR_ERR(sr_info->base);
>
> -       irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +       ret = platform_get_irq_optional(pdev, 0);
> +       if (ret < 0 && ret != -ENXIO)
> +               return dev_err_probe(&pdev->dev, ret, "failed to get IRQ resource\n");
> +       if (ret > 0)
> +               sr_info->irq = ret;
>
>         sr_info->fck = devm_clk_get(pdev->dev.parent, "fck");
>         if (IS_ERR(sr_info->fck))
> @@ -870,9 +874,6 @@ static int omap_sr_probe(struct platform_device *pdev)
>         sr_info->autocomp_active = false;
>         sr_info->ip_type = pdata->ip_type;
>
> -       if (irq)
> -               sr_info->irq = irq->start;
> -
>         sr_set_clk_length(sr_info);
>
>         list_add(&sr_info->node, &sr_list);
> @@ -926,7 +927,7 @@ static int omap_sr_probe(struct platform_device *pdev)
>
>         }
>
> -       return ret;
> +       return 0;
>
>  err_debugfs:
>         debugfs_remove_recursive(sr_info->dbg_dir);
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko

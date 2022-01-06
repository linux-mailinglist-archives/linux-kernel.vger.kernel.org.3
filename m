Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959EB486609
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 15:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240103AbiAFO3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 09:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239914AbiAFO3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 09:29:07 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E0EC061245;
        Thu,  6 Jan 2022 06:29:06 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id f5so10115027edq.6;
        Thu, 06 Jan 2022 06:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MsehdqVjrVTecOsT2A3/jvDnhXUmIOCHfrOrdcU8UVM=;
        b=UrJtsfQ7NJ+QtMGLOaDEgRRlGqO713SgVzZh/dng9yIPTN1hdHbMLUImcBriLV6oDH
         yggHoRK2nle8vKwyy6OLnMIkgjDidnAWtQHSJPZydSgMf+af6cqzKbS/1y8FpbdfJOdj
         dt8K4B1KLSIxP4l9Ml7KO3LxbYf0lq9E3hscz7rBrFYAEIJX4XhQvht1ZJ1ZdziDr6oq
         5gTJhhRd3bxM/KAoVavmXLkFCABBQtmj8C1Oyg+EdW2ctGWUN2q3pCNbUoPdM3QuHYP5
         l8GRrFVmadJIJXv4pyqbjX04VdlcCoaaD8jiUwqGAbPbZxDgEj5zy/kuyUwth9cxAMgy
         gJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MsehdqVjrVTecOsT2A3/jvDnhXUmIOCHfrOrdcU8UVM=;
        b=bf6jPSNJdsqINAayFzICYgrSjBmE6nSREKpTB1KF2SOW3BaPJSfMzuB5X6J9gzSWzV
         z6sLm7h08GOpoaWx0J80N3EYtWomJPk8q+yM+tOgkukXhN/rV32bZBovZz/hvZBEVkhi
         N3nwkobrWcvNTb3eg0YNs+MfABFk5QZxjmNZ+P6YbZWQIY2EmCOVwTsz09PQGKs5xguM
         UnVWAuzWCThKol1KNhB+1b7qX6uRDg/4/6Uq163nalCKLtH58BmhUEOcYn4NFsNA00xV
         gdfx6D9iq9k3s5pq2OxmZHBXkTa6daMAMLPZUIzhnjoQX3wgfvmR7T3n0z7u/ZEP2pJV
         UJ7g==
X-Gm-Message-State: AOAM532e55/3yo8EVL8kd3wjNWjwKeNfeNpBrF3mcFXT8ph7ow4XFYcC
        pkiVkAQRkUsjbXOKXbNEUtAyzli+G83AhrmcjrQ=
X-Google-Smtp-Source: ABdhPJz7HioIYv4BqhhXBSq9nU4v4rvim8NcG3OrW68hvMH+696lsXKGzKQM6YfBxwSBhjs4RsYPnvhyvHqEDd0ULOs=
X-Received: by 2002:a05:6402:2ce:: with SMTP id b14mr58724969edx.122.1641479345425;
 Thu, 06 Jan 2022 06:29:05 -0800 (PST)
MIME-Version: 1.0
References: <20220104145212.4608-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220104145212.4608-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 6 Jan 2022 16:28:29 +0200
Message-ID: <CAHp75Ve4t8Pas5t+wdNWyN_Z9w_V4jcYbxjfgOmru_DimfGV=A@mail.gmail.com>
Subject: Re: [PATCH v3] thermal: rcar_thermal: Use platform_get_irq_optional()
 to get the interrupt
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 4, 2022 at 4:52 PM Lad Prabhakar
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

>         for (i = 0; i < chip->nirqs; i++) {
> -               irq = platform_get_resource(pdev, IORESOURCE_IRQ, i);
> -               if (!irq)
> -                       continue;
> +               int irq;

> +               irq = platform_get_irq_optional(pdev, i);
> +               if (irq < 0 && irq != -ENXIO) {
> +                       ret = irq;
> +                       goto error_unregister;
> +               }
> +               if (!irq || irq == -ENXIO)
> +                       break;

Wouldn't be better to assign to ret

               ret = platform_get_irq_optional(pdev, i);
               if (ret < 0 && ret != -ENXIO)
                       goto error_unregister;
               if (ret > 0)
                       irq = ret;
               else
                       break;

?

-- 
With Best Regards,
Andy Shevchenko

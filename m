Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340C34781B5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhLQAjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:39:47 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:54050 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbhLQAj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:39:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCB9961FDE;
        Fri, 17 Dec 2021 00:39:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DAEAC36AF9;
        Fri, 17 Dec 2021 00:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639701566;
        bh=75TZSoCMHP9oRCfE0m+T4/+QO5utCgszrUM5wKG5cwQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mZyfyMzL/elcJDR0irvrGMfdhr/2ltDYW972gtQWrb7cw3hZYXTHjsxupZQ1D9YLL
         8wmRFAEk450/cS1Vx0ySWq/gVzrlPxbueGdopBr2vn3Ft+CjiaoYshxmRQ0o8zXwci
         PXdaSfEqgolrE36rJe5q5RquIsN8ZNdqYdpgD/Sc8zBPr4eyKXral6ZCAXABAf62xh
         biUJ2A69tcnng4iK79leN3NzfOvZS7GwzYS2R2baceXxQtwtk/c88Ij9K+GjsLFsAi
         6Bwvx6dY5mLsqkLFgJ3SvIS2f8UnQirFKY+feoLts4dw4vHnQUvNXfdaL8zM9g3NMf
         4IettCaLbWCDA==
Received: by mail-ed1-f41.google.com with SMTP id y22so1773140edq.2;
        Thu, 16 Dec 2021 16:39:26 -0800 (PST)
X-Gm-Message-State: AOAM5331YybD9FWv6W/W8Vizs6bKTl36abeJtgKMs8jwKETr+yz3DWNi
        IdzHsewGW9sdzO0b8vfBiRMlXA9aRABfwGZLmw==
X-Google-Smtp-Source: ABdhPJyRTG/8JNTAhLNq0O/FQ8QnwEpuHFO7fkkcyl10+duI5Vhu10MpqAJ5TkeaLA5s5zndkwWHdgqHiN9w9F8ztEI=
X-Received: by 2002:a17:907:94c2:: with SMTP id dn2mr457207ejc.325.1639701564480;
 Thu, 16 Dec 2021 16:39:24 -0800 (PST)
MIME-Version: 1.0
References: <20211217001238.16298-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20211217001238.16298-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 16 Dec 2021 18:39:13 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLf0FHYt-+4hEG3FkecrBJOwd=ub_yeEKWZ1DKPUycgkQ@mail.gmail.com>
Message-ID: <CAL_JsqLf0FHYt-+4hEG3FkecrBJOwd=ub_yeEKWZ1DKPUycgkQ@mail.gmail.com>
Subject: Re: [PATCH] ata: pata_of_platform: Use of_irq_to_resource() to
 populate IRQ resource
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 6:12 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypassed the hierarchical setup and messed up the
> irq chaining.
>
> In preparation for removal of static setup of IRQ resource from DT core
> code use of_irq_to_resource().
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Hi,
>
> Dropping usage of platform_get_resource() was agreed based on
> the discussion [0].
>
> [0] https://patchwork.kernel.org/project/linux-renesas-soc/
> patch/20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
>
> Cheers,
> Prabhakar
> ---
>  drivers/ata/pata_of_platform.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
> index 35aa158fc976..557f349eb533 100644
> --- a/drivers/ata/pata_of_platform.c
> +++ b/drivers/ata/pata_of_platform.c
> @@ -9,6 +9,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
> +#include <linux/of_irq.h>
>  #include <linux/platform_device.h>
>  #include <linux/ata_platform.h>
>  #include <linux/libata.h>
> @@ -25,11 +26,12 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
>         struct device_node *dn = ofdev->dev.of_node;
>         struct resource io_res;
>         struct resource ctl_res;
> -       struct resource *irq_res;
> +       struct resource irq_res;
>         unsigned int reg_shift = 0;
>         int pio_mode = 0;
>         int pio_mask;
>         bool use16bit;
> +       int irq;
>
>         ret = of_address_to_resource(dn, 0, &io_res);
>         if (ret) {
> @@ -45,7 +47,9 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
>                 return -EINVAL;
>         }
>
> -       irq_res = platform_get_resource(ofdev, IORESOURCE_IRQ, 0);
> +       irq = of_irq_to_resource(dn, 0, &irq_res);

No, platform_get_irq() please. I really want to get rid of the 4 users
of of_irq_to_resource() in the tree, not add more.

Yeah, that means __pata_platform_probe() needs to change, but it's all
of 2 callers. Really, I think pata_platform.c and pata_of_platform.c
should be merged. I'm guessing the separation traces back to DT using
a different bus type.

Rob

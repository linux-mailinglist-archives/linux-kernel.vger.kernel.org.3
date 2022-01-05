Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6996048506F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 10:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239112AbiAEJyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 04:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239099AbiAEJyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 04:54:01 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C2CC061761;
        Wed,  5 Jan 2022 01:54:01 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id n30so47509448eda.13;
        Wed, 05 Jan 2022 01:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X4GNTeCisLQzSi9OxOY5ormoDr/5CoiqbLTNDynQNJw=;
        b=XBb1ctMH1k7p7Y4eqegcb7iGQ+VNtzswgcA8KybqEm7OkARMJOlf0BcABOs8C/1M9V
         CY4UqvhRN37oSK1xeQqjIBEAh+rgE2Re9m0xi1KgjSvBIBr4yvf3Nm45AmwuUOvSoitP
         b/HR1fdGJr8FsWW7e/uJB6Y+9v1OH6Uz+oJoAD2epxw7Hx5UqXaMN5s9UPC8PWlBEy+a
         gHEeKc+1lgqvaNGsv++3KHzeXS/po53loPkOqggimooUHszZdIsqWcHhniUIJ97alavK
         3MVMsL2qAB2zCbIzs2x0AtsKZHbTRBkakbskIOS4bXX9FbdgTsj4cHGwm0CRkI3SqIxy
         emjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X4GNTeCisLQzSi9OxOY5ormoDr/5CoiqbLTNDynQNJw=;
        b=5rFbXvXFOp/cdYWngevcjIsJwcTeWP1RFxE7vXYZkSx4c97OJHWCJLDDY0wx+FJMQg
         NkhkTn8xRifCvqzlIDMXzPUHmlqNoFOKDMbTXwp4HkN7F82RMhSqjqTqFPTwXappP788
         opiR23aL4b4qp2tXOUh3EG4d9OwwK+QvckGNr3RoWpaY62YpMLwNFKEQppMVDEaDTihx
         FflviL7sC5dILkrQINOTol+9ZL4qE4ZBlv9ZNef3iomS1qEblAACWWEElfmSqqoDI3Nv
         0ylrTQqvzEkyenavC46Ngtm3hjimsCLD+npLZE7fS4QhTQz8yIhUbqwK5xi7MuwTFNRC
         bfVw==
X-Gm-Message-State: AOAM533wg/lrJvfdlfQ1HV2ZB1UOywGitGK5vvUKL7Wnrj4Xp8za/r8D
        pKQje8lSnf7qH/2/rkHTR/RUzfE0Q6B0osRbXBs54b67A5M=
X-Google-Smtp-Source: ABdhPJwgJeUDOADi2zIrrz7Da1NhPqDRKfiMU4sYAC+cAKycZRF5EALdm/rVupM9dDJB9PCNRqbSKAA+h3ubA0yaTqE=
X-Received: by 2002:a05:6402:795:: with SMTP id d21mr17476727edy.270.1641376439894;
 Wed, 05 Jan 2022 01:53:59 -0800 (PST)
MIME-Version: 1.0
References: <20220105001410.27916-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220105001410.27916-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 5 Jan 2022 11:53:23 +0200
Message-ID: <CAHp75Vd-7-6ZtGeRH=27H=H=SJnO5k-ntiYjpoPVic1G2Y1EaQ@mail.gmail.com>
Subject: Re: [PATCH v4] ata: pata_of_platform: Use platform_get_irq_optional()
 to get the interrupt
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 5, 2022 at 2:14 AM Lad Prabhakar
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
> Note this code just sets the start and not the end of IRQ resource as
> __pata_platform_probe() only uses the start member and also we don't
> set the IRQ resource flags as this is handled automatically for DT.

...

> +       irq = platform_get_irq_optional(ofdev, 0);
> +       if (irq < 0 && irq != -ENXIO)
> +               return irq;
> +
> +       if (irq > 0) {

> +               memset(&irq_res, 0, sizeof(irq_res));

To avoid subtle mistakes in the future, I would suggest doing this
unconditionally.

> +               irq_res.start = irq;

This is interesting. For consistency I would assign the end as well.

> +       }

Hence something like

memset(&irq_res, ...);

irq = ...
if (irq < 0 ...)
  return irq;
if (irq > 0) {
  irq_res.start = irq;
  irq_res.end = irq;
}

-- 
With Best Regards,
Andy Shevchenko

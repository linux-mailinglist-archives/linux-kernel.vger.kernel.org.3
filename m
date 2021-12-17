Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B92478D24
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 15:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236984AbhLQOPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 09:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236979AbhLQOPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 09:15:00 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD73C061574;
        Fri, 17 Dec 2021 06:15:00 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id f9so6728231ybq.10;
        Fri, 17 Dec 2021 06:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IVl4kP6KS6rFyAw7lz0JUNc6X9NKPfCXgxB1Yg/KL/c=;
        b=HrGiYsyQA8JB5SNWH6cYEs6sKR16u2xxPe1c6COv8Ohk5JaJLQSIdAcJAuZi9imSls
         PTjGp8Y5WSjCP/RwtfhhbCLcd2jOeNCOkt46JNjguibogUo6nRnzY2S79q3nYzGlUpHD
         6uUiO7Hj5X74bPsFJFyKdQPbiEdxRCCAp+4qW5XPknJaL54fNKr/7vUc7Fa5SA3r0AmP
         OwMYZzeuJEpKg16zE7IFwq5H3gKjtkq3kNTVT+hPvWo02rdiPRvimP4IgstuGWrzbW6+
         5Rta3ueaU9sHQJ64P9yFxoyZH7npNySoLt4zEsDV0olpr69Qt9qBYI1e0gwF3iN2eTOk
         lMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IVl4kP6KS6rFyAw7lz0JUNc6X9NKPfCXgxB1Yg/KL/c=;
        b=MyXlXIqz8WIh48cs+3hdScqW5I2kYCLabxPio854Ab/t9Vim5k3vrwA1zvHsXyGT/n
         OsSBDVbWCepWxiolejk101hqVCjU51mJjkTydlKjcCIekBzQbXJPMFGzFWb7fKUwT7+7
         dP4uI8Eb6mfPXyKiDE6/mJSDqTOxM37fi1kwKCk7AFaPeRZzNdTtrkzRwOd0WJ5cr3ue
         PaRF9X0DMtZMIDFWGMhWMKzcRbZBnvlmsRl3vUPs/QCRRlDh/SWy1CYkI/WXkGJJ9UVz
         0rl9uGoRL2me0I5hfuJqMKDtoUOA1/5WmcfdpJzoQa4AEGzr7KtbEBUTQ3YnvW8WME6/
         mb+Q==
X-Gm-Message-State: AOAM531fQCdO9FiyP0z8KeZltc8VdCtB4jNF+kbY/WUOFwWzp049bpFs
        qxarZ8zOp/G0cQ8fPRjxbpok/hQVODXADhiM/LlAdRI09zs=
X-Google-Smtp-Source: ABdhPJw2aMX4VhQ8vYCjBtjZ2xRsn/Ohg3s2jkN2sp8iZPKuYIGQLZ6kP+Uar1yuNqKllru2jBwpNkn9v9gQFq1ZrSs=
X-Received: by 2002:a25:1004:: with SMTP id 4mr4513107ybq.669.1639750499887;
 Fri, 17 Dec 2021 06:14:59 -0800 (PST)
MIME-Version: 1.0
References: <20211217001238.16298-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <ca168723-f113-8620-056d-ab2ee801d8fe@omp.ru>
In-Reply-To: <ca168723-f113-8620-056d-ab2ee801d8fe@omp.ru>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 17 Dec 2021 14:14:33 +0000
Message-ID: <CA+V-a8vdsLaL4bwsv1ORKDK1YXUhQHzAwUrUHUiaG9SJCSOV+Q@mail.gmail.com>
Subject: Re: [PATCH] ata: pata_of_platform: Use of_irq_to_resource() to
 populate IRQ resource
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

On Fri, Dec 17, 2021 at 9:33 AM Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
>
> Hello!
>
> On 17.12.2021 3:12, Lad Prabhakar wrote:
>
> > platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> > allocation of IRQ resources in DT core code, this causes an issue
> > when using hierarchical interrupt domains using "interrupts" property
> > in the node as this bypassed the hierarchical setup and messed up the
> > irq chaining.
> >
> > In preparation for removal of static setup of IRQ resource from DT core
> > code use of_irq_to_resource().
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > Hi,
> >
> > Dropping usage of platform_get_resource() was agreed based on
> > the discussion [0].
> >
> > [0] https://patchwork.kernel.org/project/linux-renesas-soc/
> > patch/20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> >
> > Cheers,
> > Prabhakar
> > ---
> >   drivers/ata/pata_of_platform.c | 11 ++++++++---
> >   1 file changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
> > index 35aa158fc976..557f349eb533 100644
> > --- a/drivers/ata/pata_of_platform.c
> > +++ b/drivers/ata/pata_of_platform.c
> [...]
> > @@ -45,7 +47,9 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
> >               return -EINVAL;
> >       }
> >
> > -     irq_res = platform_get_resource(ofdev, IORESOURCE_IRQ, 0);
> > +     irq = of_irq_to_resource(dn, 0, &irq_res);
>
>     Why not use platform_get_irq_optional()?
>
Agreed.

Cheers,
Prabhakar
> > +     if (irq <= 0 && irq != -ENXIO)
> > +             return irq ? irq : -ENXIO;
> >
> >       of_property_read_u32(dn, "reg-shift", &reg_shift);
> >
> [...]
>
> MBR, Sergey

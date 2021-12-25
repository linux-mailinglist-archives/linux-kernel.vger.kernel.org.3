Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6563247F402
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 18:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbhLYRNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 12:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhLYRNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 12:13:32 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DE3C061401;
        Sat, 25 Dec 2021 09:13:32 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 139so140523ybd.3;
        Sat, 25 Dec 2021 09:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NatHlFP0XUBwKDlB+KIyTyC4AsmzmonDRKzzcjxel0c=;
        b=U14jWEqI8cJS+JIp510rymM8RiUHdW0Rh8kbufPlC9foVHoxOF5Te5FEWs2zdrC2zC
         QDgkxoezVzDAsipwgonRTUWbcjP7ocLSmNEyP+V/TSPy0huMlAI2Yn7b+D7mpiSitEh0
         nNVuQZXIRvF6OubMwoghifhvuOU/UsiQbI4RfsJktq/uJcrqCGtO0Qm71M76B1kQv5ma
         S4etrdKXvUkrQQZ6qcFAIxRNs/5W17j5Hh6AfO8TzhxFG+9mTzYTSrPtkcsMtOEM9Tvv
         UbaQmnI6n7guxEfeT2ufk90yA9QibWd5x7u134XnswVk7nrFvgAwbHK01AlLWkpDgIRt
         Basw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NatHlFP0XUBwKDlB+KIyTyC4AsmzmonDRKzzcjxel0c=;
        b=R+CJRLgnhCe2lz7sdyhfh2ksee4cS5KTwStSaBfYrLb0qmm/25dqteMDSSZQwAI5f8
         td5volp8M3cT5zAhj4yS4+n17akiqYNperO1nHxAtgpB2mFnk8ON7ahw/hkDfnI9Ddyh
         0zBqDtFe9crs2NQ0n904PoERD8viHsFIc8kvyFkQu1dPuq3znnRsytbnqv4W5oveFKaC
         CR2kPdWZcRls+5q19efL4prjil+56/XA1iigwp2j1acBC/Dx/BfXAG4TNJLnN4mIXHW+
         Hgg2dk9ByJdIsKfPILmJQFKCrenma3hIJfMiexcpy/9tJWlAQ097Z6P3mzNMrDz7cBnn
         rWYg==
X-Gm-Message-State: AOAM530cQQGysX6xz6het8B0GpdTdZqVzyp+tR3ftHtb187RD9J9kIMi
        wTMKsbz0CNTNWdYATnFVs/uKNn/cV7Cc0V73xsA=
X-Google-Smtp-Source: ABdhPJyHsFZBIBR6XNc3MZMLWHSIZjQJNiOOlK/eZww/0jngzINOecCy3va1AVVwjRFaViIOo2ZIIpHaDcTiVToJzVY=
X-Received: by 2002:a25:e7cc:: with SMTP id e195mr2933487ybh.251.1640452411495;
 Sat, 25 Dec 2021 09:13:31 -0800 (PST)
MIME-Version: 1.0
References: <20211224131300.18198-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211224131300.18198-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAHp75VdLOuzpjzrwQw71KWNM82-_TwPtYrE7ukrmZoDN3x0gQA@mail.gmail.com>
In-Reply-To: <CAHp75VdLOuzpjzrwQw71KWNM82-_TwPtYrE7ukrmZoDN3x0gQA@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sat, 25 Dec 2021 17:13:05 +0000
Message-ID: <CA+V-a8tovrh-SobwCpPfdNuME-ijMrd9Crstq_wXEe2jpZF-9Q@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] ata: pata_of_platform: Use platform_get_irq_optional()
 to get the interrupt
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thank you for the review.

On Sat, Dec 25, 2021 at 5:02 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sat, Dec 25, 2021 at 3:55 AM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >
> > platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> > allocation of IRQ resources in DT core code, this causes an issue
> > when using hierarchical interrupt domains using "interrupts" property
> > in the node as this bypasses the hierarchical setup and messes up the
> > irq chaining.
> >
> > In preparation for removal of static setup of IRQ resource from DT core
> > code use platform_get_irq_optional().
>
> ...
>
> > +       irq = platform_get_irq_optional(ofdev, 0);
> > +       if (irq < 0 && irq != -ENXIO)
> > +               return irq;
> > +
> > +       if (irq > 0) {
>
> > +               memset(&irq_res, 0x0, sizeof(struct resource));
>
> Why do you need that variable at all?
>
Are you referring to the irq_res variable? That's because
__pata_platform_probe() requires it.

> 0x0 -> 0
> sizeof(irq_res)
>
OK, I will update it.

Cheers,
Prabhakar

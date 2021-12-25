Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2561B47F3FD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 18:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbhLYRKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 12:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhLYRKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 12:10:51 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E533C061401;
        Sat, 25 Dec 2021 09:10:51 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id o185so4735107ybo.12;
        Sat, 25 Dec 2021 09:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1qKorauZ5ZbwDDuS4Hsh/2L8kR1WOpJxg99UyaqwyRY=;
        b=EWNvZW2Bwtw1HuqzeM1rPMoX6glkYgiYkao9SLLoT9pz3tA88qIhxE+GcaqaU2oCsj
         Fj89BvC20pDfBozTasPRNXvx+yNW24ROhcDsa4BAYI7Ti9Bl9SuqfwY4YEPzvcgzR5UJ
         Xow2uyNTg6tblIEe61d0kucWK7/d91yKWGIVSlacL7lC77nw68VBOzav4Q9n1XX1DBad
         RraQ5rOhmSGDIayLtOMb7jUVIsvoUJdi4wT8/5qJ9uTPe/nyUy8ILHqL0fnJ+jBv36JC
         1eEavGEHkg7yy6JtaZiwe6PA6l/RGnfc6AAsxi3Hl+bWFr+CtikvPDpQjBX6UzppOC68
         B4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1qKorauZ5ZbwDDuS4Hsh/2L8kR1WOpJxg99UyaqwyRY=;
        b=3kQl2D4zsNlVO7VxUbScNb39tGHeUlQCeyruoXIiLyPvcjqXfK6O+DQH3jHFEPJPlf
         pPp+tt3EWDETHGOoWGU8ma55Ua4Bmx+8e3GqT+6311eRuseIW2pDnHQeEN6afUerZzYe
         hoZJWTVe91xYX+vxtYkfbDMrfrO60NBWEOOoBRFAD6ITr5s4YW/HxRh1y75egY1FI7kr
         jYhhodKcWoWr3s9xz+SbrnrmLtjJ5lx0NWx5Oppeemh8U/rn4//xuGQRhw699VSBAh62
         Cbk3KnsE08NO1sK0xs9DM/gW1qIvcaH8qv1rUdAeD/7TG3XkFxPr0vsYMJvkpNyMtjYG
         3rCQ==
X-Gm-Message-State: AOAM531jTRiMIw1Err86yLcuU840qxLjSKPBsrKaWqmE+EW18UKddeCx
        024mftqGndrIVillvVvnBbOGykimaaCrCucnBPs=
X-Google-Smtp-Source: ABdhPJxg5M2gTvWeo8XoQbxVY5lByQ5/hY2NrKqSPC62Acc46EwCUqPvtOYbOF7WYqEsHmN7LfrNhB+DIdlk4hL4zWg=
X-Received: by 2002:a25:1004:: with SMTP id 4mr14364126ybq.669.1640452250517;
 Sat, 25 Dec 2021 09:10:50 -0800 (PST)
MIME-Version: 1.0
References: <20211224202231.31130-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAHp75Vda7LTR=8eUki3yXEk5ia8va2Ma6Pqgj-4v6nSphNZjow@mail.gmail.com>
In-Reply-To: <CAHp75Vda7LTR=8eUki3yXEk5ia8va2Ma6Pqgj-4v6nSphNZjow@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sat, 25 Dec 2021 17:10:24 +0000
Message-ID: <CA+V-a8vj30jPdXQ8PhFuawiNab0UJdiN8D6mh=c4mNGchTFfhw@mail.gmail.com>
Subject: Re: [PATCH v3] soc: ti: smartreflex: Use platform_get_irq_optional()
 to get the interrupt
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thank you for the review.

On Sat, Dec 25, 2021 at 4:56 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sat, Dec 25, 2021 at 4:08 AM Lad Prabhakar
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
> > +       ret = platform_get_irq_optional(pdev, 0);
> > +       if (ret < 0 && ret != -ENXIO) {
>
> > +               dev_err(&pdev->dev, "%s: failed to get IRQ resource\n", __func__);
> > +               return ret;
>
> Almost fine, but you should exclude this from the deferred probe, so switch to
>
>   return dev_err_probe(...);
>
Agreed.

> > +       }
> > +       if (ret > 0)
> > +               sr_info->irq = ret;
>
> ...
>
> > +       ret = 0;
>
> I do not see the context, is it really necessary?
>
Yes the change is necessary as the probe callback returns ret on
success, and in the below code flow there might be a case where ret
inst set. So setting the ret here.

Cheers,
Prabhakar

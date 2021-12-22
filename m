Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFBF47D02D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 11:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244250AbhLVKnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 05:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244247AbhLVKnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 05:43:35 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAF4C06173F;
        Wed, 22 Dec 2021 02:43:35 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 131so5304675ybc.7;
        Wed, 22 Dec 2021 02:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Vz25OSJbakuWpEywjtLALOtBu/iEUp/q30n1jN5wis=;
        b=AyUvIBw0mFJmeYTqBMquxP66Cr0SHdjxuOiF8xjQ6jtNVubjkjCETMtlEFyAAhM9gA
         B34+nGa5YOgLgLzyCn/n9Tl5xH84LCym+vZcu35dHL1/KP36/MWxhmrroVjSkhJvvyl4
         nrLLXTw2nNbB0LIcJJ3HiAH+nMnypbnGbxf8Y11s17iucRAF5z1hCGoT1benElODWaNg
         fz5M7kf66RcTW7fU4X7QLkJka0HvCrGZoD7kGAhPv6CV0EHgDkN6Yl1iPot/LKI1tzYO
         V9fpX76OcuYNt0YVgd951ypIpG7eO193ly4LApIPP+koxCgEY8NTlH3qeX2nL4MZ++Ia
         hAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Vz25OSJbakuWpEywjtLALOtBu/iEUp/q30n1jN5wis=;
        b=BoVt4R5RKLoBsBmPshcEGk8kEWDk68DWPrn9iiREeh+7/GmC5AzRSmqCuSHvufQt17
         UU6fAnpk9mAcI1TbMcy0e25NYV37rXD6wf/Ha8gZhWoxFbNfA2r0+Jmnzi0aZWJzb33E
         uOKR/veLGQaBKyfbzH5McIDJlCjG6ZD227Ky1++2Phx8l1+XhOIfhqT9GjWBWxcHM6Rv
         h7+LiVTtUBIzVDhvlkJQP+W7DoML/iSmsNy+FJ3+5EyTodmMAe/fk1d1jDnsT8efo16n
         s5VkehIcB9gpdJbubtrGfnujdwG4VTEy1x+Rhs2eR8EH22UMdqCJyCq4qh2/UJ1QEdFE
         MWHA==
X-Gm-Message-State: AOAM532lpRZyWVYcNChncVMYc0M+g1MLhes33qPt2Yz2Kq1/7u8K8Wqk
        Z1bANlaa8czjH2GHpTbOzKF3nK09K8X+MuVazhIUpTRlloA=
X-Google-Smtp-Source: ABdhPJw3biLmdDa0m57Mn77USRvpzrPyP5ZLPan59LQfvS5x+IN3wmNnA8JEfzaOtxglQqlMjv7h3DZddqVAevxJMfM=
X-Received: by 2002:a25:cb97:: with SMTP id b145mr3345276ybg.186.1640169814597;
 Wed, 22 Dec 2021 02:43:34 -0800 (PST)
MIME-Version: 1.0
References: <20211221203916.18588-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211221203916.18588-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <7b8882c1-a3ef-2cb4-ab2a-a367755cad85@kernel.org>
In-Reply-To: <7b8882c1-a3ef-2cb4-ab2a-a367755cad85@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 22 Dec 2021 10:43:08 +0000
Message-ID: <CA+V-a8tEHP8Y1_v4bCEvnK19vqrcT+LgssZ+jqGLMSZfYXLqCA@mail.gmail.com>
Subject: Re: [PATCH 2/2] memory: omap-gpmc: Make use of the devm_platform_ioremap_resource()
To:     Roger Quadros <rogerq@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

On Wed, Dec 22, 2021 at 10:30 AM Roger Quadros <rogerq@kernel.org> wrote:
>
> Hi Lad,
>
> On 21/12/2021 22:39, Lad Prabhakar wrote:
> > Use the devm_platform_ioremap_resource() helper instead of
> > calling platform_get_resource() and devm_ioremap_resource()
> > separately.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  drivers/memory/omap-gpmc.c | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> >
> > diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
> > index 56f401ba53a5..582fe102f923 100644
> > --- a/drivers/memory/omap-gpmc.c
> > +++ b/drivers/memory/omap-gpmc.c
> > @@ -2492,7 +2492,6 @@ static int gpmc_probe(struct platform_device *pdev)
> >  {
> >       int rc;
> >       u32 l;
> > -     struct resource *res;
> >       struct gpmc_device *gpmc;
> >
> >       gpmc = devm_kzalloc(&pdev->dev, sizeof(*gpmc), GFP_KERNEL);
> > @@ -2502,11 +2501,7 @@ static int gpmc_probe(struct platform_device *pdev)
> >       gpmc->dev = &pdev->dev;
> >       platform_set_drvdata(pdev, gpmc);
> >
> > -     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -     if (!res)
> > -             return -ENOENT;
> > -
> > -     gpmc_base = devm_ioremap_resource(&pdev->dev, res);
> > +     gpmc_base = devm_platform_ioremap_resource(pdev, 0);
> >       if (IS_ERR(gpmc_base))
> >               return PTR_ERR(gpmc_base);
> >
> >
>
> Thanks for the patch but this is already being taken care of by this patch
> https://lore.kernel.org/lkml/20211221131757.2030-4-rogerq@kernel.org/T/#m9516df757d98049d769601ee4601005f74f3cec7
>
Thanks for the pointer, this patch can be dropped.

Cheers,
Prabhakar

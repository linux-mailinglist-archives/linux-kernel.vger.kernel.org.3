Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B363481C18
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 13:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239317AbhL3Md0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 07:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbhL3MdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 07:33:25 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0BAC061574;
        Thu, 30 Dec 2021 04:33:24 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id e202so29070712ybf.4;
        Thu, 30 Dec 2021 04:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vAnVuyhDyOqSDpVecpePDGpCLlrsb4u5oVIUyGQIigM=;
        b=knbtVI06jsv3f7mpLlir2DoX+1gPdzxij/X8LvmrB46KFAEe8rX2cFKqghTrn2bv5R
         0S/Wy8k62B4TwVwLkoYNks87y6ZorTAwTXJMbJhKFPrIj9/ubNgPCbQg/qZGWMyD/dD+
         vpc2hKkJXaGCix3lpFMFqLSZ6Ll7nYI5v+X0GbFojHF97Eh5SOB6cmW64VAo5EixnRfg
         +aQHwG9GhALUZJyGUYW+NFf2vMEQGARzgg/4fefGJJMxjhpOoHrpGHllbYTJIygoP/DZ
         TUz7zTeE01LQuxQ6sueLmAzSiUdcpaswOmX1bLoEhaS+1YzTPNpN2txhwto106acNuQZ
         0Ehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vAnVuyhDyOqSDpVecpePDGpCLlrsb4u5oVIUyGQIigM=;
        b=UhAeeAifo69ZZwwXBNKrhFc7H8UpanLkgaHUG1NhDZF8thWbVSfBgDiT4HxEIKhxjM
         b6JDEgkzbCp0WEyspc29euQAO1Qasyd4hJPyqgqITyCxGeYezU6bai05rZc93pLrFAXy
         RZ45kzEZ/gch61U/XsZR6+Ya8XgHBfneitgeqaER3bloNpMOv7DDZCe5s1fndVwObsW0
         CkAYhW+ik2KrV+yiQtm3rPNpVjRjicbBJBuoXLyPP607g164+rOB/IG9bndhUlVSCeyL
         WxdP1c467lOKRLzqd+lD65Pz6S2ZXfEwrUi+hLeHJff0BUGL7XC2+H6l4oUwADCD9est
         EkFQ==
X-Gm-Message-State: AOAM533xrrxxsfNWP38c32eida4dA2wLJjuQMGYhfWSa6degyHXVg0hR
        mFs7pfUbPKiBrDIPsdfUwcRb3idAwxR8WY6mlceSM1KQWrpxhA==
X-Google-Smtp-Source: ABdhPJztJjoCSt13eeXjnX/Dry1sgLWNmKKhFDSarqgwEZcaTtCTD+A7t7N4IP25u0VqHiGVCKCaecyMYicCG0uNLiM=
X-Received: by 2002:a25:7509:: with SMTP id q9mr19566507ybc.315.1640867604209;
 Thu, 30 Dec 2021 04:33:24 -0800 (PST)
MIME-Version: 1.0
References: <20211223173015.22251-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211223173015.22251-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <Ycz4Ba5P1Srx3ALv@pendragon.ideasonboard.com>
In-Reply-To: <Ycz4Ba5P1Srx3ALv@pendragon.ideasonboard.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 30 Dec 2021 12:32:58 +0000
Message-ID: <CA+V-a8vQnHH1ZEFRMxRCpB7NziGXz90zULXDJWDZOtTZkA-pJA@mail.gmail.com>
Subject: Re: [PATCH 01/13] media: vsp1: Use platform_get_irq() to get the interrupt
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-media <linux-media@vger.kernel.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Thank you for the review.

On Thu, Dec 30, 2021 at 12:06 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Prabhakar,
>
> Thank you for the patch.
>
> On Thu, Dec 23, 2021 at 05:30:02PM +0000, Lad Prabhakar wrote:
> > platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> > allocation of IRQ resources in DT core code, this causes an issue
> > when using hierarchical interrupt domains using "interrupts" property
> > in the node as this bypasses the hierarchical setup and messes up the
> > irq chaining.
> >
> > In preparation for removal of static setup of IRQ resource from DT core
> > code use platform_get_irq().
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Will you get this merged with the whole series, or should I take it in
> my tree ?
>
I intend to get this merged with the whole series, just to make sure
all of them are part of the same release. If there is an issue that's
OK too.

> > ---
> >  drivers/media/platform/vsp1/vsp1_drv.c | 13 +++++--------
> >  1 file changed, 5 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/media/platform/vsp1/vsp1_drv.c b/drivers/media/platform/vsp1/vsp1_drv.c
> > index c9044785b903..bbba91a65a0f 100644
> > --- a/drivers/media/platform/vsp1/vsp1_drv.c
> > +++ b/drivers/media/platform/vsp1/vsp1_drv.c
> > @@ -794,7 +794,6 @@ static int vsp1_probe(struct platform_device *pdev)
> >  {
> >       struct vsp1_device *vsp1;
> >       struct device_node *fcp_node;
> > -     struct resource *irq;
> >       unsigned int i;
> >       int ret;
> >
> > @@ -813,14 +812,12 @@ static int vsp1_probe(struct platform_device *pdev)
> >       if (IS_ERR(vsp1->mmio))
> >               return PTR_ERR(vsp1->mmio);
> >
> > -     irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> > -     if (!irq) {
> > -             dev_err(&pdev->dev, "missing IRQ\n");
> > -             return -EINVAL;
> > -     }
> > +     ret = platform_get_irq(pdev, 0);
> > +     if (ret < 0)
> > +             return ret;
>
> I'd use an int irq local variable, but it doesn't matter much. Up to
> you.
>
Anyway I plan to post a v2 for this series fixing a couple of comments
from Andy. Will use a local variable irq then and include your RB tag.

> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> >
> > -     ret = devm_request_irq(&pdev->dev, irq->start, vsp1_irq_handler,
> > -                           IRQF_SHARED, dev_name(&pdev->dev), vsp1);
> > +     ret = devm_request_irq(&pdev->dev, ret, vsp1_irq_handler,
> > +                            IRQF_SHARED, dev_name(&pdev->dev), vsp1);
> >       if (ret < 0) {
> >               dev_err(&pdev->dev, "failed to request IRQ\n");
> >               return ret;
>
Cheers,
Prabhakar

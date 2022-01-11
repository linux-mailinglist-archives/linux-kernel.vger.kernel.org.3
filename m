Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C61648ABA1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 11:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349327AbiAKKn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 05:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237719AbiAKKn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 05:43:58 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5F9C06173F;
        Tue, 11 Jan 2022 02:43:58 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id c6so43959779ybk.3;
        Tue, 11 Jan 2022 02:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YPPxEIJ1b3WsR5CbwpQEJ1LNBsj9p5scd+Ef/LoGxDg=;
        b=gXsFRCra6nliHf/3CK+rPbVevQeSk93QLN/GWr7V4ghS1/HTHSWMWeVik3yr7k/Iw2
         Vngid3RiwsMTv5RysXmvg4L5M28SZ1bzheOcYLjfOs+ICqD0NZ4YNAKsNB4bNisIiuOk
         /e+O00COvRkZuPX7cuApvnirOgECMtPcYVjlg3lzLTdCOm/VjwSirwuIJH1emgJf9zIr
         TD6kuHKPW1neJf+ei+IGKWnPz7gAvL8YKagbm30a3Ygq3W9+8J5b7HJ+j9Zj7WWSnwnC
         xccengawxtgY/ExgpePK5ilysN12/mz+DW5zavpZyPg0DIKaMKpWzQ2nDO/WBQWCwfoV
         fvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YPPxEIJ1b3WsR5CbwpQEJ1LNBsj9p5scd+Ef/LoGxDg=;
        b=gbIvLHvulRA68EnAMn23RvPCVxby8/7R5AHBhyj66yTmsDLkniLmWD7eMhRUqjc8j+
         zJ+js+sE17H/QkML8zYOPGU7iMTvbWczClpQ2nLU9UkrXJxkNLSrHY5PmQkTew1+sSvR
         ZIyNU/DgHCHBWchFYUUniBJjvgguN4pV3xXB9q3Rv5lmmHbul2lkNS+eNUe4wS+jx8G3
         c0UjqUbmzNWFZbSN2rf7Rgv8w15lH7ID5cHPRleuk59CLPmx4QIQ2gk3slPO4Xfuntmg
         q5q7XFwMNRIKqe9YhYS8etC3W7egyAsNnhpfCqTD9STrRTnkRLSBigUtQkaZOKYH/xjN
         Q7AQ==
X-Gm-Message-State: AOAM532o43CV7I2iCdHxsluT1sqQWCfgeyO/cIoq/v7fRIDny71WkddK
        r0Du6sL1EHtyGxhWi/JyKulUuRO3MKqnHh4+xIc=
X-Google-Smtp-Source: ABdhPJzc3CLrFuDtDlqT+Tdsx/kjMDUfArJpNc5UDEgBPtw06FEhnBCA0bbND95HNuwkU+xXNtRIMLo8uK13LO0zMpw=
X-Received: by 2002:a25:1657:: with SMTP id 84mr1736375ybw.251.1641897837232;
 Tue, 11 Jan 2022 02:43:57 -0800 (PST)
MIME-Version: 1.0
References: <20220111002314.15213-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220111002314.15213-7-prabhakar.mahadev-lad.rj@bp.renesas.com> <0bfff433-e216-6f9d-d225-9f07ac48013a@xs4all.nl>
In-Reply-To: <0bfff433-e216-6f9d-d225-9f07ac48013a@xs4all.nl>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 11 Jan 2022 10:43:31 +0000
Message-ID: <CA+V-a8sszaUP6o6LJgDX49oPGVQFOc6G0vtY3p6sz4JNm=xB4A@mail.gmail.com>
Subject: Re: [PATCH v2 06/13] media: davinci: vpif: Use platform_get_irq_optional()
 to get the interrupt
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-media <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Tue, Jan 11, 2022 at 10:25 AM Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
>
> Hi Prabhakar,
>
> On 11/01/2022 01:23, Lad Prabhakar wrote:
> > platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> > allocation of IRQ resources in DT core code, this causes an issue
> > when using hierarchical interrupt domains using "interrupts" property
> > in the node as this bypasses the hierarchical setup and messes up the
> > irq chaining.
> >
> > In preparation for removal of static setup of IRQ resource from DT core
> > code use platform_get_irq_optional().
> >
> > While at it, propagate error code in case devm_request_irq() fails
> > instead of returning -EINVAL in vpif_display.c.
>
> Please note that this patch clashes with [1], for which I just posted a PR [2].
>
Ouch, I think I had a comment for patch#2 which needed to be addressed
(I was nitpicking anyway) so I was hoping this will go in first.

> So once [2] is merged you'll need to rebase this patch.
>
Ok, do you want me to just re-send this patch alone or the entire series?

Cheers,
Prabhakar

> Regards,
>
>         Hans
>
> [1] https://patchwork.linuxtv.org/project/linux-media/list/?series=7000
> [2] https://patchwork.linuxtv.org/project/linux-media/patch/63d723aa-b6a3-ff42-c3e4-f1fcb979be11@xs4all.nl/
>
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1->v2
> > * Used DEFINE_RES_IRQ_NAMED() macro
> > * Considered IRQ0 as no IRQ.
> > ---
> >  drivers/media/platform/davinci/vpif.c         | 18 ++++++++------
> >  drivers/media/platform/davinci/vpif_capture.c | 24 ++++++++++++-------
> >  drivers/media/platform/davinci/vpif_display.c | 21 ++++++++++------
> >  3 files changed, 40 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/media/platform/davinci/vpif.c b/drivers/media/platform/davinci/vpif.c
> > index 5a89d885d0e3..2dbb464399cc 100644
> > --- a/drivers/media/platform/davinci/vpif.c
> > +++ b/drivers/media/platform/davinci/vpif.c
> > @@ -20,8 +20,10 @@
> >  #include <linux/err.h>
> >  #include <linux/init.h>
> >  #include <linux/io.h>
> > +#include <linux/irq.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> > +#include <linux/of.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/spinlock.h>
> > @@ -425,9 +427,10 @@ EXPORT_SYMBOL(vpif_channel_getfid);
> >
> >  static int vpif_probe(struct platform_device *pdev)
> >  {
> > -     static struct resource *res_irq;
> > +     static struct resource res_irq;
> >       struct platform_device *pdev_capture, *pdev_display;
> >       struct device_node *endpoint = NULL;
> > +     int irq;
> >
> >       vpif_base = devm_platform_ioremap_resource(pdev, 0);
> >       if (IS_ERR(vpif_base))
> > @@ -453,19 +456,20 @@ static int vpif_probe(struct platform_device *pdev)
> >        * For DT platforms, manually create platform_devices for
> >        * capture/display drivers.
> >        */
> > -     res_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> > -     if (!res_irq) {
> > -             dev_warn(&pdev->dev, "Missing IRQ resource.\n");
> > +     irq = platform_get_irq(pdev, 0);
> > +     if (irq < 0) {
> >               pm_runtime_put(&pdev->dev);
> > -             return -EINVAL;
> > +             return irq;
> >       }
> > +     res_irq = (struct resource)DEFINE_RES_IRQ_NAMED(irq, of_node_full_name(pdev->dev.of_node));
> > +     res_irq.flags |= irq_get_trigger_type(irq);
> >
> >       pdev_capture = devm_kzalloc(&pdev->dev, sizeof(*pdev_capture),
> >                                   GFP_KERNEL);
> >       if (pdev_capture) {
> >               pdev_capture->name = "vpif_capture";
> >               pdev_capture->id = -1;
> > -             pdev_capture->resource = res_irq;
> > +             pdev_capture->resource = &res_irq;
> >               pdev_capture->num_resources = 1;
> >               pdev_capture->dev.dma_mask = pdev->dev.dma_mask;
> >               pdev_capture->dev.coherent_dma_mask = pdev->dev.coherent_dma_mask;
> > @@ -480,7 +484,7 @@ static int vpif_probe(struct platform_device *pdev)
> >       if (pdev_display) {
> >               pdev_display->name = "vpif_display";
> >               pdev_display->id = -1;
> > -             pdev_display->resource = res_irq;
> > +             pdev_display->resource = &res_irq;
> >               pdev_display->num_resources = 1;
> >               pdev_display->dev.dma_mask = pdev->dev.dma_mask;
> >               pdev_display->dev.coherent_dma_mask = pdev->dev.coherent_dma_mask;
> > diff --git a/drivers/media/platform/davinci/vpif_capture.c b/drivers/media/platform/davinci/vpif_capture.c
> > index 8fe55374c5a3..aaf8a0ec98ff 100644
> > --- a/drivers/media/platform/davinci/vpif_capture.c
> > +++ b/drivers/media/platform/davinci/vpif_capture.c
> > @@ -1607,7 +1607,6 @@ static __init int vpif_probe(struct platform_device *pdev)
> >  {
> >       struct vpif_subdev_info *subdevdata;
> >       struct i2c_adapter *i2c_adap;
> > -     struct resource *res;
> >       int subdev_count;
> >       int res_idx = 0;
> >       int i, err;
> > @@ -1632,15 +1631,22 @@ static __init int vpif_probe(struct platform_device *pdev)
> >               goto vpif_free;
> >       }
> >
> > -     while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, res_idx))) {
> > -             err = devm_request_irq(&pdev->dev, res->start, vpif_channel_isr,
> > -                                     IRQF_SHARED, VPIF_DRIVER_NAME,
> > -                                     (void *)(&vpif_obj.dev[res_idx]->
> > -                                     channel_id));
> > -             if (err) {
> > -                     err = -EINVAL;
> > +     while (1) {
> > +             int irq;
> > +
> > +             err = platform_get_irq_optional(pdev, res_idx);
> > +             if (err < 0 && err != -ENXIO)
> > +                     goto vpif_unregister;
> > +             if (err > 0)
> > +                     irq = err;
> > +             else
> > +                     break;
> > +
> > +             err = devm_request_irq(&pdev->dev, irq, vpif_channel_isr,
> > +                                    IRQF_SHARED, VPIF_DRIVER_NAME,
> > +                                    (void *)(&vpif_obj.dev[res_idx]->channel_id));
> > +             if (err)
> >                       goto vpif_unregister;
> > -             }
> >               res_idx++;
> >       }
> >
> > diff --git a/drivers/media/platform/davinci/vpif_display.c b/drivers/media/platform/davinci/vpif_display.c
> > index 59f6b782e104..c4a0c4a4448c 100644
> > --- a/drivers/media/platform/davinci/vpif_display.c
> > +++ b/drivers/media/platform/davinci/vpif_display.c
> > @@ -1221,7 +1221,6 @@ static __init int vpif_probe(struct platform_device *pdev)
> >  {
> >       struct vpif_subdev_info *subdevdata;
> >       struct i2c_adapter *i2c_adap;
> > -     struct resource *res;
> >       int subdev_count;
> >       int res_idx = 0;
> >       int i, err;
> > @@ -1245,13 +1244,21 @@ static __init int vpif_probe(struct platform_device *pdev)
> >               goto vpif_free;
> >       }
> >
> > -     while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, res_idx))) {
> > -             err = devm_request_irq(&pdev->dev, res->start, vpif_channel_isr,
> > -                                     IRQF_SHARED, VPIF_DRIVER_NAME,
> > -                                     (void *)(&vpif_obj.dev[res_idx]->
> > -                                     channel_id));
> > +     while (1) {
> > +             int irq;
> > +
> > +             err = platform_get_irq_optional(pdev, res_idx);
> > +             if (err < 0 && err != -ENXIO)
> > +                     goto vpif_unregister;
> > +             if (err > 0)
> > +                     irq = err;
> > +             else
> > +                     break;
> > +
> > +             err = devm_request_irq(&pdev->dev, irq, vpif_channel_isr,
> > +                                    IRQF_SHARED, VPIF_DRIVER_NAME,
> > +                                    (void *)(&vpif_obj.dev[res_idx]->channel_id));
> >               if (err) {
> > -                     err = -EINVAL;
> >                       vpif_err("VPIF IRQ request failed\n");
> >                       goto vpif_unregister;
> >               }
>

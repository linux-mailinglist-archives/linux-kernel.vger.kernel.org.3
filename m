Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038E1497910
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 07:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235789AbiAXG4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 01:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235782AbiAXG4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 01:56:11 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34528C06173D
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 22:56:11 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id q22so2471081ljh.7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 22:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6eCEcMeA9Fkb0FluXxSrK7i6IfK5ynhLkp1exKbEon8=;
        b=OGBcMOrV1Z0m2tOW1AiBcywVQKzyrsnU/JUIawoJ4prFqLdEjMc7dVWmXZBcH7FxaY
         4qo4K6XAAa2LyDI0c+fvoiJ53fa0kXDxguZyrHyL4XJreVdSXHd27L1i52qw0X/ZNzoE
         sQr7Uzxq4SgmFQOEfr759mutd41cl50vHxVFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6eCEcMeA9Fkb0FluXxSrK7i6IfK5ynhLkp1exKbEon8=;
        b=JGoGnhS9gN9rGEIah2z/JmBkF2A19RJq7k4NYVD9w6mPsjiT3UOZ5eyAOOoK0yeS4y
         irexfsGg00M+ALomg4+b1F5tYl+Oddbge+2uTFrQea6OqDbD+dMezLCBuf6nAllyS5fq
         wYT+eK7zPqmpVIz/f6Ut/9yGkedfjXynLkkoQVMSk61KL4QZOzArvsiMw5JCdyVGAS0+
         ALuLHviVOzl/KUfhR7rRIslXSIXnUCm8YREhzkvBNC0IGT87o3py1DKTOUyePOyvqr9I
         mDWDTOCUEEF2TL4mef1+G8j4s00ihYi294IePPin0p+RfvCc3VSonfRa29XSRE9FxtNb
         cUMQ==
X-Gm-Message-State: AOAM533aoCWmbqBMdOCNLBc3dLm6aHFuLes5sRi9q9r/b3LY5fQZlLkj
        UZ5ZGLGpC+fnyUBO3WhYvC0xnaHrcWUHBWsDeDAXqg==
X-Google-Smtp-Source: ABdhPJyQX8kByoNsnhzYvi39UHrRBNLJT8x4eB8dLRIbLqUY9db041EKQT+HEsVFbuzf9bwzlZzkdhG3mdce8oTvEiU=
X-Received: by 2002:a2e:b70a:: with SMTP id j10mr10465200ljo.376.1643007369423;
 Sun, 23 Jan 2022 22:56:09 -0800 (PST)
MIME-Version: 1.0
References: <20220123033306.29799-1-qizhong.cheng@mediatek.com>
 <CAGXv+5EcAXFTnjkbeU4f3J2s4Ue5zxrN4QgS=t54BnLX8Gkw2w@mail.gmail.com> <bddf917f241a6628d43ddd95b577024c9ddf9931.camel@mediatek.com>
In-Reply-To: <bddf917f241a6628d43ddd95b577024c9ddf9931.camel@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 24 Jan 2022 14:55:58 +0800
Message-ID: <CAGXv+5GUW6qcxwnfj3dsn7Lb1yY5bNv+v+PQ2VN1NX9yPmGd2A@mail.gmail.com>
Subject: Re: [PATCH] PCI: mediatek: Change MSI interrupt processing sequence
To:     "qizhong.cheng" <qizhong.cheng@mediatek.com>
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, chuanjia.liu@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 2:27 PM qizhong.cheng
<qizhong.cheng@mediatek.com> wrote:
>
> Hi chenYu,
>
> On Mon, 2022-01-24 at 11:12 +0800, Chen-Yu Tsai wrote:
> > Hi,
> >
> > On Sun, Jan 23, 2022 at 11:34 AM qizhong cheng
> > <qizhong.cheng@mediatek.com> wrote:
> > >
> > > As an edge-triggered interrupts, its interrupt status should be
> > > cleared
> > > before dispatch to the handler of device.
> >
> > I'm curious, is this just a code correction or are there real world
> > cases where something fails?
>
> Yes, we found a failure when used iperf tool for wifi and network cards
> performance testing. The function of "while" has just been executed,
> and the EP sent an MSI before executing "Clear MSI interrupt status".
> After executing "Clear MSI interrupt status", this edge-triggered
> interrupt status is cleared, but EP is still waiting for interrupt
> handler.

Can you also include this in the commit log?  It would be nice to record
the exact scenario that this fix targets.

ChenYu

> >
> > Also, please add a Fixes tag and maybe Cc stable so this gets
> > backported
> > automatically.
>
> Thanks for your review, I will fix it in the next version.
>
> >
> > ChenYu
> >
> > > Signed-off-by: qizhong cheng <qizhong.cheng@mediatek.com>
> > > ---
> > >  drivers/pci/controller/pcie-mediatek.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/pcie-mediatek.c
> > > b/drivers/pci/controller/pcie-mediatek.c
> > > index 2f3f974977a3..705ea33758b1 100644
> > > --- a/drivers/pci/controller/pcie-mediatek.c
> > > +++ b/drivers/pci/controller/pcie-mediatek.c
> > > @@ -624,12 +624,12 @@ static void mtk_pcie_intr_handler(struct
> > > irq_desc *desc)
> > >                 if (status & MSI_STATUS){
> > >                         unsigned long imsi_status;
> > >
> > > +                       /* Clear MSI interrupt status */
> > > +                       writel(MSI_STATUS, port->base +
> > > PCIE_INT_STATUS);
> > >                         while ((imsi_status = readl(port->base +
> > > PCIE_IMSI_STATUS))) {
> > >                                 for_each_set_bit(bit, &imsi_status,
> > > MTK_MSI_IRQS_NUM)
> > >                                         generic_handle_domain_irq(p
> > > ort->inner_domain, bit);
> > >                         }
> > > -                       /* Clear MSI interrupt status */
> > > -                       writel(MSI_STATUS, port->base +
> > > PCIE_INT_STATUS);
> > >                 }
> > >         }
> > >
> > > --
> > > 2.25.1
> > >
> > >
> > > _______________________________________________
> > > Linux-mediatek mailing list
> > > Linux-mediatek@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-mediatek
>

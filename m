Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B806B47E730
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 18:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244502AbhLWRhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 12:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237588AbhLWRhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 12:37:23 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4895FC061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 09:37:23 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id d10so18594479ybe.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 09:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KUeVodc32xriSm1pts3x5c9nn/1tURjzxfW/sn365PQ=;
        b=pUhYAX/xZmgCQH10337pELpQwQeqYlsrNaSrJZpIiPKfCv2VZngQDBpaelUOctwRmA
         fMtJpgbEovFrAn7Ot6fv6ujwLBpifVJ0C1ZyGGOJ7Y2hK45Xd8pBWRfEw2JT+3+j968v
         4YT3bxpFsoPhvoXKxbJC2lUrlk7KHXCfeKJoJbwhefbBm8KFrX6TjECv/N5vHTj06nde
         wYDllw8uCKfuPCElnv+gNk2zP94g2ne/LlvxK68l/xdu2a/inS2gCaSJ9slb5vToqOwQ
         16OeASno9PbnY4U2kcO36hCGwtJUCuXAn6WH05Wa9Ciunc7FLb37OPNQ7wfUnB1GvJDj
         5Prw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KUeVodc32xriSm1pts3x5c9nn/1tURjzxfW/sn365PQ=;
        b=kfaCKpQ+eNqqTjgmr0wht/lQm30mT0J5ez5PI+LGCpxXEm+fCfAj+UH7CSg70b6NdU
         UzGtcHXWxx5M1a3Rr0ApjQqPRgEeI/JA7jabenPM4jaPsI+BzmvbmrWLsK0omuu5PtvD
         ccp9HbyGq78C0IOGQV0b2O2RuZZJRDIQR1exFaydUEQYwAe+Nv4E75eyc+Jaf1UHtPPs
         XrwQG2+BljZQNQsvVybYhmhKKut3ZNd56kJjmCK4EGPgy6SdGGgrkvLodJ7bzLXaobRg
         bO73Hz/arpCb2ysS6mehYKXbSyt/UxFsv6aNAo+27pDj/od9i8lr4fbVfOXrjGllUpkY
         y+Ig==
X-Gm-Message-State: AOAM532EcpVRgTjC5l44IAzSShGwwKDOx+iKXsTy3cukDp2ar2NygULT
        e3NRAJfEfDJpFrFO7kXiSlSuGoo40HjIfnX1XeU=
X-Google-Smtp-Source: ABdhPJwGp0CD0g7j0WHniWa/we1JWICoA+6kOxGAF1A+2M8FxbUKy01MKjP6qea2hb9gkJFTI8naq162/Tn1tOLAmVc=
X-Received: by 2002:a25:98c4:: with SMTP id m4mr4574126ybo.613.1640281042468;
 Thu, 23 Dec 2021 09:37:22 -0800 (PST)
MIME-Version: 1.0
References: <20211223130046.9365-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211223130046.9365-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <f9efc8e8-9dc6-8a80-15bb-bc2d9aaf60cb@arm.com>
In-Reply-To: <f9efc8e8-9dc6-8a80-15bb-bc2d9aaf60cb@arm.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 23 Dec 2021 17:36:56 +0000
Message-ID: <CA+V-a8vqpX=z9a+s=pgCY07EE6=uhdtq_NJOr+8VoGZ21kUmLQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] iommu/arm-smmu: Use platform_irq_count() to get the
 interrupt count
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Rob Clark <robdclark@chromium.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Xin Tan <tanxin.ctf@gmail.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

Thank you for the review.

On Thu, Dec 23, 2021 at 2:14 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-12-23 13:00, Lad Prabhakar wrote:
> > platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> > allocation of IRQ resources in DT core code, this causes an issue
> > when using hierarchical interrupt domains using "interrupts" property
> > in the node as this bypasses the hierarchical setup and messes up the
> > irq chaining.
> >
> > In preparation for removal of static setup of IRQ resource from DT core
> > code use platform_get_irq_count().
>
> Nit: platform_irq_count()
>
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >   drivers/iommu/arm/arm-smmu/arm-smmu.c | 12 ++++++------
> >   1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > index 4bc75c4ce402..4844cd075644 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > @@ -2105,12 +2105,12 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
> >       if (IS_ERR(smmu))
> >               return PTR_ERR(smmu);
> >
> > -     num_irqs = 0;
> > -     while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, num_irqs))) {
> > -             num_irqs++;
> > -             if (num_irqs > smmu->num_global_irqs)
> > -                     smmu->num_context_irqs++;
> > -     }
> > +     num_irqs = platform_irq_count(pdev);
> > +     if (num_irqs < 0)
> > +             return num_irqs;
> > +
> > +     if (num_irqs > smmu->num_global_irqs)
> > +             smmu->num_context_irqs += (num_irqs - smmu->num_global_irqs);
>
> This seems a bit overcomplicated. I reckon:
>
>         smmu->num_context_irqs = num_irqs - smmu->num_global_irqs;
>         if (num_irqs <= smmu->num_global_irqs) {
>                 dev_err(...
>
> should do it.
>
Agreed.

> However, FYI I have some patches refactoring most of the IRQ stuff here
> that I plan to post next cycle (didn't quite have time to get them done
> for 5.17 as I'd hoped...), so unless this needs to go in right now as an
> urgent fix, I'm happy to take care of removing platform_get_resource()
> as part of that if it's easier.
>
Fine by me, let me know if it gets any later than planned I'll send a v2.

Cheers,
Prabhakar

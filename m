Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4AE4ADC5B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379708AbiBHPTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379804AbiBHPTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:19:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927A9C0613CA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 07:19:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28D9861476
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 15:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62CEBC004E1;
        Tue,  8 Feb 2022 15:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644333578;
        bh=fIjxqOup6OwNvRXLtgfT5VcCzdLMcW360tWbTxHYLyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A691zmXwYzGeuKQXa/N6uWG/wsfSLBJIJOtIyoGzTkIcBq2+cKkBle4kAQZ3gf+LW
         6sbg9V+g9m17lomD+4XR/Fq0Nz1KWjzZJ2z9bvoABFRKK4CWEsDwTS+j9diztxWY5U
         5UXR0x7A7qrV8mSM9G9B1Thn/AKdWiSATfqkKb9Oq0w8I+1x5yQItdfX9CJ3aHyB0u
         c+ouxKI86H33fVqpGBCrVmopDZImiC4X5ciw2dWYaI6AzSGK48MqDIEisJYMwKA0h3
         FqxURq4I9v4S9ZRK+D6/wRH6yQ9iL48Qy1h7Yr29kRktyncaj9v2KXS2q3qHR2ftsQ
         7290lS/6N5klA==
Date:   Tue, 8 Feb 2022 15:19:32 +0000
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, Xin Tan <tanxin.ctf@gmail.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH 1/2] iommu/arm-smmu: Use platform_irq_count() to get the
 interrupt count
Message-ID: <20220208151932.GB1802@willie-the-truck>
References: <20211223130046.9365-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211223130046.9365-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <f9efc8e8-9dc6-8a80-15bb-bc2d9aaf60cb@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9efc8e8-9dc6-8a80-15bb-bc2d9aaf60cb@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 02:14:35PM +0000, Robin Murphy wrote:
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
> >   	if (IS_ERR(smmu))
> >   		return PTR_ERR(smmu);
> > -	num_irqs = 0;
> > -	while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, num_irqs))) {
> > -		num_irqs++;
> > -		if (num_irqs > smmu->num_global_irqs)
> > -			smmu->num_context_irqs++;
> > -	}
> > +	num_irqs = platform_irq_count(pdev);
> > +	if (num_irqs < 0)
> > +		return num_irqs;
> > +
> > +	if (num_irqs > smmu->num_global_irqs)
> > +		smmu->num_context_irqs += (num_irqs - smmu->num_global_irqs);
> 
> This seems a bit overcomplicated. I reckon:
> 
> 	smmu->num_context_irqs = num_irqs - smmu->num_global_irqs;
> 	if (num_irqs <= smmu->num_global_irqs) {
> 		dev_err(...
> 
> should do it.
> 
> However, FYI I have some patches refactoring most of the IRQ stuff here that
> I plan to post next cycle (didn't quite have time to get them done for 5.17
> as I'd hoped...), so unless this needs to go in right now as an urgent fix,
> I'm happy to take care of removing platform_get_resource() as part of that
> if it's easier.

Did you get anywhere with this? December 23rd is long forgotten by now ;)

Will

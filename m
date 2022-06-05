Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E09B53DE8C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 00:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351595AbiFEWGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 18:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238038AbiFEWGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 18:06:25 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [5.144.164.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307DA17043
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 15:06:23 -0700 (PDT)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 93A3820569;
        Mon,  6 Jun 2022 00:06:19 +0200 (CEST)
Date:   Mon, 6 Jun 2022 00:06:18 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Will Deacon <will@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        jamipkettunen@somainline.org, Rob Clark <robdclark@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] iommu/qcom: Write TCR before TTBRs to fix ASID
 access behavior
Message-ID: <20220605220618.n6rkb6cfdzzgst3j@SoMainline.org>
References: <20220527212901.29268-1-konrad.dybcio@somainline.org>
 <20220527212901.29268-3-konrad.dybcio@somainline.org>
 <20220531155559.GB25502@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531155559.GB25502@willie-the-truck>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-31 16:55:59, Will Deacon wrote:
> On Fri, May 27, 2022 at 11:28:57PM +0200, Konrad Dybcio wrote:
> > From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> > 
> > As also stated in the arm-smmu driver, we must write the TCR before
> > writing the TTBRs, since the TCR determines the access behavior of
> > some fields.
> 
> Where is this stated in the arm-smmu driver?
> 
> > 
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> > ---
> >  drivers/iommu/arm/arm-smmu/qcom_iommu.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> > index 1728d4d7fe25..75f353866c40 100644
> > --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> > +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> > @@ -273,18 +273,18 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
> >  			ctx->secure_init = true;
> >  		}
> >  
> > -		/* TTBRs */
> > -		iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
> > -				pgtbl_cfg.arm_lpae_s1_cfg.ttbr |
> > -				FIELD_PREP(ARM_SMMU_TTBRn_ASID, ctx->asid));
> > -		iommu_writeq(ctx, ARM_SMMU_CB_TTBR1, 0);
> > -
> >  		/* TCR */
> >  		iommu_writel(ctx, ARM_SMMU_CB_TCR2,
> >  				arm_smmu_lpae_tcr2(&pgtbl_cfg));
> >  		iommu_writel(ctx, ARM_SMMU_CB_TCR,
> >  			     arm_smmu_lpae_tcr(&pgtbl_cfg) | ARM_SMMU_TCR_EAE);
> >  
> > +		/* TTBRs */
> > +		iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
> > +				pgtbl_cfg.arm_lpae_s1_cfg.ttbr |
> > +				FIELD_PREP(ARM_SMMU_TTBRn_ASID, ctx->asid));
> > +		iommu_writeq(ctx, ARM_SMMU_CB_TTBR1, 0);
> 
> I'd have thought that SCTLR.M would be clear here, so it shouldn't matter
> what order we write these in.

Having tested the series without this particular patch on 8976 (Sony
Loire Suzu), it doesn't seem to matter indeed.  I'll ask around if this
"access behaviour" was observed on a different board/platform.

- Marijn

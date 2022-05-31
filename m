Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185C453945B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 17:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345937AbiEaP4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 11:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243830AbiEaP4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 11:56:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34FD527F4;
        Tue, 31 May 2022 08:56:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A4CF613E2;
        Tue, 31 May 2022 15:56:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E06C385A9;
        Tue, 31 May 2022 15:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654012568;
        bh=7uGXLWpMXH5FP6g6lTa6LFc8636SvC0zhKEGjnRNQQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nYtB3DJFhm85N5k2gFA65iswAFxUThtvjMc4GPWr3W1OuKdQUsz5cvy4dtpq9hZAI
         pl7Wb2d7vYHwzDdEcZxi6sc8IVkKlbCmxVqR3OkM5AQJP+5JDPcNBNy0dkoB5u3+SK
         9Ls2FeWFT3GMgjXoZbJD1XnlLzNxvSsnUd1YUeL/Kwv+mIBkldV1xHA+5PZwQQhB2w
         b3jWTjlA6iycPQGZmYYZ6SbyaVZ4he4sXOMACC5wHFXof86nHuUSkalvwuzEGDPSji
         ToVddgHJweOKFr4n1epMSbiwTvwaWLuDOZbPV+8kagsaE+jBg360qYmIIF9XJh0f+J
         6gSMUOlnNUEag==
Date:   Tue, 31 May 2022 16:55:59 +0100
From:   Will Deacon <will@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Rob Clark <robdclark@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] iommu/qcom: Write TCR before TTBRs to fix ASID
 access behavior
Message-ID: <20220531155559.GB25502@willie-the-truck>
References: <20220527212901.29268-1-konrad.dybcio@somainline.org>
 <20220527212901.29268-3-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527212901.29268-3-konrad.dybcio@somainline.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 11:28:57PM +0200, Konrad Dybcio wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> 
> As also stated in the arm-smmu driver, we must write the TCR before
> writing the TTBRs, since the TCR determines the access behavior of
> some fields.

Where is this stated in the arm-smmu driver?

> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> index 1728d4d7fe25..75f353866c40 100644
> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> @@ -273,18 +273,18 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
>  			ctx->secure_init = true;
>  		}
>  
> -		/* TTBRs */
> -		iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
> -				pgtbl_cfg.arm_lpae_s1_cfg.ttbr |
> -				FIELD_PREP(ARM_SMMU_TTBRn_ASID, ctx->asid));
> -		iommu_writeq(ctx, ARM_SMMU_CB_TTBR1, 0);
> -
>  		/* TCR */
>  		iommu_writel(ctx, ARM_SMMU_CB_TCR2,
>  				arm_smmu_lpae_tcr2(&pgtbl_cfg));
>  		iommu_writel(ctx, ARM_SMMU_CB_TCR,
>  			     arm_smmu_lpae_tcr(&pgtbl_cfg) | ARM_SMMU_TCR_EAE);
>  
> +		/* TTBRs */
> +		iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
> +				pgtbl_cfg.arm_lpae_s1_cfg.ttbr |
> +				FIELD_PREP(ARM_SMMU_TTBRn_ASID, ctx->asid));
> +		iommu_writeq(ctx, ARM_SMMU_CB_TTBR1, 0);

I'd have thought that SCTLR.M would be clear here, so it shouldn't matter
what order we write these in.

Will

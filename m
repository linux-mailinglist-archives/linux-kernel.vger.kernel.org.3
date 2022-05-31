Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC8C5394F3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 18:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346151AbiEaQ0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 12:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241124AbiEaQ0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 12:26:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81AE195DDB;
        Tue, 31 May 2022 09:26:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 484C023A;
        Tue, 31 May 2022 09:26:21 -0700 (PDT)
Received: from [10.57.81.38] (unknown [10.57.81.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E8023F73D;
        Tue, 31 May 2022 09:26:19 -0700 (PDT)
Message-ID: <edf89f9a-23ce-16ce-33f4-7796ed6bdb4c@arm.com>
Date:   Tue, 31 May 2022 17:26:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/6] iommu/qcom: Write TCR before TTBRs to fix ASID access
 behavior
Content-Language: en-GB
To:     Will Deacon <will@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        jamipkettunen@somainline.org, iommu@lists.linux-foundation.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, linux-arm-kernel@lists.infradead.org
References: <20220527212901.29268-1-konrad.dybcio@somainline.org>
 <20220527212901.29268-3-konrad.dybcio@somainline.org>
 <20220531155559.GB25502@willie-the-truck>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220531155559.GB25502@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-31 16:55, Will Deacon wrote:
> On Fri, May 27, 2022 at 11:28:57PM +0200, Konrad Dybcio wrote:
>> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>>
>> As also stated in the arm-smmu driver, we must write the TCR before
>> writing the TTBRs, since the TCR determines the access behavior of
>> some fields.
> 
> Where is this stated in the arm-smmu driver?

In arm_smmu_write_context_bank() - IIRC it's mostly about the case where 
if you write a 16-bit ASID to TTBR before setting TCR2.AS you might end 
up losing the top 8 bits of it. However, in the context of a pantomime 
where we just have to pretend to program the "hardware" the way the 
firmware has already programmed it (on pain of getting randomly reset if 
we look at it wrong), I can't imagine it really matters.

Robin.

>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>> ---
>>   drivers/iommu/arm/arm-smmu/qcom_iommu.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
>> index 1728d4d7fe25..75f353866c40 100644
>> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
>> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
>> @@ -273,18 +273,18 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
>>   			ctx->secure_init = true;
>>   		}
>>   
>> -		/* TTBRs */
>> -		iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
>> -				pgtbl_cfg.arm_lpae_s1_cfg.ttbr |
>> -				FIELD_PREP(ARM_SMMU_TTBRn_ASID, ctx->asid));
>> -		iommu_writeq(ctx, ARM_SMMU_CB_TTBR1, 0);
>> -
>>   		/* TCR */
>>   		iommu_writel(ctx, ARM_SMMU_CB_TCR2,
>>   				arm_smmu_lpae_tcr2(&pgtbl_cfg));
>>   		iommu_writel(ctx, ARM_SMMU_CB_TCR,
>>   			     arm_smmu_lpae_tcr(&pgtbl_cfg) | ARM_SMMU_TCR_EAE);
>>   
>> +		/* TTBRs */
>> +		iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
>> +				pgtbl_cfg.arm_lpae_s1_cfg.ttbr |
>> +				FIELD_PREP(ARM_SMMU_TTBRn_ASID, ctx->asid));
>> +		iommu_writeq(ctx, ARM_SMMU_CB_TTBR1, 0);
> 
> I'd have thought that SCTLR.M would be clear here, so it shouldn't matter
> what order we write these in.
> 
> Will
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

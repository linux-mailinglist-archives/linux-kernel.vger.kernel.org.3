Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09D6542E7B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237435AbiFHKyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237009AbiFHKyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:54:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A80EA13F3C;
        Wed,  8 Jun 2022 03:54:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39283139F;
        Wed,  8 Jun 2022 03:54:29 -0700 (PDT)
Received: from [10.57.83.136] (unknown [10.57.83.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 897F33F73B;
        Wed,  8 Jun 2022 03:54:26 -0700 (PDT)
Message-ID: <4911a6c8-e494-5a5e-015d-d9fcf886d253@arm.com>
Date:   Wed, 8 Jun 2022 11:54:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/6] iommu/qcom: Write TCR before TTBRs to fix ASID access
 behavior
Content-Language: en-GB
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Will Deacon <will@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        jamipkettunen@somainline.org, Rob Clark <robdclark@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org
References: <20220527212901.29268-1-konrad.dybcio@somainline.org>
 <20220527212901.29268-3-konrad.dybcio@somainline.org>
 <20220531155559.GB25502@willie-the-truck>
 <20220605220618.n6rkb6cfdzzgst3j@SoMainline.org>
 <1930a7b3-3637-9e3b-3dac-7baf034c7b7a@collabora.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1930a7b3-3637-9e3b-3dac-7baf034c7b7a@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-08 11:27, AngeloGioacchino Del Regno wrote:
> Il 06/06/22 00:06, Marijn Suijten ha scritto:
>> On 2022-05-31 16:55:59, Will Deacon wrote:
>>> On Fri, May 27, 2022 at 11:28:57PM +0200, Konrad Dybcio wrote:
>>>> From: AngeloGioacchino Del Regno 
>>>> <angelogioacchino.delregno@somainline.org>
>>>>
>>>> As also stated in the arm-smmu driver, we must write the TCR before
>>>> writing the TTBRs, since the TCR determines the access behavior of
>>>> some fields.
>>>
>>> Where is this stated in the arm-smmu driver?
>>>
>>>>
>>>> Signed-off-by: AngeloGioacchino Del Regno 
>>>> <angelogioacchino.delregno@somainline.org>
>>>> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>>>> ---
>>>>   drivers/iommu/arm/arm-smmu/qcom_iommu.c | 12 ++++++------
>>>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c 
>>>> b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
>>>> index 1728d4d7fe25..75f353866c40 100644
>>>> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
>>>> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
>>>> @@ -273,18 +273,18 @@ static int qcom_iommu_init_domain(struct 
>>>> iommu_domain *domain,
>>>>               ctx->secure_init = true;
>>>>           }
>>>> -        /* TTBRs */
>>>> -        iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
>>>> -                pgtbl_cfg.arm_lpae_s1_cfg.ttbr |
>>>> -                FIELD_PREP(ARM_SMMU_TTBRn_ASID, ctx->asid));
>>>> -        iommu_writeq(ctx, ARM_SMMU_CB_TTBR1, 0);
>>>> -
>>>>           /* TCR */
>>>>           iommu_writel(ctx, ARM_SMMU_CB_TCR2,
>>>>                   arm_smmu_lpae_tcr2(&pgtbl_cfg));
>>>>           iommu_writel(ctx, ARM_SMMU_CB_TCR,
>>>>                    arm_smmu_lpae_tcr(&pgtbl_cfg) | ARM_SMMU_TCR_EAE);
>>>> +        /* TTBRs */
>>>> +        iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
>>>> +                pgtbl_cfg.arm_lpae_s1_cfg.ttbr |
>>>> +                FIELD_PREP(ARM_SMMU_TTBRn_ASID, ctx->asid));
>>>> +        iommu_writeq(ctx, ARM_SMMU_CB_TTBR1, 0);
>>>
>>> I'd have thought that SCTLR.M would be clear here, so it shouldn't 
>>> matter
>>> what order we write these in.
>>
>> Having tested the series without this particular patch on 8976 (Sony
>> Loire Suzu), it doesn't seem to matter indeed.  I'll ask around if this
>> "access behaviour" was observed on a different board/platform.
>>
>> - Marijn
> 
> On some platforms, the bootloader (and/or the hypervisor) is performing 
> some
> initialization of the IOMMU which, depending on the actual firmware version
> that ran before booting Linux, may or may not leave SCTLR.M cleared.

But does it actually matter even then? If we're only allowed to program 
the same ASID that was in use beforehand, then logically we can't be 
changing TCR2.AS in a way that makes any difference anyway.

I see no point in pretending to worry about theoretical architectural 
correctness in a driver tied to specific implementations that already 
violate the given architecture in many other ways. If there's a known 
firmware implementation that definitely requires this, that should be 
called out; otherwise, there doesn't seem much justification for the 
patch at all.

Thanks,
Robin.

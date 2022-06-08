Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4337D542DF7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237517AbiFHKfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239072AbiFHKey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:34:54 -0400
X-Greylist: delayed 150 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Jun 2022 03:28:28 PDT
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D752A3B8D;
        Wed,  8 Jun 2022 03:28:26 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2C259660181B;
        Wed,  8 Jun 2022 11:27:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654684053;
        bh=Kq9FiJlI6hhYA2IYA9Osr8xu/rdeYfLtmdfJ9Zo21bQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FQi1/TEz3EasDsgmDWKT21PyoHVa0B1l+hnaC+he5pFJCyG0OBxNaBihX1tZuKQD+
         mHKU1KaOba8jFYXdNqbdrrXqN8lO8lO7Culr0dnlbmYCPH6JEm9O2Sak9yiNqs8O5i
         FFl6wdxReAhG7BA2vfcP69C8vrQns3Cs9NtrCqVfV4s2uIQmpNazeEGoMOAd61WZTp
         s8dFGBeK31HkaAPVpksS12zrex99GIZuBoQHFs4/60HgPC0MlWj453xyuiiW3H6j/i
         1tlfMROMlR6dBcYBB7STPOJ7YR7lJUo0AFJNk0XjhDhIIdDzh8dKdNPEDhMTdpKc9V
         W1qk3cDcXPd5Q==
Message-ID: <1930a7b3-3637-9e3b-3dac-7baf034c7b7a@collabora.com>
Date:   Wed, 8 Jun 2022 12:27:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/6] iommu/qcom: Write TCR before TTBRs to fix ASID access
 behavior
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Will Deacon <will@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        jamipkettunen@somainline.org, Rob Clark <robdclark@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org
References: <20220527212901.29268-1-konrad.dybcio@somainline.org>
 <20220527212901.29268-3-konrad.dybcio@somainline.org>
 <20220531155559.GB25502@willie-the-truck>
 <20220605220618.n6rkb6cfdzzgst3j@SoMainline.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220605220618.n6rkb6cfdzzgst3j@SoMainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/06/22 00:06, Marijn Suijten ha scritto:
> On 2022-05-31 16:55:59, Will Deacon wrote:
>> On Fri, May 27, 2022 at 11:28:57PM +0200, Konrad Dybcio wrote:
>>> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>>>
>>> As also stated in the arm-smmu driver, we must write the TCR before
>>> writing the TTBRs, since the TCR determines the access behavior of
>>> some fields.
>>
>> Where is this stated in the arm-smmu driver?
>>
>>>
>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>>> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>>> ---
>>>   drivers/iommu/arm/arm-smmu/qcom_iommu.c | 12 ++++++------
>>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
>>> index 1728d4d7fe25..75f353866c40 100644
>>> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
>>> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
>>> @@ -273,18 +273,18 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
>>>   			ctx->secure_init = true;
>>>   		}
>>>   
>>> -		/* TTBRs */
>>> -		iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
>>> -				pgtbl_cfg.arm_lpae_s1_cfg.ttbr |
>>> -				FIELD_PREP(ARM_SMMU_TTBRn_ASID, ctx->asid));
>>> -		iommu_writeq(ctx, ARM_SMMU_CB_TTBR1, 0);
>>> -
>>>   		/* TCR */
>>>   		iommu_writel(ctx, ARM_SMMU_CB_TCR2,
>>>   				arm_smmu_lpae_tcr2(&pgtbl_cfg));
>>>   		iommu_writel(ctx, ARM_SMMU_CB_TCR,
>>>   			     arm_smmu_lpae_tcr(&pgtbl_cfg) | ARM_SMMU_TCR_EAE);
>>>   
>>> +		/* TTBRs */
>>> +		iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
>>> +				pgtbl_cfg.arm_lpae_s1_cfg.ttbr |
>>> +				FIELD_PREP(ARM_SMMU_TTBRn_ASID, ctx->asid));
>>> +		iommu_writeq(ctx, ARM_SMMU_CB_TTBR1, 0);
>>
>> I'd have thought that SCTLR.M would be clear here, so it shouldn't matter
>> what order we write these in.
> 
> Having tested the series without this particular patch on 8976 (Sony
> Loire Suzu), it doesn't seem to matter indeed.  I'll ask around if this
> "access behaviour" was observed on a different board/platform.
> 
> - Marijn

On some platforms, the bootloader (and/or the hypervisor) is performing some
initialization of the IOMMU which, depending on the actual firmware version
that ran before booting Linux, may or may not leave SCTLR.M cleared.

Cheers,
Angelo

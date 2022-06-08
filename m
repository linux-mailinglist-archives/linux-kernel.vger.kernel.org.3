Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F97542E9F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 13:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237446AbiFHLDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 07:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237403AbiFHLDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 07:03:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5ECB8A32A;
        Wed,  8 Jun 2022 04:03:18 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 901E566016FD;
        Wed,  8 Jun 2022 12:03:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654686197;
        bh=rFzcWUsWEhZ5a2h/qAW0YZxnMQx08NX5sEO/CaAZHwY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GIVKw8FrdL+nDZ77LqwwlCHLGA9EvGE3PaE4jeVQpLtqYJl6BA1aZNJssNr6jEaUi
         miY2V8Ui+66FOEfr2CFddTDBhIQQbVkr5QpKaENEEV5n3EjltAzUCXM328H6nryJ4u
         lyZB1muOegm2OA2ATe45VQRNboB5rnyqnOK75Ku1zjaXzYWubWBkNbNk3Tj2D5LrY2
         pD/g0zfUUP1nffU1Gy2MLJKdqQ4ZJT1wBKoRQCKBswLhtdJmxSS2yLhMJe6onlDxkd
         q4tD5kHp85lFcEYxji3vzh9znRB+v/zWno8xAZ5x7dggMcuS+5oCSQUvYS7O/PKR+s
         9dJBUXIpN6H6w==
Message-ID: <24931967-87be-5207-eb2b-47c064aee0c7@collabora.com>
Date:   Wed, 8 Jun 2022 13:03:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/6] iommu/qcom: Write TCR before TTBRs to fix ASID access
 behavior
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>,
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
 <4911a6c8-e494-5a5e-015d-d9fcf886d253@arm.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <4911a6c8-e494-5a5e-015d-d9fcf886d253@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/06/22 12:54, Robin Murphy ha scritto:
> On 2022-06-08 11:27, AngeloGioacchino Del Regno wrote:
>> Il 06/06/22 00:06, Marijn Suijten ha scritto:
>>> On 2022-05-31 16:55:59, Will Deacon wrote:
>>>> On Fri, May 27, 2022 at 11:28:57PM +0200, Konrad Dybcio wrote:
>>>>> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>>>>>
>>>>> As also stated in the arm-smmu driver, we must write the TCR before
>>>>> writing the TTBRs, since the TCR determines the access behavior of
>>>>> some fields.
>>>>
>>>> Where is this stated in the arm-smmu driver?
>>>>
>>>>>
>>>>> Signed-off-by: AngeloGioacchino Del Regno 
>>>>> <angelogioacchino.delregno@somainline.org>
>>>>> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>>>>> ---
>>>>>   drivers/iommu/arm/arm-smmu/qcom_iommu.c | 12 ++++++------
>>>>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c 
>>>>> b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
>>>>> index 1728d4d7fe25..75f353866c40 100644
>>>>> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
>>>>> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
>>>>> @@ -273,18 +273,18 @@ static int qcom_iommu_init_domain(struct iommu_domain 
>>>>> *domain,
>>>>>               ctx->secure_init = true;
>>>>>           }
>>>>> -        /* TTBRs */
>>>>> -        iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
>>>>> -                pgtbl_cfg.arm_lpae_s1_cfg.ttbr |
>>>>> -                FIELD_PREP(ARM_SMMU_TTBRn_ASID, ctx->asid));
>>>>> -        iommu_writeq(ctx, ARM_SMMU_CB_TTBR1, 0);
>>>>> -
>>>>>           /* TCR */
>>>>>           iommu_writel(ctx, ARM_SMMU_CB_TCR2,
>>>>>                   arm_smmu_lpae_tcr2(&pgtbl_cfg));
>>>>>           iommu_writel(ctx, ARM_SMMU_CB_TCR,
>>>>>                    arm_smmu_lpae_tcr(&pgtbl_cfg) | ARM_SMMU_TCR_EAE);
>>>>> +        /* TTBRs */
>>>>> +        iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
>>>>> +                pgtbl_cfg.arm_lpae_s1_cfg.ttbr |
>>>>> +                FIELD_PREP(ARM_SMMU_TTBRn_ASID, ctx->asid));
>>>>> +        iommu_writeq(ctx, ARM_SMMU_CB_TTBR1, 0);
>>>>
>>>> I'd have thought that SCTLR.M would be clear here, so it shouldn't matter
>>>> what order we write these in.
>>>
>>> Having tested the series without this particular patch on 8976 (Sony
>>> Loire Suzu), it doesn't seem to matter indeed.  I'll ask around if this
>>> "access behaviour" was observed on a different board/platform.
>>>
>>> - Marijn
>>
>> On some platforms, the bootloader (and/or the hypervisor) is performing some
>> initialization of the IOMMU which, depending on the actual firmware version
>> that ran before booting Linux, may or may not leave SCTLR.M cleared.
> 
> But does it actually matter even then? If we're only allowed to program the same 
> ASID that was in use beforehand, then logically we can't be changing TCR2.AS in a 
> way that makes any difference anyway.
> 
> I see no point in pretending to worry about theoretical architectural correctness 
> in a driver tied to specific implementations that already violate the given 
> architecture in many other ways. If there's a known firmware implementation that 
> definitely requires this, that should be called out; otherwise, there doesn't seem 
> much justification for the patch at all.
> 

This is something I wrote more than one year ago, hence I don't remember clearly,
but if my memories aren't failing me, this was necessary to enable support for
the AArch64 pagetables.
If that doesn't make sense to you, I guess that Marijn or Konrad can help testing
switching to AA64 PT with the incorrect programming sequence.

Aside from that, as a strictly personal opinion (and nothing else), I think that
ensuring architectural correctness *where possible* can only be good: I don't see
why we should intentionally keep a wrong programming sequence in principle.

Regards,
Angelo

> Thanks,
> Robin.



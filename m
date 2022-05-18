Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D4C52B4EE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 10:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbiERI3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 04:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbiERI3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 04:29:31 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F95131F1D;
        Wed, 18 May 2022 01:29:30 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 3EE671F44C48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652862568;
        bh=B5iXBTSLQ4uTMVDMAikh/PyBC8/1DmHnDiYnDQpXUGc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VcZSgyDFkXVQ7ZBn6tniLuaZ9UMwP2ol1ef2Kzy5s8z7Xo9QrYRbECkueg5HvXsu7
         Kj0VuXcW9sczbDy0CexTkc3zMJf3rKpQzlGST0kZr8cbOuqQ9rUy3ht1H7G9Q2rmnU
         UOlyrtxgsMkLwV4A0gJdMmkKPmLvofWMD6kNgk6rpx+DVqph87f5Qb8dUdTBUjZkzH
         WDAW1JqlhB3X/IxoSD3TV8WpPVN6JuYGyV4MfFvyWUqZFsIZCMF4nyHI0hwskPq+g7
         Od19IMjW/qJd5+RBTtB5vaoC921CK71aF1PFQozoeBmiE9QRtEd6h7f4XRjg944Mvv
         qqJcGEHj8exew==
Message-ID: <b003c37c-0f2d-31f6-6a74-4e1f0f4a1ccb@collabora.com>
Date:   Wed, 18 May 2022 10:29:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/8] iommu: mtk_iommu: Lookup phandle to retrieve syscon
 to infracfg
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, yong.wu@mediatek.com
Cc:     joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220517132107.195932-1-angelogioacchino.delregno@collabora.com>
 <20220517132107.195932-3-angelogioacchino.delregno@collabora.com>
 <16fb07d9-28d8-5c73-1eb5-ec13544d22e5@arm.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <16fb07d9-28d8-5c73-1eb5-ec13544d22e5@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/05/22 16:12, Robin Murphy ha scritto:
> On 2022-05-17 14:21, AngeloGioacchino Del Regno wrote:
>> This driver will get support for more SoCs and the list of infracfg
>> compatibles is expected to grow: in order to prevent getting this
>> situation out of control and see a long list of compatible strings,
>> add support to retrieve a handle to infracfg's regmap through a
>> new "mediatek,infracfg" phandle.
>>
>> In order to keep retrocompatibility with older devicetrees, the old
>> way is kept in place, but also a dev_warn() was added to advertise
>> this change in hope that the user will see it and eventually update
>> the devicetree if this is possible.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/iommu/mtk_iommu.c | 40 +++++++++++++++++++++++++--------------
>>   1 file changed, 26 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
>> index 71b2ace74cd6..cfaaa98d2b50 100644
>> --- a/drivers/iommu/mtk_iommu.c
>> +++ b/drivers/iommu/mtk_iommu.c
>> @@ -1134,22 +1134,34 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>>       data->protect_base = ALIGN(virt_to_phys(protect), MTK_PROTECT_PA_ALIGN);
>>       if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_4GB_MODE)) {
>> -        switch (data->plat_data->m4u_plat) {
>> -        case M4U_MT2712:
>> -            p = "mediatek,mt2712-infracfg";
>> -            break;
>> -        case M4U_MT8173:
>> -            p = "mediatek,mt8173-infracfg";
>> -            break;
>> -        default:
>> -            p = NULL;
>> +        infracfg = syscon_regmap_lookup_by_phandle(dev->of_node, 
>> "mediatek,infracfg");
>> +        if (IS_ERR(infracfg)) {
>> +            dev_warn(dev, "Cannot find phandle to mediatek,infracfg:"
>> +                      " Please update your devicetree.\n");
> 
> Is this really a dev_warn-level problem? There's no functional impact, given that 
> we can't stop supporting the original binding any time soon, if ever, so I suspect 
> this is more likely to just annoy users and CI systems than effect any significant 
> change.
> 

The upstream devicetrees were updated to use the new handle and this is a way to
warn about having outdated DTs... besides, I believe that CIs will always get the
devicetree from the same tree that the kernel was compiled from (hence no message
will be thrown).

In any case, if you think that a dev_info would be more appropriate, I can change
that no problem.

>> +            /*
>> +             * Legacy devicetrees will not specify a phandle to
>> +             * mediatek,infracfg: in that case, we use the older
>> +             * way to retrieve a syscon to infra.
>> +             *
>> +             * This is for retrocompatibility purposes only, hence
>> +             * no more compatibles shall be added to this.
>> +             */
>> +            switch (data->plat_data->m4u_plat) {
>> +            case M4U_MT2712:
>> +                p = "mediatek,mt2712-infracfg";
>> +                break;
>> +            case M4U_MT8173:
>> +                p = "mediatek,mt8173-infracfg";
>> +                break;
>> +            default:
>> +                p = NULL;
>> +            }
>> +
>> +            infracfg = syscon_regmap_lookup_by_compatible(p);
> 
> Would it not make sense to punt this over to the same mechanism as for pericfg, 
> such that it simplifies down to something like:
> 
>      if (IS_ERR(infracfg) && plat_data->infracfg) {
>          infracfg = syscon_regmap_lookup_by_compatible(plat_data->infracfg);
>          ...
>      }
> 
> ?
> 
> TBH if we're still going to have a load of per-SoC data in the driver anyway then I 
> don't see that we really gain much by delegating one aspect of it to DT, but meh. I 
> would note that with the phandle approach, you still need some *other* flag in the 
> driver to know whether a phandle is expected to be present or not, whereas a NULL 
> vs. non-NULL string is at least neatly self-describing.
> 

That would be possible but, as Yong also pointed out, we should try to reduce the
per-SoC data in the driver by commonizing as much as possible, because this driver
supports a very long list of SoCs (even though they're not all upstreamed yet),
and the list is going to grow even more with time: this is also why I have changed
the MT8195 pericfg regmap lookup with a phandle like I've done for infra.

There would also be another way, which would imply adding a generic compatible
"mediatek,infracfg" to the infra syscon node, but I really don't like that for
more than one reason, one of which is that this poses an issue, for which it's
not guaranteed that the registers are in infracfg and not infracfg_ao (even
though the offsets are the same), so then we would be back to ground zero.

Regards,
Angelo


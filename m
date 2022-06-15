Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258DC54C887
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348459AbiFOM2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242459AbiFOM22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:28:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BA3393FE;
        Wed, 15 Jun 2022 05:28:26 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C559266016CB;
        Wed, 15 Jun 2022 13:28:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655296105;
        bh=4nU9NX8b9cZ1xmaDRmhjERV+Ti0iFHjk5ZJ4I5OHFKg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=e5N5JyBggQ4zs0Fz6xkG5P2lTO0eO/wPkxz+z/OFofBarb38HNedfhq9yqtAGVf9l
         0PUw9XO54LL0vF86XTinY+iAdtn0vk4Cog3WIh1GyrpJhL0kBf4f/JrH+vE8vJMuri
         pL/55G3lZaHGC1ajx5gZtMmsLmHpwR2on5Znu0b6mjMQfw8tJamf5lPTj/n2ixxjGk
         hVpxxfdyYxchxSCViNHYe/Kqhx1sSLwsAkfZyrJXGAGPpd5IG6TM/0O7yeZPiVNgvA
         ms0JorOxWEy7yJA9A1FBIPkfTl/hfpPIPWev17eGOBt0zC3COek5AMRUVVVWrKGXb3
         W0fO4VBtVmmyA==
Message-ID: <e4a2c56e-8e38-b44c-04b4-fd792fbf2f74@collabora.com>
Date:   Wed, 15 Jun 2022 14:28:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 6/6] iommu: mtk_iommu: Lookup phandle to retrieve
 syscon to pericfg
Content-Language: en-US
To:     Matthias Brugger <matthias.bgg@gmail.com>, yong.wu@mediatek.com
Cc:     joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@linaro.org
References: <20220609100802.54513-1-angelogioacchino.delregno@collabora.com>
 <20220609100802.54513-7-angelogioacchino.delregno@collabora.com>
 <8b31b1d2-4ed7-11a1-2124-4641c8f3abcd@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <8b31b1d2-4ed7-11a1-2124-4641c8f3abcd@gmail.com>
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

Il 15/06/22 14:09, Matthias Brugger ha scritto:
> 
> 
> On 09/06/2022 12:08, AngeloGioacchino Del Regno wrote:
>> On some SoCs (of which only MT8195 is supported at the time of writing),
>> the "R" and "W" (I/O) enable bits for the IOMMUs are in the pericfg_ao
>> register space and not in the IOMMU space: as it happened already with
>> infracfg, it is expected that this list will grow.
>>
>> Instead of specifying pericfg compatibles on a per-SoC basis, following
>> what was done with infracfg, let's lookup the syscon by phandle instead.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/iommu/mtk_iommu.c | 23 +++++++++++++----------
>>   1 file changed, 13 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
>> index 90685946fcbe..0ea0848581e9 100644
>> --- a/drivers/iommu/mtk_iommu.c
>> +++ b/drivers/iommu/mtk_iommu.c
>> @@ -138,6 +138,8 @@
>>   /* PM and clock always on. e.g. infra iommu */
>>   #define PM_CLK_AO            BIT(15)
>>   #define IFA_IOMMU_PCIE_SUPPORT        BIT(16)
>> +/* IOMMU I/O (r/w) is enabled using PERICFG_IOMMU_1 register */
>> +#define HAS_PERI_IOMMU1_REG        BIT(17)
> 
>  From what I can see MTK_IOMMU_TYPE_INFRA is only set in MT8195 which uses pericfg. 
> So we don't need a new flag here. For me the flag name MTK_IOMMU_TYPE_INFRA was 
> confusing as it has nothing to do with the use of infracfg. I'll hijack this patch 
> to provide some feedback on the actual code, please see below.
> 
>>   #define MTK_IOMMU_HAS_FLAG_MASK(pdata, _x, mask)    \
>>                   ((((pdata)->flags) & (mask)) == (_x))
>> @@ -187,7 +189,6 @@ struct mtk_iommu_plat_data {
>>       u32            flags;
>>       u32            inv_sel_reg;
>> -    char            *pericfg_comp_str;
>>       struct list_head    *hw_list;
>>       unsigned int        iova_region_nr;
>>       const struct mtk_iommu_iova_region    *iova_region;
>> @@ -1218,14 +1219,16 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>>               goto out_runtime_disable;
>>           }
>>       } else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA) &&
>> -           data->plat_data->pericfg_comp_str) {
> 
> Check for pericfg_comp_str is not needed, we only have one platform that uses 
> MTK_IOMMU_TYPE_INFRA.
> 

Fair enough. I agree.

>> -        infracfg = 
>> syscon_regmap_lookup_by_compatible(data->plat_data->pericfg_comp_str);
> 
> We can do something like this to make the code clearer:
> data->pericfg = syscon_regmap_lookup_by_compatible(data->plat_data->pericfg_comp_str);
>          if (IS_ERR(data->pericfg)) {
> 
> Using infracfg variable here is confusing as it has nothing to do with infracfg 
> used with HAS_4GB_MODE flag.

Yes Matthias, using the infracfg variable is confusing - that's why I changed that
already....

> 
> Regards,
> Matthias
> 
>> -        if (IS_ERR(infracfg)) {
>> -            ret = PTR_ERR(infracfg);
>> -            goto out_runtime_disable;
>> +           MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_PERI_IOMMU1_REG)) {



>> +        data->pericfg = syscon_regmap_lookup_by_phandle(dev->of_node, 
>> "mediatek,pericfg");

....Here, where I'm assigning directly to data->pericfg :-P

By the way, since it was only about one platform, my intention was to remove the
pericfg_comp_str from struct iommu_plat_data (as you can see), but then, with the
current code, I had to assign .....


>> +        if (IS_ERR(data->pericfg)) {
>> +            p = "mediatek,mt8195-pericfg_ao";

...the string to 'p', because otherwise it would go over 100 columns.

In any case, I just checked and, apparently, MT8195 is really the one and only SoC
that needs this pericfg register to be managed by Linux... even the latest and
greatest smartphone chip (Dimensity 9000, MT6983) doesn't need this (at least,
from what I can read on a downstream kernel).

On an afterthought, perhaps the best idea is to just leave this as it is and, as
you proposed, avoid using that confusing infracfg variable, without adding the
pericfg handle at all.

After all, it's just one single SoC.

I'll send a new version soon!

Cheers,
Angelo


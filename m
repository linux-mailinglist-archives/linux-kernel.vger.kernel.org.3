Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2D0529DF8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244722AbiEQJ1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245143AbiEQJ0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:26:53 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6812AE0A;
        Tue, 17 May 2022 02:26:52 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id BD6B01F443ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652779611;
        bh=D7c61EwGqdBX0Lw08AQnOwRHtOVIW1E5TNgutoUJtfQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kxvCx6+RAIRbpZiibenhzoNCxHqJVohhnT00pE5zUajFhHFvesGnd1pbT3/AMINPP
         RfX0fuHUR83AMDEcfX/cJ1azgYG06gR8B2t+9BC5uOIsfmu90YXxjxJFJ36/KXWlsM
         0rBR7jE3jdpFgTABLgMUdwLAaibhhnMcUAFouQ30bX7n0v96NwqDxP7P7EjXax4mze
         AN4N9rNTZlwcHZDRSnXssYRTldeMvOIfxmGvk+OsNWn+9hVA4x8fRDRGvea1jjDLya
         KWnKOV1h5mE1aaSK7LdL7JG7vEp/Jcr8xAhUfqmxV/Ncb4woj6SnZ9cExjuKjfGFmW
         GNNkhXwX6VllA==
Message-ID: <9a67d3e8-8840-03b1-aec8-5a218e810eae@collabora.com>
Date:   Tue, 17 May 2022 11:26:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/2] iommu: mtk_iommu: Add support for MT6795 Helio X10
 M4Us
Content-Language: en-US
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        yf.wang@mediatek.com, mingyuan.ma@mediatek.com
References: <20220513151411.395744-1-angelogioacchino.delregno@collabora.com>
 <20220513151411.395744-3-angelogioacchino.delregno@collabora.com>
 <38e38006662b52631a2145228444b9d70f9eb2c6.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <38e38006662b52631a2145228444b9d70f9eb2c6.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/05/22 11:08, Yong Wu ha scritto:
> On Fri, 2022-05-13 at 17:14 +0200, AngeloGioacchino Del Regno wrote:
>> Add support for the M4Us found in the MT6795 Helio X10 SoC.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <
>> angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/iommu/mtk_iommu.c | 20 +++++++++++++++++++-
>>   1 file changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
>> index 71b2ace74cd6..3d802dd3f377 100644
>> --- a/drivers/iommu/mtk_iommu.c
>> +++ b/drivers/iommu/mtk_iommu.c
>> @@ -157,6 +157,7 @@
>>   enum mtk_iommu_plat {
>>   	M4U_MT2712,
>>   	M4U_MT6779,
>> +	M4U_MT6795,
>>   	M4U_MT8167,
>>   	M4U_MT8173,
>>   	M4U_MT8183,
>> @@ -953,7 +954,8 @@ static int mtk_iommu_hw_init(const struct
>> mtk_iommu_data *data, unsigned int ban
>>   	 * Global control settings are in bank0. May re-init these
>> global registers
>>   	 * since no sure if there is bank0 consumers.
>>   	 */
>> -	if (data->plat_data->m4u_plat == M4U_MT8173) {
>> +	if (data->plat_data->m4u_plat == M4U_MT6795 ||
>> +	    data->plat_data->m4u_plat == M4U_MT8173) {
>>   		regval = F_MMU_PREFETCH_RT_REPLACE_MOD |
>>   			 F_MMU_TF_PROT_TO_PROGRAM_ADDR_MT8173;
>>   	} else {
>> @@ -1138,6 +1140,9 @@ static int mtk_iommu_probe(struct
>> platform_device *pdev)
>>   		case M4U_MT2712:
>>   			p = "mediatek,mt2712-infracfg";
>>   			break;
>> +		case M4U_MT6795:
>> +			p = "mediatek,mt6795-infracfg";
>> +			break;
>>   		case M4U_MT8173:
>>   			p = "mediatek,mt8173-infracfg";
>>   			break;
>> @@ -1404,6 +1409,18 @@ static const struct mtk_iommu_plat_data
>> mt6779_data = {
>>   	.larbid_remap  = {{0}, {1}, {2}, {3}, {5}, {7, 8}, {10}, {9}},
>>   };
>>   
>> +static const struct mtk_iommu_plat_data mt6795_data = {
>> +	.m4u_plat     = M4U_MT6795,
>> +	.flags	      = HAS_4GB_MODE | HAS_BCLK | RESET_AXI |
>> +			HAS_LEGACY_IVRP_PADDR | MTK_IOMMU_TYPE_MM,
>> +	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
>> +	.banks_num    = 1,
>> +	.banks_enable = {true},
>> +	.iova_region  = single_domain,
>> +	.iova_region_nr = ARRAY_SIZE(single_domain),
>> +	.larbid_remap = {{0}, {1}, {2}, {3}, {4}}, /* Linear mapping.
>> */
>> +};
> 
> This is nearly same with mt8173_data. mt8173 has one more larb than
> mt6795, its larbid_remap is also ok for mt6795.
> 

I think that we should be explicit about the larbid_remap property,
since mt6795 has one less larb, we should explicitly say that like
I did there... that's only for human readability I admit ... but,
still, I wouldn't want to see people thinking that MT6795 has 6 LARBs
because they've read that larbid_remap having 6 entries.

> thus it looks we could use mt8173 as the backward compatible.
>      compatible = "mediatek,mt6795-m4u",
>                   "mediatek,mt8173-m4u";
> 
> After this, the only thing is about "mediatek,mt6795-infracfg". we have
> to try again with mediatek,mt6795-infracfg after mediatek,mt8173-
> infracfg fail. I think we should allow the backward case in 4GB mode
> judgment if we have.
> 
> What's your opinion? or some other suggestion?
> Thanks.

I know, I may have a plan for that, but I wanted to have a good reason to
propose such a thing, as if it's just about two SoCs needing that, there
would be no good reason to get things done differently.

...so, in order to provide a good cleanup, we have two possible roads to
follow here: either we add a generic "mediatek,infracfg" compatible to the
infra node (but I don't like that), or we can do it like it was previously
done in mtk-pm-domains.c (I prefer that approach):

iommu: iommu@somewhere {
	... something ...
	mediatek,infracfg = <&infracfg>;
};

infracfg = syscon_regmap_lookup_by_compatible(node, "mediatek,infracfg");
if (IS_ERR(infracfg)) {
	/* try with the older way */
	switch (...) {
	case .... p = "mediatek,mt2712-infracfg";
	... blah blah ...
	}
	/* legacy also failed, ouch! */
	if (IS_ERR(infracfg))
		return PTR_ERR(infracfg);
}

ret = regmap_read ... etc etc etc

Cheers,
Angelo

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36B252B7E1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbiERKRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 06:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbiERKRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 06:17:10 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC4E63385;
        Wed, 18 May 2022 03:17:08 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e28so1414782wra.10;
        Wed, 18 May 2022 03:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JDEZhGlxX3q41z2Qv8MwS9G1+Y1QFJKsUDzF/L6uQHk=;
        b=DqcZNdspyaqBHAVNilMYjZm+kFa4AMru817n+8jVHzW0BElL+LDpTda3Ji5Il/FCJM
         fQqtZPPjgg0bMjYCtLO/3GJPHY4BTrSKAU9RoaC9ooJhO4j7tXIhRZdCjv80NDNCpbB0
         cdPTa3dTI5LBOcj9Niid+ZBPaDJ/I2UuyCrgB9IpqklOOdEW7z5J4WSVOdS+l3aQL8ts
         Aur2p3ho/eYy0hogD3YUmsvTJMPJJVIfV5v/BiYxCVi2nfRriicrZ0u3xtMB4/+9ZeLh
         MDSzCEQ9M1kqpJf53btb2mwnoLmY5UMjyS6abKAV33bjU13/gjjRWR+Tdt63KjaR6ro1
         QPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JDEZhGlxX3q41z2Qv8MwS9G1+Y1QFJKsUDzF/L6uQHk=;
        b=Mj6bdSnh1nnzda7y0I32Fnmm0PFvop6mSjuGEBZOeU+YEm338rGeqk79f+XCiXxFlt
         8BeybrYXEIxo2Bk1VAPt65wtWAHGg5f2Rxu9MRKa/dWwgoIgEaBZExDbD/rN9bQQpnrA
         vpcnX14opvl1WyLuSAylAdncXVDhrwGgLbavgEAUthPok/RTkuJFB8A5ZiE6sJtZ9UMk
         t1Ck5h/2RttcmFia7ar7Nd/aTrCWtkyv9qpURs5Sj7tieSe7RFcA/ozYav1OsthYLkCB
         o/xW3jUinUU6TJC7N13411ttiK3nZkrC7cdUv4HPmxS2eVkv75VI7Im1lc/IoSWfT6Zr
         iqYw==
X-Gm-Message-State: AOAM530ZTAwprM+Wftj10yMLyYJdaPKobJbF4XGweLCYJWY6yTqHalRL
        reXM1xz+/UMGK22bPro1FWQ=
X-Google-Smtp-Source: ABdhPJz50zZNy75WZIl5SLAdw28vWdjTJPUizP3Z3rcoOxsGrTac4hDC7TuNeWeo0hTCukYSkqg5zA==
X-Received: by 2002:adf:a3c2:0:b0:20c:fecc:8885 with SMTP id m2-20020adfa3c2000000b0020cfecc8885mr16733860wrb.463.1652869026824;
        Wed, 18 May 2022 03:17:06 -0700 (PDT)
Received: from [192.168.0.36] ([5.225.216.194])
        by smtp.gmail.com with ESMTPSA id k19-20020a05600c479300b003942a244edbsm1525822wmo.32.2022.05.18.03.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 03:17:06 -0700 (PDT)
Message-ID: <33ef032c-8233-6f01-a064-e0564df0258d@gmail.com>
Date:   Wed, 18 May 2022 12:17:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 4/8] iommu: mtk_iommu: Lookup phandle to retrieve syscon
 to pericfg
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, yong.wu@mediatek.com
Cc:     joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220517132107.195932-1-angelogioacchino.delregno@collabora.com>
 <20220517132107.195932-5-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220517132107.195932-5-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/05/2022 15:21, AngeloGioacchino Del Regno wrote:
> On some SoCs (of which only MT8195 is supported at the time of writing),
> the "R" and "W" (I/O) enable bits for the IOMMUs are in the pericfg_ao
> register space and not in the IOMMU space: as it happened already with
> infracfg, it is expected that this list will grow.
> 
> Instead of specifying pericfg compatibles on a per-SoC basis, following
> what was done with infracfg, let's lookup the syscon by phandle instead.
> Also following the previous infracfg change, add a warning for outdated
> devicetrees, in hope that the user will take action.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/iommu/mtk_iommu.c | 26 ++++++++++++++++----------
>   1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index cfaaa98d2b50..c7e2d836199e 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -138,6 +138,8 @@
>   /* PM and clock always on. e.g. infra iommu */
>   #define PM_CLK_AO			BIT(15)
>   #define IFA_IOMMU_PCIE_SUPPORT		BIT(16)
> +/* IOMMU I/O (r/w) is enabled using PERICFG_IOMMU_1 register */
> +#define HAS_PERI_IOMMU1_REG		BIT(17)
>   
>   #define MTK_IOMMU_HAS_FLAG_MASK(pdata, _x, mask)	\
>   				((((pdata)->flags) & (mask)) == (_x))
> @@ -187,7 +189,6 @@ struct mtk_iommu_plat_data {
>   	u32			flags;
>   	u32			inv_sel_reg;
>   
> -	char			*pericfg_comp_str;
>   	struct list_head	*hw_list;
>   	unsigned int		iova_region_nr;
>   	const struct mtk_iommu_iova_region	*iova_region;
> @@ -1214,14 +1215,19 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>   			goto out_runtime_disable;
>   		}
>   	} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA) &&
> -		   data->plat_data->pericfg_comp_str) {
> -		infracfg = syscon_regmap_lookup_by_compatible(data->plat_data->pericfg_comp_str);
> -		if (IS_ERR(infracfg)) {
> -			ret = PTR_ERR(infracfg);
> -			goto out_runtime_disable;
> -		}
> +		   MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_PERI_IOMMU1_REG)) {
> +		data->pericfg = syscon_regmap_lookup_by_phandle(dev->of_node, "mediatek,pericfg");
> +		if (IS_ERR(data->pericfg)) {
> +			dev_warn(dev, "Cannot find phandle to mediatek,pericfg:"
> +				      " Please update your devicetree.\n");
>   
> -		data->pericfg = infracfg;
> +			p = "mediatek,mt8195-pericfg_ao";
> +			data->pericfg = syscon_regmap_lookup_by_compatible(p);
> +			if (IS_ERR(data->pericfg)) {
> +				ret = PTR_ERR(data->pericfg);
> +				goto out_runtime_disable;
> +			}
> +		}
>   	}
>   
>   	platform_set_drvdata(pdev, data);
> @@ -1480,8 +1486,8 @@ static const struct mtk_iommu_plat_data mt8192_data = {
>   static const struct mtk_iommu_plat_data mt8195_data_infra = {
>   	.m4u_plat	  = M4U_MT8195,
>   	.flags            = WR_THROT_EN | DCM_DISABLE | STD_AXI_MODE | PM_CLK_AO |
> -			    MTK_IOMMU_TYPE_INFRA | IFA_IOMMU_PCIE_SUPPORT,
> -	.pericfg_comp_str = "mediatek,mt8195-pericfg_ao",
> +			    HAS_PERI_IOMMU1_REG | MTK_IOMMU_TYPE_INFRA |
> +			    IFA_IOMMU_PCIE_SUPPORT,
>   	.inv_sel_reg      = REG_MMU_INV_SEL_GEN2,
>   	.banks_num	  = 5,
>   	.banks_enable     = {true, false, false, false, true},

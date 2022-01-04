Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3275D484585
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbiADPzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:55:15 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33310 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbiADPzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:55:02 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id F26C61F43596
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641311701;
        bh=fPBIfJjVcoXofCD1fNUii7LIvv42S5BZmY9Gwg/vvxs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GuT8uwRR0r1DXel74kTa76Ic4uUp1nwzwOBXQqig/2HM6O2Azi93HPr6wVR2VLSM+
         2j91N+G5h5h7Tm/IBemQKdb30xRh1YbQEZsNj6S0VObC2t1X629kYS1bi363Cuz6dw
         eUigh5eCsjcQXVDAl18GGmtTa3LwmvfivTIQDMf02R5VUuuoZiTGYKtpwxfud/uBpM
         oIermrwBW+PMu8PYScVRRuv16vjYdcwrx2I+BW+JjLFsLUWmMwwCNTfC77BffrXyXG
         F3885a8L67q05vcM0qFKUXYbxaPixhLaPT/HtRIk1vh9az2AADZfsNOYkPQVh9ctsL
         TqlfPq61mLleg==
Subject: Re: [PATCH v3 22/33] iommu/mediatek: Add PCIe support
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Hsin-Yi Wang <hsinyi@chromium.org>, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, chao.hao@mediatek.com,
        yen-chang.chen@mediatek.com
References: <20210923115840.17813-1-yong.wu@mediatek.com>
 <20210923115840.17813-23-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <3b5e7072-0935-4383-27a1-dd8d623cc608@collabora.com>
Date:   Tue, 4 Jan 2022 16:54:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923115840.17813-23-yong.wu@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/09/21 13:58, Yong Wu ha scritto:
> Currently the code for of_iommu_configure_dev_id is like this:
> 
> static int of_iommu_configure_dev_id(struct device_node *master_np,
>                                       struct device *dev,
>                                       const u32 *id)
> {
>         struct of_phandle_args iommu_spec = { .args_count = 1 };
> 
>         err = of_map_id(master_np, *id, "iommu-map",
>                         "iommu-map-mask", &iommu_spec.np,
>                         iommu_spec.args);
> ...
> }
> 
> It supports only one id output. BUT our PCIe HW has two ID(one is for
> writing, the other is for reading). I'm not sure if we should change
> of_map_id to support output MAX_PHANDLE_ARGS.
> 
> Here add the solution in ourselve drivers. If it's pcie case, enable one
> more bit.
> 
> Not all infra iommu support PCIe, thus add a PCIe support flag here.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c | 21 ++++++++++++++++++++-
>   1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 37d6dfb4feab..3f1fd8036345 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -20,6 +20,7 @@
>   #include <linux/of_address.h>
>   #include <linux/of_irq.h>
>   #include <linux/of_platform.h>
> +#include <linux/pci.h>
>   #include <linux/platform_device.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/regmap.h>
> @@ -132,6 +133,7 @@
>   #define MTK_IOMMU_TYPE_MM		(0x0 << 13)
>   #define MTK_IOMMU_TYPE_INFRA		(0x1 << 13)
>   #define MTK_IOMMU_TYPE_MASK		(0x3 << 13)
> +#define IFA_IOMMU_PCIe_SUPPORT		BIT(15)

This definition looks like "breaking" the naming convention that's used in this
driver... what about MTK_INFRA_IOMMU_PCIE_SUPPORT?

>   
>   #define MTK_IOMMU_HAS_FLAG(pdata, _x)	(!!(((pdata)->flags) & (_x)))
>   
> @@ -401,8 +403,11 @@ static int mtk_iommu_config(struct mtk_iommu_data *data, struct device *dev,
>   				larb_mmu->mmu &= ~MTK_SMI_MMU_EN(portid);
>   		} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA)) {
>   			peri_mmuen_msk = BIT(portid);
> -			peri_mmuen = enable ? peri_mmuen_msk : 0;
> +			/* PCIdev has only one output id, enable the next writing bit for PCIe */
> +			if (dev_is_pci(dev))
> +				peri_mmuen_msk |= BIT(portid + 1);
>   
> +			peri_mmuen = enable ? peri_mmuen_msk : 0;
>   			ret = regmap_update_bits(data->pericfg, PERICFG_IOMMU_1,
>   						 peri_mmuen_msk, peri_mmuen);
>   			if (ret)
> @@ -977,6 +982,15 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>   		ret = component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
>   		if (ret)
>   			goto out_bus_set_null;
> +	} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA) &&
> +		   MTK_IOMMU_HAS_FLAG(data->plat_data, IFA_IOMMU_PCIe_SUPPORT)) {
> +		#ifdef CONFIG_PCI

Please fix the indentation of this ifdef (do not indent).

> +		if (!iommu_present(&pci_bus_type)) {
> +			ret = bus_set_iommu(&pci_bus_type, &mtk_iommu_ops);
> +			if (ret) /* PCIe fail don't affect platform_bus. */
> +				goto out_list_del;
> +		}
> +		#endif
>   	}
>   	return ret;
>   
> @@ -1007,6 +1021,11 @@ static int mtk_iommu_remove(struct platform_device *pdev)
>   	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
>   		device_link_remove(data->smicomm_dev, &pdev->dev);
>   		component_master_del(&pdev->dev, &mtk_iommu_com_ops);
> +	} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA) &&
> +		   MTK_IOMMU_HAS_FLAG(data->plat_data, IFA_IOMMU_PCIe_SUPPORT)) {
> +		#ifdef CONFIG_PCI

ditto.

> +		bus_set_iommu(&pci_bus_type, NULL);
> +		#endif
>   	}
>   	pm_runtime_disable(&pdev->dev);
>   	devm_free_irq(&pdev->dev, data->irq, data);
> 



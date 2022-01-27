Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A52B49E012
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239896AbiA0LCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:02:14 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51184 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbiA0LCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:02:13 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 484FA1F45063
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643281332;
        bh=y7Q22FYn8FoxG+Q7a9gHib0Iq0zzREi7aiuVl2foqxg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LBoJzGDUMVKX/gSf3SIgVY/ZJKUJvgV0EfVS5PiKs6FAyMFU88KJCNZHbtzmGFgVW
         gicw+2P8E7/gwjAFTRxW9k8eECDChSpaPtbtyLsQFK+vNVAjBEJD40pf8lpgklenY2
         WqVtlopRIn4O42kbfyCUMs9fC4qtEniYdaupWno8nKxKK+/RqaBWpcgmwXpEuZ1W0K
         tcqxnUZVd5tHcpGhdL1BXymy7MvRGt3ff77giKXyibWzeDi+GxCbtPOrfDrjSFIiVt
         gcoKhn/NlXMKLMEuy2tRvJw8IHcce6jMZUuB+NR/9kRI5CHgUKQuRtK/UmmTclCVuG
         BOeN7Nwg0V+QQ==
Subject: Re: [PATCH v4 06/35] iommu/mediatek: Add mutex for m4u_group and
 m4u_dom in data
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Hsin-Yi Wang <hsinyi@chromium.org>, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, xueqi.zhang@mediatek.com,
        yen-chang.chen@mediatek.com, mingyuan.ma@mediatek.com,
        yf.wang@mediatek.com, libo.kang@mediatek.com,
        chengci.xu@mediatek.com
References: <20220125085634.17972-1-yong.wu@mediatek.com>
 <20220125085634.17972-7-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <62d2a231-3d05-5008-fae2-335c4ad853bd@collabora.com>
Date:   Thu, 27 Jan 2022 12:02:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220125085634.17972-7-yong.wu@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/01/22 09:56, Yong Wu ha scritto:
> Add a mutex to protect the data in the structure mtk_iommu_data,
> like ->"m4u_group" ->"m4u_dom". For the internal data, we should
> protect it in ourselves driver. Add a mutex for this.
> This could be a fix for the multi-groups support.
> 
> Fixes: c3045f39244e ("iommu/mediatek: Support for multi domains")
> Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c | 13 +++++++++++--
>   drivers/iommu/mtk_iommu.h |  2 ++
>   2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index ec2c387abf60..095736bfb7b4 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -464,15 +464,16 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
>   		dom->data = data;
>   	}
>   
> +	mutex_lock(&data->mutex);
>   	if (!data->m4u_dom) { /* Initialize the M4U HW */
>   		ret = pm_runtime_resume_and_get(m4udev);
>   		if (ret < 0)
> -			return ret;
> +			goto data_unlock;

In order to enhance human readability, I would rather propose:

			goto err_unlock;

Apart from this,
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

>   
>   		ret = mtk_iommu_hw_init(data);
>   		if (ret) {
>   			pm_runtime_put(m4udev);
> -			return ret;
> +			goto data_unlock;
>   		}
>   		data->m4u_dom = dom;
>   		writel(dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK,
> @@ -480,9 +481,14 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
>   
>   		pm_runtime_put(m4udev);
>   	}
> +	mutex_unlock(&data->mutex);
>   
>   	mtk_iommu_config(data, dev, true, domid);
>   	return 0;
> +
> +data_unlock:
> +	mutex_unlock(&data->mutex);
> +	return ret;
>   }
>   
>   static void mtk_iommu_detach_device(struct iommu_domain *domain,
> @@ -592,6 +598,7 @@ static struct iommu_group *mtk_iommu_device_group(struct device *dev)
>   	if (domid < 0)
>   		return ERR_PTR(domid);
>   
> +	mutex_lock(&data->mutex);
>   	group = data->m4u_group[domid];
>   	if (!group) {
>   		group = iommu_group_alloc();
> @@ -600,6 +607,7 @@ static struct iommu_group *mtk_iommu_device_group(struct device *dev)
>   	} else {
>   		iommu_group_ref_get(group);
>   	}
> +	mutex_unlock(&data->mutex);
>   	return group;
>   }
>   
> @@ -874,6 +882,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>   	}
>   
>   	platform_set_drvdata(pdev, data);
> +	mutex_init(&data->mutex);
>   
>   	ret = iommu_device_sysfs_add(&data->iommu, dev, NULL,
>   				     "mtk-iommu.%pa", &ioaddr);
> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> index f81fa8862ed0..f413546ac6e5 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -80,6 +80,8 @@ struct mtk_iommu_data {
>   
>   	struct dma_iommu_mapping	*mapping; /* For mtk_iommu_v1.c */
>   
> +	struct mutex			mutex; /* Protect m4u_group/m4u_dom above */
> +
>   	struct list_head		list;
>   	struct mtk_smi_larb_iommu	larb_imu[MTK_LARB_NR_MAX];
>   };
> 



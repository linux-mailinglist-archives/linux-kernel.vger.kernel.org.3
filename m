Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB7149E067
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240053AbiA0LPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:15:23 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51374 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbiA0LPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:15:22 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 87E5F1F4508E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643282121;
        bh=lPBbkFX/VxEnKHj3FJ/pw/Em27NywQUGj2yt/sKz3GM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VBr8OTzitfSr7ZA14ETCD9IX13ZKRLsa4UvjsGOg5i1PbyjX6Z7jDTuUQ12ti8Z7V
         HQSbSGxt4ReNXMMfSPFsBLKPDSuXEJUfEK68FVQFyxOPQgmY38Y8vTCgQY3VEZ5UrN
         lzbPZ/ssyHtq8oRiFDiMVZX+CZMO9XVVTjc3GVUEa1ym/uQJ97uwMoMXOuFKPgF7nu
         PPJ+w7CDIA3pFHU/DjoDIuWGl11O291Bk6TLcUdzcgm8N5dNEIr4UQTODPqFkLet8L
         ChiCzUizmOxwTYtWeI+uKEhAsFsnejt1EuNKLTFWnJi9SJ795XLq9vjhYcr79gCjug
         5AvSH1Rslii8w==
Subject: Re: [PATCH v4 27/35] iommu/mediatek: Remove mtk_iommu.h
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
 <20220125085634.17972-28-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <8e1847d0-7c6f-b022-999b-666cb90e9931@collabora.com>
Date:   Thu, 27 Jan 2022 12:15:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220125085634.17972-28-yong.wu@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/01/22 09:56, Yong Wu ha scritto:
> Currently there is only compare_of/release_of/a suspend structure in the
> header file. I think it is no need to keep a header file only for these.
> Move these into the c file and rm this header file.
> 
> I think there should be a common helper for compare_of and release_of.
> There is many copy in drm, it should be another topic.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c    | 25 ++++++++++++++++++++-
>   drivers/iommu/mtk_iommu.h    | 42 ------------------------------------
>   drivers/iommu/mtk_iommu_v1.c | 21 +++++++++++++++---
>   3 files changed, 42 insertions(+), 46 deletions(-)
>   delete mode 100644 drivers/iommu/mtk_iommu.h
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 80c1e5a75868..f88c7bb235bf 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -14,6 +14,7 @@
>   #include <linux/io.h>
>   #include <linux/iommu.h>
>   #include <linux/iopoll.h>
> +#include <linux/io-pgtable.h>
>   #include <linux/list.h>
>   #include <linux/mfd/syscon.h>
>   #include <linux/module.h>
> @@ -30,7 +31,7 @@
>   #include <asm/barrier.h>
>   #include <soc/mediatek/smi.h>
>   
> -#include "mtk_iommu.h"
> +#include <dt-bindings/memory/mtk-memory-port.h>
>   
>   #define REG_MMU_PT_BASE_ADDR			0x000
>   #define MMU_PT_ADDR_MASK			GENMASK(31, 7)
> @@ -166,6 +167,17 @@ struct mtk_iommu_iova_region {
>   	unsigned long long	size;
>   };
>   
> +struct mtk_iommu_suspend_reg {
> +	u32			misc_ctrl;
> +	u32			dcm_dis;
> +	u32			ctrl_reg;
> +	u32			int_control0;
> +	u32			int_main_control;
> +	u32			ivrp_paddr;
> +	u32			vld_pa_rng;
> +	u32			wr_len_ctrl;
> +};
> +
>   struct mtk_iommu_plat_data {
>   	enum mtk_iommu_plat			m4u_plat;
>   	u32					flags;
> @@ -219,6 +231,17 @@ struct mtk_iommu_domain {
>   	struct mutex			mutex; /* Protect "data" in this structure */
>   };
>   
> +/* TODO: A common helper is expected. */
> +static inline int compare_of(struct device *dev, void *data)
> +{
> +	return dev->of_node == data;
> +}
> +
> +static inline void release_of(struct device *dev, void *data)
> +{
> +	of_node_put(data);
> +}
> +

Since it's just one line, at this point you should also open-code these,

as in you can then remove the two helper functions entirely.
So, please do that.

>   static inline int mtk_iommu_bind(struct device *dev)
>   {
>   	struct mtk_iommu_data *data = dev_get_drvdata(dev);
> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> deleted file mode 100644
> index d332f9769f83..000000000000
> --- a/drivers/iommu/mtk_iommu.h
> +++ /dev/null
> @@ -1,42 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Copyright (c) 2015-2016 MediaTek Inc.
> - * Author: Honghui Zhang <honghui.zhang@mediatek.com>
> - */
> -
> -#ifndef _MTK_IOMMU_H_
> -#define _MTK_IOMMU_H_
> -
> -#include <linux/device.h>
> -#include <linux/io.h>
> -#include <linux/io-pgtable.h>
> -#include <linux/iommu.h>
> -#include <linux/spinlock.h>
> -#include <soc/mediatek/smi.h>
> -#include <dt-bindings/memory/mtk-memory-port.h>
> -
> -struct mtk_iommu_suspend_reg {
> -	union {
> -		u32			standard_axi_mode;/* v1 */
> -		u32			misc_ctrl;/* v2 */
> -	};
> -	u32				dcm_dis;
> -	u32				ctrl_reg;
> -	u32				int_control0;
> -	u32				int_main_control;
> -	u32				ivrp_paddr;
> -	u32				vld_pa_rng;
> -	u32				wr_len_ctrl;
> -};
> -
> -static inline int compare_of(struct device *dev, void *data)
> -{
> -	return dev->of_node == data;
> -}
> -
> -static inline void release_of(struct device *dev, void *data)
> -{
> -	of_node_put(data);
> -}
> -
> -#endif
> diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> index b762a05328d4..23c3bc175153 100644
> --- a/drivers/iommu/mtk_iommu_v1.c
> +++ b/drivers/iommu/mtk_iommu_v1.c
> @@ -7,7 +7,6 @@
>    *
>    * Based on driver/iommu/mtk_iommu.c
>    */
> -#include <linux/memblock.h>
>   #include <linux/bug.h>
>   #include <linux/clk.h>
>   #include <linux/component.h>
> @@ -28,10 +27,9 @@
>   #include <linux/spinlock.h>
>   #include <asm/barrier.h>
>   #include <asm/dma-iommu.h>
> -#include <linux/init.h>
> +#include <dt-bindings/memory/mtk-memory-port.h>
>   #include <dt-bindings/memory/mt2701-larb-port.h>
>   #include <soc/mediatek/smi.h>
> -#include "mtk_iommu.h"
>   
>   #define REG_MMU_PT_BASE_ADDR			0x000
>   
> @@ -87,6 +85,13 @@
>    */
>   #define M2701_IOMMU_PGT_SIZE			SZ_4M
>   
> +struct mtk_iommu_suspend_reg {
> +	u32			standard_axi_mode;
> +	u32			dcm_dis;
> +	u32			ctrl_reg;
> +	u32			int_control0;
> +};
> +
>   struct mtk_iommu_data {
>   	void __iomem			*base;
>   	int				irq;
> @@ -110,6 +115,16 @@ struct mtk_iommu_domain {
>   	struct mtk_iommu_data		*data;
>   };
>   
> +static inline int compare_of(struct device *dev, void *data)
> +{
> +	return dev->of_node == data;
> +}
> +
> +static inline void release_of(struct device *dev, void *data)
> +{
> +	of_node_put(data);
> +}
> +

....And the same comment applies here too.

>   static inline int mtk_iommu_bind(struct device *dev)
>   {
>   	struct mtk_iommu_data *data = dev_get_drvdata(dev);
> 




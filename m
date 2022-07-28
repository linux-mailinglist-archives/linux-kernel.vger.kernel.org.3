Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44032583CE6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236870AbiG1LLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236842AbiG1LLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:11:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1913366AEA;
        Thu, 28 Jul 2022 04:11:24 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5D1096601B43;
        Thu, 28 Jul 2022 12:11:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1659006682;
        bh=HdGjw/OBjE3zUQje7IO4DrBbsmLFLo6LX1yNZk/DHIU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=a63ZsaB1hPLpTv6U3RzU+yxPYonWHSIohCRtNO24IrQkrg/qclGSlEwsEWKXuoNbL
         NhOKVPkbkpUmaJt4mipvg3tJY5ihK1fociEFzrXGLN4jkg7pHVY7SSe5j5D84P9tQa
         Oaj1fCHOJikOQvzwSLtP1k2JPqT96pBjaMWCgxVFSv3ZHcrGaKJPYUmaGunIuVG/50
         dqu5fjPbin4A2uRZgrqAzlL0wTA2+gNG+QPjhQ3uXdORBzmcKisTSPnXtX4bRbRa7w
         cihRtzhPkhHBzA0l37ivSjjTFEtCoFqfIo+tb2JfNrMALkHt4NnqSwplAKh+qajEcQ
         3JSUOVdQvdH3Q==
Message-ID: <73886ab3-14bd-e643-aaff-d805edd196af@collabora.com>
Date:   Thu, 28 Jul 2022 13:11:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 2/3] memory: mtk-smi: Add enable IOMMU SMC command for
 MM master
Content-Language: en-US
To:     "Chengci.Xu" <chengci.xu@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220727104541.7309-1-chengci.xu@mediatek.com>
 <20220727104541.7309-3-chengci.xu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220727104541.7309-3-chengci.xu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/07/22 12:45, Chengci.Xu ha scritto:
> For concerns about security, the register to enable/disable IOMMU of
> SMI LARB should only be configured in secure world. Thus, we add some
> SMC command for multimedia master to enable/disable MM IOMMU in ATF by
> setting the register of SMI LARB. This function is prepared for MT8188.
> 
> Signed-off-by: Chengci.Xu <chengci.xu@mediatek.com>
> ---
>   drivers/memory/mtk-smi.c                 | 11 +++++++++++
>   include/linux/soc/mediatek/mtk_sip_svc.h |  3 +++
>   include/soc/mediatek/smi.h               |  7 +++++++
>   3 files changed, 21 insertions(+)
> 
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index d7cb7ead2ac7..41ce66c39123 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -3,6 +3,7 @@
>    * Copyright (c) 2015-2016 MediaTek Inc.
>    * Author: Yong Wu <yong.wu@mediatek.com>
>    */
> +#include <linux/arm-smccc.h>
>   #include <linux/clk.h>
>   #include <linux/component.h>
>   #include <linux/device.h>
> @@ -14,6 +15,7 @@
>   #include <linux/of_platform.h>
>   #include <linux/platform_device.h>
>   #include <linux/pm_runtime.h>
> +#include <linux/soc/mediatek/mtk_sip_svc.h>
>   #include <soc/mediatek/smi.h>
>   #include <dt-bindings/memory/mt2701-larb-port.h>
>   #include <dt-bindings/memory/mtk-memory-port.h>
> @@ -89,6 +91,7 @@
>   #define MTK_SMI_FLAG_THRT_UPDATE	BIT(0)
>   #define MTK_SMI_FLAG_SW_FLAG		BIT(1)
>   #define MTK_SMI_FLAG_SLEEP_CTL		BIT(2)
> +#define MTK_SMI_FLAG_SEC_REG		BIT(3)
>   #define MTK_SMI_CAPS(flags, _x)		(!!((flags) & (_x)))
>   
>   struct mtk_smi_reg_pair {
> @@ -235,6 +238,7 @@ static void mtk_smi_larb_config_port_gen2_general(struct device *dev)
>   	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
>   	u32 reg, flags_general = larb->larb_gen->flags_general;
>   	const u8 *larbostd = larb->larb_gen->ostd ? larb->larb_gen->ostd[larb->larbid] : NULL;
> +	struct arm_smccc_res res;
>   	int i;
>   
>   	if (BIT(larb->larbid) & larb->larb_gen->larb_direct_to_common_mask)
> @@ -259,6 +263,13 @@ static void mtk_smi_larb_config_port_gen2_general(struct device *dev)
>   		reg |= BANK_SEL(larb->bank[i]);
>   		writel(reg, larb->base + SMI_LARB_NONSEC_CON(i));
>   	}
> +
> +	if (MTK_SMI_CAPS(flags_general, MTK_SMI_FLAG_SEC_REG)) {
> +		arm_smccc_smc(MTK_SIP_KERNEL_IOMMU_CONTROL, IOMMU_ATF_CMD_CONFIG_SMI_LARB,
> +			      larb->larbid, (u32)(*larb->mmu), 0, 0, 0, 0, &res);
> +		if (res.a0 != 0)
> +			dev_err(dev, "Enable iommu fail, ret %ld\n", res.a0);

This means that the system will eventually crash or anyway be unstable: in this
case, we should not allow further interaction with the IOMMUs and/or SMI.

So, if you place this here, you will have to change this function to return
something for the caller to take action.

> +	}
>   }
>   
>   static const u8 mtk_smi_larb_mt8195_ostd[][SMI_LARB_PORT_NR_MAX] = {
> diff --git a/include/linux/soc/mediatek/mtk_sip_svc.h b/include/linux/soc/mediatek/mtk_sip_svc.h
> index 082398e0cfb1..0761128b4354 100644
> --- a/include/linux/soc/mediatek/mtk_sip_svc.h
> +++ b/include/linux/soc/mediatek/mtk_sip_svc.h
> @@ -22,4 +22,7 @@
>   	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, MTK_SIP_SMC_CONVENTION, \
>   			   ARM_SMCCC_OWNER_SIP, fn_id)
>   
> +/* IOMMU related SMC call */
> +#define MTK_SIP_KERNEL_IOMMU_CONTROL	MTK_SIP_SMC_CMD(0x514)
> +
>   #endif
> diff --git a/include/soc/mediatek/smi.h b/include/soc/mediatek/smi.h
> index 11f7d6b59642..8c781b7bd88d 100644
> --- a/include/soc/mediatek/smi.h
> +++ b/include/soc/mediatek/smi.h
> @@ -9,6 +9,13 @@
>   #include <linux/bitops.h>
>   #include <linux/device.h>
>   
> +/* IOMMU & SMI ATF CMD */
> +
> +enum IOMMU_ATF_CMD {

Why do you have an enumeration when you're defining just one command?
Is it expected to have more?

Besides, the enum name should be lower case, and...

> +	IOMMU_ATF_CMD_CONFIG_SMI_LARB,		/* For mm master to en/disable iommu */
> +	IOMMU_ATF_CMD_COUNT,

if IOMMU_ATF_CMD_COUNT means "end of this enumeration", please call it
IOMMU_ATF_CMD_MAX instead.

> +};
> +
>   #if IS_ENABLED(CONFIG_MTK_SMI)
>   
>   #define MTK_SMI_MMU_EN(port)	BIT(port)


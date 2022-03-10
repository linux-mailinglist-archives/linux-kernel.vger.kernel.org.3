Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285AE4D4C3E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 16:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240292AbiCJOyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 09:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346147AbiCJOmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:42:38 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3512110EC71;
        Thu, 10 Mar 2022 06:40:42 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 42B881F4592C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646923240;
        bh=twmvPMBXpCtjQaOxFlhSQ0t2WCEZ9mk4gP1Gmfjc8cY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bu6K6V2iDa++LupO2x7yaRGExEZNhxm11yrUSf02TZ9Kxyrz7sb9akpciPqa7AZ1H
         /lGsHPgeVloLRWcIFAb3182BKNwYEyU5OktHpyzzRENe8KOYfeY+0eljBkpJui6AAU
         Z535DZMSTrDqmXmw6DoVWIxVeZFvkXtJyfRbazGi5XS7KHwGzOFlwDHRzZt9i43rAZ
         KEWauRFPe8gk8QJRmjPCAX5xO+/rvRSjZkCVNuinwhy4Egew/utvEcPNJy9uuhfRLa
         HTp9gAPz2rhoqAhCnKwpX0wDXclIsmca4LRGlheB1nVPfbPB9R4UieXX2Y/9opXp3h
         MlLZxpKubHQFg==
Message-ID: <4974d21c-953c-30c1-8dbf-5826dbb20d8e@collabora.com>
Date:   Thu, 10 Mar 2022 15:40:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] remoteproc: mediatek: fix side effect of mt8195 sram
 power on
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220309114713.8156-1-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220309114713.8156-1-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/03/22 12:47, Tinghan Shen ha scritto:
> The definition of L1TCM_SRAM_PDN bits on mt8195 is different to mt8192.
> 
> L1TCM_SRAM_PDN bits[3:0] control the power of mt8195 L1TCM SRAM.
> 
> L1TCM_SRAM_PDN bits[7:4] control the access path to EMI for SCP.
> These bits have to be powered on to allow EMI access for SCP.
> 
> Bits[7:4] also affect audio DSP because audio DSP and SCP are
> placed on the same hardware bus. If SCP cannot access EMI, audio DSP is
> blocked too.
> 
> L1TCM_SRAM_PDN bits[31:8] are not used.
> 
> This fix removes modification of bits[7:4] when power on/off mt8195 SCP
> L1TCM. It's because the modification introduces a short period of time
> blocking audio DSP to access EMI. This was not a problem until we have
> to load both SCP module and audio DSP module. audio DSP needs to access
> EMI because it has source/data on DRAM. Audio DSP will have unexpected
> behavior when it accesses EMI and the SCP driver blocks the EMI path at
> the same time.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>   drivers/remoteproc/mtk_common.h |  4 +++
>   drivers/remoteproc/mtk_scp.c    | 57 +++++++++++++++++++++++++++++----
>   2 files changed, 55 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
> index 5ff3867c72f3..27e7172c926d 100644
> --- a/drivers/remoteproc/mtk_common.h
> +++ b/drivers/remoteproc/mtk_common.h
> @@ -51,6 +51,10 @@
>   #define MT8192_CORE0_WDT_IRQ		0x10030
>   #define MT8192_CORE0_WDT_CFG		0x10034
>   
> +#define MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS		0xF0

This is GENMASK(7, 4)..

> +#define MT8195_L1TCM_SRAM_PDN_RESERVED_BITS \
> +	MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS
> +

Why are you defining the same thing twice?
Please drop this.

>   #define SCP_FW_VER_LEN			32
>   #define SCP_SHARE_BUFFER_SIZE		288
>   
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index dcddb33e9997..4d75af856fd1 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -365,22 +365,32 @@ static int mt8183_scp_before_load(struct mtk_scp *scp)
>   	return 0;
>   }
>   
> -static void mt8192_power_on_sram(void __iomem *addr)
> +static void scp_sram_power_on(void __iomem *addr, u32 reserved_mask)
>   {
>   	int i;
>   
>   	for (i = 31; i >= 0; i--)
> -		writel(GENMASK(i, 0), addr);
> +		writel(GENMASK(i, 0) & ~reserved_mask, addr);
>   	writel(0, addr);
>   }
>   
> -static void mt8192_power_off_sram(void __iomem *addr)
> +static void scp_sram_power_off(void __iomem *addr, u32 reserved_mask)
>   {
>   	int i;
>   
>   	writel(0, addr);
>   	for (i = 0; i < 32; i++)
> -		writel(GENMASK(i, 0), addr);
> +		writel(GENMASK(i, 0) & ~reserved_mask, addr);
> +}
> +
> +static void mt8192_power_on_sram(void __iomem *addr)
> +{
> +	scp_sram_power_on(addr, 0);
> +}
> +
> +static void mt8192_power_off_sram(void __iomem *addr)
> +{
> +	scp_sram_power_off(addr, 0);
>   }
>   
>   static int mt8192_scp_before_load(struct mtk_scp *scp)
> @@ -403,6 +413,27 @@ static int mt8192_scp_before_load(struct mtk_scp *scp)
>   	return 0;
>   }
>   
> +static int mt8195_scp_before_load(struct mtk_scp *scp)
> +{
> +	/* clear SPM interrupt, SCP2SPM_IPC_CLR */
> +	writel(0xff, scp->reg_base + MT8192_SCP2SPM_IPC_CLR);
> +
> +	writel(1, scp->reg_base + MT8192_CORE0_SW_RSTN_SET);
> +
> +	/* enable SRAM clock */
> +	mt8192_power_on_sram(scp->reg_base + MT8192_L2TCM_SRAM_PD_0);

At this point, you can simply use scp_sram_power_{on, off} instead of defining
a new function for just one call... I get that your intent here is to enhance
human readability, but I don't think that this is really happening with that and,
if it is, it's just about a little ignorable difference.

Please use scp_sram_power_on() and scp_sram_power_off() directly.

	scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
	... etc :)

> +	mt8192_power_on_sram(scp->reg_base + MT8192_L2TCM_SRAM_PD_1);
> +	mt8192_power_on_sram(scp->reg_base + MT8192_L2TCM_SRAM_PD_2);
> +	scp_sram_power_on(scp->reg_base + MT8192_L1TCM_SRAM_PDN,
> +			  MT8195_L1TCM_SRAM_PDN_RESERVED_BITS);
> +	mt8192_power_on_sram(scp->reg_base + MT8192_CPU0_SRAM_PD);
> +
> +	/* enable MPU for all memory regions */
> +	writel(0xff, scp->reg_base + MT8192_CORE0_MEM_ATT_PREDEF);
> +
> +	return 0;
> +}
> +

Please remember to add me to the Cc's for the next version, so that I will be
able to timely give you my R-b tag for this one.

Regards,
Angelo



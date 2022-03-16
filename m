Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2307C4DB640
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 17:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349868AbiCPQgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 12:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiCPQgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 12:36:13 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034FD38BD2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 09:34:56 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id fs4-20020a17090af28400b001bf5624c0aaso2972046pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 09:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yi7Fr4VjNaLYohLqXAKfgtCUa62BFfEOwT38Sq58nO0=;
        b=m+T/AT+HiyIWBjaMKOoseHgXZJjQky0/ENj6At7vGTwxAQw4MSXeCCrSIQ6JTNxiIK
         az7JoNRc5wwr+bk3EPQnv4OhhhI+G4KiGAgUPYinnC4sL6I7R19X9eO7odrfGbCmkoww
         NqQqxPbj9PbPu7gl2dojfc5Kl5KHhJ+1FvVNqJdbSd5nUhiBODGX04SRbvSCxRgvC7Oj
         qH0bAMr2tqpHEIbsyuZoyWwkvEHDBOpNAfvvaX4c1vRJK+lhPsuHYYCL8jQUvj1Vj2HP
         ySyH/wpDv67NZMnYhx5G6Ehoww3EQvWqBnHG59IEsBKPVzDM2W+DXHTdQ4eSVTaRWV9n
         6elQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yi7Fr4VjNaLYohLqXAKfgtCUa62BFfEOwT38Sq58nO0=;
        b=hqE2gdK3s6xrHrYJrdqrbX9GAEKm6FB53noIjYMyac0miyAQTB8et3hkSHCa5w4/5g
         p6ppK3EQpYCpEhB1FumB7bO6VskMKnhxMXaaJgDDzco3X0UwDlVbhGWxfhkCcCwRdzEF
         mHECgPVQAv6SXqXQf1bjzSRaQn7H0bfpVZ13bTM+QOdZDt4K0BtfoJ0BxzVSmce9+4a3
         sY4BtAGbOB7Bv/urs9T9LGeYqUFAMuuwIEnQ2CI52qrrGQpruPcNI3dQiOodf6bIgnDD
         kcP+MYCcSA6u1Evm/MtEbtWWvN5C2kuOtPOP2Pn/lx8chB1Z28uFPYn4fTufBRKSFvjw
         SpRg==
X-Gm-Message-State: AOAM531i6f8D3iq6GwJ+Cd8Pp2ZKS3IpVXVo0mvtaYPaUNYdQkD20hsh
        hg/SxjumaIikr8ltcmljqPL/Dw==
X-Google-Smtp-Source: ABdhPJwf+LjEDU0Y7vIqn4NhNtObxMCOjI13MunbIn9VX1QWxHz7JQkwgz9JFx3M3K3LM+iJ46BQ4w==
X-Received: by 2002:a17:90a:408d:b0:1bf:610b:6209 with SMTP id l13-20020a17090a408d00b001bf610b6209mr11097180pjg.194.1647448495431;
        Wed, 16 Mar 2022 09:34:55 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id oc3-20020a17090b1c0300b001bf8c88a8c4sm7321131pjb.35.2022.03.16.09.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 09:34:53 -0700 (PDT)
Date:   Wed, 16 Mar 2022 10:34:51 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v4] remoteproc: mediatek: Fix side effect of mt8195 sram
 power on
Message-ID: <20220316163451.GA2546942@p14s>
References: <20220316031117.7311-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316031117.7311-1-tinghan.shen@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning,

On Wed, Mar 16, 2022 at 11:11:17AM +0800, Tinghan Shen wrote:
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
> Fixes: 79111df414fc ("remoteproc: mediatek: Support mt8195 scp")
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
> v4: add Fixes and Reviewed-by tags
> v3: fix build error
> v2: apply comments about macro definition and function calls
> ---
>  drivers/remoteproc/mtk_common.h |  2 ++
>  drivers/remoteproc/mtk_scp.c    | 67 +++++++++++++++++++++++++++++++----------
>  2 files changed, 53 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
> index 5ff3867c72f3..ff954a06637c 100644
> --- a/drivers/remoteproc/mtk_common.h
> +++ b/drivers/remoteproc/mtk_common.h
> @@ -51,6 +51,8 @@
>  #define MT8192_CORE0_WDT_IRQ		0x10030
>  #define MT8192_CORE0_WDT_CFG		0x10034
>  
> +#define MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS		GENMASK(7, 4)
> +
>  #define SCP_FW_VER_LEN			32
>  #define SCP_SHARE_BUFFER_SIZE		288
>  
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index 36e48cf58ed6..5f686fe09203 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -365,22 +365,22 @@ static int mt8183_scp_before_load(struct mtk_scp *scp)
>  	return 0;
>  }
>  
> -static void mt8192_power_on_sram(void __iomem *addr)
> +static void scp_sram_power_on(void __iomem *addr, u32 reserved_mask)

Why is @reserved_mask needed?  It is not described in the changelong and as far
as I can see in this patchset the parameter is always set to '0', which has no
effect on the mask that gets generated.

Thanks,
Mathieu

>  {
>  	int i;
>  
>  	for (i = 31; i >= 0; i--)
> -		writel(GENMASK(i, 0), addr);
> +		writel(GENMASK(i, 0) & ~reserved_mask, addr);
>  	writel(0, addr);
>  }
>  
> -static void mt8192_power_off_sram(void __iomem *addr)
> +static void scp_sram_power_off(void __iomem *addr, u32 reserved_mask)
>  {
>  	int i;
>  
>  	writel(0, addr);
>  	for (i = 0; i < 32; i++)
> -		writel(GENMASK(i, 0), addr);
> +		writel(GENMASK(i, 0) & ~reserved_mask, addr);
>  }
>  
>  static int mt8192_scp_before_load(struct mtk_scp *scp)
> @@ -391,11 +391,32 @@ static int mt8192_scp_before_load(struct mtk_scp *scp)
>  	writel(1, scp->reg_base + MT8192_CORE0_SW_RSTN_SET);
>  
>  	/* enable SRAM clock */
> -	mt8192_power_on_sram(scp->reg_base + MT8192_L2TCM_SRAM_PD_0);
> -	mt8192_power_on_sram(scp->reg_base + MT8192_L2TCM_SRAM_PD_1);
> -	mt8192_power_on_sram(scp->reg_base + MT8192_L2TCM_SRAM_PD_2);
> -	mt8192_power_on_sram(scp->reg_base + MT8192_L1TCM_SRAM_PDN);
> -	mt8192_power_on_sram(scp->reg_base + MT8192_CPU0_SRAM_PD);
> +	scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_0, 0);
> +	scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
> +	scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_2, 0);
> +	scp_sram_power_on(scp->reg_base + MT8192_L1TCM_SRAM_PDN, 0);
> +	scp_sram_power_on(scp->reg_base + MT8192_CPU0_SRAM_PD, 0);
> +
> +	/* enable MPU for all memory regions */
> +	writel(0xff, scp->reg_base + MT8192_CORE0_MEM_ATT_PREDEF);
> +
> +	return 0;
> +}
> +
> +static int mt8195_scp_before_load(struct mtk_scp *scp)
> +{
> +	/* clear SPM interrupt, SCP2SPM_IPC_CLR */
> +	writel(0xff, scp->reg_base + MT8192_SCP2SPM_IPC_CLR);
> +
> +	writel(1, scp->reg_base + MT8192_CORE0_SW_RSTN_SET);
> +
> +	/* enable SRAM clock */
> +	scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_0, 0);
> +	scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
> +	scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_2, 0);
> +	scp_sram_power_on(scp->reg_base + MT8192_L1TCM_SRAM_PDN,
> +			  MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS);
> +	scp_sram_power_on(scp->reg_base + MT8192_CPU0_SRAM_PD, 0);
>  
>  	/* enable MPU for all memory regions */
>  	writel(0xff, scp->reg_base + MT8192_CORE0_MEM_ATT_PREDEF);
> @@ -551,11 +572,25 @@ static void mt8183_scp_stop(struct mtk_scp *scp)
>  static void mt8192_scp_stop(struct mtk_scp *scp)
>  {
>  	/* Disable SRAM clock */
> -	mt8192_power_off_sram(scp->reg_base + MT8192_L2TCM_SRAM_PD_0);
> -	mt8192_power_off_sram(scp->reg_base + MT8192_L2TCM_SRAM_PD_1);
> -	mt8192_power_off_sram(scp->reg_base + MT8192_L2TCM_SRAM_PD_2);
> -	mt8192_power_off_sram(scp->reg_base + MT8192_L1TCM_SRAM_PDN);
> -	mt8192_power_off_sram(scp->reg_base + MT8192_CPU0_SRAM_PD);
> +	scp_sram_power_off(scp->reg_base + MT8192_L2TCM_SRAM_PD_0, 0);
> +	scp_sram_power_off(scp->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
> +	scp_sram_power_off(scp->reg_base + MT8192_L2TCM_SRAM_PD_2, 0);
> +	scp_sram_power_off(scp->reg_base + MT8192_L1TCM_SRAM_PDN, 0);
> +	scp_sram_power_off(scp->reg_base + MT8192_CPU0_SRAM_PD, 0);
> +
> +	/* Disable SCP watchdog */
> +	writel(0, scp->reg_base + MT8192_CORE0_WDT_CFG);
> +}
> +
> +static void mt8195_scp_stop(struct mtk_scp *scp)
> +{
> +	/* Disable SRAM clock */
> +	scp_sram_power_off(scp->reg_base + MT8192_L2TCM_SRAM_PD_0, 0);
> +	scp_sram_power_off(scp->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
> +	scp_sram_power_off(scp->reg_base + MT8192_L2TCM_SRAM_PD_2, 0);
> +	scp_sram_power_off(scp->reg_base + MT8192_L1TCM_SRAM_PDN,
> +			   MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS);
> +	scp_sram_power_off(scp->reg_base + MT8192_CPU0_SRAM_PD, 0);
>  
>  	/* Disable SCP watchdog */
>  	writel(0, scp->reg_base + MT8192_CORE0_WDT_CFG);
> @@ -901,11 +936,11 @@ static const struct mtk_scp_of_data mt8192_of_data = {
>  
>  static const struct mtk_scp_of_data mt8195_of_data = {
>  	.scp_clk_get = mt8195_scp_clk_get,
> -	.scp_before_load = mt8192_scp_before_load,
> +	.scp_before_load = mt8195_scp_before_load,
>  	.scp_irq_handler = mt8192_scp_irq_handler,
>  	.scp_reset_assert = mt8192_scp_reset_assert,
>  	.scp_reset_deassert = mt8192_scp_reset_deassert,
> -	.scp_stop = mt8192_scp_stop,
> +	.scp_stop = mt8195_scp_stop,
>  	.scp_da_to_va = mt8192_scp_da_to_va,
>  	.host_to_scp_reg = MT8192_GIPC_IN_SET,
>  	.host_to_scp_int_bit = MT8192_HOST_IPC_INT_BIT,
> -- 
> 2.15.GIT
> 

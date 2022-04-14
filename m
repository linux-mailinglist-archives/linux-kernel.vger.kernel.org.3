Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD4C501D51
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 23:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346877AbiDNVVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 17:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345666AbiDNVV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 17:21:27 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5E1E6160;
        Thu, 14 Apr 2022 14:19:01 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 154A21F47CE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649971140;
        bh=2xKknOtDpSR8eQDaiaIyagDa3TimNCOxCV05QM9h4w4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GGsh8woUuFVu9AByGubOp4z01sVpeiC5ATFwD3L5+80wsbyGo9tpii4Btn190Ebzv
         2GPkMFbNnHvjbsYOMSOKEG2n4Fm4Tc86Y1u0kvXPRuLGcyd6SUg/k8fGngKGJJEc81
         y/GE3JTd6QrkuZRVLX/RjMCmR9H9pf9HuxY1VDb9BaXMUDzUavxbXp7Pc58Yj1sz/Y
         x3UK4OJ/HFXulBdjHewAJfPJiJSrXIiWWrUGZ+tcX7o+7eSzBJ356XO4K7aCVjwwd6
         YljzroGf/EjaE/QxQt3cXTEtU5wP2vlXYGoOuvdpG1owipTanYuqW4zl27y9aQfEkZ
         YmpQOIxAeEA9w==
Date:   Thu, 14 Apr 2022 17:18:55 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>
Subject: Re: [PATCH v2 1/1] arm64: dts: mt8192: Add mmc device nodes
Message-ID: <20220414211855.5crksjgvar3ugayq@notapiano>
References: <20220407113703.26423-1-allen-kh.cheng@mediatek.com>
 <20220407113703.26423-2-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220407113703.26423-2-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 07:37:03PM +0800, Allen-KH Cheng wrote:
> In mt8192 SoC, mmc driver dose not use the MSDC module to control
> clock. It will read/write register to enable/disable clock. Also
> there is no other device of mt8192 using MSDC controller.
> 
> We add mmc nodes for mt8192 SoC and remove the clock-controller in
> dts for avoid a duplicate unit-address(11f60000) warning.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 34 +++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index a6da7b04b9d4..18a58239d6f1 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -985,10 +985,36 @@
>  			#clock-cells = <1>;
>  		};
>  
> -		msdc: clock-controller@11f60000 {
> -			compatible = "mediatek,mt8192-msdc";
> -			reg = <0 0x11f60000 0 0x1000>;
> -			#clock-cells = <1>;
> +		mmc0: mmc@11f60000 {
> +			compatible = "mediatek,mt8192-mmc", "mediatek,mt8183-mmc";
> +			reg = <0 0x11f60000 0 0x1000>, <0 0x11f50000 0 0x1000>;
> +			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&topckgen CLK_TOP_MSDC50_0_SEL>,
> +				 <&msdc_top CLK_MSDC_TOP_H_MST_0P>,
> +				 <&msdc_top CLK_MSDC_TOP_SRC_0P>,
> +				 <&msdc_top CLK_MSDC_TOP_P_CFG>,
> +				 <&msdc_top CLK_MSDC_TOP_P_MSDC0>,
> +				 <&msdc_top CLK_MSDC_TOP_AXI>,
> +				 <&msdc_top CLK_MSDC_TOP_AHB2AXI_BRG_AXI>;
> +			clock-names = "source", "hclk", "source_cg", "sys_cg",
> +				      "pclk_cg", "axi_cg", "ahb_cg";
> +			status = "disabled";
> +		};
> +
> +		mmc1: mmc@11f70000 {
> +			compatible = "mediatek,mt8192-mmc", "mediatek,mt8183-mmc";
> +			reg = <0 0x11f70000 0 0x1000>, <0 0x11c70000 0 0x1000>;
> +			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&topckgen CLK_TOP_MSDC30_1_SEL>,
> +				 <&msdc_top CLK_MSDC_TOP_H_MST_1P>,
> +				 <&msdc_top CLK_MSDC_TOP_SRC_1P>,
> +				 <&msdc_top CLK_MSDC_TOP_P_CFG>,
> +				 <&msdc_top CLK_MSDC_TOP_P_MSDC1>,
> +				 <&msdc_top CLK_MSDC_TOP_AXI>,
> +				 <&msdc_top CLK_MSDC_TOP_AHB2AXI_BRG_AXI>;
> +			clock-names = "source", "hclk", "source_cg", "sys_cg",
> +				      "pclk_cg", "axi_cg", "ahb_cg";
> +			status = "disabled";
>  		};
>  
>  		mfgcfg: clock-controller@13fbf000 {
> -- 
> 2.18.0
> 
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866464C04A8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 23:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbiBVWe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 17:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236063AbiBVWe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 17:34:27 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C15CC6277;
        Tue, 22 Feb 2022 14:34:01 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 07B771F442FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645569240;
        bh=bgMJpukKsAN/2biajYD0mGaPqwL63HQC8cQg4u9C94g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O+uQejWktUJuxx1ndtBGCiMmIzqI2aGr5fsrAL9xiQZvod9c3+N1eb1Y7E6MkPHVI
         YnJri23wDglTuWQIrUjh1XTDWfHgHO8CZ/tn+W38Jz/Jn9I7LJNHo8RRn5WfmmWu9Z
         74uMw7c35/26DBzTdU5TLzjX1PYImKCzQ/V4RzHAgXCe9DavaKekAaX9Coflafyeux
         GIY/oHrt2gTyTkCEuoowdF2bqAzaQW3Ohm06/MfUDruQYkomovnE2M9Wb9ZZ5mkoeI
         5RhnttcZA6Io9DSPpENTtcsPOXzS8Yv7t5fUMfTVOacDA7DOYItyoT0HAcp9FVgnTT
         igFCguYvhIPng==
Date:   Tue, 22 Feb 2022 17:33:55 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        --to=Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>
Subject: Re: [PATCH v2 17/23] arm64: dts: mt8192: Add vcodec lat and core
 nodes
Message-ID: <20220222223355.o4o6v7yxozsnkz33@notapiano>
References: <20220218091633.9368-1-allen-kh.cheng@mediatek.com>
 <20220218091633.9368-18-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218091633.9368-18-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 05:16:27PM +0800, Allen-KH Cheng wrote:
> Add vcodec lat and core nodes for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 58 ++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 936aa788664f..543a80252ce5 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -1291,6 +1291,64 @@
>  			power-domains = <&spm MT8192_POWER_DOMAIN_ISP2>;
>  		};
>  
> +		vcodec_dec: vcodec_dec@16000000 {

It's usually preferred to use '-' instead of '_' in the node name, like:

		vcodec_dec: vcodec-dec@16000000 {

Same thing for the other vcodec nodes below.

But more importantly, the Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
dt-binding shows the mtk-vcodec-lat and mtk-vcodec-core as subnodes of
vcodec-dec. So I would follow that same structure here. Unless it does make more
sense to have the nodes separate like this, but in that case the dt-binding
should be updated.

> +			compatible = "mediatek,mt8192-vcodec-dec";
> +			reg = <0 0x16000000 0 0x1000>;		/* VDEC_SYS */
> +			mediatek,scp = <&scp>;
> +			iommus = <&iommu0 M4U_PORT_L4_VDEC_MC_EXT>;
> +		};
> +
> +		vcodec_lat: vcodec_lat@0x16010000 {

Again, please drop the '0x' prefix.

> +			compatible = "mediatek,mtk-vcodec-lat";
> +			reg = <0 0x16010000 0 0x800>;		/* VDEC_MISC */
> +			interrupts = <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH 0>;
> +			iommus = <&iommu0 M4U_PORT_L5_VDEC_LAT0_VLD_EXT>,
> +				<&iommu0 M4U_PORT_L5_VDEC_LAT0_VLD2_EXT>,
> +				<&iommu0 M4U_PORT_L5_VDEC_LAT0_AVC_MV_EXT>,
> +				<&iommu0 M4U_PORT_L5_VDEC_LAT0_PRED_RD_EXT>,
> +				<&iommu0 M4U_PORT_L5_VDEC_LAT0_TILE_EXT>,
> +				<&iommu0 M4U_PORT_L5_VDEC_LAT0_WDMA_EXT>,
> +				<&iommu0 M4U_PORT_L5_VDEC_LAT0_RG_CTRL_DMA_EXT>,
> +				<&iommu0 M4U_PORT_L5_VDEC_UFO_ENC_EXT>;
> +			clocks = <&topckgen CLK_TOP_VDEC_SEL>,
> +				 <&vdecsys_soc CLK_VDEC_SOC_VDEC>,
> +				 <&vdecsys_soc CLK_VDEC_SOC_LAT>,
> +				 <&vdecsys_soc CLK_VDEC_SOC_LARB1>,
> +				 <&topckgen CLK_TOP_MAINPLL_D4>;
> +			clock-names = "vdec-sel", "vdec-soc-vdec", "vdec-soc-lat", "vdec-vdec",
> +				      "vdec-top";
> +			assigned-clocks = <&topckgen CLK_TOP_VDEC_SEL>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_MAINPLL_D4>;
> +			power-domains = <&spm MT8192_POWER_DOMAIN_VDEC>;
> +		};
> +
> +		vcodec_core: vcodec_core@0x16025000 {

Ditto.

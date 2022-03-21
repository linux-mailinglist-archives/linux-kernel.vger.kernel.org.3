Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F41D4E3451
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbiCUX3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbiCUX3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:29:21 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C05824D9B2;
        Mon, 21 Mar 2022 16:27:04 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id B251C1F43C95
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647905222;
        bh=YfOseyYYNtgwVpfTGjA3bqGA2K2nb9b7uI+RBSwgmUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T6L1pRqk5jtI5BIq/oxERd8AafUJBe/N5RQOSJzTFuRAa1le7WyF/rxgeEDoQVivH
         +ijVN5/jLghtNAvDjanbWKkAaH5AqsqCMlIWTnQmzPRBvobCD42H2j5n5C4WXKgMi0
         NbPlYLAmlV+hFcLcG2uvVpI8r4Djc2k6RChlsO/l4vNomPU6V4IxvHLfaXpXwtKMv9
         fPBTBCGX0TunfrfBGfDzAgUgff22eXG/OgNORVC7a0nWSofWhHNFv4QyP97+lwl6He
         6loJfvaOAE0Cy718tMUsHOW6OzSKokCariFJgk8HgHAP7evsBB+PPHylM9nF4tkvnZ
         dll6miS7BBR3Q==
Date:   Mon, 21 Mar 2022 19:26:57 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>
Subject: Re: [PATCH v4 18/22] arm64: dts: mt8192: Add display nodes
Message-ID: <20220321232657.6z2g3p2aflixzamp@notapiano>
References: <20220318144534.17996-1-allen-kh.cheng@mediatek.com>
 <20220318144534.17996-19-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220318144534.17996-19-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Allen,

please see my comment below.

On Fri, Mar 18, 2022 at 10:45:30PM +0800, Allen-KH Cheng wrote:
> Add display nodes for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 111 +++++++++++++++++++++++
>  1 file changed, 111 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index a77d405dd508..59183fb6c80b 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -1205,6 +1205,13 @@
>  			#clock-cells = <1>;
>  		};
>  
> +		mutex: mutex@14001000 {
> +			compatible = "mediatek,mt8192-disp-mutex";
> +			reg = <0 0x14001000 0 0x1000>;
> +			interrupts = <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&mmsys CLK_MM_DISP_MUTEX0>;
> +		};
> +
>  		smi_common: smi@14002000 {
>  			compatible = "mediatek,mt8192-smi-common";
>  			reg = <0 0x14002000 0 0x1000>;
> @@ -1236,6 +1243,110 @@
>  			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>  		};
>  
> +		ovl0: ovl@14005000 {
> +			compatible = "mediatek,mt8192-disp-ovl";
> +			reg = <0 0x14005000 0 0x1000>;
> +			interrupts = <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&mmsys CLK_MM_DISP_OVL0>;
> +			iommus = <&iommu0 M4U_PORT_L0_OVL_RDMA0>,
> +				 <&iommu0 M4U_PORT_L0_OVL_RDMA0_HDR>;
> +			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> +		};
> +
> +		ovl_2l0: ovl@14006000 {
> +			compatible = "mediatek,mt8192-disp-ovl-2l";
> +			reg = <0 0x14006000 0 0x1000>;
> +			interrupts = <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH 0>;
> +			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> +			clocks = <&mmsys CLK_MM_DISP_OVL0_2L>;
> +			iommus = <&iommu0 M4U_PORT_L1_OVL_2L_RDMA0>,
> +				 <&iommu0 M4U_PORT_L1_OVL_2L_RDMA0_HDR>;
> +		};
> +
> +		rdma0: rdma@14007000 {
> +			compatible = "mediatek,mt8192-disp-rdma";
> +			reg = <0 0x14007000 0 0x1000>;
> +			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&mmsys CLK_MM_DISP_RDMA0>;
> +			iommus = <&iommu0 M4U_PORT_L0_DISP_RDMA0>;
> +			mediatek,larb = <&larb0>;
> +			mediatek,rdma-fifo-size = <5120>;
> +			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> +		};
> +
> +		color0: color@14009000 {
> +			compatible = "mediatek,mt8192-disp-color",
> +				     "mediatek,mt8173-disp-color";
> +			reg = <0 0x14009000 0 0x1000>;
> +			interrupts = <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH 0>;
> +			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> +			clocks = <&mmsys CLK_MM_DISP_COLOR0>;
> +		};
> +
> +		ccorr0: ccorr@1400a000 {
> +			compatible = "mediatek,mt8192-disp-ccorr";
> +			reg = <0 0x1400a000 0 0x1000>;
> +			interrupts = <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH 0>;
> +			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> +			clocks = <&mmsys CLK_MM_DISP_CCORR0>;
> +		};
> +
> +		aal0: aal@1400b000 {
> +			compatible = "mediatek,mt8192-disp-aal",
> +				     "mediatek,mt8193-disp-aal";

Typo: "mediatek,mt8193-disp-aal" should be "mediatek,mt8173-disp-aal", otherwise 
the drm driver doesn't even probe. Typos happen, just please make sure you're
testing before sending to the list so these kind of issues can be caught
earlier.

Thanks,
Nícolas

> +			reg = <0 0x1400b000 0 0x1000>;
> +			interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH 0>;
> +			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> +			clocks = <&mmsys CLK_MM_DISP_AAL0>;
> +		};

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DC74C0552
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 00:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbiBVXZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 18:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbiBVXZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 18:25:13 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8C895A22;
        Tue, 22 Feb 2022 15:24:46 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 3901E1F437CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645572285;
        bh=Y99Kgv35NWklxSCIAVoRoJB52jvRTFhn5NbAZVxgVIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k89Zla47G5rHXIFtgcXqP2eULMzjER8Soov6YODpH/uPXBC5HubzP6ZlILYQ24Zde
         TqjPAFYy1BV/7MCF7laeurtK/6IzNDOrA+iXIaJ5JpUgQOPmCU7avNLQ4xpvWtcIGF
         eHx2nuRaf+BlmGFuTMg+bE9yvj0HaGhzqIPGUrm1WdQOkNVi8DzPrsfTk5KpXMlsR3
         iIdL2aZcbQKhc5bPAdaYzwSYRBApi/eZ72lLIergQ0YDOg5/o93k0NIm13xW4MG9kF
         5QwKyv9TURAlDgsB6C1asYoUACIuCn/Rd8tgAyvR+BGeR4yWrDqY1kCQaKhCif5MEg
         VtvuLLOZxK0jg==
Date:   Tue, 22 Feb 2022 18:24:39 -0500
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
Subject: Re: [PATCH v2 22/23] arm64: dts: mt8192: Add gce info for display
 nodes
Message-ID: <20220222232439.dhsvnut3phudlsls@notapiano>
References: <20220218091633.9368-1-allen-kh.cheng@mediatek.com>
 <20220218091633.9368-23-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218091633.9368-23-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 05:16:32PM +0800, Allen-KH Cheng wrote:
> Add gce info for display nodes.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 1f1555fd18f5..df884c48669e 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -1226,6 +1226,9 @@
>  		mmsys: syscon@14000000 {
>  			compatible = "mediatek,mt8192-mmsys", "syscon";
>  			reg = <0 0x14000000 0 0x1000>;
> +			mboxes = <&gce 0 CMDQ_THR_PRIO_HIGHEST 1>,
> +				 <&gce 1 CMDQ_THR_PRIO_HIGHEST 1>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0 0x1000>;

As a side note, the current mmsys dt-binding,
Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml, doesn't
define mboxes or mediatek,gce-client-reg, but looks like there's already a patch
in the ML adding those:

https://lore.kernel.org/all/20220126071932.32615-2-jason-jh.lin@mediatek.com/

>  			#clock-cells = <1>;
>  		};
>  
> @@ -1234,6 +1237,8 @@
>  			reg = <0 0x14001000 0 0x1000>;
>  			interrupts = <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH 0>;
>  			clocks = <&mmsys CLK_MM_DISP_MUTEX0>;
> +			mediatek,gce-events = <CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_0>,
> +					      <CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_1>;
>  		};
>  
>  		smi_common: smi@14002000 {
> @@ -1275,6 +1280,7 @@
>  			iommus = <&iommu0 M4U_PORT_L0_OVL_RDMA0>,
>  				 <&iommu0 M4U_PORT_L0_OVL_RDMA0_HDR>;
>  			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x5000 0x1000>;
>  		};
>  
>  		ovl_2l0: ovl@14006000 {
> @@ -1285,6 +1291,7 @@
>  			clocks = <&mmsys CLK_MM_DISP_OVL0_2L>;
>  			iommus = <&iommu0 M4U_PORT_L1_OVL_2L_RDMA0>,
>  				 <&iommu0 M4U_PORT_L1_OVL_2L_RDMA0_HDR>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x6000 0x1000>;
>  		};
>  
>  		rdma0: rdma@14007000 {
> @@ -1296,6 +1303,7 @@
>  			mediatek,larb = <&larb0>;
>  			mediatek,rdma-fifo-size = <5120>;
>  			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x7000 0x1000>;
>  		};
>  
>  		color0: color@14009000 {
> @@ -1305,6 +1313,7 @@
>  			interrupts = <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH 0>;
>  			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>  			clocks = <&mmsys CLK_MM_DISP_COLOR0>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x9000 0x1000>;
>  		};
>  
>  		ccorr0: ccorr@1400a000 {
> @@ -1313,6 +1322,7 @@
>  			interrupts = <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH 0>;
>  			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>  			clocks = <&mmsys CLK_MM_DISP_CCORR0>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xa000 0x1000>;
>  		};
>  
>  		aal0: aal@1400b000 {
> @@ -1321,6 +1331,7 @@
>  			interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH 0>;
>  			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>  			clocks = <&mmsys CLK_MM_DISP_AAL0>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xb000 0x1000>;
>  		};
>  
>  		gamma0: gamma@1400c000 {
> @@ -1330,6 +1341,7 @@
>  			interrupts = <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH 0>;
>  			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>  			clocks = <&mmsys CLK_MM_DISP_GAMMA0>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xc000 0x1000>;
>  		};
>  
>  		postmask0: postmask@1400d000 {
> @@ -1339,6 +1351,7 @@
>  			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>  			clocks = <&mmsys CLK_MM_DISP_POSTMASK0>;
>  			iommus = <&iommu0 M4U_PORT_L0_DISP_POSTMASK0>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xd000 0x1000>;
>  		};
>  
>  		dither0: dither@1400e000 {
> @@ -1348,6 +1361,7 @@
>  			interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH 0>;
>  			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>  			clocks = <&mmsys CLK_MM_DISP_DITHER0>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xe000 0x1000>;
>  		};
>  
>  		dsi0: dsi@14010000 {
> @@ -1371,6 +1385,7 @@
>  			clocks = <&mmsys CLK_MM_DISP_OVL2_2L>;
>  			iommus = <&iommu0 M4U_PORT_L1_OVL_2L_RDMA2>,
>  				 <&iommu0 M4U_PORT_L1_OVL_2L_RDMA2_HDR>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x4000 0x1000>;
>  		};
>  
>  		rdma4: rdma@14015000 {
> @@ -1381,6 +1396,7 @@
>  			clocks = <&mmsys CLK_MM_DISP_RDMA4>;
>  			iommus = <&iommu0 M4U_PORT_L1_DISP_RDMA4>;
>  			mediatek,rdma-fifo-size = <2048>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x5000 0x1000>;
>  		};
>  
>  		dpi0: dpi@14016000 {
> -- 
> 2.18.0
> 
> 

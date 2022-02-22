Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14014C0467
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 23:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbiBVWNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 17:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiBVWNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 17:13:53 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797BFC2E77;
        Tue, 22 Feb 2022 14:13:27 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id F3D1B1F441DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645568006;
        bh=q2TRzkQcc6bxTmQ/UE5mgvEoMLViCD8R1DxoR1bUm8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cJeaMIhBX76bNSPu+Z0Vn1AwC1FdJrr2rZ75ydgqwiypbJ/Po6LLAxh+vufAhtn6m
         QjYtQGbR7H2nT8vW4oPbMOBXzYDftTe7IikOAJQTNfjdv7pxOhCZgAgpoxjdmMYu05
         CAnVu90tbDjltLVpQjp0NafZ1+33mJ77qluatWdobByPZxNgFtL7zw3qrczeCJVdaT
         mbAWAOTpjrUcY20z283K/DdeNTbXcqtqqgnWWQUtwZWRDy0n5aHM6kJPDT9SK/r/FN
         R/JfzUW2JNCUBtVeWKGWTeodvYt268u9tGfbBS6nINpwRBkpWfvtnQcJyqk19hM/zk
         UPhHkUqG7fi5Q==
Date:   Tue, 22 Feb 2022 17:13:21 -0500
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
Subject: Re: [PATCH v2 16/23] arm64: dts: mt8192: Add H264 venc device node
Message-ID: <20220222221321.q5zhe7kbwf6xzafr@notapiano>
References: <20220218091633.9368-1-allen-kh.cheng@mediatek.com>
 <20220218091633.9368-17-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218091633.9368-17-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 05:16:26PM +0800, Allen-KH Cheng wrote:
> Adds H264 venc node for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 40887120fdb3..936aa788664f 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -1342,6 +1342,29 @@
>  			power-domains = <&spm MT8192_POWER_DOMAIN_VENC>;
>  		};
>  
> +		vcodec_enc: vcodec@0x17020000 {

The node address shouldn't have the '0x' prefix. Please drop it.

> +			compatible = "mediatek,mt8192-vcodec-enc";
> +			reg = <0 0x17020000 0 0x2000>;
> +			iommus = <&iommu0 M4U_PORT_L7_VENC_RCPU>,
> +				<&iommu0 M4U_PORT_L7_VENC_REC>,
> +				<&iommu0 M4U_PORT_L7_VENC_BSDMA>,
> +				<&iommu0 M4U_PORT_L7_VENC_SV_COMV>,
> +				<&iommu0 M4U_PORT_L7_VENC_RD_COMV>,
> +				<&iommu0 M4U_PORT_L7_VENC_CUR_LUMA>,
> +				<&iommu0 M4U_PORT_L7_VENC_CUR_CHROMA>,
> +				<&iommu0 M4U_PORT_L7_VENC_REF_LUMA>,
> +				<&iommu0 M4U_PORT_L7_VENC_REF_CHROMA>,
> +				<&iommu0 M4U_PORT_L7_VENC_SUB_R_LUMA>,
> +				<&iommu0 M4U_PORT_L7_VENC_SUB_W_LUMA>;

Please fix indentation:
			iommus = <&iommu0 M4U_PORT_L7_VENC_RCPU>,
				 <&iommu0 M4U_PORT_L7_VENC_REC>,
				 <&iommu0 M4U_PORT_L7_VENC_BSDMA>,
				 <&iommu0 M4U_PORT_L7_VENC_SV_COMV>,
				 <&iommu0 M4U_PORT_L7_VENC_RD_COMV>,
				 <&iommu0 M4U_PORT_L7_VENC_CUR_LUMA>,
				 <&iommu0 M4U_PORT_L7_VENC_CUR_CHROMA>,
				 <&iommu0 M4U_PORT_L7_VENC_REF_LUMA>,
				 <&iommu0 M4U_PORT_L7_VENC_REF_CHROMA>,
				 <&iommu0 M4U_PORT_L7_VENC_SUB_R_LUMA>,
				 <&iommu0 M4U_PORT_L7_VENC_SUB_W_LUMA>;

> +			interrupts = <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH 0>;
> +			mediatek,scp = <&scp>;
> +			power-domains = <&spm MT8192_POWER_DOMAIN_VENC>;
> +			clocks = <&vencsys CLK_VENC_SET1_VENC>;
> +			clock-names = "venc-set1";
> +			assigned-clocks = <&topckgen CLK_TOP_VENC_SEL>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D4>;
> +		};
> +
>  		camsys: clock-controller@1a000000 {
>  			compatible = "mediatek,mt8192-camsys";
>  			reg = <0 0x1a000000 0 0x1000>;
> -- 
> 2.18.0
> 
> 

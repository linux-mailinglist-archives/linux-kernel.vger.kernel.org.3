Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790FF4C02E1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 21:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbiBVULI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 15:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiBVULH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 15:11:07 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451E310CF22;
        Tue, 22 Feb 2022 12:10:41 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 962771F43B94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645560640;
        bh=ijj2dOGdIN4gy/4SAGPiZ20l35Ou58dlQ9MCO5DfMIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G29CedeLHQLOCZfpfQbXX3XGa/nWcAvsTeMiNJZOsDGFnAgdYZyDnAgQFbC8m0deA
         Vt+3/geQqeCPUzmdB8wrYXBCKB8CHJt/Ld9rS/uXc4iwNVZ515AAHeKJX66hivM9ZJ
         r4XlsCk6FQDniPjKYHIRdBU2uL8rvjBZpY/BLcnZRPdKFnt/j9jGwOiBX10U28FGjD
         NOsL0t71Wz/Jaq8/1ui5ABEk4ws6yxl508TopE3RbC9rVksAgYX9I6H2MlM5rFdmGK
         lCeQ6zxWsUnJFqZWKCm9laTtntmxnljkOuVnFnIOIN83ghTGSdsB5ClP6jrzGSDBud
         AcqnN5T8i1n+Q==
Date:   Tue, 22 Feb 2022 15:10:34 -0500
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
Subject: Re: [PATCH v2 06/23] arm64: dts: mt8192: Add usb-phy node
Message-ID: <20220222201034.pb36pfrgujushsge@notapiano>
References: <20220218091633.9368-1-allen-kh.cheng@mediatek.com>
 <20220218091633.9368-7-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218091633.9368-7-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 05:16:16PM +0800, Allen-KH Cheng wrote:
> Add xhci node for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 25 ++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 61aadd7bd397..ce18d692175f 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -875,6 +875,31 @@
>  			#clock-cells = <1>;
>  		};
>  
> +		u3phy0: usb-phy@11e40000 {

According to Documentation/devicetree/bindings/phy/mediatek,tphy.yaml, this node
should be called t-phy. Only the child nodes should be usb-phy.

> +			compatible = "mediatek,mt8192-tphy",
> +				     "mediatek,generic-tphy-v2";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			status = "okay";

"okay" is already the default status, so you can drop this line, as well as the
ones on the child nodes below.

> +
> +			u2port0: usb-phy@11e40000 {
> +				reg = <0 0x11e40000 0 0x700>;
> +				clocks = <&clk26m>;
> +				clock-names = "ref";
> +				#phy-cells = <1>;
> +				status = "okay";
> +			};
> +
> +			u3port0: usb-phy@11e40700 {
> +				reg = <0 0x11e40700 0 0x900>;
> +				clocks = <&clk26m>;
> +				clock-names = "ref";
> +				#phy-cells = <1>;
> +				status = "okay";
> +			};
> +		};
> +
>  		i2c0: i2c@11f00000 {
>  			compatible = "mediatek,mt8192-i2c";
>  			reg = <0 0x11f00000 0 0x1000>,
> -- 
> 2.18.0
> 
> 

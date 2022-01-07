Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254D6487909
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347854AbiAGOeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:34:00 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40890 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347842AbiAGOdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:33:54 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 408B91F41A85
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641566033;
        bh=S6g2QtSzI5+1r67tBCkX1p6hf9aRQncVydbE/K0CvFE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FiZyESksESvLJVJb31IPZiU8saE3D5wey8Tkw0hgSqxnZLlHXC9d0CLvICOOGHNk1
         4rLTTumsxrOIzSXyOZIoVTqUJHhRj2PEU6Ro5SteSJ/Xpr1sSin0/THxxHPVW6nzEP
         SuEWH1/nUw4RiPF8zadC1QS9sfhkwDZI+I1/18WsjMcErmSBQCILbEkVeUPaSiY9Dd
         dCqA4iX7Iw/Imb09nkq2oZWEMrva7noxD0eDc0sRyyJgM5jDyXuEs/cIEvhwO1umpX
         iUPtjUHRaiR3rzs+JNYCBa8su1nGx5+Qbh6FMm77tT6dCQME73NK6B82f9auX/u4wC
         lTRc0KScgey4A==
Subject: Re: [PATCH v21 7/8] arm64: dts: mt8192: add svs device information
To:     Roger Lu <roger.lu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Guenter Roeck <linux@roeck-us.net>
References: <20220107095200.4389-1-roger.lu@mediatek.com>
 <20220107095200.4389-8-roger.lu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <010f9b6a-d6bf-b27a-cb2d-c5fd181c3ac7@collabora.com>
Date:   Fri, 7 Jan 2022 15:33:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220107095200.4389-8-roger.lu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/01/22 10:51, Roger Lu ha scritto:
> Add compitable/reg/irq/clock/efuse/reset setting in svs node.

Typo: compitable => compatible
.. also, you're not only adding the svs node, but also efuse: please add that
information in the commit description.

> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>

This patch seems to not apply on top of the current linux-next, can you please
rebase it? That would resolve issues with this series and would be picked sooner.

Apart from that...

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 39 ++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index c7c7d4e017ae..c111e26489dd 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -9,6 +9,8 @@
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/interrupt-controller/irq.h>
>   #include <dt-bindings/pinctrl/mt8192-pinfunc.h>
> +#include <dt-bindings/reset/ti-syscon.h>
> +
>   
>   / {
>   	compatible = "mediatek,mt8192";
> @@ -268,6 +270,14 @@
>   			compatible = "mediatek,mt8192-infracfg", "syscon";
>   			reg = <0 0x10001000 0 0x1000>;
>   			#clock-cells = <1>;
> +
> +			infracfg_rst: reset-controller {
> +				compatible = "mediatek,infra-reset", "ti,syscon-reset";
> +				#reset-cells = <1>;
> +				ti,reset-bits = <
> +					0x150 5 0x154 5 0 0     (ASSERT_SET | DEASSERT_SET | STATUS_NONE) /* 0: svs */
> +				>;
> +			};
>   		};
>   
>   		pericfg: syscon@10003000 {
> @@ -362,6 +372,20 @@
>   			status = "disabled";
>   		};
>   
> +		svs: svs@1100b000 {
> +			compatible = "mediatek,mt8192-svs";
> +			reg = <0 0x1100b000 0 0x1000>;
> +			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&infracfg CLK_INFRA_THERM>;
> +			clock-names = "main";
> +			nvmem-cells = <&svs_calibration>,
> +				      <&lvts_e_data1>;
> +			nvmem-cell-names = "svs-calibration-data",
> +					   "t-calibration-data";
> +			resets = <&infracfg_rst 0>;
> +			reset-names = "svs_rst";
> +		};
> +
>   		spi1: spi@11010000 {
>   			compatible = "mediatek,mt8192-spi",
>   				     "mediatek,mt6765-spi";
> @@ -479,6 +503,21 @@
>   			#clock-cells = <1>;
>   		};
>   
> +		efuse: efuse@11c10000 {
> +			compatible = "mediatek,efuse";
> +			reg = <0 0x11c10000 0 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			lvts_e_data1: data1@1c0 {
> +				reg = <0x1c0 0x58>;
> +			};
> +
> +			svs_calibration: calib@580 {
> +				reg = <0x580 0x68>;
> +			};
> +		};
> +
>   		i2c3: i2c3@11cb0000 {
>   			compatible = "mediatek,mt8192-i2c";
>   			reg = <0 0x11cb0000 0 0x1000>,
> 


-- 
AngeloGioacchino Del Regno
Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

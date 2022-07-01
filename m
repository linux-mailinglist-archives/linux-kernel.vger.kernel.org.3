Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D167D563C51
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 00:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiGAW0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 18:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiGAW0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 18:26:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4BF6EE93;
        Fri,  1 Jul 2022 15:26:18 -0700 (PDT)
Received: from notapiano (unknown [194.36.25.35])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4E0F566017F5;
        Fri,  1 Jul 2022 23:26:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656714377;
        bh=beS5ia/epfrcQ6hdTw5AHZCvOKhrfWGiS1y5nk9Am2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=STp0U8Ao78Klox+71MTgbfJRjfjdaEkXSCVsMjF5mHJRTTbTpaseIN+VA/bXaOYc0
         q4TDttde0IZm4jASx3gX9Qz6dEjt6JtTI4EnLJvcI/GlxsUqPfg/wxObtjCXbTnvrW
         53xvASSd4bs07A3030tOm4YsYmhAZT1rSni07usd9LH2syDI2ELgG/J8Do7vHzoA2c
         bRSxM+vyoGri8THfzfKwk3yRO2HZETNaq+cP0G25t56PZWLHZYef26VDjNE8SYG83W
         kql0SmkB4QuqKSLQk7AQz55lfZlpVaaIHcXuE6ZS8EIkDeW1IqM0G8EYiVC1dU8NKV
         Pw6wnMVaNLD0w==
Date:   Fri, 1 Jul 2022 18:26:09 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, hsinyi@chromium.org,
        allen-kh.cheng@mediatek.com, gtk3@inbox.ru, luca@z3ntu.xyz,
        sam.shih@mediatek.com, sean.wang@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
Subject: Re: [PATCH 04/11] arm64: dts: mediatek: cherry: Add platform
 regulators layout and config
Message-ID: <20220701222609.w6nowe5ng4ndszol@notapiano>
References: <20220630153316.308767-1-angelogioacchino.delregno@collabora.com>
 <20220630153316.308767-5-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220630153316.308767-5-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 05:33:09PM +0200, AngeloGioacchino Del Regno wrote:
> Add the regulators layout for this platform, including the basic power
> rails controlled by the EC (and/or always on).
> Moreover, include the MT6359 PMIC devicetree and add some configuration
> for its regulators, essential to keep the machine alive after booting.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../boot/dts/mediatek/mt8195-cherry.dtsi      | 102 ++++++++++++++++++
>  1 file changed, 102 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> index 14f8f30b1eb3..091338f7d5ff 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> @@ -5,6 +5,7 @@
>  
>  #include <dt-bindings/gpio/gpio.h>
>  #include "mt8195.dtsi"
> +#include "mt6359.dtsi"
>  
>  / {
>  	aliases {
> @@ -19,6 +20,107 @@ memory@40000000 {
>  		device_type = "memory";
>  		reg = <0 0x40000000 0 0x80000000>;
>  	};
> +
> +	/* system wide LDO 3.3V power rail */
> +	pp3300_z5: regulator-3v3-pp3300-ldo-z5 {

I wouldn't have both "3v3" and "pp3300" in the node name since they mean the
same thing, but feel free to ignore this comment :).

> +		compatible = "regulator-fixed";
> +		regulator-name = "pp3300_ldo_z5";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&ppvar_sys>;
> +	};
> +
> +	/* separately switched 3.3V power rail */
> +	pp3300_s3: regulator-3v3-pp3300-s3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "pp3300_s3";
> +		/* automatically sequenced by PMIC EXT_PMIC_EN2 */
> +		regulator-always-on;
> +		regulator-boot-on;

Missing regulator-min/max-microvolt?

> +		vin-supply = <&pp3300_z2>;
> +	};
[..]
> -- 
> 2.35.1
> 

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas

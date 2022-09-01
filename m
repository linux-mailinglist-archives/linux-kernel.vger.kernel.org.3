Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813075A9EF0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 20:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbiIAS32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 14:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiIAS31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 14:29:27 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7A87CB62;
        Thu,  1 Sep 2022 11:29:26 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9319B6CD;
        Thu,  1 Sep 2022 20:29:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1662056964;
        bh=Z2PmbE+q+oRXUcaxQb4yleqabhSi7+sIU+fRtX1f08s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EC9PRlW04t2B9cCt+4wz2+8sQ2yp8ZM7K4V7wFcAu18ic4AGLGU00x4HynEEWPN2Q
         Qz2NoygeN3lB+O3uKqaXMdjNbid1+cX2wo60JSgsJWl4n9pr++mwna1ahvOcnmbBYQ
         uTEIOzPWZL7Zo/XQrQStWN6+c4w7jIunb8wj3B2s=
Date:   Thu, 1 Sep 2022 21:29:13 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] arm64: dts: imx8mp-verdin: board regulators: add
 always-on
Message-ID: <YxD5+RCYtzcxEdjj@pendragon.ideasonboard.com>
References: <20220901110422.1859621-1-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220901110422.1859621-1-max.oss.09@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

(CC'ing Mark and Liam)

Thank you for the patch.

On Thu, Sep 01, 2022 at 01:04:22PM +0200, Max Krummenacher wrote:
> From: Max Krummenacher <max.krummenacher@toradex.com>
> 
> These regulators are switched on by HW during power up and can not
> be influenced by SW.
> Set the always-on property.

Is this needed ? When a fixed regulator has no control GPIO or clock, as
is the case here, I would expect the driver and/or regulator core to
understand that it's always on, as the alternative is always-off, which
is pointless :-) Mark, Liam, what do you think ?

> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> 
> ---
> 
>  arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
> index 557cfef8f049..76cc89296150 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
> @@ -62,6 +62,7 @@ button-wakeup {
>  	/* Carrier Board Supplies */
>  	reg_1p8v: regulator-1p8v {
>  		compatible = "regulator-fixed";
> +		regulator-always-on;
>  		regulator-max-microvolt = <1800000>;
>  		regulator-min-microvolt = <1800000>;
>  		regulator-name = "+V1.8_SW";
> @@ -69,6 +70,7 @@ reg_1p8v: regulator-1p8v {
>  
>  	reg_3p3v: regulator-3p3v {
>  		compatible = "regulator-fixed";
> +		regulator-always-on;
>  		regulator-max-microvolt = <3300000>;
>  		regulator-min-microvolt = <3300000>;
>  		regulator-name = "+V3.3_SW";
> @@ -76,6 +78,7 @@ reg_3p3v: regulator-3p3v {
>  
>  	reg_5p0v: regulator-5p0v {
>  		compatible = "regulator-fixed";
> +		regulator-always-on;
>  		regulator-max-microvolt = <5000000>;
>  		regulator-min-microvolt = <5000000>;
>  		regulator-name = "+V5_SW";

-- 
Regards,

Laurent Pinchart

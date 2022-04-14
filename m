Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171A850176B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 17:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239333AbiDNPgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349384AbiDNOUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 10:20:01 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2340C9BBB6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:11:12 -0700 (PDT)
Received: from SoMainline.org (D57D4C6E.static.ziggozakelijk.nl [213.125.76.110])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id A5B533EEFB;
        Thu, 14 Apr 2022 16:11:09 +0200 (CEST)
Date:   Thu, 14 Apr 2022 16:11:07 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        Vinod Koul <vkoul@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>
Subject: Re: [PATCH 1/1] arm64: dts: qcom: sm8350-sagami: UFS phy - add
 'vdda-pll-supply' & 'vdda-phy-supply'
Message-ID: <20220414141107.sazz72sl6giehpjx@SoMainline.org>
References: <20220414122928.349126-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414122928.349126-1-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-14 17:59:28, Bhupesh Sharma wrote:
> As suggested by Bjorn during review of [1], the vdda-pll-supply' &
> 'vdda-phy-supply' supplies denote the power for the bus and the
> clock of the UFS PHY.
> 
> For pdx215 to have a functional UFS [..] safe to assume [..]

By "functional" you are referring to sending a certain UFS command that
accidentally wipes the bootloader [1] [2], turning the device into a
_very_ expensive (+$1000) paperweight?

[1]: https://lore.kernel.org/lkml/20211111184630.605035-1-konrad.dybcio@somainline.org/
[2]: https://github.com/kholk/kernel/commit/2e7a9ee1c91a016baa0b826a7752ec45663a0561

> In absence of the same 'make dtbs_check' leads to following warnings:
> 
> arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dt.yaml:
>  phy-wrapper@88e9000: 'vdda-phy-supply' is a required property
> 
> arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dt.yaml:
>  phy-wrapper@88e9000: 'vdda-pll-supply' is a required property
> 
> [1]. https://lore.kernel.org/lkml/20220228123019.382037-9-bhupesh.sharma@linaro.org/
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: konrad.dybcio@somainline.org
> Cc: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  .../dts/qcom/sm8350-sony-xperia-sagami.dtsi   | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> index 90b13cbe2fa6..238ac9380ca2 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> @@ -3,6 +3,7 @@
>   * Copyright (c) 2021, Konrad Dybcio <konrad.dybcio@somainline.org>
>   */
>  
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  #include "sm8350.dtsi"
>  #include "pm8350.dtsi"
>  #include "pm8350b.dtsi"
> @@ -75,6 +76,27 @@ ramoops@ffc00000 {
>  	};
>  };
>  
> +&apps_rsc {
> +	pm8350-rpmh-regulators {
> +		compatible = "qcom,pm8350-rpmh-regulators";
> +		qcom,pmic-id = "b";
> +
> +		vreg_l1b_0p88: ldo1 {
> +			regulator-name = "vreg_l1b_0p88";
> +			regulator-min-microvolt = <912000>;
> +			regulator-max-microvolt = <920000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l6b_1p2: ldo6 {
> +			regulator-name = "vreg_l6b_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1208000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +};
> +
>  &adsp {
>  	status = "okay";
>  	firmware-name = "qcom/adsp.mbn";
> @@ -256,4 +278,7 @@ &usb_1_hsphy {
>  
>  &usb_1_qmpphy {
>  	status = "okay";
> +
> +	vdda-phy-supply = <&vreg_l6b_1p2>;
> +	vdda-pll-supply = <&vreg_l1b_0p88>;

I'm probably understanding your patch wrong, but this is the USB phy,
not the UFS phy?  The warning from dtbs_check on `phy-wrapper@88e9000`
is also the `qmp-usb3-phy`, not the `qmp-ufs-phy` - seems this patch has
little to do with UFS after all?

>  };
> -- 
> 2.35.1
> 

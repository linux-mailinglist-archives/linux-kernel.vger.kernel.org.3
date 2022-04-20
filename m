Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD6A507EFE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 04:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348705AbiDTCoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 22:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344734AbiDTCof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:44:35 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFE7377D7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 19:41:50 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-e5ca5c580fso619090fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 19:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aaX/UB/2BnqdVf5C8GfwvoatWrRoN/yQh5VPxrROKnA=;
        b=w8ElRxixNxczkAPSzOilsYI1pNXrdnHKeUV12k8IHbGZw24Riiz/+1SYrEvkxMxDjy
         4JdAV2AM8nbTtjYWWiE60Yn1kamcRup6xEeaYY/sV3MGVU74FttnhcUn6E3cUVVrW1I6
         QQwX5Ct4amk+euAWMhLxPc2KjUx6EU9Y48eKZ2GsM7DlfaVce84NN1KHpfl+IHaepuxu
         UODZOwOc/LXe7NneiytyjbYQ5uq0LGv3YNl1MXyr3RhlCN3bpupDiDvXTRUFX86D3L3h
         wOznhUtAB9kiRMWKbesYmSpDENs4AiHxpjyE9FOw8y1pHLLC5uuNCyfml/bdaGmavy3P
         Wzlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aaX/UB/2BnqdVf5C8GfwvoatWrRoN/yQh5VPxrROKnA=;
        b=FVG0Gbf8NZcCvUyTH/ZCgWGrFlcG+dV6vmZjb3BPLrDqgf033sCGj4WPY87WN2iWoz
         X5akneigyUrPR9z6Db5VE+VhQLYEFCnAY8drLHyFURnSTi01uLEeNSNMGL/n642FZM6x
         C9RjJtmxiRDfQAfvuI5V05mn0sXMoULLYgjmM2zLEys/WMzwZeOZRug5SfHRjVjLAKkN
         N3+YK2VjsyrcxSGKWHRzigFSU2Z0FUmvkT1Db43c6yWwZA+zldHd1RxUQNy9XtqwjbIO
         8cOUDO4lqutv9WfrPRyqj4J+XjNEeyJXrq3xp2NM1LvqtLgjd3/9B/ZPcibbZj98rV3u
         wPYw==
X-Gm-Message-State: AOAM531/qhlmxMxLDPPkVzksHXLg4R37I2l5cvThPC4/MENzHdW64+1a
        TnyZAzPppUg2107iW11mtsy16w==
X-Google-Smtp-Source: ABdhPJx/b7/bSQcrLQiriSkVkxOgSx/ZCNnuCH6SWCqN2lWYiL+xBRcWyS2xtW/clxXTZAw9aszy0A==
X-Received: by 2002:a05:6870:7090:b0:e6:49ed:4a9b with SMTP id v16-20020a056870709000b000e649ed4a9bmr219923oae.177.1650422510011;
        Tue, 19 Apr 2022 19:41:50 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id e18-20020a9d7312000000b006054dfa7eb6sm2781708otk.78.2022.04.19.19.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 19:41:49 -0700 (PDT)
Date:   Tue, 19 Apr 2022 21:41:47 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        konrad.dybcio@somainline.org
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, Marijn Suijten <marijn.suijten@somainline.org>
Subject: Re: [PATCH v2 1/1] arm64: dts: qcom: sm8350-sagami: usb qmp phy node
 - add 'vdda-pll-supply' & 'vdda-phy-supply'
Message-ID: <Yl9y668H/N+bcrP4@builder.lan>
References: <20220419205854.1269922-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419205854.1269922-1-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19 Apr 15:58 CDT 2022, Bhupesh Sharma wrote:

How about making the subject:

"arm64: dts: qcom: sm8350-sagami: add supplies to USB phy node"

It still says the same thing, but in much less characters.

> As suggested by Bjorn during review of [1], the 'vdda-pll-supply' &
> 'vdda-phy-supply' supplies denote the power for the bus and the
> clock of the usb qmp phy and are used by the qcom qmp phy driver.
> 
> So, its safe to assume that the two regulators are the same as on
> the MTP. So let's wire them up in the same way as the MTP.
> 

I'm not sure it's "safe to assume", so I would like to get Konrad's
input before merging this.

> In absence of the same 'make dtbs_check' leads to following warnings:
> 
> arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dt.yaml:
>  phy-wrapper@88e9000: 'vdda-phy-supply' is a required property
> 
> arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dt.yaml:
>  phy-wrapper@88e9000: 'vdda-pll-supply' is a required property
> 

This is good!

Thanks for the patch Bhupesh,
Bjorn

> [1]. https://lore.kernel.org/lkml/20220228123019.382037-9-bhupesh.sharma@linaro.org/
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: konrad.dybcio@somainline.org
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
> Changes since v1:
> -----------------
> - v1 can be found here: https://www.spinics.net/lists/linux-arm-msm/msg108467.html
> - Fixed the commit message to read usb qmp phy instead of ufs phy (which
>   was introduced erroraneously in the commit log).
> 
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
>  };
> -- 
> 2.35.1
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0830518B15
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 19:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240376AbiECRbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 13:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240375AbiECRbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 13:31:23 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F413DDD2
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 10:27:49 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-e9027efe6aso17824551fac.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 10:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GiDmkd6XuqThs4HFUR/z2IY+5TaIpRlZZuzKQVJMQSQ=;
        b=iKpAcaR3ZIEHJzgosS5umMsBITErH9PsIh1LOOZtpnsgkbyzkfOBUMp4c0k3m45SOe
         ISlOoCuWkTg8GqmwbMDX8I8KYDI4UHLy9m6KOdg0HUNre0FuIklM2ZBa4/HkWJER+tva
         mPQXraMUJRMhKPR0z1XY51MaCyrXv7dzCLVzKcFJFAgeW/b2VW0y51tmm/ZthMXDvsRS
         ubgOX/mZJn118Oj+ZK6H+pCFV5kbc3IaZ3aQosXLHC8p+fA+hUxM8sxsbQ9Py2kYU0cN
         yiMI7zKD/mP5c14pprXrpCiWIQ9yb2JdgxoAU1uxUbf65GcOfRHPN7IYNTmNMEgbTdce
         3+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GiDmkd6XuqThs4HFUR/z2IY+5TaIpRlZZuzKQVJMQSQ=;
        b=TAgCNOCd+HldsmpgoA7BDHd+oPE4LN+jrg6JGpzbT/9/q2VB1LY/twfuKqnv+w0hJd
         wGdcUADTA3GXs8CF0gHTxsvklJfCyKpb51gGNqccc0nO6CFYE7Nmyx45KWaCc4yDKSA1
         QCVXdTw25qhBgwgn6F/0hLZkynz5KfglNP0AQiuI9GEO+SefptgtpRjvBE6YPa23eCZQ
         GXIXvOCtk1Qy3XWEKmaMnBjuq59K0MeKXoTnTeIN/tgbI+OsvYWP0vt3X1jkYAb/NsTl
         G7THlqpvyrQHzYyRl8rRiXR2BPpqZd3ppOgUDeDCaiQcNIPdvWKNjN3Skpv8mO3CRAfz
         /3/Q==
X-Gm-Message-State: AOAM530CvnS++0czW2/cRpIWGiRDzn5ecT8j5CNoHIkPLjRPfCTrRnYt
        onZk8LMqCjNjslnbYb2wEiuo6g4ePnbK+l+f
X-Google-Smtp-Source: ABdhPJy9mynMQRqNpxS+jRVFv9yYAa3f3I1JGltk29Z+pcuQXfmF5wAaEK8KsCPIUxzrSCa7Yp2muQ==
X-Received: by 2002:a05:6870:6087:b0:e1:dc8b:56ba with SMTP id t7-20020a056870608700b000e1dc8b56bamr2180822oae.22.1651598869224;
        Tue, 03 May 2022 10:27:49 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a8-20020a4ad5c8000000b0035eb4e5a6c6sm5096138oot.28.2022.05.03.10.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 10:27:48 -0700 (PDT)
Date:   Tue, 3 May 2022 12:27:43 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, jonathan@marek.ca,
        tdas@codeaurora.org, anischal@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2 8/8] arm64: dts: qcom: sm8350: Add DISPCC node
Message-ID: <YnFmD8pEmPxpXex7@builder.lan>
References: <20220503130448.520470-1-robert.foss@linaro.org>
 <20220503130448.520470-8-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503130448.520470-8-robert.foss@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03 May 08:04 CDT 2022, Robert Foss wrote:

> Add the dispcc clock-controller DT node for sm8350.
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8350.dtsi | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index 52428b6df64e..94c2519e9f48 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -3,7 +3,9 @@
>   * Copyright (c) 2020, Linaro Limited
>   */
>  
> +#include <dt-bindings/interconnect/qcom,sm8350.h>

This looks unrelated.

Rest looks good.

Regards,
Bjorn

>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/qcom,dispcc-sm8350.h>
>  #include <dt-bindings/clock/qcom,gcc-sm8350.h>
>  #include <dt-bindings/clock/qcom,rpmh.h>
>  #include <dt-bindings/dma/qcom-gpi.h>
> @@ -2525,6 +2527,31 @@ usb_2_dwc3: usb@a800000 {
>  			};
>  		};
>  
> +		dispcc: clock-controller@af00000 {
> +			compatible = "qcom,sm8350-dispcc";
> +			reg = <0 0x0af00000 0 0x10000>;
> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>;
> +			clock-names = "bi_tcxo",
> +				      "dsi0_phy_pll_out_byteclk",
> +				      "dsi0_phy_pll_out_dsiclk",
> +				      "dsi1_phy_pll_out_byteclk",
> +				      "dsi1_phy_pll_out_dsiclk",
> +				      "dp_phy_pll_link_clk",
> +				      "dp_phy_pll_vco_div_clk";
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			#power-domain-cells = <1>;
> +
> +			power-domains = <&rpmhpd SM8350_MMCX>;
> +			power-domain-names = "mmcx";
> +		};
> +
>  		adsp: remoteproc@17300000 {
>  			compatible = "qcom,sm8350-adsp-pas";
>  			reg = <0 0x17300000 0 0x100>;
> -- 
> 2.34.1
> 

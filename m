Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3E0465179
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 16:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350892AbhLAP07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 10:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350877AbhLAP05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 10:26:57 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2F2C061748
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 07:23:36 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so35634720otg.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 07:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9+xNJVk8HaWXrz0AyxQ/3VS9PEvSB6w7UJMIbnaoCx4=;
        b=Xy1CH92TddcQ/sbu1yk2gMq8epXWc8xm0RAWuszpNYrw24WQ88tlk5ucl9YH+NB8Zm
         OCaisjnB/qvFJioEQ4114EyarXUUjC0NNLhJW53iFHiF6r9RcVmofXsYzgBCQYozxQSI
         khng6Y1I+pQ5d5bgHbkf7Tr2Vsks5QssTp7b3IwVbp971VzP1Hl3R69nx+2ZnBtVZmZW
         q7b2D8A/vsrU0JkTScW1A7iaVr7jtNnfMNDBAEmPG+lsTwN3N75ygAN3zhL8WmJCS622
         y57YIwX8T/i2LcNjSjJCWmRQIESkytKTxk2PuWYRveSfX+/1hb0GOVxCs7BNJx9Veq8y
         9EMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9+xNJVk8HaWXrz0AyxQ/3VS9PEvSB6w7UJMIbnaoCx4=;
        b=7Z7Zg/6YtYgfi9mKvIagjRsx7e3WEu6i7JltLz56p/F55VDx5YgBgT68OJ5lr9RBNu
         oaqKwgcxXGecM/RUJnbrcQ2TJ1x9mEJf1p2cCGvmZ8zW6SQSt0jLYyGfe0krBcmc/0ru
         SKZTo9Il0+ychkm2PNm91vuwij3ahFFKhjipchQFmYQrPyIvV9OHYPmeV1kVe8x8ycxt
         AE7tWFZpv3qqd6e/UaOTifus7pbE5cyHaWxUia2zwkDFVgg+Pnm396qdShratc8ZmpsP
         6tFpWddVyl7iFWwGwb2YFr7gbl2sdn3zFfpB/RjSvd3h4FUnoO4CLx0WzpjzxY0isjK1
         A0Mw==
X-Gm-Message-State: AOAM531qoVNAlOiIYcNbAazkP8w/09IKrxhOW0ZITjRnRYak3A3nNDzK
        eyoi0wTCrOVAnkKPxMaSBSBOCw==
X-Google-Smtp-Source: ABdhPJwroTxLQszV8WreruCOvQLv3di1HHM7v1yitiEuvrBNj3Ia6KwKOOw3SuNlqkZzq+8iWr5nJg==
X-Received: by 2002:a9d:373:: with SMTP id 106mr6293793otv.127.1638372215677;
        Wed, 01 Dec 2021 07:23:35 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id g1sm4449ooq.2.2021.12.01.07.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 07:23:35 -0800 (PST)
Date:   Wed, 1 Dec 2021 09:23:30 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org, robh+dt@kernel.org,
        Kuogee Hsieh <khsieh@codeaurora.org>, robdclark@gmail.com,
        seanpaul@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com, quic_abhinavk@quicinc.com,
        dianders@chromium.org, quic_khsieh@quicinc.com,
        quic_mkrishn@quicinc.com
Subject: Re: [PATCH v4 4/4] arm64: dts: qcom: sc7280: Add Display Port node
Message-ID: <YaeTckalY6BZJqdb@builder.lan>
References: <1637580555-1079-1-git-send-email-quic_sbillaka@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1637580555-1079-1-git-send-email-quic_sbillaka@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 22 Nov 05:29 CST 2021, Sankeerth Billakanti wrote:

> From: Kuogee Hsieh <khsieh@codeaurora.org>
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>

Can you please update this to make From: and Signed-off-by: match.


Also I don't know how you prepared this patch series, because this says
patch 4/4, but it's not part of the same series as the other patches.

I did pick up the first  3 patches, but then noticed that you are back
at using the original labels, so please see below and send all 4 patches
in a proper series.

> ---
> 
> Changes in v4:
>     - Add the patch to display DT change series (Bjorn Andersson)
>     - Remove the trailing whitespaces
> 
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 90 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 88 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 5ad500e..0b2ffd5 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -2693,8 +2693,8 @@
>  				 <&gcc GCC_DISP_GPLL0_CLK_SRC>,
>  				 <&dsi_phy 0>,
>  				 <&dsi_phy 1>,
> -				 <0>,
> -				 <0>,
> +				 <&dp_phy 0>,
> +				 <&dp_phy 1>,
>  				 <&edp_phy 0>,
>  				 <&edp_phy 1>;
>  			clock-names = "bi_tcxo",
> @@ -2791,6 +2791,13 @@
>  							remote-endpoint = <&edp_in>;
>  						};
>  					};
> +
> +					port@2 {
> +                                                reg = <2>;
> +                                                dpu_intf0_out: endpoint {
> +                                                        remote-endpoint = <&dp_in>;
> +                                                };
> +                                        };
>  				};
>  
>  				mdp_opp_table: opp-table {
> @@ -3002,6 +3009,79 @@
>  
>  				status = "disabled";
>  			};
> +
> +			msm_dp: displayport-controller@ae90000 {

As requested previously, can you please label this mdss_dp, to make it
sort nicely in the dts?

Thanks,
Bjorn

> +				compatible = "qcom,sc7280-dp";
> +
> +				reg = <0 0x0ae90000 0 0x1400>;
> +
> +				interrupt-parent = <&mdss>;
> +				interrupts = <12>;
> +
> +				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DP_AUX_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DP_LINK_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DP_LINK_INTF_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK>;
> +				clock-names =	"core_iface",
> +						"core_aux",
> +						"ctrl_link",
> +						"ctrl_link_iface",
> +						"stream_pixel";
> +				#clock-cells = <1>;
> +				assigned-clocks = <&dispcc DISP_CC_MDSS_DP_LINK_CLK_SRC>,
> +						  <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK_SRC>;
> +				assigned-clock-parents = <&dp_phy 0>, <&dp_phy 1>;
> +				phys = <&dp_phy>;
> +				phy-names = "dp";
> +
> +				operating-points-v2 = <&dp_opp_table>;
> +				power-domains = <&rpmhpd SC7280_CX>;
> +
> +				#sound-dai-cells = <0>;
> +
> +				status = "disabled";
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					port@0 {
> +						reg = <0>;
> +						dp_in: endpoint {
> +							remote-endpoint = <&dpu_intf0_out>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +						dp_out: endpoint { };
> +					};
> +				};
> +
> +				dp_opp_table: opp-table {
> +					compatible = "operating-points-v2";
> +
> +					opp-160000000 {
> +						opp-hz = /bits/ 64 <160000000>;
> +						required-opps = <&rpmhpd_opp_low_svs>;
> +					};
> +
> +					opp-270000000 {
> +						opp-hz = /bits/ 64 <270000000>;
> +						required-opps = <&rpmhpd_opp_svs>;
> +					};
> +
> +					opp-540000000 {
> +						opp-hz = /bits/ 64 <540000000>;
> +						required-opps = <&rpmhpd_opp_svs_l1>;
> +					};
> +
> +					opp-810000000 {
> +						opp-hz = /bits/ 64 <810000000>;
> +						required-opps = <&rpmhpd_opp_nom>;
> +					};
> +				};
> +			};
>  		};
>  
>  		pdc: interrupt-controller@b220000 {
> @@ -3104,6 +3184,12 @@
>  				bias-pull-up;
>  			};
>  
> +			dp_hot_plug_det: dp-hot-plug-det {
> +				pins = "gpio47";
> +				function = "dp_hot";
> +				bias-disable;
> +                        };
> +
>  			qspi_clk: qspi-clk {
>  				pins = "gpio14";
>  				function = "qspi_clk";
> -- 
> 2.7.4
> 

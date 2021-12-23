Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9078A47DE6F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 06:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhLWFFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 00:05:55 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40686 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhLWFFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 00:05:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 070ABB81E95;
        Thu, 23 Dec 2021 05:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C7FC36AE9;
        Thu, 23 Dec 2021 05:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640235950;
        bh=agQnUbtfJwOPtqzN1B0I5CnVnwhcfTy4lYFDUwaExz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sxDtlfMlAAzg5bHDijj0UlQQd+24Ss8y1SsP5TxK7Yx+Nb7naanEdu38eeH9OOXFN
         p4sxDtTveDDT4RakT7i4fHsH3xGlNEYydzUPZw3bFe87k1dgMCls1CLDgYfs3fykcV
         qqHb2GcUbKzg07JB5yfCQHGthapUsVNBALzOz0tfoKAMLkNaEIF/U73OpW0Y4m0qK3
         KwDhswVLdaOwjtyZ6dFXOjyRzf2/bs61WMD6SL2tsA7F4WleZaSxJTJSLRhJMMGlHh
         dhnCo/s7VC+4SpfhucEBWv4tV1ov8GPyQbinpDHCSk4i62qHtQPsWyq7PjNH+LTKPA
         fyXAEcAy2Zr1w==
Date:   Thu, 23 Dec 2021 10:35:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sm8350: Correct UFS symbol clocks
Message-ID: <YcQDqg7r6tWI+KcU@matsya>
References: <20211222162058.3418902-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222162058.3418902-1-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-12-21, 08:20, Bjorn Andersson wrote:
> The introduction of '9a61f813fcc8 ("clk: qcom: regmap-mux: fix parent
> clock lookup")' broke UFS support on SM8350.
> 
> The cause for this is that the symbol clocks have a specified rate in
> the "freq-table-hz" table in the UFS node, which causes the UFS code to
> request a rate change, for which the "bi_tcxo" happens to provide the
> closest rate.  Prior to the change in regmap-mux it was determined
> (incorrectly) that no change was needed and everything worked.
> 
> The rates of 75 and 300MHz matches the documentation for the symbol
> clocks, but we don't represent the parent clocks today. So let's mimic
> the configuration found in other platforms, by omitting the rate for the
> symbol clocks as well to avoid the rate change.
> 
> While at it also fill in the dummy symbol clocks that was dropped from
> the GCC driver as it was upstreamed.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

> 
> Fixes: 59c7cf814783 ("arm64: dts: qcom: sm8350: Add UFS nodes")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - Updated commit message to clarify that the removed numbers are correct.
> 
>  arch/arm64/boot/dts/qcom/sm8350.dtsi | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index bc176c252bca..ceb064a83038 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -38,6 +38,24 @@ sleep_clk: sleep-clk {
>  			clock-frequency = <32000>;
>  			#clock-cells = <0>;
>  		};
> +
> +		ufs_phy_rx_symbol_0_clk: ufs-phy-rx-symbol-0 {
> +			compatible = "fixed-clock";
> +			clock-frequency = <1000>;
> +			#clock-cells = <0>;
> +		};
> +
> +		ufs_phy_rx_symbol_1_clk: ufs-phy-rx-symbol-1 {
> +			compatible = "fixed-clock";
> +			clock-frequency = <1000>;
> +			#clock-cells = <0>;
> +		};
> +
> +		ufs_phy_tx_symbol_0_clk: ufs-phy-tx-symbol-0 {
> +			compatible = "fixed-clock";
> +			clock-frequency = <1000>;
> +			#clock-cells = <0>;
> +		};
>  	};
>  
>  	cpus {
> @@ -606,9 +624,9 @@ gcc: clock-controller@100000 {
>  				 <0>,
>  				 <0>,
>  				 <0>,
> -				 <0>,
> -				 <0>,
> -				 <0>,
> +				 <&ufs_phy_rx_symbol_0_clk>,
> +				 <&ufs_phy_rx_symbol_1_clk>,
> +				 <&ufs_phy_tx_symbol_0_clk>,
>  				 <0>,
>  				 <0>;
>  		};
> @@ -2079,8 +2097,8 @@ ufs_mem_hc: ufshc@1d84000 {
>  				<75000000 300000000>,
>  				<0 0>,
>  				<0 0>,
> -				<75000000 300000000>,
> -				<75000000 300000000>;
> +				<0 0>,
> +				<0 0>;
>  			status = "disabled";
>  		};
>  
> -- 
> 2.33.1

-- 
~Vinod

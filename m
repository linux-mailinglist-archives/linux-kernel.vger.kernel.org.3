Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE7647D01C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 11:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244216AbhLVKhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 05:37:12 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41872 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244207AbhLVKhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 05:37:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5592B81B75;
        Wed, 22 Dec 2021 10:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE02DC36AE8;
        Wed, 22 Dec 2021 10:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640169428;
        bh=9Dx47wNPtTPgpUOjJ2e9sf0H/NhesZjsttM9oBKJaOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C8hIg5+qyretpcioj+KiYbCgMH7LIIvyxfC8H07JMqsyuaUejymy16iUWLX0zGFtl
         toxFHKsVEiudsBwtSNZf9bBb8T0svcaDTLnCpSLVej8woAj01Mfq8thr5U6zViqMRR
         WBv4mzEVvir1Y0qEKCslxvzO1jO4tTYLG3Mmlqpn3WO4tj/OK4cx2m2XkSma7uaHHn
         3BYLAe1GSz/vzP5nrADZ+G1EgzW2loKHwGEhCwh1Dc70mElju2rO3AUvZEGfE/wKcw
         GJaNATHFxD4CPLnbxrvNB6nhcgmnnQrFqTITgU0phA3UN0XZJRrQcXOMOUPAGdKTHn
         tTHbXl7EA0DWQ==
Date:   Wed, 22 Dec 2021 16:07:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8350: Correct UFS symbol clocks
Message-ID: <YcL/0PUeAI6SJ86s@matsya>
References: <20211222002644.3396011-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222002644.3396011-1-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-12-21, 16:26, Bjorn Andersson wrote:
> The introduction of '9a61f813fcc8 ("clk: qcom: regmap-mux: fix parent
> clock lookup")' broke UFS support on SM8350.
> 
> The cause for this is that the symbol clocks have a specified rate in
> the "freq-table-hz" table in the UFS node, which causes the UFS code to
> request a rate change, for which the "bi_tcxo" happens to provide the
> closest rate.  Prior to the change in regmap-mux it was determined
> (incorrectly) that no change was needed and everything worked. Instead
> mimic the configuration found in other platforms, by omitting the rate
> for the symbol clocks as well to avoid the rate change.
> 
> While at it also fill in the dummy symbol clocks that was dropped from
> the GCC driver as it was upstreamed.
> 
> Fixes: 59c7cf814783 ("arm64: dts: qcom: sm8350: Add UFS nodes")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
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

should the rate be zero here?

-- 
~Vinod

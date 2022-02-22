Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8654C02C0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 21:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbiBVUCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 15:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbiBVUCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 15:02:12 -0500
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C0DC55BC;
        Tue, 22 Feb 2022 12:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
        s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=RAjZhwN+MZdnp4/RC9NZ6Pdsw6fvCTm9U8G9JOs4k1Q=; b=NC5SuUqonceRs3gFYjjT8+rutl
        iWurGT3uN4Y/BLTpf1+iiO7uQ95YuRtFaCNo1ofojsO6jFM2hAXvGRCZBcVG67g6EBz9o42kiIT1w
        DL+hlSERE09Cb9DAGg37nXqVlYnvp7iOof1p0zUz/nTw5Dbl+myNzP59bT0bLA7mW54u8J4fa+4nC
        A0WVVbs1JCi3ETmUTG0hT4LjWNwqbix+M/toXv/GjsKl5hA7f3+QlzwtJZHqaD3oqK9ggOngGQuw4
        B0D5ZGGsZwxl+mcCu4Wj296fRd2hn4cf+aAqjxDdGRJXpp2BI+7MeAuJlw+2zC1rF5pQEV7qFX5Xk
        FlhDuV7Q==;
Received: from noodles by the.earth.li with local (Exim 4.94.2)
        (envelope-from <noodles@earth.li>)
        id 1nMbLx-00CQsd-GG; Tue, 22 Feb 2022 20:01:41 +0000
Date:   Tue, 22 Feb 2022 20:01:41 +0000
From:   Jonathan McDowell <noodles@earth.li>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/18] ARM: dts: qcom: add saw for l2 cache and
 kraitcc for ipq8064
Message-ID: <YhVBJaPR7a/E9n1B@earth.li>
References: <20220218002956.6590-1-ansuelsmth@gmail.com>
 <20220218002956.6590-11-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218002956.6590-11-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 01:29:48AM +0100, Ansuel Smith wrote:
> Add saw compatible for l2 cache and kraitcc node for ipq8064 dtsi.
> Also declare clock-output-names for acc0 and acc1 and qsb fixed clock
> for the secondary mux.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  arch/arm/boot/dts/qcom-ipq8064.dtsi | 34 +++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> index c579fb09e768..7df1c1482220 100644
> --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> @@ -298,6 +298,12 @@ smem: smem@41000000 {
>  	};
>  
>  	clocks {
> +		qsb: qsb {
> +			compatible = "fixed-clock";
> +			clock-frequency = <384000000>;
> +			#clock-cells = <0>;
> +		};
> +
>  		cxo_board {
>  			compatible = "fixed-clock";
>  			#clock-cells = <0>;
> @@ -504,11 +510,19 @@ IRQ_TYPE_EDGE_RISING)>,
>  		acc0: clock-controller@2088000 {
>  			compatible = "qcom,kpss-acc-v1";
>  			reg = <0x02088000 0x1000>, <0x02008000 0x1000>;
> +			clock-output-names = "acpu0_aux";
> +			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;

You need to add the pxo_board: label to the clock above or we get:

arch/arm/boot/dts/qcom-ipq8064.dtsi:645.34-652.5: ERROR (phandle_references): /soc/clock-controller@2088000: Reference to non-existent node or label "pxo_board"

arch/arm/boot/dts/qcom-ipq8064.dtsi:654.34-661.5: ERROR (phandle_references): /soc/clock-controller@2098000: Reference to non-existent node or label "pxo_board"

> +			clock-names = "pll8_vote", "pxo";
> +			#clock-cells = <0>;
>  		};
>  
>  		acc1: clock-controller@2098000 {
>  			compatible = "qcom,kpss-acc-v1";
>  			reg = <0x02098000 0x1000>, <0x02008000 0x1000>;
> +			clock-output-names = "acpu1_aux";
> +			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
> +			clock-names = "pll8_vote", "pxo";
> +			#clock-cells = <0>;
>  		};
>  
>  		adm_dma: dma-controller@18300000 {
> @@ -532,17 +546,23 @@ adm_dma: dma-controller@18300000 {
>  		};
>  
>  		saw0: regulator@2089000 {
> -			compatible = "qcom,saw2";
> +			compatible = "qcom,saw2", "qcom,apq8064-saw2-v1.1-cpu", "syscon";
>  			reg = <0x02089000 0x1000>, <0x02009000 0x1000>;
>  			regulator;
>  		};
>  
>  		saw1: regulator@2099000 {
> -			compatible = "qcom,saw2";
> +			compatible = "qcom,saw2", "qcom,apq8064-saw2-v1.1-cpu", "syscon";
>  			reg = <0x02099000 0x1000>, <0x02009000 0x1000>;
>  			regulator;
>  		};
>  
> +		saw_l2: regulator@02012000 {
> +			compatible = "qcom,saw2", "syscon";
> +			reg = <0x02012000 0x1000>;
> +			regulator;
> +		};
> +
>  		gsbi2: gsbi@12480000 {
>  			compatible = "qcom,gsbi-v1.0.0";
>  			cell-index = <2>;
> @@ -899,6 +919,16 @@ l2cc: clock-controller@2011000 {
>  			clock-output-names = "acpu_l2_aux";
>  		};
>  
> +		kraitcc: clock-controller {
> +			compatible = "qcom,krait-cc-v1";
> +			clocks = <&gcc PLL9>, <&gcc PLL10>, <&gcc PLL12>,
> +				 <&acc0>, <&acc1>, <&l2cc>, <&qsb>;
> +			clock-names = "hfpll0", "hfpll1", "hfpll_l2",
> +				      "acpu0_aux", "acpu1_aux", "acpu_l2_aux",
> +				      "qsb";
> +			#clock-cells = <1>;
> +		};
> +
>  		lcc: clock-controller@28000000 {
>  			compatible = "qcom,lcc-ipq8064";
>  			reg = <0x28000000 0x1000>;
> -- 
> 2.34.1
> 

J.

-- 
      Hats off to the insane.      |  .''`.  Debian GNU/Linux Developer
                                   | : :' :  Happy to accept PGP signed
                                   | `. `'   or encrypted mail - RSA
                                   |   `-    key on the keyservers.

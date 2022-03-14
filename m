Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025F54D7F5D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 11:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238041AbiCNKDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 06:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbiCNKDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 06:03:41 -0400
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1D537ABD;
        Mon, 14 Mar 2022 03:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
        s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=GMRm70IRJ3DPdDAQd7rMaNIYMjmW5VYnvTf7K/KQIYQ=; b=U5N1VFVDe80FOaeIDdd17u8TFT
        MhyUOzbd8/jOQ76yrdHMZk9XbAYGKQXhILyC0h7sfwj1eqbRoHSU9Je8Dc4Ld39qMBXddZ2yxnGpw
        XmiV9Pn5phcS5tGHViuUc+FbhR4ub7adiw0/cipImjzl6mFqgLr/C5H8+03XtSmJF0XkeiOBwdZHE
        wBNuuDvPdtcWoVMyEC0sGLrR7eiGePzNjOv+GAk/gl9rndycSHuSHNBcsmrOeiuepa/nofsMwrUvj
        xPxvqIJM595r7AKn0qEPmAFRd5hTlR+WV6g6ebRXHZznDN0GX1Zy5Rw3/BRBuQTlsDIAowawVHbAV
        yNrONV0g==;
Received: from noodles by the.earth.li with local (Exim 4.94.2)
        (envelope-from <noodles@earth.li>)
        id 1nThWv-009O7y-JT; Mon, 14 Mar 2022 10:02:21 +0000
Date:   Mon, 14 Mar 2022 10:02:21 +0000
From:   Jonathan McDowell <noodles@earth.li>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 15/15] ARM: dts: qcom: add syscon and cxo/pxo clock to
 gcc node for ipq8064
Message-ID: <Yi8SrZkjYdU3W8aj@earth.li>
References: <20220226135235.10051-1-ansuelsmth@gmail.com>
 <20220226135235.10051-16-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220226135235.10051-16-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AFAICT the rest of the series has been picked up in clk-for-5.18, but I
don't see this there or in dts-for-5.18. It's required for a
functioning tsens driver on IPQ8064 so it would be nice to see it landed.

On Sat, Feb 26, 2022 at 02:52:35PM +0100, Ansuel Smith wrote:
> Add syscon compatible required for tsens driver to correctly probe driver
> and access the reg. Also add cxo and pxo tag and declare them as gcc clock
> now requires them for the ipq8064 gcc driver that has now been modernized.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  arch/arm/boot/dts/qcom-ipq8064.dtsi | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> index 11481313bdb6..5524a68cf3d1 100644
> --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> @@ -298,13 +298,13 @@ smem: smem@41000000 {
>  	};
>  
>  	clocks {
> -		cxo_board {
> +		cxo_board: cxo_board {
>  			compatible = "fixed-clock";
>  			#clock-cells = <0>;
>  			clock-frequency = <25000000>;
>  		};
>  
> -		pxo_board {
> +		pxo_board: pxo_board {
>  			compatible = "fixed-clock";
>  			#clock-cells = <0>;
>  			clock-frequency = <25000000>;
> @@ -736,7 +736,9 @@ tsens_calib_backup: calib_backup@410 {
>  		};
>  
>  		gcc: clock-controller@900000 {
> -			compatible = "qcom,gcc-ipq8064";
> +			compatible = "qcom,gcc-ipq8064", "syscon";
> +			clocks = <&pxo_board>, <&cxo_board>;
> +			clock-names = "pxo", "cxo";
>  			reg = <0x00900000 0x4000>;
>  			#clock-cells = <1>;
>  			#reset-cells = <1>;
> -- 
> 2.34.1
> 

J.

-- 
    I program, therefore I am.     |  .''`.  Debian GNU/Linux Developer
                                   | : :' :  Happy to accept PGP signed
                                   | `. `'   or encrypted mail - RSA
                                   |   `-    key on the keyservers.

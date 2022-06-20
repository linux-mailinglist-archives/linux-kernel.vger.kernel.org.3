Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86405512C5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238771AbiFTIat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbiFTIap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:30:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A7B120B2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:30:44 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1o3Cnr-0003dz-2w; Mon, 20 Jun 2022 10:30:35 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1o3Cnq-0002if-Ek; Mon, 20 Jun 2022 10:30:34 +0200
Date:   Mon, 20 Jun 2022 10:30:34 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shengjiu.wang@gmail.com
Subject: Re: [PATCH v2 1/3] arm64: dts: imx8mm-evk: add bt-sco sound card
 support
Message-ID: <20220620083034.hy5qtfpl3hdr5van@pengutronix.de>
References: <1655691813-19878-1-git-send-email-shengjiu.wang@nxp.com>
 <1655691813-19878-2-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655691813-19878-2-git-send-email-shengjiu.wang@nxp.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shengjiu,

On 22-06-20, Shengjiu Wang wrote:
> Add bt-sco sound card, which supports wb profile as default
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> index c42b966f7a64..cf734d2a94be 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> @@ -75,6 +75,11 @@
>  		linux,autosuspend-period = <125>;
>  	};
>  
> +	audio_codec_bt_sco: audio-codec-bt-sco {
> +		#sound-dai-cells = <1>;
> +		compatible = "linux,bt-sco";

The compatible property should always be the first property. This
apply to your other patches as well.

Regards,
  Marco

> +	};
> +
>  	wm8524: audio-codec {
>  		#sound-dai-cells = <0>;
>  		compatible = "wlf,wm8524";
> @@ -107,6 +112,25 @@
>  			clocks = <&clk IMX8MM_CLK_SAI3_ROOT>;
>  		};
>  	};
> +
> +	sound-bt-sco {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "bt-sco-audio";
> +		simple-audio-card,format = "dsp_a";
> +		simple-audio-card,bitclock-inversion;
> +		simple-audio-card,frame-master = <&btcpu>;
> +		simple-audio-card,bitclock-master = <&btcpu>;
> +
> +		btcpu: simple-audio-card,cpu {
> +			sound-dai = <&sai2>;
> +			dai-tdm-slot-num = <2>;
> +			dai-tdm-slot-width = <16>;
> +		};
> +
> +		simple-audio-card,codec {
> +			sound-dai = <&audio_codec_bt_sco 1>;
> +		};
> +	};
>  };
>  
>  &A53_0 {
> @@ -346,6 +370,16 @@
>  	status = "okay";
>  };
>  
> +&sai2 {
> +	#sound-dai-cells = <0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai2>;
> +	assigned-clocks = <&clk IMX8MM_CLK_SAI2>;
> +	assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
> +	assigned-clock-rates = <24576000>;
> +	status = "okay";
> +};
> +
>  &sai3 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_sai3>;
> @@ -494,6 +528,15 @@
>  		>;
>  	};
>  
> +	pinctrl_sai2: sai2grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SAI2_TXC_SAI2_TX_BCLK      0xd6
> +			MX8MM_IOMUXC_SAI2_TXFS_SAI2_TX_SYNC     0xd6
> +			MX8MM_IOMUXC_SAI2_TXD0_SAI2_TX_DATA0    0xd6
> +			MX8MM_IOMUXC_SAI2_RXD0_SAI2_RX_DATA0    0xd6
> +		>;
> +	};
> +
>  	pinctrl_sai3: sai3grp {
>  		fsl,pins = <
>  			MX8MM_IOMUXC_SAI3_TXFS_SAI3_TX_SYNC     0xd6
> -- 
> 2.17.1
> 
> 
> 

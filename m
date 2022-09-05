Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AB25AC877
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 03:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbiIEBRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 21:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiIEBRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 21:17:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670B01EAF5;
        Sun,  4 Sep 2022 18:17:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0351560F3C;
        Mon,  5 Sep 2022 01:17:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8346C433D6;
        Mon,  5 Sep 2022 01:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662340628;
        bh=i6YebanYdcVUYEtFkj/RLupCZbN05OptRzFY1/Cjs28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bdu5Vc8IEC3GpwPCtIDJXubDt76+2fOIU9UUTnK7QjBd0XyiHS4DUA2gbWdddkPSP
         G9jFIkohfycQOonR6ce5uj82LlZirajPgJ7e9yiFZvFMbCDu3Hk9+72uuQ7IkK9OiI
         8FuY7njhEkLZiTj1q/CfOwW1WISNJIzt+0Vk0+hZdkxodYZ3GtKObNdg1v3Brje7E8
         w9OTzueSmGqcMPF7kXHcyfXj59zQnAOzl4j1umD9gBPZyBuJDTndxdy6mYCde9tph4
         0ymCrtvUKnz6maT1OQ88CmIWOok3HLNkvx0L34f1cPQj6jhobCtBgMCl6IRGT8mvEq
         lhuXN2aK+gl3A==
Date:   Mon, 5 Sep 2022 09:17:02 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Camelia Groza <camelia.groza@nxp.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>
Subject: Re: [PATCH 8/9] arm64: dts: ls1046a-qds: add mmio based mdio-mux
 support
Message-ID: <20220905011702.GT1728671@dragon>
References: <20220824231200.494-1-leoyang.li@nxp.com>
 <20220824231200.494-9-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824231200.494-9-leoyang.li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 06:11:59PM -0500, Li Yang wrote:
> There is mmio based mdio mux function in the FPGA device on ls1046a-qds
> board.  Add the mmio based mdio-mux nodes to ls1046a-qds boards and
> add simple-mfd as a compatbile for the FPGA node to reflect the
> multi-function nature of it.
> 
> Signed-off-by: Camelia Groza <camelia.groza@nxp.com>
> Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  .../boot/dts/freescale/fsl-ls1046a-qds.dts    | 156 +++++++++++++++++-
>  1 file changed, 154 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
> index eec62c63dafe..eb74ed6419b6 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
> @@ -3,7 +3,7 @@
>   * Device Tree Include file for Freescale Layerscape-1046A family SoC.
>   *
>   * Copyright 2016 Freescale Semiconductor, Inc.
> - * Copyright 2018 NXP
> + * Copyright 2018-2021 NXP
>   *
>   * Shaohui Xie <Shaohui.Xie@nxp.com>
>   */
> @@ -25,6 +25,20 @@ aliases {
>  		serial1 = &duart1;
>  		serial2 = &duart2;
>  		serial3 = &duart3;
> +

Unnecessary newline.

> +		emi1-slot1 = &ls1046mdio_s1;
> +		emi1-slot2 = &ls1046mdio_s2;
> +		emi1-slot4 = &ls1046mdio_s4;

Keep the list alphabetically sorted?

> +
> +		sgmii-s1-p1 = &sgmii_phy_s1_p1;
> +		sgmii-s1-p2 = &sgmii_phy_s1_p2;
> +		sgmii-s1-p3 = &sgmii_phy_s1_p3;
> +		sgmii-s1-p4 = &sgmii_phy_s1_p4;
> +		sgmii-s4-p1 = &sgmii_phy_s4_p1;
> +		qsgmii-s2-p1 = &qsgmii_phy_s2_p1;
> +		qsgmii-s2-p2 = &qsgmii_phy_s2_p2;
> +		qsgmii-s2-p3 = &qsgmii_phy_s2_p3;
> +		qsgmii-s2-p4 = &qsgmii_phy_s2_p4;
>  	};
>  
>  	chosen {
> @@ -153,8 +167,9 @@ nand@1,0 {
>  	};
>  
>  	fpga: board-control@2,0 {
> -		compatible = "fsl,ls1046aqds-fpga", "fsl,fpga-qixis";
> +		compatible = "fsl,ls1046aqds-fpga", "fsl,fpga-qixis", "simple-mfd";
>  		reg = <0x2 0x0 0x0000100>;
> +		ranges = <0 2 0 0x100>;
>  	};
>  };
>  
> @@ -177,3 +192,140 @@ qflash0: flash@0 {
>  };
>  
>  #include "fsl-ls1046-post.dtsi"
> +
> +&fman0 {
> +	ethernet@e0000 {
> +		phy-handle = <&qsgmii_phy_s2_p1>;
> +		phy-connection-type = "sgmii";
> +	};
> +
> +	ethernet@e2000 {
> +		phy-handle = <&sgmii_phy_s4_p1>;
> +		phy-connection-type = "sgmii";
> +	};
> +
> +	ethernet@e4000 {
> +		phy-handle = <&rgmii_phy1>;
> +		phy-connection-type = "rgmii";
> +	};
> +
> +	ethernet@e6000 {
> +		phy-handle = <&rgmii_phy2>;
> +		phy-connection-type = "rgmii";
> +	};
> +
> +	ethernet@e8000 {
> +		phy-handle = <&sgmii_phy_s1_p3>;
> +		phy-connection-type = "sgmii";
> +	};
> +
> +	ethernet@ea000 {
> +		phy-handle = <&sgmii_phy_s1_p4>;
> +		phy-connection-type = "sgmii";
> +	};
> +
> +	ethernet@f0000 { /* DTSEC9/10GEC1 */
> +		phy-handle = <&sgmii_phy_s1_p1>;
> +		phy-connection-type = "xgmii";
> +	};
> +
> +	ethernet@f2000 { /* DTSEC10/10GEC2 */
> +		phy-handle = <&sgmii_phy_s1_p2>;
> +		phy-connection-type = "xgmii";
> +	};
> +};
> +
> +&fpga {
> +	#address-cells = <1>;
> +	#size-cells = <1>;

Have a newline between properties and child node.

Shawn

> +	mdio-mux-emi1@54 {
> +		compatible = "mdio-mux-mmioreg", "mdio-mux";
> +		mdio-parent-bus = <&mdio0>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x54 1>;    /* BRDCFG4 */
> +		mux-mask = <0xe0>; /* EMI1 */
> +
> +		/* On-board RGMII1 PHY */
> +		ls1046mdio0: mdio@0 {
> +			reg = <0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			rgmii_phy1: ethernet-phy@1 { /* MAC3 */
> +				reg = <0x1>;
> +			};
> +		};
> +
> +		/* On-board RGMII2 PHY */
> +		ls1046mdio1: mdio@20 {
> +			reg = <0x20>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			rgmii_phy2: ethernet-phy@2 { /* MAC4 */
> +				reg = <0x2>;
> +			};
> +		};
> +
> +		/* Slot 1 */
> +		ls1046mdio_s1: mdio@40 {
> +			reg = <0x40>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +
> +			sgmii_phy_s1_p1: ethernet-phy@1c {
> +				reg = <0x1c>;
> +			};
> +
> +			sgmii_phy_s1_p2: ethernet-phy@1d {
> +				reg = <0x1d>;
> +			};
> +
> +			sgmii_phy_s1_p3: ethernet-phy@1e {
> +				reg = <0x1e>;
> +			};
> +
> +			sgmii_phy_s1_p4: ethernet-phy@1f {
> +				reg = <0x1f>;
> +			};
> +		};
> +
> +		/* Slot 2 */
> +		ls1046mdio_s2: mdio@60 {
> +			reg = <0x60>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +
> +			qsgmii_phy_s2_p1: ethernet-phy@8 {
> +				reg = <0x8>;
> +			};
> +
> +			qsgmii_phy_s2_p2: ethernet-phy@9 {
> +				reg = <0x9>;
> +			};
> +
> +			qsgmii_phy_s2_p3: ethernet-phy@a {
> +				reg = <0xa>;
> +			};
> +
> +			qsgmii_phy_s2_p4: ethernet-phy@b {
> +				reg = <0xb>;
> +			};
> +		};
> +
> +		/* Slot 4 */
> +		ls1046mdio_s4: mdio@80 {
> +			reg = <0x80>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +
> +			sgmii_phy_s4_p1: ethernet-phy@1c {
> +				reg = <0x1c>;
> +			};
> +		};
> +	};
> +};
> -- 
> 2.37.1
> 

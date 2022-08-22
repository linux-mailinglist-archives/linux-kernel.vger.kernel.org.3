Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FAB59B81A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 05:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbiHVDoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 23:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiHVDox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 23:44:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A851E3CB;
        Sun, 21 Aug 2022 20:44:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7267A60F3E;
        Mon, 22 Aug 2022 03:44:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB231C433D6;
        Mon, 22 Aug 2022 03:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661139891;
        bh=7EoGd1aThgWPqn9T0rRcgrDBnqKbihivwVbw+DiehrM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UT/jTvzwjUva377P7aqi7MT/p0QWAc2ad24GVYTt3HO1rZta+efNtN4vImifxSW1h
         8T4M6iTHl1u1tGBzlORnLbDw8uuZYP8u1uiMFLDxKkp0sC+FDZOTsCgVyD1rr88Sf7
         EWLp3b2Wxhhk1cEr2MnYaODY1bfppT9vkTnWDMLjHKKOEUjJ/AJb5rsRXxn2vxf/22
         TlluLpfz37ZZmS0mkWpO6f2+FNX13cTQAli13YXi13e9XAr0dXZ7pQT5eMmxseXVSE
         cUiEyo7kipFIQl/mN2coiD87dyE9aLH+DetCW6C32YpVk4HeG19MezB7D+cCquV3oj
         tgcrmOo4745sA==
Date:   Mon, 22 Aug 2022 11:44:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] arm64: dts: ls2080a-qds: add mdio mux nodes from
 on-board FPGA
Message-ID: <20220822034446.GS149610@dragon>
References: <20220817204357.21753-1-leoyang.li@nxp.com>
 <20220817204357.21753-2-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817204357.21753-2-leoyang.li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 03:43:52PM -0500, Li Yang wrote:
> Add mmio mdio mux nodes from the on-board FPGA.
> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  .../boot/dts/freescale/fsl-ls2080a-qds.dts    | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts
> index f6c3ee78ace0..ef79c9a78f89 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts
> @@ -23,3 +23,72 @@ chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
>  };
> +
> +/* Update DPMAC connections to external PHYs, under SerDes 0x2a_0x49. */
> +&dpmac9 {
> +	phy-handle = <&mdio0_phy12>;
> +	phy-connection-type = "sgmii";
> +};
> +
> +&dpmac10 {
> +	phy-handle = <&mdio0_phy13>;
> +	phy-connection-type = "sgmii";
> +};
> +
> +&dpmac11 {
> +	phy-handle = <&mdio0_phy14>;
> +	phy-connection-type = "sgmii";
> +};
> +
> +&dpmac12 {
> +	phy-handle = <&mdio0_phy15>;
> +	phy-connection-type = "sgmii";
> +};
> +
> +&ifc {
> +	boardctrl: board-control@3,0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "fsl,tetra-fpga", "fsl,fpga-qixis", "simple-mfd";
> +		reg = <3 0 0x300>;
> +		ranges = <0 3 0 0x300>;
> +
> +		mdio-mux-emi1@54 {
> +			compatible = "mdio-mux-mmioreg", "mdio-mux";
> +			mdio-parent-bus = <&emdio1>;
> +			reg = <0x54 1>;		/* BRDCFG4 */
> +			mux-mask = <0xe0>;	/* EMI1_MDIO */
> +

Unnecessary newline.

> +			#address-cells=<1>;
> +			#size-cells = <0>;
> +
> +			/* Child MDIO buses, one for each riser card:
> +			 * reg = 0x0, 0x20, 0x40, 0x60, 0x80, 0xa0.
> +			 * VSC8234 PHYs on the riser cards.
> +			 */
> +
> +			mdio_mux3: mdio@60 {
> +				reg = <0x60>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				mdio0_phy12: mdio_phy0@1c {

Hyphen is recommended in node name.

Shawn

> +					reg = <0x1c>;
> +				};
> +
> +				mdio0_phy13: mdio_phy1@1d {
> +					reg = <0x1d>;
> +				};
> +
> +				mdio0_phy14: mdio_phy2@1e {
> +					reg = <0x1e>;
> +				};
> +
> +				mdio0_phy15: mdio_phy3@1f {
> +					reg = <0x1f>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> -- 
> 2.37.1
> 

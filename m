Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C4B4FAB4B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 03:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbiDJBMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 21:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbiDJBMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 21:12:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89A313D26;
        Sat,  9 Apr 2022 18:10:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FC7260DF5;
        Sun, 10 Apr 2022 01:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87877C385A0;
        Sun, 10 Apr 2022 01:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649553028;
        bh=Z/tB8bGdmjpVmeRIP8sMA1pejWdPqmHeBhXIGj4yzYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TL0xNjwIZ21uqdRMy1dk9YwQ7+cgGccIyBHB7AH2RPPdVxM606wNPd4nImAe+QO0K
         bOzBwMXP7j/WDw7bTdmVnaiEXlJSfZs7SAM7NERp4dCHz1i9XtcC/O5otJvByFEEmj
         Po20k7R2gwrsLZLnCgLpcJRQk7AmN9sjPADqwrws3IPN4QBz75R4c7w+g8oxkU2nVF
         uCZ/SE9jM7ROhnNNfVi0ksc4MD5s67ukPR9a6fXplI9TCTW9MePOt7V9KKiF7fFDns
         5Yvmff+2bTZ0DGogT4jugFQYsnwbX8Oa/7O6P1ztbSpAZgcJbWYggLg5/9AkJ7ZuJI
         7z+Zag8d1h85Q==
Date:   Sun, 10 Apr 2022 09:10:23 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] arm64: dts: ls2080a-qds: add mdio mux nodes from
 on-board FPGA
Message-ID: <20220410011023.GG129381@dragon>
References: <20220317190109.3742-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317190109.3742-1-leoyang.li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 02:01:04PM -0500, Li Yang wrote:
> Add mmio mdio mux nodes from the on-board FPGA.
> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  .../boot/dts/freescale/fsl-ls2080a-qds.dts    | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts
> index f6c3ee78ace0..c3caca1c0ab6 100644
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
> +		mdio_mux_emi1 {
> +			compatible = "mdio-mux-mmioreg", "mdio-mux";
> +			mdio-parent-bus = <&emdio1>;
> +			reg = <0x54 1>;		/* BRDCFG4 */

Please ensure the patch doesn't introduce additional DTC warnings.  I
think 'reg' should present only in nodes with a matching unit-address.

Shawn

> +			mux-mask = <0xe0>;	/* EMI1_MDIO */
> +
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
> 2.25.1
> 

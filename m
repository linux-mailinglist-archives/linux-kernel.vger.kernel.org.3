Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B15949076A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 12:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbiAQLwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 06:52:06 -0500
Received: from gloria.sntech.de ([185.11.138.130]:59718 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233818AbiAQLwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 06:52:05 -0500
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1n9QYI-0007Kl-RZ; Mon, 17 Jan 2022 12:51:58 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org,
        Johan Jonker <jbx6244@gmail.com>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] dts64: rk3568: drop pclk_xpcs from gmac0
Date:   Mon, 17 Jan 2022 12:51:57 +0100
Message-ID: <7013096.8LbZJEEdqx@diego>
In-Reply-To: <8285bea7-559c-5834-78c7-5a062b7d8269@gmail.com>
References: <20220116124911.65203-1-linux@fw-web.de> <20220116124911.65203-2-linux@fw-web.de> <8285bea7-559c-5834-78c7-5a062b7d8269@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 17. Januar 2022, 11:47:16 CET schrieb Johan Jonker:
> Hi Frank,
> 
> Despite that the DT is hosted in the kernel tree
> DT and mainline kernel driver support are 2 separate things.
> PCLK_XPCS might be in use elsewhere.

I've just looked through the rk3568 TRM and I guess the
pclk_xpcs belongs to the QSGMII_PCS block living at
the 0xfda00000 address in the memory map.

From glancing at the documentation that PCS thingy
can sit in between the dmac and the phy to "optimize" things
like power consumption.

Looking at the PIPE_GRF_XPCS_CON0, we can see that
bit1 decides which mac is to be selected to use the sgmii
interface to that PCS block.

As the QSGMII_PCS block should have its own driver
due to also its own config registers (see above), the pclk_xpcs
also will belong to it and should be modeled there.

Also I guess boards currently in production will use
regular gmii network interfaces?



> Given the link below pclk_xpcs is only needed for rk3568.
> Maybe gmac1 should have a PCLK_XPCS too, because one can select between
> them.
> 
> ethernet: stmicro: stmmac: Add SGMII/QSGMII support for RK3568
> https://github.com/rockchip-linux/kernel/commit/1fc7cbfe9e227c700c692f1de3137914b3ea6ca6
> 
> The original dtsi did have PCLK_XPCS in both nodes.
> https://github.com/rockchip-linux/kernel/blob/develop-4.19/arch/arm64/boot/dts/rockchip/rk3568.dtsi#L2121
> https://github.com/rockchip-linux/kernel/blob/develop-4.19/arch/arm64/boot/dts/rockchip/rk3568.dtsi#L1492
> 
> Maybe fix the document or leave it as it is for now as long the driver
> isn't updated and someone has tested it.
> That's up to the DT maintainer.
> 
> Johan
> 
> ===
> 
> XPCS is also part of PD_PIPE.
> See Rockchip RK3568 TRM Part1 V1.0-20210111.pdf page 475.
> Please advise if the power-domain@RK3568_PD_PIPE does need a PCLK_XPCS
> fix or is PCLK_PIPE enough in combination with a PHY driver?
> 
> PD_PIPE:
> 
> BIU_PIPE
> USB3OTG
> PCIE20
> PCIE30
> SATA
> XPCS
> 
> 
> 	power-domain@RK3568_PD_PIPE {
> 		reg = <RK3568_PD_PIPE>;
> 		clocks = <&cru PCLK_PIPE>;
> 		pm_qos = <&qos_pcie2x1>,
> 			 <&qos_pcie3x1>,
> 			 <&qos_pcie3x2>,
> 			 <&qos_sata0>,
> 			 <&qos_sata1>,
> 			 <&qos_sata2>,
> 			 <&qos_usb3_0>,
> 			 <&qos_usb3_1>;
> 		#power-domain-cells = <0>;
> 	};
> 
> 
> 
> On 1/16/22 1:49 PM, Frank Wunderlich wrote:
> > From: Frank Wunderlich <frank-w@public-files.de>
> > 
> > pclk_xpcs is not supported and breaks dtbs_check, so remove it
> > 
> > following warnings occour, and many more
> > 
> > rk3568-evb1-v10.dt.yaml: ethernet@fe2a0000: clocks:
> >     [[15, 386], [15, 389], [15, 389], [15, 184], [15, 180], [15, 181],
> >     [15, 389], [15, 185], [15, 172]] is too long
> > 	From schema: Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > rk3568-evb1-v10.dt.yaml: ethernet@fe2a0000: clock-names:
> >     ['stmmaceth', 'mac_clk_rx', 'mac_clk_tx', 'clk_mac_refout', 'aclk_mac',
> >     'pclk_mac', 'clk_mac_speed', 'ptp_ref', 'pclk_xpcs'] is too long
> > 	From schema: Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > 
> > after removing the clock the other warnings are also gone.
> > 
> > Co-developed-by: Peter Geis <pgwipeout@gmail.com>
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3568.dtsi | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> > index 2fd313a295f8..d91df1cde736 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> > @@ -32,13 +32,11 @@ gmac0: ethernet@fe2a0000 {
> >  		clocks = <&cru SCLK_GMAC0>, <&cru SCLK_GMAC0_RX_TX>,
> >  			 <&cru SCLK_GMAC0_RX_TX>, <&cru CLK_MAC0_REFOUT>,
> >  			 <&cru ACLK_GMAC0>, <&cru PCLK_GMAC0>,
> > -			 <&cru SCLK_GMAC0_RX_TX>, <&cru CLK_GMAC0_PTP_REF>,
> > -			 <&cru PCLK_XPCS>;
> > +			 <&cru SCLK_GMAC0_RX_TX>, <&cru CLK_GMAC0_PTP_REF>;
> >  		clock-names = "stmmaceth", "mac_clk_rx",
> >  			      "mac_clk_tx", "clk_mac_refout",
> >  			      "aclk_mac", "pclk_mac",
> > -			      "clk_mac_speed", "ptp_ref",
> > -			      "pclk_xpcs";
> > +			      "clk_mac_speed", "ptp_ref";
> >  		resets = <&cru SRST_A_GMAC0>;
> >  		reset-names = "stmmaceth";
> >  		rockchip,grf = <&grf>;
> > 
> 





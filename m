Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B615E550959
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 10:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbiFSI0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 04:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbiFSI0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 04:26:23 -0400
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4A4EE04;
        Sun, 19 Jun 2022 01:26:21 -0700 (PDT)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout3.routing.net (Postfix) with ESMTP id 07C4B6005D;
        Sun, 19 Jun 2022 08:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1655627180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MObysxFrMSSxxojyXx/k2lns89uVHtCedLLQwnNeQzw=;
        b=dSslP97cX409h15pUItAk2gtWxJ3HIRkXdJiK+TQr6q0JcWJRcJmdlHMHl9MIM6OM7qkxu
        aveu86sTFIjpBESzt3UsN6sM9tyvY9odwpFjF7OKcyZgr2E8zebpF1yC5KyRw38FCAcof5
        w1ek7rxDMIG+OMr2WE47XGOAJUrs3Y4=
Received: from frank-G5.. (fttx-pool-157.180.227.195.bambit.de [157.180.227.195])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 0D09C10054D;
        Sun, 19 Jun 2022 08:26:18 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Liang Chen <cl@rock-chips.com>, Simon Xue <xxm@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/5] arm64: dts: rockchip: rk3568: Add PCIe v3 nodes
Date:   Sun, 19 Jun 2022 10:26:04 +0200
Message-Id: <20220619082605.7935-5-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220619082605.7935-1-linux@fw-web.de>
References: <20220619082605.7935-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 9bc0433d-bfc7-47ef-8d70-fe93204cb928
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Add nodes to rk356x devicetree to support PCIe v3.

Co-developed-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v4:
- update pcie3 reg/ranges

v3:
- fix from Peter: change bus-range and msi-map, msi-map needs
  to start from 0x0

v2:
- change to compatible with soc-part
- change rockchip,bifurcation to vendor unspecific bifurcation
---
 arch/arm64/boot/dts/rockchip/rk3568.dtsi | 122 +++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
index 5eafddf62edc..3f568f6747f6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
@@ -42,6 +42,128 @@ qos_sata0: qos@fe190200 {
 		reg = <0x0 0xfe190200 0x0 0x20>;
 	};
 
+	pcie30_phy_grf: syscon@fdcb8000 {
+		compatible = "rockchip,rk3568-pcie3-phy-grf", "syscon";
+		reg = <0x0 0xfdcb8000 0x0 0x10000>;
+	};
+
+	pcie30phy: phy@fe8c0000 {
+		compatible = "rockchip,rk3568-pcie3-phy";
+		reg = <0x0 0xfe8c0000 0x0 0x20000>;
+		#phy-cells = <0>;
+		clocks = <&pmucru CLK_PCIE30PHY_REF_M>, <&pmucru CLK_PCIE30PHY_REF_N>,
+			 <&cru PCLK_PCIE30PHY>;
+		clock-names = "refclk_m", "refclk_n", "pclk";
+		resets = <&cru SRST_PCIE30PHY>;
+		reset-names = "phy";
+		rockchip,phy-grf = <&pcie30_phy_grf>;
+		status = "disabled";
+	};
+
+	pcie3x1: pcie@fe270000 {
+		compatible = "rockchip,rk3568-pcie";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x0 0xf>;
+		clocks = <&cru ACLK_PCIE30X1_MST>, <&cru ACLK_PCIE30X1_SLV>,
+			 <&cru ACLK_PCIE30X1_DBI>, <&cru PCLK_PCIE30X1>,
+			 <&cru CLK_PCIE30X1_AUX_NDFT>;
+		clock-names = "aclk_mst", "aclk_slv",
+			      "aclk_dbi", "pclk", "aux";
+		device_type = "pci";
+		interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "sys", "pmc", "msg", "legacy", "err";
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie3x1_intc 0>,
+				<0 0 0 2 &pcie3x1_intc 1>,
+				<0 0 0 3 &pcie3x1_intc 2>,
+				<0 0 0 4 &pcie3x1_intc 3>;
+		linux,pci-domain = <1>;
+		num-ib-windows = <6>;
+		num-ob-windows = <2>;
+		max-link-speed = <3>;
+		msi-map = <0x0 &gic 0x1000 0x1000>;
+		num-lanes = <1>;
+		phys = <&pcie30phy>;
+		phy-names = "pcie-phy";
+		power-domains = <&power RK3568_PD_PIPE>;
+		reg = <0x3 0xc0400000 0x0 0x00400000>,
+		      <0x0 0xfe270000 0x0 0x00010000>,
+		      <0x3 0x7f000000 0x0 0x01000000>;
+		ranges = <0x01000000 0x0 0x3ef00000 0x3 0x7ef00000 0x0 0x00100000>,
+			 <0x02000000 0x0 0x00000000 0x3 0x40000000 0x0 0x3ef00000>;
+		reg-names = "dbi", "apb", "config";
+		resets = <&cru SRST_PCIE30X1_POWERUP>;
+		reset-names = "pipe";
+		/* bifurcation; lane1 when using 1+1 */
+		status = "disabled";
+
+		pcie3x1_intc: legacy-interrupt-controller {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 157 IRQ_TYPE_EDGE_RISING>;
+		};
+	};
+
+	pcie3x2: pcie@fe280000 {
+		compatible = "rockchip,rk3568-pcie";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x0 0xf>;
+		clocks = <&cru ACLK_PCIE30X2_MST>, <&cru ACLK_PCIE30X2_SLV>,
+			 <&cru ACLK_PCIE30X2_DBI>, <&cru PCLK_PCIE30X2>,
+			 <&cru CLK_PCIE30X2_AUX_NDFT>;
+		clock-names = "aclk_mst", "aclk_slv",
+			      "aclk_dbi", "pclk", "aux";
+		device_type = "pci";
+		interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "sys", "pmc", "msg", "legacy", "err";
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie3x2_intc 0>,
+				<0 0 0 2 &pcie3x2_intc 1>,
+				<0 0 0 3 &pcie3x2_intc 2>,
+				<0 0 0 4 &pcie3x2_intc 3>;
+		linux,pci-domain = <2>;
+		num-ib-windows = <6>;
+		num-ob-windows = <2>;
+		max-link-speed = <3>;
+		msi-map = <0x0 &gic 0x2000 0x1000>;
+		num-lanes = <2>;
+		phys = <&pcie30phy>;
+		phy-names = "pcie-phy";
+		power-domains = <&power RK3568_PD_PIPE>;
+		reg = <0x3 0xc0800000 0x0 0x00400000>,
+		      <0x0 0xfe280000 0x0 0x00010000>,
+		      <0x3 0xbf000000 0x0 0x01000000>;
+		ranges = <0x01000000 0x0 0x3ef00000 0x3 0xbef00000 0x0 0x00100000>,
+			 <0x02000000 0x0 0x00000000 0x3 0x80000000 0x0 0x3ef00000>;
+		reg-names = "dbi", "apb", "config";
+		resets = <&cru SRST_PCIE30X2_POWERUP>;
+		reset-names = "pipe";
+		/* bifurcation; lane0 when using 1+1 */
+		status = "disabled";
+
+		pcie3x2_intc: legacy-interrupt-controller {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 162 IRQ_TYPE_EDGE_RISING>;
+		};
+	};
+
 	gmac0: ethernet@fe2a0000 {
 		compatible = "rockchip,rk3568-gmac", "snps,dwmac-4.20a";
 		reg = <0x0 0xfe2a0000 0x0 0x10000>;
-- 
2.34.1


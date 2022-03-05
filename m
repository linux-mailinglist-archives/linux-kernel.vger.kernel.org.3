Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9924CE49C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 12:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbiCEL1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 06:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbiCEL1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 06:27:15 -0500
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBD940E7D;
        Sat,  5 Mar 2022 03:26:25 -0800 (PST)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout2.routing.net (Postfix) with ESMTP id 8AA445FD5D;
        Sat,  5 Mar 2022 11:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1646479584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oeojDkbixb+3+AqcShTPnuHWz+1GrcPznWJUJt5Sy3k=;
        b=v+/pylN7fIi8+EJUtnWzr056KkXzMdaedd8sSSturEfyQOeI/a9pkpI49bIs4yF/Ja939r
        PGjd/jAyuF/eyz+2yuGft/UJbOOMwn/NJkYAHL3di/Z10AG0fLpyvwGR17sXfiZhtiOV2b
        w34lFlqgJmc4Nma/5qE68J+88L8z9Mw=
Received: from localhost.localdomain (fttx-pool-217.61.157.101.bambit.de [217.61.157.101])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 9D40F1007DD;
        Sat,  5 Mar 2022 11:26:23 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     devicetree@vger.kernel.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v5 5/5] arm64: dts: rockchip: Add sata nodes to rk356x
Date:   Sat,  5 Mar 2022 12:26:07 +0100
Message-Id: <20220305112607.257734-6-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220305112607.257734-1-linux@fw-web.de>
References: <20220305112607.257734-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 6c0e6171-3ca7-422f-bfb9-56d26079865c
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

RK356x supports up to 3 sata controllers which were compatible with the
existing snps,dwc-ahci binding.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
changes in v4:
 - drop newline in dts
 - re-add clock-names
 -  add soc specific compatible
changes in v3:
  - fix combphy error by moving sata0 to rk3568.dtsi
  - remove clock-names and interrupt-names
changes in v2:
  - added sata0 + 1, but have only tested sata2
---
 arch/arm64/boot/dts/rockchip/rk3568.dtsi | 14 ++++++++++++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 28 ++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
index 5b0f528d6818..3e07d9f6a2d1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
@@ -8,6 +8,20 @@
 / {
 	compatible = "rockchip,rk3568";
 
+	sata0: sata@fc000000 {
+		compatible = "rockchip,rk3568-dwc-ahci", "snps,dwc-ahci";
+		reg = <0 0xfc000000 0 0x1000>;
+		clocks = <&cru ACLK_SATA0>, <&cru CLK_SATA0_PMALIVE>,
+			 <&cru CLK_SATA0_RXOOB>;
+		clock-names = "sata", "pmalive", "rxoob";
+		interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+		phys = <&combphy0 PHY_TYPE_SATA>;
+		phy-names = "sata-phy";
+		ports-implemented = <0x1>;
+		power-domains = <&power RK3568_PD_PIPE>;
+		status = "disabled";
+	};
+
 	pipe_phy_grf0: syscon@fdc70000 {
 		compatible = "rockchip,rk3568-pipe-phy-grf", "syscon";
 		reg = <0x0 0xfdc70000 0x0 0x1000>;
diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 7cdef800cb3c..264dd030e703 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -230,6 +230,34 @@ scmi_shmem: sram@0 {
 		};
 	};
 
+	sata1: sata@fc400000 {
+		compatible = "rockchip,rk3568-dwc-ahci", "snps,dwc-ahci";
+		reg = <0 0xfc400000 0 0x1000>;
+		clocks = <&cru ACLK_SATA1>, <&cru CLK_SATA1_PMALIVE>,
+			 <&cru CLK_SATA1_RXOOB>;
+		clock-names = "sata", "pmalive", "rxoob";
+		interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+		phys = <&combphy1 PHY_TYPE_SATA>;
+		phy-names = "sata-phy";
+		ports-implemented = <0x1>;
+		power-domains = <&power RK3568_PD_PIPE>;
+		status = "disabled";
+	};
+
+	sata2: sata@fc800000 {
+		compatible = "rockchip,rk3568-dwc-ahci", "snps,dwc-ahci";
+		reg = <0 0xfc800000 0 0x1000>;
+		clocks = <&cru ACLK_SATA2>, <&cru CLK_SATA2_PMALIVE>,
+			 <&cru CLK_SATA2_RXOOB>;
+		clock-names = "sata", "pmalive", "rxoob";
+		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+		phys = <&combphy2 PHY_TYPE_SATA>;
+		phy-names = "sata-phy";
+		ports-implemented = <0x1>;
+		power-domains = <&power RK3568_PD_PIPE>;
+		status = "disabled";
+	};
+
 	gic: interrupt-controller@fd400000 {
 		compatible = "arm,gic-v3";
 		reg = <0x0 0xfd400000 0 0x10000>, /* GICD */
-- 
2.25.1


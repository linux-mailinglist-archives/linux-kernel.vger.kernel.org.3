Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE1F4C5E1E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 19:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiB0S3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 13:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiB0S3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 13:29:02 -0500
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9345463EA;
        Sun, 27 Feb 2022 10:28:24 -0800 (PST)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout1.routing.net (Postfix) with ESMTP id A7DBB4013B;
        Sun, 27 Feb 2022 18:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1645986502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0xLcegYYoVjPeAY4Eq9m0ZZ+KHV0zGkTbYObM28HdIw=;
        b=r5y1cZtFYgJCq8Ynl9cOib4u03jqoHGOxha2dubGvYEYy6hloM32ODKNuFJZh310rN7VFo
        BrppjbdWXFPK8Dz1V7NjUeI6cH0Wbyw612un5SN2jPD6TsSAaOYQxMiGgwuKzTExcSVVmV
        g6r+KRSSDzCAFASb9EQoNhhY+n8/9bQ=
Received: from localhost.localdomain (fttx-pool-80.245.76.205.bambit.de [80.245.76.205])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id EEDDA405AF;
        Sun, 27 Feb 2022 18:28:21 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     "devicetree @ vger . kernel . org Damien Le Moal" 
        <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>
Subject: [PATCH v3 3/3] arm64: dts: rockchip: Add sata nodes to rk356x
Date:   Sun, 27 Feb 2022 19:28:00 +0100
Message-Id: <20220227182800.275572-4-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220227182800.275572-1-linux@fw-web.de>
References: <20220227182800.275572-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: fc5c7eba-beac-4129-b3e2-d00c639c3d91
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
changes in v3:
  - fix combphy error by moving sata0 to rk3568.dtsi
  - remove clock-names and interrupt-names
changes in v2:
  - added sata0 + 1, but have only tested sata2
---
 arch/arm64/boot/dts/rockchip/rk3568.dtsi | 14 +++++++++++++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 26 ++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
index 5b0f528d6818..2a2f65899d47 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
@@ -8,6 +8,19 @@
 / {
 	compatible = "rockchip,rk3568";
 
+	sata0: sata@fc000000 {
+		compatible = "snps,dwc-ahci";
+		reg = <0 0xfc000000 0 0x1000>;
+		clocks = <&cru ACLK_SATA0>, <&cru CLK_SATA0_PMALIVE>,
+			 <&cru CLK_SATA0_RXOOB>;
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
@@ -114,3 +127,4 @@ power-domain@RK3568_PD_PIPE {
 		#power-domain-cells = <0>;
 	};
 };
+
diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 7cdef800cb3c..484c5ace718a 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -230,6 +230,32 @@ scmi_shmem: sram@0 {
 		};
 	};
 
+	sata1: sata@fc400000 {
+		compatible = "snps,dwc-ahci";
+		reg = <0 0xfc400000 0 0x1000>;
+		clocks = <&cru ACLK_SATA1>, <&cru CLK_SATA1_PMALIVE>,
+			 <&cru CLK_SATA1_RXOOB>;
+		interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+		phys = <&combphy1 PHY_TYPE_SATA>;
+		phy-names = "sata-phy";
+		ports-implemented = <0x1>;
+		power-domains = <&power RK3568_PD_PIPE>;
+		status = "disabled";
+	};
+
+	sata2: sata@fc800000 {
+		compatible = "snps,dwc-ahci";
+		reg = <0 0xfc800000 0 0x1000>;
+		clocks = <&cru ACLK_SATA2>, <&cru CLK_SATA2_PMALIVE>,
+			 <&cru CLK_SATA2_RXOOB>;
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


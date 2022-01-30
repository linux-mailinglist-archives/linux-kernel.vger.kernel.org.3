Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD944A3709
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 15:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355304AbiA3Oyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 09:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355242AbiA3Oya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 09:54:30 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0F2C061741;
        Sun, 30 Jan 2022 06:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=BQp+OnhjsTEYATdGEqp/xWApd1Z1iShnMRkOroWlLH4=; b=dN3mK1tEq9EEeWaP4Lumm02HSb
        sERMVQYJ/1re5e8hw3xIVUcwCQZPosN7PYtRsI4xX9r4ji8PafJ0bKHfuLi3Nk9YKn53x4FFpy3kP
        Y0CfvIfu3axe/YkvKnSf38Et3HlTT7m/duXI+g5ZsFvNdGzh9PZugppchIljdu6XLixg=;
Received: from p200300daa716f900d40f7dfd86c385e0.dip0.t-ipconnect.de ([2003:da:a716:f900:d40f:7dfd:86c3:85e0] helo=Maecks.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nEBYB-0002if-Qi; Sun, 30 Jan 2022 15:51:31 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     soc@kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, john@phrozen.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 10/13] ARM: dts: Add PCIe support for Airoha EN7523
Date:   Sun, 30 Jan 2022 15:51:13 +0100
Message-Id: <20220130145116.88406-11-nbd@nbd.name>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220130145116.88406-1-nbd@nbd.name>
References: <20220130145116.88406-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This uses the MediaTek MT7622 PCIe driver, since the PCIe IP block is nearly
identical to the one in MT7622

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 arch/arm/boot/dts/en7523-evb.dts |  8 +++++
 arch/arm/boot/dts/en7523.dtsi    | 60 ++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/arch/arm/boot/dts/en7523-evb.dts b/arch/arm/boot/dts/en7523-evb.dts
index 69754ef9a628..0a79f5f6c311 100644
--- a/arch/arm/boot/dts/en7523-evb.dts
+++ b/arch/arm/boot/dts/en7523-evb.dts
@@ -25,3 +25,11 @@ memory@80000000 {
 		reg = <0x80000000 0x20000000>;
 	};
 };
+
+&pcie0 {
+	status = "okay";
+};
+
+&pcie1 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/en7523.dtsi b/arch/arm/boot/dts/en7523.dtsi
index 1e5280be02ba..b897fb6cffd2 100644
--- a/arch/arm/boot/dts/en7523.dtsi
+++ b/arch/arm/boot/dts/en7523.dtsi
@@ -122,4 +122,64 @@ uart1: serial@1fbf0000 {
 		clock-frequency = <1843200>;
 		status = "okay";
 	};
+
+
+	pcie0: pcie@1fa91000 {
+		compatible = "airoha,en7523-pcie", "mediatek,mt7622-pcie";
+		device_type = "pci";
+		reg = <0x1fa91000 0x1000>;
+		reg-names = "port0";
+		linux,pci-domain = <0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "pcie_irq";
+		clocks = <&scu EN7523_CLK_PCIE>;
+		clock-names = "sys_ck0";
+		bus-range = <0x00 0xff>;
+		ranges = <0x82000000 0 0x20000000  0x20000000  0 0x8000000>;
+		status = "disabled";
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie_intc0 0>,
+				<0 0 0 2 &pcie_intc0 1>,
+				<0 0 0 3 &pcie_intc0 2>,
+				<0 0 0 4 &pcie_intc0 3>;
+		pcie_intc0: interrupt-controller {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+		};
+	};
+
+	pcie1: pcie@1fa92000 {
+		compatible = "airoha,en7523-pcie", "mediatek,mt7622-pcie";
+		device_type = "pci";
+		reg = <0x1fa92000 0x1000>;
+		reg-names = "port1";
+		linux,pci-domain = <1>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "pcie_irq";
+		clocks = <&scu EN7523_CLK_PCIE>;
+		clock-names = "sys_ck1";
+		bus-range = <0x00 0xff>;
+		ranges = <0x82000000 0 0x28000000  0x28000000  0 0x8000000>;
+		status = "disabled";
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie_intc1 0>,
+				<0 0 0 2 &pcie_intc1 1>,
+				<0 0 0 3 &pcie_intc1 2>,
+				<0 0 0 4 &pcie_intc1 3>;
+		pcie_intc1: interrupt-controller {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+		};
+	};
+
 };
-- 
2.32.0 (Apple Git-132)


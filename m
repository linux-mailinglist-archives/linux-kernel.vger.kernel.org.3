Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595D44A9846
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 12:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358165AbiBDLPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 06:15:48 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44176 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiBDLPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 06:15:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0091B83659;
        Fri,  4 Feb 2022 11:15:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA90C340EF;
        Fri,  4 Feb 2022 11:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643973342;
        bh=pyBLRuJJ06eYguE/khXqSQCbVLT0wJ76+vNTWivwPNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D1A2sh045XTKOyzJLmpNqJSVVIfrUO/TuoAXGndhHj/aHioGz9/O3X8l9OVXalHAQ
         g3HXsGrCXkrrqrAShWNQ+v50uZpW7nEDCSol1E7DejR+x3IoDjBmiphdBa9xJ9TMJp
         RLkDIJ8Fgwzfaxd315Dtd3tSXIUZFWh/i/TQgE+FLzrNUD0271DU+4o0ZQIDAY3bCP
         4cPOr3mbC+PnMzAZs/vaEioLTPI765FubHFq8Td2qFcfhRv1kjbBhdZB0ZL81SnuAI
         4P9lplHE2aRkpbx3DTzoxwiCFHyQUEBSZ/ZxHak0/gjBaibRJHVgBVseaIpBJwryKI
         8+wk1swfyMJ5w==
From:   Roger Quadros <rogerq@kernel.org>
To:     nm@ti.com
Cc:     kishon@ti.com, vigneshr@ti.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v3 1/2] arm64: dts: ti: k3-am64-main: Add GPMC memory controller node
Date:   Fri,  4 Feb 2022 13:15:32 +0200
Message-Id: <20220204111533.10787-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220204111533.10787-1-rogerq@kernel.org>
References: <20220204111533.10787-1-rogerq@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPMC is a unified memory controller dedicated for interfacing
with external memory devices like
  - Asynchronous SRAM-like memories and ASICs
  - Asynchronous, synchronous, and page mode burst NOR flash
  - NAND flash
  - Pseudo-SRAM devices

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 19 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts  |  4 ++++
 arch/arm64/boot/dts/ti/k3-am642-sk.dts   |  4 ++++
 3 files changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 012011dc619a..94ea5c304d73 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -1289,4 +1289,23 @@
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
 	};
+
+	gpmc0: memory-controller@3b000000 {
+		compatible = "ti,am64-gpmc";
+		power-domains = <&k3_pds 80 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 80 0>;
+		clock-names = "fck";
+		reg = <0x00 0x03b000000 0x00 0x400>,
+		      <0x00 0x050000000 0x00 0x8000000>;
+		reg-names = "cfg", "data";
+		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+		gpmc,num-cs = <3>;
+		gpmc,num-waitpins = <2>;
+		#address-cells = <2>;
+		#size-cells = <1>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index e94ae178b1ae..6bd0c0876865 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -678,3 +678,7 @@
 	pinctrl-0 = <&main_mcan1_pins_default>;
 	phys = <&transceiver2>;
 };
+
+&gpmc0 {
+	status = "disabled";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index a9785bec12df..40706aa61514 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -533,3 +533,7 @@
 &main_mcan1 {
 	status = "disabled";
 };
+
+&gpmc0 {
+	status = "disabled";
+};
-- 
2.17.1


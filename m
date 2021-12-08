Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C6046D432
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbhLHNTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:19:20 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60916 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbhLHNTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:19:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56965B817AE;
        Wed,  8 Dec 2021 13:15:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D65DC341C7;
        Wed,  8 Dec 2021 13:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638969345;
        bh=hjducVqW50CuU5bubaiTZGflO0pLSH4F4fUmaSzQXNk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gSRhPDs29aFk1jYrnXr4CF01zwOC8rws3Kw0enwvS5AsucuDJRr9r50jffNMK+q+n
         18lOUDbPt6YpkdQOZujUXS675f4dMG5rYWstMlYASnt5gkpPQ1YtSj9I8ILJK+p8o0
         78lvZSoiCMyniNGEK1SfDaR9XagGA5eCx/YKIjoIZanMFa82YHsIeelQK6ObAgQ85k
         JgZwIUDYFCsfqonsdyza493VQczmrShD21ed518m/FWtbbCOFZLD0L/0LP0d7iFBc4
         Taijgp5ql+Tk5vt27NTD+BX5KAksEArBqT4/ifJ0+DGiVqHp56uXztNSCExSgOMymg
         e81N0yo6shTxA==
From:   Roger Quadros <rogerq@kernel.org>
To:     nm@ti.com
Cc:     kishon@ti.com, vigneshr@ti.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 1/2] arm64: dts: ti: k3-am64-main: Add GPMC memory controller node
Date:   Wed,  8 Dec 2021 15:15:35 +0200
Message-Id: <20211208131536.23667-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211208131536.23667-1-rogerq@kernel.org>
References: <20211208131536.23667-1-rogerq@kernel.org>
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
index 5ad638b95ffc..830bfc0929b9 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -1253,4 +1253,23 @@
 			bus_freq = <1000000>;
 		};
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
index 6726c4c7c28c..e13866a6e131 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -638,3 +638,7 @@
 &icssg1_mdio {
 	status = "disabled";
 };
+
+&gpmc0 {
+	status = "disabled";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 6b04745147be..e2793202af38 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -525,3 +525,7 @@
 &icssg1_mdio {
 	status = "disabled";
 };
+
+&gpmc0 {
+	status = "disabled";
+};
-- 
2.17.1


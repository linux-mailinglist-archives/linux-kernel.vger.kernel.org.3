Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14E9587AF1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 12:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbiHBKpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 06:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236426AbiHBKpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 06:45:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938B4248FA;
        Tue,  2 Aug 2022 03:45:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 330E76106C;
        Tue,  2 Aug 2022 10:45:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFCDC433B5;
        Tue,  2 Aug 2022 10:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659437104;
        bh=yo2nOdusVJuwB3QYOkQK2Nyjtyu5pQaagx4P5BoZTuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hlEewfSFQUx0cuQhGmBWh6PkGjH+RvLp1AamidCUcxyh9r1pX1EaGU7IxnGApDv9p
         yAaxe2H6Z+oeWTgHhBeG3fvgGeT9Tj6PuLR5gyqtKi5X3Rm09FwNOeRDJtQTI7FnwN
         wsv9/MExIrzdPkYb/8TIDThjaR7zqCu0pCE2cV6V6ANaxvXgO+e36Pmy3XTCypxPNL
         OrlFet0nQRJU2aINVNhPfh6Jnf/nPCvMDEmQ/bKq31UuCZflHHLKQO5aSIWZtgJLzR
         wlQOITsZlokJfjShk3wkvaYHDskqovU6FqahUnRCquhmsQkVS/YSnKOfFnoeyaHSdc
         7krHv/YRttrNA==
From:   Roger Quadros <rogerq@kernel.org>
To:     nm@ti.com, vigneshr@ti.com
Cc:     kishon@ti.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v4 1/2] arm64: dts: ti: k3-am64-main: Add GPMC memory controller node
Date:   Tue,  2 Aug 2022 13:44:55 +0300
Message-Id: <20220802104456.11069-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220802104456.11069-1-rogerq@kernel.org>
References: <20220802104456.11069-1-rogerq@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 19 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts  |  4 ++++
 arch/arm64/boot/dts/ti/k3-am642-sk.dts   |  4 ++++
 3 files changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index cdb530597c5e..0059de0aeedf 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -1308,4 +1308,23 @@
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
index 8e7893e58b03..30647fc3eec2 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -676,3 +676,7 @@
 	pinctrl-0 = <&main_mcan1_pins_default>;
 	phys = <&transceiver2>;
 };
+
+&gpmc0 {
+	status = "disabled";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 59f506cbd275..bd9b36b16787 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -593,3 +593,7 @@
 &main_mcan1 {
 	status = "disabled";
 };
+
+&gpmc0 {
+	status = "disabled";
+};
-- 
2.17.1


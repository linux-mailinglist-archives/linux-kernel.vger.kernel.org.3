Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A529C50A2A3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389409AbiDUOig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389501AbiDUOi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:38:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05A901EC40;
        Thu, 21 Apr 2022 07:35:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C50BA1515;
        Thu, 21 Apr 2022 07:35:28 -0700 (PDT)
Received: from e120809.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DD353F73B;
        Thu, 21 Apr 2022 07:35:27 -0700 (PDT)
From:   Diego Sueiro <diego.sueiro@arm.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     liviu.dudau@arm.com, sudeep.holla@arm.com,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, nd@arm.com, diego.sueiro@arm.com
Subject: [PATCH] arm64: dts: fvp: Add virtio-rng support
Date:   Thu, 21 Apr 2022 15:35:21 +0100
Message-Id: <ac3be672c636091ee1e079cadce776b1fb7e0b2e.1650543392.git.diego.sueiro@arm.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The virtio-rng is available from FVP_Base_RevC-2xAEMvA version 11.17, so add
the devicetree node to support it.

Signed-off-by: Diego Sueiro <diego.sueiro@arm.com>
---
 arch/arm64/boot/dts/arm/fvp-base-revc.dts            | 3 ++-
 arch/arm64/boot/dts/arm/rtsm_ve-motherboard-rs2.dtsi | 7 +++++++
 arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi     | 2 +-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/arm/fvp-base-revc.dts b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
index 269b649934b5..a496e39e6204 100644
--- a/arch/arm64/boot/dts/arm/fvp-base-revc.dts
+++ b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
@@ -241,6 +241,7 @@ bus@8000000 {
 				<0 0 41 &gic 0 0 GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
 				<0 0 42 &gic 0 0 GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
 				<0 0 43 &gic 0 0 GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
-				<0 0 44 &gic 0 0 GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+				<0 0 44 &gic 0 0 GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
+				<0 0 46 &gic 0 0 GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 	};
 };
diff --git a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard-rs2.dtsi b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard-rs2.dtsi
index 33182d9e5826..1b6326514c97 100644
--- a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard-rs2.dtsi
+++ b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard-rs2.dtsi
@@ -21,6 +21,13 @@ virtio-net@150000 {
 					reg = <0x150000 0x200>;
 					interrupts = <44>;
 				};
+
+				virtio-rng@200000 {
+					compatible = "virtio,mmio";
+					reg = <0x200000 0x200>;
+					interrupts = <46>;
+					status = "disabled";
+				};
 			};
 		};
 	};
diff --git a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
index 5f6cab668aa0..a999e7f52d8b 100644
--- a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
+++ b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
@@ -110,7 +110,7 @@ iofpga-bus@300000000 {
 				compatible = "simple-bus";
 				#address-cells = <1>;
 				#size-cells = <1>;
-				ranges = <0 3 0 0x200000>;
+				ranges = <0 3 0 0x210000>;
 
 				v2m_sysreg: sysreg@10000 {
 					compatible = "arm,vexpress-sysreg";
-- 
2.35.1


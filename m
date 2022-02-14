Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E590E4B526B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354725AbiBNN5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:57:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354747AbiBNN44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:56:56 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78F44EA0F;
        Mon, 14 Feb 2022 05:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644847006; x=1676383006;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CuM7K8ToBJ7RKoIFBCQywAvEKq4J6OlP+754BZRgkAU=;
  b=saOkMCzi7dk+ohFWbPJTmQ5EeP0tmoKhpEeyVZUr74PcxJXsED9pBUpc
   wOMu3ykI98sJ3kJcLNIPFKKd4TkAe3K0M6M+n3WKOKEsJ4zPkjn7Yqirz
   uTIF+ddZqVYe7/Xst0FNZQ/1J8JeZwAwAMKp51i4F1p7Rz+IfPPoIDDWT
   9cM/OPPgB4w4teeN5v2boYFyth0iMdn4wDPrOpGK8/tdH41uPymwBNVsv
   KnxSV2lN7IA2urfIgQu079H93+a6fRkpI/XoJlrL4UsO8wyuGwW9pXXUu
   t0OOclw6/FV/LETYwCn/gj3fJkfyY5LAEjmlqDwrq0JaysuwlciLtCYo+
   Q==;
IronPort-SDR: B4lG6+0O8Fx8pvTp7P8/ONZSveDcqE57ZBUKdWX9EA6vsq0sDSyTpZotJRZPZgLeVR6rLU5EHG
 o8HqLk8S45lD/NFgNfjuz+BeVBsFECw7i+3Kg4ItMCRvHlzpJ2/QQ6xW1pDTlUzcX9MNsh9m4I
 5+eIJkisejTqeacF+YIbQgrreNXoCoP6RgaCU5dL3Fz4bS6P61zHjKUSsyfI0HZJHKffcBi69r
 TqyfGdulzKTVsIg7nT9RAUz87sn004wL/9Nn3hDxJws9nayDXJh4/hkQuGWXnoupuDBxGw5pzO
 Jijcg0wleA6s1poY97SoTQ+T
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="85633793"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Feb 2022 06:56:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 14 Feb 2022 06:56:44 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 14 Feb 2022 06:56:38 -0700
From:   <conor.dooley@microchip.com>
To:     <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <robh+dt@kernel.org>,
        <jassisinghbrar@gmail.com>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <lee.jones@linaro.org>,
        <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <geert@linux-m68k.org>,
        <krzysztof.kozlowski@canonical.com>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
CC:     <lewis.hanly@microchip.com>, <conor.dooley@microchip.com>,
        <daire.mcnamara@microchip.com>, <ivan.griffin@microchip.com>,
        <atishp@rivosinc.com>, Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v7 07/11] riscv: dts: microchip: add fpga fabric section to icicle kit
Date:   Mon, 14 Feb 2022 13:58:37 +0000
Message-ID: <20220214135840.168236-8-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220214135840.168236-1-conor.dooley@microchip.com>
References: <20220214135840.168236-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Split the device tree for the Microchip MPFS into two sections by adding
microchip-mpfs-fabric.dtsi, which contains peripherals contained in the
FPGA fabric.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 .../dts/microchip/microchip-mpfs-fabric.dtsi  | 25 +++++++++++++++++++
 .../microchip/microchip-mpfs-icicle-kit.dts   |  8 ++++++
 .../boot/dts/microchip/microchip-mpfs.dtsi    |  1 +
 3 files changed, 34 insertions(+)
 create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs-fabric.dtsi

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs-fabric.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs-fabric.dtsi
new file mode 100644
index 000000000000..854320e17b28
--- /dev/null
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs-fabric.dtsi
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* Copyright (c) 2020-2021 Microchip Technology Inc */
+
+/ {
+	core_pwm0: pwm@41000000 {
+		compatible = "microchip,corepwm-rtl-v4";
+		reg = <0x0 0x41000000 0x0 0xF0>;
+		microchip,sync-update-mask = /bits/ 32 <0>;
+		#pwm-cells = <2>;
+		clocks = <&clkcfg CLK_FIC3>;
+		status = "disabled";
+	};
+
+	i2c2: i2c@44000000 {
+		compatible = "microchip,corei2c-rtl-v7";
+		reg = <0x0 0x44000000 0x0 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&clkcfg CLK_FIC3>;
+		interrupt-parent = <&plic>;
+		interrupts = <122>;
+		clock-frequency = <100000>;
+		status = "disabled";
+	};
+};
diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
index 6d19ba196f12..ab803f71626a 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
@@ -68,6 +68,10 @@ &mmc {
 	sd-uhs-sdr104;
 };
 
+&i2c2 {
+	status = "okay";
+};
+
 &emac0 {
 	phy-mode = "sgmii";
 	phy-handle = <&phy0>;
@@ -86,3 +90,7 @@ phy1: ethernet-phy@9 {
 		ti,fifo-depth = <0x01>;
 	};
 };
+
+&core_pwm0 {
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
index 717e39b30a15..c7d73756c9b8 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -3,6 +3,7 @@
 
 /dts-v1/;
 #include "dt-bindings/clock/microchip,mpfs-clock.h"
+#include "microchip-mpfs-fabric.dtsi"
 
 / {
 	#address-cells = <2>;
-- 
2.35.1


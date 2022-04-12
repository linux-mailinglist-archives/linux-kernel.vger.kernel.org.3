Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6ECF4FE3EE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 16:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356665AbiDLOiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 10:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356585AbiDLOiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 10:38:09 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE645C864;
        Tue, 12 Apr 2022 07:35:50 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 32CF222249;
        Tue, 12 Apr 2022 16:35:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1649774148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G/hnT3AEhxVxbNwEdDE7vvgvmJxgXYZA0Ny8VTY14TA=;
        b=Ww/nu+x4QXsYJMEE0AH07YIcmC0qeLlkPD42SFTL3CJUgKcpbHUiQa9cSpRkeoL0j/XBnB
        CyZG6NFX/0k9k9+JMFI3cJY8Dn4XEHaS9poZLGPVrKpvaiCyQYfCRhNGV1zFje/qNFHRq6
        LZqy5hFLZVnhPBycjABPOchfUfssPnU=
From:   Michael Walle <michael@walle.cc>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v3 2/2] arm64: dts: imx8mn: add 8MNANOD3L-EVK device tree
Date:   Tue, 12 Apr 2022 16:32:38 +0200
Message-Id: <20220412143238.1925059-3-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220412143238.1925059-1-michael@walle.cc>
References: <20220412143238.1925059-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a device tree for the 8MNANOD3L-EVK eval board which features an
IMX8MN SoC. It is similar to the 8MNANODLPD4-EVK eval board except it
has an IMX8MN UltraLite SoC and DDR3L memory. It esp. differs in the
PMIC configuration because the SoC has a smaller package and thus the
ARM core voltage is combined with the SoC voltage and the DDR voltage
is 1.35V for the DDR3L memory.

Signed-off-by: Michael Walle <michael@walle.cc>
---
changes since v2:
 - new patch

 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx8mn-ddr3l-evk.dts   | 114 ++++++++++++++++++
 2 files changed, 115 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-ddr3l-evk.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 85c2c9ba5110..bdb76e67ccfe 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -73,6 +73,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mn-beacon-kit.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-bsh-smm-s2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-bsh-smm-s2pro.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mn-ddr3l-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-ddr4-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-tqma8mqnl-mba8mx.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-var-som-symphony.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-ddr3l-evk.dts b/arch/arm64/boot/dts/freescale/imx8mn-ddr3l-evk.dts
new file mode 100644
index 000000000000..000e2c0596df
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mn-ddr3l-evk.dts
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include "imx8mn.dtsi"
+#include "imx8mn-evk.dtsi"
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	model = "NXP i.MX8MNano DDR3L EVK board";
+	compatible = "fsl,imx8mn-ddr3l-evk", "fsl,imx8mn";
+};
+
+&A53_0 {
+	cpu-supply = <&buck1>;
+};
+
+&A53_1 {
+	cpu-supply = <&buck1>;
+};
+
+&A53_2 {
+	cpu-supply = <&buck1>;
+};
+
+&A53_3 {
+	cpu-supply = <&buck1>;
+};
+
+&i2c1 {
+	pmic: pmic@25 {
+		compatible = "nxp,pca9450b";
+		reg = <0x25>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pmic>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+
+		regulators {
+			buck1: BUCK1 {
+				regulator-name = "VDD_SOC_0V9";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <950000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck4: BUCK4 {
+				regulator-name = "VDD_3V3";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck5: BUCK5 {
+				regulator-name = "VDD_1V8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck6: BUCK6 {
+				regulator-name = "NVCC_DRAM_1V35";
+				regulator-min-microvolt = <1350000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1: LDO1 {
+				regulator-name = "NVCC_SNVS_1V8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo2: LDO2 {
+				regulator-name = "VDD_SNVS_0V8";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo3: LDO3 {
+				regulator-name = "VDDA_1V8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4: LDO4 {
+				regulator-name = "VDD_PHY_1V2";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo5: LDO5 {
+				regulator-name = "NVCC_SD2";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+};
-- 
2.30.2


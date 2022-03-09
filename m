Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3594D2E57
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 12:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbiCILnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 06:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbiCILm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:42:59 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5608616BCD8;
        Wed,  9 Mar 2022 03:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1646826120; x=1678362120;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yev62PtTcyJMc3JdaFGquolvb6gHeScWk6sAEYEIg2I=;
  b=Zr8YUmpppWtqFq4oDWk/Z/mWS1rbeuGKJhey9Paww8mkCYLQSqcYeQvz
   x9B3DA5/uOYhZEPbBDdJD56PUOW3DDm0ovvO8Zt0rORqvHSQowPMV7JEy
   J8s3ucQpvU19ZH+kqHPJN0TKP4z2aPpRx2bFAECeAhfM7ZX8iKvrJcZxc
   tw45Zr9NRiR+Ge7Y0oFMjA8oKZOh4c7PfNZc8rHlzp6CYP1uRM0WtSi2x
   hnjZSR6lIqu92N+2od9dFyCKFKdSfv4yIJFn9XUW0zIWTd0OKNz1+VleF
   dpRUZs97IpWLRkwqq/2B/Vqx+/vnBSxp/0ssx+zyqBfHYAVxosZ6xGlZW
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,167,1643670000"; 
   d="scan'208";a="22553375"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 09 Mar 2022 12:41:55 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 09 Mar 2022 12:41:55 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 09 Mar 2022 12:41:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1646826115; x=1678362115;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yev62PtTcyJMc3JdaFGquolvb6gHeScWk6sAEYEIg2I=;
  b=NlXklOp/5EsGkMVjcVC+ji5EyEw9hhSIfOuz/hp0iuLRRuMS+07UdWG+
   p7ajRUkIDFz0fDkEqltBNJuLI6ie21FENEHOXzbWwEMUkyKwjP2So+0IM
   4Vzc0TSXv9FXKC++7vVZfMmCWufXCGc5/1ODajtHQLj/W1yDezG8NzhrY
   ILMCA7r668IjvuyR/5buXqYZve51u5yZHRykfnkiLV/1s+pcrmswBsOlr
   4pb6IZMc6whyAse9cjyfyD9VbUvDu7+nnSWd3Y6irMj3jRRR4er3mNYJ/
   UPzZBsV2pt3F+ZSPo9oPYphiTtFU3c8f1zMo6ogWaW0qW9FV03T+v9xPP
   w==;
X-IronPort-AV: E=Sophos;i="5.90,167,1643670000"; 
   d="scan'208";a="22553374"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 09 Mar 2022 12:41:55 +0100
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 8963F280078;
        Wed,  9 Mar 2022 12:41:55 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 8/8] [DNI] arm64: dts: tqma8mqml: add IMX327 MIPI-CSI overlay
Date:   Wed,  9 Mar 2022 12:41:44 +0100
Message-Id: <20220309114144.120643-9-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220309114144.120643-1-alexander.stein@ew.tq-group.com>
References: <20220309114144.120643-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
Changes in v3:
* None

 arch/arm64/boot/dts/freescale/Makefile        |  4 +
 .../imx8mm-tqma8mqml-mba8mx-imx327.dts        | 95 +++++++++++++++++++
 2 files changed, 99 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx-imx327.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index faa01802276d..b27842200d5f 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -57,6 +57,10 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-icore-mx8mm-edimm2.2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-n801x-s.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-nitrogen-r2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-tqma8mqml-mba8mx.dtb
+
+tqma8mqml-mba8mx-imx327-dtbs += imx8mm-tqma8mqml-mba8mx.dtb imx8mm-tqma8mqml-mba8mx-imx327.dtbo
+dtb-$(CONFIG_ARCH_MXC) += tqma8mqml-mba8mx-imx327.dtb
+
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw71xx-0x.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw72xx-0x.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx-imx327.dts b/arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx-imx327.dts
new file mode 100644
index 000000000000..3f1223d4d73b
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx-imx327.dts
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright 2021 TQ-Systems GmbH
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	compatible = "tq,imx8mm-tqma8mqml-mba8mx", "tq,imx8mm-tqma8mqml", "fsl,imx8mm";
+
+	sensor_clk: sensor-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <37125000>;
+	};
+};
+
+&csi {
+       status = "okay";
+};
+
+&i2c3 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	vc_fpga: fpga@10 {
+		reg = <0x10>;
+		compatible = "vc,fpga";
+
+		vc_fpga_reg: regulator {
+			regulator-name = "CAM_VCC";
+		};
+
+		vc_fpga_reset: reset {
+			#reset-cells = <0>;
+		};
+
+		vc_fpga_gpio: gpio-chip {
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+	};
+
+	sony_imx327: camera@1a {
+		#address-cells = <0x1>;
+		#size-cells = <0x0>;
+		reg = <0x1a>;
+
+		compatible = "sony,imx327", "sony,imx290";
+
+		clock-names = "xclk";
+		clocks = <&sensor_clk>;
+		clock-frequency = <37125000>;
+
+		vdd-supply = <&vc_fpga_reg>;
+
+		vdda-supply = <&vc_fpga_reg>;
+		vddd-supply = <&vc_fpga_reg>;
+		vdddo-supply = <&vc_fpga_reg>;
+
+		reset-gpios = <&vc_fpga_gpio 0 GPIO_ACTIVE_HIGH>;
+
+		port@0 {
+			reg = <0>;
+
+			sony_imx327_ep0: endpoint {
+				remote-endpoint = <&imx8mm_mipi_csi_in>;
+				data-lanes = <1 2>;
+				clock-lanes = <0>;
+				clock-noncontinuous = <1>;
+				link-frequencies = /bits/ 64 <445500000 297000000>;
+			};
+		};
+	};
+};
+
+&mipi_csi {
+       status = "okay";
+
+       ports {
+               #address-cells = <1>;
+               #size-cells = <0>;
+
+               port@0 {
+                       reg = <0>;
+                       imx8mm_mipi_csi_in: endpoint {
+                               remote-endpoint = <&sony_imx327_ep0>;
+                               data-lanes = <1 2>;
+                       };
+               };
+       };
+};
\ No newline at end of file
-- 
2.25.1


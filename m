Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41674A991A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 13:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358761AbiBDMPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 07:15:40 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:57007 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358587AbiBDMP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 07:15:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1643976928; x=1675512928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WX0S5yywfJteoi/TvV8TssMpvmQJ3W0EAQZbPxU9SAY=;
  b=T7K5cViJke0Teckn5Lk0mmJ3LhyyYPVUoiM18lLNrGSumiHzJylrJKSO
   IGAJEgUK1Xaf7xck5f4/vG3w+AJG2S3jPVcEQ69CJ+cEL9LGV0J8Kex40
   FS4mnJV6nbTLBnGPUYGrS1+KsRZ0Qxwl28kGz+dbLzT/2Kvlwhdw2pSeg
   w3dZ1duPw3mu7d7f5cbxN/2cL94fUsc37HaMbF7G/xTYyx+HWXJu0xkwX
   X436ccqnyfUctfJ2AGiid1ruB2sagUQZ/YFxVQfz2UTqgHeuDvl/IKDak
   4G/F0sPBhstxG4jUPWoAw7WF242wT1HPva9Wx4feByb06yPRFYTlNAsmN
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,342,1635199200"; 
   d="scan'208";a="21903438"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 04 Feb 2022 13:15:26 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 04 Feb 2022 13:15:26 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 04 Feb 2022 13:15:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1643976926; x=1675512926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WX0S5yywfJteoi/TvV8TssMpvmQJ3W0EAQZbPxU9SAY=;
  b=UNFkcce9q6budxdHMNO+j4l/CwIDPZuVxW1Nz0ysYQ9GbAPUbSlNyFIP
   VI0OHH3sxX7/zQ7b14VXozFCEqBdqyb+/KRXq7Ng+9CS0dc8xCFdN6JYX
   h/mK2SQxQ7MqCjov6EXNr5ndPkGfeMcXTRmm+Y8KUg1hqmTpoOy3X7ei6
   lui4d6HbmzT4aLSi9LtnW6rz/krFy3wDqa2seirQfvGIqNKH80xehZ7v+
   Vrczd38PFJWWMgOzsojS8dstUifJhgTOC+WcSb+yDjL/h6EMU5vCn5xiZ
   u4vrqwLd2RcuOJuYjUMGxHkcBRPUa+ysiJh5TcQS3X3dzDq+d7kk3w65w
   A==;
X-IronPort-AV: E=Sophos;i="5.88,342,1635199200"; 
   d="scan'208";a="21903437"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 04 Feb 2022 13:15:26 +0100
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 6D5A7280065;
        Fri,  4 Feb 2022 13:15:26 +0100 (CET)
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
Subject: [PATCH 8/8] [DNI] arm64: dts: tqma8mqml: add IMX327 MIPI-CSI overlay
Date:   Fri,  4 Feb 2022 13:15:14 +0100
Message-Id: <20220204121514.2762676-9-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220204121514.2762676-1-alexander.stein@ew.tq-group.com>
References: <20220204121514.2762676-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 arch/arm64/boot/dts/freescale/Makefile        |  4 +
 .../imx8mm-tqma8mqml-mba8mx-imx327.dts        | 95 +++++++++++++++++++
 2 files changed, 99 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx-imx327.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 852615febf9a..5ef8ff05452e 100644
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


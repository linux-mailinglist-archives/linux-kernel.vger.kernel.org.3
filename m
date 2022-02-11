Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C1A4B27D9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350909AbiBKO2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:28:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350816AbiBKO2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:28:17 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404203BB;
        Fri, 11 Feb 2022 06:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1644589689; x=1676125689;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WX0S5yywfJteoi/TvV8TssMpvmQJ3W0EAQZbPxU9SAY=;
  b=RtSwmEnPwT5PN9dxgVce5AJhtmoTH2PyoVZtKfSi1PItqwxlB5iAdBO4
   QB3fhC9Po7TNQNAAtbvLIld3AXLMUSGgg2n44fRy7w4ZT5f5Nbm5B/3XJ
   aGjEzqJYeVcaTj/lIzjkh06LkQ11I6TgNuhxhLyPq3wcF6g0YhN5zhluN
   +/L3doKkJxGqTwE5p17KHiK6FRQBbOsQSswEZgDTHmd0RiWIyK5o/y2ZD
   RKpJi4gg6gINuVXBE88JU+hSlTWSMdLZzDUh5bpmWwvBxBudKB5i3q99K
   XrnKnkesKd+GuGowbhIX7TGulIhsBkSlYhs/gto2kTysWTBCAL1t1Iy4/
   g==;
X-IronPort-AV: E=Sophos;i="5.88,361,1635199200"; 
   d="scan'208";a="22042295"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 11 Feb 2022 15:28:03 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 11 Feb 2022 15:28:03 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 11 Feb 2022 15:28:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1644589683; x=1676125683;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WX0S5yywfJteoi/TvV8TssMpvmQJ3W0EAQZbPxU9SAY=;
  b=JXFiNviKKL3pVSTEBWuf1qUT5zKmsqTmad6gQFM7LXdPnBRmD4qSEj2B
   tR0OSVhW/3w6fSx2K4CXJJyE3FB2NpHk+6rWnfjgA0hnVIOkPoPeLLj17
   vHS9UZHE0VjDzFDFbgnvyABFqNSxEq2pbNOxFf9v7VHNDJTOyKiI/vn0M
   7NEmtJmBP+1pxFR+Xlk2VN1Obsd4hejOQeL5K4u5ICmbKHWuHoj2hRy9o
   wlUPgT4wEemseqtDtC0UlXEZ8ndD2Y+x0D00eD3ua61hk2GfOsAC3/o3g
   /gi3pXQJjbFT+yHNZif2AdUI2KVyXSlN9wzIdQlWXBOZBUyyazL5/C4QO
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,361,1635199200"; 
   d="scan'208";a="22042294"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 11 Feb 2022 15:28:03 +0100
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 059D1280075;
        Fri, 11 Feb 2022 15:28:03 +0100 (CET)
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
Subject: [PATCH v2 9/9] [DNI] arm64: dts: tqma8mqml: add IMX327 MIPI-CSI overlay
Date:   Fri, 11 Feb 2022 15:27:52 +0100
Message-Id: <20220211142752.779952-10-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211142752.779952-1-alexander.stein@ew.tq-group.com>
References: <20220211142752.779952-1-alexander.stein@ew.tq-group.com>
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB144B272D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 14:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350579AbiBKNbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 08:31:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350572AbiBKNbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 08:31:00 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E50F2BE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 05:30:59 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1nIW0V-0005wy-IV; Fri, 11 Feb 2022 14:30:39 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1nIW0T-009juP-2v; Fri, 11 Feb 2022 14:30:37 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Robin van der Gracht <robin@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v3 2/5] ARM: dts: imx6dl-prtvt7: Add missing tvp5150 video decoder node
Date:   Fri, 11 Feb 2022 14:30:32 +0100
Message-Id: <20220211133035.2321330-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220211133035.2321330-1-o.rempel@pengutronix.de>
References: <20220211133035.2321330-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin van der Gracht <robin@protonic.nl>

Add missing tvp5150 video decoder node to make composite video input
work.

Signed-off-by: Robin van der Gracht <robin@protonic.nl>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/imx6dl-prtvt7.dts | 42 +++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-prtvt7.dts b/arch/arm/boot/dts/imx6dl-prtvt7.dts
index be7c4cb339e7..baaa6ffc4df9 100644
--- a/arch/arm/boot/dts/imx6dl-prtvt7.dts
+++ b/arch/arm/boot/dts/imx6dl-prtvt7.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 #include "imx6dl.dtsi"
 #include "imx6qdl-prti6q.dtsi"
+#include <dt-bindings/display/sdtv-standards.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/sound/fsl-imx-audmux.h>
@@ -171,6 +172,18 @@ panel_in: endpoint {
 		};
 	};
 
+	connector {
+		compatible = "composite-video-connector";
+		label = "Composite0";
+		sdtv-standards = <SDTV_STD_PAL_B>;
+
+		port {
+			comp0_out: endpoint {
+				remote-endpoint = <&tvp5150_comp0_in>;
+			};
+		};
+	};
+
 	reg_bl_12v0: regulator-bl-12v0 {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -295,6 +308,31 @@ sgtl5000: audio-codec@a {
 		VDDIO-supply = <&reg_3v3>;
 		VDDD-supply = <&reg_1v8>;
 	};
+
+	video@5c {
+		compatible = "ti,tvp5150";
+		reg = <0x5c>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+
+			tvp5150_comp0_in: endpoint {
+				remote-endpoint = <&comp0_out>;
+			};
+		};
+
+		/* Output port 2 is video output pad */
+		port@2 {
+			reg = <2>;
+
+			tvp5151_to_ipu1_csi0_mux: endpoint {
+				remote-endpoint = <&ipu1_csi0_mux_from_parallel_sensor>;
+			};
+		};
+	};
 };
 
 &i2c3 {
@@ -322,6 +360,10 @@ &ipu1_di0_disp0 {
 	remote-endpoint = <&display_in>;
 };
 
+&ipu1_csi0_mux_from_parallel_sensor {
+	remote-endpoint = <&tvp5151_to_ipu1_csi0_mux>;
+};
+
 &pwm1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
-- 
2.30.2


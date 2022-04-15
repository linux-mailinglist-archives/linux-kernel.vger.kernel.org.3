Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8149450287F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 12:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352458AbiDOKxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 06:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352406AbiDOKwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 06:52:42 -0400
Received: from mxout4.routing.net (mxout4.routing.net [IPv6:2a03:2900:1:a::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034743A5F1;
        Fri, 15 Apr 2022 03:50:13 -0700 (PDT)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout4.routing.net (Postfix) with ESMTP id 676DA100770;
        Fri, 15 Apr 2022 10:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1650019812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LB1Fy7OsMtsEl7x4ThJWUnVjP7eO5zGGMTmEHLEcvp0=;
        b=UiSFVDiHH0VKsEEJGo1JRnjUxdWuyg3ksgL7cYQKeyUcjIQz8d1IiEg7KUXVV+Lh0F5ToZ
        CU4S6dh4FvXTDBr+so0ftw6g5PmWBTCSzn7yqlDWOONPWAe1CE6Iooax2dPv/AaPD88aoO
        uQs05isNeVhkl7gNnP/hKh+V1OCF0Sk=
Received: from localhost.localdomain (fttx-pool-217.61.153.244.bambit.de [217.61.153.244])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 4FC3610074F;
        Fri, 15 Apr 2022 10:50:11 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: rockchip: enable vop2 and hdmi tx on BPI-R2-Pro
Date:   Fri, 15 Apr 2022 12:49:50 +0200
Message-Id: <20220415104951.27104-3-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220415104951.27104-1-linux@fw-web.de>
References: <20220415104951.27104-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 65da6b53-325e-43b0-a251-c92be1d4911d
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Enable the RK356x Video Output Processor (VOP) 2 on the
BananaPi R2 Pro board.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 .../boot/dts/rockchip/rk3568-bpi-r2-pro.dts   | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
index 0950f9659bb4..cc3591251bab 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
@@ -8,6 +8,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/soc/rockchip,vop2.h>
 #include "rk3568.dtsi"
 
 / {
@@ -54,6 +55,17 @@ dc_12v: dc-12v {
 		regulator-max-microvolt = <12000000>;
 	};
 
+	hdmi-con {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
 	vcc3v3_sys: vcc3v3-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_sys";
@@ -184,6 +196,24 @@ &gmac1m1_rgmii_clk
 	status = "okay";
 };
 
+&hdmi {
+	avdd-0v9-supply = <&vdda0v9_image>;
+	avdd-1v8-supply = <&vcca1v8_image>;
+	status = "okay";
+};
+
+&hdmi_in {
+	hdmi_in_vp0: endpoint {
+		remote-endpoint = <&vp0_out_hdmi>;
+	};
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
 &i2c0 {
 	status = "okay";
 
@@ -600,3 +630,20 @@ &usb2phy0_otg {
 	phy-supply = <&vcc5v0_usb_otg>;
 	status = "okay";
 };
+
+&vop {
+	assigned-clocks = <&cru DCLK_VOP0>, <&cru DCLK_VOP1>;
+	assigned-clock-parents = <&pmucru PLL_HPLL>, <&cru PLL_VPLL>;
+	status = "okay";
+};
+
+&vop_mmu {
+	status = "okay";
+};
+
+&vp0 {
+	vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
+		reg = <ROCKCHIP_VOP2_EP_HDMI0>;
+		remote-endpoint = <&hdmi_in_vp0>;
+	};
+};
-- 
2.25.1


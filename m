Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8DB2478888
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 11:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbhLQKNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 05:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbhLQKM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 05:12:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A61C06173F;
        Fri, 17 Dec 2021 02:12:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30B95B82789;
        Fri, 17 Dec 2021 10:12:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DEABC36AF3;
        Fri, 17 Dec 2021 10:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639735975;
        bh=x5typq3Mr2F76cJCU3rYh7i3bB0cbEY2vH9vvKOrlKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dEfw07ftNgY6xBg89DVEGh+9i0MHnBXh08SedDkOgPYY8xL5w/OwLkclllJef+2w4
         US6amcFpDKLwYawixc18o1tLYhbgGtyqadCfc4OoS8+d/vBhtWzavigq+pUaQxHTK0
         NIxXaEf4X00idzo9yHO7DkxPH2V6QC0fgj8MOWJ3IrHornl8Ijl5guxKGvd5jH8U+Z
         V0ZO1aNsoEImU9uLDLptH/nBCl43AeMIxpAiDIXfd1di8E8E2dPaM6FzcduwJ10KrX
         u+YeTeRL705xPCLR0LABwGQH7j26PXVC28zsm/wh0fJS/TfBmM8OqlGfgxrLOkrzvm
         JMN7I/PEVyQ2g==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1myAEP-000g6S-Df; Fri, 17 Dec 2021 11:12:53 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v2 6/7] arm64: dts: hisilicon: Add usb mux hub for hikey970
Date:   Fri, 17 Dec 2021 11:12:50 +0100
Message-Id: <a517832273a0fe1d4c4f5c60a6b619a217fd64d5.1639735742.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639735742.git.mchehab@kernel.org>
References: <cover.1639735742.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Add dt bindings for Kirin 970 USB HUB. Such board comes with an
integrated USB HUB provided via a TI TUSB8041 4-port USB 3.0 hub.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH v2 0/7] at: https://lore.kernel.org/all/cover.1639735742.git.mchehab@kernel.org/

 .../boot/dts/hisilicon/hi3670-hikey970.dts    | 23 +++++++++++++++++++
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     | 10 ++++----
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
index 60594db07041..95ca49f1e455 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
@@ -53,6 +53,29 @@ wlan_en: wlan-en-1-8v {
 		startup-delay-us = <70000>;
 		enable-active-high;
 	};
+
+	usb-hub {
+		compatible = "hisilicon,usbhub";
+		typec-vbus-gpios = <&gpio26 1 0>;
+		otg-switch-gpios = <&gpio4 2 0>;
+		hub-reset-en-gpios = <&gpio0 3 0>;
+		hub-vdd-supply = <&ldo17>;
+		usb-role-switch;
+
+		port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			hikey_usb_ep0: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&dwc3_role_switch>;
+			};
+			hikey_usb_ep1: endpoint@1 {
+				reg = <1>;
+				remote-endpoint = <&rt1711h_ep>;
+			};
+		};
+	};
 };
 
 /*
diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
index b47654b50139..486dc93ab47b 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -915,7 +915,7 @@ usb31_misc_rst: usb31_misc_rst_controller {
 			hisi,rst-syscon = <&usb3_otg_bc>;
 		};
 
-		usb3: hisi_dwc3 {
+		usb3: dwc3 {
 			compatible = "hisilicon,hi3670-dwc3";
 			#address-cells = <2>;
 			#size-cells = <2>;
@@ -925,10 +925,10 @@ usb3: hisi_dwc3 {
 				  <&crg_ctrl HI3670_HCLK_GATE_USB3OTG>,
 				  <&crg_ctrl HI3670_CLK_GATE_USB3OTG_REF>,
 				  <&crg_ctrl HI3670_ACLK_GATE_USB3DVFS>;
-			clock-names = "clk_gate_abb_usb",
-				      "hclk_gate_usb3otg",
-				      "clk_gate_usb3otg_ref",
-				      "aclk_gate_usb3dvfs";
+			clock-names = "abb",
+				      "hclk",
+				      "ref",
+				      "aclk";
 
 			assigned-clocks = <&crg_ctrl HI3670_ACLK_GATE_USB3DVFS>;
 			assigned-clock-rates = <238000000>;
-- 
2.33.1


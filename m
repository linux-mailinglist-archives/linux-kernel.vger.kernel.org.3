Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF304494E55
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 13:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244258AbiATMwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 07:52:24 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:39663 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243898AbiATMwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 07:52:19 -0500
Received: (Authenticated sender: foss@0leil.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 020201BF206;
        Thu, 20 Jan 2022 12:52:11 +0000 (UTC)
From:   quentin.schulz@theobroma-systems.com
To:     robh+dt@kernel.org, heiko@sntech.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Quentin Schulz <foss+kernel@0leil.net>
Subject: [PATCH] arm64: dts: rockchip: fix rk3399-puma-haikou USB OTG mode
Date:   Thu, 20 Jan 2022 13:51:56 +0100
Message-Id: <20220120125156.16217-1-quentin.schulz@theobroma-systems.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

The micro USB3.0 port available on the Haikou evaluation kit for Puma
RK3399-Q7 SoM supports dual-role model (aka drd or OTG) but its support
was broken until now because of missing logic around the ID pin.

This adds proper support for USB OTG on Puma Haikou by "connecting" the
GPIO used for USB ID to the USB3 controller device.

Cc: Quentin Schulz <foss+kernel@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 .../arm64/boot/dts/rockchip/rk3399-puma-haikou.dts |  1 +
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
index 292bb7e80cf3..2564ef28d256 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
@@ -231,6 +231,7 @@ &usbdrd3_0 {
 };
 
 &usbdrd_dwc3_0 {
+	extcon = <&extcon_usb3>;
 	dr_mode = "otg";
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index fb67db4619ea..c9a563ae3cfd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -32,6 +32,13 @@ clkin_gmac: external-gmac-clock {
 		#clock-cells = <0>;
 	};
 
+	extcon_usb3: extcon-usb3 {
+		compatible = "linux,extcon-usb-gpio";
+		id-gpio = <&gpio1 RK_PC2 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb3_id>;
+	};
+
 	vcc1v2_phy: vcc1v2-phy {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc1v2_phy";
@@ -422,6 +429,13 @@ vcc5v0_host_en: vcc5v0-host-en {
 			  <4 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
+
+	usb3 {
+		usb3_id: usb3-id {
+			rockchip,pins =
+			  <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
 };
 
 &sdhci {
-- 
2.34.1


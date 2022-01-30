Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A8D4A3705
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 15:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355274AbiA3Oyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 09:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347262AbiA3OyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 09:54:21 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2D5C061714;
        Sun, 30 Jan 2022 06:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=S+gp2c7uepAhlZJciiIL/NF6cYbDHJeJxuzPgMrFY8g=; b=mPN6X6wIMbhDqic69Dbj6lq9TT
        r+9w8M1ZEb5HLiZSlx+l6vO4PucxtPPZOMLMzCNo+b2+wXKhEcy2T4hqgnOa4GKXUOT2ZMPTArqCO
        /h69W0pupxr9gDwD5JS1C71rkVlJJAA7HR2wBlCFGqqK2uO/IR+N5wm45kSDGshlg628=;
Received: from p200300daa716f900d40f7dfd86c385e0.dip0.t-ipconnect.de ([2003:da:a716:f900:d40f:7dfd:86c3:85e0] helo=Maecks.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nEBYE-0002if-2f; Sun, 30 Jan 2022 15:51:34 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     soc@kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, john@phrozen.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 13/13] ARM: dts: add GPIO support for Airoha EN7523
Date:   Sun, 30 Jan 2022 15:51:16 +0100
Message-Id: <20220130145116.88406-14-nbd@nbd.name>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220130145116.88406-1-nbd@nbd.name>
References: <20220130145116.88406-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Crispin <john@phrozen.org>

Airoha's GPIO controller on their ARM EN7523 SoCs consists of two banks of 32
GPIOs

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 arch/arm/boot/dts/en7523-evb.dts |  8 ++++++++
 arch/arm/boot/dts/en7523.dtsi    | 20 ++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/en7523-evb.dts b/arch/arm/boot/dts/en7523-evb.dts
index 0a79f5f6c311..cd9cded5b564 100644
--- a/arch/arm/boot/dts/en7523-evb.dts
+++ b/arch/arm/boot/dts/en7523-evb.dts
@@ -33,3 +33,11 @@ &pcie0 {
 &pcie1 {
 	status = "okay";
 };
+
+&gpio0 {
+	status = "okay";
+};
+
+&gpio1 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/en7523.dtsi b/arch/arm/boot/dts/en7523.dtsi
index b897fb6cffd2..8932e2ab96b6 100644
--- a/arch/arm/boot/dts/en7523.dtsi
+++ b/arch/arm/boot/dts/en7523.dtsi
@@ -3,6 +3,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/en7523-clk.h>
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -123,6 +124,25 @@ uart1: serial@1fbf0000 {
 		status = "okay";
 	};
 
+	gpio0: gpio@1fbf0200 {
+		compatible = "airoha,en7523-gpio";
+		reg = <0x1fbf0204 0x4>,
+		      <0x1fbf0200 0x4>,
+		      <0x1fbf0220 0x4>,
+		      <0x1fbf0214 0x4>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio1: gpio@1fbf0270 {
+		compatible = "airoha,en7523-gpio";
+		reg = <0x1fbf0270 0x4>,
+		      <0x1fbf0260 0x4>,
+		      <0x1fbf0264 0x4>,
+		      <0x1fbf0278 0x4>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 
 	pcie0: pcie@1fa91000 {
 		compatible = "airoha,en7523-pcie", "mediatek,mt7622-pcie";
-- 
2.32.0 (Apple Git-132)


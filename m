Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D6847B52A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 22:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhLTV1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 16:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbhLTV1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 16:27:19 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31655C061574;
        Mon, 20 Dec 2021 13:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3CCFqbnJaEsNHKIy+EIUHks7M8kzr8LfqnwggzuMonk=; b=pUcNCjAlQtlQcoB/oKfXoiMAaL
        92PBdHF4tZ/bAh+XP7Ak40x51MxGCr4bjoZelJYO0gQEICa4ZOjUHKtZuLvcPSsK+DKYgPGfzZ/bP
        9HVPafS2wTte0r7fRptvcl6C5o53lPI/jZkj7hYPD4DZFg1Z0JVjzRRhEPR1HkP4/lwM=;
Received: from p54ae911a.dip0.t-ipconnect.de ([84.174.145.26] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mzQ3v-0000zo-9r; Mon, 20 Dec 2021 22:19:15 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     john@phrozen.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 14/14] ARM: dts: add GPIO support for Airoha EN7523
Date:   Mon, 20 Dec 2021 22:18:54 +0100
Message-Id: <20211220211854.89452-15-nbd@nbd.name>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211220211854.89452-1-nbd@nbd.name>
References: <20211220211854.89452-1-nbd@nbd.name>
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
index 862da104d6f2..d9cc5a1b83b8 100644
--- a/arch/arm/boot/dts/en7523.dtsi
+++ b/arch/arm/boot/dts/en7523.dtsi
@@ -3,6 +3,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/en7523-clk.h>
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -120,6 +121,25 @@ uart1: serial@1fbf0000 {
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
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5C84676D5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 12:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351907AbhLCL6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 06:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbhLCL6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:58:12 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2056C06173E;
        Fri,  3 Dec 2021 03:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=JvONQWCJsHnDyCyBVeKU/6qlvcXXNWDR5qe13qM8lnM=; b=GxJdWteE8trZ48jQuYJg8f0LV9
        r1pyzzR5lY2AEjwgxvqJEm9f7Bhme8bJ4bk8yytaUyHoaTANTUFtlUKJ/xaY204vgKEYYfkuDwk9m
        T+A5hwKhpHPDyaa+n4A2eFplXt+haVFSPnCZQAbJ9L4iJYQXScHdceKCJJVUvtemlu2g=;
Received: from p54ae943f.dip0.t-ipconnect.de ([84.174.148.63] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mt6p2-0004Ez-Qj; Fri, 03 Dec 2021 12:33:48 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     john@phrozen.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 14/14] ARM: dts: add GPIO support for Airoha EN7523
Date:   Fri,  3 Dec 2021 12:33:31 +0100
Message-Id: <20211203113331.20510-15-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20211203113331.20510-1-nbd@nbd.name>
References: <20211203113331.20510-1-nbd@nbd.name>
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
2.30.1


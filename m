Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBBF14660EF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhLBJ53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:57:29 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:49049 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356825AbhLBJ4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:56:44 -0500
Received: (Authenticated sender: herve.codina@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPA id 2AC5E240009;
        Thu,  2 Dec 2021 09:53:16 +0000 (UTC)
From:   Herve Codina <herve.codina@bootlin.com>
To:     Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 4/6] ARM: dts: spear3xx: Use plgpio regmap in SPEAr310 and SPEAr320
Date:   Thu,  2 Dec 2021 10:52:53 +0100
Message-Id: <20211202095255.165797-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202095255.165797-1-herve.codina@bootlin.com>
References: <20211202095255.165797-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resources used by plgpio and pinmux are conflicting on SPEAr310
and SPEAr320.

Use the newly introduced regmap property in plgpio node to use
pinmux resources from plgpio and so avoid the conflict.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 arch/arm/boot/dts/spear310.dtsi | 1 +
 arch/arm/boot/dts/spear320.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/spear310.dtsi b/arch/arm/boot/dts/spear310.dtsi
index 8ce751a1376d..77570833d46b 100644
--- a/arch/arm/boot/dts/spear310.dtsi
+++ b/arch/arm/boot/dts/spear310.dtsi
@@ -92,6 +92,7 @@ serial@b2200000 {
 			gpiopinctrl: gpio@b4000000 {
 				compatible = "st,spear-plgpio";
 				reg = <0xb4000000 0x1000>;
+				regmap = <&pinmux>;
 				#interrupt-cells = <1>;
 				interrupt-controller;
 				gpio-controller;
diff --git a/arch/arm/boot/dts/spear320.dtsi b/arch/arm/boot/dts/spear320.dtsi
index 3bc1e93a0a55..47ac4474ed96 100644
--- a/arch/arm/boot/dts/spear320.dtsi
+++ b/arch/arm/boot/dts/spear320.dtsi
@@ -120,6 +120,7 @@ serial@a4000000 {
 			gpiopinctrl: gpio@b3000000 {
 				compatible = "st,spear-plgpio";
 				reg = <0xb3000000 0x1000>;
+				regmap = <&pinmux>;
 				#interrupt-cells = <1>;
 				interrupt-controller;
 				gpio-controller;
-- 
2.31.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFFC4A9849
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 12:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358286AbiBDLPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 06:15:50 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44184 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358144AbiBDLPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 06:15:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15754B834FA;
        Fri,  4 Feb 2022 11:15:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191C8C340F0;
        Fri,  4 Feb 2022 11:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643973344;
        bh=+lkpa6kOGh3Lq5B7G4GtRG7N4JHFU8GzcTpPpfNyE/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SuJ9GlEATshafp5wt7OKx1ikd+8ibzIe3I75hOvi36A9jTEeMNv+J4+OcWGx57Kqn
         xovlyZQc4ODVm0idjaEuZzzC9x27eLxqDlhTYIGlZ8XoDqyz6SQgHyIP0ctKwmwsXr
         cF/6QZkrsFX7UJ5WPpA48AYN46k9jrOBzYU7BiasGeWi+jI7hUZk2s+O1ppIi7HyNg
         U3mkMworWwqtcMLybrU7MSHDjXcCG+qElrnbNU8pYwIfyW72QPRMlevwYJw9aBrBSN
         bAswxqv+ndiRf0mu5hX018K9McZ95UbmmIJ7+logpaXGqhPsQbpzltRb5B2FGHeVRX
         yTwVomAi/3MCg==
From:   Roger Quadros <rogerq@kernel.org>
To:     nm@ti.com
Cc:     kishon@ti.com, vigneshr@ti.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v3 2/2] arm64: dts: ti: k3-am64-main: Add ELM (Error Location Module) node
Date:   Fri,  4 Feb 2022 13:15:33 +0200
Message-Id: <20220204111533.10787-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220204111533.10787-1-rogerq@kernel.org>
References: <20220204111533.10787-1-rogerq@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ELM module is used for GPMC NAND accesses for detecting
and correcting errors during reads due to NAND bitflips errors.

4-, 8-, and 16-bit error-correction levels are supported using
the BCH (Bose-ChaudhurI-Hocquenghem) algorithm.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 9 +++++++++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts  | 4 ++++
 arch/arm64/boot/dts/ti/k3-am642-sk.dts   | 4 ++++
 3 files changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 94ea5c304d73..b17620e999a5 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -1308,4 +1308,13 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
+
+	elm0: ecc@25010000 {
+		compatible = "ti,am3352-elm";
+		reg = <0x00 0x25010000 0x00 0x2000>;
+		interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 54 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 54 0>;
+		clock-names = "fck";
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 6bd0c0876865..0252218282c2 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -682,3 +682,7 @@
 &gpmc0 {
 	status = "disabled";
 };
+
+&elm0 {
+	status = "disabled";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 40706aa61514..1d91b7ec8912 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -537,3 +537,7 @@
 &gpmc0 {
 	status = "disabled";
 };
+
+&elm0 {
+	status = "disabled";
+};
-- 
2.17.1


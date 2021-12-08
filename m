Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70AA146D434
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbhLHNTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:19:23 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60930 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbhLHNTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:19:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8FB1B8169E;
        Wed,  8 Dec 2021 13:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0E6C341CA;
        Wed,  8 Dec 2021 13:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638969347;
        bh=sP1X52euc3a3IC3rrT+6kJqmIt9xXd3lURVpwfwOqyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jghHbfX7ORnQUeGwArie1uIWyYaZ9lfJ3pYM38FcQomdWeXHvVRPLgXK93XQDiVfi
         h+eZqukg2EKSdmXOtQH9E6g0FzRziGwIMNi5mK8ggWI/mFpEltzJv4c90gecGtZfjJ
         7iCUeg/sljQCf6/zFo0WdJ/h2Cpa9/ERdBX8QIxqpkiyrD9TFIDu6pYCboQtf97F+j
         FS96/sGrLYy2sSh9DpWvKuTULPG/eDueEcuVIXTUsQqRwYltCO/jrOCtMELfjsQPtW
         iet9pDMQJO4buB0YyUFt5ztns/fCnqIA/cFGaAhjr2FyxqYT6gjRx9Jm1Cj5B1Z6GL
         sINARbKfxBFwg==
From:   Roger Quadros <rogerq@kernel.org>
To:     nm@ti.com
Cc:     kishon@ti.com, vigneshr@ti.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 2/2] arm64: dts: ti: k3-am64-main: Add ELM (Error Location Module) node
Date:   Wed,  8 Dec 2021 15:15:36 +0200
Message-Id: <20211208131536.23667-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211208131536.23667-1-rogerq@kernel.org>
References: <20211208131536.23667-1-rogerq@kernel.org>
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
index 830bfc0929b9..179b3a6706c9 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -1272,4 +1272,13 @@
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
index e13866a6e131..d6037dc664ec 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -642,3 +642,7 @@
 &gpmc0 {
 	status = "disabled";
 };
+
+&elm0 {
+	status = "disabled";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index e2793202af38..788813ab294f 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -529,3 +529,7 @@
 &gpmc0 {
 	status = "disabled";
 };
+
+&elm0 {
+	status = "disabled";
+};
-- 
2.17.1


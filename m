Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357BB46CA0B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 02:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239485AbhLHBiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 20:38:01 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:5643 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239381AbhLHBh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 20:37:58 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1B818kPL089262;
        Wed, 8 Dec 2021 09:08:46 +0800 (GMT-8)
        (envelope-from tommy_huang@aspeedtech.com)
Received: from tommy0527-VirtualBox.aspeedtech.com (192.168.2.141) by
 TWMBX02.aspeed.com (192.168.0.24) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 8 Dec 2021 09:33:44 +0800
From:   Tommy Haung <tommy_huang@aspeedtech.com>
To:     <joel@jms.id.au>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <robh+dt@kernel.org>, <andrew@aj.id.au>,
        <linux-aspeed@lists.ozlabs.org>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>, tommy-huang <tommy_huang@aspeedtech.com>
Subject: [PATCH v5 2/7] ARM: dts: aspeed: ast2600-evb: Enable GFX device
Date:   Wed, 8 Dec 2021 09:33:32 +0800
Message-ID: <20211208013337.13806-3-tommy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211208013337.13806-1-tommy_huang@aspeedtech.com>
References: <20211208013337.13806-1-tommy_huang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.2.141]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1B818kPL089262
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joel Stanley <joel@jms.id.au>

Enable the GFX device with a framebuffer memory region.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: tommy-huang <tommy_huang@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-ast2600-evb.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
index b7eb552640cb..e223dad2abd0 100644
--- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
@@ -23,6 +23,19 @@
 		reg = <0x80000000 0x80000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		gfx_memory: framebuffer {
+			size = <0x01000000>;
+			alignment = <0x01000000>;
+			compatible = "shared-dma-pool";
+			reusable;
+		};
+	};
+
 	vcc_sdhci0: regulator-vcc-sdhci0 {
 		compatible = "regulator-fixed";
 		regulator-name = "SDHCI0 Vcc";
@@ -300,3 +313,8 @@
 	vqmmc-supply = <&vccq_sdhci1>;
 	clk-phase-sd-hs = <7>, <200>;
 };
+
+&gfx {
+	status = "okay";
+	memory-region = <&gfx_memory>;
+};
-- 
2.17.1


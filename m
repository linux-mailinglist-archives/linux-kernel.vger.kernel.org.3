Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34074A9C04
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359780AbiBDPdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:33:47 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:30192 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359758AbiBDPdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:33:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1643988825; x=1675524825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cMuHKZNdUu+zY6CdLdDCUWTRhz2pGKkgXeGpnTamYJQ=;
  b=2h8fXKgOVw91o8ltCvmi9EnCnVk9H+MjBoWN/ddCMyTdlbtMu5FlQ9jg
   tP2ZwmDrB1EHe28ndsVwHQQEztx0wf2UYoimkWqv4ieRm1gIojs6rKKJN
   Xo3EfU9qiMqQ3l86bJlGZk9geGRlWteSN/KmtqVdcRFXwYaNvpCDVuxUP
   btkX6bpx5V0ZJZ2+rYO9v4XRw7y8RfDsr7O7vLGzRx9qv4EvGOV4uAc5/
   +I4x3rxzsJwCfnTy2Khfw/b04mb7khbrhwScLAKVcM36SqAUkvndAKXoW
   HdeDKNKl1xkPsPwidIdQt1dWwVdYTcw5kHST9Sh97PRxY3m9bX84GzCa+
   A==;
IronPort-SDR: zpZdcWx37nKUNCq1otdCfN9xDfpo9XBmq4KvCYeAQV+8TuLvlspfalhFwIiH8pGgnTHshrIjjp
 OURIJqpcWtTPf+RZ5NTrz1hzdnQTbmIugMAT+VL9SuLhJ0JYP59d7kQNqNl132NfS/QJOxLuQg
 I+hRQCDIicV/4dovh7IQONReCDyTJk3feoq7mhRHjdzY3wY6J6i0y7sSomGy3XHYGVITkcnTkw
 y0wQTffP9lxZb6TNYFuHyT+qCWNyWXZadqOJPHIJjWlB6JASRAT6qQT/thOq9RX9ehT1IExfcH
 pAGFoszifsopF/mXTr34MzTg
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="147655033"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Feb 2022 08:33:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Feb 2022 08:33:44 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 4 Feb 2022 08:33:42 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <lars.povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
        <UNGLinuxDriver@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH 2/2] arm64: dts: sparx5: Fix for sgpio nodes
Date:   Fri, 4 Feb 2022 16:35:35 +0100
Message-ID: <20220204153535.465827-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220204153535.465827-1-horatiu.vultur@microchip.com>
References: <20220204153535.465827-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the support for irqs was added for sgpio driver the memory size was
not updated. Because the irq registers are found at address 0x108.

Fixes: d0f482bb06f944 ("arm64: dts: sparx5: Add the Sparx5 switch node")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 arch/arm64/boot/dts/microchip/sparx5.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index 787ebcec121d..b9f2e2fa3d43 100644
--- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
@@ -305,7 +305,7 @@ sgpio0: gpio@61101036c {
 			pinctrl-names = "default";
 			resets = <&reset 0>;
 			reset-names = "switch";
-			reg = <0x6 0x1101036c 0x100>;
+			reg = <0x6 0x1101036c 0x118>;
 			sgpio_in0: gpio@0 {
 				compatible = "microchip,sparx5-sgpio-bank";
 				reg = <0>;
@@ -335,7 +335,7 @@ sgpio1: gpio@611010484 {
 			pinctrl-names = "default";
 			resets = <&reset 0>;
 			reset-names = "switch";
-			reg = <0x6 0x11010484 0x100>;
+			reg = <0x6 0x11010484 0x118>;
 			sgpio_in1: gpio@0 {
 				compatible = "microchip,sparx5-sgpio-bank";
 				reg = <0>;
@@ -365,7 +365,7 @@ sgpio2: gpio@61101059c {
 			pinctrl-names = "default";
 			resets = <&reset 0>;
 			reset-names = "switch";
-			reg = <0x6 0x1101059c 0x100>;
+			reg = <0x6 0x1101059c 0x118>;
 			sgpio_in2: gpio@0 {
 				reg = <0>;
 				compatible = "microchip,sparx5-sgpio-bank";
-- 
2.33.0


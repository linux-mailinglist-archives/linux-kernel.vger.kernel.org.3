Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8234A9C05
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359764AbiBDPdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:33:45 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:30192 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiBDPdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:33:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1643988823; x=1675524823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jn5W82d/PJK3RnYJ6ylz47sRhGybpqB76SGsGUGEZVM=;
  b=paRxI6rGmvShWleGskGgadyw1zNgolDmYBWMi8OXcFjeIG0Rr/bf+mO7
   t9OWtuU+AjxU+Wpbxv2Bm7Zql2TgKBjSTY9eqy1Z4iAvJrEhmSNbDxdHv
   FOEBsKK5qHu2xmqR21MCoRwYYCSG1LvkcLYZ6dNCn2SDjmU7DZXy1v6wv
   O1feE9wr9yG4mff/M3+L8P+S2PSJiIt7QZgGnJHK/er9KiPU60owMWQPu
   CH09ExIxd9+aurhXQE81Ql1FhrZ+8e07REauGqpBIUWrLBdUNxrfr98nk
   4+sXpXlaAm+RGJpvhlQBxJ5cR3XiVZfSTmWyPSJyS0qll2A5CkujYDM73
   g==;
IronPort-SDR: j5wnxlThHVdkXuQxtk+Tk+TGGIpyOvHJINBjssfTRHmI842ZTHd2r5ThjUC6aXtSbZ3Lo2A8gj
 aMaGtiLlvig7OYjxkGsqMTJRErX1MYUaBD82g8lSvK9U475S2rto6u0traVXhPftz+XKaeJgg/
 kzw/z79fqvvJRoZeo0A292mzaaTaeuyOTwQrCFmHmuYfFLKKkOan7X/hgzkxRRJOxgj/KjWtuu
 O0lEUpUVfISGCX5+9raisCUSxxOWeoOLBPY1FUjdthwCUnb21/MfUyH+jdrEP7AQIgZ0vKzkZT
 ut1Vld9KLFCWihDurYLddgRf
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="147655023"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Feb 2022 08:33:42 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Feb 2022 08:33:42 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 4 Feb 2022 08:33:40 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <lars.povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
        <UNGLinuxDriver@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH 1/2] dt-bindings: pinctrl: pinctrl-microchip-sgpio: Fix example
Date:   Fri, 4 Feb 2022 16:35:34 +0100
Message-ID: <20220204153535.465827-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220204153535.465827-1-horatiu.vultur@microchip.com>
References: <20220204153535.465827-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The blamed commit adds support for irq, but the reqisters for irq are
outside of the memory size. They are at address 0x108. Therefore update
the memory size to cover all the registers used by the device.

Fixes: 01a9350bdd49fb ("dt-bindings: pinctrl: pinctrl-microchip-sgpio: Add irq support")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 .../devicetree/bindings/pinctrl/microchip,sparx5-sgpio.yaml     | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/microchip,sparx5-sgpio.yaml b/Documentation/devicetree/bindings/pinctrl/microchip,sparx5-sgpio.yaml
index cb554084bdf1..0df4e114fdd6 100644
--- a/Documentation/devicetree/bindings/pinctrl/microchip,sparx5-sgpio.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/microchip,sparx5-sgpio.yaml
@@ -145,7 +145,7 @@ examples:
       clocks = <&sys_clk>;
       pinctrl-0 = <&sgpio2_pins>;
       pinctrl-names = "default";
-      reg = <0x1101059c 0x100>;
+      reg = <0x1101059c 0x118>;
       microchip,sgpio-port-ranges = <0 0>, <16 18>, <28 31>;
       bus-frequency = <25000000>;
       sgpio_in2: gpio@0 {
-- 
2.33.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086C147B37C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 20:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240729AbhLTTJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 14:09:01 -0500
Received: from aposti.net ([89.234.176.197]:34358 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240701AbhLTTI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 14:08:59 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     list@opendingux.net, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/2] dt-bindings: mmc: ingenic: Support using bi-directional DMA channel
Date:   Mon, 20 Dec 2021 19:08:39 +0000
Message-Id: <20211220190840.108061-2-paul@crapouillou.net>
In-Reply-To: <20211220190840.108061-1-paul@crapouillou.net>
References: <20211220190840.108061-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the binding documentation and the examples to support
bi-directional DMA channels.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 .../devicetree/bindings/mmc/ingenic,mmc.yaml  | 37 ++++++++++++++++---
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/ingenic,mmc.yaml b/Documentation/devicetree/bindings/mmc/ingenic,mmc.yaml
index 01d5c6da0eeb..2d10aedf2e00 100644
--- a/Documentation/devicetree/bindings/mmc/ingenic,mmc.yaml
+++ b/Documentation/devicetree/bindings/mmc/ingenic,mmc.yaml
@@ -39,14 +39,15 @@ properties:
     const: mmc
 
   dmas:
-    items:
-      - description: DMA controller phandle and request line for RX
-      - description: DMA controller phandle and request line for TX
+    minItems: 1
+    maxItems: 2
 
   dma-names:
-    items:
-      - const: rx
-      - const: tx
+    oneOf:
+      - items:
+          - const: rx
+          - const: tx
+      - const: tx-rx
 
 required:
   - compatible
@@ -80,3 +81,27 @@ examples:
              <&dma JZ4780_DMA_MSC0_TX 0xffffffff>;
       dma-names = "rx", "tx";
     };
+  - |
+    #include <dt-bindings/clock/ingenic,jz4780-cgu.h>
+    #include <dt-bindings/dma/jz4780-dma.h>
+    /*
+     * Alternative version of the example above,
+     * but using one single DMA channel for both
+     * TX and RX.
+     */
+    mmc1: mmc@13460000 {
+      compatible = "ingenic,jz4780-mmc";
+      reg = <0x13460000 0x1000>;
+
+      interrupt-parent = <&intc>;
+      interrupts = <36>;
+
+      clocks = <&cgu JZ4780_CLK_MSC1>;
+      clock-names = "mmc";
+
+      cap-sd-highspeed;
+      cap-mmc-highspeed;
+      cap-sdio-irq;
+      dmas = <&dma JZ4780_DMA_MSC1_TX JZ4780_DMA_MSC1_RX 0xffffffff>;
+      dma-names = "tx-rx";
+    };
-- 
2.34.1


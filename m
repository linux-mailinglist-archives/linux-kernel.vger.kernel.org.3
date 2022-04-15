Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DCC502D0D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346900AbiDOPkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355557AbiDOPkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:40:07 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B263EBBD;
        Fri, 15 Apr 2022 08:37:18 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E3968240002;
        Fri, 15 Apr 2022 15:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650037037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2CL2yuVd3kigzfVSkE0/5mfrLXFod+JkAYraYwsI5yU=;
        b=E0bCZnAtw7mEYIG9Lxb2FhuK+XOefo+1mlfdCuptDQfMS03GW3jhFQACfrs1xGkoZez/8f
        o3g2gdR5OgGW0egF8rxwp9BzfaY4jRkwaWovaZBzHfZPkRZsP2hCAFvici5AlVasxFD2yk
        jWnEdQAQEUxh8YwBIwqkhyae2/JqBgqWiFBZAgRfSuFCOnzr0DUUDo/K+X1+iSJ1koWTcZ
        915RZebkKE/xIE9OTU6t+XHt5720HaecDc+Qzza9GwxcQxoRJvIb097pFovQs5uCkkwr7s
        tBtje/ucy8P9BHQsckP+vcvame0ab5YqUfaaiSu10M4c0WvyZTlz6TAbHQyMvA==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 1/4] dt-bindings: media: Add Allwinner A31 ISP bindings documentation
Date:   Fri, 15 Apr 2022 17:37:05 +0200
Message-Id: <20220415153708.637804-2-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220415153708.637804-1-paul.kocialkowski@bootlin.com>
References: <20220415153708.637804-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces YAML bindings documentation for the Allwinner A31 Image
Signal Processor (ISP).

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../media/allwinner,sun6i-a31-isp.yaml        | 117 ++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml

diff --git a/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml
new file mode 100644
index 000000000000..ffca216b841f
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml
@@ -0,0 +1,117 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/allwinner,sun6i-a31-isp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner A31 Image Signal Processor Driver (ISP) Device Tree Bindings
+
+maintainers:
+  - Paul Kocialkowski <paul.kocialkowski@bootlin.com>
+
+properties:
+  compatible:
+    enum:
+      - allwinner,sun6i-a31-isp
+      - allwinner,sun8i-v3s-isp
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Bus Clock
+      - description: Module Clock
+      - description: DRAM Clock
+
+  clock-names:
+    items:
+      - const: bus
+      - const: mod
+      - const: ram
+
+  resets:
+    maxItems: 1
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        description: CSI0 input port
+
+        properties:
+          reg:
+            const: 0
+
+          endpoint:
+            $ref: /schemas/graph.yaml#/$defs/endpoint-base
+            unevaluatedProperties: false
+
+        additionalProperties: false
+
+      port@1:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        description: CSI1 input port
+
+        properties:
+          reg:
+            const: 0
+
+          endpoint:
+            $ref: /schemas/graph.yaml#/$defs/endpoint-base
+            unevaluatedProperties: false
+
+        additionalProperties: false
+
+    anyOf:
+      - required:
+        - port@0
+      - required:
+        - port@1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/sun8i-v3s-ccu.h>
+    #include <dt-bindings/reset/sun8i-v3s-ccu.h>
+
+    isp: isp@1cb8000 {
+        compatible = "allwinner,sun8i-v3s-isp";
+        reg = <0x01cb8000 0x1000>;
+        interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&ccu CLK_BUS_CSI>,
+             <&ccu CLK_CSI1_SCLK>,
+             <&ccu CLK_DRAM_CSI>;
+        clock-names = "bus", "mod", "ram";
+        resets = <&ccu RST_BUS_CSI>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+
+                isp_in_csi0: endpoint {
+                    remote-endpoint = <&csi0_out_isp>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.35.2


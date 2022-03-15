Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02574DA485
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 22:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351943AbiCOVWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 17:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239608AbiCOVWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 17:22:02 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B86F5B3F3;
        Tue, 15 Mar 2022 14:20:49 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 0FC1B1F42BBB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647379248;
        bh=tQqfNRntYK0gQYFiWjGgyBq66FzjlHnza9MyAlo7SoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hBQpOiLZ7B6v9RyVoB7nXjXGpkZ25gXuYbYIgCqlkpm+xRAMCF6EfeLPONjrYSBF6
         3BPu2Y5f6SdfnPt0+7opbJv0GCM404MYieMopv/UJW3wmll+MTLbUAppDR1sxw9bhS
         r7loE7VPvhDZscgTbBdVii6WyV0natSXJ9UJRDkI98IvKP3kPIbFL7r8s5q86rL1qC
         dNZU2vOiIEcNWUtohsZ3pnRnX/AvAPj9NXGBqrF+ssRixJLjMV7ZmNq4qiuKA2YMN3
         ccHfr8ADDwySkzeFUtE4C54Ovk7FP03d7N/hFawan7LYrhHRDMlC1rzQe1x/xEIFlR
         DC8Ktt8DI239w==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v1 1/4] dt-bindings: pinctrl: mt8192: Add wrapping node for pin configurations
Date:   Tue, 15 Mar 2022 17:19:33 -0400
Message-Id: <20220315211936.442708-2-nfraprado@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220315211936.442708-1-nfraprado@collabora.com>
References: <20220315211936.442708-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On mt8192, the pinctrl node has pinctrl groups to group pin
configurations. Each pinctrl group contains one or more pinmux subnodes
to list needed pins and their configurations. By supporting multiple
subnodes, we can configure different pin characteristics
(driving/pull-up/pull-down/etc.) in a pinctrl group.

Update the mt8192 pinctrl dt-binding to add the missing pinctrl group
node that wraps the pinmux subnodes and update the example at the end.
While at it, also remove the example embedded in the description since
it is redundant to the already supplied example at the end.

This same change was done for mt8195 in commit 79dcd4e840cc ("dt-bindings:
pinctrl: mt8195: add wrapping node of pin configurations").

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 .../bindings/pinctrl/pinctrl-mt8192.yaml      | 92 ++++++++++---------
 1 file changed, 47 insertions(+), 45 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml
index 3c84676a167d..d63e23d9ed16 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml
@@ -51,62 +51,55 @@ properties:
 
 #PIN CONFIGURATION NODES
 patternProperties:
-  '^pins':
+  '-pins$':
     type: object
-    description: |
-      A pinctrl node should contain at least one subnodes representing the
-      pinctrl groups available on the machine. Each subnode will list the
-      pins it needs, and how they should be configured, with regard to muxer
-      configuration, pullups, drive strength, input enable/disable and
-      input schmitt.
-      An example of using macro:
-      pincontroller {
-        /* GPIO0 set as multifunction GPIO0 */
-        state_0_node_a {
-          pinmux = <PINMUX_GPIO0__FUNC_GPIO0>;
-        };
-        /* GPIO1 set as multifunction PWM */
-        state_0_node_b {
-          pinmux = <PINMUX_GPIO1__FUNC_PWM_1>;
-        };
-      };
-    $ref: "pinmux-node.yaml"
-
-    properties:
-      pinmux:
+    additionalProperties: false
+    patternProperties:
+      '^pins':
+        type: object
         description: |
-          Integer array, represents gpio pin number and mux setting.
-          Supported pin number and mux varies for different SoCs, and are defined
-          as macros in dt-bindings/pinctrl/<soc>-pinfunc.h directly.
+          A pinctrl node should contain at least one subnodes representing the
+          pinctrl groups available on the machine. Each subnode will list the
+          pins it needs, and how they should be configured, with regard to muxer
+          configuration, pullups, drive strength, input enable/disable and
+          input schmitt.
+        $ref: "pinmux-node.yaml"
 
-      drive-strength:
-        description: |
-          It can support some arguments, such as MTK_DRIVE_4mA, MTK_DRIVE_6mA, etc. See
-          dt-bindings/pinctrl/mt65xx.h. It can only support 2/4/6/8/10/12/14/16mA in mt8192.
-        enum: [2, 4, 6, 8, 10, 12, 14, 16]
+        properties:
+          pinmux:
+            description: |
+              Integer array, represents gpio pin number and mux setting.
+              Supported pin number and mux varies for different SoCs, and are defined
+              as macros in dt-bindings/pinctrl/<soc>-pinfunc.h directly.
 
-      bias-pull-down: true
+          drive-strength:
+            description: |
+              It can support some arguments, such as MTK_DRIVE_4mA, MTK_DRIVE_6mA, etc. See
+              dt-bindings/pinctrl/mt65xx.h. It can only support 2/4/6/8/10/12/14/16mA in mt8192.
+            enum: [2, 4, 6, 8, 10, 12, 14, 16]
 
-      bias-pull-up: true
+          bias-pull-down: true
 
-      bias-disable: true
+          bias-pull-up: true
 
-      output-high: true
+          bias-disable: true
 
-      output-low: true
+          output-high: true
 
-      input-enable: true
+          output-low: true
 
-      input-disable: true
+          input-enable: true
 
-      input-schmitt-enable: true
+          input-disable: true
 
-      input-schmitt-disable: true
+          input-schmitt-enable: true
 
-    required:
-      - pinmux
+          input-schmitt-disable: true
 
-    additionalProperties: false
+        required:
+          - pinmux
+
+        additionalProperties: false
 
 allOf:
   - $ref: "pinctrl.yaml#"
@@ -151,8 +144,17 @@ examples:
                     interrupts = <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH 0>;
                     #interrupt-cells = <2>;
 
-                    pins {
-                      pinmux = <PINMUX_GPIO0__FUNC_GPIO0>;
-                      output-low;
+                    spi1-default-pins {
+                            pins-cs-mosi-clk {
+                                    pinmux = <PINMUX_GPIO157__FUNC_SPI1_A_CSB>,
+                                             <PINMUX_GPIO159__FUNC_SPI1_A_MO>,
+                                             <PINMUX_GPIO156__FUNC_SPI1_A_CLK>;
+                                    bias-disable;
+                            };
+
+                            pins-miso {
+                                    pinmux = <PINMUX_GPIO158__FUNC_SPI1_A_MI>;
+                                    bias-pull-down;
+                            };
                     };
             };
-- 
2.35.1


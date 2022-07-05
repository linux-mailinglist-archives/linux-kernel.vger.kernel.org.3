Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F225B565FFC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 02:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiGEAFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 20:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiGEAFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 20:05:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B8CB49D;
        Mon,  4 Jul 2022 17:05:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ACD04B815D1;
        Tue,  5 Jul 2022 00:05:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214DCC3411E;
        Tue,  5 Jul 2022 00:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656979504;
        bh=nUuGZzXB3lm/BS5eqFFgRGH6y+AP1FVcEon7bhUr3Hc=;
        h=From:To:Cc:Subject:Date:From;
        b=OZblpWXWvnI5Ww9hfS92j/UpBX/Fw5JzbrPCSOoZAy8MJpRUEd1Lt5gEjCySPThet
         2IEk/qgtFzjdcSiryhx/dq4UVwkuEEpeEsbWioc2nOBjtMHVrQhhELWv02us5mcMdw
         npASJJ2lQQuf8NdaLQGrgzcCW2ULe/8u686ceSozS0iigxEIawtOg3f3Z85RVR22UX
         NWqosrr8x3xn6Y5k/KYSdNngODhozB7Qdfx13X5D6U+nSkxoybhQ/KLUxd2Oy9AMAb
         rz9Vwfha+1NCxJxsUChHftUcFQ3/Up7aMa/N7OwnS+U77IR2VdCs1BdP73yIZ2+wNj
         t5NzZ3aP7lL3Q==
Received: by pali.im (Postfix)
        id 10D4079F; Tue,  5 Jul 2022 02:05:01 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: leds: Add cznic,turris1x-leds.yaml binding
Date:   Tue,  5 Jul 2022 02:04:47 +0200
Message-Id: <20220705000448.14337-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device-tree bindings documentation for Turris 1.x RGB LEDs.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 .../bindings/leds/cznic,turris1x-leds.yaml    | 116 ++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/cznic,turris1x-leds.yaml

diff --git a/Documentation/devicetree/bindings/leds/cznic,turris1x-leds.yaml b/Documentation/devicetree/bindings/leds/cznic,turris1x-leds.yaml
new file mode 100644
index 000000000000..fd09613c8d2d
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/cznic,turris1x-leds.yaml
@@ -0,0 +1,116 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/cznic,turris1x-leds.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: CZ.NIC's Turris 1.x LEDs driver
+
+maintainers:
+  - Pali Rohár <pali@kernel.org>
+
+description:
+  This module adds support for the RGB LEDs found on the front panel of the
+  Turris 1.x routers. There are 8 RGB LEDs that are controlled by CZ.NIC CPLD
+  firmware running on Lattice FPGA. Firmware is open source and available at
+  https://gitlab.nic.cz/turris/hw/turris_cpld/-/blob/master/CZ_NIC_Router_CPLD.v
+
+properties:
+  compatible:
+    const: cznic,turris1x-leds
+
+  reg:
+    maxItems: 2
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^multi-led@[0-7]$":
+    type: object
+    $ref: leds-class-multicolor.yaml#
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 7
+
+    required:
+      - reg
+
+additionalProperties: false
+
+examples:
+  - |
+
+    #include <dt-bindings/leds/common.h>
+
+    cpld@3,0 {
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        led-controller@13 {
+            compatible = "cznic,turris1x-leds";
+            reg = <0x13 0x1d>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            multi-led@0 {
+                    reg = <0x0>;
+                    color = <LED_COLOR_ID_RGB>;
+                    function = LED_FUNCTION_WAN;
+            };
+
+            multi-led@1 {
+                    reg = <0x1>;
+                    color = <LED_COLOR_ID_RGB>;
+                    function = LED_FUNCTION_LAN;
+                    function-enumerator = <5>;
+            };
+
+            multi-led@2 {
+                    reg = <0x2>;
+                    color = <LED_COLOR_ID_RGB>;
+                    function = LED_FUNCTION_LAN;
+                    function-enumerator = <4>;
+            };
+
+            multi-led@3 {
+                    reg = <0x3>;
+                    color = <LED_COLOR_ID_RGB>;
+                    function = LED_FUNCTION_LAN;
+                    function-enumerator = <3>;
+            };
+
+            multi-led@4 {
+                    reg = <0x4>;
+                    color = <LED_COLOR_ID_RGB>;
+                    function = LED_FUNCTION_LAN;
+                    function-enumerator = <2>;
+            };
+
+            multi-led@5 {
+                    reg = <0x5>;
+                    color = <LED_COLOR_ID_RGB>;
+                    function = LED_FUNCTION_LAN;
+                    function-enumerator = <1>;
+            };
+
+            multi-led@6 {
+                    reg = <0x6>;
+                    color = <LED_COLOR_ID_RGB>;
+                    function = LED_FUNCTION_WLAN;
+            };
+
+            multi-led@7 {
+                    reg = <0x7>;
+                    color = <LED_COLOR_ID_RGB>;
+                    function = LED_FUNCTION_POWER;
+            };
+        };
+    };
+
+...
-- 
2.20.1


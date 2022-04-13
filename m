Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9354FEF9C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 08:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbiDMGMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 02:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbiDMGLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:11:15 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8A635A95;
        Tue, 12 Apr 2022 23:08:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1649830121; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=M93nIZCPOTy7SQV7AhKolQJqHKRYb0HMeWy5u3CFe/rvt8PPqPtQw95UKUknVe5ODWabcV8gsvPyQOeEF/zAGuhDUV/k1Ku88DYSFlTX2Pq3Qu7nnVLHkLBNNIKQ/hMh4rEEh7c8gCJ4m2QofkK06Q9Y6g/oCxfKfIse3F/iGgU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1649830121; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=kvX7/HILmGsGFUpCgEqWcAxlrRzLYM66Yu5Zr3A0qRU=; 
        b=CqHrPmHmrixKFMvG4tklbZAyDU7s3eBpyKBl+6ywrWgUgbDBo41vrmGR9LjsUH/mc3/NOSMwIYHKhfpnf3pGauuSa1+z/58SyCYIbKNX0jAuMZcpqSOYWCaxj7ugWPTmp5riPw8AdbM3/UbwQ9o1JGauBAut1HWFJujiSGUiNwU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1649830121;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
        bh=kvX7/HILmGsGFUpCgEqWcAxlrRzLYM66Yu5Zr3A0qRU=;
        b=HMSKAdoVeDvDXwYwl8TCn3j/5OWFwi4jJ6s3ANBs5b4i2bcHwSdEWnu7irnbzQ8Z
        vD0Uos4SwfCoJ9htnCdXDrGuqQLiiQOioVS/2uHOtmVQQWG7GL5uD0zFz9RhK2PDgul
        H+tKD42ueYCVIEBnUecwNnLe8Vh6fdWVP6mc6cuo=
Received: from arinc9-PC.localdomain (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1649830120014391.1248903549166; Tue, 12 Apr 2022 23:08:40 -0700 (PDT)
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     erkin.bozoglu@xeront.com,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: [PATCH 11/14] dt-bindings: pinctrl: add binding for Ralink MT7620 pinctrl
Date:   Wed, 13 Apr 2022 09:07:26 +0300
Message-Id: <20220413060729.27639-12-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413060729.27639-1-arinc.unal@arinc9.com>
References: <20220413060729.27639-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for the Ralink MT7620 pin controller for MT7620, MT7628 and
MT7688 SoCs.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 .../pinctrl/ralink,mt7620-pinctrl.yaml        | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
new file mode 100644
index 000000000000..01578b8aa277
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/ralink,mt7620-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ralink MT7620 Pin Controller
+
+maintainers:
+  - Arınç ÜNAL <arinc.unal@arinc9.com>
+  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
+
+description:
+  Ralink MT7620 pin controller for MT7620, MT7628 and MT7688 SoCs.
+  The pin controller can only set the muxing of pin groups. Muxing indiviual pins
+  is not supported. There is no pinconf support.
+
+properties:
+  compatible:
+    const: ralink,mt7620-pinctrl
+
+patternProperties:
+  '-pins$':
+    type: object
+    patternProperties:
+      '^(.*-)?pinmux$':
+        type: object
+        description: node for pinctrl.
+        $ref: pinmux-node.yaml#
+
+        properties:
+          groups:
+            description: The pin group to select.
+            enum: [
+              # For MT7620 SoC
+              ephy, i2c, mdio, nd_sd, pa, pcie, rgmii1, rgmii2, spi, spi refclk, uartf, uartlite, wdt, wled,
+
+              # For MT7628 and MT7688 SoCs
+              gpio, i2c, i2s, p0led_an, p0led_kn, p1led_an, p1led_kn, p2led_an, p2led_kn, p3led_an,
+              p3led_kn, p4led_an, p4led_kn, perst, pwm0, pwm1, refclk, sdmode, spi, spi cs1, spis, uart0,
+              uart1, uart2, wdt, wled_an, wled_kn,
+            ]
+
+          function:
+            description: The mux function to select.
+            enum: [
+              # For MT7620 SoC
+              ephy, gpio, gpio i2s, gpio uartf, i2c, i2s uartf, mdio, nand, pa, pcie refclk, pcie rst,
+              pcm gpio, pcm i2s, pcm uartf, refclk, rgmii1, rgmii2, sd, spi, spi refclk, uartf, uartlite,
+              wdt refclk, wdt rst, wled,
+
+              # For MT7628 and MT7688 SoCs
+              antenna, debug, gpio, i2c, i2s, jtag, p0led_an, p0led_kn, p1led_an, p1led_kn, p2led_an,
+              p2led_kn, p3led_an, p3led_kn, p4led_an, p4led_kn, pcie, pcm, perst, pwm, pwm0, pwm1,
+              pwm_uart2, refclk, rsvd, sdxc, sdxc d5 d4, sdxc d6, sdxc d7, spi, spi cs1, spis, sw_r, uart0,
+              uart1, uart2, utif, wdt, wled_an, wled_kn, -,
+            ]
+
+        required:
+          - groups
+          - function
+
+        additionalProperties: false
+
+    additionalProperties: false
+
+allOf:
+  - $ref: "pinctrl.yaml#"
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  # Pinmux controller node
+  - |
+    pinctrl {
+      compatible = "ralink,mt7620-pinctrl";
+
+      i2c_pins: i2c0-pins {
+        pinmux {
+          groups = "i2c";
+          function = "i2c";
+        };
+      };
+    };
-- 
2.25.1


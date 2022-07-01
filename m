Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27288563276
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 13:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbiGALZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 07:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbiGALZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:25:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A3897E02E;
        Fri,  1 Jul 2022 04:25:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38D54143D;
        Fri,  1 Jul 2022 04:25:08 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5F063F66F;
        Fri,  1 Jul 2022 04:25:05 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH v12 2/7] dt-bindings: pinctrl: sunxi: Make interrupts optional
Date:   Fri,  1 Jul 2022 12:24:48 +0100
Message-Id: <20220701112453.2310722-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220701112453.2310722-1-andre.przywara@arm.com>
References: <20220701112453.2310722-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The R_PIO pinctrl device on the Allwinner H616 SoC does not have an
interrupt (it features only two pins).
However the binding requires at least naming one upstream interrupt,
plus the #interrupt-cells and interrupt-controller properties.

Drop the unconditional requirement for the interrupt properties, and
make them dependent on being not this particular pinctrl device.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../pinctrl/allwinner,sun4i-a10-pinctrl.yaml      | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
index bfce850c20351..0bd903954195b 100644
--- a/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
@@ -133,14 +133,11 @@ patternProperties:
 
 required:
   - "#gpio-cells"
-  - "#interrupt-cells"
   - compatible
   - reg
-  - interrupts
   - clocks
   - clock-names
   - gpio-controller
-  - interrupt-controller
 
 allOf:
   # FIXME: We should have the pin bank supplies here, but not a lot of
@@ -148,6 +145,18 @@ allOf:
   # warnings.
 
   - $ref: "pinctrl.yaml#"
+  - if:
+      not:
+        properties:
+          compatible:
+            enum:
+              - allwinner,sun50i-h616-r-pinctrl
+    then:
+      required:
+        - "#interrupt-cells"
+        - interrupts
+        - interrupt-controller
+
   - if:
       properties:
         compatible:
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0B359E945
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbiHWRXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238953AbiHWRVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:21:01 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B2E72B42;
        Tue, 23 Aug 2022 07:57:15 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-11d2dcc31dbso8945018fac.7;
        Tue, 23 Aug 2022 07:57:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=6vKFgG/f4olyJVJpZJ7xkmGvVQtzgpp9UOpLpTbBPqo=;
        b=xk3yrcnMijhkRSbZTa9tscnQTB9JxOutcT147dWFBwTZJO7k2U3ihVeGVZUALLXDRr
         E9+ArVKsbte2IKgdph6eq2ejbp6FMLdwzDGTgzx2hMerflGZb2RA4b87e7+7UzCWmLWH
         qB8h74sSmWt/0fKXPYOvoSPqWH5ehuUEG+NntxVyz/pX5yNjwoZSbys5Dwm2H5m8iJ/s
         Io2Tp4xPM9jCEqZ521xIwBvJ2EACXkIn/wpx8C4+HFwBsJR9FOWHQKENzE0zuOdWAqQM
         LUeRm/ycEobroiMCs0DqVRL9VflgUbhryt15t4jmk1mq8U/1io/fU9L72EbKqBlEpj7v
         5wXA==
X-Gm-Message-State: ACgBeo1qLB4DxnGvAeMPvxCwIxAb93gTo7SiEwZHE7xCaBCbEk2Uc23+
        IPqWlfcEzKeTx+dyXI5yJg==
X-Google-Smtp-Source: AA6agR7GsswgCm1oVUYqFahlkY5PDkMbKcIWNl1BzDcfp9UNHL7YH48DtHNxx8jPoayC/XAVDNTv7g==
X-Received: by 2002:a05:6871:152:b0:11d:b1e3:737e with SMTP id z18-20020a056871015200b0011db1e3737emr1079705oab.249.1661266634692;
        Tue, 23 Aug 2022 07:57:14 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id t1-20020a056870600100b0011c65559b04sm3840637oaa.34.2022.08.23.07.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 07:57:13 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Robert Jones <rjones@gateworks.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Ripard <mripard@kernel.org>,
        - <patches@opensource.cirrus.com>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Chris Zhong <zyw@rock-chips.com>,
        Zhang Qing <zhangqing@rock-chips.com>,
        Alistair Francis <alistair@alistair23.me>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Renner Berthing <kernel@esmil.dk>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] dt-bindings: mfd: Add missing (unevaluated|additional)Properties on child nodes
Date:   Tue, 23 Aug 2022 09:56:35 -0500
Message-Id: <20220823145649.3118479-4-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to ensure only documented properties are present, node schemas
must have unevaluatedProperties or additionalProperties set to false
(typically).

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../mfd/allwinner,sun6i-a31-prcm.yaml         | 40 +++++++++++++++++++
 .../mfd/allwinner,sun8i-a23-prcm.yaml         | 10 +++++
 .../bindings/mfd/cirrus,lochnagar.yaml        |  5 +++
 .../devicetree/bindings/mfd/dlg,da9063.yaml   |  7 ++--
 .../bindings/mfd/gateworks-gsc.yaml           |  5 ++-
 .../bindings/mfd/maxim,max14577.yaml          |  1 +
 .../bindings/mfd/maxim,max77843.yaml          |  1 +
 .../bindings/mfd/rockchip,rk817.yaml          |  2 +
 .../bindings/mfd/silergy,sy7636a.yaml         |  1 +
 .../bindings/mfd/st,stm32-lptimer.yaml        |  4 ++
 .../bindings/mfd/st,stm32-timers.yaml         |  3 ++
 .../devicetree/bindings/mfd/st,stmfx.yaml     |  1 +
 .../bindings/mfd/stericsson,ab8500.yaml       | 22 ++++++++++
 .../devicetree/bindings/mfd/ti,tps65086.yaml  |  1 +
 .../bindings/mfd/x-powers,axp152.yaml         |  1 +
 15 files changed, 100 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/allwinner,sun6i-a31-prcm.yaml b/Documentation/devicetree/bindings/mfd/allwinner,sun6i-a31-prcm.yaml
index d131759ccaf3..021d33cb3dd6 100644
--- a/Documentation/devicetree/bindings/mfd/allwinner,sun6i-a31-prcm.yaml
+++ b/Documentation/devicetree/bindings/mfd/allwinner,sun6i-a31-prcm.yaml
@@ -22,6 +22,7 @@ properties:
 patternProperties:
   "^.*_(clk|rst)$":
     type: object
+    unevaluatedProperties: false
 
     properties:
       compatible:
@@ -34,6 +35,45 @@ patternProperties:
           - fixed-factor-clock
 
     allOf:
+      - if:
+          properties:
+            compatible:
+              contains:
+                const: fixed-factor-clock
+
+        then:
+          $ref: /schemas/clock/fixed-factor-clock.yaml#
+
+      - if:
+          properties:
+            compatible:
+              contains:
+                const: allwinner,sun4i-a10-mod0-clk
+
+        then:
+          properties:
+            "#clock-cells":
+              const: 0
+
+            # Already checked in the main schema
+            compatible: true
+
+            clocks:
+              maxItems: 2
+
+            clock-output-names:
+              maxItems: 1
+
+            phandle: true
+
+          required:
+            - "#clock-cells"
+            - compatible
+            - clocks
+            - clock-output-names
+
+          additionalProperties: false
+
       - if:
           properties:
             compatible:
diff --git a/Documentation/devicetree/bindings/mfd/allwinner,sun8i-a23-prcm.yaml b/Documentation/devicetree/bindings/mfd/allwinner,sun8i-a23-prcm.yaml
index aa5e683b236c..01f4f5210574 100644
--- a/Documentation/devicetree/bindings/mfd/allwinner,sun8i-a23-prcm.yaml
+++ b/Documentation/devicetree/bindings/mfd/allwinner,sun8i-a23-prcm.yaml
@@ -22,6 +22,7 @@ properties:
 patternProperties:
   "^.*(clk|rst|codec).*$":
     type: object
+    unevaluatedProperties: false
 
     properties:
       compatible:
@@ -36,6 +37,15 @@ patternProperties:
       - compatible
 
     allOf:
+      - if:
+          properties:
+            compatible:
+              contains:
+                const: fixed-factor-clock
+
+        then:
+          $ref: /schemas/clock/fixed-factor-clock.yaml#
+
       - if:
           properties:
             compatible:
diff --git a/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml b/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml
index ad285cb480c9..86f7341eb7e1 100644
--- a/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml
+++ b/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml
@@ -144,6 +144,7 @@ properties:
       CODECs digital core if not being provided by an internal regulator.
     type: object
     $ref: /schemas/regulator/regulator.yaml#
+    unevaluatedProperties: false
     properties:
       compatible:
         enum:
@@ -161,6 +162,7 @@ properties:
       CODECs MICVDD.
     type: object
     $ref: /schemas/regulator/regulator.yaml#
+    unevaluatedProperties: false
     properties:
       compatible:
         enum:
@@ -177,6 +179,7 @@ properties:
       Initialisation data for the MIC1VDD supplies.
     type: object
     $ref: /schemas/regulator/regulator.yaml#
+    unevaluatedProperties: false
     properties:
       compatible:
         enum:
@@ -202,6 +205,7 @@ properties:
       Initialisation data for the MIC2VDD supplies.
     type: object
     $ref: /schemas/regulator/regulator.yaml#
+    unevaluatedProperties: false
     properties:
       compatible:
         enum:
@@ -228,6 +232,7 @@ properties:
       the CODECs analog and 1.8V digital supplies.
     type: object
     $ref: /schemas/regulator/regulator.yaml#
+    unevaluatedProperties: false
     properties:
       compatible:
         enum:
diff --git a/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml b/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
index d71933460e90..54b47bd4c6aa 100644
--- a/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
+++ b/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
@@ -71,8 +71,9 @@ properties:
 
   regulators:
     type: object
+    additionalProperties: false
     patternProperties:
-      "^(ldo[1-11]|bcore[1-2]|bpro|bmem|bio|bperi)$":
+      "^(ldo([1-9]|1[01])|bcore[1-2]|bpro|bmem|bio|bperi)$":
         $ref: /schemas/regulator/regulator.yaml
         unevaluatedProperties: false
 
@@ -112,7 +113,7 @@ examples:
         };
 
         regulators {
-          regulator-bcore1 {
+          bcore1 {
             regulator-name = "BCORE1";
             regulator-min-microvolt = <300000>;
             regulator-max-microvolt = <1570000>;
@@ -120,7 +121,7 @@ examples:
             regulator-max-microamp = <2000000>;
             regulator-boot-on;
           };
-          regulator-ldo11 {
+          ldo11 {
             regulator-name = "LDO_11";
             regulator-min-microvolt = <900000>;
             regulator-max-microvolt = <3600000>;
diff --git a/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml b/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
index 5e0fe3ebe1d2..acb9c54942d9 100644
--- a/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
+++ b/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
@@ -46,6 +46,7 @@ properties:
 
   adc:
     type: object
+    additionalProperties: false
     description: Optional hardware monitoring module
 
     properties:
@@ -59,8 +60,9 @@ properties:
         const: 0
 
     patternProperties:
-      "^channel@[0-9]+$":
+      "^channel@[0-9a-f]+$":
         type: object
+        additionalProperties: false
         description: |
           Properties for a single ADC which can report cooked values
           (i.e. temperature sensor based on thermister), raw values
@@ -113,6 +115,7 @@ properties:
 patternProperties:
   "^fan-controller@[0-9a-f]+$":
     type: object
+    additionalProperties: false
     description: Optional fan controller
 
     properties:
diff --git a/Documentation/devicetree/bindings/mfd/maxim,max14577.yaml b/Documentation/devicetree/bindings/mfd/maxim,max14577.yaml
index 52edd1bf549f..995e96ee7445 100644
--- a/Documentation/devicetree/bindings/mfd/maxim,max14577.yaml
+++ b/Documentation/devicetree/bindings/mfd/maxim,max14577.yaml
@@ -39,6 +39,7 @@ properties:
 
   extcon:
     type: object
+    additionalProperties: false
     properties:
       compatible:
         enum:
diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77843.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77843.yaml
index f30f96bbff43..2e2a2a86b57d 100644
--- a/Documentation/devicetree/bindings/mfd/maxim,max77843.yaml
+++ b/Documentation/devicetree/bindings/mfd/maxim,max77843.yaml
@@ -32,6 +32,7 @@ properties:
 
   motor-driver:
     type: object
+    additionalProperties: false
     properties:
       compatible:
         const: maxim,max77843-haptic
diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
index bfc1720adc43..9b2378312ce2 100644
--- a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
+++ b/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
@@ -87,6 +87,7 @@ properties:
     patternProperties:
       "^(LDO_REG[1-9]|DCDC_REG[1-4]|BOOST|OTG_SWITCH)$":
         type: object
+        unevaluatedProperties: false
         $ref: ../regulator/regulator.yaml#
     unevaluatedProperties: false
 
@@ -111,6 +112,7 @@ properties:
       additional properties are required for the codec, this node can be
       omitted.
     type: object
+    additionalProperties: false
     properties:
       rockchip,mic-in-differential:
         type: boolean
diff --git a/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
index 6de74c701635..ee0be32ac020 100644
--- a/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
+++ b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
@@ -42,6 +42,7 @@ properties:
       vcom:
         type: object
         $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
         description:
           The regulator for the compenstation voltage. Enabling/disabling this
           enables/disables the entire device.
diff --git a/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml b/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
index a58f08aa430d..d950dd5d48bd 100644
--- a/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
+++ b/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
@@ -46,6 +46,7 @@ properties:
 
   pwm:
     type: object
+    additionalProperties: false
 
     properties:
       compatible:
@@ -60,6 +61,7 @@ properties:
 
   counter:
     type: object
+    additionalProperties: false
 
     properties:
       compatible:
@@ -70,6 +72,7 @@ properties:
 
   timer:
     type: object
+    additionalProperties: false
 
     properties:
       compatible:
@@ -81,6 +84,7 @@ properties:
 patternProperties:
   "^trigger@[0-9]+$":
     type: object
+    additionalProperties: false
 
     properties:
       compatible:
diff --git a/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml b/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
index 5db00af8e116..e2c3c3b44abb 100644
--- a/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
+++ b/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
@@ -69,6 +69,7 @@ properties:
 
   pwm:
     type: object
+    additionalProperties: false
 
     properties:
       compatible:
@@ -104,6 +105,7 @@ properties:
 
   counter:
     type: object
+    additionalProperties: false
 
     properties:
       compatible:
@@ -115,6 +117,7 @@ properties:
 patternProperties:
   "^timer@[0-9]+$":
     type: object
+    additionalProperties: false
 
     properties:
       compatible:
diff --git a/Documentation/devicetree/bindings/mfd/st,stmfx.yaml b/Documentation/devicetree/bindings/mfd/st,stmfx.yaml
index b2a4e4aa7ff6..b4d54302582f 100644
--- a/Documentation/devicetree/bindings/mfd/st,stmfx.yaml
+++ b/Documentation/devicetree/bindings/mfd/st,stmfx.yaml
@@ -57,6 +57,7 @@ properties:
     patternProperties:
       "^[a-zA-Z]*-pins$":
         type: object
+        additionalProperties: false
 
         allOf:
           - $ref: ../pinctrl/pinmux-node.yaml
diff --git a/Documentation/devicetree/bindings/mfd/stericsson,ab8500.yaml b/Documentation/devicetree/bindings/mfd/stericsson,ab8500.yaml
index 623a4b5cd27a..6c8d42f27fe8 100644
--- a/Documentation/devicetree/bindings/mfd/stericsson,ab8500.yaml
+++ b/Documentation/devicetree/bindings/mfd/stericsson,ab8500.yaml
@@ -51,6 +51,7 @@ properties:
       provides the reference clock for the entire U8500 system and
       the DB8500 counterpart.
     type: object
+    additionalProperties: false
 
     properties:
       compatible:
@@ -63,6 +64,7 @@ properties:
     description: Node describing the AB8500 GPIO controller. A few
       GPIO pins available for misc usage.
     type: object
+    additionalProperties: false
 
     properties:
       compatible:
@@ -78,6 +80,7 @@ properties:
   rtc:
     description: Node describing the AB8500 battery-backed RTC.
     type: object
+    additionalProperties: false
 
     properties:
       compatible:
@@ -337,34 +340,40 @@ properties:
         description: The voltage for the auxilary LDO regulator 1
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
 
       ab8500_ldo_aux2:
         description: The voltage for the auxilary LDO regulator 2
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
 
       ab8500_ldo_aux3:
         description: The voltage for the auxilary LDO regulator 3
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
 
       ab8500_ldo_aux4:
         description: The voltage for the auxilary LDO regulator 4
           only present on AB8505
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
 
       ab8500_ldo_aux5:
         description: The voltage for the auxilary LDO regulator 5
           only present on AB8505
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
 
       ab8500_ldo_aux6:
         description: The voltage for the auxilary LDO regulator 6
           only present on AB8505
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
 
       # There is never any AUX7 regulator which is confusing
 
@@ -373,18 +382,21 @@ properties:
           only present on AB8505
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
 
       ab8500_ldo_intcore:
         description: The LDO regulator for the internal core voltage
           of the AB8500
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
 
       ab8500_ldo_adc:
         description: Analog power regulator for the analog to digital converter
           ADC, only present on AB8505
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
 
       ab8500_ldo_tvout:
         description: The voltage for the TV output regulator, incidentally
@@ -393,33 +405,39 @@ properties:
           Only present on AB8500.
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
 
       ab8500_ldo_audio:
         description: The LDO regulator for the audio codec output
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
 
       ab8500_ldo_anamic1:
         description: The LDO regulator for the analog microphone 1
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
 
       ab8500_ldo_anamic2:
         description: The LDO regulator for the analog microphone 2
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
 
       ab8500_ldo_dmic:
         description: The LDO regulator for the digital microphone
           only present on AB8500
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
 
       ab8500_ldo_ana:
         description: Analog power regulator for CSI and DSI interfaces,
           Camera Serial Interface CSI and Display Serial Interface DSI.
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
 
     required:
       - compatible
@@ -442,16 +460,19 @@ properties:
         description: The voltage for the VSMPS1 external regulator
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
 
       ab8500_ext2:
         description: The voltage for the VSMPS2 external regulator
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
 
       ab8500_ext3:
         description: The voltage for the VSMPS3 external regulator
         type: object
         $ref: ../regulator/regulator.yaml#
+        unevaluatedProperties: false
 
     required:
       - compatible
@@ -462,6 +483,7 @@ patternProperties:
   "^pwm@[1-9]+?$":
     type: object
     $ref: ../pwm/pwm.yaml#
+    unevaluatedProperties: false
     description: Represents each of the PWM blocks in the AB8500
 
     properties:
diff --git a/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml b/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
index 6aeedda3be15..3fdd9cb5b347 100644
--- a/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
@@ -38,6 +38,7 @@ properties:
 
   regulators:
     type: object
+    additionalProperties: false
     description: |
       List of child nodes that specify the regulator initialization data.
       Child nodes must be named after their hardware counterparts:
diff --git a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
index 3a53bae611bc..b9b71ba33893 100644
--- a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
+++ b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
@@ -260,6 +260,7 @@ properties:
       "^(([a-f])?ldo[0-9]|dcdc[0-7a-e]|ldo(_|-)io(0|1)|(dc1)?sw|rtc(_|-)ldo|drivevbus|dc5ldo)$":
         $ref: /schemas/regulator/regulator.yaml#
         type: object
+        unevaluatedProperties: false
 
         properties:
           regulator-ramp-delay:
-- 
2.34.1


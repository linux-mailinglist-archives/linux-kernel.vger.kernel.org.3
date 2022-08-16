Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5172C596295
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 20:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbiHPSjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 14:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiHPSjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 14:39:46 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDACF28E23;
        Tue, 16 Aug 2022 11:39:44 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id o14so5803635ilt.2;
        Tue, 16 Aug 2022 11:39:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=1Gx22ZxnAmnMwEfl5YlDrlXFX0Bj7DkuXh1bXl4r6lw=;
        b=Im7+nxtLb2cNm/LC/hX+bHFB88UI0fCE2J8gqNgZPW+2iyfibZemr51GfrB1PEicQq
         rX0B8tX6ufnlqnV1XbsUGnMh+m/n7mzcZg0Xrg7USKoiaitUK7o6v1WLLZn+ZASqLDSw
         OJWgZOP8hSSqhwLiSe6YMFcp3WHHw68sKFZbT6wobFLJrWx8Vr0RRcd4xluqqSeZ1bm8
         VatOHAGDTfZqF+3JUSsM9tSYzU/DZIasV3M7VcFK/DBZybNj3ywjts23krewzt5cfBjE
         9TtLTkHWSdiZToMKWFGzEdEdxvlerztaHX7xXZafVLLrt3nZl7rHmnrvU2htGIiLh+fs
         PV9Q==
X-Gm-Message-State: ACgBeo3SbabxedJVJaGv45fN1yDvN1IbyR6emgOTuzbCAVpDTXMF4rSU
        1SWjrlMX8itvjQp9/joObw==
X-Google-Smtp-Source: AA6agR7E2rTGDXJIItDCaM5J7iKfWFaJQIPjX9CWRwfGAd3Pe8DUwZJclWfapqP077Ab+CQMrVxB2Q==
X-Received: by 2002:a05:6e02:b26:b0:2de:b192:9dfc with SMTP id e6-20020a056e020b2600b002deb1929dfcmr10382551ilu.273.1660675183936;
        Tue, 16 Aug 2022 11:39:43 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id c23-20020a023317000000b00339ceeec5edsm4734843jae.12.2022.08.16.11.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 11:39:43 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC] dt-bindings: pinctrl: brcm: Ensure all child node properties are documented
Date:   Tue, 16 Aug 2022 12:39:10 -0600
Message-Id: <20220816183911.2517173-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Broadcom pinctrl bindings are incomplete for child nodes as they are
missing 'unevaluatedProperties: false' to prevent unknown properties.
Fixing this reveals many warnings including having grandchild nodes in some
cases.

Signed-off-by: Rob Herring <robh@kernel.org>
---
This recursive schema requires a fix not yet committed in dtschema.

I'm looking for feedback on whether group->pins or group->groups is the
right fix here. There's more warnings with this change in the gpio-sysctl
bindings.
---
 .../pinctrl/brcm,bcm6318-pinctrl.yaml         |  5 ++++
 .../pinctrl/brcm,bcm63268-pinctrl.yaml        | 23 +++++++++++--------
 .../pinctrl/brcm,bcm6328-pinctrl.yaml         |  5 ++++
 .../pinctrl/brcm,bcm6358-pinctrl.yaml         |  1 +
 .../pinctrl/brcm,bcm6362-pinctrl.yaml         |  7 +++++-
 .../pinctrl/brcm,bcm6368-pinctrl.yaml         |  7 +++++-
 6 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6318-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6318-pinctrl.yaml
index ab019a1998e8..1792d07e497d 100644
--- a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6318-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6318-pinctrl.yaml
@@ -24,6 +24,7 @@ patternProperties:
   '-pins$':
     type: object
     $ref: pinmux-node.yaml#
+    additionalProperties: false
 
     properties:
       function:
@@ -37,6 +38,10 @@ patternProperties:
         enum: [ gpio0, gpio1, gpio2, gpio3, gpio4, gpio5, gpio6, gpio7,
                 gpio8, gpio9, gpio10, gpio11, gpio12, gpio13, gpio40 ]
 
+    patternProperties:
+      '-pins$':
+        $ref: '#/patternProperties/-pins$'
+
 allOf:
   - $ref: "pinctrl.yaml#"
 
diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm63268-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/brcm,bcm63268-pinctrl.yaml
index 8c9d4668c8c4..7aa1b6738ebf 100644
--- a/Documentation/devicetree/bindings/pinctrl/brcm,bcm63268-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm63268-pinctrl.yaml
@@ -24,6 +24,7 @@ patternProperties:
   '-pins$':
     type: object
     $ref: pinmux-node.yaml#
+    unevaluatedProperties: false
 
     properties:
       function:
@@ -41,6 +42,10 @@ patternProperties:
                 vdsl_phy_override_1_grp, vdsl_phy_override_2_grp,
                 vdsl_phy_override_3_grp, dsl_gpio8, dsl_gpio9 ]
 
+    patternProperties:
+      '-pins$':
+        $ref: '#/patternProperties/-pins$'
+
 allOf:
   - $ref: "pinctrl.yaml#"
 
@@ -122,46 +127,46 @@ examples:
 
       pinctrl_nand: nand-pins {
         function = "nand";
-        group = "nand_grp";
+        pins = "nand_grp";
       };
 
       pinctrl_gpio35_alt: gpio35_alt-pins {
         function = "gpio35_alt";
-        pin = "gpio35";
+        pins = "gpio35";
       };
 
       pinctrl_dectpd: dectpd-pins {
         function = "dectpd";
-        group = "dectpd_grp";
+        pins = "dectpd_grp";
       };
 
       pinctrl_vdsl_phy_override_0: vdsl_phy_override_0-pins {
         function = "vdsl_phy_override_0";
-        group = "vdsl_phy_override_0_grp";
+        pins = "vdsl_phy_override_0_grp";
       };
 
       pinctrl_vdsl_phy_override_1: vdsl_phy_override_1-pins {
         function = "vdsl_phy_override_1";
-        group = "vdsl_phy_override_1_grp";
+        pins = "vdsl_phy_override_1_grp";
       };
 
       pinctrl_vdsl_phy_override_2: vdsl_phy_override_2-pins {
         function = "vdsl_phy_override_2";
-        group = "vdsl_phy_override_2_grp";
+        pins = "vdsl_phy_override_2_grp";
       };
 
       pinctrl_vdsl_phy_override_3: vdsl_phy_override_3-pins {
         function = "vdsl_phy_override_3";
-        group = "vdsl_phy_override_3_grp";
+        pins = "vdsl_phy_override_3_grp";
       };
 
       pinctrl_dsl_gpio8: dsl_gpio8-pins {
         function = "dsl_gpio8";
-        group = "dsl_gpio8";
+        pins = "dsl_gpio8";
       };
 
       pinctrl_dsl_gpio9: dsl_gpio9-pins {
         function = "dsl_gpio9";
-        group = "dsl_gpio9";
+        pins = "dsl_gpio9";
       };
     };
diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6328-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6328-pinctrl.yaml
index a8e22ec02215..e42071abf282 100644
--- a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6328-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6328-pinctrl.yaml
@@ -24,6 +24,7 @@ patternProperties:
   '-pins$':
     type: object
     $ref: pinmux-node.yaml#
+    unevaluatedProperties: false
 
     properties:
       function:
@@ -36,6 +37,10 @@ patternProperties:
                 gpio20, gpio25, gpio26, gpio27, gpio28, hsspi_cs1,
                 usb_port1 ]
 
+    patternProperties:
+      '-pins$':
+        $ref: '#/patternProperties/-pins$'
+
 allOf:
   - $ref: "pinctrl.yaml#"
 
diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6358-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6358-pinctrl.yaml
index 35867355a47a..20dbb1a3c19b 100644
--- a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6358-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6358-pinctrl.yaml
@@ -24,6 +24,7 @@ patternProperties:
   '-pins$':
     type: object
     $ref: pinmux-node.yaml#
+    unevaluatedProperties: false
 
     properties:
       function:
diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6362-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6362-pinctrl.yaml
index b584d4b27223..ac0e775383b9 100644
--- a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6362-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6362-pinctrl.yaml
@@ -24,6 +24,7 @@ patternProperties:
   '-pins$':
     type: object
     $ref: pinmux-node.yaml#
+    unevaluatedProperties: false
 
     properties:
       function:
@@ -41,6 +42,10 @@ patternProperties:
                 gpio15, gpio16, gpio17, gpio18, gpio19, gpio20, gpio21,
                 gpio22, gpio23, gpio24, gpio25, gpio26, gpio27, nand_grp ]
 
+    patternProperties:
+      '-pins$':
+        $ref: '#/patternProperties/-pins$'
+
 allOf:
   - $ref: "pinctrl.yaml#"
 
@@ -204,6 +209,6 @@ examples:
 
       pinctrl_nand: nand-pins {
         function = "nand";
-        group = "nand_grp";
+        pins = "nand_grp";
       };
     };
diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6368-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6368-pinctrl.yaml
index 229323d9237d..91f0ec45c871 100644
--- a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6368-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6368-pinctrl.yaml
@@ -24,6 +24,7 @@ patternProperties:
   '-pins$':
     type: object
     $ref: pinmux-node.yaml#
+    unevaluatedProperties: false
 
     properties:
       function:
@@ -42,6 +43,10 @@ patternProperties:
                 gpio24, gpio25, gpio26, gpio27, gpio28, gpio29, gpio30,
                 gpio31, uart1_grp ]
 
+    patternProperties:
+      '-pins$':
+        $ref: '#/patternProperties/-pins$'
+
 allOf:
   - $ref: "pinctrl.yaml#"
 
@@ -215,6 +220,6 @@ examples:
 
       pinctrl_uart1: uart1-pins {
         function = "uart1";
-        group = "uart1_grp";
+        pins = "uart1_grp";
       };
     };
-- 
2.34.1


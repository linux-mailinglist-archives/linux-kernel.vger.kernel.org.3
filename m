Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAFC51C3E9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 17:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbiEEP33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 11:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381289AbiEEP3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 11:29:19 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9741B13F83;
        Thu,  5 May 2022 08:25:38 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m62so2867452wme.5;
        Thu, 05 May 2022 08:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZT7VKniHc2GWnckoL6MlPZLbnEyYu3dBdYD4+s+IxsM=;
        b=C8t6mAJCq+WIzOm3ph6BRBIpkmNzO8S5iLhTHSeH70Hjw+nsvjx4OkIpVE9A750j/A
         d5dDN1kPWKbiHu3nm/VibKzPwTwXuAElwpwUcqHfdYdIfCzWfcFEbEeobLzdrflybnBF
         BWr6q/MXeVmXPGb0a7X2frx9VYl7kdMMQfY95cy8u/Z8cfe9VYe7HVcQxpwMT+dgpXCe
         ZkBTFz19lmo9sMAa7uX1EDr5/Nl8z2s6756jrM87n6R275ETab+705H9P//tHXYFT+OK
         xV5GydmBDul8Zgi9TW1+6KtxXtH8G8eddMfqbt3EU8tTOjhKzMFFEyXU6eqIsVCCMMAE
         i+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZT7VKniHc2GWnckoL6MlPZLbnEyYu3dBdYD4+s+IxsM=;
        b=edotFQiADyuQyGFbTSls1PWFCB8jddGPA6W4Bg3RPjfwfMMH1bLcM1Rb6088m31Zd/
         oEUSIVa2jdf4V+uwRm5Ba1mP5MxOrFfOQA3nVaf9b8dMKq0MpzK5Clzp9c9NJhCEo2Bs
         Gszhjn2/wFD3LrBgJqogzgMN67RH/3V/xlZtM7q6Zx0jYKyVaPeQY2TQeLivbMgQUJdD
         8sjCkCO2MEAoq3cbBhaFOMGHoO3lsf/y6EmYzpuOIGr6x6ut0U5go8ROiy+vXXZAsRlw
         1LACoTKNGiScEPKc22FlPArVAPlAAX1JazyH6i+wkXMQd0MdUxV1eVzJ0zsKVHx+y/n1
         VVFQ==
X-Gm-Message-State: AOAM530YZrZKUnHwQc9Ghdlr8hFduE4Ddfm6kKzBdCVZRepLqNZmBopo
        bki7KzkN0/z6O3E4vassHdA=
X-Google-Smtp-Source: ABdhPJyMfXNkPjZccwCM1iYOKjcd6z2zdTI0eKyvKaqZuV96XO0gnkHHYm3w65F32UNamNDCeYQDUQ==
X-Received: by 2002:a05:600c:3b9e:b0:394:69e2:267a with SMTP id n30-20020a05600c3b9e00b0039469e2267amr3559662wms.35.1651764337184;
        Thu, 05 May 2022 08:25:37 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id h12-20020a05600016cc00b0020c5253d8e4sm1578679wrf.48.2022.05.05.08.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 08:25:36 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     pavel@ucw.cz
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/3] dt-bindings: leds: convert ktd2692 bindings to yaml
Date:   Thu,  5 May 2022 18:25:17 +0300
Message-Id: <20220505152521.71019-3-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505152521.71019-1-markuss.broks@gmail.com>
References: <20220505152521.71019-1-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts the leds-ktd2692.txt bindings to modern yaml
style device-tree bindings.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 .../bindings/leds/kinetic,ktd2692.yaml        | 87 +++++++++++++++++++
 .../devicetree/bindings/leds/leds-ktd2692.txt | 50 -----------
 2 files changed, 87 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/kinetic,ktd2692.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-ktd2692.txt

diff --git a/Documentation/devicetree/bindings/leds/kinetic,ktd2692.yaml b/Documentation/devicetree/bindings/leds/kinetic,ktd2692.yaml
new file mode 100644
index 000000000000..bac95a51afa1
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/kinetic,ktd2692.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/kinetic,ktd2692.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: KTD2692 Flash LED Driver from Kinetic Technologies
+
+maintainers:
+  - Markuss Broks <markuss.broks@gmail.com>
+
+description: |
+  KTD2692 is the ideal power solution for high-power flash LEDs.
+  It uses ExpressWire single-wire programming for maximum flexibility.
+
+  The ExpressWire interface through CTRL pin can control LED on/off and
+  enable/disable the IC, Movie(max 1/3 of Flash current) / Flash mode current,
+  Flash timeout, LVP(low voltage protection).
+
+  Also, When the AUX pin is pulled high while CTRL pin is high,
+  LED current will be ramped up to the flash-mode current level.
+
+properties:
+  compatible:
+    const: kinetic,ktd2692
+
+  ctrl-gpios:
+    maxItems: 1
+    description: Specifier of the GPIO connected to CTRL pin.
+
+  aux-gpios:
+    maxItems: 1
+    description: Specifier of the GPIO connected to CTRL pin.
+
+  vin-supply:
+    description: LED supply (2.7V to 5.5V).
+
+  led:
+    type: object
+    $ref: common.yaml#
+    description: Properties for the LED.
+    properties:
+      function: true
+      color: true
+      flash-max-timeout-us:
+        description: Flash LED maximum timeout.
+
+      led-max-microamp:
+        maximum: 300000
+        description: Minimum Threshold for Timer protection
+          is defined internally (Maximum 300mA).
+
+      flash-max-microamp:
+        maximum: 300000
+        description: Flash LED maximum current
+          Formula - I(uA) = 15000000 / Rset.
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - ctrl-gpios
+  - led
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/leds/common.h>
+
+    ktd2692 {
+      compatible = "kinetic,ktd2692";
+      ctrl-gpios = <&gpc0 1 0>;
+      aux-gpios = <&gpc0 2 0>;
+      vin-supply = <&vbat>;
+
+      led {
+        function = LED_FUNCTION_FLASH;
+        color = <LED_COLOR_ID_WHITE>;
+        flash-max-timeout-us = <250000>;
+        flash-max-microamp = <150000>;
+        led-max-microamp = <25000>;
+      };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/leds/leds-ktd2692.txt b/Documentation/devicetree/bindings/leds/leds-ktd2692.txt
deleted file mode 100644
index 853737452580..000000000000
--- a/Documentation/devicetree/bindings/leds/leds-ktd2692.txt
+++ /dev/null
@@ -1,50 +0,0 @@
-* Kinetic Technologies - KTD2692 Flash LED Driver
-
-KTD2692 is the ideal power solution for high-power flash LEDs.
-It uses ExpressWire single-wire programming for maximum flexibility.
-
-The ExpressWire interface through CTRL pin can control LED on/off and
-enable/disable the IC, Movie(max 1/3 of Flash current) / Flash mode current,
-Flash timeout, LVP(low voltage protection).
-
-Also, When the AUX pin is pulled high while CTRL pin is high,
-LED current will be ramped up to the flash-mode current level.
-
-Required properties:
-- compatible : Should be "kinetic,ktd2692".
-- ctrl-gpios : Specifier of the GPIO connected to CTRL pin.
-- aux-gpios : Specifier of the GPIO connected to AUX pin.
-
-Optional properties:
-- vin-supply : "vin" LED supply (2.7V to 5.5V).
-  See Documentation/devicetree/bindings/regulator/regulator.txt
-
-A discrete LED element connected to the device must be represented by a child
-node - See Documentation/devicetree/bindings/leds/common.txt
-
-Required properties for flash LED child nodes:
-  See Documentation/devicetree/bindings/leds/common.txt
-- led-max-microamp : Minimum Threshold for Timer protection
-  is defined internally (Maximum 300mA).
-- flash-max-microamp : Flash LED maximum current
-  Formula : I(mA) = 15000 / Rset.
-- flash-max-timeout-us : Flash LED maximum timeout.
-
-Optional properties for flash LED child nodes:
-- label : See Documentation/devicetree/bindings/leds/common.txt
-
-Example:
-
-ktd2692 {
-	compatible = "kinetic,ktd2692";
-	ctrl-gpios = <&gpc0 1 0>;
-	aux-gpios = <&gpc0 2 0>;
-	vin-supply = <&vbat>;
-
-	flash-led {
-		label = "ktd2692-flash";
-		led-max-microamp = <300000>;
-		flash-max-microamp = <1500000>;
-		flash-max-timeout-us = <1835000>;
-	};
-};
-- 
2.35.1


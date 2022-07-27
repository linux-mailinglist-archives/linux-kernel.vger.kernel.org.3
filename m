Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19289582FD0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 19:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242165AbiG0RaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 13:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238218AbiG0R1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 13:27:40 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818457F516
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:47:17 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id p21so12803991ljh.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5hs2L2k4qCWX2gnOpNz9FnyN8tjq/hVKa8FSzGNbvHY=;
        b=Nz0NtvJJcqRxKRT5px1ZtW+FsV3draGdGXgF0M1caY5X80Ck5ISgFnye8Uc4zVnKP+
         NZAJDWjUgAB1QXuRhbz5q7XwylRoJkn6ZrwdtRq+uc4nbfL2dbcdfL3rCVkenbinO2lX
         RkEaydx3XxdbrMXW7MnBOEbMkbp66BAu5KOoqz1fCHNrrFCWndREWI31kaUy4y2GdjSz
         7VhhNvCgBBiBd8t6xRsMoPPNJsS6jBWIjX4E52O+5eQWrf57+LgA/gYg0tr+wkLL09Hi
         j1BkwCmAnJazmJetMngMGCZm0ksdNSqRd/eDy/klK1zvtCHT/G7lCeZ7cM426Xw314zr
         GFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5hs2L2k4qCWX2gnOpNz9FnyN8tjq/hVKa8FSzGNbvHY=;
        b=s38XAjx3Eggeg0YRWU1cf9xB7BYI25Bp4LF/Fjr1IBCtoQ39XUV6JP6oGGbVKraxrD
         k1EHtJ2QOs9UaLryBpZU5EzYWWX/skylMkUphtVC6BPsqb2XXR0Ed5jx4OnlF2+TQO94
         wOddnNVSFK9b1IHoJkcBnaVe6UClsTBdl65hBNmEFPE0tw1/KOKG/CX5f4tabf/3u7LX
         GijPfva2DWti+qmLZ+FcE8MTMNrAdbc0cSkQWAKnyWakEymrF4daE/ifeFeTeZfQHin+
         jSztjD0gzJpquw8H531/rZ/5xFgNWeZkg3IH1X7/+ZDiqlXTlAC499PI5y6nhAtpekCj
         jcBA==
X-Gm-Message-State: AJIora/xIUWZS5UGAT7qblYV5KxX5pS45Fc9w7Ol2mptN3ncAIMH59tu
        JOyiMSq03AG8hwR59YvPmNr07w==
X-Google-Smtp-Source: AGRyM1tnLBvt1C5HTanFjLIbWJ2+62dBBeJtU9YqyUQ6RsYe+3R4sNIhehgwrriDI2l1EWHaP57Qqw==
X-Received: by 2002:a2e:780a:0:b0:25d:f5af:856d with SMTP id t10-20020a2e780a000000b0025df5af856dmr7663949ljc.222.1658940433759;
        Wed, 27 Jul 2022 09:47:13 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id 18-20020ac25f52000000b0048910301774sm3375149lfz.307.2022.07.27.09.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 09:47:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lucas Stankus <lucas.p.stankus@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Oleksij Rempel <linux@rempel-privat.de>, kernel@pengutronix.de,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Stefan Popa <stefan.popa@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Joachim Eastwood <manabian@gmail.com>,
        Tomas Melin <tomas.melin@vaisala.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Beniamin Bia <beniamin.bia@analog.com>,
        Patrick Vasseur <patrick.vasseur@c-s.fr>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexandru Lazar <alazar@startmail.com>,
        Oskar Andero <oskar.andero@gmail.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <martenli@axis.com>,
        Bogdan Pricop <bogdan.pricop@emutex.com>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Dan Murphy <dmurphy@ti.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Phil Reid <preid@electromag.com.au>,
        Michael Welling <mwelling@ieee.org>,
        Lukas Wunner <lukas@wunner.de>,
        Robert Jones <rjones@gateworks.com>,
        Chris Coffey <cmc@babblebit.net>,
        Slawomir Stepien <sst@poczta.fm>,
        Sankar Velliangiri <navin@linumiz.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 04/10] dt-bindings: iio: dac: use spi-peripheral-props.yaml
Date:   Wed, 27 Jul 2022 18:46:40 +0200
Message-Id: <20220727164646.387541-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220727164646.387541-1-krzysztof.kozlowski@linaro.org>
References: <20220727164646.387541-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of listing directly properties typical for SPI peripherals,
reference the spi-peripheral-props.yaml schema.  This allows using all
properties typical for SPI-connected devices, even these which device
bindings author did not tried yet.

Remove the spi-* properties which now come via spi-peripheral-props.yaml
schema, except for the cases when device schema adds some constraints
like maximum frequency.

While changing additionalProperties->unevaluatedProperties, put it in
typical place, just before example DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/iio/dac/adi,ad5064.yaml          | 7 +++----
 .../devicetree/bindings/iio/dac/adi,ad5360.yaml          | 7 +++----
 .../devicetree/bindings/iio/dac/adi,ad5380.yaml          | 9 +++++----
 .../devicetree/bindings/iio/dac/adi,ad5421.yaml          | 7 ++++---
 .../devicetree/bindings/iio/dac/adi,ad5449.yaml          | 7 +++----
 .../devicetree/bindings/iio/dac/adi,ad5624r.yaml         | 9 +++++----
 .../devicetree/bindings/iio/dac/adi,ad5686.yaml          | 9 +++++----
 .../devicetree/bindings/iio/dac/adi,ad5755.yaml          | 9 +++++----
 .../devicetree/bindings/iio/dac/adi,ad5758.yaml          | 4 ++--
 .../devicetree/bindings/iio/dac/adi,ad5761.yaml          | 7 +++----
 .../devicetree/bindings/iio/dac/adi,ad5764.yaml          | 7 +++----
 .../devicetree/bindings/iio/dac/adi,ad5770r.yaml         | 7 ++++---
 .../devicetree/bindings/iio/dac/adi,ad5791.yaml          | 9 +++++----
 .../devicetree/bindings/iio/dac/adi,ad8801.yaml          | 7 +++----
 .../devicetree/bindings/iio/dac/microchip,mcp4922.yaml   | 9 +++++----
 .../devicetree/bindings/iio/dac/ti,dac082s085.yaml       | 9 +++++----
 .../devicetree/bindings/iio/dac/ti,dac7311.yaml          | 7 ++++---
 .../devicetree/bindings/iio/dac/ti,dac7612.yaml          | 7 ++++---
 18 files changed, 71 insertions(+), 66 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5064.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5064.yaml
index 05ed4e0ec364..c04165fa9259 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5064.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5064.yaml
@@ -95,15 +95,12 @@ properties:
   vrefD-supply: true
   vref-supply: true
 
-  spi-max-frequency: true
-
-additionalProperties: false
-
 required:
   - compatible
   - reg
 
 allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
   - # Shared external vref, no internal reference
     if:
       properties:
@@ -232,6 +229,8 @@ allOf:
         - vrefA-supply
         - vrefB-supply
 
+unevaluatedProperties: false
+
 examples:
   - |
     spi {
diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5360.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5360.yaml
index 65f86f26947c..86e2884cdfb1 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5360.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5360.yaml
@@ -28,10 +28,6 @@ properties:
   vref1-supply: true
   vref2-supply: true
 
-  spi-max-frequency: true
-
-additionalProperties: false
-
 required:
   - compatible
   - reg
@@ -39,6 +35,7 @@ required:
   - vref1-supply
 
 allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
   - if:
       properties:
         compatible:
@@ -63,6 +60,8 @@ allOf:
       required:
         - vref2-supply
 
+unevaluatedProperties: false
+
 examples:
   - |
     spi {
diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5380.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5380.yaml
index d599b418a020..ff50c72c62b5 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5380.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5380.yaml
@@ -39,14 +39,15 @@ properties:
     description:
       If not supplied devices will use internal regulators.
 
-  spi-max-frequency: true
-
-additionalProperties: false
-
 required:
   - compatible
   - reg
 
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
 examples:
   - |
     spi {
diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5421.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5421.yaml
index 188f656617e3..52d089ebde95 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5421.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5421.yaml
@@ -26,13 +26,14 @@ properties:
     maxItems: 1
     description: Fault signal.
 
-  spi-max-frequency: true
-
 required:
   - compatible
   - reg
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5449.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5449.yaml
index 044332c97743..d2af2d491986 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5449.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5449.yaml
@@ -27,19 +27,16 @@ properties:
   reg:
     maxItems: 1
 
-  spi-max-frequency: true
-
   VREF-supply: true
   VREFA-supply: true
   VREFB-supply: true
 
-additionalProperties: false
-
 required:
   - compatible
   - reg
 
 allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
   - if:
       properties:
         compatible:
@@ -72,6 +69,8 @@ allOf:
         - VREFA-supply
         - VREFB-supply
 
+unevaluatedProperties: false
+
 examples:
   - |
     spi {
diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5624r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5624r.yaml
index 330383b85eeb..4d5111a5f9bd 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5624r.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5624r.yaml
@@ -22,17 +22,18 @@ properties:
   reg:
     maxItems: 1
 
-  spi-max-frequency: true
-
   vref-supply:
     description: If not present, internal reference will be used.
 
-additionalProperties: false
-
 required:
   - compatible
   - reg
 
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
 examples:
   - |
     spi {
diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
index 5c26441eae9f..13f214234b8e 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
@@ -53,14 +53,15 @@ properties:
   vcc-supply:
     description: If not supplied the internal reference is used.
 
-  spi-max-frequency: true
-
-additionalProperties: false
-
 required:
   - compatible
   - reg
 
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
 examples:
   - |
     spi {
diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5755.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5755.yaml
index f866b88e1440..9a3c2926bf85 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5755.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5755.yaml
@@ -25,8 +25,6 @@ properties:
     description: Either this or spi-cpol but not both.
   spi-cpol: true
 
-  spi-max-frequency: true
-
   adi,ext-dc-dc-compenstation-resistor:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
@@ -67,8 +65,6 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
-
 patternProperties:
   "^channel@[0-7]$":
     type: object
@@ -123,6 +119,11 @@ oneOf:
   - required:
       - spi-cpol
 
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
 examples:
   - |
     spi {
diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml
index fd4edca34a28..e49e7556175d 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml
@@ -16,7 +16,6 @@ properties:
   reg:
     maxItems: 1
 
-  spi-max-frequency: true
   spi-cpha: true
 
   adi,dc-dc-mode:
@@ -99,6 +98,7 @@ required:
   - adi,dc-dc-mode
 
 allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
   - if:
       properties:
         adi,dc-dc-mode:
@@ -115,7 +115,7 @@ allOf:
       required:
         - adi,range-microvolt
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5761.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5761.yaml
index 7f95a9ed55fe..df550b5af2f7 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5761.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5761.yaml
@@ -22,18 +22,15 @@ properties:
   reg:
     maxItems: 1
 
-  spi-max-frequency: true
-
   vref-supply:
     description: If not supplied, internal reference will be used.
 
-additionalProperties: false
-
 required:
   - compatible
   - reg
 
 allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
   - if:
       properties:
         compatible:
@@ -45,6 +42,8 @@ allOf:
       required:
         - vref-supply
 
+unevaluatedProperties: false
+
 examples:
   - |
     spi {
diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5764.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5764.yaml
index 8e893d52bfb1..0b409a727a43 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5764.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5764.yaml
@@ -22,18 +22,15 @@ properties:
   reg:
     maxItems: 1
 
-  spi-max-frequency: true
-
   vrefAB-supply: true
   vrefCD-supply: true
 
-additionalProperties: false
-
 required:
   - compatible
   - reg
 
 allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
   - if:
       properties:
         compatible:
@@ -46,6 +43,8 @@ allOf:
         - vrefAB-supply
         - vrefCD-supply
 
+unevaluatedProperties: false
+
 examples:
   - |
     spi {
diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
index 24ac40180ac1..ca5432ffdedb 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
@@ -49,8 +49,6 @@ properties:
       asserted during driver probe.
     maxItems: 1
 
-  spi-max-frequency: true
-
   '#address-cells':
     const: 1
 
@@ -138,7 +136,10 @@ required:
   - channel@4
   - channel@5
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
index 650d1ebdcec3..3a84739736f6 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
@@ -23,19 +23,20 @@ properties:
   reg:
     maxItems: 1
 
-  spi-max-frequency: true
-
   vdd-supply: true
   vss-supply: true
 
-additionalProperties: false
-
 required:
   - compatible
   - reg
   - vdd-supply
   - vss-supply
 
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
 examples:
   - |
     spi {
diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad8801.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad8801.yaml
index 6a3990a8d0ad..1849a2ff05c7 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad8801.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad8801.yaml
@@ -19,19 +19,16 @@ properties:
   reg:
     maxItems: 1
 
-  spi-max-frequency: true
-
   vrefh-supply: true
   vrefl-supply: true
 
-additionalProperties: false
-
 required:
   - compatible
   - reg
   - vrefh-supply
 
 allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
   - if:
       properties:
         compatible:
@@ -44,6 +41,8 @@ allOf:
       properties:
         vrefl-supply: false
 
+unevaluatedProperties: false
+
 examples:
   - |
     spi {
diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp4922.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4922.yaml
index 4c430abcdbf9..19374401e509 100644
--- a/Documentation/devicetree/bindings/iio/dac/microchip,mcp4922.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4922.yaml
@@ -21,17 +21,18 @@ properties:
   reg:
     maxItems: 1
 
-  spi-max-frequency: true
-
   vref-supply: true
 
-additionalProperties: false
-
 required:
   - compatible
   - reg
   - vref-supply
 
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
 examples:
   - |
     spi {
diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac082s085.yaml b/Documentation/devicetree/bindings/iio/dac/ti,dac082s085.yaml
index b0157050f1ee..201b04af2b22 100644
--- a/Documentation/devicetree/bindings/iio/dac/ti,dac082s085.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/ti,dac082s085.yaml
@@ -33,21 +33,22 @@ properties:
   vref-supply:
     description: Needed to provide output scaling.
 
-  spi-max-frequency: true
-
 required:
   - compatible
   - reg
   - vref-supply
 
-additionalProperties: false
-
 oneOf:
   - required:
       - spi-cpha
   - required:
       - spi-cpol
 
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
 examples:
   - |
     vref_2v5_reg: regulator-vref {
diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac7311.yaml b/Documentation/devicetree/bindings/iio/dac/ti,dac7311.yaml
index 10be98d1f19c..a6814587dbc4 100644
--- a/Documentation/devicetree/bindings/iio/dac/ti,dac7311.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/ti,dac7311.yaml
@@ -24,14 +24,15 @@ properties:
       Reference voltage must be supplied to establish the scaling of the
       output voltage.
 
-  spi-max-frequency: true
-
 required:
   - compatible
   - reg
   - vref-supply
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml b/Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml
index d172b142f6ed..20dd1370660d 100644
--- a/Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml
@@ -29,13 +29,14 @@ properties:
       DACs are loaded when the pin connected to this GPIO is pulled low.
     maxItems: 1
 
-  spi-max-frequency: true
-
 required:
   - compatible
   - reg
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1


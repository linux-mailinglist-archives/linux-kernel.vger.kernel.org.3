Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A9D595C10
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235544AbiHPMos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbiHPMoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:44:15 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEE913F94
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:43:46 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id v2so14751307lfi.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=5hs2L2k4qCWX2gnOpNz9FnyN8tjq/hVKa8FSzGNbvHY=;
        b=y4qreQTlptq3ZLtXKHi4z9s1pf/uhl2u76QyATsQs64fwvjWvgBOmVWipn8JZ4ta5E
         0b/KtZW87knXYSh+CRSGp9MwAdQCc9jjgQaqAa14Glb/z33FfysjfbulgJWFJVpbOzdZ
         rMVW6pOgAIQt8EeGuDk/gFTaTdMcjAPZ/WN4tvQVy/GdGIKjWi87C3mvUJRgXHjKWfXU
         xv/YZTiENEup3HJFtmApuho+2jDekt97D4DQO4hwMSb4Kro/K82RnahZ3RWg37NFmDY5
         SENrG6hwmedH6hL80bNdtS7XVRzCk4houLlhyT/EzvhGxh6SXpMD/rRKSdFQYI4OZmJh
         tlvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=5hs2L2k4qCWX2gnOpNz9FnyN8tjq/hVKa8FSzGNbvHY=;
        b=3qlAzTg3cxEzESJo38jwV9T3MRFaE5KG0fhOe34god+y90h9E/UPRIBGQSxOtJUdi8
         8TkdvaSK+03N2uKBHGGcCKrSK8As007zM/SahZa4Cbu8bMNq7KHXi2mmciDqQQ0nNdtD
         vzmH6/Q+MaK323qqzUMAucX7m5ucxmIvqSocr6I95HIRyyXR9OJswFYrX0Ok96oxmVF4
         ivUbY0SAhMVz/xEYyPMVcq98cFICFrPtt3RFG6tFgUdR0UfFpmxZp0/j/COsrCvoz4yM
         f4li7hI+8ipeKTdCAFqbqmoCDhq5oVXYnf6fwbQMoueVdPTBigCcRmyXBRd0bdzZkuyC
         G05w==
X-Gm-Message-State: ACgBeo2bbm94iwwi4nfO+ZIYxBIZWFdUZhEbJ1fJ4dWtRbAMz4DSYZvV
        ugBUjMqTIdg0NZ5MsNUkRmcmHg==
X-Google-Smtp-Source: AA6agR6FX9mBswwyGojrokUrfZDhAdQaWazy4yS3SeMZ8KSw/baYtaZh4Ry0OA+WpeLB+Bhi/NRBDw==
X-Received: by 2002:a05:6512:16a1:b0:48a:87a2:103c with SMTP id bu33-20020a05651216a100b0048a87a2103cmr7923987lfb.554.1660653823793;
        Tue, 16 Aug 2022 05:43:43 -0700 (PDT)
Received: from krzk-bin.. (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id k14-20020ac257ce000000b0048ae4cf8a2csm1374331lfo.258.2022.08.16.05.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 05:43:43 -0700 (PDT)
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
        Tomas Melin <tomas.melin@vaisala.com>,
        Sean Nyekjaer <sean@geanix.com>,
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
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Andrew Davis <afd@ti.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Phil Reid <preid@electromag.com.au>,
        Michael Welling <mwelling@ieee.org>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Coffey <cmc@babblebit.net>,
        Slawomir Stepien <sst@poczta.fm>,
        Sankar Velliangiri <navin@linumiz.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 04/10] dt-bindings: iio: dac: use spi-peripheral-props.yaml
Date:   Tue, 16 Aug 2022 15:43:15 +0300
Message-Id: <20220816124321.67817-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220816124321.67817-1-krzysztof.kozlowski@linaro.org>
References: <20220816124321.67817-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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


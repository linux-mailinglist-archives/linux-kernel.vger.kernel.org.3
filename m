Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4E5595BFF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbiHPMn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbiHPMnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:43:45 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621A0A1AE
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:43:37 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id e15so14802393lfs.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ayYkQxSVc3r5eIqKtjX7SfLxrRnU/l94e979dZXtdn0=;
        b=DH8zgvFsfwNF2TaJ9zRChQZvF8uvo4X0a8Zmz1JHAwX1UnxjhpRyDDhgqxD1VEHYdH
         CWXOlFhwqnycLuaOXmPf4rOOOWF8J7KshA7/d15KDTfEl+Zid0G805GiffuLIt91PLML
         qJVz3ZZ6ydKhywas3Ak+kGzlyCN8/Dzjvk0lL62rQhkpoyfJESmjw4mtayok8UcUnIlu
         f2ZO+VJ0VlQ8+QLBGUfC7tNfiCpoM56yW+7NQnRk3p9CNd3MmViizgQijmF1hSQznv2W
         Xz2fny3jE7lCpN8Yy0DUKDpYGDnzMGDPFvwe3JtHtKP0mqBib9ro0QJ1CEFrjvUkm8kk
         KaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ayYkQxSVc3r5eIqKtjX7SfLxrRnU/l94e979dZXtdn0=;
        b=M4xaqSD/iRItZxKOjj65/rKh25fvQLx5Vff13CBxe6uA5Vax+hFK/qbwUkDaUCoGNy
         hGbYwk0mej+u1TibjuZPNBCM+8LLiNMqu+1IbGV9ieSDzGaRhcZ/E5zX9SjlaMi1a5Tq
         S0dbjU9RdrqOij4h6a+3AY6TP55SEXoVw1byItV7FrveKKU/cWfMrbiMHi9GZxHLeB2x
         eHJTtQdy5NOiEosmEMshzL9XCX0fTPgXXF+khM3DjEXJKB06rRuk4WOnWEutMIGX9PEt
         XYvOCd6y0hTQnSUTBsbS0oJh63DcQBAzKR7sH8txnZ2Vez92yXEBQDtLoS+a6J2sJPAQ
         2ocA==
X-Gm-Message-State: ACgBeo2WxBXqyMnDkTKV00gazQ2LNGqH+6mrmbrdRh0vsaZXSmWgH5Np
        BctRsTjvvudajNhPUNGn5KNpfA==
X-Google-Smtp-Source: AA6agR5oBic4YlIx6yOSWpEtwmWx5lgJHUmqtCVaWnC7VVP/A0BwyNldUpgwzYKmekUoVnpe0Rr9IA==
X-Received: by 2002:a05:6512:3f1d:b0:492:348c:5cc9 with SMTP id y29-20020a0565123f1d00b00492348c5cc9mr4424560lfa.399.1660653815062;
        Tue, 16 Aug 2022 05:43:35 -0700 (PDT)
Received: from krzk-bin.. (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id k14-20020ac257ce000000b0048ae4cf8a2csm1374331lfo.258.2022.08.16.05.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 05:43:34 -0700 (PDT)
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
Subject: [PATCH v3 01/10] dt-bindings: iio: adc: use spi-peripheral-props.yaml
Date:   Tue, 16 Aug 2022 15:43:12 +0300
Message-Id: <20220816124321.67817-2-krzysztof.kozlowski@linaro.org>
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
Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 .../bindings/iio/adc/adi,ad7124.yaml          |  7 ++---
 .../bindings/iio/adc/adi,ad7192.yaml          |  7 ++---
 .../bindings/iio/adc/adi,ad7280a.yaml         |  7 ++---
 .../bindings/iio/adc/adi,ad7292.yaml          |  7 ++---
 .../bindings/iio/adc/adi,ad7298.yaml          |  6 +++--
 .../bindings/iio/adc/adi,ad7476.yaml          |  8 +++---
 .../bindings/iio/adc/adi,ad7606.yaml          |  7 ++---
 .../bindings/iio/adc/adi,ad7768-1.yaml        |  7 ++---
 .../bindings/iio/adc/adi,ad7923.yaml          |  7 ++---
 .../bindings/iio/adc/adi,ad7949.yaml          |  7 ++---
 .../bindings/iio/adc/holt,hi8435.yaml         |  7 ++---
 .../bindings/iio/adc/lltc,ltc2496.yaml        |  8 +++---
 .../bindings/iio/adc/maxim,max1027.yaml       |  5 +++-
 .../bindings/iio/adc/maxim,max11100.yaml      |  7 +++--
 .../bindings/iio/adc/maxim,max1118.yaml       | 26 ++++++++++---------
 .../bindings/iio/adc/maxim,max1241.yaml       |  7 ++---
 .../bindings/iio/adc/microchip,mcp3201.yaml   |  6 +++--
 .../bindings/iio/adc/microchip,mcp3911.yaml   |  5 +++-
 .../bindings/iio/adc/ti,adc0832.yaml          |  7 ++---
 .../bindings/iio/adc/ti,adc084s021.yaml       |  7 ++---
 .../bindings/iio/adc/ti,adc108s102.yaml       |  6 +++--
 .../bindings/iio/adc/ti,adc12138.yaml         |  7 ++---
 .../bindings/iio/adc/ti,adc128s052.yaml       |  7 ++---
 .../bindings/iio/adc/ti,adc161s626.yaml       |  7 ++---
 .../bindings/iio/adc/ti,ads124s08.yaml        |  7 ++---
 .../bindings/iio/adc/ti,ads131e08.yaml        |  7 ++---
 .../bindings/iio/adc/ti,ads8344.yaml          |  7 ++---
 .../bindings/iio/adc/ti,ads8688.yaml          |  7 ++---
 .../bindings/iio/adc/ti,tlc4541.yaml          |  7 ++---
 .../bindings/iio/adc/ti,tsc2046.yaml          |  7 ++---
 30 files changed, 131 insertions(+), 93 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
index fb3d0dae9bae..75a7184a4735 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
@@ -52,8 +52,6 @@ properties:
   avdd-supply:
     description: avdd supply can be used as reference for conversion.
 
-  spi-max-frequency: true
-
 required:
   - compatible
   - reg
@@ -106,7 +104,10 @@ patternProperties:
 
     additionalProperties: false
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
index 22b7ed3723f6..cc347dade4ef 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
@@ -30,8 +30,6 @@ properties:
 
   spi-cpha: true
 
-  spi-max-frequency: true
-
   clocks:
     maxItems: 1
     description: phandle to the master clock (mclk)
@@ -94,7 +92,10 @@ required:
   - spi-cpol
   - spi-cpha
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7280a.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7280a.yaml
index a694d5794d4a..dfb8f305e2f0 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7280a.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7280a.yaml
@@ -28,8 +28,6 @@ properties:
     description: IRQ line for the ADC
     maxItems: 1
 
-  spi-max-frequency: true
-
   adi,voltage-alert-last-chan:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
@@ -55,7 +53,10 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
index a3e39a40c9b3..1bfbeed6f299 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
@@ -30,8 +30,6 @@ properties:
 
   spi-cpha: true
 
-  spi-max-frequency: true
-
   '#address-cells':
     const: 1
 
@@ -65,7 +63,10 @@ patternProperties:
 
     additionalProperties: true
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7298.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7298.yaml
index ca414bb396c5..cd8ac5162d27 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7298.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7298.yaml
@@ -24,13 +24,15 @@ properties:
 
   vref-supply: true
   vdd-supply: true
-  spi-max-frequency: true
 
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
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
index 666414a9c0de..44c671eeda73 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
@@ -66,8 +66,6 @@ properties:
       to the other supplies. Needed to be able to establish channel scaling
       unless there is also an internal reference available (e.g. ad7091r)
 
-  spi-max-frequency: true
-
   adi,conversion-start-gpios:
     description: A GPIO used to trigger the start of a conversion
     maxItems: 1
@@ -76,9 +74,9 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
-
 allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
   # Devices where reference is vcc
   - if:
       properties:
@@ -158,6 +156,8 @@ allOf:
       properties:
         adi,conversion-start-gpios: false
 
+unevaluatedProperties: false
+
 examples:
   - |
     spi {
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index 516fc24d3346..ac5a47c8f070 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -32,8 +32,6 @@ properties:
 
   spi-cpol: true
 
-  spi-max-frequency: true
-
   avcc-supply: true
 
   interrupts:
@@ -105,7 +103,10 @@ required:
   - interrupts
   - adi,conversion-start-gpios
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
index a85a28145ef6..3ce59d4d065f 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
@@ -50,8 +50,6 @@ properties:
   reset-gpios:
     maxItems: 1
 
-  spi-max-frequency: true
-
   spi-cpol: true
 
   spi-cpha: true
@@ -88,7 +86,10 @@ patternProperties:
       - reg
     additionalProperties: false
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
index e82194974eea..24a810c23197 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
@@ -43,13 +43,14 @@ properties:
   '#size-cells':
     const: 0
 
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
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
index 0b10ed5f74ae..9ee4d977c5ed 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
@@ -49,8 +49,6 @@ properties:
     default: 4096000
 
 
-  spi-max-frequency: true
-
   '#io-channel-cells':
     const: 1
 
@@ -64,7 +62,10 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/adc/holt,hi8435.yaml b/Documentation/devicetree/bindings/iio/adc/holt,hi8435.yaml
index 52490cbb0af0..56bcbe5dcd79 100644
--- a/Documentation/devicetree/bindings/iio/adc/holt,hi8435.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/holt,hi8435.yaml
@@ -24,8 +24,6 @@ properties:
       GPIO used for controlling the reset pin
     maxItems: 1
 
-  spi-max-frequency: true
-
   "#io-channel-cells":
     const: 1
 
@@ -33,7 +31,10 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
index 0bd2fc0356c8..5207c919abe0 100644
--- a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
@@ -22,15 +22,15 @@ properties:
   reg:
     maxItems: 1
 
-  spi-max-frequency:
-    description: maximal spi bus frequency supported
-
 required:
   - compatible
   - vref-supply
   - reg
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max1027.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max1027.yaml
index 46b7747076b9..d0a7ed26d9ea 100644
--- a/Documentation/devicetree/bindings/iio/adc/maxim,max1027.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/maxim,max1027.yaml
@@ -45,7 +45,10 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max11100.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max11100.yaml
index 0cf87556ef82..4f74cb33383a 100644
--- a/Documentation/devicetree/bindings/iio/adc/maxim,max11100.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/maxim,max11100.yaml
@@ -26,13 +26,16 @@ properties:
     minimum: 100000
     maximum: 4800000
 
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
diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max1118.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max1118.yaml
index e948b3e37b0c..bb336e33ebe2 100644
--- a/Documentation/devicetree/bindings/iio/adc/maxim,max1118.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/maxim,max1118.yaml
@@ -28,23 +28,25 @@ properties:
   vref-supply:
     description: External reference, needed to establish input scaling
 
-if:
-  properties:
-    compatible:
-      contains:
-        const: maxim,max1118
-then:
-  required:
-    - vref-supply
-else:
-  properties:
-    vref-supply: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: maxim,max1118
+    then:
+      required:
+        - vref-supply
+    else:
+      properties:
+        vref-supply: false
 
 required:
   - compatible
   - reg
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
index 4c7e0d94bff1..58b12fe8070c 100644
--- a/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
@@ -39,15 +39,16 @@ properties:
       thus enabling power-down mode.
     maxItems: 1
 
-  spi-max-frequency: true
-
 required:
   - compatible
   - reg
   - vdd-supply
   - vref-supply
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3201.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3201.yaml
index fcc1ba53b20d..18108f0f3731 100644
--- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3201.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3201.yaml
@@ -32,7 +32,6 @@ properties:
   reg:
     maxItems: 1
 
-  spi-max-frequency: true
   spi-cpha: true
   spi-cpol: true
 
@@ -51,7 +50,10 @@ required:
   - reg
   - vref-supply
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
index 95ab285f4eba..067a7bbadab8 100644
--- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
@@ -51,7 +51,10 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/adc/ti,adc0832.yaml b/Documentation/devicetree/bindings/iio/adc/ti,adc0832.yaml
index f5a923cc847f..686721176a58 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,adc0832.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,adc0832.yaml
@@ -24,8 +24,6 @@ properties:
   reg:
     maxItems: 1
 
-  spi-max-frequency: true
-
   vref-supply:
     description: External reference, needed to establish input scaling
 
@@ -37,7 +35,10 @@ required:
   - reg
   - vref-supply
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/adc/ti,adc084s021.yaml b/Documentation/devicetree/bindings/iio/adc/ti,adc084s021.yaml
index 1a113b30a414..726d2cbfa368 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,adc084s021.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,adc084s021.yaml
@@ -19,8 +19,6 @@ properties:
   reg:
     maxItems: 1
 
-  spi-max-frequency: true
-
   vref-supply:
     description: External reference, needed to establish input scaling
 
@@ -37,7 +35,10 @@ required:
   - spi-cpol
   - spi-cpha
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/adc/ti,adc108s102.yaml b/Documentation/devicetree/bindings/iio/adc/ti,adc108s102.yaml
index ae5ce60987fe..9b072b057f16 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,adc108s102.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,adc108s102.yaml
@@ -19,7 +19,6 @@ properties:
 
   reg: true
   vref-supply: true
-  spi-max-frequency: true
   "#io-channel-cells":
     const: 1
 
@@ -28,7 +27,10 @@ required:
   - reg
   - vref-supply
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/adc/ti,adc12138.yaml b/Documentation/devicetree/bindings/iio/adc/ti,adc12138.yaml
index ec3b2edf1fb7..076088a328c3 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,adc12138.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,adc12138.yaml
@@ -31,8 +31,6 @@ properties:
     maxItems: 1
     description: Conversion clock input.
 
-  spi-max-frequency: true
-
   vref-p-supply:
     description: The regulator supply for positive analog voltage reference
 
@@ -62,7 +60,10 @@ required:
   - clocks
   - vref-p-supply
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/adc/ti,adc128s052.yaml b/Documentation/devicetree/bindings/iio/adc/ti,adc128s052.yaml
index d54a0183f024..775eee972b12 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,adc128s052.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,adc128s052.yaml
@@ -27,8 +27,6 @@ properties:
   reg:
     maxItems: 1
 
-  spi-max-frequency: true
-
   vref-supply: true
 
   "#io-channel-cells":
@@ -39,7 +37,10 @@ required:
   - reg
   - vref-supply
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/adc/ti,adc161s626.yaml b/Documentation/devicetree/bindings/iio/adc/ti,adc161s626.yaml
index 3f4f334d6f73..afe782522904 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,adc161s626.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,adc161s626.yaml
@@ -21,8 +21,6 @@ properties:
   reg:
     maxItems: 1
 
-  spi-max-frequency: true
-
   vdda-supply: true
 
   "#io-channel-cells":
@@ -32,7 +30,10 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads124s08.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads124s08.yaml
index 2e6abc9d746a..56a3f1766aab 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,ads124s08.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads124s08.yaml
@@ -18,8 +18,6 @@ properties:
   reg:
     maxItems: 1
 
-  spi-max-frequency: true
-
   spi-cpha: true
 
   reset-gpios:
@@ -32,7 +30,10 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml
index e0670e3fbb72..5882de6fd967 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml
@@ -28,8 +28,6 @@ properties:
   reg:
     maxItems: 1
 
-  spi-max-frequency: true
-
   spi-cpha: true
 
   clocks:
@@ -120,7 +118,10 @@ patternProperties:
 
     additionalProperties: false
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads8344.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads8344.yaml
index b8c398187d5c..f75b2c702986 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,ads8344.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads8344.yaml
@@ -19,8 +19,6 @@ properties:
   reg:
     maxItems: 1
 
-  spi-max-frequency: true
-
   vref-supply:
     description: Supply the 2.5V or 5V reference voltage
 
@@ -32,7 +30,10 @@ required:
   - reg
   - vref-supply
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads8688.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads8688.yaml
index a0af4b24877f..f26fdbc15f84 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,ads8688.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads8688.yaml
@@ -25,13 +25,14 @@ properties:
     description: Optional external reference.  If not supplied, assume
       REFSEL input tied low to enable the internal reference.
 
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
diff --git a/Documentation/devicetree/bindings/iio/adc/ti,tlc4541.yaml b/Documentation/devicetree/bindings/iio/adc/ti,tlc4541.yaml
index 6c2539b3d707..314d1d99bf73 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,tlc4541.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,tlc4541.yaml
@@ -21,8 +21,6 @@ properties:
   reg:
     maxItems: 1
 
-  spi-max-frequency: true
-
   vref-supply: true
 
   "#io-channel-cells":
@@ -33,7 +31,10 @@ required:
   - reg
   - vref-supply
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml b/Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml
index 601d69971d84..0b48814c0dc2 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml
@@ -23,8 +23,6 @@ properties:
   interrupts:
     maxItems: 1
 
-  spi-max-frequency: true
-
   "#io-channel-cells":
     const: 1
 
@@ -59,7 +57,10 @@ patternProperties:
 
     additionalProperties: false
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1


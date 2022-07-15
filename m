Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B46575EDA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 11:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbiGOJxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 05:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbiGOJxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 05:53:13 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B304D81480
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 02:53:10 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id c15so5189025ljr.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 02:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iWnFHdJkpHs2zY2dBDf4t+WlNVKjMqc8zpf/aZJAmpo=;
        b=qOH3sNOStNit+gxBsEgvbVZ1NARteYO7cNa1eTXNmsQ50grcdqQtxcn/JbJvFKOEch
         Z9Zgbv7I4bgEaYCtDFvuD+fiiI4JN26pl7qidz6kc4s819sWSMdPhP/d5157eUnqFfhz
         Gqbb52/ybOPvzVcA9f7ja3ux0/De0FDN7RjisqeJ5GkzXYLB4Jun04rXL447infvEVq2
         Hr3PGgGWMw/s3lxOhaU6PlHP6En+8WLXEVzP/8C53R+jQHJCmLsV1IbbjYqk2jNN+khp
         4k/LO1H/RgDdHhihZ+R87Y05PsAYCTgYcaUrfl0+X6etMUyVoRtJbPUsRt0oqlFe7rqN
         +2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iWnFHdJkpHs2zY2dBDf4t+WlNVKjMqc8zpf/aZJAmpo=;
        b=luvyRtXK5wkxyEfQAp+AFzLhGpSdN58otdLsBJqMEycqPKB3yXkzKHY+eTf89tUc1R
         s9hzYi5dU9Wk1seisqPiKKncigVzcY4e6we4YcoHzIB4tWcj/6qk5kTFAYcBKwYmmNo6
         7GMk1ohkAkwRgNfkQwh2pvzAJrHd7Z5BVUeCT/ukZ2PbSD6vopuRrLTrGwERvi4RnoDj
         bQpMPNZyBEjml7Ojmhl5DwYZxeesQeuaUmSaHh/nW91mTOBnnOAbxBdgDk9H7xg0sqki
         H1sFG97YNHpo1fTS+YoBe7eCqec4PM6KVy7uA3AfGg0cKCkgLXutyN7k4Txtf5akzssf
         SrwA==
X-Gm-Message-State: AJIora+ZXrFi+pAGY3bkrwJLcLYmyLqeKuTtWNtMZvNuQX7hxSn/vox9
        O7OAmhK987boib5kWsPC3sMTaA==
X-Google-Smtp-Source: AGRyM1v3T6c8Gz65tvi7jm/1E82uX3ZyTk33AETMHjR0AKvb9qI1lNUO86YvGTPjaArRZji/Bhg6gw==
X-Received: by 2002:a2e:805a:0:b0:25d:3f51:3cac with SMTP id p26-20020a2e805a000000b0025d3f513cacmr6750434ljg.30.1657878788966;
        Fri, 15 Jul 2022 02:53:08 -0700 (PDT)
Received: from krzk-bin.. (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id e5-20020a2e9845000000b0025d9f28db3esm487795ljj.20.2022.07.15.02.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 02:53:08 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Beniamin Bia <beniamin.bia@analog.com>,
        Patrick Vasseur <patrick.vasseur@c-s.fr>,
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
        Dan Murphy <dmurphy@ti.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFC PATCH] dt-bindings: iio: adc: use spi-peripheral-props.yaml
Date:   Fri, 15 Jul 2022 11:53:02 +0200
Message-Id: <20220715095302.214276-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

This is an RFC with only some files changed, as I am still not sure of
benefits for typical case - device node has just spi-max-frequency and
nothing more.  I still find useful to reference the schema, but maybe I
am missing something?

Before doing wide-tree cleanup like this, I would be happy to receive
some feedback whether this makes sense.
---
 .../bindings/iio/adc/adi,ad7124.yaml          |  7 ++---
 .../bindings/iio/adc/adi,ad7192.yaml          | 11 +++-----
 .../bindings/iio/adc/adi,ad7280a.yaml         |  7 ++---
 .../bindings/iio/adc/adi,ad7292.yaml          |  9 +++----
 .../bindings/iio/adc/adi,ad7476.yaml          |  8 +++---
 .../bindings/iio/adc/adi,ad7606.yaml          | 11 +++-----
 .../bindings/iio/adc/adi,ad7768-1.yaml        | 11 +++-----
 .../bindings/iio/adc/adi,ad7923.yaml          |  7 ++---
 .../bindings/iio/adc/holt,hi8435.yaml         |  7 ++---
 .../bindings/iio/adc/lltc,ltc2496.yaml        |  8 +++---
 .../bindings/iio/adc/maxim,max1027.yaml       |  5 +++-
 .../bindings/iio/adc/maxim,max11100.yaml      |  7 +++--
 .../bindings/iio/adc/maxim,max1118.yaml       | 26 ++++++++++---------
 .../bindings/iio/adc/maxim,max1241.yaml       |  7 ++---
 .../bindings/iio/adc/microchip,mcp3201.yaml   |  9 +++----
 .../bindings/iio/adc/microchip,mcp3911.yaml   |  5 +++-
 .../bindings/iio/adc/ti,adc0832.yaml          |  7 ++---
 .../bindings/iio/adc/ti,adc084s021.yaml       |  7 ++---
 .../bindings/iio/adc/ti,adc108s102.yaml       |  6 +++--
 .../bindings/iio/adc/ti,adc12138.yaml         |  7 ++---
 .../bindings/iio/adc/ti,adc128s052.yaml       |  7 ++---
 .../bindings/iio/adc/ti,ads124s08.yaml        |  9 +++----
 .../bindings/iio/adc/ti,ads131e08.yaml        |  9 +++----
 23 files changed, 103 insertions(+), 94 deletions(-)

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
index 22b7ed3723f6..195c7e6e5206 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
@@ -26,12 +26,6 @@ properties:
   reg:
     maxItems: 1
 
-  spi-cpol: true
-
-  spi-cpha: true
-
-  spi-max-frequency: true
-
   clocks:
     maxItems: 1
     description: phandle to the master clock (mclk)
@@ -94,7 +88,10 @@ required:
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
index a3e39a40c9b3..8ebeb06675bb 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
@@ -28,10 +28,6 @@ properties:
     description: |
       The regulator supply for ADC and DAC reference voltage.
 
-  spi-cpha: true
-
-  spi-max-frequency: true
-
   '#address-cells':
     const: 1
 
@@ -65,7 +61,10 @@ patternProperties:
 
     additionalProperties: true
 
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
index 73775174cf57..f76eaa4ca154 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -29,12 +29,6 @@ properties:
   reg:
     maxItems: 1
 
-  spi-cpha: true
-
-  spi-cpol: true
-
-  spi-max-frequency: true
-
   avcc-supply: true
 
   interrupts:
@@ -106,7 +100,10 @@ required:
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
index a85a28145ef6..117c4eb28f4e 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
@@ -50,12 +50,6 @@ properties:
   reset-gpios:
     maxItems: 1
 
-  spi-max-frequency: true
-
-  spi-cpol: true
-
-  spi-cpha: true
-
   "#io-channel-cells":
     const: 1
 
@@ -88,7 +82,10 @@ patternProperties:
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
index fcc1ba53b20d..dc7a8a50495d 100644
--- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3201.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3201.yaml
@@ -32,10 +32,6 @@ properties:
   reg:
     maxItems: 1
 
-  spi-max-frequency: true
-  spi-cpha: true
-  spi-cpol: true
-
   vref-supply:
     description: External reference.
 
@@ -51,7 +47,10 @@ required:
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
index 54955f03df93..1a589ad1659f 100644
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
diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads124s08.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads124s08.yaml
index 9f5e96439c01..efdc8701a2e5 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,ads124s08.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads124s08.yaml
@@ -18,10 +18,6 @@ properties:
   reg:
     maxItems: 1
 
-  spi-max-frequency: true
-
-  spi-cpha: true
-
   reset-gpios:
     maxItems: 1
 
@@ -32,7 +28,10 @@ required:
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
index e0670e3fbb72..b8608f58bbca 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml
@@ -28,10 +28,6 @@ properties:
   reg:
     maxItems: 1
 
-  spi-max-frequency: true
-
-  spi-cpha: true
-
   clocks:
     description: |
       Device tree identifier to the clock source (2.048 MHz).
@@ -120,7 +116,10 @@ patternProperties:
 
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


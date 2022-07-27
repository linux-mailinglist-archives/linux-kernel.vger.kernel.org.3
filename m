Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE5F582FB1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 19:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239142AbiG0R27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 13:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242159AbiG0R1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 13:27:35 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24917E83D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:47:13 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id q7so5012823ljp.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1OkHpjzGCry+ZL6//0vSWmlU3q3YJnXwCwfZ625r6ZU=;
        b=OdFsbffjdPuAG+i0aLOyLOTL1B4JMDmd0jqT8YKt3OD0j4KUyoxxg0/IlIVlXmOTqG
         Qrk2Hmqlw6ILOg2FRXTOJHNVR791ajvg4c5r3Z5PKHtzvrlib624iqRQJSu8Yt2IMNef
         a65m0Yfk9r0qZ+ZFi42tswpWo/LgkrQu2B35jgVTHqWWRh8HuaPLP7BpmGbTnkosltvu
         pI3ckFFDFJYLwwHUubFN9lR8qgOujROpducc2YGNnQT2CuGThSNtsbenTudSRdJwz/0y
         e0QwaycEoQzc6QukVzXiHxNChxuSS5m+FjMxgBrBifBlpnQcBjE2nRfA2HMfqX9B73Er
         XYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1OkHpjzGCry+ZL6//0vSWmlU3q3YJnXwCwfZ625r6ZU=;
        b=eAVVgGl9B9J9oB9VihSQxuaM9bPgmNxU7YiaYDMG+ZK5Perc4YWJZMizGQ/FlPojHR
         odF4nnex9JXfyAGpWvYv0JxjC4M/uxwr8xC4QOcyM1aRCXeRbzXWbaf1hqkJ+Zelpkwy
         LtBk3ches6YV7DAtRnYlLMcP945JwrwYwl8P8EU2TMbtWGWpiaql3J6a+Zoxs6H7SRAO
         nASfG8e7Ztz8AFVXiMO5Elu1sR5H2qIN60+J5hLhK3chXU1uxdMzW8wHN6VZLwPpVXkP
         toj6qLs87Iqp4EIz0QkhK/oeHGceqLrtPKh8Cr8g4Me8Jpm1Id931XzQqoQEjeLvTUEc
         GWMg==
X-Gm-Message-State: AJIora9nKhb9ns/QQQi/6GQkUZrRiAFXquUWG5whN3FJvRRQ/mdrUk6F
        96MaiIGOHDc3CNbPkGd+vDSL7A==
X-Google-Smtp-Source: AGRyM1tq+XscqgTAiSYgbgmYLXWSAr8Aj4Q1GW3kkYgpdqZHoEE9e7yaYdiManN2n3HTwpBhc2r6Kw==
X-Received: by 2002:a2e:a36a:0:b0:25d:d73d:d8c9 with SMTP id i10-20020a2ea36a000000b0025dd73dd8c9mr7615913ljn.68.1658940427856;
        Wed, 27 Jul 2022 09:47:07 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id 18-20020ac25f52000000b0048910301774sm3375149lfz.307.2022.07.27.09.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 09:47:07 -0700 (PDT)
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
Subject: [PATCH v2 02/10] dt-bindings: iio: accel: use spi-peripheral-props.yaml
Date:   Wed, 27 Jul 2022 18:46:38 +0200
Message-Id: <20220727164646.387541-3-krzysztof.kozlowski@linaro.org>
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

I wonder if spi-3wire is device specific (not controller) and should be
rather explicitly mentioned by device schema. Just like spi-cpol/cpha.
---
 .../devicetree/bindings/iio/accel/adi,adis16201.yaml     | 7 ++++---
 .../devicetree/bindings/iio/accel/adi,adis16240.yaml     | 7 ++++---
 .../devicetree/bindings/iio/accel/adi,adxl313.yaml       | 9 ++++-----
 .../devicetree/bindings/iio/accel/adi,adxl345.yaml       | 7 ++++---
 .../devicetree/bindings/iio/accel/adi,adxl355.yaml       | 7 ++++---
 .../devicetree/bindings/iio/accel/adi,adxl367.yaml       | 7 ++++---
 .../devicetree/bindings/iio/accel/adi,adxl372.yaml       | 7 ++++---
 .../devicetree/bindings/iio/accel/bosch,bma220.yaml      | 7 ++++---
 .../devicetree/bindings/iio/accel/bosch,bma255.yaml      | 5 ++++-
 .../devicetree/bindings/iio/accel/bosch,bmi088.yaml      | 7 ++++---
 .../devicetree/bindings/iio/accel/fsl,mma7455.yaml       | 7 ++++---
 .../devicetree/bindings/iio/accel/kionix,kxsd9.yaml      | 7 ++++---
 .../devicetree/bindings/iio/accel/murata,sca3300.yaml    | 5 ++++-
 .../devicetree/bindings/iio/accel/nxp,fxls8962af.yaml    | 7 ++++---
 14 files changed, 56 insertions(+), 40 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml
index 6f8f8a6258fe..7332442e5661 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml
@@ -27,15 +27,16 @@ properties:
   interrupts:
     maxItems: 1
 
-  spi-max-frequency: true
-
   vdd-supply: true
 
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
diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
index 8d829ef878bc..f6f97164c2ca 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
@@ -25,14 +25,15 @@ properties:
   interrupts:
     maxItems: 1
 
-  spi-max-frequency: true
-
 required:
   - compatible
   - reg
   - interrupts
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
index d6afc1b8c272..7c1bc7810528 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
@@ -22,10 +22,6 @@ properties:
   reg:
     maxItems: 1
 
-  spi-3wire: true
-
-  spi-max-frequency: true
-
   vs-supply:
     description: Regulator that supplies power to the accelerometer
 
@@ -48,7 +44,10 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
index 9bb039e2f533..346abfb13a3a 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
@@ -32,8 +32,6 @@ properties:
 
   spi-cpol: true
 
-  spi-max-frequency: true
-
   interrupts:
     maxItems: 1
 
@@ -42,7 +40,10 @@ required:
   - reg
   - interrupts
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
index ba54d6998f2e..14b487088ab4 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
@@ -45,13 +45,14 @@ properties:
   vddio-supply:
     description: Regulator that provides power to the bus
 
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
diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
index d259e796c1d6..f10d98d34cb8 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
@@ -35,8 +35,6 @@ properties:
   interrupts:
     maxItems: 1
 
-  spi-max-frequency: true
-
   vdd-supply: true
   vddio-supply: true
 
@@ -45,7 +43,10 @@ required:
   - reg
   - interrupts
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
index 38b59b6454ce..73a5c8f814cc 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
@@ -25,14 +25,15 @@ properties:
   interrupts:
     maxItems: 1
 
-  spi-max-frequency: true
-
 required:
   - compatible
   - reg
   - interrupts
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
index 942b23ad0712..5dd06f5905b4 100644
--- a/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
@@ -20,8 +20,6 @@ properties:
   interrupts:
     maxItems: 1
 
-  spi-max-frequency: true
-
   vdda-supply: true
   vddd-supply: true
   vddio-supply: true
@@ -30,7 +28,10 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
index 478e75ae0885..457a709b583c 100644
--- a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
@@ -72,7 +72,10 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
index 272eb48eef5a..3cb82576d758 100644
--- a/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
@@ -24,8 +24,6 @@ properties:
   reg:
     maxItems: 1
 
-  spi-max-frequency: true
-
   vdd-supply: true
 
   vddio-supply: true
@@ -50,7 +48,10 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/accel/fsl,mma7455.yaml b/Documentation/devicetree/bindings/iio/accel/fsl,mma7455.yaml
index 7c8f8bdc2333..589ca8178f4a 100644
--- a/Documentation/devicetree/bindings/iio/accel/fsl,mma7455.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/fsl,mma7455.yaml
@@ -40,13 +40,14 @@ properties:
         - "INT1"
         - "INT2"
 
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
diff --git a/Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.yaml b/Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.yaml
index 390b87242fcb..f64d99b35492 100644
--- a/Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.yaml
@@ -29,13 +29,14 @@ properties:
   mount-matrix:
     description: an optional 3x3 mounting rotation matrix.
 
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
diff --git a/Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml b/Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml
index f6e2a16a710b..00c990caa1e4 100644
--- a/Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml
@@ -29,7 +29,10 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
index ad529ab2c6e2..65ce8ea14b52 100644
--- a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
@@ -27,8 +27,6 @@ properties:
   vdd-supply:
     description: phandle to the regulator that provides power to the accelerometer
 
-  spi-max-frequency: true
-
   interrupts:
     maxItems: 1
 
@@ -44,7 +42,10 @@ required:
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


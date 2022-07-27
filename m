Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D40582FE3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 19:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242340AbiG0RbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 13:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242181AbiG0R2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 13:28:31 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B137FE61
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:47:29 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id m12so26858410lfj.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Tysa2646FPeIVNiHGi3W/H89t++BUP3ETBrFPRlVhE=;
        b=BMHaoQHWUjxOqin5iFDh5Q7ZstwBh4/d8Y0RCri+Lp/qeZ9UglnV/3vaEb7xZnVPs7
         nNPVjzhy9HIqFwyCaQ2zqsLiGwdgEYxyajDMTqmr048CsEYUswMLP2ynE9LmG8AVqxST
         Bn7YOmAfl9evLu95wG/sZZ9apHwBeEJU2zwUAPJOkIq51QYdGeh/esSdG0FbfBbsAsZH
         HXrRqo4bZmHLxYEVN6Pj7f7i3G+viPpf5W6TnrBLXDEgLFR3Ho3A7MVIzWw6Il6UUopg
         IELKdLkADR/HNhuuBcuL+rDKVJiFVcyqhatpyczgqPKr9RK3IcjDpQARH6ukuwZfJEFq
         yz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Tysa2646FPeIVNiHGi3W/H89t++BUP3ETBrFPRlVhE=;
        b=UZP09DW56/vjuJsIyBqqBE6BaAM/Je6cnxrLhdXTyDgJ5Kv09/wVaMTGF6Tg1qzfCj
         Dgb5SD0A+ILJlGJtdCEIzODgyyIdBrPqFYXLTPHZ7nrLVAGJXf8cPsuDasLlpiTx3SOV
         HuumnIp8FzpXr2tjkU5cgyMwAVOsDAKUCpY7upTJ5dW8bqBVv5pIS0aWGaJx7tWQEYsQ
         U+rPUUPz9fiQREIxTd6oC1YFNNvKVe55zcMDQ6y8HTcnaqVIxdUZrmp3wo2EsMT3YrUo
         KZ0WS0gMcKOyRlIAJIrOInT1Ktok4Mj/ksTqzYXjUxmFhx+x/S7CfTwYq2n0PXZbwUyA
         sSRg==
X-Gm-Message-State: AJIora8h+KQ8jKtD/rttvLgRs9RLvyEM7farRksJXDdvPgPjVO5OoaYT
        c7ANQMCGjdBlYsFuiFwSskvQSg==
X-Google-Smtp-Source: AGRyM1vmh7HmMwSNeSSIgsIVOXPC4LcHYD7jNf0qFvpii7Dtgi/92kOVE66rVVAg8/X6a0SRqhLSzA==
X-Received: by 2002:a05:6512:39d5:b0:48a:bfe9:23ee with SMTP id k21-20020a05651239d500b0048abfe923eemr694931lfu.604.1658940443564;
        Wed, 27 Jul 2022 09:47:23 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id 18-20020ac25f52000000b0048910301774sm3375149lfz.307.2022.07.27.09.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 09:47:22 -0700 (PDT)
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
Subject: [PATCH v2 07/10] dt-bindings: iio: imu: use spi-peripheral-props.yaml
Date:   Wed, 27 Jul 2022 18:46:43 +0200
Message-Id: <20220727164646.387541-8-krzysztof.kozlowski@linaro.org>
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
 .../devicetree/bindings/iio/imu/adi,adis16460.yaml       | 7 ++++---
 .../devicetree/bindings/iio/imu/adi,adis16480.yaml       | 9 +++++----
 .../devicetree/bindings/iio/imu/bosch,bmi160.yaml        | 7 ++++---
 .../devicetree/bindings/iio/imu/invensense,icm42600.yaml | 6 ++++--
 .../devicetree/bindings/iio/imu/invensense,mpu6050.yaml  | 5 ++---
 .../devicetree/bindings/iio/imu/nxp,fxos8700.yaml        | 7 ++++---
 .../devicetree/bindings/iio/imu/st,lsm6dsx.yaml          | 9 +++++----
 7 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
index 340be256f283..d166dbca18c3 100644
--- a/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
@@ -25,8 +25,6 @@ properties:
 
   spi-cpol: true
 
-  spi-max-frequency: true
-
   interrupts:
     maxItems: 1
 
@@ -35,7 +33,10 @@ required:
   - reg
   - interrupts
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
index dd29dc6c4c19..56e0dc20f5e4 100644
--- a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
@@ -47,8 +47,6 @@ properties:
         - DIO3
         - DIO4
 
-  spi-max-frequency: true
-
   spi-cpha: true
   spi-cpol: true
 
@@ -96,8 +94,6 @@ properties:
       - DIO3
       - DIO4
 
-additionalProperties: false
-
 required:
   - compatible
   - reg
@@ -106,6 +102,11 @@ required:
   - spi-cpol
   - spi-max-frequency
 
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
index 6e73cd889b5c..a0760382548d 100644
--- a/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
@@ -46,13 +46,14 @@ properties:
   mount-matrix:
     description: an optional 3x3 mounting rotation matrix
 
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
diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index 4c1c083d0e92..488349755c99 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
@@ -47,7 +47,6 @@ properties:
   vddio-supply:
     description: Regulator that provides power to the bus
 
-  spi-max-frequency: true
   spi-cpha: true
   spi-cpol: true
 
@@ -56,7 +55,10 @@ required:
   - reg
   - interrupts
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
index 3ebc6526d82d..ec64d7877fe5 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
@@ -40,8 +40,6 @@ properties:
   interrupts:
     maxItems: 1
 
-  spi-max-frequency: true
-
   vdd-supply: true
   vddio-supply: true
 
@@ -54,6 +52,7 @@ properties:
       These devices also support an auxiliary i2c bus via an i2c-gate.
 
 allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
   - if:
       not:
         properties:
@@ -67,7 +66,7 @@ allOf:
       properties:
         i2c-gate: false
 
-additionalProperties: false
+unevaluatedProperties: false
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml b/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml
index 479e7065d4eb..beeaa3c902cd 100644
--- a/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml
@@ -36,13 +36,14 @@ properties:
   drive-open-drain:
     type: boolean
 
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
diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
index 5d4839f00898..0ceb29fb01b7 100644
--- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
@@ -45,8 +45,6 @@ properties:
     description:
       Supports up to 2 interrupt lines via the INT1 and INT2 pins.
 
-  spi-max-frequency: true
-
   vdd-supply:
     description: if defined provides VDD power to the sensor.
 
@@ -81,12 +79,15 @@ properties:
   wakeup-source:
     $ref: /schemas/types.yaml#/definitions/flag
 
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
     #include <dt-bindings/interrupt-controller/irq.h>
-- 
2.34.1


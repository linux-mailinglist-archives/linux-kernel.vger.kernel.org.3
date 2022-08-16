Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8044B595C24
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbiHPMpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbiHPMoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:44:38 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7E82C133
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:43:56 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id r17so14731024lfm.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=CXWLPPyHffdUKuA6Nm8ApG3LHh3g7wZtkqYdznNRN8w=;
        b=AACz0m1AQALNunroOyLPkD+7qM2UR2daldpDp2VErgcmy7kc0LM2QrgVdUc1hqkIfJ
         r2J01qTMkw4MZbzewnJN5xM7Q3kmGIWU9eNWzz/OR9OQYRTYX+sQMckF3qyIWBTbejTE
         Hbp96ucsxSLX3WLtuF9WLrrRj6sJVMzp4AFS1AgMTaaf4ZoQaKIqo0rFAvaMwzBs7WqG
         MRCBxqDqn5lQnGk2rDC1cMjLyHl1CCTRT+akfuSkXjorW4DgagoayvqjdsYWOU80/Toj
         o9kSmy2zptlTUUWDhLtiZwEeWhAY8uf3gg2VTSvnhi+Ww1RtX9oMSjLdcfuRhqeSwtZS
         lh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=CXWLPPyHffdUKuA6Nm8ApG3LHh3g7wZtkqYdznNRN8w=;
        b=qGtiCvFdzoBjFXOXajNB/JSmQy6X+AqpXh19Vb1U6+AMLV5CtVjKky7IlZ2mB04fvF
         ZYjbByGYaLHBNBR4CEyMHTPd8BoO5LfQxkWJLYTdcdnwVWyIM5lUiv/+kUE7pBbktZ7T
         qq8QxIxl5PCBkwPSvF66SBmRH+PFwQxvS3jMCZRugiL4k+4Tb7jAUipjXgaR5IbMAA6+
         K2D14twXnSetiTHCjp0DkbjyqkSTS1N5eX9fs6vlR7q0eAJ3NiPKYP2hvYC4Y1co0cWm
         XQWliFenF1ayAbq9v7K6RS5pbAcQkahQAG60EcXES6SWT14x0ibyuaL3CfqJC9RFqoUt
         HBQQ==
X-Gm-Message-State: ACgBeo39fFE0N4ZdiVCsfukOF9yeUhW+/InPvJraxq28mePYD3MaI0dH
        hbHj99oA97chjVItqOat76RjTA==
X-Google-Smtp-Source: AA6agR6okIUsd0Dorj2iqDsr4LYXY9JJLftQminZIbQ8fg7f3rePXVY3Jusz4bxIRsstLq4R3qRGoA==
X-Received: by 2002:a05:6512:1689:b0:492:8e9f:fe79 with SMTP id bu9-20020a056512168900b004928e9ffe79mr2904579lfb.478.1660653832955;
        Tue, 16 Aug 2022 05:43:52 -0700 (PDT)
Received: from krzk-bin.. (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id k14-20020ac257ce000000b0048ae4cf8a2csm1374331lfo.258.2022.08.16.05.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 05:43:52 -0700 (PDT)
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
Subject: [PATCH v3 07/10] dt-bindings: iio: imu: use spi-peripheral-props.yaml
Date:   Tue, 16 Aug 2022 15:43:18 +0300
Message-Id: <20220816124321.67817-8-krzysztof.kozlowski@linaro.org>
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
index 0203b83b8587..24416b59b782 100644
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


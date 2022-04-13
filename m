Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E854FF3D1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiDMJmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbiDMJmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:42:44 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9393586F;
        Wed, 13 Apr 2022 02:40:23 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id c6so1645361edn.8;
        Wed, 13 Apr 2022 02:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QV2H8Zpc3cQYjchDu8RYw5gWfW1y7hY5+ft9F48s9lg=;
        b=qPQtL4dx5UsyjmfJN1u2zFmTxY9nARpLmPh3SIwgOeAl6LunvZ77eTTgWZkXe1Db2n
         5dgiV02CRGnQXBnQ2kbmEnt7wvHMlZb1Dx49BbrzoICLWJuF+iDqQlI5MoWKryXGBO0N
         uLWkc+kTAWpUSgC0qylQGE4aRCXDqZUWoSBtaJY1GVbKf6HsjhPZb1DRHjfsgNqzuHJa
         UusJTCm/Sci4jSYGYk7OpRcgBVxkK7ggF0N88v88nL13GxAIQ3IzqGf79bYmLpr9E0Z8
         JaDAxI9jf1xBqzomjPy16HrmpRhH9mf+nlruximkz8tmRp5HimoB7fVl5cvXPNvD3B6c
         0Vkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QV2H8Zpc3cQYjchDu8RYw5gWfW1y7hY5+ft9F48s9lg=;
        b=6kTEXOvNEche1e3F0fir6CyvvyaAyfctj22npkPtRV7WJ5moGqOmk8/qB5R7K7e2EQ
         nmJgvSjLu5StKCFcYMJ8vyGy6wa/Qu15mnLSzhz586uiXh9A5nwE1XipjqD2OyMIfLyl
         i8PNGKmmBL5XAXRDKf6ElRTz5p37pEoW84VyILf+KZZwjqMQzqUXmY2E4ZUojOeRYDA+
         Y2ZYQRCQkAYfJIqQKuKlCZihbBew5kz9mrqXtgFUF8Ob2RW2zA10o9AetW7s2rf2cwhD
         6/GiROiUd96cMFUwWVgkzWE3gWu/F5QWADphI1Mi91WzM9R6eYUiLyKnz8S0420sVv9/
         JIZg==
X-Gm-Message-State: AOAM530yUelcsbMeoVwSB0WVdhvKJaCrew9Z8j81VrNMIV48GK/Y66zw
        OlRrlR6PyZ7H8YLdAabRGz8=
X-Google-Smtp-Source: ABdhPJwQTDqwvRxq+U5T7h87eKFZua1Dz6/aJbupJ6rps5B27cxrMfXpWPKTvZmoPdRkG6trWPSZJQ==
X-Received: by 2002:a05:6402:2881:b0:41d:8c32:917 with SMTP id eg1-20020a056402288100b0041d8c320917mr9355516edb.328.1649842822325;
        Wed, 13 Apr 2022 02:40:22 -0700 (PDT)
Received: from demon-pc.localdomain ([188.24.22.234])
        by smtp.gmail.com with ESMTPSA id t1-20020a170906178100b006e7edb2c0bdsm11403265eje.15.2022.04.13.02.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 02:40:21 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: [PATCH v1 1/3] dt-bindings: iio: adc: add AD4130
Date:   Wed, 13 Apr 2022 12:40:09 +0300
Message-Id: <20220413094011.185269-1-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AD4130-8 is an ultra-low power, high precision,
measurement solution for low bandwidth battery
operated applications.

The fully integrated AFE (Analog Front-End)
includes a multiplexer for up to 16 single-ended
or 8 differential inputs, PGA (Programmable Gain
Amplifier), 24-bit Sigma-Delta ADC, on-chip
reference and oscillator, selectable filter
options, smart sequencer, sensor biasing and
excitation options, diagnostics, and a FIFO
buffer.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 .../bindings/iio/adc/adi,ad4130.yaml          | 255 ++++++++++++++++++
 1 file changed, 255 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
new file mode 100644
index 000000000000..e9dce54e9802
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
@@ -0,0 +1,255 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2022 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad4130.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD4130 ADC device driver
+
+maintainers:
+  - Cosmin Tanislav <cosmin.tanislav@analog.com>
+
+description: |
+  Bindings for the Analog Devices AD4130 ADC. Datasheet can be found here:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4130-8.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad4130-8-16-lfcsp
+      - adi,ad4130-8-16-wlcsp
+      - adi,ad4130-8-24-lfcsp
+      - adi,ad4130-8-24-wlcsp
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description: phandle to the master clock (mclk)
+
+  clock-names:
+    items:
+      - const: mclk
+
+  interrupts:
+    minItems: 1
+    maxItems: 1
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 1
+    description:
+      Default if not supplied is dout-int.
+    items:
+      enum:
+        - dout-int
+        - clk
+        - p1
+        - dout
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  refin1-supply:
+    description: refin1 supply. Can be used as reference for conversion.
+
+  refin2-supply:
+    description: refin2 supply. Can be used as reference for conversion.
+
+  avdd-supply:
+    description: AVDD voltage supply. Can be used as reference for conversion.
+
+  iovdd-supply:
+    description: IOVDD voltage supply. Used for the chip interface.
+
+  spi-max-frequency:
+    maximum: 5000000
+
+  adi,mclk-sel:
+    description: |
+      Select the clock.
+      0: Internal 76.8kHz clock.
+      1: Internal 76.8kHz clock, output to the CLK pin.
+      2: External 76.8kHz clock.
+      3. External 153.6kHz clock.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+    default: 0
+
+  adi,int-ref-en:
+    description: |
+      Specify if internal reference should be enabled.
+    type: boolean
+    default: true
+
+  adi,bipolar:
+    description: Specify if the device should be used in bipolar mode.
+    type: boolean
+    default: false
+
+  adi,vbias-pins:
+    description: Analog inputs to apply a voltage bias of (AVDD − AVSS) / 2 to.
+    items:
+      minimum: 0
+      maximum: 15
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+patternProperties:
+  "^channel@([0-9]|1[0-5])$":
+    type: object
+    $ref: adc.yaml
+
+    properties:
+      reg:
+        description: |
+          The channel number.
+        items:
+          minimum: 0
+          maximum: 15
+
+      diff-channels:
+        description: |
+          Besides the analog inputs available, internal inputs can be used.
+          16: Internal temperature sensor.
+          17: AVss
+          18: Internal reference.
+          19: DGND.
+          20: (AVDD − AVSS)/6+
+          21: (AVDD − AVSS)/6-
+          22: (IOVDD − DGND)/6+
+          23: (IOVDD − DGND)/6-
+          24: (ALDO − AVSS)/6+
+          25: (ALDO − AVSS)/6-
+          26: (DLDO − DGND)/6+
+          27: (DLDO − DGND)/6-
+          28: V_MV_P
+          29: V_MV_M
+        $ref: adc.yaml
+        items:
+          minimum: 0
+          maximum: 29
+
+      adi,reference-select:
+        description: |
+          Select the reference source to use when converting on the
+          specific channel. Valid values are:
+          0: REFIN1(+)/REFIN1(−).
+          1: REFIN2(+)/REFIN2(−).
+          2: REFOUT/AVSS (Internal reference)
+          3: AVDD/AVSS
+          If not specified, internal reference is used.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1, 2, 3]
+        default: 2
+
+      adi,excitation-pin-0:
+        description: |
+          Analog input to apply excitation current to while the channel
+          is active.
+        minimum: 0
+        maximum: 15
+        default: 0
+
+      adi,excitation-pin-1:
+        description: |
+          Analog input to apply excitation current to while this channel
+          is active.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 15
+        default: 0
+
+      adi,excitation-current-0-nanoamps:
+        description: |
+          Excitation current in nanoamps to be applied to pin specified in
+          adi,excitation-pin-0 while this channel is active.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 100, 10000, 20000, 50000, 100000, 150000, 200000]
+        default: 0
+
+      adi,excitation-current-1-nanoamps:
+        description: |
+          Excitation current in nanoamps to be applied to pin specified in
+          adi,excitation-pin-1 while this channel is active.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 100, 10000, 20000, 50000, 100000, 150000, 200000]
+        default: 0
+
+      adi,burnout-current-nanoamps:
+        description: |
+          Burnout current in nanoamps to be applied for this channel.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 500, 2000, 4000]
+        default: 0
+
+      adi,buffered-positive:
+        description: Enable buffered mode for positive input.
+        type: boolean
+
+      adi,buffered-negative:
+        description: Enable buffered mode for negative input.
+        type: boolean
+
+    required:
+      - reg
+      - diff-channels
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      adc@0 {
+        compatible = "adi,ad4130-8-24-wlcsp";
+        reg = <0>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        spi-max-frequency = <5000000>;
+        interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
+        interrupt-parent = <&gpio>;
+
+        channel@0 {
+          reg = <0>;
+          /* AIN8, AIN9 */
+          diff-channels = <8 9>;
+        };
+
+        channel@1 {
+          reg = <1>;
+          /* AIN10, AIN11 */
+          diff-channels = <10 11>;
+        };
+
+        channel@2 {
+          reg = <2>;
+          /* Temperature Sensor, DGND */
+          diff-channels = <16 19>;
+        };
+
+        channel@3 {
+          reg = <3>;
+          /* Internal reference, DGND */
+          diff-channels = <18 19>;
+        };
+
+        channel@4 {
+          reg = <4>;
+          /* DGND, DGND */
+          diff-channels = <19 19>;
+        };
+      };
+    };
-- 
2.35.1


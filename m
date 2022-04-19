Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24665507174
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353629AbiDSPL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348100AbiDSPLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:11:22 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AD03A722;
        Tue, 19 Apr 2022 08:08:39 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id g13so5840889ejb.4;
        Tue, 19 Apr 2022 08:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r/lx8h/YA3FacDxHfZr6IUqjxAW27UWEEZueJ8izSdQ=;
        b=bPXlO4AoSraM0tJaXWBZDtpPacSA3+7RJTzOfNFgmEllEz484hDBgslUit6+GT0iA+
         VTy0gqyx/NjgCxc6qW25falHOwZR+pdVQA5k2yaCEp1WvQSw6Xx0JweRgMztWLzfw2kx
         yfWiCkGE890nqx/2cHbumyU3ApyH987Ogtc7jN1tJsmpN/DHSYSjgJeH3BW7bjTi5K+N
         u/iJ39tSJLhu6hXte/fRPRwkfmceDetgufDXJ9qLKhYO5Exu43NpMpOqDpDnOOHKzQH0
         MvN60hpnsxvIvcaYgtCPltzgPKJsqzNxqDGi92sN6vlLg/1MNn3aY8dW/rq6i7V+OOf0
         WDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r/lx8h/YA3FacDxHfZr6IUqjxAW27UWEEZueJ8izSdQ=;
        b=UNAd0RBXCRauPf5FLnwI2o7jdAz4Rko9gQSo0sNe9jNZz1FLsL4OFGeWRdobukVG8W
         Xh7eILvvJ571IAYzFHP1dAeWHXaYHII5cuELTkUluVAl6F+59wKgLdD3NJbUuHzcW8qS
         V8kJGcv6mDdut2a4wXr3lw36gqpqqSTybgMJUqWRFJ1hlFY/pcwTipDxZc5I0Ka46mng
         EAmq/uTHwKP5dKB3bRq3n7L4LxfClCsBUmMRiCSgV4x39MRwryntdlbkBse7I6O90KXa
         oXhgUl9CjhTAuGJpvJvHXkDaSx3c4iPHUl6QOnJ0ZFnoAdNImVpQ49dygV1RtU1g7icx
         ut8g==
X-Gm-Message-State: AOAM530M+/4CNOnNP2gtzjfLO1PpJu/xSdxbZlCRjz4cjICMw/c32d+g
        S4LCBYKhdHJxmFqGA/OybnjW384kAUc=
X-Google-Smtp-Source: ABdhPJw27tknQfYPFuRnJD772OVVF9udw4CC09CF4EnrlydXNAKZ7c4siRGdnvToJiM2VwQGc6nBww==
X-Received: by 2002:a17:906:478d:b0:6e8:8ee0:1f9f with SMTP id cw13-20020a170906478d00b006e88ee01f9fmr13642770ejc.296.1650380918393;
        Tue, 19 Apr 2022 08:08:38 -0700 (PDT)
Received: from demon-pc.localdomain ([188.24.22.234])
        by smtp.gmail.com with ESMTPSA id m1-20020a170906234100b006ef83025804sm3548604eja.87.2022.04.19.08.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 08:08:37 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: [PATCH v3 1/2] dt-bindings: iio: adc: add AD4130
Date:   Tue, 19 Apr 2022 18:08:27 +0300
Message-Id: <20220419150828.191933-2-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220419150828.191933-1-cosmin.tanislav@analog.com>
References: <20220419150828.191933-1-cosmin.tanislav@analog.com>
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

AD4130-8 is an ultra-low power, high precision, measurement solution for
low bandwidth battery operated applications.

The fully integrated AFE (Analog Front-End) includes a multiplexer for up
to 16 single-ended or 8 differential inputs, PGA (Programmable Gain
Amplifier), 24-bit Sigma-Delta ADC, on-chip reference and oscillator,
selectable filter options, smart sequencer, sensor biasing and excitation
options, diagnostics, and a FIFO buffer.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 .../bindings/iio/adc/adi,ad4130.yaml          | 264 ++++++++++++++++++
 1 file changed, 264 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
new file mode 100644
index 000000000000..32996b62cd20
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
@@ -0,0 +1,264 @@
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
+    maxItems: 1
+
+  interrupt-names:
+    description: |
+      Specify which interrupt pin should be configured as Data Ready / FIFO
+      interrupt.
+      Default if not supplied is dout-int.
+    enum:
+      - dout-int
+      - clk
+      - p2
+      - dout
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
+  adi,int-clk-out:
+    description: Specify if the internal clock should be exposed on the CLK pin.
+    type: boolean
+
+  adi,ext-clk-freq:
+    description: Specify the frequency of the external clock.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [76800, 153600]
+    default: 76800
+
+  adi,bipolar:
+    description: Specify if the device should be used in bipolar mode.
+    type: boolean
+
+  adi,vbias-pins:
+    description: Analog inputs to apply a voltage bias of (AVDD − AVSS) / 2 to.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    maxItems: 16
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
+          17: AVSS
+          18: Internal reference
+          19: DGND
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
+        items:
+          minimum: 0
+          maximum: 29
+
+      adi,reference-select:
+        description: |
+          Select the reference source to use when converting on the
+          specific channel. Valid values are:
+          0: REFIN1(+)/REFIN1(−)
+          1: REFIN2(+)/REFIN2(−)
+          2: REFOUT/AVSS (Internal reference)
+          3: AVDD/AVSS
+          If not specified, REFIN1 is used.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1, 2, 3]
+        default: 0
+
+      adi,excitation-pin-0:
+        description: |
+          Analog input to apply excitation current to while the channel
+          is active.
+        $ref: /schemas/types.yaml#/definitions/uint32
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
+    #include <dt-bindings/interrupt-controller/irq.h>
+
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
+
+          adi,reference-select = <2>;
+
+          /* AIN8, AIN9 */
+          diff-channels = <8 9>;
+        };
+
+        channel@1 {
+          reg = <1>;
+
+          adi,reference-select = <2>;
+
+          /* AIN10, AIN11 */
+          diff-channels = <10 11>;
+        };
+
+        channel@2 {
+          reg = <2>;
+
+          adi,reference-select = <2>;
+
+          /* Temperature Sensor, DGND */
+          diff-channels = <16 19>;
+        };
+
+        channel@3 {
+          reg = <3>;
+
+          adi,reference-select = <2>;
+
+          /* Internal reference, DGND */
+          diff-channels = <18 19>;
+        };
+
+        channel@4 {
+          reg = <4>;
+
+          adi,reference-select = <2>;
+
+          /* DGND, DGND */
+          diff-channels = <19 19>;
+        };
+      };
+    };
-- 
2.35.3


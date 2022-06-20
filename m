Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF06552223
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 18:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244338AbiFTQVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 12:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242450AbiFTQVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 12:21:22 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E7B6559;
        Mon, 20 Jun 2022 09:21:20 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id me5so22156789ejb.2;
        Mon, 20 Jun 2022 09:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kgeraIwqKjIZ3+8PeZj2VY5jVhJICMdVF12/pBry4E8=;
        b=ZwqZSpk2vH9taleQUsiJg7vyvmYf7of7i65bVNbbYfSj5TkElX4/qEZSmsdZpVbeyV
         C3MunbVWuqCvUnGYtI3IeJle1u5Je4YAIN4FEFR+sY8fpQa5CVHjrFbXNEamOrgiYhdV
         PC7eUNJ4FIBQIzdJHiVfto1x1Ldv9OiBEs41PJjpHY2r5vdus7bRYfdiZ1NlA7iHdknE
         /sbwDeDWZBMHbexS0LF0MMnHcl6R3qoGsbQ0LrkdspGkysRMbhcT79s4M9CPoVo7tj+N
         usPQfuWRB9XBHY5j9mBaG7oW6jc7GqPrPDmgQFV4oIRY20TuXYxyS9/GDK9OPoWDSqbQ
         jEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kgeraIwqKjIZ3+8PeZj2VY5jVhJICMdVF12/pBry4E8=;
        b=SsQn3nguWwoCX8fhcMwcfMYSBg7RjYuFNZPbAbEBg0AtmzC23KJDeL3x2EHZcHpfJK
         gSPK1UaobO/mq9LvSbHDRj3jjjjfjLykfHGrw9Hmafrp8Uheb4SWsnSEibfatNqdkupm
         VHCU1ZnXEfODY3fPIuYiKwBlE8d4uOFOmIsJhFpW5x8aTsGD8RNByox8PXQ4RWPc3DE+
         G3jH3GfFxhacCl0dCVE0MJ0a4rYMX1cRVUYtopeK7MJ1GQdn+bvVgxBkDdx36E7RsCYM
         PjStR/B5UbyFbRaH+AfdTmhW49Bko2lLlv8oG1Y1w+hocHWdced41Mwx5j4f2HqJVtUp
         kuUg==
X-Gm-Message-State: AJIora9nc2zZXtLU35wAfZEsWdmtSrW0LOFW41BRsO+mGyogQGSPm328
        Ylwd8Rzht2XSzu8AT1MfXZ3OIiI3W6s=
X-Google-Smtp-Source: AGRyM1utA4fXelLlX1f3nvF3xKf8/i1p0eCkUH0YfKeSWCEw5CvvULzPj62T6TCefV976+wOaGGkvw==
X-Received: by 2002:a17:906:3bd2:b0:711:ce53:5d5f with SMTP id v18-20020a1709063bd200b00711ce535d5fmr21671424ejf.500.1655742079338;
        Mon, 20 Jun 2022 09:21:19 -0700 (PDT)
Received: from demon-pc.localdomain ([79.119.98.153])
        by smtp.gmail.com with ESMTPSA id 2-20020a170906328200b00722dceb3f8bsm318744ejw.151.2022.06.20.09.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 09:21:19 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: [PATCH v5 1/2] dt-bindings: iio: adc: add AD4130
Date:   Mon, 20 Jun 2022 19:20:58 +0300
Message-Id: <20220620162059.1097264-2-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220620162059.1097264-1-cosmin.tanislav@analog.com>
References: <20220620162059.1097264-1-cosmin.tanislav@analog.com>
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
 .../bindings/iio/adc/adi,ad4130.yaml          | 259 ++++++++++++++++++
 1 file changed, 259 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
new file mode 100644
index 000000000000..b72f3da07309
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
@@ -0,0 +1,259 @@
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
+      - adi,ad4130
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
+      Default if not supplied is int.
+    enum:
+      - int
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
+  adi,ext-clk-freq-hz:
+    description: Specify the frequency of the external clock.
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
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        description: The channel number.
+        minimum: 0
+        maximum: 15
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
+      adi,excitation-current-0-nanoamp:
+        description: |
+          Excitation current in nanoamps to be applied to pin specified in
+          adi,excitation-pin-0 while this channel is active.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 100, 10000, 20000, 50000, 100000, 150000, 200000]
+        default: 0
+
+      adi,excitation-current-1-nanoamp:
+        description: |
+          Excitation current in nanoamps to be applied to pin specified in
+          adi,excitation-pin-1 while this channel is active.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 100, 10000, 20000, 50000, 100000, 150000, 200000]
+        default: 0
+
+      adi,burnout-current-nanoamp:
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
+        compatible = "adi,ad4130";
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
2.36.1


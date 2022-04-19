Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8516C5067CA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 11:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350379AbiDSJir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 05:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350350AbiDSJik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 05:38:40 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E831B78B;
        Tue, 19 Apr 2022 02:35:55 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id r13so31680966ejd.5;
        Tue, 19 Apr 2022 02:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DzznzN6//5u0Id/oxKym5EKV3NbLyKjwGRDtfrCzzlU=;
        b=YMEOnJAS2K1OHPl7cOhmbdyYORK26A/lJHyRSWqMYYZ4wqstrAWc+wo/csL57KNFkk
         7/5GKw/F85m23xvYw/zPIb6IHahei91Q7MbvOHTiwwo0UjcbImYQEfEGKNP6jK84xwPA
         ECbV759hE4YnSaGfRLWUkqFEZKfScpa8cDeugMgeXAPazmXYhlE350i4ilIwDoa7wCL2
         Vi/HtvyjbVj1ynGBfHrcz8WcQtKNz3a+KVfWd8qW+UPJ+irUa7E4haKQJWoVHvRilkrd
         JEuiEui/rjjbVa9eYcDNDj0JDq/+Ke7hS8ny8ydgZ2H9D9yGz6i1HMdZ5mzf+snIpTeg
         c2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DzznzN6//5u0Id/oxKym5EKV3NbLyKjwGRDtfrCzzlU=;
        b=gN7W46iz7CyAKq/KebRUyvteYGEDBa3vmezV1pApIgkrx0hn8/6FBXy/xg/StNW1M8
         jWbLHJSg4F4LlNZh9Q2bVF6Mn5gme+043EW1JVdcDd6s+FPXCdRQJOTYFCLbVirSVQG4
         bsgGyBp2gAczVFfmTwbfnvwutVDlwsnabBnvaVU7u83PH3CMl/araN4Q7HXWxDSb/nA/
         axuOwWcpdwNZPXujuUNF7fRkTP6h4sc/HFVvH+xMeyFtWtYlC9eCazTG+bDc3Iie0FlY
         e/TswVn0wJFKKfwcvr1ngi64z6lmwke/YPDKU3xkT0EV0QdYRfFu0H3B4qVkTU/UPAPd
         dE5A==
X-Gm-Message-State: AOAM531EEhh0T/Juf2kzIiy1JoiBSVlLTUXO0ZbHHaLkTle/XJlBwk8s
        jja4r6n50kQNr0DE8cExfNCjxNg2NQ4=
X-Google-Smtp-Source: ABdhPJwkMKonpWLwycJltNiLyL0ezYz9HUwvYP0/n0lFa4EviJ/muqhdBeFxuQvUUxoudABAK8WJxg==
X-Received: by 2002:a17:906:4fc3:b0:6e0:66a5:d59c with SMTP id i3-20020a1709064fc300b006e066a5d59cmr12404206ejw.131.1650360954084;
        Tue, 19 Apr 2022 02:35:54 -0700 (PDT)
Received: from demon-pc.localdomain ([188.24.22.234])
        by smtp.gmail.com with ESMTPSA id u25-20020a170906b11900b006e08588afedsm5467198ejy.132.2022.04.19.02.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 02:35:53 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: add AD4130
Date:   Tue, 19 Apr 2022 12:35:05 +0300
Message-Id: <20220419093506.135553-2-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220419093506.135553-1-cosmin.tanislav@analog.com>
References: <20220419093506.135553-1-cosmin.tanislav@analog.com>
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
 .../bindings/iio/adc/adi,ad4130.yaml          | 263 ++++++++++++++++++
 1 file changed, 263 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
new file mode 100644
index 000000000000..bf1d2a36b6a7
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
@@ -0,0 +1,263 @@
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
+        $ref: adc.yaml
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


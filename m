Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9033C56A3F3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235652AbiGGNl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbiGGNlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:41:53 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8B12AC50
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 06:41:48 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id h23so32444443ejj.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 06:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x9SEXfxmbq3oaLoJpaZMHa0I5XU73gWib47dKMECVig=;
        b=NdSs3D119NFmgx9oRALnzUPBiTr6HLHbcFMMpW9HFi/7TuvjPDLvVq9RoqeeVnSylS
         mggZ7yLse7gJ2pSZjyApacqi0G3+vJBaXPAN6P2V9MXwIXSOauCvgCJCAPR5IXQ2nAAL
         P4/3NUcqgL+LKfLRwHg24Tc3DJ1EZsdiHJB6KYycopNJ+xKQR9eDUMwl5ZzAAdZOFOKJ
         E/mD5WWf9i11yC+QBhrXclMDFpVwRrYtn0pydwbtg5UskzHGQDW0Jt/OO+iiB58TCOhE
         pgaCgsDYhCwQ7kugds+3Wf7fcsMYBWqijzHP5w5oH7PJMVmoruWIrsmkcvUnqNU6gu4W
         nj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x9SEXfxmbq3oaLoJpaZMHa0I5XU73gWib47dKMECVig=;
        b=B94p6Dm6RhZc2JRi5ERFGpmoCrcNqZS0tK5s6E9u87r0AAhBa6NBr3scvmbrIrbZj1
         VReJUYVAc47GVAcBLLz0cleTzQ5crDvFiKIUE9Z2BfpdwcLLSruHFI/CvikwLHJN9cMV
         IXivgpY47QKwEXYplVrMYHci2G1U7dbwTOdR7QHMd25ErCounFRUI9Zsb4EdYPkvGcsg
         xBd5vv7plfh+yOO0JBd2fceXAbZHKG3sIKLMjamUiWid0mlIxavziSrpj+WpPIR2d3jk
         WUFqRD4UGmiSuIqJYHjTEpYJSJLpcK0dmzEcV+TUFuxl706tzeqifxuurC+SKT2+j1W4
         UrlA==
X-Gm-Message-State: AJIora+INxBS9pa/LUV1W3zHum/UGdlQOApmKX53GvjDh5uqxKXfcJ2s
        Qf6xXCaT8oYrEgVVS+R+NwT/XFw6SOD61KQo
X-Google-Smtp-Source: AGRyM1sIsyTXLEnixxVMNlvhsmwWmUI/YRO8EhY0n1tEJQqa1alos+3k577qneBLKbZEYCnXqfppog==
X-Received: by 2002:a17:907:6ea3:b0:726:ca39:5d98 with SMTP id sh35-20020a1709076ea300b00726ca395d98mr45989383ejc.400.1657201307224;
        Thu, 07 Jul 2022 06:41:47 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id eg37-20020a05640228a500b0043a587eb95dsm9550141edb.5.2022.07.07.06.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 06:41:46 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v2 1/5] dt-bindings: mfd: Add bindings for MAX5970 and MAX5978
Date:   Thu,  7 Jul 2022 15:41:37 +0200
Message-Id: <20220707134141.1172300-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220707134141.1172300-1-Naresh.Solanki@9elements.com>
References: <20220707134141.1172300-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcello Sylvester Bauer <sylv@sylv.io>

The MAX597x is a hot swap controller with configurable fault protection.
It also has 10bit ADC for current & voltage measurements.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 .../devicetree/bindings/mfd/max5970.yaml      | 164 ++++++++++++++++++
 1 file changed, 164 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/max5970.yaml

diff --git a/Documentation/devicetree/bindings/mfd/max5970.yaml b/Documentation/devicetree/bindings/mfd/max5970.yaml
new file mode 100644
index 000000000000..a0cc6a7543b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/max5970.yaml
@@ -0,0 +1,164 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/max5970.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Regulator driver for MAX5970 smart switch from Maxim Integrated.
+
+maintainers:
+  - Patrick Rudolph <patrick.rudolph@9elements.com>
+
+description: |
+  The smart switch provides no output regulation, but independent fault protection
+  and voltage and current sensing.
+  Programming is done through I2C bus.
+
+  Datasheets:
+    https://datasheets.maximintegrated.com/en/ds/MAX5970.pdf
+    https://datasheets.maximintegrated.com/en/ds/MAX5978.pdf
+
+properties:
+  compatible:
+    enum:
+      - maxim,max5970
+      - maxim,max5978
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  leds:
+    type: object
+    description:
+      Properties for single channel.
+
+    patternProperties:
+      "^led@[0-3]$":
+        $ref: /schemas/leds/common.yaml#
+        type: object
+
+    additionalProperties: true
+
+  vss1-supply:
+    description: Supply of the first channel.
+
+  "#io-channel-cells":
+    const: 1
+
+  regulators:
+    type: object
+    description:
+      Properties for single channel.
+
+    patternProperties:
+      "^(sw[0-1])$":
+        $ref: /schemas/regulator/regulator.yaml#
+        type: object
+
+      shunt-resistor-micro-ohms:
+        description: |
+          The value of curent sense resistor in microohms.
+          Must be specified for each channel.
+
+    additionalProperties: true
+
+required:
+  - compatible
+  - reg
+  - regulators
+  - vss1-supply
+
+allOf:
+  - $ref: /schemas/regulator/regulator.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - maxim,max5970
+    then:
+      properties:
+        vss2-supply:
+          description: Supply of the second channel.
+
+        io-channels:
+          items:
+            - description: voltage first channel
+            - description: current first channel
+            - description: voltage second channel
+            - description: current second channel
+          description: |
+            Voltage and current for first and second channel.
+      required:
+        - vss2-supply
+
+    else:
+      properties:
+        io-channels:
+          items:
+            - description: voltage first channel
+            - description: current first channel
+          description: |
+            Voltage and current for first channel.
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            leds {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                led@0 {
+                        reg = <0>;
+                        label = "led0";
+                        default-state = "on";
+                };
+                led@1 {
+                        reg = <1>;
+                        label = "led1";
+                        default-state = "on";
+                };
+            };
+            regulator@3a {
+                    reg = <0x3a>;
+                    vss1-supply = <&p3v3>;
+                    compatible = "maxim,max5978";
+
+                    regulators {
+                            sw0_ref_0: SW0 {
+                                   regulator-compatible = "SW0";
+                                   shunt-resistor-micro-ohms = <12000>;
+                            };
+                    };
+            };
+    };
+
+  - |
+    i2c {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            regulator@3a {
+                    reg = <0x3a>;
+                    vss1-supply = <&p3v3>;
+                    vss2-supply = <&p5v>;
+                    compatible = "maxim,max5970";
+
+                    regulators {
+                            sw0_ref_1: SW0 {
+                                   regulator-compatible = "SW0";
+                                   shunt-resistor-micro-ohms = <12000>;
+                            };
+                            sw1_ref_1: SW1 {
+                                   regulator-compatible = "SW1";
+                                   shunt-resistor-micro-ohms = <10000>;
+                            };
+                    };
+            };
+    };
+...
-- 
2.35.3


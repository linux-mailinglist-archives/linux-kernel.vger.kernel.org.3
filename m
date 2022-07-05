Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A06566E81
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 14:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240086AbiGEMjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 08:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237580AbiGEMbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 08:31:13 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13206201AF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 05:23:08 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z19so15007672edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 05:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x9SEXfxmbq3oaLoJpaZMHa0I5XU73gWib47dKMECVig=;
        b=MPC7uKOHBGhXoxQ7KL4OLy9MH+UwM9DEQU9ot0hig/UBXF8xJwRKc3u7kdP+kmF6su
         q04zdeyvh+SQ2GwkYoWuXsTJaQUmoVMUw79cJkaldka5oWoO840MPXy7xVqgsnU7MpDZ
         rFHT7+9190pUnCy9VNHQ6HucrBygdIVd0SqZjEp65K/NqZEwWnOXMyslzcDRmFqqVlfo
         PX74foBtiLBgH4B8tn/6P2AkpT1jvSGSK2K6H28ncI9RionHAX8zxkrefd42CmBfsVJo
         jzHTORRdflhncVbhTHMNjdlhDnI+M6KTRkNbsNJ+XIsCse8XRttflqkp1FMC6mQj52H4
         ikHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x9SEXfxmbq3oaLoJpaZMHa0I5XU73gWib47dKMECVig=;
        b=IGyvq5s2Qpky/xTc6jVqW918jtfkAqe4SPMnoRto/uXNGx6/GrHMI3cJfQy8q+oJDt
         el9kLF7V702BuYmX0l/btxrARNMQFWJ5NSwELoxbRjuDmT6nmqBAoDuuB6rmM3erorVW
         E+qH0sQHC+A6Zkfv4M1e9NBIbn7FHKymA3DpzMKki37Vxi3B+B7rcs8ehfNDu5R9ITdg
         2DTGKdpHAJHx1EwFDRQwgmgX7wW6gqcKPm0Iu/YXwwEwQBb4b6qpoY1CdWWSNlOXTJth
         116JIAYJOwRXQFYilpB1WTFeA66X+9cML+nG0Z/yv3tkXQ+ROL/2b5eqv1WMWD9DDFFv
         Eq5w==
X-Gm-Message-State: AJIora/xrupWSt4myB0ou6FVXCQV5Pv8p6hdLX6+sVCAbv2luAkpEMk1
        L0dJf57qpG0G/P9ed3VYHQ9T4gnpnk55Qw==
X-Google-Smtp-Source: AGRyM1uPd7DoKvt97zd0EGbYw4S53t2roABdJuEnLJVSwC84Ir/eXJXqc9pEu7vKrQmqyzv13C/Uaw==
X-Received: by 2002:a05:6402:298a:b0:43a:76f8:a75c with SMTP id eq10-20020a056402298a00b0043a76f8a75cmr4453436edb.216.1657023786287;
        Tue, 05 Jul 2022 05:23:06 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id f15-20020a1709062c4f00b007081282cbd8sm15764758ejh.76.2022.07.05.05.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 05:23:05 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH 1/5] dt-bindings: mfd: Add bindings for MAX5970 and MAX5978
Date:   Tue,  5 Jul 2022 14:22:39 +0200
Message-Id: <20220705122244.472894-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.35.3
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


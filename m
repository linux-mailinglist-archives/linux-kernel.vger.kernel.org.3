Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41FE59B02B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 22:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbiHTT65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 15:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbiHTT6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 15:58:31 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC58165AB
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 12:58:29 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d10so6759803plr.6
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 12:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=di2SPGU5x1pTiaeM4K+fw8L7yPhLD/oZqXCEZ+r+vdc=;
        b=Kt3Dgo1jDXx7s0mZOIqmWuvVIfmApyXitJu3xxj8Ufsl5L2t88PxrUvhKRtjtOGMqn
         0HTS0DzqdQovD+OK2qgjp9Cn6p5AMCmRsnD5jsCn1EXqTSbRmbHTmVdlxr706KBOV7lZ
         IDMO6vHu4HcSqlnP9KARqlDfunDglJ+paNmYYFWAxmq6XXrA0kl2uRBSmEXZ4Pwe1tuF
         3rtmKPYCv89sKqnOAc51aN7Rj1eZ2nV453xWCszHObWdckDgLilkftxJwINRus2PaIA6
         B65DJR/iR8hcPntsfDNStrSpNrbHD7X3mzScjMlsBrY/m+4KutloRN33y7EVvv2cNQzp
         fM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=di2SPGU5x1pTiaeM4K+fw8L7yPhLD/oZqXCEZ+r+vdc=;
        b=7rhJcblXZDoo3l9aH1m9xSIoX1LaKUJiT7D7nkW6OAF9CGG8coG9HsbCxozt8zEKgw
         60plDknLMS4BJRdyGU9oCCqvR1YKxC3yq6GGz9EXjrxDKCpnUw6vE0ZnkPwaD+gPt7Ib
         /K3pmTxspc7I7FAM3OocCuSvrl22cKiBIW1EcPN9esbdR/Y1DgUfoHiV+S2P2nuc9tak
         9tVWzWhv1uFjKMW8jRFPn5U6Cc0/UNPzWyq1Uc5+rGwF/tG9rbDkyj7jqM+301ySZVU8
         0cX+wFYv0EHLxD02shZvPV2PDVM14AT8Q1U+nHw7Yl74o5GgrpO6UJUV9/VJ3iJ0idzU
         6TZg==
X-Gm-Message-State: ACgBeo37DllH87i39HaC1pZPDWEoMx7YNBSDit7/WR0BIKS+fxuLwLHa
        5tDkrkZXvYaUmfHbHRXaGeghtA==
X-Google-Smtp-Source: AA6agR7i3yPKVE4Kp5uSMKmrbyXdBYlktP2wELeOCMKvIwDlFLhtppJXK5q4nU97XkKr/2FPPx0bUg==
X-Received: by 2002:a17:90b:3b47:b0:1fa:d988:c916 with SMTP id ot7-20020a17090b3b4700b001fad988c916mr11885488pjb.240.1661025508471;
        Sat, 20 Aug 2022 12:58:28 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id u66-20020a626045000000b005363bc65bb1sm2316794pfb.91.2022.08.20.12.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 12:58:27 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, brad@pensando.io,
        blarson@amd.com, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        ulf.hansson@linaro.org, will@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v6 06/17] dt-bindings: mfd: amd,pensando-elbasr: Add AMD Pensando Elba System Resource chip
Date:   Sat, 20 Aug 2022 12:57:39 -0700
Message-Id: <20220820195750.70861-7-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220820195750.70861-1-brad@pensando.io>
References: <20220820195750.70861-1-brad@pensando.io>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brad Larson <blarson@amd.com>

Add support for the AMD Pensando Elba SoC System Resource chip
using the SPI interface.  The Elba SR is a Multi-function Device
supporting device register access using CS0, smbus interface for
FRU and board peripherals using CS1, dual Lattice I2C masters for
transceiver management using CS2, and CS3 for flash access.

Signed-off-by: Brad Larson <blarson@amd.com>
---
 .../bindings/mfd/amd,pensando-elbasr.yaml     | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml

diff --git a/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml b/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
new file mode 100644
index 000000000000..ded347c3352c
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/amd,pensando-elbasr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD Pensando Elba SoC Resource Controller bindings
+
+description: |
+  AMD Pensando Elba SoC Resource Controller is a set of
+  miscellaneous control/status registers accessed on CS0,
+  a designware i2c master/slave on CS1, a Lattice rd1173
+  dual i2c master on CS2, and flash on CS3.  The /dev interfaces
+  created are /dev/pensr0.<CS>.  Hardware reset of the eMMC
+  is implemented by a sub-device reset-controller which accesses
+  a CS0 control register.
+
+maintainers:
+  - Brad Larson <blarson@amd.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - amd,pensando-elbasr
+
+  spi-max-frequency:
+    description: Maximum SPI frequency of the device in Hz.
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - spi-max-frequency
+
+patternProperties:
+  '^reset-controller@[a-f0-9]+$':
+    $ref: /schemas/reset/amd,pensando-elbasr-reset.yaml
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        num-cs = <4>;
+
+        sysc: system-controller@0 {
+            compatible = "amd,pensando-elbasr";
+            reg = <0>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            spi-max-frequency = <12000000>;
+
+            rstc: reset-controller@0 {
+                compatible = "amd,pensando-elbasr-reset";
+                reg = <0>;
+                #reset-cells = <1>;
+            };
+        };
+
+        i2c1: i2c@1 {
+            compatible = "amd,pensando-elbasr";
+            reg = <1>;
+            spi-max-frequency = <12000000>;
+        };
+
+        i2c2: i2c@2 {
+            compatible = "amd,pensando-elbasr";
+            reg = <2>;
+            spi-max-frequency = <12000000>;
+            interrupt-parent = <&porta>;
+            interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+        };
+
+        flash@3 {
+            compatible = "amd,pensando-elbasr";
+            reg = <3>;
+            spi-max-frequency = <12000000>;
+        };
+    };
+
+...
-- 
2.17.1


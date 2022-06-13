Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79949549FFB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350869AbiFMUrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350859AbiFMUqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:46:15 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAF563E8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 12:57:35 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id cx11so6586264pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 12:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CxeTCAcTP8AUI8T+Y1RRaiE90Utk4Y2UEreNjJtF518=;
        b=K/v2jO5IdTe/h76LE2Jxy/tvRZn9AmCccVf1AkXLWlMIzbkmxYm/ZwgFbNO6+3O/Kt
         4V9MpxjJroIQakw44BkG+KTieiewz5bO7dRHXDEYbW2tFWdQITQLEFjkVgAgZ++w3zb3
         yQ+q0XcGD9QYgULfH+JLrJSAajGFvEvYoFa98mhY72p+MamwyB57K4GpYYQK7hqwOIWw
         GxxplsF/k6yXLLYJLUdbfWE7FYArvAyiFDSlvX3GjiDAqFHAQUD9anUbzfRM7jJ3VuHK
         rRt50hbqOH9hhJjNwcJWT8Nait8EO2Mt3MiqE6MXiqHbK1X2Lj1c0ICx66Z5Xo82ZRC5
         ysjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CxeTCAcTP8AUI8T+Y1RRaiE90Utk4Y2UEreNjJtF518=;
        b=pAaxASm0Qo5hKUeG/sSZPgtGR/pbcLvTJB67VahTuG/9/5EpBBHx0VjR6QZDpsMn9m
         Q2nFuwmJK3LZfQemEs1hwVHRMLLu8CcHHMDjbHxuFuYf4Lw4zWxBm2VXOV4ibofrhqjA
         gO8iu/Eugd7vCruo0GexwR9ekIdQeTBYN6C3fI9QFUIVKYXCdulc/57R6jYZ88qGVgmx
         6uRBuY7x8x5MW+IBRFer8+EBMiXyvTo+8IVQ5KWzb626Xs/9vDOzHqQ/OSJq4EVfhzq6
         Ely1X7oKqiqUqWYjzKWBw5J14ef+hXFTpOFXAwcs9876CDHkOE9MzNmqoDiGu4Y8xW3A
         h51A==
X-Gm-Message-State: AJIora8Hq2xSvpg+ER0DzTM2y6P7fokwGF4wmTipmFTIW9P8aA04naFt
        0P7Bcy5u+1gRW12FGhNci4cWNg==
X-Google-Smtp-Source: AGRyM1uaxRjzT8MWjnK6bWvdvwkw+v6UKaPUZDECQDILWdwJMIHOst5z4ufQem0zzfJHU5KaXms+Sw==
X-Received: by 2002:a17:902:a613:b0:168:a216:f3ff with SMTP id u19-20020a170902a61300b00168a216f3ffmr584840plq.21.1655150254961;
        Mon, 13 Jun 2022 12:57:34 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id q21-20020a170902edd500b0016797c33b6csm5509357plk.116.2022.06.13.12.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 12:57:34 -0700 (PDT)
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
Subject: [PATCH v5 06/15] dt-bindings: mfd: amd,pensando-elbasr: Add AMD Pensando Elba System Resource chip
Date:   Mon, 13 Jun 2022 12:56:49 -0700
Message-Id: <20220613195658.5607-7-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220613195658.5607-1-brad@pensando.io>
References: <20220613195658.5607-1-brad@pensando.io>
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
 .../bindings/mfd/amd,pensando-elbasr.yaml     | 93 +++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml

diff --git a/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml b/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
new file mode 100644
index 000000000000..13356800b1cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/amd,pensando-elbasr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD Pensando Elba SoC Resource Controller bindings
+
+description: |
+  AMD Pensando Elba SoC Resource Controller bindings attached to a SPI bus.
+
+maintainers:
+  - Brad Larson <blarson@amd.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - amd,pensando-elbasr
+      - const: simple-mfd
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
+    $ref: ../reset/amd,pensando-elbasr-reset.yaml
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/reset/amd,pensando-elba-reset.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    spi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        num-cs = <4>;
+
+        spi@0 {
+          compatible = "amd,pensando-elbasr", "simple-mfd";
+          reg = <0>;
+          #address-cells = <1>;
+          #size-cells = <0>;
+          spi-max-frequency = <12000000>;
+
+          rstc: reset-controller@0 {
+            compatible = "amd,pensando-elbasr-reset";
+            reg = <0>;
+            #reset-cells = <1>;
+          };
+        };
+
+        spi@1 {
+          compatible = "amd,pensando-elbasr", "simple-mfd";
+          reg = <1>;
+          spi-max-frequency = <12000000>;
+        };
+
+        spi@2 {
+          compatible = "amd,pensando-elbasr", "simple-mfd";
+          reg = <2>;
+          spi-max-frequency = <12000000>;
+          interrupt-parent = <&porta>;
+          interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+        };
+
+        spi@3 {
+          compatible = "amd,pensando-elbasr", "simple-mfd";
+          reg = <3>;
+          spi-max-frequency = <12000000>;
+        };
+    };
+
+...
-- 
2.17.1


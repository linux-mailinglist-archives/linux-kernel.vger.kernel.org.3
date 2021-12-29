Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86CC14812D7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 13:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238663AbhL2MrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 07:47:11 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:34536
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238590AbhL2MrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 07:47:07 -0500
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 50ECE3F206
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640782026;
        bh=OwXVxDUNHiNBsMlyx2vvQ9vqNwzXFDkR9fITbhvv6ps=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=suy8u90G4rUI1suy+HRcW4qWKx3f3fIdCH+RCHrbbHxUHZFsU07VyC8VtISdtCR6v
         W8uEuOEErnDJgItXQgdyMFZLR+iz3wvNUTBR/dcIKuJ5yt86q/DzZx47z1KIeT/t5o
         /DDyk8twWqtWWy3C97NwoH6eJigOob+m6M4TE02CHKg3novpXUiK6mhfac3PCkqafZ
         Q8WRojBKVZnMT5IYqMscqBvSlDFDI7uYANOGQkf2cVrosecJcR8eWIgLzc+IFkMS+H
         cQFdwGjbbpf94ZyVcTXDWNxeVR+ZBhTPfVkBDLXkowxN9u3t5/1qTBOuB4BmknccYw
         XCsBiTspotzjA==
Received: by mail-lj1-f198.google.com with SMTP id n6-20020a2e82c6000000b00221698ffa68so7246397ljh.17
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 04:47:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OwXVxDUNHiNBsMlyx2vvQ9vqNwzXFDkR9fITbhvv6ps=;
        b=695OCmra06X8oCuerAU9rYEzGLUj++3Vspz2Br9QLeDrWQvf/EwaG5N5gO8stF/Dui
         vwz2294hXC+h+kwP49lT6AFSRvk8QKnUq/aAXEc2taUL5+C3x+g4Ckl/FtCZR8hxleg5
         wEPvp1qGqll7j0Uskh2wzwXSy85A2QDdXAGk8kt1I/lT3kgXkBNIjTmQIEq04BHFrDbw
         LYEJo+u6Dc4PSmrbUBNaKf/nKp8JRCaTpFvSQk3DBWbhLcY7N+XCYYR9LhMprJ/wZmlF
         Q6iTWNxzD0+G6jT3Iew5DN2l8dropqnvrT6fAyHFMMLHYM7q9UctJwMJ6aG+ar+hNARx
         eI4g==
X-Gm-Message-State: AOAM530bxaky8Z7eObrH0XlBux8jLeF+IRtc3qkW/Scidd+RKEPx8ray
        ycy0pNTnpGzUPZTUt8BFZeUe5Y/7+LO16YUDnOpY7cW6LSIpH7qpk25EhBBfyKMkaIRuM1YTKXi
        YaClU0bhUJIp+awAT0Gxgjtj0xJMnD1WNjHKeVXX0wg==
X-Received: by 2002:ac2:51bc:: with SMTP id f28mr22837349lfk.222.1640782025649;
        Wed, 29 Dec 2021 04:47:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzxlGSDNuVy9A0zTlQuoOwthlW7pXRr59PjrQaxjdZcO/w8Pf78FJV3HvNi8hIKJtFoMm3G1w==
X-Received: by 2002:ac2:51bc:: with SMTP id f28mr22837340lfk.222.1640782025478;
        Wed, 29 Dec 2021 04:47:05 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id e11sm711158ljn.73.2021.12.29.04.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 04:47:04 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Inki Dae <inki.dae@samsung.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Beomho Seo <beomho.seo@samsung.com>
Subject: [PATCH 4/5] dt-bindings: mfd: maxim,max77843: add MAX77843 bindings
Date:   Wed, 29 Dec 2021 13:46:30 +0100
Message-Id: <20211229124631.21576-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211229124631.21576-1-krzysztof.kozlowski@canonical.com>
References: <20211229124631.21576-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings for MAX77843 MFD driver, based on Exynos5433 TM2
devicetree.  These are neither accurate nor finished bindings but at
least allow parsing existing DTS files.

The example DTS was copied from existing DTS
(exynos5433-tm2-common.dtsi), so keep the license as GPL-2.0-only.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/mfd/maxim,max77843.yaml          | 144 ++++++++++++++++++
 1 file changed, 144 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max77843.yaml

diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77843.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77843.yaml
new file mode 100644
index 000000000000..7f3d74f254af
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/maxim,max77843.yaml
@@ -0,0 +1,144 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/maxim,max77843.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX77843 MicroUSB and Companion Power Management IC
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+description: |
+  This is a part of device tree bindings for Maxim MAX77843 MicroUSB
+  Integrated Circuit (MUIC).
+
+  The Maxim MAX77843 is a MicroUSB and Companion Power Management IC which
+  includes voltage current regulators, charger, fuel-gauge, haptic motor driver
+  and MicroUSB management IC.
+
+properties:
+  compatible:
+    const: maxim,max77843
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  extcon:
+    $ref: ../extcon/maxim,max77843.yaml
+
+  motor-driver:
+    type: object
+    properties:
+      compatible:
+        const: maxim,max77843-haptic
+
+      haptic-supply:
+        description: Power supply to the haptic motor
+
+      pwms:
+        maxItems: 1
+
+    required:
+      - compatible
+      - haptic-supply
+      - pwms
+
+  regulators:
+    $ref: ../regulator/maxim,max77843.yaml
+
+required:
+  - compatible
+  - interrupts
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@66 {
+            compatible = "maxim,max77843";
+            interrupt-parent = <&gpa1>;
+            interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
+            reg = <0x66>;
+
+            extcon {
+                compatible = "maxim,max77843-muic";
+
+                connector {
+                    compatible = "samsung,usb-connector-11pin",
+                                 "usb-b-connector";
+                    label = "micro-USB";
+                    type = "micro";
+
+                    ports {
+                        #address-cells = <1>;
+                        #size-cells = <0>;
+
+                        port@0 {
+                            /*
+                             * TODO: The DTS this is based on does not have
+                             * port@0 which is a required property. The ports
+                             * look incomplete and need fixing.
+                             * Add a disabled port just to satisfy dtschema.
+                             */
+                            reg = <0>;
+                            status = "disabled";
+                        };
+
+                        port@3 {
+                            reg = <3>;
+                            endpoint {
+                                remote-endpoint = <&mhl_to_musb_con>;
+                            };
+                        };
+                    };
+                };
+
+                ports {
+                    port {
+                        endpoint {
+                            remote-endpoint = <&usb_to_muic>;
+                        };
+                    };
+                };
+            };
+
+            regulators {
+                compatible = "maxim,max77843-regulator";
+
+                SAFEOUT1 {
+                    regulator-name = "SAFEOUT1";
+                    regulator-min-microvolt = <3300000>;
+                    regulator-max-microvolt = <4950000>;
+                };
+
+                SAFEOUT2 {
+                    regulator-name = "SAFEOUT2";
+                    regulator-min-microvolt = <3300000>;
+                    regulator-max-microvolt = <4950000>;
+                };
+
+                CHARGER {
+                    regulator-name = "CHARGER";
+                    regulator-min-microamp = <100000>;
+                    regulator-max-microamp = <3150000>;
+                };
+            };
+
+            motor-driver {
+                compatible = "maxim,max77843-haptic";
+                haptic-supply = <&ldo38_reg>;
+                pwms = <&pwm 0 33670 0>;
+            };
+        };
+    };
-- 
2.32.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC7C4813F7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 15:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240185AbhL2OPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 09:15:45 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:41038
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240178AbhL2OPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 09:15:37 -0500
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8DF843FFDB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 14:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640787336;
        bh=xjpaBT4k5k7qUGav+X1f3ed+VMfqTCz+TxkdIGd/Ihc=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=J9/xNCTsAxgAW2gWrz9n70uNPLd2xKLoVJsqwJcY3EXAsunHMtoCyQuS0tpG0UHT3
         K5geDEtf6Vp16FON2gcNI7lifCRX77RXmzbGV8BsaT7H2nobdv7RU4TsvEkGDXKPt8
         CLm5czCpvLSVd6SM2V1jxLcN1EWFKEbMQA7OZQ/XbIGFbAIkEebvEsTlciJEJeFSDt
         KunK8ZL5kuRRaqyUWTUQ0bUuaCQs/AIz68l5EXvLpKM0RJXMFh9znrpcBL8ncHrJP/
         90XDVH9scyJKk/HkuozElAGjVNm+UFXl2RVXazOl/qJjXR2eYi6X1kuDUmUqqXKYa9
         M7IAqSWlnp2+w==
Received: by mail-lj1-f197.google.com with SMTP id y4-20020a2e95c4000000b0022dbab5f69eso4540364ljh.14
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 06:15:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xjpaBT4k5k7qUGav+X1f3ed+VMfqTCz+TxkdIGd/Ihc=;
        b=K8W9S3BJOAvtj6aJqW3XXAVXp3YxiFF6BYP1VSkd0DgEYewY9Xey2AzsWyyqqYYLD6
         RKhS8ck29p9qeOjAxpjIewv1dStBtK7VRLWXNVl6shiqcIEBRoBfu0BOoz/YfvI8+aNV
         SAsUB4L9n0wLRF4cQwqqzZGIMFoxrtSfv6u+WfYQumvV/b8mxs/yL13pob5oKdU6qT7H
         TC31sq9+nZJMmXOkOa/o3oTst2Gm1rGJ7Acv9uoG7jlJFRqFz0TEDCgmgmxMwcVfotbG
         dKDOovQPYkW1bYZDGtxAm1Zqihz7vU2Yjv425/UApmCEGmzbEksFUkxU2avHMNIeu2cQ
         maaQ==
X-Gm-Message-State: AOAM532Eb6kkhG+gH242cbqtbFbLFT314S0LPn/AWkEB+zUDTwcNQUoL
        akO6tcWOSoLyngZXdR5ChqC2rGbFTguBJZVsWnQRsuIJhmCmHIfMAsFP40sQuMTfL9YtOVdvlzo
        ApfozRcMbofBe5IjHDIR9OS3epu8C+H2KzoUV5u0QTQ==
X-Received: by 2002:ac2:4e8a:: with SMTP id o10mr22695256lfr.560.1640787335838;
        Wed, 29 Dec 2021 06:15:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzjImqt/WxrVZhwSXYX8us+ll9PozKa8qXbA8xwGfKdbRXwMbBRcwVvp98V5cj9NZiV1cQHIg==
X-Received: by 2002:ac2:4e8a:: with SMTP id o10mr22695241lfr.560.1640787335628;
        Wed, 29 Dec 2021 06:15:35 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id a16sm1316164ljm.98.2021.12.29.06.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 06:15:34 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 2/4] dt-bindings: power: supply: maxim,max14577: convert to dtschema
Date:   Wed, 29 Dec 2021 15:15:22 +0100
Message-Id: <20211229141524.34174-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211229141524.34174-1-krzysztof.kozlowski@canonical.com>
References: <20211229141524.34174-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Charger bindings of Maxim MAX14577/MAX77836 MUIC to DT
schema format.  The existing bindings were defined in
../bindings/mfd/max14577.txt.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/power/supply/maxim,max14577.yaml | 84 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max14577.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max14577.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max14577.yaml
new file mode 100644
index 000000000000..3978b48299de
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max14577.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/maxim,max14577.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX14577/MAX77836 MicroUSB and Companion Power Management IC Charger
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+description: |
+  This is a part of device tree bindings for Maxim MAX14577/MAX77836 MicroUSB
+  Integrated Circuit (MUIC).
+
+  See also Documentation/devicetree/bindings/mfd/maxim,max14577.yaml for
+  additional information and example.
+
+properties:
+  compatible:
+    enum:
+      - maxim,max14577-charger
+      - maxim,max77836-charger
+
+  maxim,constant-uvolt:
+    description:
+      Battery Constant Voltage in uV
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 4000000
+    maximum: 4350000
+
+  maxim,eoc-uamp:
+    description: |
+      Current in uA for End-Of-Charge mode.
+      MAX14577: 50000-20000
+      MAX77836: 5000-100000
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  maxim,fast-charge-uamp:
+    description: |
+      Current in uA for Fast Charge
+      MAX14577: 90000-950000
+      MAX77836: 45000-475000
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  maxim,ovp-uvolt:
+    description:
+      OverVoltage Protection Threshold in uV; In an overvoltage condition, INT
+      asserts and charging stops.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [6000000, 6500000, 7000000, 7500000]
+
+required:
+  - compatible
+  - maxim,constant-uvolt
+  - maxim,eoc-uamp
+  - maxim,fast-charge-uamp
+  - maxim,ovp-uvolt
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: maxim,max14577-charger
+    then:
+      properties:
+        maxim,eoc-uamp:
+          minimum: 50000
+          maximum: 200000
+        maxim,fast-charge-uamp:
+          minimum: 90000
+          maximum: 950000
+    else:
+      # max77836
+      properties:
+        maxim,eoc-uamp:
+          minimum: 5000
+          maximum: 100000
+        maxim,fast-charge-uamp:
+          minimum: 45000
+          maximum: 475000
+
+additionalProperties: false
diff --git a/MAINTAINERS b/MAINTAINERS
index d1f8f312f322..13e21c229c5d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11681,6 +11681,7 @@ M:	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
 M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
 L:	linux-pm@vger.kernel.org
 S:	Supported
+F:	Documentation/devicetree/bindings/power/supply/maxim,max14577.yaml
 F:	Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
 F:	drivers/power/supply/max14577_charger.c
 F:	drivers/power/supply/max77693_charger.c
-- 
2.32.0


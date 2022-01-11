Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810D448B47E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344779AbiAKRvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:51:04 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:54074
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344709AbiAKRvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:51:00 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1B7373F1EE
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 17:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641923459;
        bh=Ky4Nsy7oalY16bNXsSxGbr4iSjVK2d1F92X5y/VROW8=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=BG5MMDR2bAihcm4OOdL4rab+l0NQKyV6Q1SPDQvR7e/qldEx/wZMRzB/ecFtHNB/Z
         vHv+GcZSKNXpGr2eeKN0xpHrmw7FjdE/lCJSJfWunvvFOqaSXA4xB8jUZPR7QTL6Ta
         Xm96q/Z/j2KqNMEwYw/IlwVnMotnCsw50w92BtMGnCGgLBJc6H2p+i3FOxko6QT+pZ
         7RPDSDUgsK81b7Ra/tKx0C1QW19+nFWHI65S90ofpSj8lm0WwhuZTS3pjG7+fnxwxa
         eY80Xid44D0QvK/6SaX5BLx9xVU+q+nO/JgxyHE5ZGh8R89jW618z4E3l1djyPhww/
         qXryabjp/8T5A==
Received: by mail-ed1-f72.google.com with SMTP id z9-20020a05640240c900b003fea688a17eso3064890edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 09:50:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ky4Nsy7oalY16bNXsSxGbr4iSjVK2d1F92X5y/VROW8=;
        b=zEYph0Kb7ZL5N/m9klC+KkcpG3lA0ryTQI3hRX889oK1kDKPfWRBNvoH1+cwLqBAHh
         7A6hq4Ke6QTLxtm8qFLMY/A3NbefnwZoW2tz3MHt4Ifst9EsGjwheC3KqoMyooju6a9N
         A7aH87IR3IYhB084Z15tU/fPFwx73RSM5pkHcyJgAe+YQRch5F9BlzTZsR4IftNNdC5U
         +1zFp4s8kaXWJ1PyXoViGVPmBVtoWyRh1aZxp0XCTb2SoTKFtemEwO4lN8zyIxDBYLVS
         5+yScSLNbnDkVKA6HWde5QZvXGoob24Do0+ZO6F9K546IcYLA7HP9dScbxodH7tlU8op
         l+3g==
X-Gm-Message-State: AOAM533ITUAtJPjK2f+y0CbfbO/ltoUnWZM4Jkq/LJdFCjxGUZSaSEqD
        HmQWgPilNMEhJ5I0Byp6P4dGsX8z1uFcpedIU9DsuOoEQccg3CKUxcIRY90oc7I3OwnxBL7Tvpi
        UoHUkG7duJfk6raZe19WsMZQsak8mlhlOSGsz+3wGig==
X-Received: by 2002:a05:6402:cb8:: with SMTP id cn24mr4240219edb.95.1641923458807;
        Tue, 11 Jan 2022 09:50:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzx9wwlVpoawVqU0Ge74rjEjab/82+gkGE3u88EenodQl8wnd5r337GQ7qDD/V4AqiEEq2YTQ==
X-Received: by 2002:a05:6402:cb8:: with SMTP id cn24mr4240194edb.95.1641923458503;
        Tue, 11 Jan 2022 09:50:58 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id p25sm5265160edw.75.2022.01.11.09.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 09:50:57 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: leds: maxim,max77693: convert to dtschema
Date:   Tue, 11 Jan 2022 18:50:14 +0100
Message-Id: <20220111175017.223966-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111175017.223966-1-krzysztof.kozlowski@canonical.com>
References: <20220111175017.223966-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the LEDs bindings of Maxim MAX77693 MUIC to DT schema format.
The existing bindings were defined in ../bindings/mfd/max77693.txt.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/leds/maxim,max77693.yaml         | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/maxim,max77693.yaml

diff --git a/Documentation/devicetree/bindings/leds/maxim,max77693.yaml b/Documentation/devicetree/bindings/leds/maxim,max77693.yaml
new file mode 100644
index 000000000000..86a0005cf156
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/maxim,max77693.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/maxim,max77693.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX77693 MicroUSB and Companion Power Management IC LEDs
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+description: |
+  This is a part of device tree bindings for Maxim MAX77693 MicroUSB Integrated
+  Circuit (MUIC).
+
+  There are two LED outputs available - FLED1 and FLED2. Each of them can
+  control a separate LED or they can be connected together to double the
+  maximum current for a single connected LED. One LED is represented by one
+  child node.
+
+  See also Documentation/devicetree/bindings/mfd/maxim,max77693.yaml for
+  additional information and example.
+
+properties:
+  compatible:
+    const: maxim,max77693-led
+
+  maxim,boost-mode:
+    description:
+      In boost mode the device can produce up to 1.2A of total current on both
+      outputs. The maximum current on each output is reduced to 625mA then. If
+      not enabled explicitly, boost setting defaults to LEDS_BOOST_FIXED in
+      case both current sources are used.
+      See LEDS_BOOST_* in include/dt-bindings/leds/common.h.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2]
+
+  maxim,boost-mvout:
+    description: |
+      Output voltage of the boost module in millivolts.
+      Valid values: 3300 - 5500, step by 25 (rounded down)
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 3300
+    maximum: 5500
+    default: 3300
+
+  maxim,mvsys-min:
+    description: |
+      Low input voltage level in millivolts. Flash is not fired if chip
+      estimates that system voltage could drop below this level due to flash
+      power consumption.
+      Valid values: 2400 - 3400, step by 33 (rounded down)
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 2400
+    maximum: 3400
+    default: 2400
+
+patternProperties:
+  "^([a-z]+-)?led[01]?$":
+    type: object
+    $ref: common.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      led-sources:
+        allOf:
+          - minItems: 1
+            maxItems: 2
+            items:
+              minimum: 0
+              maximum: 1
+
+      led-max-microamp:
+        description: |
+          Valid values for a LED connected to one FLED output:
+            15625 - 250000, step by 15625 (rounded down)
+          Valid values for a LED connected to both FLED outputs:
+            15625 - 500000, step by 15625 (rounded down)
+
+      flash-max-microamp:
+        description: |
+          Valid values for a single LED connected to one FLED output
+          (boost mode must be turned off):
+            15625 - 1000000, step by 15625 (rounded down)
+          Valid values for a single LED connected to both FLED outputs:
+            15625 - 1250000, step by 15625 (rounded down)
+          Valid values for two LEDs case:
+            15625 - 625000, step by 15625 (rounded down)
+
+      flash-max-timeout-us:
+        description: |
+          Valid values: 62500 - 1000000, step by 62500 (rounded down)
+        minimum: 62500
+        maximum: 1000000
+
+    required:
+      - flash-max-microamp
+      - flash-max-timeout-us
+      - led-max-microamp
+      - led-sources
+
+required:
+  - compatible
+
+additionalProperties: false
-- 
2.32.0


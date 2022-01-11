Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33D048B444
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241941AbiAKRo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:44:27 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:53486
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344111AbiAKRoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:44:21 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0F23A40A8A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 17:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641923060;
        bh=UwxCg/3JRxb+xIwzo2AXdt3q4ESk3LoFT4Bw/xZKpww=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=o5GXslVAzD3nFqgjJJFAtxtn3n/4JpuSUEb1Gg9tL2Nsb5U8q7N25pMY+YeNhoOWg
         VACqAn+3BNMxQg1xQox+tCHEtbOEzMKrjo0i0oyPR7lLUxjbjaxPtQkjUiiu7Kn5LS
         /Vpe1t+5R2J4Gt82H4DhG+rYLIS2duYf3i93zo075hEXQ6e12lyUBcxwDdvtitr3pz
         JTiqY6CP9vxzsZx9CebMCkZ/FeCU+pcvHPYaphY2PGbzx6TZIkAVhvGNVlLB8dNicE
         QtMkdGzvgWFBMC/WsPSASUV+h9R2hlnB+DWXi43pi9hr14Af/H/INhTg8rgl1i8f9P
         Tl1vLyk4ZdK9A==
Received: by mail-ed1-f71.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso13946398edt.20
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 09:44:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UwxCg/3JRxb+xIwzo2AXdt3q4ESk3LoFT4Bw/xZKpww=;
        b=2LF4OeLT+KewLFgYsZbhh0w3F82033ExRwSuZcoV1asYKHTQ/e2tX9B25zdoZtJFyq
         4weJbdEx24/VFQF8mxK8VveNJIBGtZ7BnPp6onQPE05iYN44xn0k9TrSWq2gXaHh8Rwh
         eSP0nB7DCaD8E62pcpSaZ+dgcrdPkkC6DARdJYqR0kIZ/qAPHUBHKI2SxrYcDXCSN4z5
         RXsFoNfLLwdQ5wLUDSFEp/J/iFuPd6wNxwSpasVQuWObbD1dqn5iqChpdwTqJSfm1Jgh
         iBkyC3ahRUF4ZbodckIaobQzBMriXBAZZk7w0glvtrksURwafw1t5HIxhH5OUwZJxemQ
         8EQA==
X-Gm-Message-State: AOAM532An5e7Ns3Y3Vlmv8ClSYFM/steo0RasaVpDCh6jIPoAfUtq0FO
        QKtOn30idw/v01LbG41hsUzEFi8wPQH+4HAezg4GUCdgaK7WnWLLPiaItb8cXmGsLYH06vxugf6
        8W1Je/OvGMz5MMbQ/tl299Bp2k6X0SvqsybzW5JGbtw==
X-Received: by 2002:a05:6402:1c08:: with SMTP id ck8mr5463523edb.406.1641923059344;
        Tue, 11 Jan 2022 09:44:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxsS0hDLRYk0r5JjweCUErlbNd0YkPquUINIsjfQ4os97kXEQhtnlMaSz1xWFtOEmAAPmTevg==
X-Received: by 2002:a05:6402:1c08:: with SMTP id ck8mr5463508edb.406.1641923059150;
        Tue, 11 Jan 2022 09:44:19 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id g9sm3758657ejo.222.2022.01.11.09.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 09:44:18 -0800 (PST)
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
Cc:     Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/4] dt-bindings: power: supply: maxim,max14577: convert to dtschema
Date:   Tue, 11 Jan 2022 18:43:35 +0100
Message-Id: <20220111174337.223320-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111174337.223320-1-krzysztof.kozlowski@canonical.com>
References: <20220111174337.223320-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Charger bindings of Maxim MAX14577/MAX77836 MUIC to DT
schema format.  The existing bindings were defined in
../bindings/mfd/max14577.txt.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB194CC0DE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 16:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbiCCPNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 10:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbiCCPNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:13:48 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525C743AC2;
        Thu,  3 Mar 2022 07:13:01 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 29so7134849ljv.10;
        Thu, 03 Mar 2022 07:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GARCkxgiyMRjl3V6/FiJ6/g+bqmKHGIILslZSNmkwfA=;
        b=h7NbkBfUgk8ILcp8iiVBXoxXQSJ4qgWCaoKRZaGWHJ6OZbTyRF9Z7YKuYDLvSEm2Sp
         2Lo7G7DhMiX/ImQkd25u3aBE3QylBwQuZh+eZ/gkSwvbH9bRaRfxkMkm2q4LOYCdnvgp
         eUtAvpEMRZ5ImJMqsxV1rfQHphPQXlWbaSWbX7893UCrwvb6Tho9qwhdIKbZ+TeXL6ly
         sl2fe9gOxQy4Zk66dNuXziHsp7lmzmRZaV3QvFIpPJTkHLHp1kolAcAaOV2u3FrYVPmg
         iWypA4VuuMhSTYuUJDVAfUKDhWv8OzIrWdkxSzO7p2bQMAYo8cQd7cszYC+cXH0uW1FP
         IHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GARCkxgiyMRjl3V6/FiJ6/g+bqmKHGIILslZSNmkwfA=;
        b=EDJq7R8nDr8+RK2N7dGGfdpAPEadMq4v6cX8W06MWMwUgYA2IlDCWA0zyub1YmjaBm
         35Cn0wrUAGL4CVNegIpBlZL7K5FHD477HElC2zAUTyh6/4B9WrlocZ1AXgvTTAcoDaun
         syIWQs4HD+TeJJras2rCG/YTHZgbK6KtO1IvtVXndestgolxNCvW5l7j7uYaAC64CtLC
         9Izorh5CDNBVDtKNQkPVr6L5pBMU9s8M7dW/B0ZqjZiDAq6ZnA2d7a2nADDnV876l1zH
         VzHD+/LG7ftyE/mtTJ/YLdwtE61oYBJ/qMTH4pH50yW76NIB+2s/6DCiSR8hOaO8jEgz
         655A==
X-Gm-Message-State: AOAM532L/eYZhSEYMXUMQo+HujaTDXeyyIyGFeGnqqWi9vDhxJx5qCct
        ++E08IjstVfOR78uF9yH0ANV9wlqkX0aDWu0
X-Google-Smtp-Source: ABdhPJxMmfTn6xPsVJe+YMMj5AMkzA8nSoqcC/rAmnpkZ/Ihx99BL/dv7OHz/b28GorrGVbORfzVBA==
X-Received: by 2002:a2e:a305:0:b0:246:4233:3848 with SMTP id l5-20020a2ea305000000b0024642333848mr23150069lje.3.1646320376611;
        Thu, 03 Mar 2022 07:12:56 -0800 (PST)
Received: from localhost.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id a10-20020a056512374a00b004438dd764d1sm476022lfs.306.2022.03.03.07.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 07:12:56 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        jeff@labundy.com, markuss.broks@gmail.com,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski@canonical.com, rydberg@bitmath.com,
        sfr@canb.auug.org.au, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v8 1/2] dt-bindings: input/touchscreen: bindings for Imagis
Date:   Thu,  3 Mar 2022 17:12:26 +0200
Message-Id: <20220303151227.25659-2-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220303151227.25659-1-markuss.broks@gmail.com>
References: <20220303151227.25659-1-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds device-tree bindings for the Imagis
IST3038C touch screen IC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 .../input/touchscreen/imagis,ist3038c.yaml    | 74 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
new file mode 100644
index 000000000000..e3a2b871e50c
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/imagis,ist3038c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Imagis IST30XXC family touchscreen controller bindings
+
+maintainers:
+  - Markuss Broks <markuss.broks@gmail.com>
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+properties:
+  $nodename:
+    pattern: "^touchscreen@[0-9a-f]+$"
+
+  compatible:
+    enum:
+      - imagis,ist3038c
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply:
+    description: Power supply regulator for the chip
+
+  vddio-supply:
+    description: Power supply regulator for the I2C bus
+
+  touchscreen-size-x: true
+  touchscreen-size-y: true
+  touchscreen-fuzz-x: true
+  touchscreen-fuzz-y: true
+  touchscreen-inverted-x: true
+  touchscreen-inverted-y: true
+  touchscreen-swapped-x-y: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - touchscreen-size-x
+  - touchscreen-size-y
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      touchscreen@50 {
+        compatible = "imagis,ist3038c";
+        reg = <0x50>;
+        interrupt-parent = <&gpio>;
+        interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
+        vdd-supply = <&ldo1_reg>;
+        vddio-supply = <&ldo2_reg>;
+        touchscreen-size-x = <720>;
+        touchscreen-size-y = <1280>;
+        touchscreen-fuzz-x = <10>;
+        touchscreen-fuzz-y = <10>;
+        touchscreen-inverted-x;
+        touchscreen-inverted-y;
+      };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 781a5795d8ff..3dca47d6f1d3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -560,6 +560,8 @@ patternProperties:
     description: Ingenieurburo Fur Ic-Technologie (I/F/I)
   "^ilitek,.*":
     description: ILI Technology Corporation (ILITEK)
+  "^imagis,.*":
+    description: Imagis Technologies Co., Ltd.
   "^img,.*":
     description: Imagination Technologies Ltd.
   "^imi,.*":
-- 
2.20.1


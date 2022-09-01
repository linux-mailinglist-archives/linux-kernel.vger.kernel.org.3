Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC7C5A8F8B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbiIAHPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbiIAHOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:14:51 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F778125EAD
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 00:14:43 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id x10so16915594ljq.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 00:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=km6NXmC+Flc6gi2HFcUWUmGr8CF+d6lMjhuuuaPJIfU=;
        b=fDN9jO8cTU7aN1SfkFkwyyPttQDO5E+4SyCP3K2eQ1GgBT1DpRR0syK5hKNVB2/BK+
         nvA+iaAmpn5yUBsFbTCyOgOjsi1CVRHo0QPMfJdKgC6dJIlK7Xa6McnIQcPl4N54a5eF
         YUw2/iMb0sZ6QcLLhXL7bjR7Sj3WWlgyNosoc+L0+9po6MSV88ntL8eLUHe9Y9KPZCLh
         yfbLCNGnSZKsJiFFMuCacZRz+yKkxAXeWt31v6H8CKhsyy7ZVqqmGeUjudQsIxbKq0ch
         u5q83gwlXotABbaP9tW2zYlbcSQbZsYVmvBZuZREWHxmOAf9ry/XRD1PhW79nhy1h2i1
         Wx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=km6NXmC+Flc6gi2HFcUWUmGr8CF+d6lMjhuuuaPJIfU=;
        b=S+26wNuRI1RpBkCFCJCKYAqTKTznND8chIW+BbJREViouVKprvaeKkaVI2el9CYSus
         xsiOjPp89YrsF7LqJTDp5kgtz3JcH01Tg27b8pq3sj/c8C26CXzLjw83Q0JUXg3ptskO
         z/uO6aWR5BOmXv9RIM0dMv/eRH0tI6GJJK5mdQ5Io8qoOWJ/BzYPJpnrpPUjTg/7k/eJ
         FZa2M/lZwzV8kIe0IhWRmZPYmdeGRbkEq5S9xwp3VqdMQ/oyI+m/S2pQCjCLgu0zZHIk
         L95MK1oh6PnOD8BBdDFRaqOubYFWWwsAhPH6hjlVuWn0jFkjlhQSauxKNcpM8HeOroGR
         HP/Q==
X-Gm-Message-State: ACgBeo0OW+gqSUxOJBcBEEmEEDZ00VddSnVlpPwArbkC9IFg9gIwtxEX
        nFTBfMAUah0IsLJgc+LNjW11mw==
X-Google-Smtp-Source: AA6agR7nfUvJaMyZAykfOJ1hwec2TsfAl7ZRolDYILrbpPNf7QefeokqkbM+QKYcZ2eZmBCiUwjwzQ==
X-Received: by 2002:a2e:9e11:0:b0:268:c7d0:9662 with SMTP id e17-20020a2e9e11000000b00268c7d09662mr137209ljk.309.1662016481664;
        Thu, 01 Sep 2022 00:14:41 -0700 (PDT)
Received: from krzk-bin.. (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id 11-20020ac2482b000000b00492e2918a5asm1229403lft.269.2022.09.01.00.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 00:14:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] media: dt-bindings: dongwoon,dw9714: convert to dtschema
Date:   Thu,  1 Sep 2022 10:14:37 +0300
Message-Id: <20220901071437.17637-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Convert Dongwoon Anatech DW9714 camera voice coil lens driver to DT
schema and extend the bindings with vcc-supply (already used by driver)
and powerdown-gpios (based on datasheet, not used by the driver).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Update path in Maintainers
---
 .../bindings/media/i2c/dongwoon,dw9714.txt    |  9 ----
 .../bindings/media/i2c/dongwoon,dw9714.yaml   | 47 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 48 insertions(+), 10 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/i2c/dongwoon,dw9714.txt
 create mode 100644 Documentation/devicetree/bindings/media/i2c/dongwoon,dw9714.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/dongwoon,dw9714.txt b/Documentation/devicetree/bindings/media/i2c/dongwoon,dw9714.txt
deleted file mode 100644
index b88dcdd41def..000000000000
--- a/Documentation/devicetree/bindings/media/i2c/dongwoon,dw9714.txt
+++ /dev/null
@@ -1,9 +0,0 @@
-Dongwoon Anatech DW9714 camera voice coil lens driver
-
-DW9174 is a 10-bit DAC with current sink capability. It is intended
-for driving voice coil lenses in camera modules.
-
-Mandatory properties:
-
-- compatible: "dongwoon,dw9714"
-- reg: I²C slave address
diff --git a/Documentation/devicetree/bindings/media/i2c/dongwoon,dw9714.yaml b/Documentation/devicetree/bindings/media/i2c/dongwoon,dw9714.yaml
new file mode 100644
index 000000000000..66229a3dc05d
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/dongwoon,dw9714.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/dongwoon,dw9714.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Dongwoon Anatech DW9714 camera voice coil lens driver
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+description:
+  DW9174 is a 10-bit DAC with current sink capability. It is intended for
+  driving voice coil lenses in camera modules.
+
+properties:
+  compatible:
+    const: dongwoon,dw9714
+
+  reg:
+    maxItems: 1
+
+  powerdown-gpios:
+    description:
+      XSD pin for shutdown (active low)
+
+  vcc-supply:
+    description: VDD power supply
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        camera-lens@c {
+            compatible = "dongwoon,dw9714";
+            reg = <0x0c>;
+            vcc-supply = <&reg_csi_1v8>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index ebc140e71b49..8573e3810688 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6233,7 +6233,7 @@ M:	Sakari Ailus <sakari.ailus@linux.intel.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
-F:	Documentation/devicetree/bindings/media/i2c/dongwoon,dw9714.txt
+F:	Documentation/devicetree/bindings/media/i2c/dongwoon,dw9714.yaml
 F:	drivers/media/i2c/dw9714.c
 
 DONGWOON DW9768 LENS VOICE COIL DRIVER
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0BE4EE915
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 09:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343872AbiDAH3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 03:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343862AbiDAH3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 03:29:12 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EFF25AED1
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 00:27:23 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id r13so4004677ejd.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 00:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O+A1T3BDaFyKGF1/nLA+83q2cwMWkojLwLtnjt6Im0g=;
        b=j+eVewyktWt9RZpMGZVqLlXxN6rOBQc59O6iqd9c+QDB3iZ6LVLc9U7ye4CPrjiOKE
         y5grcvba/Fl1jmVsDg7QiQTET1Qm9Eq3B5C6l4os5HQyM6nx7B5mEIOLhCbsJZgUGT2e
         Ef4JUPXjrBqmwwHVmTBe8y5ZukQnZL7ppjH/DMwD11Gn3I1WNX8gVSursmKKIBGOXnJL
         Pk6dGcSC2/ehn3wvD7U2zI1D87O4tmdo64+fp7crso7ce697kNCS+0RIf4iB8UfYI0DB
         IM3Fb+EbP+KjN71iEFNeP1UtTG5pSa+ysnTL+IHIRFL8vU0XszrfjEBwRwzj6keQVw1f
         hI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O+A1T3BDaFyKGF1/nLA+83q2cwMWkojLwLtnjt6Im0g=;
        b=fGdJy9435inIphKJ2n5NeA0Rv5BFD6GWKy5IH/xksqRYVEP8aK+IHeoIHXjJe3FnH8
         7eyT/RV1F1hkv7AP0cUC3d5OEOLKCeKp7Srz+JGVtsn5fffvDJYG+HESndsQiGEoxhM/
         h7Ln7IHa1e3l7d7HEUz0+aSUn2z0U/1GFGw0/GDomv5rmrRq6ytJFwVp73Q17DWY3LM7
         98wqjUttVaLANZpynvR7i2H4goTcv1TH7sJMF+EleOLZigwIeJjC6bn6E+s1L68ZMyBS
         +3RQUmZJZpFIqE3Civ6EwgLr2UNTKBTjRV61lvCVmm96fN2N5TkjgUqWeJNR1i8AsAwx
         1YzA==
X-Gm-Message-State: AOAM531j7bvDtaBG4PTkhePl9mAxm08RPXXBMk7Iu+QFo1hikz0d6W8J
        v6uk9JpUn75EShEaeEHLCX45mA==
X-Google-Smtp-Source: ABdhPJzp8YxEfUN85bEPan9Rtud03kSOf0voG7Rc8WffBmwyRVz87PjBiiRTp9YcR+PZgRpvKWcWiA==
X-Received: by 2002:a17:907:7f94:b0:6da:64ec:fabc with SMTP id qk20-20020a1709077f9400b006da64ecfabcmr8199091ejc.717.1648798041987;
        Fri, 01 Apr 2022 00:27:21 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id r1-20020a170906550100b006e116636338sm713485ejp.2.2022.04.01.00.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 00:27:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3] dt-bindings: gpio: add common consumer GPIO lines
Date:   Fri,  1 Apr 2022 09:27:14 +0200
Message-Id: <20220401072714.106403-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
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

Typical GPIO lines like enable, powerdown, reset or wakeup are not
documented as common, which leads to new variations of these (e.g.
pwdn-gpios).  Add a common schema which serves also as a documentation
for preferred naming.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v2:
1. Correct email.

Changes since v1:
1. Select-true, add maxItems and description for each entry (Rob).
2. Mention ACTIVE_LOW in bindings description (Linus).
3. Add allOf for pwrseq reset-gpios case.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/gpio/gpio-consumer-common.yaml   | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-consumer-common.yaml

diff --git a/Documentation/devicetree/bindings/gpio/gpio-consumer-common.yaml b/Documentation/devicetree/bindings/gpio/gpio-consumer-common.yaml
new file mode 100644
index 000000000000..40d0be31e200
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-consumer-common.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/gpio-consumer-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common GPIO lines
+
+maintainers:
+  - Bartosz Golaszewski <brgl@bgdev.pl>
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description:
+  Pay attention to using proper GPIO flag (e.g. GPIO_ACTIVE_LOW) for the GPIOs
+  using inverted signal (e.g. RESETN).
+
+select: true
+
+properties:
+  enable-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the enable control pin.
+
+  reset-gpios:
+    description:
+      GPIO (or GPIOs for power sequence) connected to the device reset pin
+      (e.g. RESET or RESETN).
+
+  powerdown-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the power down pin (hardware power down or power cut,
+      e.g. PD or PWDN).
+
+  pwdn-gpios:
+    maxItems: 1
+    description: Use powerdown-gpios
+    deprecated: true
+
+  wakeup-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the pin waking up the device from suspend or other
+      power-saving modes.
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mmc-pwrseq-simple
+    then:
+      properties:
+        reset-gpios:
+          minItems: 1
+          maxItems: 32
+    else:
+      properties:
+        reset-gpios:
+          maxItems: 1
+
+additionalProperties: true
-- 
2.32.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3DE4EE910
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 09:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343850AbiDAH1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 03:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbiDAH1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 03:27:15 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77053146B6D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 00:25:26 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id yy13so4032614ejb.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 00:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/t2zgm28640sLeV6kA0AwpNLVqoTUM4cVza522LYquQ=;
        b=dMDRJ2l9pkFtp0SYw60Bh+Xjhy28mryKubnrk6NWUw6OJYxC5+on6k7UdUEc2nVLil
         /5VpVL9ALHFdo+s/wZ9+6TCxQ9Ie2ecXOVpvNDm+BU2PpcxFg9iI7Z/SUhVRtJJGZreV
         WHRM8n0H0VkIreJugtHyyCAA0FpbnqTbb03PafEoFuTPZ81T+8PFCJv/807W6zcp62w6
         8Fa+IQgqqsgOUgq6TflIBRLo3PkQfxRuvRI+n/COZE4vn0pg/QlCWZASDGvR2asUXvPK
         KALDgIOUQXe4wZLtWqpu0pc2z9Dm/4G+4hZmgzpnFEBzzte+qjE/EsYEeohHfz1ce55Z
         QAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/t2zgm28640sLeV6kA0AwpNLVqoTUM4cVza522LYquQ=;
        b=i5I1E6Xrqkohe9Q1vc9m1thAAQIQXGSaeTOppUnpbCchwIqa3ALmrmFWGWqOXFk+ci
         AKTj0LWetZHRVVMfHiGqXwldNK+3PgO9N7S4AmLqnK0bg9k3ErIJA8K+PnHX09zQmnPw
         avvaRFN8jIet/K/VI24VIOs/8iHr4JeFTY9sKUCOl4gzNVNLyq1EFCvRy1KZ6L92as3a
         xXMVoqVZP37zsTju3O/KIGr+XdAZDryR9DQYKUSgR3y2BFY7Zve/KZzaxib9ngCPl4Em
         hIHVouRBNJVsXyppaCUeolEZ8cMW1nF6rX75c6wdjDuSAS9vRSq6OWw6jWezi4sv6wYZ
         T4jA==
X-Gm-Message-State: AOAM531zr8IPYkaEc3vDceH+/nXuKUA4DTYDJcxFHDlSl6E3Bbp1/68/
        W0cOnldfwnv/3wmHsJSfFm9OSjxW6ZcKwB8v
X-Google-Smtp-Source: ABdhPJzUqE+gc30V5iETlir8J69/5Ngy1eFYcPXPb6KnaFx2lTXcGW/LwPqrFpOk3Ak/bQElXYZuSQ==
X-Received: by 2002:a17:907:1c0a:b0:6da:7ac4:5349 with SMTP id nc10-20020a1709071c0a00b006da7ac45349mr8083394ejc.596.1648797924939;
        Fri, 01 Apr 2022 00:25:24 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id u25-20020a170906b11900b006e08588afedsm693737ejy.132.2022.04.01.00.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 00:25:24 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v2] dt-bindings: gpio: add common consumer GPIO lines
Date:   Fri,  1 Apr 2022 09:25:16 +0200
Message-Id: <20220401072516.105903-1-krzysztof.kozlowski@linaro.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Typical GPIO lines like enable, powerdown, reset or wakeup are not
documented as common, which leads to new variations of these (e.g.
pwdn-gpios).  Add a common schema which serves also as a documentation
for preferred naming.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v1:
1. Select-true, add maxItems and description for each entry (Rob).
2. Mention ACTIVE_LOW in bindings description (Linus).
3. Add allOf for pwrseq reset-gpios case.
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


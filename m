Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CDD560030
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 14:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbiF2MiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 08:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbiF2MiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 08:38:11 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CF265BE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 05:38:09 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ay16so32320523ejb.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 05:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xffDvQ4wmTlhbTHoSRY6CPrwO+KGNYtOQPheNUgMMls=;
        b=isvoegge0G/3rLqgNYq1TraRhOBmwJk6sByRDFuEpY3HRuVM+EZXfxD73xlA9WGoqi
         chksnKBcz6dUkwYYYo9jKQfmpBc+LrfCkDHgh/OnfXaONUcCUiqkvIlJMF/NjEX9+Cr2
         Om36D7fL02bnlJjkvD1aKdXkqD2qeUxh2ggulHNxbLAppuPvidWe5OH1FbRRkcWi2Pom
         a+bSXNF40aKMLqLjpg0oI+e2uRwi6HVkO4mx1MCJo3viI1YoglAKCYSovbHd382x0GRl
         kHc2hyQtGGxENG1Kat8Hwsjw6ONb1rlLVIuB2mAP2SGwMs9+uBC9/W/68SMRCx4UWqQD
         i5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xffDvQ4wmTlhbTHoSRY6CPrwO+KGNYtOQPheNUgMMls=;
        b=d1vnOV9ydOJN6VwNGzNwXbRYPdJ4ToUsh1oxVXciq6P546cy8BALp4JchWzv5nGtiN
         evXTOFU9upy6Mc97xTM7VskUQ73D7OVWIcWhndPbXWGcpK02XCOOSkyVxdnx1El9WNs9
         HYMG+Jx7mNs+SuFyrKrPvkprialwmJ2Qv3N1n4dHZgAq/mx6b7KUSpQ/0MTv8jR/5oFq
         V7hQpWPNXPJC8X2KbkRZTVLK9gPgUZXwLpPqqjX9roUDfkPDJK0IuXU1kXxJZOQ1/oR/
         vMFXYPUKwOz/Ez4SYeqbPihSv/KHpJpGJRPjYGcnkr0EdtQDwrYiGbf3BUaqWJmjBuU8
         3Ixw==
X-Gm-Message-State: AJIora849p6WYuiUYX5vW3WhawAXSdBwGlh70+Bx/Be4aFh9nGjkBq0O
        vllauGMt7RLBbdwe7OOakcrxcQ==
X-Google-Smtp-Source: AGRyM1sbRmV7Ln3hOp7mKI5FGQ9uRHEZcWKjAdhQcMce0mwwiALmlGAElCFO91SZr84Kzu+ijhvbhA==
X-Received: by 2002:a17:907:3e08:b0:726:2af1:1d5f with SMTP id hp8-20020a1709073e0800b007262af11d5fmr3174507ejc.235.1656506288542;
        Wed, 29 Jun 2022 05:38:08 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id v5-20020a170906338500b006fed85c1a8fsm7729657eja.202.2022.06.29.05.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 05:38:07 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: power: reset: qcom,pshold: convert to dtschema
Date:   Wed, 29 Jun 2022 14:38:04 +0200
Message-Id: <20220629123804.94906-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Qualcomm Power Supply Hold Reset bindings to DT schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/power/reset/msm-poweroff.txt     | 17 ---------
 .../bindings/power/reset/qcom,pshold.yaml     | 35 +++++++++++++++++++
 2 files changed, 35 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/reset/msm-poweroff.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/qcom,pshold.yaml

diff --git a/Documentation/devicetree/bindings/power/reset/msm-poweroff.txt b/Documentation/devicetree/bindings/power/reset/msm-poweroff.txt
deleted file mode 100644
index ce44ad357565..000000000000
--- a/Documentation/devicetree/bindings/power/reset/msm-poweroff.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-MSM Restart Driver
-
-A power supply hold (ps-hold) bit is set to power the msm chipsets.
-Clearing that bit allows us to restart/poweroff. The difference
-between poweroff and restart is determined by unique power manager IC
-settings.
-
-Required Properties:
--compatible: "qcom,pshold"
--reg: Specifies the physical address of the ps-hold register
-
-Example:
-
-	restart@fc4ab000 {
-		compatible = "qcom,pshold";
-		reg = <0xfc4ab000 0x4>;
-	};
diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pshold.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pshold.yaml
new file mode 100644
index 000000000000..527962d54a8f
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/qcom,pshold.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/qcom,pshold.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SoC restart and power off
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description:
+  A power supply hold (ps-hold) bit is set to power the Qualcomm chipsets.
+  Clearing that bit allows us to restart/power off. The difference between
+  power off and restart is determined by unique power manager IC settings.
+
+properties:
+  compatible:
+    const: qcom,pshold
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    reset-controller@fc4ab000 {
+        compatible = "qcom,pshold";
+        reg = <0xfc4ab000 0x4>;
+    };
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E644B099A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 10:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238769AbiBJJei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 04:34:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbiBJJeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 04:34:36 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF0610BE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 01:34:36 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id q7so8332456wrc.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 01:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uP4Uhmk6vf2xAms7r10tSMA4oqT1ek32FC/AUougGL0=;
        b=W/UdOp+KHYfoCGq5kyfNbeGihSdUCcanlaMSjidwzWLNzJ5O6cFux6UYv15uPgsKV9
         Q2vh+2e8fi3Et5DhYtOJvR6fjKig3adKGKIbbfQBjz2vhfto3+DLma/Of/trwk2nvjT/
         FDk2N28echunb9G02DJCM/cedvdpR9XuYF6m02IArUoOUaAg+at+jtQxr7RpkMOytL8D
         8OJlXvoEaXJEgwu1SEQEW/xgEa2I5qlk7yNTyhzeyZlHIeD+2183hGnloncRONEjq+64
         LGXMSPwN0+nFLlOw4TshmtY+Soa+5EjDZizvdrz2ds0hCVia/FVhv9P1WYtKcT6G+rcB
         zpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uP4Uhmk6vf2xAms7r10tSMA4oqT1ek32FC/AUougGL0=;
        b=OiyKkrERzB19vQJ4SADguB+PyPyFZfmqaMpF20NE6mytXJmhD8L/QpdM62BIoirA/U
         1+WaGFthJgLmtKQhEq8gLMQJ6WjEHo2zora1mkbyfw9jQ9JJV6z29jaVsQTC3t3pEN8E
         oyMLYm+7wJKZ6+4MNftgUBs6b0m+poe+m58wyZQSWao7PUdypGWikK1yQZuQAt58YL3o
         /4Nfzie8f95PJHB/lhDSqGtKHbaoC9dPrxtbBZqEBa1k161Z5BG2eK8uX64SjtrTUCYL
         jYv6bw2Y4fvdpA9iEzRO77wK06gt8gS9nMdsBvdvLub12G31QQpjJQdsH5ESQxQVBCdg
         TH+A==
X-Gm-Message-State: AOAM5318I/TScBMnjFoCRxjzZlNAdW5I6FLvA6JaGRGvWUAt8I/VCpR/
        uGRlLiFXOdS1B5vg0XfcGCGpxw==
X-Google-Smtp-Source: ABdhPJwOGqM6+TjFx/Q1NCGhs1yihK636P8Cyp2S1UH3Zdgv/l1e1PR0Y5iMcTh6rIsWe3+M2eU3cA==
X-Received: by 2002:a5d:6da2:: with SMTP id u2mr5399791wrs.294.1644485674810;
        Thu, 10 Feb 2022 01:34:34 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id 1sm20531111wry.52.2022.02.10.01.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 01:34:34 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     krzysztof.kozlowski@canonical.com, linux@roeck-us.net,
        robh+dt@kernel.org, wim@linux-watchdog.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2] dt-bindings: watchdog: convert faraday,ftwdt010 to yaml
Date:   Thu, 10 Feb 2022 09:34:27 +0000
Message-Id: <20220210093427.2813601-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert watchdog/faraday,ftwdt010.txt to yaml.
This permits to detect missing properties like clocks and resets or
compatible like moxa,moxart-watchdog.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
Changes since v1:
- Added myself as maintainer as requested by Linus
- Added $ref to watchdog.yaml
- Removed useless quotes
- Added blank lines between properties
- Removed timeout-sec as already provided by watchdog.yaml

 .../bindings/watchdog/faraday,ftwdt010.txt    | 22 ------
 .../bindings/watchdog/faraday,ftwdt010.yaml   | 67 +++++++++++++++++++
 2 files changed, 67 insertions(+), 22 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.txt b/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.txt
deleted file mode 100644
index 9ecdb502e605..000000000000
--- a/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-Faraday Technology FTWDT010 watchdog
-
-This is an IP part from Faraday Technology found in the Gemini
-SoCs and others.
-
-Required properties:
-- compatible : must be one of
-  "faraday,ftwdt010"
-  "cortina,gemini-watchdog", "faraday,ftwdt010"
-- reg : shall contain base register location and length
-- interrupts : shall contain the interrupt for the watchdog
-
-Optional properties:
-- timeout-sec : the default watchdog timeout in seconds.
-
-Example:
-
-watchdog@41000000 {
-	compatible = "faraday,ftwdt010";
-	reg = <0x41000000 0x1000>;
-	interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
-};
diff --git a/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.yaml b/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.yaml
new file mode 100644
index 000000000000..64e9c414cc60
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/faraday,ftwdt010.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Faraday Technology FTWDT010 watchdog
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+  - Corentin Labbe <clabbe@baylibre.com>
+
+description: |
+  This is an IP part from Faraday Technology found in the Gemini
+  SoCs and others.
+
+allOf:
+  - $ref: "watchdog.yaml#"
+
+properties:
+  compatible:
+    oneOf:
+      - const: faraday,ftwdt010
+      - items:
+          - const: cortina,gemini-watchdog
+          - const: faraday,ftwdt010
+      - items:
+          - const: moxa,moxart-watchdog
+          - const: faraday,ftwdt010
+
+  reg:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: PCLK
+
+  interrupts:
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
+    #include <dt-bindings/interrupt-controller/irq.h>
+    watchdog@41000000 {
+      compatible = "faraday,ftwdt010";
+      reg = <0x41000000 0x1000>;
+      interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
+    };
+  - |
+    watchdog: watchdog@98500000 {
+      compatible = "moxa,moxart-watchdog", "faraday,ftwdt010";
+      reg = <0x98500000 0x10>;
+      clocks = <&clk_apb>;
+      clock-names = "PCLK";
+    };
+...
-- 
2.34.1


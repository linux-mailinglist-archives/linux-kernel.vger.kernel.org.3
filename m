Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9448B4B24EE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345913AbiBKLzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:55:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbiBKLzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:55:42 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA50EEAE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 03:55:40 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id o24so12159417wro.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 03:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FFTn8zwjTX2hFzTgJT6QAjUmkuMKVR409IkO5bq/6Ns=;
        b=RUkCmM49DAHtqyXh3m1sKwckw6Y6y9JmMteiPJ6JQbjWqNHPEBamE2o3viBwED7twG
         oIK8QLR5pGVyK+5yqzzMZgBS0dG6CyUIEA+lxD2Ev2ol3VTtINq54YfZLHGKdF39t7Bg
         h/21GMI6cxKFu61g42kLzomBwLky19G0jO1nR32qbtOH4exjR3FY797knQmp+2mNtXkD
         ZrQKSIW8JMSV4fNytzMYj4m2vH/7/yWbcXQuBSSIf+71kHNqVOHjRwLjq+SSjpZxuP/3
         ANfn87g3lpDVUZxSk4/VcT5cqZqMH9PBbRIgWWwCqX1dW2cq/jq66dAGxcXO2o8LqbQ0
         fX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FFTn8zwjTX2hFzTgJT6QAjUmkuMKVR409IkO5bq/6Ns=;
        b=Cu8TKaSa+fAFO0tCpj9r//bQD0GEbKp2EmPWpulL24rDJpetl4pE4AzJB0vqDi4pz1
         GIQ9XMM6hiV46AWTg4oNoSKugATnaO5hPVE54CQzqu5E5RFWz1g/gDy3uNWyHxtYcTiH
         6wyULdEQb9FYRDefAKv3PvltXbjswaHl8q3im9006kMT15LVXc/c4JgCin6UBuGV+Bzq
         DsNY5fwyURyDt4l/B3SgkL9muohPW9xIbadXayW8J7tpvdMXy0JbC826yKD1erAqSMsZ
         +ufWO76t5xGBpe2/b8mn8tXvrKtJIRwLO2Lr2IXBVC5UIO7d6nm6LOgYPilOry28ok44
         BoGw==
X-Gm-Message-State: AOAM533cvduT7vMe02ZVpW4W/NTlFeE91xCYyJMZ8EDqBh4Lr5cVd+DP
        z0KMsVbYjrPvOcT+k1T8WSGWuOTY8S0QGg==
X-Google-Smtp-Source: ABdhPJwt7XPCUknMlwxpa45RJ3Vt8/4BhE5nZWfzZzlmQGaNHfBBEXQ3be5TsTPXfbcgYuQDQ/D8aw==
X-Received: by 2002:a05:6000:128d:: with SMTP id f13mr1062625wrx.675.1644580539259;
        Fri, 11 Feb 2022 03:55:39 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id bg23sm4899482wmb.5.2022.02.11.03.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 03:55:38 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     krzysztof.kozlowski@canonical.com, linux@roeck-us.net,
        robh+dt@kernel.org, wim@linux-watchdog.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v4] dt-bindings: watchdog: convert faraday,ftwdt010 to yaml
Date:   Fri, 11 Feb 2022 11:55:28 +0000
Message-Id: <20220211115528.3382374-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converts watchdog/faraday,ftwdt010.txt to yaml.
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
- Removed timeout-secs as already provided by watchdog.yaml

Change since v2:
- rewrite compatible section

Changes since v3:
- Fix indent errors reported by yamllint
- Change additionalProperties to unevaluatedProperties
- Added timeout-secs in example

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
index 000000000000..ca9e1beff76b
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
+          - enum:
+              - cortina,gemini-watchdog
+              - moxa,moxart-watchdog
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
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    watchdog@41000000 {
+      compatible = "faraday,ftwdt010";
+      reg = <0x41000000 0x1000>;
+      interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
+      timeout-secs = <5>;
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


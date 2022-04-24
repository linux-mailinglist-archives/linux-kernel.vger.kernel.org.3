Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27CA50D09A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 10:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbiDXIyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 04:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238767AbiDXIxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 04:53:46 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAFA1EAF4;
        Sun, 24 Apr 2022 01:50:46 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id r13so24163567ejd.5;
        Sun, 24 Apr 2022 01:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SaSVAGu2XwyZao07Jymtbz3ykD0KKs6DAdj6tUH3Obk=;
        b=RjB5zd+KGvmtQtc+Xo1nuEZ0TX1aASqC0Ic8+GKMksqXdoF05w8NKSukK9SvU0bDHM
         HXBwIv8iOKcJrAiDJET8kX5a1Fqw86SsDwF2cMhj6u3pfVGWbbBOHe6YxtBtVov0nal2
         ZuqTegYZwQPG7fzG1OP9oaM9RKhzR5xu7DY+TMtgkLGClKa1grpucmDBVRDWVw+k1+Qg
         b4aUVB15cZTvGptA1h8GwOJ6jlWWG/+ISKNI6hpUPVPiEzC0RN4G9iNvOJP+FFteSEMQ
         N3de/O6n/9pUrwqNjnI6hDTnsfkBfcDu6Yzh1hrxlPEcVMW8qyCJDFGuop2lfkFGtlz5
         NZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SaSVAGu2XwyZao07Jymtbz3ykD0KKs6DAdj6tUH3Obk=;
        b=hs3pU/SVFtgViUxmhD6y4ehMH7SAWJnymvQVkXjHi0+wqGPF1rvB9dtnWvSv/zNYiJ
         29DbCzhDaGlG2+z8j3yLkpxJ5pf84FUef70+QySySBcACSOV4ayNcn4L3ZdMquu51h80
         hUKlRfFudpcKn9KqLTrX8gLjWhEy5Pdp5GJb5l3Xs950MGEbPY5OWc8LKsKvN5vhGDST
         VLqXFZE4vglAxHY+kbkAkE35Ml++fm8/3FPW8J1+7DEF1/hWeZtjUB9/vFeJxjbU3YWD
         TwYjzruDvK12u9Jqgm2dnQ54ZzRc8I4Y/8ron6YhnuO6p65IIn+y6Wu1FIYDHZzs+GV6
         dqiQ==
X-Gm-Message-State: AOAM531+0Dy1ngyfvyFMMNoVrvzYCguWRdfd5OOmxJ0nZvHq730D6NIF
        XEqv3Ffovm4InFow169lJLM=
X-Google-Smtp-Source: ABdhPJzzvMcUnsjX5m8kOC3MoubcHlQ48XHwvDcY9nmYjBRcmKIN1r5JLTL2A/SCNRd7aPswcvoc8w==
X-Received: by 2002:a17:906:dc8b:b0:6ef:86e8:777 with SMTP id cs11-20020a170906dc8b00b006ef86e80777mr11822490ejc.326.1650790244772;
        Sun, 24 Apr 2022 01:50:44 -0700 (PDT)
Received: from localhost.localdomain ([138.199.7.245])
        by smtp.gmail.com with ESMTPSA id gy10-20020a170906f24a00b006e894144707sm2435971ejb.53.2022.04.24.01.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 01:50:44 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Sam Shih <sam.shih@mediatek.com>, Ryder Lee <ryder.lee@kernel.org>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>
Subject: [PATCH v2 3/3] dt-bindings: arm: mediatek: infracfg: Convert to DT schema
Date:   Sun, 24 Apr 2022 12:46:47 +0400
Message-Id: <20220424084647.76577-4-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220424084647.76577-1-y.oudjana@protonmail.com>
References: <20220424084647.76577-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

Convert infracfg bindings to DT schema format. Not all drivers
currently implement resets, so #reset-cells is made a required
property only for those that do. Using power-controller in the
example node name makes #power-domain-cells required causing
a dt_binding_check error. To solve this, the node is renamed to
syscon@10001000.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../arm/mediatek/mediatek,infracfg.txt        | 42 ----------
 .../arm/mediatek/mediatek,infracfg.yaml       | 81 +++++++++++++++++++
 2 files changed, 81 insertions(+), 42 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
deleted file mode 100644
index f66bd720571d..000000000000
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
+++ /dev/null
@@ -1,42 +0,0 @@
-Mediatek infracfg controller
-============================
-
-The Mediatek infracfg controller provides various clocks and reset
-outputs to the system.
-
-Required Properties:
-
-- compatible: Should be one of:
-	- "mediatek,mt2701-infracfg", "syscon"
-	- "mediatek,mt2712-infracfg", "syscon"
-	- "mediatek,mt6765-infracfg", "syscon"
-	- "mediatek,mt6779-infracfg_ao", "syscon"
-	- "mediatek,mt6797-infracfg", "syscon"
-	- "mediatek,mt7622-infracfg", "syscon"
-	- "mediatek,mt7623-infracfg", "mediatek,mt2701-infracfg", "syscon"
-	- "mediatek,mt7629-infracfg", "syscon"
-	- "mediatek,mt7986-infracfg", "syscon"
-	- "mediatek,mt8135-infracfg", "syscon"
-	- "mediatek,mt8167-infracfg", "syscon"
-	- "mediatek,mt8173-infracfg", "syscon"
-	- "mediatek,mt8183-infracfg", "syscon"
-	- "mediatek,mt8516-infracfg", "syscon"
-- #clock-cells: Must be 1
-- #reset-cells: Must be 1
-
-The infracfg controller uses the common clk binding from
-Documentation/devicetree/bindings/clock/clock-bindings.txt
-The available clocks are defined in dt-bindings/clock/mt*-clk.h.
-Also it uses the common reset controller binding from
-Documentation/devicetree/bindings/reset/reset.txt.
-The available reset outputs are defined in
-dt-bindings/reset/mt*-resets.h
-
-Example:
-
-infracfg: power-controller@10001000 {
-	compatible = "mediatek,mt8173-infracfg", "syscon";
-	reg = <0 0x10001000 0 0x1000>;
-	#clock-cells = <1>;
-	#reset-cells = <1>;
-};
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
new file mode 100644
index 000000000000..8681b785ed6d
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/arm/mediatek/mediatek,infracfg.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: MediaTek Infrastructure System Configuration Controller
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+
+description:
+  The Mediatek infracfg controller provides various clocks and reset outputs
+  to the system. The clock values can be found in <dt-bindings/clock/mt*-clk.h>,
+  and reset values in <dt-bindings/reset/mt*-reset.h> and
+  <dt-bindings/reset/mt*-resets.h>.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - mediatek,mt2701-infracfg
+              - mediatek,mt2712-infracfg
+              - mediatek,mt6765-infracfg
+              - mediatek,mt6779-infracfg_ao
+              - mediatek,mt6797-infracfg
+              - mediatek,mt7622-infracfg
+              - mediatek,mt7629-infracfg
+              - mediatek,mt7986-infracfg
+              - mediatek,mt8135-infracfg
+              - mediatek,mt8167-infracfg
+              - mediatek,mt8173-infracfg
+              - mediatek,mt8183-infracfg
+              - mediatek,mt8516-infracfg
+          - const: syscon
+      - items:
+          - const: mediatek,mt7623-infracfg
+          - const: mediatek,mt2701-infracfg
+          - const: syscon
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - mediatek,mt2701-infracfg
+          - mediatek,mt2712-infracfg
+          - mediatek,mt7622-infracfg
+          - mediatek,mt7986-infracfg
+          - mediatek,mt8135-infracfg
+          - mediatek,mt8173-infracfg
+          - mediatek,mt8183-infracfg
+then:
+  required:
+    - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    infracfg: clock-controller@10001000 {
+        compatible = "mediatek,mt8173-infracfg", "syscon";
+        reg = <0x10001000 0x1000>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+    };
-- 
2.36.0


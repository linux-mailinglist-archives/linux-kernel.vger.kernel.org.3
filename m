Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41595077B1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356452AbiDSSR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238262AbiDSSQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:16:38 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4DE3E5CC;
        Tue, 19 Apr 2022 11:12:42 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id k23so34593070ejd.3;
        Tue, 19 Apr 2022 11:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T8WZXYOCLzRkmpLF9jgUFJORJhr+qxoHhiRi9zpd0ak=;
        b=KKC135UwYK8aFfg6KnPB2uae0AGzdqsE2qCEZfPPQkakgr3W9ZpC0gS7cAyPJCSZgu
         iAfkP/W64GRzTOJAbKKbTWbUcfQg4azyTFIdj4PCl9eqHuIeCIdcXiT1u4Wu/CRNwqHC
         8rglGa0q4v0eHNhHItJ5efTBi2aCewf9I4HhHG1S12AMZg06omh4WmT7kuQKBy0CUgZn
         8lp3foWbTEMGMBert1cn+XCAaMlUAn4titeD1M6GCN6cdnq5ImqOJBuSCg6U/H1xxlTi
         n3G2TCkSTLgrz+JMDOJBbW7tz1GL8rLePx22kNZiiQdN4Ahov2irzEFvoSRbULcuDydX
         0s/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T8WZXYOCLzRkmpLF9jgUFJORJhr+qxoHhiRi9zpd0ak=;
        b=aWt3hRR98EvQqcepwuJqZ+iS+lAC4dc8U4YXyFveV2YFpDufwgiCbJdrjNQ/vqzQKJ
         KiA5OZZD6KTupV0aFL2qJgsMMbtMAdjPIuGJnzIU10jiYmEQfF0zsa19kXNnY9X69y0S
         k5KWsUm4j5wH1Rk9Ok7/OLBzx5v77Mx/g3oCMxoDCJNxp318ix5DKmwPAPPCCxAviI1n
         HWB5zY477/1Ktp66FYB/ze3SUjwcdPwHe63VbN8XcLkwRaRigIe6714P/YhGy63dfV3q
         gxm2e+bkIPwefHEtvcEMubv1cjRSJyA7d9At4rLvcRdY4lvraY6O5wIgd6swPiarccSk
         Dpdw==
X-Gm-Message-State: AOAM532MzROdH7eMWD2BKqyEb7hhFpGyb5vZYMos6M3QF18k3zcoTm3K
        JXv70yo5NdS7ySoTVGrsMqU=
X-Google-Smtp-Source: ABdhPJySoL89++QqvT+oP9zBi5KoJWlUpMj4I7Bj+2B8C2b9jxLYAeVHWiypffHVq3yANRc52Hhwgw==
X-Received: by 2002:a17:906:c1d6:b0:6d6:e0a3:bbc7 with SMTP id bw22-20020a170906c1d600b006d6e0a3bbc7mr14665249ejb.484.1650391961210;
        Tue, 19 Apr 2022 11:12:41 -0700 (PDT)
Received: from localhost.localdomain ([212.102.35.230])
        by smtp.gmail.com with ESMTPSA id b20-20020a1709063f9400b006e12836e07fsm5930614ejj.154.2022.04.19.11.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 11:12:40 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Sam Shih <sam.shih@mediatek.com>, Stephen Boyd <sboyd@kernel.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] dt-bindings: arm: mediatek: infracfg: Convert to DT schema
Date:   Tue, 19 Apr 2022 22:09:39 +0400
Message-Id: <20220419180938.19397-4-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220419180938.19397-1-y.oudjana@protonmail.com>
References: <20220419180938.19397-1-y.oudjana@protonmail.com>
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
 .../arm/mediatek/mediatek,infracfg.yaml       | 79 +++++++++++++++++++
 2 files changed, 79 insertions(+), 42 deletions(-)
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
index 000000000000..4f43fe9f103e
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
@@ -0,0 +1,79 @@
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
+  to the system.
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
+    infracfg: syscon@10001000 {
+        compatible = "mediatek,mt8173-infracfg", "syscon";
+        reg = <0x10001000 0x1000>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+    };
-- 
2.35.3


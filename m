Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7E450D099
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 10:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238744AbiDXIxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 04:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237601AbiDXIx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 04:53:28 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1842C1CFD6;
        Sun, 24 Apr 2022 01:50:28 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id w16so2894369ejb.13;
        Sun, 24 Apr 2022 01:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9hGLWJes4t+4tQMjv3m5RoPb2lvXCIf1ih3dR2aQ4Qc=;
        b=anaLUvD7MuN2zlKzDM7sN/GC+fVdQNLICiJb/sPF1fU8HlUvcyUizTZbHybv+PT4KK
         tO+dpwAc45opffGIyePpf3pm7WtM2xvqQ2IVVk+9MiS+DM3APDdmhuOjW9HTvfCTK8WR
         INcFWxBxztZHMSBcAysEUfq4kcgduFwx4yWcvSWCjD+AzeaO+7/wjwiO6/4LwZPEdjLO
         9p1QrVYJ4s96hA8dov3IkIqWp5yU7rfXNE0ln8rGC7pr/ObS2GaQp6/uCUmQMq9LrUcw
         ilYAvsQ3LPxy18gTQnGbs7UCK/SaRwzpBvEoSd6RdZdqDM7OGZkDkru6YYUxjUC185on
         vKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9hGLWJes4t+4tQMjv3m5RoPb2lvXCIf1ih3dR2aQ4Qc=;
        b=3xAPqaWQE3WkBOHQOPxbCV/lguifGb9YUUMwZSo/mwln5H9OJDR2jvOv8uFYDobmf9
         iYQ+ebjjrrb/PJDfsg5Gc+ydJXuoREKoDbNxysCnJitWpi038ialJcoxNZdATX3JYJuC
         O4MMILK9FUBruvcQm9vXJVl8iuv+SQudibpg/3KbeAdi4WevdMSfoWrloo5yRTBpoGPB
         EuwzTQVZ8TmWfrdZGhMzfH8V4/9ieWWupMte/4YwS/zjzxzzMU1JCUBOiMbtXXvlyjAL
         QaIv0xsxpKLhdoDUcZdkBwCkaPbtXFvTwJfqswTuDQrN75fXJFZyNTaaTs7bNzO210Sp
         eFyw==
X-Gm-Message-State: AOAM5300LQPDGK937CfuQQJHVlV/IrEuHS2NckM7dT7cMlXuOQMaP4QQ
        XRy+TBsC8Eo5U25HBBPWMKA=
X-Google-Smtp-Source: ABdhPJwBtC5p5qrhVd/u7qXx7lSPfmACDBIYD3HWFPMHT5rAadi8AQ5JK+DpO9egTuehUQK3iKG09g==
X-Received: by 2002:a17:907:7f8f:b0:6f0:e67:e3a7 with SMTP id qk15-20020a1709077f8f00b006f00e67e3a7mr11700601ejc.517.1650790226555;
        Sun, 24 Apr 2022 01:50:26 -0700 (PDT)
Received: from localhost.localdomain ([138.199.7.245])
        by smtp.gmail.com with ESMTPSA id gy10-20020a170906f24a00b006e894144707sm2435971ejb.53.2022.04.24.01.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 01:50:26 -0700 (PDT)
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
Subject: [PATCH v2 1/3] dt-bindings: arm: mediatek: topckgen: Convert to DT schema
Date:   Sun, 24 Apr 2022 12:46:45 +0400
Message-Id: <20220424084647.76577-2-y.oudjana@protonmail.com>
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

Convert topckgen bindings to DT schema format. MT2701, MT7623 and
MT7629 device trees currently have the syscon compatible without
it being mentioned in the old DT bindings file which introduces
dtbs_check errors when converting to DT schema as-is, so
mediatek,mt2701-topckgen and mediatek,mt7629-topckgen are placed
in the last items list with the syscon compatible, and syscon is
added to the mediatek,mt7623-topckgen list.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../arm/mediatek/mediatek,topckgen.txt        | 35 -----------
 .../bindings/clock/mediatek,topckgen.yaml     | 61 +++++++++++++++++++
 2 files changed, 61 insertions(+), 35 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
deleted file mode 100644
index b82422bb717f..000000000000
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-Mediatek topckgen controller
-============================
-
-The Mediatek topckgen controller provides various clocks to the system.
-
-Required Properties:
-
-- compatible: Should be one of:
-	- "mediatek,mt2701-topckgen"
-	- "mediatek,mt2712-topckgen", "syscon"
-	- "mediatek,mt6765-topckgen", "syscon"
-	- "mediatek,mt6779-topckgen", "syscon"
-	- "mediatek,mt6797-topckgen"
-	- "mediatek,mt7622-topckgen"
-	- "mediatek,mt7623-topckgen", "mediatek,mt2701-topckgen"
-	- "mediatek,mt7629-topckgen"
-	- "mediatek,mt7986-topckgen", "syscon"
-	- "mediatek,mt8135-topckgen"
-	- "mediatek,mt8167-topckgen", "syscon"
-	- "mediatek,mt8173-topckgen"
-	- "mediatek,mt8183-topckgen", "syscon"
-	- "mediatek,mt8516-topckgen"
-- #clock-cells: Must be 1
-
-The topckgen controller uses the common clk binding from
-Documentation/devicetree/bindings/clock/clock-bindings.txt
-The available clocks are defined in dt-bindings/clock/mt*-clk.h.
-
-Example:
-
-topckgen: power-controller@10000000 {
-	compatible = "mediatek,mt8173-topckgen";
-	reg = <0 0x10000000 0 0x1000>;
-	#clock-cells = <1>;
-};
diff --git a/Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml b/Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml
new file mode 100644
index 000000000000..5b8b37a2e594
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/clock/mediatek,topckgen.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: MediaTek Top Clock Generator Controller
+
+maintainers:
+  - Michael Turquette <mturquette@baylibre.com>
+  - Stephen Boyd <sboyd@kernel.org>
+
+description:
+  The Mediatek topckgen controller provides various clocks to the system.
+  The clock values can be found in <dt-bindings/clock/mt*-clk.h>.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - mediatek,mt6797-topckgen
+          - mediatek,mt7622-topckgen
+          - mediatek,mt8135-topckgen
+          - mediatek,mt8173-topckgen
+          - mediatek,mt8516-topckgen
+      - items:
+          - const: mediatek,mt7623-topckgen
+          - const: mediatek,mt2701-topckgen
+          - const: syscon
+      - items:
+          - enum:
+              - mediatek,mt2701-topckgen
+              - mediatek,mt2712-topckgen
+              - mediatek,mt6765-topckgen
+              - mediatek,mt6779-topckgen
+              - mediatek,mt7629-topckgen
+              - mediatek,mt7986-topckgen
+              - mediatek,mt8167-topckgen
+              - mediatek,mt8183-topckgen
+          - const: syscon
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    topckgen: clock-controller@10000000 {
+        compatible = "mediatek,mt8173-topckgen";
+        reg = <0x10000000 0x1000>;
+        #clock-cells = <1>;
+    };
-- 
2.36.0


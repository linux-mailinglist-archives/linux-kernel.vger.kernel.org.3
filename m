Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D933950777B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355536AbiDSSQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356422AbiDSSQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:16:01 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117993EA88;
        Tue, 19 Apr 2022 11:12:30 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id u18so22350174eda.3;
        Tue, 19 Apr 2022 11:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nV/V/sSiQrpacLvnsxKcMtnuzTjfpOGiqmnW9+zsuXw=;
        b=C8+SnHSvi/3OxwkFOy+xJfV8PXdzA+KCAXh+TU+xF+OVvSe3RpJiOEznblvsAwOcDu
         zzMbQsNlM3oAsUgSoLBVDvUmfoNp1dyyisooBTR2VXMNLVgHfdyTg91VS5cNCwo7WI+N
         0TkETmBVk6LR4CKxNMGdlM6LhvbljypPM6xMlDXHkTN2WdA9cUKI0XG61aMFYB0KM7IG
         rhLmAVDM97ba+odgtNnPTTVsfpF0jN7qrSFmIYo+YI+Y1P5PbTwZtXjXz8XrEH3E7sfL
         lJx5kx102RHf8tb1oES2lAjcxOJufDCWHl3I0gtSLc6AQFxsP99brDfEq9tjmMzvMFi3
         KCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nV/V/sSiQrpacLvnsxKcMtnuzTjfpOGiqmnW9+zsuXw=;
        b=07GRT2KkzSjduQLdUrNerQHWyrkBNIohtj2RqCrcLCKTdJsRq+P1OQiCZ9rsRzDpi/
         Bntuxx4P3ut2+6sp/nf5p6+zOxuhFkoqtHHl8xEHW/YZFJswN7FV+PiZdZNeSVC4BoNP
         XEoCWAkwE7yB2F4cpiPY3hawZ2gRxB1f1wWHlgYfKuPk+fodLrqCfO+p4Z0V5rIUdFkS
         rcM5MvgX2ijgUq4b/N8YJUFrO+qtPdIMKZ6SsKfQcDE09moqO0qPebuvq3pr9eMlyt8B
         UKsl1kHl0L8ZpTvZeqI9J/hmY+N3XZ6m5H/QggnAKjv+w9RQ0Uy7+80GA29+w/cwpnHh
         uJBQ==
X-Gm-Message-State: AOAM5328RXdGBKWD0yVyB68H5OUUbu8TRKmwEC6sDg4gcO1OKoK+RX96
        e+KmEqYGytgC7d5AxGn+VkY=
X-Google-Smtp-Source: ABdhPJw5Qs3spIyZaNmqd45dxxwH/JvTxPVzOd6tS7esXoye+O3Ju9Qtxs1013fkuta7ZoX7sN1YbQ==
X-Received: by 2002:a05:6402:5cf:b0:41d:7aa7:152a with SMTP id n15-20020a05640205cf00b0041d7aa7152amr19365895edx.68.1650391948620;
        Tue, 19 Apr 2022 11:12:28 -0700 (PDT)
Received: from localhost.localdomain ([212.102.35.230])
        by smtp.gmail.com with ESMTPSA id b20-20020a1709063f9400b006e12836e07fsm5930614ejj.154.2022.04.19.11.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 11:12:28 -0700 (PDT)
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
Subject: [PATCH 1/3] dt-bindings: arm: mediatek: topckgen: Convert to DT schema
Date:   Tue, 19 Apr 2022 22:09:37 +0400
Message-Id: <20220419180938.19397-2-y.oudjana@protonmail.com>
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
 .../arm/mediatek/mediatek,topckgen.yaml       | 60 +++++++++++++++++++
 2 files changed, 60 insertions(+), 35 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.yaml

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
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.yaml
new file mode 100644
index 000000000000..9ce9cf673cbc
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/arm/mediatek/mediatek,topckgen.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: MediaTek Top Clock Generator Controller
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+
+description:
+  The Mediatek topckgen controller provides various clocks to the system.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - mediatek,mt6797-topckgen
+              - mediatek,mt7622-topckgen
+              - mediatek,mt8135-topckgen
+              - mediatek,mt8173-topckgen
+              - mediatek,mt8516-topckgen
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
2.35.3


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A48250D094
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 10:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238764AbiDXIxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 04:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238753AbiDXIxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 04:53:39 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B7A1EAF4;
        Sun, 24 Apr 2022 01:50:37 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y21so8276565edo.2;
        Sun, 24 Apr 2022 01:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8W5+Z8xfgLRyM84vERTjWIAUY1i0+LAcAHaXYj8ooeI=;
        b=HJVWKxSRlzwEzSVJHhutKBP5YESaIhaHsOm1yHH1zoXuYdANXyi5CYFsyyjoS0Io7F
         6KMGQFIiDqaztWWrI5n2/l71KCG3en34KF7Cy7E3DTCMZb2NZXoc8brPMNPwYPTIM9c0
         UtbB2zeFfLRMOKhH85AYwgcAbpiogLbrs+XnRpaftzE2FspRyIREhPAjn/VbxElB/A6i
         ZcavS0FjE0ZylygFWZpSO4/QVz/2FG7sQT0PgohsL5YM/NvmG5sWlIqlSiHea25e7DYE
         dMocobgbtDCT6+mZOHQFqPK1kqceHUVmR7Y8G7pa/jAAJZyV9AqYQExXMpfYS/wJcybs
         QOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8W5+Z8xfgLRyM84vERTjWIAUY1i0+LAcAHaXYj8ooeI=;
        b=B3geEdd/kT59kUjDMhuIO/6Xt6RtAtAnPDvTu0PIVTc4tpAuQNcnZjx5rjn61vkZJY
         LrHiD4cRJG1X8i8ojSF1YGuDOjn9dKTmiPqUy9RMt25CKCj7Eo3jw2qAgRFfQw3FRHeu
         K+xKcH8m+waiqHbCp3O0hCRzy2NjnrdL1uhQu0ZJBbX2dCeGww8cNRh0U5USvc03vjC4
         iFXj4jjcXrXbElv4AWiznEaCXxvdo+FsUsXV8SKhFiqTYzNgA/Sjc65uGTviQgIWc/GT
         t6WUeydBZk2NAIeqZuKfMAp8elv4HC89L8aiqat/aDC2H6J/3wucDK8388FssJ1Z+azl
         RrLA==
X-Gm-Message-State: AOAM531UTKelR3gV05aAR1wi5rCiO+WjRf+QoSOWywIBaqVL1S8XCsW/
        woQL9lR4DijN3+K3893/V/Q=
X-Google-Smtp-Source: ABdhPJxCHoStiGRdxwMSQct0lwtQdbcFNX3mNwhWPi/jWgi/9gF+dy8m5VkfSZr+vzy2KVFkMVuC7g==
X-Received: by 2002:a50:f69c:0:b0:425:c96a:5c09 with SMTP id d28-20020a50f69c000000b00425c96a5c09mr7964237edn.256.1650790236424;
        Sun, 24 Apr 2022 01:50:36 -0700 (PDT)
Received: from localhost.localdomain ([138.199.7.245])
        by smtp.gmail.com with ESMTPSA id gy10-20020a170906f24a00b006e894144707sm2435971ejb.53.2022.04.24.01.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 01:50:36 -0700 (PDT)
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
Subject: [PATCH v2 2/3] dt-bindings: arm: mediatek: apmixedsys: Convert to DT schema
Date:   Sun, 24 Apr 2022 12:46:46 +0400
Message-Id: <20220424084647.76577-3-y.oudjana@protonmail.com>
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

Convert apmixedsys bindings to DT schema format. MT2701, MT7623 and
MT7629 device trees currently have the syscon compatible without
it being mentioned in the old DT bindings file which introduces
dtbs_check errors when converting to DT schema as-is, so
mediatek,mt2701-apmixedsys and mediatek,mt7629-apmixedsys are placed
in the last items list with the syscon compatible, and syscon is
added to the mediatek,mt7623-apmixedsys list.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../arm/mediatek/mediatek,apmixedsys.txt      | 35 -----------
 .../bindings/clock/mediatek,apmixedsys.yaml   | 61 +++++++++++++++++++
 2 files changed, 61 insertions(+), 35 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
deleted file mode 100644
index 3fa755866528..000000000000
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-Mediatek apmixedsys controller
-==============================
-
-The Mediatek apmixedsys controller provides the PLLs to the system.
-
-Required Properties:
-
-- compatible: Should be one of:
-	- "mediatek,mt2701-apmixedsys"
-	- "mediatek,mt2712-apmixedsys", "syscon"
-	- "mediatek,mt6765-apmixedsys", "syscon"
-	- "mediatek,mt6779-apmixedsys", "syscon"
-	- "mediatek,mt6797-apmixedsys"
-	- "mediatek,mt7622-apmixedsys"
-	- "mediatek,mt7623-apmixedsys", "mediatek,mt2701-apmixedsys"
-	- "mediatek,mt7629-apmixedsys"
-	- "mediatek,mt7986-apmixedsys"
-	- "mediatek,mt8135-apmixedsys"
-	- "mediatek,mt8167-apmixedsys", "syscon"
-	- "mediatek,mt8173-apmixedsys"
-	- "mediatek,mt8183-apmixedsys", "syscon"
-	- "mediatek,mt8516-apmixedsys"
-- #clock-cells: Must be 1
-
-The apmixedsys controller uses the common clk binding from
-Documentation/devicetree/bindings/clock/clock-bindings.txt
-The available clocks are defined in dt-bindings/clock/mt*-clk.h.
-
-Example:
-
-apmixedsys: clock-controller@10209000 {
-	compatible = "mediatek,mt8173-apmixedsys";
-	reg = <0 0x10209000 0 0x1000>;
-	#clock-cells = <1>;
-};
diff --git a/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml b/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml
new file mode 100644
index 000000000000..770546195fb5
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/clock/mediatek,apmixedsys.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: MediaTek AP Mixedsys Controller
+
+maintainers:
+  - Michael Turquette <mturquette@baylibre.com>
+  - Stephen Boyd <sboyd@kernel.org>
+
+description:
+  The Mediatek apmixedsys controller provides PLLs to the system.
+  The clock values can be found in <dt-bindings/clock/mt*-clk.h>.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - mediatek,mt6797-apmixedsys
+          - mediatek,mt7622-apmixedsys
+          - mediatek,mt7986-apmixedsys
+          - mediatek,mt8135-apmixedsys
+          - mediatek,mt8173-apmixedsys
+          - mediatek,mt8516-apmixedsys
+      - items:
+          - const: mediatek,mt7623-apmixedsys
+          - const: mediatek,mt2701-apmixedsys
+          - const: syscon
+      - items:
+          - enum:
+              - mediatek,mt2701-apmixedsys
+              - mediatek,mt2712-apmixedsys
+              - mediatek,mt6765-apmixedsys
+              - mediatek,mt6779-apmixedsys
+              - mediatek,mt7629-apmixedsys
+              - mediatek,mt8167-apmixedsys
+              - mediatek,mt8183-apmixedsys
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
+    apmixedsys: clock-controller@10209000 {
+        compatible = "mediatek,mt8173-apmixedsys";
+        reg = <0x10209000 0x1000>;
+        #clock-cells = <1>;
+    };
-- 
2.36.0


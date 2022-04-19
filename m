Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFB350779A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356505AbiDSSRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356484AbiDSSQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:16:09 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC643E0D3;
        Tue, 19 Apr 2022 11:12:36 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id r13so34610666ejd.5;
        Tue, 19 Apr 2022 11:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZhelTs57qB8l8snfqOh3tsOfdXgjXxOg3YxbLx/o20g=;
        b=KMjlgvdZbFgtrDUD5sGre35l5IsjYq/4lFCHGa5O4f6vUnz8Z879bU2B9iknQi29hc
         zQoZsHYeuBBHKqoc0JXikAHQUVjXoTHRHeVaeqoBXFcZMJAYgs2bVl6SqIDbvA/K0/jq
         hH9V1AOPG1FXqLhQV4VslfQmc7Igc0rhuOa+x7u1cBI5T1BHiZe54e2IONJ3pIa0U1dt
         2c9JQyviwNIY6SI01uSrEtgXVupQjNTqWVT3n0bMuCzwS5KkZ2aReqSxwypKY9j+fKRN
         RI/4N0IOUFf3SGn592yRrR16+grUd+49M2m2y962EHNY+sC8RxQjiK1qw2nli57m02FE
         q+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZhelTs57qB8l8snfqOh3tsOfdXgjXxOg3YxbLx/o20g=;
        b=LpwWRpAQwSgGVSCvAIiuWcosSmCjK/wJRmUUh+3qprW+ujiiNMNmsSsdXlIUlr/Up2
         +rJRn5AM37ZGJ9DUpHcR7Cr/3R1piFlNXkNHp+T9l0GaqPFs4TP+TlcZPlUbTGEODt0L
         cRzplWfoIRrCsU53qnsYYlrFyFOpOBs8Mxb63NBiDycGmCMpHV4knty3s+IZfZkEQGPT
         7hKwBEdVKr6WSqzwIJww5LcSYzggu20F/ajWG8tU1Go50omZUR2f3WIOMMrodGoVMrR2
         lskUMRn4LY5uH1Hd7anKSRVS7wv+ZamcHYt9JKR6y7hoJ8U2jphQOTwugZ951bCc7Icv
         3Nig==
X-Gm-Message-State: AOAM531QdRfgsIpi9/cG4if9xp1tVTvU7fEYyfE0CWLBKajw0e3Ooonz
        M6Ch/kEf2sbUw8YuydZdKzI=
X-Google-Smtp-Source: ABdhPJyeIZRBjgA3MKX+mlJppPwTSIKZXJss/g8U03EN6uX9wqh5+ibHjB3tWGPq+OFnSu3HfGR4tA==
X-Received: by 2002:a17:907:2d08:b0:6e8:8e58:f70e with SMTP id gs8-20020a1709072d0800b006e88e58f70emr15434200ejc.301.1650391955354;
        Tue, 19 Apr 2022 11:12:35 -0700 (PDT)
Received: from localhost.localdomain ([212.102.35.230])
        by smtp.gmail.com with ESMTPSA id b20-20020a1709063f9400b006e12836e07fsm5930614ejj.154.2022.04.19.11.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 11:12:35 -0700 (PDT)
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
Subject: [PATCH 2/3] dt-bindings: arm: mediatek: apmixedsys: Convert to DT schema
Date:   Tue, 19 Apr 2022 22:09:38 +0400
Message-Id: <20220419180938.19397-3-y.oudjana@protonmail.com>
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
 .../arm/mediatek/mediatek,apmixedsys.yaml     | 60 +++++++++++++++++++
 2 files changed, 60 insertions(+), 35 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.yaml

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
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.yaml
new file mode 100644
index 000000000000..fc967fdc8aec
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/arm/mediatek/mediatek,apmixedsys.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: MediaTek AP Mixedsys Controller
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+
+description:
+  The Mediatek apmixedsys controller provides PLLs to the system.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - mediatek,mt6797-apmixedsys
+              - mediatek,mt7622-apmixedsys
+              - mediatek,mt7986-apmixedsys
+              - mediatek,mt8135-apmixedsys
+              - mediatek,mt8173-apmixedsys
+              - mediatek,mt8516-apmixedsys
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
2.35.3


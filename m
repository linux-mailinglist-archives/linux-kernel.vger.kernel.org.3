Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE125A7365
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 03:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbiHaBeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 21:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiHaBeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 21:34:13 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A736DB14C3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 18:34:10 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y141so13049755pfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 18:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=vhZ3yILypvJYBsR07fkWNRnqx8C8Eemkyou0+SjZ/pw=;
        b=cMSqVjK2Zfuhis85tst7BCwfAKBK2t9NliW2wwptDc3jcSLvsk23IFXL1Ba9QZNbLC
         RX0DbKquu1UnUWoZqzpAPwmEa6sGt3eS9DJi7Xc77uohiNcPVNoo8RG8QDAcwwJoqAAx
         FtQyKE8TyoclIShBe/nRYQFQZL9ZI4ZVzGZpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=vhZ3yILypvJYBsR07fkWNRnqx8C8Eemkyou0+SjZ/pw=;
        b=5M3KyPW6OtJ2mwZEy4BzZVp7aXaAGzyt7wvIYe8O2gR2QVwPArxJi1JP0zM5NuymI4
         NVDzlERWdeI/oMAQ2FhQ1t07YZ2Q+QnB/II7iL/Xinm4Lnh0f/m+aJOaAajlP7W1i00y
         8DM8trCGNnhC3OnhG4be/xbDadenq0In3c6JEXDGLVRlJY+U2+kj1asW0k5/lXkNmoCe
         wWeOM3vYotktUhfyo53nTnrqPlWRVepeEoefj+l/JQMVWTcNVKBX9CGHAXmzzQpE+32E
         gVQ3QEJTLj5tYD2cJsrWEV9s9fZgch4emDmIgz7aNF/XjLi1Q6I3fwd++9v1DhjuGS0T
         pZ/w==
X-Gm-Message-State: ACgBeo1Dpf767/CR6FDj5euXzmZ8BXVCr9l+82tPWCpe9MKRrrcdh12E
        c3Jpp4awtxl6IX7W1GHVBWXLXw==
X-Google-Smtp-Source: AA6agR4ccLRkb7LZHm0w+AIKx+colMNa8gkGdaPzUYlDlj4c6fTm7pv6uev6zAoWSFIZgENYZSJ7nQ==
X-Received: by 2002:a65:6b8e:0:b0:42a:162c:e3a0 with SMTP id d14-20020a656b8e000000b0042a162ce3a0mr20198378pgw.464.1661909648973;
        Tue, 30 Aug 2022 18:34:08 -0700 (PDT)
Received: from jwerner-p920.mtv.corp.google.com ([2620:15c:202:201:2e75:b9a4:fb1:b1b8])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902e84a00b00174f4316c24sm4261382plg.245.2022.08.30.18.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 18:34:08 -0700 (PDT)
From:   Julius Werner <jwerner@chromium.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        Jian-Jia Su <jjsu@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Julius Werner <jwerner@chromium.org>
Subject: [PATCH 3/4] dt-bindings: memory: Add jedec,lpddr4 and jedec,lpddr5 bindings
Date:   Tue, 30 Aug 2022 18:33:58 -0700
Message-Id: <20220831013359.1807905-4-jwerner@chromium.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220831013359.1807905-1-jwerner@chromium.org>
References: <20220831013359.1807905-1-jwerner@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds bindings for LPDDR4 and LPDDR5 memory analogous to the
existing bindings for LPDDR2 and LPDDR3. For now, the new types are only
needed for topology description, so other properties like timing
parameters are omitted. They can be added later if needed.

Signed-off-by: Julius Werner <jwerner@chromium.org>
---
 .../ddr/jedec,lpddr-props.yaml                |  4 ++
 .../memory-controllers/ddr/jedec,lpddr4.yaml  | 36 ++++++++++++++
 .../memory-controllers/ddr/jedec,lpddr5.yaml  | 48 +++++++++++++++++++
 3 files changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr4.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr5.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
index 0c7d2feafd77c8..e1182e75ca1a3f 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
@@ -53,9 +53,13 @@ properties:
       - 512
       - 1024
       - 2048
+      - 3072
       - 4096
+      - 6144
       - 8192
+      - 12288
       - 16384
+      - 24576
       - 32768
 
   io-width:
diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr4.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr4.yaml
new file mode 100644
index 00000000000000..860300cebee754
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr4.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/ddr/jedec,lpddr4.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LPDDR4 SDRAM compliant to JEDEC JESD209-4
+
+allOf:
+  - $ref: "jedec,lpddr-props.yaml#"
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+properties:
+  compatible:
+    items:
+      - pattern: "^lpddr4-[0-9a-f]{2},[0-9a-f]{4}$"
+      - const: jedec,lpddr4
+
+required:
+  - compatible
+  - density
+  - io-width
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    lpddr4 {
+        compatible = "lpddr4-ff,0100", "jedec,lpddr4";
+        density = <8192>;
+        io-width = <16>;
+        manufacturer-id = <255>;
+        revision-id = <1 0>;
+    };
diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr5.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr5.yaml
new file mode 100644
index 00000000000000..ae3894bb346d5e
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr5.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/ddr/jedec,lpddr5.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LPDDR5 SDRAM compliant to JEDEC JESD209-5
+
+allOf:
+  - $ref: "jedec,lpddr-props.yaml#"
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+properties:
+  compatible:
+    items:
+      - pattern: "^lpddr5-[0-9a-f]{2},[0-9a-f]{4}$"
+      - const: jedec,lpddr5
+
+  serial-id:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      Serial IDs read from Mode Registers 47 through 54. One byte per uint32
+      cell (i.e. <MR47 MR48 MR49 MR50 MR51 MR52 MR53 MR54>).
+    minItems: 8
+    maxItems: 8
+    items:
+      minimum: 0
+      maximum: 255
+
+required:
+  - compatible
+  - density
+  - io-width
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    lpddr4 {
+        compatible = "lpddr5-01,0200", "jedec,lpddr5";
+        density = <8192>;
+        io-width = <8>;
+        manufacturer-id = <1>;
+        revision-id = <2 0>;
+        serial-id = <3 1 0 0 0 0 0 0>;
+    };
-- 
2.31.0


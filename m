Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E575B1062
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 01:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiIGX3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 19:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiIGX33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 19:29:29 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3EBB8F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 16:29:23 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 123so6735589pfy.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 16:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=yQkwNtni2gxxdATORPGlV1fDV03YMJzpHvkUqtYbFaw=;
        b=dvSWdYIkn2Efto6iM0rwgEjCNE/o1OhsX46iIUwrKcEFYP8cKlumrQs65UR5i89595
         NbDPrdVhP6/Esw01d0gQ47EDPPXHZmn4+eKT7EL1OtSNuCD8yfownW/vhU8IVXdYFArs
         walXYWOAwWMANNnebV83/GfapsY1r/uFEudkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=yQkwNtni2gxxdATORPGlV1fDV03YMJzpHvkUqtYbFaw=;
        b=FYQyRI+vB2jaQpABnw+0BBhQeLzQCcv4ZniOrjKa5MA1ExztlCGUKJsD5RrsZ05jSO
         7ag4zFfMNXbK1JLLyI7CIVRSTIGLNnLYQHOlpUm3EnCITyms6TIdyY41PO9kWbV0VyIX
         Tyv4PSl5P2ZmfCQZv3N/5HWnOICniEJt9mzrCJaoMaexgMgo+5WA3U0BqQXhac9g3d42
         L6/443XaTnG7bizwB3yK/m+Oybyd/tS8/8KwyhwuWQjFuv/m9A+9543rxwD6Z4QOuc7k
         l37UjnOoCqpEHnm/d/zPC4UI3eQy3oQnEBJcJyvC2q8FUYCE6uNSvsRsZhCDWx1+py5o
         IoaQ==
X-Gm-Message-State: ACgBeo3Bvzm9FCTXh8cGZ3GI0pAyYEPXaeiJE/7HUqQTGS1QnHMGRE2Y
        Hf8NmjGCbjsSlBu5870tLKjBBw==
X-Google-Smtp-Source: AA6agR73gLQF4pgbpUaEj6zw3YArSWJPDjhe+CF3Nnx0UEHo/lIbzNJnb34ZIaiLak2PG4NYZIzHrw==
X-Received: by 2002:a05:6a00:a04:b0:534:d8a6:40ce with SMTP id p4-20020a056a000a0400b00534d8a640cemr6184297pfh.15.1662593363022;
        Wed, 07 Sep 2022 16:29:23 -0700 (PDT)
Received: from jwerner-p920.mtv.corp.google.com ([2620:15c:202:201:1cee:f8f:cc9f:568f])
        by smtp.gmail.com with ESMTPSA id g6-20020a17090a708600b002000dabc356sm201521pjk.45.2022.09.07.16.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 16:29:22 -0700 (PDT)
From:   Julius Werner <jwerner@chromium.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        Jian-Jia Su <jjsu@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Julius Werner <jwerner@chromium.org>
Subject: [PATCH 3/4 v2] dt-bindings: memory: Add jedec,lpddr4 and jedec,lpddr5 bindings
Date:   Wed,  7 Sep 2022 16:29:13 -0700
Message-Id: <20220907232914.243502-3-jwerner@chromium.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220907232914.243502-1-jwerner@chromium.org>
References: <20220907232914.243502-1-jwerner@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
 .../memory-controllers/ddr/jedec,lpddr5.yaml  | 47 +++++++++++++++++++
 3 files changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr4.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr5.yaml

Changelog:

- v2
  - removed minItems
  - moved `$ref` below `maintainers`
  - renamed example node from `lpddr4` to `lpddr`

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
index 4114cfa8de67f1..92ef660888f318 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
@@ -45,9 +45,13 @@ properties:
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
index 00000000000000..0b2394c032797f
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
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+allOf:
+  - $ref: "jedec,lpddr-props.yaml#"
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
+    lpddr {
+        compatible = "lpddr4-ff,0100", "jedec,lpddr4";
+        density = <8192>;
+        io-width = <16>;
+        manufacturer-id = <255>;
+        revision-id = <1 0>;
+    };
diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr5.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr5.yaml
new file mode 100644
index 00000000000000..d86e1e30380e47
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr5.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/ddr/jedec,lpddr5.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LPDDR5 SDRAM compliant to JEDEC JESD209-5
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+allOf:
+  - $ref: "jedec,lpddr-props.yaml#"
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
+    lpddr {
+        compatible = "lpddr5-01,0200", "jedec,lpddr5";
+        density = <8192>;
+        io-width = <8>;
+        manufacturer-id = <1>;
+        revision-id = <2 0>;
+        serial-id = <3 1 0 0 0 0 0 0>;
+    };
-- 
2.31.0


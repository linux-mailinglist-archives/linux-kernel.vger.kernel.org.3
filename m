Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A43858110B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 12:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238549AbiGZKY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 06:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238577AbiGZKYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 06:24:23 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870E52FFFC;
        Tue, 26 Jul 2022 03:24:22 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d7so12898780plr.9;
        Tue, 26 Jul 2022 03:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a5n2rQav5Pw8Em71zzLULSb7yyvZg/ST3BqtiUX72ak=;
        b=DBlM0t360Nn8hZ8HcEji79X8RDW5tVb9bdRBpHJbVG6bkMidQ+cy2kYHaO1sykaq5M
         JsUkkMuM0zl7vmifQL37tkRyr0yzMiohtHzz18gmGA1eeyEeip+6RBV7uScqI1BCLWlP
         ogN0SZ96O0JY14Dw4FIx1t6Yw0louWg6ubzR6cSUpchE/poUF3gcmJh5dQGFYB4AICHZ
         sD5Bg8KLFLvzlnOsFDh6Nn2SyITWujc9a0KS5yhgmS3z93PUrChwwlWaRiOwEE/lFEh0
         hHNdxDt83BJFXIsHPytW7htVQw2sSv9dl7aeWIGclRlRIWDM9ZG5y6Us1fr8fPhA9bAh
         Q1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a5n2rQav5Pw8Em71zzLULSb7yyvZg/ST3BqtiUX72ak=;
        b=k+qfLqYx7wit+Q5vRzl++OSQEKy6z99Aga5WFBhiPb/qG4v2BK3s8M+iFkgpi2QIx2
         Cr+UXbonHmQKaGWSfHCCmfDjE81txYUSWESmEfMZTInO9l/njlq2vYvgdx8WSmPyBWtt
         z+cQQJz1eTdny4KVXkcDJgXtweeQ2w//UVCoqLf6jHYkX2wlDIHZPT9GNKMrhPyUctR3
         4WTWlAqAg4HICTPetG+s0JJrb7hR1bno0kudvOpvnqraPSJ0vKbV23eB3VqJQlO3eZB3
         Zp2V0hlTD028QsUE27O5EkYJTnzwVl7oIG6oZiyVcbLgIQ3qXnzYR1ow/uflFk3BMRyx
         PkIA==
X-Gm-Message-State: AJIora/plYpXRDE4XjZ2PIJyvrM945ptU8LRD+i7duCh5G5J8g2dj8CD
        tZKOdhDA9giWiXJ6jEM+VV2GKBOTFEM0sA==
X-Google-Smtp-Source: AGRyM1snqPJunO0+wb0ccw6OAhxDGmtiDDB0TNFOu9gHYUB5mZL0ZcS1WNuvqJoHWTG4ic9eSc7HIA==
X-Received: by 2002:a17:902:e84e:b0:16b:f773:4692 with SMTP id t14-20020a170902e84e00b0016bf7734692mr16357375plg.19.1658831061807;
        Tue, 26 Jul 2022 03:24:21 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id m12-20020a17090ab78c00b001ef3cec7f47sm10421753pjr.52.2022.07.26.03.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 03:24:21 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH V6 1/2] dt-bindings: mfd: sprd: Add bindings for ums512 global registers
Date:   Tue, 26 Jul 2022 18:24:03 +0800
Message-Id: <20220726102404.564498-2-gengcixi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220726102404.564498-1-gengcixi@gmail.com>
References: <20220726102404.564498-1-gengcixi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Add bindings for Unisoc system global register which provide register map
for clocks.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/mfd/sprd,ums512-glbreg.yaml      | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml

diff --git a/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml b/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
new file mode 100644
index 000000000000..416f94a09c27
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2022 Unisoc Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/sprd,ums512-glbreg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Unisoc System Global Register
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+description:
+  Unisoc system global registers provide register map
+  for clocks and some multimedia modules of the SoC.
+
+properties:
+  compatible:
+    items:
+      - const: sprd,ums512-glbregs
+      - const: syscon
+      - const: simple-mfd
+
+  "#address-cells": true
+  "#size-cells": true
+
+  ranges:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+patternProperties:
+  "^clock-controller@[0-9a-f]+$":
+    type: object
+    $ref: "../clock/sprd,ums512-clk.yaml"
+    description:
+      Clock controller for the SoC clocks.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    ap_apb_regs: syscon@71000000 {
+      compatible = "sprd,ums512-glbregs", "syscon", "simple-mfd";
+      reg = <0x71000000 0x3000>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+      ranges = <0 0x71000000 0x3000>;
+
+      clock-controller@0 {
+        compatible = "sprd,ums512-apahb-gate";
+        reg = <0x0 0x2000>;
+        #clock-cells = <1>;
+      };
+    };
+
+  - |
+    ap_intc5_regs: syscon@32360000 {
+      compatible = "sprd,ums512-glbregs", "syscon", "simple-mfd";
+      reg = <0x32360000 0x1000>;
+    };
-- 
2.25.1


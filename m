Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07A951BCF5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 12:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355250AbiEEKSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 06:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355152AbiEEKSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 06:18:31 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8A2517F7;
        Thu,  5 May 2022 03:14:52 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d17so3985699plg.0;
        Thu, 05 May 2022 03:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a5n2rQav5Pw8Em71zzLULSb7yyvZg/ST3BqtiUX72ak=;
        b=XJAT33VmgQlgzLEQ+S4zoq8s2zjs7g5bL5Se32zHSNIiO/ToUNzCGqhXNpXy1YUaFh
         go6t/knJ/DjtP23H/ysX+YX7puvpbBHnxA9k3JAtvlT6OETmcFuhzkOBMUNYy+mY3+Mw
         9ogzx1EaMeftMPgWGagJgengD8Kfp0YHESA4SNM54/zC3ihqSTvhs7dd4NHoOKAqYwIU
         4cLMsWwM7M/+k11+/ZHX75xAUY4T//VEh/sI2Cj8nDkBrTM4MVJeBOYZfczFNZGkdxJ+
         P1o7kbHTPV20qU7QM21LorSyaDsDnDRlPR/uXhvZw+EGMPMsvPqKjEL1wS2wGgO6ImP0
         HAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a5n2rQav5Pw8Em71zzLULSb7yyvZg/ST3BqtiUX72ak=;
        b=zUJvAUBduOqeXVt80nyQvWG7rkbpoPKq9dEv0GFwzjMzDJ1VIVt3clYCEKpkCVyA0D
         Id/kDhqHsFsuv/MeEXT4wKanXLWl05eXQy8gW6y1rtKJaGOrBQnOg/k5ugJUkt9ToVHq
         0SA4hWaDmTV8K4nGLzv5SWEilbGGFdeSOPi0RGaAvohB0eZfYM9MVGPdMvnqj2C0wp4C
         nFwuhmNj2p+VJfHEqeXd6+R5Mek8z1iO+TUe+xSO2bPiTeMxaaT0y6e6oQQwibspfDT2
         Dgw1X98wh5DXC8MzJIFUmzGwnBsQBWgRoaT35PrN+ZKFKiwlMwCOY2BS4roIyaq2bKvN
         qPiQ==
X-Gm-Message-State: AOAM532+E4rsH09wfK66Ow1l+oNfi506p4requ9ysf3jSKw6jWhAdMHS
        3uymvN8bf0RaHgNd4+b16anNDZDwoz4=
X-Google-Smtp-Source: ABdhPJyjd+LpZrQpSpEoByGpWahDQelTNqowRxC5l0fXbEGpOAUVfYfA6i3CbN7VyS6CN+Wy8Zn8Tw==
X-Received: by 2002:a17:903:2344:b0:15e:d382:2e3b with SMTP id c4-20020a170903234400b0015ed3822e3bmr4923641plh.37.1651745692085;
        Thu, 05 May 2022 03:14:52 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id y10-20020a1709027c8a00b0015e8d4eb2d2sm1099717pll.284.2022.05.05.03.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 03:14:51 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com, lee.jones@linaro.org
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/4] dt-bindings: mfd: sprd: Add bindings for ums512 global registers
Date:   Thu,  5 May 2022 18:14:31 +0800
Message-Id: <20220505101433.1575096-3-gengcixi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505101433.1575096-1-gengcixi@gmail.com>
References: <20220505101433.1575096-1-gengcixi@gmail.com>
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


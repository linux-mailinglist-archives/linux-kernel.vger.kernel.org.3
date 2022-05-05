Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E040D51BCF6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 12:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355178AbiEEKSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 06:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355141AbiEEKS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 06:18:28 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E12F517F7;
        Thu,  5 May 2022 03:14:49 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n8so3972415plh.1;
        Thu, 05 May 2022 03:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j0lpWHtkZPnUSw3Pz3NPm999/qD6Tlj3Gh1CrgJTGZU=;
        b=VxyYBP2h13BJiv24GVFMhKdV0vR5LsXwX8f9cu2NG1UV99aQ3OEDkeUfqQNbj5IR3f
         H1orNojlI/EHg+K0auKwroHtUV09/VTkjS2iO9ENlTlr6kfCp+goflCuErdW7bqSeU/k
         fUmzOT9+P8A95eshGKn0xoQfXUmfgsrqGMProoXBI5J2kn1BxISbf7Ot84Y0uKMXb5/u
         zS10KuYCJOk6Z8p5i+Y/wF5LQqSr3d206wITmjLlMyit/p+l9AD6H0Hc28SNwanCzb2N
         M3jNbYaF8nokfX4P4PRBvA682Avyh2KelfoHEQ5A07Y836Ighf7yEQoVUY4enz2N9KAs
         lEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j0lpWHtkZPnUSw3Pz3NPm999/qD6Tlj3Gh1CrgJTGZU=;
        b=ixpqhIRUnkHu3ENfa2G8o4vUodLwNBg2OZnczTYRjds6slIod4vh8bdCoXnef6NRyj
         or2LFgFMwWQcT50/eKTqYWKfi2J7iX8YwdYUid3hHYOYYCSpTwIkBOBP333PnSSU65yp
         2vsB96bJYHPUb0IHJ6yh/hogAzLmDDSPIwI+3HB5knh3MUUkLTYImFb+aFCrd+F1Q076
         ZxoeLULrR9ZOQsCHHTWAldjd1qC35LWUuveXeDBEf13A8LiNd55JfXItsDUMJHq5UaaI
         JuvSHIObtg5EFouvKooYQRnUGNGLvF5NCvPfSjGN01eaSrHdCRMQmFZZAPgkwDOnSIAi
         LjSQ==
X-Gm-Message-State: AOAM530GR7IkDsQDzsFy8Q5WRNUZ27PQy/HU44dV/x+BDlM7Gxuxucth
        Fsm5WTTwx+9Sr7KmUIUEYdpKObxlvGg=
X-Google-Smtp-Source: ABdhPJzOspbHXb6jok9CYiaBBBHTWSh4+uYGnQCPjbjDlG3nhGX2jUv354wHsDBbWCZLiTGKaZzoig==
X-Received: by 2002:a17:902:8f94:b0:151:64c5:7759 with SMTP id z20-20020a1709028f9400b0015164c57759mr26785799plo.4.1651745688654;
        Thu, 05 May 2022 03:14:48 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id y10-20020a1709027c8a00b0015e8d4eb2d2sm1099717pll.284.2022.05.05.03.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 03:14:48 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com, lee.jones@linaro.org
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/4] dt-bindings: clk: sprd: Add bindings for ums512 clock controller
Date:   Thu,  5 May 2022 18:14:30 +0800
Message-Id: <20220505101433.1575096-2-gengcixi@gmail.com>
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

From: Cixi Geng <cixi.geng1@unisoc.com>

Add a new bindings to describe ums512 clock compatible string.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/clock/sprd,ums512-clk.yaml       | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml

diff --git a/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
new file mode 100644
index 000000000000..5f747b0471cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2022 Unisoc Inc.
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/clock/sprd,ums512-clk.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: UMS512 Soc clock controller
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - sprd,ums512-apahb-gate
+      - sprd,ums512-ap-clk
+      - sprd,ums512-aonapb-clk
+      - sprd,ums512-pmu-gate
+      - sprd,ums512-g0-pll
+      - sprd,ums512-g2-pll
+      - sprd,ums512-g3-pll
+      - sprd,ums512-gc-pll
+      - sprd,ums512-aon-gate
+      - sprd,ums512-audcpapb-gate
+      - sprd,ums512-audcpahb-gate
+      - sprd,ums512-gpu-clk
+      - sprd,ums512-mm-clk
+      - sprd,ums512-mm-gate-clk
+      - sprd,ums512-apapb-gate
+
+  "#clock-cells":
+    const: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 4
+    description: |
+      The input parent clock(s) phandle for the clock, only list
+      fixed clocks which are declared in devicetree.
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: ext-26m
+      - const: ext-32k
+      - const: ext-4m
+      - const: rco-100m
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - '#clock-cells'
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    ap_clk: clock-controller@20200000 {
+      compatible = "sprd,ums512-ap-clk";
+      reg = <0x20200000 0x1000>;
+      clocks = <&ext_26m>;
+      clock-names = "ext-26m";
+      #clock-cells = <1>;
+    };
+...
-- 
2.25.1


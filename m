Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE7C50575F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 15:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244076AbiDRNzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 09:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244878AbiDRNa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 09:30:59 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6505CE6;
        Mon, 18 Apr 2022 05:56:55 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id j71so5221133pge.11;
        Mon, 18 Apr 2022 05:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3RmbqWDCHtc1JuoT+1cmbYRFQbM05GFwr7wy6zBNXBo=;
        b=elsFxi3jPPKytAjqdnpPYY3bP74/0ETbi7ODK8bTAaY7F5yDOjoF/kPIcjSR7vwW53
         Ug/OB685jhBUShxkwqBS3ncFNTJ7CRZotzQGNXXEP5cgMPBcwl6AnDCsJi/jO1VSri1I
         DTpLIjxSiZ4+vQwkAN9dUhSzmxs09FzTfge59fjKIB4YJUIDImMP+emekgWlHS5Pe0QJ
         NWOilKHUi4PYWAJ/Nv+nJ5ljNF1+Jbi94iQPjw+mlIor/CAkOAc7wyoSkcOY7oD3fEBX
         Nrm0hfTO9shVnmjyrxwcKBNsSPQPWfj1wiDr4DzGi8KcQPtaPezxZynrOEZmHygVTuz1
         AZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3RmbqWDCHtc1JuoT+1cmbYRFQbM05GFwr7wy6zBNXBo=;
        b=d818gKhYu1SsHcZE0CKFuD8N031C5gai5KNEQVaw8/a1YJYBLG1ih08M8juV2mxsJh
         FJY3UGb6bNXIH4spfWoD7Yi8+i8FAQX/ntZPgu2HbOYYeqXrWFOq/jBotS+vr6ayp6DD
         KZdAmoQsWYus4jsUb761s22Igcm0UCq/NnAozowrG81Rb/HA/BT4SYBfiVXVCA6EruI2
         uxK17eGgTjZjcbHMNV7WUzWgVlC/R/lwUiOY5y8gs+GxmfubBPLUNM4lvsT335h+xN+j
         a4zts1hY8nxepPv07urHB8fNKL2asqbVuevX9neUe3LJH+DYU46qWLZymuiSrhC94OxD
         wkzw==
X-Gm-Message-State: AOAM533nk7FD8a9eb5208OWhoUX/ykqLfTNvYyhSC9/akLxUjKqHLeOb
        wdX/xFeR8mNuhyCt1rz3Eog=
X-Google-Smtp-Source: ABdhPJyRyKjKhx2kwNZsHqMThRsW2PKIRtmopjtFqnSqnMJyqNY2TapErQLK8sXasFbCVL+u1fIdRA==
X-Received: by 2002:a63:4b1e:0:b0:3a3:9226:594c with SMTP id y30-20020a634b1e000000b003a39226594cmr10073035pga.5.1650286614880;
        Mon, 18 Apr 2022 05:56:54 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 73-20020a63064c000000b003a216524089sm11358212pgg.57.2022.04.18.05.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 05:56:54 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/3] dt-bindings: clk: sprd: Add bindings for ums512 clock controller
Date:   Mon, 18 Apr 2022 20:56:28 +0800
Message-Id: <20220418125630.2342538-2-gengcixi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220418125630.2342538-1-gengcixi@gmail.com>
References: <20220418125630.2342538-1-gengcixi@gmail.com>
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

Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 .../bindings/clock/sprd,ums512-clk.yaml       | 112 ++++++++++++++++++
 1 file changed, 112 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml

diff --git a/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
new file mode 100644
index 000000000000..89824d7c6be4
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2022 Unisoc Inc.
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/clock/sprd,ums512-clk.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: UMS512 Clock Control Unit Device Tree Bindings
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+properties:
+  "#clock-cells":
+    const: 1
+
+  compatible:
+    oneOf:
+      - items:
+          - const: sprd,ums512-glbregs
+          - const: syscon
+          - const: simple-mfd
+      - items:
+          - enum:
+              - sprd,ums512-apahb-gate
+              - sprd,ums512-ap-clk
+              - sprd,ums512-aonapb-clk
+              - sprd,ums512-pmu-gate
+              - sprd,ums512-g0-pll
+              - sprd,ums512-g2-pll
+              - sprd,ums512-g3-pll
+              - sprd,ums512-gc-pll
+              - sprd,ums512-aon-gate
+              - sprd,ums512-audcpapb-gate
+              - sprd,ums512-audcpahb-gate
+              - sprd,ums512-gpu-clk
+              - sprd,ums512-mm-clk
+              - sprd,ums512-mm-gate-clk
+              - sprd,ums512-apapb-gate
+
+  clocks:
+    minItems: 1
+    description: |
+      The input parent clock(s) phandle for this clock, only list fixed
+      clocks which are declared in devicetree.
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
+
+if:
+  properties:
+    compatible:
+      enum:
+        - sprd,ums512-ap-clk
+        - sprd,ums512-aonapb-clk
+        - sprd,ums512-mm-clk
+then:
+  required:
+    - reg
+
+else:
+  description: |
+    Other UMS512 clock nodes should be the child of a syscon node in
+    which compatible string should be:
+            "sprd,ums512-glbregs", "syscon", "simple-mfd"
+
+    The 'reg' property for the clock node is also required if there is a sub
+    range of registers for the clocks.
+
+additionalProperties: true
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
+
+  - |
+    ap_apb_regs: syscon@71000000 {
+      compatible = "sprd,ums512-glbregs", "syscon", "simple-mfd";
+      reg = <0x71000000 0x3000>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+      #clock-cells = <1>;
+      ranges = <0 0x71000000 0x3000>;
+
+      apahb_gate: clock-controller@0 {
+        compatible = "sprd,ums512-apahb-gate";
+        reg = <0x0 0x2000>;
+        #clock-cells = <1>;
+      };
+    };
+
+...
-- 
2.25.1


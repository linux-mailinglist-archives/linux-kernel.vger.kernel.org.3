Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACAD500D5C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243297AbiDNMag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243300AbiDNMaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:30:14 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C8190CCE;
        Thu, 14 Apr 2022 05:27:23 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id s137so4657105pgs.5;
        Thu, 14 Apr 2022 05:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c3EanACHaC/nlOtTjx3gdJ53FihM7PgGzOgcD5vC+kI=;
        b=PoeieKCwUgWi87wRiZJD1WASjVVqwZiAyNToXIDHguyXuVYvvHLrF0hZPajWjCVtKa
         gDrSOquFqMxxaLC0U7t/G41zL2zYlpyqHyUUY1Xek1gsFHBwv4cFdaDMcmNlUpNCladD
         ehlR0G2NBdCW303U3UiElMKzacUZcI9k+KOx0eA62MANZ+zBxBSl8BGu6w2YRe7di4yQ
         w4fgQHpEI7cJXQ4j3z9KOxnyQQqbPooSMB2/Q8IatEiFdv/IsoXzpCJtMkVdogX+G9IM
         28iycYsIGTnFbnH3PheGFpAAYjwYPC1jVYnOh91DZV1ppakBjAtBlZteNiPB9M8fT05v
         +bjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c3EanACHaC/nlOtTjx3gdJ53FihM7PgGzOgcD5vC+kI=;
        b=UgyaWFhSandzJRwtI6TTJ0XMp+RxeNpB0vDHyvibYoRBIyvwktNDXJESxioMttjLQs
         UKdm0mWgavr+dnu6jA8thdiAPrctZ3NkzCxjtX0aD8yzqnHtcMEY9xusopDwnKjy0mjl
         T2rFbykTD7ouhlko5RzDENzosFFIqvY+uulHkyNrGWmjhHwroRnsO4Vqe9wE3FG4YdyQ
         6TQxexqezBCwgjc2FqLdr94shW+WhDbGnfUnDW5k9/2tmJ5t2CdshuvPS7UiZ2jDElBy
         wwlf27NhvXuctvrf6+pbCZDjHGUrYY298bDFb2f2CW+mstDRbtLSsAYTWFS6sZKCUKaW
         KZTA==
X-Gm-Message-State: AOAM530LxAzDxCVBWmesFdhmUUhsx3GBzi1DuMDq0f3UDISaLim0rEUV
        MjTzvpbaxGLtwo9hDcfzspkJkEdyl+c=
X-Google-Smtp-Source: ABdhPJziuQABLthtWfVKqLnH/Hojek3liQ1ZFG3IAevh8ht2idmcBnpXIjBCCipMzFNaiLbrtpkCOQ==
X-Received: by 2002:a63:6984:0:b0:398:8db9:7570 with SMTP id e126-20020a636984000000b003988db97570mr2044366pgc.373.1649939242873;
        Thu, 14 Apr 2022 05:27:22 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id pi2-20020a17090b1e4200b001c7b15928e0sm6265826pjb.23.2022.04.14.05.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 05:27:22 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/3] dt-bindings: clk: sprd: Add bindings for ums512 clock controller
Date:   Thu, 14 Apr 2022 20:26:55 +0800
Message-Id: <20220414122657.526406-2-gengcixi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220414122657.526406-1-gengcixi@gmail.com>
References: <20220414122657.526406-1-gengcixi@gmail.com>
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
 .../bindings/clock/sprd,ums512-clk.yaml       | 108 ++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml

diff --git a/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
new file mode 100644
index 000000000000..518c51d621c3
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
@@ -0,0 +1,108 @@
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
+    items:
+      - enum:
+        - sprd,ums512-apahb-gate
+        - sprd,ums512-ap-clk
+        - sprd,ums512-aonapb-clk
+        - sprd,ums512-pmu-gate
+        - sprd,ums512-g0-pll
+        - sprd,ums512-g2-pll
+        - sprd,ums512-g3-pll
+        - sprd,ums512-gc-pll
+        - sprd,ums512-aon-gate
+        - sprd,ums512-audcpapb-gate
+        - sprd,ums512-audcpahb-gate
+        - sprd,ums512-gpu-clk
+        - sprd,ums512-mm-clk
+        - sprd,ums512-mm-gate-clk
+        - sprd,ums512-apapb-gate
+      - const: sprd,ums512-glbregs
+      - const: syscon
+      - const: simple-mfd
+
+  clocks:
+    minItems: 1
+    maxItems: 4
+    description: |
+      The input parent clock(s) phandle for this clock, only list fixed
+      clocks which are declared in devicetree.
+
+  clock-names:
+    minItems: 1
+    maxItems: 4
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
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        ap_clk: clock-controller@20200000 {
+                compatible = "sprd,ums512-ap-clk";
+                reg = <0 0x20200000 0 0x1000>;
+                clocks = <&ext_26m>;
+                clock-names = "ext-26m";
+                #clock-cells = <1>;
+        };
+
+        syscon@20100000{
+               compatible = "sprd,ums512-glbregs", "syscon","simple-mfd";
+               reg = <0 0x20100000 0 0x4000>;
+               clocks = <&ext_32k>, <&ext_26m>;
+               clock-names = "ext-32k", "ext-26m";
+               #clock-cells = <1>;
+        };
+    };
+...
-- 
2.25.1


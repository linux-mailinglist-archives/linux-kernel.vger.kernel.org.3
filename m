Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67A04F9344
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 12:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbiDHKsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiDHKsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:48:01 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0307433761C;
        Fri,  8 Apr 2022 03:45:59 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id z16so8056395pfh.3;
        Fri, 08 Apr 2022 03:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B+y9O7YBtL9hDUsmV9qnq8IDPIYek1TEN2GRHOTz3g4=;
        b=qoqbOn292okenjH4dD/yS4XaKvgDIJY5ldJEkv6XLn4lVxXvLjMdg2SjBw9llwNxVG
         8mK0mwhynt3ihKUHU1FuvkqJwJ3H5tGmpifKYvFf8ejUD4UY6kPw3Cu7MrmK2vVQZa93
         43O/T4KXxH2h9Or+4Tss1KW1UxUW4/6qfwpw4jAGOk+tIFgeLGSJIZBXTuS+1jzJbxPV
         brTNWG4oqiCaWOioNXFFM1sSmB/UP3R/vdLT9NugMVNAyFuSzhnQJjrG2jgHto8fW+69
         8/8FXl3dt6O7/JIA++fuYMK+dRlli61QJYDM1CR7MjyWwSCfbwci4h0h3RynUNyynRKW
         lcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B+y9O7YBtL9hDUsmV9qnq8IDPIYek1TEN2GRHOTz3g4=;
        b=JKHo5i7700EMDlyzSkf9mjfAE4KWcSO9rqUHJAZkAdXpwj0gw/mMKV72Y9aljEBHGz
         a5bhiQgiJg173cn1+q/gjZWoU8lCVkIE+fVg653DfTLnldnvkCZnhynBVayqFGbvuSCQ
         P/Is23LBsKwWiCoLX/o3EZ4dA51czA/hTpt9c8mmOoAZy7O1CqCsxRyzcWcj4XNvBz/v
         F86CTRRG/miRxGwZOF9ZYgNO3/+gd1hsS3a+l801XypTHnHXNXRsmXuEUT5OjxFQtGae
         pSXNnk2C6r/YOEnnB+Z5+qJIapS+COM3ZJv5R1z1aqYKRgViGaML/dV8OhyyLsMZPJwz
         QUew==
X-Gm-Message-State: AOAM530WPJVt4fwpBUE0rtOVevS7uFpkj1CLu/+mHNiwAWuZ3usdD7Sc
        OAE2VEmSyttG1ZSP64ZHL+w=
X-Google-Smtp-Source: ABdhPJxEK4D6xs1b3TDJapTXT/xSOcY9IFlWQJQ419VRYJBDhw9q2QDA8arWGO9D07QCBMSDbQFFdg==
X-Received: by 2002:a63:1c5c:0:b0:398:f69b:1996 with SMTP id c28-20020a631c5c000000b00398f69b1996mr15007543pgm.370.1649414758351;
        Fri, 08 Apr 2022 03:45:58 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id m17-20020a17090a859100b001bc20ddcc67sm11184902pjn.34.2022.04.08.03.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 03:45:57 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: clk: sprd: add bindings for ums512 clock controller
Date:   Fri,  8 Apr 2022 18:45:18 +0800
Message-Id: <20220408104520.1896568-2-gengcixi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220408104520.1896568-1-gengcixi@gmail.com>
References: <20220408104520.1896568-1-gengcixi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cixi Geng <cixi.geng1@unisoc.com>

add a new bindings to describe ums512 clock compatible string.

Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 .../bindings/clock/sprd,ums512-clk.yaml       | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml

diff --git a/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
new file mode 100644
index 000000000000..a80bd6ca4a7a
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
@@ -0,0 +1,100 @@
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
+    enum:
+      - sprd,ums512-aon-gate
+      - sprd,ums512-apahb-gate
+      - sprd,ums512-apapb-gate
+      - sprd,ums512-audcpahb-gate
+      - sprd,ums512-audcpapb-gate
+      - sprd,ums512-g0-pll
+      - sprd,ums512-g2-pll
+      - sprd,ums512-g3-pll
+      - sprd,ums512-gc-pll
+      - sprd,ums512-gpu-clk
+      - sprd,ums512-mm-clk
+      - sprd,ums512-mm-gate-clk
+      - sprd,ums512-pmu-gate
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


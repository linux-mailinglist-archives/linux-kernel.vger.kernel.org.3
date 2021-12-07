Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361C246BDB7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237829AbhLGOc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 09:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237891AbhLGOcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:32:03 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83F7C061574;
        Tue,  7 Dec 2021 06:28:32 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id v19so9543398plo.7;
        Tue, 07 Dec 2021 06:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/nNkUI+dH8AtxQEgxzy9cBX4XHXv2DfxTs/bgyz0Ark=;
        b=lx9iBywff8VfOzI76zIp/g2B+P5si5t69INRhDOYymGRLhut0DM2oaUboYscNuLjVs
         FknNw68absaRu0H87arX4cGLRyIWNWsFong3fm6GYmsP8Z4rzIaQlNRM6tt1LbLMviRj
         KsPeZXaJO8HW1BaNaJsSnx8hGttkaZWgc4GaAjQjB9SWA38sAfrnh3i0eLLz5KXYCqz0
         RJjzFC1cCrPgPgxCm7Q0M2gZ3l3Y3/kWUnkbX5S+Izn7uz7HulmFkTQ5zfVAY+Ep1YHy
         qC1Aeu73Y7ntJIFbr3uwFnWZwyETWE9SPnyQDxGhnVtWIW9BubpSbPXLtHcKYydc2SD/
         RlyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/nNkUI+dH8AtxQEgxzy9cBX4XHXv2DfxTs/bgyz0Ark=;
        b=PS7wSvvvLoqJMW3f3zsSgHpkEretKkLwD1QdbGMf1wh57bMc8ffG2aoJ6pxxUGtj5N
         dhmpIqCbDlh4Rg/pYVh3Zp7VRkiG7Q9kGIwZr3zs+8d50GYchgOuM31Eodu18yiri+nF
         ZQW5hWIxz/NdLOuIMcAjjkQy8FNFBD0M4NHoQS0DSXIACiKdK/JF1YUWB8exEN7lZYr5
         s7sKpKSYr7G6N7I+NEi61sp7+yEFTyO/Ch1X4FG6pfDXNfuAfU9uCXyEKWHtd3cF5mC9
         Qg8SE45CtQYCFsGasoqOMBYBUrfj77T0VYcK40HRVQA34VdmqBc7/qFWXvK7Y2Gksmzy
         ecTg==
X-Gm-Message-State: AOAM533CMMBs7v/zPW3GmZIXdMYTIg96fHNf73yDWB09yEgQqpGLQn9y
        lGEtARIbngfe4zrW6w329NA=
X-Google-Smtp-Source: ABdhPJxoKOxNTmfxKJet/zL+gef2s7B1z7k9gSMsGLGmv69RwwdeTdPgous4DJuQZXX3/wZ5i/RdKA==
X-Received: by 2002:a17:90b:4f45:: with SMTP id pj5mr7130302pjb.70.1638887312577;
        Tue, 07 Dec 2021 06:28:32 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([103.6.5.6])
        by smtp.gmail.com with ESMTPSA id d20sm16373247pfl.88.2021.12.07.06.28.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Dec 2021 06:28:32 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, kevin3.tang@gmail.com,
        pony1.wu@gmail.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v8 5/6] dt-bindings: display: add Unisoc's mipi dsi controller bindings
Date:   Tue,  7 Dec 2021 22:27:16 +0800
Message-Id: <20211207142717.30296-6-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211207142717.30296-1-kevin3.tang@gmail.com>
References: <20211207142717.30296-1-kevin3.tang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Tang <kevin.tang@unisoc.com>

Adds MIPI DSI Controller
support for Unisoc's display subsystem.

v5:
  - Remove panel_in port for dsi node.

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../display/sprd/sprd,sharkl3-dsi-host.yaml   | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml

diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
new file mode 100644
index 000000000..bc5594d18
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/sprd/sprd,sharkl3-dsi-host.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Unisoc MIPI DSI Controller
+
+maintainers:
+  - Kevin Tang <kevin.tang@unisoc.com>
+
+properties:
+  compatible:
+    const: sprd,sharkl3-dsi-host
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 2
+
+  clocks:
+    minItems: 1
+
+  clock-names:
+    items:
+      - const: clk_src_96m
+
+  power-domains:
+    maxItems: 1
+
+  ports:
+    type: object
+
+    properties:
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+      port@0:
+        type: object
+        description:
+          A port node with endpoint definitions as defined in
+          Documentation/devicetree/bindings/media/video-interfaces.txt.
+          That port should be the input endpoint, usually coming from
+          the associated DPU.
+
+    required:
+      - "#address-cells"
+      - "#size-cells"
+      - port@0
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/sprd,sc9860-clk.h>
+    dsi: dsi@63100000 {
+        compatible = "sprd,sharkl3-dsi-host";
+        reg = <0x63100000 0x1000>;
+        interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>,
+          <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+        clock-names = "clk_src_96m";
+        clocks = <&pll CLK_TWPLL_96M>;
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            port@0 {
+                reg = <0>;
+                dsi_in: endpoint {
+                    remote-endpoint = <&dpu_out>;
+                };
+            };
+        };
+    };
-- 
2.29.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29674ADF52
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 18:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384086AbiBHRTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 12:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383765AbiBHRT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 12:19:26 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FCDC0613C9
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 09:19:25 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1F80940052
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 17:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644340764;
        bh=kMaTNaBI2iO4IYdjvaEgTk0fgCfiFl3MO+VYGfyVvmE=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=S8YUe039q0V1YHkmtynFNIq+AVYiyRPZRKPsc4cX0Wql8lXdj56wkiWRzxBA//XjA
         u6eIfs63mdd8r46ODSZRRV0nsOs1NwADKjFq5hsUgbtY/6q+C/N2lSa3xVx6ZVBvM8
         4292xgIwkOBZcgelQtcRg40B+WgCEiB2Y0Ac5nn8RmWrO4u2Bam2ECb/ky6OFXFiXe
         kEjTWhFr3kuDdRbEus/d8gatLLVKwAWBT2Uz5tQ2GcztMzUOLp2lkl7+f19ly2Icdg
         cd0LTOys6T89DJIMgmpI1/euGHvTXTrCN2CR84mj9VJFUXvVFLLEKNMw8iVj9XbfWy
         AYhPpzCx3OWtw==
Received: by mail-ej1-f72.google.com with SMTP id 13-20020a170906328d00b006982d0888a4so5990471ejw.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 09:19:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kMaTNaBI2iO4IYdjvaEgTk0fgCfiFl3MO+VYGfyVvmE=;
        b=P8TTCsQFxUSfcLKTmd6ylXlwsCMjPzi7RzK4ZMnX9CGhVsBdb7KsdIZeAx2CXcmxrn
         oFuZmbcMm+ZJx8XKFwfbvBAzWu0wiZEOLHHQ1vvkVnkrHQvGKPJ80NSizn2wmIzNKB11
         eCHi94kdK9gIOv37RVtwyk7Ubdx3Lk0pcJoD/3omhaf45ut8WHFaKV2Tjrn+4rIvNi0k
         xVp2ingz/I73RmnIAsCKr2qVTw+Zee5f7e3NQ74ZWIt4BmKgzQz1cIOfc0DrTeYznpZO
         vgmKCMzhjQaX8+pikRdLc5/VIHCF5/o68394rZWIcbWTz51bRTkjkXooTddUhzTdKM1A
         wj5w==
X-Gm-Message-State: AOAM531jEC6a1lPJRYGZcIwv80SM2txCB9Q3EesLnVMqE/EdytTopRaa
        i2HF7gXzhhK8A6US2fHILlau28tKPdoDhY8MqW9a0bBKIA3s2mBDQwwXF38qxx6Tqpjfxpx82tV
        iNTECXq8SeQLzPwPkFWHTcbXSDO3FCdK/WAZrWir0bw==
X-Received: by 2002:aa7:d809:: with SMTP id v9mr5652415edq.2.1644340763449;
        Tue, 08 Feb 2022 09:19:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwlLGYgUd+Cr4yCQlVE0VWHIHMy+r8JCbb5AQJa47VNi9iyYKn2B1Q1E+kn15abkGcHd22WRg==
X-Received: by 2002:aa7:d809:: with SMTP id v9mr5652400edq.2.1644340763212;
        Tue, 08 Feb 2022 09:19:23 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id r10sm5125550ejy.148.2022.02.08.09.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 09:19:22 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH 09/10] dt-bindings: display: samsung,exynos5433-mic: convert to dtschema
Date:   Tue,  8 Feb 2022 18:18:22 +0100
Message-Id: <20220208171823.226211-10-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220208171823.226211-1-krzysztof.kozlowski@canonical.com>
References: <20220208171823.226211-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Exynos5433 MIC bindings to DT schema format.

The conversion includes also updates to the bindings, matching the
current DTS and Linux driver: adding optional power-domains.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/display/exynos/exynos-mic.txt    | 51 ----------
 .../samsung/samsung,exynos5433-mic.yaml       | 95 +++++++++++++++++++
 2 files changed, 95 insertions(+), 51 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/exynos/exynos-mic.txt
 create mode 100644 Documentation/devicetree/bindings/display/samsung/samsung,exynos5433-mic.yaml

diff --git a/Documentation/devicetree/bindings/display/exynos/exynos-mic.txt b/Documentation/devicetree/bindings/display/exynos/exynos-mic.txt
deleted file mode 100644
index 0fba2ee6440a..000000000000
--- a/Documentation/devicetree/bindings/display/exynos/exynos-mic.txt
+++ /dev/null
@@ -1,51 +0,0 @@
-Device-Tree bindings for Samsung Exynos SoC mobile image compressor (MIC)
-
-MIC (mobile image compressor) resides between decon and mipi dsi. Mipi dsi is
-not capable to transfer high resoltuion frame data as decon can send. MIC
-solves this problem by compressing the frame data by 1/2 before it is
-transferred through mipi dsi. The compressed frame data must be uncompressed in
-the panel PCB.
-
-Required properties:
-- compatible: value should be "samsung,exynos5433-mic".
-- reg: physical base address and length of the MIC registers set and system
-       register of mic.
-- clocks: must include clock specifiers corresponding to entries in the
-	  clock-names property.
-- clock-names: list of clock names sorted in the same order as the clocks
-	       property. Must contain "pclk_mic0", "sclk_rgb_vclk_to_mic0".
-- samsung,disp-syscon: the reference node for syscon for DISP block.
-- ports: contains a port which is connected to decon node and dsi node.
-	 address-cells and size-cells must 1 and 0, respectively.
-- port: contains an endpoint node which is connected to the endpoint in the
-	decon node or dsi node. The reg value must be 0 and 1 respectively.
-
-Example:
-SoC specific DT entry:
-mic: mic@13930000 {
-	compatible = "samsung,exynos5433-mic";
-	reg = <0x13930000 0x48>;
-	clocks = <&cmu_disp CLK_PCLK_MIC0>,
-	       <&cmu_disp CLK_SCLK_RGB_VCLK_TO_MIC0>;
-	clock-names = "pclk_mic0", "sclk_rgb_vclk_to_mic0";
-	samsung,disp-syscon = <&syscon_disp>;
-
-	ports {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		port@0 {
-			reg = <0>;
-			mic_to_decon: endpoint {
-				remote-endpoint = <&decon_to_mic>;
-			};
-		};
-
-		port@1 {
-			reg = <1>;
-			mic_to_dsi: endpoint {
-				remote-endpoint = <&dsi_to_mic>;
-			};
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/display/samsung/samsung,exynos5433-mic.yaml b/Documentation/devicetree/bindings/display/samsung/samsung,exynos5433-mic.yaml
new file mode 100644
index 000000000000..01fccb138ebd
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/samsung/samsung,exynos5433-mic.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/samsung/samsung,exynos5433-mic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos5433 SoC Mobile Image Compressor (MIC)
+
+maintainers:
+  - Inki Dae <inki.dae@samsung.com>
+  - Joonyoung Shim <jy0922.shim@samsung.com>
+  - Seung-Woo Kim <sw0312.kim@samsung.com>
+  - Kyungmin Park <kyungmin.park@samsung.com>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+description: |
+  MIC (Mobile Image Compressor) resides between DECON and MIPI DSI. MIPI DSI is
+  not capable of transferring high resoltuion frame data as DECON can send. MIC
+  solves this problem by compressing the frame data by 1/2 before it is
+  transferred through MIPI DSI. The compressed frame data must be uncompressed
+  in the panel PCB.
+
+properties:
+  compatible:
+    const: samsung,exynos5433-mic
+
+  clocks:
+    minItems: 2
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: pclk_mic0
+      - const: sclk_rgb_vclk_to_mic0
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    description:
+      Contains a port which is connected to mic node.
+
+  power-domains:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  samsung,disp-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to DISP system controller interface.
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - ports
+  - reg
+  - samsung,disp-syscon
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/exynos5433.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    image-processor@13930000 {
+        compatible = "samsung,exynos5433-mic";
+        reg = <0x13930000 0x48>;
+        clocks = <&cmu_disp CLK_PCLK_MIC0>,
+                 <&cmu_disp CLK_SCLK_RGB_VCLK_TO_MIC0>;
+        clock-names = "pclk_mic0",
+                      "sclk_rgb_vclk_to_mic0";
+        power-domains = <&pd_disp>;
+        samsung,disp-syscon = <&syscon_disp>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                mic_to_decon: endpoint {
+                    remote-endpoint = <&decon_to_mic>;
+                };
+            };
+
+            port@1 {
+                reg = <1>;
+                mic_to_dsi: endpoint {
+                    remote-endpoint = <&dsi_to_mic>;
+                };
+            };
+        };
+    };
-- 
2.32.0


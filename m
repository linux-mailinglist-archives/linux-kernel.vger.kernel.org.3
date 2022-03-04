Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E168D4CD8ED
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240730AbiCDQQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235671AbiCDQQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:16:16 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108951B8CB4
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 08:15:28 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id e24so431217wrc.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 08:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Nqj3Wj2afL4vH+AWQbMmnZZbmdqpSeJYR5BS2/Kv0Y=;
        b=OOS1o/jw7tYZCPMkqoGNeane3XqwRqfkrZVcw7gh/2d4grjXT+DEjE7qawH3IEvUOS
         KjJIsANa0cft/ebHmTMCPxTg0ND7PA5GXVbZpkAe9fWpLNJfkhz6iIBNBFMXYmLaNMfo
         fonMddZ/xVAAAyHlU1wySfS63mLMTTTK6gZ3mCbX4nmmBeaccJd6X2bsfzS2nYoP1EbR
         GrTAnaJ3qvyV9Y4woTsVIZsMYMF/znKif6xNvdbWnqb6M8tvluHkNcrdL1SUlDv1ODmP
         bRXLomEr0uYQBtlHOnZnz4TdVhWoqzw0Q8fn9jyOvof+Sk/VHY0zASNZJSABovJTPT19
         F2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Nqj3Wj2afL4vH+AWQbMmnZZbmdqpSeJYR5BS2/Kv0Y=;
        b=BB8zHwz8KcJ/CBAfg+FuVF/DqhossOAD4ji7kZADE5VhzKwLE4ueMobQd5ClOn7Cs1
         qJiwLuaDQ3g9+16YFK4AbwK1xsC/WqD2jwCaEIAxQAL4+E5mAdQUbgYrPN9e84CSecfX
         gb3lHTsilE6uy3U904Kx6kO+d4IQLCPZ5lg6otnXgHXfTHDqQMioxOBNXisZNckAg0nF
         Y/OsjTj4E3ndKdoaCGTa5l1gezWtRjmBgd1+XP32VOZl6mZxAxEJg22jBWXGAkIj4abe
         SGggcGlzs47TE+1APGcR47j81rxkDrYzl4xrO2zautPK38UQHxy+ITCFhppFQROM6aJZ
         vdkg==
X-Gm-Message-State: AOAM5339sS2Q/z+IWkfro2DE9TmoIFENVsTy8oOKIq/kIB17HiwLtjbf
        oEMtOx9z3XsA3n8XE8u8GE4d4A==
X-Google-Smtp-Source: ABdhPJzNkPllUg3CGamJ/9qQ6VEA0o7v+Nic7Ku68JBY2CRMOsrZPqCMPRFONhuaEBXE9kW5K1f9Fw==
X-Received: by 2002:a05:6000:186d:b0:1e8:49fc:69ce with SMTP id d13-20020a056000186d00b001e849fc69cemr30513168wri.80.1646410526620;
        Fri, 04 Mar 2022 08:15:26 -0800 (PST)
Received: from xps-9300.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g6-20020a5d5406000000b001f049726044sm4937307wrv.79.2022.03.04.08.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 08:15:26 -0800 (PST)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, robh+dt@kernel.or
Cc:     matthias.bgg@gmail.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        stephane.leprovost@mediatek.com, khilman@baylibre.com,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v4 1/7] dt bindings: remoteproc: Add bindings for the MT8183 APU
Date:   Fri,  4 Mar 2022 17:15:08 +0100
Message-Id: <20220304161514.994128-2-abailon@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220304161514.994128-1-abailon@baylibre.com>
References: <20220304161514.994128-1-abailon@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds dt bindings for the APU present in the MT8183.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 .../bindings/remoteproc/mtk,apu.yaml          | 122 ++++++++++++++++++
 1 file changed, 122 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,apu.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,apu.yaml b/Documentation/devicetree/bindings/remoteproc/mtk,apu.yaml
new file mode 100644
index 000000000000..b640aa96d678
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/mtk,apu.yaml
@@ -0,0 +1,122 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+
+---
+$id: "http://devicetree.org/schemas/remoteproc/mtk,apu.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Mediatek AI Processor Unit (APU)
+
+description:
+  This document defines the binding for the APU, a co-processor that could
+  offload the CPU for machine learning and neural network.
+
+maintainers:
+  - Alexandre Bailon <abailon@bayLibre.com>
+
+properties:
+  compatible:
+    const: mediatek,mt8183-apu
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 3
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: axi
+      - const: ipu
+      - const: jtag
+
+  iommus:
+    maxItems: 3
+
+  memory-region:
+    maxItems: 3
+
+  memory-region-da:
+    description:
+      Array of APU device address. This is used to map the APU device address
+      to a physical address.
+    maxItems: 3
+
+  power-domains:
+    maxItems: 1
+
+  pinctrl:
+    description: pinctrl handles, required to configure pins for JTAG.
+
+  pinctrl-names:
+    items:
+      - const: jtag
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - iommus
+  - memory-region
+  - memory-region-da
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8183-clk.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/memory/mt8183-larb-port.h>
+    #include <dt-bindings/power/mt8183-power.h>
+
+    reserved-memory {
+      #address-cells = <1>;
+      #size-cells = <1>;
+      ranges;
+
+      vdev0buffer: vdev0buffer@52900000 {
+        compatible = "shared-dma-pool";
+        reg = <0x52900000 0x4000>;
+        no-map;
+      };
+
+      vdev0vring0: vdev0vring0@52904000 {
+        compatible = "shared-dma-pool";
+        reg = <0x52904000 0x2000>;
+        no-map;
+      };
+
+      vdev0vring1: vdev0vring1@52906000 {
+        compatible = "shared-dma-pool";
+        reg = <0x52906000 0x2000>;
+        no-map;
+      };
+    };
+
+    apu0: apu@19100000 {
+      compatible = "mediatek,mt8183-apu";
+      reg = <0x19180000 0x14000>;
+      interrupts = <GIC_SPI 292 IRQ_TYPE_LEVEL_LOW>;
+
+      iommus = <&iommu M4U_PORT_IMG_IPUO>,
+         <&iommu M4U_PORT_IMG_IPU3O>,
+         <&iommu M4U_PORT_IMG_IPUI>;
+
+      clocks = <&ipu_core0 CLK_IPU_CORE0_AXI>,
+         <&ipu_core0 CLK_IPU_CORE0_IPU>,
+         <&ipu_core0 CLK_IPU_CORE0_JTAG>;
+
+      clock-names = "axi", "ipu", "jtag";
+
+      power-domains = <&scpsys MT8183_POWER_DOMAIN_VPU_CORE0>;
+      memory-region = <&vdev0buffer>, <&vdev0vring0>, <&vdev0vring1>;
+      memory-region-da = <0x6fff8000>, <0x6fffc000>, <0x6fffe000>;
+    };
+...
-- 
2.34.1


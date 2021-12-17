Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575A647922E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239509AbhLQQ73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236035AbhLQQ7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:59:25 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F40C061574;
        Fri, 17 Dec 2021 08:59:25 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id s1so5308603wrg.1;
        Fri, 17 Dec 2021 08:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n50XPIjlROmdpqTND1KrzUG6N3eU7uscwN5ADZRFYWE=;
        b=fgoapQ9eZodQi0HD7+mkYJNWsF5XplxwTuJJfJn6eaVjHkf6Ospz0OGLi5yAL9iFAD
         9bqxz5kxiT4stXQoUM7Xoxxn0uSiMWcXJYoX4EDrskzF1HJKpWdTYJu4MIu63GAM7afX
         Rb/tsNut9CZQQHVIAVnnluJjieyP7laZFraaAPhqpb4IjfUU1hLT3VOOM33aMyBZjyNO
         EpaMfSbhz9kImUvUzM8NB2ZEpyTcFybRQNo2JseDC+/vl7i8S8hUKDrTpoDObyXoEARO
         vvwbZldmLeOd75GPxEOW33ryEwHBZ676VsqOR6eL4hzlNu5fQr0tql+3NV1TvtVCm2Qj
         /RXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n50XPIjlROmdpqTND1KrzUG6N3eU7uscwN5ADZRFYWE=;
        b=zZgtFkkzmKcHXdQzy+Q2WKogSZgScpqIEDgkbMjGVwBd39w2xi/OHLIU0uwAtHmiTs
         G2VDuxFCmCLjej1xuVT8ja0VjgcKsz6N9vHIrMYia0WY92XtH0VCegO9Xz2sWu8syhx0
         P7y7RbAakgRGYFB/XOK07uap1HAvAxZDYDAb1dMtdbQ6TlIVpFpE4tHMxOwUQvA6BclT
         16dV4ej4MQKTCrSz69UitFFeX89NdXuxp4RsmNpVVedEt3R9MTOSgFA/ksUU2fR1L2pc
         Ly3jfu16T3kfpYHUX8tv8Sb7tYXuZOqcnUJVhhcNHdT8UpujKd7GUqvW3MQZ1YXSkDP8
         mRfQ==
X-Gm-Message-State: AOAM532l3u4QU3Lm+cDBNOJrO6dfrmwOFoLGGg5uSSg8R+nG/4XfE7pQ
        odw6Zbecv+CObMx9v5e0sFI=
X-Google-Smtp-Source: ABdhPJzZDUEiZZB5XMPnHzCxrBYkIN2mtMwCwQFOvhjnWuSpuMksMJFVoORXs6O6eLpFJW1CdnalIA==
X-Received: by 2002:a5d:604e:: with SMTP id j14mr3076097wrt.119.1639760363678;
        Fri, 17 Dec 2021 08:59:23 -0800 (PST)
Received: from localhost ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id a10sm12440291wmq.27.2021.12.17.08.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 08:59:23 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] dt-bindings: memory: Add Tegra210 memory controller bindings
Date:   Fri, 17 Dec 2021 17:59:16 +0100
Message-Id: <20211217165919.2700920-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217165919.2700920-1-thierry.reding@gmail.com>
References: <20211217165919.2700920-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Document the bindings for the memory controller found on Tegra210 SoCs.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../nvidia,tegra210-mc.yaml                   | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra210-mc.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra210-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra210-mc.yaml
new file mode 100644
index 000000000000..ef21c11052e3
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra210-mc.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/nvidia,tegra210-mc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra210 SoC Memory Controller
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+  - Jon Hunter <jonathanh@nvidia.com>
+
+description: |
+  The NVIDIA Tegra210 SoC features a 64 bit memory controller that is split into two 32 bit
+  channels to support LPDDR3 and LPDDR4 with x16 subpartitions. The MC handles memory requests for
+  34-bit virtual addresses from internal clients and arbitrates among them to allocate memory
+  bandwidth.
+
+  Up to 8 GiB of physical memory can be supported. Security features such as encryption of traffic
+  to and from DRAM via general security apertures are available for video and other secure
+  applications.
+
+properties:
+  $nodename:
+    pattern: "^memory-controller@[0-9a-f]+$"
+
+  compatible:
+    items:
+      - enum:
+          - nvidia,tegra210-mc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: module clock
+
+  clock-names:
+    items:
+      - const: mc
+
+  "#iommu-cells":
+    const: 1
+
+  "#reset-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - "#iommu-cells"
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/tegra210-car.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    mc: memory-controller@70019000 {
+        compatible = "nvidia,tegra210-mc";
+        reg = <0x70019000 0x1000>;
+        interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&tegra_car TEGRA210_CLK_MC>;
+        clock-names = "mc";
+
+        #iommu-cells = <1>;
+        #reset-cells = <1>;
+    };
-- 
2.34.1


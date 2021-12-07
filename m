Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A4D46BDA5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237827AbhLGObt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 09:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237820AbhLGObs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:31:48 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B28C061748;
        Tue,  7 Dec 2021 06:28:18 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 71so14010392pgb.4;
        Tue, 07 Dec 2021 06:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k3VX3I7y9xb7wsw2EFMUi2KX7EoFTuOAW4MR3tKQ32Y=;
        b=D/oGGndHpbKYyz23y3ZctunZPJKbWBzt1/Tf4u1HekEFHrqh4BfhpUT0ACwsI7TXfw
         ftxEZVpbANUg6WaMwScs+FCpTo74OlEYYUhyrZUFpXLVBH8PS4/5FW1J0WW66tBvZWbh
         lpqlVwMJMZ6fjrogHo52takRiFMx2PVzJYfieevtqaY8V7pC/fxJ1NddFpv8rJY5EL2h
         5kfvRre+gRUrvXAc2o1ZRu7Nf+K5Z/FJgzag6GURo3bHzH8ghNpp+ZP0/C1QQcZwmEdT
         TKjEmcLBraTVFGsLeJzAE6kuV6Vw7avkEq8j6GxSsM0jyMxeHGINn3Cw+6U9K7DzK0D6
         LPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k3VX3I7y9xb7wsw2EFMUi2KX7EoFTuOAW4MR3tKQ32Y=;
        b=Xb5GkKe0lT7rmeRtlhdif0qcRss0gEzI0YnAw1KXGF7qn08wDU2w0GnjfnqCuY51QZ
         +Z39knpQvKuoBaJGpu2CYrT4CrMvR9IwGhhyudHf5vSa1AtR6H18WYWUQnwbOrBHh5NO
         dzoFbVfCGLfL86u8FN3Rw5t/1GBfpIWc2EGNHdrmvvwFEHZ/gorZdaxa8teCDfFIbOs2
         7Po/QPtJNCO7yC3D0ZWUw/Wax23IkxYKgxvFZsz8dpRdnHG0SU+AjusRO+b8gi8+5W7K
         p/0TpgBkYQ5SM4MpIOqHb+FSdw/WQnLSssKvck6H7Hn0GszB/ZpxqEOAx1aRAJKISztw
         nYog==
X-Gm-Message-State: AOAM531+oMFHiKZuygKDKLnM6WpIGOLz5UAEtzXWGzkEBjhbNEmjW/Qe
        yCMvOmAvoGWqmx4gNhTQMzM=
X-Google-Smtp-Source: ABdhPJzYCDEsy6w5v+vfJK80BRKAykU8tpWz7FrBnvAf5fGj3sEO0irtTRjkvczLLXlrKrnfsRAooQ==
X-Received: by 2002:a63:8149:: with SMTP id t70mr24020143pgd.2.1638887297908;
        Tue, 07 Dec 2021 06:28:17 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([103.6.5.6])
        by smtp.gmail.com with ESMTPSA id d20sm16373247pfl.88.2021.12.07.06.28.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Dec 2021 06:28:17 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, kevin3.tang@gmail.com,
        pony1.wu@gmail.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v8 3/6] dt-bindings: display: add Unisoc's dpu bindings
Date:   Tue,  7 Dec 2021 22:27:14 +0800
Message-Id: <20211207142717.30296-4-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211207142717.30296-1-kevin3.tang@gmail.com>
References: <20211207142717.30296-1-kevin3.tang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Tang <kevin.tang@unisoc.com>

DPU (Display Processor Unit) is the Display Controller for the Unisoc SoCs
which transfers the image data from a video memory buffer to an internal
LCD interface.

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../display/sprd/sprd,sharkl3-dpu.yaml        | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml

diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml
new file mode 100644
index 000000000..4ebea60b8
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/sprd/sprd,sharkl3-dpu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Unisoc Sharkl3 Display Processor Unit (DPU)
+
+maintainers:
+  - Kevin Tang <kevin.tang@unisoc.com>
+
+description: |
+  DPU (Display Processor Unit) is the Display Controller for the Unisoc SoCs
+  which transfers the image data from a video memory buffer to an internal
+  LCD interface.
+
+properties:
+  compatible:
+    const: sprd,sharkl3-dpu
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+
+  clock-names:
+    items:
+      - const: clk_src_128m
+      - const: clk_src_384m
+
+  power-domains:
+    maxItems: 1
+
+  iommus:
+    maxItems: 1
+
+  port:
+    type: object
+    description:
+      A port node with endpoint definitions as defined in
+      Documentation/devicetree/bindings/media/video-interfaces.txt.
+      That port should be the output endpoint, usually output to
+      the associated DSI.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/sprd,sc9860-clk.h>
+    dpu: dpu@63000000 {
+        compatible = "sprd,sharkl3-dpu";
+        reg = <0x63000000 0x1000>;
+        interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
+        clock-names = "clk_src_128m", "clk_src_384m";
+
+        clocks = <&pll CLK_TWPLL_128M>,
+          <&pll CLK_TWPLL_384M>;
+
+        dpu_port: port {
+            dpu_out: endpoint {
+                remote-endpoint = <&dsi_in>;
+            };
+        };
+    };
-- 
2.29.0


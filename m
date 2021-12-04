Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C239A468750
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 20:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354864AbhLDUBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 15:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352265AbhLDUB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 15:01:28 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54904C061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 11:58:02 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id a18so13358752wrn.6
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 11:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RSJ8rGvZX67933cmw+4RLDbf6BZmksUEJydzASkQ3V0=;
        b=LmU/P33uDD3UHJteDxV9vA0XQRx3PLy+jlTCQ2LhFmwvyH0xVrE9meK/Px7/5Ydvak
         P3/d2MRgWbsbM+PCkY12AxlSissAEWOe7EzYA6YqzziiNYFzLbmLCokpm+2gcMhBpnz0
         MY423fyZUpGCzlSw6OHZ8vZJ5mEJdhPKjuUgCAV6r2945/36vP9Z0aPr36upYuudSeHD
         agE6T+/WAnEEQxIu1TwksnUGp0d3/3kyqCDopm98pITCxNkfMt1MUOwITONCnERNvrK7
         W41wHy0ksfvlPQOhCUxQgDWj2pVxknZ6IEOVJUCAtmoPwtM62E1pP+bYaXGZQrW5k672
         xpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RSJ8rGvZX67933cmw+4RLDbf6BZmksUEJydzASkQ3V0=;
        b=ArrqpRsaXdd9VTz2YXWrENvre6HaR0bEziE3TUTKQ9AMnky8Hr+pQD7TilXp7EIhFM
         W6mYo6fFd69jNUzjkcpwx3WJU9AA84i5Ubj/AmW9gLtGnjj7Iu7tT9fPeEsomAfe0wIy
         ATjBFUgNzfEeBWQR/8MFD2KtTeKTH9aFmFwMtrH7QqZBzO1ACj7fcLOMEwX4WjC3h2FM
         MiN3u2uRPUanZkYLhgKhgD9tXfDkaImWq9HqSied79YYwOAl/hF2W5ezPHSzuY9MmkLy
         GfgL3/0ME1cEhwukSDAVsp1TGxEbMUPt90+4jVoTJEXEtkM3lvEAYuOcL3l+jyltdxLf
         p40Q==
X-Gm-Message-State: AOAM533JZNMuTeP5JSx/pfaErn38XALJFUyjPHeMdLGNP25SpANwkZwm
        7rHRErsHmhdd3seuhFGC14EwleuDtZcYdlV+
X-Google-Smtp-Source: ABdhPJwlBtUOaf3YhiQX4/sZMSpYAUi6d808EdHla+a2pw0KGJu4f+aiw32PhKkQQ0rdpRfCYDSUOQ==
X-Received: by 2002:adf:8165:: with SMTP id 92mr33475250wrm.199.1638647880827;
        Sat, 04 Dec 2021 11:58:00 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id k8sm6252445wrn.91.2021.12.04.11.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 11:58:00 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v3 1/5] dt-bindings: soc: samsung: Add Exynos USI bindings
Date:   Sat,  4 Dec 2021 21:57:53 +0200
Message-Id: <20211204195757.8600-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211204195757.8600-1-semen.protsenko@linaro.org>
References: <20211204195757.8600-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add constants for choosing USIv2 configuration mode in device tree.
Those are further used in USI driver to figure out which value to write
into SW_CONF register. Also document USIv2 IP-core bindings.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v3:
  - Removed usi0 "status" property from the example
  - Made child nodes pattern allow only serial/spi/i2c node names
  - Moved all USIv2 specific properties under corresponding "if:"
  - Renamed compatible from samsung,exynos-usi-v2 to samsung,exynos850-usi
  - Related: submitted separate patch removing warning on
    "make dt_binding_check" for USI bindings

Changes in v2:
  - Combined dt-bindings doc and dt-bindings header patches
  - Added i2c node to example in bindings doc
  - Added mentioning of shared internal circuits
  - Added USI_V2_NONE value to bindings header

 .../bindings/soc/samsung/exynos-usi.yaml      | 159 ++++++++++++++++++
 include/dt-bindings/soc/samsung,exynos-usi.h  |  17 ++
 2 files changed, 176 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
 create mode 100644 include/dt-bindings/soc/samsung,exynos-usi.h

diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
new file mode 100644
index 000000000000..0af4821fae5e
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
@@ -0,0 +1,159 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/samsung/exynos-usi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung's Exynos USI (Universal Serial Interface) binding
+
+maintainers:
+  - Sam Protsenko <semen.protsenko@linaro.org>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+description: |
+  USI IP-core provides selectable serial protocol (UART, SPI or High-Speed I2C).
+  USI shares almost all internal circuits within each protocol, so only one
+  protocol can be chosen at a time. USI is modeled as a node with zero or more
+  child nodes, each representing a serial sub-node device. The mode setting
+  selects which particular function will be used.
+
+  Refer to next bindings documentation for information on protocol subnodes that
+  can exist under USI node:
+
+  [1] Documentation/devicetree/bindings/serial/samsung_uart.yaml
+  [2] Documentation/devicetree/bindings/i2c/i2c-exynos5.txt
+  [3] Documentation/devicetree/bindings/spi/spi-samsung.txt
+
+properties:
+  $nodename:
+    pattern: "^usi@[0-9a-f]+$"
+
+  compatible:
+    enum:
+      - samsung,exynos850-usi   # for USIv2 (Exynos850, ExynosAutoV9)
+
+  reg: true
+
+  clocks: true
+
+  clock-names: true
+
+  ranges: true
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  samsung,sysreg:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      Should be phandle/offset pair. The phandle to System Register syscon node
+      (for the same domain where this USI controller resides) and the offset
+      of SW_CONF register for this USI controller.
+
+  samsung,mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Selects USI function (which serial protocol to use). Refer to
+      <include/dt-bindings/soc/samsung,exynos-usi.h> for valid USI mode values.
+
+  samsung,clkreq-on:
+    type: boolean
+    description:
+      Enable this property if underlying protocol requires the clock to be
+      continuously provided without automatic gating. As suggested by SoC
+      manual, it should be set in case of SPI/I2C slave, UART Rx and I2C
+      multi-master mode. Usually this property is needed if USI mode is set
+      to "UART".
+
+      This property is optional.
+
+patternProperties:
+  # All other properties should be child nodes
+  "^(serial|spi|i2c)@[0-9a-f]+$":
+    type: object
+    description: Child node describing underlying USI serial protocol
+
+required:
+  - compatible
+  - ranges
+  - "#address-cells"
+  - "#size-cells"
+  - samsung,sysreg
+  - samsung,mode
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - samsung,exynos850-usi
+
+then:
+  properties:
+    reg:
+      maxItems: 1
+
+    clocks:
+      items:
+        - description: Bus (APB) clock
+        - description: Operating clock for UART/SPI/I2C protocol
+
+    clock-names:
+      items:
+        - const: pclk
+        - const: ipclk
+
+  required:
+    - reg
+    - clocks
+    - clock-names
+
+else:
+  properties:
+    reg: false
+    clocks: false
+    clock-names: false
+    samsung,clkreq-on: false
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/soc/samsung,exynos-usi.h>
+
+    usi0: usi@138200c0 {
+        compatible = "samsung,exynos850-usi";
+        reg = <0x138200c0 0x20>;
+        samsung,sysreg = <&sysreg_peri 0x1010>;
+        samsung,mode = <USI_V2_UART>;
+        samsung,clkreq-on; /* needed for UART mode */
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+        clocks = <&cmu_peri 32>, <&cmu_peri 31>;
+        clock-names = "pclk", "ipclk";
+
+        serial_0: serial@13820000 {
+            compatible = "samsung,exynos850-uart";
+            reg = <0x13820000 0xc0>;
+            interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&cmu_peri 32>, <&cmu_peri 31>;
+            clock-names = "uart", "clk_uart_baud0";
+            status = "disabled";
+        };
+
+        hsi2c_0: i2c@13820000 {
+            compatible = "samsung,exynosautov9-hsi2c";
+            reg = <0x13820000 0xc0>;
+            interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            clocks = <&cmu_peri 32>, <&cmu_peri 31>;
+            clock-names = "hsi2c_pclk", "hsi2c";
+            status = "disabled";
+        };
+    };
diff --git a/include/dt-bindings/soc/samsung,exynos-usi.h b/include/dt-bindings/soc/samsung,exynos-usi.h
new file mode 100644
index 000000000000..a01af169d249
--- /dev/null
+++ b/include/dt-bindings/soc/samsung,exynos-usi.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2021 Linaro Ltd.
+ * Author: Sam Protsenko <semen.protsenko@linaro.org>
+ *
+ * Device Tree bindings for Samsung Exynos USI (Universal Serial Interface).
+ */
+
+#ifndef __DT_BINDINGS_SAMSUNG_EXYNOS_USI_H
+#define __DT_BINDINGS_SAMSUNG_EXYNOS_USI_H
+
+#define USI_V2_NONE		0
+#define USI_V2_UART		1
+#define USI_V2_SPI		2
+#define USI_V2_I2C		3
+
+#endif /* __DT_BINDINGS_SAMSUNG_EXYNOS_USI_H */
-- 
2.30.2


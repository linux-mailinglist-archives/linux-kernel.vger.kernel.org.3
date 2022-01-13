Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E06148D703
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 12:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbiAML6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 06:58:04 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:49578 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234313AbiAML6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 06:58:02 -0500
Received: from droid11-sz.amlogic.com (10.28.8.21) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.2176.2; Thu, 13 Jan 2022
 19:58:00 +0800
From:   Liang Yang <liang.yang@amlogic.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-clk@vger.kernel.org>
CC:     Liang Yang <liang.yang@amlogic.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 3/4] clk: meson: add DT documentation for emmc clock controller
Date:   Thu, 13 Jan 2022 19:57:44 +0800
Message-ID: <20220113115745.45826-4-liang.yang@amlogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220113115745.45826-1-liang.yang@amlogic.com>
References: <20220113115745.45826-1-liang.yang@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.8.21]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the MMC sub clock controller driver, the potential consumer
of this driver is MMC or NAND. Also add four clock bindings IDs which
provided by this driver.

Signed-off-by: Liang Yang <liang.yang@amlogic.com>
---
 .../bindings/clock/amlogic,mmc-clkc.yaml      | 64 +++++++++++++++++++
 include/dt-bindings/clock/amlogic,mmc-clkc.h  | 14 ++++
 2 files changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.yaml
 create mode 100644 include/dt-bindings/clock/amlogic,mmc-clkc.h

diff --git a/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.yaml
new file mode 100644
index 000000000000..a274c3d5fc2e
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/amlogic,mmc-clkc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic MMC Sub Clock Controller Driver Device Tree Bindings
+
+maintainers:
+  - jianxin.pan@amlogic.com
+  - liang.yang@amlogic.com
+
+properties:
+  compatible:
+    enum:
+      - "amlogic,axg-mmc-clkc", "syscon"
+      - "amlogic,gx-mmc-clkc", "syscon"
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: "clkin0", "clkin1"
+
+  "#clock-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - "#clock-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    sd_mmc_c_clkc: clock-controller@7000 {
+	compatible = "amlogic,axg-mmc-clkc", "syscon";
+	reg = <0x0 0x7000 0x0 0x4>;
+	#clock-cells = <1>;
+
+	clock-names = "clkin0", "clkin1";
+	clocks = <&clkc CLKID_SD_MMC_C_CLK0>,
+		 <&clkc CLKID_FCLK_DIV2>;
+     };
+
+  - |
+    sd_emmc_b_clkc: clock-controller@5000 {
+	compatible = "amlogic,axg-mmc-clkc", "syscon";
+	reg = <0x0 0x5000 0x0 0x4>;
+
+	#clock-cells = <1>;
+	clock-names = "clkin0", "clkin1";
+	clocks = <&clkc CLKID_SD_EMMC_B_CLK0>,
+		 <&clkc CLKID_FCLK_DIV2>;
+    };
+
+...
\ No newline at end of file
diff --git a/include/dt-bindings/clock/amlogic,mmc-clkc.h b/include/dt-bindings/clock/amlogic,mmc-clkc.h
new file mode 100644
index 000000000000..71301517b183
--- /dev/null
+++ b/include/dt-bindings/clock/amlogic,mmc-clkc.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
+ */
+
+#ifndef __MMC_CLKC_H
+#define __MMC_CLKC_H
+
+#define CLKID_MMC_DIV		0
+#define CLKID_MMC_PHASE_CORE	1
+#define CLKID_MMC_PHASE_TX	2
+#define CLKID_MMC_PHASE_RX	3
+
+#endif
-- 
2.34.1


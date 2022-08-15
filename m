Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBABB593197
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 17:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241389AbiHOPQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 11:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242993AbiHOPQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 11:16:27 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF6C22409C;
        Mon, 15 Aug 2022 08:16:24 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,238,1654527600"; 
   d="scan'208";a="129579733"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 16 Aug 2022 00:16:24 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id C19994018A18;
        Tue, 16 Aug 2022 00:16:19 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Conor Dooley <Conor.Dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 6/8] riscv: dts: renesas: Add minimal DTS for Renesas RZ/Five SMARC EVK
Date:   Mon, 15 Aug 2022 16:14:49 +0100
Message-Id: <20220815151451.23293-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the minimal blocks required for booting the Renesas RZ/Five
SMARC EVK with initramfs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
* New patch
---
 arch/riscv/boot/dts/Makefile                  |  1 +
 arch/riscv/boot/dts/renesas/Makefile          |  2 ++
 .../boot/dts/renesas/r9a07g043f01-smarc.dts   | 16 ++++++++++
 .../boot/dts/renesas/rzfive-smarc-som.dtsi    | 22 +++++++++++++
 arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi | 32 +++++++++++++++++++
 5 files changed, 73 insertions(+)
 create mode 100644 arch/riscv/boot/dts/renesas/Makefile
 create mode 100644 arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dts
 create mode 100644 arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
 create mode 100644 arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi

diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
index ff174996cdfd..b0ff5fbabb0c 100644
--- a/arch/riscv/boot/dts/Makefile
+++ b/arch/riscv/boot/dts/Makefile
@@ -3,5 +3,6 @@ subdir-y += sifive
 subdir-y += starfive
 subdir-$(CONFIG_SOC_CANAAN_K210_DTB_BUILTIN) += canaan
 subdir-y += microchip
+subdir-y += renesas
 
 obj-$(CONFIG_BUILTIN_DTB) := $(addsuffix /, $(subdir-y))
diff --git a/arch/riscv/boot/dts/renesas/Makefile b/arch/riscv/boot/dts/renesas/Makefile
new file mode 100644
index 000000000000..2d3f5751a649
--- /dev/null
+++ b/arch/riscv/boot/dts/renesas/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_R9A07G043) += r9a07g043f01-smarc.dtb
diff --git a/arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dts b/arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dts
new file mode 100644
index 000000000000..7428f643a9b3
--- /dev/null
+++ b/arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/Five SMARC EVK
+ *
+ * Copyright (C) 2022 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+
+#include "r9a07g043.dtsi"
+#include "rzfive-smarc.dtsi"
+
+/ {
+	model = "Renesas SMARC EVK based on r9a07g043f01";
+	compatible = "renesas,smarc-evk", "renesas,r9a07g043f01", "renesas,r9a07g043";
+};
diff --git a/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
new file mode 100644
index 000000000000..4a4acde6a2a7
--- /dev/null
+++ b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/Five SMARC EVK SOM
+ *
+ * Copyright (C) 2022 Renesas Electronics Corp.
+ */
+
+/ {
+	chosen {
+		bootargs = "ignore_loglevel";
+	};
+
+	memory@48000000 {
+		device_type = "memory";
+		/* first 128MB is reserved for secure area. */
+		reg = <0x0 0x48000000 0x0 0x38000000>;
+	};
+};
+
+&extal_clk {
+	clock-frequency = <24000000>;
+};
diff --git a/arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi b/arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi
new file mode 100644
index 000000000000..4864a2a62d6b
--- /dev/null
+++ b/arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/Five SMARC EVK carrier board
+ *
+ * Copyright (C) 2022 Renesas Electronics Corp.
+ */
+
+#include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
+#include "rzfive-smarc-som.dtsi"
+
+/ {
+	aliases {
+		serial0 = &scif0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&pinctrl {
+	scif0_pins: scif0 {
+		pinmux = <RZG2L_PORT_PINMUX(6, 4, 6)>, /* TxD */
+			 <RZG2L_PORT_PINMUX(6, 3, 6)>; /* RxD */
+	};
+};
+
+&scif0 {
+	pinctrl-0 = <&scif0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
-- 
2.25.1


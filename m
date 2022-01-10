Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C92489A9C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbiAJNr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:47:59 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:42483 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234580AbiAJNrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:47:47 -0500
X-IronPort-AV: E=Sophos;i="5.88,277,1635174000"; 
   d="scan'208";a="106558155"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Jan 2022 22:47:42 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 32C1342E3548;
        Mon, 10 Jan 2022 22:47:40 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 11/12] arm64: dts: renesas: Add initial device tree for RZ/V2L SMARC EVK
Date:   Mon, 10 Jan 2022 13:46:58 +0000
Message-Id: <20220110134659.30424-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110134659.30424-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110134659.30424-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biju Das <biju.das.jz@bp.renesas.com>

Add basic support for RZ/V2L SMARC EVK (based on R9A07G054L2):
- memory
- External input clock
- CPG
- Pin controller
- SCIF
- GbEthernet
- Audio Clock

It shares the same carrier board with RZ/G2L with the same pin mapping.
Delete the gpio-hog nodes from pinctrl as this will be added later when
the functionality has been tested.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
* None
---
 arch/arm64/boot/dts/renesas/Makefile          |  1 +
 .../boot/dts/renesas/r9a07g054l2-smarc.dts    | 25 +++++++++++++++++++
 .../dts/renesas/rzg2l-smarc-pinfunction.dtsi  |  2 +-
 .../boot/dts/renesas/rzg2l-smarc-som.dtsi     |  2 +-
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  |  2 +-
 5 files changed, 29 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 8e696a38c560..2daba38d1161 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -77,3 +77,4 @@ dtb-$(CONFIG_ARCH_R8A77965) += r8a779m5-salvator-xs.dtb
 
 dtb-$(CONFIG_ARCH_R9A07G044) += r9a07g044l2-smarc.dtb
 dtb-$(CONFIG_ARCH_R9A07G044) += r9a07g044c2-smarc.dtb
+dtb-$(CONFIG_ARCH_R9A07G054) += r9a07g054l2-smarc.dtb
diff --git a/arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dts b/arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dts
new file mode 100644
index 000000000000..39ef55bfe0c3
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/G2L SMARC EVK board
+ *
+ * Copyright (C) 2021 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+#include "r9a07g054l2.dtsi"
+#include "rzg2l-smarc-som.dtsi"
+#include "rzg2l-smarc-pinfunction.dtsi"
+#include "rzg2l-smarc.dtsi"
+
+/ {
+	model = "Renesas SMARC EVK based on r9a07g054l2";
+	compatible = "renesas,smarc-evk", "renesas,r9a07g054l2", "renesas,r9a07g054";
+};
+
+&pinctrl {
+	/delete-node/ can0-stb;
+	/delete-node/ can1-stb;
+	/delete-node/ gpio-sd0-pwr-en-hog;
+	/delete-node/ sd0-dev-sel-hog;
+	/delete-node/ sd1-pwr-en-hog;
+};
diff --git a/arch/arm64/boot/dts/renesas/rzg2l-smarc-pinfunction.dtsi b/arch/arm64/boot/dts/renesas/rzg2l-smarc-pinfunction.dtsi
index 71d83e447670..2ef217445f72 100644
--- a/arch/arm64/boot/dts/renesas/rzg2l-smarc-pinfunction.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc-pinfunction.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 /*
- * Device Tree Source for the RZ/G2L SMARC pincontrol parts
+ * Device Tree Source for the RZ/{G2L,V2L} SMARC pincontrol parts
  *
  * Copyright (C) 2021 Renesas Electronics Corp.
  */
diff --git a/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
index 9112e79079a1..aeacd22e9eb0 100644
--- a/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 /*
- * Device Tree Source for the RZ/G2L SMARC SOM common parts
+ * Device Tree Source for the RZ/{G2L,V2L} SMARC SOM common parts
  *
  * Copyright (C) 2021 Renesas Electronics Corp.
  */
diff --git a/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
index 46abb29718cc..78034f36156d 100644
--- a/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 /*
- * Device Tree Source for the RZ/G2L SMARC EVK common parts
+ * Device Tree Source for the RZ/{G2L,V2L} SMARC EVK common parts
  *
  * Copyright (C) 2021 Renesas Electronics Corp.
  */
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD0A468115
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 01:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383719AbhLDAU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 19:20:59 -0500
Received: from inva021.nxp.com ([92.121.34.21]:54232 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1383666AbhLDAUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 19:20:51 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9202220221E;
        Sat,  4 Dec 2021 01:17:25 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 08282200B75;
        Sat,  4 Dec 2021 01:17:25 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 70BDB40007;
        Fri,  3 Dec 2021 17:17:24 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alex Marginean <alexandru.marginean@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Jason Liu <jason.hui.liu@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2 8/8] arm64: dts: ls1028a-qds: add overlays for various serdes protocols
Date:   Fri,  3 Dec 2021 18:17:18 -0600
Message-Id: <20211204001718.8511-9-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211204001718.8511-1-leoyang.li@nxp.com>
References: <20211204001718.8511-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Marginean <alexandru.marginean@nxp.com>

Add overlays for various serdes protocols on LS1028A QDS board using
different PHY cards.  These should be applied at boot, based on serdes
configuration.  If no overlay is applied, only the RGMII interface on
the QDS is available in Linux.

Building device tree fragments requires passing the "-@" argument to
dtc, which increases the base dtb size and might cause some platforms to
fail to store the new binary. To avoid that, it would be nice to only
pass "-@" for the platforms where fragments will be used, aka
LS1028A-QDS. One approach suggested by Rob Herring is used here:

https://lore.kernel.org/patchwork/patch/821645/

Also moved the enet* override nodes in dts file to be in alphabetic order.

Signed-off-by: Alex Marginean <alexandru.marginean@nxp.com>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Jason Liu <jason.hui.liu@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |  16 +++
 .../dts/freescale/fsl-ls1028a-qds-13bb.dts    | 113 ++++++++++++++++++
 .../dts/freescale/fsl-ls1028a-qds-65bb.dts    | 108 +++++++++++++++++
 .../dts/freescale/fsl-ls1028a-qds-7777.dts    |  82 +++++++++++++
 .../dts/freescale/fsl-ls1028a-qds-85bb.dts    | 107 +++++++++++++++++
 .../dts/freescale/fsl-ls1028a-qds-899b.dts    |  75 ++++++++++++
 .../dts/freescale/fsl-ls1028a-qds-9999.dts    |  79 ++++++++++++
 .../boot/dts/freescale/fsl-ls1028a-qds.dts    |  19 ++-
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |   2 +-
 9 files changed, 595 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-13bb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-65bb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-7777.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-85bb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-899b.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-9999.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index a14a6173b765..f518eb1e1142 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -1,4 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0
+
+# required for overlay support
+DTC_FLAGS_fsl-ls1028a-qds := -@
+DTC_FLAGS_fsl-ls1028a-qds-13bb := -@
+DTC_FLAGS_fsl-ls1028a-qds-65bb := -@
+DTC_FLAGS_fsl-ls1028a-qds-7777 := -@
+DTC_FLAGS_fsl-ls1028a-qds-85bb := -@
+DTC_FLAGS_fsl-ls1028a-qds-899b := -@
+DTC_FLAGS_fsl-ls1028a-qds-9999 := -@
+
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-frdm.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-frwy.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-oxalis.dtb
@@ -11,6 +21,12 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-kontron-sl28-var2.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-kontron-sl28-var3-ads2.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-kontron-sl28-var4.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-qds.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-qds-13bb.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-qds-65bb.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-qds-7777.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-qds-85bb.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-qds-899b.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-qds-9999.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-rdb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1043a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1043a-rdb.dtb
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-13bb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-13bb.dts
new file mode 100644
index 000000000000..f748a2c12a70
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-13bb.dts
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree fragment for LS1028A QDS board, serdes 13bb
+ *
+ * Copyright 2019-2021 NXP
+ *
+ * Requires a LS1028A QDS board with lane B rework.
+ * Requires a SCH-30841 card with lane A of connector rewired to PHY lane C.
+ * Set-up is a SCH-30842 card in slot 1 and SCH-30841 in slot 2.
+ */
+
+/dts-v1/;
+/plugin/;
+
+/ {
+	fragment@0 {
+		target = <&mdio_slot1>;
+
+		__overlay__ {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			slot1_sgmii: ethernet-phy@2 {
+				/* AQR112 */
+				reg = <0x2>;
+				compatible = "ethernet-phy-ieee802.3-c45";
+			};
+		};
+	};
+
+	fragment@1 {
+		target = <&enetc_port0>;
+
+		__overlay__ {
+			phy-handle = <&slot1_sgmii>;
+			phy-mode = "usxgmii";
+			managed = "in-band-status";
+			status = "okay";
+		};
+	};
+
+	fragment@2 {
+		target = <&mdio_slot2>;
+
+		__overlay__ {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* 4 ports on AQR412 */
+			slot2_qxgmii0: ethernet-phy@0 {
+				reg = <0x0>;
+				compatible = "ethernet-phy-ieee802.3-c45";
+			};
+
+			slot2_qxgmii1: ethernet-phy@1 {
+				reg = <0x1>;
+				compatible = "ethernet-phy-ieee802.3-c45";
+			};
+
+			slot2_qxgmii2: ethernet-phy@2 {
+				reg = <0x2>;
+				compatible = "ethernet-phy-ieee802.3-c45";
+			};
+
+			slot2_qxgmii3: ethernet-phy@3 {
+				reg = <0x3>;
+				compatible = "ethernet-phy-ieee802.3-c45";
+			};
+		};
+	};
+
+	fragment@3 {
+		target = <&mscc_felix_ports>;
+
+		__overlay__ {
+			port@0 {
+				status = "okay";
+				phy-handle = <&slot2_qxgmii0>;
+				phy-mode = "usxgmii";
+				managed = "in-band-status";
+			};
+
+			port@1 {
+				status = "okay";
+				phy-handle = <&slot2_qxgmii1>;
+				phy-mode = "usxgmii";
+				managed = "in-band-status";
+			};
+
+			port@2 {
+				status = "okay";
+				phy-handle = <&slot2_qxgmii2>;
+				phy-mode = "usxgmii";
+				managed = "in-band-status";
+			};
+
+			port@3 {
+				status = "okay";
+				phy-handle = <&slot2_qxgmii3>;
+				phy-mode = "usxgmii";
+				managed = "in-band-status";
+			};
+		};
+	};
+
+	fragment@4 {
+		target = <&mscc_felix>;
+
+		__overlay__ {
+			status = "okay";
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-65bb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-65bb.dts
new file mode 100644
index 000000000000..8ffb707a1576
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-65bb.dts
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree fragment for LS1028A QDS board, serdes 69xx
+ *
+ * Copyright 2019-2021 NXP
+ *
+ * Requires a LS1028A QDS board with lane B rework.
+ * Requires a SCH-30842 card in slot 1 and a SCH-28021 card in slot 2.
+ */
+
+/dts-v1/;
+/plugin/;
+
+/ {
+	fragment@0 {
+		target = <&mdio_slot1>;
+
+		__overlay__ {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			slot1_sgmii: ethernet-phy@2 {
+				/* AQR112 */
+				reg = <0x2>;
+				compatible = "ethernet-phy-ieee802.3-c45";
+			};
+		};
+	};
+
+	fragment@1 {
+		target = <&enetc_port0>;
+
+		__overlay__ {
+			phy-handle = <&slot1_sgmii>;
+			phy-mode = "2500base-x";
+			managed = "in-band-status";
+			status = "okay";
+		};
+	};
+
+	fragment@2 {
+		target = <&mdio_slot2>;
+
+		__overlay__ {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* 4 ports on VSC8514 */
+			slot2_qsgmii0: ethernet-phy@8 {
+				reg = <0x8>;
+			};
+
+			slot2_qsgmii1: ethernet-phy@9 {
+				reg = <0x9>;
+			};
+
+			slot2_qsgmii2: ethernet-phy@a {
+				reg = <0xa>;
+			};
+
+			slot2_qsgmii3: ethernet-phy@b {
+				reg = <0xb>;
+			};
+		};
+	};
+
+	fragment@3 {
+		target = <&mscc_felix_ports>;
+
+		__overlay__ {
+			port@0 {
+				status = "okay";
+				phy-handle = <&slot2_qsgmii0>;
+				phy-mode = "qsgmii";
+				managed = "in-band-status";
+			};
+
+			port@1 {
+				status = "okay";
+				phy-handle = <&slot2_qsgmii1>;
+				phy-mode = "qsgmii";
+				managed = "in-band-status";
+			};
+
+			port@2 {
+				status = "okay";
+				phy-handle = <&slot2_qsgmii2>;
+				phy-mode = "qsgmii";
+				managed = "in-band-status";
+			};
+
+			port@3 {
+				status = "okay";
+				phy-handle = <&slot2_qsgmii3>;
+				phy-mode = "qsgmii";
+				managed = "in-band-status";
+			};
+		};
+	};
+
+	fragment@4 {
+		target = <&mscc_felix>;
+
+		__overlay__ {
+			status = "okay";
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-7777.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-7777.dts
new file mode 100644
index 000000000000..eb6a1e674f10
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-7777.dts
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree fragment for LS1028A QDS board, serdes 7777
+ *
+ * Copyright 2019-2021 NXP
+ *
+ * Requires a LS1028A QDS board without lane B rework.
+ * Requires a SCH-30841 card without lane A/C rewire and with a FW with muxing
+ * disabled, plugged in slot 1.
+ */
+
+/dts-v1/;
+/plugin/;
+
+/ {
+	fragment@0 {
+		target = <&mdio_slot1>;
+
+		__overlay__ {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* 4 ports on AQR412 */
+			slot1_sxgmii0: ethernet-phy@0 {
+				reg = <0x0>;
+				compatible = "ethernet-phy-ieee802.3-c45";
+			};
+
+			slot1_sxgmii1: ethernet-phy@1 {
+				reg = <0x1>;
+				compatible = "ethernet-phy-ieee802.3-c45";
+			};
+
+			slot1_sxgmii2: ethernet-phy@2 {
+				reg = <0x2>;
+				compatible = "ethernet-phy-ieee802.3-c45";
+			};
+
+			slot1_sxgmii3: ethernet-phy@3 {
+				reg = <0x3>;
+				compatible = "ethernet-phy-ieee802.3-c45";
+			};
+		};
+	};
+
+	fragment@1 {
+		target = <&mscc_felix_ports>;
+
+		__overlay__ {
+			port@0 {
+				status = "okay";
+				phy-handle = <&slot1_sxgmii0>;
+				phy-mode = "2500base-x";
+			};
+
+			port@1 {
+				status = "okay";
+				phy-handle = <&slot1_sxgmii1>;
+				phy-mode = "2500base-x";
+			};
+
+			port@2 {
+				status = "okay";
+				phy-handle = <&slot1_sxgmii2>;
+				phy-mode = "2500base-x";
+			};
+
+			port@3 {
+				status = "okay";
+				phy-handle = <&slot1_sxgmii3>;
+				phy-mode = "2500base-x";
+			};
+		};
+	};
+
+	fragment@2 {
+		target = <&mscc_felix>;
+		__overlay__ {
+			status = "okay";
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-85bb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-85bb.dts
new file mode 100644
index 000000000000..8e90c3088ba1
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-85bb.dts
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree fragment for LS1028A QDS board, serdes 85bb
+ *
+ * Copyright 2019-2021 NXP
+ *
+ * Requires a LS1028A QDS board with lane B rework.
+ * Requires a SCH-24801 card in slot 1 and a SCH-28021 card in slot 2.
+ */
+
+/dts-v1/;
+/plugin/;
+
+/ {
+	fragment@0 {
+		target = <&mdio_slot1>;
+
+		__overlay__ {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			slot1_sgmii: ethernet-phy@1c {
+				/* 1st port on VSC8234 */
+				reg = <0x1c>;
+			};
+		};
+	};
+
+	fragment@1 {
+		target = <&enetc_port0>;
+
+		__overlay__ {
+			phy-handle = <&slot1_sgmii>;
+			phy-mode = "sgmii";
+			managed = "in-band-status";
+			status = "okay";
+		};
+	};
+
+	fragment@2 {
+		target = <&mdio_slot2>;
+
+		__overlay__ {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* 4 ports on VSC8514 */
+			slot2_qsgmii0: ethernet-phy@8 {
+				reg = <0x8>;
+			};
+
+			slot2_qsgmii1: ethernet-phy@9 {
+				reg = <0x9>;
+			};
+
+			slot2_qsgmii2: ethernet-phy@a {
+				reg = <0xa>;
+			};
+
+			slot2_qsgmii3: ethernet-phy@b {
+				reg = <0xb>;
+			};
+		};
+	};
+
+	fragment@3 {
+		target = <&mscc_felix_ports>;
+
+		__overlay__ {
+			port@0 {
+				status = "okay";
+				phy-handle = <&slot2_qsgmii0>;
+				phy-mode = "qsgmii";
+				managed = "in-band-status";
+			};
+
+			port@1 {
+				status = "okay";
+				phy-handle = <&slot2_qsgmii1>;
+				phy-mode = "qsgmii";
+				managed = "in-band-status";
+			};
+
+			port@2 {
+				status = "okay";
+				phy-handle = <&slot2_qsgmii2>;
+				phy-mode = "qsgmii";
+				managed = "in-band-status";
+			};
+
+			port@3 {
+				status = "okay";
+				phy-handle = <&slot2_qsgmii3>;
+				phy-mode = "qsgmii";
+				managed = "in-band-status";
+			};
+		};
+	};
+
+	fragment@4 {
+		target = <&mscc_felix>;
+
+		__overlay__ {
+			status = "okay";
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-899b.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-899b.dts
new file mode 100644
index 000000000000..5d0a094e6c44
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-899b.dts
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree fragment for LS1028A QDS board, serdes 85xx
+ *
+ * Copyright 2019-2021 NXP
+ *
+ * Requires a LS1028A QDS board without lane B rework.
+ * Requires a SCH-24801 card in slot 1.
+ */
+
+/dts-v1/;
+/plugin/;
+
+/ {
+	fragment@0 {
+		target = <&mdio_slot1>;
+		__overlay__ {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* VSC8234 */
+			slot1_sgmii0: ethernet-phy@1c {
+				reg = <0x1c>;
+			};
+
+			slot1_sgmii1: ethernet-phy@1d {
+				reg = <0x1d>;
+			};
+
+			slot1_sgmii2: ethernet-phy@1e {
+				reg = <0x1e>;
+			};
+
+			slot1_sgmii3: ethernet-phy@1f {
+				reg = <0x1f>;
+			};
+		};
+	};
+
+	fragment@1 {
+		target = <&enetc_port0>;
+		__overlay__ {
+			phy-handle = <&slot1_sgmii0>;
+			phy-mode = "sgmii";
+			managed = "in-band-status";
+			status = "okay";
+		};
+	};
+
+	fragment@2 {
+		target = <&mscc_felix_ports>;
+		__overlay__ {
+			port@1 {
+				status = "okay";
+				phy-handle = <&slot1_sgmii1>;
+				phy-mode = "sgmii";
+				managed = "in-band-status";
+			};
+
+			port@2 {
+				status = "okay";
+				phy-handle = <&slot1_sgmii2>;
+				phy-mode = "sgmii";
+				managed = "in-band-status";
+			};
+		};
+	};
+
+	fragment@3 {
+		target = <&mscc_felix>;
+		__overlay__ {
+			status = "okay";
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-9999.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-9999.dts
new file mode 100644
index 000000000000..1ef743c48e84
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-9999.dts
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree fragment for LS1028A QDS board, serdes 85xx
+ *
+ * Copyright 2019-2021 NXP
+ *
+ * Requires a LS1028A QDS board without lane B rework.
+ * Requires a SCH-24801 card in slot 1.
+ */
+
+/dts-v1/;
+/plugin/;
+
+/ {
+	fragment@0 {
+		target = <&mdio_slot1>;
+		__overlay__ {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* VSC8234 */
+			slot1_sgmii0: ethernet-phy@1c {
+				reg = <0x1c>;
+			};
+
+			slot1_sgmii1: ethernet-phy@1d {
+				reg = <0x1d>;
+			};
+
+			slot1_sgmii2: ethernet-phy@1e {
+				reg = <0x1e>;
+			};
+
+			slot1_sgmii3: ethernet-phy@1f {
+				reg = <0x1f>;
+			};
+		};
+	};
+
+	fragment@1 {
+		target = <&mscc_felix_ports>;
+		__overlay__ {
+			port@0 {
+				status = "okay";
+				phy-handle = <&slot1_sgmii0>;
+				phy-mode = "sgmii";
+				managed = "in-band-status";
+			};
+
+			port@1 {
+				status = "okay";
+				phy-handle = <&slot1_sgmii1>;
+				phy-mode = "sgmii";
+				managed = "in-band-status";
+			};
+
+			port@2 {
+				status = "okay";
+				phy-handle = <&slot1_sgmii2>;
+				phy-mode = "sgmii";
+				managed = "in-band-status";
+			};
+
+			port@3 {
+				status = "okay";
+				phy-handle = <&slot1_sgmii3>;
+				phy-mode = "sgmii";
+				managed = "in-band-status";
+			};
+		};
+	};
+
+	fragment@2 {
+		target = <&mscc_felix>;
+		__overlay__ {
+			status = "okay";
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
index 782853a449cc..177bc1405f0f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
@@ -211,6 +211,16 @@ &duart1 {
 	status = "okay";
 };
 
+&enetc_port1 {
+	phy-handle = <&qds_phy1>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+};
+
+&enetc_port2 {
+	status = "okay";
+};
+
 &esdhc {
 	status = "okay";
 };
@@ -326,17 +336,16 @@ rtc@51 {
 	};
 };
 
-&enetc_port1 {
-	phy-handle = <&qds_phy1>;
-	phy-mode = "rgmii-id";
+&lpuart0 {
 	status = "okay";
 };
 
-&lpuart0 {
+&lpuart1 {
 	status = "okay";
 };
 
-&lpuart1 {
+&mscc_felix_port4 {
+	ethernet = <&enetc_port2>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 5c17dfaa50de..f305ac2906d8 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -1115,7 +1115,7 @@ mscc_felix: ethernet-switch@0,5 {
 				interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 
-				ports {
+				mscc_felix_ports: ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
 
-- 
2.25.1


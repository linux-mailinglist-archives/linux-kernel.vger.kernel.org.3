Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A6548D7AF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbiAMMYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:24:49 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:22276 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbiAMMYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:24:22 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220113122421epoutp0291526f837a4c263d87928ff983c622ce~J1AYKvY5T2969529695epoutp02F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:24:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220113122421epoutp0291526f837a4c263d87928ff983c622ce~J1AYKvY5T2969529695epoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642076661;
        bh=OHNMYfBdu1SF9tQwB6mgGnNAhNqp5m31ZTVNeOQe8g8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rYiBi0Qi3XxYWxaLFO3t6RcAMUfpdHHvEsp9rplFZCHfgNVyDQXUzc8dXtwlmlTwH
         8rIBMmFzX/k4cUuI5P48Z7IDtwOKmNYSI78X9W7WclDxm/QRt1nThy0Cq5VJsrLGxb
         W9d90WJ9hjAnwlPEsSs/NEStvxAnn7v1vn3KUjQM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220113122420epcas5p1ff6007467c5936d1b1fd0146f614a368~J1AXVQYsK2652426524epcas5p1f;
        Thu, 13 Jan 2022 12:24:20 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JZNsD2mBjz4x9Pq; Thu, 13 Jan
        2022 12:24:16 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C4.21.46822.EE910E16; Thu, 13 Jan 2022 21:24:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220113122413epcas5p46cb2cafb73936c423017240f98f72845~J1AREjVPH1113011130epcas5p4Q;
        Thu, 13 Jan 2022 12:24:13 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220113122413epsmtrp1cbe3dc38c6306c3a3f1beb09ab37c424~J1ARE6X1e1991219912epsmtrp1Q;
        Thu, 13 Jan 2022 12:24:13 +0000 (GMT)
X-AuditID: b6c32a4a-de5ff7000000b6e6-8f-61e019eee83d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        7A.A9.08738.DE910E16; Thu, 13 Jan 2022 21:24:13 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220113122409epsmtip26fdb3e9080e0e4a40f8499b36b004fd0~J1ANTP3n01247412474epsmtip2v;
        Thu, 13 Jan 2022 12:24:09 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com, Arjun K V <arjun.kv@samsung.com>,
        Aswani Reddy <aswani.reddy@samsung.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        Sriranjani P <sriranjani.p@samsung.com>,
        Chandrasekar R <rcsekar@samsung.com>,
        Shashank Prashar <s.prashar@samsung.com>
Subject: [PATCH 14/23] arm64: dts: fsd: Add initial device tree support
Date:   Thu, 13 Jan 2022 17:41:34 +0530
Message-Id: <20220113121143.22280-15-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220113121143.22280-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmlu47yQeJBj+P61gceH+QxeLBvG1s
        FstX7mKxOLR5K7vF+2U9jBbzj5xjtdj49geTxZQ/y5ksNj2+xmrxseceq8XDV+EWl3fNYbOY
        cX4fk8Wp65/ZLBZt/cJuMevCDlaL1r1H2C0Ov2lntZi3Yy6jxePrf9gsbr9Zx+og6rFm3hpG
        j1kNvWwem1Z1snncubaHzWPzknqPKyeaWD36tqxi9PjXNJfd4/MmuQDOqGybjNTElNQihdS8
        5PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKD3lBTKEnNKgUIBicXFSvp2
        NkX5pSWpChn5xSW2SqkFKTkFJgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGa8urmcuOHqNseLR
        tfAGxo1LGbsYOTkkBEwkFkzdwtTFyMUhJLCbUeL94k2MEM4nRokD3/axQzifGSW2b3jDDNNy
        +/8DNojELkaJNcd2s0I4LUwSk47PBRvMJqAtcXc6yGBODhEBN4kbjR1gNrPAeRaJac3iILaw
        gLtE06wtrCA2i4CqxM+dk8B6eQVsJZ7enMQCsU1eYvWGA0CbOTg4geJ3V+WB7JIQOMMhsfn1
        K6gnXCR6359jh7CFJV4d3wJlS0m87G9jB+mVEMiW6NllDBGukVg67xjUeHuJA1fmsICUMAto
        SqzfpQ9xJZ9E7+8nTBCdvBIdbUIQ1aoSze+uQnVKS0zs7maFsD0kjt48Bw2FCYwSm3YtYp/A
        KDsLYeoCRsZVjJKpBcW56anFpgVGeanl8IhKzs/dxAhOtVpeOxgfPvigd4iRiYPxEKMEB7OS
        CG9/0f1EId6UxMqq1KL8+KLSnNTiQ4ymwBCbyCwlmpwPTPZ5JfGGJpYGJmZmZiaWxmaGSuK8
        p9M3JAoJpCeWpGanphakFsH0MXFwSjUwubloMIQ2u8jys1v+9TXJSovnnuI7jX9n/7oP/kab
        JixhWRkkUZ7ePq1hqVDi+s0PnTiWHGE3rO20u/Ze/exi4eC7xn0q6VUPA/PMymosrjxcpK2c
        /Nw+1WX//GkaE90stO8pbClzifCb4vf8rEfGn6tXjxhW5tdyXX+wvmPynYnvkiL36tn7bjh4
        0dhi8uzt5p+jGI8flIw6z8rkP6O881LEP9XJ4u9j19o635PSPL5b8q69aazMvXn5O9gfKij+
        kystZmDcHWH/4OJkhlCe4OyQF1U5T/o3uHwTfP3R4aaobl3InnMpYtFyJYen7Vw8zT/wedbN
        KTu/s2rlLd/38EqqV9z9+237Vq3f76SrxFKckWioxVxUnAgA/SfUmz4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsWy7bCSvO5byQeJBm+XyFgceH+QxeLBvG1s
        FstX7mKxOLR5K7vF+2U9jBbzj5xjtdj49geTxZQ/y5ksNj2+xmrxseceq8XDV+EWl3fNYbOY
        cX4fk8Wp65/ZLBZt/cJuMevCDlaL1r1H2C0Ov2lntZi3Yy6jxePrf9gsbr9Zx+og6rFm3hpG
        j1kNvWwem1Z1snncubaHzWPzknqPKyeaWD36tqxi9PjXNJfd4/MmuQDOKC6blNSczLLUIn27
        BK6MVxfXMxccvcZY8ehaeAPjxqWMXYycHBICJhK3/z9g62Lk4hAS2MEo8eXQYhaIhLTE9Y0T
        2CFsYYmV/56zQxQ1MUls+NUK1s0moC1xd/oWJhBbRMBDou3fPWaQImaBxywSV76+YwZJCAu4
        SzTN2sIKYrMIqEr83DkJrJlXwFbi6c1JUNvkJVZvOABUz8HBCRS/uyoPJCwkYCNx7tV6tgmM
        fAsYGVYxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgRHipbWDsY9qz7oHWJk4mA8xCjB
        wawkwttfdD9RiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6p
        Bqb16QFxb9t9Mj6wf9twbNZ/1WkPjknum1eYKCIb5diRbfioa6deSz7Lg71n9k+5lca4WCDk
        wV61nNCKLmGxp4aWglWbdJcxFxZt2DBb4MKBL6arNrz3j7F9mdQt86J28prg1Md+rza7R6o7
        Pub9Xa8TLcg7ebnW3Ti2W2dtGg71iR1W2qax9NahtRXXeRXPG93j93xxbk1LofYDm6nePqzX
        r/LqiYdX3TmUqVJiGnJ5tsx7nfyOZZFTOcIOzd53SPxXzY0lvJanZxtONr/mpbi2pae7ymiB
        os0CR+F7YTkX/GQ3eTYkBD3KNrjL3BISPO/AotTTb6bG3MniFfyo/L3m9qGMGUoCVT0m8pWu
        eUosxRmJhlrMRcWJADFUle4DAwAA
X-CMS-MailID: 20220113122413epcas5p46cb2cafb73936c423017240f98f72845
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220113122413epcas5p46cb2cafb73936c423017240f98f72845
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
        <CGME20220113122413epcas5p46cb2cafb73936c423017240f98f72845@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial device tree support for "Full Self-Driving" (FSD) SoC
This SoC contain three clusters of four cortex-a72 CPUs and various
peripheral IPs.

Cc: linux-fsd@tesla.com
Signed-off-by: Arjun K V <arjun.kv@samsung.com>
Signed-off-by: Aswani Reddy <aswani.reddy@samsung.com>
Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
Signed-off-by: Chandrasekar R <rcsekar@samsung.com>
Signed-off-by: Shashank Prashar <s.prashar@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 MAINTAINERS                        |   8 +
 arch/arm64/Kconfig.platforms       |   6 +
 arch/arm64/boot/dts/Makefile       |   1 +
 arch/arm64/boot/dts/tesla/Makefile |   3 +
 arch/arm64/boot/dts/tesla/fsd.dts  | 140 ++++++
 arch/arm64/boot/dts/tesla/fsd.dtsi | 715 +++++++++++++++++++++++++++++
 6 files changed, 873 insertions(+)
 create mode 100644 arch/arm64/boot/dts/tesla/Makefile
 create mode 100644 arch/arm64/boot/dts/tesla/fsd.dts
 create mode 100644 arch/arm64/boot/dts/tesla/fsd.dtsi

diff --git a/MAINTAINERS b/MAINTAINERS
index fb18ce7168aa..02d56909c5e2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2726,6 +2726,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/media/tegra-cec.txt
 F:	drivers/media/cec/platform/tegra/
 
+ARM/TESLA FSD SoC SUPPORT
+M:	Alim Akhtar <alim.akhtar@samsung.com>
+M:	linux-fsd@tesla.com
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	linux-samsung-soc@vger.kernel.org
+S:	Maintained
+F:	arch/arm64/boot/dts/tesla*
+
 ARM/TETON BGA MACHINE SUPPORT
 M:	"Mark F. Brown" <mark.brown314@gmail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 54e3910e8b9b..bb8a047c2359 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -267,6 +267,12 @@ config ARCH_TEGRA
 	help
 	  This enables support for the NVIDIA Tegra SoC family.
 
+config ARCH_TESLA_FSD
+	bool "ARMv8 based Tesla platform"
+	select ARCH_EXYNOS
+	help
+	  Support for ARMv8 based Tesla platforms.
+
 config ARCH_SPRD
 	bool "Spreadtrum SoC platform"
 	help
diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 639e01a4d855..1ba04e31a438 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -27,6 +27,7 @@ subdir-y += rockchip
 subdir-y += socionext
 subdir-y += sprd
 subdir-y += synaptics
+subdir-y += tesla
 subdir-y += ti
 subdir-y += toshiba
 subdir-y += xilinx
diff --git a/arch/arm64/boot/dts/tesla/Makefile b/arch/arm64/boot/dts/tesla/Makefile
new file mode 100644
index 000000000000..a9818cda6b08
--- /dev/null
+++ b/arch/arm64/boot/dts/tesla/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_TESLA_FSD) += \
+	fsd.dtb
diff --git a/arch/arm64/boot/dts/tesla/fsd.dts b/arch/arm64/boot/dts/tesla/fsd.dts
new file mode 100644
index 000000000000..e9bbd3284de9
--- /dev/null
+++ b/arch/arm64/boot/dts/tesla/fsd.dts
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Tesla FSD board device tree source
+ *
+ * Copyright (c) 2017-2021 Samsung Electronics Co., Ltd.
+ *		https://www.samsung.com
+ * Copyright (c) 2017-2021 Tesla, Inc.
+ *		https://www.tesla.com
+ */
+
+/dts-v1/;
+#include "fsd.dtsi"
+
+/ {
+	model = "Tesla Full Self-Driving (FSD) SoC";
+	compatible = "tesla,fsd";
+
+	aliases {
+		serial0 = &serial_0;
+		serial1 = &serial_1;
+	};
+
+	chosen {
+		stdout-path = &serial_0;
+		linux,initrd-start = <0xE0000000>;
+		linux,initrd-end = <0xE4F00000>;
+		bootargs = "console=ttySAC0,115200n8
+			earlycon=exynos4210,0x14180000 root=/dev/ram0
+			init=/linuxrc";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x2 0x00000000>;
+	};
+};
+
+&fin_pll {
+	clock-frequency = <24000000>;
+};
+
+&serial_0 {
+	status = "okay";
+};
+
+&serial_1 {
+	status = "okay";
+};
+
+&clock_cmu {
+	status = "okay";
+};
+
+&clock_imem {
+	status = "okay";
+};
+
+&clock_peric {
+	status = "okay";
+};
+
+&smmu_isp {
+	status = "okay";
+};
+
+&clock_fsys0 {
+	status = "okay";
+};
+
+&clock_fsys1 {
+	status = "okay";
+};
+
+&smmu_peric {
+	status = "okay";
+};
+
+&smmu_imem {
+	status = "okay";
+};
+
+&smmu_fsys0 {
+	status = "okay";
+};
+
+&hsi2c_0 {
+	status = "okay";
+};
+
+&hsi2c_1 {
+	status = "okay";
+};
+
+&hsi2c_2 {
+	status = "okay";
+};
+
+&hsi2c_3 {
+	status = "okay";
+};
+
+&hsi2c_4 {
+	status = "okay";
+};
+
+&hsi2c_5 {
+	status = "okay";
+};
+
+&hsi2c_6 {
+	status = "okay";
+};
+
+&hsi2c_7 {
+	status = "okay";
+};
+
+&pwm_0 {
+	status = "okay";
+};
+
+&pwm_1 {
+	status = "okay";
+};
+
+&mdma0 {
+	status = "okay";
+};
+
+&mdma1 {
+	status = "okay";
+};
+
+&pdma0 {
+	status = "okay";
+};
+
+&pdma1 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
new file mode 100644
index 000000000000..47cd9f20566e
--- /dev/null
+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
@@ -0,0 +1,715 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Tesla Full Self-Driving SoC device tree source
+ *
+ * Copyright (c) 2017-2022 Samsung Electronics Co., Ltd.
+ *		https://www.samsung.com
+ * Copyright (c) 2017-2022 Tesla, Inc.
+ *		https://www.tesla.com
+ */
+
+#include <dt-bindings/clock/fsd-clk.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "tesla,fsd";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		watchdog0 = &watchdog_0;
+		watchdog1 = &watchdog_1;
+		watchdog2 = &watchdog_2;
+		hsi2c0 = &hsi2c_0;
+		hsi2c1 = &hsi2c_1;
+		hsi2c2 = &hsi2c_2;
+		hsi2c3 = &hsi2c_3;
+		hsi2c4 = &hsi2c_4;
+		hsi2c5 = &hsi2c_5;
+		hsi2c6 = &hsi2c_6;
+		hsi2c7 = &hsi2c_7;
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpucl0_0>;
+				};
+				core1 {
+					cpu = <&cpucl0_1>;
+				};
+				core2 {
+					cpu = <&cpucl0_2>;
+				};
+				core3 {
+					cpu = <&cpucl0_3>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cpucl1_0>;
+				};
+				core1 {
+					cpu = <&cpucl1_1>;
+				};
+				core2 {
+					cpu = <&cpucl1_2>;
+				};
+				core3 {
+					cpu = <&cpucl1_3>;
+				};
+			};
+
+			cluster2 {
+				core0 {
+					cpu = <&cpucl2_0>;
+				};
+				core1 {
+					cpu = <&cpucl2_1>;
+				};
+				core2 {
+					cpu = <&cpucl2_2>;
+				};
+				core3 {
+					cpu = <&cpucl2_3>;
+				};
+			};
+		};
+
+		/* Cluster 0 */
+		cpucl0_0: cpu@0 {
+				device_type = "cpu";
+				compatible = "arm,cortex-a72";
+				reg = <0x0 0x000>;
+				enable-method = "psci";
+				clock-frequency = <2400000000>;
+				cpu-idle-states = <&CPU_SLEEP>;
+				next-level-cache = <&L2_0>;
+		};
+
+		cpucl0_1: cpu@1 {
+				device_type = "cpu";
+				compatible = "arm,cortex-a72";
+				reg = <0x0 0x001>;
+				enable-method = "psci";
+				clock-frequency = <2400000000>;
+				cpu-idle-states = <&CPU_SLEEP>;
+				next-level-cache = <&L2_0>;
+		};
+
+		cpucl0_2: cpu@2 {
+				device_type = "cpu";
+				compatible = "arm,cortex-a72";
+				reg = <0x0 0x002>;
+				enable-method = "psci";
+				clock-frequency = <2400000000>;
+				cpu-idle-states = <&CPU_SLEEP>;
+				next-level-cache = <&L2_0>;
+		};
+
+		cpucl0_3: cpu@3 {
+				device_type = "cpu";
+				compatible = "arm,cortex-a72";
+				reg = <0x0 0x003>;
+				enable-method = "psci";
+				cpu-idle-states = <&CPU_SLEEP>;
+				next-level-cache = <&L2_0>;
+		};
+
+		/* Cluster 1 */
+		cpucl1_0: cpu@100 {
+				device_type = "cpu";
+				compatible = "arm,cortex-a72";
+				reg = <0x0 0x100>;
+				enable-method = "psci";
+				clock-frequency = <2400000000>;
+				cpu-idle-states = <&CPU_SLEEP>;
+				next-level-cache = <&L2_0>;
+		};
+
+		cpucl1_1: cpu@101 {
+				device_type = "cpu";
+				compatible = "arm,cortex-a72";
+				reg = <0x0 0x101>;
+				enable-method = "psci";
+				clock-frequency = <2400000000>;
+				cpu-idle-states = <&CPU_SLEEP>;
+				next-level-cache = <&L2_0>;
+		};
+
+		cpucl1_2: cpu@102 {
+				device_type = "cpu";
+				compatible = "arm,cortex-a72";
+				reg = <0x0 0x102>;
+				enable-method = "psci";
+				clock-frequency = <2400000000>;
+				cpu-idle-states = <&CPU_SLEEP>;
+				next-level-cache = <&L2_0>;
+		};
+
+		cpucl1_3: cpu@103 {
+				device_type = "cpu";
+				compatible = "arm,cortex-a72";
+				reg = <0x0 0x103>;
+				enable-method = "psci";
+				clock-frequency = <2400000000>;
+				cpu-idle-states = <&CPU_SLEEP>;
+				next-level-cache = <&L2_0>;
+		};
+
+		/* Cluster 2 */
+		cpucl2_0: cpu@200 {
+				device_type = "cpu";
+				compatible = "arm,cortex-a72";
+				reg = <0x0 0x200>;
+				enable-method = "psci";
+				clock-frequency = <2400000000>;
+				cpu-idle-states = <&CPU_SLEEP>;
+				next-level-cache = <&L2_0>;
+		};
+
+		cpucl2_1: cpu@201 {
+				device_type = "cpu";
+				compatible = "arm,cortex-a72";
+				reg = <0x0 0x201>;
+				enable-method = "psci";
+				clock-frequency = <2400000000>;
+				cpu-idle-states = <&CPU_SLEEP>;
+				next-level-cache = <&L2_0>;
+		};
+
+		cpucl2_2: cpu@202 {
+				device_type = "cpu";
+				compatible = "arm,cortex-a72";
+				reg = <0x0 0x202>;
+				enable-method = "psci";
+				clock-frequency = <2400000000>;
+				cpu-idle-states = <&CPU_SLEEP>;
+				next-level-cache = <&L2_0>;
+		};
+
+		cpucl2_3: cpu@203 {
+				device_type = "cpu";
+				compatible = "arm,cortex-a72";
+				reg = <0x0 0x203>;
+				enable-method = "psci";
+				clock-frequency = <2400000000>;
+				cpu-idle-states = <&CPU_SLEEP>;
+				next-level-cache = <&L2_0>;
+		};
+
+		idle-states {
+			entry-method = "arm,psci";
+
+			CPU_SLEEP: cpu-sleep {
+				idle-state-name = "c2";
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				arm,psci-suspend-param = <0x0010000>;
+				entry-latency-us = <30>;
+				exit-latency-us = <75>;
+				min-residency-us = <300>;
+				status = "okay";
+			};
+		};
+
+		L2_0: l2-cache0 {
+			compatible = "cache";
+		};
+	};
+
+	arm-pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 372 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 384 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 385 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 386 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 387 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpucl0_0>, <&cpucl0_1>, <&cpucl0_2>,
+				     <&cpucl0_3>, <&cpucl1_0>, <&cpucl1_1>,
+				     <&cpucl1_2>, <&cpucl1_3>, <&cpucl2_0>,
+				     <&cpucl2_1>, <&cpucl2_2>, <&cpucl2_3>;
+	};
+
+	psci {
+		compatible = "arm,psci";
+		method = "smc";
+		cpu_on = <0xC4000003>;
+		cpu_suspend = <0xC4000001>;
+		cpu_off = <0x84000002>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	fin_pll: clock {
+		compatible = "fixed-clock";
+		clock-output-names = "fin_pll";
+		#clock-cells = <0>;
+	};
+
+	soc: soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x0 0x0 0x0 0x0 0x0 0x18000000>;
+		dma-ranges = <0x0 0x0 0x0 0x0 0x10 0x0>;
+
+		gic: interrupt-controller@10400000 {
+			compatible = "arm,gic-v3";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg =	<0x0 0x10400000 0x0 0x10000>, /* GICD */
+				<0x0 0x10600000 0x0 0x200000>; /* GICR_RD+GICR_SGI */
+		};
+
+		smmu_isp: iommu@12100000 {
+			compatible = "arm,mmu-500";
+			reg = <0x0 0x12100000 0x0 0x10000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <11>;
+			interrupts = <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>, /* Global secure fault */
+				     <GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>, /* Global non-secure fault */
+				     <GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH>, /* Combined secure interrupt */
+				     <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>, /* Combined non-secure interrupt */
+				     /* Performance counter interrupts */
+				     <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>, /* for CAM_CSI   */
+				     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>, /* for CAM_DP_0  */
+				     <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>, /* for CAM_DP_1  */
+				     <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>, /* for CAM_ISP_0 */
+				     <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>, /* for CAM_ISP_1 */
+				     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>, /* for CAM_MFC_0 */
+				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>, /* for CAM_MFC_1 */
+				     /* Per context non-secure context interrupts, 0-7 interrupts */
+				     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>, /* for CONTEXT_0 */
+				     <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>, /* for CONTEXT_1 */
+				     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>, /* for CONTEXT_2 */
+				     <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>, /* for CONTEXT_3 */
+				     <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>, /* for CONTEXT_4 */
+				     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>, /* for CONTEXT_5 */
+				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>, /* for CONTEXT_6 */
+				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>; /* for CONTEXT_7 */
+			status = "disabled";
+		};
+
+		smmu_imem: iommu@10200000 {
+			compatible = "arm,mmu-500";
+			reg = <0x0 0x10200000 0x0 0x10000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <7>;
+			interrupts = <GIC_SPI 438 IRQ_TYPE_LEVEL_HIGH>, /* Global secure fault */
+				     <GIC_SPI 439 IRQ_TYPE_LEVEL_HIGH>, /* Global non-secure fault */
+				     <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>, /* Combined secure interrupt */
+				     <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>, /* Combined non-secure interrupt */
+				     /* Performance counter interrupts */
+				     <GIC_SPI 441 IRQ_TYPE_LEVEL_HIGH>, /* for FSYS1_0 */
+				     <GIC_SPI 442 IRQ_TYPE_LEVEL_HIGH>, /* for FSYS1_1 */
+				     <GIC_SPI 443 IRQ_TYPE_LEVEL_HIGH>, /* for IMEM_0  */
+				     /* Per context non-secure context interrupts, 0-3 interrupts */
+				     <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>, /* for CONTEXT_0 */
+				     <GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH>, /* for CONTEXT_1 */
+				     <GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>, /* for CONTEXT_2 */
+				     <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>; /* for CONTEXT_3 */
+			status = "disabled";
+		};
+
+		smmu_peric: iommu@14900000 {
+			compatible = "arm,mmu-500";
+			reg = <0x0 0x14900000 0x0 0x10000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <5>;
+			interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>, /* Global secure fault */
+				     <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>, /* Global non-secure fault */
+				     <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>, /* Combined secure interrupt */
+				     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>, /* Combined non-secure interrupt */
+				     /* Performance counter interrupts */
+				     <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>, /* for PERIC */
+				     /* Per context non-secure context interrupts, 0-1 interrupts */
+				     <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>, /* for CONTEXT_0 */
+				     <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>; /* for CONTEXT_1 */
+			status = "disabled";
+		};
+
+		smmu_fsys0: iommu@15450000 {
+			compatible = "arm,mmu-500";
+			reg = <0x0 0x15450000 0x0 0x10000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <5>;
+			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>, /* Global secure fault */
+				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>, /* Global non-secure fault */
+				     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>, /* Combined secure interrupt */
+				     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>, /* Combined non-secure interrupt */
+				     /* Performance counter interrupts */
+				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>, /* for FSYS0   */
+				     /* Per context non-secure context interrupts, 0-1 interrupts */
+				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>, /* for CONTEXT_0 */
+				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>; /* for CONTEXT_1 */
+			status = "disabled";
+		};
+
+		clock_cmu: clock-controller@11C10000 {
+			compatible = "tesla,fsd-clock-cmu";
+			reg = <0x0 0x11C10000 0x0 0x3000>;
+			#clock-cells = <1>;
+			clocks = <&fin_pll>;
+			clock-names = "fin_pll";
+			status = "disabled";
+		};
+
+		clock_imem: clock-controller@10010000 {
+			compatible = "tesla,fsd-clock-imem";
+			reg = <0x0 0x10010000 0x0 0x3000>;
+			#clock-cells = <1>;
+			clocks = <&fin_pll>,
+				<&clock_cmu DOUT_CMU_IMEM_TCUCLK>,
+				<&clock_cmu DOUT_CMU_IMEM_ACLK>,
+				<&clock_cmu DOUT_CMU_IMEM_DMACLK>;
+			clock-names = "fin_pll",
+				"dout_cmu_imem_tcuclk",
+				"dout_cmu_imem_aclk",
+				"dout_cmu_imem_dmaclk";
+			status = "disabled";
+		};
+
+		clock_peric: clock-controller@14010000 {
+			compatible = "tesla,fsd-clock-peric";
+			reg = <0x0 0x14010000 0x0 0x3000>;
+			#clock-cells = <1>;
+			clocks = <&fin_pll>,
+				<&clock_cmu DOUT_CMU_PLL_SHARED0_DIV4>,
+				<&clock_cmu DOUT_CMU_PERIC_SHARED1DIV36>,
+				<&clock_cmu DOUT_CMU_PERIC_SHARED0DIV3_TBUCLK>,
+				<&clock_cmu DOUT_CMU_PERIC_SHARED0DIV20>,
+				<&clock_cmu DOUT_CMU_PERIC_SHARED1DIV4_DMACLK>;
+			clock-names = "fin_pll",
+				"dout_cmu_pll_shared0_div4",
+				"dout_cmu_peric_shared1div36",
+				"dout_cmu_peric_shared0div3_tbuclk",
+				"dout_cmu_peric_shared0div20",
+				"dout_cmu_peric_shared1div4_dmaclk";
+			status = "disabled";
+		};
+
+		clock_fsys0: clock-controller@15010000 {
+			compatible = "tesla,fsd-clock-fsys0";
+			reg = <0x0 0x15010000 0x0 0x3000>;
+			#clock-cells = <1>;
+			clocks = <&fin_pll>,
+				<&clock_cmu DOUT_CMU_PLL_SHARED0_DIV6>,
+				<&clock_cmu DOUT_CMU_FSYS0_SHARED1DIV4>,
+				<&clock_cmu DOUT_CMU_FSYS0_SHARED0DIV4>;
+			clock-names = "fin_pll",
+				"dout_cmu_pll_shared0_div6",
+				"dout_cmu_fsys0_shared1div4",
+				"dout_cmu_fsys0_shared0div4";
+			status = "disabled";
+		};
+
+		clock_fsys1: clock-controller@16810000 {
+			compatible = "tesla,fsd-clock-fsys1";
+			reg = <0x0 0x16810000 0x0 0x3000>;
+			#clock-cells = <1>;
+			clocks = <&fin_pll>,
+				<&clock_cmu DOUT_CMU_FSYS1_SHARED0DIV8>,
+				<&clock_cmu DOUT_CMU_FSYS1_SHARED0DIV4>;
+			clock-names = "fin_pll",
+				"dout_cmu_fsys1_shared0div8",
+				"dout_cmu_fsys1_shared0div4";
+			status = "disabled";
+		};
+
+		clock_mfc: clock-controller@12810000 {
+			compatible = "tesla,fsd-clock-mfc";
+			reg = <0x0 0x12810000 0x0 0x3000>;
+			#clock-cells = <1>;
+			clocks = <&fin_pll>;
+			clock-names = "fin_pll";
+			status = "disabled";
+		};
+
+		clock_csi: clock-controller@12610000 {
+			compatible = "tesla,fsd-clock-cam_csi";
+			reg = <0x0 0x12610000 0x0 0x3000>;
+			#clock-cells = <1>;
+			clocks = <&fin_pll>;
+			clock-names = "fin_pll";
+			status = "disabled";
+		};
+
+		mdma0: mdma@10100000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x0 0x10100000 0x0 0x1000>;
+			interrupts = <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
+			clocks = <&clock_imem IMEM_DMA0_IPCLKPORT_ACLK>;
+			clock-names = "apb_pclk";
+			iommus = <&smmu_imem 0x800 0x0>;
+			status = "disabled";
+		};
+
+		mdma1: mdma@10110000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x0 0x10110000 0x0 0x1000>;
+			interrupts = <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
+			clocks = <&clock_imem IMEM_DMA1_IPCLKPORT_ACLK>;
+			clock-names = "apb_pclk";
+			iommus = <&smmu_imem 0x801 0x0>;
+			status = "disabled";
+		};
+
+		pdma0: pdma@14280000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x0 0x14280000 0x0 0x1000>;
+			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
+			clocks = <&clock_peric PERIC_DMA0_IPCLKPORT_ACLK>;
+			clock-names = "apb_pclk";
+			iommus = <&smmu_peric 0x2 0x0>;
+			status = "disabled";
+		};
+
+		pdma1: pdma@14290000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x0 0x14290000 0x0 0x1000>;
+			interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
+			clocks = <&clock_peric PERIC_DMA1_IPCLKPORT_ACLK>;
+			clock-names = "apb_pclk";
+			iommus = <&smmu_peric 0x1 0x0>;
+			status = "disabled";
+		};
+
+		mct: mct@10040000 {
+			compatible = "samsung,exynos4210-mct";
+			reg = <0x0 0x10040000 0x0 0x800>;
+			interrupts = <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 460 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 461 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 464 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 470 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&fin_pll>, <&clock_imem IMEM_MCT_PCLK>;
+			clock-names = "fin_pll", "mct";
+		};
+
+		serial_0: serial@14180000 {
+			compatible = "samsung,exynos4210-uart";
+			reg = <0x0 0x14180000 0x0 0x100>;
+			interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&pdma1 0>, <&pdma1 1>;
+			dma-names = "tx", "rx";
+			clocks = <&clock_peric PERIC_PCLK_UART0>,
+				 <&clock_peric PERIC_SCLK_UART0>;
+			clock-names = "uart", "clk_uart_baud0";
+			status = "disabled";
+		};
+
+		serial_1: serial@14190000 {
+			compatible = "samsung,exynos4210-uart";
+			reg = <0x0 0x14190000 0x0 0x100>;
+			interrupts = <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&pdma1 2>, <&pdma1 3>;
+			dma-names = "tx", "rx";
+			clocks = <&clock_peric PERIC_PCLK_UART1>,
+				 <&clock_peric PERIC_SCLK_UART1>;
+			clock-names = "uart", "clk_uart_baud0";
+			status = "disabled";
+		};
+
+		pmu_system_controller: system-controller@11400000 {
+			compatible = "samsung,exynos7-pmu", "syscon";
+			reg = <0x0 0x11400000 0x0 0x5000>;
+		};
+
+		watchdog_0: watchdog@100A0000 {
+			compatible = "samsung,exynos7-wdt";
+			reg = <0x0 0x100A0000 0x0 0x100>;
+			interrupts = <GIC_SPI 471 IRQ_TYPE_LEVEL_HIGH>;
+			samsung,syscon-phandle = <&pmu_system_controller>;
+			clocks = <&fin_pll>;
+			clock-names = "watchdog";
+			interrupt-mode = <1>;
+		};
+
+		watchdog_1: watchdog@100B0000 {
+			compatible = "samsung,exynos7-wdt";
+			reg = <0x0 0x100B0000 0x0 0x100>;
+			interrupts = <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>;
+			samsung,syscon-phandle = <&pmu_system_controller>;
+			clocks = <&fin_pll>;
+			clock-names = "watchdog";
+			interrupt-mode = <1>;
+		};
+
+		watchdog_2: watchdog@100C0000 {
+			compatible = "samsung,exynos7-wdt";
+			reg = <0x0 0x100C0000 0x0 0x100>;
+			interrupts = <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>;
+			samsung,syscon-phandle = <&pmu_system_controller>;
+			clocks = <&fin_pll>;
+			clock-names = "watchdog";
+			interrupt-mode = <1>;
+		};
+
+		pwm_0: pwm@14100000 {
+			compatible = "samsung,exynos4210-pwm";
+			reg = <0x0 0x14100000 0x0 0x100>;
+			samsung,pwm-outputs = <0>, <1>, <2>, <3>;
+			#pwm-cells = <3>;
+			clocks = <&clock_peric PERIC_PWM0_IPCLKPORT_I_PCLK_S0>;
+			clock-names = "timers";
+			status = "disabled";
+		};
+
+		pwm_1: pwm@14110000 {
+			compatible = "samsung,exynos4210-pwm";
+			reg = <0x0 0x14110000 0x0 0x100>;
+			samsung,pwm-outputs = <0>, <1>, <2>, <3>;
+			#pwm-cells = <3>;
+			clocks = <&clock_peric PERIC_PWM1_IPCLKPORT_I_PCLK_S0>;
+			clock-names = "timers";
+			status = "disabled";
+		};
+
+		hsi2c_0: hsi2c@14200000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x0 0x14200000 0x0 0x1000>;
+			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c0_bus>;
+			clocks = <&clock_peric PERIC_PCLK_HSI2C0>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_1: hsi2c@14210000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x0 0x14210000 0x0 0x1000>;
+			interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c1_bus>;
+			clocks = <&clock_peric PERIC_PCLK_HSI2C1>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_2: hsi2c@14220000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x0 0x14220000 0x0 0x1000>;
+			interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c2_bus>;
+			clocks = <&clock_peric PERIC_PCLK_HSI2C2>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_3: hsi2c@14230000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x0 0x14230000 0x0 0x1000>;
+			interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c3_bus>;
+			clocks = <&clock_peric PERIC_PCLK_HSI2C3>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_4: hsi2c@14240000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x0 0x14240000 0x0 0x1000>;
+			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c4_bus>;
+			clocks = <&clock_peric PERIC_PCLK_HSI2C4>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_5: hsi2c@14250000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x0 0x14250000 0x0 0x1000>;
+			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c5_bus>;
+			clocks = <&clock_peric PERIC_PCLK_HSI2C5>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_6: hsi2c@14260000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x0 0x14260000 0x0 0x1000>;
+			interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c6_bus>;
+			clocks = <&clock_peric PERIC_PCLK_HSI2C6>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_7: hsi2c@14270000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x0 0x14270000 0x0 0x1000>;
+			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c7_bus>;
+			clocks = <&clock_peric PERIC_PCLK_HSI2C7>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+	};
+};
-- 
2.17.1


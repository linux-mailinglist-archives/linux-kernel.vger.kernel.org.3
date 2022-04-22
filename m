Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E44650C21D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbiDVWJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbiDVWHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:07:40 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71DF2E6631;
        Fri, 22 Apr 2022 13:53:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVBSeJxlFv0uTrbIr/UV1uAarLbosyTxN0z8iTjKMNtTO6jYA1+o9hZvyJD35jjSspq18WeZy8WXM63r/pu0eTMM2ovbdneQf9iCcbG/luGE0WyFv0aIqMflgdnJBkfyAlQoNtOhz29nJLWVKIUYWvEATN/svnJ8yIL6c5iucoWkBaswaqxjT7Dreof3vEbIpw+yTUcAhOFjoSAeDur2Ljit6giVHti1rxEllvBWzsljVZ34PcmwTzaxVEajwcw1qgelngTFibduc22t0VvdLm5tTVu6ifmPKp0ypu2PPMzlMhlWLcjMnJTYfI8RSOAEq1xhgalSkbu+vPg5K32fcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmtAVw5BCxoaNwfpB1twrKP/angLHxvgQQbR8DZ8wSw=;
 b=g4fUWS4rmqNUZKH0FBB5rs6de+1MKk//WwEzh5Er2e3Q+XZUDqnOIUR1otQd1xUtGF6qVXUg1G/ctqZskq9xvJi3UQ/sRoqoiGh1Xawx0nQB9HnjlnNM+i2QpdizJeWEyKvqukTUMuOtaxLW28z8IZBzZh6K9pZvH190ob23mKg+nzI3vKx+RDy0DAuv1DKYhydCjvXdPTZD9T2Qrweo+eTHzp+SZa+0Tsx8PGeQDxjH0iPgEcVsZ42b/6fyiSJLhXK+TgkRG/P7UQGmpbSldqTjR28Rq+1lsq/iSOZf0zXj6teAI8BuTNYJufSeeGJn1ItQzh9bdwLnb5JZ+hjN5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmtAVw5BCxoaNwfpB1twrKP/angLHxvgQQbR8DZ8wSw=;
 b=BdbSpDon8lBtYxKGhjfPsJp6sV+QdWpSM9jBw1gaWayS9Tt0gaqTJ/8Y+C8IUkYRbNPNPJ5HbDggiansHQlhPwVMEism/NhkAGGuJcpKyrcrwKoPRr9OUmVm40AQGSirI4v7RhxDYuOH/zE/QVxUkAAuLEslfgNLaM8o7PQ3wD4WMFBR84NHeMkhEHkH6iZjLwj5wsXMnn81KkFW8pJOwq7eKF422GYKjKU6OJyXlN62ko8tyoJDSALHrOFo8vy7Znwm8bL3RvG+CbHAwhj0pNXH/FhZejQfzLklNz5ExsJT5A9cP4lcBVMfwJRfBfVJh9x+q0qRDFRB5GYciEGBEg==
Received: from BN9PR03CA0195.namprd03.prod.outlook.com (2603:10b6:408:f9::20)
 by BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 20:53:06 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::25) by BN9PR03CA0195.outlook.office365.com
 (2603:10b6:408:f9::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Fri, 22 Apr 2022 20:53:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 20:53:06 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 22 Apr
 2022 20:52:21 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 22 Apr
 2022 13:52:20 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Fri, 22 Apr 2022 13:52:20 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <smangipudi@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH v6 03/10] hte: Add tegra194 HTE kernel provider
Date:   Fri, 22 Apr 2022 13:52:14 -0700
Message-ID: <20220422205221.952-4-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220422205221.952-1-dipenp@nvidia.com>
References: <20220422205221.952-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d58eaec-25eb-4409-e996-08da24a21a26
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5126452D957B73E9FA03AC28AEF79@BL1PR12MB5126.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +u9XYcRjGXm1Qk/8Cbr8eN99CklseaYH9JBn8sizVU4xA9DyT8S/CsVWuhp3vLfFGHN0aGlbNNOHK0kLtBV7jUUHSTw//FjHFU8r4bm+DI0cjB4ZL/A6HObP3lyzup2WwrpY2JfEmxJyd/UdNfUgX5ZViOUHBVCQc1LFAOPa+S7oILOnH3XgUy9LAaqinMv/XhtsUR+Aqysxk1vqwPGdqjGOe/uDZaieETeOgahs+XopvzElmZoguVUULg0rvSymQl1MoMPn1rRlnp3H31wjWvrypiAalB1h3kXM14yx0WTvEXLpetOlK6v9fi1tLHz6YHTH7Ebj4DLhbQM+dogmVRc3WfOJf+mTHY+9LJjktNWP2xhWIRtwIkRvjdMiFctRMPaMHkNSymoEWqROm2EbiVkFpwShNBtdF9ctjVEnsbJOvXJPuQeIWfB3bEYL/7w6JukeZh8zwfua3zFBbn+xhODpDLJOimnwTDZkAs9JakzAw2LDascNWmYTcKXhBOkehsY5H0zGfMPNTeVF9kqXFgSWOT1MlQLXaJY/oSH5/wvIceqR2aNo6NZ5yd4Evg9oMr/RS+0mOEBuqFWka+3CYzjwVSR+BU64mCfD00spkN5bIBTnsRpOWyd8FtFntA6ItvpABC/vQwv2vWltYQLcyhM8lJl3A5Wd3D0mfzcMPsgRi9tG2/7rx9rj8trxd59nLIXCmJ4EUPWP7H+1CqoUzG7CpBXkdw1r0IHA1QbPnO/YWSMXTn3YPbxjJbYRGp/Gsiq+bxu6ajnO8t5L6cz+MA==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(186003)(336012)(6666004)(426003)(47076005)(36756003)(316002)(30864003)(921005)(107886003)(1076003)(2906002)(7696005)(82310400005)(110136005)(70586007)(70206006)(2616005)(8676002)(4326008)(26005)(5660300002)(86362001)(508600001)(7416002)(40460700003)(83380400001)(8936002)(356005)(81166007)(36860700001)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 20:53:06.6687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d58eaec-25eb-4409-e996-08da24a21a26
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5126
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra194 device has multiple HTE instances also known as GTE
(Generic hardware Timestamping Engine) which can timestamp subset of
SoC lines/signals. This provider driver focuses on IRQ and GPIO lines
and exposes timestamping ability on those lines to the consumers
through HTE subsystem.

Also, with this patch, added:
- documentation about this provider and its capabilities at
Documentation/hte.
- Compilation support in Makefile and Kconfig

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
Reported-by: kernel test robot <lkp@intel.com>
---
Changes in v3:
- Addressed grammatical/spelling errors.

Changes in v4:
- Added gpio line level detection.
- Added edge setup for GPIO lines if requested.
- Added match_from_linedata callback to help hte_req_ts_by_linedata_ns
HTE API.

Changes in v6:
- Added xlate_plat support.
- Added secondary mapping of the GPIO lines to GTE namespace.

 Documentation/hte/index.rst        |  22 +
 Documentation/hte/tegra194-hte.rst |  47 ++
 Documentation/index.rst            |   1 +
 drivers/hte/Kconfig                |  12 +
 drivers/hte/Makefile               |   1 +
 drivers/hte/hte-tegra194.c         | 730 +++++++++++++++++++++++++++++
 6 files changed, 813 insertions(+)
 create mode 100644 Documentation/hte/index.rst
 create mode 100644 Documentation/hte/tegra194-hte.rst
 create mode 100644 drivers/hte/hte-tegra194.c

diff --git a/Documentation/hte/index.rst b/Documentation/hte/index.rst
new file mode 100644
index 000000000000..9f43301c05dc
--- /dev/null
+++ b/Documentation/hte/index.rst
@@ -0,0 +1,22 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============================================
+The Linux Hardware Timestamping Engine (HTE)
+============================================
+
+The HTE Subsystem
+=================
+
+.. toctree::
+   :maxdepth: 1
+
+   hte
+
+HTE Tegra Provider
+==================
+
+.. toctree::
+   :maxdepth: 1
+
+   tegra194-hte
+
diff --git a/Documentation/hte/tegra194-hte.rst b/Documentation/hte/tegra194-hte.rst
new file mode 100644
index 000000000000..4037b1c8224a
--- /dev/null
+++ b/Documentation/hte/tegra194-hte.rst
@@ -0,0 +1,47 @@
+HTE Kernel provider driver
+==========================
+
+Description
+-----------
+The Nvidia tegra194 HTE provider driver implements two GTE
+(Generic Timestamping Engine) instances: 1) GPIO GTE and 2) LIC
+(Legacy Interrupt Controller) IRQ GTE. Both GTE instances get the
+timestamp from the system counter TSC which has 31.25MHz clock rate, and the
+driver converts clock tick rate to nanoseconds before storing it as timestamp
+value.
+
+GPIO GTE
+--------
+
+This GTE instance timestamps GPIO in real time. For that to happen GPIO
+needs to be configured as input. The always on (AON) GPIO controller instance
+supports timestamping GPIOs in real time and it has 39 GPIO lines. The GPIO GTE
+and AON GPIO controller are tightly coupled as it requires very specific bits
+to be set in GPIO config register before GPIO GTE can be used, for that GPIOLIB
+adds two optional APIs as below. The GPIO GTE code supports both kernel
+and userspace consumers. The kernel space consumers can directly talk to HTE
+subsystem while userspace consumers timestamp requests go through GPIOLIB CDEV
+framework to HTE subsystem.
+
+.. kernel-doc:: drivers/gpio/gpiolib.c
+   :functions: gpiod_enable_hw_timestamp_ns gpiod_disable_hw_timestamp_ns
+
+For userspace consumers, GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE flag must be
+specified during IOCTL calls. Refer to ``tools/gpio/gpio-event-mon.c``, which
+returns the timestamp in nanoseconds.
+
+LIC (Legacy Interrupt Controller) IRQ GTE
+-----------------------------------------
+
+This GTE instance timestamps LIC IRQ lines in real time. There are 352 IRQ
+lines which this instance can add timestamps to in real time. The hte
+devicetree binding described at ``Documentation/devicetree/bindings/hte/``
+provides an example of how a consumer can request an IRQ line. Since it is a
+one-to-one mapping with IRQ GTE provider, consumers can simply specify the IRQ
+number that they are interested in. There is no userspace consumer support for
+this GTE instance in the HTE framework.
+
+The provider source code of both IRQ and GPIO GTE instances is located at
+``drivers/hte/hte-tegra194.c``. The test driver
+``drivers/hte/hte-tegra194-test.c`` demonstrates HTE API usage for both IRQ
+and GPIO GTE.
diff --git a/Documentation/index.rst b/Documentation/index.rst
index ee639a500278..90eaf47e5214 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -140,6 +140,7 @@ needed).
    mhi/index
    tty/index
    peci/index
+   hte/index
 
 Architecture-agnostic documentation
 -----------------------------------
diff --git a/drivers/hte/Kconfig b/drivers/hte/Kconfig
index 478a80a2f384..3bd0fa367e84 100644
--- a/drivers/hte/Kconfig
+++ b/drivers/hte/Kconfig
@@ -12,3 +12,15 @@ menuconfig HTE
 
 	  If unsure, say no.
 
+if HTE
+
+config HTE_TEGRA194
+	tristate "NVIDIA Tegra194 HTE Support"
+	depends on ARCH_TEGRA_194_SOC
+	help
+	  Enable this option for integrated hardware timestamping engine also
+	  known as generic timestamping engine (GTE) support on NVIDIA Tegra194
+	  systems-on-chip. The driver supports 352 LIC IRQs and 39 AON GPIOs
+	  lines for timestamping in realtime.
+
+endif
diff --git a/drivers/hte/Makefile b/drivers/hte/Makefile
index fc03bdf44427..3ae7c4029991 100644
--- a/drivers/hte/Makefile
+++ b/drivers/hte/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_HTE)		+= hte.o
+obj-$(CONFIG_HTE_TEGRA194)	+= hte-tegra194.o
 
diff --git a/drivers/hte/hte-tegra194.c b/drivers/hte/hte-tegra194.c
new file mode 100644
index 000000000000..6765f07e5adb
--- /dev/null
+++ b/drivers/hte/hte-tegra194.c
@@ -0,0 +1,730 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021-2022 NVIDIA Corporation
+ *
+ * Author: Dipen Patel <dipenp@nvidia.com>
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/stat.h>
+#include <linux/interrupt.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/hte.h>
+#include <linux/uaccess.h>
+#include <linux/gpio/driver.h>
+#include <linux/gpio/consumer.h>
+
+#define HTE_SUSPEND	0
+
+/* HTE source clock TSC is 31.25MHz */
+#define HTE_TS_CLK_RATE_HZ	31250000ULL
+#define HTE_CLK_RATE_NS		32
+#define HTE_TS_NS_SHIFT	__builtin_ctz(HTE_CLK_RATE_NS)
+
+#define NV_AON_SLICE_INVALID	-1
+#define NV_LINES_IN_SLICE	32
+
+/* AON HTE line map For slice 1 */
+#define NV_AON_HTE_SLICE1_IRQ_GPIO_28	12
+#define NV_AON_HTE_SLICE1_IRQ_GPIO_29	13
+
+/* AON HTE line map For slice 2 */
+#define NV_AON_HTE_SLICE2_IRQ_GPIO_0	0
+#define NV_AON_HTE_SLICE2_IRQ_GPIO_1	1
+#define NV_AON_HTE_SLICE2_IRQ_GPIO_2	2
+#define NV_AON_HTE_SLICE2_IRQ_GPIO_3	3
+#define NV_AON_HTE_SLICE2_IRQ_GPIO_4	4
+#define NV_AON_HTE_SLICE2_IRQ_GPIO_5	5
+#define NV_AON_HTE_SLICE2_IRQ_GPIO_6	6
+#define NV_AON_HTE_SLICE2_IRQ_GPIO_7	7
+#define NV_AON_HTE_SLICE2_IRQ_GPIO_8	8
+#define NV_AON_HTE_SLICE2_IRQ_GPIO_9	9
+#define NV_AON_HTE_SLICE2_IRQ_GPIO_10	10
+#define NV_AON_HTE_SLICE2_IRQ_GPIO_11	11
+#define NV_AON_HTE_SLICE2_IRQ_GPIO_12	12
+#define NV_AON_HTE_SLICE2_IRQ_GPIO_13	13
+#define NV_AON_HTE_SLICE2_IRQ_GPIO_14	14
+#define NV_AON_HTE_SLICE2_IRQ_GPIO_15	15
+#define NV_AON_HTE_SLICE2_IRQ_GPIO_16	16
+#define NV_AON_HTE_SLICE2_IRQ_GPIO_17	17
+#define NV_AON_HTE_SLICE2_IRQ_GPIO_18	18
+#define NV_AON_HTE_SLICE2_IRQ_GPIO_19	19
+#define NV_AON_HTE_SLICE2_IRQ_GPIO_20	20
+#define NV_AON_HTE_SLICE2_IRQ_GPIO_21	21
+#define NV_AON_HTE_SLICE2_IRQ_GPIO_22	22
+#define NV_AON_HTE_SLICE2_IRQ_GPIO_23	23
+#define NV_AON_HTE_SLICE2_IRQ_GPIO_24	24
+#define NV_AON_HTE_SLICE2_IRQ_GPIO_25	25
+#define NV_AON_HTE_SLICE2_IRQ_GPIO_26	26
+#define NV_AON_HTE_SLICE2_IRQ_GPIO_27	27
+
+#define HTE_TECTRL		0x0
+#define HTE_TETSCH		0x4
+#define HTE_TETSCL		0x8
+#define HTE_TESRC		0xC
+#define HTE_TECCV		0x10
+#define HTE_TEPCV		0x14
+#define HTE_TECMD		0x1C
+#define HTE_TESTATUS		0x20
+#define HTE_SLICE0_TETEN	0x40
+#define HTE_SLICE1_TETEN	0x60
+
+#define HTE_SLICE_SIZE		(HTE_SLICE1_TETEN - HTE_SLICE0_TETEN)
+
+#define HTE_TECTRL_ENABLE_ENABLE	0x1
+
+#define HTE_TECTRL_OCCU_SHIFT		0x8
+#define HTE_TECTRL_INTR_SHIFT		0x1
+#define HTE_TECTRL_INTR_ENABLE		0x1
+
+#define HTE_TESRC_SLICE_SHIFT		16
+#define HTE_TESRC_SLICE_DEFAULT_MASK	0xFF
+
+#define HTE_TECMD_CMD_POP		0x1
+
+#define HTE_TESTATUS_OCCUPANCY_SHIFT	8
+#define HTE_TESTATUS_OCCUPANCY_MASK	0xFF
+
+enum tegra_hte_type {
+	HTE_TEGRA_TYPE_GPIO = 1U << 0,
+	HTE_TEGRA_TYPE_LIC = 1U << 1,
+};
+
+struct hte_slices {
+	u32 r_val;
+	unsigned long flags;
+	/* to prevent lines mapped to same slice updating its register */
+	spinlock_t s_lock;
+};
+
+struct tegra_hte_line_mapped {
+	int slice;
+	u32 bit_index;
+};
+
+struct tegra_hte_line_data {
+	unsigned long flags;
+	void *data;
+};
+
+struct tegra_hte_data {
+	enum tegra_hte_type type;
+	u32 map_sz;
+	u32 sec_map_sz;
+	const struct tegra_hte_line_mapped *map;
+	const struct tegra_hte_line_mapped *sec_map;
+};
+
+struct tegra_hte_soc {
+	int hte_irq;
+	u32 itr_thrshld;
+	u32 conf_rval;
+	struct hte_slices *sl;
+	const struct tegra_hte_data *prov_data;
+	struct tegra_hte_line_data *line_data;
+	struct hte_chip *chip;
+	struct gpio_chip *c;
+	void __iomem *regs;
+};
+
+static const struct tegra_hte_line_mapped tegra194_aon_gpio_map[] = {
+	/* gpio, slice, bit_index */
+	/* AA port */
+	[0]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_11},
+	[1]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_10},
+	[2]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_9},
+	[3]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_8},
+	[4]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_7},
+	[5]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_6},
+	[6]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_5},
+	[7]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_4},
+	/* BB port */
+	[8]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_3},
+	[9]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_2},
+	[10] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_1},
+	[11] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_0},
+	/* CC port */
+	[12] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_22},
+	[13] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_21},
+	[14] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_20},
+	[15] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_19},
+	[16] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_18},
+	[17] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_17},
+	[18] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_16},
+	[19] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_15},
+	/* DD port */
+	[20] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_14},
+	[21] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_13},
+	[22] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_12},
+	/* EE port */
+	[23] = {1, NV_AON_HTE_SLICE1_IRQ_GPIO_29},
+	[24] = {1, NV_AON_HTE_SLICE1_IRQ_GPIO_28},
+	[25] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_27},
+	[26] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_26},
+	[27] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_25},
+	[28] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_24},
+	[29] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_23},
+};
+
+static const struct tegra_hte_line_mapped tegra194_aon_gpio_sec_map[] = {
+	/* gpio, slice, bit_index */
+	/* AA port */
+	[0]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_11},
+	[1]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_10},
+	[2]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_9},
+	[3]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_8},
+	[4]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_7},
+	[5]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_6},
+	[6]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_5},
+	[7]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_4},
+	/* BB port */
+	[8]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_3},
+	[9]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_2},
+	[10] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_1},
+	[11] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_0},
+	[12]  = {NV_AON_SLICE_INVALID, 0},
+	[13]  = {NV_AON_SLICE_INVALID, 0},
+	[14] = {NV_AON_SLICE_INVALID, 0},
+	[15] = {NV_AON_SLICE_INVALID, 0},
+	/* CC port */
+	[16] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_22},
+	[17] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_21},
+	[18] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_20},
+	[19] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_19},
+	[20] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_18},
+	[21] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_17},
+	[22] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_16},
+	[23] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_15},
+	/* DD port */
+	[24] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_14},
+	[25] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_13},
+	[26] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_12},
+	[27] = {NV_AON_SLICE_INVALID, 0},
+	[28] = {NV_AON_SLICE_INVALID, 0},
+	[29] = {NV_AON_SLICE_INVALID, 0},
+	[30] = {NV_AON_SLICE_INVALID, 0},
+	[31] = {NV_AON_SLICE_INVALID, 0},
+	/* EE port */
+	[32] = {1, NV_AON_HTE_SLICE1_IRQ_GPIO_29},
+	[33] = {1, NV_AON_HTE_SLICE1_IRQ_GPIO_28},
+	[34] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_27},
+	[35] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_26},
+	[36] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_25},
+	[37] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_24},
+	[38] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_23},
+	[39] = {NV_AON_SLICE_INVALID, 0},
+};
+
+static const struct tegra_hte_data aon_hte = {
+	.map_sz = ARRAY_SIZE(tegra194_aon_gpio_map),
+	.map = tegra194_aon_gpio_map,
+	.sec_map_sz = ARRAY_SIZE(tegra194_aon_gpio_sec_map),
+	.sec_map = tegra194_aon_gpio_sec_map,
+	.type = HTE_TEGRA_TYPE_GPIO,
+};
+
+static const struct tegra_hte_data lic_hte = {
+	.map_sz = 0,
+	.map = NULL,
+	.type = HTE_TEGRA_TYPE_LIC,
+};
+
+static inline u32 tegra_hte_readl(struct tegra_hte_soc *hte, u32 reg)
+{
+	return readl(hte->regs + reg);
+}
+
+static inline void tegra_hte_writel(struct tegra_hte_soc *hte, u32 reg,
+				    u32 val)
+{
+	writel(val, hte->regs + reg);
+}
+
+static int tegra_hte_map_to_line_id(u32 eid,
+				    const struct tegra_hte_line_mapped *m,
+				    u32 map_sz, u32 *mapped)
+{
+
+	if (m) {
+		if (eid > map_sz)
+			return -EINVAL;
+		if (m[eid].slice == NV_AON_SLICE_INVALID)
+			return -EINVAL;
+
+		*mapped = (m[eid].slice << 5) + m[eid].bit_index;
+	} else {
+		*mapped = eid;
+	}
+
+	return 0;
+}
+
+static int tegra_hte_line_xlate(struct hte_chip *gc,
+				const struct of_phandle_args *args,
+				struct hte_ts_desc *desc, u32 *xlated_id)
+{
+	int ret = 0;
+	u32 line_id;
+	struct tegra_hte_soc *gs;
+	const struct tegra_hte_line_mapped *map = NULL;
+	u32 map_sz = 0;
+
+	if (!gc || !desc || !xlated_id)
+		return -EINVAL;
+
+	if (args) {
+		if (gc->of_hte_n_cells < 1)
+			return -EINVAL;
+
+		if (args->args_count != gc->of_hte_n_cells)
+			return -EINVAL;
+
+		desc->attr.line_id = args->args[0];
+	}
+
+	gs = gc->data;
+	if (!gs || !gs->prov_data)
+		return -EINVAL;
+
+	/*
+	 *
+	 * There are two paths GPIO consumers can take as follows:
+	 * 1) The consumer (gpiolib-cdev for example) which uses GPIO global
+	 * number which gets assigned run time.
+	 * 2) The consumer passing GPIO from the DT which is assigned
+	 * statically for example by using TEGRA194_AON_GPIO gpio DT binding.
+	 *
+	 * The code below addresses both the consumer use cases and maps into
+	 * HTE/GTE namespace.
+	 */
+	if (gs->prov_data->type == HTE_TEGRA_TYPE_GPIO && !args) {
+		line_id = desc->attr.line_id - gs->c->base;
+		map = gs->prov_data->map;
+		map_sz = gs->prov_data->map_sz;
+	} else if (gs->prov_data->type == HTE_TEGRA_TYPE_GPIO && args) {
+		line_id = desc->attr.line_id;
+		map = gs->prov_data->sec_map;
+		map_sz = gs->prov_data->sec_map_sz;
+	} else {
+		line_id = desc->attr.line_id;
+	}
+
+	ret = tegra_hte_map_to_line_id(line_id, map, map_sz, xlated_id);
+	if (ret < 0) {
+		dev_err(gc->dev, "line_id:%u mapping failed\n",
+			desc->attr.line_id);
+		return ret;
+	}
+
+	if (*xlated_id > gc->nlines)
+		return -EINVAL;
+
+	dev_dbg(gc->dev, "requested id:%u, xlated id:%u\n",
+		desc->attr.line_id, *xlated_id);
+
+	return 0;
+}
+
+static int tegra_hte_line_xlate_plat(struct hte_chip *gc,
+				     struct hte_ts_desc *desc, u32 *xlated_id)
+{
+	return tegra_hte_line_xlate(gc, NULL, desc, xlated_id);
+}
+
+static int tegra_hte_en_dis_common(struct hte_chip *chip, u32 line_id, bool en)
+{
+	u32 slice, sl_bit_shift, line_bit, val, reg;
+	struct tegra_hte_soc *gs;
+
+	sl_bit_shift = __builtin_ctz(HTE_SLICE_SIZE);
+
+	if (!chip)
+		return -EINVAL;
+
+	gs = chip->data;
+
+	if (line_id > chip->nlines) {
+		dev_err(chip->dev,
+			"line id: %u is not supported by this controller\n",
+			line_id);
+		return -EINVAL;
+	}
+
+	slice = line_id >> sl_bit_shift;
+	line_bit = line_id & (HTE_SLICE_SIZE - 1);
+	reg = (slice << sl_bit_shift) + HTE_SLICE0_TETEN;
+
+	spin_lock(&gs->sl[slice].s_lock);
+
+	if (test_bit(HTE_SUSPEND, &gs->sl[slice].flags)) {
+		spin_unlock(&gs->sl[slice].s_lock);
+		dev_dbg(chip->dev, "device suspended");
+		return -EBUSY;
+	}
+
+	val = tegra_hte_readl(gs, reg);
+	if (en)
+		val = val | (1 << line_bit);
+	else
+		val = val & (~(1 << line_bit));
+	tegra_hte_writel(gs, reg, val);
+
+	spin_unlock(&gs->sl[slice].s_lock);
+
+	dev_dbg(chip->dev, "line: %u, slice %u, line_bit %u, reg:0x%x\n",
+		line_id, slice, line_bit, reg);
+
+	return 0;
+}
+
+static int tegra_hte_enable(struct hte_chip *chip, u32 line_id)
+{
+	if (!chip)
+		return -EINVAL;
+
+	return tegra_hte_en_dis_common(chip, line_id, true);
+}
+
+static int tegra_hte_disable(struct hte_chip *chip, u32 line_id)
+{
+	if (!chip)
+		return -EINVAL;
+
+	return tegra_hte_en_dis_common(chip, line_id, false);
+}
+
+static int tegra_hte_request(struct hte_chip *chip, struct hte_ts_desc *desc,
+			     u32 line_id)
+{
+	int ret;
+	struct tegra_hte_soc *gs;
+	struct hte_line_attr *attr;
+
+	if (!chip || !chip->data || !desc)
+		return -EINVAL;
+
+	gs = chip->data;
+	attr = &desc->attr;
+
+	if (gs->prov_data->type == HTE_TEGRA_TYPE_GPIO) {
+		if (!attr->line_data)
+			return -EINVAL;
+
+		ret = gpiod_enable_hw_timestamp_ns(attr->line_data,
+						   attr->edge_flags);
+		if (ret)
+			return ret;
+
+		gs->line_data[line_id].data = attr->line_data;
+		gs->line_data[line_id].flags = attr->edge_flags;
+	}
+
+	return tegra_hte_en_dis_common(chip, line_id, true);
+}
+
+static int tegra_hte_release(struct hte_chip *chip, struct hte_ts_desc *desc,
+			     u32 line_id)
+{
+	struct tegra_hte_soc *gs;
+	struct hte_line_attr *attr;
+	int ret;
+
+	if (!chip || !chip->data || !desc)
+		return -EINVAL;
+
+	gs = chip->data;
+	attr = &desc->attr;
+
+	if (gs->prov_data->type == HTE_TEGRA_TYPE_GPIO) {
+		ret = gpiod_disable_hw_timestamp_ns(attr->line_data,
+						    gs->line_data[line_id].flags);
+		if (ret)
+			return ret;
+
+		gs->line_data[line_id].data = NULL;
+		gs->line_data[line_id].flags = 0;
+	}
+
+	return tegra_hte_en_dis_common(chip, line_id, false);
+}
+
+static int tegra_hte_clk_src_info(struct hte_chip *chip,
+				  struct hte_clk_info *ci)
+{
+	(void)chip;
+
+	if (!ci)
+		return -EINVAL;
+
+	ci->hz = HTE_TS_CLK_RATE_HZ;
+	ci->type = CLOCK_MONOTONIC;
+
+	return 0;
+}
+
+static int tegra_hte_get_level(struct tegra_hte_soc *gs, u32 line_id)
+{
+	struct gpio_desc *desc;
+
+	if (gs->prov_data->type == HTE_TEGRA_TYPE_GPIO) {
+		desc = gs->line_data[line_id].data;
+		if (desc)
+			return gpiod_get_raw_value(desc);
+	}
+
+	return -1;
+}
+
+static void tegra_hte_read_fifo(struct tegra_hte_soc *gs)
+{
+	u32 tsh, tsl, src, pv, cv, acv, slice, bit_index, line_id;
+	u64 tsc;
+	struct hte_ts_data el;
+
+	while ((tegra_hte_readl(gs, HTE_TESTATUS) >>
+		HTE_TESTATUS_OCCUPANCY_SHIFT) &
+		HTE_TESTATUS_OCCUPANCY_MASK) {
+		tsh = tegra_hte_readl(gs, HTE_TETSCH);
+		tsl = tegra_hte_readl(gs, HTE_TETSCL);
+		tsc = (((u64)tsh << 32) | tsl);
+
+		src = tegra_hte_readl(gs, HTE_TESRC);
+		slice = (src >> HTE_TESRC_SLICE_SHIFT) &
+			    HTE_TESRC_SLICE_DEFAULT_MASK;
+
+		pv = tegra_hte_readl(gs, HTE_TEPCV);
+		cv = tegra_hte_readl(gs, HTE_TECCV);
+		acv = pv ^ cv;
+		while (acv) {
+			bit_index = __builtin_ctz(acv);
+			line_id = bit_index + (slice << 5);
+			el.tsc = tsc << HTE_TS_NS_SHIFT;
+			el.raw_level = tegra_hte_get_level(gs, line_id);
+			hte_push_ts_ns(gs->chip, line_id, &el);
+			acv &= ~BIT(bit_index);
+		}
+		tegra_hte_writel(gs, HTE_TECMD, HTE_TECMD_CMD_POP);
+	}
+}
+
+static irqreturn_t tegra_hte_isr(int irq, void *dev_id)
+{
+	struct tegra_hte_soc *gs = dev_id;
+	(void)irq;
+
+	tegra_hte_read_fifo(gs);
+
+	return IRQ_HANDLED;
+}
+
+static bool tegra_hte_match_from_linedata(const struct hte_chip *chip,
+					  const struct hte_ts_desc *hdesc)
+{
+	struct tegra_hte_soc *hte_dev = chip->data;
+
+	if (!hte_dev || (hte_dev->prov_data->type != HTE_TEGRA_TYPE_GPIO))
+		return false;
+
+	return hte_dev->c == gpiod_to_chip(hdesc->attr.line_data);
+}
+
+static const struct of_device_id tegra_hte_of_match[] = {
+	{ .compatible = "nvidia,tegra194-gte-lic", .data = &lic_hte},
+	{ .compatible = "nvidia,tegra194-gte-aon", .data = &aon_hte},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tegra_hte_of_match);
+
+static const struct hte_ops g_ops = {
+	.request = tegra_hte_request,
+	.release = tegra_hte_release,
+	.enable = tegra_hte_enable,
+	.disable = tegra_hte_disable,
+	.get_clk_src_info = tegra_hte_clk_src_info,
+};
+
+static void tegra_gte_disable(void *data)
+{
+	struct platform_device *pdev = data;
+	struct tegra_hte_soc *gs = dev_get_drvdata(&pdev->dev);
+
+	tegra_hte_writel(gs, HTE_TECTRL, 0);
+}
+
+static int tegra_get_gpiochip_from_name(struct gpio_chip *chip, void *data)
+{
+	return !strcmp(chip->label, data);
+}
+
+static int tegra_hte_probe(struct platform_device *pdev)
+{
+	int ret;
+	u32 i, slices, val = 0;
+	u32 nlines;
+	struct device *dev;
+	struct tegra_hte_soc *hte_dev;
+	struct hte_chip *gc;
+
+	dev = &pdev->dev;
+
+	ret = of_property_read_u32(dev->of_node, "nvidia,slices", &slices);
+	if (ret != 0) {
+		dev_err(dev, "Could not read slices\n");
+		return -EINVAL;
+	}
+	nlines = slices << 5;
+
+	hte_dev = devm_kzalloc(dev, sizeof(*hte_dev), GFP_KERNEL);
+	if (!hte_dev)
+		return -ENOMEM;
+
+	gc = devm_kzalloc(dev, sizeof(*gc), GFP_KERNEL);
+	if (!gc)
+		return -ENOMEM;
+
+	dev_set_drvdata(&pdev->dev, hte_dev);
+	hte_dev->prov_data = of_device_get_match_data(&pdev->dev);
+
+	hte_dev->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(hte_dev->regs))
+		return PTR_ERR(hte_dev->regs);
+
+	ret = of_property_read_u32(dev->of_node, "nvidia,int-threshold",
+				   &hte_dev->itr_thrshld);
+	if (ret != 0)
+		hte_dev->itr_thrshld = 1;
+
+	hte_dev->sl = devm_kcalloc(dev, slices, sizeof(*hte_dev->sl),
+				   GFP_KERNEL);
+	if (!hte_dev->sl)
+		return -ENOMEM;
+
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0) {
+		dev_err_probe(dev, ret, "failed to get irq\n");
+		return ret;
+	}
+	hte_dev->hte_irq = ret;
+	ret = devm_request_irq(dev, hte_dev->hte_irq, tegra_hte_isr, 0,
+			       dev_name(dev), hte_dev);
+	if (ret < 0) {
+		dev_err(dev, "request irq failed.\n");
+		return ret;
+	}
+
+	gc->nlines = nlines;
+	gc->ops = &g_ops;
+	gc->dev = dev;
+	gc->data = hte_dev;
+	gc->xlate_of = tegra_hte_line_xlate;
+	gc->xlate_plat = tegra_hte_line_xlate_plat;
+	gc->of_hte_n_cells = 1;
+
+	if (hte_dev->prov_data &&
+	    hte_dev->prov_data->type == HTE_TEGRA_TYPE_GPIO) {
+		hte_dev->line_data = devm_kcalloc(dev, nlines,
+						  sizeof(*hte_dev->line_data),
+						  GFP_KERNEL);
+		if (!hte_dev->line_data)
+			return -ENOMEM;
+
+		gc->match_from_linedata = tegra_hte_match_from_linedata;
+
+		hte_dev->c = gpiochip_find("tegra194-gpio-aon",
+					   tegra_get_gpiochip_from_name);
+		if (!hte_dev->c)
+			return dev_err_probe(dev, -EPROBE_DEFER,
+					     "wait for gpio controller\n");
+	}
+
+	hte_dev->chip = gc;
+
+	ret = devm_hte_register_chip(hte_dev->chip);
+	if (ret) {
+		dev_err(gc->dev, "hte chip register failed");
+		return ret;
+	}
+
+	for (i = 0; i < slices; i++) {
+		hte_dev->sl[i].flags = 0;
+		spin_lock_init(&hte_dev->sl[i].s_lock);
+	}
+
+	val = HTE_TECTRL_ENABLE_ENABLE |
+	      (HTE_TECTRL_INTR_ENABLE << HTE_TECTRL_INTR_SHIFT) |
+	      (hte_dev->itr_thrshld << HTE_TECTRL_OCCU_SHIFT);
+	tegra_hte_writel(hte_dev, HTE_TECTRL, val);
+
+	ret = devm_add_action_or_reset(&pdev->dev, tegra_gte_disable, pdev);
+	if (ret)
+		return ret;
+
+	dev_dbg(gc->dev, "lines: %d, slices:%d", gc->nlines, slices);
+
+	return 0;
+}
+
+static int __maybe_unused tegra_hte_resume_early(struct device *dev)
+{
+	u32 i;
+	struct tegra_hte_soc *gs = dev_get_drvdata(dev);
+	u32 slices = gs->chip->nlines / NV_LINES_IN_SLICE;
+	u32 sl_bit_shift = __builtin_ctz(HTE_SLICE_SIZE);
+
+	tegra_hte_writel(gs, HTE_TECTRL, gs->conf_rval);
+
+	for (i = 0; i < slices; i++) {
+		spin_lock(&gs->sl[i].s_lock);
+		tegra_hte_writel(gs,
+				 ((i << sl_bit_shift) + HTE_SLICE0_TETEN),
+				 gs->sl[i].r_val);
+		clear_bit(HTE_SUSPEND, &gs->sl[i].flags);
+		spin_unlock(&gs->sl[i].s_lock);
+	}
+
+	return 0;
+}
+
+static int __maybe_unused tegra_hte_suspend_late(struct device *dev)
+{
+	u32 i;
+	struct tegra_hte_soc *gs = dev_get_drvdata(dev);
+	u32 slices = gs->chip->nlines / NV_LINES_IN_SLICE;
+	u32 sl_bit_shift = __builtin_ctz(HTE_SLICE_SIZE);
+
+	gs->conf_rval = tegra_hte_readl(gs, HTE_TECTRL);
+	for (i = 0; i < slices; i++) {
+		spin_lock(&gs->sl[i].s_lock);
+		gs->sl[i].r_val = tegra_hte_readl(gs,
+				((i << sl_bit_shift) + HTE_SLICE0_TETEN));
+		set_bit(HTE_SUSPEND, &gs->sl[i].flags);
+		spin_unlock(&gs->sl[i].s_lock);
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops tegra_hte_pm = {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(tegra_hte_suspend_late,
+				     tegra_hte_resume_early)
+};
+
+static struct platform_driver tegra_hte_driver = {
+	.probe = tegra_hte_probe,
+	.driver = {
+		.name = "tegra_hte",
+		.pm = &tegra_hte_pm,
+		.of_match_table = tegra_hte_of_match,
+	},
+};
+
+module_platform_driver(tegra_hte_driver);
+
+MODULE_AUTHOR("Dipen Patel <dipenp@nvidia.com>");
+MODULE_DESCRIPTION("NVIDIA Tegra HTE (Hardware Timestamping Engine) driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1


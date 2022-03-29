Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0483F4EA75C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 07:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbiC2Fr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 01:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiC2FrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 01:47:16 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2B6326EE;
        Mon, 28 Mar 2022 22:45:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KoUUadovmUfsT8ydYDd9C3SuHi00gU0BPfavyxJ9DIZAX5cqGzMU8ZANeDF0Fhh9R6+XZht35aD9Z9OC5a1NhpoEzt8WGI4LynQsxMPbBhMRwXe387Vupr7jLOZ+LIhgGXvSwNBOfjlLWJ6oqJ/jrPtdE6lNaj7RaYF9NWgPxH+x6tyVlQU6B4A8Rj9T7hfDZxKAIn85nejoet365Me8AXvgrBz4oEf/q1peJ2tOpwaR12qBda1tUG1sKtiyWdRAXNA1HlEs5X9SdEX/4JKKc47oPikohtGJiPEm8+A9YQWMSPRfnqnbDWXcbyEw7Xs4Yor5fMG4hZvH7tgiIlBr4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lk9jG+0ivQ6l69DONlp+pWX8Woy84N/WHypG/Jzyxt8=;
 b=nkfGi8VR+pvhyKsTyZQHex955MpZRJk/HI4et9Efy0xcXQNvqO7Pe7M8Mp6n5E5A/UtEfOSmimu7K2B3+3ITrb4psPpIQp3eRngKuEIjRgog1/gl0VoXOltO27tfwj9P2p9b7QTQtzGWWwUpK/1zjsMN4wgNC9dJztHyFvoAs80/7kx8ESB0epFumqPaO3ocvoIS3lFfrIj5ScHAs5tJ0XiX2HXySUWL6hb9w+Ro1/+fMU0LbrBiwaKzAuCp/tinB6FkAxs0V0EVH+VB2Y2fFCP7CYIIohzQgWatsgR+588vAtc9ENhtZug4GjWpfVqNHU5bgQ1bQVxjuXEJkDqbZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lk9jG+0ivQ6l69DONlp+pWX8Woy84N/WHypG/Jzyxt8=;
 b=dQZgBdMk27I33g37b3wkl0uHGgWTOx2biHO+2wuQ+KZ33jOukOtbg1lA6b78I9QaocNg9qOmYW0+vIoEcVbOUhIYgZuTpdqHPd8LfeWhbS+CTjibkRnaSN0I+e/GRUYilC6vlm/eRieP63wYRWxJkRjl7XxB+DXfbgFvCtT4o0oQ0Ae6yTA97GQPVEHzGN1Tpn7VzgVHZfawnnyuOKfTLdyvdjs4ZHCnZJlU1IhHRvnrpz/X11bEqPq+xe0BSDILLeWBSVfiVV+ZQuRVf0P9Mb53gFGiAYnvtyPcxzXdazw3VHr5WgoWiq/Dklf3P1AGigCa4B3qZYW5OAp31q6/KQ==
Received: from DM3PR12CA0083.namprd12.prod.outlook.com (2603:10b6:0:57::27) by
 MW3PR12MB4364.namprd12.prod.outlook.com (2603:10b6:303:5c::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.19; Tue, 29 Mar 2022 05:45:28 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:57:cafe::4a) by DM3PR12CA0083.outlook.office365.com
 (2603:10b6:0:57::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Tue, 29 Mar 2022 05:45:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5102.17 via Frontend Transport; Tue, 29 Mar 2022 05:45:28 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 29 Mar
 2022 05:45:27 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 28 Mar
 2022 22:45:27 -0700
Received: from dipenp.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Mon, 28 Mar 2022 22:45:26 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <smangipudi@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH v5 03/11] hte: Add tegra194 HTE kernel provider
Date:   Mon, 28 Mar 2022 22:45:13 -0700
Message-ID: <20220329054521.14420-4-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220329054521.14420-1-dipenp@nvidia.com>
References: <20220329054521.14420-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 686b1e84-b080-4bb0-417c-08da11475486
X-MS-TrafficTypeDiagnostic: MW3PR12MB4364:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4364A06B2A57444D4F670801AE1E9@MW3PR12MB4364.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8NoAYIa2pAePhLzvENUbTz/xx9E9bciiHfGsFsdJbyyDO9fZfgfTOxqd3E78Oov63Pdo0xkWw5SAaT3/jeWT5IP3kXVQMnM7z7YqpDLliBOC74q+MZFKtKjAmO7rETrzVvDQ7pp64r6oexYSpfGBSsT50i9aDrT3W+6i2B3Gfw1Koysbf98mN1i9fS3ufb7ZCFeYqVPtmOvyje+FHPlbSGIQbxA2KqqegzlpFlw4lFxBJwrVGpjaZx9Niz87dUbahZyuBY58NBAGzz2O9TVtuwA9AJzIo3elB9fsPg5jmkCoUu5aP4ajy/YDofSExgvyMzqsn9+1UKiAi/AGBfifoAEOgV7qUouZemdLQJtcvBeAW6gtX4IXDaegee30jpajso8B/bxhc0b47a7hU3LQiAHUt55nNrQ/jE8mIv9HpbYNLBwEu5kW3J5RYLUa8e2KitW78Y+wUXXHm8vXxF8DblOInekjtBkAcPvriQJT+aKoG86bg8e178e3WnGRrkH6PEvPnPraWFNpFqDZneTIh/igy3SppPMh9roiMlv33/pWWSmb4b6dA71kPXFdvihfwvdKOYY7i1IBnnofFhAEf4S5oQXEnyJgNrbU/m++6NT8huFeHQt7McNeuGSvGmKhJhFiWZf0Wqn+kE4qzsT6HLsAgcyOyS+PxZDaE+MkQk++u9rxk+VEAj/n5wv4flqd8EXfdTXO4HNp+LF/TEVmw35p0OcuzRzyrt9E9p/QnNxYgjC732djXGhg9/p0oCxpQYCc/IErAOLbiJwhMRSPRQ==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(107886003)(40460700003)(36756003)(30864003)(81166007)(36860700001)(7416002)(5660300002)(70586007)(356005)(70206006)(2616005)(4326008)(2906002)(8936002)(8676002)(426003)(82310400004)(7696005)(316002)(110136005)(6666004)(336012)(47076005)(921005)(83380400001)(26005)(86362001)(186003)(508600001)(1076003)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 05:45:28.3062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 686b1e84-b080-4bb0-417c-08da11475486
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4364
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

 Documentation/hte/index.rst        |  22 +
 Documentation/hte/tegra194-hte.rst |  52 +++
 Documentation/index.rst            |   1 +
 drivers/hte/Kconfig                |  12 +
 drivers/hte/Makefile               |   1 +
 drivers/hte/hte-tegra194.c         | 690 +++++++++++++++++++++++++++++
 6 files changed, 778 insertions(+)
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
index 000000000000..0c1c7773c88a
--- /dev/null
+++ b/Documentation/hte/tegra194-hte.rst
@@ -0,0 +1,52 @@
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
+subsytem while userspace consumers timestamp requests go through GPIOLIB CDEV
+framework to HTE subsystem.
+
+.. kernel-doc:: drivers/gpio/gpiolib.c
+   :functions: gpiod_enable_hw_timestamp_ns gpiod_disable_hw_timestamp_ns
+
+There is hte-tegra194-gpio-test.c, located in ``drivers/hte/`` directory, test
+driver which demonstrates GPIO GTE functionality in kenel space and code added
+in gpiolib-cdev.c demonstrates userspace example.
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
+this GTE instance in the hte framework. The sample test code
+hte-tegra194-irq-test.c, located in the ``drivers/hte/`` directory,
+demonstrates how to use an IRQ GTE instance.
+
+The provider source code of both IRQ and GPIO GTE instances is located at
+``drivers/hte/hte-tegra194.c``.
+
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
index 1fcfe17cf28a..ebd9817651c2 100644
--- a/drivers/hte/Kconfig
+++ b/drivers/hte/Kconfig
@@ -20,3 +20,15 @@ menuconfig HTE
 
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
index 000000000000..cff3e2364319
--- /dev/null
+++ b/drivers/hte/hte-tegra194.c
@@ -0,0 +1,690 @@
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
+/* AON GPIO port AA pins */
+#define NV_AON_GPIO_PORT_AA_0		0
+#define NV_AON_GPIO_PORT_AA_1		1
+#define NV_AON_GPIO_PORT_AA_2		2
+#define NV_AON_GPIO_PORT_AA_3		3
+#define NV_AON_GPIO_PORT_AA_4		4
+#define NV_AON_GPIO_PORT_AA_5		5
+#define NV_AON_GPIO_PORT_AA_6		6
+#define NV_AON_GPIO_PORT_AA_7		7
+
+/* AON GPIO port BB pins */
+#define NV_AON_GPIO_PORT_BB_0		8
+#define NV_AON_GPIO_PORT_BB_1		9
+#define NV_AON_GPIO_PORT_BB_2		10
+#define NV_AON_GPIO_PORT_BB_3		11
+
+/* AON GPIO port CC pins */
+#define NV_AON_GPIO_PORT_CC_0		12
+#define NV_AON_GPIO_PORT_CC_1		13
+#define NV_AON_GPIO_PORT_CC_2		14
+#define NV_AON_GPIO_PORT_CC_3		15
+#define NV_AON_GPIO_PORT_CC_4		16
+#define NV_AON_GPIO_PORT_CC_5		17
+#define NV_AON_GPIO_PORT_CC_6		18
+#define NV_AON_GPIO_PORT_CC_7		19
+
+/* AON GPIO port DD pins */
+#define NV_AON_GPIO_PORT_DD_0		20
+#define NV_AON_GPIO_PORT_DD_1		21
+#define NV_AON_GPIO_PORT_DD_2		22
+
+/* AON GPIO port EE pins */
+#define NV_AON_GPIO_PORT_EE_0		23
+#define NV_AON_GPIO_PORT_EE_1		24
+#define NV_AON_GPIO_PORT_EE_2		25
+#define NV_AON_GPIO_PORT_EE_3		26
+#define NV_AON_GPIO_PORT_EE_4		27
+#define NV_AON_GPIO_PORT_EE_5		28
+#define NV_AON_GPIO_PORT_EE_6		29
+
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
+	const struct tegra_hte_line_mapped *map;
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
+	[NV_AON_GPIO_PORT_AA_0]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_11},
+	[NV_AON_GPIO_PORT_AA_1]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_10},
+	[NV_AON_GPIO_PORT_AA_2]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_9},
+	[NV_AON_GPIO_PORT_AA_3]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_8},
+	[NV_AON_GPIO_PORT_AA_4]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_7},
+	[NV_AON_GPIO_PORT_AA_5]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_6},
+	[NV_AON_GPIO_PORT_AA_6]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_5},
+	[NV_AON_GPIO_PORT_AA_7]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_4},
+	[NV_AON_GPIO_PORT_BB_0]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_3},
+	[NV_AON_GPIO_PORT_BB_1]  = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_2},
+	[NV_AON_GPIO_PORT_BB_2] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_1},
+	[NV_AON_GPIO_PORT_BB_3] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_0},
+	[NV_AON_GPIO_PORT_CC_0] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_22},
+	[NV_AON_GPIO_PORT_CC_1] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_21},
+	[NV_AON_GPIO_PORT_CC_2] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_20},
+	[NV_AON_GPIO_PORT_CC_3] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_19},
+	[NV_AON_GPIO_PORT_CC_4] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_18},
+	[NV_AON_GPIO_PORT_CC_5] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_17},
+	[NV_AON_GPIO_PORT_CC_6] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_16},
+	[NV_AON_GPIO_PORT_CC_7] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_15},
+	[NV_AON_GPIO_PORT_DD_0] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_14},
+	[NV_AON_GPIO_PORT_DD_1] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_13},
+	[NV_AON_GPIO_PORT_DD_2] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_12},
+	[NV_AON_GPIO_PORT_EE_0] = {1, NV_AON_HTE_SLICE1_IRQ_GPIO_29},
+	[NV_AON_GPIO_PORT_EE_1] = {1, NV_AON_HTE_SLICE1_IRQ_GPIO_28},
+	[NV_AON_GPIO_PORT_EE_2] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_27},
+	[NV_AON_GPIO_PORT_EE_3] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_26},
+	[NV_AON_GPIO_PORT_EE_4] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_25},
+	[NV_AON_GPIO_PORT_EE_5] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_24},
+	[NV_AON_GPIO_PORT_EE_6] = {2, NV_AON_HTE_SLICE2_IRQ_GPIO_23},
+};
+
+static const struct tegra_hte_data aon_hte = {
+	.map_sz = ARRAY_SIZE(tegra194_aon_gpio_map),
+	.map = tegra194_aon_gpio_map,
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
+static inline int tegra_hte_map_to_line_id(u32 eid, struct tegra_hte_soc *gs,
+					  u32 *mapped)
+{
+	const struct tegra_hte_line_mapped *m;
+
+	if (gs->prov_data && gs->prov_data->map) {
+		m = gs->prov_data->map;
+		if (eid > gs->prov_data->map_sz)
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
+	if (!gs)
+		return -EINVAL;
+
+	/*
+	 * GPIO consumers send base + offset as line id which is a GPIO
+	 * logical id in GPIO namespace, convert it into the hardware GPIO
+	 * number before mapping it into HTE/GTE namespace.
+	 */
+	if (gs->prov_data->type == HTE_TEGRA_TYPE_GPIO)
+		line_id = desc->attr.line_id - gs->c->base;
+	else
+		line_id = desc->attr.line_id;
+
+	ret = tegra_hte_map_to_line_id(line_id, gc->data,
+				       xlated_id);
+	if (ret < 0) {
+		dev_dbg(gc->dev, "line_id:%u mapping failed\n",
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
+	gc->xlate = tegra_hte_line_xlate;
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


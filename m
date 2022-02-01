Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717324A67E8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 23:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbiBAWXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 17:23:41 -0500
Received: from mail-bn7nam10on2045.outbound.protection.outlook.com ([40.107.92.45]:29824
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239346AbiBAWWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 17:22:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JytCtKOBED9tyLq9O48Yk1Rr43bQBP8WvdsYtkAncH7KZCiqIxm1zIRWAhnM5nJj3NXXX7hH1sFcXNx6+ycZnzAdVAGnZKLvZ4evxQ8xGQo4SYHgN87Y/GMU464Bgi7CvLMyHFj2BkbbZ12+n16/F7vZTprYe9seLvPqTWdwfZIXv+umElD2Qh5xAi6iCiEgz4lOU9j1P+t7OmSP9x3vyu7z0tLnjYtvAKrA+Lv0H8TPlNTXF4Kiv7oXbp45o2yTVciw23w1QXc7JapqlULZWR1yWK2BSJk9FeqBd0w22AJCMruxVQoorQTnnb4QOA4eMkY82FXh27tnDhARfpdD+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3FYeg6KGKGWGsDMnUM3uaeBSbybH1+Nh2FcgB5x3pg=;
 b=KtBzqAqNkSOTI09Jpbzp9ccY4rFFRBppZfb/ODmkt/ADF4CRD6GWqVONTORgfabzFLkvUPe5GPKpZghfiZi5kaFV48nV9JHODzGe2eRC3RedhgeYvk6tHGvny+buwJR1xTsl2KUONY4iwrXHxVX793Rrw2bQ7OyOgcZVeRB0aGhpSIICIRtjjhpHdG0iUGMiphTN1BWDQs3iSRVDK5090DHxap8PF1uOupeXLVfT8w88aQtl/j3jrd/ITL3nMnP/iYFPcb3Ixy6CTtETrHv+hNhYyF/C6VwMXa21O2fRU4wX5XF1tmNlb9yG+1fSsmYwUB6tGvgPW2HWHJdTs0WV2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3FYeg6KGKGWGsDMnUM3uaeBSbybH1+Nh2FcgB5x3pg=;
 b=dy3wKmsjuSlGzNZO4mzDtF7g3rIMpBt0HnWECx6oiLjt4F2p1PNNzBjJDiXv3DUIjUr/GrYUA6y6iU+ItvqnA35hM4DHtXFlYsu4KcERD/9vFcvdNnixbqtWqVh93Fjg73CiVmIlCvFnNXsW2x3euT6LXGGMAPVSbxwYVHD+004B/JskHqhaFWmNbb7LHiJrca8hgW5BTKLipdAz3q09YDD5fPV6pi/GU9OjEUmme1QMxHJscxsAVM/UKokv/c2jZpABEf9+lONtaDeDX0zofizsampRZXfbrzj+rdRBcVmJZZ/zNn0cmhHriMQEnqKc1B5PwwU7p9v1Jct9EBIOhg==
Received: from BN0PR04CA0204.namprd04.prod.outlook.com (2603:10b6:408:e9::29)
 by CH2PR12MB4906.namprd12.prod.outlook.com (2603:10b6:610:6a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Tue, 1 Feb
 2022 22:22:33 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::3f) by BN0PR04CA0204.outlook.office365.com
 (2603:10b6:408:e9::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Tue, 1 Feb 2022 22:22:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Tue, 1 Feb 2022 22:22:32 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 1 Feb
 2022 22:22:31 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 1 Feb 2022
 14:22:31 -0800
Received: from dipenp.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 1 Feb 2022 14:22:31 -0800
From:   Dipen Patel <dipenp@nvidia.com>
To:     <smangipudi@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH v4 07/11] gpio: tegra186: Add HTE in gpio-tegra186 driver
Date:   Tue, 1 Feb 2022 14:26:26 -0800
Message-ID: <20220201222630.21246-8-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220201222630.21246-1-dipenp@nvidia.com>
References: <20220201222630.21246-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d61fe7cc-6518-4608-f921-08d9e5d157ac
X-MS-TrafficTypeDiagnostic: CH2PR12MB4906:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4906B8F10B8495106D69A7DBAE269@CH2PR12MB4906.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Vk+qTWTKKbFWWoR1nXfCCBv+fk1YQilF1Nbw1eabdly7PKvoXMQAkDOUxC8owRpwRK0l8vmQiVpjbIAPN6ZaD0BAinHrhkvjlCGsoc/+OVoD6vXDjBOi+4IMIE2CmYzzlVfoSCSwZ9OlWQWuTL5ycARM+BotHxL3S47s6qcYP0AVrYCkOMDHA/pLw2ITlOWFe7pkIKw+Smy83ei6od2D/9Bs0RzrWY1RTg7vbDUwCEZ61j1yJiJyHrTizFxOFug5ZLwhItEBB/akHjctju/71lQPUINarkt3FAv72WvNaoMB+y5a9liGjF+bR4g6CGZAGv/8RyIFZLwOe+Snve2JR5RfLEZ3/kSATCMiynKkeaG9TYxoJx49nTursZffI26tBn9gIyTadltxqwnH7aX/mxyU6J93TZKNcwPwQLkYXzaxvlZoZkIsfXCrDc8mgR03FNQoUzVTCV9KozMZQdfEQRHHQ/2/87e0kWuDlKlO9lkvM5BRgUNTPah8V1WSYSXlwmMhRIHhft5tH2IWp/kKR8JuRsvApo1KB/KYgzDN16IzXM1pKZsiaEIop3370sQMmEE/7fgFsR+R2Z+7ydpRitiPPlO14AOyy7COAxD4fJQntZbFjFcxqkaXXci/XqAbDJx8CUe4Bw4tXlV5FiXzf+bqAgCdmJYZKgjV6jheZj/mKIWPIcXjHIcFv55Qmo1kp8eeT5LurgPPS77cLnxz9LzNzLSjVPUUb+PAcCKrPTmM5d/bixbklip+3tBy3tTNf0SqavdoCNkp57HvfjEJA==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(508600001)(81166007)(110136005)(921005)(356005)(86362001)(83380400001)(7416002)(5660300002)(2906002)(82310400004)(7696005)(70586007)(6666004)(70206006)(8936002)(8676002)(36756003)(186003)(4326008)(47076005)(2616005)(336012)(40460700003)(107886003)(316002)(26005)(426003)(36860700001)(1076003)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 22:22:32.9640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d61fe7cc-6518-4608-f921-08d9e5d157ac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4906
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra194 AON GPIO controller with the use of its internal hardware
timestamping engine (HTE) also known as GTE can timestamp GPIO
lines through system counter. This patch implements enable/disable
callbacks for the GPIO controller. In enable call, it will set
timestamp function bit and GPIO line rising/falling edges in the
config register. In disable call, it restores the state.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
---
 drivers/gpio/gpio-tegra186.c | 81 +++++++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index 91c77fccc1e6..3bf6f7e18dcc 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2016-2017 NVIDIA Corporation
+ * Copyright (c) 2016-2022 NVIDIA Corporation
  *
  * Author: Thierry Reding <treding@nvidia.com>
+ *	   Dipen Patel <dpatel@nvidia.com>
  */
 
 #include <linux/gpio/driver.h>
@@ -11,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/hte.h>
 
 #include <dt-bindings/gpio/tegra186-gpio.h>
 #include <dt-bindings/gpio/tegra194-gpio.h>
@@ -35,6 +37,7 @@
 #define  TEGRA186_GPIO_ENABLE_CONFIG_TRIGGER_LEVEL BIT(4)
 #define  TEGRA186_GPIO_ENABLE_CONFIG_DEBOUNCE BIT(5)
 #define  TEGRA186_GPIO_ENABLE_CONFIG_INTERRUPT BIT(6)
+#define  TEGRA186_GPIO_ENABLE_CONFIG_TIMESTAMP_FUNC BIT(7)
 
 #define TEGRA186_GPIO_DEBOUNCE_CONTROL 0x04
 #define  TEGRA186_GPIO_DEBOUNCE_CONTROL_THRESHOLD(x) ((x) & 0xff)
@@ -75,6 +78,7 @@ struct tegra_gpio_soc {
 	const struct tegra186_pin_range *pin_ranges;
 	unsigned int num_pin_ranges;
 	const char *pinmux;
+	bool has_gte;
 };
 
 struct tegra_gpio {
@@ -193,6 +197,76 @@ static int tegra186_gpio_direction_output(struct gpio_chip *chip,
 	return 0;
 }
 
+#define HTE_BOTH_EDGES	(HTE_RISING_EDGE_TS | HTE_FALLING_EDGE_TS)
+
+static int tegra186_gpio_en_hw_ts(struct gpio_chip *gc, u32 offset,
+				  unsigned long flags)
+{
+	struct tegra_gpio *gpio;
+	void __iomem *base;
+	int value;
+
+	if (!gc)
+		return -EINVAL;
+
+	gpio = gpiochip_get_data(gc);
+	if (!gpio)
+		return -ENODEV;
+
+	base = tegra186_gpio_get_base(gpio, offset);
+	if (WARN_ON(base == NULL))
+		return -EINVAL;
+
+	value = readl(base + TEGRA186_GPIO_ENABLE_CONFIG);
+	value |= TEGRA186_GPIO_ENABLE_CONFIG_TIMESTAMP_FUNC;
+
+	if (flags == HTE_BOTH_EDGES) {
+		value |= TEGRA186_GPIO_ENABLE_CONFIG_TRIGGER_TYPE_DOUBLE_EDGE;
+	} else if (flags == HTE_RISING_EDGE_TS) {
+		value |= TEGRA186_GPIO_ENABLE_CONFIG_TRIGGER_TYPE_SINGLE_EDGE;
+		value |= TEGRA186_GPIO_ENABLE_CONFIG_TRIGGER_LEVEL;
+	} else if (flags == HTE_FALLING_EDGE_TS) {
+		value |= TEGRA186_GPIO_ENABLE_CONFIG_TRIGGER_TYPE_SINGLE_EDGE;
+	}
+
+	writel(value, base + TEGRA186_GPIO_ENABLE_CONFIG);
+
+	return 0;
+}
+
+static int tegra186_gpio_dis_hw_ts(struct gpio_chip *gc, u32 offset,
+				   unsigned long flags)
+{
+	struct tegra_gpio *gpio;
+	void __iomem *base;
+	int value;
+
+	if (!gc)
+		return -EINVAL;
+
+	gpio = gpiochip_get_data(gc);
+	if (!gpio)
+		return -ENODEV;
+
+	base = tegra186_gpio_get_base(gpio, offset);
+	if (WARN_ON(base == NULL))
+		return -EINVAL;
+
+	value = readl(base + TEGRA186_GPIO_ENABLE_CONFIG);
+	value &= ~TEGRA186_GPIO_ENABLE_CONFIG_TIMESTAMP_FUNC;
+	if (flags == HTE_BOTH_EDGES) {
+		value &= ~TEGRA186_GPIO_ENABLE_CONFIG_TRIGGER_TYPE_DOUBLE_EDGE;
+	} else if (flags == HTE_RISING_EDGE_TS) {
+		value &= ~TEGRA186_GPIO_ENABLE_CONFIG_TRIGGER_TYPE_SINGLE_EDGE;
+		value &= ~TEGRA186_GPIO_ENABLE_CONFIG_TRIGGER_LEVEL;
+	} else if (flags == HTE_FALLING_EDGE_TS) {
+		value &= ~TEGRA186_GPIO_ENABLE_CONFIG_TRIGGER_TYPE_SINGLE_EDGE;
+	}
+	writel(value, base + TEGRA186_GPIO_ENABLE_CONFIG);
+
+	return 0;
+}
+
 static int tegra186_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
 	struct tegra_gpio *gpio = gpiochip_get_data(chip);
@@ -719,6 +793,10 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
 	gpio->gpio.set = tegra186_gpio_set;
 	gpio->gpio.set_config = tegra186_gpio_set_config;
 	gpio->gpio.add_pin_ranges = tegra186_gpio_add_pin_ranges;
+	if (gpio->soc->has_gte) {
+		gpio->gpio.en_hw_timestamp = tegra186_gpio_en_hw_ts;
+		gpio->gpio.dis_hw_timestamp = tegra186_gpio_dis_hw_ts;
+	}
 
 	gpio->gpio.base = -1;
 
@@ -971,6 +1049,7 @@ static const struct tegra_gpio_soc tegra194_aon_soc = {
 	.name = "tegra194-gpio-aon",
 	.instance = 1,
 	.num_irqs_per_bank = 8,
+	.has_gte = true,
 };
 
 #define TEGRA234_MAIN_GPIO_PORT(_name, _bank, _port, _pins)	\
-- 
2.17.1


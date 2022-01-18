Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492304912BC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 01:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244004AbiARATB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 19:19:01 -0500
Received: from mail-mw2nam12on2073.outbound.protection.outlook.com ([40.107.244.73]:35457
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243885AbiARASu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 19:18:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsaNUdpNEYZ/LeXOBessITHDfD9TnEB1niJxLYuh7MnCOb3I1EAxrbsu5OdnT+7MlC6FnfZWWQbVGgdCk35b7u8Ku1XL2+ADVZFXEh48/lPpqUhi5qoJjnk2hoNR1bIYmJAkeiLar5d3g0x+s2ni5qxIjyuHP3YpvS5do93OpZK2khRSwLE6LmHyvtOqh7SmEWwUmS5h2Rgm8y+IQsGpeXKAq4blPf3QTwgFd3jBLwS141HzNN0cyJJ7sQjYK9QRRriaKNP5vHTqirUAK/vBLsUHHzpG8SIXHXm/l+WAnZHD8iq0LeLfFSopecCxeXvGS+3VZ39bMKA4Io0wxFEdjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEN50aTUHlaLlLnQ1NrRVpulQhOGElpfUvPnItaoogE=;
 b=Glakxeo3A0Q3uasrngvZ6dXDH5H4dvHuYlO/niQt1oYANFYEFZxWZ0PaG5z/eY4eP4CKDAQsHxCPXKEWGh+nVMaIUrtNHGWPLiyJc8a5U1EZbliDYsE1qtPOQa69wFO00NGq6VCFPAzh1zUwNdBzcZjcdem3JEnOB6bKh38fN96FsVR3ypcejkbMlEbnMOhyqr6KVL3WG7F1alHRBEVLsvzBm0AiIDywCRFjZ7w1ZQxG1MmeocAjBIK0m7g9PsNuPZPxYt0Q5rUyi2sBkvkdnXJ29OUWcuBW/QOxhtajvQmjN1IdPbx+ZycyBlJrulYVDZ+Zvnvjqqo2HKgn40Muvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEN50aTUHlaLlLnQ1NrRVpulQhOGElpfUvPnItaoogE=;
 b=fE1IzKWIe3zJE4k/HLYI7Ehol4wuVexk2hdah8wXWDlYFas9j7Q18DgwC64vB9lW/Qviac2IlNTNF2CSI9n9oMtDLSaczlMyQ90VhzovRCLID56gfXfeXHy+nwGIgHcmJe7fs99IIAYVbTbJgcPtMXlw0QDxLyJ1yTzCgteXOy/codC9BufHCV/v2FisKjyr4/M1WNPDOpDZH/q4lTsiJp7oNoXz95rY99/2u4NQi3Sk0Vhsa5hj4Ti05jeCgUj/5cawWizcZNj6Mj+Xwx5IybCNHJcCp0Vs+F7gB8HnOD75oI+/VCJT6l/WV7Qb9VHLB8t6kAHA2IiqDsHkjiKRzg==
Received: from MW4PR03CA0300.namprd03.prod.outlook.com (2603:10b6:303:b5::35)
 by MN2PR12MB3805.namprd12.prod.outlook.com (2603:10b6:208:15a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Tue, 18 Jan
 2022 00:18:45 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::67) by MW4PR03CA0300.outlook.office365.com
 (2603:10b6:303:b5::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Tue, 18 Jan 2022 00:18:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4888.9 via Frontend Transport; Tue, 18 Jan 2022 00:18:45 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 18 Jan
 2022 00:18:44 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 18 Jan
 2022 00:18:44 +0000
Received: from dipenp.nvidia.com (10.127.8.14) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 18 Jan 2022 00:18:44 +0000
From:   Dipen Patel <dipenp@nvidia.com>
To:     <smangipudi@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [RFC v4 07/11] gpio: tegra186: Add HTE in gpio-tegra186 driver
Date:   Mon, 17 Jan 2022 16:22:10 -0800
Message-ID: <20220118002214.18271-8-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220118002214.18271-1-dipenp@nvidia.com>
References: <20220118002214.18271-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60c32265-16fd-4414-c4b6-08d9da181726
X-MS-TrafficTypeDiagnostic: MN2PR12MB3805:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3805C689C4BA2807133D4B1AAE589@MN2PR12MB3805.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HPEti6OM4YK/S1Z98n2+Dafy0EWNf6KJr3g1jdcmI8fQtTZEX8dC6ssFd/up9GUPm/zI4xAg5mf1QSt1GAgOUwKN+4DMnJdXXm4sKAl5pAKqooGzGurlFMj8yBE+tV0t2Yn6lMku+CVb2ycfCO5lxn/m4WLC0aFyl7fnjoYxTVrB5U8vv+4ekD/BWZNP9sfDgOomvSUa7FxDbHOrJAzdkfvtu/VeJ9mm7YAf8g3gt6scszWQjJmttp9FW+PDtdD0LlKQjBFbelTvS/3JlM4G50l4TXT7DJn2thiPqGc9xFayvhIengwT9gKijyWJ/2FhriWV1iCdRILurE3u9uyex9O8/T288UVFLqFb6MYKDUBGJInAVeWzCJIN8Yi8HfylgZcc7UIT9JOeDtGQklPdLHP4rwOGocuDDiE0p6MWpiFQwR+Xps9AepOKLtVREp6Iur0NtP7m37qRYmCe17x40augMwwm5P40vvk1PXPZOIhSmT8sihfdFyCR4uxWyEO1Bilyl8F3UZjP0v2FyGRHgNmtf7GzG+wYtVFhmd8V91i0U0l3VYsWJz2WohzwCtno16zldVWFjiDXbNHgIbQW7GUvi6V1d2AfzJeJSYOuuXN/F94uSZF6BiLhi/y/fbWEJEGxjDsexq7t0IkpJFb9KQlVAk7HjsG2De18CE0WeN6WLUPJuMqT4lS3FEUw7XDNcORoTcLztI9G7htJ31wR9BMWBYPfRTY/Sok5c1ja/x4FD/1j9m7e7n5O8DSlVX0eM35oHZbveYmq1uNa+iKWpFa3ap59H6W0cmjVEYNJ8mKh2D/+tSfzQDWAS7CZlBuvNBGN+fMgxd/+kqaRhygnwdu34rOXg6EYcap1/fr7MzE=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(40470700002)(46966006)(36840700001)(70206006)(70586007)(5660300002)(426003)(40460700001)(356005)(186003)(36860700001)(83380400001)(86362001)(4326008)(2906002)(110136005)(82310400004)(2616005)(7416002)(81166007)(1076003)(921005)(316002)(26005)(7696005)(336012)(107886003)(47076005)(508600001)(8676002)(6666004)(8936002)(36756003)(36900700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 00:18:45.1029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c32265-16fd-4414-c4b6-08d9da181726
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3805
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
Changes in v4:
- Added edge setup and hardware timestamping enable/disable APIs.

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


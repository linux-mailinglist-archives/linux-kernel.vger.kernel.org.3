Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBAF4EA788
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 07:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbiC2Ftw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 01:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbiC2Fri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 01:47:38 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7443F3207A;
        Mon, 28 Mar 2022 22:45:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jAwTJRDp3WZkGGqIRt+sgSjejPplV1H+Ydhhdfdi2cx++XgSnfjyTXaAEoLvv3g9IAQW05XJIJ+UISAWYGczRZ6PbSmnZArdJE/HuBd8CsJz4YDnQi4PWsJjkcNNour2bB+Ny3vioBa8YrcA40K8XUo4BNMUCDv5EWTFztNAPaoCpOo3qS7h02eGgYskcf501tM5Jj6v8zfAW9lYOAZnlM/2/CIo1QPF9xrEmltmvQfZUNBDkyVE4Fh/KvXD+NqvKKcOYaAMJw7FUKjO+DZsD6Xk4o4LEQiHFT6EWyzTN47GdpsBU9ZI7I+uq+6iSD6/rkj0X33n6tQSJzhWcV99TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IaTxI9UkLtJEEWrhDbrW1unf3iRzgF2RgTbwALfPXo=;
 b=iS7lPjrChVBxSi9acAMWHIW3EgDMIaUt2dfewI+ojlM/4Ep6u28SbjlghYh6o3eYy+xMkzQHoC0Avrn4Mm18Vtn2L8CZpQdAQG9jB6KHRh0Xu0bjlvMtX+MY3ENtpowtlHYr/6Zy+Yqis4ekLiE6FgvtsT4KBschqq9CaEIKWXJA9RFSONGouYB54ardkJ8mA+ps2NbhPG6MXyALTEFZFmNSvK0JN0Ei81i1HArzyfkn6uNjDkaXpseQFgXE2/2DnjATfLqcaGdYNXdD8+FoH4h8E0At3MNQGlCeTh+8luErXtQEssaSNM8E6vWUHdXJJNlWtE2bdRSL9zNQQaKK3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IaTxI9UkLtJEEWrhDbrW1unf3iRzgF2RgTbwALfPXo=;
 b=tyGrIyZzwJAROsBW5RMowPJZcvKM+8fDVr/c8kgJypLTmXU0NrQIneqDcBYNmDbvWsuQ638l8ua/sx012YLiM8XqU+hwSJiMLAVWoqwLecvP7/3wzPqYZu5nMilnIc9h/AS9DuvGmP7gqEnG/NfQJmCzzyyT1OlFRVQi10dgSIgAqAlLbj8TsJ5Y1GVe3F6nVvLH/uyINvOcTjWNhgbXKVGpIM+t374bYJfpacUEoq1/DndS6Fh/4/7Z/jHvle3vWDIypSEynRJcT88IhzO9ySYTqQiTMH5wFq3bZFuRUUi3ni4AnB4drQvI3Rn4AnkqZuqHTYZQSzclcdNbUJaIGQ==
Received: from MW4PR04CA0343.namprd04.prod.outlook.com (2603:10b6:303:8a::18)
 by CH2PR12MB4310.namprd12.prod.outlook.com (2603:10b6:610:a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 29 Mar
 2022 05:45:35 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::38) by MW4PR04CA0343.outlook.office365.com
 (2603:10b6:303:8a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Tue, 29 Mar 2022 05:45:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5102.17 via Frontend Transport; Tue, 29 Mar 2022 05:45:35 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 29 Mar
 2022 05:45:34 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 28 Mar
 2022 22:45:33 -0700
Received: from dipenp.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Mon, 28 Mar 2022 22:45:33 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <smangipudi@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH v5 07/11] gpio: tegra186: Add HTE in gpio-tegra186 driver
Date:   Mon, 28 Mar 2022 22:45:17 -0700
Message-ID: <20220329054521.14420-8-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220329054521.14420-1-dipenp@nvidia.com>
References: <20220329054521.14420-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1b4803e-62c5-41a5-38e5-08da1147588f
X-MS-TrafficTypeDiagnostic: CH2PR12MB4310:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB43100609F7856C8FE329601EAE1E9@CH2PR12MB4310.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kP/vWFNHUN9vE10YEsKWdyPiu2uBeW1DOjTZwWAwAXweKHRI4SItYnjW2eZv2kLGjjcRqsC3tDEAb1UdgrcAAOdT01jMBEsadGEuWQXukNt3kbVVsmLZqgL5d0m7cO57ci+y0hnuxJ81KeoqycWCVEsz3pVHa8oots8I43cUIzPwG+U+jM9W1iIYihyqYrf1YLIRNFtRjqOfSnLiEIwnHWPhZl7UKEgnVvin6wZJ7oJzKloFxhzaZZjc8Sfmm82OoRNLn/PdDNu24Bh6+lfP9y4XK3ChZ01mJKrfNIBsnMHovBwzE+IRd1+XzgQsGWJZeyTazyALZMOFABlFb19jGFQ5UFKKLgfh2PKCKzK8qWjjgmkJbooE6kbmOZtxwQFfKCgSiwx1S/E8aHWF4Tv19OfVXRc+qAZ7Ga0muYCaa73eDMF2sUYsEUJJOHYfzr61oy3XtzQDD+ZlruMbSAg03zHn6hFthoGidpqh3eauJWo7QIj4hz1gHFKr13/pU0I29THlFwe7I+TlArG1AaVEPZLuPKh6HHwxkz99e0ML5q0ghhyqb0EXloS1oUgnPWaJLkOFxJM+gPc1HlJyosbnrZzdsQ5wFdHJocNPjCra3vHCzl2EK0/BX3n6HG7tdWRw7BdqEaLOZmaYmIObkz7RC/GGvleKJMzluzvRO6Pt/UTYpyWrHBx0cBDFTeEWzFzFu7Wp0RB0uj2u30XGXQPpRLqdRsFBLxYmbLjvrtNtEpQkI2rmMWKiv4T/r/ifxYX5gmInB733FhXcqdcfdlbLOQ==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(508600001)(2906002)(110136005)(1076003)(5660300002)(336012)(426003)(8676002)(4326008)(8936002)(7416002)(2616005)(186003)(107886003)(26005)(83380400001)(40460700003)(86362001)(70206006)(47076005)(316002)(6666004)(7696005)(70586007)(82310400004)(356005)(36860700001)(921005)(36756003)(81166007)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 05:45:35.1540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b4803e-62c5-41a5-38e5-08da1147588f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4310
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 031fe105b58e..6a6852b4785e 100644
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
@@ -36,6 +38,7 @@
 #define  TEGRA186_GPIO_ENABLE_CONFIG_TRIGGER_LEVEL BIT(4)
 #define  TEGRA186_GPIO_ENABLE_CONFIG_DEBOUNCE BIT(5)
 #define  TEGRA186_GPIO_ENABLE_CONFIG_INTERRUPT BIT(6)
+#define  TEGRA186_GPIO_ENABLE_CONFIG_TIMESTAMP_FUNC BIT(7)
 
 #define TEGRA186_GPIO_DEBOUNCE_CONTROL 0x04
 #define  TEGRA186_GPIO_DEBOUNCE_CONTROL_THRESHOLD(x) ((x) & 0xff)
@@ -76,6 +79,7 @@ struct tegra_gpio_soc {
 	const struct tegra186_pin_range *pin_ranges;
 	unsigned int num_pin_ranges;
 	const char *pinmux;
+	bool has_gte;
 };
 
 struct tegra_gpio {
@@ -194,6 +198,76 @@ static int tegra186_gpio_direction_output(struct gpio_chip *chip,
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
@@ -726,6 +800,10 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
 	gpio->gpio.set = tegra186_gpio_set;
 	gpio->gpio.set_config = tegra186_gpio_set_config;
 	gpio->gpio.add_pin_ranges = tegra186_gpio_add_pin_ranges;
+	if (gpio->soc->has_gte) {
+		gpio->gpio.en_hw_timestamp = tegra186_gpio_en_hw_ts;
+		gpio->gpio.dis_hw_timestamp = tegra186_gpio_dis_hw_ts;
+	}
 
 	gpio->gpio.base = -1;
 
@@ -977,6 +1055,7 @@ static const struct tegra_gpio_soc tegra194_aon_soc = {
 	.name = "tegra194-gpio-aon",
 	.instance = 1,
 	.num_irqs_per_bank = 8,
+	.has_gte = true,
 };
 
 #define TEGRA234_MAIN_GPIO_PORT(_name, _bank, _port, _pins)	\
-- 
2.17.1


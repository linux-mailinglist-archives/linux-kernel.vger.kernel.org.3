Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FD350C169
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbiDVWJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbiDVWHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:07:09 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67192E5EF4;
        Fri, 22 Apr 2022 13:52:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E87riR5r032W9kwwlg5v2p2fV+nlo5lsHSCPU380zm+oJtLqgnNyxL2rlCkMeGORqeAlMOCKgqJK4eGUJ41aRVVcY7dYFJe3oA3Cnr0HUn3MIk/NXocC9fa5+cdeZpN8L//Z73fU5vKlckdmpZV3bdc3TLg0SbPvD84qeaBeJG7mtOIueUgyX0ZEydw+kmGDIDdQVlMRDGYHCGDdefh+lG+kPI/EbaYuSXmS2jUNYb799whKvi3mhGoBAh0ppWphAsP5fOYZKwo5r4oYt4qHbQ5DihwPxP0jbBH6Ja9jaghTAMwIXSZQ+xlRMjopWZVadkSrMFlljkxZjI6jI4SLSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IaTxI9UkLtJEEWrhDbrW1unf3iRzgF2RgTbwALfPXo=;
 b=fFDkWgXgh9aSFvHy8rUw308BRgaA2MFbXr6ggNAvE2A/kwBTt1P9iUOyAV5ZmoOcoegbEAGxU8jETxUDiyeuJZSbX+3cuGvrNQEGoS6jmhTIqMbY+S9wTqG+33dxj1JGGi1D3Wfr4zrjBnW6O+RH1rCfM+DExOv0d+UPj/AqPJ2ceZg21yNAdFZH1rE+1r+kgvpZ6fX3PjBjwll11XBA1pl3BbzPFDzoSw5/lj9Rq4EFyVZws0kL4O2TSLvX1kqoOGFXvOg6X8uHWq+UUBfZg/cbXSfnySXYavpliRtGZisXmGBXbVndn1DDSAYpT0y+e4stUh2kd1XyyI8zE869rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IaTxI9UkLtJEEWrhDbrW1unf3iRzgF2RgTbwALfPXo=;
 b=Gxf+H47I3gi/DSAb5Ue3MlCiMhTqJAp0HGinUDGDaO1UxVGfeTUG2FBXNi2+9iioM1SLjIQu6/KryRN28Q0+ycol0SYuC5DJD209DjLSVDH/eS/CW4yRd4aRwXQ0qaJcJzHq+PPr50i6DOpUkKK3WLHmLzMOVQuX0AiWlmDv9VNcj8Cg5J9VGSFS6ZZVsHdJMb0AiWbsUxvyS+HZ554f8k/40IhJounXKecii19PXajS7uEUyjsnMttJ5xeSgfezonY9UPVN7WxGO7Vu9lvE4fyBtEd/ZyJRbH8C+/k5DXopPVbC9hzYyl97Y3GNCEnYAY6cdGhBYAVuAyz7phrFbQ==
Received: from DS7PR03CA0343.namprd03.prod.outlook.com (2603:10b6:8:55::17) by
 MW2PR12MB2571.namprd12.prod.outlook.com (2603:10b6:907:10::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Fri, 22 Apr 2022 20:52:26 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::f8) by DS7PR03CA0343.outlook.office365.com
 (2603:10b6:8:55::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Fri, 22 Apr 2022 20:52:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 20:52:26 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 22 Apr
 2022 20:52:25 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 22 Apr
 2022 13:52:24 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Fri, 22 Apr 2022 13:52:24 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <smangipudi@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH v6 06/10] gpio: tegra186: Add HTE in gpio-tegra186 driver
Date:   Fri, 22 Apr 2022 13:52:17 -0700
Message-ID: <20220422205221.952-7-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220422205221.952-1-dipenp@nvidia.com>
References: <20220422205221.952-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a0189df-db70-4bf3-014b-08da24a201f7
X-MS-TrafficTypeDiagnostic: MW2PR12MB2571:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB25718160DAB6596F214A6658AEF79@MW2PR12MB2571.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RPtACZrL7tWguZfsjH/bpsqt6/HLqbMn5r7PQCf+imY5zZ30Jgj9PwR8x8OSyBjq+uoWxqxBV134+0BKNZqOOTFyfgyjMhEwZdostgthulaR9xxtaxeoOqYJMUYTtCdFyHVQgu9gBkUULfgGv2uR8mqMlMGxancGMqpRf6+dXDIgf1LT555Dp6pD+npq7VV2HvCk46SXT0WrTFO7j5K/LFoK+hH73Qc0kY3/LAhU46z+eISpNzH7ZRqPkVN+wsuvfr16THgUmvZjNhK0Qat8Qj3zTBJVUiTZiMrmdo5ew6x4U05r6FgdBW+PEWbQHtgTa1hEwZp56jdS6JPaXBTZsRoQDIMLp0u/O+pYTPYrJVzZj8P7/FJkIWdXq7l+cAG/ebOF0dEPfdyA8PWBZzDibkcBVH1iPEVkdktjdd6u4QmFUMOklypipq7TrqbBcBSEPyZZ84yT3vX3XcUyqKvQAnkUyYVl2wiH3s9fdYYPsmSsfIjZrfNCayDLdrSeBqHjzOiPXy225g9dVC5cqZjR9frMTSxzn+zt2UHKuhremRlAlKc+Jf69kPQ2aveErI/ji132SaBoMfmWmiBropJvpYBtnUzX7mHmtgVsbjEbgKz1zaoJInDRY6dgPzDdaCBOcPWsYNO0wgWXwwTY2guUsr8cIxF+OJJrKyOR36B8mIBYAogOXbcj7cmS9aQ+vI8tSLsPP8Vdcs8HBJvIMu3evG7hLkFj1cD0nZbbvrsb3+6DjjyO9rh1m19mZjcLHYZrXvbNBHb4j25SENivJf1rSQ==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2906002)(921005)(36860700001)(82310400005)(107886003)(356005)(7696005)(81166007)(336012)(426003)(47076005)(186003)(86362001)(83380400001)(6666004)(26005)(110136005)(2616005)(1076003)(316002)(8936002)(40460700003)(70206006)(36756003)(70586007)(4326008)(5660300002)(508600001)(8676002)(7416002)(2101003)(36900700001)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 20:52:26.1363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0189df-db70-4bf3-014b-08da24a201f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2571
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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


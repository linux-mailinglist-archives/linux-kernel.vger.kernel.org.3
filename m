Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57AD14A67CA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 23:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240994AbiBAWWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 17:22:44 -0500
Received: from mail-dm6nam12on2067.outbound.protection.outlook.com ([40.107.243.67]:51105
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239198AbiBAWWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 17:22:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYcPEAgKuXccRqHIZqLflCnlYO37Xx+Jb1kfucwtfmjZfmuNfs0oNwaG7SuE38fxv0Ri0pKORucANNPH6x9a5kfCnAhuWSaNwrOG8S7UlwkzexyP8kKgRrSzPRD0Buo59L+CHgcDJChpsz9/xPR2GyA3YgjxaTviscn9g+vdyD0+c0GxiIxrV/o2gHB2cI8NCDmhfLzaG/X5I94f0ws24GynW3AlW3WXUBungSVDpHRMFnp3wTe1Bic7X81QMIaAhy8VRWfVP+Nx6dG+L7YFPT6Q/hw+gOjZYNPJYTftZB4lKIgjx46oPATjc1M315GkV9gEbsk3WpBKxyhJmEoEzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MMMvvWpkLK9O/qCA0+nQyRhg/QYxFylSpdpdzng1kE=;
 b=XuihvLmT2Z59rwubnJlbtkj1v7EmVtFBlNG1W2Vr7Bzb5wA6V/AAh/sp1liIi8ajys3GwORZbjMoZUHP/wh7NawS2w158XZN7Q57fGX/1pIl0i9CNq+zy2wQBVQQ3jCsZi3cW234m+Zktzq5xIAbDUucRGidPq8CJvB7VJBpB4AsWssm5mVgtRpPIA1kaLc+zSNEqRzbnZJ7Y1QeLR3G9TK0JJbrYpWC58SbgVHlqW7WBcAuNAKPlSb+99WBLcT2yl7wAd6PaW0MP8L5dcPMNLqLgHSQAaKyawjIQ38IRN3wPXgF7I8gWkKsanRI67G9dEfbiSAW5Bfr1ZE8vs5b/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MMMvvWpkLK9O/qCA0+nQyRhg/QYxFylSpdpdzng1kE=;
 b=MHSJQLq+F9+NgCBLldcLegwOBXbHAMC4oIhpv8FQYAo5nQ23H/KykNxO2LjOrcW4ruTVzzAzOu+pCxcbI1868oUCJfWKkY9pz0FAvO/lGB7RQQJK7A0cJnkr8tssU0Pp7jVrA66C5oj3F8puK6LH0NhIMxWJqP3Vlw/zRmgR+xOIy4cgtgMPKmvAFyLonv6bhZpYFUsp5AE19EGs2xqeCCixcL7VYh9BieM8C5e9x3/5ZZJpj7v28SAz4yzFphe6VPHXmDYzwax0+LcxoT8OAPcOcppx8dxRCcwA6F+U8Vs5oaaq213YmBd2RhpjQla8d7pyegVlIoMSR5m0So80TA==
Received: from DM5PR07CA0124.namprd07.prod.outlook.com (2603:10b6:3:13e::14)
 by CH2PR12MB4135.namprd12.prod.outlook.com (2603:10b6:610:7c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Tue, 1 Feb
 2022 22:22:31 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13e:cafe::70) by DM5PR07CA0124.outlook.office365.com
 (2603:10b6:3:13e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.22 via Frontend
 Transport; Tue, 1 Feb 2022 22:22:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Tue, 1 Feb 2022 22:22:31 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 1 Feb
 2022 22:22:30 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 1 Feb 2022
 14:22:30 -0800
Received: from dipenp.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 1 Feb 2022 14:22:30 -0800
From:   Dipen Patel <dipenp@nvidia.com>
To:     <smangipudi@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH v4 06/11] gpiolib: Add HTE support
Date:   Tue, 1 Feb 2022 14:26:25 -0800
Message-ID: <20220201222630.21246-7-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220201222630.21246-1-dipenp@nvidia.com>
References: <20220201222630.21246-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8c3f9a1-9357-476c-6cbd-08d9e5d156ad
X-MS-TrafficTypeDiagnostic: CH2PR12MB4135:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4135337DA99D5828476B828CAE269@CH2PR12MB4135.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: faubguJT1e9rG0ZM6l5zSNBCPfNIiankluIaKUQO4jotRL82It5qPjBreOnBOxKF9a8FWB4F/7WNxa9NvTAJec55D9KOdze7HVxjQ7pTGKZqsT5of2mSVD7bGmBNUEXYWLVV/oM86xi5w7ZTf78bbNLbRdPBH5x3D/HjVUPH4TXqsxzqgQjWl7SBDUwDqP9YCptCf4CVuZWNrbP+WLdkY9NMNsitDVNS5r1+sGNGiMHnpry/fNAth4Oskc88MrCaRaW89G0flmNDZBrXEn9vojtPN44rDivlIjF5DblFop39mxE2nFEPX4k040zRCD1OlSHyf4440vggj/eL7xR1eoze+J9qTuecZyHB0vpd94QrQU2MWCCBiUqRUb8U6U34L65JaAGeu1cJgW44XUDSm7ddKdD21Jsl6gVy8kyj4VJByDSo4oVx7cdVK2QdOS8RilYFvNVmBd/CZZ5JVKx4O7vumIH3r4+So5LzD25W/demlK84ySvhChBmsE9QFn8XTn9Hedi8qunuxnmUhGX6ItFfORA6sTVRn5viFKLQab5pLZQx2FZAMqrrBUOoJZxZNwLoPTc9esKNkuscEifQztEZv6685daXNFAEr9FcdSKNTOfYgkzx3faeC1NSRiNYSCbjaeYmKaGUQDTAnJQoAq//ZiZBiDO0FmndF03EFXqb6X0Ia4KH73ixpFpMfRL1Ogr38/VqrcIOF08Gz9ZC5RDYkFo/km8G/1Xc3lh1N8uUdANWPu72e/TNvrnlfpNGSYGxc5TeIaPkKg0v8nClwA==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(8936002)(110136005)(7416002)(8676002)(5660300002)(36860700001)(47076005)(6666004)(356005)(82310400004)(921005)(81166007)(40460700003)(426003)(4326008)(83380400001)(336012)(2906002)(86362001)(186003)(36756003)(7696005)(26005)(1076003)(107886003)(70586007)(508600001)(316002)(70206006)(2616005)(36900700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 22:22:31.3673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c3f9a1-9357-476c-6cbd-08d9e5d156ad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4135
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some GPIO chip can provide hardware timestamp support on its GPIO lines
, in order to support that, additional API needs to be added which
can talk to both GPIO chip and HTE (hardware timestamping engine)
providers if there is any dependencies. This patch introduces optional
hooks to enable and disable hardware timestamping related features
in the GPIO controller chip.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/gpio/gpiolib.c        | 58 +++++++++++++++++++++++++++++++++++
 drivers/gpio/gpiolib.h        |  1 +
 include/linux/gpio/consumer.h | 16 ++++++++--
 include/linux/gpio/driver.h   | 10 ++++++
 4 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 3859911b61e9..e9ffee5f4bc9 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2424,6 +2424,64 @@ int gpiod_direction_output(struct gpio_desc *desc, int value)
 }
 EXPORT_SYMBOL_GPL(gpiod_direction_output);
 
+/**
+ * gpiod_enable_hw_timestamp - Enable hardware timestamp.
+ *
+ * @desc: GPIO to enable.
+ * @flags: Flags related to GPIO edge.
+ *
+ * Return 0 in case of success, else negative error code.
+ */
+int gpiod_enable_hw_timestamp(struct gpio_desc *desc, unsigned long flags)
+{
+	int ret = 0;
+	struct gpio_chip *gc;
+
+	VALIDATE_DESC(desc);
+
+	gc = desc->gdev->chip;
+	if (!gc->en_hw_timestamp) {
+		gpiod_warn(desc, "%s: hw ts not supported\n", __func__);
+		return -ENOTSUPP;
+	}
+
+	ret = gc->en_hw_timestamp(gc, gpio_chip_hwgpio(desc), flags);
+	if (ret)
+		gpiod_warn(desc, "%s: hw ts request failed\n", __func__);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gpiod_enable_hw_timestamp);
+
+/**
+ * gpiod_disable_hw_timestamp - Disable hardware timestamp.
+ *
+ * @desc: GPIO to disable.
+ * @flags: Flags related to GPIO edge, same value as used during enable call.
+ *
+ * Return 0 in case of success, else negative error code.
+ */
+int gpiod_disable_hw_timestamp(struct gpio_desc *desc, unsigned long flags)
+{
+	int ret = 0;
+	struct gpio_chip *gc;
+
+	VALIDATE_DESC(desc);
+
+	gc = desc->gdev->chip;
+	if (!gc->dis_hw_timestamp) {
+		gpiod_warn(desc, "%s: hw ts not supported\n", __func__);
+		return -ENOTSUPP;
+	}
+
+	ret = gc->dis_hw_timestamp(gc, gpio_chip_hwgpio(desc), flags);
+	if (ret)
+		gpiod_warn(desc, "%s: hw ts release failed\n", __func__);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gpiod_disable_hw_timestamp);
+
 /**
  * gpiod_set_config - sets @config for a GPIO
  * @desc: descriptor of the GPIO for which to set the configuration
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 30bc3f80f83e..33acc5754630 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -117,6 +117,7 @@ struct gpio_desc {
 #define FLAG_EDGE_RISING     16	/* GPIO CDEV detects rising edge events */
 #define FLAG_EDGE_FALLING    17	/* GPIO CDEV detects falling edge events */
 #define FLAG_EVENT_CLOCK_REALTIME	18 /* GPIO CDEV reports REALTIME timestamps in events */
+#define FLAG_EVENT_CLOCK_HTE		19 /* GPIO CDEV reports hardware timestamps in events */
 
 	/* Connection label */
 	const char		*label;
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 3ad67b4a72be..e85e590e3ce8 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -112,6 +112,8 @@ int gpiod_get_direction(struct gpio_desc *desc);
 int gpiod_direction_input(struct gpio_desc *desc);
 int gpiod_direction_output(struct gpio_desc *desc, int value);
 int gpiod_direction_output_raw(struct gpio_desc *desc, int value);
+int gpiod_enable_hw_timestamp(struct gpio_desc *desc, unsigned long flags);
+int gpiod_disable_hw_timestamp(struct gpio_desc *desc, unsigned long flags);
 
 /* Value get/set from non-sleeping context */
 int gpiod_get_value(const struct gpio_desc *desc);
@@ -353,8 +355,18 @@ static inline int gpiod_direction_output_raw(struct gpio_desc *desc, int value)
 	WARN_ON(desc);
 	return -ENOSYS;
 }
-
-
+static inline int gpiod_enable_hw_timestamp_ns(struct gpio_desc *desc,
+					       unsigned long flags)
+{
+	WARN_ON(desc);
+	return -ENOSYS;
+}
+static inline int gpiod_disable_hw_timestamp_ns(struct gpio_desc *desc,
+						unsigned long flags)
+{
+	WARN_ON(desc);
+	return -ENOSYS;
+}
 static inline int gpiod_get_value(const struct gpio_desc *desc)
 {
 	/* GPIO can never have been requested */
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index b0728c8ad90c..f28d1e9b61f0 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -320,6 +320,10 @@ struct gpio_irq_chip {
  * @add_pin_ranges: optional routine to initialize pin ranges, to be used when
  *	requires special mapping of the pins that provides GPIO functionality.
  *	It is called after adding GPIO chip and before adding IRQ chip.
+ * @en_hw_timestamp: Dependent on GPIO chip, an optional routine to
+ *	enable hardware timestamp.
+ * @dis_hw_timestamp: Dependent on GPIO chip, an optional routine to
+ *	disable hardware timestamp.
  * @base: identifies the first GPIO number handled by this chip;
  *	or, if negative during registration, requests dynamic ID allocation.
  *	DEPRECATION: providing anything non-negative and nailing the base
@@ -416,6 +420,12 @@ struct gpio_chip {
 
 	int			(*add_pin_ranges)(struct gpio_chip *gc);
 
+	int			(*en_hw_timestamp)(struct gpio_chip *gc,
+						   u32 offset,
+						   unsigned long flags);
+	int			(*dis_hw_timestamp)(struct gpio_chip *gc,
+						    u32 offset,
+						    unsigned long flags);
 	int			base;
 	u16			ngpio;
 	u16			offset;
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E0C50C152
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbiDVWI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiDVWHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:07:07 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5912E4488;
        Fri, 22 Apr 2022 13:52:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgLUcGeaEkrk1tVloHhZ56jqSx8xUDfRwhUbHDHnXWy9W+fL/BD3GcOH8kYqbpiqiXxwcAzghrMmbSGmjhD3ekICynM8DtHtyCAvxP2BpYcRouJuB6XMyYWU9+nnS0qAHeuivzIAylcGX46ajeZvinfLZWPgJrwGg/YnBbT8OC8wOAxkfuAgoCn9AZzgkj0nZLHACqisBrAYqUw/E4Rv9oSQSFFgxVpnVFFowmNuaxDfpFHQmlSZ95YqRPVzlc4/yROqtI/BaMzrQHiuNtOukvUlrmu36rdvvygs2bNe+QL68aLhd2j7b6zSEM0mmTbe/fNCXgrWqTgZdwyJssLemQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITyEFyeFH6hC6eufSq73GhBubBuc5AKwYI6jRdPc+8k=;
 b=LwcndrHLScnTNF9plpiJSPyfWe2RggfUc1Xdlxwu6VYRuiqtrZ0dmkwQLz4iuWEpxMliIHHX6fjtopfBxB2r55UyF5PS96Xl883xv7ZcVwNhUDiUZ5/38x4BQ5uhtofe9OvhwDJKQQER0Moz+MK7B9cUOeRVmnaKzCbPaUgwIH27l4Jn6F9UWGYbpyMWRFSqxB29+q0rM3nw4gshSzBXLSPX9HonifIP+6ex5BnFdZwYq8a9WmIyAkMJMItq9o5fajIVeyr9BdVLoj8hK1IoSNk8eoqLffMElLCfRq4UEVUy0RJ50ZYzievibwBs/W0oO8kvRQrDI+wgihKawqV5og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITyEFyeFH6hC6eufSq73GhBubBuc5AKwYI6jRdPc+8k=;
 b=M5Gmxp1hr0xpPzKJd+m/0fywcAsVGeiWS5+E2wXSqIcEFdooo36sp7lUyuhhb72APCNibCkQtgoCvE7yc3wtoMtIW4n7iNbJLnv3oWEYmUoBHzr2HSB0QQ+GVUQUmNhlkT7y+xfI1jmuPfhZ7Kozp/5wJ9E0vc/OJBRbkMJcx9Xgi5cQXYO/JQSGSAgHUbgHRJzXzDTRRTZPlOu2nMOTpMbzAxtgWWbzvu2aF7z1wUTlXspDSXQ5aQ3l/R0S/ZKTsktLRDBZURrLzcxLBQX5YI4zZvXJ4CS66blrLomp5mb++Dxc+Jr3P5lYDovtFCYgqKtL1cXRIxfQltnaxFsGDg==
Received: from MW4PR03CA0036.namprd03.prod.outlook.com (2603:10b6:303:8e::11)
 by BYAPR12MB3431.namprd12.prod.outlook.com (2603:10b6:a03:da::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Fri, 22 Apr
 2022 20:52:25 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::d4) by MW4PR03CA0036.outlook.office365.com
 (2603:10b6:303:8e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Fri, 22 Apr 2022 20:52:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 20:52:24 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 22 Apr
 2022 20:52:24 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 22 Apr
 2022 13:52:23 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Fri, 22 Apr 2022 13:52:23 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <smangipudi@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH v6 05/10] gpiolib: Add HTE support
Date:   Fri, 22 Apr 2022 13:52:16 -0700
Message-ID: <20220422205221.952-6-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220422205221.952-1-dipenp@nvidia.com>
References: <20220422205221.952-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5ad5410-4acb-4ba4-5fb9-08da24a2012c
X-MS-TrafficTypeDiagnostic: BYAPR12MB3431:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB343173AAF45E4DABE28604DDAEF79@BYAPR12MB3431.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W1arXFGO11icaEQtWStDfYfBrXoM0/YS1kjPB+MYt2RtHklHCsaPp5RZbJGVUjCsnCuwnxE+Pm+VB933HA9y0h/EdtM2HSFAbvtHVGpGjfxDKeRrZSkmXd+HjxeTYRVfQ0CIROXBgRkFxT8W5H/06lYnJXI5mOdTmAxySd2apyQQhY0Zqg6pQRbqBpuFDU3qb5Nov/HXpujgxahl0DVYsdoZoJHRsWHR2czjVHK4P/A7OrYCjfuUmdLwc+ycOLKo9gZipqeF+RqMXa7aRlevd/4ZZzvfelMvDy4Aj2hF2MsLvGV0ImS30yUEWM41XVLK3h8JOsdsOQ4sEBd6uDY16OZZ7zdGSgSCndWMRf7JPwyLdxdAtqVzL3hbCkPqCR5njYXU05JYA7uufbhfhSPTBZDOE4Ud61VgupNrac8SNSOivf4Rr9b89AMWBsjPauw3mpu/wFii3JofRYtRZ8zumzgN5/Vsq8KdCqL+10+ifjbxNtIIcEiXaZWapU3uoctLnj/aJ60q8SqOBn3x4BJczwJXWiDcVJlzgy3JMQd3F4hZG9ChsNpgG6uGvXyArgCjiXdSJXWttHeOLWbFOFGdwbetUrkaNoihyljgR47cWRzwkNmvK778MXzkeipkfTYvA0ynooLXffn2NbXYkkyUjRb1jj6wUcG1YJwUzXybY928lZ8S+eMEelmGvyxwPY7QbsJf7QyMVQN0/K6TxWWFDfENSLVDeEAd5xRplVGLZM4VedwGqXLuYrsCcMCaE61JOEGolDRjFdw+ykvD5iTeug==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(107886003)(4326008)(47076005)(8936002)(81166007)(7416002)(316002)(83380400001)(82310400005)(5660300002)(2616005)(8676002)(1076003)(86362001)(426003)(336012)(186003)(7696005)(508600001)(2906002)(40460700003)(921005)(6666004)(36860700001)(70586007)(70206006)(26005)(356005)(110136005)(36756003)(2101003)(36900700001)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 20:52:24.8240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ad5410-4acb-4ba4-5fb9-08da24a2012c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3431
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Changes in v2:
- removed get timestamp and is timestamp enabled APIs

Changes in v4:
- Removed gpiod_req_hw_timestamp_ns and gpiod_rel_hw_timestamp_ns APIs.
- Added callbacks for the GPIO driver to enable hardware timestamping
functionality if supported which takes gpio desc and flags as arguments.
- Added APIs are called from GPIO provider rather than gpiolib-cdev framework.

 drivers/gpio/gpiolib.c        | 58 +++++++++++++++++++++++++++++++++++
 drivers/gpio/gpiolib.h        |  1 +
 include/linux/gpio/consumer.h | 16 ++++++++--
 include/linux/gpio/driver.h   | 10 ++++++
 4 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e59884cc12a7..60cd7cc33647 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2434,6 +2434,64 @@ int gpiod_direction_output(struct gpio_desc *desc, int value)
 }
 EXPORT_SYMBOL_GPL(gpiod_direction_output);
 
+/**
+ * gpiod_enable_hw_timestamp_ns - Enable hardware timestamp in nanoseconds.
+ *
+ * @desc: GPIO to enable.
+ * @flags: Flags related to GPIO edge.
+ *
+ * Return 0 in case of success, else negative error code.
+ */
+int gpiod_enable_hw_timestamp_ns(struct gpio_desc *desc, unsigned long flags)
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
+EXPORT_SYMBOL_GPL(gpiod_enable_hw_timestamp_ns);
+
+/**
+ * gpiod_disable_hw_timestamp_ns - Disable hardware timestamp.
+ *
+ * @desc: GPIO to disable.
+ * @flags: Flags related to GPIO edge, same value as used during enable call.
+ *
+ * Return 0 in case of success, else negative error code.
+ */
+int gpiod_disable_hw_timestamp_ns(struct gpio_desc *desc, unsigned long flags)
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
+EXPORT_SYMBOL_GPL(gpiod_disable_hw_timestamp_ns);
+
 /**
  * gpiod_set_config - sets @config for a GPIO
  * @desc: descriptor of the GPIO for which to set the configuration
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 06f3faa9fbef..29a7d39062b3 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -158,6 +158,7 @@ struct gpio_desc {
 #define FLAG_EDGE_RISING     16	/* GPIO CDEV detects rising edge events */
 #define FLAG_EDGE_FALLING    17	/* GPIO CDEV detects falling edge events */
 #define FLAG_EVENT_CLOCK_REALTIME	18 /* GPIO CDEV reports REALTIME timestamps in events */
+#define FLAG_EVENT_CLOCK_HTE		19 /* GPIO CDEV reports hardware timestamps in events */
 
 	/* Connection label */
 	const char		*label;
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index c3aa8b330e1c..7eaec081ae6c 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -109,6 +109,8 @@ int gpiod_get_direction(struct gpio_desc *desc);
 int gpiod_direction_input(struct gpio_desc *desc);
 int gpiod_direction_output(struct gpio_desc *desc, int value);
 int gpiod_direction_output_raw(struct gpio_desc *desc, int value);
+int gpiod_enable_hw_timestamp_ns(struct gpio_desc *desc, unsigned long flags);
+int gpiod_disable_hw_timestamp_ns(struct gpio_desc *desc, unsigned long flags);
 
 /* Value get/set from non-sleeping context */
 int gpiod_get_value(const struct gpio_desc *desc);
@@ -350,8 +352,18 @@ static inline int gpiod_direction_output_raw(struct gpio_desc *desc, int value)
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


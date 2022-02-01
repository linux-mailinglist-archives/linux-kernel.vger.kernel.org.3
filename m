Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B270E4A67D9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 23:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241643AbiBAWXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 17:23:02 -0500
Received: from mail-co1nam11on2046.outbound.protection.outlook.com ([40.107.220.46]:46336
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240109AbiBAWWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 17:22:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVc3z6tA9RW7+t7ILjobK4xlGv25DiWHVLa9yCuf4GOlBooDNtXkp+8Fd+ApB2TDaA96+k8Kwr531tezKL91p2wJieTmDQ6w8/t5YyNv2N6n63kz6uhj2/w0spdNTJtU+xQ9mJM02LfNH/4J4rcg/xpsme/9Z5Fq+tAETqu7kbgXdRbJA85o7e7BfTMFOloSndlpdc9ZoyLEjO47gndMZW0QZunfKys2QP4qRSz1gM2LIH5Hro+qwQbM1IrOTWIgxil7sXnI/X6hjv76L6KRPiDIGFnLCje6thfrTK1pIHdK9wJgiGMWjN8faXnz/UlBht9mwdTx7CR/lWaGFJ2uwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3x4tczivBMPailX61T2q3QKjg3lLUWhRm/lDbnird8=;
 b=EmmiRwCDYeD3CHDU0epsBMVpW6BxRTDc1cipD4KmNh+yHGsEgR3FuTtFtyjtfOKdA5SMekUpDWqq6Jmw1HTK6vudApx0o/jSUHfe3B/rGZn6y1UwDZvluK/9AkyvtzP6ayiET31Lzm04b+xiaWjr2DQT8pkaOnaOBL3ypCA6SXDPxkBR93DsL547C8nlopWPpTuBtddbXJcZ4NXRwtclCF4DxttjyzhmsY4bqawIKuegf9osgnk7Mpg10KCILP8Jx67DS+9i15vyGLwMvOqvC3/wa9SKo6ZAnI19GzLGzH8dbeVL1Y8Z3mJ5ZAJfqpNZ0LEFKYyDN4Zg626AJbv9lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3x4tczivBMPailX61T2q3QKjg3lLUWhRm/lDbnird8=;
 b=ap7IfiEb4SemtRu0LjDMe25LKTktW0/WbnnB7WYxP8VBIzvlBbrSst0zqRpaVBcWdyV7ylyFR4IeqWjWohHrlwh56ZK7z7WR6ipyAD+jGKHtUmk3rWrlyJYy3lVLtqWyo4beJWJVTDpkb9F5Zo4a23W+4d6V9Bh2lZ0Y5HP+1yJY62D7KYsiStoh2pP9IKMMRH4t2SevUW50d92OyIRGtO88PvoMyuWC2u2YYudUMfVH2Z31D7YUujNZwVpaDP3K5gzNgfKuQztKuM25Db8teKw2tv7ESUrzvb77cAONYzwYknonUtyexRqN5XNAmktKxNeGxxifI3pq0cPMac/y3w==
Received: from BN9PR03CA0676.namprd03.prod.outlook.com (2603:10b6:408:10e::21)
 by BN9PR12MB5383.namprd12.prod.outlook.com (2603:10b6:408:104::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.21; Tue, 1 Feb
 2022 22:22:37 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::b4) by BN9PR03CA0676.outlook.office365.com
 (2603:10b6:408:10e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Tue, 1 Feb 2022 22:22:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Tue, 1 Feb 2022 22:22:37 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 1 Feb
 2022 22:22:35 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 1 Feb 2022
 14:22:35 -0800
Received: from dipenp.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 1 Feb 2022 14:22:35 -0800
From:   Dipen Patel <dipenp@nvidia.com>
To:     <smangipudi@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH v4 10/11] hte: Add tegra GPIO HTE test driver
Date:   Tue, 1 Feb 2022 14:26:29 -0800
Message-ID: <20220201222630.21246-11-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220201222630.21246-1-dipenp@nvidia.com>
References: <20220201222630.21246-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60593d46-9b9d-4ec6-c781-08d9e5d15a56
X-MS-TrafficTypeDiagnostic: BN9PR12MB5383:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5383FE7699AD135B275E848CAE269@BN9PR12MB5383.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CAYCANsu9niRpJVHM7plntbKejEkgpq/M9Q4qxTDQ4/oaAUDueDJOroszQBQluU1MPYxaoq1HSgXWhaKt0GZ88qBe4miFxnYpFN+kJFR/lrCNO53jHdHmWt+n1VKuUr7yNmRIKT6lG05mu+d47s6w8mKH295rIRCDOp1wIAPVPL+8idiKKQSqFp4Nu+bcqg7JN7WCgfFlwye7+hhihosxCBOyFOPzfPTn5V/H5fSrKlGCwoFVYQCw+IQZoKT9/CgRTs9zC0M+xhbAI9KiNc7eHsci4r0ffDiHcDCmQA+8bJS7oqgOgoAgutYWFkdTgkLE5JEpZzW/0hlsLldcYNY3KSp7rn2/BgVgX08b1EW1FBeTlqyFm+2mBR2t7/XaxokRBIGDCo1oHTnrhioXx4iRgKmWkZuV2we0Dw2pXrETDbOHUb57LeqQWfh3e+biaM66rXF7eG92OGBhN6y0a7XnjPQng9ntB/Jv63uobX1UeB8+snO/EbnmpaRHiPf472M7T7+77hw4noN/bAqbxT+QCOlDsPmo5CdOid+GQ7iZcGjfzhbCt9UYiLE4yyZDVIufGKcM22N0wd2bmVDtnmUu/ZkEMLoQQMC/s+nc2SgLHSjbdDHLBmKPKTQqMlm5SXFcDORraTirRoMr8FWWjS5SYnpmZXwRsZeVG+qVZJsYW2g85n2LLb+l9mlgKj4UmwYTM+VTMZmJLBIMkoxpwXDuQLDZ6GyDAuST9WxKUCmZ5sr2064T36xvoAkGnLGTvJ/mUziZdcl6SeedaZOxzQf+Q==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(107886003)(1076003)(40460700003)(36860700001)(8936002)(2616005)(70586007)(81166007)(47076005)(316002)(36756003)(83380400001)(921005)(426003)(336012)(186003)(26005)(110136005)(6666004)(70206006)(2906002)(82310400004)(5660300002)(7696005)(8676002)(7416002)(356005)(4326008)(86362001)(508600001)(36900700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 22:22:37.4479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60593d46-9b9d-4ec6-c781-08d9e5d15a56
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5383
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra194 AON GPIO controller supports hardware timestamping
through its HTE known as Generic timestamping Engine(GTE).
This kernel space gpio consumer test driver demonstrates HTE
functionality. During probe it registers sysfs
interface /sys/kernel/tegra_hte_gpio_test/gpio_en_dis. The value 1
enables gpio line for the HTE functionality while the value 0
disables that.

The test driver can be compiled as a module and takes optional
parameters gpio_out and gpio_in of type uint that specifies logical
GPIO numbers.

This patch also adds compilation support in Kconfig and Makefile.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
---
 drivers/hte/Kconfig                  |   9 +
 drivers/hte/Makefile                 |   1 +
 drivers/hte/hte-tegra194-gpio-test.c | 273 +++++++++++++++++++++++++++
 3 files changed, 283 insertions(+)
 create mode 100644 drivers/hte/hte-tegra194-gpio-test.c

diff --git a/drivers/hte/Kconfig b/drivers/hte/Kconfig
index dee8b7a2b980..f20f38ae172b 100644
--- a/drivers/hte/Kconfig
+++ b/drivers/hte/Kconfig
@@ -38,4 +38,13 @@ config HTE_TEGRA194_IRQ_TEST
 	  The NVIDIA Tegra194 GTE IRQ test driver demonstrates HTE subsystem
 	  usage for the LIC IRQ hardware timestamp.
 
+config HTE_TEGRA194_GPIO_TEST
+        tristate "NVIDIA Tegra194 HTE GPIO Test"
+        depends on HTE_TEGRA194
+        help
+	  The NVIDIA Tegra194 GTE GPIO test driver demonstrates how to use the HTE
+	  subsystem indirectly through gpiolib API calls for GPIO lines for the
+	  hardware-assisted timestamping.
+
 endif
+
diff --git a/drivers/hte/Makefile b/drivers/hte/Makefile
index 75b7932c2ffc..1d12f3a36709 100644
--- a/drivers/hte/Makefile
+++ b/drivers/hte/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_HTE)		+= hte.o
 obj-$(CONFIG_HTE_TEGRA194)	+= hte-tegra194.o
 obj-$(CONFIG_HTE_TEGRA194_IRQ_TEST) += hte-tegra194-irq-test.o
+obj-$(CONFIG_HTE_TEGRA194_GPIO_TEST) += hte-tegra194-gpio-test.o
 
diff --git a/drivers/hte/hte-tegra194-gpio-test.c b/drivers/hte/hte-tegra194-gpio-test.c
new file mode 100644
index 000000000000..dee5a687e21a
--- /dev/null
+++ b/drivers/hte/hte-tegra194-gpio-test.c
@@ -0,0 +1,273 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021-2022 NVIDIA Corporation
+ *
+ * Author: Dipen Patel <dipenp@nvidia.com>
+ */
+
+#include <linux/version.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/interrupt.h>
+#include <linux/gpio.h>
+#include <linux/timer.h>
+#include <linux/platform_device.h>
+#include <linux/workqueue.h>
+#include <linux/hte.h>
+
+/*
+ * Tegra194 On chip HTE (hardware timestamping engine) also known as GTE
+ * (generic timestamping engine) can monitor subset of GPIO lines for the event
+ * and timestamp accordingly.
+ *
+ * This sample HTE GPIO test driver demonstrates HTE API usage by enabling
+ * hardware timestamp on gpio_in line which is configured as rising edge.
+ *
+ * Note: gpio_out and gpio_in need to be shorted externally in order for this
+ * test driver to work for the GPIO monitoring. The test driver has been
+ * tested on Jetson AGX Xavier platform by shorting pin 32 and 16 on 40 pin
+ * header. The gpio_out and gpio_in can be passed as parameter during module
+ * loading.
+ *
+ * How to run test driver:
+ * - Load test driver
+ * - echo 1 >/sys/kernel/tegra_hte_gpio_test/gpio_en_dis, sends request to HTE
+ * - echo 0 >/sys/kernel/tegra_hte_gpio_test/gpio_en_dis or unloading sends
+ *   release request to HTE.
+ * - Once requested, at regular interval gpio_out pin toggles triggering
+ *   HTE for rising edge on gpio_in pin. It will print message as below:
+ *   GPIO HW timestamp(1): <timestamp>, edge: rising.
+ */
+
+static unsigned int gpio_in = 322;
+module_param(gpio_in, uint, 0660);
+
+static unsigned int gpio_out = 321;
+module_param(gpio_out, uint, 0660);
+
+static struct tegra_hte_test {
+	bool is_ts_en;
+	int gpio_in_irq;
+	struct gpio_desc *gpio_in;
+	struct gpio_desc *gpio_out;
+	struct hte_ts_desc desc;
+	struct timer_list timer;
+	struct kobject *kobj;
+} hte;
+
+static hte_return_t process_hw_ts(struct hte_ts_data *ts, void *p)
+{
+	char *edge;
+	(void)p;
+
+	if (!ts)
+		return HTE_CB_HANDLED;
+
+	if (ts->raw_level < 0)
+		edge = "Unknown";
+
+	pr_info("GPIO HW timestamp(%llu): %llu, edge: %s\n", ts->seq, ts->tsc,
+		(ts->raw_level >= 0) ? ((ts->raw_level == 0) ?
+					"falling" : "rising") : edge);
+
+	return HTE_CB_HANDLED;
+}
+
+/*
+ * Sysfs attribute to request/release HTE gpio line
+ */
+static ssize_t store_gpio_en_dis(struct kobject *kobj,
+				 struct kobj_attribute *attr,
+				 const char *buf, size_t count)
+{
+	int ret = count;
+	unsigned long val = 0;
+	(void)kobj;
+	(void)attr;
+
+	if (kstrtoul(buf, 10, &val) < 0) {
+		ret = -EINVAL;
+		goto error;
+	}
+
+	if (val == 1) {
+		if (hte.is_ts_en) {
+			ret = -EEXIST;
+			goto error;
+		}
+
+		hte.desc.attr.line_data = hte.gpio_in;
+		hte.desc.attr.line_id = desc_to_gpio(hte.gpio_in);
+		/*
+		 * Driver requests irq which implicitly specifies the edges
+		 * for HTE subsystem, no need to setup through HTE
+		 */
+		hte.desc.attr.edge_flags = HTE_EDGE_NO_SETUP;
+		hte.desc.attr.name = "gte_gpio";
+
+		ret = hte_req_ts_by_linedata_ns(&hte.desc, process_hw_ts,
+						NULL, NULL);
+		if (ret)
+			goto error;
+
+		hte.is_ts_en = true;
+	} else if (val == 0) {
+		if (!hte.is_ts_en) {
+			ret = -EINVAL;
+			goto error;
+		}
+		ret = hte_release_ts(&hte.desc);
+		if (ret)
+			goto error;
+
+		hte.is_ts_en = false;
+	}
+
+	ret = count;
+
+error:
+	return ret;
+}
+
+struct kobj_attribute gpio_en_dis_attr =
+		__ATTR(gpio_en_dis, 0220, NULL, store_gpio_en_dis);
+
+static struct attribute *attrs[] = {
+	&gpio_en_dis_attr.attr,
+	NULL,
+};
+
+static struct attribute_group tegra_hte_test_attr_group = {
+	.attrs = attrs,
+};
+
+static int tegra_hte_test_sysfs_create(void)
+{
+	int ret;
+
+	/* Creates /sys/kernel/tegra_hte_gpio_test */
+	hte.kobj = kobject_create_and_add("tegra_hte_gpio_test", kernel_kobj);
+	if (!hte.kobj)
+		return -ENOMEM;
+
+	ret = sysfs_create_group(hte.kobj, &tegra_hte_test_attr_group);
+	if (ret)
+		kobject_put(hte.kobj);
+	return ret;
+}
+
+static void gpio_timer_cb(struct timer_list *t)
+{
+	(void)t;
+
+	gpiod_set_value(hte.gpio_out, !gpiod_get_value(hte.gpio_out));
+	mod_timer(&hte.timer, jiffies + msecs_to_jiffies(8000));
+}
+
+static irqreturn_t tegra_hte_test_gpio_isr(int irq, void *data)
+{
+	(void)irq;
+	(void)data;
+
+	return IRQ_HANDLED;
+}
+
+static int __init tegra_hte_gpio_test_init(void)
+{
+	int ret = 0;
+
+	ret = gpio_request(gpio_out, "gte_test_gpio_out");
+	if (ret) {
+		pr_err("failed request gpio out\n");
+		return -EINVAL;
+	}
+
+	ret = gpio_request(gpio_in, "gte_test_gpio_in");
+	if (ret) {
+		pr_err("failed request gpio in\n");
+		ret = -EINVAL;
+		goto free_gpio_out;
+	}
+
+	hte.gpio_out = gpio_to_desc(gpio_out);
+	if (!hte.gpio_out) {
+		pr_err("failed convert gpio out to desc\n");
+		ret = -EINVAL;
+		goto free_gpio_in;
+	}
+
+	hte.gpio_in = gpio_to_desc(gpio_in);
+	if (!hte.gpio_in) {
+		pr_err("failed convert gpio in to desc\n");
+		ret = -EINVAL;
+		goto free_gpio_in;
+	}
+
+	ret = gpiod_direction_output(hte.gpio_out, 0);
+	if (ret) {
+		pr_err("failed to set output\n");
+		ret = -EINVAL;
+		goto free_gpio_in;
+	}
+
+	ret = gpiod_direction_input(hte.gpio_in);
+	if (ret) {
+		pr_err("failed to set input\n");
+		ret = -EINVAL;
+		goto free_gpio_in;
+	}
+
+	ret = gpiod_to_irq(hte.gpio_in);
+	if (ret < 0) {
+		pr_err("failed to map GPIO to IRQ: %d\n", ret);
+		ret = -ENXIO;
+		goto free_gpio_in;
+	}
+
+	hte.gpio_in_irq = ret;
+	ret = request_irq(ret, tegra_hte_test_gpio_isr,
+			  IRQF_TRIGGER_RISING,
+			  "tegra_hte_gpio_test_isr", &hte);
+	if (ret) {
+		pr_err("failed to acquire IRQ\n");
+		ret = -ENXIO;
+		goto free_irq;
+	}
+
+	ret = tegra_hte_test_sysfs_create();
+	if (ret != 0) {
+		pr_err("sysfs creation failed\n");
+		ret = -ENXIO;
+		goto free_irq;
+	}
+
+	timer_setup(&hte.timer, gpio_timer_cb, 0);
+	mod_timer(&hte.timer, jiffies + msecs_to_jiffies(5000));
+
+	return 0;
+
+free_irq:
+	free_irq(hte.gpio_in_irq, &hte);
+free_gpio_in:
+	gpio_free(gpio_in);
+free_gpio_out:
+	gpio_free(gpio_out);
+
+	return ret;
+}
+
+static void __exit tegra_hte_gpio_test_exit(void)
+{
+	free_irq(hte.gpio_in_irq, &hte);
+	gpio_free(gpio_in);
+	gpio_free(gpio_out);
+	hte_release_ts(&hte.desc);
+	kobject_put(hte.kobj);
+	del_timer(&hte.timer);
+}
+
+module_init(tegra_hte_gpio_test_init);
+module_exit(tegra_hte_gpio_test_exit);
+MODULE_AUTHOR("Dipen Patel <dipenp@nvidia.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1


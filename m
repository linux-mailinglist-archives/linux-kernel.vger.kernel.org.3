Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53724EA789
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 07:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbiC2Ft7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 01:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbiC2Frq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 01:47:46 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2BC24A77A;
        Mon, 28 Mar 2022 22:45:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieLahHl00UQTUDm43Ga60ot9ajnf0GrrspHgwGI29AbbIg0clVBRxdZP5rw742XVu++fNya0CufUU+hwDwE7WDUSRJJyEOIWyzHBfi8nbJnnTCCK/FeWIyF8410Cj2U9gZkHPyj9gvyc5PBqNrFwuWfH2hbKT9tqVi8ECSNj4e8w5UGtpcI+IUm6O8LljS7QUoHIubHRHUi4mAK5I/wNVYGhDOmSbCQ3m1ABjvlVpklEnngbTFFVR0G2gNYKcDJga/mYcWmgRf9XVANDZaVrEU6yLP9DZl6OHPUene/kjpbtDqRJblZDxaHjnL0B5CEpuJcrFgzvx0zXnFM9l6Jk/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKEhf/zCdU6tL7sbr1TEG/NywfImcSTjVLUN12Dg9kE=;
 b=ENaM3YFv2uDcPiejRvlQ06CxBzeIpdnwMDKVQQVHjBwQ3OnZDK2BmRpyOXGRhE683RPwf/T8KP+L2ocNg5wbzL0r7X5g95Qt76pIOpvH3LKfuMQlEP1eCDnUqxmuEvAyz+Uwl4Me3KjwKBR7gWYTd2m7g2/UvpC94wNRSJMUFJlfX22x9UXLH48ArEhRQHMcBS+Ro0p//zbvI1k3dfPH8mR1V+mC4g+Q4MmP3c+4hyVUnc0WXqikA+VCF+lCU8iKdIgcJvJDHiM1iTrR10Fkjmd0ZU4LOv9YjAI5TpEggt2JrdN1EDHpsPSneIMmONn6A+G1jdWcIL074m9qRSqYuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKEhf/zCdU6tL7sbr1TEG/NywfImcSTjVLUN12Dg9kE=;
 b=dZKiavucZIZsdo05jkMrfGVs7cuIWdNRwnFLZznpbArSgyjL4H10GcVNiFEJUdqFtcEp2nh/d1EkN0Efzo1Jzb17QownZWxMpKQYF4XWIn4YaETriuHxaUNKR07mxT6AEuPOXOnWQF8aPSoGLKGUglKhoT3h7VGDPNWZPZUa+9egGv8gRsbnTIT0OUIZIxR1L3pt5w1e0utDj+w0wwPjTTCDuyzuTsiCDXZ1Amlb0yBhflA3Y6GU1mbe615z3V8czkXcztlhb662RC+HejH8Xkj+IxHLxU9Po1RYaSAQWSD61X135BYAiGrj289xrQKqmgI7rGAPuq9JEED47qzhvA==
Received: from DM3PR12CA0071.namprd12.prod.outlook.com (2603:10b6:0:57::15) by
 SA0PR12MB4526.namprd12.prod.outlook.com (2603:10b6:806:98::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.18; Tue, 29 Mar 2022 05:45:41 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:57:cafe::80) by DM3PR12CA0071.outlook.office365.com
 (2603:10b6:0:57::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18 via Frontend
 Transport; Tue, 29 Mar 2022 05:45:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5102.17 via Frontend Transport; Tue, 29 Mar 2022 05:45:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 29 Mar
 2022 05:45:40 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 28 Mar
 2022 22:45:40 -0700
Received: from dipenp.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Mon, 28 Mar 2022 22:45:39 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <smangipudi@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH v5 10/11] hte: Add tegra GPIO HTE test driver
Date:   Mon, 28 Mar 2022 22:45:20 -0700
Message-ID: <20220329054521.14420-11-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220329054521.14420-1-dipenp@nvidia.com>
References: <20220329054521.14420-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30cfe2c9-5322-4f39-5e7a-08da11475c11
X-MS-TrafficTypeDiagnostic: SA0PR12MB4526:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB4526A61D7746FF7FA9DAB967AE1E9@SA0PR12MB4526.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4DcxqQWQfsEDpb3nIz6azFGzUjDnBLn/Ll3GoiIaQ9l5pnvnKZR35WoGjMS0X1NwEFDiT2QgzKPmPdKndYe3weqcLnu724WostOF13O4Py4sUI0PVXqIH7P2wYyskXIYASoiAQ+a2pyVRY0h8wDtXBC7wuSfAzafucp+HVs3athm0VAaJeAnv7g6TwC2V3yM1WBaWBJ1+o1tpmU/QmS8npj1D/YNhXGX18HpV42imDFSh0rPOO5H/xQWaVoJv8ZIXmvjJjjK61E4SOuWFkRu3R+ziayedhOtnvTayGENfLfKT/M81v9JJPt/6F6hbfTOZ1qW49/BK27lNjlL/VmowwwrsIvpm79J3wbY9srFhC2Jq1jcbYYhpMz8zJ4T/JtMygrKZk4ZQXUb/EuUFT9tmKxexbPUruMfCkLIqnJyKHwhrRy4bmJT43Q1m2YagXz6VXdppFB/V8XuxRJ7Qcaz7F9Eo8GhTCL++rsSanl92H3lgwP7SuzwovM4Gp9EiUyrVNQ9GWl0tp98Ufl9BTYoHuSFjh9WVLz9egDU2Wt011TfTcNo9w624Mc0zUs6mUyCyjV6ODsmwxhJtQA6Ga0zRjLXeRk+wZlXZqHnpjVu3lkuU/kPIJhSN+D8veHu8JxkA1Pfgncx4fU1N519tat0Ca/ePQPFD+aE6McDrHkFkr42zKtB+0U1P2C7H2hCZ/XYt58Hl2/KQPNH4k0AUtHR/itzsEcW8npKR6x5Z1+/HB9GFncZs77dn3NCgOK5LkQSUrAhJjXZ6BLHTo+27YCxJQ==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2906002)(40460700003)(47076005)(83380400001)(36860700001)(316002)(186003)(36756003)(6666004)(1076003)(110136005)(26005)(5660300002)(8936002)(7416002)(70586007)(86362001)(921005)(356005)(8676002)(4326008)(107886003)(2616005)(7696005)(82310400004)(508600001)(336012)(81166007)(70206006)(426003)(83996005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 05:45:41.0088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30cfe2c9-5322-4f39-5e7a-08da11475c11
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4526
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Changes in v3:
- Addressed grammatical errors.

Changes in v4:
- Reflected HTE and GPIOLIB subsytem API changes.

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


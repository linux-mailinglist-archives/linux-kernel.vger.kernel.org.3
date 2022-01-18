Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928974912BD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 01:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244068AbiARATH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 19:19:07 -0500
Received: from mail-dm6nam10on2065.outbound.protection.outlook.com ([40.107.93.65]:13472
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243897AbiARASu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 19:18:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6w+x7E2e6iwPlgTX0gJNOPQf1IPeUPkfTeLGcLdEBJ0rmY7DCyvPJVcIo3EycJVrQzq2YHd1cDJx3KLiKpafMff/phJ0O/zi8Au0qV4atcleEGeDTjzqKQ1hPArHME50fqMi0BIRytBD8pbiQioLGhPgQrUOy35hMw/vmsDtRAw2OVAFt5Hycyrb8/HFmnT2Yaswf638jHQnlW4dtH4fVtjE7hkqh0IhkC2ZXrCkN5AMl9ivxhnPeJGpctLCK9IHmhPoH884QsGeaInx+IcfXXx9lLfGbWTOirlVySD2makfPtCoU7C071IUpNjqbR/9ju/4SksXLnelk9Kv/0EKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKEhf/zCdU6tL7sbr1TEG/NywfImcSTjVLUN12Dg9kE=;
 b=BcSm3Vb484dH7wzxhrto5dMVfO0mU80xvkdwx/Qz35jfQgzK3QGUZ7kCjLc5xNdU1I27TF/kHxrV5TSUW0TTakFYoj3myGTO8/AHo4D0R81kM0yWB7HDtKQyRS6gtOiTjjd3QPE3AKoRxgUv0Tx7Z2/w3bV+KoxhUpf8T7NcpXMNLRADyX3E2VUrZcpj7nrs2LdvNlc1sMPBkX4FQVVSs9VxnjyumbCh6zs5r8LrpntcpnoAnvwgbAy31LuNYIQm4BfzhcuMRiOM2Jdrcn50H2l3M1neFxjZu0I/lqMytIpnd4ZCS1jxQnFVVK8B0cY/wPPwhcJ/CLcUgBtavhhi0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKEhf/zCdU6tL7sbr1TEG/NywfImcSTjVLUN12Dg9kE=;
 b=hDoXXKZBr3Elz0GHaq42h8ngKI+DFB3F9ubweRXFMw1CTOrgTvx7kIGNRzvHRqMGK0ygu0yRUr8043ucdENO2OknumDLawPmSDIK/8elnEE8OxiIpQa0xFF3MV9a2E3i/n1ja6awcu8oW3D88FavZYFBaGWHHf2IGeQCcZ8zS/lDqbTZd4wY1P4ON21fsK5mXpnONqLNzaosGDaoNP2RNEGhYhCQre1XgFwtex/7Tum5OLszAmhm/TEIwbQQtfnHPMrmpMtittPTJanQ2w6cDpsV0mvkuBwZlOWi7mBYUceewKsOdK4CezIuaMLCuqqRQYLDFbHRfl2Z+1Xz/uhBQQ==
Received: from DM6PR11CA0026.namprd11.prod.outlook.com (2603:10b6:5:190::39)
 by MN2PR12MB3965.namprd12.prod.outlook.com (2603:10b6:208:168::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Tue, 18 Jan
 2022 00:18:48 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::f9) by DM6PR11CA0026.outlook.office365.com
 (2603:10b6:5:190::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Tue, 18 Jan 2022 00:18:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4888.9 via Frontend Transport; Tue, 18 Jan 2022 00:18:47 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 18 Jan
 2022 00:18:47 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 18 Jan
 2022 00:18:47 +0000
Received: from dipenp.nvidia.com (10.127.8.14) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 18 Jan 2022 00:18:47 +0000
From:   Dipen Patel <dipenp@nvidia.com>
To:     <smangipudi@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [RFC v4 10/11] hte: Add tegra GPIO HTE test driver
Date:   Mon, 17 Jan 2022 16:22:13 -0800
Message-ID: <20220118002214.18271-11-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220118002214.18271-1-dipenp@nvidia.com>
References: <20220118002214.18271-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 666a7076-8032-4460-a345-08d9da1818de
X-MS-TrafficTypeDiagnostic: MN2PR12MB3965:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB39656E1409C8789FDBA1BAEDAE589@MN2PR12MB3965.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X/QQPAPbtLp0/NPul3/uGfD99a27vUklni0EwHBt/OHlXaOLBe5OUfaX9p8BwkNc1MuLk+mMkVKLmhfW01V/6nVRJ4tiRO0iiOY9E6Pf7uhkIdGXQ/U3ao9OFqZeaYUGf9Ncb/ihmgkFNwevOkSbU4PNIqZD/bgHD13Tl7WffcrnXRBYhDbm18Ea8Hkl01JkRl98Zljtm75+ox7jYTjBm84z154jRwQekXedO6Vi5wZyE99ZUjn+yES4fP6MK0Ojb9wsJFj9eep7eppwhpHhryiY9AegFetlT0Xx/lJg1mBRCqe4oMYBL9RjasKlolaNQe1ydJou2aUgZruQRJjvyBEh5DGlXM+l2rYYcAlcUw08dM4WbpJfQOrHj6P9244jZhKrVm5fMSMcw6eZP2ZEdLmiqR35EUrFqWLFQlD8N3KhPPyaflzj/ss1/NQbW9GJDLv91qN6p79WQg/lQJ5hIYfbuKtt92iDe/cPWQHmbNaSwv3xbpCUZIKkiqA7At5y4OyXOihsH8H3Rh0YvmvFgrjl3kURIw8GOtcqDhMDBA5KpbPHi7muyiLWOTZ3cMRVDiIj8e3pPCm7r7qLfE/tcIbv3H0UVemJUaA0E3eF/C0F57l+eldP6uuT2JpFK6KHC8/pGUvj/+znlj+52ZNKNxgjRRT68aUBHctCBJxM1j1WAM/gXaccZKC+wlmZ8sUC0nlHH2XTGOBKYtOAqM3yCfrWXqp/POaxi9TwwdaqB3QyRvIt1hplF3bZF+QjTwsygo0pBpF3nv4Pd9K2Ep4AwJpsnKPizZP+sjgSVrWbVI7fAWbY6Y52Yu5LMaWQ8df+UDfoLoqg0DCujFkhivyXcyUjElvvKhTxckahNHQHFpY=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700002)(336012)(4326008)(83380400001)(8676002)(508600001)(40460700001)(8936002)(26005)(70206006)(70586007)(921005)(36860700001)(82310400004)(426003)(186003)(86362001)(2906002)(7696005)(1076003)(5660300002)(81166007)(2616005)(47076005)(107886003)(6666004)(110136005)(7416002)(36756003)(316002)(356005)(36900700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 00:18:47.9231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 666a7076-8032-4460-a345-08d9da1818de
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3965
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


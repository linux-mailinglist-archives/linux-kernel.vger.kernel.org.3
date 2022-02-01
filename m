Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692274A67D6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 23:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240925AbiBAWWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 17:22:52 -0500
Received: from mail-dm6nam11on2044.outbound.protection.outlook.com ([40.107.223.44]:47745
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239227AbiBAWWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 17:22:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6+ki7Dvruc+JRedPxGJM9B5ZXsgiplC+T6DsejlhqJovT8OEfWMHemEtU0rkAzWbdjRCayuZwXFJPc+4L2wOapbNrMcs6u5JxLjKHxGLhniCvVO2J95r/VBIAH2SHIoUlqSNmLTnLaSz05bcmJMjMVWK1ahfCPxW4e7SvwIN7r52/+UkGeOYLmKlLW+mHOZ/hVywOEtyGBjav5ScttIWILkPTJ15g4DU5HziokIe/7l++5ockurA1qtwwj7px7RGtQIfwVUlk5XkbQ/9Jeq+cHC6H+7lEl9PmW/S4M6XW4q3EfTWThFnUgLSzVNEY+73Cs/sMG+zr+koGXc6d5X1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SgoCthrpCOpI1N1e66JMVkOexy0KhB2qUNl44jUmZw=;
 b=blbhduuPk5kltNLNJlKFoRMO2NWV3+FHrl2peWygEEuMMTuNiEmbLoe9u6merlNu5KEsWQZ+tcLJggv9k2Nk7V+TiAT15oPnpHl/jHFi16OhqdTVrZz5WevGXUdvwdLD9ZghCp9FO5fJOkbkaaNRzvKckK9SLQvBc5orsjEi/lwi7LruLkqhLF1xNtlclAdJ+JmstfUoOalj7LYuPa5u4f9k2QkSRczwUrJ3sWRSjWBiL6RxkM+HML6rf7y5ki0cUCn5+ik0OuqbYs1qGT/Ut2q7NTdY4akuJJGfkYEZW6TZNGp36H70v6SElb4VTv/Z2TayaEQtTVxJWMzGd6eSig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SgoCthrpCOpI1N1e66JMVkOexy0KhB2qUNl44jUmZw=;
 b=mKtKkoovc4fcO2PBU2t4HLuI95VHt47q0yAKFjX1/8082G4b8uQZJ3ppP5tOJj0VZwlaHir/2+6/TtFd0pvhA6ohElLdPZcNkGTb89h8lS0mMBFEmvWvM0/vQZ+clf5/+8s15Ti0S8wLjyq8txVJmIHvtFYLaVwVoGqAeJ95E8KWpcfayGqEDSm0dea5cZ3yL+RflHUZ/rWbkfqdxmfhMW9GiG36KXZGOALCWMntFpyuZ+YuoXy5aZ59qY5T2HfLHOGwNW16mp6P/aT4T7sBK77WNH2xi01pcFm9JH5wI8GPUZhOhQStC8MsHiuP7S06ReNgRAgms79yKrBTKdIjmg==
Received: from BN9PR03CA0084.namprd03.prod.outlook.com (2603:10b6:408:fc::29)
 by BN8PR12MB3060.namprd12.prod.outlook.com (2603:10b6:408:4a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Tue, 1 Feb
 2022 22:22:32 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::c5) by BN9PR03CA0084.outlook.office365.com
 (2603:10b6:408:fc::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Tue, 1 Feb 2022 22:22:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Tue, 1 Feb 2022 22:22:32 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 1 Feb
 2022 22:22:29 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 1 Feb 2022
 14:22:29 -0800
Received: from dipenp.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 1 Feb 2022 14:22:28 -0800
From:   Dipen Patel <dipenp@nvidia.com>
To:     <smangipudi@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH v4 05/11] hte: Add Tegra194 IRQ HTE test driver
Date:   Tue, 1 Feb 2022 14:26:24 -0800
Message-ID: <20220201222630.21246-6-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220201222630.21246-1-dipenp@nvidia.com>
References: <20220201222630.21246-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d41a8cf-0876-41a1-ab7a-08d9e5d1571b
X-MS-TrafficTypeDiagnostic: BN8PR12MB3060:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB30609760CCAB03A81DB554B5AE269@BN8PR12MB3060.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zxR3Sp4dvU9UJF+OXb8NTPYmkf7HG4NGFU8sUENV5LySXwY7MMeT92nCQMU1hjmEvtJvY9wA2Nrh6bNz3gqRF8XQC23S919NZogorLKHI7fzLgo9FOTUY7nY82f/on6Pj0Pm7+X21N0A/a1OhMMX0841LMowLUB131Nr3inW2lnsI58B7vVyoYsk7ZERUDRJ15RMa51DNHLSW2fdOxdaUIKie2mVo2BEwzY9o2eqrMhZg9cNGB9Zs1FV+yNWtS4ST2ZZj+4tfIRO20/jPzo9U50KjEXGSpmi+SdR9rdE3fZiDJLWMCbMP+FoBynCBq95qh2Xy9pnGUuV3g8oPc/671YR6YvCLM0jOu1UGABGl8xfXuDv3d8BcBI8h/+mm/cmmILWAUVirUs43z7gZhypBqcXpOKo5vLSwRafkc6FbtLXUUQWlV8cuuDD1iFF3Tpr+tdzYfxLUxt5Xwu1Dvi/fqn3duK3R7A6CiKmequpXfdi9JdFQrRk48rY3gbsDKhHz1GzRPpmNN/+TTO2WC14so8CEWpjO8mSROBfQHD71i58ufLM8iK/2GbMwyovt4Un3fv3cG45jCSnGO/kLt0ppTYSZzWOfRqAWF+5viF2FY5rezD9dFpRAnOJbNxlZZgzvLXB8QTscDmEPI92CxHf48E97OT+N0ZgXR01WLKr1DwCtwGXaczvJmAEKGw0S7n+6DyxhsjqienanwG4CjuyXbi3BmC0xDGYa7FvzHtBMjPxKJdxRza3hcmdDLIdk/5Hnh3cZuX7Q4LKFYfGFDquzA==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(1076003)(26005)(47076005)(6666004)(7696005)(110136005)(5660300002)(2616005)(7416002)(83380400001)(107886003)(2906002)(186003)(82310400004)(336012)(426003)(40460700003)(70206006)(508600001)(86362001)(921005)(356005)(316002)(81166007)(8936002)(4326008)(8676002)(36756003)(36860700001)(70586007)(83996005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 22:22:32.0273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d41a8cf-0876-41a1-ab7a-08d9e5d1571b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3060
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra194 has IRQ HTE provider which can timestamp IRQ lines in realtime
, this test driver implements consumer side which tests such provider
through HTE subsystem. During its probe, it registers sysfs interface
to easily navigate from userspace as below.

All the files are at /sys/kernel/tegra_hte_irq_test/.

- en_dis - Write only, Value 1 enables HTE line, 0 disables it

This driver can be compiled as loadable module and is tested on Jetson
AGX platform using 0x19 IRQ line which belongs to i2c controller
3160000.i2c.

i2cdetect -y 1 from the userspace on this platform should be enough to
generate LIC I2C IRQ. The HTE should be able to generate
timestamps for each interrupts.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
---
 drivers/hte/Kconfig                 |   7 ++
 drivers/hte/Makefile                |   1 +
 drivers/hte/hte-tegra194-irq-test.c | 179 ++++++++++++++++++++++++++++
 3 files changed, 187 insertions(+)
 create mode 100644 drivers/hte/hte-tegra194-irq-test.c

diff --git a/drivers/hte/Kconfig b/drivers/hte/Kconfig
index ebd9817651c2..dee8b7a2b980 100644
--- a/drivers/hte/Kconfig
+++ b/drivers/hte/Kconfig
@@ -31,4 +31,11 @@ config HTE_TEGRA194
 	  systems-on-chip. The driver supports 352 LIC IRQs and 39 AON GPIOs
 	  lines for timestamping in realtime.
 
+config HTE_TEGRA194_IRQ_TEST
+        tristate "NVIDIA Tegra194 HTE LIC IRQ Test"
+        depends on HTE_TEGRA194
+        help
+	  The NVIDIA Tegra194 GTE IRQ test driver demonstrates HTE subsystem
+	  usage for the LIC IRQ hardware timestamp.
+
 endif
diff --git a/drivers/hte/Makefile b/drivers/hte/Makefile
index 3ae7c4029991..75b7932c2ffc 100644
--- a/drivers/hte/Makefile
+++ b/drivers/hte/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_HTE)		+= hte.o
 obj-$(CONFIG_HTE_TEGRA194)	+= hte-tegra194.o
+obj-$(CONFIG_HTE_TEGRA194_IRQ_TEST) += hte-tegra194-irq-test.o
 
diff --git a/drivers/hte/hte-tegra194-irq-test.c b/drivers/hte/hte-tegra194-irq-test.c
new file mode 100644
index 000000000000..9202e4ac5659
--- /dev/null
+++ b/drivers/hte/hte-tegra194-irq-test.c
@@ -0,0 +1,179 @@
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
+#include <linux/hte.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/workqueue.h>
+
+/*
+ * Tegra194 On chip HTE (hardware timestamping engine) also known as GTE
+ * (generic timestamping engine) can monitor LIC (Legacy interrupt controller)
+ * IRQ lines for the event and timestamp accordingly in realtime. Follow
+ * technical reference manual for the IRQ numbers and descriptions.
+ *
+ * This sample HTE IRQ test driver demonstrating HTE API usage by enabling
+ * lic irq line in HTE to monitor and timestamp.
+ *
+ * Device tree snippet to activate this driver:
+ *	tegra_hte_irq_test {
+ *		compatible = "nvidia,tegra194-hte-irq-test";
+ *		hardware-timestamps = <&tegra_hte_lic 0x19>;
+ *		hardware-timestamp-names = "hte-lic";
+ *		status = "okay";
+ *	};
+ *
+ * How to run this test driver (It is tested on Jetson AGX Xavier platform):
+ *
+ * - From above device tree snippet, it uses 0x19 interrupt which is for
+ *   i2c controller 1.
+ * - Once loaded, echo 1 >/sys/kernel/tegra_hte_irq_test/en_dis, it makes HTE
+ *   request on above IRQ line.
+ * - Run i2cdetect -y 1 1>/dev/null, this command will generate i2c bus
+ *   transactions which creates timestamp data. The driver print timestamp data
+ *   on console as IRQ HW timestamp(1): <timestamp>.
+ * - Unloading the driver or echo 0 >/sys/kernel/tegra_hte_irq_test/en_dis
+ *   disables the HTE.
+ */
+
+static struct tegra_hte_test {
+	struct hte_ts_desc desc;
+	struct kobject *kobj;
+	struct device *pdev;
+} hte;
+
+static hte_return_t process_hw_ts(struct hte_ts_data *ts, void *p)
+{
+	(void)p;
+
+	if (!ts)
+		return HTE_CB_HANDLED;
+
+	dev_info(hte.pdev, "IRQ HW timestamp(%llu): %llu\n", ts->seq, ts->tsc);
+
+	return HTE_CB_HANDLED;
+}
+
+/*
+ * Sysfs attribute to request/release HTE IRQ line.
+ */
+static ssize_t store_en_dis(struct kobject *kobj,
+			    struct kobj_attribute *attr,
+			    const char *buf, size_t count)
+{
+	int ret = count;
+	unsigned long val = 0;
+	struct hte_clk_info ci;
+	(void)kobj;
+	(void)attr;
+
+	if (kstrtoul(buf, 10, &val) < 0) {
+		ret = -EINVAL;
+		goto error;
+	}
+
+	if (val == 1) {
+		ret = devm_of_hte_request_ts_ns(hte.pdev, &hte.desc,
+						process_hw_ts, NULL, NULL);
+		if (ret)
+			goto error;
+
+		hte_get_clk_src_info(&hte.desc, &ci);
+		dev_info(hte.pdev, "clk rate:%llu, clk type: %d\n",
+			 ci.hz, ci.type);
+	} else if (val == 0) {
+		ret = hte_release_ts(&hte.desc);
+		if (ret)
+			goto error;
+	}
+
+	ret = count;
+
+error:
+	return ret;
+}
+
+struct kobj_attribute en_dis_attr =
+		__ATTR(en_dis, 0220, NULL, store_en_dis);
+
+static struct attribute *attrs[] = {
+	&en_dis_attr.attr,
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
+	/* Creates /sys/kernel/tegra_hte_irq_test */
+	hte.kobj = kobject_create_and_add("tegra_hte_irq_test", kernel_kobj);
+	if (!hte.kobj)
+		return -ENOMEM;
+
+	ret = sysfs_create_group(hte.kobj, &tegra_hte_test_attr_group);
+	if (ret)
+		kobject_put(hte.kobj);
+
+	return ret;
+}
+
+static const struct of_device_id tegra_hte_irq_test_of_match[] = {
+	{ .compatible = "nvidia,tegra194-hte-irq-test"},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tegra_hte_irq_test_of_match);
+
+static int tegra_hte_test_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	dev_set_drvdata(&pdev->dev, &hte);
+	hte.pdev = &pdev->dev;
+
+	if (of_property_read_string(hte.pdev->of_node,
+	    "hardware-timestamp-names", &hte.desc.attr.name))
+		hte.desc.attr.name = NULL;
+
+	ret = tegra_hte_test_sysfs_create();
+	if (ret != 0) {
+		dev_err(hte.pdev, "sysfs creation failed\n");
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+static int tegra_hte_test_remove(struct platform_device *pdev)
+{
+	(void)pdev;
+
+	kobject_put(hte.kobj);
+
+	return 0;
+}
+
+static struct platform_driver tegra_hte_irq_test_driver = {
+	.probe = tegra_hte_test_probe,
+	.remove = tegra_hte_test_remove,
+	.driver = {
+		.name = "tegra_hte_irq_test",
+		.of_match_table = tegra_hte_irq_test_of_match,
+	},
+};
+module_platform_driver(tegra_hte_irq_test_driver);
+
+MODULE_AUTHOR("Dipen Patel <dipenp@nvidia.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1


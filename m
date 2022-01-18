Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE074912AA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 01:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243941AbiARAS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 19:18:56 -0500
Received: from mail-mw2nam08on2070.outbound.protection.outlook.com ([40.107.101.70]:14945
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243858AbiARASr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 19:18:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDOQQeqHHoDF7Er7GEcJQDQnFjOfzS/pNf6dD5KeFEoL6sOEdUCO+0vq0VH9Jq2/jUu4i8YGSQs2d0fh07jjhMsVEGsKsBiDmruB8oSCHNKwaXBHYLwebrmq7KNJbv4o5f7dhpQMMXBKxz4g35QvZT5Ehb/y9oSmAitzxPPdCaczVGTvPOTnoQ7bvebz4xyS1PvPr4EfKNh/g7iKUw8cbz78ZWo/V4AahManPs9opok7vaIg2pOKt/nEDdBiq7b8eXovielEbseOdETOvvYqPB3F0vCWJAQTnjLJUoEJREgB/xMgU7CXaZfr5G63sOTneTxGy7R/WrFAIFSKJHLeHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SgoCthrpCOpI1N1e66JMVkOexy0KhB2qUNl44jUmZw=;
 b=m4DsktPDBaSd8Kn8JxyrJdT1CXJ6qGcJfTTjRl6PVGn9avJtnRvqM6yR5+YNQ5TrUH/bhTpgfvr9ibcJQQfF4CEp5Bc01xP1PIr0LvCi6MfZSz8Xp7pXQB0CfRd0xR9GEqoQd2mLCRVYVAEgoAmwC+rFuxEiHPovBT5bt5gVYdw0iIVrL4CRw2+oyaBfdCfeINwmwT+1+Jcpzo4Wwd588MMNYMNs4hkYflplCo3+DiGu5lmxXJ5UPnfpIisM1+O/6whoW1OO7zRH3ez+UsxeXefKCV0f7mCOZktdq/olpJz8SKOxEbDxzBQ5YjQQOMBZq9EaRxph+G9gxGlt8vektg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SgoCthrpCOpI1N1e66JMVkOexy0KhB2qUNl44jUmZw=;
 b=ogjqq3SiT1NPGg00+X8FpvycxvxwNUbVc+YhXC2aJRnmUTL101dxN/8j4QYwNV0SZwkTMEiwYoyDdU2iEHwyojhWOxZ6fBknWCWRiMGRiAVTiFkD9MZLrHo/C4LiCLtG65iQIsc6BtHhDOTeVSk20Fqv2I6Nv26fKFZ3h/ieq2UMQqjyYnrG5AZLdYfjYDyDuXymjbcQHv9TjPfzVjzpx28ig6bjrJCEO9zq+ujCYa58IKLvCvgA+ByrA5v9vDA7NTWFJZaQBrHaC74i0NrqkcofeS4S6DP6qkWiDJfIfGsphnyt95SkgEgLcvshiebwjLHx55+mx3YHBARcmyDjtQ==
Received: from MW3PR05CA0004.namprd05.prod.outlook.com (2603:10b6:303:2b::9)
 by CH2PR12MB5561.namprd12.prod.outlook.com (2603:10b6:610:69::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Tue, 18 Jan
 2022 00:18:43 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::8d) by MW3PR05CA0004.outlook.office365.com
 (2603:10b6:303:2b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.2 via Frontend
 Transport; Tue, 18 Jan 2022 00:18:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4888.9 via Frontend Transport; Tue, 18 Jan 2022 00:18:43 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 18 Jan
 2022 00:18:42 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 18 Jan
 2022 00:18:42 +0000
Received: from dipenp.nvidia.com (10.127.8.14) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 18 Jan 2022 00:18:42 +0000
From:   Dipen Patel <dipenp@nvidia.com>
To:     <smangipudi@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [RFC v4 05/11] hte: Add Tegra194 IRQ HTE test driver
Date:   Mon, 17 Jan 2022 16:22:08 -0800
Message-ID: <20220118002214.18271-6-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220118002214.18271-1-dipenp@nvidia.com>
References: <20220118002214.18271-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69156ae8-76e3-4e5d-a7ef-08d9da18161b
X-MS-TrafficTypeDiagnostic: CH2PR12MB5561:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB5561FD86C1C92280E6306B1AAE589@CH2PR12MB5561.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j7FUnErpsDArUdjJYpR6Q6lXvTjy+7NZl9MK86IgsFidCj+0HaHESiXYgNHUmcpwZ4zHoXsVvBTlEf2i6QkMa/reFz5hZezSokXOhHJ7SCwqUVGsWoMbGZEQb1Ro2mqI5HlsJ9ZRCuPlypcTP1JiStERghwl/CKWpEj0IEzh8AHrDBPA9YcKP7i2uQ2h5r+UQcT1fD0G6dCpV97tRBp8AbpcnYWHEXdB5oP50zBEFurQU1+z7zvOqwNscRpBukASxGyNoVYNBO56SCJL9jHp5HHGnD/Pakx5cIyRFJvynIl4qVEAxyCAT12ZA68+27SUV9X2BvNYldpuG3Z1W6ZmVreXKvJVLy4U+HdRrqMr0rqiflGRygedgzD+yjivI5cCmFmozpZAdnMX2seaOWZcd03IFke0SohcpCFHcBlbL0veaMPjzzxzLLo8y+IVfTrC+/drWYvO1tQ41TTiFFaaEVTcY8k1aV/Hc7/iCKK/EUvF+Op97H0bukB6QA8yPKblHDsgQT6/8mo5JP1COWj8bPRiv6STTGoIZoNU7zl90E71fkrMlJHJ2r9d61OdS2Ry4yNYj1EwnGcFhpp1SJl7mnuNkwv5d3Ru1v6X8rUUc0sLZ5AEpe7HfmYkec5u+up1TDzvLamQc5orgI9gUVn7uqHfuq+IrQBFrkgUxoJRUmdRjX1inS/AY6uqy4KVtJWYYYQeUJkNNHUVppr6PTeGjvCXY7Qnt4qaNISuqaxjQCfTwGvwMs6ugfuqInLnIEFWqAkj5xselzJnYIqeW+b4xIOBZ5wo3HDmY3ZvrtRiGIlVDBP9olcXb6xPZRrc77T5l7o2cM2wNVwzGJUEEbBesu2ZrvRHGXEFPXd4zPh64Bg=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(40470700002)(46966006)(36756003)(316002)(186003)(426003)(2906002)(2616005)(336012)(107886003)(70586007)(70206006)(8936002)(7416002)(8676002)(5660300002)(6666004)(110136005)(4326008)(508600001)(7696005)(921005)(356005)(86362001)(26005)(40460700001)(83380400001)(36860700001)(81166007)(82310400004)(1076003)(47076005)(83996005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 00:18:43.3523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69156ae8-76e3-4e5d-a7ef-08d9da18161b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5561
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


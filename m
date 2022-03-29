Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087074EA77C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 07:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbiC2Frt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 01:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbiC2FrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 01:47:20 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2047.outbound.protection.outlook.com [40.107.212.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A19A24A882;
        Mon, 28 Mar 2022 22:45:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXl4c861H422SCR0jHYrKv0LG8IXQ6hYuSBOBOE27g71GeYpl3LSomLhl91LXshZ558Wf+tyYBAknj+wBte44XDSSGAGtzU5KxBhHeDyQkugegWhYpHNZD2U7BjmyRcQ7NQ6McVwf68yEc+sFBvzbqvbiwI/+OsoOSn1dXNHlIuVyDJ3vts1ke1cVEujh1PQ901Z/D8e0qqaABan6RdJeoXYd79OSTftYYJhddftYqAiMNgzo3n6Ac5qxXMVOVzNuz+1a8ojiwB3fqcE2FLfvpciZACpIo+cgKRtHjcShhV5pzZggBm5ztRx7f5RXV+KjJ7xFqMUz7kC0qPqtJvVNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SgoCthrpCOpI1N1e66JMVkOexy0KhB2qUNl44jUmZw=;
 b=I0seCkJneSVMGS6YVBHp2yoP6QCg5bssi2Gb1tESk3AQZxL6C3BySnm0o49qsKp9wmJDc5w08TR7VsLN28sTjNP8YX6ERNFRW8Olnlw0SakpjCK8vfAEilhgrt+AVmA1M4cAHAiNtrAKExEQ6RNWQzxq0GVj5J1DmpT33eMvo8tax63IuUslvgSNs963Xj6YK4i++z8Y1g0YzeuXMfmoFvKhZYIirXV+V/OcpNkUk3H0fUxNO+eJts7UNCxHyutf9hK8kmdpHJx9Rbh4CZDUnhWQlXEXWWZw6Idy5lwpFoxf4LiWxJdmdq5uq2Ziuo4qX7KtTysiURB0alL3P+UocQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SgoCthrpCOpI1N1e66JMVkOexy0KhB2qUNl44jUmZw=;
 b=YtkP+bUX+whlxpAjcoZ/fQq4iRy6uqLF/EGMhtMv5u/nb3V4fjNDts0mSy2aMKexKyYl5Py4AiA31nCpMZTST4HXZPCZkMzuxUfdapk//BjvAffUeVOZwkBFUe6Ew5emcFHEoob1N+NJRtEL1TPiojRWxV9Kuu9qb8+xg9kSxD82/qMHYSBW3wQelSj+TUFDD5SFjaoyYG6GAQe08r9hiXe3yhv5nWWrLuiFEc/rRiffERIZfNkyMTu1BcOWbiOGtgm+L9pYsGn5dmaSupEzr+wtZaFu29cUXyo/BVmDyA0jN51vChEmw+Q3JaT/CSaMzmbMR2IkRDTmiI1ZBgl+Iw==
Received: from MW4PR03CA0042.namprd03.prod.outlook.com (2603:10b6:303:8e::17)
 by BL0PR12MB2532.namprd12.prod.outlook.com (2603:10b6:207:4a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.21; Tue, 29 Mar
 2022 05:45:32 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::b9) by MW4PR03CA0042.outlook.office365.com
 (2603:10b6:303:8e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.13 via Frontend
 Transport; Tue, 29 Mar 2022 05:45:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5102.17 via Frontend Transport; Tue, 29 Mar 2022 05:45:31 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 29 Mar
 2022 05:45:31 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 28 Mar
 2022 22:45:30 -0700
Received: from dipenp.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Mon, 28 Mar 2022 22:45:29 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <smangipudi@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH v5 05/11] hte: Add Tegra194 IRQ HTE test driver
Date:   Mon, 28 Mar 2022 22:45:15 -0700
Message-ID: <20220329054521.14420-6-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220329054521.14420-1-dipenp@nvidia.com>
References: <20220329054521.14420-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee48eba5-af2b-4580-c3e9-08da11475665
X-MS-TrafficTypeDiagnostic: BL0PR12MB2532:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB25322F14BDE2D3AB8B927B8FAE1E9@BL0PR12MB2532.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GyeTHKrvUgRGsSfG8RTdnUBBO3Uca0O83ADhwEpnyGUOxxbSvti77+y/8v+JWsjxgrhtRQL/bkfqKhLUulIT5wXVHBKaAwKDBdFZqLZNq8MbwAW23pNhO+rGIRC4DRj0uL7DEFozEbcJ7MzsLXvKVxm0ODM7XnSPZk3MRTA8DwcU1i/jD995aigLy9gb55hdSZ9vGBZrVFjWEF+L0MENlqfZwDglAz/vkHcs9oII5oNZEYnHL1PTI5WpBzIQt8U02sgkUreSe+/b11wVHFH5SvKtPn/hpP2ZH73c/1Osn0TVIl8uY/tOPDhX+hpHBYZvW/0lmYlARQgIHixR3ysTdnZsnacA0f5888VAe0Y6xoOYJfcTbyvRC6IQKn4Q1r4mtjOCgJ4duf/RR2YluKJsUYSGwIqFI2cD4neemMrf1MlVUs6zLlBLPkOvLRZccZqpX+THTw0GTdnEerbQkiQ9ta8TBFikufdpmrCqwuKqjzEPH6JVt8GezEQsmxr8LX3etTReKb63AUsvFyOMtIhNtdTDe6HfG/vOocVUHyTqTbc2mOvDTKmc9X7/ZgjpO0GyCeje8fZGzQnydjkaF6qQwtE66nUcB/9k7zN5Cf3nHI3VL0Kmhp7it7DQ8WvxSntM+GBpiZJs1R1h8LAro7+zHEoVv/gfivOaMPAV950A5S/uugir4KPmsQw0DUC/Fyp/MoFDsHbOiUS3GerWhmQqCw7SQUqGiob5+QVUwNZroSdMa7iRquFqMCbr3oVKSFAePwg0oKcIWdaOyi2lo2Qemw==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(81166007)(921005)(356005)(508600001)(70586007)(26005)(86362001)(36756003)(70206006)(2616005)(7696005)(6666004)(336012)(426003)(1076003)(316002)(110136005)(82310400004)(186003)(107886003)(40460700003)(2906002)(4326008)(5660300002)(8936002)(7416002)(8676002)(83380400001)(47076005)(36860700001)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 05:45:31.4956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee48eba5-af2b-4580-c3e9-08da11475665
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2532
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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


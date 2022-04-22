Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0300E50C213
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbiDVWJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbiDVWHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:07:10 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11F021BAC4;
        Fri, 22 Apr 2022 13:52:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NI1a4LK/AijNIML30Qi0HeXhyEPulh0O9mkv1vTvloO/YiwMvSLd90YMUganY36bggzBGaIPFticxPRFibv6A0j9vsXE5NvleiTphY6seAXyxNIs8UkpBUIZ1DyjtvhyZwPMnN5290agaKGSOtoy4HoNB+uuF9iEPVoi9s4xA9QWpR4cRI+avxdVTsIilKNC5CaiLoFSYgs4rYQs46YsNZAahjjc3DaYpuETsPNZoy5dQonEcCxMbN8wQHNbCV1Urh8TR3l9tS39XWn+CjCm4jz9Jjh1DUrAT3YLYVZslAUmvOWch+79QPxEOZ/VZy39oJUzvJS/7TvtwA31HsBTwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+LO7qG+JayVM1sfhql9qMKARNS0TDwQwN5QBYlBmj8=;
 b=ebTVOGck157HmxsOhnRzz6uZzjziY151oUbbRpRX6Z+D1DKmai2DRlA1DNNci6twRlzlBSFEHD54AznTLoNJO7xKtLa9ijwZTsUzV+xGR1vH81BZt387ubdJPAGU58B6LL4y3gvyeLQdFDAGwYdE7n/cdmXkR2kkXUewmuGPVP7vTYme0liAE34zY8op87rLWIRBEJexxFTCHzSE4qYAyKPsSxZLRPIqPoJPdfSrTuhayPaPINK9vrefzwB38wF9fvQZ1v7FB2VCH6KJDl9a2cI1FT5gBFegq2fic1F07EPRthTcs7JfMRk2+lTPhGbUHXN50w3XmHuSd3gosG8Oog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+LO7qG+JayVM1sfhql9qMKARNS0TDwQwN5QBYlBmj8=;
 b=s9okXZPmYXHbpk6GeGy3JhVr5saj1qQfrFoT5v3bOoV34quMA2NVylcx5zcG988Gprxpr7ruhiwxvlQ0WUxHOWn/oqkCPafGG3X0RogtueeHd/5LeZgyNrkRyVYoOKiSH0+bey8IQB7CK1z+GGLvUznEbpmz4vjGrqIZUrNVtSOnzezU+RqRzKndo2UFQBv3Z18I9ES+uDrS5z6DGrsn8a1V3IfilvIvNyIZWrPwIR+BZ4PzAeJscEMABbb9LuyEWiHSN7so2xf83+4oL9cffFZlVjfjhGjlTBlUnfZQj1Wk3zrx7hoBoFikU2+Rbph7Eg9oxMpJM9EQ4GMvb04lxA==
Received: from MW4PR04CA0185.namprd04.prod.outlook.com (2603:10b6:303:86::10)
 by MW2PR12MB2489.namprd12.prod.outlook.com (2603:10b6:907:d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 20:52:29 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::1c) by MW4PR04CA0185.outlook.office365.com
 (2603:10b6:303:86::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Fri, 22 Apr 2022 20:52:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 20:52:29 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 22 Apr
 2022 20:52:29 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 22 Apr
 2022 13:52:28 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Fri, 22 Apr 2022 13:52:28 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <smangipudi@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH v6 09/10] hte: Add tegra HTE test driver
Date:   Fri, 22 Apr 2022 13:52:20 -0700
Message-ID: <20220422205221.952-10-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220422205221.952-1-dipenp@nvidia.com>
References: <20220422205221.952-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4ed1639-3f18-4b75-7d1a-08da24a20410
X-MS-TrafficTypeDiagnostic: MW2PR12MB2489:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2489DA2251A93A22D66A99D1AEF79@MW2PR12MB2489.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fvvqavrbgdn72y6m2VlD6xsm4rI3G5NREdfaT/UIY588mQKTHMNP+xj5LszsHbE7BgKWLGlrCd3MsTRbIqmzygVWLp6Dxjzpjr6kL1kut5gA1D5Au75Nb8hU10plStyNFO2d8n6ovoRNEPK//ipxEo0Rd1xfyf9xESRUZGOuiw4+Di8dq1CNHfcGE8g/RaAsqJRvnpHbII2cptNPfFiVkjLVNC4bsDqM3aFvc6RyhD56FfjXI39UVxS7SGQWYeAqR7aLHucqNPnj8doxSRxSt/UiPHmlUHqSgPS86ur2KZJBZKkUHHlIEDm+RQP6Pc/HU/UK4b7VcVZr3e4a7mniuAoK8fOB3Op897z8v79TS78q5yxHZMV4eMc8WaQYbFBRZlMKYvWscC9ycAZskbh5kk+Q314Lb2kK0AgAlm1YBN/vxTO3OJMzfoZTWkkLxMxePY8A1eBkXjQ++oFxn3JgFxhLOLfC1uFxUubnOYVPEHOdjhD3zIWvXXJFnW3hRlpONLOW8JodYb4OZBpinNtzt91kJFQ/DLH54F5Rvb57AjLohtAXFJjaFrQKJfyA873o4NzUYIEIQ/hkEFtUbSqmAXII30o8y+KOcEBAOJbxIYPBAmjJMzcMYI6vkVo4MlxTfnGywZFgNXvW+fBjmfjFv1QON1m22u3nohlu9yuz9C7xQGADC5yP+9br1pBFNkYG9YvOn64EC7UEPjjdegWfH9++X800uSrFydcf/jWQDqt2juEevqxPU4eJl2wXtPOAiExBLP8KVVnxxHTKt6G2gw==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(1076003)(7416002)(47076005)(508600001)(426003)(186003)(36860700001)(2906002)(82310400005)(336012)(26005)(7696005)(6666004)(40460700003)(921005)(81166007)(356005)(5660300002)(86362001)(2616005)(83380400001)(107886003)(8936002)(316002)(110136005)(8676002)(36756003)(4326008)(70206006)(70586007)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 20:52:29.6744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ed1639-3f18-4b75-7d1a-08da24a20410
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2489
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test driver uses IRQ and GPIO lines to timestamp using HTE
subsystem. The patch also adds compilation support in Kconfig and
Makefile.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
---
Changes in v6:
- Merged tegra irq and gpio HTE test drivers.

 drivers/hte/Kconfig             |   7 +
 drivers/hte/Makefile            |   2 +-
 drivers/hte/hte-tegra194-test.c | 239 ++++++++++++++++++++++++++++++++
 3 files changed, 247 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hte/hte-tegra194-test.c

diff --git a/drivers/hte/Kconfig b/drivers/hte/Kconfig
index 3bd0fa367e84..cf29e0218bae 100644
--- a/drivers/hte/Kconfig
+++ b/drivers/hte/Kconfig
@@ -23,4 +23,11 @@ config HTE_TEGRA194
 	  systems-on-chip. The driver supports 352 LIC IRQs and 39 AON GPIOs
 	  lines for timestamping in realtime.
 
+config HTE_TEGRA194_TEST
+        tristate "NVIDIA Tegra194 HTE Test"
+        depends on HTE_TEGRA194
+        help
+	  The NVIDIA Tegra194 GTE test driver demonstrates how to use HTE
+	  framework to timestamp GPIO and LIC IRQ lines.
+
 endif
diff --git a/drivers/hte/Makefile b/drivers/hte/Makefile
index 3ae7c4029991..8cca124849d2 100644
--- a/drivers/hte/Makefile
+++ b/drivers/hte/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_HTE)		+= hte.o
 obj-$(CONFIG_HTE_TEGRA194)	+= hte-tegra194.o
-
+obj-$(CONFIG_HTE_TEGRA194_TEST) += hte-tegra194-test.o
diff --git a/drivers/hte/hte-tegra194-test.c b/drivers/hte/hte-tegra194-test.c
new file mode 100644
index 000000000000..0682d972fb5a
--- /dev/null
+++ b/drivers/hte/hte-tegra194-test.c
@@ -0,0 +1,239 @@
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
+ * This sample HTE GPIO test driver demonstrates HTE API usage by enabling
+ * hardware timestamp on gpio_in and specified LIC IRQ lines.
+ *
+ * Note: gpio_out and gpio_in need to be shorted externally in order for this
+ * test driver to work for the GPIO monitoring. The test driver has been
+ * tested on Jetson AGX Xavier platform by shorting pin 32 and 16 on 40 pin
+ * header.
+ *
+ * Device tree snippet to activate this driver:
+ *	tegra_hte_test {
+ *		compatible = "nvidia,tegra194-hte-test";
+ *		in-gpio = <&gpio_aon TEGRA194_AON_GPIO(BB, 1)>;
+ *		out-gpio = <&gpio_aon TEGRA194_AON_GPIO(BB, 0)>;
+ *		timestamps = <&tegra_hte_aon TEGRA194_AON_GPIO(BB, 1)>,
+ *			     <&tegra_hte_lic 0x19>;
+ *		timestamp-names = "hte-gpio", "hte-i2c-irq";
+ *		status = "okay";
+ *	};
+ *
+ * How to run test driver:
+ * - Load test driver.
+ * - For the GPIO, at regular interval gpio_out pin toggles triggering
+ *   HTE for rising edge on gpio_in pin.
+ *
+ * - For the LIC IRQ line, it uses 0x19 interrupt which is i2c controller 1.
+ * - Run i2cdetect -y 1 1>/dev/null, this command will generate i2c bus
+ *   transactions which creates timestamp data.
+ * - It prints below message for both the lines.
+ *   HW timestamp(<line id>:<ts seq number>): <timestamp>, edge: <edge>.
+ * - Unloading the driver disables and deallocate the HTE.
+ */
+
+static struct tegra_hte_test {
+	int gpio_in_irq;
+	struct device *pdev;
+	struct gpio_desc *gpio_in;
+	struct gpio_desc *gpio_out;
+	struct hte_ts_desc *desc;
+	struct timer_list timer;
+	struct kobject *kobj;
+} hte;
+
+static hte_return_t process_hw_ts(struct hte_ts_data *ts, void *p)
+{
+	char *edge;
+	struct hte_ts_desc *desc = p;
+
+	if (!ts || !p)
+		return HTE_CB_HANDLED;
+
+	if (ts->raw_level < 0)
+		edge = "Unknown";
+
+	pr_info("HW timestamp(%u: %llu): %llu, edge: %s\n",
+		desc->attr.line_id, ts->seq, ts->tsc,
+		(ts->raw_level >= 0) ? ((ts->raw_level == 0) ?
+					"falling" : "rising") : edge);
+
+	return HTE_CB_HANDLED;
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
+static const struct of_device_id tegra_hte_test_of_match[] = {
+	{ .compatible = "nvidia,tegra194-hte-test"},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tegra_hte_test_of_match);
+
+static int tegra_hte_test_probe(struct platform_device *pdev)
+{
+	int ret = 0;
+	int i, cnt;
+
+	dev_set_drvdata(&pdev->dev, &hte);
+	hte.pdev = &pdev->dev;
+
+	hte.gpio_out = gpiod_get(&pdev->dev, "out", 0);
+	if (IS_ERR(hte.gpio_out)) {
+		dev_err(&pdev->dev, "failed to get gpio out\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	hte.gpio_in = gpiod_get(&pdev->dev, "in", 0);
+	if (IS_ERR(hte.gpio_in)) {
+		dev_err(&pdev->dev, "failed to get gpio in\n");
+		ret = -EINVAL;
+		goto free_gpio_out;
+	}
+
+	ret = gpiod_direction_output(hte.gpio_out, 0);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to set output\n");
+		ret = -EINVAL;
+		goto free_gpio_in;
+	}
+
+	ret = gpiod_direction_input(hte.gpio_in);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to set input\n");
+		ret = -EINVAL;
+		goto free_gpio_in;
+	}
+
+	ret = gpiod_to_irq(hte.gpio_in);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to map GPIO to IRQ: %d\n", ret);
+		ret = -ENXIO;
+		goto free_gpio_in;
+	}
+
+	hte.gpio_in_irq = ret;
+	ret = request_irq(ret, tegra_hte_test_gpio_isr,
+			  IRQF_TRIGGER_RISING,
+			  "tegra_hte_gpio_test_isr", &hte);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to acquire IRQ\n");
+		ret = -ENXIO;
+		goto free_irq;
+	}
+
+	cnt = of_hte_req_count(hte.pdev);
+	if (cnt < 0)
+		goto free_irq;
+
+	dev_info(&pdev->dev, "Total requested lines:%d\n", cnt);
+
+	hte.desc = devm_kzalloc(hte.pdev, sizeof(*hte.desc) * cnt, GFP_KERNEL);
+	if (!hte.desc) {
+		ret = -ENOMEM;
+		goto free_irq;
+	}
+
+	for (i = 0; i < cnt; i++) {
+		if (i == 0)
+			/*
+			 * GPIO hte init, line_id and name will be parsed from
+			 * the device tree node. The edge_flag is implicitly
+			 * set by request_irq call. Only line_data is needed to be
+			 * set.
+			 */
+			hte_init_line_attr(&hte.desc[i], 0, 0, NULL,
+					   hte.gpio_in);
+		else
+			/*
+			 * same comment as above except that IRQ does not need
+			 * line data.
+			 */
+			hte_init_line_attr(&hte.desc[i], 0, 0, NULL, NULL);
+
+		ret = hte_ts_get(hte.pdev, &hte.desc[i], i);
+		if (ret)
+			goto ts_put;
+
+		ret = devm_hte_request_ts_ns(hte.pdev, &hte.desc[i],
+					     process_hw_ts, NULL,
+					     &hte.desc[i]);
+		if (ret) /* no need to ts_put, request API takes care */
+			goto free_irq;
+	}
+
+	timer_setup(&hte.timer, gpio_timer_cb, 0);
+	mod_timer(&hte.timer, jiffies + msecs_to_jiffies(5000));
+
+	return 0;
+
+ts_put:
+	cnt = i;
+	for (i = 0; i < cnt; i++)
+		hte_ts_put(&hte.desc[i]);
+free_irq:
+	free_irq(hte.gpio_in_irq, &hte);
+free_gpio_in:
+	gpiod_put(hte.gpio_in);
+free_gpio_out:
+	gpiod_put(hte.gpio_out);
+out:
+
+	return ret;
+}
+
+static int tegra_hte_test_remove(struct platform_device *pdev)
+{
+	(void)pdev;
+
+	free_irq(hte.gpio_in_irq, &hte);
+	gpiod_put(hte.gpio_in);
+	gpiod_put(hte.gpio_out);
+	del_timer(&hte.timer);
+
+	return 0;
+}
+
+static struct platform_driver tegra_hte_test_driver = {
+	.probe = tegra_hte_test_probe,
+	.remove = tegra_hte_test_remove,
+	.driver = {
+		.name = "tegra_hte_test",
+		.of_match_table = tegra_hte_test_of_match,
+	},
+};
+module_platform_driver(tegra_hte_test_driver);
+
+MODULE_AUTHOR("Dipen Patel <dipenp@nvidia.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1


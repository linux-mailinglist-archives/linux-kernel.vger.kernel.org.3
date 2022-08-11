Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0EA58FCA2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbiHKMnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235358AbiHKMn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:43:29 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80077.outbound.protection.outlook.com [40.107.8.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D3389911;
        Thu, 11 Aug 2022 05:43:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMsRPo74vWo1n0PH+4D31LkY1AIB5612bRXE4n+Re025qNALvgMEzTMLl+2Imn3GN2ulVCdA4Txbk+oxgHnT85CU+/bMOW/1lLxRpJiC4HfRnIHR48CYKf9Q3UQGda1U/2hLkRLEuAIy/0GDnDluWGeN+AM4neBOGvbMBx7JFLa6YAqLRMQzXk4FxKZIiilUaiU6FXJbQWMQTLO3xguukOAKrkwYQlwltzzIyskrP+Qt09vjWGHvnfSIoq1ZyKIESAIICvQ/Q3BQddIIEWsiFueiQQbC3PIstbTG1XgR54JWvXio/b+EFN5Mx+HRVV9Hpyny5ZFs0/HY+lsjvmC9VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kDVlq297AWQj8JhZI9Q+3qSr4e7scoK2W4Q/LKu+hs=;
 b=JbVXEmPr2Fwg1vnEcanF8P0J1RCvcWxWHQst38Qa6tzJoPYtPrYIBrz1DKeDd9lho5GWmoRqUJYrGRJD5VKPoSfQjnOXnFc1fCN4uvkgpSImQUYu+e+07UPl/xBlSzhIQDgiBHfszE+I3JsAVsz+h6tb6JIp2Nlyvvz6v1BCIjpuuqQclzBumG67EUFeZlrTL6yrF1e8nzcrisAhVqgc/Yow6RdMCUJdGZ27y7Qv+AXH0MLPJQ1Ua95Sjv+ZsUduKf5UI1tXVKCsKttXjJdaAOTdpuJTlmM8LMJCUIsYM3tVPyG9HSBzk2eg9oVF/cBNL1VF6dm7k8H1SMG3B2+dxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kDVlq297AWQj8JhZI9Q+3qSr4e7scoK2W4Q/LKu+hs=;
 b=dnFwZ2fojZuBYtY8trcNJBTLOHyZTfCUTxZVFBhdzWvMpK3+FaEwDJ2cnu3daurwObPwVLUMrgWIyf998HG9EVYThrbkHUIY3dhcw+em3S3k2TqmMYxMV39wMP4VrxtSWlKy+qMOxE38RSWSKPCM3DznpCunT9oZQAKCjlb3heI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23)
 by VI1PR0402MB2832.eurprd04.prod.outlook.com (2603:10a6:800:b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.22; Thu, 11 Aug
 2022 12:43:25 +0000
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca]) by AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca%5]) with mapi id 15.20.5525.010; Thu, 11 Aug 2022
 12:43:25 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, brgl@bgdev.pl, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH v4 3/3] gpio: imx-scu: add imx-scu GPIO driver
Date:   Thu, 11 Aug 2022 07:41:35 -0500
Message-Id: <20220811124135.95299-4-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220811124135.95299-1-shenwei.wang@nxp.com>
References: <20220811124135.95299-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0044.namprd17.prod.outlook.com
 (2603:10b6:a03:167::21) To AM9PR04MB8274.eurprd04.prod.outlook.com
 (2603:10a6:20b:3e8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 265073b9-cad1-4e42-e347-08da7b9714db
X-MS-TrafficTypeDiagnostic: VI1PR0402MB2832:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GKuTNwnVpNh9z9EqEfOk7drwh30YC1gF5Ml2O6ivqejPD8F1x81U0SMqMoSRMzF4S6sta0hBxpARSOX4HtyE+R+MLCSfMYn2OkkP+jHKY5HGr58uuve/hhIQlTFBzZS4jZtow6NrIW6yMtfwWmwLtTbOVjjC3Q5l4ncDl9GydKtBphFhILLsAXwJlILi8HVKEtyxouE4sDF4F9iI0CzpofA2dQQRFH8NaJ9O7ZDWZFcVXnPfB316ynMaZ6Hb2HTPJu54QEgp04rkr3Y68o6UkiGxmdW0EQqJ/I38gRU0x36DLm0f2+OUFuNd7e1q6rqmNuYoo/YftUSTz96QXS/2sFWrHwEjmhNfWYIYPLgfdP6inCc0x5vjojLZ6RdekHJSCgcvqQmaXK8VrrMBz5WEhdPXBt/HWZpiaBBxNMTYe3FO0kGv+nWL+JLnLfNKizood3dyYdG4sCQZP7aSLwKw0c04QdcpB7xzaCCfuOGDGcPX3tsZkQquwZfK8bxmv/RoVibp20t64OZGYICarPlQ95+wzBrKZlYExIOa/Ha7ZDuffhZ5ss5p5FpnvZbto3ubQgSxj+ptXUwLKsfVEnSRBpLV0TvH60XRYFzZMaL9aTaMkd02RiYiTrihi8ZNmXyMc/p7WduCcDWGhhReav4KYW5u/ZPW8SvEBKWZsHCP9sg4V5PJU63fmtODLScyJwe+pat3BVmBp2hswMtOhN0igQjRuQlMIxAI1L1wRFTK/AQL7bGpcN9E/99E9hrrMCFgyMtQR1o8GlrIhWBJATgJ160mCjD+z8Uk3ADHxtDwAlJRgzvxcUApN4LbSe3AdWfF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8274.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(6666004)(186003)(6636002)(41300700001)(478600001)(1076003)(83380400001)(2906002)(36756003)(316002)(26005)(7416002)(38350700002)(8936002)(6512007)(52116002)(6506007)(44832011)(2616005)(5660300002)(55236004)(86362001)(66476007)(8676002)(66556008)(66946007)(4326008)(6486002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jB8A4pJQztOOQF8ZL6QXOr0FpwpgzxZc0ff6ApK39mzLvVKx5vyPF05gWfrR?=
 =?us-ascii?Q?JxcF4xtvfec+2KYfaGtKqj1bTZAJrnrCay+m4GvBdXktwVc1lWs6nq2tkWWB?=
 =?us-ascii?Q?Jiue/QFH5WlobVX9e5uDWxavHcP5XB/3G6OZg2faWPGR7xqYMZUqZWCUejvp?=
 =?us-ascii?Q?Auy7LkKEEIDjBiBlugrqAP0leZOMLj4jBEHaSeuzVoboNF3hf4Q3iqGau2NQ?=
 =?us-ascii?Q?Q9FpYBHg70jd0/D+H+hpyZPGRjZzEGBetx6ddj7bFPAegSqBSLRsDJEL9E8M?=
 =?us-ascii?Q?4zoLSQMIXlOoUcnRGGKZQGfuuQ1NmRf8yJ8kuJ4jBVDa2jHL5p2sN3Z5KkbK?=
 =?us-ascii?Q?rfflZKNpJlThp83na2qrvBqgajqA680xIy8EkHQKKs6RkuNY6O6phdYbMWA2?=
 =?us-ascii?Q?wWWanJlR7Oravnj4aQtaZ/vmWBfRjjuitpx0HevxRtt60EWBUGYfG/W098NE?=
 =?us-ascii?Q?GRIspUmPK7INQzzIjvyUunJYOpz/jElU3vVZEqwge6EdUVrcXPKjgmzgm+eh?=
 =?us-ascii?Q?YNIqzf9uUj+PHirQ3ByHuj6Et8ylAnxWG6+6J+tkoW8ilkFCxbqesQT1RSKF?=
 =?us-ascii?Q?z8ik4hcHmM+zdOSwbdYQC0BO3WrHEQYG+5Oaaryh4gYiA7XnR1U/H8tRjHhx?=
 =?us-ascii?Q?+BljzjtLNvoMv26VkUTZq3yjR0CzqOGkgGpw+xdVRktu+qPDWM6zaVCwrbev?=
 =?us-ascii?Q?MSLI1jE6bs05YzecnZPDPOY25jgtPiIVNepCct9ujL7sAg0SAyal99HOCJ/U?=
 =?us-ascii?Q?9JIAiTrx5gPkm2/lFj77lWn6X6RA74nTq2z6pMTBoxYXI0nkWLrmID2oKCdP?=
 =?us-ascii?Q?OrgTkHm5LK/rWbOUoyDEXFZdXdmzaW8Y6/xGQ0KzXF6WZVaw4cM4tkTvv1NI?=
 =?us-ascii?Q?OQIVm/+Lg9NytIaomGEvK6XTaLC3uR/WF9kc4CqmL+SFURxoHIfiMhqwSBhE?=
 =?us-ascii?Q?8VYMe6hudbOL7s6TtjVO8SyvznqXGRMPl00Xt5QXb2gCOeFguE8H/rLLbdJY?=
 =?us-ascii?Q?azeJbpt/L3pFOBLdrcvjsXq2dWC4WrTOdPzOMiJLK3DWDGmO7E5iMjNeg9Rx?=
 =?us-ascii?Q?DHpBOSAxxtS++srhDVyWgJyNsaAUK+DPr9YeeK9A1DdKSYYNoVMqTSKlAB4v?=
 =?us-ascii?Q?WnJU8noqPxVFQ2Xscoa6D7Yx2whgV/JiYKlwrA+7UeYKCrnJtf2JmxT/4yMk?=
 =?us-ascii?Q?d7yuM2nErF5AS8cSK+KQqMcxcaJEoa6vX5Iaa17BPSOnhThVJ/Qi4ZFTRRWe?=
 =?us-ascii?Q?MBBiyQngRZNhbIEFBsFanh4K5G6BideRPZkN9NcWagSmorfxIU8ZK9W2b4Nf?=
 =?us-ascii?Q?g7Fe7ftlSZBHad9QadQ5m5oRoml1XNz7C1pvusAy9R6tDq7O6XIWYdKs4fD8?=
 =?us-ascii?Q?hRWViC8beYOgYpKH+eEi0YqwI9CWznoN6ynqdH44FAz+aTctLezPAfF4LjW2?=
 =?us-ascii?Q?RGdUOf2Gxq3jk2hNVcSctn4NTBevVi/pXL6g2Ttq2Pp1rro0pdPZqf9G2qD7?=
 =?us-ascii?Q?E31xJ3o6J8TGqRWQXw54LwtcjVT7JxdQlo+QsDdhaW6h3drWK7k7lneHbiYk?=
 =?us-ascii?Q?ktab1mafmxM13RJCmEAjuKyrXV9oGgFWkSGhBqXb8hXkyI/TQGSoJNOWzeUt?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 265073b9-cad1-4e42-e347-08da7b9714db
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8274.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 12:43:24.9235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVw1HOXO/zUeBILUQIPMdWugbAIQ4SxZfariyvlGYWBvy3m+17eBVvI+97hSEPZacJvaW5kg5MZAvB3TevBazQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2832
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SCU firmware on i.MX8 platforms provides a set of APIs to
control the GPIO PINs on the SCU domain. This patch implements the
standard GPIO driver interface to access those PINs on the
SCU domain over the SCU APIs.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/gpio/Kconfig        |   4 ++
 drivers/gpio/Makefile       |   1 +
 drivers/gpio/gpio-imx-scu.c | 139 ++++++++++++++++++++++++++++++++++++
 3 files changed, 144 insertions(+)
 create mode 100644 drivers/gpio/gpio-imx-scu.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 0499c2facbb0..b01310f6ebcc 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -341,6 +341,10 @@ config GPIO_ICH
 
 	  If unsure, say N.
 
+config GPIO_IMX_SCU
+       def_bool y
+       depends on IMX_SCU
+
 config GPIO_IOP
 	tristate "Intel IOP GPIO"
 	depends on ARCH_IOP32X || COMPILE_TEST
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 3fa4f3f93d85..b39ab87793ec 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_HTC_EGPIO)			+= gpio-htc-egpio.o
 obj-$(CONFIG_GPIO_I8255)		+= gpio-i8255.o
 obj-$(CONFIG_GPIO_ICH)			+= gpio-ich.o
 obj-$(CONFIG_GPIO_IDT3243X)		+= gpio-idt3243x.o
+obj-$(CONFIG_GPIO_IMX_SCU)		+= gpio-imx-scu.o
 obj-$(CONFIG_GPIO_IOP)			+= gpio-iop.o
 obj-$(CONFIG_GPIO_IT87)			+= gpio-it87.o
 obj-$(CONFIG_GPIO_IXP4XX)		+= gpio-ixp4xx.o
diff --git a/drivers/gpio/gpio-imx-scu.c b/drivers/gpio/gpio-imx-scu.c
new file mode 100644
index 000000000000..17be21b8f3b7
--- /dev/null
+++ b/drivers/gpio/gpio-imx-scu.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2021~2022 NXP
+ *
+ * The driver exports a standard gpiochip interface
+ * to control the PIN resources on SCU domain.
+ */
+
+#include <linux/module.h>
+#include <linux/gpio/driver.h>
+#include <linux/platform_device.h>
+#include <linux/firmware/imx/svc/rm.h>
+#include <dt-bindings/firmware/imx/rsrc.h>
+
+struct scu_gpio_priv {
+	struct gpio_chip	chip;
+	struct mutex		lock;
+	struct device		*dev;
+	struct imx_sc_ipc	*handle;
+};
+
+static unsigned int scu_rsrc_arr[] = {
+	IMX_SC_R_BOARD_R0,
+	IMX_SC_R_BOARD_R1,
+	IMX_SC_R_BOARD_R2,
+	IMX_SC_R_BOARD_R3,
+	IMX_SC_R_BOARD_R4,
+	IMX_SC_R_BOARD_R5,
+	IMX_SC_R_BOARD_R6,
+	IMX_SC_R_BOARD_R7,
+};
+
+static int imx_scu_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct scu_gpio_priv *priv = gpiochip_get_data(chip);
+	int level;
+	int err;
+
+	if (offset >= chip->ngpio)
+		return -EINVAL;
+
+	mutex_lock(&priv->lock);
+
+	/* to read PIN state via scu api */
+	err = imx_sc_misc_get_control(priv->handle,
+			scu_rsrc_arr[offset], 0, &level);
+	mutex_unlock(&priv->lock);
+
+	if (err) {
+		dev_err(priv->dev, "SCU get failed: %d\n", err);
+		return err;
+	}
+
+	return level;
+}
+
+static void imx_scu_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
+{
+	struct scu_gpio_priv *priv = gpiochip_get_data(chip);
+	int err;
+
+	if (offset >= chip->ngpio)
+		return;
+
+	mutex_lock(&priv->lock);
+
+	/* to set PIN output level via scu api */
+	err = imx_sc_misc_set_control(priv->handle,
+			scu_rsrc_arr[offset], 0, value);
+	mutex_unlock(&priv->lock);
+
+	if (err)
+		dev_err(priv->dev, "SCU set (%d) failed: %d\n",
+				scu_rsrc_arr[offset], err);
+}
+
+static int imx_scu_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
+{
+	if (offset >= chip->ngpio)
+		return -EINVAL;
+
+	return GPIO_LINE_DIRECTION_OUT;
+}
+
+static int imx_scu_gpio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct scu_gpio_priv *priv;
+	struct gpio_chip *gc;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	ret = imx_scu_get_handle(&priv->handle);
+	if (ret)
+		return ret;
+
+	priv->dev = dev;
+	mutex_init(&priv->lock);
+
+	gc = &priv->chip;
+	gc->base = -1;
+	gc->parent = dev;
+	gc->ngpio = sizeof(scu_rsrc_arr)/sizeof(unsigned int);
+	gc->label = dev_name(dev);
+	gc->get = imx_scu_gpio_get;
+	gc->set = imx_scu_gpio_set;
+	gc->get_direction = imx_scu_gpio_get_direction;
+
+	platform_set_drvdata(pdev, priv);
+
+	return devm_gpiochip_add_data(dev, gc, priv);
+}
+
+static const struct of_device_id imx_scu_gpio_dt_ids[] = {
+	{ .compatible = "fsl,imx8qxp-sc-gpio" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver imx_scu_gpio_driver = {
+	.driver	= {
+		.name = "gpio-imx-scu",
+		.of_match_table = imx_scu_gpio_dt_ids,
+	},
+	.probe = imx_scu_gpio_probe,
+};
+
+static int __init _imx_scu_gpio_init(void)
+{
+	return platform_driver_register(&imx_scu_gpio_driver);
+}
+
+subsys_initcall_sync(_imx_scu_gpio_init);
+
+MODULE_AUTHOR("Shenwei Wang <shenwei.wang@nxp.com>");
+MODULE_DESCRIPTION("NXP GPIO over IMX SCU API");
+MODULE_LICENSE("GPL");
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28422591171
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 15:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238894AbiHLNb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 09:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238732AbiHLNbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 09:31:17 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2066.outbound.protection.outlook.com [40.107.105.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F417A525;
        Fri, 12 Aug 2022 06:31:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWPwUR2yzz+A1IBM16OiuO9dCFs8CT9sO8iCBEqrPWeMNDig5Y0gtTz7ymayoaXuVD0lzmfk3fn1O+qQJUJE5DuALjpvZYHwTdYEEGTHQ6pj9sX9ZwxQ35BCOq/agTeru3Ac/qEoA8ITwA4jey1+Y24UstHvM+zMc/lZheqfBKveyD8Ymo1hMWXJ2mrvi/bYRSjOFqkyc+gDv7XO6/+qi0qMHA7dE1r3l7Cu6g9SbER8ioJz2wuIUGi9bnxLTGnyz0P6bfhnFpetFEU4WFGsdrBTa1oODFxb/9HN/lmM5Zr7vLBGDAGHfuOK6hAY5/qM/UOCegzATxHuEcnlCnEmKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kDVlq297AWQj8JhZI9Q+3qSr4e7scoK2W4Q/LKu+hs=;
 b=W4wLM6cR8YDnaA2n0CfRE4LUrFwb644hL3HCthoVmnz9lMW+OiZDZMdFPu8tiWFQuEz15MV/HceptY4WfVsIN1QA2ASnR9IB8IRhMEh+L5alePkmLXQ8dmVRd+jmirai0xCSBg3UVXnqrZesAD1/WjNONG4OvY71+JGoskAQL2HVSQoGT8EkSsZi5OPR2mmVeTNctndcU84BhpFqe/8d/1pcXQ5610OMXgT2Q/mhZrQQ8pjoO3zoDl2tKMdCV4NN/BiR8znTBc6PjOsSJLKoYIyE3OGDJ9zR85vg/XabT5siZ7i+5vuIYKFvmP8ORxE6hV0wqeoTqJD1dc+/jaONqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kDVlq297AWQj8JhZI9Q+3qSr4e7scoK2W4Q/LKu+hs=;
 b=EujxDGgc66qHIxqpg2fGah61ysaXk8NHzBv9I51vCEKXArCR1TxBloSDkhFdMBDvcC9bQ8108jholXJ+5lfEP3xKOUyioOxmOpjWwOZnyNfNFrhNdc1zHhQzmRXA6ytmwDlvNKSuX6bbDF7OrILfL3ejPZ4Y1RenzdMPM6KeRz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23)
 by DB7PR04MB5226.eurprd04.prod.outlook.com (2603:10a6:10:21::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Fri, 12 Aug
 2022 13:31:03 +0000
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca]) by AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca%5]) with mapi id 15.20.5525.010; Fri, 12 Aug 2022
 13:31:03 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, brgl@bgdev.pl, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH v5 3/3] gpio: imx-scu: add imx-scu GPIO driver
Date:   Fri, 12 Aug 2022 08:30:12 -0500
Message-Id: <20220812133012.7283-4-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812133012.7283-1-shenwei.wang@nxp.com>
References: <20220812133012.7283-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0062.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::13) To AM9PR04MB8274.eurprd04.prod.outlook.com
 (2603:10a6:20b:3e8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4249200d-ae41-4aeb-2a27-08da7c66e701
X-MS-TrafficTypeDiagnostic: DB7PR04MB5226:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DBAQ2LcZpoK5xogCkW3y4SFb3Mad/5RZItMLRPjEVbli+G6Ev2TDWk8LIX16OUYhDY70cZcoShT81ZPUXBtzXkep0w6xkwFxcbi4MyugKRyyG9sg7sgasjctNM5HSQgKagqM8g/K6El8anPk4T6L3T6ziGxdR3kCBagB34Ls3T3JDmPLPINn1kLKbnf78gW8AwRBUdUC2v+/bSPVoNJVBaEU/6yPn6z6JTKXXQnasGAIJUm5Q7XdPxCoUNP/Q50kjIb8YK0Gm/sMAebXrI2PdltAibh+vVYa7w3v+p5sRF1+p4XXyY6aWSGUm5yKpeKMKNbkss/cN8XMHTEJWlDkK2zzjphJW3v+Wmg4rT78A0XuMeCQqjTreJ3kthWGJsO2M0WqjjB1QyTFeA92fgkuvtcXR9p5kKjQlC/LxwyfNIsZPDlQRFH7Ej8gQ8HwEGC1Uk8eqoj9rWuHtlTF9bvvv4TVcxs93gjyQPKHQxrCrHxpomsQLDSkXPQIrpA1dzE1MCQzECl4eWVBO5nKGpVpjPyS7VvnXL9V5Yxkzb9DizbZVYFZxrudzn0No+TKxauYImyc42lCwry5BMQlpk9Pxyz1sFgNPppi+NCUusxRFsTpJxUkREp5X6M6nsumlBFgSSmzU+enpLnmV9GgBfRHIvthzEbrGGL+Jw/rQL/ejBXHaXnByK2GO+iX6cwsImhmUj30CMbBsHv0gkarQN5YN1ckzl91I5n3DJ4NKIIm61ZKBsMgYrCdMZZxppJRW/SRX5yR1ENVZhsL/VVP/333aq9201a+a8bkJPh8521gBtk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8274.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(8676002)(83380400001)(86362001)(66476007)(66556008)(38350700002)(66946007)(38100700002)(4326008)(5660300002)(316002)(6636002)(6506007)(8936002)(7416002)(55236004)(6666004)(2906002)(6512007)(44832011)(26005)(52116002)(1076003)(186003)(2616005)(478600001)(41300700001)(6486002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m1lledGh1/c6L0uKdy3en0muCdPvANbxyOQkQgtpPHdk2K0YjzzYh2Bl0rn2?=
 =?us-ascii?Q?fwrZO0tF9v8lTlNxGTOZFUqWb+n6RzHX7e4W+sAE3IFmJ5tYiIGtaC5uA+Tp?=
 =?us-ascii?Q?lsVHYxntp+WMESsJv3mKXTFxsWW/Lpu5+tN4L7DE0afOCq4ixvhuyO9AERPp?=
 =?us-ascii?Q?4o8aKB7vbHtKYnAkmOXojt0ywBydlnD+Bgu+SHEmJN694PeuKgoggRGcN+yP?=
 =?us-ascii?Q?flSvsSB17XPhYolFiTuGy0dkmHDZXD/nUckPpzH9U6/tTQM15cQUzUxGVxEl?=
 =?us-ascii?Q?kjo4svWh+7g62+7KWEp0y7D9G355cXMaoyVT+Lu1qH0ZxlF0ysseJbPCFXrm?=
 =?us-ascii?Q?8T6o0Cp9uSSUvQcQ+QzZnEJT31WjVaSaDBEtxm+HNXMYTZ0byt7meksUPFrK?=
 =?us-ascii?Q?fi5RC6Q8iOFVUwK0zjhi8RJk3KmVFcs85UoxTj9wiAuPJBlfb/gTR1Jeu5/9?=
 =?us-ascii?Q?pcAFDMKSXlj4k9TIxcacSisjsgfXcLFS2LmLhRi78sT9LN+f9MlK+gEi9Lgl?=
 =?us-ascii?Q?dGHOSz19YgAPygr7iqAC1HNUI4eOYJn/q4B6yqucE9aujCDW00k086iwAL6I?=
 =?us-ascii?Q?FH1hlJVlKn1BTjmPVihf/RAqni7pDv206CL4BIOX2ppCD834Nm0yhECN+Do6?=
 =?us-ascii?Q?oH3Xq0hnP5czRbcU9kiZClpxPNoqqGZp0zuSXrXW089bsEBw9/5SIKrcebda?=
 =?us-ascii?Q?XpvjqUoQBOX4iiVIJEVnsdJPo4D1ZeJwj04GN5VoNI5LMS+kdJNHf4lnbXJu?=
 =?us-ascii?Q?bu3fbKx9wqiSBrAjvNi/8BtmQqkwearoMmYW9y2tYIKoP55rveeV5FXJqxgY?=
 =?us-ascii?Q?5NBt11NIkgeGs3iT2/ZB1fe2abSCpAe2XecYg5+UtF4EOAXUxtTGWxnyVTSh?=
 =?us-ascii?Q?Y0qZ/CsBJEKypdXIMlIZ47FX15q1cEvNCu2DkgGHthgX7dGIpN1vwAReZcRz?=
 =?us-ascii?Q?rkN71fa1SjThaBW+tJPFcIcBd0M0212jpuYzVA7jLDJs7f3lzxXFS9mLowSE?=
 =?us-ascii?Q?cr5ea/rY6+hKVhDHBczCmSRNVdSPe0Ya6uTMp/f4+UDm/y0qIpw+T0yxVdq2?=
 =?us-ascii?Q?dtNo77vDS5sfeBXQNlC7QqGHgzLj2vvaRUylnT9X5L5lvedgfAE949mHQPbI?=
 =?us-ascii?Q?AIkO83yCMlh22k6GP0gg7OdusIwg5FrGQmLWSj0fN2K3Br9q6o7A2yv4GDhQ?=
 =?us-ascii?Q?9EVvh7znQ18nk1Mnf4CxmoQznaplE/Z85ba7RdcuiJihVLj2VOEDen14To8Z?=
 =?us-ascii?Q?d83A7h6O8fCfhsljniDzy5uE2L3GlIT8RQFB1bDzWVgEq7Gyy0obWONUWjqg?=
 =?us-ascii?Q?MACGZQHmEH62BMqGWGCCXWt0EJp41b5e8QT1gvrN1CZa9CATbBfss8GJ4SY7?=
 =?us-ascii?Q?9J2ZOV3zXBpdEubv8DMM1IKSb/DEh5NUQh8Kr/vr1E8ZYfqtGsx5ABCCn8yI?=
 =?us-ascii?Q?DcLqMPEkKEUKo21r+WbskxpmM8s8ard8rxFiqKoD3PJ2gCElD7nNlpnW9P/n?=
 =?us-ascii?Q?CeVNbaQwMf0y/Wu6Dh1z0634DtrEdE0yMYGy/5Bm2L1MK3PttM9NaCaEU2QH?=
 =?us-ascii?Q?41T8gFuPUx0aujq1GUb9XtvJMmDlz4L3u1eMc3f3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4249200d-ae41-4aeb-2a27-08da7c66e701
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8274.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 13:31:03.4841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /zDbHHS6ReJm8Y8WZb8XZvPC/6nJBt3j3l5l3kDFX4RkV0BPV++BbcE3FcAdRApBIrMNlwLjCPzmc3UPOnieQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5226
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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


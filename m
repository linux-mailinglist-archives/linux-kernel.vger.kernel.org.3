Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57C558ED5A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbiHJNcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbiHJNbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:31:44 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D98E45063;
        Wed, 10 Aug 2022 06:31:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ox4XXBht0l+Bc9NJrfrqzxMebBEFGl47bW2P7jzzjDrGDbP1gOrolYxCdp5RFjiPs0VMw062b/Q/VbN25YAExwUdnEhpk6/IPyc51SJlUnI9KSvzHwPasUABFWHq7AXvZWWq9+uAgj2OcR+3CKCz0BRetxxxEMuWn2rdXx03vj9s4wjMW+bQN7eh7P7FgBtdoGD8H9aT/llHfX9dWFb/osjgT761emvLnTVtV621EJuB7B5jUgtDVYCrpej8hSb2yeA6BK8/gPWSm/NGCKobqpjoI/sSs4aEYLPiRNtj87tRTvQNCHM1bJN6woXtIu2YDynjLStziuLF48Bq5sRjvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YoEFm4tcMY+26oBVnEQLOvXCqrVOX8Dqj4j0haglyQ=;
 b=Zev+eUVPBKxnpVlBfbOY0updv6u6h4Jdcf+X9ER95jRCRsyObGqbJanVJSp+j+5cyzk5vQ2oTFLnFwTKmvB+2NjNnFKTBRkCQsAjb3G+8wvTdSPCw8OAHFXKKfgi8RwnMkKZdPb1+yl1iT2bhDR2AK9JK29IKqMr/Lphin4mzI/EIBpXUNqtgZQtlkVi6397lEBiBipc9tJO5FxJ/UvicTl4B5QgVUYgnFnOsnDqw9as7nPjHZ/s4norjxGgETdNZfO7z2Kq+25n6kxdP2as+D9lBRcy9zp1xXCTFlSZ8BlcJh3Sm2isO4kjxP67ykjHANX6YyAs7JyXidx+rF9eEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YoEFm4tcMY+26oBVnEQLOvXCqrVOX8Dqj4j0haglyQ=;
 b=Tl1ZbxnNt11bwWOuD/pnAxlxgZbLrBABJfCqT3UWB2Th/8QPc3F5f48Lr40nuH6wm7ddCkOAD7gHIcbF2gaFWfX360LGzCPdpNYZt0AakNdoVc8QehCDEnCLiNOxzw3kQSoGJx+3yxXQzGdqCQyVpg+7pe3bxuR0vpZEcEhSg8M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23)
 by AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Wed, 10 Aug
 2022 13:31:40 +0000
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca]) by AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca%5]) with mapi id 15.20.5525.010; Wed, 10 Aug 2022
 13:31:40 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, brgl@bgdev.pl, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH v3 3/3] firmware: imx: add imx-scu GPIO driver
Date:   Wed, 10 Aug 2022 08:30:05 -0500
Message-Id: <20220810133005.74653-4-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220810133005.74653-1-shenwei.wang@nxp.com>
References: <20220810133005.74653-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::25) To AM9PR04MB8274.eurprd04.prod.outlook.com
 (2603:10a6:20b:3e8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b289b4d-81a9-45c0-9e32-08da7ad4a84b
X-MS-TrafficTypeDiagnostic: AM6PR04MB6630:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qs2MESF/nJaNlmuUC3yTPJLugNO1kqD7psrYU9ccupeosybfo24t+WRNeuZiQ8xrXTqx5ePWtP5kvBIhb+7eWwPAsMlI+jHk1+zsnG6arJfUwrB/Pl1JymSaqyBXg2/tL4k1CMnvn2emA1yi7CBhqeUYUGSkkrSPLoORbUatKrh6ZaDkfsuFGVEhL+8XE9zsigM787q5fQmJIEeUHHKYTS1604qycW+HjKJijc6zugp2bHnhnNA3ipwIV0A3nq5zO8N0XKrcfbbTNZGdCA4FnLJSoNTxGjY/icC+KVKZ6MoTDkweOeoJrFLQXKaJ61Aav08k5gOH8cDcve/lezcTgtTz89mlPeD3S5JfhP1fRvUl0cloDKC1twRb/iMx0mCvcNNyrzf43ryxCra09V9qQa3YC4ku4vP/n6hAMms8D5RoxX16WMxG1THsr/yIkgUWrRyLmrqm0uCFlm+XUurkGhnz6niWB8owNs9Xj1IxaFNAMTDRDQDgEJfcTcJkidawYpqhE1sZmNco+vX2B1q01Omz5DYQQrqA6W9WamvOGLjD18F4jag2mBx3wic3VltdSYFuAWk68L+fYM5+sTO06GxecAZei90/+J1zeghxLNnzScZhNfT+E8ydaZ5eaKFbL1NXFTqPXAIFHTMq76WG9tz/r3lTJmjty0DkyUWfszT8C9YprH4X6RZWvShJJG4NhAc6SVtYoEV9C2kEcs42b2pjib7IJfBsWlCSSSXhsz15xSV24fbAlxYbxcUDLOm2Xy3kVxcbwbFso7oDrdyNYgoMoSC4hJvkILX1hhKl/D0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8274.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(478600001)(2906002)(186003)(55236004)(36756003)(8936002)(44832011)(6666004)(52116002)(1076003)(6486002)(2616005)(316002)(66476007)(66946007)(6506007)(5660300002)(83380400001)(26005)(38100700002)(6512007)(6636002)(8676002)(66556008)(4326008)(7416002)(38350700002)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UltNNqAO+YEX1ARpM1QPsZlKoiOzc3Oge/6w/CZIQDhD7QBcDKdApUP21mYN?=
 =?us-ascii?Q?VUhxpsSQ5rmQBxs4tut+3p5Z7IOIT9kGLGuiZ0wI9ighOaeMK9j6IV46wqlV?=
 =?us-ascii?Q?3ezsLn1UXyvtbszpM1LiSc9i9ixNT3tuEKmAR8LXLKrSxIPTBH6aR5QYwa0d?=
 =?us-ascii?Q?JnSiQmdZitcEiA7KKVH5L3m+1wIdCt0ZVgAGBX0+KWWFSKszgCMiiCAu0Eoi?=
 =?us-ascii?Q?JZIdOsyP2T463S6/m1wR2b06uI2/XYwYjvX1fAvpEIbVQ1UICfVS9SWTdeYL?=
 =?us-ascii?Q?NjZZYDwBPaEiSVt5I8HGYM3OukTiE844aS2OMO5as5T6JBGFXENeySwa8g2A?=
 =?us-ascii?Q?xuPHHhTf6tnQrTo1Ijfl0lMnyfWfAwrbhG9AYp3+uKviTV5kuo9YRZo/NOxV?=
 =?us-ascii?Q?g5d36GXdN4e4ZAg/UfuzafhJ3cmvIV1MugV1zzRpH69wyUQoQYI3Wobr6wiY?=
 =?us-ascii?Q?tpEcmKf250/jiXGOG9WIV/hbmOFwlsDBSjIFQ8+15zBp2uOO0xTAvG2Dc9Sg?=
 =?us-ascii?Q?jn2/HXF4NUcLPBS3L26utIfST5PrXNF94Y1kd87q6g13ErGF8HizHTUA54QH?=
 =?us-ascii?Q?t0w3kEOlkm4+tdJR592xhy+33Z7pohO93FVGah4I3EqR59r/vHZ607H3oEhq?=
 =?us-ascii?Q?oT2iM/COPKoxp4IaQh/3xBWA9cki+ScJdhKUTEZTjHY9rOnQikdNgmbhGNyL?=
 =?us-ascii?Q?HSaylL+FdtsgmB8xqT6uMBhvj+65MCuS4xpjsNVjxNjDAgojtWq25W4SDsH5?=
 =?us-ascii?Q?PtxjU6CbsIuvLfwMn+QFZ0i/7usVpbCsnHww5O+4UrO9CVghdemgOTnADSDJ?=
 =?us-ascii?Q?xOE6JvBXYn4zFEYxQtaZGVxge8d1OUSqu2XgI2x2hEtn54oiDlNiTxEIAlMh?=
 =?us-ascii?Q?LZuh06SWheJ80clHT3SOUVRBoYd87CNRb5DkmyYmKNXt45BRrfXyFiQFxBSY?=
 =?us-ascii?Q?5+4gydUwtH3tM1xWCUAGUtX/4tBIUKU0yAdXbHzWu1WUke3/xkqPGZkuToMc?=
 =?us-ascii?Q?5PMGMfE/u+DkV0NSi01cUAeGxGhVaB9c7tyktOkxrevuxitZqqJJBX68Kkeb?=
 =?us-ascii?Q?P85NGfD+JOVfzls7BizJbLNMdb9LlD+y2l8I591sxwZi+rXJIW6/baujzyXN?=
 =?us-ascii?Q?ahqCw9DRDt4XIcbOhWgKFCwIUphj5wxavLN5ZED/EcUu7FuMHMQxIZbOv9a/?=
 =?us-ascii?Q?qGKOLCr92sRiPV2n+iJK7qz2WBj4SkznZa6zTw13WmzHrAj0Yk2azJh82qv9?=
 =?us-ascii?Q?FY/EBTppLZqfmJK9vzfnqLbnhxzlpTcDocfYPo9X+fB82CFXRbFhvK4j8SCH?=
 =?us-ascii?Q?ej+GkFD+gfkO4Jn7OGgNCjcErx59ZmCGofZWInWrr+J34L/U03korXlX/yAG?=
 =?us-ascii?Q?52VYiz3b7fbXJpsaVhBif+IhvO9CNmlcU5oXqkXYOp7I4Hfzy/zbvKL8N+va?=
 =?us-ascii?Q?2QZEjK+sItwnFsIUTh32uoQioZpB4pIi1rPdQh7pj1WNhgiUnbbgII6zF8eg?=
 =?us-ascii?Q?LHlxsmpe1rLtIWJp2C1NjOwlmlsiBwEvzR4DLTtiZLgSATSU64Gx8G+e/pNm?=
 =?us-ascii?Q?dGz0OIh75umQxL5HUtWZzJWA0+0EbOPEGb/+sC7z?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b289b4d-81a9-45c0-9e32-08da7ad4a84b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8274.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 13:31:40.3716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ErBAlRep4GXYPaB2z91Sn7tnDh/5fxNID5CWUo0tzp28c+yVGVHrqzrm0a4t7yFQaT6hqlYJCB3qtogrKTQC0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6630
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
 drivers/gpio/gpio-imx-scu.c | 140 ++++++++++++++++++++++++++++++++++++
 3 files changed, 145 insertions(+)
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
index 000000000000..8891262d609f
--- /dev/null
+++ b/drivers/gpio/gpio-imx-scu.c
@@ -0,0 +1,140 @@
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
+	{ .compatible = "fsl,imx-sc-gpio" },
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


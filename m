Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6A858DA5F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 16:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241485AbiHIOcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 10:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243509AbiHIObx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 10:31:53 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00047.outbound.protection.outlook.com [40.107.0.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F8C1C903;
        Tue,  9 Aug 2022 07:31:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6w5ZVmjETE0CTALfu64EdIqOiUUM57l/Fdv6yfRi3cW0vOPfW//fsQgN3Myhh5Lg3dTHrCE/uDI+knyXRcYZNJgWoNbVorx33BB7R20PkoGRye6hEjKDCpuDkUmq8Kv8Dna3gxOc8pVFbRzRnuHRhbWpPEfJlHiuq+cGlBiia1oP1mpkGiC/p7X2wMlVW4Qom6dJ+nH95pQiedCUyR8kKe+nGOcV8ytqIzW2AoxLSClnl9xR4Yin/Rv/5ywr5a4sOd+PQ8BRDaXhRuVzB/w7upeKGbbpQJ3SReJipHFKTE+ki7GmSsp4Y6lbwOxj0If8clKhf4SY7LgtMF5M217Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxu/U9tqMOHp9+XNoADjX5mI6QN1TkJOQzcZtKHbtg4=;
 b=YEklJaZU7cR5FMc9r98DqEQjj8LossTlZM9bMWaGlPaMsPIbPU4wrdcOFuCU7jKw1AOSw7rOEz+4KDqIchMQ2UVvwwvCEyafpk2aDiC35mzAqK7f4n3XJQ/F3uKeqDI8qo2/wGbKEX5qjcHQkJvFewcaLEHp0IY9xBKG4D6SPz9MSSGD0YC45ud6bUmbZpORfk0KKf4ov/TsXJPM+Z4g30O/wcnwy4fgBgaB7uIQF1MF3ICgra6xOZFnVOgNUWIaIaqnQZQ9v0Ueo2YxN/astOq/dQifPUP65KIkSWJKMTUDDdMzaK3ew0v/Kp7HA9LSzbEODvNLobcrtw9/aR1WBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxu/U9tqMOHp9+XNoADjX5mI6QN1TkJOQzcZtKHbtg4=;
 b=W8qho5OXyBj/CQp4zCo6LijpyVONMR7aBjnzQP9f1UcgQ9zLuCQsa6SgJK8rCVZujognHSq8vntvySiCmUTh4LxVTEnFFnhX7/Or6kWQuPoXRWxnd36QR3K7RZzjn7+atLc18Y0Rx18UBdWQbC3T4loU8vcDHz9TNDqHWGSzHEE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23)
 by DB7PR04MB5226.eurprd04.prod.outlook.com (2603:10a6:10:21::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Tue, 9 Aug
 2022 14:31:45 +0000
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca]) by AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca%5]) with mapi id 15.20.5525.010; Tue, 9 Aug 2022
 14:31:45 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, brgl@bgdev.pl, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH v2 3/3] firmware: imx: add imx-scu GPIO driver
Date:   Tue,  9 Aug 2022 09:31:05 -0500
Message-Id: <20220809143105.17967-4-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220809143105.17967-1-shenwei.wang@nxp.com>
References: <20220809143105.17967-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0082.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::23) To AM9PR04MB8274.eurprd04.prod.outlook.com
 (2603:10a6:20b:3e8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6d2521a-adc7-479d-a9f6-08da7a13e25e
X-MS-TrafficTypeDiagnostic: DB7PR04MB5226:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gzkSqC1ztb7EBMb+qM2BSS8UVGNhH7Pm4BqiY/bJxPfUVaYw9e4O8SV1Z9b1/5EDAPGMeAXtYnxmM7NII7kYV7Woh7jnkbOBBzwAPWP/YLTbqQJnbpr6FvOj/lsMIXAELHcASiVNPXEzEG9cTVz6Px+a9n8B9uuXCDvuzEMDw70njAMo7WMgGCHTe+P7G4yL7oxhO9Wb6ER3Ea0V4iqCiGewlOdTGdZA+vI2iKU5bgYKgLheg8Tk1bXaPRkVAnINmD9NOsCobqcXfuueDsgN6aXQraOABji3zEoQ2/DirnWlWIOVNduhNKVjaNHWEAFViTc0gDBJtMKa0jXv8ogVn0AaC782lTXEYBInYlNSzWG3nbo0XwvImcPAN6t+h4IjM8clrK2Z6OUaIhY9dFwgSZCL/51mOyHpkFd7IDA1qu79fgf1GNlRqBRZkKBfEHB2YsoXRbHA5db/+yNVkkHNh5vi0pRD773GpNJb/Fh5RDfT9+NnuBaQaPUEsiDjtKERXJH2mLfO6RNIkprawVGolY0k67ix7cEeJruAXiMNC+GihFPsqOmVLLcRpWunhD72mf/RlYZzpZnirWjLz4+L9R82++24yxJSUVbTbUYEDNZ8zXrZl+XubobDMtln5khl1uy6AzZojHaebKHtm2tKdJaPpDiMvMsIh0Fz1imGsdyeQEM7ORLzMp/Da8nheqwvPiMGvfKTIlu1XYBOkqwTOCIzLbzFqUiEhO52tyKXG/5Zp+USbFxxGS28OF75hLCUJqCXmpetJXiccZ7mluXYqh3qZBNFwFJjPsaXc/Ap2co=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8274.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(6666004)(55236004)(2906002)(52116002)(26005)(6512007)(7416002)(6506007)(44832011)(8936002)(6486002)(41300700001)(478600001)(36756003)(86362001)(1076003)(2616005)(186003)(83380400001)(66946007)(5660300002)(6636002)(316002)(66556008)(66476007)(38350700002)(4326008)(8676002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MozQllthrx5LRTwJvYQu1UlIdWmzbgz9nWq3YhBWF0Wnrp9vohO128Fvsc1Y?=
 =?us-ascii?Q?5cksQPslEqwAzGJvl72rzNJoo3GZqSfBjXejXVvHUUl3IXwZy1m+g2bqvNqu?=
 =?us-ascii?Q?4L///PZbbUdqlFXJ4u9lhYXGax7Rzwnb+kXPBqEXL2Pee2Fqr11VkkR4mKZ5?=
 =?us-ascii?Q?o8H11zTlcRK27im09tMQF7dwYb9gl0WUySmdvluRTRQgtKlcevEt0yd/N06J?=
 =?us-ascii?Q?I7C+CqcbNTbIp5UfsD75Ws+bMNRu9ubmzHErI5cR0FOdSLKbS8Jvu4cB2iq3?=
 =?us-ascii?Q?bDE461PWxkKfwTAQebaH3xWgYN3jlZbLa2HWq2g+9I6lzHrzgg8RGTQCkb7z?=
 =?us-ascii?Q?JpbEcrR5C8lNRHAN9OfFGetIVgW78ipJkF2W9dLZXueGdHYZbJXXk2chNt/H?=
 =?us-ascii?Q?h2JDcbzNpCSQLlRYHnoKNbkVmAxGdblrlZTE9GivfoSGWgKAKl5CsC59vFr2?=
 =?us-ascii?Q?Hj3oNVlHmLKYNw1Y2tXAwjw07G1qNfc+wSEn2DarB1g8+HQXglHiVAfyOYij?=
 =?us-ascii?Q?uL71T+Hme5iocE7c5m6MKXgI0GDVScFUwCh5xd4Jn3vIAExARCDdrarMOhPM?=
 =?us-ascii?Q?r67lHz1Sk1zvsN3w4eTSws5HISalusLLkCgu6ve4UqWc/Z3PpyfJL1Af65Z4?=
 =?us-ascii?Q?MPUy289ITJRXE0bGb48r+b5X98eM3oGvgJRVEEm9OVXDy6Aq33HVHHUDhd5h?=
 =?us-ascii?Q?j4o3mgzkawppXulPdKT+ml7xXdVAUrvQvqBrB/fcC/CtTGHgtpSZRoLUK8An?=
 =?us-ascii?Q?r1wc/OUW/ao+xTAuAYkYJJ8RBPTOebhyhskvmzicYGw9S1+JAabzPF+rXZvF?=
 =?us-ascii?Q?p+5WvCmVqqIIefCieAlOy6g8By6NKQgFbpsVDTDRMV7jRhtwZ4WTCdEzXJ9E?=
 =?us-ascii?Q?uesQ4F6g1xyIwVmHM3ntU+ThASyMQMf4C0Nz8MGdIS7HmypIfTw9UwdMSLF9?=
 =?us-ascii?Q?i4xKI33jBTGmVo8lP3ocQHQDZLF/fGHlpkXd9SLJ48WgH4NuBo8FGV2uwPSl?=
 =?us-ascii?Q?3hmj6dTmqmtyQHvi11D6u60SZwDLOq70Yr4Mza4PwWlAsiF6dLaobY6uE5I0?=
 =?us-ascii?Q?Bj187xDcDXkscxoqvpyXbJcHZJL8v64DZ7HZ0mGc1kqHgXYave92EqMvTXGV?=
 =?us-ascii?Q?Cm1/mvjefRkqDNdtQ1ST7jo2dA1br6aH996sEqrCKAAKoGagrnybpChzc73I?=
 =?us-ascii?Q?W/zCXmwLgDv5PJ38kgRHZ6MWzebVvTUWH7hNN5Uwl5gMp0sCzmNaZeyAXsVx?=
 =?us-ascii?Q?qWu9AYfdM3XSMqMWafihs6/lB7EQ2sdj0aJwyVRHJqj/RAdeR1a+47mYvC2L?=
 =?us-ascii?Q?F3srUyzNh15Xjw4Un7R8d8ABU0a3xppq5zhLqUukL0Re+Pb5IpsOuyscd/5D?=
 =?us-ascii?Q?6PaKSgSGPDR7LeCbB/SvSPNp55cpm46GVAEqInedifIDzx5efkRyjcYbSN/F?=
 =?us-ascii?Q?Dp/U83ztmERx2E2njqnYXNUOI4pudB60ZRhw5pisAQKPFbWNeM8GINdM/XUz?=
 =?us-ascii?Q?1uPe2wBlyB7A8o47WKyK/y9luwg5MpMWomPE3hMzjK+tZTEcBFmiXt5UBiOr?=
 =?us-ascii?Q?hf9FbR0ky3wciYaUBJdJA7hvX5OyP9b30T5034x1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d2521a-adc7-479d-a9f6-08da7a13e25e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8274.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 14:31:44.9355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YCv+aaNzsOQk5uVdHPhXh324Z18zTTG0aRi3Cy9YSUK0ypTXWcKlv3PyUxhkD32omWeUn1UdRaR/hV7HVejShQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5226
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
index 000000000000..2f4a991a9ad6
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
+	{ .compatible = "fsl,imx8-scu-gpio" },
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


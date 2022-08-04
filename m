Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1945B58A0D1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 20:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240083AbiHDSuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 14:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240056AbiHDSua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 14:50:30 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60045.outbound.protection.outlook.com [40.107.6.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97514140AC;
        Thu,  4 Aug 2022 11:50:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8tkRYBzsqJK8h/O+5ImqkCmZNoZV4g9qdhvTmscAygcLQY+xQKfO5QSc4vElNGl7tiWxKvSYy+6mP8G9quIk9/S9tuIuYX9/Yyfr7gkH5/kbWq28NGra1owhTWgbIonue4sgZJ7klUURWSNPwRIlo6XMy744apE+q7R1ZNYi7gLTRzQUBpcWUTPbcoU48NxBDgnd/wy1GqidI5cFshECGbymXXDMlGl3o11domAzP+jH7zqTPFgqMC4U10iFSUBlHha9dxmtDf54qsiwH85O/DZu9vvocKtnFMtAhN7TEnP5Exht+uyeR/e6oz06rVmWv8BW0HSXb0oTJl1Fms4ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSYlgki2uUy08cGzelO1onOjK1dHM751zgleNz3R62E=;
 b=VURCenFCpHbxgdRqXV2O/2Lee0G2+TTORey0arnsZTRcVaaGYNXsOoWAtYPFCdG93PXmjLr5wWMJ8Nj77ArKPlILD8FfzuV8IY6ESCcMSRLr/GcBgCq3d5zv+la9tM8twa/FQt7aKi+5HpqLpbrL1NuikCgq907avXJMewU1stz10ir0gfxZXYAw2UbofYLU/ueI4RDYCfRRP29iChmwy3puYh15w5dzKxjf4ji40f8H4plaqGd6xUPKjZb6qGdw3UdxJx6mpC2RlMIJm/ghCrjmaQuHC0Z/uyEhTxnR+72QJ6tbTiZz+6n2DNM/jY6gE5NBvstK/+eZ2FCeViry7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSYlgki2uUy08cGzelO1onOjK1dHM751zgleNz3R62E=;
 b=BsfRMfW+9MENVWHogO/Vaggdz8AkFIK+tpUDtGA2KU1DTbPh1F0RE0rVSg11AAy+4YTFnyTJdZmgL82zF3UTs0ErcK9nypQN1TWGmKnmGy11QH7PGnN5Tetimn9+XL4xtCTiDfH6PUXwCuwVNnWIkNDTEH4VQLXwDdiqJ3HErDs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23)
 by AM6PR04MB3992.eurprd04.prod.outlook.com (2603:10a6:209:50::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Thu, 4 Aug
 2022 18:50:21 +0000
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca]) by AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca%5]) with mapi id 15.20.5504.015; Thu, 4 Aug 2022
 18:50:21 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, brgl@bgdev.pl, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH v1 3/3] firmware: imx: add imx-scu GPIO driver
Date:   Thu,  4 Aug 2022 13:49:08 -0500
Message-Id: <20220804184908.470216-4-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804184908.470216-1-shenwei.wang@nxp.com>
References: <20220804184908.470216-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:208:23a::34) To AM9PR04MB8274.eurprd04.prod.outlook.com
 (2603:10a6:20b:3e8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebc9bde4-dd0f-479a-a5a4-08da764a2eb3
X-MS-TrafficTypeDiagnostic: AM6PR04MB3992:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BLDdbOk+j/QfBGPTWHWi/mSohWRlO9E6vVdav2bwue5WMr3qXuY6re/yUREbveXG/xSrM4WznDFCkqEHn4HCYKKCPhTBvm30uPNjB3Vj0P0RfphJ4KvIM6u+jVILERZZ+uOmK+Ve2sdSaAfw9jALAYw63TVtRPGFcQ8+R0Ujfxr4ViYGprJhw/cXZeSsdGcVqS5IVwjCBkTAxcm4ykMhW/VydHE6mvrTylzzRlYcRevq/b9qcEVtWqXbBDuxqjA32Cws1vUXaesomXaGwPf10iYzmyBLbqCkJt45I74zbf7aDQoRI7wcX41ybWHYrXGO+9SWrzT0m7u6O54B0RJFVYN5W8vBmpfCa5pV/8DpYqTXcUljjDKBFacr6NwWGBB2sDtFTo214IdGZw2wt8KLIFOGFiz6eWsRF7oMRLc0ktOHZuTshdx6Vjtps/aVu6qcx+l4U4HVR10qN+5e2pVKJzcOxVFyhKoXp5/zdVuL5Blk7AeD0y/m/kiQ1+cYHZzkrvEFGFYznKOUwwJl+8O7Jftricu/ANnu1sRtcjIqD2vtjcqV8dsJyaEz7GDzXQwWnaevPM5ZYoGyBv+LVQw7JN80e643sA4FHOTNB+ufbTtvVubksNjtqSMB/dTEJQs/t8tJf/m36l4mzbrutCvqeU00vunxRKDJp7E2RGqRjenZRJ4eN7TRTXgneahocGR/8K6/W003BiOafLkXLlkc0mDeZB6cXOnfDpjs2c2WbEHRqvN8F0QHqVXw8u8mJggIwcK3MRiXNBLNwWlINdad6ARNEwbE8RlvWv2+aic8PSQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8274.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(2906002)(6636002)(36756003)(4326008)(8676002)(66946007)(38100700002)(66556008)(8936002)(316002)(66476007)(6486002)(38350700002)(6666004)(86362001)(52116002)(478600001)(6506007)(55236004)(26005)(6512007)(41300700001)(7416002)(5660300002)(44832011)(2616005)(186003)(1076003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eE7qzfHdH7pnlMx1eSJb06ebrXQyJENCE+fj82Q+tnWWkRWoYTk4OrBxZMyi?=
 =?us-ascii?Q?k2rIZoteQ84DcRscQ6ktPLEl9yYmN80Qbb7+jizTkkltCh5YXIMOsmoZZQeW?=
 =?us-ascii?Q?khucBU7GffBA++Nw3GWc0iEUkKe/xh1DTbnszg9rk6SYXyyOYDIJRpQcuAzZ?=
 =?us-ascii?Q?ndQu+AAK1Z30pYtnRQPhKyz+83FzJI9rmf352OCJGyYe7xkuAPmcnJ9MRJrl?=
 =?us-ascii?Q?czHTOIb4CggFv8mPg+EiaKegVN2kpOUStvw0JwAjLYDvBxSnNO8yNcW865TY?=
 =?us-ascii?Q?BwUIbecmHr27HSyywii4BpKYsOWTAM3L48eAEvcLm6X6xvu3I4UNHDCeMNQp?=
 =?us-ascii?Q?YiO9w5gdZbtbXpKuRbk8LdcFsOyblrtSgxgbsZRzANw37bElp4emm+/hGzWr?=
 =?us-ascii?Q?fdzKwGNI6RV1f0tkcgi9/+qwBO74BJvqapju/jJOIJXs2xol9yrDR7CIOxYm?=
 =?us-ascii?Q?vbRTt9VzKVVoqJsJILefnyMa+lA9nATd/xtJ4gzPJgBnWYdNcPCKBU3fi9lC?=
 =?us-ascii?Q?RhX3IafuRcElEKTfQ0PJ7Nykd27Hwe5lCgA0f94MtVNBMqC66YSf1fyFmAt2?=
 =?us-ascii?Q?8lFCLVokIbl7XkqsukDAZknQ/w2Erl7uPYFpCcs3TTmK+UcayDmZPtA1bkqy?=
 =?us-ascii?Q?PxpJaKlxzQ8T44AfeXMb2MESwYIYWpJk8FJs9aG6vhlWey7eS6EDNKVyBq3h?=
 =?us-ascii?Q?NmvusgrJmPNvoYErS3ABe0YpS4vZGjfGQ2y6rAlEnTcIeH0tJZxIDyhFhSez?=
 =?us-ascii?Q?Zh3n7aLGfA7auJgRBQU0b9Dc48e4TAdxiDXnR/gZRksTqzmQ0yiVWN9D3G8D?=
 =?us-ascii?Q?z09snI0X6cVG7QGAilltzZAgNcYZQxscCai0kQHpjNjcP4Jn0MP0VB7eXIxg?=
 =?us-ascii?Q?CvQtmtkDtAVHcOWD/K0fCZmRH96utzvaDtMFl+qjXkdbLOSFBHAUIrmX3zTp?=
 =?us-ascii?Q?9/Y28OT5r4eFXqd/saU07+d3on3yDZr17KoGt92syYIQMpWcPcFvA/xPJ8rs?=
 =?us-ascii?Q?qUXlwNHsbSrGBWS+n/Gabdctis+m3uFq1zGKe+AoMLCyadApuaH3csAz3zmx?=
 =?us-ascii?Q?DCE6LVwfMaLarobcMF5WrRYJNzmf5nxNfiM/3Y4lGELAUikxE+FLjjjpC8c7?=
 =?us-ascii?Q?q4EX+SssK+EGuBEAu8KQ1qb4eDLhEIScyqMulVafpDQJ3jXBukzN16vBu2mG?=
 =?us-ascii?Q?OM9nBuaJZye3ALAfxMAZzwL6XwuBAQZif4BMeht87SKnzqe0Khsk4hxeiatp?=
 =?us-ascii?Q?CfWbONNfRrYN2YfA3zs+SdWn28gZXbj5dO3wD2doplu2MOX7bwZeabVsYfob?=
 =?us-ascii?Q?QdApCRwgEClcrHHTkEo/h+VNONJMcIAc9Rwd8ZoWoWfNC4/naxw70uyL5Uvl?=
 =?us-ascii?Q?yF9D0IXGWkUlCTQ/V2a8PCwm/IPhVib0K16ZHLlce3F3/j1fe2iAGouNzCqL?=
 =?us-ascii?Q?A2PCllCr/bQ0FP1Wt8xDKiXoH54yTUz5jeOLEJp19/+ggOjNULJUPctARnzk?=
 =?us-ascii?Q?JGkGCHrM0cuObk/wJdBy9SNZKxgspb4ba7pV1G5d7SGfq2Yjphn5GufY1wMJ?=
 =?us-ascii?Q?lguahuJcSgmzqFfBnws+R/SPaLHVAFCEcpXnu1mH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc9bde4-dd0f-479a-a5a4-08da764a2eb3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8274.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 18:50:21.0466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fBhUKRSmrjH432Z5msc4yxRMEml1aM1G/BwgztSilYmPAm3rW6DdHh2w8x/yA8SY8fW0ZxUroC96y6xGEExCzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB3992
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/firmware/imx/Kconfig        |   6 ++
 drivers/firmware/imx/Makefile       |   1 +
 drivers/firmware/imx/imx-scu-gpio.c | 139 ++++++++++++++++++++++++++++
 3 files changed, 146 insertions(+)
 create mode 100644 drivers/firmware/imx/imx-scu-gpio.c

diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
index c027d99f2a59..484c13f3149a 100644
--- a/drivers/firmware/imx/Kconfig
+++ b/drivers/firmware/imx/Kconfig
@@ -28,3 +28,9 @@ config IMX_SCU_PD
 	depends on IMX_SCU
 	help
 	  The System Controller Firmware (SCFW) based power domain driver.
+
+config IMX_SCU_GPIO
+       def_bool y
+       depends on IMX_SCU
+       help
+         Say Y here to enable the imx8 gpio over SCFW MISC API
diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index b76acbade2a0..436476502bd8 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
 obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
+obj-$(CONFIG_IMX_SCU_GPIO)	+= imx-scu-gpio.o
 obj-$(CONFIG_IMX_SCU_PD)	+= scu-pd.o
diff --git a/drivers/firmware/imx/imx-scu-gpio.c b/drivers/firmware/imx/imx-scu-gpio.c
new file mode 100644
index 000000000000..2f4a991a9ad6
--- /dev/null
+++ b/drivers/firmware/imx/imx-scu-gpio.c
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


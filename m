Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922DB5503E2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 11:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbiFRJVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 05:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbiFRJVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 05:21:04 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80088.outbound.protection.outlook.com [40.107.8.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252F426AE1;
        Sat, 18 Jun 2022 02:21:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HlLGmUJxK/DFpcBtSrTZvAJNqfDBf002Wd0Qe6sC3jxtWRClUTbyRqQmyO19K83TXEOShvoPgzkyKrAXNCkQ9FxyGPTaffvP+2v0ggRTIHaIZQe49oPVL7/x6F7tGRAININOUNJogoQUbaD377f+nW4P8tFIrcUgo4gvnbGyzVgFergYfOxOozND/xCa7vb77I0D4gwxJOSMvGkU4k46qoS3SqLCsrBnPTajZFvcm0YAmijL+J6pkmd4OGpDbbLNX+KX2HboExAPgBMsg7RqrPeWCx5y+JCPyv6y/pQLPDNCRWBiY7ZrlhffGSh6MMR8TXngUv1NvzozFxKKqDhS+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YS4xDNBpxLgSrrjcD4rF7KVY9sbBKBr+C1gebBsMw8c=;
 b=NtRMyOsddcHBbi7icwxlhUiuSg9D7cTmWWmxzqHA2Lap53sbQPSb6rCVGZRhdNSvpqQAyzUSbp8mBhZeMvtlZVFRK2aLRBcaPqoTrVG/uGAFDClZfJsjaWpn2rkD1l1ycebQ1Z+/1ihxV+88ZfHy8tp4Tp2V5UjBi6Nci9N0s/cF136GBwZRKoXhV28pLFyYGhQpDxdYoEkzf2nJeZWVinPu/3rWhX7QVNDbmiU5o8mB4mTnNmTzSbrRKqztsz8SWo511VcmsI+JLRHDN46AxYCGM0Zw99Pnx5i+xn5AeN4ndDKysNibZOM+svN+MNV+b6e5mtXawAF4m+0uFfvzjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YS4xDNBpxLgSrrjcD4rF7KVY9sbBKBr+C1gebBsMw8c=;
 b=mxKCjvba+SZ8XFSOZOZKjFen55UTPqZi6r3w4ZbjyLk1aYfxjQXFK5/UaSU2kPSBhz5juX88OjM6JnjpKR+RQhgv2JyI1RBCSxhLC/3LT6F1MVOwM+KH0fV4VBGze0LHmNrWQOafYbChwivLxd/Be4Bdmrf3waii5UkQoN9JI7c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AM0PR04MB4209.eurprd04.prod.outlook.com (2603:10a6:208:62::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Sat, 18 Jun
 2022 09:20:58 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502%7]) with mapi id 15.20.5353.018; Sat, 18 Jun 2022
 09:20:58 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Subject: [PATCH 2/2] phy: freescale: Add i.MX8qm Mixel LVDS PHY support
Date:   Sat, 18 Jun 2022 17:22:01 +0800
Message-Id: <20220618092201.3837791-3-victor.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220618092201.3837791-1-victor.liu@nxp.com>
References: <20220618092201.3837791-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::15) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a955eaeb-4e18-468f-dceb-08da510bdab9
X-MS-TrafficTypeDiagnostic: AM0PR04MB4209:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB4209709466F129317DB2E4B198AE9@AM0PR04MB4209.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JU7LP2w7AucGV7ElCEQ/qwOgC/M4BA69CzSk+tADxjCH3TVK9b4hzqOX1afDarWVJD3uPtdjR29u6kzQFwreyvMfK/07xTTDMFrM2EeRAVWOmbP43JhRR+h/5Nz/IX/5L1SmGE6I/bEeA4/VWpPWajBYKX4Z0/K5KSaJjE4ZqtZfYjDgflJ4XyML/LGH2r4nCvWErOg3XaW5AGeKneP0bcNfY0v1hRkyKtfRmb/yVRe9z5OgX5RjV4C91CzPaiM9hlbY6YqHyJ3EB2T8+plUkxfhsDq5m9Z0eGd30gFsI7tpLFXFArnrY1OhYhRQF/aDzo7l5muYzogifkyL2yIVJkN/LfjT6+ZyJWgc13E7TBOLX+P6AhzO8BwDSfGRvUVEG56osYIzWUleu1ybRvvd6MmF7dEdisL9Lyuayl1F8+pnGL0l6nJ/3bSGBj5usj9+R8V06Ob+F6as71Ha2hzsjnokyiohdfaag8mAU8BXRkZO3gCPXTZH2eOfnZpniUE6XOqUBpJhgROYpKox8P4eMxc02gjsCD/tj+ZHdJ0m7eaWGj5yF4rEukzQHAsMajnwZI0VenZLknR3VR3tZsmf38a1i/LH+P3Bw4/+O8V+5WOS4UuGni+ao2ZOmzgmbhwMFyXu3qQgqvgGpDTenWTBEKsDAtT4x/gVKQxywcWWQk0Z3GKuIrF0BkhLU0xiqCQzHzUmqz9uYlgLLrHTg5OLpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(186003)(26005)(1076003)(38350700002)(7416002)(38100700002)(316002)(6512007)(83380400001)(6506007)(2616005)(36756003)(8676002)(6666004)(52116002)(6486002)(86362001)(2906002)(8936002)(66946007)(4326008)(66556008)(66476007)(5660300002)(30864003)(498600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tnsJYEN5+rbzJxNM9I0poeT2bkWO1mRAxTWxviT3OHYrYDBQVeqLTSEXaBYK?=
 =?us-ascii?Q?s0iY7HzfZg0KE26mMagAhsvvX9TWDELx9SbIvVvsawxPLaslHfoPA15Tuj1w?=
 =?us-ascii?Q?R868LVqaDWbdtCM8Ou5ZXqyv4dlflMOx2w3Sy+6HM0FpB89tDMNuFzKvrm/f?=
 =?us-ascii?Q?eX3nuL9tHjyxHwQOIO+dBrx7gwJ0QlHKGKJ4Ju5rQ4Xl8d8qzhCAck5hPvYh?=
 =?us-ascii?Q?eOXupg989bJ1S1BKuSlyi8rJOksK58zs6caIaAmIOlFh+xML2+JYDSZNpurD?=
 =?us-ascii?Q?1TNlAtmng9rrNbyVxHx5Kkhk8JP13rD7b97wzPM+rMiZfqwt3aN+96HQFgwL?=
 =?us-ascii?Q?CNFOokoFWzS9TzqMiTM7qC4wP0GzCzNTiAhMwhJ/uJQ7oGvynCjyRA7w68ai?=
 =?us-ascii?Q?KJVK093ws/Lb3EYn7B5Ke83dH68nmOsFV9tPCf0BBsMiuyr1ijH5Kizli/rS?=
 =?us-ascii?Q?QXtYeOYi6xCyDz6M+dtH9eUNGqhi1bdqXh7Jro5nrb1UflSkMhhTmgem5YaX?=
 =?us-ascii?Q?bJpyt51jgllcs/gzR/3dJML2Klz6/FXcm7WMVXkeJ9uqGV0IMQc54zOhB7qQ?=
 =?us-ascii?Q?MREqSWUT4P3LrT21PIYr7hsRR3vOlWoETxFnqDViR8OZhO71e5Q+/DroDdbn?=
 =?us-ascii?Q?QK+O5ASwtaFnYda7CP2c5wlV89k01oAfAXQMqd+6Fuv42OzV1P9zNuqRApAW?=
 =?us-ascii?Q?AvVg14m/cYioFBwK5eEALD0QqBih9jtRfbxNmA07vdEjDfvEANqxOiSaDX9L?=
 =?us-ascii?Q?wsK9km65EDM/t0A9n1SgMqcsr8bgww5IRkqCIklFRFDYObisjOWubEHxB7Q/?=
 =?us-ascii?Q?Ths+dMhwt9xF7EDtlgCymGo0MwrrcrQush/GCPIuyH+wMfLH//LT9m8HbDSt?=
 =?us-ascii?Q?UX7CIXIk/GDL5mxnt5sLlxogBE2TafqG6SQTDhC9f2qANw4Pmsz0s2GyeMgI?=
 =?us-ascii?Q?/bVSUU0jeaoCcgndCcACpTJMyImMVW4Nfxb1Am7km0W6Wac53fU+b1XcCDzj?=
 =?us-ascii?Q?QlJ+nnyUDgX29hRhS9DH2eMHWMBcxDDBOHfjeAS9SRSJ1IjmNIor2wFiou5g?=
 =?us-ascii?Q?CuaDuXRF7MCU6MaaZ2xKgmrpSUtTAIJFOWM+E23i3ViqqUt2v4yv0lW7BRvj?=
 =?us-ascii?Q?JDBenk0lAVIPyWB81Rro/XXQc/O27KQhHTGjqJJjoP9mVdUt980UG4CfzBMS?=
 =?us-ascii?Q?Qno4Cj2UNGlBtym8R3CDNyxzDk3gWayHKJqqG0i/sP0qNF0uPFYDXldSPtMI?=
 =?us-ascii?Q?CaLYfnrZt4SBJe2rCkvDbcqBofHYCe4CWi8tHqWK3xnecoviIuzQmzoCkLNf?=
 =?us-ascii?Q?IEWLSvP0uDFv1/nhlSNipAYpON0SCxiIvXJoUxJeyFpTpZtWHxDrp8hM9oCF?=
 =?us-ascii?Q?TpvfFtz2rhRWDkvcwIft54wTx1TFpQql1zyHceljhqNXqFrOTAF5XlYKeGJU?=
 =?us-ascii?Q?cst0ZpRDVbmTvhPy/GyTHRpRHHYAaDlMp3FVpBlCTXZ5WinyXH6GD8XyUa3i?=
 =?us-ascii?Q?g+TCCeLsXdtlpHNz6+v6izRrCocgZD7vXd48EtcL96IYe+UqUbiE75blk2RI?=
 =?us-ascii?Q?VrY5NCQ1UcnM7G/5A9XsVJ/56NGe1/DbrgC2C+tVvnR0T4KqNHST0DnDXGOy?=
 =?us-ascii?Q?3YEyukVEwjSijsou231eXZguUl5G8uZpX+WNoLPUtQc7Zkg3zH+PqaUn53u7?=
 =?us-ascii?Q?QhNqZuETI12WvQJT6ZvaZV8Hk+iKThsBQWJb+5k8RcBvV1+mYVM4uaMDy5v5?=
 =?us-ascii?Q?BpVohtVs4w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a955eaeb-4e18-468f-dceb-08da510bdab9
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2022 09:20:58.4949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S09BMm1rMNpt8lCNpGp4XX49Mqq3AoQ5Qj36Uv+tXwHdxBz6SZmdPGcj+KWsoS82mfbYHpHMXV5q2oR07FTVsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4209
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds Freescale i.MX8qm LVDS PHY support.
The PHY IP is from Mixel, Inc.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
 drivers/phy/freescale/Kconfig                 |   9 +
 drivers/phy/freescale/Makefile                |   1 +
 .../phy/freescale/phy-fsl-imx8qm-lvds-phy.c   | 448 ++++++++++++++++++
 3 files changed, 458 insertions(+)
 create mode 100644 drivers/phy/freescale/phy-fsl-imx8qm-lvds-phy.c

diff --git a/drivers/phy/freescale/Kconfig b/drivers/phy/freescale/Kconfig
index f9c54cd02036..853958fb2c06 100644
--- a/drivers/phy/freescale/Kconfig
+++ b/drivers/phy/freescale/Kconfig
@@ -8,6 +8,15 @@ config PHY_FSL_IMX8MQ_USB
 	select GENERIC_PHY
 	default ARCH_MXC && ARM64
 
+config PHY_MIXEL_LVDS_PHY
+	tristate "Mixel LVDS PHY support"
+	depends on OF
+	select GENERIC_PHY
+	select REGMAP_MMIO
+	help
+	  Enable this to add support for the Mixel LVDS PHY as found
+	  on NXP's i.MX8qm SoC.
+
 config PHY_MIXEL_MIPI_DPHY
 	tristate "Mixel MIPI DSI PHY support"
 	depends on OF && HAS_IOMEM
diff --git a/drivers/phy/freescale/Makefile b/drivers/phy/freescale/Makefile
index 3518d5dbe8a7..cedb328bc4d2 100644
--- a/drivers/phy/freescale/Makefile
+++ b/drivers/phy/freescale/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_PHY_FSL_IMX8MQ_USB)	+= phy-fsl-imx8mq-usb.o
+obj-$(CONFIG_PHY_MIXEL_LVDS_PHY)	+= phy-fsl-imx8qm-lvds-phy.o
 obj-$(CONFIG_PHY_MIXEL_MIPI_DPHY)	+= phy-fsl-imx8-mipi-dphy.o
 obj-$(CONFIG_PHY_FSL_IMX8M_PCIE)	+= phy-fsl-imx8m-pcie.o
 obj-$(CONFIG_PHY_FSL_LYNX_28G)		+= phy-fsl-lynx-28g.o
diff --git a/drivers/phy/freescale/phy-fsl-imx8qm-lvds-phy.c b/drivers/phy/freescale/phy-fsl-imx8qm-lvds-phy.c
new file mode 100644
index 000000000000..bdd11079b7b0
--- /dev/null
+++ b/drivers/phy/freescale/phy-fsl-imx8qm-lvds-phy.c
@@ -0,0 +1,448 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2017-2020,2022 NXP
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+
+#define REG_SET		0x4
+#define REG_CLR		0x8
+
+#define PHY_CTRL	0x0
+#define  M_MASK		GENMASK(18, 17)
+#define  M(n)		FIELD_PREP(M_MASK, (n))
+#define  CCM_MASK	GENMASK(16, 14)
+#define  CCM(n)		FIELD_PREP(CCM_MASK, (n))
+#define  CA_MASK	GENMASK(13, 11)
+#define  CA(n)		FIELD_PREP(CA_MASK, (n))
+#define  TST_MASK	GENMASK(10, 5)
+#define  TST(n)		FIELD_PREP(TST_MASK, (n))
+#define  CH_EN(id)	BIT(3 + (id))
+#define  NB		BIT(2)
+#define  RFB		BIT(1)
+#define  PD		BIT(0)
+
+/* Power On Reset(POR) value */
+#define  CTRL_RESET_VAL	(M(0x0) | CCM(0x4) | CA(0x4) | TST(0x25))
+
+/* PHY initialization value and mask */
+#define  CTRL_INIT_MASK	(M_MASK | CCM_MASK | CA_MASK | TST_MASK | NB | RFB)
+#define  CTRL_INIT_VAL	(M(0x0) | CCM(0x5) | CA(0x4) | TST(0x25) | RFB)
+
+#define PHY_STATUS	0x10
+#define  LOCK		BIT(0)
+
+#define PHY_NUM		2
+
+#define MIN_CLKIN_FREQ	25000000
+#define MAX_CLKIN_FREQ	165000000
+
+#define PLL_LOCK_SLEEP		10
+#define PLL_LOCK_TIMEOUT	1000
+
+struct mixel_lvds_phy {
+	struct phy *phy;
+	struct phy_configure_opts_lvds cfg;
+	unsigned int id;
+};
+
+struct mixel_lvds_phy_priv {
+	struct regmap *regmap;
+	struct mutex lock;	/* protect remap access and cfg of our own */
+	struct clk *phy_ref_clk;
+	struct mixel_lvds_phy *phys[PHY_NUM];
+};
+
+static int mixel_lvds_phy_init(struct phy *phy)
+{
+	struct mixel_lvds_phy_priv *priv = dev_get_drvdata(phy->dev.parent);
+
+	mutex_lock(&priv->lock);
+	regmap_update_bits(priv->regmap,
+			   PHY_CTRL, CTRL_INIT_MASK, CTRL_INIT_VAL);
+	mutex_unlock(&priv->lock);
+
+	return 0;
+}
+
+static int mixel_lvds_phy_power_on(struct phy *phy)
+{
+	struct mixel_lvds_phy_priv *priv = dev_get_drvdata(phy->dev.parent);
+	struct mixel_lvds_phy *lvds_phy = phy_get_drvdata(phy);
+	struct mixel_lvds_phy *companion = priv->phys[lvds_phy->id ^ 1];
+	struct phy_configure_opts_lvds *cfg = &lvds_phy->cfg;
+	u32 val = 0;
+	u32 locked;
+	int ret;
+
+	ret = clk_prepare_enable(priv->phy_ref_clk);
+	if (ret < 0) {
+		dev_err(&phy->dev,
+			"failed to enable PHY reference clock: %d\n", ret);
+		return ret;
+	}
+
+	/* The master PHY would power on the slave PHY. */
+	if (cfg->is_slave)
+		return 0;
+
+	mutex_lock(&priv->lock);
+	if (cfg->bits_per_lane_and_dclk_cycle == 7) {
+		if (cfg->differential_clk_rate < 44000000)
+			val |= M(0x2);
+		else if (cfg->differential_clk_rate < 90000000)
+			val |= M(0x1);
+		else
+			val |= M(0x0);
+	} else {
+		val = NB;
+
+		if (cfg->differential_clk_rate < 32000000)
+			val |= M(0x2);
+		else if (cfg->differential_clk_rate < 63000000)
+			val |= M(0x1);
+		else
+			val |= M(0x0);
+	}
+	regmap_update_bits(priv->regmap, PHY_CTRL, M_MASK | NB, val);
+
+	/*
+	 * Enable two channels synchronously,
+	 * if the companion PHY is a slave PHY.
+	 */
+	if (companion->cfg.is_slave)
+		val = CH_EN(0) | CH_EN(1);
+	else
+		val = CH_EN(lvds_phy->id);
+	regmap_write(priv->regmap, PHY_CTRL + REG_SET, val);
+
+	ret = regmap_read_poll_timeout(priv->regmap, PHY_STATUS, locked,
+				       locked, PLL_LOCK_SLEEP,
+				       PLL_LOCK_TIMEOUT);
+	if (ret < 0) {
+		dev_err(&phy->dev, "failed to get PHY lock: %d\n", ret);
+		clk_disable_unprepare(priv->phy_ref_clk);
+	}
+	mutex_unlock(&priv->lock);
+
+	return ret;
+}
+
+static int mixel_lvds_phy_power_off(struct phy *phy)
+{
+	struct mixel_lvds_phy_priv *priv = dev_get_drvdata(phy->dev.parent);
+	struct mixel_lvds_phy *lvds_phy = phy_get_drvdata(phy);
+
+	mutex_lock(&priv->lock);
+	regmap_write(priv->regmap, PHY_CTRL + REG_CLR, CH_EN(lvds_phy->id));
+	mutex_unlock(&priv->lock);
+
+	clk_disable_unprepare(priv->phy_ref_clk);
+
+	return 0;
+}
+
+static int mixel_lvds_phy_configure(struct phy *phy,
+				    union phy_configure_opts *opts)
+{
+	struct mixel_lvds_phy_priv *priv = dev_get_drvdata(phy->dev.parent);
+	struct phy_configure_opts_lvds *cfg = &opts->lvds;
+	int ret;
+
+	ret = clk_set_rate(priv->phy_ref_clk, cfg->differential_clk_rate);
+	if (ret)
+		dev_err(&phy->dev,
+			"failed to set PHY reference clock rate(%lu): %d\n",
+			cfg->differential_clk_rate, ret);
+
+	return ret;
+}
+
+/* Assume the master PHY's configuration set is cached first. */
+static int mixel_lvds_phy_check_slave(struct phy *slave_phy)
+{
+	struct device *dev = &slave_phy->dev;
+	struct mixel_lvds_phy_priv *priv = dev_get_drvdata(dev->parent);
+	struct mixel_lvds_phy *slv = phy_get_drvdata(slave_phy);
+	struct mixel_lvds_phy *mst = priv->phys[slv->id ^ 1];
+	struct phy_configure_opts_lvds *mst_cfg = &mst->cfg;
+	struct phy_configure_opts_lvds *slv_cfg = &slv->cfg;
+
+	if (mst_cfg->bits_per_lane_and_dclk_cycle !=
+	    slv_cfg->bits_per_lane_and_dclk_cycle) {
+		dev_err(dev, "number bits mismatch(mst: %u vs slv: %u)\n",
+			mst_cfg->bits_per_lane_and_dclk_cycle,
+			slv_cfg->bits_per_lane_and_dclk_cycle);
+		return -EINVAL;
+	}
+
+	if (mst_cfg->differential_clk_rate !=
+	    slv_cfg->differential_clk_rate) {
+		dev_err(dev, "dclk rate mismatch(mst: %lu vs slv: %lu)\n",
+			mst_cfg->differential_clk_rate,
+			slv_cfg->differential_clk_rate);
+		return -EINVAL;
+	}
+
+	if (mst_cfg->lanes != slv_cfg->lanes) {
+		dev_err(dev, "lanes mismatch(mst: %u vs slv: %u)\n",
+			mst_cfg->lanes, slv_cfg->lanes);
+		return -EINVAL;
+	}
+
+	if (mst_cfg->is_slave == slv_cfg->is_slave) {
+		dev_err(dev, "master PHY is not found\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int mixel_lvds_phy_validate(struct phy *phy, enum phy_mode mode,
+				   int submode, union phy_configure_opts *opts)
+{
+	struct mixel_lvds_phy_priv *priv = dev_get_drvdata(phy->dev.parent);
+	struct mixel_lvds_phy *lvds_phy = phy_get_drvdata(phy);
+	struct phy_configure_opts_lvds *cfg = &opts->lvds;
+	int ret = 0;
+
+	if (mode != PHY_MODE_LVDS) {
+		dev_err(&phy->dev, "invalid PHY mode(%d)\n", mode);
+		return -EINVAL;
+	}
+
+	if (cfg->bits_per_lane_and_dclk_cycle != 7 &&
+	    cfg->bits_per_lane_and_dclk_cycle != 10) {
+		dev_err(&phy->dev, "invalid bits per data lane(%u)\n",
+			cfg->bits_per_lane_and_dclk_cycle);
+		return -EINVAL;
+	}
+
+	if (cfg->lanes != 4 && cfg->lanes != 3) {
+		dev_err(&phy->dev, "invalid data lanes(%u)\n", cfg->lanes);
+		return -EINVAL;
+	}
+
+	if (cfg->differential_clk_rate < MIN_CLKIN_FREQ ||
+	    cfg->differential_clk_rate > MAX_CLKIN_FREQ) {
+		dev_err(&phy->dev, "invalid differential clock rate(%lu)\n",
+			cfg->differential_clk_rate);
+		return -EINVAL;
+	}
+
+	mutex_lock(&priv->lock);
+	/* cache configuration set of our own for check */
+	memcpy(&lvds_phy->cfg, cfg, sizeof(*cfg));
+
+	if (cfg->is_slave) {
+		ret = mixel_lvds_phy_check_slave(phy);
+		if (ret)
+			dev_err(&phy->dev,
+				"failed to check slave PHY: %d\n", ret);
+	}
+	mutex_unlock(&priv->lock);
+
+	return ret;
+}
+
+static const struct phy_ops mixel_lvds_phy_ops = {
+	.init = mixel_lvds_phy_init,
+	.power_on = mixel_lvds_phy_power_on,
+	.power_off = mixel_lvds_phy_power_off,
+	.configure = mixel_lvds_phy_configure,
+	.validate = mixel_lvds_phy_validate,
+	.owner = THIS_MODULE,
+};
+
+static int mixel_lvds_phy_reset(struct device *dev)
+{
+	struct mixel_lvds_phy_priv *priv = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		dev_err(dev, "failed to get PM runtime: %d\n", ret);
+		return ret;
+	}
+
+	regmap_write(priv->regmap, PHY_CTRL, CTRL_RESET_VAL);
+
+	ret = pm_runtime_put(dev);
+	if (ret < 0)
+		dev_err(dev, "failed to put PM runtime: %d\n", ret);
+
+	return ret;
+}
+
+static struct phy *mixel_lvds_phy_xlate(struct device *dev,
+					struct of_phandle_args *args)
+{
+	struct mixel_lvds_phy_priv *priv = dev_get_drvdata(dev);
+	unsigned int phy_id;
+
+	if (args->args_count != 1) {
+		dev_err(dev,
+			"invalid argument number(%d) for 'phys' property\n",
+			args->args_count);
+		return ERR_PTR(-EINVAL);
+	}
+
+	phy_id = args->args[0];
+
+	if (phy_id >= PHY_NUM) {
+		dev_err(dev, "invalid PHY index(%d)\n", phy_id);
+		return ERR_PTR(-ENODEV);
+	}
+
+	return priv->phys[phy_id]->phy;
+}
+
+static int mixel_lvds_phy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct phy_provider *phy_provider;
+	struct mixel_lvds_phy_priv *priv;
+	struct mixel_lvds_phy *lvds_phy;
+	struct phy *phy;
+	int i;
+	int ret;
+
+	if (!dev->of_node)
+		return -ENODEV;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->regmap = syscon_node_to_regmap(dev->of_node->parent);
+	if (IS_ERR(priv->regmap)) {
+		ret = PTR_ERR(priv->regmap);
+		dev_err_probe(dev, ret, "failed to get regmap\n");
+		return ret;
+	}
+
+	priv->phy_ref_clk = devm_clk_get(dev, "phy_ref");
+	if (IS_ERR(priv->phy_ref_clk)) {
+		ret = PTR_ERR(priv->phy_ref_clk);
+		dev_err_probe(dev, ret, "failed to get PHY reference clock\n");
+		return ret;
+	}
+
+	mutex_init(&priv->lock);
+
+	dev_set_drvdata(dev, priv);
+
+	pm_runtime_enable(dev);
+
+	ret = mixel_lvds_phy_reset(dev);
+	if (ret) {
+		dev_err(dev, "failed to do POR reset: %d\n", ret);
+		return ret;
+	}
+
+	for (i = 0; i < PHY_NUM; i++) {
+		lvds_phy = devm_kzalloc(dev, sizeof(*lvds_phy), GFP_KERNEL);
+		if (!lvds_phy) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		phy = devm_phy_create(dev, NULL, &mixel_lvds_phy_ops);
+		if (IS_ERR(phy)) {
+			ret = PTR_ERR(phy);
+			dev_err(dev, "failed to create PHY for channel%d: %d\n",
+				i, ret);
+			goto err;
+		}
+
+		lvds_phy->phy = phy;
+		lvds_phy->id = i;
+		priv->phys[i] = lvds_phy;
+
+		phy_set_drvdata(phy, lvds_phy);
+	}
+
+	phy_provider = devm_of_phy_provider_register(dev, mixel_lvds_phy_xlate);
+	if (IS_ERR(phy_provider)) {
+		ret = PTR_ERR(phy_provider);
+		dev_err(dev, "failed to register PHY provider: %d\n", ret);
+		goto err;
+	}
+
+	return 0;
+err:
+	pm_runtime_disable(dev);
+
+	return ret;
+}
+
+static int mixel_lvds_phy_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+static int __maybe_unused mixel_lvds_phy_runtime_suspend(struct device *dev)
+{
+	struct mixel_lvds_phy_priv *priv = dev_get_drvdata(dev);
+
+	/* power down */
+	mutex_lock(&priv->lock);
+	regmap_write(priv->regmap, PHY_CTRL + REG_SET, PD);
+	mutex_unlock(&priv->lock);
+
+	dev_dbg(dev, "runtime suspended\n");
+
+	return 0;
+}
+
+static int __maybe_unused mixel_lvds_phy_runtime_resume(struct device *dev)
+{
+	struct mixel_lvds_phy_priv *priv = dev_get_drvdata(dev);
+
+	/* power up + control initialization */
+	mutex_lock(&priv->lock);
+	regmap_update_bits(priv->regmap, PHY_CTRL,
+			   CTRL_INIT_MASK | PD, CTRL_INIT_VAL);
+	mutex_unlock(&priv->lock);
+
+	dev_dbg(dev, "runtime resumed\n");
+
+	return 0;
+}
+
+static const struct dev_pm_ops mixel_lvds_phy_pm_ops = {
+	SET_RUNTIME_PM_OPS(mixel_lvds_phy_runtime_suspend,
+			   mixel_lvds_phy_runtime_resume, NULL)
+};
+
+static const struct of_device_id mixel_lvds_phy_of_match[] = {
+	{ .compatible = "fsl,imx8qm-lvds-phy" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mixel_lvds_phy_of_match);
+
+static struct platform_driver mixel_lvds_phy_driver = {
+	.probe	= mixel_lvds_phy_probe,
+	.remove	= mixel_lvds_phy_remove,
+	.driver = {
+		.pm = &mixel_lvds_phy_pm_ops,
+		.name = "mixel-lvds-phy",
+		.of_match_table	= mixel_lvds_phy_of_match,
+	}
+};
+module_platform_driver(mixel_lvds_phy_driver);
+
+MODULE_DESCRIPTION("Mixel LVDS PHY driver");
+MODULE_AUTHOR("Liu Ying <victor.liu@nxp.com>");
+MODULE_LICENSE("GPL");
-- 
2.25.1


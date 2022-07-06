Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CDE567CCB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 05:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbiGFDs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 23:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiGFDsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 23:48:33 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150071.outbound.protection.outlook.com [40.107.15.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7C4220F0;
        Tue,  5 Jul 2022 20:46:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkazIuQXsO+4H7TN5iQ7j0Ba3EF4vqdjzR9znEUh1uiT/t3i6Nd2Xdje5C+rawxIUyz7DnHwnETS6gsXidnVoOM8v7D7+Pj25RLe7UqOwNny5y0dVGn2653cWYJlTs4PY0w6ouR334xlN/sCF4Nr/iiMs8ugfmGKbcSuASyeTOsIFcvDNWVbIEaHyiEcapFekg1OK5o9H/A5aznTVhfqx+NwsIS2lml7nZ93dwx+GB5fRLlvUqU+2JfL7qqslSxXgxQUq1JlwvujDIETGPy0/6UYxqFoX0xC1xOdbTYY9YZyXbrWWGTbuPj/B/twaNZtPYEnCzlycXVZ64+OzQA93A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8pvstkYsmbeNZRvVYi7hrL8jaX+Qz8IwmWOTS9+GZY=;
 b=IcWWgJ1Gm2CteU0NoWjoqbWqTtqcxBLw+kQdBBuQB0PlRBNnl8KR5g/WFTLDy3RA2vAS2QOEh4vT/Lf0Cot7asIaDi7L6OQSXbkTins8nKVQBo2ngVln9+2iLNe+gEctiKJ/xZm+4O3JB5XgfzKIAOJb4IUyJoQuFMMJSPSDNI5xWITxHfLCiZik7Ynpq9BiUoicJb4oRy/r3yLI9TKsFzXgXre6JLgm/tvrpZWHPuda245n3qPI4KYrv2Bueu55TxjbIlbrmMpOUpZqBrVOh+FHdCWs8T0ktfL3UfXOGXWsH0FcU0nkzsjPNKAR4NVUAljcpn5WGZYfNqpIMzxUTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8pvstkYsmbeNZRvVYi7hrL8jaX+Qz8IwmWOTS9+GZY=;
 b=mx3oe+Yf0a0Zc2rT17F7fsAUjdyvvV6Bz3MvKOy6gxErCaF2akwlRqsjWXZhGlHyOTIfUSMpI9tRsrSlo+5tiXf6eRZsoMpfj95GAp5NJ8IxkKHmgZ6CuMSwwPacSF0S5vvAPQIKQJXPGxM1RYK8XxWbURgWt9FxiOYG7NhG2l8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by VE1PR04MB6463.eurprd04.prod.outlook.com (2603:10a6:803:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Wed, 6 Jul
 2022 03:46:46 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::416e:6e99:bac6:d3a9]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::416e:6e99:bac6:d3a9%5]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 03:46:46 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, krzysztof.kozlowski@linaro.org
Subject: [PATCH v4 3/3] phy: freescale: Add i.MX8qm Mixel LVDS PHY support
Date:   Wed,  6 Jul 2022 11:48:10 +0800
Message-Id: <20220706034810.2352641-4-victor.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706034810.2352641-1-victor.liu@nxp.com>
References: <20220706034810.2352641-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0045.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::14)
 To AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 469ad4aa-c9d9-4890-c4a2-08da5f022616
X-MS-TrafficTypeDiagnostic: VE1PR04MB6463:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rqaS95dFkOw5n2h5RaWukp/wbluY5Jj2+jSOxYk2Xgrq9Xq+TMJllFYP3kqOL0bQ7eHKCtEvQu0ivw+0Vu7iAE8dvz8kv8VkCcJzlj8zzdbKwPqxtm/hcvkrWY/buvQhyzDAQFHOcupaacOS61W7Ng5rY1Dfq40R2e6sh8VVRepT9zQ4Q6u4vhh5NJ73M2rkZxbO6JBAmu/J68MyWfwrINcUItXJaeKCAsqWvY2wtDmUfaqy26rMgwgPJHSjHrvS73nmHaOo09GScAYCeDB60xzlkiHWg1SErq0Bd+Ln+o9VmYt1jottUkdqieDz7CfV75UxJgKbkOcW+5Msp31FbPIKjNb6vps5u6wJl5YeKxvIl+1R/JTpHELpEbJKiinZsig/t3KlN4DvO6Ih6Tb2+sxulEAs67CtMeiwcr7FdHXh2BUQRNaohe1IwcpT7mszV7NhpI1DMzZ+KoDhFqUW9Bc4/iR6kUGF/2vkUAX3nF1MyXNyipK26jbtlGJsRt34Fp+evbRwJcnbaAHKyKixio/MOSsXQ7WTRlIHimk0RynXgDC0VPgly44fZP6WKZxRGCHMQJt9lxpt5Q1xJMl4PGBQtpxYskDcethYXrN266QWl6GMqD0qyXxtbwEvJUmpD+pxNykEiLwAaMAp3+ZATz7KeaX5NmyHvvRnzvK0Rv/1i7f+SUy0nfSHgVtrTwMC4k83Hm4i+1l9pvd1G++r1DwaY3Qxqel+HUsY1ERaaUy7h0f2hy4wY1BwqizfhYWjPaHC4Tx4Xgbbo5Jj4xAn9BxCGvMRGJLYlmvW8GYY8a69ooWkU94qXj7FSkV/ugQH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(1076003)(8936002)(6486002)(478600001)(86362001)(38100700002)(38350700002)(66946007)(4326008)(6512007)(8676002)(66476007)(30864003)(66556008)(5660300002)(2616005)(7416002)(26005)(186003)(52116002)(36756003)(316002)(2906002)(6506007)(41300700001)(83380400001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?evcmWqATT7dceLukTo13hn8p0vpQJ7lpVcyfRBHsT8CXziPd07XPt7s+s+7D?=
 =?us-ascii?Q?3uctOZWDED+DI/shX/YPQfV8SLZ6u7m2Eg1REnWIMe+JQLn3PIXI9yJyZGnG?=
 =?us-ascii?Q?mM8R5HUQsgquCENE+94MLRh7nCp5u9Iidz/YKJa3FUaFGbvoelpXeZ/9gZ+k?=
 =?us-ascii?Q?octDRjZgoBSxo+4DVRl+Xl+HIhUBJUYgFTtGGA6+Cg/HksEtswUL9MKrUtrm?=
 =?us-ascii?Q?WXQ4kKgLbCJ3XcPAnSKKi8Vg4ygXUOmgypkpeAbR0gAdFnJLtWcu8B2BAVlF?=
 =?us-ascii?Q?uBdBQNU41t6jziz5T/+VJcjsc4gBJXQY3pf8/KlD0ZpT6pLbkgv/V8WAhIj/?=
 =?us-ascii?Q?nV4Wmj2UkGPF4uxIkwWF1Hiv6Z4oBbnF9ck5vsAlE2d79hOcmxSfm9sbXZKk?=
 =?us-ascii?Q?lGN9cMsxRZqskXYnOxygkujaLrrX0l9V4gVd1T8EUO7w5JMBFPZUxKsi8DIq?=
 =?us-ascii?Q?Bm0WSCnuru3HFIOsri8hpmC/Ji+bTUi9ppoWtTh951gaxSkXELHUUlV02KWJ?=
 =?us-ascii?Q?RLvAhePnlPLFlK+jlo9SPuEHMXQyhg5LgYacviune0cBPXr03StOipdZHONY?=
 =?us-ascii?Q?BbMaZRV5c1FBBbXT/M2yVQtINyf/3/dk+9mrqe3jAyBTLswZBFzW2Ie9qyvx?=
 =?us-ascii?Q?S0ScgYvoNTZ15poIE2+/FBAt6FJlRrSJS8XcGQl3vPOF2dyIVXsDif0U+Hpm?=
 =?us-ascii?Q?KnX5sjSwCsBTn25bVjKVhX8Km5y2ACH6J1kOmZAC5h8P/nmegxCnl+79UQdA?=
 =?us-ascii?Q?d+hvPxuIUcafpLYyuw8gHobZ+oQkTHCmV7Xu4amhVE92818yLSNIG5CS/V0q?=
 =?us-ascii?Q?X6ouUvCpaUKwDpY/xF+wobIC/REAv6g8L/vd4I7Y8xa1eUYZA0ZteKOSu+3i?=
 =?us-ascii?Q?ilLAVyl42VJkS8E4gwSl/WJ5zWU+pyJViJMsifrHbMPMj1IdMULQc8vKTRSd?=
 =?us-ascii?Q?r04BKhsA/GNbiHhpgewyxavpmgfZREKNeYN5h/WmxI5DaiWskNBoT6Zra22n?=
 =?us-ascii?Q?ElnXzVtM3MRGrSh6OFAxt8Z2/eIWDDsa8pa1P5DFmCz3gKDB1RZxaRhWaLSH?=
 =?us-ascii?Q?bm7atFxt9PRuvOxhrYvC907Lk29kRVzBLi9nseXZH66Xqbyr9y1aWsiJDE5G?=
 =?us-ascii?Q?A3+Vd6gSdGbDyTL96Es3R5Dmrrg13bKHKxTJsZQQMy9IJkXsEm8Z46pEyDRm?=
 =?us-ascii?Q?uE39TTip6bb14NT3SC3R6wE1QAxqgdxUFx/zj/S+duDE/KQAsGllodQQmPLW?=
 =?us-ascii?Q?3AHBb9d7yFOxUBz+u9dP58bfbPwgp/70oXx4IGobWAjhG2TWaWOJ7/gXYv4h?=
 =?us-ascii?Q?OtokXlBQTbYn+R4LUpssMRfhI/lilhV//0XuIEJR0IGLSc2axDPRTSEQiT2d?=
 =?us-ascii?Q?5pIbMuE0hSfbVvhbBsjRNCZhczwLaZOQ1wScXh3Mn/WvTMqOPmDBqwCDWNln?=
 =?us-ascii?Q?bk6G2OH5G4b1h9ldmuiOYwFXAnFA90XGqpdmDsnvNM7bcJ6pYHkQITmbAScl?=
 =?us-ascii?Q?Gp/oDYuoS2NonMnKZpgT6L5G+F8kbz++jcby4T57PihDDSYNa1BU2TlPOh1P?=
 =?us-ascii?Q?19SiNZXXggHe868hNTioodTcz09JUiP/T7eEOpy3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 469ad4aa-c9d9-4890-c4a2-08da5f022616
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 03:46:46.1977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DlZy15FchEErN7Afp5KWHyWX8lRacHc1Aj0eFdEoY6I2vT0jJIFqWapt9VNFuBdLvwhUqo5Zp/1ZMBwWKMWRDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6463
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Freescale i.MX8qm LVDS PHY support.
The PHY IP is from Mixel, Inc.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v3->v4:
* Use MEGA macro. (Vinod)
* Check slave phy in ->power_off() and power off two phy synchronously
  when necessary. (Vinod)
* Use single line for error message. (Vinod)
* Use pm_runtime_resume_and_get() instead of pm_runtime_get_sync(). (Vinod)

v2->v3:
* No change.

v1->v2:
* Drop 'This patch' from commit message. (Krzysztof)
* Make dev_err_probe() function calls as one-liners. (Krzysztof)
* Drop unnecessary debug messages. (Krzysztof)
* Get phy_ref_clk without name specified due to 'clock-names' dropped from
  dt-binding.

 drivers/phy/freescale/Kconfig                 |   9 +
 drivers/phy/freescale/Makefile                |   1 +
 .../phy/freescale/phy-fsl-imx8qm-lvds-phy.c   | 450 ++++++++++++++++++
 3 files changed, 460 insertions(+)
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
index 000000000000..e514b64bfdab
--- /dev/null
+++ b/drivers/phy/freescale/phy-fsl-imx8qm-lvds-phy.c
@@ -0,0 +1,450 @@
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
+#include <linux/units.h>
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
+#define MIN_CLKIN_FREQ	(25 * MEGA)
+#define MAX_CLKIN_FREQ	(165 * MEGA)
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
+	/* The master PHY would power on the slave PHY. */
+	if (cfg->is_slave)
+		return 0;
+
+	ret = clk_prepare_enable(priv->phy_ref_clk);
+	if (ret < 0) {
+		dev_err(&phy->dev,
+			"failed to enable PHY reference clock: %d\n", ret);
+		return ret;
+	}
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
+	struct mixel_lvds_phy *companion = priv->phys[lvds_phy->id ^ 1];
+	struct phy_configure_opts_lvds *cfg = &lvds_phy->cfg;
+
+	/* The master PHY would power off the slave PHY. */
+	if (cfg->is_slave)
+		return 0;
+
+	mutex_lock(&priv->lock);
+	if (companion->cfg.is_slave)
+		regmap_write(priv->regmap, PHY_CTRL + REG_CLR,
+			     CH_EN(0) | CH_EN(1));
+	else
+		regmap_write(priv->regmap, PHY_CTRL + REG_CLR,
+			     CH_EN(lvds_phy->id));
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
+		dev_err(&phy->dev, "failed to set PHY reference clock rate(%lu): %d\n",
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
+			dev_err(&phy->dev, "failed to check slave PHY: %d\n", ret);
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
+	ret = pm_runtime_resume_and_get(dev);
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
+	if (IS_ERR(priv->regmap))
+		return dev_err_probe(dev, PTR_ERR(priv->regmap),
+				     "failed to get regmap\n");
+
+	priv->phy_ref_clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->phy_ref_clk))
+		return dev_err_probe(dev, PTR_ERR(priv->phy_ref_clk),
+				     "failed to get PHY reference clock\n");
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


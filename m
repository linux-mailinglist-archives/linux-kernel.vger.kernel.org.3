Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFE3551914
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 14:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242753AbiFTMho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 08:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242579AbiFTMhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 08:37:41 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2084.outbound.protection.outlook.com [40.107.22.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC13175BE;
        Mon, 20 Jun 2022 05:37:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVPWlBUtLHxj4So9+YY709ObMKP4d7/81dFpwuLb3S8IgUXd+6gY8J2UmxqR0BDjweWL+iMOf6RipYFBt/CN/lFUxEycPKu6v3iNihuvorvKuUUnEGyNbd8+mGdmIXqjc80WpvSuivPBGMIrkuZSb90oofGZd1/0bCcwulKoyXHo8IDbxMRYlH3RXKovUMDYS4D/ztOxraBKPULvhZ2fyOPvE4PfB3/pLIX5k4XO2x+sRcV583kDpKnS34AX7/UU3w0jn4ycf82nPb0lU309KN7JYbBT1KEeFJQuRVKWKW6SMJ3Y5hriTKgSU4qnX5bJN9pxlWlJgOoLgYuVwALZEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YOldlPREB8yae/CoX0VqwFYfCl+I7MwfoNDjCHUFMw=;
 b=P2LPiGhFKBHH8tfBkVT6A6L4gRD9YMNRU2tzgpfpdKfx2OrR52lkXkzUmUmiQZqFNmMcfN1OdCAI66lrp0NaPPYnlM9tyHo3xT1tQZPBQHl8teQjy+S3/7SRIi8MpFTQsSvT+M4GbmT03PfRZv6nO1qkkMMwiOXNy8nZ9159KbIlSgdLyDqLJrCWFiTrxBlaC3WYgi6jSLjmD1+dlixjp3MY0b2B31FfZ5UIWdx7XGRtSZl+gkyVnq1CckoZsYlyFroPdTaU5mXEGOP+tAGvp9PDvbLvpWQ8icacPn3xNd540BXEBsw6nrNGuqFg4x9/txCyN6rjuwZM+u1jtT9BDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YOldlPREB8yae/CoX0VqwFYfCl+I7MwfoNDjCHUFMw=;
 b=E8ooBB9hrWwdeXpCEIB0/YyZKY/ArqoeuYgJogOtWfdpRwXMLVYkL0rrKC/qTW2PDO8Q2IrYE+4CB/bhbLkLo/dn6x4LPeYUQhxyxkNqf6dW7mm0PsSt7MnojWFPW//uS0Bz/0I8QHDuka14LdYKYW88H3HYqV6n2vXGhdt7USY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AM8PR04MB7873.eurprd04.prod.outlook.com (2603:10a6:20b:247::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Mon, 20 Jun
 2022 12:37:37 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502%6]) with mapi id 15.20.5353.021; Mon, 20 Jun 2022
 12:37:37 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, krzysztof.kozlowski@linaro.org
Subject: [PATCH v3 3/3] phy: freescale: Add i.MX8qm Mixel LVDS PHY support
Date:   Mon, 20 Jun 2022 20:38:54 +0800
Message-Id: <20220620123854.1138028-4-victor.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620123854.1138028-1-victor.liu@nxp.com>
References: <20220620123854.1138028-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0219.apcprd06.prod.outlook.com
 (2603:1096:4:68::27) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c09a91a-5680-4cda-311f-08da52b9a81e
X-MS-TrafficTypeDiagnostic: AM8PR04MB7873:EE_
X-Microsoft-Antispam-PRVS: <AM8PR04MB7873277790E075D4B969905798B09@AM8PR04MB7873.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gU/hN/m/VLn2pMD2vvYkv3C/riag+rN6VY8LMiFQtKnkz7t1kuQzg9154iE9cj/dW+Z1INYOndn+fC4IXQNe2zRIX/Tz07VOUVJFSAFh2RbGi5cd0R1kOF/h37xZLr8fy54y8zChh9Sxa/IoRYThe4k3RnLIj/d2aVyA1Z0vc662X0En0R+5hT3AAxyGj6LFnebXuhuAGlJo6L+hD/XeTU4m9YuWHYUYQ3Em8gOL8iBNP6EblvMysIP1f/lhMJ+EHEJ4ZFy+7QKVTM7yPdw5bgICR9zC8CKWbyveXnWGyN/RkTBoStPvzhZk66vYFyOo6TOV80a0Oytc3grn8+9f/Vbg5OebLMVAlCT2sm13O4bTlfCiUVssX8JBFNU+FulUHF9dQGWVvaASbDr0Co3gyu8nOTYUSHR6OSVUDJtoVLLZjy8rMPYt9tNQ5MT8NK97xuIJc3uRcBytLGWvHPPoU57XQA/3PsrIQRqapAYC+RLRhVIH/dNF9xF0CUvoWBMihL/GtslChsE1jiEfQlKvybl6DUk/ConUseXVXUwVHUOc/Cu2FrvQDGFSyN/+5V9rtEorn8qgjY9Mn8vWZlSxSqd4RoMBQXfhHdJXBarinrOtgT6pEBdFsia7Wi++N57W7wZr7hhvCiv1NqC+ohwmcBdS3nEZOp8lhB7wNGZE9QScEaoMqfxvxpnLV43om3q+JhToiC8r3VOmiin5SkX9uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(66556008)(66946007)(36756003)(8676002)(4326008)(66476007)(6486002)(83380400001)(316002)(186003)(1076003)(478600001)(8936002)(2616005)(5660300002)(41300700001)(38100700002)(7416002)(6512007)(30864003)(26005)(38350700002)(52116002)(6666004)(6506007)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pcjAzLoMIm48SNMwYBwf4G5845U/XPx6SCrMEGymkidnh7Hw0pMF9nQWw0K+?=
 =?us-ascii?Q?NhdSlhcxqonL0U+JB4vo0NcgXDmizVBPdE87YvMHeGBA9OgR3aWI6FrBCxKw?=
 =?us-ascii?Q?cv2841r41wOpD7vpotsyNcF1urYFLOlzSGjDioAcxQajXTUCvFphL8t2HIJL?=
 =?us-ascii?Q?DR0iHSt+O5cJym+uftCf4vmNTM5s3Wsh/rGCze8odPwEoVTgOTFjzox783wC?=
 =?us-ascii?Q?8y1iRGvCyG/PQzaviDfTU4vw9OSIU2DokUnm5zvqnbGktSmMkcCtMX1WLSlv?=
 =?us-ascii?Q?EUmHcEmIi+vNqZf7d3AWROAqNnLi1PRPmSZjaGvhbJdF0Xv+YVZe33SNccCH?=
 =?us-ascii?Q?hDQEbdrPW4nl6JngaJTP+J9aKi92Fcwz8LQnWHIe/fZDA0iSbI1Ws8+PxaW1?=
 =?us-ascii?Q?m++Ar/GVJ4Gi8Mj36YOHqHqOUwmRNzybIq5/QylYwyK0+0U6bp/mAJLLdBP5?=
 =?us-ascii?Q?HAYLQiCnkYDad4c5snjfV05H2osxRVPzRe5LeEgZZE1Ce/DNznyUlhl8fZI+?=
 =?us-ascii?Q?EBIcuHZjCJ2Skgp0kzk22iDewztmG1WmqGqUCiepCJundpmraUCKRcYi8Bu3?=
 =?us-ascii?Q?mVJ8RQCFue8pInYQdZFYXybnnM2WDyJqYjlPk9SCClnjJ5hMgyi/GHIE6fLz?=
 =?us-ascii?Q?NtDI8drtV7detgnqDch5sadF0l5Utr1zbkLWYGE82I/up3sXMzj4htBp7gN+?=
 =?us-ascii?Q?EM6lNV6xonpjyt3BHowCDZndplbLy8sCOM84IjcfXmHGxdwUzoIUE6OuTgoQ?=
 =?us-ascii?Q?GZnaNidXMEgJGHcFcCFzMdmosFaTSKqAz3/aii1B6mCtFTcGIgUxWxdggzgp?=
 =?us-ascii?Q?D4sF2Ev5aS8sxiawc9f8G/NTSrSXwDxlv2oGoi+O11aa0EGiUl0sjq0c+eWE?=
 =?us-ascii?Q?1R6vlva9JJ8dxKHKMWkUmfjj2Yfy7CBTUA66ZlG/pWVFqlsRMHcgk2fA00/C?=
 =?us-ascii?Q?kH2cxpjd5evhfHFIxHgkVkN0lHtBBD5OhG6qTxImz/cnW5Vi5HRHTejCO6NM?=
 =?us-ascii?Q?qEUUavbYFA46cm9PCiS+HEfsQUmMumylUA3iUl+6oXqyx7QbbeTA0sBpgaWn?=
 =?us-ascii?Q?C9NW4Jk394QwW5Nby20pQF6hU/LZ1kxEuIvzK1CA+6sGoOX+ennJHTPypCfX?=
 =?us-ascii?Q?pBTv5K1xudqKPTToyMSrTXkhzNKVIZbucXTClkUsYsgV45pb1tyGMk75TluG?=
 =?us-ascii?Q?UQA7NwQOpoVZcKiAT8H0M9rhw+724uavmj47yqUFPJQ3eyWNgO46YsEInl7z?=
 =?us-ascii?Q?cYodhpxoq4VQUZxDzpXjbIKanhFTe9HZDZC9MsYm9t5DFRP2M+93Ui8dvOq/?=
 =?us-ascii?Q?ybXVa/egNIKaZ7jsXxDi6Lu2VlOrh8O7JGXciaxOSswFr4/HLnnIX5nWD+N6?=
 =?us-ascii?Q?opk6gUizZRE7wJk66mumqKFv7/xHG2PfY0ouyIK47C0AsW7X+uXZCwi4DsG1?=
 =?us-ascii?Q?gLCWkTmK8SASllWdEEDPerJdy05V2eXb2oJ4F+AoS9Sbupv9DwoxgUPavW8X?=
 =?us-ascii?Q?+KrUa7Q9SypB+0H2MqsubuYbTsguQIrGvMhg2tWUYLH2RWfvCGa7Z9n+yZtV?=
 =?us-ascii?Q?wodFOikyzXQUJk0CrOPla/jXP18MuHwWue7Jbyc86HMJuRkO1TCuGqci0q2L?=
 =?us-ascii?Q?uhg5VgzMpsMHJahvSRMKCONtrnGGxsnqSa2iZaEYPU2OqSzaPm3eOEPQt6Dx?=
 =?us-ascii?Q?Io84amGoMenlJOa0iyWM2x47RPVbmtMTZ5vnHWWvjjWTI9onRIhdl3wztRr1?=
 =?us-ascii?Q?YbqNkUoPQw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c09a91a-5680-4cda-311f-08da52b9a81e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 12:37:37.1824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dYtes46rW0ZZ2+hZ8ll8+b00pr1oGBPkQbOwHso40fcmyBmPffuAOcqrRMFFkf7ihu8Ns4t4j4hkxNzI3/XeDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7873
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
 .../phy/freescale/phy-fsl-imx8qm-lvds-phy.c   | 440 ++++++++++++++++++
 3 files changed, 450 insertions(+)
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
index 000000000000..37f77115ddab
--- /dev/null
+++ b/drivers/phy/freescale/phy-fsl-imx8qm-lvds-phy.c
@@ -0,0 +1,440 @@
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


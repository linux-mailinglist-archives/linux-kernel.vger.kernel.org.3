Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91634550F06
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 05:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238205AbiFTDok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 23:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238110AbiFTDod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 23:44:33 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060.outbound.protection.outlook.com [40.107.21.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8D7CE2D;
        Sun, 19 Jun 2022 20:44:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOyVw0fNGNPRvFonwtJAgzFWXb6njFqFSeiOoxKWdqTsvdh9H9YQrnQn/tM8oMcHOQPJ8OSRxmd/dvKDk9veLZga63L+YGUh2w1MV/eFm0TZRfTOzYGh5NvbXTAL3auVkhUw1+2pVs7O/7062+s1CfRMRVH5fWAFku3RjHfZkr8VcKQyj1boMYQ+HsrRBlkYNvdjA14azgRcUysmbpvf7IZnTYUzBJVVr4Q1mjRvIWYItqSN66/Vh0UwV+xrqcPBjyH/e+XsY9hiIFVab56F9v2dtOrzoG9LjJRCtNQThaQ5lbDtEnhn7IfN5jk+nTuvrI4XjVYMEAWTaid9CSHjWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMaXT+oEMTEebcqyKU8b7m1grHc4GKptpfoEXSX1aeA=;
 b=iZpd9eLeVJC2FsQU7dKMNpO++SLloZcPBDQ2FJ+TnaZT+oNqTPerC/2UOu5dqrxgM8UsiHNz9femQ7Vu+MJfyn5DGARKLFZ4JOMYGgNBVu3wlyuCNpf5akxH5YkZYw+GQKYf+Qew1yePkjNCIlgK0AIbzx1twEHmgqdNGTglklwtmJ/tJYI2LILBS/uAQJYURPA6sFaj/XMlmqh9LudRNEUSf4ZkfThjSo+riHCyFSWFZeQ+q4Dn8Gn3l2HrrHIHErOIVggGvrRfwYwBGOYE2smz0FFR6Hw+jUhdD+HkTR01pBk9JYKxJteAYUvHXg8/Kuh4iguYEaROzzQbg5wjMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMaXT+oEMTEebcqyKU8b7m1grHc4GKptpfoEXSX1aeA=;
 b=HVM8D50xx+YFm86UhUlMd3pIAmirv+F7q0bt8f6MqpBdSdlcKcijKWu2wvsJ2xm/A85sCZJHV0f2glhCckliajzepn2t2oLfzLq7dSwr7QKEAArL0ojbssNPBwrHX1pgDINnkesjmcysjkac4t208i4+62ty3pJww+lhqzusu0w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by PA4PR04MB7965.eurprd04.prod.outlook.com (2603:10a6:102:c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Mon, 20 Jun
 2022 03:44:24 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502%6]) with mapi id 15.20.5353.021; Mon, 20 Jun 2022
 03:44:24 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, krzysztof.kozlowski@linaro.org
Subject: [PATCH v2 3/3] phy: freescale: Add i.MX8qm Mixel LVDS PHY support
Date:   Mon, 20 Jun 2022 11:45:33 +0800
Message-Id: <20220620034533.4108170-4-victor.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620034533.4108170-1-victor.liu@nxp.com>
References: <20220620034533.4108170-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:196::7) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c86d968-feaa-49ae-2168-08da526f2adf
X-MS-TrafficTypeDiagnostic: PA4PR04MB7965:EE_
X-Microsoft-Antispam-PRVS: <PA4PR04MB79653FEA0F259EE424187CED98B09@PA4PR04MB7965.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1/56ioT3N2J//bHzkijOPnGgNKUI/RSSiMgACUKcgjO0B5pT5VcHRCrbCKsmhLBt5pECUcElgx4xL6J32Es8Qj2gd6Z6uMsbrnsengMNx6uhjSPtsgu1NPstJJgMrop1mGyegGu+b8S/SMtVBvT6mOIbIy4JX/KjuDnYcJfo0dwaJczg5VzXEjbLIuG+hwffcM7cIXyiGhKaHTZKjtQnP7g85aO+teNjBLoDIKsbif6eIKJXwe4ar4cDPtpoeytGkFCLVWEzINVMstzcSpEkIu3H5NjR8Vm4FWi9EA0e6wrWGtNWDTGiWOLTHO4xTpT19ALGrHgGNFgUqbQae/e6os0Kia+QvZr7DNXBNVBs63AAs5O+nxxeRia8FoF5QSt1dqRj9oMOR80hFBIWyZaRNZlOThHhNbMGdDrC9UZ45zTTBa2uc/Uvl5YFN9mzRvZUI2ZwVkCZ5bxy1IgypZDp6/F/LM+TkZGsbI6kZ+WhFXbq4gx6G+DPRtkTPlWLk8NRmktTzBWudDimUedl+Dr1nn42GeKpk4lP0oVeKcv06qnmDPB3FtyvJdVm4rO1TAfNmfSKyZXktQM714XmnyYdf9DqEs61hV2TDXK6oJXexMNYstHw2UJ+5VYSKS0/N+MzCZ5gIU1Ezj3ny0VEVqJX+63E1id+89izW6tmaRRSrDrCkvBDzxYDRSeJJmlwtlx8UeSC8RZoI9RbhmuN6ex+CQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(6506007)(66556008)(52116002)(7416002)(5660300002)(316002)(26005)(6512007)(30864003)(6666004)(66476007)(498600001)(86362001)(8936002)(8676002)(66946007)(6486002)(4326008)(2906002)(1076003)(2616005)(186003)(36756003)(38350700002)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kuvYXUA3s3qyp350XrivIGyGrU1vT3Lt0a8Mp6S798YTRKES2CrJEAs7sCOT?=
 =?us-ascii?Q?t4IhOLBOTv4ycWqoWs98FGx3RiUBw44ATlT61licptwP/1kiu3qU/RoIRp2i?=
 =?us-ascii?Q?CBs6yGq7JlEF39rp1yLqNjRIMJi3Af6UoOCOcIIRA5zo0Wvp2t7W80ZJfVk6?=
 =?us-ascii?Q?Fbu1pV7cRunYERUA87f2a7CFcXr0eNvNovGMYgx8TWRVR3+QAScCt1NYkyqz?=
 =?us-ascii?Q?mVITpQEcLO+86CxVkUTKRJDNus4lOp1QApjTi/+yfYl/fieJXg1oy/UzvhgX?=
 =?us-ascii?Q?m09s6NMV/IaRCtFGmVUyojGNrFx096lkDKofcW1nC/1yjH2wJ68gR1K84/GL?=
 =?us-ascii?Q?iRqb69/UhDTbUcL/bvxisPsp1QQNHCqZUu8ojXzR2wXEZ4zjXR/XJq8BIZfg?=
 =?us-ascii?Q?VIYEmlBkJN7/Pp506Fj2699gR1EKfWEfwE9U4KAa1hvNyAYDvdNoD5QULBfy?=
 =?us-ascii?Q?G2nz/iwCMj3iuCf1HXxTdw95gNTRLWjEWdzf59fjCVdycQ+rAc1dSdV6DpHZ?=
 =?us-ascii?Q?ExxQ9/WSktvQgbCDgz1roWhAn4iQwReEGy1uY7xZgoJurMBtB7jKg7ZsccnD?=
 =?us-ascii?Q?MBOeLka1gVoMlWMDw88RBaGvBS9/vsbv2l51v3lM1nya9zI4cBrX9qdmus2J?=
 =?us-ascii?Q?K7wghdiEbwLxkudnnBB+1Btn5CkVxQ2A4SWQ7BXCpB+OtZvTrK8+gcpRdWWT?=
 =?us-ascii?Q?o4h4aRMyxlCuv8JDgOxSKUcKlXGbq907W0s+x7k1YI3/gH6rkoicCzcgaKHE?=
 =?us-ascii?Q?8cWxzy/WBMUkj0GwnDnkzHoJphYtNuaWd860wfFn+881qv9ASFzOpNSSEVol?=
 =?us-ascii?Q?aA+Rf9nhZZs06DH36P9NZuyJZVUl4GxyIZXgvE/eidX0QZZJG3lscTnj1GrV?=
 =?us-ascii?Q?XUYmUlzLJmTeFzYt+8t0R1krHbmCBPGJeKjJ6eN17O6CaQM83f9uzBVDZCxW?=
 =?us-ascii?Q?6VKuN0tT27WgHKsgkLBiWVBIoAzxpJoJlEebPbmD4YqZMDe+Yz5ALQTAkxhP?=
 =?us-ascii?Q?RF10txQWGHP4gNLY6/s+c5jmDAjW03Mjwem/PTwh6ozMLm9ylaTdL2jERLeS?=
 =?us-ascii?Q?z2UPOvLYsM78mQXsSTJKdPmColHCBpAQFIAbExolv/C/5jNH1Neyna2ZZl+/?=
 =?us-ascii?Q?aM1XiDN5rfYSHp+fiaVFGXMEkhSJbhjdBmaffrOoriXI2swOmXkVrDSGzRLU?=
 =?us-ascii?Q?Ejqn7vheJTsahDRtHX6GR0/5Xn6Aybsdjv0mO7+Oi5+g+zXkNQXNV5Yb1ksr?=
 =?us-ascii?Q?eV7IdxkehAL5CzFNKD90Wf1nXxz/9yOW7qu9v/aUBSDRtOCMqMYl4ySFm6+B?=
 =?us-ascii?Q?d1J3P0jkv++spRmNE7zfJa1TuY7KBBWREErHMMWRxbbtjW4ZYxzy12Lo+ihH?=
 =?us-ascii?Q?KYb4RbsZTYkdC9UH48Inv8bOzPVsZuR8CQAjFSIKpIqYZ3MfX77gB924V7+s?=
 =?us-ascii?Q?4MdHzBR8DUNq+WVC7LKR0Nq38y1yYrqznpKs/foEEcXIZZA5TmXbzAx9B222?=
 =?us-ascii?Q?2QGbwrsK/WHR/mZBs7shN+GKZCLAwoatILPZsyWd8MZyRod2jCgPAG7j1ksI?=
 =?us-ascii?Q?aVqigQHr4ZO88U/eZXYu9/8Wfe44XIGnXytc7Uweaq33veTm59HkMVCKZneg?=
 =?us-ascii?Q?fC2IzpNYL1R6Sk7FOEzwT66nIRlnEUUqNYo9wKPtMYeejmxNJI4Rg48HP9MD?=
 =?us-ascii?Q?f4ScGNj9yDTIOCYzqf9wp0R/rwtc39O8quqGXmbK7WCjvxsNmPOnCpD9uriS?=
 =?us-ascii?Q?ZAfv9Nr/yg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c86d968-feaa-49ae-2168-08da526f2adf
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 03:44:24.2889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pvW9ssts5vNZr8ocYTsQxFt2KF2TDhm6Dj3l59Yi8vdvJ5ZSqzyeaqQ2CbaOzX9T4zNjsuDN+o4tWZsloYXwZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7965
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
v1->v2:
* Drop 'This patch' from commit message. (Krzysztof)
* Make dev_err_probe() function calls as one-liners. (Krzysztof)
* Drop unnecessary debug messages. (Krzysztof)

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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921AD5A685C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiH3Q0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiH3Q0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:26:06 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80059.outbound.protection.outlook.com [40.107.8.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CB6B24A2;
        Tue, 30 Aug 2022 09:26:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUyot+OEf0WGmPvKFkLPVKHY7qEvnVACDNwNf7Zh44hqy2mcE/iQdiqscSL+9YkN7f7Ln7uqZJopCFGizDPaTZWj0kLUXmkqOJ9ad4QXGg8SxEsYdGLb8B1F8vgoHEmfGfNL04DTGtByYQsHvOe/g24/B3BKuL6HqS0sMOF/Phxb3/ojByHIlgE5pQkYSciIeQDyB72xgtnNYQVo2kbLBXALb04lTRhQ7mpCUXHmC+LEqdttL5Axnf6Mh5Y+xFtczuDCWELMCj+EqNZqpStY1ip1sFuuzhU0Kp8DH+HcsHmD8cf9ARvBCZVeFC8KFgvZ8Fdipa2I4vYTzywNdyozkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jg9uhQ/ff3Xfs4xgRjPmerClNufYztUOGEUdYItZp9c=;
 b=UqeY+rY9KDH5BfAtEWXKwZWeo0AQZCR8xOpXoAQrsDvaa7rmIq+tFhQdpiZLlGn0/kCcXmqrluv7DfiPHNn+Bg99lYAzCAX5RxNWstS/sX73bNUBGI9OwZic5Pq4on0XeZ8NkeUblZzF5OWWcLjMLAifWGL2K1ly8zHaYq6ki9Nd48px6bsO9wo7enhNz7uQFFIow8gcJdwMlqg0f02UTLVSyXdndjiA7ePByzWfboAYErRetUDJMqgU7Ip3A5lUEm+SsBYNe9DrqD/l7oMZugGdxiFtgGvZ086bS/ANA0lZw36pYcgdYS9qBaEXDK6UFPEQf2mWB3DQlwFkldyW3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jg9uhQ/ff3Xfs4xgRjPmerClNufYztUOGEUdYItZp9c=;
 b=dpoxsGenuWOCkrfeySIRYVGHcspeG4HQtZtfMW6pM/tpfQEsAclNBBGjhnCSWwGaCjtpGwAYfVSTRNuuBtLO1CzlnxuoSURQRigipqwW5hznB1/LmJ9exyhOnb0vmXCEcdcdh8od96dYjAx3wQwf2VgxRLNIQ+FEyeuVxmuF5rc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM6PR04MB4086.eurprd04.prod.outlook.com (2603:10a6:209:50::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 16:25:58 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::85cb:614b:9f52:2dba]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::85cb:614b:9f52:2dba%5]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 16:25:58 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, imx@lists.linux.dev
Subject: [PATCH v1 1/1] usb: phy: mxs: apply board calibration value base on chip trim value
Date:   Tue, 30 Aug 2022 11:25:38 -0500
Message-Id: <20220830162538.2845274-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0149.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::34) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4735dc4-cc32-4fb4-c88d-08da8aa451ff
X-MS-TrafficTypeDiagnostic: AM6PR04MB4086:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 44bsFC8ElMDWiDMjmd3N5QnooxzceJHNIqW9mXt6h/JTV0XMqV0NUb0aaJfjmnjUVznL3tFAHii+Jd1bojv+CX1G4bGNf86korb5g/4r8hD8Np5gqAmaO+ow1erLqKujR2pRXqSpG7yAdFU2L3l4zgPh8N1UT6VvLgIR/j3ZCDDcjyVxfUEMW7GGBSd5y4Mt7gpkH9By3tY7zCjRrEgnE1DwlTg1RsitGAFuFIkCObmyDRaNWswPlEAMeDlZodIc3RX5NSLJB9adkFIFtpTtvh+dMHCyz220YuycGTkEj4ckzbOCwh9Am0iXVgoxPyJx5rhxmh6r2wYRWRJda8ccIZeTkjcuqVFwA/8P+V+jonsKwN5bmNPFtSjXc+yXTUvYPvGxO2WY70LSkxuOFAUOKrWJyqwO4ZO1oYo4LGhZFeG0r3bZ4V8bL+GEM/LG9QbLje9IowrxGFO/NQJjDBrflDkcugCMzzOXgFppMR8UHAoYBk4wcsxUwG30X92WraCRpfD9AWSyqU8YxFAsQycLJtx+zdYzlZtr8XMmhfJ+mtwfQPaOtphP5Q52jb7AlxY9x3NvkLwMjZ/1oCZTi04bnXGfRCtIddnc7cl/ei1RwAvC4cPkuWGqBYyxY9XwyKWnshSpqJIODfy1tqX4KxeN6+1itGcKAtULSqlWr3PbsScXT2ixn848Rjg/vUQ1Hrr0GESkIpUYLXP+Y/Ah7xD1Kp8SQvluvAM2lSwIqjc8A4TuZ7N8lIS0iSQJlPAtoemZnFuJ0mR4Qnn75/dndnymHTOyAjVOnkF+GA5GjoeCd37UndxjP9H0aRzoSRJL5vVbV1njpagruII8n1FA4Pf42Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(26005)(316002)(921005)(38350700002)(38100700002)(6512007)(7416002)(6666004)(5660300002)(41300700001)(86362001)(8936002)(478600001)(8676002)(6506007)(6486002)(66476007)(52116002)(66946007)(2616005)(66556008)(2906002)(186003)(1076003)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?34owG6iHoyYJwXIGLF/+vtm6QishqbomV6R1AIA5VleUMP2FJDXdqJLu9LEK?=
 =?us-ascii?Q?QoV2Nj1Huyw6KtXszOMcLQtjFDNdD3jBNoZ9ROL/AG8TEHjWyp4xVaIsSaCb?=
 =?us-ascii?Q?MT5vAZhA30zmTAMmIbwQMf+JeqKHcrL6GtCxwBsTGi6Ka1tZDD42849jy8Ft?=
 =?us-ascii?Q?57BEGRTt3K8Sp2s3WykO0cSnvmrSyVlDwNsTn4yAaDc7+V4rxmBj+qktvri+?=
 =?us-ascii?Q?Lr+S/eYBJ+zeGJ14F7EmUtFEB91rZJMoNCTXBnFfyTPbOLSjl0rxLTKfYsKt?=
 =?us-ascii?Q?ptaRdOywMBarKvdAcCHtaezI+x78v52cUPprAGrFK3j4CLVm1bZ6hFkJw6mv?=
 =?us-ascii?Q?0in6+Niv94S4lzdFyxId4LHWKlJcYh1nUM42FqFIsTfJWg2XwEU+rVsd/nR7?=
 =?us-ascii?Q?Gn1QzCoLHxaQaiVHaFs8S1HnJiHQBhaJmCB73VQFCSOKFE/5Wj7hRog9+QgM?=
 =?us-ascii?Q?MxIYvfMAQCSnZHc4y8cAXbzsRVbjkR5rc3PhKdd+Gl7HY5DLWSGP6GwRWYoq?=
 =?us-ascii?Q?h2TjDEATPo/9o6tCM5gxDzp8XO9I26sgGEvF4Nb+5xU4U/Pg5JrNyg8epuRl?=
 =?us-ascii?Q?UeqG0WSPubZQObLHDTgV3/U35uW6J4u7/MKQloezUOjbTvKm326Pd8CMD2g5?=
 =?us-ascii?Q?Vhru1x1ee+fWGHHSDQS799k8GJfsHSMT5+pjeXzi8a0iZXDjp3XXyB2aNRsw?=
 =?us-ascii?Q?MmT/bDXDdg9CnfMsUuSz/QsMOGR7LQlq6HHY81nDthDsCkuKoiOk5dpcPqyW?=
 =?us-ascii?Q?zizt1/Rjsnp7gUzvlisA6iWWPbF0d7KEtxA2YBeVc/Up1KqDlDE9newyeHiF?=
 =?us-ascii?Q?FxLZYmI+j60agalHRPLDupjYlIV0fUs5F/ntc3i/wJshpGmKcLEoYqn4fN0a?=
 =?us-ascii?Q?PARJ+eXldQv5nAtYh88fk4mFwz0R1QIyQ5Rhod1nSpMYbMLQWRzyrMqkaOrj?=
 =?us-ascii?Q?Gd7MRsG5wicHLLWW3W0xsbDIsZ6I12GF5Hqw2g10bMWHWqANl/ugqwiARcqW?=
 =?us-ascii?Q?wNdqGOFIqe/2spm8HA2Angl6mC4Mly4igKVVhxAL1IOjyIg4CgMY7zL4/F5m?=
 =?us-ascii?Q?FwU2o8f9HKFyMGsJORkHMFelMPzP11JVapiUmG+HhbJFjYkAq4prfHYZzSYM?=
 =?us-ascii?Q?VUhQYQ1ssM9CdVlRg1cwGwDU64Pwsxsygqay1ouN7ED4Ul1vNhEYB7u1kPNn?=
 =?us-ascii?Q?HrvOpp5FI5jDetKeFNiqk4zTDT/QSIka86msItb2uswj6XP/LqfOm2G5+NBC?=
 =?us-ascii?Q?SU04cSAtXZFy1wvpFOZlhg6EQ43ylLFeA2QnrohFyLmRCiKm39bwWy2pEA72?=
 =?us-ascii?Q?KKe4wmz7+Sojc+yCzXNQU0psyQXXClkm+uA+xyL8xj9xlm1IC8+Og9GNy82b?=
 =?us-ascii?Q?8wmPGjSgKqakfMDcshaFtYrfxuT4U1+qJ///LDb5isuJIdD3RPi04YZqv0o1?=
 =?us-ascii?Q?omQbkgbb3WEcO6zRyEoybfWRIoecM6H0jeShOpROYWVpsyAz6vKx4xzafZCV?=
 =?us-ascii?Q?20YnPII1TFf9tu+rfyPf2/ZjSab3T73jVoNquf7wDFmw3vPfjpX0pLrny/Z9?=
 =?us-ascii?Q?AiNZMQwLaMbggjKi2pILsTwFiD6hcwT7etqVp4kW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4735dc4-cc32-4fb4-c88d-08da8aa451ff
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 16:25:58.3989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rv/lZ7vmVanFXCyvZrF3ZyRfq4R+/xx02yBtK4jITR+KzNYFufZlaPtPR3QD+NokPfZw6klTqWP7em+IYDgUFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4086
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USBPHY_TRIM_OVERRIDE provide chip trim value. DTS provide board level
calibration data. Board level calibration data should be base on chip
trim value.

For example, TXCAL45DP board level hope add +2.85% register base on
standard 45ohm. But chip trim value is -5.25% to get 45ohm output.
Actually finial TXCAL45DP should be -5.25% + 2.85% = -2.4%.

If chip have not trim value at USBPHY_TRIM_OVERRIDE, No behavior change.
board level calibration will be applied.

If chip have trim value at USBPHY_TRIM_OVERRIDE and no DTS board level
data, chip trim value will be applied.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/usb/phy/phy-mxs-usb.c | 40 ++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
index f909741641ec3..e11b2b9c18a1e 100644
--- a/drivers/usb/phy/phy-mxs-usb.c
+++ b/drivers/usb/phy/phy-mxs-usb.c
@@ -38,6 +38,12 @@
 #define HW_USBPHY_IP_SET			0x94
 #define HW_USBPHY_IP_CLR			0x98
 
+#define HW_USBPHY_TRIM_OVERRIDE			0x130
+#define GM_USBPHY_TRIM_TXCAL45DP(x)		(((x) >> 28) & 0xF)
+#define GM_USBPHY_TRIM_TXCAL45DN(x)		(((x) >> 24) & 0xF)
+#define GM_USBPHY_TRIM_TX_D_CAL(x)		(((x) >> 20) & 0xF)
+#define GM_USBPHY_TRIM_DEFAULT			0x7
+
 #define GM_USBPHY_TX_TXCAL45DP(x)            (((x) & 0xf) << 16)
 #define GM_USBPHY_TX_TXCAL45DN(x)            (((x) & 0xf) << 8)
 #define GM_USBPHY_TX_D_CAL(x)                (((x) & 0xf) << 0)
@@ -993,6 +999,19 @@ static enum usb_charger_type mxs_phy_dcd_flow(struct usb_phy *phy)
 	return chgr_type;
 }
 
+static int mxs_phy_trim_offset(int val, int trim)
+{
+	if (trim == 0)
+		return val;
+
+	val = val + trim - GM_USBPHY_TRIM_DEFAULT;
+
+	val = max(val, 0);
+	val = min(val, 0xf);
+
+	return val;
+}
+
 static int mxs_phy_probe(struct platform_device *pdev)
 {
 	void __iomem *base;
@@ -1001,6 +1020,7 @@ static int mxs_phy_probe(struct platform_device *pdev)
 	int ret;
 	struct device_node *np = pdev->dev.of_node;
 	u32 val;
+	u32 trim;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
@@ -1038,26 +1058,38 @@ static int mxs_phy_probe(struct platform_device *pdev)
 		}
 	}
 
+	trim = readl(base + HW_USBPHY_TRIM_OVERRIDE);
+	trim &= GENMASK(31, 20);
+	val = 45;
+	ret = of_property_read_u32(np, "fsl,tx-cal-45-dn-ohms", &val);
 	/* Precompute which bits of the TX register are to be updated, if any */
-	if (!of_property_read_u32(np, "fsl,tx-cal-45-dn-ohms", &val) &&
+	if ((!ret || trim) &&
 	    val >= MXS_PHY_TX_CAL45_MIN && val <= MXS_PHY_TX_CAL45_MAX) {
 		/* Scale to a 4-bit value */
 		val = (MXS_PHY_TX_CAL45_MAX - val) * 0xF
 			/ (MXS_PHY_TX_CAL45_MAX - MXS_PHY_TX_CAL45_MIN);
+
+		val = mxs_phy_trim_offset(val, GM_USBPHY_TRIM_TXCAL45DN(trim));
 		mxs_phy->tx_reg_mask |= GM_USBPHY_TX_TXCAL45DN(~0);
 		mxs_phy->tx_reg_set  |= GM_USBPHY_TX_TXCAL45DN(val);
 	}
 
-	if (!of_property_read_u32(np, "fsl,tx-cal-45-dp-ohms", &val) &&
+	val = 45;
+	ret = of_property_read_u32(np, "fsl,tx-cal-45-dp-ohms", &val);
+	if ((!ret || trim) &&
 	    val >= MXS_PHY_TX_CAL45_MIN && val <= MXS_PHY_TX_CAL45_MAX) {
 		/* Scale to a 4-bit value. */
 		val = (MXS_PHY_TX_CAL45_MAX - val) * 0xF
 			/ (MXS_PHY_TX_CAL45_MAX - MXS_PHY_TX_CAL45_MIN);
+
+		val = mxs_phy_trim_offset(val, GM_USBPHY_TRIM_TXCAL45DP(trim));
 		mxs_phy->tx_reg_mask |= GM_USBPHY_TX_TXCAL45DP(~0);
 		mxs_phy->tx_reg_set  |= GM_USBPHY_TX_TXCAL45DP(val);
 	}
 
-	if (!of_property_read_u32(np, "fsl,tx-d-cal", &val) &&
+	val = 100;
+	ret = of_property_read_u32(np, "fsl,tx-d-cal", &val);
+	if ((!ret || trim) &&
 	    val >= MXS_PHY_TX_D_CAL_MIN && val <= MXS_PHY_TX_D_CAL_MAX) {
 		/* Scale to a 4-bit value.  Round up the values and heavily
 		 * weight the rounding by adding 2/3 of the denominator.
@@ -1065,6 +1097,8 @@ static int mxs_phy_probe(struct platform_device *pdev)
 		val = ((MXS_PHY_TX_D_CAL_MAX - val) * 0xF
 			+ (MXS_PHY_TX_D_CAL_MAX - MXS_PHY_TX_D_CAL_MIN) * 2/3)
 			/ (MXS_PHY_TX_D_CAL_MAX - MXS_PHY_TX_D_CAL_MIN);
+
+		val = mxs_phy_trim_offset(val, GM_USBPHY_TRIM_TX_D_CAL(trim));
 		mxs_phy->tx_reg_mask |= GM_USBPHY_TX_D_CAL(~0);
 		mxs_phy->tx_reg_set  |= GM_USBPHY_TX_D_CAL(val);
 	}
-- 
2.35.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEDA54C951
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353873AbiFOM7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352413AbiFOM6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:58:43 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130075.outbound.protection.outlook.com [40.107.13.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1192342A3C;
        Wed, 15 Jun 2022 05:58:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IX9AXs1vnRLAOEaDSlLDwqTLE80tdXkoETQq06foWIbGdZtaZg+WGGmUmgjkQ0OBIVcyxNPtxkQJy1GQFvS4z5IX5DPSH6T0Wrkgdj4qiCVJ0Iz4R14HUiFnRNyvC5x6yqsE0RGdUG1Lg2VtDgLzC3OjtDpf2Fulp1GO0Qv9jAHLi3hY/YjuXRDRTlrSDWH0NLeCN98LhjliL3Bfey0BHSnLtIQeU3NFKH6sVMEfdi5msh6F1GAuaF05Y/4Ecvkgu8e6A/0o2aSlX2tqsg0pSIqanTCt7Z19UD7qEstAK7LZQcZaGi3RJ8GHd4WXg80IfYmfXf6Y57TDMPXTFDav7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwWfdN3ju35/NhPciXjKPFWZhIXvmDQ0cKrn8POWCbM=;
 b=OHYjUqxMR3moCEqPm3/zLJYYEwPmBZhhC0+Rk4RUPH88uSbhTSEQ8SIlwAFMzbtN7YRk8Ki/dslrhAVybwtvbOf/fXF97S/1Kfm1HlNM4p5Dnxsy7r72riXSthoj2qekhtdk/Akm3TYCmPhv8PMJmZdtB/4OdrnXobexKYpPErTWwhuRZV4m0OboTD0waudGK1okGMvIC/7ry6F5EmSRzL8nLrtN42bzHLhpfoFhuw/9Zptc/5VwmYUgZKUVmfo1LQmL+gQwj2RMn4ofcAFhXxmjOkBlj6m9hJQ9zqLNzjDNP1ajoaosIK3+Rc0pwQN1Hl1vXMBEw9TCy0FHE/jxSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwWfdN3ju35/NhPciXjKPFWZhIXvmDQ0cKrn8POWCbM=;
 b=keaZ5TRfLNHz+dSfZEnQ6DPY3EAoTp0Q9w0YBoDYbL/Couqv06JFA1lUFKVzRUK5cW+qxAp6A87D7xWwowIwon7UH653BDcHI4s1kDBY1vXOxlgozwJOTTAL8KhAgEHdO9g9djDhZSOLfAaVnoySSOqV6FXeW5+5YaSLt0081U8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7004.eurprd04.prod.outlook.com (2603:10a6:10:11c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Wed, 15 Jun
 2022 12:58:39 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5353.014; Wed, 15 Jun 2022
 12:58:39 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/2] mailbox: imx: support RST channel
Date:   Wed, 15 Jun 2022 21:00:09 +0800
Message-Id: <20220615130009.1457986-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615130009.1457986-1-peng.fan@oss.nxp.com>
References: <20220615130009.1457986-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0013.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::9) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f613d92b-bc4e-4884-35df-08da4ecec42a
X-MS-TrafficTypeDiagnostic: DB8PR04MB7004:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB700496061C6CF6BFB9F92FAFC9AD9@DB8PR04MB7004.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OZZraky+5HtpSQMYtMZ2XRxaWaTumU5qqopJtuFpkJTckSA1wn2CrWNf7pbaybki4hjNCFVxiI8dIeejA6qyL6jpeQ87Sb+FhNYKQHVTROLFPSPm+ygyoJZ5urrGJdlltZ322iB7wd7Am66i6wJYpRejJOZet4wMVaer9wuWZQbZfnTfs0l0Aqaw0amJloOmPZ2WdMcmz9FSMgJZfDlsPHEJ+yPm3PQUHs/vgdVpoMhpQQMXoBGnTtoFPvIG0d3WmaWAToDnv5zLx0GU9hLZF/SQlN0GmjIms61tOHVsOAkhWgF9sADR29OYASK4fXw3LuR4qi8CfcQksSiXRfEdJDJ2YG2YXswLXpje8GF9s3OmbUi6ngL0XqES0kNpDYpoB8gzHfG6dgvHYTu1VkURFIpet3ORUJTlIF9ubeL8JwgnPBGVbRMQy64Dq7tyuOqF1rnHIC6HtYks64AFimr1Rr9RaifFyJagHLE57vcICO24T8F/W77p2y8ygAEkxBSu1MwTqG0LzyEU2Gyiv5+5cBN6pR1IIGIMedboxLtDytZnYldm1a3hiuiW0lp068XFcENtzOB9VOyGc+zYlYOWNnqcUrxiZDP82+7DRAd2ZBNvYy1d0M2rCWYFEd5dev/5BiVIpFzKHQVF60a2H/XzvWf1tyFlnX28IJACetFlhl/YA7NcpXAtymiqICVPzN75+A/58ihw22YNwISm5Aeirg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(7416002)(15650500001)(2906002)(186003)(83380400001)(316002)(508600001)(6666004)(6486002)(1076003)(2616005)(66946007)(8676002)(66476007)(6506007)(4326008)(52116002)(6512007)(26005)(5660300002)(86362001)(66556008)(38100700002)(8936002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l4J2t+jD5NjzEJDyoPkQzIHFwSp1aoVh8Byqu8O7fo10zL/KF4dslPrkh8z2?=
 =?us-ascii?Q?1FU5KTBC1mYyh3I64izkw0ZaAOLVEmN2xpGVDwMjhgQ01jZG+/5eYzFcI5DW?=
 =?us-ascii?Q?HUku8xLIi/iHlYUmVaOtTcfJdQws3Y5AJnH5syJSTBTL7H3MUQ8fBS7Xffjq?=
 =?us-ascii?Q?mlfwZvvHYFQ3+g3uZlyRmstkDODZNBw8QzgO1dBUk+KsnLm0qR7pfzmBgb3l?=
 =?us-ascii?Q?bER3ibHqOzv+/WbX0nHlZmv+kZTQsqmSo+YeIn4rOh82W/aXrgb3Pv7x+E/m?=
 =?us-ascii?Q?AUbZ6qBR55GPJUNDY+LSIKPl8MMuk74JEDtKyEAI75XY+X+18M8HaiCVtzVg?=
 =?us-ascii?Q?vgbASW4DbIJwBElDrZlYCNB/BysWGB71cvL/rkRLSTpK4Bok4+Zm0mK7TJG7?=
 =?us-ascii?Q?/HMPaopLWUROKOq8MfHJzYA8u3PAVgL8mpdgpmgyDPjOEuLqpHQhuSnkpRjb?=
 =?us-ascii?Q?u+3mAGObBUeX1+k+SjegZNrGY6PS+msu81q6s3rlxNfbacJnQUHCJI1lk9X3?=
 =?us-ascii?Q?uLgPS6MgaxKOmFRjAWMxGrgQ+6UDp3zApboYyKQT+z3FTn8mHBN7GF6IF/jL?=
 =?us-ascii?Q?TYPR6jsETzjpDo7sp/uSapYxvZLYTRst9zdBcosu4EsH5rGQ2zV0O6C2+gF3?=
 =?us-ascii?Q?hwyg/rJAQ4Fwx8KYnclT6S4uXVneEdbGOjM9csW0+yH+MNxvU/7OrtqAAy0V?=
 =?us-ascii?Q?zaPa8sJtctOEpAU8pwhEAVI9nAqVrAruPxqVFebWMkTff7YFn3/G3E7/BC+4?=
 =?us-ascii?Q?iZpb2ZpvbCHrmhBulRYlx6B+datYESsAcCiPEVOMo4yd/ocqLh9JlqEOwIfZ?=
 =?us-ascii?Q?hPIcQ3dY/QSoF1tKtjXVwAMEjcEFR8GQtLa3eR2DppgdCILfPnOkI8xkHMQm?=
 =?us-ascii?Q?FysQTVJDpRzvjgUfeExoPcTQnmr57W+oCqGmkLFVFUIejyhQQ9Y9MepBs/YG?=
 =?us-ascii?Q?jqVptNENNrgNntQ0VjCeReES0dt5Zpe7NC2qVIYcNTeYORtUZ3jokZavK5jR?=
 =?us-ascii?Q?SFU5ahtogKBo72k6C+2QzcmVWg5oXyRMdARBVH07H76DHxE0GcKl9U7kv26k?=
 =?us-ascii?Q?42/TkFsU4T8hyx6U5mRk05eac/KlMzDwab2t+hhA68XoCLEDoMGtI1UIou2o?=
 =?us-ascii?Q?pmTEWCZWXlQONdX09D2ct9/4PY9uyz+oPgzA8ZfUd++S98DNTisSqZNv9Sfi?=
 =?us-ascii?Q?lIDORuuWjKbmgBAcKTlNsANKkuy3HYMbeMAN0lfPkMzw2Ig0fdfST9j52lYN?=
 =?us-ascii?Q?KWqS+uAGJ7ZPuXasNdpNUUjELd3MMBS2bJipkPMHO9VhVPvk+ZtfrCMgergu?=
 =?us-ascii?Q?0a+W3PcWYrI7XiGeIrOGzfDVlWawlqWT0K9rbocwAZc6sIgV7WwMorhH3K+8?=
 =?us-ascii?Q?w5VoifytUwzySh1S5LK4yFZfjBaLLxG8905IAO16fXnMs8xPRP9aRtanUyXI?=
 =?us-ascii?Q?j0vE8kcwVXAhi7sRh5dTAK8BK7h4HQ/PhLl0sCj8ACCLdSb8hoe+7w5kFuDr?=
 =?us-ascii?Q?oYlwXeE8NJCLu8nfhaukHO2xzZzwv6nqSR6WGRVRff72tRY2d36FvZc/P7oI?=
 =?us-ascii?Q?oASWBDojfHzLgEvOixA6i/Wt4t+g0tC8x1uuJQsUl+MLvf90uLGB2PXiL/bn?=
 =?us-ascii?Q?gNpZpZ2EJy8PjSk2eaD1XY9XgVc6TTjLiTCbHV5/7OPyFtQjFTBBr51XvKMM?=
 =?us-ascii?Q?EfKOAJVXVhcWqu3159N64gnhBWBtrKmZVfPw89bVH01T/P4/2JirwnleUfUu?=
 =?us-ascii?Q?DoQ5f7Yspw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f613d92b-bc4e-4884-35df-08da4ecec42a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 12:58:38.9707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UW4YKuGzo7evKcr1Hau3bFWZWO6MSPNFBITqKbAwbcueRfLxGXwpg38M2B67as1/2z3/siJb8gBXsLZs/9MgMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7004
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX generic MU supports MU-A/B reset feature.

When stop/start remotecore, MU is not reset. So when Linux stop
remotecore, the MU-B side BCR may contain valid configuration,
because MU-B is not reset. So when linux start Mcore
again and notify Mcore, Mcore is not ready to handle MU interrupt
and cause issues. So need reset MU when stop Mcore.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index b10239d6ef93..37fc765783f8 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -19,7 +19,7 @@
 #include <linux/suspend.h>
 #include <linux/slab.h>
 
-#define IMX_MU_CHANS		16
+#define IMX_MU_CHANS		17
 /* TX0/RX0/RXDB[0-3] */
 #define IMX_MU_SCU_CHANS	6
 /* TX0/RX0 */
@@ -35,9 +35,11 @@ enum imx_mu_chan_type {
 	IMX_MU_TYPE_RX		= 1, /* Rx */
 	IMX_MU_TYPE_TXDB	= 2, /* Tx doorbell */
 	IMX_MU_TYPE_RXDB	= 3, /* Rx doorbell */
+	IMX_MU_TYPE_RST		= 4, /* Reset */
 };
 
 enum imx_mu_xcr {
+	IMX_MU_CR,
 	IMX_MU_GIER,
 	IMX_MU_GCR,
 	IMX_MU_TCR,
@@ -50,6 +52,7 @@ enum imx_mu_xsr {
 	IMX_MU_GSR,
 	IMX_MU_TSR,
 	IMX_MU_RSR,
+	IMX_MU_xSR_MAX,
 };
 
 struct imx_sc_rpc_msg_max {
@@ -85,7 +88,7 @@ struct imx_mu_priv {
 	int			irq[IMX_MU_CHANS];
 	bool			suspend;
 
-	u32 xcr[4];
+	u32 xcr[IMX_MU_xCR_MAX];
 
 	bool			side_b;
 };
@@ -105,8 +108,8 @@ struct imx_mu_dcfg {
 	enum imx_mu_type type;
 	u32	xTR;		/* Transmit Register0 */
 	u32	xRR;		/* Receive Register0 */
-	u32	xSR[4];		/* Status Registers */
-	u32	xCR[4];		/* Control Registers */
+	u32	xSR[IMX_MU_xSR_MAX];	/* Status Registers */
+	u32	xCR[IMX_MU_xCR_MAX];	/* Control Registers */
 };
 
 #define IMX_MU_xSR_GIPn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(28 + (3 - (x))))
@@ -121,6 +124,9 @@ struct imx_mu_dcfg {
 #define IMX_MU_xCR_TIEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(20 + (3 - (x))))
 /* General Purpose Interrupt Request */
 #define IMX_MU_xCR_GIRn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(16 + (3 - (x))))
+/* MU reset */
+#define IMX_MU_xCR_RST(type)	(type & IMX_MU_V2 ? BIT(0) : BIT(5))
+#define IMX_MU_xSR_RST(type)	(type & IMX_MU_V2 ? BIT(0) : BIT(7))
 
 
 static struct imx_mu_priv *to_imx_mu_priv(struct mbox_controller *mbox)
@@ -497,6 +503,8 @@ static irqreturn_t imx_mu_isr(int irq, void *p)
 		val &= IMX_MU_xSR_GIPn(priv->dcfg->type, cp->idx) &
 			(ctrl & IMX_MU_xCR_GIEn(priv->dcfg->type, cp->idx));
 		break;
+	case IMX_MU_TYPE_RST:
+		return IRQ_NONE;
 	default:
 		dev_warn_ratelimited(priv->dev, "Unhandled channel type %d\n",
 				     cp->type);
@@ -581,6 +589,8 @@ static void imx_mu_shutdown(struct mbox_chan *chan)
 {
 	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
 	struct imx_mu_con_priv *cp = chan->con_priv;
+	int ret;
+	u32 sr;
 
 	if (cp->type == IMX_MU_TYPE_TXDB) {
 		tasklet_kill(&cp->txdb_tasklet);
@@ -598,6 +608,13 @@ static void imx_mu_shutdown(struct mbox_chan *chan)
 	case IMX_MU_TYPE_RXDB:
 		imx_mu_xcr_rmw(priv, IMX_MU_GIER, 0, IMX_MU_xCR_GIEn(priv->dcfg->type, cp->idx));
 		break;
+	case IMX_MU_TYPE_RST:
+		imx_mu_xcr_rmw(priv, IMX_MU_CR, IMX_MU_xCR_RST(priv->dcfg->type), 0);
+		ret = readl_poll_timeout(priv->base + priv->dcfg->xSR[IMX_MU_SR], sr,
+					 !(sr & IMX_MU_xSR_RST(priv->dcfg->type)), 1, 5);
+		if (ret)
+			dev_warn(priv->dev, "RST channel timeout\n");
+		break;
 	default:
 		break;
 	}
@@ -865,7 +882,7 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx6sx = {
 	.xTR	= 0x0,
 	.xRR	= 0x10,
 	.xSR	= {0x20, 0x20, 0x20, 0x20},
-	.xCR	= {0x24, 0x24, 0x24, 0x24},
+	.xCR	= {0x24, 0x24, 0x24, 0x24, 0x24},
 };
 
 static const struct imx_mu_dcfg imx_mu_cfg_imx7ulp = {
@@ -888,7 +905,7 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp = {
 	.xTR	= 0x200,
 	.xRR	= 0x280,
 	.xSR	= {0xC, 0x118, 0x124, 0x12C},
-	.xCR	= {0x110, 0x114, 0x120, 0x128},
+	.xCR	= {0x8, 0x110, 0x114, 0x120, 0x128},
 };
 
 static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp_s4 = {
-- 
2.25.1


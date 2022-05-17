Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC711529AEB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbiEQHfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241555AbiEQHe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:34:59 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2082.outbound.protection.outlook.com [40.107.20.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF5048E55;
        Tue, 17 May 2022 00:33:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7fhAhPw5Le1c1eXwVOVy/XNH39lAE9l6MV0JW78PDPX7U1SoXr/Mb/mz72kBCFkPl8Lp1T8Tj/Co2u+hItDCXw/8op+E9nX193IAnqURa9M1wLgiPDQOJObZIMD/WGYHO0Fh5P8U0n949URQi7YIaxqzHIQuC1PN54jRoHiu8xVJhbTw7BOiCiN377UhVaT+mq726DnEBEDMQriiZxNbfDkpgXIuZGQR6hlWWIyFsYC7YKkB+LnxoiwR8ozm6rz4ZFDc1O609O6qyCR0NEl/Pl0sCDj/r1VqNeekXKdlboOCidplLrvqwNN432QAmdcZn4/yAeJffQoGd+rq74p+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcP+SMcmjA1eJIBzocu5WezxaepUxNvNPfi5xIZbcAI=;
 b=j1s8zvNKCU6yttXhg4mgsdPzluKW+qRszIGPbZuzqay1QCj20mpUcJPr4Kb8uUvmS5lZpQbFMso9zFUeDIzOGqb8Pw8ZT3ksvcCVAognrxgTWqOA0ZUpLZUbVVnci+ClLI9OLQq6UWJu2WAr2V92V0PLoGvbW3Ex/fdpHhjpiX8qfMD84yLJ4+7CPdliPQbGVfbgLIWI2/Y9HCb7a91gXyb+MwUHOtO9F2ajJU4MytZiZbm935H0hbPIsF014MUQv86105CzRhSUvL6GlCKUc33dvyjzU0rPsPD5kZWbYKsSoklByMa7svIYsFgf2z88+s5fNWv72V0XsjucFgDDdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcP+SMcmjA1eJIBzocu5WezxaepUxNvNPfi5xIZbcAI=;
 b=kx6mpGtJt66RgchvmJZvqnUhFDEFBVOYeQoWn1349/aU2oD4V4tUSS/+1A5lxXXXmTEdHapPD5HDGcnmymJcW5RLrPX5DPxjHr+CMUhRA1Uaef+xjz/9Im+rrlWA15uDRJb3Ne1b3WPJ4hZSshXpJwKHHsssMmvQFBlpbUYs/W0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB4375.eurprd04.prod.outlook.com (2603:10a6:20b:20::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 07:33:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5250.014; Tue, 17 May 2022
 07:33:41 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] mailbox: imx: support RST channel
Date:   Tue, 17 May 2022 15:35:18 +0800
Message-Id: <20220517073518.34474-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220517073518.34474-1-peng.fan@oss.nxp.com>
References: <20220517073518.34474-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7984a3fd-31a3-4c71-c23d-08da37d790bc
X-MS-TrafficTypeDiagnostic: AM6PR04MB4375:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB43759CC0A9528F9C32E8D74EC9CE9@AM6PR04MB4375.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e9s/3J/v/anAisy07R18Dg030fwHWnuh5GvYJyVSC2v0FR8xJ/1r0IpifZLDYDwrFohsygOiW5C1MYpEXpIkHPUGRTIsNTZwPpfmtq0eRetajhZh1lwLKAD9nlheN80nQZFBlwTYtRBsFwkpR++9n9+R4X1ZTTC4gHxHq2YXsGfykPcRRvsvHLpjtnZr+G9LZzJ9nTRb4irjPOXjvYJl09hgOAGJSijR17Lwk01KAek+yhvZOXJFoQsgTGluszHvgw6f7RyFCC5cWQPF/96S/0DBFFHdL+XPHPA67qrBrBvoFhvvYU/4yevWZUHUVKx9+yh7RSU7ObWKNpZGsoLVgp1KZ6tXGbwq1f+b/XzySvx8ldpkzoWbvhC+NDMQ+wEU0iFRmMSrq8cPx5zrqdtmAL1p5nzU1dGLuBaZwfYt/mQvhxdskSR6gkhJzCdyvcGY2FqZn2lFcU8g6kIz4f05zzLu54heli9zofE3K2KUjybQHnYGGK47FMtEMz6lSRk66wtLo+GZEn6FP9GqqYfGNap0r61TNeGmDGvPKeaB+qyYQLYW9fUwKCstFDGahl0wPzBw2O3hACaiVTuzBV8+uHvt7VSx7grxrQAh1Ms2V9RqOE6zpkY+dpksPAR4AfrPkJovRGOn36M5rFbunJZlvTLyyI2Asre5qmuejCTjDDHoChWhRFF74tPIQmFsAormIq0GcAECIytQ4iBuNA54Nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(8676002)(4326008)(66556008)(66476007)(2616005)(6666004)(15650500001)(316002)(38100700002)(38350700002)(86362001)(83380400001)(8936002)(5660300002)(186003)(6506007)(26005)(6512007)(6486002)(2906002)(52116002)(508600001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y7pefkjaTqDsMASLWZB8VMVc3UbONh24KbCOEts3PISaHu4aCQ+kSd+di3pv?=
 =?us-ascii?Q?UhJaLfgJClP8ZGGhvSvpy0ypHvK9zDeGtmQ7O3lbk35gm0Abo/RFUk6z+I2Z?=
 =?us-ascii?Q?twRafA0JrF2VvRVBFL6wOpCo6XIJ3mOOwqb1gBKHThFc/uwVdoDfxzBDNIgf?=
 =?us-ascii?Q?KTJc22ojz7rqxDSFzhdU+nUpZ0BYiDUEd9GQFtKAzdaTf7YUdFPDcoCE7OcZ?=
 =?us-ascii?Q?/GFASgdu6M/ee7apfq6ZJKf3pKgkgnznXBlPNgCmyUfjBK8iTh91Vs8TOOP1?=
 =?us-ascii?Q?JYAwD7RpJZLrKRrST6miLPsAlevaQRXNuEZb6l2TxEPfWTxDcLOpd0O8n78p?=
 =?us-ascii?Q?56FQkWSgDSn6Kk3nIn3m6ayCdE9IhMmnM0Z2sEaRZQZ/gbcScUOa+CWAMeAA?=
 =?us-ascii?Q?5Wf0+TxXfIVJS1ELRDewMfq18Ayoa8wkcqdUnGBvAybl+xse2DPZ3CpdfvZQ?=
 =?us-ascii?Q?ANCrnU9WuUpsb971WaUzHoqj9girt7DMVlQ0A9UG6rhWl+x33PgBl/CslhNS?=
 =?us-ascii?Q?Sfz6/oxiZdV+KFgpdGbrpEB9dO9a7/sygNamL7EID21HbGvg2YRWcgUU/e+1?=
 =?us-ascii?Q?wrErIsfQ9DTMydhOkRMuHJb6qsQ27SQxfXR6fK0dohEM+jqFA8wn8Z2hpjVD?=
 =?us-ascii?Q?KWTxobXPCpxTskc1MTvfgvtE8oCRrEDcn0YGuZrwzhVGPTl8oJBCwP4yvVVz?=
 =?us-ascii?Q?csUAzULgrXBeGjwLFyaL9UirQ9Aj2xE39PLE+ropMit6lcemZ4oRWRrYQnih?=
 =?us-ascii?Q?guOSSJKyLbe7JANC3pUcmTLDNZXDo8f3B1O2VpyLZdoeEbkDGssUP24f2cWy?=
 =?us-ascii?Q?5mW2EI9kVDA69PtLRrY8xQKB0osuvk266d2YjsY6liiZjdA9eoolSx7Tuy+g?=
 =?us-ascii?Q?f071c6k8XGSQwKCRKFPJzZ6Ssi1JJXuniBHBfB/J7S9DHAqVCBo6peEfn/SG?=
 =?us-ascii?Q?S3M97ny0mwbuetp5gEmj2UOglK7JSf3kx0J622TlrDmCmzf7f6tvjLFPf39q?=
 =?us-ascii?Q?EsxCWvRRK9hgMsW5yH+7J5HFXrJnOVUpVQtP4xHrTTzz85D0t9hX0dmZBDpG?=
 =?us-ascii?Q?WRzxaYHwtPtxPl2cRaMiAN7r8+z8cnkmXybRYVjE5rSd1eDzLmsXzy32AVCw?=
 =?us-ascii?Q?nX3nu0iyjQKfIJWribcKXTjfiEVEUBS2nmmKzU7pA6QOQ7PxhyBjg09E9VSv?=
 =?us-ascii?Q?X2Jw1VG+pN8CkgrbOiOtnYl4GiD2lTbhAbQxY5/i1bVL6eYSx0KpYupu4Y+i?=
 =?us-ascii?Q?yKz5froiLDCbS7MNJ1i1Zhuyxa0/k//8gKa93gJZp14a/6l25RFp9djD0Ghx?=
 =?us-ascii?Q?RoEobABhJGXH+OBYJMOSD8JnWCY/KFaka0jLPlqDjhvFfwxkD2lA3dZ8tRCu?=
 =?us-ascii?Q?HRTv06zeo6P4ws8jLae1dCSvxxGn/HYVkrv9B93RXF1sFHij1S4899bckDD9?=
 =?us-ascii?Q?o7CZkDVLMWT0qLmaxJy8E1jn1c5uY6lAa7EmJngr6NLtl7yb6WFPhvE897J+?=
 =?us-ascii?Q?k369ofxiNAIKqoUDBIR7Jj5CUQpdhWNfymggTEc7Sh/k8dfbgRLRpukcHBd2?=
 =?us-ascii?Q?RrOZQzIQ3iAJzg0sb5uDAqWaU7/aQ4JgwP5Twmg4t6QhPYAbMkAjkDzn0s6z?=
 =?us-ascii?Q?V+9p93lIIi0bJMRaJ+6f7WMIkC/2K4SQJy6zlPWq9um/rAzr20Gy9yXlELwm?=
 =?us-ascii?Q?gHSlR7zrL13WIfPUftswhj7nAFTMfaZWYP5WaDCFoKhyEI25z47vnAs9Oc06?=
 =?us-ascii?Q?rYumKr5Nbg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7984a3fd-31a3-4c71-c23d-08da37d790bc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 07:33:41.3539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QK05WhexDrLhvkIYnoFrTT0JfmHRWRBiEwECkDbfVpC/SGk1nOCwi4xg6eMszjov3NkkApDbK7rKgU22yS1R/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4375
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
index e88f544a1548..ce05ddc8402c 100644
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
@@ -867,7 +884,7 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx6sx = {
 	.xTR	= 0x0,
 	.xRR	= 0x10,
 	.xSR	= {0x20, 0x20, 0x20, 0x20},
-	.xCR	= {0x24, 0x24, 0x24, 0x24},
+	.xCR	= {0x24, 0x24, 0x24, 0x24, 0x24},
 };
 
 static const struct imx_mu_dcfg imx_mu_cfg_imx7ulp = {
@@ -891,7 +908,7 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp = {
 	.xTR	= 0x200,
 	.xRR	= 0x280,
 	.xSR	= {0xC, 0x118, 0x124, 0x12C},
-	.xCR	= {0x110, 0x114, 0x120, 0x128},
+	.xCR	= {0x8, 0x110, 0x114, 0x120, 0x128},
 };
 
 static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp_s4 = {
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081B54AB33E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 02:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348502AbiBGByC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 20:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348528AbiBGBx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 20:53:58 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130088.outbound.protection.outlook.com [40.107.13.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BC9C0401C7;
        Sun,  6 Feb 2022 17:53:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRdLO+10Lcg4VbDVjNwHzxETlhjwZmlN/7379V0Q6sIHh8lNeKkPxWxgVyac1ynwjvWK1l+XGMzhrwe4LGLPP+s5nhFdMuBqhOQ0cpfqR6NjshvgIhaBBdbgv8JGhTvkKep3UCOC3FEBeOniXsjspXc6T4Vf0Pz+QMOxdJjqQOBTea9cFm9taOMNNJfJ3qMtuMJQPZxPRkpMxdafJY2wgQABTX8MfX3KWagYZvdMD12InpKGDKASodwv1zwcGq672Wk118p0gfjDNHL+3H0IFa48aynG2KK7zLKBLZwbIO0k1pIPIt2T341gQKy/TQPM8t26UHDI7TeO3vkY5qYpCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epRTnvLZv6luqrscflz5l4WxjNfOVfooGjuIuM4az9M=;
 b=XtFSCb6tQ2NI9xofVkOsI4tvE5fjVQaizIwzcHazD2EYWpZ1mHmYAKI2Zy+OlqH6/C8oQhS78VocaUx63n6jNyeEGMCtpxs3z7kBT4cg7faLWKWn/Cuyc8+TQymbNpBF0DBE4h8ch2ghTrUXR4MXPN3pgCdjCpwvSZQNltD7zfXcfnGVrR8yqHoZSCsDgCS9njjHUSo2JjLVzXYGGA35dbuQQb+naVxLa54LjnNiE0F6bzm/K9ef9+CUUJ1Ey6wTtF2b4Qfx12jdvS2QKlZeM1fQgzuyVpV/ahTs+kNwM06QohDFkcXPJcDxwqyr9N/T8Pty+ixCRAkbyRRc5aDU7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epRTnvLZv6luqrscflz5l4WxjNfOVfooGjuIuM4az9M=;
 b=Yo7IhJj8BF1sG0AB6NjMi6AtYSzFfpwtdM4ftrdFMWVx8Rgs/CUFqT4yKJCHU1T3Eh/rC+zzi3BOEXvN9h4IJyif7z0SZArT8SH0QGogu98SCrEl3GB9GqXIzSvZoDU/Bst3pP7A+zSkpFLeB6PF6qmnTOvBSNejXcImi/ZeDAI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR0401MB2493.eurprd04.prod.outlook.com (2603:10a6:800:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 7 Feb
 2022 01:53:47 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 01:53:47 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 5/6] mailbox: imx: introduce rxdb callback
Date:   Mon,  7 Feb 2022 09:52:10 +0800
Message-Id: <20220207015211.394297-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220207015211.394297-1-peng.fan@oss.nxp.com>
References: <20220207015211.394297-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0152.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::32) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95785d6d-2a37-44f5-07cf-08d9e9dcade3
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2493:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2493087006D7A2A0A06997EFC92C9@VI1PR0401MB2493.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J2eCG27bRcS4jEHcD+s0+vAceyk2LI2cnik1nd6BRSi1z2p5UfoL2jjGn8iYc4fj2YDUK4I6hKgXA+WSVGeOTS/zUzmdCXCGF3sOrCvR4etBNBRZA3fS4pw6MVK3Slq0IQXgffDGFdkAZIUDXkuJctx04JtJNAdEULVGw5xtz7JWcoIqvzR2AUesz5wiaWDe96O1bAYVxLmXnADO3vgd0T7LO+aQV08wpZAp4gMoVvIhLurfrDmr4H4ha4GYupwgm3fWkT7knjYDMNqHP7srl0V2I52rkC21bEV0LFBGVfGSQgscQMzfGfr6vD0EKFvCPoie++7AvbAkIFhk5zJWjTU+t4LDOG5dQpf7FHRH0c2lMAkpHqb0CbEjbAZGqGRaqy320mFBRwicUO46cmmogJ+/NQWM+FubAu+wVDpe6OPRdLAU7Dh0yEqxoVTpmP5lFRRhrb1RoBOAQRxlwkkR0Qz+ALxU9IfiA2VfhPMXOed82QeeG0viA6a1xSRTWSY/6nvHAvX8PKybO7jc3aGm7uEHyJdVPz3Yt30Q1xJ9WMB3XKNEMVafD/2B9HbYMGgeH0+iz6SD4eG0GEJsHs1kuLzlHEgFYp8XOOZolLY4URFMLDyRRLIfDExBIFZHA4a72VZC0faSXeMQmxpC6M71FYRBd93H6aENSKXFppYYPe5DT53NUbsQHa1ZosFVGz6RBvwvRbM/FqHq6Sq+ZW9DVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(52116002)(1076003)(6512007)(6506007)(6666004)(8676002)(8936002)(66946007)(508600001)(2616005)(66556008)(66476007)(26005)(186003)(38350700002)(38100700002)(2906002)(316002)(6486002)(5660300002)(15650500001)(86362001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aXKtVtVz6xL5eT7DcKpg2VwpmLbrGXWm8wDkTTBYpX7lE4y4aWnj9f2P4NKl?=
 =?us-ascii?Q?xihfSrYarFNyEKeExAHlhrn3nRZb3ubiKdNwpnpxMIMfz/AGRennfGZI/vwH?=
 =?us-ascii?Q?62zVKwuop2npLv1ZyV0Vad+66jr2ZCDKjCRlMKZj4H15fJM3xi38hkar/LLx?=
 =?us-ascii?Q?ceIC0jpMHS/Zj1aa/3bEApjzkGQ90PcshaE6jZnW5k3rckLOVMIe1AJZZAK3?=
 =?us-ascii?Q?rceAzLr+XbMfz4SpxIu0JL0QZIEjQmLEmDvXleUbQDksTD9M81vIMUB2rOs/?=
 =?us-ascii?Q?KlUEb/7TE1Vp2Mb4LYiYMonlB6ArzF2hizUW1yUkT2FXZ1yoLF6+A90sFhzg?=
 =?us-ascii?Q?xXpm+YOSLMeEOD5/eJz+RXfEvZGT/9qqkdvtsGRyEnH9Yp0p/bJYlTyaiPfe?=
 =?us-ascii?Q?50+j3rv8QC/vRwJLJXragRRx/0y6eW+SjKCW7ODd+G40P51FA744VZ5eJfPw?=
 =?us-ascii?Q?h0QYIXoppuRL5bChi59cvbGzvDNw7+aWt7qotlHnlB33AOGudfmbPGCZJq1A?=
 =?us-ascii?Q?jVqrz8iXYp8WA61EPlZ19SThzN6fTD5dyRmP/BaZZkeKCx/0AN+n3Oip4K4C?=
 =?us-ascii?Q?Wo9dWBsQZsh0d3ucefKK/aUdgGiB8KDPNP1iMRakAsQAG8AqInj0Z5bjnGjS?=
 =?us-ascii?Q?u1z74X0i2XnH7SvMgrMutoxqyLrJKeVDUGd//5hnkQ31tGh1nSFNoyfaeq5x?=
 =?us-ascii?Q?PjtgJF0hr0qB55MsJzRbuA30qBF/6XYPdqpQhZFi+ESlepBNRhcPmWkjpXsP?=
 =?us-ascii?Q?zzJefS6/L60uxBR445ql6F6SwuN9ZWqjZTTZnzXjanlVFPbAYexxMOEp02Jw?=
 =?us-ascii?Q?04D+gmG/ZHxKHzy9wSlMwxVbVhpSgrvwWkqGWGlOl1V6N6P/xL8kpoCTHU3i?=
 =?us-ascii?Q?eyCcU8vdmREq/idom44Ttc+joQhWZmbWHtu/ebxaMJlTsllafw/zPTuq9vNO?=
 =?us-ascii?Q?ZH45DqcOICEcZuRGLVjw816pe7XxjdTBFqDXctu04rw8gsBbC6pV1oWqmv+U?=
 =?us-ascii?Q?ViIUXim4v/ih+sJ8h6N3fX4qlEzajnbODJxRKFZZFjMGimZFKYpdAkMOKbu9?=
 =?us-ascii?Q?TcdxAuyuC8tpNm7iqMm069RlH+Sy7NWFqtjk/PJ8tnWCwAM/1i9vF/PVsSDR?=
 =?us-ascii?Q?PxRbxQZegAv3aTyUvnPbqZNGVSKEYu87O+vRYy1EkW5aH8Ti108JEeUBbwEU?=
 =?us-ascii?Q?cSbR2+xrG+fdIMh9h1zJ+g5SEElE8jqzYVlVv1dyW6rbfjXLM29Gn++vzuad?=
 =?us-ascii?Q?sZtqHKt2TtKulIlXCNxo41QNff0YChmVN7D3Pm2iDCcKYYd3PvWP5v2vY9R8?=
 =?us-ascii?Q?74+q/+9SIm0KsXSYgTwBvCA6R7/ei3+08ayTg1gKRkPqkV4GIKjBc2gZQCIk?=
 =?us-ascii?Q?U/pGB8lDi86Y88CIbq7MCbfQDsXY/P7OnHLmV/5R+/hXvduiThGkTGExDD6d?=
 =?us-ascii?Q?Zp33GjotPVfyvcOLSvS5bc1Bds6mrF+8pC74yGDcAxizXiWfMTtCDEo6Il4F?=
 =?us-ascii?Q?jV04Mn1q+yQVfOoIk3+b+QUuBLBgAPfLVHsGSE4wJHRfVOHvPb5ZX0BjN15u?=
 =?us-ascii?Q?jqcwqrefJECYGeMTrOOcUNXKBRhiFXJb5rwK57qnteiC4ncjitGTtRAQWHAl?=
 =?us-ascii?Q?FcaQx0ilfWtJ9mKNKTkXJLQ=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95785d6d-2a37-44f5-07cf-08d9e9dcade3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 01:53:47.0945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x9B+aUFXHWU2eI9OXvgw4mMGN3SHTUwM4WqR+44PieUvxVfRMsHkNYAi0wUhrRQp4YGjfGRc9qvvNGwN0v6Pag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2493
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add a rxdb callback to prepare for i.MX8 SECO MU rxdb which has a
different logic.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index a29f8006ad0d..399e12671bad 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -93,6 +93,7 @@ enum imx_mu_type {
 struct imx_mu_dcfg {
 	int (*tx)(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp, void *data);
 	int (*rx)(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp);
+	int (*rxdb)(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp);
 	void (*init)(struct imx_mu_priv *priv);
 	enum imx_mu_type type;
 	u32	xTR;		/* Transmit Register0 */
@@ -179,6 +180,16 @@ static int imx_mu_generic_rx(struct imx_mu_priv *priv,
 	return 0;
 }
 
+static int imx_mu_generic_rxdb(struct imx_mu_priv *priv,
+			       struct imx_mu_con_priv *cp)
+{
+	imx_mu_write(priv, IMX_MU_xSR_GIPn(priv->dcfg->type, cp->idx),
+		     priv->dcfg->xSR[IMX_MU_GSR]);
+	mbox_chan_received_data(cp->chan, NULL);
+
+	return 0;
+}
+
 static int imx_mu_specific_tx(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp, void *data)
 {
 	u32 *arg = data;
@@ -329,9 +340,7 @@ static irqreturn_t imx_mu_isr(int irq, void *p)
 		priv->dcfg->rx(priv, cp);
 	} else if ((val == IMX_MU_xSR_GIPn(priv->dcfg->type, cp->idx)) &&
 		   (cp->type == IMX_MU_TYPE_RXDB)) {
-		imx_mu_write(priv, IMX_MU_xSR_GIPn(priv->dcfg->type, cp->idx),
-			     priv->dcfg->xSR[IMX_MU_GSR]);
-		mbox_chan_received_data(chan, NULL);
+		priv->dcfg->rxdb(priv, cp);
 	} else {
 		dev_warn_ratelimited(priv->dev, "Not handled interrupt\n");
 		return IRQ_NONE;
@@ -639,6 +648,7 @@ static int imx_mu_remove(struct platform_device *pdev)
 static const struct imx_mu_dcfg imx_mu_cfg_imx6sx = {
 	.tx	= imx_mu_generic_tx,
 	.rx	= imx_mu_generic_rx,
+	.rxdb	= imx_mu_generic_rxdb,
 	.init	= imx_mu_init_generic,
 	.xTR	= 0x0,
 	.xRR	= 0x10,
@@ -649,6 +659,7 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx6sx = {
 static const struct imx_mu_dcfg imx_mu_cfg_imx7ulp = {
 	.tx	= imx_mu_generic_tx,
 	.rx	= imx_mu_generic_rx,
+	.rxdb	= imx_mu_generic_rxdb,
 	.init	= imx_mu_init_generic,
 	.xTR	= 0x20,
 	.xRR	= 0x40,
@@ -659,7 +670,9 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx7ulp = {
 static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp = {
 	.tx	= imx_mu_generic_tx,
 	.rx	= imx_mu_generic_rx,
+	.rxdb	= imx_mu_generic_rxdb,
 	.init	= imx_mu_init_generic,
+	.rxdb	= imx_mu_generic_rxdb,
 	.type	= IMX_MU_V2,
 	.xTR	= 0x200,
 	.xRR	= 0x280,
@@ -682,6 +695,7 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8_scu = {
 	.tx	= imx_mu_specific_tx,
 	.rx	= imx_mu_specific_rx,
 	.init	= imx_mu_init_specific,
+	.rxdb	= imx_mu_generic_rxdb,
 	.xTR	= 0x0,
 	.xRR	= 0x10,
 	.xSR	= {0x20, 0x20, 0x20, 0x20},
-- 
2.25.1


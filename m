Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D684AB853
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353506AbiBGKJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 05:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352085AbiBGJ7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:59:44 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2073.outbound.protection.outlook.com [40.107.21.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C80C043181;
        Mon,  7 Feb 2022 01:59:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUgterBFl26HHWgCwltJnI0E1GIlzxCS4X9roqUNB+K0TaHE2EJQqGLcEwtyTf38tu/E/CnMwVUo4BPoBBeIuNSKxfXAgmUujeLmUeolPmYpo6a6evcjGQ4E4F7FV6Lob+7u/4cPvmGIKEqBqw++xa9zAsnZGAaS0YWAPgLMBuuuQzFqyPpTgl5f8COEo14Y+VHY/MfOfDJZ2oZH1my/Z6RtT34HJhAbMt7LTSPDpX6aj/CP+DkjPhPDIhQ6lcypAfh2iJnGdCx0MWvAnSSiIklVHG/kJR6VjzqsAyp6JVlS+BnmUiQ2vJ8cA+V0CU97HwlJucI4qpsDbD/4Q7rb/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZtf9Owg9LxNvE8WKDK7XB09ITrhJeKKpGMP1v2oZXg=;
 b=L9w5oNO9goseqWEyv2Tlwy5iYgPF60m7Kw2hVEzmpAzTqStUpaOTgLIvg8GeWKILEqkWd3X9FZKqAVDvq5gYKUti3eq8l9lW+9yzR6bowH3zkNnxFC5IR8ubfJpXZL4WczAoUEJCSHFr223Q4cMrCsGMAhD48IzaMp71TnySA7kbpx2PDeu60duCOaN/I6E+uQm17QZXcahOcgB2SYbq8e6WXczb859ugrPKVJyWz0mLTW2tDi85eLItpWJZRnVHccakk2cYb5nGXtJ7ib3IvJVKrHnBYOmsWcb9AVG6SiadeTL0p9/TY6wesjzGDU4Avh41UrS6jDOzLQHh5OHPHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZtf9Owg9LxNvE8WKDK7XB09ITrhJeKKpGMP1v2oZXg=;
 b=dPXX+TOvcpRtAmZ2t4JvJVjAsh1F2JhdRiQJzd6Znj5Ee11YwmFF4xXYllMT4mNOv4FHxp9go0tziJM70lkZItzyECOY4yKJVZelgmNGpvtICznCFqwGbAVNvnYqNT24OxWMU8VHLrzvKIrAZzCYK9BOzArw53zQ6BD1GoOCo9k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB5163.eurprd04.prod.outlook.com (2603:10a6:10:21::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 7 Feb
 2022 09:59:40 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 09:59:40 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4/5] mailbox: imx: support i.MX93 S401 MU
Date:   Mon,  7 Feb 2022 17:58:31 +0800
Message-Id: <20220207095832.1590225-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220207095832.1590225-1-peng.fan@oss.nxp.com>
References: <20220207095832.1590225-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0090.apcprd03.prod.outlook.com
 (2603:1096:4:7c::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17a28efd-32a6-4c79-d065-08d9ea208eaa
X-MS-TrafficTypeDiagnostic: DB7PR04MB5163:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB5163DA21F27CB2B573CA0F50C92C9@DB7PR04MB5163.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rHWMZfXdkhFhqysEEBctVVCprm3DiQjrq6EN9va9qo3lfflZ/UaCk37Q+/tZ9L8u/VO3O6Oh0qb+/kFUkK9LMTybw5YsUZbSMsjzFHfm20DxwFf7Xm217jIsrNvwvt37ScVIE0ToOo6ktx3j/qGAbq03E5qz6jEQN6KICTysW0nsDdY8i8OdLuOt/iYxM6QWBFSrY1RqM++DQVVb+HDS8gLKo49orp5gwxdJX4I0cL1KAWDwNHaGEWeQWdCCuDOx7oUj1WM5UxCct9NuZUds2g8PGJJOgTXHkeVp0pFqHkWoyuZIw7jHeQr3XnOWDjJve/066+2EZJtSdACfoxIzkWusz2uOuwTsfNUX56tjUc9Iw9PBDjyzkAFLSb+H/hoWOv5iX9Smx9JIn37+Ja/TJ5Ed03EAQOs6FCCkhr18fWsuTW7JiM2LaEBpzjaLnyPfQZiyS1ZI5/XPE1taqKdPrQ21lxxpVQTobqo53jmLmpqJJynd/LO4stNPLxKtd8bcwYsGTzDBTkvwAJMVQhqms7D6oIIvTXl30V3P5gODYiiirNeIBWZhMETXtvvgh6h9Zc8b4fKmv9PCYTUCiBwEheRpZU9xfE022SVSmO7foBge6MOsVWrPS7On+3+HRfrVjJLF406tEbmT5xehSAPSpAqoXvqwdXsnMOVAnjY9Zy5D58fTGY5DYby69kAtD7ikjoAA1mbWusdk4+CawR9JJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(66476007)(38100700002)(38350700002)(8936002)(8676002)(66556008)(66946007)(316002)(4326008)(83380400001)(2906002)(15650500001)(6486002)(5660300002)(508600001)(6506007)(2616005)(6666004)(6512007)(1076003)(26005)(186003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LP9qqwwKleQufZB5B2eLif1/w/kjEoLH8muSGX5SeykKvWWHTZZY9nmMpIqI?=
 =?us-ascii?Q?MtPvdPpKF4tY2iUiN2AzPO0VgCgB2KnegjNg5nIS+JcGihNV++RX9R8Z6cGM?=
 =?us-ascii?Q?5LOHMBPjI6KyIkOOC3LZUWjOYnusGOw0wgnYmj56PZgz9YHpfzfKt4MI+QuN?=
 =?us-ascii?Q?OwRgusHqteo9FDehfXUGt1+JQBLmiUbo4FS6Ro5Vxpm0YqEapXdH7MIXv/Iq?=
 =?us-ascii?Q?XZbkJ/CKUvRLfaRJ3H6bNoQ1PF7gpBR5T3fRCX4jimErfkCDmsGtf/PT4Nfb?=
 =?us-ascii?Q?lJh8NmhY3hNlVfDk3JzM/7nUdCvSryR5m3LkLqglKS2qSXx4h51ki1B07W3E?=
 =?us-ascii?Q?ie/VbMH/gWELMvqVJjbFDtSzUYxu3zx04F0gDHhL9dDTW8K84l/74Kzcznlr?=
 =?us-ascii?Q?WOCHp/KTqjGYRynyKoDTjBBmZqxiMY2Qm4BtXQMaWvjgYRBcQ22vJenZIZ1L?=
 =?us-ascii?Q?SLRiJgtRW/bXGyX2ff6CqYKkad6SaMLZYApri615mMPd0UzhybPNAB2wo852?=
 =?us-ascii?Q?/BmSU7hF3eJzdmrkSeTSbuRzY1AGGxvcb53JXJp8vaZ2+wa9+38r/GFVD/g2?=
 =?us-ascii?Q?htXaXMJ05rQVe9WXrm5pGWEY1yDzw5gylNoNXkiIFaqHKEv4uV/0MqP/ivIS?=
 =?us-ascii?Q?eWb4t+QHSx0JEbX5mENKehXxFPYVCk1jSL54z7Ilh4fa6hE5H9mG2UJq1Txq?=
 =?us-ascii?Q?C2Oaa8QnKlvqLzen/uIO3j9KCeeRxu/JzCnmq632d20H8wJ6H1wCKZHxHbqy?=
 =?us-ascii?Q?7xgNNnr7QR7JQ4R1UqZMbNYMJvPHPnHblZIPMu9lNicsPwd0uz1SZYzAJW4A?=
 =?us-ascii?Q?fTh+nStFCfHkVST4bz3GhVFppCkp1w8i9CYwhBuwJT456hyBRd4hJY4yMrIa?=
 =?us-ascii?Q?vSnpkLxhnL/K4D04FItU5A2udbtzwKek92WVsiHcSMKzE6T43R7UsNfoeLbx?=
 =?us-ascii?Q?V8Z0mESXoZppSUuYZtZ2PB4+25rjt22efrHflDwkJSM2ubrHlZTA27+rAYSg?=
 =?us-ascii?Q?u5LLkNNwsWEzm/9/5azv99wrUpieRyQq9e76o4S9ZACAQDiqcVA1JIUT4n7r?=
 =?us-ascii?Q?IGBLrdTY0PHkpCfL/LRQHtg7o+BseZ2/eg6xe09KqkayxjHIsq62H31kQl3y?=
 =?us-ascii?Q?peJp7q8bY38jCPuoc7fv1VFfTyEGx9sHll3+HjV3km040xt4UWLsfZ+AiU+3?=
 =?us-ascii?Q?uNsjXBpLbBB3plb32fxOn2ytMtMZxHxoWj9ZgfWGThJKLk5l/YmEjP47u5oB?=
 =?us-ascii?Q?lqedZMClwApEKiyk6eHr9lJSm6kew4fhmLvyB+I1cpmtp+uAT+37QSKjt1yq?=
 =?us-ascii?Q?SkOeYLTcYd63Jb0f2MRBPBOL6A9/dFts30+GZQeQ66pGf9I9V4l7+IXdYJag?=
 =?us-ascii?Q?GH6kjkBgOBaPFXU6FRKSEkz44ESR/Q9BaP9vVKaqNkFbQLm5YKoO0O2r7mxx?=
 =?us-ascii?Q?uMvMR8IWa3Um5sGp3/LRb/EjH73SdgYYpE61fm8a7R768AZLSOTW6VTIpCkZ?=
 =?us-ascii?Q?RTPIn7v8hjinho/6VM7++frdst5OGu0GqKAzhPPVWan00W99yoCVz8mtxS7O?=
 =?us-ascii?Q?xhuhjzSCse0DWF8ecOTsBkLwPJfjGelKNF+lIizv2g5mD0Ekpy0QJY1h4t58?=
 =?us-ascii?Q?/g87TTLCMj89HhoWJhc/Yqg=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a28efd-32a6-4c79-d065-08d9ea208eaa
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 09:59:40.5547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: okuKqTiATRxDsk2u+rPYkkSu9X+bsULKyd/GadC1/do/HEnKLqtnFmOpSyxFN1FCgjM7/JCnoRHI87P5XtDMpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5163
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX93 S401 MU support two interrupts: tx empty and rx full.

 - introduce a new flag IMX_MU_V2_IRQ for the dual interrupt case
 - Add i.MX93 S401 MU cfg

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 47 ++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 03699843a6fd..da1c6ca8bee2 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -28,6 +28,7 @@
 #define IMX_MU_SECO_TX_TOUT (msecs_to_jiffies(3000))
 #define IMX_MU_SECO_RX_TOUT (msecs_to_jiffies(3000))
 
+/* Please not change TX & RX */
 enum imx_mu_chan_type {
 	IMX_MU_TYPE_TX,		/* Tx */
 	IMX_MU_TYPE_RX,		/* Rx */
@@ -92,6 +93,7 @@ enum imx_mu_type {
 	IMX_MU_V1,
 	IMX_MU_V2 = BIT(1),
 	IMX_MU_V2_S4 = BIT(15),
+	IMX_MU_V2_IRQ = BIT(16),
 };
 
 struct imx_mu_dcfg {
@@ -536,7 +538,8 @@ static int imx_mu_startup(struct mbox_chan *chan)
 {
 	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
 	struct imx_mu_con_priv *cp = chan->con_priv;
-	unsigned long irq_flag = IRQF_SHARED;
+	unsigned long irq_flag = 0;
+	int irq;
 	int ret;
 
 	pm_runtime_get_sync(priv->dev);
@@ -551,11 +554,16 @@ static int imx_mu_startup(struct mbox_chan *chan)
 	if (!priv->dev->pm_domain)
 		irq_flag |= IRQF_NO_SUSPEND;
 
-	ret = request_irq(priv->irq[0], imx_mu_isr, irq_flag,
-			  cp->irq_desc, chan);
+	if (priv->dcfg->type & IMX_MU_V2_IRQ) {
+		irq = priv->irq[cp->type];
+	} else {
+		irq = priv->irq[0];
+		irq_flag |= IRQF_SHARED;
+	}
+
+	ret = request_irq(irq, imx_mu_isr, irq_flag, cp->irq_desc, chan);
 	if (ret) {
-		dev_err(priv->dev,
-			"Unable to acquire IRQ %d\n", priv->irq[0]);
+		dev_err(priv->dev, "Unable to acquire IRQ %d\n", irq);
 		return ret;
 	}
 
@@ -762,14 +770,23 @@ static int imx_mu_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	priv->irq[0] = platform_get_irq(pdev, 0);
-	if (priv->irq[0] < 0)
-		return priv->irq[0];
-
 	dcfg = of_device_get_match_data(dev);
 	if (!dcfg)
 		return -EINVAL;
 	priv->dcfg = dcfg;
+	if (priv->dcfg->type & IMX_MU_V2_IRQ) {
+		priv->irq[IMX_MU_TYPE_TX] = platform_get_irq_byname(pdev, "txirq");
+		if (priv->irq[IMX_MU_TYPE_TX] < 0)
+			return priv->irq[IMX_MU_TYPE_TX];
+		priv->irq[IMX_MU_TYPE_RX] = platform_get_irq_byname(pdev, "rxirq");
+		if (priv->irq[IMX_MU_TYPE_RX] < 0)
+			return priv->irq[IMX_MU_TYPE_RX];
+	} else {
+		priv->irq[0] = platform_get_irq(pdev, 0);
+		if (priv->irq[0] < 0)
+			return priv->irq[0];
+
+	}
 
 	if (priv->dcfg->type & IMX_MU_V2_S4)
 		size = sizeof(struct imx_s4_rpc_msg_max);
@@ -890,6 +907,17 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp_s4 = {
 	.xCR	= {0x110, 0x114, 0x120, 0x128},
 };
 
+static const struct imx_mu_dcfg imx_mu_cfg_imx93_s4 = {
+	.tx	= imx_mu_specific_tx,
+	.rx	= imx_mu_specific_rx,
+	.init	= imx_mu_init_specific,
+	.type	= IMX_MU_V2 | IMX_MU_V2_S4 | IMX_MU_V2_IRQ,
+	.xTR	= 0x200,
+	.xRR	= 0x280,
+	.xSR	= {0xC, 0x118, 0x124, 0x12C},
+	.xCR	= {0x110, 0x114, 0x120, 0x128},
+};
+
 static const struct imx_mu_dcfg imx_mu_cfg_imx8_scu = {
 	.tx	= imx_mu_specific_tx,
 	.rx	= imx_mu_specific_rx,
@@ -917,6 +945,7 @@ static const struct of_device_id imx_mu_dt_ids[] = {
 	{ .compatible = "fsl,imx6sx-mu", .data = &imx_mu_cfg_imx6sx },
 	{ .compatible = "fsl,imx8ulp-mu", .data = &imx_mu_cfg_imx8ulp },
 	{ .compatible = "fsl,imx8ulp-mu-s4", .data = &imx_mu_cfg_imx8ulp_s4 },
+	{ .compatible = "fsl,imx93-mu-s4", .data = &imx_mu_cfg_imx93_s4 },
 	{ .compatible = "fsl,imx8-mu-scu", .data = &imx_mu_cfg_imx8_scu },
 	{ .compatible = "fsl,imx8-mu-seco", .data = &imx_mu_cfg_imx8_seco },
 	{ },
-- 
2.25.1


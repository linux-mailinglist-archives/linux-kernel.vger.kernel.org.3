Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2444D2CB8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 11:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbiCIKDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 05:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbiCIKDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 05:03:09 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AD316FDEC;
        Wed,  9 Mar 2022 02:02:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDENiwcKq0zmInoISniZNCScjzAzNl2NVudzfo9kAC6NWydTLmMrmR7NA13U6LsCgd9Y65DMn8oJeCsop+aU5/ZCjeZBGFlxacNSs43L+a6oRxxgdJWtRjq+2A/Vy/YYuwpIH9xXJOtbQ6sKLLO92xysdGwrn8p/UZWAx6sy1HI6yCIhlxd04xFWsZXCyAkS3J4X9TEOfL/Q3M4cE6OljdSJm2SWSehEZJpcJw2kH72Xf6m1Ipp08jV918jpPSy+e32WCDiVpGtYaivfE9ff8YgaNO7AY7RXDVIFpR9y0iZZ0MIIQjLFZLB7ks0NobqmhpESYGw4j4gDev/y4QkzYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9BKoOi4tAOesIotZkm3ll4pO/2B/OQVVHULsgO4Xfc=;
 b=a0w0I0ACzkrh5pu7is0vDePaT/6lCuOrU/yEncY5fd9Ln7j3sfG46CDx1MKZNY5m8FP/L+L5cDABL6R3HDOXRaWoHd8+//KqZvyXvz9Kp5hCTPy38phBh6sbydxF2VFfOVPL9kmbiKk57eX94l2kvk1e283fsizflsPXyngtQxD2ZqnyfluSCSvxave1z4jBVPj/t1w2g9oDBtyfrYxJaeteFN3k1+2PNyhBUu82lK4dMmEvbftkMVdXyGHV/N4qMo3XStulLhihrPgC7La4Ze1IulwUyz+PuNCOyaBhMuqtJ4QrTKfu0vBxk0C375c2Hsazn6Smiu91vrHX2yYL4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9BKoOi4tAOesIotZkm3ll4pO/2B/OQVVHULsgO4Xfc=;
 b=ZNZ4x6k7IsrDYaGHNmyONDxjxAxATxvAyd/AOWfrkP+qvClXPApsRTXjJVUOz9nZvo5pIEhmLj4jnqNBJc6dvsjt93HtAPURr4xcHY+NpwPwL78KHhk6hiPEmek6LreOkWpUXReZI5g8qUTvwoUatjCjq2led2GmMVnWSQOV1Ss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6724.eurprd04.prod.outlook.com (2603:10a6:208:17a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Wed, 9 Mar
 2022 10:02:08 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 10:02:08 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, daniel.baluta@nxp.com,
        o.rempel@pengutronix.de, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V7 3/5] mailbox: imx: extend irq to an array
Date:   Wed,  9 Mar 2022 18:03:43 +0800
Message-Id: <20220309100345.2633862-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220309100345.2633862-1-peng.fan@oss.nxp.com>
References: <20220309100345.2633862-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0180.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::36) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fac9f26-382b-4978-145e-08da01b3ded7
X-MS-TrafficTypeDiagnostic: AM0PR04MB6724:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB672484B06A92C9DB9BFF1C30C90A9@AM0PR04MB6724.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UXWMU90JERfFtCqjOHGcO6+YTH6Ni/5sG83zz6kCNGBYBMXZIP9Nfuq6zEn/ucHycX/3jJy6my/pfVWxlVFEPg95/QMUpHxjxeEC5qoreJOdXtEAVKIa2DDqjhQqwW1G4ouXtL5WXuB8pJFLnWMwSkkSKbCNw4BTELjnZSfHTCE5u7mBp7dTyy3FTn1iKlFMvYfj3BRXXc1jCVacGxeT7xmr50snU6HGcJ/rPBEk+zX6OtTdSJoI2Kh+rOJJykDV+6k1e76eCa7v/2batMAOzDXexm+E8FT+KT4ovBOXmLFi/F1EpzwpDBGctWXIkQd2/P1/qeJcFV2g8YM1GIQFQwxsiMnAoKm5ULndZuwlYp20vQGirTKPG84nhqjG6G+ZsqXlDqv6tV0gDBKD1gIzJKwkcbPLxYIHzq2jvmRPCTOuxZSifq3Fn+s9aVUIpOslsO6dy4mylY6PQbsPOVFnVdqDfXs3TmnBfq0DGNrJGZ+aGm7gBxSeWqC7gwEiuGAjXuHlhXu3zXC7Bo8CbrGhMUfC3u9+s1OsS69wT+xl2zzuNlfh0rz7PY1hVXRkQm0nAt8TFS9+aaR9ai0OFswuVjeUkbJ7KOxuIlDlliGn1smuGYyYhyTx92AKYRtf39sBhJyaP2EF7wHAfTPLUWbZ8eN/r/X6o/qF6OiUwU+eiKeMx9Yq9bmDsG6H1p3cvifs+XyzMzECgudJBZUgBIYuVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(38100700002)(316002)(66556008)(4326008)(6666004)(8676002)(66476007)(38350700002)(86362001)(66946007)(6512007)(8936002)(52116002)(6506007)(2906002)(508600001)(26005)(15650500001)(186003)(1076003)(5660300002)(83380400001)(2616005)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WJ3Fus3wM09M50R9jruacBr7NMIkJ/PpAFYzhGWG2zsQWkaWyE2LV3YcxHy3?=
 =?us-ascii?Q?v1vhzsho5AqY/JS6iw1wAJXbse8x2ZtJWJUHfiXCdVux30g2FqblJS1Cg3FC?=
 =?us-ascii?Q?QaLcvGDv86w98q631eKs4H0bFLqUTXp+iIVDRkfqJhC08iuN9a4v2MiGBmvC?=
 =?us-ascii?Q?+Dw5kdGzJq03URd7MAo/+H+BsNK7fvjCoOoMWNjhdfIqOlCUdOhuh6uB/j0r?=
 =?us-ascii?Q?rWqfDTidu6fBM4budn2yUpNML8ltxxDzkApbNZANLX+CvBtnAUm8LpVc8vE2?=
 =?us-ascii?Q?NEORlQHAipF/fmAP5GyQkUgwstFYp0EhsxlD//v4Vm/BNxQqi8LQWeundbzc?=
 =?us-ascii?Q?MJGRF5B+rH/fhLXeMBW1/FCUk4p0JWHdqCLSqvmsw/2zT0f9hGNslxw4BEDs?=
 =?us-ascii?Q?vl1wqmWlJnXZ4zzgG9MliwzRpsmSGyUCDiEiIahSI3Pzxj2i/IWt8WVCBiU4?=
 =?us-ascii?Q?eyTYMQGFqoh8zVjDe5gU7LrlZ2VJ7DMsqZTrJWeHnVg00JUjHODpTIyQRWQy?=
 =?us-ascii?Q?Mc1iZU51qz8WQET4QthUWkoOfwG/blt40ktO7FSLsq1d4UPVeYHhAGGMTBqq?=
 =?us-ascii?Q?jDws9thMYUSc4Pi5ym2+3dtG4AUYiFmh/L/y13F01J5Q8i72U7ZHEwsXlge6?=
 =?us-ascii?Q?ymhsFA66nn8nxN8Yp/t12ekuxrPEX70VKh/OtRvn1GP+V6WT3hl6ahJhl0I4?=
 =?us-ascii?Q?l3fOnN64dEihC5pwp5sacQ4/XCEy32WbdCPPUFLDnTDpF88+FBGfOi5LSRjn?=
 =?us-ascii?Q?TzBFzRDJZS7+t0bZvKHRlgWFbdFwQNbt96fjAtTYTSxoxNZ9kcOz3dTNH642?=
 =?us-ascii?Q?lvPonLG2Egg4KJ64tu/zs75D2gnutS8WP4mKJomFOwANNXKCSpK4Nrvgq+Z+?=
 =?us-ascii?Q?FjG0OyI4SCWu6U0BrSZTF6HdxTNab3kn1m5srVPO9E00/zx8NjCPTX9rempc?=
 =?us-ascii?Q?ZO+IFxorl3qHMwCQqCQ2zq+8/OHlQxi7tzbxNTfyWwbfQ0Jv9/nHOeRK14ba?=
 =?us-ascii?Q?kTpxJJCTvXoqHjtlz3wt11Qh7k1gqtEU2FS/y8hQDuViRyPRq0+GMflV18fR?=
 =?us-ascii?Q?VV73x550wrxMVfXoILFo/IAohTHWrofz1XL0mAVwnuR/IaNKA4mMcAlJo+O7?=
 =?us-ascii?Q?NKylJMNRlNyg31axmyZZEF0+/KKLgEKm8wrUiGp8VrtnlOqb00FheS3GZQiX?=
 =?us-ascii?Q?db2fcJ6mw9Ok94RPN/sreHWUqeLflgP9aoRN/6nUVUuupWdqSQAZxjEwg4xc?=
 =?us-ascii?Q?iTe0Qx2UU4hF942WNvOmF0QnI2BfERUltqno7as0ZnMwsHFuy4SEKAdZYJs9?=
 =?us-ascii?Q?CLTISdhytepFaZ7KXahlgk7DoXoV42lCVKwfM+Nd+vKguHDcZ3/+3CWCVtT3?=
 =?us-ascii?Q?hT7tSJq+/KppQ+mH2aN0qI4aFoP2V4P68cgAV+IHCTMlM30aHSXqLKTlHkia?=
 =?us-ascii?Q?8IBz0NpjH62VD+wo/33bdolYDq9lwPvBVD4Nsw4jIv/fXhxIqfLG6lH1qWME?=
 =?us-ascii?Q?eUsm6Zh8EG+r6BOF6VfwTrNl+YrsifuaGD5KCnOnNt5AddQ6DHrFm1ncUEdc?=
 =?us-ascii?Q?++Iuv42emXbhb179PnY4VEU5FNSo6WCWL2VpbDFnImnGQt763xpZH/6MXijx?=
 =?us-ascii?Q?7Y/EmC3QbDnRC0MT9KXDEZU=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fac9f26-382b-4978-145e-08da01b3ded7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 10:02:07.8882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ZVas2zbtBjzzX0A3QRvLIyz6eGayAHKmOwjawG3lTQVJU//Xpg4siYZFjAr7dZIOMmFXH5Jp668cXIH3HIyWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6724
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

To i.MX93 S401 MU, there are two interrupts: rx full and tx empty.
So extend irq to an array to prepare i.MX93 S401 MU support.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index cd011ca5707e..03699843a6fd 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -80,7 +80,7 @@ struct imx_mu_priv {
 	struct imx_mu_con_priv  con_priv[IMX_MU_CHANS];
 	const struct imx_mu_dcfg	*dcfg;
 	struct clk		*clk;
-	int			irq;
+	int			irq[IMX_MU_CHANS];
 	bool			suspend;
 
 	u32 xcr[4];
@@ -551,11 +551,11 @@ static int imx_mu_startup(struct mbox_chan *chan)
 	if (!priv->dev->pm_domain)
 		irq_flag |= IRQF_NO_SUSPEND;
 
-	ret = request_irq(priv->irq, imx_mu_isr, irq_flag,
+	ret = request_irq(priv->irq[0], imx_mu_isr, irq_flag,
 			  cp->irq_desc, chan);
 	if (ret) {
 		dev_err(priv->dev,
-			"Unable to acquire IRQ %d\n", priv->irq);
+			"Unable to acquire IRQ %d\n", priv->irq[0]);
 		return ret;
 	}
 
@@ -598,7 +598,7 @@ static void imx_mu_shutdown(struct mbox_chan *chan)
 		break;
 	}
 
-	free_irq(priv->irq, chan);
+	free_irq(priv->irq[0], chan);
 	pm_runtime_put_sync(priv->dev);
 }
 
@@ -762,9 +762,9 @@ static int imx_mu_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	priv->irq = platform_get_irq(pdev, 0);
-	if (priv->irq < 0)
-		return priv->irq;
+	priv->irq[0] = platform_get_irq(pdev, 0);
+	if (priv->irq[0] < 0)
+		return priv->irq[0];
 
 	dcfg = of_device_get_match_data(dev);
 	if (!dcfg)
-- 
2.25.1


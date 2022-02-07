Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A659C4AB85E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353653AbiBGKJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 05:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352080AbiBGJ7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:59:40 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BDDC043181;
        Mon,  7 Feb 2022 01:59:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWfKugBYYTlpo9q16n1V8EMUepQ4+NC+6LiN2ynkI15/4wImKpd0Zrw3ZVqlEBf+9stF19TOqF2dM4N6wR0LycTJW0daUgYmrB7T+GwjBIbgPU3z2psi7c9b9ViDBK2wP0uu/vJ2bPyjJxK9VM1P85UgaK92y13bz6xidB+g2JcgBnTlpQE4HRoWPe/9R1LZ8lcoDDK6L+Tqin0d8FRZGuE6sehZzIuEMfDKIZX27OapItFPo0OrZyWs4imWyVA0BKskaSKwSM83lFbIXBAKFi6971sP4teN7qyMezjsZ4fLdTM+TKI+pL3Ez5apegiLklVMs25j3PLmGqMLVcswiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9BKoOi4tAOesIotZkm3ll4pO/2B/OQVVHULsgO4Xfc=;
 b=OIJ52kal14sigOs0nICbvPM8AEA+0Ms+ZTAw7Hd7/8caexrV/aadrlVSOIngMcizOhOW+WD9tHC3gECqSBOZ1QnYMIOThzgyih9d8OQ9kqpZOeHtbaOkHuktCFL028DyWNX3jclzGufoguEEz7t9yuPVrXtZ9XMPVX/sl95q1hmoRPqdu+izkWezqGzBjexQvLYCF13yf710KD+UT++eBBvxy3L4K+de7QAqZfEVhy/04GXBltSiF4hBs8s3nMwX+H1qAtBLSHZuno+rWQSpamDvfhxyBCza4JH/Ew0jTg6kowbhiCGJgjdKmKUK6pdxeTrfRAXemA1h2Nt6poQdaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9BKoOi4tAOesIotZkm3ll4pO/2B/OQVVHULsgO4Xfc=;
 b=XFzZxBqIUeXq2772QDMCtHizwt5zfxrGpD+gI9OBVVaCobfeVmKYWpYXGHM4PEU212QGdpGVR9jLpkBGwH1DcQA9ZnAgANcJFSdaItGfoHISQ6/via8ShhrYOgkzdCiFkw8dMKUNSsMSwV/3Mb340AeI9KgFcjzRKRuz8+pFFDM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB5163.eurprd04.prod.outlook.com (2603:10a6:10:21::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 7 Feb
 2022 09:59:37 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 09:59:37 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/5] mailbox: imx: extend irq to an array
Date:   Mon,  7 Feb 2022 17:58:30 +0800
Message-Id: <20220207095832.1590225-4-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0595e584-4f5e-4807-8543-08d9ea208c8f
X-MS-TrafficTypeDiagnostic: DB7PR04MB5163:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB516339E947088DF3A8E31ED6C92C9@DB7PR04MB5163.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y6TcG3BUUit2I+ghMndcnIWdZYcauPwykWga0RWNxO5xCM6ktDi4VU1rEuSCKty0uKkp9hbDeRozXJSXdsEkDB3GmUyLcUJjiGkPrV81cVawNVN13TMoXY6+8RLMcmGh+LWRjQrs0OjMvaRSXE/xt90ElqWPomQdfswcihcL+Y5JlIE3cDpZpGGaxL326R31KQ2gdAOtzePhqtygNrLb2Po8yrk/TBRtgL6hJ/k9seadMweWB0lzRUyrgeVNQ/IuVbZj2jHJjes0Gf3cmDM9U1cCU/SL97XJ+8MmmVjwFO1ynQAgXpVGy0PI1qOv/JL98kwYDnWsjOhrsPQB8vOzQPoNoQz3SCiE/PSc5usE+M/28R6VXhhZfLTctqDHUZoVZSRsi8GG05IELIhML6OgGrF2zHR+3NY4KeUcCAxeGAWV79ZTEPrPxRDnhdlNVUref9tvlOaVoi0EGmwe0E7DezpoG549gUr+MnThc14bWu0+vnvq3XYGiC6MIOQQx7zwFpyCFJRppd3GxEEoQi59wWzfjgKR96H5YqVscGdvLU1VpD9iJNaps93oXMDqm70+iNGkn7r5WP3LWrXcNFp02PEYCMxHKaI9pTyNqBELPmLlZLbGaBhbiaw4eW3d59IYTOfCym2eqUEw1+jx4bGTnzauz7Uomx3gI2XFRRGHOYTMO7EpcJOlBG3iVN/Pzh5SW2veJIOdKlSS4NUpJa0gUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(66476007)(38100700002)(38350700002)(8936002)(8676002)(66556008)(66946007)(316002)(4326008)(83380400001)(2906002)(15650500001)(6486002)(5660300002)(508600001)(6506007)(2616005)(6666004)(6512007)(1076003)(26005)(186003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EsQuYhHyKhAHNdlV87nXBWtx+CWucOPmNgLOVuHNk7rDV7KEc8JbenuKsoxF?=
 =?us-ascii?Q?X+k+WpKwy2Psv3mL2mR5MgXuDCAFJQ+dybt7+Krg5R0JQJNHbTvHq3/MonwB?=
 =?us-ascii?Q?+RBF6Lw/5bANa7TcM5+lbc6PCQBLBzMmbZ27ZJR70p6sj5hW1cPnHIOWWyWj?=
 =?us-ascii?Q?vHvV4/mZEAW4MR/8D9QSeCVqEzIjYscsT1Ev+miQF8pKs5UoGgQ0sMr08s1r?=
 =?us-ascii?Q?nBnfiMCCa5uOWtR4OvbR/lyPyTX7tGz9LPKl5tfWTrJ/rV/z7OC8rGZn2RSg?=
 =?us-ascii?Q?hO+s7sKPXPu9u8V2IVIvxAhvC/JWjiasTZAJD0+CgVznWGxQ5PSwx+lASNlv?=
 =?us-ascii?Q?KTOQ3xK4L4RdkHoiVTmQnGPsugqeUge8TRst+AgagoMoR1bk693bpuTYR0j3?=
 =?us-ascii?Q?p5EX/rvRB4gxOIesNGH+ry4GjU0Tgg9jHLq4aPdK8x04bAwLS3XSHbewoxLA?=
 =?us-ascii?Q?XvLbzuQNWD+Y0ShBPnUrXeV6DlGCRUUoYIjd0fGYJNy64lRuuiNhqQPa8woR?=
 =?us-ascii?Q?ObzmsvOrjX4eDcjWXJ8P/t/JBkOhiDrqW0Kwl5iaFOooZhwB/mWZXvl4FtHc?=
 =?us-ascii?Q?9zPy4wGKon3w675eibdMy0zzcjPMbfdUkCmu++oAb32CKHzRWH0KoPWvOVnO?=
 =?us-ascii?Q?umSNyzNjYiJ5u987Gz2aJnONjWI5x/NHtgVeu6pYyM4fR+pju4vADQ2h+bBR?=
 =?us-ascii?Q?Z2kMuF4+CFpMx9wxM15b6Z5Swh0RgPdpbKV4ntYDOkTNdfVaL7nfGlC8Zela?=
 =?us-ascii?Q?RsXFboiXpQJQPB7Ug2Pai4pqsbvUfIPuxO6ZKznbPQrUe+twlIVP6m1XakiY?=
 =?us-ascii?Q?3hGmzExipjNhgqkmgP30TVd8pv6L7HU1FVlNLsobUWVDEoSXlmUPldaZD4xz?=
 =?us-ascii?Q?Yc6B3Ob5RBVTeFk7lS3/OBPRDr4Cq5mfYxb8XM5z/F2F23pufI210vCUfwRw?=
 =?us-ascii?Q?KQmxZp7zvd/aunnq/+jA0dA1K/SzUVMMD0gFAN1jH6cxBqbKUMcsaOTf9W59?=
 =?us-ascii?Q?pVFCog4Grsh6Nde/5A18CcxZ8YR5vG1JxUWCezXrKK0br76y95gPbNAAtSYL?=
 =?us-ascii?Q?g4C11dtDdBSLnYj2CgZlxXBjvDhiOFjGjrEJy5NpXBkNfzZM9D33QHx8vOGs?=
 =?us-ascii?Q?5ZBlswdyFWZ8u7t0LCNkEzO3eKggQMIiUr7iDuxYXtg+jU2JwsbXqBpsUQFa?=
 =?us-ascii?Q?560Nuv1z3tuzS5hsPwV6nBjkfrX+n9FTDFYZcesvHtp8tEhVL4tOJTFIjMVl?=
 =?us-ascii?Q?2EZdy10ZciRhIB6lwf6mVpf6eO64zCMZFy2aLiZi8+GsGM0MKtPxBrk8TsZ+?=
 =?us-ascii?Q?1/tDg8gWvrnZ91J2PzVEqUB93fE9jGLsNmQ2A7zlbqbPropaFyJOYclW43AG?=
 =?us-ascii?Q?7phCA+S7pLGEsltS1glPSDqEyxu8bl7hGIMflnQCF1/nDwd3bGelmcYfzB8/?=
 =?us-ascii?Q?QWnJEOvSBeCOj6lAEKE14ybql00UDeu85mqkG6y0967OlZfA1Rw+qVhg0q3G?=
 =?us-ascii?Q?mRNkd/yK6y/xxxzXVh4ilS+Jk9Qw9xYPqC7hnbjO+bYiIEUcmC1JNZ6JLhOx?=
 =?us-ascii?Q?noYbSEIe6aaB2KRqVDVI9+7O8gaFDfGnWtg6PuHQrX3Y7hm8ciNLyNHLW/DY?=
 =?us-ascii?Q?mcmnxoBQ8BIwsNAkHHd1RnM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0595e584-4f5e-4807-8543-08d9ea208c8f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 09:59:36.9423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jb8rsw0togdulYsMTfsMUZQFKP9oW3YoqOY+Ck8NxnkZGxGjfYOHNqdM7IM5DT6ZZv4LIlSStKiJTE40kGeR2w==
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


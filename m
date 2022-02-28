Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B830D4C6136
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 03:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbiB1CjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 21:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbiB1CjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 21:39:17 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80074.outbound.protection.outlook.com [40.107.8.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F6E47AE0;
        Sun, 27 Feb 2022 18:38:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPTv+KSRwZf7k1D3M6ywaKpNJQf7YKjFMG95ivwth5CaDiT4DP4LSNwgEVmSg6GbwK74YIBrj3I46VawR9XRxy1Ap1q+vfbjrzSIxIuoitwGIm1g1v8KTjSe3nuRsqfvsEfE/z4KxRI80nLnnwV6CRKWWQiKwFymezgMmm6NA1Sv+LVT9GplW9LxRrujTKgw+d56C02uh8HdlFXfnNW7rgIQ9VDs++HFKxwrLKn5U3Ncq7j2m44KYgLe2aGXT5j7HJn+fy3KCX9MiV2DucT8pM2mYoaEJTUGtzAmBOQIQxsW1imhRkPbM40asTJrcVG7c1x6Fzhx6Rb2IX4b+NnwOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9BKoOi4tAOesIotZkm3ll4pO/2B/OQVVHULsgO4Xfc=;
 b=ISEGQG1CPgPLB5FSyzclvNhoe460eJ73ybje77wNiOJVs5wQvwnbwHhT//QbD7yI2o7mqRj1ICj3LL2aF6lQi6Qxca08qyNPDTBi6IymfLWh1Q/uNy/JAeVKTQuHY46uMF0yWiY6LR7WZ78gONMOQCQlKr6QEFB3YfL9+duu624V+Qj71HrgapKi2Oa7GtRjT2p8HijgKsbK7YEDJuioDTZNBcFEFFqbroUGh+hwks5iKdOGgAF1as4V2hpT3DYtll4OhTjIDbKNEH4n3oYnvCWOTyy9+ikVWw4ohuYEw7FnSw3mrUy33xfjjBwRYcbr0NrFZKZ+sjtY0yv+D10haQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9BKoOi4tAOesIotZkm3ll4pO/2B/OQVVHULsgO4Xfc=;
 b=QBoE6PtEmaP3ofBZXd+2wxr/PUYpzcJNpQ22PhTo/91DMnwXy17kl7U6HyV5VDTP714Btzv2vXnz0dofJl9UxMIjdcLMIbRWy+zI0IfrtaRoDAs44dkIRT4qw/bmbnlNGzM6zVvzfWerozceGep9IkgcShMkEdsOj3ltcPC9eW4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8720.eurprd04.prod.outlook.com (2603:10a6:102:21f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Mon, 28 Feb
 2022 02:38:37 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Mon, 28 Feb 2022
 02:38:37 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, daniel.baluta@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 3/5] mailbox: imx: extend irq to an array
Date:   Mon, 28 Feb 2022 10:40:11 +0800
Message-Id: <20220228024013.2866386-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228024013.2866386-1-peng.fan@oss.nxp.com>
References: <20220228024013.2866386-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::24)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31a3e68a-bb94-4c3b-1993-08d9fa636bcf
X-MS-TrafficTypeDiagnostic: PAXPR04MB8720:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <PAXPR04MB8720C43F76B96764F039868FC9019@PAXPR04MB8720.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g+2Fibrnlwm6Oe6hbNlQBoS+NaqqGNwuWlvQlsxoigpuWMPwQ4i4rj5fYVvCKPXNKilQEUHggBGCIKUDXf47Aty8GZ50d6DJkHdIIYOixVQuecgojKNy7t3zXqNbLnQ97DVd/6A/fX1BLYgyooOg5V331jODi9pqdFujKlYpgvrM13TvE3wH3XZGHrsbjfbbskld50w6WplUR2SyWXxn9/2s/ahv/UUdIy+hLgSTg5F9v+AzhK1JArJM4Jo+7PLNEb4duE9gSDPDKbgTlw4AuKjIML8ld2bZBXI8InA/ynrzlTmjKmMq+ctayp9xWO6AiC+J1WErCM+TL/FYXRYDxdvBXbINrknaOxmCQSRRk6qzzKaEMOoRnoZLUwjHynPdAqLPZy90GZMSlqSege2+DTTxFbW9eT/+mgQ8dnTJI+MiRL79msYgX0ZchopAjurO1UtCn0qrg7YCDsXeWjZ/NoKB3XT7yLfUVwvlIpvle8cYzGklXa19s//WftzXFZm2gtrflBaTXyVwvwDhsSz8uHK1ZoQ+TnfiFvKzIqcWV9RGtGZwE9eQO6Z+/vRWENrVDrz9Kl9lfWXs6G4tOD7r/Ldu2meVjbgLNnuRFmVSAY2tQywTf/tXEaQ7icEM21pIzab37+5ZKlmib6XSNfVKNS0+sO6IIThFOGYsqI6BtrAdGLomMMalFZm/LZqrnK53Nov1cDqy+8K1Y/BFfztKqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(2906002)(186003)(86362001)(1076003)(52116002)(26005)(316002)(2616005)(83380400001)(66946007)(66476007)(8936002)(6506007)(66556008)(8676002)(4326008)(6512007)(15650500001)(38350700002)(38100700002)(508600001)(5660300002)(7416002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8nqi11bgzErQefBLSAzPRSalqiTM5BPOCIFdyA6xRmv9+NkL842CNPhGTaCy?=
 =?us-ascii?Q?CyxRliXhXg42NbRDeZ9GKWFlp48GKWiQA/Dhknia2GkwEbV290+vAJ/ODvFA?=
 =?us-ascii?Q?ogZNPVyCp+aivvBThmpW1zSY+V+ngmC9+BS1JNVYNyybASA2wHHMHrFdN9Kd?=
 =?us-ascii?Q?2pnp6GOJC+AqvObpJLWdxc27kYPE54rbS2Pw3E5dpGb3I5uFF2StWebEfBvd?=
 =?us-ascii?Q?IIq1I+OFZ6iZ9DKHFT6q6Hq70H1SkXjAKYK71DlmPABR39cPJTPZ0/RUqQyI?=
 =?us-ascii?Q?O3LNtFlrCLcrB+m8vrHspxyvu1I0cE2K7eB9VHPFrw+BhMzSlMz8unshC0a0?=
 =?us-ascii?Q?7jDjUaXVH8ZA8NxGq0j7yPEt8f0Yw5I5Me+r/YaT32X7UywEFrprKw4DP4f9?=
 =?us-ascii?Q?of9ro062ALmSPH4pW1U3yi98EfMYwLO/JSa+A8lyoDbQp27HaLgqSCart5b9?=
 =?us-ascii?Q?V96iGxBx7sVcslW55mZINd+d/2Jn3cj1d2hn9mnD5zjbb/NOlZP8VBopPzT/?=
 =?us-ascii?Q?80IPb9AH29d2/208twwTT3NCPQV8kgs9uemIT+GSHLxIPz/AO4+4Btx1mFwl?=
 =?us-ascii?Q?IFOZDORVle0jynqMWCpU9bMIqm6Y/OUbx1kboCyAYBxQQn1sQnO54gWHPBYb?=
 =?us-ascii?Q?AwFIW+w8I8D0o3z56HtQ7cgdjhws+jrxP2X8tCPHCZDMztDLk9PPEJu0ncCH?=
 =?us-ascii?Q?1zJFO49HCPF2PmNpU6Xrm3NFjVw1yWBhA5EUm/ALdkOGWCE1T3JWVw418Lgj?=
 =?us-ascii?Q?QZfRwgSHabeT1xcWTh9MriwGagt2IHVdlRfxuIqTtN6vkvT28/Q+RtKA5g4D?=
 =?us-ascii?Q?4xzkURGvP/NanKGPsa8RQb4IZ9qhgYlT+GlYHXPkbuhgL7/Zyiw+7J5kX66Y?=
 =?us-ascii?Q?UAgtWJ+P5n+RhCHqx6l/2GoOQ5dP9gIZeiwyXb3OGrRrshdEPj39lEo2mjLS?=
 =?us-ascii?Q?AiAdbuGuL/YydKhn9/OdPSk67HbYK25YFzUuWPxShaD5+UOMmnaQv2agsWFA?=
 =?us-ascii?Q?9KF+G/pnsFv7Ljvq635XBWFmvzNmq/J2j88WVM55gEA1icN/KhmEpqDLdvVM?=
 =?us-ascii?Q?BjPj/7BM6QGcmA0e1lMVqvDhSWXrlqAdKicuLWLQ25NSYy4gj3N6TGro8/ha?=
 =?us-ascii?Q?5kZfa+UjJWgFGcIkV5br/axBYkUl8LfGw1SNyMed7l2WsuwmSR78Fwwa/sLS?=
 =?us-ascii?Q?ehJZJ8h4GkdjQu1Kf5eZe2XwcsQhRZ6to8M1+Waf1euwZAVT+tUhDs+z9hgm?=
 =?us-ascii?Q?hcS/IJ4VvnolormgPSkjMjdpTY+ZCq9+3h4FwekTnD3YaFu6yMWNlxlTAwT+?=
 =?us-ascii?Q?H2Gyd2JCH40xcAMMBy2Jsjzbn1TJIAYZdq14X9JjhVFQLV/rDO/yrdLMT6I6?=
 =?us-ascii?Q?n7OZvLh1V2VYKDqShhCYomGgE53IufyB1LL44J7zJXsqcWtAAXs4WV/GeC8t?=
 =?us-ascii?Q?/jH12zQtpF0kUBoquoeXjfJMg+q7I6Cvu2CnlYnHCqNPFkLLzSaDqynNoHRe?=
 =?us-ascii?Q?TktTC1NdwafjDLBLXgqE85LnF75LlyMOigGtkODc1OtY437ooqzkap/oz0mc?=
 =?us-ascii?Q?JvebSFcprLekjEVeIiiEAGulPexH8EyLure5X3BsW2nWY+/fzONjIQ8WLhPe?=
 =?us-ascii?Q?O4kybgjbHxzLGfLSnBEdMno=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a3e68a-bb94-4c3b-1993-08d9fa636bcf
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 02:38:36.9419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BuGQIH6pVI29tOeXjbeO1b1g9pCrJYsSRLITchjp+XHxq641xhl7AdgSnruhmtVh9NPvEp+GZxT5S6OLR3yjRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8720
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


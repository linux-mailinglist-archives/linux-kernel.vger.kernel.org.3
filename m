Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2D14B1E1B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 07:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343703AbiBKGET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 01:04:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiBKGEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 01:04:12 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F04255B2;
        Thu, 10 Feb 2022 22:04:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0xHYmmKzAvudkSI1flyOPuS3QvA3fzbGXqbL2E6u3D2nYzM8CvkU/DrF4fZ95lxQiCU7PxngMb6iPeQerBYYS9g6jKtBNQc8I8K3kkd1h81SljubDIzZU8Wngrkj/BlULxuJzKHQH5JICvZIe//H0MAJZkT9WBH879D8cjnYYJN5EjrIXb3o3RJOWOPJQ1t2/KzruO5XsB2eAKRW8Si24YVv/hlocGDHe0JOgoqoAB+ra9/960jiVA5c0qFVLG6jfwzbSEUAG9jlwtQ0y7Eh+4cMnM/FsKp02QJYKTmCGXr6nP2gR0fvhp7Lb782LSfekuZfZzimMT0/53d0aQpeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9BKoOi4tAOesIotZkm3ll4pO/2B/OQVVHULsgO4Xfc=;
 b=QK/ezTma83HOO4gvbNkhCctyTsuVJQkRZ771Otv3UuI+cdKHRSkR1ZLa/NG8c2lof70CFXmFZ56cEEI+RKNDfJI0Tn6B/HRQktZBAupvEW1HmH/JxrnlCJk7ryB1Kn9Mm7MctCH6GtdCvKhP4s32j+RhcbPZzyybzDR/bGUK5tHIICdomEh48oStoRd9PWSnj1+NWhpK7XOFyVc7mAtVSY98Z+ID3xFdn+TUwBT+Ztv5S3hzK8q23Q4IzBHUxX6vWvLZxmO3uvdXJHY0Qr7wrFEJ7SaZBwPVLbNsZzZaTS9A2NHyBpZIO4fWoQue6rdRqN6u40vSU3Lz2EPMqs1xPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9BKoOi4tAOesIotZkm3ll4pO/2B/OQVVHULsgO4Xfc=;
 b=Bvjs3ZuuIgwtiB3F9ugrC5fi6VbHTrPc4rBad2MBlMfp0ov6YR1Awy4Jxgha4x/+apOGV2dJL7pEJYzgLrKjl8iJM10mwLuhJiXHAzOqQCY/uU8VbsNxdw5BWE3cOOFcJCSCnEbEA9Z80jaBu6nLngTgTX+RTJnrbeTkwUAosug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7113.eurprd04.prod.outlook.com (2603:10a6:10:12a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 11 Feb
 2022 06:04:07 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::448c:19d:ca9a:123e]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::448c:19d:ca9a:123e%7]) with mapi id 15.20.4975.011; Fri, 11 Feb 2022
 06:04:07 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, daniel.baluta@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 3/5] mailbox: imx: extend irq to an array
Date:   Fri, 11 Feb 2022 14:02:59 +0800
Message-Id: <20220211060301.1852772-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211060301.1852772-1-peng.fan@oss.nxp.com>
References: <20220211060301.1852772-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8dae9b2-ff20-44bf-d39e-08d9ed24507f
X-MS-TrafficTypeDiagnostic: DB8PR04MB7113:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB71132CF25C563C06337FAA63C9309@DB8PR04MB7113.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yt5ihrjfbqlzgduSpcrUzAsUm2RcWnzhlHbdLvCi7XOh6qSohqe25uNuDy8WjaZTwarQf2KUHBga0TPohdZCD5QaW4IWdnVwz6PUQ9eu7iVV2gT1UmJ1wQd60sLKB0yTl8K8de2QqCUBAS907p9eYsm1pkECJt5b9mwHrIY+2g+LX6pInOnnudMg11sU32l3zqDYyda2on52TMRRJUYp8mqN3/1Nu3+N2ucjFkEecJllIEQc48ZVNpDEC8ezi7FoPbxilQ2/DfRRJfowDSKPOL+brXAq1Sd50S/Jj+Bg1qZRHMuLeGVksopqTYNytnvWuZ+eeOID4+J7mP4pCflMneVjp7ZxILRVW5KfWR7LyLIUB/YMY85qPOhu/1+mr+lS54iy4Fw/P6HjMoPB9ki9wmXhQEGxi9fnavFFXEJcRMlq3KYXQPjgbwCk5QutBRbaRIEkTFEpBL1stnpOL7QLliP/3Bt0Uidjk/Gxs+vyHJ13wjt9DRTa0f+AcLpqK8jA7TRL2hyeFSlq54gt8v4z6IAigW1fkGSC15Jwmho+P5RHwEc0QTpq5mAEEE7qb5ejswhCtRoN9o6zZm2Tltw+1SaWN7cIQoisXdaQzeCtLkxR4px5wETA4enheNXy9foIA+hL0EMJDdVLkH3zCASI7eJu6le6jI753O6e2WDEGXnfWosu4JOujBY5NHWOwaQNZg/Lhhh4OA9s+DMzKCz1eA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(186003)(26005)(8676002)(4326008)(6486002)(2906002)(66556008)(66946007)(66476007)(508600001)(316002)(1076003)(2616005)(86362001)(38100700002)(38350700002)(7416002)(6506007)(8936002)(6666004)(83380400001)(15650500001)(5660300002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8Q9epyPnXO3lq9sz1OLk6CdSLkPs+rGZI6yf2aXTTGZwL9BBBih2FQzIO9Uk?=
 =?us-ascii?Q?zUVaDA4OvCB1o/GbZmAyvmYUs8VaPwKGLbBpGv+h6tukeFJZG3eeNM85LHgp?=
 =?us-ascii?Q?tkab1ilBYrxiULKpkyr4Df0rM55pKH64vlcCNoHH8lxpGG0dTS6j6DJz88ur?=
 =?us-ascii?Q?OaxFyL2hMejDbC4PphL5aabZA/a+OrKMMl+pkJ7+DXQT1iyo/0w5w9RJ1Nz7?=
 =?us-ascii?Q?VOdnwPX4jqi3cdpGwsu6AyIHC9XdJiGSFmS36PmbBfS9smabfJC3zhlEL92Y?=
 =?us-ascii?Q?VHNnIQEE0A7TfwSwvi7mk7tYYt/vfcDaLdxfU/Flq+rtQZCFMXZPK1okUxvJ?=
 =?us-ascii?Q?ejZ75XIZfJyvqj994qDkmkORYDdNuxLE0RmdlxwgBqFLEQ3BzRgab2aKplDq?=
 =?us-ascii?Q?24lfPcKBVfqi9W7f3RbbaB1Q9DGZsrQH96lzEbwu3NYXaDpSzFG6Jx3UnJkm?=
 =?us-ascii?Q?7UC4PY3ss94Q2901v3gLUb7tg8D86ylc34DQW69l7xc7cuo50zm1Z2CJojia?=
 =?us-ascii?Q?+n19cAMkeknDh+Zs1Jaty4y1utfyXhg5x0UStBaexjkkJKPZGScvXUw6nV3s?=
 =?us-ascii?Q?aBUIW0SVjEjbuLFfQdiOdAzc6tZu0yD4FOGFT5i8AdFETiPA29wAj9LDYkH3?=
 =?us-ascii?Q?/z5Gfqh3CoBStBRbnSdC8VPAF59zMjkslWcIswBbVUjMQc4bDHnOUVaicIKR?=
 =?us-ascii?Q?MPleEKiBZkOjfQm/Hxmab4Kn6mmeXZbrVZkI0WZqDKSQd6cHhuzQZdPCmMqK?=
 =?us-ascii?Q?xbeW/sssNayitsEJ5FE5kpYCT3EvVBTYvqfbVtJRAJ/zm4aYKSDMgTnB/He5?=
 =?us-ascii?Q?Zqmsb5s1dyBHfSi8OO4Cm03aVFKDw3zxb5pa9iZS2Kxz9Wd/NKoD7Onn+tJT?=
 =?us-ascii?Q?dNpFTrB5h/IYv3iJQljPpORChC+72uyOIpFQrqJi/phtIwydROt2A4HoAW6t?=
 =?us-ascii?Q?qVokr7otXC8qp5rdAbdSNZ9Eg+MbfELpuUDacgkmwokQrnLMy2DaWaQa3Epn?=
 =?us-ascii?Q?uR23mwoNf1mZYxFQcPTeV3yCRFLh9gY51z+CCSQhe0vFSmvDuZRH8HGHXT0I?=
 =?us-ascii?Q?/Pi4KKi8Wmqj3rOy4Zx4QEGlzqzsg5CpDyBCjrm+KHC7vozzHJE1sGlQc8BK?=
 =?us-ascii?Q?4Q+Xpe7thXSMdwKU9nv2cIPFQzNW5zcDMLcDJuT5e4PcSv0RKhBGCYl9nJIz?=
 =?us-ascii?Q?4Q9EqUPYbjl4J2aCzQhmloIZq8bIDSnvrYqLF+dcMOtmEyS8nYAyJbeBGIq/?=
 =?us-ascii?Q?jQJqkvHifwxiUI4uGpEmRFWA6bApDMpzn8IfgW3V6t2WYjvLUoIUirL5vS3o?=
 =?us-ascii?Q?j1CnCxlQUvMdb3Cc2QvS9dsaHZ/r1Fb7NDTJz3LoWVpn0S5idxzG+Kxl0eF2?=
 =?us-ascii?Q?La6efpd0Iun3rZoLFwIbGoVWBsl534dIbIXqCultku+jA2I7nkjTEtsO2BdT?=
 =?us-ascii?Q?yTHdYwBzT4AjsHff0+OLK+9yDLTmP6Vm9kMZBVrVPTElkF+Cv0C+MHyPhK2y?=
 =?us-ascii?Q?MZx4GZV9tWFR8eOc9RWwkeEYNK/HZljhcVS3hrH6SMe2ewyUvI/5ILt6xAFg?=
 =?us-ascii?Q?x7zxNcnMOcQ5XSweGy+ioPmduOBtztDRq4jLdLDuVPdDdauXIbhqHASmaJ5T?=
 =?us-ascii?Q?aPKyIdJAiNF7UlKv/w7kCVs=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8dae9b2-ff20-44bf-d39e-08d9ed24507f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 06:04:07.6514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TyNxEDDeYvNKcJzU78NFTTDt5PLS/3tW9qNpkk4NRSv8pYYhYbcthQtQjT1aPgIP2y0utcaueKNsnP/+OXqe9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7113
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE934C08AC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 03:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237273AbiBWCeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 21:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237261AbiBWCcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 21:32:48 -0500
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50084.outbound.protection.outlook.com [40.107.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D895B3DA;
        Tue, 22 Feb 2022 18:30:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApbWpyc2RfjJyCvceXHfM5HEBHB9qeDwwEpb/nm0CwUF4CEXt0wYueDFwzjPzUrYyoOFg+fdGQMEzYHidnrE0aBmlU9L98NaQyJH7Sm4/JmqwS5VBduedWYFE72DMWEwZXYMDKVjbvOsU/mpVOkC58SkNJV+pIERoK4li+hPJ6QgFsRDetkpcCcxf3LGkr0Sm5npcHkDVCMrzTaXjswDTFNv4+jImqkBkyfGSS6RAIDfLHxZ9jGJh+iqNkbzEvfa0bFAqCLQJJtTL1UNr7CXRVzaHBz8sal6hsVWQH0N4nlARR65tduCuJhcQGAIOPavpkYRcWJ2qhI0ZUTzgVNLtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9BKoOi4tAOesIotZkm3ll4pO/2B/OQVVHULsgO4Xfc=;
 b=n4QROYlK1y+Ih7RuETlrx4ZyIx06X3dc18SkjtovEnoU/WWB+Km/omaoCLdK5yPD3kCjPK91xPCs50kPx0D60ouKEho4xZCXc7NY0HONULGJlJwrc3yPX8j5uDHegzSJ2JgDIcQ3TVOlwq8L96n9+PatWPE2AKm+GVyA71qIyPPFLeaCb9oGAhg0YMO6uAB7UHp4CMiFUGPjLoS811qI/D0VZT2DNbrfwtNKNMmKFkr2E3T7YxK2DjQ9UuFSKnyvI4H5QQq3uqFyFEAYLyqJzwmDqvDYR8kc/n3qE9V4HBvpUqnHyJZLFehqCWdpTDkonRlMmXc6v5D4diU39lqWdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9BKoOi4tAOesIotZkm3ll4pO/2B/OQVVHULsgO4Xfc=;
 b=YLRfDOb55D6lKnBQ8V3Kr4c2IbOm4tE2AsZWzpttGEZsiFdm56YDHKrwfuug3HA2uYiW9DaCuIppBuWxu/VuyQ8dNbI9/2IBS8sOc8FSfu5h1AtFMizmcpZTNYqBs74gMUcbNEg6TcP2pcCOjkCASaIjMnho+ANX9QU/xWzDZZY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7311.eurprd04.prod.outlook.com (2603:10a6:800:1ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 23 Feb
 2022 02:30:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Wed, 23 Feb 2022
 02:30:22 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, daniel.baluta@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 3/5] mailbox: imx: extend irq to an array
Date:   Wed, 23 Feb 2022 10:31:55 +0800
Message-Id: <20220223023157.3478540-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220223023157.3478540-1-peng.fan@oss.nxp.com>
References: <20220223023157.3478540-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::22)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fe7b145-a58a-4613-b5c7-08d9f67470fd
X-MS-TrafficTypeDiagnostic: VE1PR04MB7311:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB731150B2AFEF1E27DE8CF372C93C9@VE1PR04MB7311.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZT9MQqNPSfHua8izhhqcLkji6EOiuqwLb4g7Ja7fSUhFzv9dayMem/EAKZYZM36sF5spVv0E1lmQyhgf1C0NdX1Oj24zSObvPSMRHjfTqnhpqEN9IKk+JjW9paSPq6d9fJmc526r9qFd0yPnrbwghRJ+BJdLn0AsoasRywylKVw1NhoQYqvd77JyOfoDlrGLjDal1Z+G4e77mPxfXSZOgoYJji5+mXDTJNclR6SvBQPO/YS6h5z0Gkp10ssn6Q5KyVkE4eDwbc27PKg19LmND3jR+GEQHCffdjT7q+w69tvG1nqd2dSGmEAPsHM8cqia7FyTaW4T5B9bO9FlZ13NvGDKCstZh1yqF2MB9gj9rrFU5vppUBhrTPPbzV5a2jLY31pJ7v80DEHICOV1t74+Hp/Qiglbc8mQq5OBy7l6Su6HGrLGVJs/5WieJmwOAJtsv+zSCjHxmgEiX4ZXFDVTDz9QY5n8xRn5r/1ve6I/XTDNipmGS8JwV/uct7ZeQVP5HqJgtjFRHjfVuPK9rBCNDGsz7sXFjit9BHPCTNYWosRIcZT5F8S7i3PcO/3DYfxROXi2M3hTlphkZiwjyvGYIDz094Wkyld4PDxNp7Q7YffmGnvnudL5RPrwaINDJlLSzSMltrEW9t+xb4Mu/M+/ibA+D2fdr86ogqu137UAVp4SZYLVWrQAJlUxa6QBWKNrc9cgqm8jGJI6R5Fa40/ECA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(316002)(86362001)(26005)(2616005)(186003)(1076003)(38100700002)(38350700002)(83380400001)(508600001)(52116002)(6666004)(6512007)(6506007)(8936002)(5660300002)(8676002)(15650500001)(66476007)(4326008)(66556008)(2906002)(66946007)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o2YacWB9t7c/FbwitYhYYmUhMerseJECiUeA5HA8DUX8O3kAfBL+P862jve1?=
 =?us-ascii?Q?dzW5XEN+hn/QE37hfZdCWxPLY6DXZflBuNO6ihupyNSRbbFwHsNEMPe02TWp?=
 =?us-ascii?Q?Uq4NCyzMAu8eCLPB2iflg+2V8Qmi5RSsSET2aKJ9faUTRLNTxwN34p6NZIjD?=
 =?us-ascii?Q?S5+IIE4etaOe5xCnNy/KDNWxcar2NfaZv5JFdNnNZaTITukyKayIj0e/a0AW?=
 =?us-ascii?Q?/gYp7y5MDf1O68TvSY1Py20+DgS4+hrfgin937xkIunoKqyqalm0+B7WwIDh?=
 =?us-ascii?Q?xYhJoClgpZZ3TkHru8VTv8JsQYorULtpRgi+HizwIEYfTdV4WpRhAsFCD5MU?=
 =?us-ascii?Q?lqyCh+jQi1JUycrQNsUyjn+qgMh6AR9nw1kwxiEJ4gEKlq7rUHPUJ+faPBT9?=
 =?us-ascii?Q?BiP8sKXTOL6da1SbXP5EbLtwBOCwoK5IkbfgOpPrn5zGp4d+WoOpM/J9Mtny?=
 =?us-ascii?Q?yoCLqS9dOWRXKuMy1OyL2aO5vyYyNLtr+v2gxcZjR4s0P3jsFor97VmMtTGS?=
 =?us-ascii?Q?K+f1vSkBLohu9mehE4C901IYTpBXzbPCXRzmwyN6JvHpO3o4eP8JrOQjQO1Z?=
 =?us-ascii?Q?jIzOk1ibj1L+Hn+vSVSRTfYpI+0GrRo5zxjEevNAcD5S23VD9asPDyjgZz9Q?=
 =?us-ascii?Q?azRsFK5IaaUl8hzG8e4blMVxZLB/QHQaXaNFeJKNZtoVp7iE9aQk5W7dwIeH?=
 =?us-ascii?Q?s1YAbT1crywp3cYgyBogw640UkXzJEsJiVVfGO0WAG8ZE8fyUHBfoIVhZvKz?=
 =?us-ascii?Q?vgJcMPtZjWHPjDvf8jzQ8hil7oMD2VxLpnbC22nNglUFg4WksZwPDbrkrUPQ?=
 =?us-ascii?Q?9DSWpNamamH8wTQQsRJVremNbM41O17rJP91VF8eSSfH3GaLkb6C56tReuPg?=
 =?us-ascii?Q?EBr7/DJi0mc8n/6w6BXHRPA45OX9p8eWX1JmkBv3Wd9F5MKa/hsvxdH6Nl1q?=
 =?us-ascii?Q?R6lCzdqklvIusGQvfvFIw3ck3XbWvQLAbF7Niv3YsBF+m9sFS8zZ7A7sivUd?=
 =?us-ascii?Q?vQVmUblyfFii3mTUsasHcrLIO9BhYOvaXmjugzKh5DPgimvRhuuvHyvMDDP3?=
 =?us-ascii?Q?6LqmGw7ZFnJqrjWS98+/NA2W4A9hknbINZdEwVD09L/SBRG6MzzXnYgR9zAw?=
 =?us-ascii?Q?WLf3BCpNHs4fi7IgiAyLKQp0hZxDd587f1ku06TdMG7NOAXSWGGKDek3R2TS?=
 =?us-ascii?Q?H5BCG98qhfPgSF24j6ehxi3cxbj5eM+/1+fwEjeYssC4jOMzsWXR3/G3rZcv?=
 =?us-ascii?Q?UwQZdFvSiDqu3cYxIRGuffV+3Our8hOeAnFpuuji0dVv45nIS4MlTgX6rskZ?=
 =?us-ascii?Q?96JvWn70Ts+iWV3Syrl0U/eTMS4P/BU4HaA+qPGBHyrTqdS0aS1tbKrlCKDj?=
 =?us-ascii?Q?WV0HUOiP91dr84OPKpF5AyCSTOYqdbsO4SaIckVEFq657YNp++kbQ4m7NgSB?=
 =?us-ascii?Q?prgG9uZWG4kSDxxGYqoBJarjB9s5a4r+JHG72gXxvtJPUDQeAZJZQLzLB3LS?=
 =?us-ascii?Q?0Ii9mZIkpuWTelaMwtz1fGRUpnEvSz3ud7rIXD2Bh4I0qakpB8u7QBs7brBg?=
 =?us-ascii?Q?glT0vHhuAdlKpXeba96lPjhpJiZaL9KQlzU9BtdBr1pim7LwFM9lbeQ77IeR?=
 =?us-ascii?Q?VKPbzpcOB66dsnBdIiCNUqs=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe7b145-a58a-4613-b5c7-08d9f67470fd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 02:30:22.3825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c11OhOlmYHHCdrUQaGyrjeu985/Y86x3CKOr7SfGOadt7ydYdnj97GF1x/1JuL6QHLhVDwmNxbi3SBMVm/dYuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7311
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


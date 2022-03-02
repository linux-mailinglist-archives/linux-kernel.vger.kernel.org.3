Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAEF4C9B27
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 03:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239113AbiCBCYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 21:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239122AbiCBCYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 21:24:36 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130053.outbound.protection.outlook.com [40.107.13.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E1AA94D3;
        Tue,  1 Mar 2022 18:23:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9vuX4wCC01XuqCPwNo8cP6anVQoM6m0lE/BWswyzSk+WN2wq3dOxeTnHgUenITHyfpxTE7QMO7yAdePex4oa+O14fSwg47hRQoxReW7w2yUK1LrZHMLg7J8oJqRVF7hHA+/RhyI1lH8dKZgoOr38Gf2GraFDed4XsgbMZoaP+uPPffWKK91aiinm+gVN7fj9TbRIePc/NOjwKCWfDCb0ka4gvN3Vm3bTSj6jIt0XA3HTX9jttxxPzyUEzWz6Xf4OC403y3Iflrh0G8LETK7HrQDHXxqKr7D4kFwkHu14sPvjIexFy3yhpP9R7M5xOpLI8sWJztUDJQk+sjfb/Q6LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9BKoOi4tAOesIotZkm3ll4pO/2B/OQVVHULsgO4Xfc=;
 b=leMCmWcF0e7Pr85tscPCHhs2EJbP0KN/n+pWuieTft9+XAUq5chMZgxGTqmj2LzHUZJJn2GV0uuHv8kx9NAPHLh3iXxHg0113siUQp8HQ1IAd0fuI5cx+1f/RHNynE6nrneMn+m45Sci+x8imh4BSptjRZFRB21MdxkyGvy10hBZ5qRucKmU2SAyakE9bu0VlI9E2Q21Cbh/psiPKgKc3J2NYcV0p1cM+SjlYlt2vfh/55e34cbH5clNE9sI2Y/4TLV6ljs5efHAgUP/nscGM+yAOHF8Pg0L9AAP4y3B/Gs4hp/LEfmmD0hNcWbUu2VlPIYPuOdJtKVJKLVg7ENo6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9BKoOi4tAOesIotZkm3ll4pO/2B/OQVVHULsgO4Xfc=;
 b=MaixY62/3iyPt1s07Rzv6nJ/jDat5bypbrt3ND1W6CCwJrtEnUx4Tb9COdsTqFif+mh7mpsytVfoJ43nAblqy09ATtajilrpgP/NImUIn3ZyFPBDZ3TgozxywOG89FeoKQl1Dj8pwanQwTErgnk6WW9CR/RwBhmOZipBwObfx5A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB4144.eurprd04.prod.outlook.com (2603:10a6:803:45::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Wed, 2 Mar
 2022 02:23:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Wed, 2 Mar 2022
 02:23:49 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, daniel.baluta@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 3/5] mailbox: imx: extend irq to an array
Date:   Wed,  2 Mar 2022 10:25:20 +0800
Message-Id: <20220302022522.1789588-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220302022522.1789588-1-peng.fan@oss.nxp.com>
References: <20220302022522.1789588-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efc6b657-aee7-42aa-b11d-08d9fbf3afa9
X-MS-TrafficTypeDiagnostic: VI1PR04MB4144:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB41447E4A587B1E7DC29C8B75C9039@VI1PR04MB4144.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fZig6vD+QYs2uYAYDi8tDJvAa2gGtHTlHNLNPz7ZtX7nqFvy5d68IqXcegf3r4Ctp0O0ZbWBey0Bk6wrubdfMu/AnB3dkJyINvNQsiC0z8IeEbN+rUPqwPJxxMWZebALpaFmigiNbkIr2KRckplYBFekjtqVnsWlxhi+ei6NR1ORH9jaxaVNY1smIEWgN0f3mx3tNgXULQ0Z4XDvdExlmjWX0jAZ6KugBbu1RVfYIbJdYVNz4voiSAWqu4RAtdwzN6ovT1y+slm2oOZwRMUN9i66XVpqgTGzLq5uET1WzKBdskZmzSRH+fE/W3WvcjPMbAfub74BSLaMM8SheTNpJXlk3q6xqXr6JazL78PNQW5N0tf6CP3EljILnY6S4WZPMNTD5ZILfNTBoRGUnmex9H1TNc3eqkGaRQUNmasttNUrZsQknPaO4xHILPVoKH+gF4YiG06TRIg9VVAGUGvYwMBHYuqW+NjtQzMqbHvDPKmxtYJxrzGBB+EU5KsUdOYZYuBWHiBXfMV6bt9yH8G4HiaDcu0FWV4LywhyBZCtryvXx9Bfh0SXBwtfMRwPxOCs8e+0KfUw4TbZ4WLcRwgqfkdAhyHH2qIMrqoT4BvMAaj0s17c3DybKPTk0dbDXWlR+a+NCzycL8D0raG+lxVr8okIalDnxCsW3q1CIBRLdTto5vezK9IRgQDb3vD6CdbHFcsGppCIH9oVF7OP/EtDtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(5660300002)(15650500001)(8936002)(7416002)(66946007)(66476007)(66556008)(4326008)(8676002)(6486002)(316002)(6512007)(38100700002)(38350700002)(2616005)(6506007)(52116002)(6666004)(508600001)(2906002)(186003)(26005)(1076003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ptWuKjPouxzdOY6mmAJ+fJfsQq9xl6QTM2DK9APkkMr4zNHbLdeLkEnNlO1K?=
 =?us-ascii?Q?JGG112gdf9rPwvy1w4TKqgNr6JGBRsdl32zvzYrdVWx61zhvBi4X1FAFwySO?=
 =?us-ascii?Q?0t8wX5KilSpD+eLAhCmjX3pemGowPB19JgakqKhvPtBSCuQ5KmHoVLDGWxJt?=
 =?us-ascii?Q?lvIN8BWQj8IyKP3gc1nHPur28tnYo+VihQccvT2jusu5GzWRbnbHD+9Uibba?=
 =?us-ascii?Q?MM7IOAvG58xA3KFQw/YcAX4KuVP6QWFET1z+7whoPjgeECLD9GAlXwOiwFkf?=
 =?us-ascii?Q?Olz+t0UXomVbAFR/uKqRhG96k+qO+QrkBZH82e7dha+zOF9IGMRKgTUFfpD8?=
 =?us-ascii?Q?V7SR2Xm/n9RjGMkNZ/twL7CIt8qzBMC7xUOjpmvLF8S+ImMAhHejZ6gSwN5r?=
 =?us-ascii?Q?AxuJWiyX6O8pw9SSGuF7B6BUD73shQj2G4wG6NVrUX3LeeZ21SyIjpdVNY6m?=
 =?us-ascii?Q?ZIyKLM6ifRy8xqUgX5/Phws1X/rMoa6mo5PafbT9rGgBOKmrls1IGBp6UxSz?=
 =?us-ascii?Q?Upl+cnB81o3RLxSfgBUMNQhmJclYB7w58GSCmK8uTOqWz8yd4VtFApsURWk0?=
 =?us-ascii?Q?GCsmw6Z0f1CAV2LoTAiOBmw50X96kwHkJqCQ4xVnXz2wqATNi0XdgTZ+Nziz?=
 =?us-ascii?Q?ngssSEi6dpFJrYhAWI+c4BwN3OsZebcmWCurdaoLhLtnXgjpvSCscPSxdymM?=
 =?us-ascii?Q?DAIhsqCSEHR2O9G8lSB++Vbztu13kR+1jjKePsLdsoJs5y0SzIDet/SyX+Tu?=
 =?us-ascii?Q?Ifz8QqrEXMdsO9X0vgcyDkOIHJO4hXkwJdZkYKebyJ6cNOKDrdYNEjFZT2wf?=
 =?us-ascii?Q?+QS5UeJQHNsU5NCAC2Kyb5r3NlJf+FtzDw13Oczp7m74ulHsLHTyXaSvawib?=
 =?us-ascii?Q?GamAgTMVYpNK3zQMl1sH/oGlBBDZjafMX9TioaiECWBs3Vq+y/zJ/Hmv32en?=
 =?us-ascii?Q?GcWYt1bdQLklKOs+prLYj1XZgQXUR3AdlBGbCRVyACPnbjabH+B5MTwrgo3D?=
 =?us-ascii?Q?GVhRg9vUr7HTaXOYmuhA79s07SvuRnnmyLGsSxGaz3JPBzYZdJeKWleeuicd?=
 =?us-ascii?Q?NJXLAt8kJPJwYjAYXBZHzz5h3k3pQCb9IhjjW7mUzLjI+KlGAKNjKMMLnuPX?=
 =?us-ascii?Q?hb7o+qz8+v8q4kWHwI0HBKv8cXJIH0UJKflxrsYXUxKIYCFccGiDFrFKwNAl?=
 =?us-ascii?Q?/xhsT33nh3CG0oD5ypWi+h8c7MBFEPn8y+x1871q+83bnQvtmsYTZHOZciWy?=
 =?us-ascii?Q?d7p28h5SPr0A5Z0jIB6ihAzR9dbw+ydlY8sojPmMvQCYE8ug2d0aBAByZoYk?=
 =?us-ascii?Q?A9EoeJRBRPpWgeUlYRgflNbVhX3cGFx0o50vVYTetqb+OKKSCTBOFdpLhDv0?=
 =?us-ascii?Q?/ljh5VosEj9bC7sLOroSWsH2kyiOL4cYpd4KLUWGy/8hNVio5P3m5BkTu0BH?=
 =?us-ascii?Q?B9sUwS04k5nWYDJ1qjW8ySoPKDQbtL7qzAVxgbW1fyJqSoLwZEKODpvdU+p7?=
 =?us-ascii?Q?69fXwwbCe96mxTeflBJ2jaJe2C/dmhLQRlddU5LHykknJlGD03Jokv6vV2qN?=
 =?us-ascii?Q?Q3wGdr8RJq14oW/vEjTsffEd899/qD7usmI2ySv+N3jTsLNYheHl4CcLzRoO?=
 =?us-ascii?Q?MsQsXefOSdJA4xG5nLMt5zg=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efc6b657-aee7-42aa-b11d-08d9fbf3afa9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 02:23:49.4268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NIEqbPk9g/oCrJedVOmUzWvbrtuCd3OVkVsKU0WB1ZOaZ3nN/qI4mvyjQlV4f/dWdAlMssi1SGq9oz2E+aHcGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4144
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


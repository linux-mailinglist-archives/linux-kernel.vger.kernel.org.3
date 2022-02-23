Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9CD4C08D4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 03:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235727AbiBWCej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 21:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237410AbiBWCdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 21:33:03 -0500
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50050.outbound.protection.outlook.com [40.107.5.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C1E4615D;
        Tue, 22 Feb 2022 18:30:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzKJXuzxkdLGhA/Kb0Nm9shcxtbkOqHbzmFpfV/hkOanL85yehsiuyzUH2FIVqSZpYucAiJpHASX/ykh6hjBT3RiS5erw7JqKXVOgiGbKg8Zo4GD/emLJlr2Rr5B52dlV2Ie4dGHXywWnu4RhmFid/5FYIBKp8FCJ6gm7HlKTC7gv+yw0uze0Huuyfx80cjLOV9ay/x5o+eVGb5lwx9Wd6wY/5sd9KK1/jBlsaPh1FXtpwfZRFDYXt8zbWa45UAzTrnpH+9+hEH1uB1qrKYwO+D3GAckzlYcylQG5wfNCCsSPxk4xGTeoB/JYfdprgsF7tCKVilE8ugFpeQ+oxThFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECnriCxbkeJjVsTKVL23ubOs5FzJCH0bVdUuyInXBAc=;
 b=CCyB4ziC6cMn5D30xwHNj4j3WWrlJ+Lv2lySk3W2UgX0QGoQz7vry/ztXKmO2OXAw0MxLQQkpHLD/DxSbbLInstlLskJU1Sl3hdO3BuzlSWNVG+kmmBE/SNZgqSLAasWVXLtyUsQAoNAoonCUk1sC/BpwhNTjva1Y3RAEnedg9efm1fkdss4UiA4sHJ/h8B1YXZ+L2C21pEi12UZkJpRaqirVZ1iO9XRJQK2yuEEJXNaqhDz4csbi0SlS9HThhBjwLZxGU1e+n5PX+KBI0F05WI1pli8HkMXI1EUAovCXSEzt4i5Cy19GDc9mAYftePkttKuACfLVruzATMYMwvYyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECnriCxbkeJjVsTKVL23ubOs5FzJCH0bVdUuyInXBAc=;
 b=Gl1m3JyJlPccgFDhiNpR7VeiD7ybcOqvkeqaNcjwSKbkXsXZu6ZGN8QlWnqt2NLZBpzt354VLP9Ex7HSlF/MIF4feZDdL9Qjtz7x3iEw8SBkFoDN6hlD6n4WXdEhlP+sLVAvmq4K181T5mZYWmx0HNQGfx+6gfMwwYrh8NvqwQQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7311.eurprd04.prod.outlook.com (2603:10a6:800:1ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 23 Feb
 2022 02:30:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Wed, 23 Feb 2022
 02:30:30 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, daniel.baluta@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 5/5] mailbox: imx: support i.MX93 S401 MU
Date:   Wed, 23 Feb 2022 10:31:57 +0800
Message-Id: <20220223023157.3478540-6-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 33da5642-5be3-463b-5aaa-08d9f67475d7
X-MS-TrafficTypeDiagnostic: VE1PR04MB7311:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB731161795CB96941AC79849BC93C9@VE1PR04MB7311.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F08IVrRKEYRj7wx5wfM6Pa+TrCksUIKW09JfltD9L27vSZf6zQcGJ7XdKIUZ/6rssGXIW7gx1M3scqpfUrNbUzUDtMAD3+Xpk+WYqbQA5Ee5VmPPhoCrPovpLHZeuzFFDVgAwQjdg/2WqB3LegCtTmzPjmwPgIOCN6RC7WpYaZtSGSqbdNNsk3nncTajuRe8nhMSXwSmFjEDc2GX8jzJMFQPlwXIgCEnEjbbh5YQDf8FCanvPc5RDt3wCAj3agW0q8i3syLqQ+f/yU9XaUXC7nfBuBxV6FGtOdi19SRZLuWZQbbiT4DuYD4GepyYNJaMqrcUROt81uWtQvUeUF9XxtzkVTZfGE3i8dkluGBdkLsDai7lqu+EBNO/c05yPSUVaTo2NN6ohl7EnRRXLSvYBKDLb9dAppPH/2oz3TZx9my9BXMQpEQ8aA7sqOrSMZF55spAoJaPKzF7cRQw/r3eQpR6/LbrCXN9t/9How5sPJBBmoUnZlt3tXjsPZSwP45aETTMtNcvZ3PBUJD+TVcjoE6fbYpPD07IPcU+RpbtY6bF7BZNoAuoIvC/CFVg6uHvReXdCbQk+dUFEZ1XCm/ZSWiIsbmAD4pgu2hKPoARwHY3EVrU52o6Cm5F5AzBBnEwurRec7bLwgYv8Ay002R2pCO0gqb/cec8L/MdeKA9tow2y/3FMKD6O2dHTItn/ZnBP1fbyNjmd2kkC7tU315D5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(316002)(86362001)(26005)(2616005)(186003)(1076003)(38100700002)(38350700002)(83380400001)(508600001)(52116002)(6666004)(6512007)(6506007)(8936002)(5660300002)(8676002)(15650500001)(66476007)(4326008)(66556008)(2906002)(66946007)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aHCEwk4byyEvto3lJOZ5o6uAGmrvobHbqH5DnEJYBZAxzqjpn2VurSdlKkWe?=
 =?us-ascii?Q?sf25bodsdek0MBC1XpOV205k0gBBr+I0LG5MZeEOKq1464H5ryz4dYonKgwi?=
 =?us-ascii?Q?iaZPYZMaqmYMnH/YgR6fZvMmwLvK69vRIjaZiUUUuOwN7WMJc41alNX+920g?=
 =?us-ascii?Q?Qu+X8VflfLlLNCa9WYNuwkqzGnP5rACj5dlJoyq6as1xWmej/WCnjdrPH+J9?=
 =?us-ascii?Q?HsEaLyrh9dYWtfIw8pqjpvelqI3EsK/MJH+7lSKMn857gk4WWWdz2NGSeblP?=
 =?us-ascii?Q?c047TQJ88ZKFOTv6InQ7S4o0Rb0AWzRr892ew05+ILbgtqqWoXEsM1FBsjHL?=
 =?us-ascii?Q?V5Ue5dp64Fub6jRbQApCAKhCrBH5rGSXl91vQydx8DJ5WtEHvw+iwoa2+rJk?=
 =?us-ascii?Q?b4nYIJSF8S9L+yjgrOJQoMYDTfyZLMgSbYmoBJl7UzKJ2eM1k0V9/ynJiIyj?=
 =?us-ascii?Q?xUkXRUUh9DmU/SWvEtZcXmCERGEXKTcvrKv3I4TAJ4N4dw4GdtcVI0jHku5R?=
 =?us-ascii?Q?PmWcj/FYIR6tDOxSrSJglpiBUV1ezP5ko2t/flRvcUxRjWPG+4RfSlL4tFy9?=
 =?us-ascii?Q?hLdRMAHqoRhYn6KlxJmNs89/VzWIOoY+Zla4IDJOms5gpXwJ/6/TpHJm8brh?=
 =?us-ascii?Q?RlZu4tmmBI/fAu4cge2o7SXOGjxmvo2NxKLgtrLApradoZXDpHuNWOP05V/F?=
 =?us-ascii?Q?6U1G2HCFqJheN4JcqDq5RawOYYLntEJzcw4J0iTkw+1yF1QAEEC0KGiyYbuU?=
 =?us-ascii?Q?xW6cihpnVfEpzZH7AoJdmN/+zTdCz4Yk08LMWhs86xegKgieJ7iUS+6H2ofF?=
 =?us-ascii?Q?IyZEIIX45nT6VQBYK8zEniir5ZMrWlWpBq7cewxW3+PAqwCImC6f7Wgl48HN?=
 =?us-ascii?Q?CsURdx+/E5L3SBrbIt+GMkDNwwkWVSly4QaT2fqi9ItQYRIdnzpi/QpRu8vz?=
 =?us-ascii?Q?e4sBZ8IOY4mj/4pRMHZhQ8+Mt+vz5ylLYuovvVRq2VrzVYgfE5w6GSP91jk+?=
 =?us-ascii?Q?8jsxgSNbCj0fq2FRDMALePrTcKWlM0iiJokyTywitNUrtmujqMMe+R+kF2tr?=
 =?us-ascii?Q?T/TMMNU6/F4QMLzWYWj7xYSjtuqg/3+mftUpTzQ9lCCg9OK/dvDTVcyCdUIz?=
 =?us-ascii?Q?0Jo/LF8jvmoT9BCSwyBF0lzBywvY1FqzC1oVikz5NBoh6xc4PPONR0UzkUsy?=
 =?us-ascii?Q?zqp/VD1h7QbGo3r9VcNBgp/w+RO5ZwlNfNAxQI5MfweVSHpSSQI1siKJ1YAF?=
 =?us-ascii?Q?U/aI7Fb+KuafhNlsSyKrk4CFURobK7FviyWuHATCbszGDylnwfIK10hXhgjj?=
 =?us-ascii?Q?B0iy9C+zrzRENf70HDoO9CTPEwoD6njR5glKlBFiY0DemG5FVXzgkKddxWBC?=
 =?us-ascii?Q?+DzwwrOVx53xyueWJZHHCcM9yWYsrv3hF5Il7y8hYaF8xgBsvaVSNLE0Oh+T?=
 =?us-ascii?Q?E2MtQYLiKVsXOX/lJHH1dNbWaJxjRlcy1yhRcd3/Dor3nznxBmpec6egJ9vf?=
 =?us-ascii?Q?uy8HuS9oDVF8Y6pZH7JrHYDHZ/TiP91wn1c5CIz4HO1wc348R/vRrKvNZ1ju?=
 =?us-ascii?Q?9yPYlDjWG5Baou4cFMeR0kReTcQJ/2jpAppCEt2dPRETdQX6KnoR8ENFEBOM?=
 =?us-ascii?Q?vNfpqna/wOjEpyJt8lqo15M=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33da5642-5be3-463b-5aaa-08d9f67475d7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 02:30:30.5978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5fFu2GbOu6uaraDcT6ka1EDwwmDY/H2a8kNE5jfOs8xgGuq46Q1wtt1QxuZGZLHJYYMbGyf40YQ19MJC+yuL2g==
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

Add i.MX93 S401 MU cfg

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 4bc59a6cad20..dcbf554aa96a 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -908,6 +908,17 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp_s4 = {
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
@@ -935,6 +946,7 @@ static const struct of_device_id imx_mu_dt_ids[] = {
 	{ .compatible = "fsl,imx6sx-mu", .data = &imx_mu_cfg_imx6sx },
 	{ .compatible = "fsl,imx8ulp-mu", .data = &imx_mu_cfg_imx8ulp },
 	{ .compatible = "fsl,imx8ulp-mu-s4", .data = &imx_mu_cfg_imx8ulp_s4 },
+	{ .compatible = "fsl,imx93-mu-s4", .data = &imx_mu_cfg_imx93_s4 },
 	{ .compatible = "fsl,imx8-mu-scu", .data = &imx_mu_cfg_imx8_scu },
 	{ .compatible = "fsl,imx8-mu-seco", .data = &imx_mu_cfg_imx8_seco },
 	{ },
-- 
2.25.1


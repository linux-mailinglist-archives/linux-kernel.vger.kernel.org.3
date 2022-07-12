Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E896571457
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbiGLIU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbiGLIUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:20:39 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2056.outbound.protection.outlook.com [40.107.104.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C9BA2E79;
        Tue, 12 Jul 2022 01:20:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rjy6S7Qig3WCxukYDgUNII+jRtZdSDjlwHbuJwRvr2uXX605LiORTO2l/AUeig3RgXyA0AC3Bg9rNCLqNT5bA45Awev5IaoVR3ODq14jQT9Kj6iURPb7EmhRPTKZCaSisa4Nh21PNLlj9Z+/c/GsreD+bSE+pVCw0AkyKyBfTdgJXaVEwSpi/U4Go4hPaoWWYaAVVX1jw029+V7bauvE6oIGkLve0kaSQ5rfaNRzwt9Oy4JDi4KHu9I2BZP3UH/lpALZ+tIxW+MJWDWaf+9U27gZBp/xvWRi3yAH2VQtd4j3upt1ToStFaDs271/ReBN4sW5GSZc1b+voaWCTTsb3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCInyyf6Rs/0Yq7V0PDjeNP/427yZibEOWNf59cjthc=;
 b=UKn0hHs5DRt9whd3gpZbBz7cdWGxwELFR8AU8bLEfzAUKEgGPuQAg+8dvY6CrywCNBGJ560XX3SGmWUuuEB33QFzKwSslm+0KQ9LtD2pl9AC26Tg/dPqSc2bLksiSBASaciT8mT3jufgjaLarBpmBI9AcV8djheiCI6FjRtkmnvOL5hgcCnDX6iMzb0J8rmQvBQ1uOoRRvigQRwxhzy5uollISBYmn5OpdcHHjHeQSdsGpsxSnvdAgFOOTq3r5d1VMYpdJDbAD+6/tRuLLrC8j48ktXhnWgtMhgQgXNBudaYZ8Ucjz8pP3QCLp4eZZs6ni/atS8bp0LU16XlVuce/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCInyyf6Rs/0Yq7V0PDjeNP/427yZibEOWNf59cjthc=;
 b=ZeO2A1DJzygW6v6K7aukOOdskbtVVPBTKMvgJ66WCUNVtNdS3ljBvcm+Sbq+exZC0ReMQLCs7P8g6vWWBTTvDJbuHY6bGGlr7UJaaUIqFYnGO/fcg+Tq2tbidT2i0byaVLl2uZsecN4aedDzhXvPDESKEP/OkBeqatJyDqeEA0s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6890.eurprd04.prod.outlook.com (2603:10a6:10:117::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 08:20:31 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 08:20:31 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, aford173@gmail.com,
        Markus.Niebel@ew.tq-group.com, alexander.stein@ew.tq-group.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4/6] soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl
Date:   Tue, 12 Jul 2022 16:21:44 +0800
Message-Id: <20220712082146.1192215-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712082146.1192215-1-peng.fan@oss.nxp.com>
References: <20220712082146.1192215-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0217.apcprd06.prod.outlook.com
 (2603:1096:4:68::25) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77f4aa04-9e30-4187-648c-08da63df6289
X-MS-TrafficTypeDiagnostic: DB8PR04MB6890:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NYiJcoFTuLjqrhRAZdjV1//C8VH8zwp3yUgi7oJn4VbI8i5AuveJ+IytK1qGPj2U0Juo0ySiU4xqQrbaO5j9+I/+QfSQKJDUCkVQtJGiWrJ2LOL9aw6NTbSxO6TtjR4d251djevscb+2BgA3NtighAjGmB0IUQJ+XeSxHSUTgSCXYQRbgwses1yY74XcEar8blMycQ1EPP25+5yiid5f0nkMDESqOcrbh8dJIP7cqCYM7nbxZA7qvsrmia40G9p5vxCoZn9AMqbx8IEfNHgdbWaQFdxydsNzjFfOKF3sd3ZwuGQXGNt/xs1mqUIoRB6PK2DKZEeN/545CcIEANof96NdTLm7OFmAgz+0Knx7MpjdeGA0PhmYOPrsilXg/1M0wE0t6uwjWTS0x9L+dInKz1Fj1KeeuUyIdppstwQwzukbmaz2VIzETHLfc4RxCSG/RnKwv+GbhXr0yL+kJsZsP2L2mXWXTBybfwNGWMMsgfWXmXyb/TIavi8DNZk/V2jvXGGzFj88KisGL9fcg9VZZvjGxGogltJBR4ay4Nud+Wlk/GD/DwsTEk8ITJPwZPUNnVeyoEXH4Ulk+UsRk6Mb+rOd8RoWLhiaPFqYqcjRiy90racSThNrucG9YHUhcAaEoOSddRF8fCevA2Bo+uVGNtU/h5bsor434mjg9DRYzlwGk3vlxSu9c3NauJXhDGpgMLeojmq+RJO/h5CmTJCrHULQLhoWzEgiaD9SFCNey2TPTYbPX947WTyKmXwtn2bHuKyMNE7y3jAChFGiB8Gq1AY58j4G5xPcrquENgXfM+KtBnglvow/rt0IM8zRDE3BZ5bNRlD6StBg3OO85t8IwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(83380400001)(186003)(1076003)(2616005)(2906002)(38100700002)(38350700002)(7416002)(4326008)(66556008)(316002)(66946007)(6512007)(86362001)(5660300002)(26005)(6506007)(6486002)(478600001)(66476007)(8936002)(6666004)(8676002)(41300700001)(52116002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?thyiOWuTVAuBG0NaktUYbaFUzlSKG7TJmGANpnurMZLx+KZUhuZcAEBtABy5?=
 =?us-ascii?Q?VgC72mDmj0+H+pez3NBDtXxUheKiHhkQ/52AZ6Vmb7VHx5IZDyljQ2/sZPWT?=
 =?us-ascii?Q?B7Lfj8uTypuXZTiHRyas+ONAebrMkxgeuFmOi/2Nd6SBnz+xte0ilbTv6NQt?=
 =?us-ascii?Q?J0pBOI/o3esH04WyOlIM0rs1H6whb9GRP1uY/S1xIBjwkwyk0LlC/WrBTo9d?=
 =?us-ascii?Q?wftnOKMRsM+RwwTaKMq8VeIChajUwTix6filtc9V0lUl3840SJrCWEl52T64?=
 =?us-ascii?Q?kJn+mc4ubgXyxZP8KvSW8c82NidI1r6I/IhYsUZqzJ0VWc3kmWIm2ovEXKlL?=
 =?us-ascii?Q?mh83wqLjV3OMTGvItbqw4Iwgu/dPLeD+W7xoGVMMGqnVmBdbD48ZSj8m1vSh?=
 =?us-ascii?Q?xp1ktYTdw4pHZNqDhlX4qwj62NuJP0nLZjoGy7ir2jjVIveJd0B3yrYFMhuv?=
 =?us-ascii?Q?9oPSm3NjNqwo0mPCOFUASbfnUeuqkQkx6bkBvP+YrRycK3xrogExFu2Z/88H?=
 =?us-ascii?Q?xOZPlIgNi+DqYquoje9k/I+yIHs3nZteYV4hyE4UWw6C6KGBQZUnmr2qUN/W?=
 =?us-ascii?Q?TsUv3439fRLb/pva0CKcwD4Yj6iaOj4VWRZKOW2BJ400S84GhONk9ZudhhRc?=
 =?us-ascii?Q?GEibkm96izcdtaBPN1RRQnvFGjKeUKwGmOizBLDVEozkK68cgpDfwGJ/oBJz?=
 =?us-ascii?Q?uNOndVm7okEj+fPzT4V74lp6He5JHBlOUVp4mIAOmc3wVlYafu/t0Ih2NiKE?=
 =?us-ascii?Q?4Hc8k9i+i+rAYgqQeT2irOLMQjvn6RmucDx3oZxAfSPXCdgy1pLb2YAbbUZn?=
 =?us-ascii?Q?sJ5YyXNGMbH75HMtdPNZPQJ1yVi4QIKdxtRTgV4oVfFQjiC4zmyk4yiZS75A?=
 =?us-ascii?Q?e5R0iAZTWBu4Se5wW+hxEqdFthnzmAJZk9hPQ9DXOMqIim1cOKKdTwDvrHJI?=
 =?us-ascii?Q?LBVePKiOSF1n3uTYdWfvNu5A1GaN7Ek7c2nmEOVeRpJHqc+gSviw5fnvAiZU?=
 =?us-ascii?Q?AgeAERsZPp8mzYt5vAqujmtl27rcgk8vARERWUDTeLI0g5iwA4k7KN7V52y7?=
 =?us-ascii?Q?RkpQYd6dl69He4DqYfEL2H8L5B3xVtivGYmXo1HothPZ7+uT08MJeCOEwoBv?=
 =?us-ascii?Q?xzYI8qIIxR+XwdyA8leS/qLxniyJqzb1x5lgwG/FqC2lO+DUyDOWuvFaKfnU?=
 =?us-ascii?Q?Oy7JZmOyWigraZbzn+xrbDOWlWWhOJomoG6K4DAEoLi2e/LePUjb6C4xJBp1?=
 =?us-ascii?Q?vqNB1xTxaocTo6+LJGGD8jCjMeRMENkce/EFJL0UI8Xxj6jWZOUuvQvLsYA6?=
 =?us-ascii?Q?Wcs9gl5tSAVfUSE5u5hopfD4+PEHpTCyuht1ZSxcsplBayXNH5FJNwEDGLOJ?=
 =?us-ascii?Q?iInALSlPxAyFaB19pTcsToyGdYvFwW6tmk47f3P9PHmXHv2aQuhEOKQANP9q?=
 =?us-ascii?Q?t6iMUeya9aM/IiThJ7EHpis2OdzbcX/w8IBg/oetU+4PkBMR3Uy7vath4oz2?=
 =?us-ascii?Q?/c82mQ7h58CmV+u2/H3posY/mu2Fj6cegwKWyJQciXziAhvsHP4JZvWq9p+X?=
 =?us-ascii?Q?7ox7yIZAxmz7F1iDiZGoYyGMgYMCGlgEm1JY9tMV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f4aa04-9e30-4187-648c-08da63df6289
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 08:20:30.9936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FXdWU6TfttpktbpksTSlg32LlF3Se4O8dRMwD97bpopA1RQKgQi0NVBuLBi2vnmfbpuocMBiS6sk4tLhLI4gwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6890
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8MP has a VPU blk ctrl module that could supply clk and reset to
VPU, so add support for it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/imx8m-blk-ctrl.c | 47 ++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index 9b0f81dc292b..d958d2f0cc73 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -484,6 +484,50 @@ static const struct imx8m_blk_ctrl_data imx8mm_vpu_blk_ctl_dev_data = {
 	.num_domains = ARRAY_SIZE(imx8mm_vpu_blk_ctl_domain_data),
 };
 
+#define IMX8MP_VPUBLK_G1	0
+#define IMX8MP_VPUBLK_G2	1
+#define IMX8MP_VPUBLK_VCE	2
+
+static const struct imx8m_blk_ctrl_domain_data imx8mp_vpu_blk_ctl_domain_data[] = {
+	[IMX8MP_VPUBLK_PD_G1] = {
+		.name = "vpublk-g1",
+		.clk_names = (const char *[]){ "g1", },
+		.num_clks = 1,
+		.gpc_name = "g1",
+		.rst_mask = BIT(1),
+		.clk_mask = BIT(1),
+		.path_names = (const char *[]){"g1"},
+		.num_paths = 1,
+	},
+	[IMX8MP_VPUBLK_PD_G2] = {
+		.name = "vpublk-g2",
+		.clk_names = (const char *[]){ "g2", },
+		.num_clks = 1,
+		.gpc_name = "g2",
+		.rst_mask = BIT(0),
+		.clk_mask = BIT(0),
+		.path_names = (const char *[]){"g2"},
+		.num_paths = 1,
+	},
+	[IMX8MP_VPUBLK_PD_H1] = {
+		.name = "vpublk-h1",
+		.clk_names = (const char *[]){ "h1", },
+		.num_clks = 1,
+		.gpc_name = "h1",
+		.rst_mask = BIT(2),
+		.clk_mask = BIT(2),
+		.path_names = (const char *[]){"h1"},
+		.num_paths = 1,
+	},
+};
+
+static const struct imx8m_blk_ctrl_data imx8mp_vpu_blk_ctl_dev_data = {
+	.max_reg = 0x18,
+	.power_notifier_fn = imx8mm_vpu_power_notifier,
+	.domains = imx8mp_vpu_blk_ctl_domain_data,
+	.num_domains = ARRAY_SIZE(imx8mp_vpu_blk_ctl_domain_data),
+};
+
 static int imx8mm_disp_power_notifier(struct notifier_block *nb,
 				      unsigned long action, void *data)
 {
@@ -827,6 +871,9 @@ static const struct of_device_id imx8m_blk_ctrl_of_match[] = {
 	}, {
 		.compatible = "fsl,imx8mq-vpu-blk-ctrl",
 		.data = &imx8mq_vpu_blk_ctl_dev_data
+	}, {
+		.compatible = "fsl,imx8mp-vpu-blk-ctrl",
+		.data = &imx8mp_vpu_blk_ctl_dev_data
 	}, {
 		/* Sentinel */
 	}
-- 
2.25.1


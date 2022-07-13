Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59C3572E40
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 08:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbiGMGfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 02:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbiGMGfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 02:35:41 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF953D64FE;
        Tue, 12 Jul 2022 23:35:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MuOZQgPH3Cs2s9qKotxEKrUxL0NxNfqa6Puiv00sN6GhEFpsodLbVDh7JctYL+5UTbSxLbSEgFdRgHHqC2wSKByQgF2u+R0ORj5nCcAJniOyGx4Soj6k3En1tPvlAM/+g82DtPiFQ7N3j3cITBAV36Q9cwNtremWrSGQuhbE8ujoRdr6+SEF3CpRlxCJ/QGeAcQiItTZgZ2dOiZKgrOtCCUH+xJhxk2wIH/AFPwgxZFJtcgvWAKE1xYzQtmi9t70h4VYZm7IoI8bu501gz6nQKmRXWj1YgUrMNHOgp2F/nOSsLbNJHEyje+Zd0tiC0m2i90y8O1ovC0IEzUhcLXNuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3k4eqTbwfQlhfZty7gyIvUxvIQVou/wc+Y872Qm3Mk=;
 b=Q+SXDiFjuxT/1kjwYaR/8wKEZu73dofBI72H+BiLKa+/2YQa6r4puIPJiqUnB0+W/WtNe1GnU3i+mfOVoEifDEI6/R/1sBgMavB08TgC5t5mYfpFTr+Ec3IPu/B+mPlV7PvYG9LvDQvdNndaHMnqrVPVfSIqEoHyEyvT6f6S8kfsLdUUI1GQS6QqDy0vnJHBf1T/wepiRFY2BpGJxEbnYW7MFT9z8WgYiKt9BzdBhjFCfyhO1FvmolEadiSJ+2FbCyB6JZjiIRgACWX4oAh0/o2Q5jUqia/AxX2a9YnOulyyYq5n9d+9R/Ec/dX5uIymcXeotrDN+/x519iCxGWjPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3k4eqTbwfQlhfZty7gyIvUxvIQVou/wc+Y872Qm3Mk=;
 b=ksZKTWYEuobIxTxIX8qOIZ0PDhVmLCFxFi0idtcw3Y0Bab9Ot4wFv6EbG8W4aN1nJ3rHz5+4kIDBDZAiP2aXWlB8HEaFNZVLcPxNeZD1MIpPgkmNTzATfKuXjwtnkq0eJ1TTsaf1ThkrKAKYtMpaLKhkelqF5VGwio2hbUIBSug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB6026.eurprd04.prod.outlook.com (2603:10a6:10:d2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 13 Jul
 2022 06:35:33 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 06:35:33 +0000
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
Subject: [PATCH V2 3/6] soc: imx: add i.MX8MP HDMI blk ctrl HDCP/HRV
Date:   Wed, 13 Jul 2022 14:36:50 +0800
Message-Id: <20220713063653.2584488-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220713063653.2584488-1-peng.fan@oss.nxp.com>
References: <20220713063653.2584488-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KL1P15301CA0052.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89d3cc41-5247-470e-82cd-08da6499e35d
X-MS-TrafficTypeDiagnostic: DBBPR04MB6026:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BqDUAgIyOGm3Fqv+1eVyF9o3m35+IWNh6xCajHQ2J4iEeCuXIZnxFCkb1sAnOKJlFdhNXK3sZlRv9RvJ8pIXJYCneggQKVImwRWHtsTZBhzBxWKRs5K0ttfjLngzByNLNLrh3SCi9NoO41R7Q3cexx3IM7f7ItQiFiF17Pl6zJuhPNy6Ki3IfjQC3YiFskoXBqUUv6aB8l/7VvUP1xYrnz8/WuKZF8FJYCgcXAd4DcGdsGlBnyAQkbnVjYA4sQYJ3EICOslkKqbWtFS0eURvbzo6+Q1nTcpKoeO6C5N0rMglNUcM+eiuenDD+uHZ/sr/1E0y2wvvcfCbGpr3ESI8RPzX7LKczIWCa7jeQxSgl8sAO1AVxmPE34RxSvBjSx2wb5WfgJCw3vqQuDXp+nBPVQi0IrFY6ZWXJPf/8/WqZGjuL3aA9zrVh9kfPcZP+eoUDwCJGvrchoPlQrCyMd47APaueVY+bG6F+10Hyl9F/yTSl2orNO7i9qD3QA3ZiWvYA/CaSAWdyHCLlaaS3X+q1GA6VuxVSzvpTKs8ckfeIbfYE6xj1ddUXwTT6pnBuKybO8b12GmEYW2eC/pv2sEs14IH7FA1iKazEyufpMbKwJ75IEDKgJo4CXM+K5+UE9FlaiO1COCEOclc3vcSTBL8bUMOkshkNz8Ck6e5Hv5FvFA2EmNu9QioVm6hpUIZ2ziqvyvoqvyctlqElRwoyDcSGExV6l+i5c10Wy/R2NqYzLdyohlECFdLDbEQC+kmLCCRRMvE/AcwuKEH9TdozUy8Te98kExTRLXnNpJp5UuTVi+6K3W3qUHjqbhbba3VXiB9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(6486002)(2906002)(186003)(6506007)(1076003)(41300700001)(38350700002)(4326008)(8936002)(86362001)(52116002)(8676002)(66476007)(66556008)(26005)(6512007)(66946007)(316002)(478600001)(5660300002)(7416002)(2616005)(6666004)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P9UE4YoIOHT0PlBIt6H/yq9Ku0s1LaAh8WN66SXE4eYYiyoQUEMroznuO87O?=
 =?us-ascii?Q?WoQJ0XWI6DSccyIM09/beUgsdPDrkR07zcpD01U2wXX4tFJalyNJYNbxZWDO?=
 =?us-ascii?Q?hBc/X82nplnhVvteJ1U1mahJ+Q22Y3EJGtO/F+wYhHV7GTic+UwVUYvJ7Y00?=
 =?us-ascii?Q?nuXyeJmae/6lWWy502BEODGUNaCjnefpFVJ/bcQ72f6paoK+jqFseK0WUf04?=
 =?us-ascii?Q?IIIEKwxjttUTLjWWinvoD8/Hc91cwES2hfDxlycLWgpdfY/YQppyW8uiyO6d?=
 =?us-ascii?Q?ZIgbtJZVa3BB9RoYep8c3eKHLmxXXczj4IXs4L8lReFUwklhFxBIsf8iN7R4?=
 =?us-ascii?Q?DMKxz+/IFlbWNsH21BvFN1mZ7RyMfaGujRvfq4c3uU4vbWSIur1PGbIf7Ces?=
 =?us-ascii?Q?HUP94TJ8DehEiGt2o7yydjNlGdO39fuyoI3o6kpiF0zAd4qNtPDEftA4F9cJ?=
 =?us-ascii?Q?CV8d5lLFSlloDFomKvHyQJ38II/dUzEQ0kIhRZpBevxNyz39Jcf3yCpbugHy?=
 =?us-ascii?Q?KXGejH5Z/wuhTshgsLNMn6XD21xm1NBm+LxrMmrV1s2B78JiGIZl7Dqt596y?=
 =?us-ascii?Q?dwtLIW5B5UUdIMTsO1+0WHTBw8fH4coxwszSL9G7vptzildTbTDBoB/sBYjE?=
 =?us-ascii?Q?xbqgPJ9f9vsNI+ZN1L6b+oUZfBQGecQYqrWdV3yBgYuZ/VG8BfcPrzmKTLQu?=
 =?us-ascii?Q?ycmOI0EczM9frahvmpKwwKq8seVgC532DSq+8D4YD3qHgPkPL6hUhXQHl102?=
 =?us-ascii?Q?oDB7qP8/zGcIcQLZBruBC0FHzAMyqTd1VkamBug3RA9qvYFxaFvNq5R0Zd5c?=
 =?us-ascii?Q?GebtcniryNzHtVAPTANOllGWIM06rquTkfaICbdnUZxK8UtLW8sFVaQj/5VE?=
 =?us-ascii?Q?oYr0LliIj5+HF+SqOuAXMPMSdbEZKp3r3QlnWzq7ks5p5n8Kke399btZdE1m?=
 =?us-ascii?Q?Yr6VlQKi4BbkSy9qAwQSFMTTgT6aSpnEYTm5nhXl9DCerqzBBqvZg+5OtbW8?=
 =?us-ascii?Q?/S9cHcz4atUZXXGocJ0xxVIhyuy6k57VDkWZCrUmYy/Io/nZiAH4KKYKPqyx?=
 =?us-ascii?Q?FlkJwsu2eEiCwghSsM8Uoy69Q96NE92swIpkszh7cvTrJy/UEGar1HxM93o7?=
 =?us-ascii?Q?FwokTl4VMYCq9ott8Qzaod/R00+IoBiLhi15ZOwK4lUsG90sqgHd285hSI0F?=
 =?us-ascii?Q?nxCeZrmMlQWpC3xFdwIr2kY8oNk4WHW8rYybGQzpdGnzQqt7DtlTLjTJ0KPA?=
 =?us-ascii?Q?3dlRQoi4pVjzZQQ2Gc+j9xQzo4iH0LITDoWC42MUpZLwfkN7zKYMjdxRf9L5?=
 =?us-ascii?Q?BViKLdDUeMeI8/aTLS60PhHciMmlx3C2fTyBeC/N212PqE+qhxOYFqHD6EVS?=
 =?us-ascii?Q?JX8gx459wmlSRRWXljdIayCdKaUhhW7lgIr9+nOcqka4ijoFocK3ns7hZ8hz?=
 =?us-ascii?Q?7ZfSNecD3q+LMJkafs4m2KZYIO199/QhNw5mqRC4+hmMGKkjiy8CJSA6/gUf?=
 =?us-ascii?Q?vuOcfoUogiRuxKRsAb7z3oDdHwDdkwCAWNisesFDiD5ecDIRj1WH2VKVa0ME?=
 =?us-ascii?Q?j8vHR9WQtUtQwDiK2mCo6yUK+/jrBNJPBYYm8A5g?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d3cc41-5247-470e-82cd-08da6499e35d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 06:35:33.6332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uqfk1Y0nLu5Dq1nBepcQt5iuTJbOECpQKNOgV1CqJvA5RE/rrpcejlxBnn9f7oBeiIKRWClQRWYVT5zOZIo68w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6026
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8MP HDMI supports HDCP and HRV, so add them.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/imx8mp-blk-ctrl.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c b/drivers/soc/imx/imx8mp-blk-ctrl.c
index 6f983adcb47c..527d45d12a54 100644
--- a/drivers/soc/imx/imx8mp-blk-ctrl.c
+++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
@@ -235,6 +235,13 @@ static void imx8mp_hdmi_blk_ctrl_power_on(struct imx8mp_blk_ctrl *bc,
 		regmap_set_bits(bc->regmap, HDMI_RTX_RESET_CTL0, BIT(12));
 		regmap_clear_bits(bc->regmap, HDMI_TX_CONTROL0, BIT(3));
 		break;
+	case IMX8MP_HDMIBLK_PD_HDCP:
+		regmap_set_bits(bc->regmap, HDMI_RTX_CLK_CTL0, BIT(11));
+		break;
+	case IMX8MP_HDMIBLK_PD_HRV:
+		regmap_set_bits(bc->regmap, HDMI_RTX_CLK_CTL1, BIT(3) | BIT(4) | BIT(5));
+		regmap_set_bits(bc->regmap, HDMI_RTX_RESET_CTL0, BIT(15));
+		break;
 	default:
 		break;
 	}
@@ -283,6 +290,13 @@ static void imx8mp_hdmi_blk_ctrl_power_off(struct imx8mp_blk_ctrl *bc,
 		regmap_clear_bits(bc->regmap, HDMI_RTX_RESET_CTL0, BIT(12));
 		regmap_clear_bits(bc->regmap, HDMI_RTX_CLK_CTL1, BIT(22) | BIT(24));
 		break;
+	case IMX8MP_HDMIBLK_PD_HDCP:
+		regmap_clear_bits(bc->regmap, HDMI_RTX_CLK_CTL0, BIT(11));
+		break;
+	case IMX8MP_HDMIBLK_PD_HRV:
+		regmap_clear_bits(bc->regmap, HDMI_RTX_RESET_CTL0, BIT(15));
+		regmap_clear_bits(bc->regmap, HDMI_RTX_CLK_CTL1, BIT(3) | BIT(4) | BIT(5));
+		break;
 	default:
 		break;
 	}
@@ -365,6 +379,22 @@ static const struct imx8mp_blk_ctrl_domain_data imx8mp_hdmi_domain_data[] = {
 		.num_clks = 2,
 		.gpc_name = "hdmi-tx-phy",
 	},
+	[IMX8MP_HDMIBLK_PD_HRV] = {
+		.name = "hdmiblk-hrv",
+		.clk_names = (const char *[]){ "axi", "apb" },
+		.num_clks = 2,
+		.gpc_name = "hrv",
+		.path_names = (const char *[]){"hrv"},
+		.num_paths = 1,
+	},
+	[IMX8MP_HDMIBLK_PD_HDCP] = {
+		.name = "hdmiblk-hdcp",
+		.clk_names = (const char *[]){ "axi", "apb" },
+		.num_clks = 2,
+		.gpc_name = "hdcp",
+		.path_names = (const char *[]){"hdcp"},
+		.num_paths = 1,
+	},
 };
 
 static const struct imx8mp_blk_ctrl_data imx8mp_hdmi_blk_ctl_dev_data = {
-- 
2.25.1


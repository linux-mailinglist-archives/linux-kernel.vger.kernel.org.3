Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F035792B6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 07:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236968AbiGSFuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 01:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236850AbiGSFtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 01:49:55 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70042.outbound.protection.outlook.com [40.107.7.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9A531202;
        Mon, 18 Jul 2022 22:49:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anjCXN4buu5ZGFD6AyKWIGRrOfbATCc2KX8OznVJjgSRVt2lpNx7SlFda+NqA6lvlgjlAl7y9K37n6RAfaANhLSXj8hg13urcrWukm76EX+2KXOA2xKpVeJ/fxSCJXDqQk+mh1E8SOYJMYN2CLenQ0EtvWrYdHJN+fsc6hnb5zG0faDgD6iCaRHiR9nwwMIN0JVPZpI26xVXBI4JESwVlLbG5DqSb7fYfkrRTxB9dK55Gds8LCj4fWC3KprKeEbQPGiHwg0j9/S9BCpbKHNKblXFMKBSnKeUt6RCW1NKJU0N0TDgHBzWWviBQviIpoZGvv6FELmnt2Qj3QPnDaFryA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3k4eqTbwfQlhfZty7gyIvUxvIQVou/wc+Y872Qm3Mk=;
 b=jp8Pwp4LsFtw+PN1f45QpwaJBpQO5TVTrLLihmlEMEY6xhQhpJUBoHqzU1G5SfxBKIUrzhzCP1N3DQLez+ojBFTsLuzPvJ7dulzCWV1wypqWA/Dc1Xn/GDHn/Oxa8+IJ1gt7t5oFxUn2T/wDqlUiUUNxgub1in8RatvJ5NWZnx1A/fQQAwZn5MHdCT9DTLGPO6/1myRWapbsA/Kmz1ZZw8WLHkT3cTP94vTaQduG+YrU/+78VOs7CezOohrrlTHmJ/i6r6gEzB5AHsyuNatiFg6r2ZjHms4wSjuXaJoNqXh25A4GZD4fS66tFC9PAz4z5EgRbiawkZ1kKFJhxAl5xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3k4eqTbwfQlhfZty7gyIvUxvIQVou/wc+Y872Qm3Mk=;
 b=RuAxi1jCTiwAmZ6Bndyrg2Bz5eKjP0NtIAlHG/oyU2L/yOx0kTCNQqtmZWcBFivZKMv4xFALny1Iz27IA1RFUKipOWOloPOO8N2HLkAv5CljAhvPbDEPl665LYtJPZRQy2PBJ9oWuMCYnuvjGTWYHu8eX0cMEKmbKajZ+qCddGQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by HE1PR0402MB2937.eurprd04.prod.outlook.com (2603:10a6:3:d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 05:49:48 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 05:49:48 +0000
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
Subject: [PATCH V3 4/7] soc: imx: add i.MX8MP HDMI blk ctrl HDCP/HRV
Date:   Tue, 19 Jul 2022 13:50:51 +0800
Message-Id: <20220719055054.3855979-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220719055054.3855979-1-peng.fan@oss.nxp.com>
References: <20220719055054.3855979-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5dbfbec4-6e94-46b5-4ea1-08da694a7d9f
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2937:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Nw6qUDQ8PKKJBtW8AbCiK5Y8YDqaq5jxacH+1mRZW1D9svgfwxeHRlaEBbDhRE0bL7wNm1nRvGVflOkhRCozFoa3o1vHX6BsZVde1biGS43TFyYWhvL2Zu1SBQZmwo0e/Ato+RMKC0NuuTSjUhDUHZtekEzh+DAJw+UYySE3i4ej8yPCmJ+jhy3cr66GY77Xupiz6bGgVj8IvJQHTGqs1DKIKOq5O5ujldgQ+m1Owy+vpWcG07CY18k9S6iinr0HOYJu6SyDIKaK2VE0IdHorAnIW4nAjtWLvE8L5/tv7QPriKg+uwqgxN9LMrsp/3qXte75sUarlXEDezsdobZ8aZ87UuCq9f0oQ6Kw0ZhYaURcYPpIhCnxOzJ8ZI5NzTvYtrkJUd5P9Re7Gf0xRfn235nOE5DCGJo2gsDu9Y9BH/CkdK5zC/pZyiscBMUb7kt8GmS4ZzSDzbwAQdc8C+NhGCV1nrLLg8OsnFeJsfkTQ/eUJdL7/WPnF/YrcExUzAmZ3TCbqHwtyRlPzvhqXpiZzGt0wTFW92YGGVVRlSJm7tcU1Wh871nPRyNf4zK1P8hN3uq/S73xdPoHkjJqAztCO6PeEV5Hqj2ain0m6VGylh306Ygd7W/yzoNwZauKzO7XmiNUEeVBo10I0zk7kx102iQMjatJBtoXDy3whhD3J+8ox811lI/lGtFjgVckbuCMxDYFDQ+y1oMoRM6OmGdNxTzA3ZdrYes/9DbxH8sB2ZoWjHg79p8f4DS9aLHU9j94W+erxYtGGdwnoxdbAFI1xwppwjd4uNGmCwShEGwALjVAgK4OqnCdyqiFJCfM5+3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(41300700001)(7416002)(26005)(6512007)(6506007)(38100700002)(6666004)(2906002)(52116002)(38350700002)(2616005)(1076003)(186003)(316002)(66476007)(8936002)(478600001)(4326008)(86362001)(66556008)(8676002)(66946007)(5660300002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pDsF/S1ZvpdGeCRUMIhnVpGmNfOO626f98vlH5GS8Zpit+ajRHsQh5AK1MWU?=
 =?us-ascii?Q?AsM32QEGlCOF3nwabjny6cPhA3y22CvrEO+rBY78m6MaRMyVaL5hu+mIPCQG?=
 =?us-ascii?Q?iUjHoBxpEnrvGNKwmLbj/aUjj0pdhpE3EgihJ429y8MhYrvV21K5WjjOOjQ/?=
 =?us-ascii?Q?GUJu0TOtoSzcFfziB7+91hEKCYv5YVBmNwKhMHOLDr9rBc1ffSEF8X0gvX4f?=
 =?us-ascii?Q?IXEEtRKyx6MuXlF0jK3oR8uoGeXwjxWZnhOTrH8ylpGt+HaPHN7FKhRMp8FO?=
 =?us-ascii?Q?N3G2IX2ap8veQailhlganWUQx0YBvBUBloRMSrGfO8objKKrm0skgWuQlCe7?=
 =?us-ascii?Q?z4rVPJ6e/mi1S580m8F3vI1WVgeNQaLkygGmAnM0qK52wjSaw6tNmsAnoac3?=
 =?us-ascii?Q?w/gfBu5To+wErYDUFzpkooXFaWDvJDS7cqbN299ee4I0oX/QvUhQ020fmOKO?=
 =?us-ascii?Q?UO4+KsZL5e/xqSuNYNoXkfuo3CHexRqZjhtkvpmbQyFVhUUobfTltKDf1w/S?=
 =?us-ascii?Q?hChWVIt0d/pHbG7Oo1cjkgU9cC9Kj22f9bsNSIEmzoVuBzJqgm7WJhfXMqO4?=
 =?us-ascii?Q?F4C0twyzt05iW8pZO3ma9A7mHsuV7jam3R1xjfqIs1ZrhvYMZZtmbUlP5ky5?=
 =?us-ascii?Q?Q9D6uWc+1lsvgNByqV0FGg4Ot+dI81T3dgrv8eQCDTtOrp4csIsZGMv/Hb2Y?=
 =?us-ascii?Q?r3lYX8ddss+la1LjS695WZW5nlid7K/aRn5xw5qY9eeY1jgOtZwigneqv3YP?=
 =?us-ascii?Q?jjVN4CxS3EjhtQklDZbpCK9g1+NLzGrre6+wC1a6lekE9lXAiwU9XqByI9n9?=
 =?us-ascii?Q?8e/Qor8/r88Hqc6KxnFN5DfzwZKpwz4IO1Bdt7tAFOnqkRoSFW0zUAa7z/cW?=
 =?us-ascii?Q?a4xcxTQqERo93hgnIJSZTIos+WWJXspB2bhIFlf+tfc5N8XkFAn42aszNwvK?=
 =?us-ascii?Q?fttLZtAkiluZr0/qy9iHx1ZfFFyivf+VPAKiPF93S2Kd9zNs0M9OdJ1zSpsn?=
 =?us-ascii?Q?3+l+14J/75IaacjbQ9LrVsryxItWyj7d1JeaMJytEeCgaYISpgxJEuISwp7v?=
 =?us-ascii?Q?zuHGBQqILsfTldP+O+K3vvqXELDchMjAR+rnzzE85ZQecBCtxaWPYAmZQyuc?=
 =?us-ascii?Q?/m24W4hgjXY7oRblQSBNq/zCkWBgDuBo6YRw+zRhkKTh3Iu44I9Fyy1co365?=
 =?us-ascii?Q?G47smR1gTtlXnR6+nMHQTVoL+OgZYQy5l1wNa3BK52+5E8N+BfHHCRkEpxrT?=
 =?us-ascii?Q?5xJN9LoLAY2cDayojaNXsdxusCxuVVGFLA6JNzcxAYazFHRPz27/4aWsJ1kz?=
 =?us-ascii?Q?2K8g9Tlb6s4nQtGYwuKXbfu5szrEvPg+KxgViKCZ77la16wkjFHhWbtM8xxv?=
 =?us-ascii?Q?/8VNQL2CNqj3eFQ/FzCWCGmMU27mvnZ0V1QITAhaPxVTnDXVqiNOS2vmnDlG?=
 =?us-ascii?Q?yDVm2/CJ6Jap5oYetibJDylaqZf2rI8EscA/wWoXLVRFlDZzvbwsCMRGahcK?=
 =?us-ascii?Q?p9VheHuAt37eLN5ePCvNZKxRnlN9ogq3wVeFNM8Yo9JWOJunbzUOslQdfTDl?=
 =?us-ascii?Q?mscJBcaHdICTMpUBgtKt6XRPcDB2mZtTLZmSVujX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dbfbec4-6e94-46b5-4ea1-08da694a7d9f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 05:49:48.5079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+XRRjylGH/nyFvjLfBsF/gGZlNwBxkjBxMWgfPdu5LLhJ8jDB/oJ4tAmfwbdPHvfeEqVnZc1xbWeFdip5qZjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2937
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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


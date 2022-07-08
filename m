Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61ECC56B4E3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237816AbiGHIzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237479AbiGHIz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:55:28 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10056.outbound.protection.outlook.com [40.107.1.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B823204A;
        Fri,  8 Jul 2022 01:55:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjencH2yEoZkMBTM4siEKuvqo6bGzUy339IW0ovYGFIdNv2BrsYxFIeSjx11pAxDVsFYV6hhnxT5dvgCEX2Q7/8C1IJhMLdvH2ANhutz4ERJkLD2l8CpkSiXQXA0+g7WxJlFMVwImQW53bcp4+Tq0cfwXFRRj00fVJ9lEe5un8SSMsJokjM0vK2pYMrKRteJ+EBrVyWabAiIyITEPiAUaOeVXA6oOKDeqc5Zi+Hl46pBXEN5vSHCFK/8XNMjaFjsYwxxH/xUnVZZkJ5qyVf6ln7lHqYBohaeQfOhCRFcxfnt76Oj5q5HwF4fdTxs8o1tK9o0Izwt4R/NESaDW49crA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFq1v/soRy1/PKRZfFG3yla4ySPLxECTvPTdp6CXbQs=;
 b=mDq5SbYltS0e9DaoN7wVaSvwUtyJtdIRDJU/slGoal4POEbXzjjy3s/OxyA1FzpAyr9nqKReuvsb+RgsdiBdqfhmuIWLKv11V+Fsv+0jiN4O+BY4cLS9TWi/ywEd3ev2fr2egOR/rX1EiN0AqSXDeppRw8x3Puu2YH2dTf8yRlwEq2J+k8LJON0ozsOIvcCXhLcRLjOz83FNCf/mgl8AVHKoJSR0DRbZOh1/TgVCf0pCT8JPnuk5r26LbIYBq/LdIatAGSu6a/FquoJt+UzS1thX8v4Dlfsto2PSFCaK/9f/71Qeg7gIBFYs5FXEKa+rRFP6M8YAzuZO26ADhHH24g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFq1v/soRy1/PKRZfFG3yla4ySPLxECTvPTdp6CXbQs=;
 b=Zmze7CSZJtRhSrQRiaEvoAaiRcDweO1twP27HnmpPliFtPpwn6Qq9EdKiab+p+eMuaHp5oloRPY9C8Ruhq6wpYR8I+k5Ini0/Fmql4ME5kyPL9w3ekYYqs2e6C/qo4i8YLFlP/FlS5EI1K495DAJVgsN1QU2V7fNOBiqW97tEvU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB6503.eurprd04.prod.outlook.com (2603:10a6:20b:ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.19; Fri, 8 Jul
 2022 08:55:24 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%6]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 08:55:24 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abelvesa@kernel.org,
        abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 5/7] soc: imx: add icc paths for i.MX8MP hsio/hdmi blk ctrl
Date:   Fri,  8 Jul 2022 16:56:30 +0800
Message-Id: <20220708085632.1918323-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708085632.1918323-1-peng.fan@oss.nxp.com>
References: <20220708085632.1918323-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::14)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13d335e2-f857-4653-b5d0-08da60bf9865
X-MS-TrafficTypeDiagnostic: AM6PR04MB6503:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MczozFcGScVWo0zRIN8vCRKkDGu0UzTapZL4T7fWdyGa+G+gSYC8dY+EIhMzM8DDAwjCkLeArsucoLIcO9+h+uolvghXhFauTKS31NYcRlL3Yi8xZ+Uf4eu08AxY/laKMkQy2fPeB2gR41T1TsxC5doCcUTlxqOdtQ3NTTIQ7LqWjmMemZDl7B37VQMjmnZqAj/M4xDsA/67/5myId/NqqwCJ2nn49uRZhpoaHumDP1fy3QdLyXnJcV0IwcoEv1y9PXK3bd51fjplmUY21fjh3iZuuQG7j1LJZbfKMLbK7PpidOjS+KPG0RtfavkP8/oeud1rON2FhkZHu63/M2kL/uJtUAnHrLL2Wag15aH3MdcrSZs0hQK1P1s19A1dKydyT42jSao7f62/1ge1DL1QYiDajRSVpGWloZi6oPJ4ICT3eh0xQGhNNlGC8oFeprOjZec+7sJZHbWN7MHsORnwvctc2xlErwHQ+0G/NsslPeRmpr9tX4qKQ6ecAzRAn5bqiy2PGoEJDgxl94Oyoq+D5Zh9xdnrR2EQZywWJ2lhcjGowJZfuEaQRQEIE7PHCZQfQGGxqwsG1ToRhkxuStcY3tErNmLusKodT+QYDv08BjVg7v+amXSu6POd6T99fPLux2kJ+OVRbO7voT/aQ2t6lYmAzxCbm9R4qHX9DRYhQdTGrBXR7Rs+/sFI/zmH899ig3LXotgqXojMuv+o99gQZkBiJe3QY/FtW+vzgZPhEFhEamtykX0Uw33ThjLqV/ujpG0h/moBOibcz73tOQWEehwobh0zZBLzHm1N8XK3M7v1SRS4IqTJ+sD3sYWpT9lrYDNIs72oWwS1y2T5EoQAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(66556008)(66476007)(186003)(66946007)(2616005)(8936002)(1076003)(7416002)(4326008)(8676002)(5660300002)(83380400001)(6512007)(52116002)(478600001)(2906002)(38350700002)(38100700002)(6506007)(26005)(6666004)(41300700001)(921005)(6486002)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GyiDoAhWFf9wETSLSeDxXqlB8Ai5FRq14q9R+E/cNa466OD4hwAs3hUbtKLm?=
 =?us-ascii?Q?8Nkkk5sUSHEgD2MlrH2/UBSvsd1j5NZOrwJ+sDohbvOf+S9uSsjYcdapvjnh?=
 =?us-ascii?Q?rqTYG62/1qI8Hjk9y3GOz38aJH4JhLnzkuxjrgtNYIYaLAj5ObSELj79shXM?=
 =?us-ascii?Q?2G11KCl6/99tu/M7c+0Q8UgSsk3xgdocff8yHkqMVc/iYgO/xsVvW2Byq3lU?=
 =?us-ascii?Q?mZyIfZWOMZst+t9n9WymSi0usmGtoAt4QPkfdBEIeabPUFateMHwENPrcNg4?=
 =?us-ascii?Q?om8EfWP9cVok1z3G7Jm611i/LXytYt703RzeG46Ny18w8iLXgxsj9KTu89xX?=
 =?us-ascii?Q?yLNpY+3DYOFmfbCQy8AQE0GYNtOl3Q4KROlM+wkz6nQS+4hi+VMakMwuAXOT?=
 =?us-ascii?Q?FV247KhUwuZxzwjKIamNcKsx/VZAgdBjXfZoaVHB5ZEiKKDmbQru7k9uznSr?=
 =?us-ascii?Q?QXNbmM9XHLZ375BRYEwoHiNqzkqyM8yemdHZpt+/1zFynSp+ry+4oouBdnAz?=
 =?us-ascii?Q?XX1qWQk5/e3TcSr1hbgBAKalwBp2WHrYyJOX2/OrNZ5Kr84R/c9s7PTStMXh?=
 =?us-ascii?Q?r9b8kLkGJKa0HKW8LEtzP53v8f7Rqh6dxVGaCEnzevqEANDqVhAmlsfsg+kP?=
 =?us-ascii?Q?P6OAD/fbrWT9CvxhlknsrCFJf2Tii3ArKrtYJnYWgllVwtHa/Xyc0UnLzfY6?=
 =?us-ascii?Q?X4HCHjiXXB8xaicWmzaOKFi1DgAuaMgSMgVR4CrOUp5elpHBZVZVzUXCjraI?=
 =?us-ascii?Q?DCoQ9PPDDKQhNHUHip8Q6EdrBLLdFwZwpSY2RN5VnaipWxgTVnH7w3hGXF7B?=
 =?us-ascii?Q?9TzuLFgJznYHFSPl2WB3wvJCOxtABAgzU7kzH/lVfn9cMLxAvhAw4oGvdzsa?=
 =?us-ascii?Q?Q9FIVQIo4QSvLqdSP1FsmAROu3b4ZYXprFwE4JR/WHEVNc1Ypau4zYUwaklm?=
 =?us-ascii?Q?BelDJwVP7bkhR97xFpdzFPdtwI+t1olVnv64/KxEMA1yGARItxgdKzr/D16F?=
 =?us-ascii?Q?zZ0HWZ931MJjQUF5yiZaf2lU+NWgf7QysAnwv/CW5NmzmytPqAmRP00zIp/5?=
 =?us-ascii?Q?BKN8KgLtsKMQOjctPedKdKN8cHhnusx1AednDD1M8RlWhgDP8NS4hNsRZSeg?=
 =?us-ascii?Q?aO7SPFrc0vq2EvJdS4mbvgrunRhgP7tMit/gQrDNijxYGxrkVPPAMLoLZLhC?=
 =?us-ascii?Q?fweWxGNRkDURUOy5a3WdDpZk9nPZPyLrEchZ4a04aGszS0PLEyI43JaYw1an?=
 =?us-ascii?Q?jAG8aML5bv5vd+Hp60DuaBwLTpP7e4IQ9Ceai+2ssGyqVEgrhSpPSb2YsmYb?=
 =?us-ascii?Q?BapC+5LsIjFLSW2LwvsACsjtwGmGPX/rX4E06EX4tIA5xBliFceIPVJ4+2CW?=
 =?us-ascii?Q?evbahunRVV+7oOFVzHd4UwN6jbHxZX/5XiKVWZRi0FAbK7a910Zs1XdZfUGY?=
 =?us-ascii?Q?7kNzkjs8eoRm3XHp0nX2ROJEu9HBHbxeLamGy54w7xsb8Q9J/MQLGVgRbql8?=
 =?us-ascii?Q?J2oss6EUAe94CQT5z6qBS6Pq9Ds+ZuSOB/LmH0uHISAxluYhhG13CsQCxysC?=
 =?us-ascii?Q?/aS6Y+R9voITLhA/U7Fm0Nze0CRWnpq98rKPWVVh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d335e2-f857-4653-b5d0-08da60bf9865
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 08:55:24.0043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RDEe6OlQT20Oiw5P5IyS/tcxGQ1diuTDUJ0f+3yyGoWRlG7Y1i+9AHfDQU9PTqZ5s4PW7E9eYhSzOiCca4NZGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6503
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add interconnect paths for i.MX8MP hsio/hdmi blk ctrl

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/imx8mp-blk-ctrl.c | 35 +++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c b/drivers/soc/imx/imx8mp-blk-ctrl.c
index 4ca2ede6871b..6f983adcb47c 100644
--- a/drivers/soc/imx/imx8mp-blk-ctrl.c
+++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
@@ -6,6 +6,7 @@
 
 #include <linux/clk.h>
 #include <linux/device.h>
+#include <linux/interconnect.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
@@ -36,17 +37,22 @@ struct imx8mp_blk_ctrl_domain_data {
 	const char *name;
 	const char * const *clk_names;
 	int num_clks;
+	const char * const *path_names;
+	int num_paths;
 	const char *gpc_name;
 };
 
 #define DOMAIN_MAX_CLKS 2
+#define DOMAIN_MAX_PATHS 3
 
 struct imx8mp_blk_ctrl_domain {
 	struct generic_pm_domain genpd;
 	const struct imx8mp_blk_ctrl_domain_data *data;
 	struct clk_bulk_data clks[DOMAIN_MAX_CLKS];
+	struct icc_bulk_data paths[DOMAIN_MAX_PATHS];
 	struct device *power_dev;
 	struct imx8mp_blk_ctrl *bc;
+	int num_paths;
 	int id;
 };
 
@@ -144,6 +150,8 @@ static const struct imx8mp_blk_ctrl_domain_data imx8mp_hsio_domain_data[] = {
 		.clk_names = (const char *[]){ "usb" },
 		.num_clks = 1,
 		.gpc_name = "usb",
+		.path_names = (const char *[]){"usb1", "usb2"},
+		.num_paths = 2,
 	},
 	[IMX8MP_HSIOBLK_PD_USB_PHY1] = {
 		.name = "hsioblk-usb-phy1",
@@ -158,6 +166,8 @@ static const struct imx8mp_blk_ctrl_domain_data imx8mp_hsio_domain_data[] = {
 		.clk_names = (const char *[]){ "pcie" },
 		.num_clks = 1,
 		.gpc_name = "pcie",
+		.path_names = (const char *[]){"noc-pcie", "pcie"},
+		.num_paths = 2,
 	},
 	[IMX8MP_HSIOBLK_PD_PCIE_PHY] = {
 		.name = "hsioblk-pcie-phy",
@@ -322,6 +332,8 @@ static const struct imx8mp_blk_ctrl_domain_data imx8mp_hdmi_domain_data[] = {
 		.clk_names = (const char *[]){ "axi", "apb" },
 		.num_clks = 2,
 		.gpc_name = "lcdif",
+		.path_names = (const char *[]){"lcdif-hdmi"},
+		.num_paths = 1,
 	},
 	[IMX8MP_HDMIBLK_PD_PAI] = {
 		.name = "hdmiblk-pai",
@@ -395,6 +407,10 @@ static int imx8mp_blk_ctrl_power_on(struct generic_pm_domain *genpd)
 		goto clk_disable;
 	}
 
+	ret = icc_bulk_set_bw(domain->num_paths, domain->paths);
+	if (ret)
+		dev_err(bc->dev, "failed to set icc bw\n");
+
 	clk_bulk_disable_unprepare(data->num_clks, domain->clks);
 
 	return 0;
@@ -510,10 +526,29 @@ static int imx8mp_blk_ctrl_probe(struct platform_device *pdev)
 		int j;
 
 		domain->data = data;
+		domain->num_paths = data->num_paths;
 
 		for (j = 0; j < data->num_clks; j++)
 			domain->clks[j].id = data->clk_names[j];
 
+		for (j = 0; j < data->num_paths; j++) {
+			domain->paths[j].name = data->path_names[j];
+			/* Fake value for now, just let ICC could configure NoC mode/priority */
+			domain->paths[j].avg_bw = 1;
+			domain->paths[j].peak_bw = 1;
+		}
+
+		ret = devm_of_icc_bulk_get(dev, data->num_paths, domain->paths);
+		if (ret) {
+			if (ret != -EPROBE_DEFER) {
+				dev_warn_once(dev, "Could not get interconnect paths, NoC will stay unconfigured!\n");
+				domain->num_paths = 0;
+			} else {
+				dev_err_probe(dev, ret, "failed to get noc entries\n");
+				goto cleanup_pds;
+			}
+		}
+
 		ret = devm_clk_bulk_get(dev, data->num_clks, domain->clks);
 		if (ret) {
 			dev_err_probe(dev, ret, "failed to get clock\n");
-- 
2.25.1


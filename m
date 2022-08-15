Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094F2592784
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 03:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240458AbiHOBa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 21:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240447AbiHOB36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 21:29:58 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80070.outbound.protection.outlook.com [40.107.8.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A2813CCD;
        Sun, 14 Aug 2022 18:29:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwsUrtS7S2ix5vPN3uscacY+6Gmd3iyOPa5cpyZ/ILnaBEiRvxQVv24AmRHdUlrRZ1yxjhNIEts/B5tmysRs2mvQuDUVnTzRDfvNqMisfp9ek2ra36cVHmunO+cr9iS6LTZ+3S2Yc7Azn7iB9RIadEVZ24zyvbA7IBahKe06qL+583+shiPlYKpo1I6NXcpY13s1nn0ACdrJTPcVB1ff9pz2uBmgxrqy/a6FppAys+rAFshUA7+hP5bLJE8gPoj2K2nPA3lw3xtDJoi4lovBX5sPs61VF4idfjj8t7kYKFM81OoBYQRiwe2zViaYlLG15g7R4zBAozCxlJUcQo3Jsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ooWsHNXuOu7qEVLoAyWWYR3N60VI4BMJLcgz5XR7ATU=;
 b=EfRAdHL3142uFmufA4u8xj1w7z4Ujh/0kk3xmy6W7zgnNOWfcGeWtGYf46aLHOUUc6pCMC0aObd1buBKSmiejsfq3pUpHadn20thUdL3zbDJ1qHJqc/ibi23MuSh7jRJ6qvRExku1NPrhPTo9ik3WbNlR1FF5cn+RY9dJKdId0U/gj7DLjznKEr1t7QapXu6swavFp/9YaLa/a7/Z6gI+twj8pwfUBivGyHjE68JASINIUXUxqd4ijTh+QjdOXOxE6HDLp9ss/xxmkRQ4ZgLXFqxjZz58Tf0qZ4gxhHg4zwNbhhovK62rPPvyADXE5cJXt5T3gufR5zN12LYW6TeNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooWsHNXuOu7qEVLoAyWWYR3N60VI4BMJLcgz5XR7ATU=;
 b=Vvmet/AbIDCww9jORuwgOIEaiMTVqVsdBF7LureomTS1JGCWfvkfw4U8bqEWMmI6QTHitTRUx1uniTqiGooDy4QMz2aDMoSGh2U0Sroz3k72kx/Yse4/M8LI5ryGM1WdL/brE0SrCZWeRNpImcG3CL+mk84GNjBHmc86kFxq1Ls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8751.eurprd04.prod.outlook.com (2603:10a6:102:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Mon, 15 Aug
 2022 01:29:42 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 01:29:42 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, abelvesa@kernel.org,
        abel.vesa@linaro.org, mturquette@baylibre.com, sboyd@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH V2 7/8] clk: imx93: add MU1/2 clock
Date:   Mon, 15 Aug 2022 09:30:38 +0800
Message-Id: <20220815013039.474970-8-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815013039.474970-1-peng.fan@oss.nxp.com>
References: <20220815013039.474970-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0112.apcprd02.prod.outlook.com
 (2603:1096:4:92::28) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0a31ada-f9bc-4de3-fe7f-08da7e5da0e1
X-MS-TrafficTypeDiagnostic: PAXPR04MB8751:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a3/oanDfMNaVQBGC1liBF/BPLLRcP+/0LVJ+w5MKwb/R4dWXSlKN76FiwjwMaa3PG2CiDBYAJSTGJn3kwsCSBHlGuCb+K33aAxv9pgutCzBG6ypsXGwNrDFjiWpcGOFzUg60WIVK7Jhc853jZBb6Aeag1HmXNfjExrJKClrgW5UTuDtidtkJs5AT0z7Dt77zREPC3AuZbVMS3Hwu7QUHf1HxojQNK/lb3ncQ2OHn74/Hl/ETcBoOFFmQmdYNEvHUSIMEfAof864vSyuQuGAI3Xyq0FYZqH0/JF7ytQvvvwXy62kF/rdOZ29xs9O2Qaenl4GLPY40gTWh5IwAvQISa6VwArWCSK/NvssefIc8B1CcnDPxJ8mVVv1GPZ78K9i+NdzbFmwZZOFIwh5qUTTfsHD4Nyah1cSuDhVlWhW9hWAbiwRWhf9htgGGYJqPDcFcU8zwSuSbIfPN4Sik6CCzkKLPjylBDKtnRU6bV+aw69uJHZJi9MJFOHseFimPqemlsGC19cCCUeXfE8DOwS7Xu628Strwk8tX5i06hkTvZLClUSZ9fbejNEijjf1hUyTb8VFe/TBsNtUmKmRRlSa/+mv5RAN6xqwH1M4hzOy+Vemy7u1/shHE6miw66/p9V6fqUEII4PkDHdZYmy6B5c7WQRHRNlz6W9pR2o9Or1GqstC/US8zpNwVH3+Zlvsm6Wf7J4mpXdRnilkeQCk8y7zzw5KwGVmHWzvLIA6y4bSh+9GZSbMdkwdigi9JgryoWK5AJB3q7yW7Tp+VeV+A9uKsOCLzj/oWIRT3kRwk6pzt1g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(366004)(136003)(39860400002)(346002)(26005)(6506007)(52116002)(54906003)(316002)(6666004)(7416002)(6512007)(83380400001)(1076003)(478600001)(2616005)(186003)(41300700001)(2906002)(38350700002)(86362001)(6486002)(4326008)(5660300002)(8936002)(66476007)(66556008)(38100700002)(66946007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nAsnescgYCrxtttK1n9i/t9AGGRQnGAYX/NStbr+UvnACNDFHMVaDjSsZTTY?=
 =?us-ascii?Q?/bTukMPoYBkDJrHA+EnMTWS4IYr8TLc0CFX6Xy2vIP8pYmHYVxIkAXNdfWag?=
 =?us-ascii?Q?kJXeNosQ42WtH74QLXkgQIs85QSPBA2/LrpbNuWNwiOvgQUqqjpPG+ethjil?=
 =?us-ascii?Q?znsqrBEBgJ6KhTrIbk0qrsUSLou9JvhXTZTe8Y933RmkH1djnSTF2vm+D2ya?=
 =?us-ascii?Q?gRM1YP9lZH+tbMgOBhaM1KoyIkJm5A7I28D2hvpqUYb66yxUqgT4c4ZbayBq?=
 =?us-ascii?Q?vAAizK3mQuNjjGl6+4hC5P8uXOrBvLhEIwv1clMfY63mxLSzUIQGz9pQ1urn?=
 =?us-ascii?Q?yKXj581VydUo8/SE1k2LFhXC9jTQOLNRJAkN+Amgvvc+5crpYJpzDITkMy0k?=
 =?us-ascii?Q?5zd488sDVrWHZmOhuoeTSVmijpBNTiiE9KyaadsE7ToPbrsqaR3VIZ1Cu3bM?=
 =?us-ascii?Q?+m6Cr5u+/df0884Yg//sG16iRxCtz0ZyunBiz0ObW4gRMSH10meTMzu/oXw4?=
 =?us-ascii?Q?G/tZDDCAlhoe/7NiN8zmq3g+w4yoqZfn+QCnSuHNJypgeaYpK1hSPkJtfees?=
 =?us-ascii?Q?eIdyOpSHHcffrxWIzhvcrCbJYEVLOnWugOtkPS/s6xbrQqkL95Bmve67AL/w?=
 =?us-ascii?Q?QLR6reEo9xEpYVZiP13HOwwJ+sgX4skjEQXk4gHonQ6sPm5UjshfZ6XWs0rG?=
 =?us-ascii?Q?hrVBdmg38CCtI0yC1SQrMm2vUhMlSZ6VAzwKceya40mWmJpZMhLj9iPVxaNZ?=
 =?us-ascii?Q?PacadoXJN5LwoE3sO6o7alN5FkaxJgy5iYeoEVz9NKW85IXS6hUB4bLcUcV0?=
 =?us-ascii?Q?V9OoH0OVqvkCP5b55TMnCX5oh83/WktQzh2B3LO/9buoMo0nZQawOiFYWZPl?=
 =?us-ascii?Q?XAWttVjkITCZLAMDRmGpmng9wwJYKxa/ga7pwtcs4p30UWl0UOB+5l3fr/Eq?=
 =?us-ascii?Q?HSZiK06UINQqwCzAEUo1sQc+MG9kIdzzIXvRRRzRLhcgWkODnC36dyTRY0s0?=
 =?us-ascii?Q?L+jYRimkPU1ebel1Cc8bQZ+I/c/0pOatSzVr1b7dllhgu1OX1GxdnIzEG1tY?=
 =?us-ascii?Q?sQVDLDGxPvUo31B8Hnc+9uOP/zd4f/qhrwdo+iIzRy8peEWLJ2gZtnGKi5Qt?=
 =?us-ascii?Q?j3gN90SLN8f8zMxVDFbMVvFSGubhNkLyX2DJxUXDCfehZHc9UhwsWa+rJyOd?=
 =?us-ascii?Q?GyBskxgcMAs+Sbp83hM49M2ygudAILrkd/WZN29WJGKo5vXh1Iw02GVd9xFj?=
 =?us-ascii?Q?gsdPbjSt+sS/AVqs7CaRbU0XTlqkEDEdmyBoJvdjUfQdC5Fk7V4mQTItb/uE?=
 =?us-ascii?Q?zQttTqAs6D3mbMPUjDpQUMXmYCcm+C1uWeaOv0ZvD7g4k5bGOC/CJ1ztOKls?=
 =?us-ascii?Q?EhcAim8vcluHUJEnrDuIc8Nx2nwcQ+rgBT1vxzGQ7XrW+MIOrzHny0LNdgSf?=
 =?us-ascii?Q?ghWxK7SN1I0+XaodYkhKJLG5xn2mCA0O3f8M2Mv8b8VmrFJU2m4NTsVIRcnP?=
 =?us-ascii?Q?rKzB6dGiRrd+ipvyhi46TF3nnqlegTrEFZzmpEHbLwcsn/wbGzLQFLgSFZrS?=
 =?us-ascii?Q?CF+66nGho3bIrgTHLYw9AnurpxXeNgkGqbrKwsNW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a31ada-f9bc-4de3-fe7f-08da7e5da0e1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 01:29:42.4288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2hLCLJHQRnVHdwqb7FHeW13a7n/tieYn2JKC1ZNBw+SdOoebIplLl6yA4ifOKxEPjJVTqibmDS4CKMEDm22GSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8751
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The clk tree should be as:
bus_aon_root------>\               /--->MU1_B IP
                    -->MU_B gate-->
bus_wakeup_root--->/               \--->MU2_B IP

bus_aon_root------>\               /--->MU1_A IP
                    -->MU_A gate-->
bus_wakeup_root--->/               \--->MU2_A IP

So need use shared count gate. And linux use MU_B,
so set MU_A clk as CLK_IGNORE_UNUSED.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
---
 drivers/clk/imx/clk-imx93.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index 73d30a2e64b0..4008ab075dfe 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -28,6 +28,8 @@ enum clk_sel {
 	MAX_SEL
 };
 
+static u32 share_count_mub;
+
 static const char *parent_names[MAX_SEL][4] = {
 	{"osc_24m", "sys_pll_pfd0_div2", "sys_pll_pfd1_div2", "video_pll"},
 	{"osc_24m", "sys_pll_pfd0_div2", "sys_pll_pfd1_div2", "sys_pll_pfd2_div2"},
@@ -159,8 +161,10 @@ static const struct imx93_clk_ccgr {
 	{ IMX93_CLK_WDOG5_GATE,		"wdog5",	"osc_24m",		0x8400, },
 	{ IMX93_CLK_SEMA1_GATE,		"sema1",	"bus_aon_root",		0x8440, },
 	{ IMX93_CLK_SEMA2_GATE,		"sema2",	"bus_wakeup_root",	0x8480, },
-	{ IMX93_CLK_MU_A_GATE,		"mu_a",		"bus_aon_root",		0x84c0, },
-	{ IMX93_CLK_MU_B_GATE,		"mu_b",		"bus_aon_root",		0x8500, },
+	{ IMX93_CLK_MU1_A_GATE,		"mu1_a",	"bus_aon_root",		0x84c0, CLK_IGNORE_UNUSED },
+	{ IMX93_CLK_MU2_A_GATE,		"mu2_a",	"bus_wakeup_root",	0x84c0, CLK_IGNORE_UNUSED },
+	{ IMX93_CLK_MU1_B_GATE,		"mu1_b",	"bus_aon_root",		0x8500, 0, &share_count_mub },
+	{ IMX93_CLK_MU2_B_GATE,		"mu2_b",	"bus_wakeup_root",	0x8500, 0, &share_count_mub },
 	{ IMX93_CLK_EDMA1_GATE,		"edma1",	"m33_root",		0x8540, },
 	{ IMX93_CLK_EDMA2_GATE,		"edma2",	"wakeup_axi_root",	0x8580, },
 	{ IMX93_CLK_FLEXSPI1_GATE,	"flexspi",	"flexspi_root",		0x8640, },
-- 
2.37.1


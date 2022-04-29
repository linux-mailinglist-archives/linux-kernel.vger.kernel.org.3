Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD18513FD6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 02:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353598AbiD2Azq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 20:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353591AbiD2Azj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 20:55:39 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10087.outbound.protection.outlook.com [40.107.1.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36315BC84B;
        Thu, 28 Apr 2022 17:52:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7pt3KgaXOxgCnqbryWkKYZWfnC89+AxpWR5N3pZ8fFtOEXzskmsHh36S97u8pwz0ywIF2pwe39Z4xNHrIsTpIddYeKtoSNpeX5PCuaJb3IdRY+PvCRKtAyU+NT1FxYf2uNDwhW5ILEwH3Iqrm+Ea92IwTMXH8qHnwukI7V/xO/40ncI/GatDE1+ErgztxI2s+muMcqbEFkCVV9dTWdzUOst43N15ElqPq65C4pky+oQXzbNLNjHhwwz2yUVUjI7AESKV09tCx4+NuUoQG38pYQExnMQrFEUFPY32w69NAtz8IF4fJAnRAWplN545v+iu4N4zqv7OE+IUotF+eQyhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VL6x8Q83Ck96DTCFE962M7gT794X42qpo/xnHvLGlhs=;
 b=l7J8Nz04cKd/VijSVbGwy0rgSRbqzARCvDUDr430tGDGfXwKIwXWOWdMtyuh7rpTYJMok6qu0Bwzmj7CDfKNpBYkToFrtzC+5GbOCcB+zlW8E/sqmYOPyhelLP3P5Pr4bCEHQWb+upXoO6yZkdU0O7tso9YhmovVwjn2AujNfFzImDIQsuqS13tkhh5/Rrdw0fg+xuN/K4sn1vkodaFwXvcaVfbQwagA47FHLZb8oPV5GbO1SlLHc5gV7k9QUBTQmGKUJFm9wdGzNj6CawtJDWS1BmUSCIb0MsCPyUEQIjJq12d2EHglx9j7HBgoploNKIT56FrP2948HG/NB6RWEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VL6x8Q83Ck96DTCFE962M7gT794X42qpo/xnHvLGlhs=;
 b=UgnZGuIPukyO+0enMoU6SA4J4KKkFx1ZJlwR3dfkIu/UuONM4MnVRE3s93zz/DMMHb84VIAz0pjauPftHK184av8VDB/+tpOTlgLwW1xdq8e39bdUwKKARGAY8s9H5U6qLR7je5Br3cMd562W4Dbj29LSuBlendmIbMUChJHQz4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6619.eurprd04.prod.outlook.com (2603:10a6:10:108::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23; Fri, 29 Apr
 2022 00:52:17 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420%5]) with mapi id 15.20.5206.014; Fri, 29 Apr 2022
 00:52:17 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/2] remoteproc: imx_rproc: support i.MX93
Date:   Fri, 29 Apr 2022 08:53:46 +0800
Message-Id: <20220429005346.2108279-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429005346.2108279-1-peng.fan@oss.nxp.com>
References: <20220429005346.2108279-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::22) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 208a2c92-facb-443f-7603-08da297a825e
X-MS-TrafficTypeDiagnostic: DB8PR04MB6619:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB661933C4387D73811F8D3C62C9FC9@DB8PR04MB6619.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uqIY2Z406pQ2wwsM0CHU+ufWZo7gRTW6Sfl3izKwCasfXv6uEJVarNvR7ltzTHg7irjzFr29Z8sNzPmywOqTi036DHp8U5Nrb9nDJt+RLTV+velaAw5QbEU54AfM98ycgRF2UFl2LMKwjMRJ/mSHZ1365xT5LOimLPZaLUSF7Yadfk/wZhJKiKagRIPBzmDBxYjjLP2DwM1m5Q11YwkifvFuaNEd6ehFeUwPIOA9XvnSfdKjgWnlxpezN7TBHq56ZvLHZKBZHvyxcd7HRtuMpDsDbghNDkRj7lnTf8NJDkCEA5fTxVAQ1aA8Q7HeF+6di/B6Qfbgu0jn6/emEiPA/m41XoSTvY+gthtZpeql0pNNPfH50Akom5LgFxPkjuePJHzZCMTuDno6eJEMA+p85u/fmMxJVT5/oPKWxtOFAftW8CSZ3Eh0XPgS76QdXHtsJuIeGFyUxkGU+KEPbiatwjOaSnRYwRiWt5dtCW4yhmRFpuvOgCXx/TtawagDf8R3mK8yZf7jXbaeys+9oZALSAyEdE9m5S0iDrIba7Y/o8HDV4ECIA1a+Or7FutuymrpRvhXl0tDGyBrUjPJ1GCf8Z2Ijwd0XN9rssH4hik8G+ap52YdhVRbnIsXWJN1RzAl3woQbgUftCIlPSx27INA6n8HTKqn2VM9iVSa6BUgRJkWDeea/9dgpsgOkQ0GuYfXGr2zrsKpOWsp5mi26EBkEDXAOBF2eWqq0O4Px6SFzK0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(1076003)(6512007)(2616005)(5660300002)(86362001)(316002)(6486002)(7416002)(508600001)(38100700002)(38350700002)(8936002)(4326008)(6506007)(52116002)(6666004)(186003)(66946007)(66556008)(66476007)(8676002)(2906002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ah8CpZTavE69ASCRKyjjZYsKj4ZGXziMqz7+aRGASbPX3pwdeXCkRBBp2YI3?=
 =?us-ascii?Q?DLQlEWJeyyGIaYzEZyayc925g+SfyKNWBCj4ZD0Q4f6oRaAgEmeRdeBOn96F?=
 =?us-ascii?Q?4PWqh0JEuIJIFL5X1kIFVz/9tY3GjtM+ZXeIN3bbB1/z1gnP/a5NYHUXuQQb?=
 =?us-ascii?Q?ZJunLxVsU63jHp+5THGkn5Loq/rm2kJdWxIqxkfrnA+Zw5MMwfDc9gPB9zSq?=
 =?us-ascii?Q?IAIYpjsOz93wpTB10Upk5eRuKemXVFKnkaWvsbz9oKESdhgJ4xWGSds47Jds?=
 =?us-ascii?Q?6C+yrKxE8ajgIii4fqFkvfXcrsdCyD++mlu/pOPWKB7C9NsBj/ZkLcyjHYJP?=
 =?us-ascii?Q?TgMK0e2O4lFRjX4JxRtNSAru3TCL6zbIIcadrI+teTedi/BwQNrcB1iy7BkN?=
 =?us-ascii?Q?35ofusUh9b+dLfWA2DAY6B7iXJC86HAwhhMAyq+KvnyhhguBkBFpX0g/gNC3?=
 =?us-ascii?Q?cTJRrDAQ4j/JtyfuQI50ZI3TQ6MPkl24hsqdDue72eSAZVDlvxWtnYCyNYSJ?=
 =?us-ascii?Q?odtu6iPeWHYaXauKy2fJoIucM/qrRDVHyhTQpnIcqMT3eHQa+cvVmwK0A9xM?=
 =?us-ascii?Q?gRZYX68Zt62xtMXr8YlNUYcjQl9Es0pVmLnk8n8O7dub33MMqUOjfbEWi0in?=
 =?us-ascii?Q?gcO8v/0NewBDbBks5V7KG9wYBWgxAoQ0+EBVTYILkZ5x1IlvYS2xQrlpLWY4?=
 =?us-ascii?Q?vBNVAqWctTSgAxYbedftIoGsTR4AtKkMSn3AfXr/CSCYN9tnZiItObOu+RrY?=
 =?us-ascii?Q?VeSqiQxMposTqFWhquJy+Lz2bKO3lRuxoJ9/rl1D7IvxbiipzS9tBYfwQyyk?=
 =?us-ascii?Q?dJ3Vo7ukCNEQA+FGQasR3cadhKyvGApxJY5QqSeMzgP0UAFP3MsDRUATpon6?=
 =?us-ascii?Q?Y6Kv0exJ79k0OiXad5i5QYTVN4RXgdwbqFz2ljI1/kXLB2iKq3caGqICMg1I?=
 =?us-ascii?Q?k8U+sJ8R5ce0R2PCfbv3wPkilALU5j3vvLM1sNwfVdt+OBW09h+Yaw2eeS/s?=
 =?us-ascii?Q?xkSSkLSIx9cdLjR5XIAE4PQf+Vpot/EbsUgWsgprFwoWtn9fpAADoAlUhm8E?=
 =?us-ascii?Q?OT2wqgpoRswoDlwo1lwSmJgpA29K7f2PTWhDkMOpScUjZc8HpzpRGoempFwa?=
 =?us-ascii?Q?r8o5qidjJ9vy9zZMJN+yzbVcasS00UShxm2jTDR5Fz50+Uz37eYMK56TbRgM?=
 =?us-ascii?Q?xZMWwXky+zLQ91+X5YElfPyu7ctM3rvjJOibtOaHYlo/nC+d1ilMezks5Hhm?=
 =?us-ascii?Q?2rjjAtP4k8ALbhGTulnGKRsuSu2PHYymyZnk04TfjIONEeqQgZNmxyD8A99w?=
 =?us-ascii?Q?lSXcUqlKnWwJRxQ4qQMJKNmvGJ9iwJkuD5KB6GBDCn3JeppwCOkX9/Qmfe9Y?=
 =?us-ascii?Q?j7KCwMHopcsTUTFWm4OpjKAtH5PUlgHl4/BAxXP9PryLAr+s9gFkrHDqnbo+?=
 =?us-ascii?Q?k2sv7G3xpKtWnIo8yvU2vY2BBvUnyHDn7c1zodpLA+fQ4kvNv1HBo/twgrwc?=
 =?us-ascii?Q?T5dGnZY0qHLNKUXOjgJLj4hu3uLgEKa2hNoUvc/5gojII+i9d5u9ASzTwVHK?=
 =?us-ascii?Q?M6cMFXcRpiy/+pzgnliebtO1bbWTVYPLVr6Si3ULluE4ohd0cQZdVQUynb+i?=
 =?us-ascii?Q?2iWGvlv8AbFXrz52Nh0ILMVBLTusDk6JwkCnii9ev5hkDBxV2XgsHqZiW7SP?=
 =?us-ascii?Q?wIKiIZYRarv804C3OHn0SYK36FNBDUJT88Fm61MEZU7MNC712l6E7vnBVDI2?=
 =?us-ascii?Q?Od8sRyVmrg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 208a2c92-facb-443f-7603-08da297a825e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 00:52:17.8043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c8I0v9VfYdqQ1M9KC3RWxhACawVWHqR5+l/hL9xcgbm+VbaxJeI0ZCBJ1wF6QdNqlNpV+QXgCP27UGu8BvdG+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6619
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX93 features a Cortex-M33 core which could be kicked by ROM/Bootloader
/Linux. Similar with i.MX8MN/P, we use SMC to trap into Arm Trusted
Firmware to start/stop the M33 core.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 91eb037089ef..4a3352821b1d 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -91,6 +91,32 @@ struct imx_rproc {
 	void __iomem			*rsc_table;
 };
 
+static const struct imx_rproc_att imx_rproc_att_imx93[] = {
+	/* dev addr , sys addr  , size	    , flags */
+	/* TCM CODE NON-SECURE */
+	{ 0x0FFC0000, 0x201C0000, 0x00020000, ATT_OWN | ATT_IOMEM },
+	{ 0x0FFE0000, 0x201E0000, 0x00020000, ATT_OWN | ATT_IOMEM },
+
+	/* TCM CODE SECURE */
+	{ 0x1FFC0000, 0x201C0000, 0x00020000, ATT_OWN | ATT_IOMEM },
+	{ 0x1FFE0000, 0x201E0000, 0x00020000, ATT_OWN | ATT_IOMEM },
+
+	/* TCM SYS NON-SECURE*/
+	{ 0x20000000, 0x20200000, 0x00020000, ATT_OWN | ATT_IOMEM },
+	{ 0x20020000, 0x20220000, 0x00020000, ATT_OWN | ATT_IOMEM },
+
+	/* TCM SYS SECURE*/
+	{ 0x30000000, 0x20200000, 0x00020000, ATT_OWN | ATT_IOMEM },
+	{ 0x30020000, 0x20220000, 0x00020000, ATT_OWN | ATT_IOMEM },
+
+	/* DDR */
+	{ 0x80000000, 0x80000000, 0x10000000, 0 },
+	{ 0x90000000, 0x80000000, 0x10000000, 0 },
+
+	{ 0xC0000000, 0xa0000000, 0x10000000, 0 },
+	{ 0xD0000000, 0xa0000000, 0x10000000, 0 },
+};
+
 static const struct imx_rproc_att imx_rproc_att_imx8mn[] = {
 	/* dev addr , sys addr  , size	    , flags */
 	/* ITCM   */
@@ -261,6 +287,12 @@ static const struct imx_rproc_dcfg imx_rproc_cfg_imx6sx = {
 	.method		= IMX_RPROC_MMIO,
 };
 
+static const struct imx_rproc_dcfg imx_rproc_cfg_imx93 = {
+	.att		= imx_rproc_att_imx93,
+	.att_size	= ARRAY_SIZE(imx_rproc_att_imx93),
+	.method		= IMX_RPROC_SMC,
+};
+
 static int imx_rproc_start(struct rproc *rproc)
 {
 	struct imx_rproc *priv = rproc->priv;
@@ -824,6 +856,7 @@ static const struct of_device_id imx_rproc_of_match[] = {
 	{ .compatible = "fsl,imx8mn-cm7", .data = &imx_rproc_cfg_imx8mn },
 	{ .compatible = "fsl,imx8mp-cm7", .data = &imx_rproc_cfg_imx8mn },
 	{ .compatible = "fsl,imx8ulp-cm33", .data = &imx_rproc_cfg_imx8ulp },
+	{ .compatible = "fsl,imx93-cm33", .data = &imx_rproc_cfg_imx93 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, imx_rproc_of_match);
-- 
2.25.1


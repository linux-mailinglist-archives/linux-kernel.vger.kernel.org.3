Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D27D5A780B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbiHaHtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiHaHsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:48:36 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39016A1D54;
        Wed, 31 Aug 2022 00:48:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/P33IiuMFkgXAwGsXqaVMM63H6kbFrOtehyYNAZvcy9fMyPTYYAtGNBVscWXumsYPvva7S4IJ0rs60mDG+7vEyzAeuCfuD0jX2Ux0hK+tVYxJyo7iD7zYHq1rWvgTzYyt2h/0VE7z/wT7Pst3VJCURZg0LWRk2d+IqxpmTdxH0Ujk1EcQ6FjbJGyHrS7QOu+IPVw2z2F6VChWMzzszBal9tumOfb/I5T1VSgrfwRmLATjIxIWtj/uH5HIGnoMDycKFdzqEULLWvg473iLnGcMjT6aaa4rFdp9n5tI4KlfLEHX+w5dQ79ZWd+b6jJ71FLrv/hXRRu1tq7dbRTSNJrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUM7aOtmmyPF22pctpZGtVcz9UxFrxDNpAzxq5Th8t4=;
 b=GYLBJc2+0XTLIXjm87r2YDi1+/xgnIKQmEWHUyPlfWnh+2mezh7Gts4tNQWfjLXaDYu7bUkVAr9nk5jwGSHZF0Wrk+czcNFNaBouX45GPdlDQl6wTBq4ImOEfxSgi10abGPosarzrD78RuFFgqvlQmTPtwin3/FfqBAKXyg2pDR0nbmbiL/2DtxHOUaX65vW4Sv+AQLx0NUHqjgj5fIMZKiJiHxM5TGki/0RLOc8ge6wXpDSYXoeBFWTYOzSNrZR4KMHVMpOlvEEEVAanIH/wNX0LDpxd/1ZJHj5/bP/C61GDCr9J0Vn1zYezaXvnk4QNiXcAaTdNWqxrhPQPwCL+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUM7aOtmmyPF22pctpZGtVcz9UxFrxDNpAzxq5Th8t4=;
 b=VqP21+EVhkKFZ5JA8U2Q52VYxkUSN0JM4Klaif87ul8W7i+PzpmoXyYgYyZPXvNLZ7K5vx7rGjTAupgwuYNKGzyQu9wJVv+npKvHqgebDl7JIuXR7Qqpg/71VstjvJSCZpGFbxCZUCoSJldyJVXbuaXXcBsDZ5KyPsNmfqynxLQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9247.eurprd04.prod.outlook.com (2603:10a6:102:2a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 07:48:17 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 07:48:17 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 5/8] arm64: dts: imx93: add blk ctrl node
Date:   Wed, 31 Aug 2022 15:49:20 +0800
Message-Id: <20220831074923.3085937-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220831074923.3085937-1-peng.fan@oss.nxp.com>
References: <20220831074923.3085937-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0188.apcprd04.prod.outlook.com
 (2603:1096:4:14::26) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86488acf-e4e5-4701-cf0b-08da8b252a56
X-MS-TrafficTypeDiagnostic: PA4PR04MB9247:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ePMtSQw0tUaZb5wGJ8V9FVETupBRw7QsgDet76+8h+FjH9xm5zq7iacAnoR+Rt3vQMLAPFuzBOr/0RmQZrS1frvaaw/oMhg35/j1tj3kel9HQxjKg4/utxwM04/iTbq7W9rv5negkL8jPTF+/Nv2SAPHFbyaA8DQBnQ7o9F1ezUiklzcTzOKbdmSTPOcim2gNwOp3oVPT6zhTGqfgqrg0DJayktMoXfx0EVm5CxaLTaD8fHy865+zBYL8S0wazwfuROjZDj9gtOJ1mZnytzFd3qEFG4P+L6Gpuwzs6NF21AMYUNzTNyGA/xrZVIqHn9BWp/7wVXx0vZwjIgJ7QFPM03QGlVYxybrda7ib1jfNveYSQr3ilhNX5txiubBwI/1zG3PHkT4qKyW4T9PGkeYA0AgOPQ6ugB8rJqvf16ueYuTLqa24jyUJQFlhQEb4FPqQ5f9JOMiDwSC02vVdsk7c4AWo5JZJKrqTQkF2Gs7a8WqA4H8j2UREOgrvHVq/KVP9abXB54L3X0h6ujBVUiZ636mFEAnvFH6GxlFoT4GSZ+Zj2ex8h5G+129RGEl3B3f7DN06YDugBkSy0VwVzlqWWz5f69TTR0YmMVUpTb3Pwj7a1B4fEsf56aKyT1dYHxK/x2oCn3VWYOfFEs0bQppRLm0Sa5msgpngbzGnBszeot4wQNxzRd4/rAgZYnjDOcSkVabqHJlW47Snq2IjAsotS6QHwB2it3jI0NRFV/pwd0bO+tRhrBPAdm6tSRLKL4w/Srkp+XLHDYLVV4tEqMdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(66556008)(66946007)(86362001)(38350700002)(41300700001)(8936002)(66476007)(38100700002)(4326008)(8676002)(6486002)(478600001)(5660300002)(83380400001)(186003)(316002)(2616005)(1076003)(6506007)(52116002)(6512007)(26005)(6666004)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xocKuBhXYTffDk2lt7InV+b7Sdkj+6TQBCt5ZjMDJU8rnQNqcer+pFQlWBy8?=
 =?us-ascii?Q?se8Ff3TTuCkfeetoSoc2bMZwBR0nbwTcSA2JGc6qo83FReebMX+FfOFpIG4a?=
 =?us-ascii?Q?pQzkD2mc5t91WdzXz2Fcx392CTlqGryd9CPsDwV/d4spnqUh10jTMOWZHOxD?=
 =?us-ascii?Q?2OEJ7Pn6GY+tzz6l1a/65naEau41hwj0BCE7jWruje79InBnkje2ZvpHTlJk?=
 =?us-ascii?Q?D0V8/6uDAmd/BieeAzHmeKk8395bzwg2/wdcF5xVpAJiKZ989jUmtqb3uUBi?=
 =?us-ascii?Q?EwOaC03ctsbvONeQyyaM+NZZNrBwsMl4C1wE76E02hO+rzXnaTSiOaWN/l/B?=
 =?us-ascii?Q?PRbmWy3J6nlasI6efJD3gZQfc8YJzA16rrEEGODlesB3eTwB9DZ2FhVv12Mm?=
 =?us-ascii?Q?WSPnaK2pOf+97RbWU5RrSGS8FXTahSirlR9Vw9L8/tGDNI9geftmYKj/OJoX?=
 =?us-ascii?Q?7c24F46qb3cz7RWwlEvADD0vIkldbe4t3P9yfYM9iBto672J/jRkKgWbFmiv?=
 =?us-ascii?Q?nNGiWPr9H6RA3mtxyszkEs+tqzw1xCWKEywybOkeaAu14K7kKrqB1dD9RBlv?=
 =?us-ascii?Q?w+KZFKESGtszPeoMAKL2sT6ffbR6OLS+OSqeSknf5cgdUJQhK1wzCfewnDn3?=
 =?us-ascii?Q?0vZlhV9MJ+kvhjXJ1UksQMiol2T1FRZ+UVbBiCnD5m2XVLjHVWY46AIbJjPO?=
 =?us-ascii?Q?0jEJAYikLhe/O2pZwlQAyReusKQmeZXrVdLUS8iD2Mr5JHq+scW1XPP9uv0b?=
 =?us-ascii?Q?HIB1wlGj9MgN+gn55KmVsBPIjQAzkGdu5Jn8NvHW22Sxq0K3DTviYaRCLzUQ?=
 =?us-ascii?Q?IlrkqUMoxyfLuHSB9bRpA2PHenBvPjQA9/7MVbrB8UIPJZnKXaU4E6lT9Emp?=
 =?us-ascii?Q?yP1wa0xjNWK6RRMyBOnVXwyaYw6SDZ1Ng2f0OkFdfCa/jVDoouMnTkhR9vEj?=
 =?us-ascii?Q?+n9meCBalVPKgVmdNS8qWjs0Vg7G9aBZcrDO/3WYNFNBT3thMApihqlKEM6Y?=
 =?us-ascii?Q?4O1WQr9nk8yBYfiZ3vEzseRQk12Pf4vvkdTIJnkhcm85TVsjkyzp5gxs9Oxg?=
 =?us-ascii?Q?w3cSoZd2txOU1JV7u5RHpsOUMeiJDGgWqqJtVBbAtx7+oWR5Rg+55LVDq0yM?=
 =?us-ascii?Q?FcNuntuuYLx4jdlp+G6F6XWvWulUrMQDgacD+tvyuaRN9xQAf6/YWi24YFfr?=
 =?us-ascii?Q?nMHmmKfbfIRtJSVBZK0zuVTnDopyK8xSZ8yA9h6Fx7oKB8fiV4hoa1fXW0tD?=
 =?us-ascii?Q?Rdzbss7CrU8PzEQE3e3yq97jV2zqOHp+lmiD3ftBhTJszvnNBRkCXMyZhdKG?=
 =?us-ascii?Q?1iL8mJX3vDEjDd2HXqummzAN9YW6bLt8Hx5Bjcme3RP/F41zrx3Z1EwVv4uG?=
 =?us-ascii?Q?T4Bfi8yQ11VyOiryXnCV70BcTwrAwIvBO6lsE41AsSV38Iz72lUeUZ63zPV9?=
 =?us-ascii?Q?qRvjjPRkejnSMFk/w0BYSgJ/ggpQ0kBvDF5mNatMPCZPXbb1H0cVEGmYipQl?=
 =?us-ascii?Q?RcfhEqOFWxwWMAiaRYxitKajtBQ5SqF4nE+4CpqVhdMT7alrKGc60VS8N2Vr?=
 =?us-ascii?Q?chNJ1PMQzka9u9ZgUAJpl3jzOIzQ19ZoaZbDVlV5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86488acf-e4e5-4701-cf0b-08da8b252a56
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 07:48:17.0023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VrtHVOVND9cs7Vx9Nsy2Sli7VtzjPRyww3v1KJY8rRr4/742QpFqswu8lqepWm/IgBbLP3MCUkdz4BdXbgBpIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9247
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX93 BLK CTRL MIX node

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index dd76472ced46..47f98c634365 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -112,6 +112,11 @@ aips1: bus@44000000 {
 			#size-cells = <1>;
 			ranges;
 
+			anomix_ns_gpr: syscon@44210000 {
+				compatible = "fsl,imx93-aonmix-ns-syscfg", "syscon";
+				reg = <0x44210000 0x1000>;
+			};
+
 			mu1: mailbox@44230000 {
 				compatible = "fsl,imx93-mu", "fsl,imx8ulp-mu";
 				reg = <0x44230000 0x10000>;
@@ -174,6 +179,11 @@ aips2: bus@42000000 {
 			#size-cells = <1>;
 			ranges;
 
+			wakeupmix_gpr: syscon@42420000 {
+				compatible = "fsl,imx93-wakeupmix-syscfg", "syscon";
+				reg = <0x42420000 0x1000>;
+			};
+
 			mu2: mailbox@42440000 {
 				compatible = "fsl,imx93-mu", "fsl,imx8ulp-mu";
 				reg = <0x42440000 0x10000>;
-- 
2.37.1


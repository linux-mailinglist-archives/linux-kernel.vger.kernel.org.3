Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0514DD913
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 12:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbiCRLkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 07:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235895AbiCRLj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 07:39:57 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60069.outbound.protection.outlook.com [40.107.6.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65E94D60A;
        Fri, 18 Mar 2022 04:38:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WcGlC6omj2wngaCqgYS4IKY8MJWpszHpz5I3CjtmFevIEsBHCpqEeae0kAdp7OjzFN+gq1kB7ZW3klm3ECMDZCnEW+0s5eYeDHXpnNI8avEvaN9IDh+v4H5u1gFRePuMPLOjPvD5ZXRMix20ZToiX9bdqnIUf0rrpOcWxCZjaH0owNkPMXujtUE/HiiewISSQw0dS+hj8UQVCZNcCZ/ac6SK4wpIgd0zpSwBYH0DiS4upBiHEozwpUsD7PWdMpDFDpewI8xQ6mYGN1u/Bt3AetQbSkRsj8TPD9QEsSjdOYkH2KXZ/+95LP06bKBVIT+Ny/TFxNTBoxigtvIy+ZptRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7rupZoWa/v0V9YObLFPqvkVKkrDXmmtfL7PG1X4EnI=;
 b=JgldeKw0gOUXjd+QRFvSrFOPWud58c9TD2TBzuDgeBB8J9El7ZsXg3Nl2LEMNSjxNGNqgVZaRJTXeIDUgpA0LYuEBQonVh5YZ+vm2Tz45IMHIvVR2u30fz2dwb7MvRa5YABozOJinuzoZgmhp6E2iAmeqQ8d2/HHTnEp+5+8IkbMuyEXdxuVT/zaLWgOcU0hxlC5OaaXVUARZ9KF1R/LUtccKOyMKX3kEsD6WFvuqVxRWv9HnJ4ZwTp2sOXKke32DsM4Uq0nWknUvrFF0jN+Zg3znFGrESmgFEzxk1KTkGvvlwQfYcsoKGeitROzAaWze9xfex7Hu0rEB4RG6Esgmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7rupZoWa/v0V9YObLFPqvkVKkrDXmmtfL7PG1X4EnI=;
 b=fxvFUs/4T1rXBCizjhs9wdGxTNdd557Ql0o3Ydxqmz4WMlH3EaWQg903NXEeh8fEB5aOd7xek5WYXWAROZZs/JW4NJSQ9rNzbw6KwLHj5vKcbQFZO2tpTtN30ot/MqfkyTQZhueEWupAHDTssj9hFxOOJopNVe2qjOlK2ZxoNaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS8PR04MB8483.eurprd04.prod.outlook.com (2603:10a6:20b:34b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Fri, 18 Mar
 2022 11:38:35 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::6972:1f59:5d1c:e557]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::6972:1f59:5d1c:e557%5]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 11:38:35 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     robh+dt@kernel.org, krzk+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH] arm64: dts: imx8mp: add ddr controller node to support EDAC on imx8mp
Date:   Fri, 18 Mar 2022 19:35:26 +0800
Message-Id: <20220318113526.15986-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::9)
 To AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b38cc238-7577-4933-3213-08da08d3d648
X-MS-TrafficTypeDiagnostic: AS8PR04MB8483:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB8483BA7BB2205E5F6228338392139@AS8PR04MB8483.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NvzdGkFS8W/gh01FqbBeBMvoMmdaWmnlHdpQNx4iAgXrSQm5dxg+89opMvKRCkiLjh5CKz6Y4US+O7xRt3OpGf95qk0KDv7ruF0TWp3CEdThYEcVAILuKgXoJQIZbIC6fHZ7XJTj6tVkGJmymKjY5/gp5AHjPya9wqb51+6QkIPIAhL5mPoJYxQ2YMMWU22Om2z1KeBYYkJYcT94DImXSg2ZGxItQkQF88/I69n+CCqiyuSONUjNjNE8XGp2FdCxTXlifgwa6XsiejWD4NM+MhbWRbmxUfelCZJ01rcCLLxYCktM0QnCqFrDmRGraQE99JDtzhzyT4nU69y/4AECjF4rAq6ydS0BWxNv/mM1EWBg1X6feQdLXn+6aqQozmdO26hPQts/Jf8EmpNZjxWOW1ZMsI4ao+YUvLDQpzutBJS+4ygxw6QEIc+oM4L24dz7tdbthf+8n0tfPqPeewE+ibR+QzaMCFexstObFYzneVfA3Y4vT5fulpnWBh8k49Q+4xwTVY4rru+MUgsOubqiCsNJ3m3WdC/eRyX3Y16FJ533T1mMcDkbxhsQO/khVr9H/PdUuh6ttZ4CwhxMlFJTygL90/mY5HWZ/fyOyaUTQE72qRV0jPI3T4dYYnMhwrO0au1+HKKOtJ4ogVXKOFR+f8xXAPwQ9QnvJYT7SWLt0Q8n/d5oUzye2aeBH+hytUm5FY/NLbeML9+RmUEU/SvOKMfqNjBaHFFgIjDjIXZ2Hk8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(186003)(2616005)(1076003)(316002)(2906002)(38350700002)(38100700002)(86362001)(36756003)(6512007)(8936002)(6486002)(4744005)(44832011)(4326008)(8676002)(66946007)(508600001)(66476007)(66556008)(6506007)(52116002)(5660300002)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9ikqoxkEReQvjrAGDG1jcGVhWbqcawkmZ/VpnacPc5pWNMZ+tpukYL1l1/m3?=
 =?us-ascii?Q?gNKFvXWj7OLdJGGANigSCtYMLqqNlPmmZm1yjNdCTCT33bJ7da84+RPtkhJI?=
 =?us-ascii?Q?64tKfrrIcaYFQZvKDPFjAiIEvLqpaYQ3G2P7/nVrTS4JudEaSLdAuN1TeMkZ?=
 =?us-ascii?Q?hg8htAH5AUiV3N26YEdkUpJhf6NUFSCWTiu/mgmELgadBLb+Ix96gNWYL1rs?=
 =?us-ascii?Q?vYbacwdvjFXz9KzT8pJr3Zetmb+5MU0y9xpe2bjsO5ltX05FhxJ/ZNHsRcsd?=
 =?us-ascii?Q?5kmmkAW+y6Pb+qd/suTVIOiapinFHmEG/jMonXoj2IAfiJ5EfkXb8PrjM1XJ?=
 =?us-ascii?Q?iXtX3gViJ0wKGY0zROP2snfHfd8IfrWlkRp9tYOGzFzZGDTeeA0zZP+pofhK?=
 =?us-ascii?Q?IhlsSt318GFuUBSNSF5GZBvDBcNxnoV32hrMDp9vPE6m1pbqYIBNCkFxKuXn?=
 =?us-ascii?Q?wQDeT/xZDIpNVzJXf8HHvKiqxb0eSiIs3v1oBEl7JjcLuuRberD5f2sVXGLp?=
 =?us-ascii?Q?ZqxQSVhxnz+vGNHeOXQOaVVSz6NukmYNXInh2ZDG/N3uHHuRKNSfyWqGHZok?=
 =?us-ascii?Q?ga9g3cxtpFSubAkAmIsdfqDba1Tgx/vz6yH4wnYKzi4t01cMyHna6y42t+7Q?=
 =?us-ascii?Q?MH8lLCfREme/fr4tEyKMbs4b5ohlQs0RVumRnCzGIQItMGiEV06GxKMiL9Ue?=
 =?us-ascii?Q?Xnn7FlFPLpmqxH7iWcNUmtKTrT0wvTHCyV2lKnEbPg1SAF30zxU2wJxMUJF2?=
 =?us-ascii?Q?JZWZifZdIns1FmnIqEqxqPq0loShg2sHgjju3GCYMMT7iqtYLYuKvibLSZpH?=
 =?us-ascii?Q?HXdwr5v/KnWdFZI4XjmA23K/OdBfkqO2xIRXMDs6CMBy2kc83rA7L3LD++cu?=
 =?us-ascii?Q?ebTOOolUxc7tJv2C42vIMkfvk1Q28aFFf0qBmR6dbtJkVJES3YQnW4HUIqu9?=
 =?us-ascii?Q?aOwRehNgeLDzJJMnZjGUPqEUiKFIffsGFUX3srjiLUHg5gJUJiG/HHT2hSEh?=
 =?us-ascii?Q?O1j3ogqFvsaX/DHJAtNYco8kRO6Btx2LIRf+51NEh1JTsFvim2ZfX2m7lgUF?=
 =?us-ascii?Q?z0EB9jgeOl4k+K4Qz7+X/xDDuJodc9DjG1Dkwt3WNPavAGZD0kDdTic7kzFn?=
 =?us-ascii?Q?EtNMEIRtkxt+1msfXGx8vJrsvPI8FGaAtBHSagML8fOZHtPZxcS5EfeG8G4G?=
 =?us-ascii?Q?HFn0rXX4Mz0ADEPzECxhMQP89dvSbxMMnDHk9kPrUA6Eo69ubecQzc2hBHfj?=
 =?us-ascii?Q?X1dog2d8nk7dNrsUlGtuWkdUzoYh8/86Vw/KJ4FZ0hU7+tD+3IsblN6CKXRa?=
 =?us-ascii?Q?L9qyoHQC1fK7pk5PfuE1KEapPfsk8c7nMUBiRQ4H+hf3Wwq3EvD+ZsFN7kSd?=
 =?us-ascii?Q?Yx8QTw1uRbw5dzUJxKyRQSJqDEAue5ZlDPKDFxVtPNp2V8OHs50O3y/43k2S?=
 =?us-ascii?Q?vgHrR30YmVeUQ7aBZdH1rGXqgP32AjU4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b38cc238-7577-4933-3213-08da08d3d648
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 11:38:35.5649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CkkRegA5Ofl9dF+H2GqzxOC27PARz4K409tYVxJOi861eYGfKVu6e4R71txnXtuBJRvyAa2X1hB5o0CaN011bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8483
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8MP use synopsys V3.70a ddr controller IP, so add edac support
for i.MX8MP based on "snps,ddrc-3.80a" synopsys edac driver.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 794d75173cf5..a6124a11d6ee 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -902,6 +902,12 @@
 			interrupt-parent = <&gic>;
 		};
 
+		edacmc: memory-controller@3d400000 {
+			compatible = "snps,ddrc-3.80a";
+			reg = <0x3d400000 0x400000>;
+			interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		ddr-pmu@3d800000 {
 			compatible = "fsl,imx8mp-ddr-pmu", "fsl,imx8m-ddr-pmu";
 			reg = <0x3d800000 0x400000>;
-- 
2.17.1


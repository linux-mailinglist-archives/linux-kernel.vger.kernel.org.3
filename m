Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472E05A7ABC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiHaJ7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiHaJ7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:59:14 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80058.outbound.protection.outlook.com [40.107.8.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1DBD1E37;
        Wed, 31 Aug 2022 02:59:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KML9iTx2qWal6nuEErWu8hCirzkExGrtOBoTtQGqpRP2UUm5pXVSP34pSrl/I42k0z1+XQBArL1jZqifHFFR7nwt6+1breRueMAcqMiDutZ/nU/vCAPwmnzCwxBZE3ZeVv3WzCOCjyo6l1fWZfxBMIQQE8fKFm86+ImHqNryzp8GNqjo1XQwq0jivcLRTv/2xnevrm+ccIf1q+OcjeGKreHdTa5ujPTyH2a/x2wuL9rtNTySCoieShv+RLxKAMR2DjjvLckfDeY3036n1tGB9/h8ZPDEhWcY3yAUnN6ylmE4LOnf/SYCPTufcs1a7MKmSEQW3cVMGMxpLdRo6I0I0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfcpptggacbSJ++ABMHpRBtivfRnQwwmEb1OLhExWYc=;
 b=AgW/YeVzcNCn9Lc9o+hLB+IFlNxJKHGObagW3eSzHAubkqi/HIZpaRXjcVCceLowxwhN4UIiStbncSTV2cTjSZEtQgEg9gkJvGIlfQ8A4pT4PiNbi7RV3IY6T7LQPgJzU9HtazbaOCc8DT32YSWwfbyrjA0nYQd5hZcHm1NZjfydxXY1Ce3K5a7eLu6bGjnsmqhqPBUKw11IV3DY5bGDMdzHtWwn4NaZjaZdIqAcAazNlMp4H5TzJNkwSgtST/SSr5+4jn/fNNR77RimO37VvUNmtjaNNDLRzXPVaHGttafICs7d/x2LQDpoX8uOFnw60x/7MQawbpq9Ig5u9oU8vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfcpptggacbSJ++ABMHpRBtivfRnQwwmEb1OLhExWYc=;
 b=HPVbfv+vhhMKG1BO1D49HEbyO9IUSfQOdDBFRW/TIEbRRWp7ujy/i8CQAqlmk7L4Le7smy1nTGpCDvv9dHVLfAZDW+I4XlmRKXSLhuNqGBpqeSdUAWJQMIL8jItmmMN41yJIg8fEETrNStNeKOOZ8B7TEdPjZ5HY1sXsEEycdrc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB6439.eurprd04.prod.outlook.com (2603:10a6:20b:d8::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 09:59:07 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 09:59:07 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 5/6] arm64: dts: imx8ulp: add mailbox node
Date:   Wed, 31 Aug 2022 18:00:15 +0800
Message-Id: <20220831100016.3649852-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220831100016.3649852-1-peng.fan@oss.nxp.com>
References: <20220831100016.3649852-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2ea859d-c319-4dfd-c123-08da8b377177
X-MS-TrafficTypeDiagnostic: AM6PR04MB6439:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ulA3uE2EMruTDstpbJ30L8Am6zR3ru7yngQA2T8HgfuX1ZdaZrNfs2OmeUYSnYV4avr1FJcPrn3r8Hj1KM9tnr7JLiTqmSy9PvqMMtJbZJCicLUPtKoi25S5RA6uhrp8YQ74JnZ6zykpMpdxOfGlY+FNkeOqTQclN43lfZA4NxSW0o6LqcEZZhCqixk1ggv9oMAP722dZ+W99xnvg2Q0PO/kVF8Ojq8QOljn+DLGmjSySvrJVz9riFt7dv3IzzkwqIhhg/SZ/S/JGECTTdqcZrxVJw8/xyR6dT1th2Vk12SoNQWebM1wKa/eftMu/Zojl/jqVHG1ozfH45dX13N58vOFfFdmKBPZPz9ZqXNcy0JgA2suiYtb0tFhUsbVZR7FBU7tOZC51GPyaw96ec+tAthPOYxXyl4ScYlNo6W4MalXPDkkUgTpUyfh/7PF7Tgew0VG0luAK0QnQvidE0a+tv+4V1/2z4cbZy4Jm7YQ73wEBre0z49hqXgIRlUZC0ZXRjQ3JJEWN5dR0smG2KtVk7wBrFDZSdLzRXZibNucL/B8pStfKVPMg/MPWMbDQoWw5BK+wipj4grNBevw8EtKT2MgCEKGkcqShHmHKm1j1+TF1LgQ3SnEecocil+dRaxRs0z7DVIF8KF52E4jU1o1fj/JN23Z4Cdxns75qByvi0HGMQF5TNzH38syT9LnbGKHdlQBPipizHGWaz1kb2WhucD31ZhV2GvpXsBy1Nhbpdc1fWGTokRl5zlisjAWXAlkWtZEqa5LeIXzzy5N+Y8GnJKNF1Zjx2fNdRT0L+khkPA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(83380400001)(5660300002)(6666004)(66946007)(66556008)(38350700002)(66476007)(6512007)(8676002)(478600001)(26005)(38100700002)(6486002)(4326008)(8936002)(6506007)(41300700001)(2616005)(15650500001)(186003)(316002)(1076003)(52116002)(86362001)(2906002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XGaW/WSxIqx278o48C6XBSUbotPEiPvctHx136p/Hcp2Ymiih1ChO16QOe0o?=
 =?us-ascii?Q?qfulbaNA1p/HRzT9woEEtTSwTVSgCl/WTNn/c1KAbAx1+7jVdBlkWtpf7tIF?=
 =?us-ascii?Q?gsMUVZnlmz9fcq77Tv99wDABQlhYvJrMwYnihuD0uXOiMDA2Cgbezndt00Cp?=
 =?us-ascii?Q?m2dQ/qy66MsONPlB7aBfGbTU8msxU7UwtusM6d1dO8OwH15za07IoN8dDs5I?=
 =?us-ascii?Q?fBzcaT9va8tTpyBVyjQ5+21CwmdOfU7q+SkpiHzWKv7fKVQ4l2B4MxOJwkjS?=
 =?us-ascii?Q?nP1EQj4aT4PWslVALmsyhJyV3BZ3uxGVIsye4i+drbffSjcHn5e4ShOZuO4R?=
 =?us-ascii?Q?OQ/W8SuB0w7j24XemxpH/PFT9pYGVdOa8xEYjHwuQ5jegj1VKKxF4ehFJUQy?=
 =?us-ascii?Q?+ygPJo46bXm9W5jcbrESsY6DrpYD3PU97ogXnk12mTTPrXDFu+pdqPlfS7EK?=
 =?us-ascii?Q?UuUU+L898ELV3NemkZzYELclkeFaMzGpZbvlHQ+bvHy6Ha1gVeQaEa6iZJ5f?=
 =?us-ascii?Q?R4ULDijD7KRtaYEDzgUZEqOr/gHu8mBz3aS0kBeLeq0FXxpVJFwNU74TewLr?=
 =?us-ascii?Q?f/4DXNnXvKO/ij8R6WdOoij1jp6oiW7DJzhSVuhJ5/xYE3Hxsy293mnnmUCX?=
 =?us-ascii?Q?UCQQKLyekNWG+/lCnEu+1EFhUPRy74B82bsVt/TBLPnZJ4EswfLxyNoQ716M?=
 =?us-ascii?Q?iqbmfzEfoVx6eGUkO78a/FuRUR+bkYhHmd/DUZLlUTLMq9ux0ZmwoSzgbc4V?=
 =?us-ascii?Q?q0kLNFxWX5JVzwWi5t31WWN6F8xDgihnbfc112d6ADtISV97NWPbPTULkW5u?=
 =?us-ascii?Q?JbYFZXMKVc0rDgBfY8rWOrBJFx0O8EhdRSDJkOtvcEKtHt7M7xzI2QG0rLnW?=
 =?us-ascii?Q?ZEFcUwrI0N44djCgV2K2UEAuNXpUxz1Gt+zR/o1KEW9uz72uYpdx3fvV9cTy?=
 =?us-ascii?Q?yS/vM4U+ghhw3kxEOYBmpQzO5NPYAL9gb+zSXhEXLHN+EHdlcFmremSBCKqF?=
 =?us-ascii?Q?UpUj57whhEC9hm67coy+Qbovz8tUzvhTA75PDzO3+vlTWHjmJZNv6PteIJeG?=
 =?us-ascii?Q?1eeyTKBtwMNfuaMAVfC/m40LVs10XboJuo/NEsP5Lfa04UGKVIXvum46E36z?=
 =?us-ascii?Q?nJaciaN9M24NaQqmtut+liYVhoeNF8jXzKuJl7ViIBL8Xz17vPRHhpKnOoU2?=
 =?us-ascii?Q?TcQ24m+VlQxEdflFV4To93nh0maX4620uheFFzvhleAd2b71fDKm8WOq0ukp?=
 =?us-ascii?Q?S0dM/YcKnI4R3VkmjWFXbRe6LPFTghNai5tn0LY2oLzH1oHGHh69AXCJMNQK?=
 =?us-ascii?Q?DUr8wDxAPzXsm6VZRF2HCodsm8DcK0INdveE21D+4b4V68FJrzwgD0V3hHUn?=
 =?us-ascii?Q?9d21x5v8K8xhxlTJ7BjBtTvXAjp8kYv4j7sncinBiWzp4mOE9aJoVcIMuGAr?=
 =?us-ascii?Q?DYwDGZMl/TnXWccehB/tUsVz73Wt9DYRVzSyrJjz5ecH+b4TNrnoEcyma4aC?=
 =?us-ascii?Q?iAUa0lceF6EGZuRWmZTFKFbVtjzKYniSpFx0nCrpQ6FOgATdWwCGZ2HMqaxW?=
 =?us-ascii?Q?dLPgQDEPTAZOAAa5oPLtQ/68xybkBXkXo+Ds3p8y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ea859d-c319-4dfd-c123-08da8b377177
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 09:59:07.1200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qwvFOOqF84tKyFQPbmbQkzlDdVjh3+6hIPzH8mu++2eBrGqhs3BfpJmDg0cgJdNsMnJ9RMgWDcO6AZ+yS+8Pww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6439
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add Sentinel (MU)Message Unit, Generic MU nodes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index abec8ad4a8de..54ccf31896b7 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -152,6 +152,15 @@ soc: soc@0 {
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0x40000000>;
 
+		s4muap: mailbox@27020000 {
+			compatible = "fsl,imx8ulp-mu-s4";
+			reg = <0x27020000 0x10000>;
+			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <2>;
+			status = "okay";
+		};
+
+
 		per_bridge3: bus@29000000 {
 			compatible = "simple-bus";
 			reg = <0x29000000 0x800000>;
@@ -159,6 +168,23 @@ per_bridge3: bus@29000000 {
 			#size-cells = <1>;
 			ranges;
 
+			mu: mailbox@29220000 {
+				compatible = "fsl,imx8ulp-mu";
+				reg = <0x29220000 0x10000>;
+				interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+				#mbox-cells = <2>;
+				status = "disabled";
+			};
+
+			mu3: mailbox@29230000 {
+				compatible = "fsl,imx8ulp-mu";
+				reg = <0x29230000 0x10000>;
+				interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pcc3 IMX8ULP_CLK_MU3_A>;
+				#mbox-cells = <2>;
+				status = "disabled";
+			};
+
 			wdog3: watchdog@292a0000 {
 				compatible = "fsl,imx8ulp-wdt", "fsl,imx7ulp-wdt";
 				reg = <0x292a0000 0x10000>;
-- 
2.37.1


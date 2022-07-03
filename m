Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951ED564653
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 11:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbiGCJOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 05:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbiGCJN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 05:13:56 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF0563CC;
        Sun,  3 Jul 2022 02:13:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzNmhtMbzy3yWC3QTw3FjwywsLV3oRoUe4ID5YHCYDZ4ZZP97KZTHoeyEbhBmIzphQCbSG6/CQB16aC6srOgNklKi9GCRDUJkJr0vwlaQmN1BjGMTBRu+qyexUYnmY5izRmMiMSrZDMc5KN8W6rX7SpzaYD1s0CY4DO30CR+UOK+mOHQu68d9QEJU1xzdppZAeN3jZ6W1OIV991mEG04u1tYFI1WSPtY/UAncSjFBQbE2S4SOsagNOUbivD1wuyPzsYZ/hlBJ2zWcY0ja74eIYHa3p02Aa5mXiP93l6UT1K7HGhg8nJ02t3ms8b6KZPLqOxg7UAmYB5Xg8MTez0/DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Gl2/EPlcXP1Mp7SUNao7Lkppmwn9KkEHDhQjQB3Les=;
 b=ZcVFlRjxoA24pIKji9xWAgllnfv6S2WlffddzkprhrQ1PhyZ3wjxS1pGYn2uNMqjYn7VI+qlVdSBU96Kob22es1IA+KfsnXsvSSI/IvUVIWFeuafQH74M4qaXdYhwFOGr2nagfQ8ppb0C7xEa+C0a8DYztg8PqJ//Z8ZYsSZrlDyjO+gxTGEoUHV1DZXBm6uN69BZRO98B4+A3LCtnRBm36KeG0OJXHFBUyUdWwYHnzcBsWuYtHwaM4wyoQVjAVmxphPheSvItNYJE7NLzsr/hm0m8T4ejXjQHjT59VxkoJCmXo9hnumELb3RzhfZrEMju5gL65MRXdXtJDmoFg8Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Gl2/EPlcXP1Mp7SUNao7Lkppmwn9KkEHDhQjQB3Les=;
 b=YFs9xeHJnM5Ya1jFUVsR93QZEKn6ZLtIBtOQQ+rXJySDrW9/EZsp+wGanaNDUkp1CxNdudzA+6YZQw2JcVVbYQS4u6+gKYLArvXChi0FXidDkSaqi691AeZGKTDRjZuo1hvkWRIkSmUinjbT/sYFTj33rF2FTYGe5mToUTZyw2k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7768.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.19; Sun, 3 Jul
 2022 09:13:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%5]) with mapi id 15.20.5395.018; Sun, 3 Jul 2022
 09:13:51 +0000
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
Subject: [PATCH V3 7/7] arm64: dts: imx8mp: add interconnect for hsio blk ctrl
Date:   Sun,  3 Jul 2022 17:14:51 +0800
Message-Id: <20220703091451.1416264-8-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220703091451.1416264-1-peng.fan@oss.nxp.com>
References: <20220703091451.1416264-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47f80a13-2bdc-4898-e2fe-08da5cd45841
X-MS-TrafficTypeDiagnostic: AS8PR04MB7768:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PQ663PT5oX84hdvXCo+3rWNuigWcPaMlLEmsrf53KMR3r95mOPc00vffS5wJrUTxPCQ3XZqHOrBd73taBWUfZAogV5kbn4OZXM4Rmm6bgftGlCCK/C4PNcmQTrGHZxf721RdouTiFLmGa8Abhvk9O4p9CxfmcA+HwwpjhiwOxFofkSxM1bEynHriWUA5hcqLRDNwuywEURexsV0aXYpngQhtdaFzsYxi+v1LPDq24e7fvlsZO6YNzUfUov1nvGY6Wow4FfThC2xGl67hqli4TeMw9r6dymQ4ufbI68RcXoYi7vFBZ1bxT/JHVkEQbx81tqWkOOChLcQ0DZCBxtW5JRru5p1WJz/DHMWCW488hOvxYLv551xw8RAILVWiFRfI1DQgRtVEN+zZRHOcsgt96Ybg7OHfuZYnyBH1VBNxNfvHfn10lYCcMRC2b1ZkbMMnO5DEUDmeJFyQcc4bthbVU19ix0+7GviKn4p89WjYXyKSqCLTesT5acmGw9yOtYKUrNUd500g6cHN3WebJ28nHjJ+MUBwwiWcebracJoWup0wzwWK0mWn9brTr3L7w51jCWtYUnruPPaVRpnJOnXUPTI9tgz6ROYyDiQr+t74ecPyRHCluJbjiNhAA8HEaJAq9pwjSjYjVM6c9B4yIdH6LjUhA5A66bf9D56733TYDyN/+EMs0itckeMHXZGJ+vLAFgZONzzJ41M7VIPpY9eUBCRYSwnmASr8vld3FKXtP00N7l/Nfezj6tKrTiILi2OcnTV2nsSqO5MBM0QNuK/7ZsOdlbYMwDpN9Oj04f8goUzbgqqnHA8WDoQV7esN7tm44Fz/R4TEmEojvPOBYD/roIu9aUDu7NsG6vetKu6IB4A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(478600001)(4744005)(5660300002)(8936002)(7416002)(921005)(316002)(86362001)(6486002)(4326008)(8676002)(66476007)(66556008)(66946007)(2616005)(1076003)(186003)(6512007)(26005)(52116002)(2906002)(41300700001)(38100700002)(38350700002)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mmK2hBZ8R+GJz6apOxrLqvUAF9aY4LvF4n+s97OeEzVYeCF3eImqyhwk9IGx?=
 =?us-ascii?Q?b/U7oHv/etp0jHnAJLmloAqHeHV/V0dzTsYRf10WafjGQyJ2wjkq6pALvFMq?=
 =?us-ascii?Q?EyG0h+UT31RWotF8f9tUrI6N4UfcFqLcB21+tPvOSzVSkVJaoQQIZ2/U4+7N?=
 =?us-ascii?Q?ncVZtFIaQ8CrDMnfgLlgAMPmurW0UfdU9Nkzfysd/ieHohHailYQD5JalO6O?=
 =?us-ascii?Q?EAtict/45COolrUSm+jGa6DJSVkOvYw4zez45yqwIWbtSn8r8g4ZUhNUfSPO?=
 =?us-ascii?Q?R+Oy3V8D48FtbCgHndU5/UJRB+l38WUjvTuq2hNMVVer/aU+RBKID8buYQ9A?=
 =?us-ascii?Q?uQnr24Nv6+tAHVWMh/tJjkhUo+POPV2u8s1KKEMbRRFd95ZrsDoJxWvansDg?=
 =?us-ascii?Q?zXS9mikApBNssOFqcw41ZamPO16RTOiruUI0F2C2III+A1LWzIoaFfLKuFt6?=
 =?us-ascii?Q?0s/cxXLkR00SKVXjXi+YTrN44sGBWsjaZF9/aQuBbugdvmODaar5x6XJlOH7?=
 =?us-ascii?Q?nb6E8inDKfLPpQT6QeqNztw2I5ptamxGPvp0w0yVG5tkNRq6+/e5bDBWUqMB?=
 =?us-ascii?Q?gu9u7gMnFJ4gi+1IYQXAOM2V4cAuQBXE3EBQYS8oPwpKaWzFPHYJokBSBhZz?=
 =?us-ascii?Q?mphtu95ZjdHOZnxBVRLUOjArJg157kTrn5nLhJGOLBx4m6g2iBCzpJFFQjJV?=
 =?us-ascii?Q?IE7bR7ceQAa7QxB/Y7TRXeJLSgd4S/GFuLR0qHZ4az8SI25mQmdu5QKAD71q?=
 =?us-ascii?Q?cXRhR7FzmMuCb1Fl1CH/AdwKfsDc3PUiCYiL0E/kQe6EKeTD/9LQyTzTgRtQ?=
 =?us-ascii?Q?cN2nyjhJiSHcQWHR12DanRCsGuAvUOSmIfvHKY7Rr6Pcugo4cC8MUWGkRyjQ?=
 =?us-ascii?Q?C0IOI7pPDo4Ny57NLsPFNf/PFNfoowD/cHfjUWw8WJ1ruzgMJxe42StwFagW?=
 =?us-ascii?Q?UsZZntedEDxmzS5vExd/6gJ+ZYY32DaydP0UKn6sck2nDpyAmoAZ06E7+1Ft?=
 =?us-ascii?Q?4VFwVDXVXI2xHAnRXi6csQ8fPEuicBRY69tTP1SQLFfSDMl7tx11KQtco4Bq?=
 =?us-ascii?Q?yCixYjNVhJa0fmSA1e7/OTj6LctL/ryO4ldIRu9r7fi+OJGjIbo63aVv4Fc3?=
 =?us-ascii?Q?/+mdhii4Kf/htPgmpCyPUYCKn3o5HugXcNc9Ms2I4W4Ea541H/pmBYXFh2/0?=
 =?us-ascii?Q?YrQuOYIid+KgY8MkvoDMPGWI16o1+YI7p7rGZxo6CJz1pV6q/qnvuux3I9JJ?=
 =?us-ascii?Q?BvV30ZIhKNwDUKMFR3aXrwe+BSO0BhkWg5McHRT9FmdZGyNVsA7I8CriRmAs?=
 =?us-ascii?Q?a3RVAnLlOivgFSvYXO/Ve+gul/pE0Kldl/4iS3vNGfMxd3puARXol6umCCHG?=
 =?us-ascii?Q?AvXkuc0USonahIoNE1+RS1Ud9oKHUsugB0fOrp/ca/yUzHj3fwQ8uV//2CAG?=
 =?us-ascii?Q?DTJVQcKVA2bJSNYfr/dC9Q2DsypuEbb9coJ1aOmp0Ro+tZoss7zLX9bI2EvW?=
 =?us-ascii?Q?6zYpJT2ownx5R+Mw/BHvHD/AWo4lI7FSj04jUqGQ9f3JbEaD+J15paPrIf0v?=
 =?us-ascii?Q?qYR7BFOZ5iehxTGhazxfTW5+yPFt3cFP/dCDGHHo?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f80a13-2bdc-4898-e2fe-08da5cd45841
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2022 09:13:51.3005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I9l/EbbsqFGtVNMqs644pvxCt9yhLIyEELLUTdaB7vbPPi6cfq6QHSXpGDFgMo26gy5Fkk5MHwdHAC633+iQ7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7768
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add interconnect property for hsio blk ctrl

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 08bd57742294..9cceeeeb26be 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1109,6 +1109,11 @@ hsio_blk_ctrl: blk-ctrl@32f10000 {
 						<&pgc_hsiomix>, <&pgc_pcie_phy>;
 				power-domain-names = "bus", "usb", "usb-phy1",
 						     "usb-phy2", "pcie", "pcie-phy";
+				interconnects = <&noc IMX8MP_ICM_NOC_PCIE &noc IMX8MP_ICN_HSIO>,
+						<&noc IMX8MP_ICM_USB1 &noc IMX8MP_ICN_HSIO>,
+						<&noc IMX8MP_ICM_USB2 &noc IMX8MP_ICN_HSIO>,
+						<&noc IMX8MP_ICM_PCIE &noc IMX8MP_ICN_HSIO>;
+				interconnect-names = "noc-pcie", "usb1", "usb2", "pcie";
 				#power-domain-cells = <1>;
 			};
 		};
-- 
2.25.1


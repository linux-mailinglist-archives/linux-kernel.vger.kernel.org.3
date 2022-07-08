Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF1856B4DE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237834AbiGHIzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237829AbiGHIzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:55:43 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10079.outbound.protection.outlook.com [40.107.1.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EAA7C190;
        Fri,  8 Jul 2022 01:55:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TA8+wDFqPfCYypVUevlCBLOAzAzD5XWAn0La9PZfHFGPoumpy0yzNjIZtgLXzb2x/CceMph+uaX+CEKSqHSaGnHAb/oKucYBkwNe6dHXl3vbSn/yR2Cajb4Rl5jIxNewmJZGCtPnP9YHg6gB3FywZaI3RXHogIYPRwzlkFKe0ciILyqQJgDkZBkFIlVd815B7E0QE0y311bQEKu5Z0zl9u8TVfjdTsvQCQEXYjIGiju+G35DIuRftRQXQz8mkp3LRuCC+Dl3dUi/S4D5G5BlRGSuIxt5C9u+WcZddXBeGqjxI+hUcw+qw3Q4M4hYN1fo7mV8FKgX3+iOXbpK17girw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVsejrYqZChWET42fQpQwSumgTJteEyNctAvnqdN8b0=;
 b=RsmGsaY4+w+ClzM7zHIUiq0i+O2Fxfi1pEu9jPU7rXp1M5RyR7LdM2JFOH8+Dw2BAQk3WJvEd0+cGbH0f/XcpiX8F3+FD4Eo0jdUEFMQyxkSTEdWMric8yWpd5iauE1xn6grfYJNDxtxaCTeejiKeyBFbKLLdqstGeY1wjTqXX2v4dNnPV0gT+boMF6iqHw8S+aGU6EVdOM+Kuk2L7U2z7o35hZ+JIGOHQ0YFVocF5Coy5CNv08L2GGnuo0bveACXeQP8DCM8HN4CHTpiET0rCQSaGW5zZsE1Jw2Z5Uy+PVS8PEWnWPgqiqK3EF6lbtU6/7ZRFiaa8+PbgzyCCvMcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVsejrYqZChWET42fQpQwSumgTJteEyNctAvnqdN8b0=;
 b=OEvgIAOahz+L7Q8LR3LNEAJbkIY99DiYm/qIxOyegOODlI52WE24KCpPhYrGAuqVI2pUSlJlhVMh8hGPe62Z+7HIql9X1ihAgL3JcJnoV8mZNDPtRIW5nGE3nB5OyZasqFCeZDDtCUGQvkZ7AoUSfywmVbBnIp2I7khaKDZEltg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB6503.eurprd04.prod.outlook.com (2603:10a6:20b:ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.19; Fri, 8 Jul
 2022 08:55:36 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%6]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 08:55:36 +0000
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
Subject: [PATCH V4 7/7] arm64: dts: imx8mp: add interconnect for hsio blk ctrl
Date:   Fri,  8 Jul 2022 16:56:32 +0800
Message-Id: <20220708085632.1918323-8-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c3c105a3-2538-45c4-7260-08da60bf9faa
X-MS-TrafficTypeDiagnostic: AM6PR04MB6503:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: foliQyT8VJSyuCXsrsKa0GrmQE1tXfQM75Bok1MQN+R1LIKnnw+qy6MS86jqVrB0gsnvDOTs4hkPR3/pbfXirRzuto8dpLOnHZWawcpv8K3m8O7UED6CNVdMrkaDbCqCJqJBP/U5/ZiVvoftCb0N/K4lbqN8htarYNFJi1HTQVP0FkBFl/zPwmf+53PXYn6qelkV5OgHkaKnW7cu07/LHz0UWNlBP3iBhCGVRVZSQ6vfmGYwhniqphPSYRSZbD2Z/hVkB7Uq7n6Hua3gvzLUgNoyjpKtuEpUOxfc0LZaEg0Ec0RbNCuZn9gICJEZZru0mbadra3DV/XunTTN4GfD9NE2ds6MGCFj+2Gh3antuikJ2dzy9FcZlmJ4eMxryefiPk4qnS3RbJACz6js0ZGG6FygOc+1nfU5Q/2rGycZp+vk+CtLZnWjYDNwXHKB8rHRAODyjjL68LKi9Jbv56NmrHvPxg8bL0/uxsvJecF/8GvabDojssulgroM97s2UAfFWKcXb4kWBGX+8LuyeKBjIH0tmHd5k4vZAIasF7QFVIcmY3XIHbT/IPSi0TQZRBS4xi5KpAnFct9Ct2fDeIGa8wFU2J/fVcpeG46YNf5mOLRrtDuOOFCa2bMpdKmGTJHSpV+rExxUqeP+ofoBYxwvGmu0oE0WGjTfBnd2oUBh3XhYk8/M7YblK2Q3g/lgREZEHifojKsfaRTrCHdHcbHQsNIcZuGMUWjqWeRjswCOXQn8P/FDbljv0E++97tQEBcGujj5hotokYhB+EYgqoUJl7/W6MA7f+zDlFv0dgdI9C4LmDioOjfoVplZbQ5j+q5fa4Isw3unnFljcRFPMfce+zL1UM50DYIktj9H3LKk2is=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(66556008)(66476007)(186003)(66946007)(2616005)(8936002)(1076003)(7416002)(4326008)(8676002)(5660300002)(6512007)(52116002)(4744005)(478600001)(2906002)(38350700002)(38100700002)(6506007)(26005)(6666004)(41300700001)(921005)(6486002)(86362001)(316002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ny+zjPy6xxdKPNuEgJczaZcsjDvRuEvPMZYLqYZpaPDwLJ9HA9vCP4faQGHr?=
 =?us-ascii?Q?rEa6pBQI/1aaImaewnGcL1xucys1I88upefTBpl6iM6QkmbJ+9EIRCMMWl0C?=
 =?us-ascii?Q?bhGTiFEEp00PFopyTt4MAhmbLLOoLpBJAGTpH4AzkE1krOsRyN3qY8b8wz77?=
 =?us-ascii?Q?zA4ZlEB28pgjIFGED7YHzt2SpFtr3xc0j16B+ecBMPk4M9ZWRoNecyGGgCkQ?=
 =?us-ascii?Q?WA1SvoXNVn/cm9gV4JhoTr1cHNYIaQdCEf3R2tDgd1RMk5otL44zfZxG3Cko?=
 =?us-ascii?Q?1hor9vgj+1xHSV09IZFoUgPw2tfDsBc7nR+FTPdUIHrJ/3a0IRlISlw5qlKB?=
 =?us-ascii?Q?Zt6/Tsun46a8g5GETDCZdnTXxJwl8HinPpA6aFudRuJzEJHNZf3X9tn/L1He?=
 =?us-ascii?Q?LQXNZ2KohlO98xdSbb8BrUDF43XqsRxOELbbDVgZvDgPT7lfENtEOv/BOg5s?=
 =?us-ascii?Q?PzabX2Ex3B/rrmrr9bdmDFVKHtvF+ZO+xZGuT5ESKbzgkFcykTwfqFoqMi4m?=
 =?us-ascii?Q?gEsMPPp8fb+3ONi3QTiMTB0mrThaSulJ1zMtq6n+e9yrt5sDFyuDv83EdxBA?=
 =?us-ascii?Q?P5LctP2+H8pWMD/lUGC6u2XeeYq7o4giL+TaNNG5FN8jnAyJVyadq8xOOu5T?=
 =?us-ascii?Q?z7ey3bXkCBOEtiCP8300ucZnCJEarxntpk3ecxLppTHERu2voJFROJ8a0mY5?=
 =?us-ascii?Q?AHoRinNBAJ3W9w8/PFIiy8v+Xp4Lw7EbFdZtBjAMlW5uadxZZX6rgVDGj0pf?=
 =?us-ascii?Q?5CP77PKhQjOSPSz/pBl/vnCThDxq7a/berBX/YsSuUu6JkTclGumFuyps/jP?=
 =?us-ascii?Q?b7th+z85CcbiiW0RLCPvqAcvWyJnhcJT2QEufi5tGrVaqdRR3WqIBiFOTj7S?=
 =?us-ascii?Q?N4A9FOIq5+1fiuao8eR1Wc6BUGGIheiDX29lj8l+p/9JwrgC3+htOBOf6fYO?=
 =?us-ascii?Q?iZ1qUHoOgjDSJUfzBg1dBPY7qBU8yKoG84C+RU8NjOZ/6+xNxvtplBrJ3Rlq?=
 =?us-ascii?Q?e7YdLuNyYh5965tDLheNdAYWHtdzUoygRDjhj9hiWwfJ+/JtnAAI+J5ANQKc?=
 =?us-ascii?Q?gKCZkg6MXmPOh5anrzqWSotUnZA+VjMSUOQsElaQ/2Cwmucwe4sa/MZAWi8o?=
 =?us-ascii?Q?t9FobbnGcfzUhU7gQNr1mLn3YIbZtFAJvRoEbPGGr+OhVpZq7FPBXA9zdmc9?=
 =?us-ascii?Q?0jA20nyAGjEsxd3unsFofte0hTwViHSLD/TZr3R5U/ld+qxHnAerKFslkbsR?=
 =?us-ascii?Q?UjRZE1aLQppyc2I7ia+/vOb92NuSAnkzNMjokkatt2AgDAUC7dgaHDEnCXZU?=
 =?us-ascii?Q?Xr9CB6HsUlhVsIvfXydxbSvTR6BYO7bCNyDSuxs19M0pFm2fstZTpAKurNMZ?=
 =?us-ascii?Q?SGSwA33/zBTLJDT3iszjbkwRWLdR25G5UQH6PYygM0pJnI0kiMDnZ6ObXJVB?=
 =?us-ascii?Q?4I5w967s4f+FnksqVEUssNLe1tOc1CuEuviqityxAesusXp3I0OrMvMYKuYi?=
 =?us-ascii?Q?xco+gujPnBMA9/6cgMAWN6AwWuMudyQAt5vvOp9HB69OEFfAxrtx8QCP8VIB?=
 =?us-ascii?Q?bMPOT9AsxCF/dc5+IwE5ZLoSpnL6zLSBG4eDRW0w?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c105a3-2538-45c4-7260-08da60bf9faa
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 08:55:36.3551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r4RmNpW+fxcsn99E+mATOG2zZag7zw6ke70Hn8OCukwmoWz8sV9WH9eCJUXWMIOunnAM0a4FhHvYEAdffkHCoA==
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

Add interconnect property for hsio blk ctrl

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index a36d53914a24..0b165f98a82c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1108,6 +1108,11 @@ hsio_blk_ctrl: blk-ctrl@32f10000 {
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


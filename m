Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E51759B9C5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 08:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbiHVGpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 02:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbiHVGop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:44:45 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140089.outbound.protection.outlook.com [40.107.14.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511E628E0D;
        Sun, 21 Aug 2022 23:44:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zo6Fs+p1XyedO4lpju5peLyEJlttXyX/DandgsHjagIh7GpgLbbcbYvs4pFPF1GOJNyrl/6UTv8EzPUg2T6v2Uz/QfYDaRyrPlHc/YiLftnsioM1rfDaxcM6EZcLiFFerLjnNw1LrTR4lVQH69yx1n/CAfhnNKUpJrwuPm8LZ7/GfiLZqQspFDUX1LyN/9Tokw3IxXdc77bum6t7J0oK2k9WZ+gSHdG1wlnK3VVZrRBCowotCFbfo7R2HjcFaFHswmKaOr29V+0SRAPH1pQWkIhN7fQXwxsf84a0WZJ0MpZ19u1NjMDhEMwajFNgc64jHfmFKzCPboGAjXPnU0fgcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnNSF0BU5UlSQiWfXCl+cOom6/Vny2mUvWfES/DJHtE=;
 b=bSLyn7R4R2UtoFJwkHKdFFvfzx3Sn8xrS//8vU+TffNsnJr3epUDB2ho1ns0SJqZOzsUkJTgt4+Bs4dwyhpb/bSfkeM7WlQHG2o/Kosk9thy6wqBClM/GcqslhzvZhakqk8c8vYlgTgfxLSw6WkaP0ON/qANK5bD5Alucisn88ISmKGhO76JKbBPIkzHUrUe+42h8wY+aGt0N/xuLLb0useEFXoBCfb9yLE5RzAYxaE+2gZHj+8SHohHf/U9rshbCUIoCHKIHB/8ZsfgdNhaNcZfrtHs8kz9Vlnu4Vzp/0CEa/dv8bFDXKhT0uVqWIiIHtHn3EctdFCaAlonNhC1Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnNSF0BU5UlSQiWfXCl+cOom6/Vny2mUvWfES/DJHtE=;
 b=jW5gedk4xeahBdR4PuWl6SNdpn8SX+ygqJWcwKsmkMuIQ9lnu/hCK0NsihGT8f4Pi2BThb8CAt4D1EsobDE/Gjpww04xKOmNfb7fpBUWtYCJqZmYXqYN06E1nZx4Y6vZaIBsZihHFGzrOdF8iYVfOK1pLpA5GTy32Ek57lxt6aw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8752.eurprd04.prod.outlook.com (2603:10a6:102:20e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 06:44:37 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%6]) with mapi id 15.20.5546.021; Mon, 22 Aug 2022
 06:44:36 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        l.stach@pengutronix.de, laurent.pinchart@ideasonboard.com,
        marex@denx.de, m.felsch@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 7/8] arm64: dts: imx8mp: add vpu pgc nodes
Date:   Mon, 22 Aug 2022 14:45:35 +0800
Message-Id: <20220822064536.3947512-8-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220822064536.3947512-1-peng.fan@oss.nxp.com>
References: <20220822064536.3947512-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f1a431d-5ac9-4446-c50d-08da8409c7ac
X-MS-TrafficTypeDiagnostic: PAXPR04MB8752:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gNwrFfWdhfV+kn28sr28XtVrjs0F/E4Kag/GLzb3/zOrJ8SpjQPUD1ACZNnH0ZJz5dXE//8lbQIJWqByx5VxDv54qkbhAn5NULPRgfvuwmwhAwON0zywoWdLk8s5ZhCqR7RJlkKwbrtNHbvaI+142LCaXpN3LhkC9CFrWLQ/ZJ02yjtN53fuZY41cXrZg7KPy+3LYP6MKU1/mde1QGWEhstVXRhhyB5vZylnFChkI0DRcrVIelSV/yJ10+verBpW8YyYeJ+r0TpNyL0tiaN5TW3arzaWHRbk/3d+BU+AvAlGBPpHRjtPM7cg46Ej4Qh0MtiEiF+wvDMAUvs4Qj+xcnxi3xXhup1NReByGNHNAvdEs3bjdYaO/hKx7DAkPSH4XzrUxRDMCDabZmla/jDcGSidTwdhT4++vPulhrk8BpRxx+Vbz5Aa73yhkJhzF1DM4bw5dz6dV4WK+R2+OGJ0enHLKvp3A3xTqbRKQZ2JcMu4yIIAWQ2Zz1LUuYNoEhu4OnHX16jzOPeT+/IIZatJ1W8NquFe30/AdXgwZYMv7Uky3V18GUnVpUQ21Lo/o3fzItcWwGKe8ml4bi+PrqvdQbr4AkCz44R+1oKPdEan+OhKhe1Z4LL1SWYi0TN5alXlwnTuhBKv30ibIddh3pXGjlTNIO3QICii26X2pEGdI3jsbz19mrxwN+zsbp0UuZaeVXic1UmzIV+yxIPBJ2oYAGzCiOSwsnurv8fFkLQgXD3XV7h7E+NOGDhkSZYOvCU7n9G/K3NQROjV39bEbwLVliAy4j0ciB26/sVWkMq5eCk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(83380400001)(86362001)(38100700002)(38350700002)(316002)(478600001)(6512007)(66476007)(6486002)(4326008)(8676002)(66946007)(26005)(2906002)(7416002)(52116002)(186003)(1076003)(6506007)(2616005)(5660300002)(41300700001)(66556008)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YwY3YJa0A8Iwp3TJoJIuGINGQvJLpT4c1qxJjboOM2alV2Yfxl73/02ASTkX?=
 =?us-ascii?Q?GQaRYa27QDNJ85SiuxvbL53gGKYMm9JXVbwc+KEQQ49Ye+ZL0qrus87Us0c4?=
 =?us-ascii?Q?UBvOXIQjzsILAMklwXO+AkrrVePvW1IbQoFftf5+Gu4lcLxi8cJhJUrbOtl8?=
 =?us-ascii?Q?x7di7M4bUUkfD7zthN+8NQ4UMqoa3WAU4mU5aBpEBrUyxwv6aKTPhvo1fusQ?=
 =?us-ascii?Q?/Auop14s+fB7mRBB/LfNCSAuLHK0XMRllErHm88bHXEW2ZovFB1YyYUHhpqr?=
 =?us-ascii?Q?S1Rn72yE2XgB1Sa6wfZXeSd6bSra0oQBs0o3UN7/q935ERKgJuwzomSQ0jjL?=
 =?us-ascii?Q?x5bCnmZJ4pGiBJlSWQochEwmZTS92IjkF/cNkYSjb+mJe2B9c39kEZwkbhn/?=
 =?us-ascii?Q?a4yfxk8EWjxWAD2+gTOdRoL2dcN/Fg8S5ds0EPSCT9fLFPYuzkkk4iKUwWGd?=
 =?us-ascii?Q?wQIwumvEdeimRAsL/UhkMCXPMsPTz25tDR8D2BaPfXgm+pwaOnexjhWr/YYx?=
 =?us-ascii?Q?ve101Us28b5QYH3XuCXLbunLbSW9WeTbKJ4ZFMrjv1xPJgAU4X2iwLjPHnsw?=
 =?us-ascii?Q?8jc6lO1gE2MZ63Mtsigm4TkPpjjuCnX7sSMGm9bwOWWrh1az0qwnxq3ESu5E?=
 =?us-ascii?Q?ROMYDW1oNUz1A/FBs6tG0j2W/OaB463Jeg/dycDi/lYU6uGsmXtnNAR5lArW?=
 =?us-ascii?Q?9dly8N9By4uBFRZTBGG/X19SwyXavzweLag29KMHBsm+gp8wxR5qw8G1T6tb?=
 =?us-ascii?Q?9dJjQCDKz7SQDYFNUUp0m9tj02tAV8J1/Lnzkp9IBqoTFYO4X+MBTRzU0DdL?=
 =?us-ascii?Q?sEFB8u8TmEmYm9/aSaHcR53oydN2ORYNqhkEZozvYklnNQzKCYtpHndZS1cW?=
 =?us-ascii?Q?8uoBIoFuVg41D3hEe7M3QmcPfS+t6/ONdNf3rcZ07+jP7TH86+mC3ZieBl3i?=
 =?us-ascii?Q?4HqvViKJXbHMasDp1jZgTHmnKwHWfgbmlJqYNnGPJ44EplDK0zBZXaT5wKY4?=
 =?us-ascii?Q?0JYUqFwjAIhsgfLbGfS/SzLGQDOHOkBnbmF2+tyH0VgZbmaW63bSshluB94u?=
 =?us-ascii?Q?4Sa5GXERrqU5HGIM1n++eNXRQ6AK/rVpqCXq7PxSZZ6kF3kQQiNJRmxj9gT1?=
 =?us-ascii?Q?OxpihCIoUISI6yMKDl5FTYgKYvwFk+8qpxg1OIfxYF4jrXn95VN5bgdn15XV?=
 =?us-ascii?Q?WC16eCCA/BZ8hfKLRjdT8zUXadks2ttNwy041K0d18Cm5eMbzQ7bX175k7e2?=
 =?us-ascii?Q?V8xiKJkZsqZGScVJ2S5arLRENCVIwHXqHlgNKM7S1bW/vyH8T2ByXCqIo25e?=
 =?us-ascii?Q?FECzPWkFNKndaGb16IwlgeanigUzRJIZaNKtfmJk985gSGOe2bRm3rEqRU7K?=
 =?us-ascii?Q?fewiw00/3udHi6Wc4Xz82eDfoERpev7VFEq+FJVkSZ+8mBAcgqo1scFCKy/S?=
 =?us-ascii?Q?EpViiGStgbS+AmH3wTbNO5W4oXpvYqx3v07odjSjDYNLxhAbCF2uS+laBka9?=
 =?us-ascii?Q?nhJqFGakS2IwnPu9HpuA6jiwy8PWVijjHgKZ4cc3Zs4A0JW6GDGix61vy5Ar?=
 =?us-ascii?Q?vJJjlCypDetvV0fjmenOh9wLHYTMtvXrKNUxKyug?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1a431d-5ac9-4446-c50d-08da8409c7ac
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 06:44:36.7795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDcilNXY1s4t8UIdxjos9HlIkSa7opY3JR6AhkgN9b+Rx0eJrMt14Hrt7GgfFjD3brCTjADD9Kym0NCsLRb/jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8752
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8MP PGC nodes for vpu, which are used to supply power for VPU.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 27 +++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 0b165f98a82c..34af983b0210 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -598,6 +598,33 @@ pgc_ispdwp: power-domain@18 {
 						reg = <IMX8MP_POWER_DOMAIN_MEDIAMIX_ISPDWP>;
 						clocks = <&clk IMX8MP_CLK_MEDIA_ISP_ROOT>;
 					};
+
+					pgc_vpumix: power-domain@19 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MP_POWER_DOMAIN_VPUMIX>;
+						clocks =<&clk IMX8MP_CLK_VPU_ROOT>;
+					};
+
+					pgc_vpu_g1: power-domain@20 {
+						#power-domain-cells = <0>;
+						power-domains = <&pgc_vpumix>;
+						reg = <IMX8MP_POWER_DOMAIN_VPU_G1>;
+						clocks = <&clk IMX8MP_CLK_VPU_G1_ROOT>;
+					};
+
+					pgc_vpu_g2: power-domain@21 {
+						#power-domain-cells = <0>;
+						power-domains = <&pgc_vpumix>;
+						reg = <IMX8MP_POWER_DOMAIN_VPU_G2>;
+						clocks = <&clk IMX8MP_CLK_VPU_G2_ROOT>;
+					};
+
+					pgc_vpu_vc8000e: power-domain@22 {
+						#power-domain-cells = <0>;
+						power-domains = <&pgc_vpumix>;
+						reg = <IMX8MP_POWER_DOMAIN_VPU_VC8000E>;
+						clocks = <&clk IMX8MP_CLK_VPU_VC8KE_ROOT>;
+					};
 				};
 			};
 		};
-- 
2.37.1


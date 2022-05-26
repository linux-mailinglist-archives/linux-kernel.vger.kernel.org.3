Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D717534F3D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 14:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242026AbiEZMdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 08:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347423AbiEZMdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 08:33:11 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FEDBE2E;
        Thu, 26 May 2022 05:33:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neAEy1a0+pWPfMHPvD3NOtRDVctYJxrHxxIOHffCCiUo7zYJBTICg8kYi2C7fyqgVghNqGLIWUoeDTrHs60qh/yctquRwbhO5sO7/bAyZYC+1WnZgqwIBYdbRyucuw7NQL7Z54JZYM/kesefR2TQrVxE4co49i4G6pg62GEqnGBjkNpKTO9mEEANWZHGKN1X4hZ19n91Yq5oSga7LiDNvvwON9f01yJaioTqD5uvdpdirlmh6TF9ayk6XDVNQhYGoSUYyftm2JRcWaXqRuQDBOd60Q47TTFtD2mHmKRQXdGdDfSTIDNL3Q51PDxRb/mtG/yPhB3+51bdrJeD8OSpVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peLw63kd4sSBry4xOsagwJYg5O9yr5TK+vWF2yinQJ8=;
 b=LadFAiepQr6FcLTpl9sDt5IX0DIEGYy7VS20HjUfC2jUnhldYirOXXuc31gFqu8Gruu2rybSGNNrWT+2kcnEbt3O5JIIcjxAzhl3rp002TMRWQwX/ZCiYDz2UGllvlBtHRRRXGoTj7vq1EWc0/VF0Wbyv2dYcCBMNw2VdYqTHG9bWeExwJYlTjW2uD4fbXUlzqUkA1WwVXHAB6M1UAxb9xb/c1egegulY/ya9cVAuUn4+Iel6yV5HOTZ4IgbGdba4a5VlRsQ39WSFisWRDIcGDaUV3AGMiDd9YzKSSXc+pPaqyyElk6H8KA8mdD/38y7iZ+p3JX+9iGOjSmILXFMuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peLw63kd4sSBry4xOsagwJYg5O9yr5TK+vWF2yinQJ8=;
 b=g5Yr/jradRpXAZXXEfR9po+b8OIV91QlUPQ7qMmQ+EUnw2IEopotWkerwY3A0zITIhGFep3cFtz3eOZPxM18rk+By2Th6cmB28UK/biMA5XKh2FR470e/8+9FUxQC2M7dsnyUDw5Vo+d5Li5yJc/GE7WrdQRQvDEq7ZMfDxTdIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8363.eurprd04.prod.outlook.com (2603:10a6:10:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 12:33:00 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 12:33:00 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 6/7] arm64: dts: imx93: add src node
Date:   Thu, 26 May 2022 20:34:10 +0800
Message-Id: <20220526123411.270083-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220526123411.270083-1-peng.fan@oss.nxp.com>
References: <20220526123411.270083-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:4:186::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b507803-bc3f-4d7e-b864-08da3f13deb8
X-MS-TrafficTypeDiagnostic: DB9PR04MB8363:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB9PR04MB8363FB602E9369170786FAA2C9D99@DB9PR04MB8363.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4jO9OuYMsDMInK1T5QGIuvKKbUXwQbsBFP4iZCbynToem/Y1HOPk9BopSKarGzok7Hs+ZmslovTgJtWtfAYxafiYuePRtIUSZPKHj+zvovHScvZTJe0yLpFZ4i8kY4K20dt8jcKBYqPOjj5ds0rM4C4i1u19oZWD3l2P2G83RUNqkZhjbkd3d8xmIhXrl2gWmMHysKdSEL3Hx0DbQlnM3D8ORtCD3kopl8BtLclMsGHitk/S+zaA4kqnmcygoLWM39R3eI5sIrdQiVR/7PKoL5hDkXT2W7Cs3/si3VJs4NffJkXVp5L3z4ub9xMeFWAb5VZcbBtO4HSeNd7bh2uM/7aIVqGHpRkAQ+6gk/OEKNsIx9lrCcC8TTIZaDQC55VPSE8VbJ4rIXBP7Q4AjMNBDHnekJ6IH/VW6+wNji2I8dQqyjpovKvCYiWqEd5kA1ynVCeKAGGVAx4HrJTHSV2LEu/BWar9qKkgwodYjLGv6qknDMIIaG0nHvc8IkjTPpCTaAL6x2IC8NnzyHr157UN7oKUr4oFVBfN6kpneGuEDZVjkrtK7YpHW9B6+A9CdMWi80PPozQ792WCT0WEe1yPU+pE9WfPlWQ/dAyUTYBCnoo0MYN1Cox5wJfZll62SxifYQvqr4FOKerX9kA2MZoV4MH6oNbr0Fr+lPUYypSZAe8oT4h6kzwuFMzDpuqnlpxh8fCY+BEFYiErXuMj87isAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(38350700002)(6486002)(186003)(2906002)(26005)(6512007)(66476007)(66946007)(83380400001)(66556008)(4326008)(38100700002)(7416002)(86362001)(5660300002)(2616005)(1076003)(8676002)(316002)(8936002)(6506007)(52116002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vSV9qlX0OVp4iMdhdVbaVQHP6EQpJwD6qbSMv9Ks4IWNL1/Mb4wfx8g/i0hY?=
 =?us-ascii?Q?0A3SoP929iJoSP4vRvV/fPat3Pg3e9Mn9GpHgysMGxoPNaRaIor3OPr/26uR?=
 =?us-ascii?Q?GMmMsCK26SIiEXpRelqof3kPc+B4CLhSb8p3h1K0J7Jrgx4laCBITlm94N27?=
 =?us-ascii?Q?NTone/TraO/nvgWyY2U9efd+9H2y4Ux13pL7W1MErkdAqa7KTlM9VCyAaYBJ?=
 =?us-ascii?Q?R56W/pdzO/wRz3JC47f+0ZotqUShoZQ++SqEr1Q17jqCN8iLIm72wXe1cnGy?=
 =?us-ascii?Q?K35y8eR6WojHeSy47YBbchsb+NsgXNcogEvVBT4uCyemDIJGgeaZAMcDzTRp?=
 =?us-ascii?Q?IU3zMO3XjZ+BH7Ah4ukAZr7ys68rLeeSgwoqjQF9bTBBklhwoBFo07OtjHdX?=
 =?us-ascii?Q?5wbI01n77uSCtlA8Xs7yFwbxOQWwk0nVFX0BTZscRrkiZ2E9UyDXtXjeN65W?=
 =?us-ascii?Q?kykBWU6AYdyezvv8phcC4mHRx+ZeC3J7tbgXBs3meOjXpteOBr6byr0lpZyD?=
 =?us-ascii?Q?jkFeK43H/kSGNuXLeTIKreOtqZBmAkX/Wm/+XXCZnXSiLjtYHdFJKKGkNbfH?=
 =?us-ascii?Q?kl1S/6N3cNWHulSfuwiX2JYvO2aPqA0hGo1iY9cxvIIyHqRGK+vlJn1xgj83?=
 =?us-ascii?Q?ntenQjPCmxdZZpbYh4y+9tr7A+OfS3KSW7OxY8DXNDZ0lWVUYXYqfqW+8bvn?=
 =?us-ascii?Q?4xW4tOvLHTLN7BvUUESmC8IwzY/mDmFE1/tWxoVg7b9nCxwg1Rrx+sfbEaSC?=
 =?us-ascii?Q?jAYEtrfuPMr3b8xwlb8ELXCNQUIMiNYzYc6HepQ3F58oigY+MxqqO3kA15Pz?=
 =?us-ascii?Q?B9zMNg47dgrbxgmDnoCCC7jO5cE6LzXsMVzypWKGu7ksn9q5YEm5IcZjj4cs?=
 =?us-ascii?Q?a1VEveYMRNc7xuqa8k8TcoZvIMzhIXPqJK5G6u0J9fAwfIWUmGNDirxADbe6?=
 =?us-ascii?Q?AGR7U7V72tJSyXkXd8oFLoO5JzJS2cml3csapo6/a07plNXgXjAjzNUrMVYM?=
 =?us-ascii?Q?7LdUUJSxVPVbcdIAMW5PjfRn79NIYkeIyLJfZ8W140E/K+XIr6aOZAwI2Ahy?=
 =?us-ascii?Q?2cPcQAwljr9pELAX1J+vbJpapAPV4gfggqY0yWbV3scrSAKe1/i5/bU6bHhu?=
 =?us-ascii?Q?HfSfsfWCMaEr7iJHlM2AmkwmgJ4W2sQ7o80pZdE9zbAcyGyKOi1dbwJUd88Q?=
 =?us-ascii?Q?KZOPaqfsHFVkarkTKbUZbDxhtMrQGYoy4WOfv/Xk3UtlxhgziZTBRrViYowU?=
 =?us-ascii?Q?j1zRuVtwEonINaP/2O4SiLvSM2MwowXlATDvsUm/ldrUvnyciRW+Cj4DdesW?=
 =?us-ascii?Q?eowz4BdAv+FdCmJcQ8c0TZKbHSoDYmMzEqzIorDg9rA8wOI/Bzh5RllFcocw?=
 =?us-ascii?Q?bKnswZzIT2HrEOvcOCQ12xHE8ZJ7RdMKNq9z/YYksFqYT0tVI3NDTKrSDssu?=
 =?us-ascii?Q?UO8H61epzzWNKn0HfYt3wzPXHfXXdVhXw+3vPUSh88G9KG93VxTYmwJxG6Eo?=
 =?us-ascii?Q?84lIJtZhhcSu9rFr6eto7IlvsRSgipnOCgpE/tAFOquX+3TRsf3kx4IZNpuE?=
 =?us-ascii?Q?NV18O5k+c4Q3r9Hcpogfeoyp4nwENeh1zIiXpL5pyWOK3csivjTaowQ8z0Mo?=
 =?us-ascii?Q?+f/Z/XMkFTdfUqymOcmmmHbPK1c6EkcfohhPSmsIawF7PrEz7CrXaSruJS/F?=
 =?us-ascii?Q?p6yesFh5vOdkxz2q5+qHpdI5SOFsQPiYoxCwNEEkjMEb44g7rWrORiqwWsKt?=
 =?us-ascii?Q?WDVFr6ABcw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b507803-bc3f-4d7e-b864-08da3f13deb8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 12:33:00.3039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFDkSPvAyKy0ZlkldSWC2tsDV6tsRcWOKa8T60b3YfLqKIaWND1cq2Wi0bZXR0UxiLA3w7mhr0IpjJBQL/0ZoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8363
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX93 SRC node

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index f83a07c7c9b1..f7d4f769db00 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/fsl,imx93-power.h>
 
 #include "imx93-pinfunc.h"
 
@@ -161,6 +162,23 @@ clk: clock-controller@44450000 {
 				status = "okay";
 			};
 
+			src: system-controller@44460000 {
+				compatible = "fsl,imx93-src", "syscon";
+				reg = <0x44460000 0x10000>;
+
+				slice {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					mediamix: power-domain@0 {
+						reg = <IMX93_POWER_DOMAIN_MEDIAMIX>;
+						#power-domain-cells = <0>;
+						clocks = <&clk IMX93_CLK_MEDIA_AXI>,
+							 <&clk IMX93_CLK_MEDIA_APB>;
+					};
+				};
+			};
+
 			anatop: anatop@44480000 {
 				compatible = "fsl,imx93-anatop", "syscon";
 				reg = <0x44480000 0x10000>;
-- 
2.25.1


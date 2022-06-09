Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FC9544C87
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245425AbiFIMuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244811AbiFIMuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:50:04 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30081.outbound.protection.outlook.com [40.107.3.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A747013C4D8;
        Thu,  9 Jun 2022 05:49:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVSPYLfKBijrnujusf3XNrlf/Qg4Uv2Y819DdtYMsUUiTNsfJS6yw5TuiFKQJW2W/NnW1Q0rOgkyGbS4eK7lXwtPUPsVHcDtyGGHsmvMuE5gdY1vMnMaj0ugwJ9CFr1GinP3QQWzHY2pVaYYdkdI7Tk/2NmjThrZ8Rj6BH6EEdW3dMXc4t3sAi3lxmUxvhIoWoYIshecxHdY7sRrXt34lVo2Zq/rpqi24p8X9OizMQu1YNXJQiNWj9PjWGPBhXGyy4wCXwKhYcv+8NowyhKueU7ZTIQYFSVKdUUHBIspB55W13PQio38jXbszm5Dgmdo5LeuZIgNapSCpjQGvm3fLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdhSPfQYla9T1GDxpNkFztwMrm3sDs1C6hEx9QIlXxI=;
 b=Uy6IvDfvwic/bB5jih7ulJ96ohm7UPV1ffjmSXlECOOff/9qPy7TVduMgOqckf44LlFu6rmPQwkK7dzKJfHZ2W28s4QdteigpP3UWvfI7YDKVqqvHwuZTzSoTMaEC9175F9EvIZQ7XFQlGKIQGksyjzB1c4VkWFDKpvi6E2DsneL7vz+/Yu/gVXUYjmh4cat45OLU5L91RX4tptqfVbmItN6DD8SEpyt5nFwcREZ8X5FOuhgNDYsqLIBMd3Cy5NVPTxEM6We2MRge8U4lU3E8iznSod1VG0wX1HYgzE9ASuS/ovRB9eqsdl+CqbwVJtXoLTNaGGhs6Xg9w6UAh6VMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdhSPfQYla9T1GDxpNkFztwMrm3sDs1C6hEx9QIlXxI=;
 b=SlR/bQnwVLXYG7T6Ku0EYJ62dQCqK+WoUkd3HtLoUAWV7fsEGDbY+ikMuBed8pazZaDYZcXdjYSrpgmJwsA61izhBFHW01Fn8jkvHMxPXKuXO965+X97gLYyiO8R8f7eAGyCVZ5X1D5msbkeHU2Ea2y4G0r/6gOzwPGY10INa+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB6952.eurprd04.prod.outlook.com (2603:10a6:20b:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Thu, 9 Jun
 2022 12:49:44 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%8]) with mapi id 15.20.5332.012; Thu, 9 Jun 2022
 12:49:44 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 6/7] arm64: dts: imx93: add src node
Date:   Thu,  9 Jun 2022 20:50:59 +0800
Message-Id: <20220609125100.3496633-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220609125100.3496633-1-peng.fan@oss.nxp.com>
References: <20220609125100.3496633-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7573e0d7-9068-47fc-366e-08da4a1686cd
X-MS-TrafficTypeDiagnostic: AM7PR04MB6952:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB6952704B4CBECC9292138F48C9A79@AM7PR04MB6952.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4L2vl3kbZdb09wddLN7mOlUSL2RlWwE4lRa97kRwxjtc+y14U7zT5BmxmLSsgtRWJYe0704eEcCq45oQM4NTcnMQ1nRXr0OhTCFeccc0DViym/3fuJgNWXN/Dx01QQgLZywR/ORMp4IH7zQJeW1VpT16sKJLwwXyK+Sv+6OU1rMGUFniX7u8pKlPL9lVieDMvJ0B8vF/2qno3ib3Ims0QZ+ib/vh6XCGWoYlgzKQgHW8F1tEmgswZQmaPwkm59dkJZnQGyBbZ56PkESj/BmUS5+EDMPmpPZqNxULwPkA+QO7ipFjngiTH7dElBlMbYgSOuqjH+XTIqhnRHJRJe5kXU6Q0dOGIWEOCxX4YzaofPfSwSPqmCN1tKabRk7Amc7kNTMncyI+dXztMUW1ImrMqgYLXMc3y2sZEOFtXl1zpL9xVCBTb3TqxW7qIFlBH/unN3CAoFG5FHOgEodo7VjtuMB+HjZPfMELbzPDm8HP3EdoMs3ESC8YkcpG0N1x5vE1CgrzzQEZXkDO5F6Wn7BPPYKCE8MmEDec/ytl6dMEkKLhIGPeG7BkHpPfZY9MmNdZZFu88RvKBOyyrABKqhSXsYxuJ+kSGZpQz0OdbJ/xRiyJe+jl2dMDDql4Ns8D/zMWMJRPXcW/Ruf2eWN8U3bEvBRJbUcBhuo2ft6DhGyKXOMA+e20RbL8W4BSncd29FbtH8R5A9/r01pnLF83OoeBhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(6512007)(66556008)(8676002)(2906002)(4326008)(66476007)(26005)(6666004)(6506007)(38100700002)(52116002)(38350700002)(86362001)(316002)(8936002)(2616005)(508600001)(7416002)(1076003)(83380400001)(6486002)(186003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hSMmFlKPoibkovhZ2NXqa46sK5yePqKijI9/4wYOgFUFKgM7f/1H+/bFTuPa?=
 =?us-ascii?Q?5q1uDdTFbs8WBHqdnjW+fOro7obONpYEmM9BWGv9qlZoiRpirWccC2lD2VuU?=
 =?us-ascii?Q?EeLOWFMivOzGJoCMPyTXBu7V9GjzwjQlSzLmaCbO9B/6eNDkDb2G+94ZC5pF?=
 =?us-ascii?Q?chsXmhtVU5+bFe01sCNZOIFxmmzGox3qNCDWO+ZP4Ejht5LsmL/+74mbq136?=
 =?us-ascii?Q?LzEkBcw0UgVk3r82arEtydJvWuHaCgEocG+LRMm+UUMRBoglQd6xACPBrzB7?=
 =?us-ascii?Q?TPzMZoVnnJG3cc3aB0HvLP8lznRJhmYLOui08GKmdZpWltKcTjwGIMhiGby1?=
 =?us-ascii?Q?4BcRm7G5Zd1yh3o7ahecQ1L2A61Ac7ovCwT2WwazoD8nyyqm0Nm91c5AlJWV?=
 =?us-ascii?Q?g1x0sbxRtUW4Zuk9X4Nxi26YWj4wRlgVYdCtI8QAX3ZMJhk02pfVYqosegfG?=
 =?us-ascii?Q?/sNRHzuBBA7CkefY7x0mNXKXGBXp6ZYcPPL/tUfd3mz88G6bRvYSCtzXU4aV?=
 =?us-ascii?Q?vosjjLqM4fgatTvMZSop463oz7K91y5cOXep9GchNBbOcFQ4l2tiuUq4oQdn?=
 =?us-ascii?Q?WbuNHHXnzJcZDqrUCQPX77lZtUB7pNLfBskCjXokLYr2b8JVoSRc7YQ8f1SF?=
 =?us-ascii?Q?udvl3JBztHuMullsw6okS6VKSmFDQRk9aD3eB78rlwShgz0nMfHKit2eWq9F?=
 =?us-ascii?Q?ySP9QvXuafgENO15S7ZFWW+tCHUz68XVqhhhTtEUYP9X9/kt2vyJ/XtjD2M6?=
 =?us-ascii?Q?Ge6m4MwlIwzRf9rnrhTh8YH3o2yNXFKrn6I2O9YDsXoVzklFHfJ1gNHtUP/I?=
 =?us-ascii?Q?D1SPGbkn0rDGbByI0jqrj7vMSi8N3qyoc2KFFUQwsWqXyV3TJWISCdFZEvL1?=
 =?us-ascii?Q?dCxO2yTzovZROxiI4gPIct3QYl9TxEI8+WnZn+XKAzpU3OAK8Fn7Z2/FD4db?=
 =?us-ascii?Q?MoiItUnPprrsWX6RDaDsiDXzLqNJ8JlOhUgU4O7Sn/5pyafmZGUrG6gcMy7i?=
 =?us-ascii?Q?7YpajA7n2s+Kcr0SCpYMo4vN/hg39ayRiR6g0JGcL2o5Gdx0iaUVQcZcH9l0?=
 =?us-ascii?Q?D3ByFnGrAuAvPmNUAzZLcrzQWI356S6Gw2webQNd/qG+sRnk9BJnfAZwNCuy?=
 =?us-ascii?Q?i10T2dxxbu3pUI/cFZIe1QlrtS2Fz4cCLQ5RCbNYCyivoHFkZ0hEs51/N0JJ?=
 =?us-ascii?Q?uoxiQj948g41je1evXWqGC0zPEdUDtxpoA/bx2V9KAxvueMF4PkrEeDblbk8?=
 =?us-ascii?Q?MqsRf6/bsHYNh9oiEUjnO9G59vauAUoET3dWgCPNhX9+QbBAee3cNxJK94nc?=
 =?us-ascii?Q?wJ3+SzT0Kw0LjATb/JykFiGI7m05Zdb4LBMM/EHgS3S+7bD79rAb3Q36GfEo?=
 =?us-ascii?Q?G0Pm7RqJY1+s6IEk2pdyQ+82e78w/h8NxcClkCgaTr7rsnMPHWc6Ippfyz/y?=
 =?us-ascii?Q?SC+7rSYztUqw5KbXrX424UTsyrhBI3ex+UyUpDdRWPr9iPaSPmN38gaHfgPH?=
 =?us-ascii?Q?B6V9fq7EiHyqWhqfzwUFrHYmdWUSekqfvmN49L2ioKG4VbDaDG9weIuf6p9U?=
 =?us-ascii?Q?+L3few14X4kYTNnyVqgVM5llnbgvr5xtNSuR0jPhE3DLg3vjoxYoybBqZoVI?=
 =?us-ascii?Q?RF2LOqjvtJWz9Fgq30Sj9Id4/g3Ih8ZE38o4QWxerP9MvGEGYLG8F8PzFZN+?=
 =?us-ascii?Q?dF82saX+l9BW4LD0CgaWUhRPrAB/TPrByJT5RM+Yyhd69weo7ub2SNIL/a52?=
 =?us-ascii?Q?SZFYYcytnw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7573e0d7-9068-47fc-366e-08da4a1686cd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 12:49:44.0766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TdqCLs3HXVP95gCYJuQr6+Py+o0htRBjEe5KdVCBpowfCmQUL964xg8tBOd8ct/Kb1/4SOz62VJqv3c/fPgcCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6952
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
index f83a07c7c9b1..8f0658e95e0d 100644
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
+				slices {
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


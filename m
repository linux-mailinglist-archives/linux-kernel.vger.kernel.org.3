Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87D554DBED
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359653AbiFPHi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359677AbiFPHik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:38:40 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20048.outbound.protection.outlook.com [40.107.2.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FB05643B;
        Thu, 16 Jun 2022 00:38:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fg42TZTKRZMANOJUw80iJnUdm+BbYuBOOV6WTuBgXXcecsUX1QRrJJa2+qCHx5A+GsDCU3M1LD/ZL698B3wzpk11KhXG8NuZTqz+oiyfy09o+/W8NYtxeK7pFI8nEFQfgikfTiZcZdb4EA/+082h3V0c7h2DRxc6k+j7zPvdl6b5A7lLa9ALOIVeMT+sIUvx9YZBj88ZQF5J2CKh5wXlcQc+e7i7YKShoPucZEkSePw7OveybmwmDoW2P9SNYwfPSU+F2W8OspLbkYY9v89fJyvl2hgh/Xe0hSUqYRX7yBUwh1xTev0Ouft12Bc/X8YdJHFJZ+aBKvwLFvjrAvQNSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcPY4/x0vsLFHbd6JqLfwgfqicwPGcQpzuy6Oy0sgGg=;
 b=fp/PJrBdw2DEe3E0flb5rAq839GV4ccFXDuJ1dv0UU/uRrL9/bVw0HePcdpVwdo1WgFuISt+pzW/WsxmsqI3R/WVBwEbySoeIcfEi3Kwm4Pyif/0Kzp6sa1N8YiiFWooY3xprk2tunIXDaOPgl1m/iIJVGCHsrmYxjoCvczfIUOBBuwak9vac1Jo2tDcJURzB6gTUN1r68iwFWq7y7SQO+HemEimWPGscg0JABFMNZQR0YnsmVKj3Br9k6wK5obXwdM2w0CjmB7MzfG5ERXjEBd6Bsi9OXbuo89WE3QUjgbbJVX3UWTkEyOJ4lBkogYiQFCJ+YNVuGsDuhODVpYaKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcPY4/x0vsLFHbd6JqLfwgfqicwPGcQpzuy6Oy0sgGg=;
 b=H9Fq7/ypkep8moFdU8UFKqzuBY6T1pfwl+s+GcfXkni36z91e7A8gTpGrdWEnAUriXlE2ZrXsBnZq6CRVhlFqaMCP0MDXvnCFR8uUEXnoFq7bqGt7Zy7LqeXrutY2J5nS0RtMYeiqckOjQcuBrexf5AotsT+s4jtpM4Ki60yyCg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB5739.eurprd04.prod.outlook.com (2603:10a6:10:a5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.13; Thu, 16 Jun
 2022 07:38:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5353.014; Thu, 16 Jun 2022
 07:38:35 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, paul.elder@ideasonboard.com,
        marex@denx.de, aford173@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 6/8] arm64: dts: imx8mp: add NoC node
Date:   Thu, 16 Jun 2022 15:39:51 +0800
Message-Id: <20220616073953.2204978-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220616073953.2204978-1-peng.fan@oss.nxp.com>
References: <20220616073953.2204978-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a58b173-fe1b-49a9-0ccf-08da4f6b3816
X-MS-TrafficTypeDiagnostic: DB8PR04MB5739:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB5739472B4C105FDAE4C5BA04C9AC9@DB8PR04MB5739.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KOoaDOWFURanUH8R2ulMDBGYrgJigkw/0MDJZmGLcjSd95bf386ZdAEy2isY26MtQ6dAmafgruuNbgBYjhQNG4YWBbP25T/YA4lc2Oi6wWm8GBzobeRpLwiwSyVkrEsBni5F4KO71ml1kOaCj8GeI+o5MewSjr6v9r730zg5IH95RL7elxUz9QCrmwQFzrzAg8joivQRzuDHwYV4y4TSvd4naCO/39jdKxdjQe7X74cps1H4Gf3BWlIemVKfREnGNo3OhVDJctUM3TDHiIohjUxIuvwbVGdR6wOZ9pPyMGPhGTk7G/W098Og4FFhL1iYATO/ta8P0JTi33xneRpBVqeVPDXc1VHC+kRjsNq7vEG5bVQslBeXTT/di2w2ijJexsi3lUXiR63x1AuR7Lx5cHm8LCzMmEWEfL/5lmzOgSjNaIZKyyHS9tB1tYyDvNTRsyiCpwrfHqJcMZa5W3ysW3FGbJ6v/SD6sp+SNOox8iEEKyAXXH5hb2jTDMmLshnHWQ7b4je2csMFzal8lgbipBOcbEwJVp+VIPVYxg3KfRawZy4LBbA97xcMm0y1PA/vLwX4YAwhDKZTx9ljkmw3m1DNXLMmkMK9pl4i7dJpd00/bqD+7WdES820Uy26arzo8FZ5rIE4iEfpQPka8xs+xJaaWlWwyresBVwm2SYwkqjfrCSBnzwAyAIa6/4bzjThs78i+OyKZohOAZpCTxU6PqZie1NUgW8ecovhW8uK1fE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(1076003)(38350700002)(38100700002)(66946007)(316002)(8936002)(2616005)(86362001)(6666004)(186003)(26005)(66476007)(66556008)(4326008)(83380400001)(8676002)(7416002)(6506007)(52116002)(5660300002)(2906002)(508600001)(6486002)(6512007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M3BurBsLWcLWzfkL4N076SoeoHRDHc/tWpCN4bhaofIQ/7T/dO39pY3PXmKG?=
 =?us-ascii?Q?K7gCGBDguXqMaZYJyyNsT3Mvnmugl01OyEwf6exhoSUfOS2OjjDAZCFFsSpi?=
 =?us-ascii?Q?BW8r3v+QH2uTZua67UYpPNQT4gALpXsZZ/pAKv6xeOw0/v/FYWWmpz5qQ7aJ?=
 =?us-ascii?Q?QGwlJtjfQp0RdUhpB6KMnRjw7i32nQV0PtqioSlsxWTt2hBTaNW/SrF7Erxa?=
 =?us-ascii?Q?kv2uERQou6hUZFMNCwZW4+Rio7N3vIOz5s/U0wkQfRSpEgU1wDwxCHXNHWN6?=
 =?us-ascii?Q?DAWwjSdQam4cJ23tpgeIx0F49ALuD2moHcAgrzopGFOIN4cxZPxHOX0FZGOJ?=
 =?us-ascii?Q?9IVOI9JtE/iIkp1KQrftOSM1q0zy/yseUzqon3uaIy/HhXxBltDjfa3SLVkA?=
 =?us-ascii?Q?peWGrwYw69Oac21MZHBGX8JFmRwfvSTPVKhSg/icjZ9vk0DfN+xmFv/ix7Ot?=
 =?us-ascii?Q?B6H7A7o7D+z+6NGCCs2Ja2oGg7o9OGXvfLHvlZxqiGXB3hsFptWk9cjgI2QE?=
 =?us-ascii?Q?EMMbbH3buo0yq0vtyBYXeUdCHHlZ7fKQNufMd/XDL2Lye50FQmxV1F4DVC/N?=
 =?us-ascii?Q?tAdN4c46NUYmrz1Kczyv6PaYDU0gMou77AkXhyncq9trhpIlXLD2j9yc5CtB?=
 =?us-ascii?Q?iIT/obr8KZa9ocxA3K5VPvUmb053Un8kh6Gdg4vLyICz2eET0jZajxQdvTvj?=
 =?us-ascii?Q?gxGI1nHYVYvBq9PDIaUVeFkGmbexwFMnhxoWKkU/WCTUhbQmlf+OVqgI16F8?=
 =?us-ascii?Q?vMf8toqlxu0rVNBTp3xrIMURzDUh/tmsuHSakuov9BS/kGHeQnZ2zXq+nAUW?=
 =?us-ascii?Q?SF3TJdDkbrI8Z2IXJ8akCpCsDTClYQfRDMJ1NGjCOOY/rJCFFIpFKVlvOyF6?=
 =?us-ascii?Q?84bqWN8M8S3lZFZnBHM1htBVCjKhaH85UOx5aFYZkc93GzdZwBWkvL4i9tr1?=
 =?us-ascii?Q?yZEqGcCtre6xDLRWUlSNOoKUAn7JD4wn8nsDfGx9OcKh3QdiPQqe6+0bi4/g?=
 =?us-ascii?Q?YwJGBAgWLISSMeapOBPnQsKGUQPw2M4QgYkBs2sXbKhCjkfpa5FFkoOwmK8i?=
 =?us-ascii?Q?PscEpvCbQwt8E7W6f6cJe216Y6nJAZqFYX02aDdhyxD4eU4GfBpHwhFJaZoU?=
 =?us-ascii?Q?0zMbh9ucEP/dgHVeAif3DVBEG9TlumlbNg/YFJPqO8NQLwtnd+wlTRZFE1ts?=
 =?us-ascii?Q?Iz/PaEi8tNpXCRqEqifG1jM+osIRoQny9xBiila7+xP5FAeNdJnN0mDpkDhV?=
 =?us-ascii?Q?xLm8OwHWKqETlhgNsESKNpuuVJGtrI38O3KY+WIGpe0jCVoaWrLQwj1v1Kts?=
 =?us-ascii?Q?MMfDhDdUO7KZTe15AXemevy7Cj7TDe5zIPMb3W4UnS++ZIIlhHe8pOVrf9re?=
 =?us-ascii?Q?HNyAqyO8Me9FhDBtuFGQT/bZsPNn+x9u+4vUT+WHBpG8pQJeOYx7boiLmuu0?=
 =?us-ascii?Q?w/NUB2cIUkoMp0mWsqfILlMSdwCIs0W4JuD2uIsp0eRH3jQ0pRhjG/HgvnQA?=
 =?us-ascii?Q?Rgo1El95RNRyuCLIGZmSHUR7kMQXvghpKmYwI9jn9C9Gx2tG2Nb7iKEBwSbd?=
 =?us-ascii?Q?08ZEd3EwNVWqzXlFGDN6QoPoAKJdky52nYoUZHjg/tm41rQoB0zzimmypgLZ?=
 =?us-ascii?Q?ehqJHZeFYBNOuC2wBpChioPQIasuJkJFR3uVhQqUdYGEj7QzPVfQGCTgr/T2?=
 =?us-ascii?Q?u2XBgKslwSZfrOjmpNgDTjQbnip2mrpOiDOP2yiBUvL/jUeCKDp+KPFuJaIq?=
 =?us-ascii?Q?M1jsRVlfng=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a58b173-fe1b-49a9-0ccf-08da4f6b3816
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 07:38:35.0691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wlbhyofu0xtDI6IhF+v0o0sGlK5ybcqXpSL8lXikZx8qV3iToAVk7AxaXpGbCYu814fEVR2KzyauvZ5xmkCYwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5739
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8MP NoC node

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index b2f4a5f1f73c..dd6ee0a79cce 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/clock/imx8mp-clock.h>
+#include <dt-bindings/interconnect/fsl,imx8mp.h>
 #include <dt-bindings/power/imx8mp-power.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
@@ -1018,6 +1019,27 @@ eqos: ethernet@30bf0000 {
 			};
 		};
 
+		noc: interconnect@32700000 {
+			compatible = "fsl,imx8mp-noc", "fsl,imx8m-noc", "syscon";
+			reg = <0x32700000 0x100000>;
+			clocks = <&clk IMX8MP_CLK_NOC>;
+			#interconnect-cells = <1>;
+
+			operating-points-v2 = <&noc_opp_table>;
+
+			noc_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-200M {
+					opp-hz = /bits/ 64 <200000000>;
+				};
+
+				opp-1000M {
+					opp-hz = /bits/ 64 <1000000000>;
+				};
+			};
+		};
+
 		aips4: bus@32c00000 {
 			compatible = "fsl,aips-bus", "simple-bus";
 			reg = <0x32c00000 0x400000>;
-- 
2.25.1


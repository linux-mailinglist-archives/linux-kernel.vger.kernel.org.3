Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0465656D4A2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 08:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiGKGYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 02:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiGKGXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 02:23:41 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80057.outbound.protection.outlook.com [40.107.8.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B627D637B;
        Sun, 10 Jul 2022 23:23:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjiwZsI2bVlmL9QW+H8e8BOKCr9e1LqjmdLLNsY5xTw2j4sOOfkeDixUlTBPjXBQZLJz20FiHmvMC1Ac7MAJJ7cTj46CoCUVhL8U4WqDgyEUYl6Y9tpHo3bSrxgkur+tSVH/514mThBxqaqEItPkwZHxe2XzBMWjyIp50s0SaAdkc+fFm9lmPy73VIqKqZfd7dtVLAKeFU9LYkO7rgMK045WaEiPWw/EwVi4nOsg4nzUQPx32Kja9UOkuab6+nCGi1sgVTTO9RLZbRQeXTx94XXC5jfIXSvMOs5a3Q1UC09rbazzPokh+ouWERFkPeUCQhMk86P2GFGgupoE6Xoclg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8a7TK8rBMLJKw7jOIDDWzg0ZGU4t78s+Obr03vE1wDk=;
 b=MxyDVaVWHa/9D4ujDyPFi6ThF4TjyKlb038PEQhbRPyej2VFQgp/2JGQ213xiXhNJVbHTi8saTM98VO/24xboNpvC7IUiRMFqmBCi6VK2s2RBaLUCk53lrinKOsQnqTK4j6j5E603vGChEwz5UG5wZ4KSYBz5oGpam1TwXYQjPBfxHO3M3t4ZDreD7irZCJOSbYabwN20PuZjQ9wkqs/6dt/aYnbZBUsjVh2O6LjN6xbSlONitdnKPxfqlCRy+UogcD4J8kgipyvjnC8bB2WBbotejlNQFo3wKem4QScHD+ugWpNwux9JrFhQw3+m/7RJJgY6WdMkM01GFbWXkYomQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8a7TK8rBMLJKw7jOIDDWzg0ZGU4t78s+Obr03vE1wDk=;
 b=DSU/bM3gLo+nskJH4L8pkU1XiER++wKjP9H8O5SVPqw5lfvPyf7QHyGr7hgPHtG3fG0KtqUbRUhGgUsfW1spF30JW5A6qYOE5Wf+CTBqBDyiQaPXTxUvoPLTAqfD0UkK/Zhl1/vgoX/9+lcLyxk/POI2IbvulYN8HMmvUzlcZMg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB5212.eurprd04.prod.outlook.com (2603:10a6:10:20::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Mon, 11 Jul
 2022 06:23:34 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%7]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 06:23:34 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 5/6] arm64: dts: imx93: add src node
Date:   Mon, 11 Jul 2022 14:24:51 +0800
Message-Id: <20220711062452.3575032-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220711062452.3575032-1-peng.fan@oss.nxp.com>
References: <20220711062452.3575032-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0182.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24a7717a-dbb0-48ee-c266-08da6305e1c9
X-MS-TrafficTypeDiagnostic: DB7PR04MB5212:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rJZfV7n/X15sFPhdeKc3LBMs77EAjXrfbCYGtfxMQ+2iv0XxCM7vnlES2GOZMyzdL8c5l8TTJVQvJd308iAley9uoxnnU0QiU2ktgNI3jWoFbM/aJ7fxovkcrMtQsVsbHEx/0nb6xgoLpUSJ5rqXA2aWPpvjEaAW4ZAPz2UgRuM7HXIFA5WMKLJmngBT0WHpH8eZSEjvNMsTPFhRZMuYwhyD0/3Rogxbr6sLqrOq2IDZvvTrU4ctzn3WhvNBzLdGlmteQcRsoTnpFujIgTHePfpuUZk03om82BgZLog2jAQ17xlRb08rZJwxZeMHvsrU40clEV8EK/CgdevXJ3gZWhq15c1Hy6G+HG1swr6SOyDQmC4uA0CJikKOA5esdKOuh8Q4LlaFX/Wcb+BDVYfUJNXT9NgZv1y67l1E9fECTnoa5orRKQVeSpobuPfUBdcZbKXGXAQI1tGkt5OGCO9UITv4lPoLGj+eSOUX/ObgcJ3jEQcjM+1dnbVuVcE8BHwPYIZP+g9hwRhi7+qQnwDXOFV0RWqCS6rt7tuApm4tfxtnp4fkyr3RM/AUG2O65eKcKCeDTFXaShKVG7sgaS0BV5xp08znIyVJFi6iO1/V3GSjUM3+vvJJWg6MQnp27kOve8Ecv8fSYDS9bTbjY1FsPEwc0FXZgXKFU0dec38h3q4ZowwN68TMpV7FpGZ6yf2v13pe7WMbX8WLKORTyF4vl9Zc8+MXqcGSe1BmrxWrD4fDpRlRTWzKocxoa2ld+4zKDq5nsUIW+H1XKwonlyBtMFUAXeFNBfbytADzWk83E2KVudpgp4e5f2M6OyQbYWM6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(66946007)(1076003)(4744005)(66476007)(26005)(6512007)(66556008)(4326008)(8676002)(8936002)(5660300002)(186003)(2906002)(7416002)(316002)(83380400001)(86362001)(478600001)(6506007)(41300700001)(6666004)(52116002)(2616005)(38100700002)(38350700002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C+QqQSeaJ7lffhKy9M/v4QGHJaET3kZbjpr2098zTAoHP+xgU2d5GKJESSOx?=
 =?us-ascii?Q?OkI26nLbbN97aNsyZ8O/uSqWVoeY0S/INOOn3K5kItsSk477kr+LwSgbBQDC?=
 =?us-ascii?Q?lJujyRlF6ES/qTAUlWFNBWSPKOaLMZ8+EIfNMOZBDUuMP9saEI2SxeaPZLoH?=
 =?us-ascii?Q?BGDqZlbPaAdzXfHpWfwQyA5toQjKMiq6+E0IhUj47X5eL/N5R3eI0/CbUGGu?=
 =?us-ascii?Q?O8xUpuHs1fUkBWqTpLEk3F5UjZr7+dli8lritpSThlSqYIBm0PmgPxvw7REK?=
 =?us-ascii?Q?hUYm0435nOEsl/DVnB23vD67YJOsX7DJzi7sY7nOxMMVejeHP80T1Dq5ecCf?=
 =?us-ascii?Q?6uisigMT31oUZPC00xxAxgaipPDbqYnaR5yRsuCfqOGW89gYTznrE4X+lBnl?=
 =?us-ascii?Q?Qodi19FB6asNvOq+WdGWpKPkwRT0JTyrrNvdo1nBMRK9/yd0Pmd1grJB7U2K?=
 =?us-ascii?Q?0Sf9oObV1eEAZDoArePWCbnPwwja8wU9RSDwDpS6c7Lp8q+1biqcZnImnTtS?=
 =?us-ascii?Q?wVXCGmWZIqigTD5WtHA/3Rhz/aeupHvLmzEf4PISsKTKMfbJKTYe67tUEIEX?=
 =?us-ascii?Q?H3uEV7yCGbro5lD3LSeS3LRTWVmzJl4SXMQeA9ySCRaXXP+QLF4Ky8dRjzPB?=
 =?us-ascii?Q?2OREGmTYJGWQaQ7njg1PA9EbAmX2lxgtNfteh+hsYa6IBmdOaznBpKWDu8mw?=
 =?us-ascii?Q?rRvAESgEHTZQvC2VUkZ+zD6SRtGmN8yeXECiu8zH8t2vUzwH+/gaFAf9JJed?=
 =?us-ascii?Q?KOHtW41jIhEEGQdmDwBrncIkoaKbReNlKIYrnRkcfPS6Ng8tuxVG52hpnd7f?=
 =?us-ascii?Q?xxwpqNUJ2G7rEJ17lSPZXFhuT9dMy8fx76tZI2CiAwURcY6Cei2/zw1nLY1P?=
 =?us-ascii?Q?ob09etsOZ5FGSwRKB5xeUxWRJpW/iVNQx5TEtGECy3ToTszkxBLfVqz57mJa?=
 =?us-ascii?Q?tRKlVfETtFDY0obPA+1ADCWX4bRPe9GffIxQEZMBfYtsUZF+4TVO0Z3f1DSa?=
 =?us-ascii?Q?CgutQSfDex2xKBifVO3dhL4xnPw5N6bt/bzvrr2HVip0y+d4F0qGcZh+oUPW?=
 =?us-ascii?Q?hVTJWxCaXmwGBJMTzoP6A+KYA1qt6IJf23z6NcWIdUQARJqqML0K+ummHzUZ?=
 =?us-ascii?Q?yg2HSTMUljAaIGLKS07j9mbyA1o+TBXPSfkmRoR89nctu9PVe6Nsk7VQ6slK?=
 =?us-ascii?Q?Gnl7fDK/owQx+Hs4cB71NXb2h+tMtKQMOwx1gwISqonhz473EIq0PLMiOGlZ?=
 =?us-ascii?Q?AnRckmVF0UoeRqrN0hRBtV648KStzaWM44KXKN6Xs6d/tn7v03jOFH2jDggI?=
 =?us-ascii?Q?FvtiS2OxM/wPmvwBHEJghBwsRsnhaIVOYZZSbtWNrtJOiA9UAaxhCRMklqPA?=
 =?us-ascii?Q?P6sf7NXjvreJf/jes+oAaotoxvUMNiu4zhE5RRwQX385mrAtXlxIcckTq788?=
 =?us-ascii?Q?Z+oDf/jwjat6R3JxbVsx+Iu0saf5+fQ684mK8IlNK6F3gvkIxMe6FCK08wvL?=
 =?us-ascii?Q?yQVuElpSODH+/ZyAvlGVQsnDuf7R6ZtoNcO0r4+V5uJAb1RoRd7w1igtzW83?=
 =?us-ascii?Q?STTvbmlJzZJOXaX9EiC53Xy3gznIjoyr+yiwXFQZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a7717a-dbb0-48ee-c266-08da6305e1c9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 06:23:34.3397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Qhm7k874xKgTMwjj+ZHPvIop7iMJ/ytvVyD0O3Q8pailroEDamiweHOJ77RBKyYXw3BdRb/++Wvk+QP6W/HVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5212
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
 arch/arm64/boot/dts/freescale/imx93.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index f83a07c7c9b1..883d38920db4 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -161,6 +161,22 @@ clk: clock-controller@44450000 {
 				status = "okay";
 			};
 
+			src: system-controller@44460000 {
+				compatible = "fsl,imx93-src", "syscon";
+				reg = <0x44460000 0x10000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
+
+				mediamix: power-domain@8 {
+					compatible = "fsl,imx93-src-slice";
+					reg = <0x44462400 0x400>, <0x44465800 0x400>;
+					#power-domain-cells = <0>;
+					clocks = <&clk IMX93_CLK_MEDIA_AXI>,
+						 <&clk IMX93_CLK_MEDIA_APB>;
+				};
+			};
+
 			anatop: anatop@44480000 {
 				compatible = "fsl,imx93-anatop", "syscon";
 				reg = <0x44480000 0x10000>;
-- 
2.25.1


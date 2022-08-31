Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7015A7812
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiHaHtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiHaHsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:48:31 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1517BB3B39;
        Wed, 31 Aug 2022 00:48:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkhlvDNzvomOdHQr/vCkpWBRKQ4IyrcHYKgNWT+ocPwx0lnM11Lq3pEy/na/jXvtR8FuwRZ2hT5OKx2499BjMvrBA5dURuFoO9BLvKTX97dET6yZS81pdLsYOFkP8z/7FiLvKpVYdyoJSf0s5VC1JLZgtCcJBGDo/CfB88DXo2HSh2rY8CrgTVIxAOKoPxWAXqbO78/xqbTIKrrvkVJclzRFlArMWicDt8q03w8JgmMcr7fSxrB0uleQtPJ39TCv1OFmJmxT6xyNkTBKjXd07B/VtV6hJm4TQkA6E2f77X1XKDaw2Bn7vvQKCPrSWW7ArbDlZrFimgxPPCiPbLKbpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jzF5bfJ/8npWlPnzTODZW0dj63j/TG1QjRCIWaygQo=;
 b=Z0g8xNm8WhX0Ba8GTlTe/SyLdSwrs7tVc9KkKZaQnulMeXHMjQ75CbnUhcNg/ov2UetIYeU1a94Ew+sREYFYIkELubgmY0nI4P+3d+JIfQ86Fa6JnKEdla+FNL0MP6NNhMGJqXrOXQkjsSypTuMNB8E9mcykyHVJca9FhMXnYNuewct2ctzIliMXT3k6d0JQjYN4Gu+CF+uLFgpvlZ6/2IIjPgF4hQ3goQidjtHzRrlB2k2OEjTwLymTVvnx4srykffUQ5LCf+VLbOune6R65My2nQ8Ev51ULycIboLEDraobw/K/eJejETh5v3DluYcUtuacgbzk8QDIMzvVhVZEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jzF5bfJ/8npWlPnzTODZW0dj63j/TG1QjRCIWaygQo=;
 b=dfU8WIdEBPDY8xVN2nCQSz1n2ccOtHCa7KnvWkgqcIMh+YoekfhHB+QOZQrFFokjD88ngWF3S5t1bbcO4wZd7ei4ztpdl5D1P/N0AGvsRM6moTvkpDVmJjG3M4ugUzlq6RXTimIf3k0qMkjOnTQTfajKASCQ5e2xaiSjElMCGA4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9247.eurprd04.prod.outlook.com (2603:10a6:102:2a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 07:48:06 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 07:48:06 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH V2 3/8] arm64: dts: imx93: add gpio clk
Date:   Wed, 31 Aug 2022 15:49:18 +0800
Message-Id: <20220831074923.3085937-4-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1b65b60d-d9a1-49a6-10a9-08da8b252408
X-MS-TrafficTypeDiagnostic: PA4PR04MB9247:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LeGjqmUEbnHxiuqkhNbFUfjCrq70rmqb4btygctz9PmJz+79NkWizFhCOw7AcYLDDJy1yMYnhKaamEFlBQxkpK6B9KKkMSZuQx2TL+rmDz5o4e/kASPJR1d2S5qEyu1+2K6Eq6WhuxoS/BSc0JiA+3pOd1ystyf8S5K0R1eQWofL5gMGhVuuJ/7CIwBwUyA7v/NRCTscplHSJLrCQiFe5fIoGVYubUo+9BLqFQk8y1WrGDf+Pwd3bHxp71Wsdfpt2PoH83G1s0iE8qgdTwcHYkQjp3DtBtdOcRTDIA2yZ3bYsmBF0ZCbGKVxSXfhe3ur2kpcX/XjNPumIGDmg+cr4sd/dSZORa9ZOIu/UCOJAKNevMYhATUUHH1yUY3ZshSmBQ5rUAPOaY/EsHFYxSaUjVqy65pYi8qmHOrLKJ23Zob09Qcp41xOewv1L++TJnvyarxNAd0XSzD+DovQ7H8weyfjLlz4Losk0l7O+Rxloc35jRUJyDTSN9p7RsJBCoN1tyon4rvYPai+fpSzQFfK8hVRlbkuL5hjR3sv11VIgNYVc7daB+Xcs5XhTx45EPTlXEX0y1pr0VMco3IAkUsFPaOxYxYoIfVovHlZave2Rh/ohkyfGEVHSCVR0hqLGG95vsKFFOW0LbjBVJbR15ni0WkKEkZXNbicYLUNmhjW+qcfV+O6RgtzP7tcxXq+8ilcdAUPvki2qPIhgCNVump8FDF9rRVXtD3sbDknNBY3d+dZ1a3aZSwf0/79Pt8Om1X2dama26WxeTn2kj4R52c8fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(66556008)(66946007)(86362001)(38350700002)(41300700001)(8936002)(66476007)(38100700002)(4326008)(8676002)(6486002)(478600001)(5660300002)(54906003)(83380400001)(186003)(316002)(2616005)(1076003)(6506007)(52116002)(6512007)(26005)(6666004)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?27g27d/XlXLkrQI/x5Yi3w0fSxz3ksm0PLrZMY22LmWRNAENhcOchlbQ84kN?=
 =?us-ascii?Q?sY4ErZui77gyIXvN9dw29Y452Hz/jdvN/hJtKutlx9egzg1z8leFRzGOa6AL?=
 =?us-ascii?Q?6pkRNneQhu+NjHVPdrRaMfphe9xR+7UaBytyWRG12R7QI1oKc0l7OLAtXS9L?=
 =?us-ascii?Q?HaeWWtutUpwtbAJpU41iGD6BVYQ1K1DG5psDtztGjNIGT60rp8xpGw/YTpZm?=
 =?us-ascii?Q?PfWX0+nbrTV2LbUerU9x3rdAhTurjTt5LowL/y+1LO6PBJ9i6JEWyK5Bvw2t?=
 =?us-ascii?Q?dwjz6w9URJmGy0VYIPsqfphbY9iqmNtkj4KbwdNHknV7+IIRvFYRkvxEP8ID?=
 =?us-ascii?Q?c0mT9BP0XNKM7fi745aLTjlrNVb/cBkfAh7+O0xUWOpg9MHQL1ISfGS7YOSp?=
 =?us-ascii?Q?I535oH4H44dWTsTClaJUjeKYKRNuVxARR12i8oeLGYKlzSAVjCfac/62gS6J?=
 =?us-ascii?Q?wJMQTpjK9AguEfMe1LbJYFZiRJrHy1ZKLToySbtuDAryovS09ZA/hi8jg+gX?=
 =?us-ascii?Q?AAWwXsHcd4Y/EumKDyQsMEoDMiwkqYY7HIRUXKvaRT7KpXTBmviBRvSPHt+S?=
 =?us-ascii?Q?MclAr41u/YQIpC/kBgHZ9TCw5WW6NUwpWabSpWq7ckwUE4twqxKAQZZkJG1+?=
 =?us-ascii?Q?YxNk3UtIjSeQTyYB2j+g+RbBkPSHt38adcCWcNeqzzzUG3T8VXncRrcWjgDH?=
 =?us-ascii?Q?QQ2BR/RpuH2CJAPZzhn2165vq4xYRs0gMDhYxDq9d+3OjiOaTXALpvVP1h3D?=
 =?us-ascii?Q?JLw3Uv/Jm9Nss74gazvGEpRrbymzxpHeyeven/M8o6BaiA8OCEcKWgf9NTA5?=
 =?us-ascii?Q?i/mzC4Jc9V4sGEMUFfJlp8VE9TyRoMAQWnF2LalAUIa144Ry6xNkBCnlFkrm?=
 =?us-ascii?Q?TXywYB/XzkXlLaPwPJc8JA7hhOCAhhnoDC2SxWx979TLYqiKuFszBy7gPLir?=
 =?us-ascii?Q?5Tox3u/xbgbrFGowqvECSD0eUyEJAnc9oZJO2p3O3Z/MQY1b1Mns2oQ6zAMC?=
 =?us-ascii?Q?NB+da0bQzkYpbIiPvbcAhunZ1VVu7OtAUmDbIJOls7jaBTtCWWYADngT8+Tr?=
 =?us-ascii?Q?C/3cKENiU0i/9a2lmWTLkrVpU9pmyS0qLNE5SMHxL9Wb2UvwpMQxnJs9wv2s?=
 =?us-ascii?Q?bBwAdsTTJB8LbfOjdK19OITMz04aWYj6XP72VqX2ee8nqQo/vFDUoa5yXx9z?=
 =?us-ascii?Q?qRMBwNbXcAb4htOCwO1nrW8d7+a5NEY/nPVQk4eBXk4zjij62cgGo0Z5grph?=
 =?us-ascii?Q?X1obwV8rR9V9kj5u18HE6qX+S8n/nM2RYVPYip7mQg3k1nh+b5DSwRfKZ//N?=
 =?us-ascii?Q?EtvZzcZDOv4I2VMWx24YVziK5NYYT3jWbrSYpitXyesG5WXOKZxjnkY67mVW?=
 =?us-ascii?Q?JfLxWxgUu8Qfv7UZNbdATRQ/ZZYVgqJFm8LwJjndVo07umzyVPo+sSzCoLJl?=
 =?us-ascii?Q?jkh7OWq+h3YUeo6Eixp1LvezIskSPdYt47TS7og83qk60/LC/Bmf6rhOVRGX?=
 =?us-ascii?Q?jdvSGpsZyWXK9onX0485eFjlKF4rYVsMMB/P2QXKyU22W3ILrVrPHLrudf7B?=
 =?us-ascii?Q?a+e03861IRpuQc/iadGybfAkWBVENsqfotSXxPru?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b65b60d-d9a1-49a6-10a9-08da8b252408
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 07:48:06.3873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0F6x6dsg/UCZ6Y/yo+L3KIT8UOKJeL342XKkp+KC4Uo1qTLjlI70vabzVe271hDq/B6nV3ECskFEs16En3v0oA==
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

Add the GPIO clk, otherwise GPIO may not work if clk driver disable the
GPIO clk during kernel boot.

Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 431dc239631d..26d5ce4a5f2c 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -295,6 +295,9 @@ gpio2: gpio@43810080 {
 			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			clocks = <&clk IMX93_CLK_GPIO2_GATE>,
+				 <&clk IMX93_CLK_GPIO2_GATE>;
+			clock-names = "gpio", "port";
 			gpio-ranges = <&iomuxc 0 32 32>;
 		};
 
@@ -306,6 +309,9 @@ gpio3: gpio@43820080 {
 			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			clocks = <&clk IMX93_CLK_GPIO3_GATE>,
+				 <&clk IMX93_CLK_GPIO3_GATE>;
+			clock-names = "gpio", "port";
 			gpio-ranges = <&iomuxc 0 64 32>;
 		};
 
@@ -317,6 +323,9 @@ gpio4: gpio@43830080 {
 			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			clocks = <&clk IMX93_CLK_GPIO4_GATE>,
+				 <&clk IMX93_CLK_GPIO4_GATE>;
+			clock-names = "gpio", "port";
 			gpio-ranges = <&iomuxc 0 96 32>;
 		};
 
@@ -328,6 +337,9 @@ gpio1: gpio@47400080 {
 			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			clocks = <&clk IMX93_CLK_GPIO1_GATE>,
+				 <&clk IMX93_CLK_GPIO1_GATE>;
+			clock-names = "gpio", "port";
 			gpio-ranges = <&iomuxc 0 0 32>;
 		};
 	};
-- 
2.37.1


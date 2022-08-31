Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBF75A7FB0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbiHaONY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbiHaOM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:12:58 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65EED75B3;
        Wed, 31 Aug 2022 07:12:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfE9ui7cEqr6r9iCQSeSTGiM6ixgY2GgZSCNszpmRYqhAQ1P05+ecpfkQmq1ww+2VUkYE3pBdHt7KvM5noOhF0XAQZI5aVZZckGvDKwkt5ibkCtIY7hEqgjg9qqqrZXgvs70Kmbuy9QDHvmdJ5Se17ldMeopWHDsTgqnASADaKClct6QH82Afzer/NxfH2C8KoTMaGXdcOHmmDsAK8xPJ8tzd8Ky4IhhJDiV5WiGkMInxyxoyiWx9MTUFFY9/P67UsZOzjVtaNHwlGT1HkmPImIVHkuhe8zo3u6EfflCHVQtNsp00ulbQkzTKwtxb6/JSFRnBVDIlj+YFVLNXJ++6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jzF5bfJ/8npWlPnzTODZW0dj63j/TG1QjRCIWaygQo=;
 b=VsLjKGEq8zk1wjsoUK6IcPq1MIkKsFJoSQhkyOYwBp7xTynCI3St7141P47igW7Jq/SwKejo4VNXA9QP1lCSr/XQKRYzfl//O9Lz5q9ymAr2sWde10Fc7NimgiKaOrxjzpR5asPB9+uU3PNhHfkUg2i69pkjtz7Hb6Ubks38/ywGVWuGMAuR0SlIPsM6BK3VRP5UP/Yy4hQm4qZOjHoM97QqdJHNSC8tPA/De4iqBy22elnpOwv92MjoQ2V2kaVm74g7y5VTFoRAGT0UW5D0q+49tULHwlWK9WkuKUx1J2XjK4NlvTaFHsqvdvmvvJhwlV+GeifRka8gozHrxjRcDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jzF5bfJ/8npWlPnzTODZW0dj63j/TG1QjRCIWaygQo=;
 b=DNgW/rdULNUgJuJh9Cr/hlkXnzx5mjWJ9zNo9+aaw6ZYCA+K8C7IQ0YPP2R+pDqSybOCm+TTPkpiRpavJ7z/zygMGfwNzXXqNS+QX6U6wvb+Wzmk+9283nvnwGw8O/+S8as2ipyWUUla9SRVtopBnB02qpnVLI81rMQCg7TqXoQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7355.eurprd04.prod.outlook.com (2603:10a6:102:8f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 14:12:54 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 14:12:54 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH V3 3/8] arm64: dts: imx93: add gpio clk
Date:   Wed, 31 Aug 2022 22:14:13 +0800
Message-Id: <20220831141418.38532-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220831141418.38532-1-peng.fan@oss.nxp.com>
References: <20220831141418.38532-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::22)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6eb58f05-72d0-474d-c21d-08da8b5ae53f
X-MS-TrafficTypeDiagnostic: PR3PR04MB7355:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NPRMlbepVKdC+oE3ECN7Vwo2RcngDkIWPWi8af7mQgRCn/bp7569JfZumVBFXT0yRUgvFEhsziLYkbVGX4delHaC8JEe15yYYtILosBo50fgn7umxpnoD4HYtGQmdillLK9XD1dHOyMl0RIHiu4em5JGepgxr1jNi8MGNe4h7fadZX+lSaAaPKO2Lhlp4njI9delfMbxZRRGVLYXM2MXnlazrQRwQzr2X9l96VhzNPSKAfdLgTrHwZdj7Xbk2ipBPB/O47Ev32UIGymO3q6f2oMZKwJAdjoHs8/KhMRUMMuPi/iCOHAO34cxgsbn0DDrCBO0BlZW5nMRs869Kcd8TmFihMn2i4AQEBBlPrr3IMTcR9RVaujQ04QJmfZ6UP2ZI64Kx6ItyY1yzOwzidSkRMBsECuI3iiMGoUrxyMaWPUoPaPnroxgi02nVFLcIpxmBxB1bpG/o+8SF366dBK1pulO6NwaO+DnqVHOg/nZ4Vm46rtRE79iGHZJt8Oj/LtwOgyUsPoTwWX9G8q/WtMDU6D0vAgHVKYVCHpQ0i6Lemj8ab+e399ZoC9MvmTi8h0f9tcxFxumE6V57VdfN6uL5PrJWOpvVwChKMIU20ZQIdtOCn/jlis3GpngW2mnXd7TnWXZwWuHPej1AT+gwxeis3e7TAMgxjd583LErdsHegGEDk4pFl5mLkT1aqOIl/rNPW4Pm/9sZvkxx0Le/iLhstYchp16INy9iqu9rR3bK1jzP5uprZQp4zuIiwB6JlyQI6rNJRxGTaQ/QHQdUED7uA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(8676002)(4326008)(66476007)(66556008)(186003)(1076003)(2616005)(5660300002)(6506007)(52116002)(316002)(41300700001)(38100700002)(66946007)(26005)(6512007)(6666004)(86362001)(6486002)(478600001)(2906002)(54906003)(38350700002)(8936002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aAd9JXLP5KvVo5mWXvHT4kJVtM2G6fOdW+FJyfmxbxa90OOi2cAcyO2I797c?=
 =?us-ascii?Q?n0YpAKw2QzYRf3D7Bx5WX5ZEPwDACwVDIsWEn9aNkFIXNJkYs23oU9rEb1S6?=
 =?us-ascii?Q?C9CZmL1Kt2Kfp95LVIMmNC7DD9JQUwspSnYSgDn2dm7runE8FUwMO5huOf0v?=
 =?us-ascii?Q?f4U+9nxDlNzlwecZThXdKMW8Tyfu3sCI/tEF91TNR8KqnCBAq/KDVD3OGOIm?=
 =?us-ascii?Q?vnW5BnjiCaEn0KzF38mcAegxPWPHX02iFUGj4Txj77b9gErGcj3IvlT+aQhg?=
 =?us-ascii?Q?L+g24hCG7yN8NdAr6qaOAoRn95EeSVG+NI08fVIarzFyyy2dbwoqqZrZrVRa?=
 =?us-ascii?Q?FbGl415gCJKBW5htp36vAG6o6+2kshzd6oLqae+Jj+c4giK6rl914eCpfPjO?=
 =?us-ascii?Q?JiB+/SC+7YQJnv773T1h7uAn+GMkhJx2HdB1Sw813mT6960p5wb05y5pytLt?=
 =?us-ascii?Q?A8LHOBJj60F2L6Vmg1VstNZQgrSSMVnT61DKnz/8fmLXmfPc0ZxmBFW4TKt3?=
 =?us-ascii?Q?CcK6SFrhIWB4hN3Vho5wtWm0T2oh5KtO6Qf7ikcVnHrk/I/uUvWJ4gPXEQn0?=
 =?us-ascii?Q?k1Co5mkFGDHWnJ799SkgL0Jm4zYVmWHBWqmUgBbeVuT5uUI0WGnZ3y+BwAaN?=
 =?us-ascii?Q?Xb+PGmEQSWKd/ncim6PmHpTe/sGHEMtzwNWF986vGlyKBiF0zuVkGyRUGjGi?=
 =?us-ascii?Q?3hood4Q0nVJvCtW8EWnHSW8s3D8asTLLPHD8O5UgLroPpkS7ABmu8XVPbHAC?=
 =?us-ascii?Q?Q/PhJIiQwT6JD2J6OCbDz3LcTyq6bl+qxrB4o6DzHaf+i/5U5d9ghMTuhZ4F?=
 =?us-ascii?Q?4V6I8i6Q4CooT9d2sgCM6mTSWSdK1ewp7Q9n4VPmXK4GI7AEwyM3ng54zD+S?=
 =?us-ascii?Q?iXadOWwkZFqthDcXMoERR+gkvJVi+I5BUv11PLVUG/1nZIRtr1DuUc+HbWZo?=
 =?us-ascii?Q?8XtmX84mC56uP69PhtkuFQF/0Wv5tRBmbG+vtdtJkjCALRUT411BIEE9J7x/?=
 =?us-ascii?Q?Dt/XFhbSEUbPuX4cpSQb4Arf6vaoE+hNOahwUphAvcio0X3OutOYTJrhIIXt?=
 =?us-ascii?Q?9irv4z6cWP/oXm18Ni0IngJF0IMUHmhYREiIk9v35qh+5CpbhgG5H1OC6cnT?=
 =?us-ascii?Q?td/xsZ6oHYQou+1zu2+TmWctiQmT2gvvAm00E/5+dGb1b1tCKNzvgVJDNCj7?=
 =?us-ascii?Q?sHCrfNCw6RbwTBJYO05aF8+o42A2qw7/bN4BaABF7Quwkh+Z0cqsmQ6f3JBb?=
 =?us-ascii?Q?/0DJVkfQSqs9ryFxjeJwaK2DY5jVj2iDC+SSe6y1fkzk8c2435oPf4iUaUlc?=
 =?us-ascii?Q?A0oGnZgkUfv3C+UanfMu0NT3mbcg1QFTG9HgePe3TJesaSY+rI1B76yHyKuV?=
 =?us-ascii?Q?xZcdq8TxHVoPYIyhsIDzXlpjLnIlb++4q1eM6vmuw99r5zlCCGLVvWWIiPrg?=
 =?us-ascii?Q?G51IgnL4EWHhDBoQRxg6kpt+jfI6JXw5HhEf5M+hhV5qlicT4BE42SPgDG4m?=
 =?us-ascii?Q?pKqRyiv2US1K8RPJnbjVL7B4scWbnWSgxOM0oAderhL8wxXhQIkj4SRnErO8?=
 =?us-ascii?Q?+fXrIcKPbmDYDLUoGpbD56p09S3azfz4f9O2VuJq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb58f05-72d0-474d-c21d-08da8b5ae53f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 14:12:53.8949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aYBe0i0vV4o8XqIRK0KpVNuR2Mb7ZhkwoSyTIBEDoMkt+BHbA+KAcX6KRaBvEXfoFcqmFutlbtkwrfZlJCABtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7355
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


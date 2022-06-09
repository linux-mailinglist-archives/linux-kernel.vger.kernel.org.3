Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7A8544C8A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244058AbiFIMuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245483AbiFIMuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:50:06 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F89138936;
        Thu,  9 Jun 2022 05:49:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgRsgdZTJETHC6qr5JM+DEVuwLu4C8Iz6joZpnLfCCW+GZSKbAopXhXd10WMHRXblGcZlnRDYaEhMn6LJHD2HSTJ9eCHtVNcvTW2C3xtjDySFmifBxqbwlzhVldptvHthBrZREjeRZI1UUlx8xyIPSVol3jaaTyZZInB5Q8wUP6sdl1KRk2igrA0TAstZa4+N5+fMUuoKz6SlBWdF3ZFLWqdEEkNVHpFH7WU79jiej9gJhj13C3Yn737WJLlBjt0ri3UwV0xclQahrfsdiCupE2eukPkoONcvLiHTAFUVr5TnjLdcHcjRJZ5hRPQSfhAvQ6OX122xA9P3E/KjojIdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxBay6abfWj4uI2aTF7bI6Jy5vsMsTD9VaqBi1hNmZk=;
 b=gf+587XxvAeY4GRJvHOrIkcdXtGOMd3mbVXah3ajZHsdzUjAA83szOdOo//9lx+MwF0lXvlSCU6ylVvwZ3KBCqD5CCn/7Oe9ALjr1fJypG9GmalwvzGMXo0XSNUIKWZhybVsjpmyan1qIyPMPMuuZLEYKTdspFuJUP+PM7tTyL4/GQ9GUdcfb2AefvIOD394Xo+YxwN8j7RzprGrOGe4ZM12ChUZcX1MuCLi1YeWAwbkp95GEMimwunPcv54ByrLw6lWvFJ7Jah6WZMVZ9eIPb9ufCdQFi06cp2VGPYzhNTsfC83fRV9c4NoAHGLUSkIMdI5iH2Z6MTNhY7O9wyidQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxBay6abfWj4uI2aTF7bI6Jy5vsMsTD9VaqBi1hNmZk=;
 b=L/w9tQ50D7b/tBLq8j35qV5Nx2Qe87xEFvfCV/N4AOxXjImKWjYpgDDNYRopRgXhQ4MLSEBLlOKu1L3rRA/DbazzWn93bEahsaM1GyO8SQwLtpG/MElztEY1QmgL6AMNaqKYM2+gRcMt0JLxP1cTyi75r1x4MoM5EsG5oogYut8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM5PR0402MB2818.eurprd04.prod.outlook.com (2603:10a6:203:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.11; Thu, 9 Jun
 2022 12:49:48 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%8]) with mapi id 15.20.5332.012; Thu, 9 Jun 2022
 12:49:48 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 7/7] arm64: dts: imx93: add mediamix blk ctrl node
Date:   Thu,  9 Jun 2022 20:51:00 +0800
Message-Id: <20220609125100.3496633-8-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1cdc3913-dc57-416c-efed-08da4a1689b8
X-MS-TrafficTypeDiagnostic: AM5PR0402MB2818:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM5PR0402MB2818A28E8A9CF6099C65C1D2C9A79@AM5PR0402MB2818.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BWdBjxXPjyWUQB9VikR21iWUuNEkJ5dMgYl2FSqepiJPakj2unawQCABDa+Y0wT7TFrtGP2h3/Ca31rT+Z9ttWZOSvlQ8sDNrSdvHKGA+hXcf4ZKN0BMNOME2G4mjD2gJdFByz6O/Qf+enXFT5YKu1SQ80QaKFTxhKc7LB+ruYn54UOxe/lM+YFW4pumYwaR8LH5Nf8gGtUI58V8oz6cZi638ZelmlBYtiwcwbbwGZDzJjr9FCesJyWHINN1f5gZamxTjSSBOt5z/O/w6Oz9gxQmqo97Nnl303L4pzy6HfUqZQSCdiEzFQa8Mw335m2iwc3aXplYqQdsJ6JE6H2JgN0ENrXWzOTy9MxhNjkjJ1HeZgH+CHb0MM+zm6Y6wbvEihKsDoq39tg40FunKdhbhVQe8pwH7Xl2pPH9icbN83BJUADG5H7n3T/wdfrY4JVUqX6XuO7BzkrmT+Rvo3/3U7zq/rjBQGnvf1YnBgronlyYXbkkC2asPRTu8cOa2Vb7KwKDgYpuIVmiQfmJKh0la+8NscsqzQR0dwp1r2I1gmB9+m0SVv3QS9HyQJB+d4lsWVJ4ViTzCOEkp1ZSi1EdHrF6yfzfnAPS0d6w/rzSb9K8zcJRiifXzgAkSryb3XuATSo6g0Udf7hlUxBie2Nq/A+/ZbNeMPfJRyInF1J0wQwoztA0X6517vGLbuLc/VI/OnECFIRCGJGX8szd3CgWiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(66476007)(7416002)(8936002)(6486002)(4326008)(86362001)(5660300002)(66946007)(2906002)(508600001)(316002)(66556008)(52116002)(6506007)(6512007)(26005)(1076003)(2616005)(186003)(6666004)(83380400001)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TFG0O8X/wEypK/+AORm59yN8J2mn59Zx4gwubCS/XDdgPv6BA5ioO8ppZCdn?=
 =?us-ascii?Q?/WcPmoAWxNnfNPcvP13k2MBZsyjVsCGQCJMqshKhOx8435vbC8y5TMiSPZnF?=
 =?us-ascii?Q?C5cmx0N2ENHE8yDMax9MXjeshpxJajE0mNreu4r96Jk0RXvyf8DIhslRcBDo?=
 =?us-ascii?Q?GeEzk2q5SZP91/AA9hoLglZoMePsS2kfEFFlA8q3EG9ptL+t+ZXFUXhf/UE/?=
 =?us-ascii?Q?9Ot3JEupwzsfY+AqZlR2GOaGj236/M5lYEqZyyv/A8jag2uqicGTW+kGrx5S?=
 =?us-ascii?Q?EfwiA4iztCwk0QxY7f7yDhB6jiDOyWYKVkTmmXlg/sHwtoEeGLDf6qJvxDjH?=
 =?us-ascii?Q?WP/otbYRBf7mA4OD6CVOfNtPpaf9faudUsX1M6WG3e7xNBe8m7ud8sRtWTaH?=
 =?us-ascii?Q?LrVwuWXZgxCe68zej687nZ8E+hfWr6uXPYMKCkqCS4OSihLdtirzQsvpI60V?=
 =?us-ascii?Q?24K5+PsVLiJthHWs9xtlb/6r4oVZXYuYO48q3H0+WtQ0So4SyJ7XN57iC5Zx?=
 =?us-ascii?Q?hKiEfxT5Dq/vOrrwSHGxc0eKYLPSDGogyW4P5/IS5kPQ2efdYnrSX9YpKZNv?=
 =?us-ascii?Q?LX22qrI9zqK5HLC/7+/8SKyHvRYJwiGwvPn/FWCCskBA7uvblZO3gagqu6Xw?=
 =?us-ascii?Q?qVnqq4FKNP9JR7od/wxXUFn5NDLLm2c/ZKZApzxqOpEqUzIdcgmxmz1EGs/S?=
 =?us-ascii?Q?yHUAZuY/FbcBtX32r723djgV7e/49oS2sw9gBWsQPCmAGjL7XDKOVom0wY9J?=
 =?us-ascii?Q?zpkuXXuHjtUVfhDY2agPG9Sb58IG5sO+/s8syNAS8mo1RXX+3X0KIL8W4/Pz?=
 =?us-ascii?Q?qbGgesZm246AjVN6RSysjzvbRhYP+vqKx2PrV8Q4+eYtAwlsRbCCGM4c02YN?=
 =?us-ascii?Q?m6wZ8fhyyT0sLTBR7xgb7s/KrjprNjw+pxLb/fdMUhx2RvlxWA/hYSCDR+V+?=
 =?us-ascii?Q?vbgYgLYl1YJbUAsTyBjeSg3WzQ2vRswhIU1N1HQhE1ZHZV0Uh3UPpGj/Zpvj?=
 =?us-ascii?Q?7/EZvGzgcqKv3qxpIbWnPWQMmFWJSvRNkFncEwZul/DEiT7kXpANqXZK1CNr?=
 =?us-ascii?Q?bvcqhjsE49o7CR6z7R6T+2dfHY1PJVIBfi3UZG0CsO4Svhb60lmQDXETiWyF?=
 =?us-ascii?Q?Ruv3ytFVT0b+I9e25LGMQlVHr9gDPdR7zkz87rwA3R7yi95PtUZ+m99KiSwL?=
 =?us-ascii?Q?6n4wtimXXik9Ob5wWgIHOCIA6vxAEgzl3mOBzVA4sG60HijTg4RitMbUCowa?=
 =?us-ascii?Q?sVjHnywM5Bm/+snx4hejc59W8zCf9kiz/RaioZbCtjdk0G36+AiyimDeoMju?=
 =?us-ascii?Q?HYnY1JHR0hPns5TS9EIbSsttqCDaRtH+Wv4k6Y6rPZfXfYvVC0ZuA8sPaGg1?=
 =?us-ascii?Q?Am1T5qxmprXykphywRbabSUpv2psGevKrizilf88+zuE2VqwV742+1kjVMy9?=
 =?us-ascii?Q?ZT9F3pniW5ZcgIpOkCYekktFDxVThQQ7sICCjr9yMYT1J/JrkAoBEzONo6dL?=
 =?us-ascii?Q?RiJ8v1wMFYZheqzp7Tc+eV38oAL7AivCAQYwZQhrJ9D7epdWv4q3l2OQ9cDt?=
 =?us-ascii?Q?zHty7HoW4A+YHaI2EaqoZxIgTnuF/tcotTUVh2B57Re3pNorfUyJcbB7tuUH?=
 =?us-ascii?Q?tteIQJuQlavqxcVAyFN1GKi0bn9+XNjwymmbKOr8jeobM7ZED8iYu5uHQtFm?=
 =?us-ascii?Q?5ggaXBr7qeU975/6ks3SA7nV/TYhnJ/rt9TmNe2i7085r3jgBMKxfpV2HnOH?=
 =?us-ascii?Q?Wa5fHvn9Eg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cdc3913-dc57-416c-efed-08da4a1689b8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 12:49:48.7775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rg0Y3XTqHp+XM0ZDh1Pi2J55Z+RI7D7353XOLy8RtaOOtBdMOvNNMktP1JaBocUenc5fZgHy39mCnK5Bn5u0BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2818
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX93 mediamix blk ctrl node

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 8f0658e95e0d..bcc8fd296bb9 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -348,5 +348,25 @@ gpio1: gpio@47400080 {
 			#interrupt-cells = <2>;
 			gpio-ranges = <&iomuxc 0 0 32>;
 		};
+
+		media_blk_ctrl: power-controller@4ac10000 {
+			compatible = "fsl,imx93-media-blk-ctrl", "syscon";
+			reg = <0x4ac10000 0x10000>;
+			power-domains = <&mediamix>;
+			clocks = <&clk IMX93_CLK_MEDIA_APB>,
+				 <&clk IMX93_CLK_MEDIA_AXI>,
+				 <&clk IMX93_CLK_NIC_MEDIA_GATE>,
+				 <&clk IMX93_CLK_MEDIA_DISP_PIX>,
+				 <&clk IMX93_CLK_CAM_PIX>,
+				 <&clk IMX93_CLK_PXP_GATE>,
+				 <&clk IMX93_CLK_LCDIF_GATE>,
+				 <&clk IMX93_CLK_ISI_GATE>,
+				 <&clk IMX93_CLK_MIPI_CSI_GATE>,
+				 <&clk IMX93_CLK_MIPI_DSI_GATE>;
+			clock-names = "apb", "axi", "nic", "disp", "cam",
+				      "pxp", "lcdif", "isi", "csi", "dsi";
+			#power-domain-cells = <1>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.25.1

